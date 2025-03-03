Return-Path: <linux-kernel+bounces-542459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74470A4CA0F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117DE17E746
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F1C2397AA;
	Mon,  3 Mar 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="B2NryVQ0"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A473E236A68;
	Mon,  3 Mar 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022493; cv=none; b=VXfk4734cMAmlU9L2LzMCROV5L9ZveohkgfJbelgeVVbpfm3OUKNYYXZyWUE2Xc2ucUGIPPj1Igf8jw2Ak96r1aaUhgzxS04B7oxy8/uXzuSVkY2waM47skt6iq5xLXFcSoZIp6E1schpLlObORvh1ajm56cFns6o2aTEojc410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022493; c=relaxed/simple;
	bh=UPh+iaElivfjpVuJUkicR6+O2YLfUrPKAO0ntAYYgRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqGa8t6vqgCBPs1M1/BmFp0oJm/M8zBSrQjPteugrmYfAoAWONOQ9nZ9Ig8b1gfCZL62P3Gg6/ML3rOO9XgzdrBj+06puRRP3y1W73Y0ZayLpdxg3ZyVfYSBe4n8pazTJehioi6MzWzz4USdJI3NRx0eoZWlRqnOieqFGIXfDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=B2NryVQ0; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GTSlJ008860;
	Mon, 3 Mar 2025 11:14:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=iICmINFMF8Ipo2zy1gxNMdeLgBvGdLQ+hi8IyPCnP+8=; b=
	B2NryVQ0w7eQpnyQmSCw1kz6aVbWM1CnfCoRKTQvd/FH7mvIXkEU7UCr1SDQxNqV
	zv25WgYWu3/05WdTh2iiuRLJvbh1/tOTS1ZBTKFWkOtjq1HUcX734JVBycR5r4OO
	tvNT5qSbXxbd2XvxWcXx1Vdgd7DKo7y9ff7ozkeB9EqQfrVu2pFGawU5X2mn1lKG
	/XX8VxU0s0KaG0rSYstfWtcjUM4G/QNf7CFdVUL9rsYYMWU5/oo+2LF6k1dbGmPW
	XCkW4wyA0Zc84o+4XScbOan3fuoWHC5WbR+7Wgfo5vnyuZEwsIO6gzn40kFqgk8u
	FPdDgxi4ux4RnwfmWNmR0A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyg2xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:14:27 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:14:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 17:14:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 941E7820270;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 06/13] ASoC: wm9712: Use SOC_SINGLE_EXT() helper macro
Date: Mon, 3 Mar 2025 17:14:17 +0000
Message-ID: <20250303171424.444556-7-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: sZ6Xu534kYiG7mMwgZ1FSKailmmsADHb
X-Proofpoint-ORIG-GUID: sZ6Xu534kYiG7mMwgZ1FSKailmmsADHb
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c5e373 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=YWxpnfQN4UQdDMvGwCQA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

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


