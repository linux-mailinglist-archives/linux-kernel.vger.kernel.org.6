Return-Path: <linux-kernel+bounces-329224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FBB978ED7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25451F24037
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89413A26B;
	Sat, 14 Sep 2024 07:24:19 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3783CD6;
	Sat, 14 Sep 2024 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726298659; cv=none; b=AK4uGMC0rdWTmtcBJdxdX661gOva1QKy7aCPmFbUYf07FOUN+R6nOjJlRSSjTxc/wYNds1Pevqrau2I3AaxZRwiIJsHgyzST+6Bm/xpuZiAVj1sWT03nodNWuUuov6WdSaclrFXn447Lsn89UtnfsF15BDzNkjA4DSkC2yBPrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726298659; c=relaxed/simple;
	bh=VkMGAtffLbvdQYgO/+tFo8X5yq65AjvU2bRStlj604g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fHdH4Xxt1ZfenZgJmiRdxj/UhcqZa6j4aIkDLrmL6j9iE4VgtGdNZGTuxarb3Y/z2hUu04p1NqNAjpijT8DperDtmQDhjk2ueqTaXnR/qePLUAQXbzeUPEXRF+PQslG8tDryYofMYwb31askOvvaaCF9O6v1phKKzJF6tz97K/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766e53a1a0c5-390cb;
	Sat, 14 Sep 2024 15:24:13 +0800 (CST)
X-RM-TRANSID:2ee766e53a1a0c5-390cb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from leadsec.example.com.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766e53a1344e-94fe4;
	Sat, 14 Sep 2024 15:24:12 +0800 (CST)
X-RM-TRANSID:2ee766e53a1344e-94fe4
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: tas2781: Fix redundant parameter assignment
Date: Sat, 14 Sep 2024 15:23:52 +0800
Message-Id: <20240914072352.2997-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In these functions, the variable 'rc' is redundant,
thus remove it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/codecs/tas2781-i2c.c | 35 ++++++++--------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 8a8d97dd7..68887799e 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -650,7 +650,6 @@ static int tasdev_tf_data_get(struct snd_kcontrol *kcontrol,
 		(struct soc_bytes_ext *) kcontrol->private_value;
 	unsigned char *dst = ucontrol->value.bytes.data;
 	unsigned int reg;
-	int rc = -1;
 
 	if (tas_priv->chip_id == TAS2781)
 		reg = TAS2781_RUNTIME_RE_REG_TF;
@@ -659,9 +658,7 @@ static int tasdev_tf_data_get(struct snd_kcontrol *kcontrol,
 
 	guard(mutex)(&tas_priv->codec_lock);
 	dst[0] = bytes_ext->max;
-	rc = calib_data_get(tas_priv, reg, &dst[1]);
-
-	return rc;
+	return calib_data_get(tas_priv, reg, &dst[1]);
 }
 
 static int tasdev_re_data_get(struct snd_kcontrol *kcontrol,
@@ -673,7 +670,6 @@ static int tasdev_re_data_get(struct snd_kcontrol *kcontrol,
 		(struct soc_bytes_ext *) kcontrol->private_value;
 	unsigned char *dst = ucontrol->value.bytes.data;
 	unsigned int reg;
-	int rc = -1;
 
 	if (tas_priv->chip_id == TAS2781)
 		reg = TAS2781_RUNTIME_RE_REG;
@@ -681,9 +677,7 @@ static int tasdev_re_data_get(struct snd_kcontrol *kcontrol,
 		reg = TAS2563_RUNTIME_RE_REG;
 	guard(mutex)(&tas_priv->codec_lock);
 	dst[0] = bytes_ext->max;
-	rc = calib_data_get(tas_priv, reg, &dst[1]);
-
-	return rc;
+	return calib_data_get(tas_priv, reg, &dst[1]);
 }
 
 static int tasdev_r0_data_get(struct snd_kcontrol *kcontrol,
@@ -696,7 +690,6 @@ static int tasdev_r0_data_get(struct snd_kcontrol *kcontrol,
 		(struct soc_bytes_ext *) kcontrol->private_value;
 	unsigned char *dst = ucontrol->value.bytes.data;
 	unsigned int reg;
-	int rc = -1;
 
 	guard(mutex)(&tas_priv->codec_lock);
 
@@ -707,9 +700,7 @@ static int tasdev_r0_data_get(struct snd_kcontrol *kcontrol,
 	else
 		return -1;
 	dst[0] = bytes_ext->max;
-	rc = calib_data_get(tas_priv, reg, &dst[1]);
-
-	return rc;
+	return calib_data_get(tas_priv, reg, &dst[1]);
 }
 
 static int tasdev_XMA1_data_get(struct snd_kcontrol *kcontrol,
@@ -721,13 +712,10 @@ static int tasdev_XMA1_data_get(struct snd_kcontrol *kcontrol,
 		(struct soc_bytes_ext *) kcontrol->private_value;
 	unsigned char *dst = ucontrol->value.bytes.data;
 	unsigned int reg = TASDEVICE_XM_A1_REG;
-	int rc = -1;
 
 	guard(mutex)(&tas_priv->codec_lock);
 	dst[0] = bytes_ext->max;
-	rc = calib_data_get(tas_priv, reg, &dst[1]);
-
-	return rc;
+	return calib_data_get(tas_priv, reg, &dst[1]);
 }
 
 static int tasdev_XMA2_data_get(struct snd_kcontrol *kcontrol,
@@ -739,13 +727,10 @@ static int tasdev_XMA2_data_get(struct snd_kcontrol *kcontrol,
 		(struct soc_bytes_ext *) kcontrol->private_value;
 	unsigned char *dst = ucontrol->value.bytes.data;
 	unsigned int reg = TASDEVICE_XM_A2_REG;
-	int rc = -1;
 
 	guard(mutex)(&tas_priv->codec_lock);
 	dst[0] = bytes_ext->max;
-	rc = calib_data_get(tas_priv, reg, &dst[1]);
-
-	return rc;
+	return calib_data_get(tas_priv, reg, &dst[1]);
 }
 
 static int tasdev_nop_get(
@@ -1115,14 +1100,12 @@ static int tasdevice_active_num_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
 	struct tasdevice_priv *tas_priv = snd_soc_component_get_drvdata(codec);
 	int dev_id = ucontrol->value.integer.value[0];
-	int max = tas_priv->ndev - 1, rc;
+	int max = tas_priv->ndev - 1;
 
 	dev_id = clamp(dev_id, 0, max);
 
 	guard(mutex)(&tas_priv->codec_lock);
-	rc = tasdev_chn_switch(tas_priv, dev_id);
-
-	return rc;
+	return tasdev_chn_switch(tas_priv, dev_id);
 }
 
 static int tasdevice_dsp_create_ctrls(struct tasdevice_priv *tas_priv)
@@ -1339,10 +1322,8 @@ static int tasdevice_create_cali_ctrls(struct tasdevice_priv *priv)
 		i++;
 	}
 
-	rc = snd_soc_add_component_controls(priv->codec, cali_ctrls,
+	return snd_soc_add_component_controls(priv->codec, cali_ctrls,
 		nctrls < i ? nctrls : i);
-
-	return rc;
 }
 
 static void tasdevice_fw_ready(const struct firmware *fmw,
-- 
2.33.0




