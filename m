Return-Path: <linux-kernel+bounces-544339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 344CFA4E03C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A852189E4CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399F3205511;
	Tue,  4 Mar 2025 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VeFRec9Q"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29562205E06;
	Tue,  4 Mar 2025 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097161; cv=none; b=Q2+S88N6T/qzfuKCBOJjd4qtXucjNig+oTlBMMUuKhGmI7HH3Z6FzCS+cs+P40pEr4z65RXGpu4fNrF/xhnIwoOTi/ptaNjEFEwhxWIBMA7jay+rx/rQeQPd7MUO9JlqqJHvrjJSjkD69zr9hsQwtGAKrZ3uB0gz+f6U5c51xi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097161; c=relaxed/simple;
	bh=5m3Lgi++3mwVq3u00rPBKjcYFt9fzNBR4a2uPAL5A7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMpEKiEfGvNsoJJVevrysVH9iIzyNk9Z7omKKmxW1n6VTixy/BNipo47/lZsMKasBeYWIvNfx/E++4oxzDU0cwTH3A8wqdlEBQzTQtHG1/uNuZMyMQ3ovB/vzzs7HZCo3z9isOR3KP5Z3n2EeKS7ygckG0PC3V8ija9o3ZLspiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VeFRec9Q; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HN4003809;
	Tue, 4 Mar 2025 08:05:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=jMcR3OhQGVlGr6+FpUC/LYiTXFVBxlHwZDIbiGPznPs=; b=
	VeFRec9QmR3oaSvJyU0kwE0NtJxplOdNHa4uBLME2P5eRIFVcHjTT+Q9UYrCTdbJ
	KEtggU6pUqBUNziZOe81wf6vGl2A57BBftyE9MjiJXSu1hj97l3G/GeCk+Qpavnj
	eTNsqIdnjlcgYFSVoDZFS8DOYFrGK820GM9lZT3MJZXBjKmfv10Awum/p0LHZbIF
	VLoKYqAVGIN7bjca4p6I/jO2f/5Slcq2Tg6oWk8NBpYx6zISXk8d3ygIlX5iuG8y
	clNDjge6toPXJ+RkEUJmMYCoYH9Yi7qBLOwkTZv6DUYcJhvjTlrfUSVeLHnHFd5p
	HOyY4c9sRAnsmoHXv2+WAw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0ts-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:41 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 70342820248;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 07/13] ASoC: wm9713: Use SOC_DOUBLE_EXT() helper macro
Date: Tue, 4 Mar 2025 14:04:54 +0000
Message-ID: <20250304140500.976127-8-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: RPtqrHBOSJZhb0--FY-NyhHKCrJ4cZgD
X-Proofpoint-ORIG-GUID: RPtqrHBOSJZhb0--FY-NyhHKCrJ4cZgD
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708b5 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=PzMjCjVtb1Ub-jEo5JkA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

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


