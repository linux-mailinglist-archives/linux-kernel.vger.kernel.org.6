Return-Path: <linux-kernel+bounces-204286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7B88FE6BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85974B2158B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA2195B0E;
	Thu,  6 Jun 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KrPhtBIC"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92444195981
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677797; cv=none; b=QxTpL/Jdz04Qcw+hvXqamTr/ZYHqb0mSMlkSqT5BfdqF9f/0AMQ/1RvNUVs5b72SG34miBI8+GAcB2s1GNdbZAdSwjizqaaCSRRpPv3J6eu73j2T70KZuwZq70k9yQr6YTuc+hLMhR60yzIM63Wsfl7bpObcLJbsidk8vBNjscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677797; c=relaxed/simple;
	bh=PzL3Agibp2BwAUGKAq4VnWqww86W93usoupJOjzqlQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CtKu0DPAZoflCJBOE/dRWpfV9MUbL+1qQqdcVN9QjBKVVs8Ozy0epPTo31++nnuO04mNczIgyC8qy37hrtmILzEJ+cFTF1z0McHRxoKC9Y4qbu8LO9sVEBvPyNR9IHydy3R1uiU4o+HSXCjtBqnLHOz2wiof99tI+nHIr3WJjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KrPhtBIC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 456CfLTs113415;
	Thu, 6 Jun 2024 07:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717677681;
	bh=swyYL/UTh/fJIrJdY36x8AgMYNmXTYRmwCF34ITHoj4=;
	h=From:To:CC:Subject:Date;
	b=KrPhtBICtQCzyNuZnJ8b7wwxW8OP4WMYICJHklMQAM5zM2+q57syNvTz0Ik8OByNF
	 aWfa5DCMffEKHwbNJkN/Tx3gwI0fP3GHfG3sm4TAr/XE6+Geh0mIJFXTo7YQzXeIE1
	 BD7gIoLzPImGPpY7mGVazwQ8ijGj5nBFV2Hc8t4I=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 456CfLbq006673
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 07:41:21 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 07:41:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 07:41:20 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.158])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 456CfAJt103595;
	Thu, 6 Jun 2024 07:41:11 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <zhourui@huaqin.com>,
        <alsa-devel@alsa-project.org>, <i-salazar@ti.com>,
        <linux-kernel@vger.kernel.org>, <j-chadha@ti.com>,
        <liam.r.girdwood@intel.com>, <jaden-yue@ti.com>,
        <yung-chuan.liao@linux.intel.com>, <dipa@ti.com>, <yuhsuan@google.com>,
        <henry.lo@ti.com>, <tiwai@suse.de>, <baojun.xu@ti.com>, <soyer@irl.hu>,
        <Baojun.Xu@fpt.com>, <judyhsiao@google.com>, <navada@ti.com>,
        <cujomalainey@google.com>, <aanya@ti.com>, <nayeem.mahmud@ti.com>,
        <savyasanchi.shukla@netradyne.com>, <flaviopr@microsoft.com>,
        <jesse-ji@ti.com>, <darren.ye@mediatek.com>,
        Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [RESEND PATCH v4] ASoc: tas2781: Enable RCA-based playback without DSP firmware download
Date: Thu, 6 Jun 2024 20:41:03 +0800
Message-ID: <20240606124105.1492-1-shenghao-ding@ti.com>
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

In only RCA (Reconfigurable Architecture) binary case, no DSP program will
be working inside tas2563/tas2781, that is dsp-bypass mode, do not support
speaker protection, and audio acoustic algorithms in this mode.

Fixes: ef3bcde75d06 ("ASoC: tas2781: Add tas2781 driver")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v4:
 - add a description of what the state machine looks like, and why
   FW_PENDING/FAIL remain but are not used.
 - Remove TASDEVICE_DSP_FW_NONE because of unused.
 - Remove stray change.
 - Fix broken indentation.
v3:
 - Add description on RCA is Reconfigurable Architecture.
 - Add the description on enabling
 - Reword the commit
 - Remove question mark in the comments.
 - Add spaces in comments.
v2:
 - Correct comment.
 - Add Fixes.
 - Move header file to the first.
v1:
 - Split out the different logical changes into different patches.
 - rename tasdevice_dsp_fw_state -> tasdevice_fw_state, the fw are not
   only DSP fw, but also RCA(Reconfigurable data, such as acoustic data
   and register setting, etc).
 - Add TASDEVICE_RCA_FW_OK in tasdevice_fw_state to identify the state
   that only RCA binary file has been download successfully, but DSP fw
   is not loaded or loading failure.
 - Add the this strategy into tasdevice_tuning_switch.
 - If one side of the if/else has a braces both should in
   tasdevice_tuning_switch.
 - Identify whehter both RCA and DSP have been loaded or only RCA has
   been loaded in tasdevice_fw_ready.
 - Add check fw load status in tasdevice_startup.
 - remove ret in tasdevice_startup to make the code neater.
---
 include/sound/tas2781-dsp.h       | 11 ++++++++--
 sound/soc/codecs/tas2781-fmwlib.c | 18 +++++++++++-----
 sound/soc/codecs/tas2781-i2c.c    | 34 +++++++++++++++++++------------
 3 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/include/sound/tas2781-dsp.h b/include/sound/tas2781-dsp.h
