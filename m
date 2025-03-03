Return-Path: <linux-kernel+bounces-542446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3C7A4C9C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978BA3BDB69
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5225FA3A;
	Mon,  3 Mar 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mOIt+Os9"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C125F7B3;
	Mon,  3 Mar 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022097; cv=none; b=sz1kqnVLzBnlyHZmmaohj/AQwdEO0FNaPbDzPLDOIMKNDVJ5esGXm4ke4TYyY/WE0j2kvBH6zJLX7otq/grZf0ndQSxeYzMCgKGPDUB/Y8S28wxKrYDuoyMy2Wn7i6YjFZBWn9jLjr+I2/Du++4vKqCorg/hXx8J4nC9duH00iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022097; c=relaxed/simple;
	bh=YqULy4HBRXZ8WOgo3pcQbjTqtA8y2mddMoWim55ScDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJRLVpKyQdCflMH3whYwHKy/L5/gtrYKr5j1Iw/Tdt+w0f/AZaWnt2HJixEA7e0Er4zUwQ2piqVoCpO1lngzPRxYMwhyKdbvgIavK1mMc/mDHGAz/M4ECZIc6cBxdrMOiYowwWsOvWGLi/dCXTBKaR5xF4b/MX3plwXIQOaYH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mOIt+Os9; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5236w7XZ006077;
	Mon, 3 Mar 2025 11:14:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=BKzA15+jn0DfPZ4LC84odjdf8Tone1ZCZ4RyUDriNe8=; b=
	mOIt+Os9q0uk6kmmCcn5VxEpyeCkgf/71T1vJdIh9LJngwMEsYGqRZKge6tzVvkW
	ZZ2SFibQg+v+e1AEU1npGfmRnrXOSQE4uJsvbVnPWgdXadJbMteo8XWSP1bKKtFy
	jddujuWJ5Iqdz9yobWuUedMl8FM4yY2KrQoJYrNWvP6eHe2vuAbsnBu3cRNtyvAE
	hXdfeICXsu1HbPbkKfRlOtSCWLDP4UMYQEG1/V5e1pb+0iTkFBR4IKI85yWZmr/Q
	Uv61HM3TByroM++C7CFU0GGHCKQOBavtkke+87sCcYx/Kivshamo6EMJ9XU4EcZU
	HgNbEyL6wpTrwL3yg1VP9g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmdame-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:14:33 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:14:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 17:14:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5E89082255D;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 03/13] ASoC: sma1307: Use SOC_SINGLE_EXT() helper macro
Date: Mon, 3 Mar 2025 17:14:14 +0000
Message-ID: <20250303171424.444556-4-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: OdcoufdStEBN4-vKN7rYvad9NxC8oPLO
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c5e379 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=9UIenTYJiKZn6W3RuVMA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: OdcoufdStEBN4-vKN7rYvad9NxC8oPLO
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

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


