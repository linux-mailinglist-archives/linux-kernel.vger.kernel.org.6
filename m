Return-Path: <linux-kernel+bounces-566627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A7A67A98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A391895BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04AB2135BC;
	Tue, 18 Mar 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WtM6Y8M2"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D021322F;
	Tue, 18 Mar 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318117; cv=none; b=VdBaDz+PLsUEflJYP/PmhQE4VWvTn9ao+SvuC3yJj4tG0HRJZ2al3NufdZa4joM47u6uYZlzN6WWoQXHAfhAfez6c53HcwEgfGcPvlRNq7NP258Lg8J8nzusQKoE0fcyWmt2FvsKMf2rrgHQMMVLg0M6GxhAMqbFqhYPWRMQdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318117; c=relaxed/simple;
	bh=+udgpefTAy9yT5zN1PCHqOG2z6iuVyR1x244DE/iMH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2F7quPaZ/Il0ZpUX6CPmNAb5rPqWBaKa4l6m1q+lDXEj79TT9UbYDBpEKV3CHOl1F9VxTR4z7nnB/uS9MNyfU2CiYIHSdtx+5tg0/ihhbGJuPd7L+eqmgadiC9e5NMXyIzF7HPQxpe1hXR39io/lUR4W90f4Uu3x5/ucClKvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WtM6Y8M2; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I5qiuF018522;
	Tue, 18 Mar 2025 12:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=y9kQbGHzqnOYccxyxIhjlcvoEDanPvD4s8hazf7BM5o=; b=
	WtM6Y8M2lhIXKghHlvFRJC3Z22UXFv1eQrsWD3YtKkW45ckdI22yWqVoBSfDzgsQ
	19WY0HjP44TkXfY2dDxYZzJ3hnJoliX9TxVEQTTndFQSX0ka9HtIcgMgDFuhGPil
	w+qFP0+I4YofgOALf0y//leS8snhM3VH1oP+u53ikPBYEj/wBA9WLvII/hNVVun3
	gNTSRm8FTrLEkPFqd+4/bTooQ+8Z5U9gf1gc1W6DD0lupenHIivqwGX9naldnwQB
	RewLGIQC2MddPJp3sB+2pIFqXI4gLi673PJCzg5SwLAR+iri4TgwwnqGnFgMeAPm
	4/W69DrCuq/E/+BX343zRQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879v-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A4091822561;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 06/15] ASoC: ops: Replace snd_soc_read_signed() with new helper
Date: Tue, 18 Mar 2025 17:14:50 +0000
Message-ID: <20250318171459.3203730-7-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa17 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=QXL5r4s4IFEui-4iHJ8A:9
X-Proofpoint-GUID: mkDYJI0MYTuhKuuFU4HnhgGxgHd7ikf1
X-Proofpoint-ORIG-GUID: mkDYJI0MYTuhKuuFU4HnhgGxgHd7ikf1
X-Proofpoint-Spam-Reason: safe

The current snd_soc_read_signed() helper is only used from
snd_soc_get_volsw() and can be implemented more simply with
sign_extend. Remove snd_soc_read_signed() and add a new
soc_mixer_reg_to_ctl() helper. This new helper does not
include the reading of the register, but does include min and
max handling. This allows the helper to replace more of the
duplicated code and makes it easier to process the differences
between single, double register and double shift style controls.

It is worth noting this adds support for sign_bit into the _range
and sx callbacks and the invert option to sx callbacks.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-ops.c | 134 ++++++++++++++------------------------------
 1 file changed, 41 insertions(+), 93 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 53a141426a967..af4e678173172 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -110,52 +110,20 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);
 
-/**
- * snd_soc_read_signed - Read a codec register and interpret as signed value
- * @component: component
- * @reg: Register to read
- * @mask: Mask to use after shifting the register value
- * @shift: Right shift of register value
- * @sign_bit: Bit that describes if a number is negative or not.
- * @signed_val: Pointer to where the read value should be stored
- *
- * This functions reads a codec register. The register value is shifted right
- * by 'shift' bits and masked with the given 'mask'. Afterwards it translates
- * the given registervalue into a signed integer if sign_bit is non-zero.
- */
-static void snd_soc_read_signed(struct snd_soc_component *component,
-				unsigned int reg, unsigned int mask,
-				unsigned int shift, unsigned int sign_bit,
-				int *signed_val)
+static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_val,
+				unsigned int mask, unsigned int shift, int max)
 {
-	int ret;
-	unsigned int val;
-
-	val = snd_soc_component_read(component, reg);
-	val = (val >> shift) & mask;
+	int val = (reg_val >> shift) & mask;
 
-	if (!sign_bit) {
-		*signed_val = val;
-		return;
-	}
-
-	/* non-negative number */
-	if (!(val & BIT(sign_bit))) {
-		*signed_val = val;
-		return;
-	}
+	if (mc->sign_bit)
+		val = sign_extend32(val, mc->sign_bit);
 
-	ret = val;
+	val -= mc->min;
 
-	/*
-	 * The register most probably does not contain a full-sized int.
-	 * Instead we have an arbitrary number of bits in a signed
-	 * representation which has to be translated into a full-sized int.
-	 * This is done by filling up all bits above the sign-bit.
-	 */
-	ret |= ~((int)(BIT(sign_bit) - 1));
+	if (mc->invert)
+		val = max - val;
 
-	*signed_val = ret;
+	return val & mask;
 }
 
 static int soc_mixer_valid_ctl(struct soc_mixer_control *mc, long val, int max)
