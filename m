Return-Path: <linux-kernel+bounces-405399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4ED9C50CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081521F22FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8645F20DD52;
	Tue, 12 Nov 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xi4bbwMx"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573C20C480
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400559; cv=none; b=POTDe3jDXFySJvUZsyzB0mHbtIc7L04lzlgk/VHtN+2WDhd3XJpU5XiCkvnG5d7EH4robHFlTN1d7zJr6+LXPd2ocFm+exAXxnUZlYL9p8lWQreE/njqfy0hel+JycOwpQ0Snk8Nz53DUeOLfYSaYapyXz7u9K8CLpq2UmBovFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400559; c=relaxed/simple;
	bh=Mu/o9Qv5X4vFA1jVqoDuiGcIFYCOHs8UofluQ4+eEKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UHgNn1g0yjk/Aogem6ZqWc81+Cq6LssJaQinbI0oZKyOuFd+02Zvb0NQmShStHD9QJwRHzIvTKv3/uTRJ/iTSUCJtb2hQGnpYu8wIVopXsNlxn0skxLRhH5DVsLorT3issCR7jrHqyuuMXVK8U4pyLmzOQx+J0pbUoSxeJtuMuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xi4bbwMx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eac969aso30420365e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731400556; x=1732005356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6QofcCdQmsLqvy2bS7OgsAFd+Nwlz5uz8nWM8QdfQg=;
        b=xi4bbwMxLhYH890He0EpuJIQKm1uEbt6p7k97C9nHAXw3cpleuHPPuuL4CigGeCVGV
         wEGwXr8oC8h1LMjsUZ0SUFQ4GEKAMSIAwwLcBxwyg0hMf4cV3EG1dUAgWNuN0+552CAY
         DQrotiTtgbqBoqCmiVCjuurdLQpGdiEBg0mpbwzivTJ81PXGPRBvJWXqxDGJo825iVm2
         /98wW3ElR+hNhp3NuqqkB9ygWPpxv3065NKvyF6QcT1jBUCsd6JnsqBp9J4kPD1VoNMZ
         dynSEvrsjhgMkn1l82wt51pFunlgvwJp5N/8MPxGrmJrN5rqau8cMhUOmGVoVlipgDM/
         Sumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731400556; x=1732005356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6QofcCdQmsLqvy2bS7OgsAFd+Nwlz5uz8nWM8QdfQg=;
        b=QrFnTPqsvTGWtjvYMjF2nV7VfyYoAxPYUFHwG70gnhSqayYxIoIBuONzsQz6T9TX68
         FaMW7+nhrClwVN1wQGlHQTgGUP4MUNNDIXUIz6OrqyZuH9E9oJ+QjTgjiXlgAQavgjDo
         EXSbYwP2YhgRUy1/oVfm726o6a2WLbjaBHshxajwuI4+XU3HkeHJE6t2tAxGIXQj4YRZ
         GAdQKPCOYPftETOSaR84SVVfvwDAJIx2U5leGGoWZxMzCE1UikPGY5gQ4Fj/Hu4cDBG5
         K8jBq0QKq74NEPrkKoezM87L0q7e9P858sQr8AXR/eBwzQPyHk8ew2h4YeM8fpDRiFi+
         lMVw==
X-Forwarded-Encrypted: i=1; AJvYcCVaC48EWW8NCeKtjP5KgUePFYLP26BRfg2h919EjGFutucb91E2a271vUH1p4FOzTPoKd4fmQogQlNVTps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxExTxS6xGRj7SJLQFm0qACeBwVeqVWc1pQFJ7TL+XRKAKiBBw
	d2nOJSzP+r60d88SjUP481/rXoMmDJSwh0UkdrfSitjKzxFfTZAq23sqpox8OhM=
