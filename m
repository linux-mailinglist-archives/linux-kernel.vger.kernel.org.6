Return-Path: <linux-kernel+bounces-566628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B517A67A97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6534C17D9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2DD214227;
	Tue, 18 Mar 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VNaCg4gk"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092632135AD;
	Tue, 18 Mar 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318118; cv=none; b=dqnUkjWgnW2++RE8qfWqXnjgISw0tqvwo9Bd3/LxVdIMGvOm9t1LkFTVHJ1y8ArOuw21imxgAVUMMfkao52E6KYrhSI+tvTHm2Pe0+vuZs487ua5qciA8dhyx+2rgWNKQ+/I2H556RGYeCKI5NeDOHyPOjQThn8mBlz2T8cjyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318118; c=relaxed/simple;
	bh=dNi8FldfqZTRvAb5mBNjWGszg5vSj5xps+QDbo+nwfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYugpPc0DX0dw7VEs2TwJR8qNEbBslQGVgbqJK6OE5FAWE4Vqha7iv+OdF/QmkUawLd8k95oeaQmEQb0qGQlfhI3nebVPj/koJkah//9fdKcHnQ6a5ePUSBe/xNWh/5r/rO7J1dMMgCebtrO1ZwcjoEfFykCMzulUSKMFrs92Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VNaCg4gk; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I5qiuG018522;
	Tue, 18 Mar 2025 12:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UtEUg1z2/X340wR95EWqtUz/EOiezuwcYYLeLEYlHKs=; b=
	VNaCg4gklqTQgCW+92IC/g6XD2sbwoWGo8bEFNouBx3T3j4xYPiDYS4qMmsIsNF7
	8D+aDH+orrs2Fy47NIifDR+nuNHwl5a5ghk5vdSROflLvazMwZVOSg5/qipNnbC/
	WX4zRdJm+xNuWy7PP3gwyyNJ3Plg1abw1m0gAmRfLwMkAKS3ULbhIq4ZMJyME05l
	ccUHaAcwYIpzmBI4PXxn8i41JOWAMTGcuLD0rV6HyFDjxiyLjWoIsuBHaixJm2M1
	bzN8OckhJ0hhgrxNV2jknrvsIGXDEv5uSilL2SEhDO29GrzfvwGPlBu/ojtCZJ5R
	Je9muV9XqZJoULoht74LQw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879v-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:04 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B2620822562;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 07/15] ASoC: ops: Add control to register value helper
Date: Tue, 18 Mar 2025 17:14:51 +0000
Message-ID: <20250318171459.3203730-8-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa18 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=vHv68sP4-F5Tmd_KzTcA:9
X-Proofpoint-GUID: vrN2M8VdUXWhfftLzaRBNSX3NDUB4SaX
X-Proofpoint-ORIG-GUID: vrN2M8VdUXWhfftLzaRBNSX3NDUB4SaX
X-Proofpoint-Spam-Reason: safe

Add a helper function to convert from control values to register values
that can replace a lot of the duplicated code in the various put
handlers.

This also fixes a small issue in snd_soc_put_volsw where the value is
converted to a control value before doing the invert, but the invert
is done against the register max which will result in incorrect values
for inverted controls with a non-zero minimum.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-ops.c | 97 ++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 54 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index af4e678173172..888afdd23f84e 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -126,6 +126,20 @@ static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_v
 	return val & mask;
 }
 
+static unsigned int soc_mixer_ctl_to_reg(struct soc_mixer_control *mc, int val,
+					 unsigned int mask, unsigned int shift,
+					 int max)
+{
+	unsigned int reg_val;
+
+	if (mc->invert)
+		val = max - val;
+
+	reg_val = val + mc->min;
+
+	return (reg_val & mask) << shift;
+}
+
 static int soc_mixer_valid_ctl(struct soc_mixer_control *mc, long val, int max)
 {
 	if (val < 0)
@@ -292,43 +306,35 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
-	unsigned int shift = mc->shift;
-	unsigned int rshift = mc->rshift;
-	int max = mc->max;
-	int min = mc->min;
+	int max = mc->max - mc->min;
 	unsigned int mask = soc_mixer_mask(mc);
-	unsigned int invert = mc->invert;
 	int err, ret;
 	bool type_2r = false;
 	unsigned int val2 = 0;
 	unsigned int val, val_mask;
 
-	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0],
-				  mc->max - mc->min);
+	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0], max);
 	if (ret)
 		return ret;
 
