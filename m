Return-Path: <linux-kernel+bounces-566615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E731A67A88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225823A7427
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DD212D69;
	Tue, 18 Mar 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="aSkTCxV5"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D51211A2B;
	Tue, 18 Mar 2025 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318110; cv=none; b=t/rt5De+x38qoQnZdMrTQH6l6LxRGoYXXa5NjkYJzTU1OtTw698orX/D1RT5ELXluP4ztudUFN10o28SSsy/SZvQiePB8wsrwZzIXEheVFP3XBPlEEw5XZThR+kBOalFQdJSuwYNpxM4vIVdduKZJ+kqSZ7JJorYw+U6Ay7X2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318110; c=relaxed/simple;
	bh=3yI3M08MXAsxiX03n3uak+qUVfekmtgkjUwaN5HtcYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bM6FwrMKy+x4ecszkV//pyJvZvda7GWPWLcQ+BHhgxAcz5AR5fbVp27Px0K5hvZvHXzSXYJ9/VF9mVOVg7Molr0U78UaYHxE0zGJ5jGOxDSQO7qw0MKaxlCiiSZiERwa2qWyDthdJy1cuXjh/vHPJSKnyQ9FScDh+NbI8ep9a6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=aSkTCxV5; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I1uEKG028771;
	Tue, 18 Mar 2025 12:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ZFYxIfOcbKtSMKnm2CueQFeeVhTYx0GZR431HLNVbt8=; b=
	aSkTCxV5FWC1h23HkPnoSCkjeMDUYSG6KrMdvI+acnszt7fjIuMc8NF/BpEBpsPw
	kazgk8eUDOB8dV5bUNlDEJ7G/YA1QMj+NHzwqyu2EP/qs54jmb0AzVAQtiLZp4NZ
	E74aXNY2SlWycZAdOOHWtc3pngIiI+oj8Ck00GEiEi5BqjYoC9zXklryXOBf/PeP
	ebCtV3WxIc+qT8VXuh6eDQWW1kDapsm0HhaLFktXO7pV5rF/gWHnGXbdtVjnsnv9
	VqjaJZm1iQLIc3nBFfpwpNYoDs0A6w5lqOdwsyHOtrd+TIExhoaAbudjzpFJydxu
	xe/A6d6KvFSQZleHa8tlBg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:02 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8141E82255D;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 02/15] ASoC: ops: Minor formatting fixups
Date: Tue, 18 Mar 2025 17:14:46 +0000
Message-ID: <20250318171459.3203730-3-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa16 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=2oxQ3XchGMypiEoI-R8A:9
X-Proofpoint-GUID: XZr7TeV9P7Lfnn7bpmziQm0j6Xrf4ux9
X-Proofpoint-ORIG-GUID: XZr7TeV9P7Lfnn7bpmziQm0j6Xrf4ux9
X-Proofpoint-Spam-Reason: safe

No functional changes just tidying up some tabbing etc.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-ops.c | 106 ++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 52 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index cd5f927bcd4eb..9039bf3b6fb48 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -37,7 +37,7 @@
  * Returns 0 for success.
  */
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+			     struct snd_ctl_elem_info *uinfo)
 {
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 
@@ -56,7 +56,7 @@ EXPORT_SYMBOL_GPL(snd_soc_info_enum_double);
  * Returns 0 for success.
  */
 int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+			    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
@@ -87,7 +87,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_enum_double);
  * Returns 0 for success.
  */
 int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+			    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
@@ -124,8 +124,9 @@ EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);
  * the given registervalue into a signed integer if sign_bit is non-zero.
  */
 static void snd_soc_read_signed(struct snd_soc_component *component,
-	unsigned int reg, unsigned int mask, unsigned int shift,
-	unsigned int sign_bit, int *signed_val)
+				unsigned int reg, unsigned int mask,
+				unsigned int shift, unsigned int sign_bit,
+				int *signed_val)
 {
 	int ret;
 	unsigned int val;
@@ -168,7 +169,7 @@ static void snd_soc_read_signed(struct snd_soc_component *component,
  * Returns 0 for success.
  */
 int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+		       struct snd_ctl_elem_info *uinfo)
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
@@ -247,7 +248,7 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_sx);
  * Returns 0 for success.
  */
 int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+		      struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
