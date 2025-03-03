Return-Path: <linux-kernel+bounces-542442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7037AA4C972
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8116E7AB32F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEDA25EFA1;
	Mon,  3 Mar 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Td2Q3gaO"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E225E46B;
	Mon,  3 Mar 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022094; cv=none; b=itNdkhBSinxA1wES8ZyG5loj7OzMxqPbrs+c/vtTNtC63uOq99y/CtzVRZgy6dXROn0FufLx8kD3h8WjzUvGhItP8I08HtYU8ua5oCX6GRwg9JzK2s5QJgjOa8jjRGk9lPRTeWHsdz2vlpRuDvp2HSE7WnT+zpw2mBpQ0nIeoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022094; c=relaxed/simple;
	bh=XYmh4BTKy1mvuOGCFQ3H809Vx7xgorVwsfClAb56IfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJjnxZOMEAUuTb+kh1Fc7HJbhSKsaAbbGh7cxy1rDep7nkOEZ2LeGL2tXX17Es0JapJ7bMvDSjplDwiVXNj+htUJMPvOaeyca400Be97vVBIqNvgMYxBTqPCs+yp2DqeSCc9XdjpwJEWnQiPx8waT3tjE8u/SOVsWGuyg6EnNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Td2Q3gaO; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5236w7XX006077;
	Mon, 3 Mar 2025 11:14:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=CExD4RBWGtXvWXRh/s1F+bYKVl/+9yIxaoxGKhH19V0=; b=
	Td2Q3gaOpXyml+tLjbfqSmQyckJh/0yCchjOA4zOF9+fBni18cl3qCWJUOdrokhf
	pvUnKuD0lhuWDlylpFz8xPjXcKeK2whehYtAkNF6JqOI7OvqtY9mYSLuums1VOS+
	maLzorOTMjc2VDBBAJP4+Whfz8GmAO1qjkswosJU1L4WS6zO7rpwdG4GQi9dv1IU
	DJ5YjuGTAHqBlYXmvGSBRfPBTcu9462RZ7+dzW6h5nZVzadiOuo/IOFSSrfTF8zE
	/g4bZxYE3AWwBiYRq8jqiGfUep2nV+ThG5VPHfQ+Gd2nthBaRMAASHRfdGLGRliu
	KqYiZXdrlikCbPfhj/5R3w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmdame-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:14:26 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:14:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 17:14:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4909B820270;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 01/13] ASoC: Remove unused helper macro
Date: Mon, 3 Mar 2025 17:14:12 +0000
Message-ID: <20250303171424.444556-2-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: 6BvNfFPNtl-IzVZ9u9VflxS7q5JJsR5g
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c5e372 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=w59pmiIdzG9l9f2s_C4A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: 6BvNfFPNtl-IzVZ9u9VflxS7q5JJsR5g
X-Proofpoint-Spam-Reason: safe

SOC_SINGLE_VALUE_EXT() has no users, so remove it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

New since v1.

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


