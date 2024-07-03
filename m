Return-Path: <linux-kernel+bounces-239171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FA2925778
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672E3288180
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431441428E5;
	Wed,  3 Jul 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ujd4dAyD"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9C1411E0;
	Wed,  3 Jul 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000535; cv=none; b=ALVm1nEB5vkA49JCAp1x1vp1Eq6/6Zo7G7p4xjcpRhHc2Zr4G3nvd/t+fi90rP8Xu0NEodO8Z6KbDiVYVPhKTmadQKgCEiaxcOoLIHzIWL+MOVQxbd+nWyzWXYn8U5CI2VPelq+MGSDicUcY131A8oQVrIFEi2mPWbGiEK2ws2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000535; c=relaxed/simple;
	bh=K6avlmTj3HXl3IF6sXdRJdTatC9czwwt3hrIqh+w2HI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCwSKl44Ubx3Lih+tb2LBzMUwSwDo8hxt+DPRoMsiX/zvOU3oeXtagCNmgXyxOQ71M6CvaPehCYnlsfPEb4qT9RGZLZZV9LhnccDoAX4lGFkoyEoKLQZ5Uo7rMHSDvzvVCf/x04nOaCezf/Neu8vjjKKziHZP0F56/AD/e72xA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ujd4dAyD; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4637xDTS029630;
	Wed, 3 Jul 2024 04:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=xLpfh/EOvOaZoS9SdFgCbMXsXkOpWChOWYb38JS95bs=; b=
	Ujd4dAyDI9H+3Y8Db+2hORYUGz1hd/ZEpKnrvR5G/3YxJt/Qljt4FwvyVuXsGvRc
	8VncN2naq8Fv7kW3WUy5VP3gpQiq5Zbzexrn9pD+cEuia+STmAyJroFfuZy1Bk6R
	yxX1m6jQbnf1Wiql5RQCvpIXVuQqVM3OlSME7nzeQjq+6cjh/0rhpBW7TitllbRj
	HLO74ow6P2XKsaS/8mZ+ADa87Wbop/7fm3JNaN9srPhqcFeEVJRaQ+vRWTL9Ys0k
	W4WMBH/3UQDlFRCz4InQa+yLB54sXLWkBa/aIBtoHlJHZ7C5wA2WWeS062dvQ5AE
	0Ikj8LvNEOrJCEwGnh+vdQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 402fnxcq1c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 04:55:21 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 10:55:18 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 3 Jul 2024 10:55:18 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0F55E820257;
	Wed,  3 Jul 2024 09:55:18 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: cs35l56: Limit Speaker Volume to +12dB maximum
Date: Wed, 3 Jul 2024 10:55:17 +0100
Message-ID: <20240703095517.208077-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703095517.208077-1-rf@opensource.cirrus.com>
References: <20240703095517.208077-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: w2kT3kpPaJmcpFSN0gZf-kdSIybRhFLH
X-Proofpoint-ORIG-GUID: w2kT3kpPaJmcpFSN0gZf-kdSIybRhFLH
X-Proofpoint-Spam-Reason: safe

Change CS35L56_MAIN_RENDER_USER_VOLUME_MAX to 48, to limit the maximum
value of the Speaker Volume control to +12dB. The minimum value is
unchanged so that the default 0dB has the same integer control value.

The original maximum of 400 (+100dB) was the largest value that can be
mathematically handled by the DSP. The actual maximum amplification is
+12dB.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 642ef690ebc2..a6aa112e5741 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -207,7 +207,7 @@
 
 /* CS35L56_MAIN_RENDER_USER_VOLUME */
 #define CS35L56_MAIN_RENDER_USER_VOLUME_MIN		-400
-#define CS35L56_MAIN_RENDER_USER_VOLUME_MAX		400
+#define CS35L56_MAIN_RENDER_USER_VOLUME_MAX		48
 #define CS35L56_MAIN_RENDER_USER_VOLUME_MASK		0x0000FFC0
 #define CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT		6
 #define CS35L56_MAIN_RENDER_USER_VOLUME_SIGNBIT		9
-- 
2.39.2


