Return-Path: <linux-kernel+bounces-544337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343C2A4E031
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C850179510
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B0C204C35;
	Tue,  4 Mar 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="V8LPIR4q"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF612046BD;
	Tue,  4 Mar 2025 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097156; cv=none; b=tC7jHPqRmFN9Cjg39HHIyWmylDQ5eJPrvp6vtIYYHDdtTytNlkLoEuEQCxrA3aeiwIzTKsBMLnxdTro5m387biOL7WhGe+7PZmeFgiOzH35Ilf6Xgrv7LlF4+dGbGlhfoy5B3V3QbEsEMEiQPCAemk1bmc5VEWKrHe/rtl0lghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097156; c=relaxed/simple;
	bh=u5Hd0uArtDGRxH+HCbdm80NAFgV7BHiKDD1ImNNrTpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYQRKVTYElylOsdJjWTR2X/ZQ2LzktLmjG2mCnYlExOIx696Aizul+OvfnjP7mJspBNYv6ttDhAx2nZ8HVFVtyob7GUpQOdcVX2KTY+WNFBQR2ZpI2Vgl88M1ge4gk/2Vk/e2neZ8bsHltK/yi27jHBnaktPfpTovNmUP/ZSlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=V8LPIR4q; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HN1003809;
	Tue, 4 Mar 2025 08:05:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=/sueFHS3s6SAZ4eoWcd7kVeyPCQCX8lAXslE8xY3KBU=; b=
	V8LPIR4qCMMDfZDFUp98ke3X0JQrSZXfOVZJSOdW5iBvabEH1GFrxlcof5aNvBzO
	g/pBcnvZq08nO+qbPw4Zlqqtp7lJ/yQVZPkDITyTUn6E5e/j1dCWFs7iA0wbp+xq
	OW/aZVyodHVaIdR4G9qfPY335zBIMR9/bJF2dzA97qBY7ta+gW+wnFz8M38Ja//c
	ekCbR5QJiIbeH95V2V1D5sWxDaoK5SJbvSgxYLT+veYl8EGzD+eiOLubM1DUgGAY
	MaLPlXZjP/PLwm68Tcpmc45WOV7rKQg8i0TnqohRVJwQRkW6hyRrvpQNnkhC1Boa
	QQ+KlZT8JscJF9gFHXDZbA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0ts-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:36 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 370D082255C;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 03/13] ASoC: sma1307: Use SOC_SINGLE_EXT() helper macro
Date: Tue, 4 Mar 2025 14:04:50 +0000
Message-ID: <20250304140500.976127-4-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: Ghu_29ygCZ1pwpzChvh7-N5mPIn7PAAW
X-Proofpoint-ORIG-GUID: Ghu_29ygCZ1pwpzChvh7-N5mPIn7PAAW
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708b0 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=9UIenTYJiKZn6W3RuVMA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Rather than open coding use the helper macro provided by the ASoC core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

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


