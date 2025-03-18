Return-Path: <linux-kernel+bounces-566621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78847A67A91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3547AB6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25629213245;
	Tue, 18 Mar 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="f50zdKIF"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34E211A10;
	Tue, 18 Mar 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318114; cv=none; b=M6z0m/oIYqOMJJVQ4RQTXhjBJuihYe8J6HzB/aKXxrIwc3SEabhIhzZkY6RgroCJ7h/yBpVH89TKUPUo+af7GdC3ZxbLEpjLVDARbqWy8Fe3SgGZ3bbTEphYD9xR6bB2VKjeNzuBRsPXJvTdIghKps13flkO1tWUMPN+5kRIUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318114; c=relaxed/simple;
	bh=Pmkhjj2Xicnh4i5NnO0iqLI7LoSiEQkFrOYg2DFe42o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZ8xzulnbDn1wZgDHmaHGQM2ZM9djmZSq2eP7V9fSERiaOQ9JRiskdB54olyfyH0lB4l6NgHgFfVuJI55O6Mknhxhf3sGHrI1413Rg9UI7zv0+Bh9BFN7149MukKtwVD8fyyR3wW3pxEoyhlCmhM/itRSLVC6VRju6GWp11OTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=f50zdKIF; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I1uEKJ028771;
	Tue, 18 Mar 2025 12:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=AetN0+S+6cO9O1t8RISK+RD9z7owu3JlBBvzrw0F5fk=; b=
	f50zdKIFMd9jvpq6yUy6zYlbPRK030SIzuUW8cc40y3sks0DqUyYNil5Xoy/DT6e
	y4tB+G2pNAkvKhlqQm6sWr+XTicjkENdqEPHlmvtMkHarMdnQcJJ0H+H3vSbqJuk
	O5zSZWzc1Nhty3yHqFl7Wz6cV7Fn+V9jvbp+kTjotW0NP0D5ZimOnDFnBYk0C1do
	Es9ImHs9/mgSOQX4bAhcfuX0xwtSwovOx8DUNEOWQD6rLV8p/paeXuX8c0khXwxK
	U2Q6CvTt4FcEqgPoxGACMhT+gWRjMaF1zFWp2Qz/AEQVcxNU6fDT6a8GdX9Xo0yt
	Z1v/xe+vEz5zmMZ6FuH6UA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879w-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:04 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:15:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:15:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E971E82255D;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 12/15] ASoC: ops: Factor out common code from put callbacks
Date: Tue, 18 Mar 2025 17:14:56 +0000
Message-ID: <20250318171459.3203730-13-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa18 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=z1mHqx2g-KtElHCOn84A:9
X-Proofpoint-GUID: DHCWYW9t8Lbn5_65S8etAbiIzcbhsDcu
X-Proofpoint-ORIG-GUID: DHCWYW9t8Lbn5_65S8etAbiIzcbhsDcu
X-Proofpoint-Spam-Reason: safe

There are only two differences between snd_soc_put_volsw() and
snd_soc_put_volsw_sx(). The maximum field is handled differently, and
snd_soc_put_volsw() supports double controls with both values in the
same register.

