Return-Path: <linux-kernel+bounces-251096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7112930099
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BBC283CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F622097;
	Fri, 12 Jul 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmmh/NJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E2118C08;
	Fri, 12 Jul 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810463; cv=none; b=hZc6d32lPfB+bmwMeztfM+VFU0ZDGsUeeVEyDChmKn4g9QhlIzgy4JvWU0IIe5GRoygMR4eIQtREpn4JG1FM7wuKKNFrcKHaMV3NpXrs/am0jq+bpoaK9r6PiW26nL9hDIZlPpaw0xV18Q6o9+AtXljf64hgq+j99L6iz3JDRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810463; c=relaxed/simple;
	bh=/FRO0tmyhfcgTXW2WSGH+l5CQEbA0ZXqOR+40diEmPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqCwzdmEXbtShNGn1/3o75j7CjKatinplIkMRbluvkpIJ+4rDC9m6+ABLaOZmc/VV7Rmg4oDomv3vXohUCtJSvDXJDlkXY5HGVJ8ODdFzU/v7gdhtJdEwibhpa0UOhUyeyeWczBx/OXtCG/x7jq3ayzFEEWB/5BUxxlsaHYQSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmmh/NJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A053C32782;
	Fri, 12 Jul 2024 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720810462;
	bh=/FRO0tmyhfcgTXW2WSGH+l5CQEbA0ZXqOR+40diEmPU=;
	h=From:To:Cc:Subject:Date:From;
	b=pmmh/NJ42eA0VurfR3KqgY/cQuV4L+J80Bc4cu1eyHNinRr0dyaWGHDylmhv25Aae
	 oBHNd7I9UplI3/XFTzirKc08fJqWHLfznHyk7U0132YOg6iM8IcQtZaJ4NcfIlSeHu
	 +NY00kC8hoo2q84STU3Q1UjBpLhN1m/lmOf231pBBKQPHJxdHlGCVU4tWuSzW4Mg1t
	 3sLSnVdep2hqiwYyD9zB/Bl5IvJQDWw+hGRTyXsnfc00LeQ57Z4qdK+Idv3JfsAcip
	 E/uh5qsY9LvWYBuAnz7PLvVljBiH2Ir1TNC59r1U1g9xAPJ/eCa68OTIgYmjrTj+Gi
	 cR717kmQfRnAg==
From: superm1@kernel.org
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
	linux-kernel@vger.kernel.org (open list),
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	mika.westerberg@linux.intel.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Put XHCI controllers into D3 at S4/S5
Date: Fri, 12 Jul 2024 13:54:16 -0500
Message-ID: <20240712185418.937087-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When the system is put into S4 or S5 XHCI controllers remain in D0.  This
causes higher power consumption and may compromise energy certifications.
Consequently some systems consume more power in S5 than s0i3.

This affects all PCIe devices, but looking at breakdowns XHCI is the
biggest offender for power consumption.

This series checks if any wakeups are needed and puts controllers into D3
if no wakeup necessary.

This series is a spiritual successor to [1] which aimed to do this more
generally in PCI.  It also accomplishes similar goals as [2], but aims for
both S4 and S5.

[1] https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/#t
[2] https://lore.kernel.org/linux-pci/9d2f1619-1c61-4e8c-b28d-d4eddefa45c3@amd.com/T/

Mario Limonciello (2):
  xhci: pci: If no ports have wakeup enabled then disable PCI device at
    S4
  xhci: pci: Put XHCI controllers into D3hot at shutdown

 drivers/usb/host/xhci-pci.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.43.0


