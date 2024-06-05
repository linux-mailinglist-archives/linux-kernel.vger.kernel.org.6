Return-Path: <linux-kernel+bounces-201808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55438FC3BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832BF1F26E15
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E8419046E;
	Wed,  5 Jun 2024 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="vz5v9NNo"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE5190463
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569250; cv=none; b=PiWl6bgSWJH2yFTCHg7b9MnylaCEL65/yD7TiEDng/VQZtqYgKeXcP+fz7aNxdoXw+qOvuTF+YDw42MTjQJeTyGuYMB+8KvgiqfGAob+4t4VxmT44ZdHHlaYZGBPnijRlYWUnVszILsCotMLNJXS1s350f+9ZBBwIlJ/NlgRBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569250; c=relaxed/simple;
	bh=tUUAkLB1ldbb94XGaAXSSM0b1Tewctk5QUL4xNv1O6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnAP0G0RN55eDv07EAnuP6MXlkr/7pNTYwsea0MBgebfPskFzm6U451ITI5hUd/Up0Vj46YDNHSVeYw61+sKLydpVKGFwOKcCNVKNlTjyD8+5AJZ7NyDkHbDa2G+27HqTB7yiElDT1xgYVmjJ8WGlej+nwfN0/kjMLABjWZ1eY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=vz5v9NNo; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VvHjl1tgSz9spS;
	Wed,  5 Jun 2024 08:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717569243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X1WFnK/LBUaFpbEctwhiFjqVA+SMpCU6sdqC32kEpzA=;
	b=vz5v9NNoiZCRaUFcMDdhhnUVxHBwZPBHCrlArSty3faBbrXoUJqELP/qpUe+hfRH0zHZ5q
	ktZu4kSg88K4Lhv4nWUDcz+t4y2GdIkFH3GgxPhOdR5tjWXCuxAyghTYqQwiRHJ83/4hFc
	gCiCvGvyI4V3FJ5mPAqU+te2DxLeLadef7inpQ2wxivEhXEJNPIKSHCIotCT/dUoL+074/
	lK94SaSpHmUagxbInGOhWiXTZkJizDQD9ylSwuxgOQmNepL9sV9+UTGeGH9RKTurkn28ov
	J1PYO+7J4p8dXNdi4R4pFd8ePegMoKL3qTq1uHaE2IzTIKOPP6U7BVii+0vZXw==
From: Ben Walsh <ben@jubnut.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ben Walsh <ben@jubnut.com>
Subject: [PATCH v3 0/5] platform/chrome: Fix MEC concurrency problems for Framework Laptop
Date: Wed,  5 Jun 2024 07:33:46 +0100
Message-ID: <20240605063351.14836-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Framework Laptops with the Microchip EC have a problem where the EC
"stops working" after a while. Symptoms include the Fn key not
working, and "bad packet checksum" errors appearing in the system log.

The problem is caused by ACPI code which accesses the Microchip EC
(MEC) memory using the Microchip EMI protocol. It uses an AML mutex to
prevent concurrent access. But the cros_ec_lpc driver is not aware of
this mutex. The ACPI code and LPC driver both attempt to talk to the
EC at the same time, messing up communication with the EC.

The solution is to have the cros_ec_lpc_mec code find and use the AML
mutex. But to make it all work we have to do a few more things:

  * Allow the cros_ec_lpc_mec code to return error codes in case it
    can't lock the mutex.

  * Have the cros_ec_lpc code find the correct ACPI device (PNP0C09)
    and then the AML mutex itself.

  * Use the quirks mechanism to specify the AML mutex name.

Tested-on: link, hx20, azalea
Tested-by: Dustin L. Howett <dustin@howett.net>

Changes in v3:

  * Use ACPI_COMPANION instead of adev variable.
  * Stricter error checking in probe.
  * Remove a few blank lines.
  * Rebase to latest ChromeOS for-next branch.

Changes in v2:

  * Put ACPI id in a quirk, not the acpi_match_table.
  * Add return code check for mutex unlock.
  * Remove "in_range" check which belongs in a separate patch.
  * Use "ret" not "sum" variable (same value but clearer).
  * Remove excessive error logging.
  * Rebase to latest ChromeOS for-next branch.

Ben Walsh (5):
  platform/chrome: cros_ec_lpc: MEC access can return error code
  platform/chrome: cros_ec_lpc: MEC access can use an AML mutex
  platform/chrome: cros_ec_lpc: Add a new quirk for ACPI id
  platform/chrome: cros_ec_lpc: Add a new quirk for AML mutex
  platform/chrome: cros_ec_lpc: Add quirks for Framework Laptop

 drivers/platform/chrome/cros_ec_lpc.c      | 206 +++++++++++++++------
 drivers/platform/chrome/cros_ec_lpc_mec.c  |  85 ++++++++-
 drivers/platform/chrome/cros_ec_lpc_mec.h  |  18 +-
 drivers/platform/chrome/wilco_ec/mailbox.c |  22 ++-
 4 files changed, 261 insertions(+), 70 deletions(-)


base-commit: 106d6739823369c734a8fc3b13634274eee4f60e
-- 
2.45.1


