Return-Path: <linux-kernel+bounces-534282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24814A46514
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB15F42114C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0658822577E;
	Wed, 26 Feb 2025 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lIU83lq9"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E86223322;
	Wed, 26 Feb 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583926; cv=none; b=FtvtPUMuEcwZNxk3YvueBw6WlQm+1HMDvT6y9z7xB4hd2dl5w3tmmzbZHpzlo8UpfpmXGEJecM2wkTaibVO1yGPkM7uPgYcyliTW94MA5crmyGbrLV4TpKVTjnDTA8j/vMqdBP+2gnhziHT5CDurppLLAjWTIiaQmFIyuti3mGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583926; c=relaxed/simple;
	bh=kyelU+HKw3MD6MFHBujdHerWAlop3GaY22RguQ2fHTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+Wo+jMGO4LS5GM+9Qg3nyY3nKGuKac7V5fJW3KHEjPnKPrEh22a5X4QjtwWKOn9pu6dIcEeFBDAO+QqYRwAIVs+jCA+gs7CtZOPCH3hvsoP7x+sGouJ3J6hqrikUH0mINYKkKV4bGSsJn2RB6yPkOJ82E/JqrCKl1teOygPZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lIU83lq9; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFIYLl001993;
	Wed, 26 Feb 2025 09:31:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ZsvhFPjE0RQ+iRcs01URNkACL9DSz2PKmUbWcrA+Y9s=; b=
	lIU83lq98oUWeAEdfoYNY3mUQtDNvJYXhJ4n2gcrYmxqUqoMMoKRy3ckT6ESb/hw
	OmWUwQrXgNBiVF3yrZGP76qsd5g+Tge4n95BwwN4jhtgNAkY9iWS1mgVFONCA435
	N9yOI76Ctw87cVCBoACFcHbneyK/ear7J5Z99RWQluBIHn3CClvuKOUWJm5G5UUC
	XmRBJfgODiNKJG19hUyAdH57MKVatm6F17+wiqp4qnU67fqDLxdbxqU7xjcrFsf9
	hanylhqjk7Hyh3Kgj9XkxhQPcqLyxQAIbE6/a5ZXi2EacNqdXZLo9GWezT0fTDuF
	vUCMFteKjm0eF7rMjKMr5g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 451pspsr13-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:41 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:37 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B6C7882255F;
	Wed, 26 Feb 2025 15:31:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 05/12] ASoC: wm9712: Use SOC_SINGLE_EXT() helper macro
Date: Wed, 26 Feb 2025 15:31:30 +0000
Message-ID: <20250226153137.2791938-6-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: 1vt0MKuBKHjI28JfJHb5x3ai9B9OO5sK
X-Proofpoint-ORIG-GUID: 1vt0MKuBKHjI28JfJHb5x3ai9B9OO5sK
X-Authority-Analysis: v=2.4 cv=U8ZoDfru c=1 sm=1 tr=0 ts=67bf33dd cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=YWxpnfQN4UQdDMvGwCQA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
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


