Return-Path: <linux-kernel+bounces-568526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F7A696DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148CE7ACBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6183209F4B;
	Wed, 19 Mar 2025 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PethQzR1"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902A1E231F;
	Wed, 19 Mar 2025 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406693; cv=none; b=hTUeENXGgw6rQKIsDJiBvjGa6B7oTiqMLeWSOW+X9DTqeSK4hJOA7oyAvlfUCDdMTQZECVMqy0FJziJpDAyd1nqDE7k1+hNi4Zl1L/vNhvHP4dK7b7IRpxK279wmBtF6ZYUQV99ojEKWWLSKNpLdJ/XaLcGvpEtZ5eOlVgtxrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406693; c=relaxed/simple;
	bh=ARqqEUs3JR21voG0XkmqutV4r2tcM9VDqiEeOLf1vec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MA+vauRLO+lX3Ch5eiumYGvNCL0MwuGMGmkdPMindqeWFxdims2uQv/JOd7FerMNRHj23bmU4z1n468LLlsNU1FGuyCYLxkriYUN2+Ptn3YYDxoqm0HcNDF+PninFSiIPMbMFXxuyihw2sl9vsJp1ASEx1uXTpVIFwbbIlcvfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PethQzR1; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J5OEjS031622;
	Wed, 19 Mar 2025 12:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=9VaNBMYlKdQRrnH19hnp/K2dAr5sWjgduN5goWa97WI=; b=
	PethQzR1dtFqjeysyg27ZEya1M9OtwMkG3Q2Q8BgbkqpwYQy4qBh66vrGI5XAq1m
	6g1MjN1GLHCFyu4sCE9DIqXw6eAGJsmjSC1PSNDXa7v/l/TGZSddN79kI5IOweBS
	03sSYHoxQPUfYuKkSUB/IDkSXOxQ4f7GeFDZFZ7ka7M5RqNtKyW0Sl6/TvrSTXh4
	j933JuxLUj9s9uho7ozZ53MnHdCny0hZPeL8eVRyJsGnWZzzZXAwwdlns+yjQB0u
	XGVyww5i4q1OaazzmFFBQMtlN8Mt02IWPz81S1hgDNQhnyZYGkMjqtNx/tLDc2uK
	KGUbqTEUzh/VvHF7S/xsRQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45dc0mtgjx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:51:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 17:51:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 17:51:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0608D82255C;
	Wed, 19 Mar 2025 17:51:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/3] ASoC: ops: Factor out common code from get callbacks
Date: Wed, 19 Mar 2025 17:51:21 +0000
Message-ID: <20250319175123.3835849-2-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: Y4F-D2kzalOnE23wUNcC-a-cNlXhvg8q
X-Proofpoint-ORIG-GUID: Y4F-D2kzalOnE23wUNcC-a-cNlXhvg8q
X-Authority-Analysis: v=2.4 cv=XY+JzJ55 c=1 sm=1 tr=0 ts=67db041e cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=flwN6VLGnKKmA9wKfI0A:9
X-Proofpoint-Spam-Reason: safe

There are only two differences between snd_soc_get_volsw() and
snd_soc_get_volsw_sx(). The maximum field is handled differently, and
snd_soc_get_volsw() supports double controls with both values in the
same register.

Factor out the common code into a new helper and pass in the
appropriate max value such that it is handled correctly for each
control.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Drop reg and reg2 local variables that were unused

 sound/soc/soc-ops.c | 68 +++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 0b62ffb2e222f..1d7c28993a631 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -243,6 +243,33 @@ static int soc_put_volsw(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
+static int soc_get_volsw(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol,
+			 struct soc_mixer_control *mc, int mask, int max)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	unsigned int reg_val;
+	int val;
+
+	reg_val = snd_soc_component_read(component, mc->reg);
+	val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
+
+	ucontrol->value.integer.value[0] = val;
+
+	if (snd_soc_volsw_is_stereo(mc)) {
+		if (mc->reg == mc->rreg) {
+			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->rshift, max);
+		} else {
+			reg_val = snd_soc_component_read(component, mc->rreg);
+			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
+		}
+
+		ucontrol->value.integer.value[1] = val;
+	}
+
+	return 0;
+}
+
 /**
  * snd_soc_info_volsw - single mixer info callback with range.
  * @kcontrol: mixer control
@@ -299,31 +326,11 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_sx);
 int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int max = mc->max - mc->min;
 	unsigned int mask = soc_mixer_mask(mc);
-	unsigned int reg_val;
-	int val;
 
-	reg_val = snd_soc_component_read(component, mc->reg);
-	val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
-
-	ucontrol->value.integer.value[0] = val;
-
-	if (snd_soc_volsw_is_stereo(mc)) {
-		if (mc->reg == mc->rreg) {
-			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->rshift, max);
-		} else {
-			reg_val = snd_soc_component_read(component, mc->rreg);
-			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
-		}
-
-		ucontrol->value.integer.value[1] = val;
-	}
-
-	return 0;
+	return soc_get_volsw(kcontrol, ucontrol, mc, mask, mc->max - mc->min);
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw);
 
@@ -361,28 +368,11 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int reg2 = mc->rreg;
 	unsigned int mask = soc_mixer_sx_mask(mc);
-	unsigned int reg_val;
-	int val;
-
-	reg_val = snd_soc_component_read(component, reg);
-	val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, mc->max);
-
-	ucontrol->value.integer.value[0] = val;
-
-	if (snd_soc_volsw_is_stereo(mc)) {
-		reg_val = snd_soc_component_read(component, reg2);
-		val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->rshift, mc->max);
 
-		ucontrol->value.integer.value[1] = val;
-	}
-
-	return 0;
+	return soc_get_volsw(kcontrol, ucontrol, mc, mask, mc->max);
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
 
-- 
2.39.5


