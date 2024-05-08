Return-Path: <linux-kernel+bounces-173003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35B8BF9E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4023028808B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1AA7F466;
	Wed,  8 May 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Fg7jsYSw"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFCC7EF12;
	Wed,  8 May 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162201; cv=none; b=V4LPeyFTl2GfPqG0t9b/x4aLpNzX2G5ka80cl7Bwrlq99X3yRg1MqRhuAqmEPFNjAtW+qhBJ0n+F0CTpuEapcp2vun5+Nm7ABIkDtd3jsA/YsBlHi8sRGI9GsrdXePJlpoZvaWZcZRZmQSkR46/aJNnu9bS38bU7g//Svndwm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162201; c=relaxed/simple;
	bh=Mzl7cdo6GRa6aNpW/krWz0eupxXUOn59BXxd1oj37jU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dnkf6P6rVOANdnK71ndW3BGm93BhzT93BuuHVql/pQTLOJtXavy9Cb1GdEZN2VWM3Z7wF48DbqM/Dp+9SDGSFm2eNG6n/EZxlCc+JeEJosAhvyrC9sb11ftottFV8Vdr8lFbGH4PLlFOy0U2q7cx5ngHiheY4UadBvaIkQNNNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Fg7jsYSw; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4486vtiF026053;
	Wed, 8 May 2024 04:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=R
	vqf78UChrZfvXZe6KiazLJ3FLV6tQAjUMLVg1LWMFg=; b=Fg7jsYSw4SHm94xl0
	Zp8ABoUQ5zaQmHAX8qlORJ8UKfWNSLqBE1Ylc1L3yva8nvIU9xSIMrWFVlA1dMkD
	8fHukjg4ur5Isl6JTTerGZRAdZqbE6K4dU4gDsxOMlS+Y4RXpJ+GnfEn4lnHX5uB
	BF/m2xBTnZdsKdn6BodiNTV3UBkyJ4VQKxC5RYw0NLr83EaNNqOlRGTw8mLg640S
	My4J6fp+qK/7maYjcr4WysCkC6aA+aMUZso4nN9TlxNfov0Z9+xdNrfNhHRIjh0e
	lK1E9mUYW/hH3cZkiBx2O8hNr2CdeQKRttq+zZvCylOsdmm8hrkMc0Y7/+Uf1201
	iSGFA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xyshernev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 04:56:31 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 May 2024
 10:56:27 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Wed, 8 May 2024 10:56:27 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0D943820244;
	Wed,  8 May 2024 09:56:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH] ALSA: hda/cs_dsp_ctl: Use private_free for control cleanup
Date: Wed, 8 May 2024 10:56:27 +0100
Message-ID: <20240508095627.44476-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HpwR96T6fm9AdjatzGpyAfUF0IKJAH6v
X-Proofpoint-ORIG-GUID: HpwR96T6fm9AdjatzGpyAfUF0IKJAH6v
X-Proofpoint-Spam-Reason: safe

Use the control private_free callback to free the associated data
block. This ensures that the memory won't leak, whatever way the
control gets destroyed.

The original implementation didn't actually remove the ALSA
controls in hda_cs_dsp_control_remove(). It only freed the internal
tracking structure. This meant it was possible to remove/unload the
amp driver while leaving its ALSA controls still present in the
soundcard. Obviously attempting to access them could cause segfaults
or at least dereferencing stale pointers.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 3233b978af23 ("ALSA: hda: hda_cs_dsp_ctl: Add Library to support CS_DSP ALSA controls")
---
This replaces my earlier "keep it simple" attempt at cleanup.
I decided that implementing private_free is the only sensible
way to fix the cleanup.
---
 sound/pci/hda/hda_cs_dsp_ctl.c | 47 ++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 463ca06036bf..9db45d7c17e5 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <sound/soc.h>
+#include <linux/cleanup.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
 #include "hda_cs_dsp_ctl.h"
