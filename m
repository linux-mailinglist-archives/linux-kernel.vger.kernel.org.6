Return-Path: <linux-kernel+bounces-566626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD3FA67A93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1413517BE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606FB1991CB;
	Tue, 18 Mar 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qmuogI5+"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A9212B09;
	Tue, 18 Mar 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318115; cv=none; b=a50nFxhYG1fMobmoc6r1YxOt0JUSoGVNk++u/jWjodiAt6IPWYvPcnoTCUshFkSA0m5WkBxxt/DuUqFXisc6C54mXPTCFhr8mVKmNq0sUH4WlQxdaPNvuOXNe7lYf2AhG5w0bIfrE0NJZxxeMT8jx+cmyqcqsJkc18ZshgDI8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318115; c=relaxed/simple;
	bh=lhT5HZ88G4/sRt0PBVGllNagrA8yRC/VHGj1priQUCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sflLSNACiUpFwlFiqKKHjReqtTgDw2cyuqkN7M4j/qbsaIgyqLlkr8G7rE37d9l2Nfjpjk9xVUl9QZZs9kvbz2KauDEirutDxmFSQYvq+juS8wDQtvaDTx6aUfYT1elSg8TA3+uUB/wAkhGr4SNmWAT1FqPmHxl0HNHOTDpnO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qmuogI5+; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I5qiuD018522;
	Tue, 18 Mar 2025 12:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=N7BNKMAoqr52dw2Fw2AWYEwPiQRp7So4m3Cdv7YFbh0=; b=
	qmuogI5+Bo4bemApaJazNYKk1BGKelwp2a1vjcgO6dwtlY1aRU7ORviVTMvxFj3Y
	DDOtERbAM+ZgWfmjtxIBueLXCu91Wuc5WbhmQD7czPmU7iyb5+8jV9ypDbxeEEw/
	DZBGBSQkw/JfWJSv0BPBEruRcRh1pHab4JZW4aGVjm+IooY7z1B53orziA30wBdB
	KZC+vc1prPgO6ZL4/4uRxF8opLvH87qTNbo1KBKPRlqw6N/ecpilCdMcGONknU/A
	gRP2rdz7f7RLXz1nn6ymn8fyIqN+vLjf/xZmDv7LDOgVRhvNSvdpjLbv04WBpMYF
	qhZ61uY7rCGboyk0MyWTmw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879v-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:02 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 960BC822560;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 05/15] ASoC: ops: Factor out helper to check valid control values
Date: Tue, 18 Mar 2025 17:14:49 +0000
Message-ID: <20250318171459.3203730-6-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa16 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=PKG_pxTaXtLV1nRfRUwA:9
X-Proofpoint-GUID: th1SCWeC6s-2eafGsD6iHlJOgvXls26r
X-Proofpoint-ORIG-GUID: th1SCWeC6s-2eafGsD6iHlJOgvXls26r
X-Proofpoint-Spam-Reason: safe

Most of the put handlers have identical code to verify the value passed
in from user-space. Factor this out into a single helper function.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-ops.c | 82 ++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 54945017e1f1e..53a141426a967 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -158,6 +158,20 @@ static void snd_soc_read_signed(struct snd_soc_component *component,
 	*signed_val = ret;
 }
 
+static int soc_mixer_valid_ctl(struct soc_mixer_control *mc, long val, int max)
+{
+	if (val < 0)
+		return -EINVAL;
+
+	if (mc->platform_max && val > mc->platform_max)
+		return -EINVAL;
+
+	if (val > max)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int soc_mixer_mask(struct soc_mixer_control *mc)
 {
 	if (mc->sign_bit)
@@ -330,26 +344,24 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int val2 = 0;
 	unsigned int val, val_mask;
 
-	if (ucontrol->value.integer.value[0] < 0)
-		return -EINVAL;
+	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0],
+				  mc->max - mc->min);
+	if (ret)
+		return ret;
+
 	val = ucontrol->value.integer.value[0];
-	if (mc->platform_max && val > mc->platform_max)
-		return -EINVAL;
-	if (val > max - min)
-		return -EINVAL;
 	val = (val + min) & mask;
 	if (invert)
 		val = max - val;
 	val_mask = mask << shift;
 	val = val << shift;
 	if (snd_soc_volsw_is_stereo(mc)) {
-		if (ucontrol->value.integer.value[1] < 0)
-			return -EINVAL;
+		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1],
+					  mc->max - mc->min);
+		if (ret)
+			return ret;
+
 		val2 = ucontrol->value.integer.value[1];
-		if (mc->platform_max && val2 > mc->platform_max)
-			return -EINVAL;
-		if (val2 > max - min)
-			return -EINVAL;
 		val2 = (val2 + min) & mask;
 		if (invert)
 			val2 = max - val2;
@@ -435,19 +447,16 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
 	unsigned int val, val_mask;
-	int max = mc->max;
 	int min = mc->min;
 	unsigned int mask = soc_mixer_sx_mask(mc);
 	int err = 0;
 	int ret;
 
-	if (ucontrol->value.integer.value[0] < 0)
-		return -EINVAL;
+	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0], mc->max);
+	if (ret)
+		return ret;
+
 	val = ucontrol->value.integer.value[0];
-	if (mc->platform_max && val > mc->platform_max)
-		return -EINVAL;
-	if (val > max)
-		return -EINVAL;
 	val_mask = mask << shift;
 	val = (val + min) & mask;
 	val = val << shift;
@@ -458,13 +467,14 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	ret = err;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
-		unsigned int val2 = ucontrol->value.integer.value[1];
+		unsigned int val2;
 
-		if (mc->platform_max && val2 > mc->platform_max)
-			return -EINVAL;
-		if (val2 > max)
-			return -EINVAL;
+		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1],
+					  mc->max);
+		if (ret)
+			return ret;
 
+		val2 = ucontrol->value.integer.value[1];
 		val_mask = mask << rshift;
 		val2 = (val2 + min) & mask;
 		val2 = val2 << rshift;
@@ -534,15 +544,12 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	unsigned int mask = soc_mixer_mask(mc);
 	unsigned int invert = mc->invert;
 	unsigned int val, val_mask;
-	int err, ret, tmp;
+	int err, ret;
 
-	tmp = ucontrol->value.integer.value[0];
-	if (tmp < 0)
-		return -EINVAL;
-	if (mc->platform_max && tmp > mc->platform_max)
-		return -EINVAL;
-	if (tmp > mc->max - mc->min)
-		return -EINVAL;
+	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0],
+				  mc->max - mc->min);
+	if (ret)
+		return ret;
 
 	if (invert)
 		val = (max - ucontrol->value.integer.value[0]) & mask;
@@ -557,13 +564,10 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	ret = err;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
-		tmp = ucontrol->value.integer.value[1];
-		if (tmp < 0)
-			return -EINVAL;
-		if (mc->platform_max && tmp > mc->platform_max)
-			return -EINVAL;
-		if (tmp > mc->max - mc->min)
-			return -EINVAL;
+		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1],
+					  mc->max - mc->min);
+		if (ret)
+			return ret;
 
 		if (invert)
 			val = (max - ucontrol->value.integer.value[1]) & mask;
-- 
2.39.5