@@ -300,7 +301,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw);
  * Returns 0 for success.
  */
 int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+		      struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
@@ -362,9 +363,8 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 		err = snd_soc_component_update_bits(component, reg2, val_mask,
 						    val2);
 		/* Don't discard any error code or drop change flag */
-		if (ret == 0 || err < 0) {
+		if (ret == 0 || err < 0)
 			ret = err;
-		}
 	}
 
 	return ret;
@@ -382,11 +382,11 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
  * Returns 0 for success.
  */
 int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
-		      struct snd_ctl_elem_value *ucontrol)
+			 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
-	    (struct soc_mixer_control *)kcontrol->private_value;
+		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
@@ -423,18 +423,17 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
-	    (struct soc_mixer_control *)kcontrol->private_value;
-
+		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
+	unsigned int val, val_mask;
 	int max = mc->max;
 	int min = mc->min;
 	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
 	int err = 0;
 	int ret;
-	unsigned int val, val_mask;
 
 	if (ucontrol->value.integer.value[0] < 0)
 		return -EINVAL;
@@ -465,13 +464,13 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 		val2 = val2 << rshift;
 
 		err = snd_soc_component_update_bits(component, reg2, val_mask,
-			val2);
+						    val2);
 
 		/* Don't discard any error code or drop change flag */
-		if (ret == 0 || err < 0) {
+		if (ret == 0 || err < 0)
 			ret = err;
-		}
 	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_sx);
@@ -487,7 +486,7 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw_sx);
  * returns 0 for success.
  */
 int snd_soc_info_volsw_range(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+			     struct snd_ctl_elem_info *uinfo)
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
@@ -516,7 +515,7 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_range);
  * Returns 0 for success.
  */
 int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+			    struct snd_ctl_elem_value *ucontrol)
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
@@ -568,11 +567,10 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 		val = val << shift;
 
 		err = snd_soc_component_update_bits(component, rreg, val_mask,
-			val);
+						    val);
 		/* Don't discard any error code or drop change flag */
-		if (ret == 0 || err < 0) {
+		if (ret == 0 || err < 0)
 			ret = err;
-		}
 	}
 
 	return ret;
@@ -589,7 +587,7 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw_range);
  * Returns 0 for success.
  */
 int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+			    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
@@ -663,8 +661,7 @@ static int snd_soc_clip_to_platform_max(struct snd_kcontrol *kctl)
  *
  * Return 0 for success, else error.
  */
-int snd_soc_limit_volume(struct snd_soc_card *card,
-	const char *name, int max)
+int snd_soc_limit_volume(struct snd_soc_card *card, const char *name, int max)
 {
 	struct snd_kcontrol *kctl;
 	int ret = -EINVAL;
@@ -675,12 +672,15 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 
 	kctl = snd_soc_card_get_kcontrol(card, name);
 	if (kctl) {
-		struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
+		struct soc_mixer_control *mc =
+			(struct soc_mixer_control *)kctl->private_value;
+
 		if (max <= mc->max - mc->min) {
 			mc->platform_max = max;
 			ret = snd_soc_clip_to_platform_max(kctl);
 		}
 	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_limit_volume);
@@ -740,8 +740,8 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_bytes *params = (void *)kcontrol->private_value;
-	int ret, len;
 	unsigned int val, mask;
+	int ret, len;
 
 	if (!component->regmap || !params->num_regs)
 		return -EINVAL;
@@ -772,15 +772,13 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 			break;
 		case 2:
 			mask = ~params->mask;
-			ret = regmap_parse_val(component->regmap,
-							&mask, &mask);
+			ret = regmap_parse_val(component->regmap, &mask, &mask);
 			if (ret != 0)
 				return ret;
 
 			((u16 *)data)[0] &= mask;
 
-			ret = regmap_parse_val(component->regmap,
-							&val, &val);
+			ret = regmap_parse_val(component->regmap, &val, &val);
 			if (ret != 0)
 				return ret;
 
@@ -788,15 +786,13 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 			break;
 		case 4:
 			mask = ~params->mask;
-			ret = regmap_parse_val(component->regmap,
-							&mask, &mask);
+			ret = regmap_parse_val(component->regmap, &mask, &mask);
 			if (ret != 0)
 				return ret;
 
 			((u32 *)data)[0] &= mask;
 
-			ret = regmap_parse_val(component->regmap,
-							&val, &val);
+			ret = regmap_parse_val(component->regmap, &val, &val);
 			if (ret != 0)
 				return ret;
 
@@ -812,7 +808,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_bytes_put);
 
 int snd_soc_bytes_info_ext(struct snd_kcontrol *kcontrol,
-			struct snd_ctl_elem_info *ucontrol)
+			   struct snd_ctl_elem_info *ucontrol)
 {
 	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
 
@@ -824,7 +820,7 @@ int snd_soc_bytes_info_ext(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_bytes_info_ext);
 
 int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
-				unsigned int size, unsigned int __user *tlv)
+			       unsigned int size, unsigned int __user *tlv)
 {
 	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
 	unsigned int count = size < params->max ? size : params->max;
@@ -840,6 +836,7 @@ int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
 			ret = params->put(kcontrol, tlv, count);
 		break;
 	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_bytes_tlv_callback);
