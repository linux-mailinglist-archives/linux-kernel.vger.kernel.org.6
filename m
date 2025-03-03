Return-Path: <linux-kernel+bounces-542462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B47EA4CA01
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C288717E4B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8323BFA6;
	Mon,  3 Mar 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MfABsf/n"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F294F23AE9A;
	Mon,  3 Mar 2025 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022504; cv=none; b=U6dtSO1mea4M290e0QRoGDymBIvYMtC3p2Cmq+v+bZ1wC0tcc73oUFIkqQ4729NSqZZMS9Mf0SuA7y6qlYxhjxkZ0Pt927JnKl0AbQFlr5qzAcS2MgEPYmHsqsOBpZtZiPqvpkOQxS105rpxhu2aEnA7jLHE1f0iFzkt/H6Jxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022504; c=relaxed/simple;
	bh=ywwAkQtBX+EioXtw8En3vFpcivFCSJ9Ujr9LehKmvoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWy2wm/EcPU/aFErrl6ahg63SIZqWacUt0He/uh0LH8pondJ9iuSpYEj9Dd9Pvm6MCLGAAQKEWt1w/ZM8G/IZLx9vJ03gqkg8efgF7PfPWuKqFswxXMYa5C898lDw7r7g+JsytItodUwn6AecD/FVmrLPRTAJMKAMTuaW1VyoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MfABsf/n; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GTSlK008860;
	Mon, 3 Mar 2025 11:14:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ePaGDB/M8bsE29jJDCe3w8tnUcd4GQ4XoDT3P70RG0k=; b=
	MfABsf/n6K9fm7UigGh44nh0j3fDuFLSEi+K/Zzj6SEO1HBJAosCO1ZTR9K2jBGk
	+jWjb70Z1uakDbLSZwYKD7wFHUaEpzDnlzdf5mYvpv4cIN5vOopZF+rLbMvpaw52
	fxrQWVQQtzvJZGcSFhaMMu+6xiPlyLAVd6+HhhYNCpLmHl7n49FPp7QDkuBi9qqj
	K4GblKuLYK3zCoVZ0JLB7yW7i089vLgWzSqK9O6tv7EJ+lpGGNqTYMITLucZNLET
	LA21aGfBbYfMHZbRe+XsTCosyYY51zBLN9QREkYNetS9+MSmLdRvIs8GfwR3pibO
	8RI4klSrDv/Fa0yG9hPC3Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyg2xk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:14:28 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:14:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 17:14:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A3D3982025A;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 07/13] ASoC: wm9713: Use SOC_DOUBLE_EXT() helper macro
Date: Mon, 3 Mar 2025 17:14:18 +0000
Message-ID: <20250303171424.444556-8-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303171424.444556-1-ckeepax@opensource.cirrus.com>
References: <20250303171424.444556-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7WFaJtXUFlbC9oOlRs-5qhQ6gRYDmQZB
X-Proofpoint-ORIG-GUID: 7WFaJtXUFlbC9oOlRs-5qhQ6gRYDmQZB
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c5e374 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=PzMjCjVtb1Ub-jEo5JkA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

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


