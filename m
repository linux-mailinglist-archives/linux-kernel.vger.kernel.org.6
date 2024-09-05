Return-Path: <linux-kernel+bounces-316531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8915896D0C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46ED21F25072
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B1D19343D;
	Thu,  5 Sep 2024 07:50:59 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AD146A72;
	Thu,  5 Sep 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522659; cv=none; b=HOrwtt8Yz0c50vO/LvKhufgdVxkXoW5AE/QGHO39QwXQKEcS3OvcZhDkX6yE738/VrsSxQvrQw9AsmexMH6cQJgRzQ5sQBgwK86hxDY1zfLSvPlESqtWWQsLewrc3UprkQydklCR5nxzANx1hMdXungsgG23NruPi5oboy+wPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522659; c=relaxed/simple;
	bh=FnWTv0eJs1f2rm6jPuY/lIQjCuwZd7OyZXJGMJDIDtw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AX+0VDnB+OHhsOXNkj1XK//exeYaa+Nr1g8SJsTXiv4PwNHVz09NWo4F62E0Lan/a82hEIT4tlm6cDAOQKeKvLYxBkOztESP7Qnb5gcxn1U4D/SEuHVeCvuG+f0GeUd6lVFmWj8j3TFgglL+S05QUEEHmVdEnMU7NOJmMWgLe0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EED9F1A0097;
	Thu,  5 Sep 2024 09:50:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B6F331A183B;
	Thu,  5 Sep 2024 09:50:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CB140180031E;
	Thu,  5 Sep 2024 15:50:53 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 0/2] Add one clock gate for i.MX95 HSIO block
Date: Thu,  5 Sep 2024 15:29:35 +0800
Message-Id: <1725521377-22645-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

CREF_EN (Bit6) of LFAST_IO_REG control i.MX95 PCIe REF clock out
enable/disable.
Add one clock gate for i.MX95 HSIO block to support PCIe REF clock
out gate.

v3 changes:
- Squash first two dt-binding patches into one.
- Add Krzysztof's Acked-by tag, and Frank's Reviewed-by tag.

v2 changes:
- Correct the compatible entries by alphabetical order
- Include all necessary To/Cc entried reminderd by Krzysztof.
Thanks.

[PATCH v3 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible
[PATCH v3 2/2] clk: imx95-blk-ctl: Add one clock gate for HSIO block

Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml |  5 +++--
drivers/clk/imx/clk-imx95-blk-ctl.c                            | 20 ++++++++++++++++++++
2 files changed, 23 insertions(+), 2 deletions(-)

