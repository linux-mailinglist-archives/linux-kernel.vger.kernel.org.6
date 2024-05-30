Return-Path: <linux-kernel+bounces-196024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4503F8D562F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041141F2596A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5298A17E441;
	Thu, 30 May 2024 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IPxHxbWD"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902324D8C3
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111265; cv=none; b=WqbAD3eK5PKitFaP36jZ/IQBl6v7m/xFLHdr2n7ikKIyT2cS1OpxhAo6MmvKiZhbyEGMk2fWPO9rpKucA3NZNqZE5PCTuFt/zkPbfsboq2/eqiMsBJ2mzEmUbG57Z6+6j+cJD6oaL/FvqWjOkEEcZVK3FpznrJDftNkfCcHJcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111265; c=relaxed/simple;
	bh=jzhCryJW5JtNI2X+iLQwWD6k73DG4yDa1rDTIWEKIZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4Kaul9xpb19mr5mWUHDZiYL0tfPuE40rkm7MSOVurjjO3pvJtH5mgcwMFYmx6OuVyh1Tg8mNN3L1PhtNohLiZyk9gIU/a5uM/e9u3ltDnCl4pquA4z/N0/IrbuPyCZ4fDBGOQEGYOVzvhrUhZdtOBcRep72/7WAjdCWejEpVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=IPxHxbWD; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9F97F2C00CF;
	Fri, 31 May 2024 11:20:59 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717111259;
	bh=ju9yTVd43srfUJ18SKWRLayOxfYeLI5ol3mcv7TLf3M=;
	h=From:To:Cc:Subject:Date:From;
	b=IPxHxbWDOEfDLuXgWZvHoY/TiBUNet6uR0RyRSWt99Mbm/VtmI+G7Mylqmzrb74rg
	 /BLFaUxgMT56nIIAwpJVotEwiF7Emni98z89gJ9xDg5zqOBCuv+mXD+IY0utEdwqAr
	 PIxwPoxC5uxnPGBQd5QD2accuVPvk9PC/oPhjXhlDsd4lvxyo+GXfzAvEFTFkS6BpA
	 bz+LmNVKIjQrMJ8uwQ9aWdQ/mGFCMIORxDQFsK7EQ17pVKb78Tne8/y2zxNGueBLAc
	 NMFDDVBEGqu3E6xRcn7J8sboxSTuBnsMAcE8ytnN9y8ms4XTfgt0YY6poD7G5oUNCT
	 Gn/BL9FZKN5vw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B665909db0000>; Fri, 31 May 2024 11:20:59 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 6A08613EDFA;
	Fri, 31 May 2024 11:20:59 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 657FB280481; Fri, 31 May 2024 11:20:59 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	tzimmermann@suse.de,
	ojeda@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] auxdisplay: linedisp: Support configuring the boot message
Date: Fri, 31 May 2024 11:20:54 +1200
Message-ID: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=665909db a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=mV-LYs_grPyxVDLXzvUA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Like we do for charlcd, allow the configuration of the initial message
on line-display devices.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/auxdisplay/Kconfig        |  2 +-
 drivers/auxdisplay/line-display.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 69d2138d7efb..21545ffba065 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -316,7 +316,7 @@ endif # PARPORT_PANEL
=20
 config PANEL_CHANGE_MESSAGE
 	bool "Change LCD initialization message ?"
-	depends on CHARLCD
+	depends on CHARLCD || LINEDISP
 	help
 	  This allows you to replace the boot message indicating the kernel ver=
sion
 	  and the driver version with a custom message. This is useful on appli=
ances
diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-=
display.c
index e2b546210f8d..837ca63c8368 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -8,7 +8,9 @@
  * Copyright (C) 2021 Glider bv
  */
=20
+#ifndef CONFIG_PANEL_BOOT_MESSAGE
 #include <generated/utsrelease.h>
+#endif
=20
 #include <linux/container_of.h>
 #include <linux/device.h>
@@ -312,6 +314,12 @@ static int linedisp_init_map(struct linedisp *linedi=
sp)
 	return 0;
 }
=20
+#ifdef CONFIG_PANEL_BOOT_MESSAGE
+#define LINE_DISP_INIT_TEXT CONFIG_PANEL_BOOT_MESSAGE
+#else
+#define LINE_DISP_INIT_TEXT "Linux " UTS_RELEASE "       "
+#endif
+
 /**
  * linedisp_register - register a character line display
  * @linedisp: pointer to character line display structure
@@ -359,7 +367,7 @@ int linedisp_register(struct linedisp *linedisp, stru=
ct device *parent,
 		goto out_del_timer;
=20
 	/* display a default message */
-	err =3D linedisp_display(linedisp, "Linux " UTS_RELEASE "       ", -1);
+	err =3D linedisp_display(linedisp, LINE_DISP_INIT_TEXT, -1);
 	if (err)
 		goto out_del_dev;
=20
--=20
2.45.1