@@ -281,34 +249,25 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int reg2 = mc->rreg;
-	unsigned int shift = mc->shift;
-	unsigned int rshift = mc->rshift;
-	int max = mc->max;
-	int min = mc->min;
-	int sign_bit = mc->sign_bit;
+	int max = mc->max - mc->min;
 	unsigned int mask = soc_mixer_mask(mc);
-	unsigned int invert = mc->invert;
+	unsigned int reg_val;
 	int val;
 
-	snd_soc_read_signed(component, reg, mask, shift, sign_bit, &val);
+	reg_val = snd_soc_component_read(component, mc->reg);
+	val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
 
-	ucontrol->value.integer.value[0] = val - min;
-	if (invert)
-		ucontrol->value.integer.value[0] =
-			max - ucontrol->value.integer.value[0];
+	ucontrol->value.integer.value[0] = val;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
-		if (reg == reg2)
-			snd_soc_read_signed(component, reg, mask, rshift, sign_bit, &val);
-		else
-			snd_soc_read_signed(component, reg2, mask, shift, sign_bit, &val);
+		if (mc->reg == mc->rreg) {
+			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->rshift, max);
+		} else {
+			reg_val = snd_soc_component_read(component, mc->rreg);
+			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
+		}
 
-		ucontrol->value.integer.value[1] = val - min;
-		if (invert)
-			ucontrol->value.integer.value[1] =
-				max - ucontrol->value.integer.value[1];
+		ucontrol->value.integer.value[1] = val;
 	}
 
 	return 0;
@@ -408,18 +367,19 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
-	unsigned int shift = mc->shift;
-	unsigned int rshift = mc->rshift;
-	int min = mc->min;
 	unsigned int mask = soc_mixer_sx_mask(mc);
-	unsigned int val;
+	unsigned int reg_val;
+	int val;
 
-	val = snd_soc_component_read(component, reg);
-	ucontrol->value.integer.value[0] = ((val >> shift) - min) & mask;
+	reg_val = snd_soc_component_read(component, reg);
+	val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, mc->max);
+
+	ucontrol->value.integer.value[0] = val;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
-		val = snd_soc_component_read(component, reg2);
-		val = ((val >> rshift) - min) & mask;
+		reg_val = snd_soc_component_read(component, reg2);
+		val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->rshift, mc->max);
+
 		ucontrol->value.integer.value[1] = val;
 	}
 
@@ -602,33 +562,21 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int rreg = mc->rreg;
-	unsigned int shift = mc->shift;
-	int min = mc->min;
-	int max = mc->max;
+	int max = mc->max - mc->min;
 	unsigned int mask = soc_mixer_mask(mc);
-	unsigned int invert = mc->invert;
-	unsigned int val;
+	unsigned int reg_val;
+	int val;
 
-	val = snd_soc_component_read(component, reg);
-	ucontrol->value.integer.value[0] = (val >> shift) & mask;
-	if (invert)
-		ucontrol->value.integer.value[0] =
-			max - ucontrol->value.integer.value[0];
-	else
-		ucontrol->value.integer.value[0] =
-			ucontrol->value.integer.value[0] - min;
+	reg_val = snd_soc_component_read(component, mc->reg);
+	val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
+
+	ucontrol->value.integer.value[0] = val;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
-		val = snd_soc_component_read(component, rreg);
-		ucontrol->value.integer.value[1] = (val >> shift) & mask;
-		if (invert)
-			ucontrol->value.integer.value[1] =
-				max - ucontrol->value.integer.value[1];
-		else
-			ucontrol->value.integer.value[1] =
-				ucontrol->value.integer.value[1] - min;
+		reg_val = snd_soc_component_read(component, mc->rreg);
+		val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
+
+		ucontrol->value.integer.value[1] = val;
 	}
 
 	return 0;
-- 
2.39.5