-	val = ucontrol->value.integer.value[0];
-	val = (val + min) & mask;
-	if (invert)
-		val = max - val;
-	val_mask = mask << shift;
-	val = val << shift;
+	val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[0],
+				   mask, mc->shift, max);
+	val_mask = mask << mc->shift;
+
 	if (snd_soc_volsw_is_stereo(mc)) {
-		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1],
-					  mc->max - mc->min);
+		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1], max);
 		if (ret)
 			return ret;
 
-		val2 = ucontrol->value.integer.value[1];
-		val2 = (val2 + min) & mask;
-		if (invert)
-			val2 = max - val2;
 		if (reg == reg2) {
-			val_mask |= mask << rshift;
-			val |= val2 << rshift;
+			val |= soc_mixer_ctl_to_reg(mc,
+						    ucontrol->value.integer.value[1],
+						    mask, mc->rshift, max);
+			val_mask |= mask << mc->rshift;
 		} else {
-			val2 = val2 << shift;
+			val2 = soc_mixer_ctl_to_reg(mc,
+						    ucontrol->value.integer.value[1],
+						    mask, mc->shift, max);
 			type_2r = true;
 		}
 	}
@@ -404,10 +410,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
-	unsigned int shift = mc->shift;
-	unsigned int rshift = mc->rshift;
 	unsigned int val, val_mask;
-	int min = mc->min;
 	unsigned int mask = soc_mixer_sx_mask(mc);
 	int err = 0;
 	int ret;
@@ -416,10 +419,9 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	if (ret)
 		return ret;
 
-	val = ucontrol->value.integer.value[0];
-	val_mask = mask << shift;
-	val = (val + min) & mask;
-	val = val << shift;
+	val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[0],
+				   mask, mc->shift, mc->max);
+	val_mask = mask << mc->shift;
 
 	err = snd_soc_component_update_bits(component, reg, val_mask, val);
 	if (err < 0)
@@ -427,20 +429,17 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	ret = err;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
-		unsigned int val2;
-
 		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1],
 					  mc->max);
 		if (ret)
 			return ret;
 
-		val2 = ucontrol->value.integer.value[1];
-		val_mask = mask << rshift;
-		val2 = (val2 + min) & mask;
-		val2 = val2 << rshift;
+		val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[1],
+					   mask, mc->rshift, mc->max);
+		val_mask = mask << mc->rshift;
 
 		err = snd_soc_component_update_bits(component, reg2, val_mask,
-						    val2);
+						    val);
 
 		/* Don't discard any error code or drop change flag */
 		if (ret == 0 || err < 0)
@@ -498,12 +497,10 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int rreg = mc->rreg;
-	unsigned int shift = mc->shift;
-	int min = mc->min;
-	int max = mc->max;
+	int max = mc->max - mc->min;
 	unsigned int mask = soc_mixer_mask(mc);
-	unsigned int invert = mc->invert;
-	unsigned int val, val_mask;
+	unsigned int val_mask = mask << mc->shift;
+	unsigned int val;
 	int err, ret;
 
 	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0],
@@ -511,12 +508,8 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	if (ret)
 		return ret;
 
-	if (invert)
-		val = (max - ucontrol->value.integer.value[0]) & mask;
-	else
-		val = ((ucontrol->value.integer.value[0] + min) & mask);
-	val_mask = mask << shift;
-	val = val << shift;
+	val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[0],
+				   mask, mc->shift, max);
 
 	err = snd_soc_component_update_bits(component, reg, val_mask, val);
 	if (err < 0)
@@ -525,16 +518,12 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 
 	if (snd_soc_volsw_is_stereo(mc)) {
 		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1],
-					  mc->max - mc->min);
+					  max);
 		if (ret)
 			return ret;
 
-		if (invert)
-			val = (max - ucontrol->value.integer.value[1]) & mask;
-		else
-			val = ((ucontrol->value.integer.value[1] + min) & mask);
-		val_mask = mask << shift;
-		val = val << shift;
+		val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[1],
+					   mask, mc->shift, max);
 
 		err = snd_soc_component_update_bits(component, rreg, val_mask,
 						    val);
-- 
2.39.5