@@ -856,10 +853,11 @@ EXPORT_SYMBOL_GPL(snd_soc_bytes_tlv_callback);
  * Returns 0 for success.
  */
 int snd_soc_info_xr_sx(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+		       struct snd_ctl_elem_info *uinfo)
 {
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = mc->min;
@@ -883,7 +881,7 @@ EXPORT_SYMBOL_GPL(snd_soc_info_xr_sx);
  * Returns 0 for success.
  */
 int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+		      struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mreg_control *mc =
@@ -891,17 +889,18 @@ int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
 	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
-	unsigned int regwmask = (1UL<<regwshift)-1;
+	unsigned int regwmask = (1UL << regwshift) - 1;
 	unsigned int invert = mc->invert;
-	unsigned long mask = (1UL<<mc->nbits)-1;
+	unsigned long mask = (1UL << mc->nbits) - 1;
 	long min = mc->min;
 	long max = mc->max;
 	long val = 0;
 	unsigned int i;
 
 	for (i = 0; i < regcount; i++) {
-		unsigned int regval = snd_soc_component_read(component, regbase+i);
-		val |= (regval & regwmask) << (regwshift*(regcount-i-1));
+		unsigned int regval = snd_soc_component_read(component, regbase + i);
+
+		val |= (regval & regwmask) << (regwshift * (regcount - i - 1));
 	}
 	val &= mask;
 	if (min < 0 && val > max)
@@ -928,7 +927,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_xr_sx);
  * Returns 0 for success.
  */
 int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+		      struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mreg_control *mc =
@@ -936,9 +935,9 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
 	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
-	unsigned int regwmask = (1UL<<regwshift)-1;
+	unsigned int regwmask = (1UL << regwshift) - 1;
 	unsigned int invert = mc->invert;
-	unsigned long mask = (1UL<<mc->nbits)-1;
+	unsigned long mask = (1UL << mc->nbits) - 1;
 	long max = mc->max;
 	long val = ucontrol->value.integer.value[0];
 	int ret = 0;
@@ -950,10 +949,13 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 		val = max - val;
 	val &= mask;
 	for (i = 0; i < regcount; i++) {
-		unsigned int regval = (val >> (regwshift*(regcount-i-1))) & regwmask;
-		unsigned int regmask = (mask >> (regwshift*(regcount-i-1))) & regwmask;
-		int err = snd_soc_component_update_bits(component, regbase+i,
+		unsigned int regval = (val >> (regwshift * (regcount - i - 1))) &
+				      regwmask;
+		unsigned int regmask = (mask >> (regwshift * (regcount - i - 1))) &
+				       regwmask;
+		int err = snd_soc_component_update_bits(component, regbase + i,
 							regmask, regval);
+
 		if (err < 0)
 			return err;
 		if (err > 0)
@@ -974,7 +976,7 @@ EXPORT_SYMBOL_GPL(snd_soc_put_xr_sx);
  * Returns 0 for success.
  */
 int snd_soc_get_strobe(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+		       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
@@ -1007,7 +1009,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_strobe);
  * Returns 1 for success.
  */
 int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+		       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
-- 
2.39.5


