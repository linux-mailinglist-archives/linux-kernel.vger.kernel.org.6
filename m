Return-Path: <linux-kernel+bounces-544345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7145A4E056
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3553B3A7346
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A39206F2E;
	Tue,  4 Mar 2025 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WVa4u5D6"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B906206F04;
	Tue,  4 Mar 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097176; cv=none; b=dP63p7+RigVUORIJdfBupGDRUFJrP+ymnyLRzJ23wGwBNe1In4cYamfMb5XSGwCjaiTohenUjHnHCdynUm+hG+gxN0FypfevHJ/pQtxIzM7Fj2ywiWKpUpce1WZfC8IVqJ2G17Q2aKh/M6Vr3anyQ6/7seLwuStdr/SjQy7Tmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097176; c=relaxed/simple;
	bh=ojqZRUsDXoOgmiUDeq8qgvW9DRTDxrJRbyOjCMxQGuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMyqrn0GJBNSQK0UtKu85SkZMlbNyjvpHFwARNy7eA4snL104nJw6DGYqjnfIC888t31MZJ6H1t2qMrTfFN2mXy1HWSeJL+GzcoQacV/IulTInlB/lrN8yhtSyCsbDyldMVwJREJgaCajxZYRngYPxCDk2DgGCAcpTJxqysi+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WVa4u5D6; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HN9003809;
	Tue, 4 Mar 2025 08:05:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Xamx8NkmTl1igyEFsf3ucskwc70OK5zvWVuFsVjH8+M=; b=
	WVa4u5D6Y/dZblIGDGU5fF2xDlrjihYYllBiIrFyNHddzX3lPVlmUA0FF2Mr8hb2
	UlqxEHqU9DMe6L5CjrZf30pXKa5PLPg/oBSB0efpBBHVFr2+g9zCEmF3XFI+reWG
	16EwmAm2f8zhYgGmc2fYEasgGzz0RYXKSBxiu8twRrOgiLs9T8I83W9SxVmioFuG
	PSQQ46Fb1xK1dEwyZvyr4sQX+FeM6FjAnJlpxkAQniULHyMY693vF312v2wf4noz
	oH/LBzsJhOFKhwjMdIksYUDIIUNFrE6UkCPWJt3nB1vYJ8xPnVw4lmbyHba++dFt
	Ui2nS6w31EwT4GpLDcY05A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0ts-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:48 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 60C5982255F;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 06/13] ASoC: wm9712: Use SOC_SINGLE_EXT() helper macro
Date: Tue, 4 Mar 2025 14:04:53 +0000
Message-ID: <20250304140500.976127-7-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
References: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4HQu98L1jAuVjr4q92u4g0GSDdRFvHCp
X-Proofpoint-ORIG-GUID: 4HQu98L1jAuVjr4q92u4g0GSDdRFvHCp
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708bc cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=YWxpnfQN4UQdDMvGwCQA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

 sound/soc/codecs/wm9712.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index e63921de0c37a..8ff4b5f13b3a4 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -275,13 +275,9 @@ static int wm9712_hp_mixer_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-#define WM9712_HP_MIXER_CTRL(xname, xmixer, xshift) { \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = wm9712_hp_mixer_get, .put = wm9712_hp_mixer_put, \
-	.private_value = SOC_SINGLE_VALUE(SND_SOC_NOPM, \
-		(xmixer << 8) | xshift, 1, 0, 0) \
-}
+#define WM9712_HP_MIXER_CTRL(xname, xmixer, xshift) \
+	SOC_SINGLE_EXT(xname, SND_SOC_NOPM, ((xmixer) << 8) | (xshift), \
+		       1, 0, wm9712_hp_mixer_get, wm9712_hp_mixer_put)
 
 /* Left Headphone Mixers */
 static const struct snd_kcontrol_new wm9712_hpl_mixer_controls[] = {
-- 
2.39.5