Factor out the common code into a new helper and pass in the
appropriate max value such that it is handled correctly for each
control.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-ops.c | 138 +++++++++++++++++---------------------------
 1 file changed, 53 insertions(+), 85 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 29537dd3a0633..0b62ffb2e222f 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -192,6 +192,57 @@ static int soc_info_volsw(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int soc_put_volsw(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol,
+			 struct soc_mixer_control *mc, int mask, int max)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	unsigned int val1, val_mask;
+	unsigned int val2 = 0;
+	bool double_r = false;
+	int ret;
+
+	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0], max);
+	if (ret)
+		return ret;
+
+	val1 = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[0],
+				    mask, mc->shift, max);
+	val_mask = mask << mc->shift;
+
+	if (snd_soc_volsw_is_stereo(mc)) {
+		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1], max);
+		if (ret)
+			return ret;
+
+		if (mc->reg == mc->rreg) {
+			val1 |= soc_mixer_ctl_to_reg(mc,
+						     ucontrol->value.integer.value[1],
+						     mask, mc->rshift, max);
+			val_mask |= mask << mc->rshift;
+		} else {
+			val2 = soc_mixer_ctl_to_reg(mc,
+						    ucontrol->value.integer.value[1],
+						    mask, mc->shift, max);
+			double_r = true;
+		}
+	}
+
+	ret = snd_soc_component_update_bits(component, mc->reg, val_mask, val1);
+	if (ret < 0)
+		return ret;
+
+	if (double_r) {
+		int err = snd_soc_component_update_bits(component, mc->rreg,
+							val_mask, val2);
+		/* Don't drop change flag */
+		if (err)
+			return err;
+	}
+
+	return ret;
+}
+
 /**
  * snd_soc_info_volsw - single mixer info callback with range.
  * @kcontrol: mixer control
@@ -289,57 +340,11 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw);
 int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int reg2 = mc->rreg;
-	int max = mc->max - mc->min;
 	unsigned int mask = soc_mixer_mask(mc);
-	int err, ret;
-	bool type_2r = false;
-	unsigned int val2 = 0;
-	unsigned int val, val_mask;
 
-	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0], max);
-	if (ret)
-		return ret;
-
-	val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[0],
-				   mask, mc->shift, max);
-	val_mask = mask << mc->shift;
-
-	if (snd_soc_volsw_is_stereo(mc)) {
-		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1], max);
-		if (ret)
-			return ret;
-
-		if (reg == reg2) {
-			val |= soc_mixer_ctl_to_reg(mc,
-						    ucontrol->value.integer.value[1],
-						    mask, mc->rshift, max);
-			val_mask |= mask << mc->rshift;
-		} else {
-			val2 = soc_mixer_ctl_to_reg(mc,
-						    ucontrol->value.integer.value[1],
-						    mask, mc->shift, max);
-			type_2r = true;
-		}
-	}
-	err = snd_soc_component_update_bits(component, reg, val_mask, val);
-	if (err < 0)
-		return err;
-	ret = err;
-
-	if (type_2r) {
-		err = snd_soc_component_update_bits(component, reg2, val_mask,
-						    val2);
-		/* Don't discard any error code or drop change flag */
-		if (ret == 0 || err < 0)
-			ret = err;
-	}
-
-	return ret;
+	return soc_put_volsw(kcontrol, ucontrol, mc, mask, mc->max - mc->min);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 
@@ -393,48 +398,11 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
 int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-	unsigned int reg2 = mc->rreg;
-	unsigned int val, val_mask;
 	unsigned int mask = soc_mixer_sx_mask(mc);
-	int err = 0;
-	int ret;
-
-	ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[0], mc->max);
-	if (ret)
-		return ret;
-
-	val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[0],
-				   mask, mc->shift, mc->max);
-	val_mask = mask << mc->shift;
-
-	err = snd_soc_component_update_bits(component, reg, val_mask, val);
-	if (err < 0)
-		return err;
-	ret = err;
 
-	if (snd_soc_volsw_is_stereo(mc)) {
-		ret = soc_mixer_valid_ctl(mc, ucontrol->value.integer.value[1],
-					  mc->max);
-		if (ret)
-			return ret;
-
-		val = soc_mixer_ctl_to_reg(mc, ucontrol->value.integer.value[1],
-					   mask, mc->rshift, mc->max);
-		val_mask = mask << mc->rshift;
-
-		err = snd_soc_component_update_bits(component, reg2, val_mask,
-						    val);
-
-		/* Don't discard any error code or drop change flag */
-		if (ret == 0 || err < 0)
-			ret = err;
-	}
-
-	return ret;
+	return soc_put_volsw(kcontrol, ucontrol, mc, mask, mc->max);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_sx);
 
-- 
2.39.5


