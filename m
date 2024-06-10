Return-Path: <linux-kernel+bounces-208794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE3F902939
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDAD1F21240
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5514C584;
	Mon, 10 Jun 2024 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="a7F0WWpI"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73F14A85
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047578; cv=none; b=I9LioxneXAHPEL5tls9IjF/FebQsOcnUvx2hZrtqDWZhlaXvs/s5stXrrCNROZmJbcKo1UPwhYmvsn2NpN5b4dG0aCPHZMybHHfEmHTNI25YcuAcqMh4sW8RjzTvpw4ELeL5xM1JVcG9ByL9CtHcuJMylZ9sx5+IkAVIsqTdrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047578; c=relaxed/simple;
	bh=KGqwvxPvj4Ln5e71vhrELndG938ZlgrVOL2zaKHDysg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u9k7M8g48eGRdlNM/zp2w5NQM90TgvqD+CbsXVs+Mw1O14HDKajxfOoC3zEAoYzb0ZjD/PYSUJByeLGEeznXMhLdMJOXIn3gZkMojTGu1imJm2L2Ton4Nk7QTRhRObyfXmproqcBzOCl/XzcA8SKPaHALYf8CqsewG/TI5Gbqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=a7F0WWpI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718047572;
	bh=KGqwvxPvj4Ln5e71vhrELndG938ZlgrVOL2zaKHDysg=;
	h=From:Date:Subject:To:Cc:From;
	b=a7F0WWpIlIaEF6JyG9PmhiMPtgr6m6Y0G+KaihSOcE6+BI02rBH98WPEPl/2l4xtu
	 cn7Ry8pSna7maKwxniPX0GKQVrTWWvheDbR4+WFR6CCrKK/GfJXngF7SfgkrT07cgB
	 cfggcKC3BdXCRNPh/Kbu/N0+R8R39rftxlIv3upU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 10 Jun 2024 21:26:05 +0200
Subject: [PATCH] drm/amd: force min_input_signal to 0 on Framework AMD
 13/16
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAExTZ2YC/x3MQQ5AMBAAwK/Inm1SJYiviEPpqg2KVkUi/q5xn
 Ms84MkxeWiSBxxd7HmzEVmawDApawhZR4MUshBlJlCt2uwBV7bYq2Fe2EwnHoHdjHUh5KhrqvJ
 SQQx2RyPff9527/sBX6wgCWwAAAA=
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, Matt Hartley <matt.hartley@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718047572; l=2819;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KGqwvxPvj4Ln5e71vhrELndG938ZlgrVOL2zaKHDysg=;
 b=e62/svmTkpaY4tCy8VOBGB8kgLMr+GHdEXl9B/PEWz4pFnp+efPRzJ/FWEP1pFikUMicWtLbn
 u5O+aUJQF5cAJ+29mD8/WwhFiDEJf1U7f7l8zEfBztWhbS9zTsQIeyZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The value of "min_input_signal" returned from ATIF on a Framework AMD 13
is "12". This leads to a fairly bright minimum display backlight.

Introduce a quirk to override "min_input_signal" to "0" which leads to a
much lower minimum brightness, which is still readable even in daylight.

Tested on a Framework AMD 13 BIOS 3.05 and Framework AMD 16.

Link: https://community.frame.work/t/25711/9
Link: https://community.frame.work/t/47036
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7099ff9cf8c5..b481889f7491 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/backlight.h>
+#include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
 #include <linux/power_supply.h>
@@ -130,6 +131,35 @@ static struct amdgpu_acpi_priv {
 	struct amdgpu_atcs atcs;
 } amdgpu_acpi_priv;
 
+struct amdgpu_acpi_quirks {
+	bool ignore_min_input_signal;
+};
+
+static const struct dmi_system_id amdgpu_acpi_quirk_table[] = {
+	{
+		/* the Framework Laptop 13 (AMD Ryzen) and 16 (AMD Ryzen) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMD Ryzen"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Laptop"),
+		},
+		.driver_data = &(struct amdgpu_acpi_quirks) {
+			.ignore_min_input_signal = true,
+		},
+	},
+	{}
+};
+
+static const struct amdgpu_acpi_quirks *amdgpu_acpi_get_quirks(void)
+{
+	const struct dmi_system_id *dmi_id;
+
+	dmi_id = dmi_first_match(amdgpu_acpi_quirk_table);
+	if (!dmi_id)
+		return NULL;
+	return dmi_id->driver_data;
+}
+
 /* Call the ATIF method
  */
 /**
@@ -1388,6 +1418,7 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
  */
 void amdgpu_acpi_detect(void)
 {
+	const struct amdgpu_acpi_quirks *quirks = amdgpu_acpi_get_quirks();
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 	struct pci_dev *pdev = NULL;
@@ -1429,6 +1460,10 @@ void amdgpu_acpi_detect(void)
 					ret);
 			atif->backlight_caps.caps_valid = false;
 		}
+		if (quirks && quirks->ignore_min_input_signal) {
+			DRM_INFO("amdgpu_acpi quirk: min_input_signal=0\n");
+			atif->backlight_caps.min_input_signal = 0;
+		}
 	} else {
 		atif->backlight_caps.caps_valid = false;
 	}

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


