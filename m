Return-Path: <linux-kernel+bounces-544333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB7A4E033
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1352E18881A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081D217583;
	Tue,  4 Mar 2025 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Rua86gwb"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C3204F61;
	Tue,  4 Mar 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097138; cv=none; b=D7wH0NtsCwsAzwDb4PVMCT6f/BcAnj/QLbS5eN6EmbvP78ykumU6JvB83shZhLO2rzEvmBKldUQdSAvK92UnvRu3mh0HhxHnf3ML2cQsMsy0oAwfyy69Wu5yx1ICv8aakAPHd6eenREhpZvEBSUP5VwZbECHMQPDSux2V3tV7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097138; c=relaxed/simple;
	bh=H0cdDUDP0tUDNvle5mqn0PjFp2oPaKu8rzlat+yz8dU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkN+RUk5eEOkBbm4zLwHSF3GY3RmDI/s+SmDqENptml/KP6fVtx/KDwnl62VCkFgzohaEs1+JaDg1u77s6wk/ZUOc5gv5MtIw7dCEmc8laIa4Rhv7Xk/z3p2Hiat0GqtXDKJChJefLkqD2T7VAvlbZwMdyTJKoBg2tm6e5gdLoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Rua86gwb; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HMt003809;
	Tue, 4 Mar 2025 08:05:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=2PmJiXiyjwikIiGOdlzXTu7X69hQxMmcD/lVZDTlcpk=; b=
	Rua86gwby8IpXNUy7quNSe4f0usZxpQD8YsbQRTfzRQipCXyqnAwulPZvijNpsLG
	bGH4D2Im+cemJcBYARof09S6hoB9Emns4PS0kR2MoTUVDuafLlXDLolrgI8Vr2Gj
	8JuMA6O0OFBH+rLdjoGb3cI54LWw6tQC0r/dRNRVow0/wnD2ahO/LOolF/j7gkL1
	qAhIqAqv8kGCr9k1rMYGfdJJASbV/pzTp2iguTn8Vtdbo0VWevQZv0qmT+LgEkAU
	739YXG+SSTF67tNAl7Zap6KWceC2vvMj/Wxn3SppF9MEEVO2YzhxJ7UpT6R4bKS3
	uW7YCP1vVztgnlS7XBhePg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:14 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2535782026B;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 01/13] ASoC: Remove unused helper macro
Date: Tue, 4 Mar 2025 14:04:48 +0000
Message-ID: <20250304140500.976127-2-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: m4_CX73lZ8ZNE1xEDlgi9pjivU_A28yR
X-Proofpoint-ORIG-GUID: m4_CX73lZ8ZNE1xEDlgi9pjivU_A28yR
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c7089b cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=w59pmiIdzG9l9f2s_C4A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

SOC_SINGLE_VALUE_EXT() has no users, so remove it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

 include/sound/soc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6bb2fca044c5e..01151a6ada350 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -51,9 +51,6 @@ struct platform_device;
 	.sign_bit = xsign_bit, .invert = xinvert, .autodisable = xautodisable})
 #define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, xautodisable) \
 	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmax, xinvert, xautodisable)
-#define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
-	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xreg, .max = xmax, .invert = xinvert})
 #define SOC_DOUBLE_R_VALUE(xlreg, xrreg, xshift, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
-- 
2.39.5


