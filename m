Return-Path: <linux-kernel+bounces-534277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69469A46501
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604B319C017E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F58224AE0;
	Wed, 26 Feb 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mVOQ9Ss4"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD822259C;
	Wed, 26 Feb 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583923; cv=none; b=jFsWoGjIdfQDr+Gt+EhNhtaJ4S6j4vN/2W7zi5EtqYK2xiYigheDnutgLGqaX84fP1K5sEba72D5r4/QLZM09rDmIvEHfIhMrfwarkf+xlJA1MvpmRNtFm1p2jjRziq4hxA/T4Ht3aJiEo9PxkUSaeB+SrSLiGkq0e5COA0PAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583923; c=relaxed/simple;
	bh=mX1Ef/ro9gNsbQOiYPM49ljjKAuRYbPh+mOcDi0rO/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBb6Lrm3knvw81nD2rBiVQku2Iyvev6QoqSvoNwZ1v8kJGXhrahhwBJcLw7vdPmUgBGzmgEY7GhUmkWgj0uf41FwL6wWUGiWevNjhiNVJl2t7vIpssBx9PUDERUVRc90rTbAwIh9LmYZsF3UtMZq3OGCEXfuqih2xvUu81Ayu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mVOQ9Ss4; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFIYLk001993;
	Wed, 26 Feb 2025 09:31:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ODRQrKEQ2CWaEfNEpD7LDwWk9Td86Aqzt95iMZ2VidM=; b=
	mVOQ9Ss4a49wgVy5ULMC6TGrCchg5N0LTjvs0Yet1HZIAM11gongS42ylXU0RD32
	yIpW/KKMtsOkaSX6d2pSO2ebJtk2sAqucO1C0QqxHRoRVmsOGqYbc6L+HdfkaFCh
	RPQhl+NgvvxqwWjmICBDAkLxGvQcfvcGsr4z2YCZ4EEKnlw/a1JY2nRt6srbYQsy
	3WxJfnkJNNZmrg+GTnh4wYsdcoHI7Yj6rsKK7y1oxQMmOnlqDgBO//hmlnO6b1hh
	F/4hx2xM0EnQEc3vqY4gUaXRl14QD91FjJxCa2dM0J2BOWREvM6qN/so8WKpzkX+
	Hbifb0DPyUntYT5lw6WkAA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 451pspsr13-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:40 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:37 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C71E782025A;
	Wed, 26 Feb 2025 15:31:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 06/12] ASoC: wm9713: Use SOC_DOUBLE_EXT() helper macro
Date: Wed, 26 Feb 2025 15:31:31 +0000
Message-ID: <20250226153137.2791938-7-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226153137.2791938-1-ckeepax@opensource.cirrus.com>
References: <20250226153137.2791938-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qPMFKWqrY4CfVLZT7lwUDST-EHKRGEbF
X-Proofpoint-ORIG-GUID: qPMFKWqrY4CfVLZT7lwUDST-EHKRGEbF
X-Authority-Analysis: v=2.4 cv=U8ZoDfru c=1 sm=1 tr=0 ts=67bf33dc cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=PzMjCjVtb1Ub-jEo5JkA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm9713.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 64b69316e4c70..0aa6491f2c842 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -284,13 +284,9 @@ static int wm9713_hp_mixer_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-#define WM9713_HP_MIXER_CTRL(xname, xmixer, xshift) { \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = wm9713_hp_mixer_get, .put = wm9713_hp_mixer_put, \
-	.private_value = SOC_DOUBLE_VALUE(SND_SOC_NOPM, \
-		xshift, xmixer, 1, 0, 0) \
-}
+#define WM9713_HP_MIXER_CTRL(xname, xmixer, xshift) \
+	SOC_DOUBLE_EXT(xname, SND_SOC_NOPM, xshift, xmixer, 1, 0, \
+		       wm9713_hp_mixer_get, wm9713_hp_mixer_put)
 
 /* Left Headphone Mixers */
 static const struct snd_kcontrol_new wm9713_hpl_mixer_controls[] = {
-- 
2.39.5


