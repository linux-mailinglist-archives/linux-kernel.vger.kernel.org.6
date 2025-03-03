Return-Path: <linux-kernel+bounces-542440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E45A4C9FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15B03BD5D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8CF25E838;
	Mon,  3 Mar 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="N5nWPh4w"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD425E478;
	Mon,  3 Mar 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022094; cv=none; b=rITu48H/+sFU+nosulhj0miygbX91l/vtbm+mE71Xn0PoDUniElgvdCpfBXT6BTHjFfNjTEZQlwuCiRobaru/jEDSXWl2M1PXCGHJLacMfonyWqlilEYfQqGNs2hs7ihsj6mAiaThN2moDLW1YXsEEF2w1vKt/LDCM9LFzqSyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022094; c=relaxed/simple;
	bh=MSB05PSN6DwR18Lmj8hK0oNlTGmQji6rmfml++/cvoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQsymDWtQUqNdrN8RKZBCH1UfUKRUrGfgk27jYYB2wZiV/5VdctZlyz1HIoOhc7j/jSYItYDu/gJRehx1Ufo7Z+iO7dfTUkM7zAK8eZRQJKRm4aZhNVisO9u19Xft+z1l8WJGO4AVOof5YgyjYu4SNQKVmZVXcGpyu/X8u67qUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=N5nWPh4w; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5236w7Xb006077;
	Mon, 3 Mar 2025 11:14:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=kk7SewmfoGIxonH3ec1mxyvJ4ieLUHhDRbOPDFP6iCg=; b=
	N5nWPh4wD6YpwsHHR2307riZ9WbIxYpsM8OgV+cWBSNDbEBnfatojrAFot+cBYS7
	iHT/7IP+YXkF6p2kwJnrNnsNGG2bECBR065IhfSzhXWkkQ5ZNg3+xK0i/yI7VVuB
	fjTBRLj4hEy3XcvTjpbj9I0qhney3FNCWdzSR2mX0Da4CKGwyb2z8BhiVuAyBBQS
	VDRJ90j/wl24qIL510nmfMxD55Y6p+lmyJseguTof2slK86K8M8NK0+D7eDrPfXW
	4OMtZNZ9aYbZQpXTCHuXUDW7eYCV1l8FiN3XWBmwo2/tfrmMw1PW2VHJIjqwFV7L
	NSqxDqccNHQ+kHUHEqkN1Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmdame-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:14:34 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:14:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 17:14:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 58B0E82255C;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 02/13] ASoC: rt715: Remove duplicate SOC_DOUBLE_R_EXT() helper macro
Date: Mon, 3 Mar 2025 17:14:13 +0000
Message-ID: <20250303171424.444556-3-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: zgiak0dRrRV2Q1Zqy9VlVh6HPMkzz2JQ
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c5e37a cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=m7LK8A4iqEoLkfJFdDEA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: zgiak0dRrRV2Q1Zqy9VlVh6HPMkzz2JQ
X-Proofpoint-Spam-Reason: safe

The rt715 does not appear to use the SOC_DOUBLE_R_EXT() macro and even
if it did, the macro is defined identically in the ASoC headers.
Remove the redundant macro definitions.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

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


