Return-Path: <linux-kernel+bounces-568525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AABA696D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6779D3AF7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7148209689;
	Wed, 19 Mar 2025 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HgX17M1E"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB71E231D;
	Wed, 19 Mar 2025 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406693; cv=none; b=QtHdjaxI4S0ynrw+uwR1u0sGggFy7XjANw3ERuD1C9ikcBdSvKfi8HpNq3kVGdSTuU1BdPLvo+fMRQteovugDMlXW6iiopmbUkZ2U4mAgiYAcdt78ZrkARZxDiXWBH++4I/m2uFJuS606s6aJiXdw8xrze8U8ue+Cz9+ST4VH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406693; c=relaxed/simple;
	bh=t+lllHjlgPh+V51GpzR2aMgpUF6IJKPfmWsUAyYR3uA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOiAeXwc5NbQPD87VMmwriY6obirVMFU6fQRerFh+4RIdU9Xh8it2PZMthIC+hO9FCkNbyoXk/OHpEIgAlcYkI7H0Dv9tS3nsEkUH8cKCglaO8z7Uc14qXRQgqaa9M3U24tS7q6Y3QZmEiSrIZCFqh76Kx1lnSt7tQtwKQAdLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HgX17M1E; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J5OEjT031622;
	Wed, 19 Mar 2025 12:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Qcpylu2Otmzx+G6Y/PRVX7gNR7ltBQ+Vb7h/qBmcCI4=; b=
	HgX17M1EA4uqBoonjICn9hemfGTKyhVcdJXIwata++4EsN8MrHGcpzYdQ7vutoJd
	KNN367wdxkZI2k7TpE6HZjoOkpHnLgs25LK/vKx/54Q3/CPmrVQUa3toNttj0POa
	Hhy91HOyFGvbKiMJBqnvHf4oz2PPrrTYq9G+FZ9P2ddlALUOf3U1RjamSTbn+nyN
	gbrGAYYyP9lkuE4DUMB8d91FLVH1vygnFZHEY4qLeuI7917SYqjCGB/OdKd1UC3w
	/LrYxNcriR3PRM4+1p6BdzGc5IQCuYQ9tZxylVB6+blm9vwbkXSd2m8E5mg4JaAn
	jp667pQaIlfgYyDCtbORxQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45dc0mtgjx-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:51:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 17:51:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 17:51:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1433C82255D;
	Wed, 19 Mar 2025 17:51:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/3] ASoC: ops: Remove some unnecessary local variables
Date: Wed, 19 Mar 2025 17:51:22 +0000
Message-ID: <20250319175123.3835849-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319175123.3835849-1-ckeepax@opensource.cirrus.com>
References: <20250319175123.3835849-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KP39HPtT9BOiLNdLrE0T8eRqQD2Omy9b
X-Proofpoint-ORIG-GUID: KP39HPtT9BOiLNdLrE0T8eRqQD2Omy9b
X-Authority-Analysis: v=2.4 cv=XY+JzJ55 c=1 sm=1 tr=0 ts=67db041f cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=gitmLmh3CmUUKZz5OBoA:9
X-Proofpoint-Spam-Reason: safe

Remove some local variables that aren't adding much in terms of clarity
or space saving.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - A couple of local variables now dropped in proceeding patch rather
   than this one.

 sound/soc/soc-ops.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 1d7c28993a631..3ac5b3a62c812 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -664,9 +664,6 @@ int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
 	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = GENMASK(regwshift - 1, 0);
 	unsigned long mask = GENMASK(mc->nbits - 1, 0);
-	unsigned int invert = mc->invert;
-	long min = mc->min;
-	long max = mc->max;
 	long val = 0;
 	unsigned int i;
 
@@ -676,10 +673,10 @@ int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
 		val |= (regval & regwmask) << (regwshift * (regcount - i - 1));
 	}
 	val &= mask;
-	if (min < 0 && val > max)
+	if (mc->min < 0 && val > mc->max)
 		val |= ~mask;
-	if (invert)
-		val = max - val;
+	if (mc->invert)
+		val = mc->max - val;
 	ucontrol->value.integer.value[0] = val;
 
 	return 0;
@@ -711,16 +708,14 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = GENMASK(regwshift - 1, 0);
 	unsigned long mask = GENMASK(mc->nbits - 1, 0);
-	unsigned int invert = mc->invert;
-	long max = mc->max;
 	long val = ucontrol->value.integer.value[0];
 	int ret = 0;
 	unsigned int i;
 
 	if (val < mc->min || val > mc->max)
 		return -EINVAL;
-	if (invert)
-		val = max - val;
+	if (mc->invert)
+		val = mc->max - val;
 	val &= mask;
 	for (i = 0; i < regcount; i++) {
 		unsigned int regval = (val >> (regwshift * (regcount - i - 1))) &
@@ -755,17 +750,16 @@ int snd_soc_get_strobe(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int shift = mc->shift;
-	unsigned int mask = BIT(shift);
 	unsigned int invert = mc->invert != 0;
+	unsigned int mask = BIT(mc->shift);
 	unsigned int val;
 
-	val = snd_soc_component_read(component, reg);
+	val = snd_soc_component_read(component, mc->reg);
 	val &= mask;
 
-	if (shift != 0 && val != 0)
-		val = val >> shift;
+	if (mc->shift != 0 && val != 0)
+		val = val >> mc->shift;
+
 	ucontrol->value.enumerated.item[0] = val ^ invert;
 
 	return 0;
@@ -788,19 +782,17 @@ int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int shift = mc->shift;
-	unsigned int mask = BIT(shift);
-	unsigned int invert = mc->invert != 0;
 	unsigned int strobe = ucontrol->value.enumerated.item[0] != 0;
+	unsigned int invert = mc->invert != 0;
+	unsigned int mask = BIT(mc->shift);
 	unsigned int val1 = (strobe ^ invert) ? mask : 0;
 	unsigned int val2 = (strobe ^ invert) ? 0 : mask;
-	int err;
+	int ret;
 
-	err = snd_soc_component_update_bits(component, reg, mask, val1);
-	if (err < 0)
-		return err;
+	ret = snd_soc_component_update_bits(component, mc->reg, mask, val1);
+	if (ret < 0)
+		return ret;
 
-	return snd_soc_component_update_bits(component, reg, mask, val2);
+	return snd_soc_component_update_bits(component, mc->reg, mask, val2);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_strobe);
-- 
2.39.5