X-Google-Smtp-Source: AGHT+IGW+y3BR7dFB04YA4ES3C1lW4o7kCU2hloqBgpq+LKWd/AQDkgHN2jgVjcYHfhMS3JEIGnWwQ==
X-Received: by 2002:a05:600c:4690:b0:431:5226:1633 with SMTP id 5b1f17b1804b1-432b744ef66mr130754775e9.6.1731400555594;
        Tue, 12 Nov 2024 00:35:55 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa523a0esm233176195e9.0.2024.11.12.00.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:35:55 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	Ronak Jain <ronak.jain@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	imx@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	qemu-devel@nongnu.org,
	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH] firmware: Switch back to struct platform_driver::remove()
Date: Tue, 12 Nov 2024 09:35:20 +0100
Message-ID:  <36974feb6035201d53384557259ec72fe311053b.1731397962.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7555; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Mu/o9Qv5X4vFA1jVqoDuiGcIFYCOHs8UofluQ4+eEKY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnMxNYRTU/Z/YcH9oKPyjD1Bi3PtTwnTXisZzZA y+s+3m+Wv2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzMTWAAKCRCPgPtYfRL+ TnzXB/wIb7KWzpl9KhF1WQm264Rj2ne8x5AR+YU2GkZbmy5FZrtPt6HXJuJgBDULzpxixsmxIJF VlvB5dKowmesjkiHP1AFIiR2D9fWHM+CZMEFlqVCJGrdEQrW9D+UmULcTNI3XB222G4b7YLFHM0 ed5WNuOnohzkIvJSnXdnFm/sx4bu902DDKuNLJAvDs03YbVOb2skn28UEl0B7lXZ76AcJCc3CkS wV70cKyYkGbRAjHgBNtbZcxR/2sZ1BL6KTlE4IXgb8MxxwahMWg2nbcdW/xI3OHYzt0LTeREnhL 2dc2WNr0WcclVbruKzpBOsuQEfd3vxFF7Hm2ApRGzKe6CE3/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/firmware to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/firmware. While I usually prefer
to do one logical change per patch, this seems to be overengineering
here as the individual changes are really trivial and shouldn't be much
in the way for stable backports.

There is no dedicated maintainer for drivers/firmware, maybe Sudeep as
biggest committer there can take it? Or would it be sensible to split
this patch?

This is based on yesterday's next, if conflicts arise when you apply it
at some later time and don't want to resolve them, feel free to just
drop the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend. (Having said that, I
recommend b4 am -3 + git am -3 which should resolve most conflicts just
fine.)

Best regards
Uwe

 drivers/firmware/arm_scmi/driver.c            | 2 +-
 drivers/firmware/arm_scpi.c                   | 2 +-
 drivers/firmware/google/coreboot_table.c      | 2 +-
 drivers/firmware/imx/imx-dsp.c                | 2 +-
 drivers/firmware/microchip/mpfs-auto-update.c | 2 +-
 drivers/firmware/mtk-adsp-ipc.c               | 2 +-
 drivers/firmware/qemu_fw_cfg.c                | 2 +-
 drivers/firmware/raspberrypi.c                | 2 +-
 drivers/firmware/stratix10-rsu.c              | 2 +-
 drivers/firmware/stratix10-svc.c              | 2 +-
 drivers/firmware/xilinx/zynqmp.c              | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 1f53ca1f87e3..1b5fb2c4ce86 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3333,7 +3333,7 @@ static struct platform_driver scmi_driver = {
 		   .dev_groups = versions_groups,
 		   },
 	.probe = scmi_probe,
-	.remove_new = scmi_remove,
+	.remove = scmi_remove,
 };
 
 static struct dentry *scmi_debugfs_init(void)
diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index f4d47577f83e..87c323de17b9 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -1049,7 +1049,7 @@ static struct platform_driver scpi_driver = {
 		.dev_groups = versions_groups,
 	},
 	.probe = scpi_probe,
