Return-Path: <linux-kernel+bounces-284107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416594FCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A70282F08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E38128E37;
	Tue, 13 Aug 2024 04:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RRyvh5pT"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B63D994
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523947; cv=none; b=f7zsxllXoWBEYejdGyDOIZheCVY/LMI6SJ/9IJfTCO74lcG2lJOTSlZrHyU2y5n+CI//W7F4BOSyQbaJPNsuY2m6Gn8iUopVb4Ok5ubvIR0YdQyn2rdODDxgNU30xUFjg7vGNJnoo5N1wj8LOg1SsxLp4K4tQlaVY7sunPmN8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523947; c=relaxed/simple;
	bh=gwJc0XVib0+KTUgs1o4JdC5RA69htRjz2E5EOUvji4c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FFxbPSVkGODDvkpACYZD5akQs+KwIkoinb32Wferb8xGTPKNQBuG7JSfNakFQzDyKJZ/eY0pA3Di6JFarjPFrK8/FnrJFT7EJCUx/4RMWz4w+7hH0PHH4vFekij7X2Il10PXvcAPs+0gfRm0AN33h4WLfljJJ4Qwk/0wOgJ6AVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RRyvh5pT; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D4c0mZ078328;
	Mon, 12 Aug 2024 23:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723523880;
	bh=Xte8G+0VpiYtF8McsRCLaZwIghkZ8dUUM0IzF8hp5JQ=;
	h=From:To:CC:Subject:Date;
	b=RRyvh5pTu1QOYIo/89sszeZXDPRdEcoMN7BVtFDstVulQ+G1DYWymzKCkBq7ESe8y
	 HYMRgJnAP+SYjwqgu4nejd+TcKUvw9qde4vOgh6hQHuGWeJDKscdKcDC8GXO4UrNNY
	 htssQWWCgZsNZoRWSLLkdEnksam18bR+w+JiErWo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D4c09v083839
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 23:38:00 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 23:37:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 23:37:59 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.152])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D4bsqC107764;
	Mon, 12 Aug 2024 23:37:55 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13564923607@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <cameron.berkenpas@gmail.com>, <tiwai@suse.de>, <baojun.xu@ti.com>,
        <soyer@irl.hu>, <Baojun.Xu@fpt.com>, <robinchen@ti.com>
Subject: [PATCH v2] ALSA: ASoC/tas2781: fix wrong calibrated data order
Date: Tue, 13 Aug 2024 12:37:48 +0800
Message-ID: <20240813043749.108-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Baojun Xu <baojun.xu@ti.com>

Wrong calibration data order cause sound too low in some device.
Fix wrong calibrated data order, add calibration data converssion
by get_unaligned_be32() after reading from UEFI.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v2:
 - Change data type from int to __be32.
v1:
 - Change copyright date, and add new maintainer.
 - Add unaligned.h included for get_unaligned_be32().
 - In tas2781_apply_calib(), change data address transfer directly to
   get data by get_unaligned_be32(), and send address to device.
---
 sound/pci/hda/tas2781_hda_i2c.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 8a7fe48043d2..5a8193285f9f 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -2,10 +2,12 @@
 //
 // TAS2781 HDA I2C driver
 //
-// Copyright 2023 Texas Instruments, Inc.
+// Copyright 2023 - 2024 Texas Instruments, Inc.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
+// Current maintainer: Baojun Xu <baojun.xu@ti.com>
 
+#include <asm/unaligned.h>
 #include <linux/acpi.h>
 #include <linux/crc8.h>
 #include <linux/crc32.h>
@@ -519,20 +521,22 @@ static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 	static const unsigned char rgno_array[CALIB_MAX] = {
 		0x74, 0x0c, 0x14, 0x70, 0x7c,
 	};
-	unsigned char *data;
+	int offset = 0;
 	int i, j, rc;
+	__be32 data;
 
 	for (i = 0; i < tas_priv->ndev; i++) {
-		data = tas_priv->cali_data.data +
-			i * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 		for (j = 0; j < CALIB_MAX; j++) {
+			data = get_unaligned_be32(
+				&tas_priv->cali_data.data[offset]);
 			rc = tasdevice_dev_bulk_write(tas_priv, i,
 				TASDEVICE_REG(0, page_array[j], rgno_array[j]),
-				&(data[4 * j]), 4);
+				(unsigned char *)&data, 4);
 			if (rc < 0)
 				dev_err(tas_priv->dev,
 					"chn %d calib %d bulk_wr err = %d\n",
 					i, j, rc);
+			offset += 4;
 		}
 	}
 }
-- 
2.43.0


