Return-Path: <linux-kernel+bounces-542443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E9AA4CA2E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D63F3B65F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B14525F962;
	Mon,  3 Mar 2025 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Y1Vx0sb0"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718622DF83;
	Mon,  3 Mar 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022095; cv=none; b=ULe9MAxzNgxyyHXDXOAdTVo7ks6D6M5G16pXS9SXNeEI5gCmQm93ZOWLsFH6m7TNq5IsoK2gRYsWe3M3MPvli34AP0NWXCy4B5nHOf1EOmzDk65Ag4s56jYus2dOsX6T5Ifk8CLq07W2rI3NKAhXP/ozkozi5xwpkcaMWkNirYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022095; c=relaxed/simple;
	bh=SjjfEZtoOLUHHedoV60eFwJ/rZxeF7Shc4+PFgJ/+NA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LJDAKZWcDoQPCVfj+smbjohbGnsLwD55mY3hCkF6ggURf4YxEQAEoUB8/uj7FJyChFukPQ72PjOzGN9Hcux3+1OdTPeA2KdAnZNoxawkhbefcdCeSyw+Ur1SD1ZtPbZjALZnwB1uTT8ysVGNuVgwk+yMFzjM6ACwvRAK4zgl0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Y1Vx0sb0; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5236w7XY006077;
	Mon, 3 Mar 2025 11:14:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=s/yW4vxbaZeiOpEy
	3AWafozYSHeMHWngifjIQKgH118=; b=Y1Vx0sb0P9lg6Av1aUUJJFATYv6GgsAc
	RSJiXpioqmT6nMSaqC3NTAaT5o8ehrthtUi1jw/TwNUStn0CfH8GrK0Q/N7rqRpW
	SaRdgS5fFaYlUCXk9xxjVTlCDNPgbFMFT6QQyOJZA3KPwYctTkdGv5C/5Q5Si7K5
	R3wgleM5yGqGvVisP883c3rLreqWX2+hxl3HD3RT5McQZxvgT98Be1bprWI5hzrp
	rHHo/+7s4ZelO9oGn8JhgYn4Kpqf9003qSdtmR4kdX+RQFXCuytuWJbmh0dWPf7C
	7IiL9iFOF1zyWEhYiaAA3pFWMyj7DeiCUWsKFLiItnEZd6O6wjsZCg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmdame-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 11:14:26 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:14:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 17:14:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 410E282026B;
	Mon,  3 Mar 2025 17:14:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 00/13] Tidy up ASoC VALUE control macros
Date: Mon, 3 Mar 2025 17:14:11 +0000
Message-ID: <20250303171424.444556-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Wn5bLmxxjIrirAVH_TYRWcDIz4Enwa8Z
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c5e372 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=pzkeEdGVe-7zqstrry8A:9
X-Proofpoint-GUID: Wn5bLmxxjIrirAVH_TYRWcDIz4Enwa8Z
X-Proofpoint-Spam-Reason: safe

Tidy up the ASoC control value macros. Fix some drivers that should be
using core macros that aren't, combine the existing core macros to be
a little more consistent in style, and update the core macros to use
each other where possible.

Changes since v1:
 - Add the missing first patch that I managed to forget in v1. This was
   stopping the series applying, as it was only in my tree.

Thanks,
Charles

Charles Keepax (13):
  ASoC: Remove unused helper macro
  ASoC: rt715: Remove duplicate SOC_DOUBLE_R_EXT() helper macro
  ASoC: sma1307: Use SOC_SINGLE_EXT() helper macro
  ASoC: tas2562: Use SOC_SINGLE_EXT_TLV() helper macro
  ASoC: wcd938x: Use SOC_SINGLE_EXT_TLV() helper macro
  ASoC: wm9712: Use SOC_SINGLE_EXT() helper macro
  ASoC: wm9713: Use SOC_DOUBLE_EXT() helper macro
  ASoC: wsa881x: Use SOC_SINGLE_EXT_TLV() helper macro
  ASoC: atmel: tse850-pcm5142: Use SOC_SINGLE_EXT() helper macro
  ASoC: dapm: Add missing SOC_DAPM_DOUBLE_R_TLV() helper
  ASoC: dapm: Use ASoC control macros where possible
  ASoC: Tidy up SOC_DOUBLE_R_* helpers
  ASoC: Tidy up SOC_DOUBLE_* and SOC_SINGLE_* helpers

 include/sound/soc-dapm.h         | 59 ++++++++------------
 include/sound/soc.h              | 96 +++++++++++---------------------
 sound/soc/atmel/tse850-pcm5142.c | 11 +---
 sound/soc/codecs/adau17x1.c      | 10 ++--
 sound/soc/codecs/jz4760.c        | 32 ++---------
 sound/soc/codecs/jz4770.c        | 40 ++-----------
 sound/soc/codecs/rt715-sdca.c    |  8 ---
 sound/soc/codecs/rt715.c         |  8 ---
 sound/soc/codecs/sma1307.c       | 11 +---
 sound/soc/codecs/tas2562.c       | 14 +----
 sound/soc/codecs/wcd938x.c       |  9 +--
 sound/soc/codecs/wm9712.c        | 10 +---
 sound/soc/codecs/wm9713.c        | 10 +---
 sound/soc/codecs/wsa881x.c       |  9 +--
 14 files changed, 92 insertions(+), 235 deletions(-)

-- 
2.39.5


