Return-Path: <linux-kernel+bounces-566624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEACA67A95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6207117B6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCB1A8409;
	Tue, 18 Mar 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lthcbO4x"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B64212F8A;
	Tue, 18 Mar 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318115; cv=none; b=snT6+ZDaBxmDwP90KNzAFJ+/k1OyuHgQV+W3QC1/MdRWZmrL3AZjj4o6RzfvL7+ZRwRqh0PIFXfduFwz2LdugjoBKiwJOJg606eYukAWCC9asfiPzFQJpDDEvZP1fw/mWp0ENUv5lVjygBaEB3dWApl86j5ufXmHS7BLb4IVcG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318115; c=relaxed/simple;
	bh=+dH92ocLjJ6wa0Y3SrmjwQ/JRpByKYgkdY0595FFKsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SghNCRSQe8pLVhytWae+z86M9x3UBoEKIaCh7vhFnij38iV+rE9eWSfRWp6g8qXvM1cz8XFxFikCotNXHD29SAJ1/qaCTF3VcF+yiCISRGzBO05S2XPsEkku5BvisYHpiS16SZ/rruMgpO2Iquga2jmnr/0au/QQzvOlxSjapac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lthcbO4x; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I1uEKI028771;
	Tue, 18 Mar 2025 12:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=1crjX80SD3nVHWWSLi4EhYb5XqXoj/x81vkcAIpz9V0=; b=
	lthcbO4xW9X/7G+qqSk9JqtrNyvDbda5/FCczFZ8uuokarBWP/JxaOPMzMbQwxRA
	zV/8kgnMvVJV1j+Yg9e55vB7VT7c7/4pDZBoF+KsSh/OCgBXnsDngJwPciJ2DKpg
	CbngnBoP15dZYdBAkb0yDkNKwk023xydqmMITPdNHbDYsBqkZCZ13ZZNk7Ju+32U
	6GwzHrkUu5WsoTud4f5Kmw4wtnb0OCiXSANDOykEqYVKawJ91VNnAwV0hSArkxAP
	vGfV2iUZE6oXQ5BRbuDPU/eLp299qIOOM/A1HAiE3dh3glMNiWfa5Jxx5zgWupPE
	uR/SaTSIuMz8wwbAWrIEKA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879w-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:03 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CD1E682255A;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 10/15] ASoC: ops: Remove snd_soc_put_volsw_range()
Date: Tue, 18 Mar 2025 17:14:54 +0000
Message-ID: <20250318171459.3203730-11-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa17 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=Zy0Bk6uOyu1aLBoWSYEA:9
X-Proofpoint-GUID: mXYGEWDnAHO_Idx_GePhOrT-NF4H74sZ
X-Proofpoint-ORIG-GUID: mXYGEWDnAHO_Idx_GePhOrT-NF4H74sZ
X-Proofpoint-Spam-Reason: safe

With the addition of the soc_mixer_ctl_to_reg() helper it is now very
clear that the only difference between snd_soc_put_volsw() and
snd_soc_put_volsw_range() is that the former supports double controls
with both values in the same register. As such we can combine both
functions.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc.h       | 10 +++----
 sound/soc/codecs/wm5110.c |  2 +-
 sound/soc/soc-ops.c       | 62 ++-------------------------------------
 sound/soc/soc-topology.c  |  2 +-
 4 files changed, 9 insertions(+), 67 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b11c6cdb0201c..952ed77b8c87f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -66,7 +66,7 @@ struct platform_device;
 #define SOC_SINGLE_RANGE(xname, xreg, xshift, xmin, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
-	.put = snd_soc_put_volsw_range, \
+	.put = snd_soc_put_volsw, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -91,7 +91,7 @@ struct platform_device;
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_range, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
@@ -117,7 +117,7 @@ struct platform_device;
 			   xmax, xinvert)		\
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_range, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, \
 					    xshift, xmin, xmax, xinvert) }
 #define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, tlv_array) \
@@ -165,7 +165,7 @@ struct platform_device;
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_range, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, \
 					    xshift, xmin, xmax, xinvert) }
 #define SOC_DOUBLE_R_SX_TLV(xname, xreg, xrreg, xshift, xmin, xmax, tlv_array) \
@@ -569,8 +569,6 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_limit_volume(struct snd_soc_card *card,
 	const char *name, int max);
 int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index c24b42c375785..212eca675f27e 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -497,7 +497,7 @@ static int wm5110_in_pga_put(struct snd_kcontrol *kcontrol,
 	 */
 	snd_soc_dapm_mutex_lock(dapm);
 
-	ret = snd_soc_put_volsw_range(kcontrol, ucontrol);
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
 
 	snd_soc_dapm_mutex_unlock(dapm);
 
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index fbda8e21c5a60..d26d9e050af12 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -289,12 +289,12 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw);
 
 /**
- * snd_soc_put_volsw - single mixer put callback
+ * snd_soc_put_volsw - single mixer put callback with range
  * @kcontrol: mixer control
  * @ucontrol: control element information
  *
- * Callback to set the value of a single mixer control, or a double mixer
- * control that spans 2 registers.
+ * Callback to set the value , within a range, of a single mixer control, or
+ * a double mixer control that spans 2 registers.
  *
  * Returns 0 for success.
  */
@@ -450,62 +450,6 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_sx);
 
-/**
- * snd_soc_put_volsw_range - single mixer put value callback with range.
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to set the value, within a range, for a single mixer control.
- *
- * Returns 0 for success.
- */
-int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
-			    struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
-	unsigned int reg = mc->reg;
-	unsigned int rreg = mc->rreg;
-	int max = mc->max - mc->min;
-	unsigned int mask = soc_mixer_mask(mc);
-	unsigned int val_mask = mask << mc->shift;
-	unsigned int val;
-	int err, ret;
-
-	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0],
-				  mc->max - mc->min);
-	if (ret)
-		return ret;
-
-	val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[0],
-				   mask, mc->shift, max);
-
-	err = snd_soc_component_update_bits(component, reg, val_mask, val);
-	if (err < 0)
-		return err;
-	ret = err;
-
-	if (snd_soc_volsw_is_stereo(mc)) {
-		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1],
-					  max);
-		if (ret)
-			return ret;
-
-		val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[1],
-					   mask, mc->shift, max);
-
-		err = snd_soc_component_update_bits(component, rreg, val_mask,
-						    val);
-		/* Don't discard any error code or drop change flag */
-		if (ret == 0 || err < 0)
-			ret = err;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(snd_soc_put_volsw_range);
-
 static int snd_soc_clip_to_platform_max(struct snd_kcontrol *kctl)
 {
 	struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 3c988925c512f..7b0b8531bb32f 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -132,7 +132,7 @@ static const struct snd_soc_tplg_kcontrol_ops io_ops[] = {
 	{SND_SOC_TPLG_CTL_BYTES, snd_soc_bytes_get,
 		snd_soc_bytes_put, snd_soc_bytes_info},
 	{SND_SOC_TPLG_CTL_RANGE, snd_soc_get_volsw,
-		snd_soc_put_volsw_range, snd_soc_info_volsw},
+		snd_soc_put_volsw, snd_soc_info_volsw},
 	{SND_SOC_TPLG_CTL_VOLSW_XR_SX, snd_soc_get_xr_sx,
 		snd_soc_put_xr_sx, snd_soc_info_xr_sx},
 	{SND_SOC_TPLG_CTL_STROBE, snd_soc_get_strobe,
-- 
2.39.5