index 7fba7ea26a4b..3cda9da14f6d 100644
--- a/include/sound/tas2781-dsp.h
+++ b/include/sound/tas2781-dsp.h
@@ -117,10 +117,17 @@ struct tasdevice_fw {
 	struct device *dev;
 };
 
-enum tasdevice_dsp_fw_state {
-	TASDEVICE_DSP_FW_NONE = 0,
+enum tasdevice_fw_state {
+	/* Driver in startup mode, not load any firmware. */
 	TASDEVICE_DSP_FW_PENDING,
+	/* DSP firmware in the system, but parsing error. */
 	TASDEVICE_DSP_FW_FAIL,
+	/*
+	 * Only RCA (Reconfigurable Architecture) firmware load
+	 * successfully.
+	 */
+	TASDEVICE_RCA_FW_OK,
+	/* Both RCA and DSP firmware load successfully. */
 	TASDEVICE_DSP_FW_ALL_OK,
 };
 
diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 265a8ca25cbb..838d29fead96 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -2324,14 +2324,21 @@ void tasdevice_tuning_switch(void *context, int state)
 	struct tasdevice_fw *tas_fmw = tas_priv->fmw;
 	int profile_cfg_id = tas_priv->rcabin.profile_cfg_id;
 
-	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
-		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
+	/*
+	 * Only RCA-based Playback can still work with no dsp program running
+	 * inside the chip.
+	 */
+	switch (tas_priv->fw_state) {
+	case TASDEVICE_RCA_FW_OK:
+	case TASDEVICE_DSP_FW_ALL_OK:
+		break;
+	default:
 		return;
 	}
 
 	if (state == 0) {
-		if (tas_priv->cur_prog < tas_fmw->nr_programs) {
-			/*dsp mode or tuning mode*/
+		if (tas_fmw && tas_priv->cur_prog < tas_fmw->nr_programs) {
+			/* dsp mode or tuning mode */
 			profile_cfg_id = tas_priv->rcabin.profile_cfg_id;
 			tasdevice_select_tuningprm_cfg(tas_priv,
 				tas_priv->cur_prog, tas_priv->cur_conf,
@@ -2340,9 +2347,10 @@ void tasdevice_tuning_switch(void *context, int state)
 
 		tasdevice_select_cfg_blk(tas_priv, profile_cfg_id,
 			TASDEVICE_BIN_BLK_PRE_POWER_UP);
-	} else
+	} else {
 		tasdevice_select_cfg_blk(tas_priv, profile_cfg_id,
 			TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(tasdevice_tuning_switch,
 	SND_SOC_TAS2781_FMWLIB);
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 9350972dfefe..9c3c89cb36de 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -380,23 +380,32 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	mutex_lock(&tas_priv->codec_lock);
 
 	ret = tasdevice_rca_parser(tas_priv, fmw);
-	if (ret)
+	if (ret) {
+		tasdevice_config_info_remove(tas_priv);
 		goto out;
+	}
 	tasdevice_create_control(tas_priv);
 
 	tasdevice_dsp_remove(tas_priv);
 	tasdevice_calbin_remove(tas_priv);
-	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
+	tas_priv->fw_state = TASDEVICE_RCA_FW_OK;
 	scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
 		tas_priv->dev_name);
 	ret = tasdevice_dsp_parser(tas_priv);
 	if (ret) {
 		dev_err(tas_priv->dev, "dspfw load %s error\n",
 			tas_priv->coef_binaryname);
-		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
 		goto out;
 	}
-	tasdevice_dsp_create_ctrls(tas_priv);
+
+	/*
+	 * If no dsp-related kcontrol created, the dsp resource will be freed.
+	 */
+	ret = tasdevice_dsp_create_ctrls(tas_priv);
+	if (ret) {
+		dev_err(tas_priv->dev, "dsp controls error\n");
+		goto out;
+	}
 
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
 
@@ -417,9 +426,8 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	tasdevice_prmg_load(tas_priv, 0);
 	tas_priv->cur_prog = 0;
 out:
-	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
-		/*If DSP FW fail, kcontrol won't be created */
-		tasdevice_config_info_remove(tas_priv);
+	if (tas_priv->fw_state == TASDEVICE_RCA_FW_OK) {
+		/* If DSP FW fail, DSP kcontrol won't be created. */
 		tasdevice_dsp_remove(tas_priv);
 	}
 	mutex_unlock(&tas_priv->codec_lock);
@@ -466,14 +474,14 @@ static int tasdevice_startup(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *codec = dai->component;
 	struct tasdevice_priv *tas_priv = snd_soc_component_get_drvdata(codec);
-	int ret = 0;
 
-	if (tas_priv->fw_state != TASDEVICE_DSP_FW_ALL_OK) {
-		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
-		ret = -EINVAL;
+	switch (tas_priv->fw_state) {
+	case TASDEVICE_RCA_FW_OK:
+	case TASDEVICE_DSP_FW_ALL_OK:
+		return 0;
+	default:
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static int tasdevice_hw_params(struct snd_pcm_substream *substream,
-- 
2.34.1


