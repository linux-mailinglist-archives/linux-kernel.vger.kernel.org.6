Return-Path: <linux-kernel+bounces-544334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E7A4E028
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCED1766CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601A204C35;
	Tue,  4 Mar 2025 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QlpmWMyK"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01624204F65;
	Tue,  4 Mar 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097138; cv=none; b=rJWzLhodLf3qm47mBRY1MQxZ8CdjIRNzagjsRZL5S2sNreB+ESqG8Ktv9j/ySG8jwbLxFuqEcIGJsuLhIyxyBcKsQhuvVTe/QL03jvNHbuWW6CTlOr7UymqRKSSK8o7MhGuAi7cad74FgLJwF8x6dK4rW5jeACIuMNIKtMtbAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097138; c=relaxed/simple;
	bh=zE+d/+YbMn+E1MaNQHNyEjFzrPqRPonzhnB+jFeyXPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ikwQP6nUtCJRI5uxG/4xFuwtty4C+HUoFJU1rEYORMIwqKa91Q5nILizb8qXi9BMmQjPteW+9GTblWiNUNNrKe+Xim2/YB7q+1HWA1F3FI7bcEMxaYJnMdRNUnvTAQsAlV9/tzAa4nkVaFdUdIMn2H2vg5lh8GybBBgYCiwr/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QlpmWMyK; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HMu003809;
	Tue, 4 Mar 2025 08:05:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=KtwMozvYxMFAOFnL
	cAT1vAz7BXbWszWHx8Ha3yEd45w=; b=QlpmWMyKYbe+qRgWf8TlRR3/6e3JzXKE
	J0u9TzijbmVh9BYEZRb6soXN9g3GwSBs+Xadr/C+p/gNeOljgrEt9s6BqyPbMGZE
	AcAhnquRO+gAHUv9HUTW3gYpVBOwB/gnBzoB9hVPaPCPp8y0g+4Do9f/GtfB70Dp
	w4MvfeSuMvxogwDTtNOWTQW+B9O1pV4nyJb/doYpkLta+GKVhL+E5aC2PigVQ6Q5
	MnZYPGo22arcmtIJsZKVKuVKOm6dqiZOpBC5CIkZs7qg+InS3cLbgZkEq1I10chL
	kd/aaidR2y78D7cNjvC2+PTLNj+KWujOVrl1S9U3GltoQVb4qMvwDw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:15 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1DFBB820248;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 00/13] Tidy up ASoC VALUE control macros
Date: Tue, 4 Mar 2025 14:04:47 +0000
Message-ID: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OShuCjXSsmqIw-mee-f4leNhwL7W7MBR
X-Proofpoint-ORIG-GUID: OShuCjXSsmqIw-mee-f4leNhwL7W7MBR
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c7089d cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=pzkeEdGVe-7zqstrry8A:9
X-Proofpoint-Spam-Reason: safe

Tidy up the ASoC control value macros. Fix some drivers that should be
using core macros that aren't, combine the existing core macros to be
a little more consistent in style, and update the core macros to use
each other where possible.

Change since v2:
 - Fix typo in SOC_DOUBLE_RANGE_TLV refactor

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


