Return-Path: <linux-kernel+bounces-418113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3B9D5D60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8936E28361E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C51D9688;
	Fri, 22 Nov 2024 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mTM9wkni"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAEA1304BA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732271678; cv=none; b=fYEbqeWiDxLxzzbnwRyNNrA/wLr2j9H70gucGGZWMtNa6aJhSPdOsbJM0fyST3uR8dQUkR0aK165h4ybGm0UrW6uSeZWnf7y/xF8O3EBL3cxvHwlvvd4dZbkHZidAJ1/7mpaugGN0VX/zm2RFGAedC7pYGQXIwOTYveefDaWoVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732271678; c=relaxed/simple;
	bh=ZrCwIi5AoU3qqlef0/bbyK5pXsMbwUucNQUcM+FRfHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jzw5gLXxxIeDaLhBm3sAjeODXDX6uo++T/Grs50jBUkikT2rTvyTIA0Yv7uMPaCj/xhaLUJpUsWzL7TzMXSTIx91AgIPa5ySR7aFejwrrXlvw2+iQueIU3grVHVbn/s/rVeOKny5VBd3WMkDhZdN2OahhF8xsbZSY9ckCh+g1vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mTM9wkni; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732271674;
	bh=ZrCwIi5AoU3qqlef0/bbyK5pXsMbwUucNQUcM+FRfHc=;
	h=From:Date:Subject:To:Cc:From;
	b=mTM9wkniJnGa7hNlnvqfHXuEHY/DUsObr1g7wH042w509hh/HqFBesfayg4o0xCQL
	 bBjfpxwnPZC96WSNq8Uq87r7dEuoWObDpgTkh1zbkSTxrKvdxbpVEngZCKLNJ25Fcy
	 0CyoSV0u/91CHY/xVYI1wZ8aCTul9idtNGkwhRF0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 22 Nov 2024 11:34:29 +0100
Subject: [PATCH] firmware: dmi: Mark bin_attributes as __ro_after_init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-sysfs-const-bin_attr-dmi-v1-1-febd12fb27d9@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADReQGcC/x3MSwqAMAwA0atI1gZsFfxcRURqGzULqzRFFPHuF
 pdvMfOAUGAS6LIHAp0svPsElWdgV+MXQnbJoAtdKaU1yi2zoN29RJzYjybGgG5jrApbNrVpS+c
 MpPwINPP1r/vhfT/ak08hagAAAA==
X-Change-ID: 20241122-sysfs-const-bin_attr-dmi-40c387a93dda
To: Jean Delvare <jdelvare@suse.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732271672; l=1091;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ZrCwIi5AoU3qqlef0/bbyK5pXsMbwUucNQUcM+FRfHc=;
 b=2st7UsDGft42gGgknuzq7MSsZ1ojMfuZAzt4hqSUNCL89It4sgG0oheXZG7G6SbfuAwYbePK6
 65pmTbg00QeDSOfkZ90Dfn6DPcg142mkyecjWaFwbd8CbStB/ZPWKkn
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The attributes are only modified during the __init phase.
Protect them against accidental or intentional modifications afterwards.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/firmware/dmi_scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index fde0656481cc9577b05b781b703a8071e8d3fc4e..70d39adf50dcaaa7c99b48fe8e9045af5ea24d00 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -761,8 +761,8 @@ static void __init dmi_scan_machine(void)
 	pr_info("DMI not present or invalid.\n");
 }
 
-static BIN_ATTR_SIMPLE_ADMIN_RO(smbios_entry_point);
-static BIN_ATTR_SIMPLE_ADMIN_RO(DMI);
+static __ro_after_init BIN_ATTR_SIMPLE_ADMIN_RO(smbios_entry_point);
+static __ro_after_init BIN_ATTR_SIMPLE_ADMIN_RO(DMI);
 
 static int __init dmi_init(void)
 {

---
base-commit: 28eb75e178d389d325f1666e422bc13bbbb9804c
change-id: 20241122-sysfs-const-bin_attr-dmi-40c387a93dda

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


