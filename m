Return-Path: <linux-kernel+bounces-176787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B632C8C34E3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 04:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A633281A9D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 02:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBCCEEDD;
	Sun, 12 May 2024 02:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wGSj/X4l"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79698C8E9
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715482335; cv=none; b=FMuZMpIREDcURz19QHpnIJB/po8JtyCJyVyj4+VsDaIyR/fxKQNDcgHQtkxPMwkhybhbCiDUqM7JgrKosROy3FxsqJhxAhR3a5fcImjW+bqiW3UgKkonn63CR+esc2oqMubkTsf1vSWNMz5a0dFIHV7Mw0brXGt7Fs8sZ3Wsq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715482335; c=relaxed/simple;
	bh=ToAwIbvzHG0YYLRGugwY07ZmC28i54igLPITw5CgNEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYEwcaU5HtPnKm8yfVW6DIDeesQZ6LslvKTNzHuyif/oBe9V4L3Kqc73npXKsQWKUV6btCRLCv0AWjtwgnQmGwGtzVmFqCsfIBWHJ/zHdg6ZoNezKHz5/XDH4RpVo8jGprpMzf1T/UkliH017XCkguW9L9udwNGX++69Npp+o+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wGSj/X4l; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44C2p9n9130107;
	Sat, 11 May 2024 21:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715482269;
	bh=6H5QqjfnbzXi38Mhan1b/OhNz0VkiYrd/rdH/mh5vbs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wGSj/X4lJc82ItidZ2aZM0UTuoU4USS2IFBu0WJkiA92ri2otkyAcJw4LCYUUBPSA
	 yCsX/zTrmlMiMHSwKbnkaS3b+6NvhPIrC9RxARqXx3dI5M3RtplTTqCRILd3P+RgnM
	 dUGGGpQs7noFtwjnAlY8JTvMXnZ3rp4f2/KKesmo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44C2p9MP062482
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 11 May 2024 21:51:09 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 11
 May 2024 21:51:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 11 May 2024 21:51:08 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.109])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44C2ojfR039978;
	Sat, 11 May 2024 21:51:02 -0500
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
Subject: [PATCH v5 3/3] ASoC: tas2781: Fix wrong loading calibrated data sequence
Date: Sun, 12 May 2024 10:50:39 +0800
Message-ID: <20240512025040.1276-3-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240512025040.1276-1-shenghao-ding@ti.com>
References: <20240512025040.1276-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the API with correct sequence instead of the wrong one.

Fixes: ef3bcde75d06 ("ASoc: tas2781: Add tas2781 driver")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v5:
 - correct changelog has no much relationship with the patch
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
 - Call tasdevice_prmg_load instead of tasdevice_prmg_calibdata_load, it
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


