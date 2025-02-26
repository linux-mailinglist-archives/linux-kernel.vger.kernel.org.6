Return-Path: <linux-kernel+bounces-534287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE2A464FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5847A74F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D22288EA;
	Wed, 26 Feb 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PZmt1wci"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A6227E96;
	Wed, 26 Feb 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583932; cv=none; b=WDuq4coyX02IrnZSmqHG5FpQ/sa+8Z6QJG6p5GPPYFpGI+GHkODxFHzIN8AeLSUwRVFgg4ND9tDByTDkE3657uZnVr+bLHAv54mzPPzSdSZrUoynr8Y862Td2WYmJMiCHYdK5x4Vzx5zIzeimmDYEA5rPnzeJmwH9wKWWmxcsYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583932; c=relaxed/simple;
	bh=MRMeUL7IKxInvpqHogZOsMmXyScq23L2Z9S8jcNZdIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=COilm7FsyMTKsKtKolnMSmsBsr+FoiAvtjwd2RbSAI7bezSemvQv8bxcPxiFk5clyF0gKfWX+p/sKBRJTM5sDwwdsQJxtpkqJm+knayICk8HZbAVg92VVXnJ72wip0UOkU38xHfd1xAbJGqUyRY7mVgiQg58wgdqIlbnXle7mmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PZmt1wci; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFJEx2014247;
	Wed, 26 Feb 2025 09:31:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=0TVchcB8S7oS3cgf
	9539+fYVqlLWbKM98U84yK1Ovy8=; b=PZmt1wciOMOoWq+VI3b1800avihcBjPI
	sajS9QjH8xFSULuwvFxBWBfTHNrMIjm/sv1WVJmD2EOYQmjbmka1/A/kNaO9e/gy
	WwFO8ifZldGqgn24kY5Rd1JWNEBhIz4O0fhl36d0zOdpfby3iQIR+RQpoEy9AfMY
	tI1AczYmrzvgpxUFl5/4OQuI/Z3ghl6gWSxQcHAQyn8t+HJajkVdBYYaoIBLz/Ep
	76Fe0eZOHVUETueVwvyb1U6i0yy/OD+MbR/+fGXIj7T5RyDM9sXTlgQuYDDInoGN
	i7KZMVs32ZswyL4kHxnsdwD9pDurZMgT6ffQ5/imcDXj6/IDPEalfQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 451pt3hq9w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 09:31:40 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:31:37 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 15:31:37 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7A4F582025A;
	Wed, 26 Feb 2025 15:31:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 00/12] Tidy up ASoC VALUE control macros
Date: Wed, 26 Feb 2025 15:31:25 +0000
Message-ID: <20250226153137.2791938-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XrQAOUF9 c=1 sm=1 tr=0 ts=67bf33dc cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=42C1EwIAilJ0VyypoEUA:9
X-Proofpoint-ORIG-GUID: VDqWiPxJiuqEkAQnMg6X22D5zwcdOhtY
X-Proofpoint-GUID: VDqWiPxJiuqEkAQnMg6X22D5zwcdOhtY
X-Proofpoint-Spam-Reason: safe

Tidy up the ASoC control value macros. Fix some drivers that should be
using core macros that aren't, combine the existing core macros to be
a little more consistent in style, and update the core macros to use
each other where possible.

Thanks,
Charles

Charles Keepax (12):
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

 include/sound/soc-dapm.h         | 59 +++++++++-----------
 include/sound/soc.h              | 93 ++++++++++++--------------------
 sound/soc/atmel/tse850-pcm5142.c | 11 +---
 sound/soc/codecs/adau17x1.c      | 10 ++--
 sound/soc/codecs/jz4760.c        | 32 ++---------
 sound/soc/codecs/jz4770.c        | 40 +++-----------
 sound/soc/codecs/rt715-sdca.c    |  8 ---
 sound/soc/codecs/rt715.c         |  8 ---
 sound/soc/codecs/sma1307.c       | 11 ++--
 sound/soc/codecs/tas2562.c       | 14 ++---
 sound/soc/codecs/wcd938x.c       |  9 +---
 sound/soc/codecs/wm9712.c        | 10 ++--
 sound/soc/codecs/wm9713.c        | 10 ++--
 sound/soc/codecs/wsa881x.c       |  9 +---
 14 files changed, 92 insertions(+), 232 deletions(-)

-- 
2.39.5


