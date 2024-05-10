Return-Path: <linux-kernel+bounces-175260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821108C1D22
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FEE1F21C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDB149DE9;
	Fri, 10 May 2024 03:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WFTnPST3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BF149C4A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312574; cv=none; b=EDkjlEu7DoK6jU55mQu1CIXb7BF/CiBFSItlBGAwvzfsqCxixjw46EdZ7y4FFC9uHWfZfhYWr64o1RAiIDnZ53CkwG7Djkece5UyHBBabu9pLZ2HyNV6GO7vlsg1wSVv2GO/fExAjTqdPap/fjcEebnhw+ZFkAM+N4Gs8vHAIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312574; c=relaxed/simple;
	bh=YuGL2aiGqHeQOpUtTCrxnc7lbWMuKYrybH6IacruZjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFMOMnwbHh+faR8chG7mbcUFQcmXhXTX2MaPz0GAqaG/RiIuSG39Ecyr9Uog1iYy7n+eISQMzXdJEYXC+/noKUomsVZB/wjUm6nYvaqUa2pFsSO/ql1CvdsCLV1caem0vkmxZUXPoMin2GLYZ4binhrSA9L29IUH9nkktr8bS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WFTnPST3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A3fpPm101075;
	Thu, 9 May 2024 22:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715312511;
	bh=mo8nVorc8CwxHxhY4X91EqRuoA2jjCUxUj7q2d5A4j4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WFTnPST3Wpuh0KiDoAmsymedCyLB5M9IVV6cgaZlIcUEI0z/HOBvZZK5yH4vw4pY5
	 wKGJAKrZSGM0nZd3rLNBsAzuEqBdFAAbHUERw4pK85GjDHJT31Hj8cUpraSeqaUE2G
	 FcXUVEvbBq4mVNAaMhxL1zSd7jXDzyMUyVqYy/ac=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A3foN6092975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 May 2024 22:41:50 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 22:41:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 22:41:50 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.109])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A3fSBN116558;
	Thu, 9 May 2024 22:41:44 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <bard.liao@intel.com>, <yung-chuan.liao@linux.intel.com>,
        <kevin-lu@ti.com>, <cameron.berkenpas@gmail.com>, <tiwai@suse.de>,
        <baojun.xu@ti.com>, <soyer@irl.hu>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v4 3/3] ALSA: ASoc/tas2781: Fix wrong loading calibrated data sequence
Date: Fri, 10 May 2024 11:41:21 +0800
Message-ID: <20240510034123.1181-3-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240510034123.1181-1-shenghao-ding@ti.com>
References: <20240510034123.1181-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Calibrated data will be set to default after loading DSP config params,
which will cause speaker protection work abnormally. Reload calibrated
data after loading DSP config params.

Fixes: ef3bcde75d06 ("ASoc: tas2781: Add tas2781 driver")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v4:
 - Use the the culprit of the bug itself as the fixes tag
v3:
 - No changes.
v2:
 - In the Subject, fixed --> Fix
 - dsp --> DSP
 - Add Fixes tag
 - Changed the copyright year to 2024 in the related files
v1:
 - Download calibrated data after loading the new DSP config params
 - call tasdevice_prmg_load instead of tasdevice_prmg_calibdata_load, it
   is unnecessary to load calibrated data after loading DSP program. Load
   it after loading DSP config params each time.
---
 sound/soc/codecs/tas2781-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index b5abff230e43..9350972dfefe 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -2,7 +2,7 @@
 //
 // ALSA SoC Texas Instruments TAS2563/TAS2781 Audio Smart Amplifier
 //
-// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
 // https://www.ti.com
 //
 // The TAS2563/TAS2781 driver implements a flexible and configurable
@@ -414,7 +414,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 				__func__, tas_priv->cal_binaryname[i]);
 	}
 
-	tasdevice_prmg_calibdata_load(tas_priv, 0);
+	tasdevice_prmg_load(tas_priv, 0);
 	tas_priv->cur_prog = 0;
 out:
 	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
-- 
2.34.1


