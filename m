Return-Path: <linux-kernel+bounces-277493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E3C94A224
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F851C22F58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB11C7B94;
	Wed,  7 Aug 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t8hdWdSb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B171C4612
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017422; cv=none; b=uSN6gCNzSBXnlgHJsvHbDnXVvJ+gMl1QhjaN8C7X087UGjlgKaXoQDc/SsRcQhHHxgK2eTwvnqphck0FbPmcfXFgqwrACntMGH9cQXbIgka9NT4rC7aN5JelkGw3rfwrbcnVHpHHB8bulr1loPvqFROy+GQrmiU1xt0miBhjqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017422; c=relaxed/simple;
	bh=mpkpkfRcqC7mmKa6jwUnulhzEDpq/knJSbY79MsWcxk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NSSTX2sK9A9QeOphHexgIkPG3yTxcNWURRRU/AnlJ+GZiTANV3l5Ub6AotTlDdTR3R0w09gUu+klHwVO4S//7QstmxsDMRpnHg/VB4dwhKZpnYRuVx9NgxWSF2Pl3B45Fbt8/EaoqFCAsxfUJvSL4xpIAP3LFNsafczwINi7Kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t8hdWdSb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4777tqXX035878;
	Wed, 7 Aug 2024 02:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723017352;
	bh=s7LjaoEs4ssoZQMsj5bA7tff9F0fFtc8MKm7Pi+4uh8=;
	h=From:To:CC:Subject:Date;
	b=t8hdWdSb8a55HmJqaTvck9TExurc1CJyS10XBmClue1NwvLx7XCVmL3xuQKqpu8kd
	 pgYC/5RJ3Ije11gaz+gxz7tyUvII8+Fy8GHQi+LEjM8pd10tt7c8n0x7KPIIeGC2ZL
	 DDtt8mvBdQhhg4qPaMwvj7ZDyjZMMjWd47oNfIWw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4777tqik074757
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 02:55:52 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 02:55:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 02:55:52 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.152])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4777tkLw123095;
	Wed, 7 Aug 2024 02:55:47 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13564923607@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <cameron.berkenpas@gmail.com>, <tiwai@suse.de>, <baojun.xu@ti.com>,
        <soyer@irl.hu>, <Baojun.Xu@fpt.com>, <robinchen@ti.com>
Subject: [PATCH v1] ALSA: ASoC/tas2781: fix wrong calibrated data order
Date: Wed, 7 Aug 2024 15:55:40 +0800
Message-ID: <20240807075541.1458-1-shenghao-ding@ti.com>
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
v1:
 - Change copyright date, and add new maintainer.
 - Add unaligned.h included for get_unaligned_be32().
 - In tas2781_apply_calib(), change data address transfer directly to
   get data by get_unaligned_be32(), and send address to device.
---
 sound/pci/hda/tas2781_hda_i2c.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 49bd7097d..4dc3350d5 100644
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
@@ -519,20 +521,21 @@ static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 	static const unsigned char rgno_array[CALIB_MAX] = {
 		0x74, 0x0c, 0x14, 0x70, 0x7c,
 	};
-	unsigned char *data;
-	int i, j, rc;
+	int i, j, rc, data;
+	int offset = 0;
 
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
2.40.1


