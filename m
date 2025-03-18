Return-Path: <linux-kernel+bounces-566614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FFBA67A87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1268216CE15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288B3211A11;
	Tue, 18 Mar 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YQwhXjo0"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814D20F091;
	Tue, 18 Mar 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318108; cv=none; b=DMu815pGnshbiNNuRGvhykV8bWEGJCwjLx75L00YW+eTPK5tFU1uweAf2POIA8vhMZ6e5/06/QOzx2IwbgoIgQCD73NtNEWJNkzO+sdB8bDXZMU4JQnyBoqsv+NYTp4vCvhBfIwrjmu6Bcw+DHVCwgTsbpIt46GJtwwk5VvdGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318108; c=relaxed/simple;
	bh=oPe4Kq1bj9UBrWcKG8s2HHDATru23tP2EvUetFiYkYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QW2gwHDPHg5nALFTciq7/j6A2ojyJ7YkbYEJx0uArWoyXDccJZ/aHtt1+WaZlUbnAUu6kg52qdSmO8ojU2AW8C1AoqLglm4Et1nazAxwzgxUJ/uVLBsPGf+aVuIIU3dt4j71xMrLnyqQIZ/PKqRgZJNTDZhy7LD0mXiUE9vIhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YQwhXjo0; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I5qiuC018522;
	Tue, 18 Mar 2025 12:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ptvfhQxzX1FHtfnjtqDwf2qwBEyJBpTeqaAAHPr8Cs4=; b=
	YQwhXjo0xqvvRD2BKEhy1NlZbEy6n7Pt0oBhU+PcMMG8wCwkRycl8N3FN2NV535P
	4NujW5zkTvfiV8x3uJR12+NTSijckh1NOwZlpJv/BR5Ef8H3qgQZT5mtGZ0hA9As
	9ev4aE8Lpv9H66X8TEjYFi+TL1HGO8hh3Av5v1+A3br189FQPlNFdL3g13EBjVOE
	8a3F238Zlxer5i4aBP49RhbPVWP0ZwhHb8iDrhZjQSZuMFBdVp0y263OazlDvN9H
	t8EI3dFdQGckDVszssGagpmGBYGrHMK1RYkZy9cp+Fzxl8Jnwxtb+Fk3jICxFmoL
	Vnl6iHFAgNrMtZC1Ikpq+Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:01 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8804182255F;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 04/15] ASoC: ops: Update mask generation to use GENMASK
Date: Tue, 18 Mar 2025 17:14:48 +0000
Message-ID: <20250318171459.3203730-5-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa15 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=NjVXIjOy9wLvg5dM6DQA:9
X-Proofpoint-GUID: 0pF1iPF4tAqPD8ohdUNodFyXzJLCjOiC
X-Proofpoint-ORIG-GUID: 0pF1iPF4tAqPD8ohdUNodFyXzJLCjOiC
X-Proofpoint-Spam-Reason: safe

Use GENMASK to make the masks for the various control helper functions.
Also factor out a shared helper function for the volsw and volsw_range
controls since the same code is appropriate for each. Note this does add
support for sign_bit into the volsw_range callbacks.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-ops.c | 46 +++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index dac55138210d5..54945017e1f1e 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -158,6 +158,20 @@ static void snd_soc_read_signed(struct snd_soc_component *component,
 	*signed_val = ret;
 }
 
+static int soc_mixer_mask(struct soc_mixer_control *mc)
+{
+	if (mc->sign_bit)
+		return GENMASK(mc->sign_bit, 0);
+	else
+		return GENMASK(fls(mc->max) - 1, 0);
+}
+
+static int soc_mixer_sx_mask(struct soc_mixer_control *mc)
+{
+	// min + max will take us 1-bit over the size of the mask
+	return GENMASK(fls(mc->min + mc->max) - 2, 0);
+}
+
 /**
  * snd_soc_info_volsw - single mixer info callback
  * @kcontrol: mixer control
@@ -260,13 +274,10 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	int min = mc->min;
 	int sign_bit = mc->sign_bit;
-	unsigned int mask = (1ULL << fls(max)) - 1;
+	unsigned int mask = soc_mixer_mask(mc);
 	unsigned int invert = mc->invert;
 	int val;
 
-	if (sign_bit)
-		mask = BIT(sign_bit + 1) - 1;
-
 	snd_soc_read_signed(component, reg, mask, shift, sign_bit, &val);
 
 	ucontrol->value.integer.value[0] = val - min;
@@ -312,17 +323,13 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int sign_bit = mc->sign_bit;
-	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int mask = soc_mixer_mask(mc);
 	unsigned int invert = mc->invert;
 	int err, ret;
 	bool type_2r = false;
 	unsigned int val2 = 0;
 	unsigned int val, val_mask;
 
-	if (sign_bit)
-		mask = BIT(sign_bit + 1) - 1;
-
 	if (ucontrol->value.integer.value[0] < 0)
 		return -EINVAL;
 	val = ucontrol->value.integer.value[0];
@@ -391,9 +398,8 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
-	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
+	unsigned int mask = soc_mixer_sx_mask(mc);
 	unsigned int val;
 
 	val = snd_soc_component_read(component, reg);
@@ -431,7 +437,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int val, val_mask;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
+	unsigned int mask = soc_mixer_sx_mask(mc);
 	int err = 0;
 	int ret;
 
@@ -525,7 +531,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	unsigned int shift = mc->shift;
 	int min = mc->min;
 	int max = mc->max;
-	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int mask = soc_mixer_mask(mc);
 	unsigned int invert = mc->invert;
 	unsigned int val, val_mask;
 	int err, ret, tmp;
@@ -597,7 +603,7 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 	unsigned int shift = mc->shift;
 	int min = mc->min;
 	int max = mc->max;
-	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int mask = soc_mixer_mask(mc);
 	unsigned int invert = mc->invert;
 	unsigned int val;
 
@@ -891,9 +897,9 @@ int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
 	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
-	unsigned int regwmask = (1UL << regwshift) - 1;
+	unsigned int regwmask = GENMASK(regwshift - 1, 0);
+	unsigned long mask = GENMASK(mc->nbits - 1, 0);
 	unsigned int invert = mc->invert;
-	unsigned long mask = (1UL << mc->nbits) - 1;
 	long min = mc->min;
 	long max = mc->max;
 	long val = 0;
@@ -938,9 +944,9 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
 	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
-	unsigned int regwmask = (1UL << regwshift) - 1;
+	unsigned int regwmask = GENMASK(regwshift - 1, 0);
+	unsigned long mask = GENMASK(mc->nbits - 1, 0);
 	unsigned int invert = mc->invert;
-	unsigned long mask = (1UL << mc->nbits) - 1;
 	long max = mc->max;
 	long val = ucontrol->value.integer.value[0];
 	int ret = 0;
@@ -986,7 +992,7 @@ int snd_soc_get_strobe(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
-	unsigned int mask = 1 << shift;
+	unsigned int mask = BIT(shift);
 	unsigned int invert = mc->invert != 0;
 	unsigned int val;
 
@@ -1019,7 +1025,7 @@ int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
-	unsigned int mask = 1 << shift;
+	unsigned int mask = BIT(shift);
 	unsigned int invert = mc->invert != 0;
 	unsigned int strobe = ucontrol->value.enumerated.item[0] != 0;
 	unsigned int val1 = (strobe ^ invert) ? mask : 0;
-- 
2.39.5


