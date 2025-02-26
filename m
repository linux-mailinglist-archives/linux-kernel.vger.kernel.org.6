Return-Path: <linux-kernel+bounces-534281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C0A464F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD267AA1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E0225415;
	Wed, 26 Feb 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YQNX8o3N"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9F57C9F;
	Wed, 26 Feb 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583925; cv=none; b=E+iXMM2dUVVQktNKmJpwePtXczDDcnvA9qWTt44wPM2O9Vhc6hgJ29q39vkKyPD9xpHfLv1skfj0Q0/ruRfcpXTdYLGxGu9S014El9IijmPOd5FwAKGv0wHOcMiVXl63+PQbGWElGJIti5+2ZWq8DsiggBYduImFke2pi/4PfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583925; c=relaxed/simple;
	bh=LnKiYiFYtayZ6u1tikHpwizrlJaOJ14b9xYtByTNuLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gk8eVY8MvOt8Y9w079UkT5MPwkUS0Rgf8tJh2vQmhurfWYFSnb8J54SaXhf6alCCJSSUp8R4Uh+8Sh65/z/xy/FcldVSj3r3Sd1JudnpfcWqz3YmopImVmrXZsR+PQf8qbNu/uLBvWdW+hRe6tJyDPhm+vCXK5Yi1Ve9EKjQY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YQNX8o3N; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFIYLh001993;
	Wed, 26 Feb 2025 09:31:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=i/qXyLzjc+GUndwSAan4yNUFtgMCK9+U7Iwkxu+kteA=; b=
	YQNX8o3NT8RqFjV40YGyjiSO90LTy4n7n3iComcCh3mwQ/l9mPeUg4PRNz0SRzYP
	1z2fcpAHf4+XvT1ND+jznuU6LXgI7gv1ge88LtZM0fdHJ6tw8UJ1OGERmIbsyI90
	fr+VXzS/fFvUWP8ktoGeIfX/4eAhemZBklsfr7BA5JfL+/adFSfMgcu/dLHg7l4c
	LZjVKM7BZE8lcf88+pSp1kUEH7fpzSBAjrokPm6kl5rH/JOq0sANKJnpj1fjJ1FM
	a477GbEeYtzuA1B9/o/eqQWAjd/YaoCajvEQmSYsL1Uy33N0m3HNh2YtIRFBhRqa
	cgGSqVPYK3QGM4j+5h3BEQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 451pspsr13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:39 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:37 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 87848820270;
	Wed, 26 Feb 2025 15:31:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 02/12] ASoC: sma1307: Use SOC_SINGLE_EXT() helper macro
Date: Wed, 26 Feb 2025 15:31:27 +0000
Message-ID: <20250226153137.2791938-3-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: JfW3IfIVX2ckopD-dNNvSprtV7zqXn9w
X-Proofpoint-ORIG-GUID: JfW3IfIVX2ckopD-dNNvSprtV7zqXn9w
X-Authority-Analysis: v=2.4 cv=U8ZoDfru c=1 sm=1 tr=0 ts=67bf33db cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=9UIenTYJiKZn6W3RuVMA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/sma1307.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index 480bcea48541e..dac17da9ceddd 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1019,14 +1019,9 @@ static const struct snd_kcontrol_new sma1307_aif_out1_source_control = {
 	.private_value = (unsigned long)&sma1307_aif_out_source_enum
 };
 
-static const struct snd_kcontrol_new sma1307_sdo_control = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "Switch",
-	.info = snd_soc_info_volsw,
-	.get = sma1307_dapm_sdo_enable_get,
-	.put = sma1307_dapm_sdo_enable_put,
-	.private_value = SOC_SINGLE_VALUE(SND_SOC_NOPM, 0, 1, 0, 0)
-};
+static const struct snd_kcontrol_new sma1307_sdo_control =
+	SOC_SINGLE_EXT("Switch", SND_SOC_NOPM, 0, 1, 0,
+		       sma1307_dapm_sdo_enable_get, sma1307_dapm_sdo_enable_put);
 
 static const struct snd_kcontrol_new sma1307_enable_control =
 	SOC_DAPM_SINGLE("Switch", SMA1307_00_SYSTEM_CTRL, 0, 1, 0);
-- 
2.39.5


