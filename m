Return-Path: <linux-kernel+bounces-566629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F63FA67A99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFD418921A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2FB2144C8;
	Tue, 18 Mar 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="U4PtV3xZ"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B8212F89;
	Tue, 18 Mar 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318118; cv=none; b=lEtoCSIxQBle125dKpHFMP1KtysCVRanHInQvGhxn6eSPfeXHgSQuqYmQd8BaRzMupFNF37qav+GOa1RX3clVKjCVWn2jwVz8JQOp5rvHmYRrWw9GSQK0A4WW72zoUqE/WnKRfRwwlgNpst9DEUwOxAjimUjJychCbrA08PLB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318118; c=relaxed/simple;
	bh=SUNpd7U95e9/6EUQgBL8xA6jfmic1CV974GEwDbuTyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIpyLZWwwE8TWcR9rQCgwaSDMD1a3RnG0HlVTNryejRPBsz761F+5psPdfOBMxmYPnyhK7GFMaZ2oOkaCMxK6e7Mo5gcrpnYDxfS1IDy5mfFwedVOI1pbN5xBT+Sk9ZT5XZOsWwRN5HbZTmtUPrqtsnzBw4h6NiYLy+H8RRxVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=U4PtV3xZ; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I5qiuI018522;
	Tue, 18 Mar 2025 12:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Nlgk1ed49uKDWoWbCqbtak8/XbulrzkJ/Oo20sjqh54=; b=
	U4PtV3xZe+6Mg61bGP/ygiUIF+bE0vB1Y5BbjZ7vobLfqe2pKHalyiHnuDA66rc7
	FZUmPURE4TatI6gywqwlD80NT822oaN0sJcGiVcMe71YpvxQVXM8ifsDmVYwZZon
	loyT27IrXVVEdF6aRi/kjAIu1dl2pxWRAFTFWwqTWC+da/V+9O8z31k0GrMVRht/
	DOwDGAz7/MF5ZPeBGcKDCFHDOTTwmLKMRESocCXASJLaZ7GhQLyYyeIsbqlolwRd
	i8F3+6KPCvBeZOzjhx2W4FIJuASzoeU+r0tqaQa84eDCCRS52CrDpQDrbB7HO6Dc
	OboGgs3roMWHVAIUBLngQQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879v-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:05 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C60C8822564;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 09/15] ASoC: ops: Remove snd_soc_get_volsw_range()
Date: Tue, 18 Mar 2025 17:14:53 +0000
Message-ID: <20250318171459.3203730-10-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
References: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa19 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=8wWVALWcytAAMUzjV5cA:9
X-Proofpoint-GUID: gKmTCVgnAICgafmvcAHQcfbyeVG_v2Qq
X-Proofpoint-ORIG-GUID: gKmTCVgnAICgafmvcAHQcfbyeVG_v2Qq
X-Proofpoint-Spam-Reason: safe

With the addition of the soc_mixer_reg_to_ctl() helper it is now very
clear that the only difference between snd_soc_get_volsw() and
snd_soc_get_volsw_range() is that the former supports double controls
with both values in the same register. As such we can combine both
functions.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc.h       | 10 ++++------
 sound/soc/codecs/wm5110.c |  2 +-
 sound/soc/soc-ops.c       | 42 +++------------------------------------
 sound/soc/soc-topology.c  |  2 +-
 4 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b310f2c599f87..b11c6cdb0201c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -65,7 +65,7 @@ struct platform_device;
 	.private_value = SOC_SINGLE_VALUE(reg, shift, 0, max, invert, 0) }
 #define SOC_SINGLE_RANGE(xname, xreg, xshift, xmin, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
-	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw_range, \
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw_range, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
@@ -91,7 +91,7 @@ struct platform_device;
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_range, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
@@ -117,7 +117,7 @@ struct platform_device;
 			   xmax, xinvert)		\
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_range, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, \
 					    xshift, xmin, xmax, xinvert) }
 #define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, tlv_array) \
@@ -165,7 +165,7 @@ struct platform_device;
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_range, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, \
 					    xshift, xmin, xmax, xinvert) }
 #define SOC_DOUBLE_R_SX_TLV(xname, xreg, xrreg, xshift, xmin, xmax, tlv_array) \
@@ -571,8 +571,6 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_limit_volume(struct snd_soc_card *card,
 	const char *name, int max);
 int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 64eee0d2347da..c24b42c375785 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -477,7 +477,7 @@ static int wm5110_in_pga_get(struct snd_kcontrol *kcontrol,
 	 */
 	snd_soc_dapm_mutex_lock(dapm);
 
-	ret = snd_soc_get_volsw_range(kcontrol, ucontrol);
+	ret = snd_soc_get_volsw(kcontrol, ucontrol);
 
 	snd_soc_dapm_mutex_unlock(dapm);
 
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 1b52ba12df8df..fbda8e21c5a60 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -248,12 +248,12 @@ int snd_soc_info_volsw_sx(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw_sx);
 
 /**
- * snd_soc_get_volsw - single mixer get callback
+ * snd_soc_get_volsw - single mixer get callback with range
  * @kcontrol: mixer control
  * @ucontrol: control element information
  *
- * Callback to get the value of a single mixer control, or a double mixer
- * control that spans 2 registers.
+ * Callback to get the value, within a range, of a single mixer control, or a
+ * double mixer control that spans 2 registers.
  *
  * Returns 0 for success.
  */
@@ -506,42 +506,6 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_range);
 
-/**
- * snd_soc_get_volsw_range - single mixer get callback with range
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to get the value, within a range, of a single mixer control.
- *
- * Returns 0 for success.
- */
-int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
-			    struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int max = mc->max - mc->min;
-	unsigned int mask = soc_mixer_mask(mc);
-	unsigned int reg_val;
-	int val;
-
-	reg_val = snd_soc_component_read(component, mc->reg);
-	val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
-
-	ucontrol->value.integer.value[0] = val;
-
-	if (snd_soc_volsw_is_stereo(mc)) {
-		reg_val = snd_soc_component_read(component, mc->rreg);
-		val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
-
-		ucontrol->value.integer.value[1] = val;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
-
 static int snd_soc_clip_to_platform_max(struct snd_kcontrol *kctl)
 {
 	struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 9cbddfbbc556b..3c988925c512f 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -131,7 +131,7 @@ static const struct snd_soc_tplg_kcontrol_ops io_ops[] = {
 		snd_soc_put_enum_double, NULL},
 	{SND_SOC_TPLG_CTL_BYTES, snd_soc_bytes_get,
 		snd_soc_bytes_put, snd_soc_bytes_info},
-	{SND_SOC_TPLG_CTL_RANGE, snd_soc_get_volsw_range,
+	{SND_SOC_TPLG_CTL_RANGE, snd_soc_get_volsw,
 		snd_soc_put_volsw_range, snd_soc_info_volsw},
 	{SND_SOC_TPLG_CTL_VOLSW_XR_SX, snd_soc_get_xr_sx,
 		snd_soc_put_xr_sx, snd_soc_info_xr_sx},
-- 
2.39.5