@@ -97,11 +98,23 @@ static unsigned int wmfw_convert_flags(unsigned int in)
 	return out;
 }
 
-static void hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char *name)
+static void hda_cs_dsp_free_kcontrol(struct snd_kcontrol *kctl)
 {
+	struct hda_cs_dsp_coeff_ctl *ctl = (struct hda_cs_dsp_coeff_ctl *)snd_kcontrol_chip(kctl);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+
+	/* NULL priv to prevent a double-free in hda_cs_dsp_control_remove() */
+	cs_ctl->priv = NULL;
+	kfree(ctl);
+}
+
+static void hda_cs_dsp_add_kcontrol(struct cs_dsp_coeff_ctl *cs_ctl,
+				    const struct hda_cs_dsp_ctl_info *info,
+				    const char *name)
+{
 	struct snd_kcontrol_new kcontrol = {0};
 	struct snd_kcontrol *kctl;
+	struct hda_cs_dsp_coeff_ctl *ctl __free(kfree) = NULL;
 	int ret = 0;
 
 	if (cs_ctl->len > ADSP_MAX_STD_CTRL_SIZE) {
@@ -110,6 +123,13 @@ static void hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char
 		return;
 	}
 
+	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return;
+
+	ctl->cs_ctl = cs_ctl;
+	ctl->card = info->card;
+
 	kcontrol.name = name;
 	kcontrol.info = hda_cs_dsp_coeff_info;
 	kcontrol.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
@@ -117,20 +137,22 @@ static void hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char
 	kcontrol.get = hda_cs_dsp_coeff_get;
 	kcontrol.put = hda_cs_dsp_coeff_put;
 
-	/* Save ctl inside private_data, ctl is owned by cs_dsp,
-	 * and will be freed when cs_dsp removes the control */
 	kctl = snd_ctl_new1(&kcontrol, (void *)ctl);
 	if (!kctl)
 		return;
 
-	ret = snd_ctl_add(ctl->card, kctl);
+	kctl->private_free = hda_cs_dsp_free_kcontrol;
+	ctl->kctl = kctl;
+
+	/* snd_ctl_add() calls our private_free on error, which will kfree(ctl) */
+	cs_ctl->priv = no_free_ptr(ctl);
+	ret = snd_ctl_add(info->card, kctl);
 	if (ret) {
 		dev_err(cs_ctl->dsp->dev, "Failed to add KControl %s = %d\n", kcontrol.name, ret);
 		return;
 	}
 
 	dev_dbg(cs_ctl->dsp->dev, "Added KControl: %s\n", kcontrol.name);
-	ctl->kctl = kctl;
 }
 
 static void hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl,
@@ -138,7 +160,6 @@ static void hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl,
 {
 	struct cs_dsp *cs_dsp = cs_ctl->dsp;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	struct hda_cs_dsp_coeff_ctl *ctl;
 	const char *region_name;
 	int ret;
 
@@ -163,15 +184,7 @@ static void hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl,
 			 " %.*s", cs_ctl->subname_len - skip, cs_ctl->subname + skip);
 	}
 
-	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
-	if (!ctl)
-		return;
-
-	ctl->cs_ctl = cs_ctl;
-	ctl->card = info->card;
-	cs_ctl->priv = ctl;
-
-	hda_cs_dsp_add_kcontrol(ctl, name);
+	hda_cs_dsp_add_kcontrol(cs_ctl, info, name);
 }
 
 void hda_cs_dsp_add_controls(struct cs_dsp *dsp, const struct hda_cs_dsp_ctl_info *info)
@@ -203,7 +216,9 @@ void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 {
 	struct hda_cs_dsp_coeff_ctl *ctl = cs_ctl->priv;
 
-	kfree(ctl);
+	/* ctl and kctl may already have been removed by ALSA private_free */
+	if (ctl && ctl->kctl)
+		snd_ctl_remove(ctl->card, ctl->kctl);
 }
 EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
 
-- 
2.39.2


