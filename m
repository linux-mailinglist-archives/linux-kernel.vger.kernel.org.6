Return-Path: <linux-kernel+bounces-542460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80260A4CA4A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036873BED3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41482397B9;
	Mon,  3 Mar 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Kr6ADw3w"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A123908B;
	Mon,  3 Mar 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022493; cv=none; b=lxT8G1zvgIXMB5/8YpCxXaWWlvmhGsWSewxzM9XO06Yr6/ms0cvz5YYBAK0QpHxioiR35HNGxXpA0AXTxeiMH6zr1Etc93AVW3sGctYi/KzPvgbr99tsYF6qYESswwcL5+29R4oGsBAxssUG3/AmvB+S/MYpYK5EGNB3eton7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022493; c=relaxed/simple;
	bh=cvmiC5T+YFNWOY5uCuBlTnr+UjdBiuwmwBtnxin+HyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbdm1T78DL5AbIwi9RupxjUXc2vP3x1ZHuDuVAbwNQiMP2SmhmwzJ/7ahMhVZwjw87UAobvVsMZb2D/BuBtQkxqiW4SXyz+ajw18UDqByjcPZfbCucbJ3SPZ29p4adXvF1CL+f1WhqqT2S4hfSqxkeo4jgoMGFfAvlRfJdfICwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Kr6ADw3w; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GTSlL008860;
	Mon, 3 Mar 2025 11:14:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=sKGphp2prtA4Tql5Kr5Be6D0B0OHIdhwPF0jAGlnHjY=; b=
	Kr6ADw3wT9fK6VMEeUoIKea0dof2PsVw0dmEH6Whh+tVi6UFJCgtbjhfXBs/uIEu
	HkMdEZBG039ljRzpnBXejNR8IV9lL6+8+Ge9OqTGtBHhq+JDl53ouc4kSIQf66kX
	6tww561GlbJTzrJLVg5IJ8zcLgJj8acLGj1JjHG5gk1LFmEb6QogeOigvI3eh7pk
	xBW5ytG3Wrth+LR7kOSBgkVZXHSVaVHCdXHebNotuDbIfpMJNd4jwA2T2MUxokSi
	lbjm9vQQBsMn83PnUYyyJfE0NE4LJuekHzD/BAZz29Fzjx1XrgvoYGZnpfwnw8jl
	CUjHSnr/EBVlcQlmkLvi9w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyg2xk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:14:29 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:14:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 17:14:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C630982026B;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 09/13] ASoC: atmel: tse850-pcm5142: Use SOC_SINGLE_EXT() helper macro
Date: Mon, 3 Mar 2025 17:14:20 +0000
Message-ID: <20250303171424.444556-10-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: D6PtqjLUkVSvofzzk-I3X0gQ5hqbx3y7
X-Proofpoint-ORIG-GUID: D6PtqjLUkVSvofzzk-I3X0gQ5hqbx3y7
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c5e375 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=0mOSjS8g2lfFcO4yiOgA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

The TSE850_DAPM_SINGLE_EXT() macro is an identical duplicate of the
core SOC_SINGLE_EXT() marco. Use the macro provided by the core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

 sound/soc/atmel/tse850-pcm5142.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 0a9efd5f28615..2a1d0408a4cf1 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -227,16 +227,9 @@ static const struct snd_kcontrol_new mux1 =
 static const struct snd_kcontrol_new mux2 =
 	SOC_DAPM_ENUM_EXT("MUX2", mux_enum, tse850_get_mux2, tse850_put_mux2);
 
-#define TSE850_DAPM_SINGLE_EXT(xname, reg, shift, max, invert, xget, xput) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = xget, \
-	.put = xput, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
-
 static const struct snd_kcontrol_new mix[] = {
-	TSE850_DAPM_SINGLE_EXT("IN Switch", SND_SOC_NOPM, 0, 1, 0,
-			       tse850_get_mix, tse850_put_mix),
+	SOC_SINGLE_EXT("IN Switch", SND_SOC_NOPM, 0, 1, 0,
+		       tse850_get_mix, tse850_put_mix),
 };
 
 static const char * const ana_text[] = {
-- 
2.39.5