-	.remove_new = scpi_remove,
+	.remove = scpi_remove,
 };
 module_platform_driver(scpi_driver);
 
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 208652a8087c..882db32e51be 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -220,7 +220,7 @@ MODULE_DEVICE_TABLE(of, coreboot_of_match);
 
 static struct platform_driver coreboot_table_driver = {
 	.probe = coreboot_table_probe,
-	.remove_new = coreboot_table_remove,
+	.remove = coreboot_table_remove,
 	.driver = {
 		.name = "coreboot_table",
 		.acpi_match_table = ACPI_PTR(cros_coreboot_acpi_match),
diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index 01c8ef14eaec..ed79e823157a 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -180,7 +180,7 @@ static struct platform_driver imx_dsp_driver = {
 		.name = "imx-dsp",
 	},
 	.probe = imx_dsp_probe,
-	.remove_new = imx_dsp_remove,
+	.remove = imx_dsp_remove,
 };
 builtin_platform_driver(imx_dsp_driver);
 
diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 0f7ec8848202..38a03698cec9 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -458,7 +458,7 @@ static struct platform_driver mpfs_auto_update_driver = {
 		.name = "mpfs-auto-update",
 	},
 	.probe = mpfs_auto_update_probe,
-	.remove_new = mpfs_auto_update_remove,
+	.remove = mpfs_auto_update_remove,
 };
 module_platform_driver(mpfs_auto_update_driver);
 
diff --git a/drivers/firmware/mtk-adsp-ipc.c b/drivers/firmware/mtk-adsp-ipc.c
index fdb083f42ebf..2b79371c61c9 100644
--- a/drivers/firmware/mtk-adsp-ipc.c
+++ b/drivers/firmware/mtk-adsp-ipc.c
@@ -132,7 +132,7 @@ static struct platform_driver mtk_adsp_ipc_driver = {
 		.name = "mtk-adsp-ipc",
 	},
 	.probe = mtk_adsp_ipc_probe,
-	.remove_new = mtk_adsp_ipc_remove,
+	.remove = mtk_adsp_ipc_remove,
 };
 builtin_platform_driver(mtk_adsp_ipc_driver);
 
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 85c525745b31..d58da3e4500a 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -757,7 +757,7 @@ MODULE_DEVICE_TABLE(acpi, fw_cfg_sysfs_acpi_match);
 
 static struct platform_driver fw_cfg_sysfs_driver = {
 	.probe = fw_cfg_sysfs_probe,
-	.remove_new = fw_cfg_sysfs_remove,
+	.remove = fw_cfg_sysfs_remove,
 	.driver = {
 		.name = "fw_cfg",
 		.of_match_table = fw_cfg_sysfs_mmio_match,
diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 18cc34987108..7ecde6921a0a 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -406,7 +406,7 @@ static struct platform_driver rpi_firmware_driver = {
 	},
 	.probe		= rpi_firmware_probe,
 	.shutdown	= rpi_firmware_shutdown,
-	.remove_new	= rpi_firmware_remove,
+	.remove		= rpi_firmware_remove,
 };
 module_platform_driver(rpi_firmware_driver);
 
diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index e20cee9c2d32..1ea39a0a76c7 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -802,7 +802,7 @@ static void stratix10_rsu_remove(struct platform_device *pdev)
 
 static struct platform_driver stratix10_rsu_driver = {
 	.probe = stratix10_rsu_probe,
-	.remove_new = stratix10_rsu_remove,
+	.remove = stratix10_rsu_remove,
 	.driver = {
 		.name = "stratix10-rsu",
 		.dev_groups = rsu_groups,
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 528f37417aea..c5c78b869561 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1271,7 +1271,7 @@ static void stratix10_svc_drv_remove(struct platform_device *pdev)
 
 static struct platform_driver stratix10_svc_driver = {
 	.probe = stratix10_svc_drv_probe,
-	.remove_new = stratix10_svc_drv_remove,
+	.remove = stratix10_svc_drv_remove,
 	.driver = {
 		.name = "stratix10-svc",
 		.of_match_table = stratix10_svc_drv_match,
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index cdb565c41119..720fa8b5d8e9 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -2118,6 +2118,6 @@ static struct platform_driver zynqmp_firmware_driver = {
 		.dev_groups = zynqmp_firmware_groups,
 	},
 	.probe = zynqmp_firmware_probe,
-	.remove_new = zynqmp_firmware_remove,
+	.remove = zynqmp_firmware_remove,
 };
 module_platform_driver(zynqmp_firmware_driver);

base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
-- 
2.45.2


