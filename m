Return-Path: <linux-kernel+bounces-544338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B1A4E039
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD6F189E3A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2C0205E17;
	Tue,  4 Mar 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ah0GM+Qp"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE6204F81;
	Tue,  4 Mar 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097157; cv=none; b=Fw2OnxuYt/7lnFAa4QHcfz/6G65k1s8aeCVbbWacOmIT2Xy59rmWuQy8AZdphPOk427u41o45xMGsmAy9G2b7K/bQCEe9VqtKGceYIHTZSiEwGpTAYbUXchAzmc6AItzEB4BUim97RKjrhdnjvqJumtrzqnxrFEAXm2PcnmqNg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097157; c=relaxed/simple;
	bh=pEWT06rF5ER29/DEwxtPdO5qDLyEoFa5N4pRldJc1Es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUPzXOE/fsTe7/1Go4l9Mgz1Qc5lxEQfvkRsptz2mdncU/pw2ZGhxxLzuY2x4Nev1lt/zr6NHZxLsaWZUeMYSA8pMYmsJIAqg9Vj/3f3ZtF1WUa0QDgz9VsbK2esfaRDMuQgiKl4G+vbeLP2JSlgIubVoygoiRcf9XKnGxcpwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ah0GM+Qp; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HMx003809;
	Tue, 4 Mar 2025 08:05:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=DAUN1xmKiHRa06mMChXhn56VKh4mQXpXTwRGsvWBm1g=; b=
	Ah0GM+QptuRZq2EgeYd3E3HmSPeq8zpc5mQlTZG1eVThf+0FEuzm2VoFLIj1BGuk
	HWJtVvvHJiKRL0OUKmQNk9qRaXFDSGIp/tjUHO7sBEhWcZO13ZhYwd8RcFkRXEpO
	tHuMH4LkMEGLzvTqYXrZcaQUdsoHzP0sS3R9KHhnOMn66ArP/1a0u9r5K8MiRJT9
	8ve089N6sPWmKdS+GQZdDlyg+Z8tFI7IH9rFsgUF7kUex9hOLWEIhbc/w0hf6BTl
	Un06fz3YSFl225ziy/zl8uWGjVl3A7y80yyEobI+wk7aqrAFhFj5JanyyxOCevY6
	QuTw/r+cIomSMHqOdhjYjA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0ts-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:29 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 332EC820270;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 02/13] ASoC: rt715: Remove duplicate SOC_DOUBLE_R_EXT() helper macro
Date: Tue, 4 Mar 2025 14:04:49 +0000
Message-ID: <20250304140500.976127-3-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: jGUAtXRPAsZMGyXIVsb2Eri6pWSUHXNZ
X-Proofpoint-ORIG-GUID: jGUAtXRPAsZMGyXIVsb2Eri6pWSUHXNZ
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708a9 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=m7LK8A4iqEoLkfJFdDEA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

The rt715 does not appear to use the SOC_DOUBLE_R_EXT() macro and even
if it did, the macro is defined identically in the ASoC headers.
Remove the redundant macro definitions.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

 sound/soc/codecs/rt715-sdca.c | 8 --------
 sound/soc/codecs/rt715.c      | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index 7e10fd9138122..7fb02654c16bd 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -427,14 +427,6 @@ static int rt715_sdca_fu_info(struct snd_kcontrol *kcontrol,
 	.private_value = RT715_SDCA_PR_VALUE(reg_base, xcount, xmax, \
 					xshift, xinvert)}
 
-#define SOC_DOUBLE_R_EXT(xname, reg_left, reg_right, xshift, xmax, xinvert,\
-	 xhandler_get, xhandler_put) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.info = snd_soc_info_volsw, \
-	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
-					    xmax, xinvert) }
-
 #define RT715_SDCA_EXT_TLV(xname, reg_base, xhandler_get,\
 	 xhandler_put, tlv_array, xcount, xmax) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 299c9b12377c6..2cf4618520918 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -486,14 +486,6 @@ static int rt715_vol_info(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-#define SOC_DOUBLE_R_EXT(xname, reg_left, reg_right, xshift, xmax, xinvert,\
-	 xhandler_get, xhandler_put) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.info = snd_soc_info_volsw, \
-	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
-					    xmax, xinvert) }
-
 #define RT715_MAIN_SWITCH_EXT(xname, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = rt715_switch_info, \
-- 
2.39.5


