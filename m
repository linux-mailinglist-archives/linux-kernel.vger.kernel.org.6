Return-Path: <linux-kernel+bounces-566619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25BEA67A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF3188EB52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2853213241;
	Tue, 18 Mar 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="e8vZd9yT"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C6212B39;
	Tue, 18 Mar 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318113; cv=none; b=oQUSmltCzkazhzJqWHZnxnADdueuvlNajXJBhYF/BJoI6TRS1zcKCIa0zQ0f/1JXehPHGeBTrruQHWe0GjKPJIOX1QTe2/WT4VS2koI9ap0qlYnD87ResKtJrdWaIfk4uPKWt3SwJ+vNVip20+fCYFTV6YXPuqqkTrxl72sKE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318113; c=relaxed/simple;
	bh=rW/pGZaK/7wUDBiYCVQC2w+K1d4bVqDqrMOHLbaztxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUtNobeRPSL8x96ZtIcWCU+1cGo6gegpLAOXqDEt5Bo0Nm5yukrnstu0PQ6AyvNrw8bBtNDgY+8+wLa7UsGnmRe8CPDLOXpK8k0sIz7UMtcDl18szrK7vgK315ixLeyZ+3OutKz53XsAbr0nDqCQSDP12n9gXCki5FBi18F1kuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=e8vZd9yT; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I5qiuH018522;
	Tue, 18 Mar 2025 12:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=SiBooa8YAtIrdsevQ+rdcHXM4a0n66JQDZ/31ASqC84=; b=
	e8vZd9yTnWkmY/4o3WZ8gyUZEd6qApdOBtr3bzy2Qlh16AgOUuHxxwT1GHXJ95CO
	ZOvpeKO/ESQUiYWy3Yfhhf5Qobh2I0l9gPnptIS9LbDSV2Lt4BxnSRs9mBf6RvDk
	7nbOaLBNoIpNPKNvVLG44Qd6NSI+yYM7l3rbbWmWBgvPK31PtE8Y6CdVn1YOvxXq
	nfm8v3OWfu2WOW4sM6r00EDHMOA/sICagtpGQuu/baSh3jr6o1y252OskQOFCiVM
	vuJ/e5UCadDGcy7tbGOVEl0gF2UFvb52bYq4xwg3M5imsaHtCu835kxjFAKZELbn
	DAXjCru++6yyTImpFgMBOg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879v-7
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
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DAF4F82255C;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 11/15] ASoC: ops: Factor out common code from info callbacks
Date: Tue, 18 Mar 2025 17:14:55 +0000
Message-ID: <20250318171459.3203730-12-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa18 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=g_t_zcTVPRxTzv0K1HYA:9
X-Proofpoint-GUID: gdQKJXPDgJNaNkl9qxqWso8jZQGsWRzr
X-Proofpoint-ORIG-GUID: gdQKJXPDgJNaNkl9qxqWso8jZQGsWRzr
X-Proofpoint-Spam-Reason: safe

snd_soc_info_volsw() and snd_soc_info_volsw_sx() do very similar
things, and have a lot of code in common. Already this is causing
some issues as the detection of volume controls has been fixed
in the normal callback but not the sx callback. Factor out a new
helper containing the common code and leave the function specific
bits behind in each callback.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-ops.c | 64 ++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index d26d9e050af12..29537dd3a0633 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -168,6 +168,30 @@ static int soc_mixer_sx_mask(struct soc_mixer_control *mc)
 	return GENMASK(fls(mc->min + mc->max) - 2, 0);
 }
 
+static int soc_info_volsw(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_info *uinfo,
+			  struct soc_mixer_control *mc, int max)
+{
+	if (mc->platform_max && mc->platform_max < max)
+		max = mc->platform_max;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+
+	if (max == 1) {
+		/* Even two value controls ending in Volume should be integer */
+		const char *vol_string = strstr(kcontrol->id.name, " Volume");
+
+		if (!vol_string || strcmp(vol_string, " Volume"))
+			uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	}
+
+	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = max;
+
+	return 0;
+}
+
 /**
  * snd_soc_info_volsw - single mixer info callback with range.
  * @kcontrol: mixer control
@@ -183,29 +207,8 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	const char *vol_string = NULL;
-	int max;
-
-	max = uinfo->value.integer.max = mc->max - mc->min;
-	if (mc->platform_max && mc->platform_max < max)
-		max = mc->platform_max;
-
-	if (max == 1) {
-		/* Even two value controls ending in Volume should always be integer */
-		vol_string = strstr(kcontrol->id.name, " Volume");
-		if (vol_string && !strcmp(vol_string, " Volume"))
-			uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-		else
-			uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	} else {
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	}
 
-	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max;
-
-	return 0;
+	return soc_info_volsw(kcontrol, uinfo, mc, mc->max - mc->min);
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
 
@@ -227,23 +230,8 @@ int snd_soc_info_volsw_sx(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int max;
 
-	if (mc->platform_max)
-		max = mc->platform_max;
-	else
-		max = mc->max;
-
-	if (max == 1 && !strstr(kcontrol->id.name, " Volume"))
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	else
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-
-	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max;
-
-	return 0;
+	return soc_info_volsw(kcontrol, uinfo, mc, mc->max);
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw_sx);
 
-- 
2.39.5


