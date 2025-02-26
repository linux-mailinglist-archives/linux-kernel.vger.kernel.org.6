Return-Path: <linux-kernel+bounces-534286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA2EA4650E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4471E19C2881
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA112288E3;
	Wed, 26 Feb 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gIquzQBz"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34FC227E95;
	Wed, 26 Feb 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583932; cv=none; b=G58uoXdrmJA3M+xuNsurHjDqbYahOK9egAb6F27rWEKs3LUX6/AoLHs3G8vZI9Aghn9xELSoqjm1IYU6ekdS6oN0ux1M1CUSbBTCbKeSt/pM7YVH4ffDcFHWh7N+K1xqG26ZwDOkvu77byMdcGbJKIWECsi5ncd5qnN1Jwc8s8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583932; c=relaxed/simple;
	bh=tiTWxLhbBldOIia0dcGpNvPsydAeaWOSabDLwodled4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TheubT+xIfJuZ+FpUcptuTW9n7lZbfLZRO4vxhmC4YI2MVz0gN4mACkBRSvhiMdbO3oQSyQZ3BBSzazOtJFq3EFcCNm0/e5tOs/pWXrpnJf/w0rgHjOAg3KHzXd56I/uVJ74MiSKoaHhGXCXLxl7qSgXqnyIx61wOPhBRIu3MVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gIquzQBz; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFJEx1014247;
	Wed, 26 Feb 2025 09:31:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=aZZyF+/g63a7aokB6cHyCjmyc4LCsOoVeCkGeOAipeA=; b=
	gIquzQBzABbYYhaOuyhgPOfW1PuwWEgHbtEdDEKh1aIbi6Onu6uNcXUnCDqoaIEE
	3paswAkLU6fsSa70eYUM6b4lAOG6Jc01/5awmekkwNDWasyIjht6DJfqgLiQZzwP
	6ppthS35+ac1ZrvJ6Dy6TWQ6QEvE6OTpxdb1qQnIdpUd5wSqSMD3C+C4EVdqV8xO
	M4H3K0yvVJaAdl2YrxCjCDJv0q/3y75WZwgnBVPfXLuxhL8nxutLlMP+htJhAUZE
	ChUgLILg09pzJsl7Km01TAUiX9OKzOzlLaMN2DMVTNseOW5FtPiohw1a+Sto7cvo
	86ikEycrLkyV/hoseABZnQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 451pt3hq9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:39 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:37 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 81F4A82026B;
	Wed, 26 Feb 2025 15:31:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 01/12] ASoC: rt715: Remove duplicate SOC_DOUBLE_R_EXT() helper macro
Date: Wed, 26 Feb 2025 15:31:26 +0000
Message-ID: <20250226153137.2791938-2-ckeepax@opensource.cirrus.com>
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
X-Authority-Analysis: v=2.4 cv=XrQAOUF9 c=1 sm=1 tr=0 ts=67bf33db cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=m7LK8A4iqEoLkfJFdDEA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-ORIG-GUID: Uo07UQuklArsP6vCspdlW0Xjh0VAno6j
X-Proofpoint-GUID: Uo07UQuklArsP6vCspdlW0Xjh0VAno6j
X-Proofpoint-Spam-Reason: safe

The rt715 does not appear to use the SOC_DOUBLE_R_EXT() macro and even
if it did, the macro is defined identically in the ASoC headers.
Remove the redundant macro definitions.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
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


