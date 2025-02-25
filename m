Return-Path: <linux-kernel+bounces-531446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43940A4409F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7013B04DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CEF26989F;
	Tue, 25 Feb 2025 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PQ6t27+J"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F726981C;
	Tue, 25 Feb 2025 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489540; cv=none; b=rWuIc999DjGtKawcvVHPD9QcwXl0q8cs1b0N21qiMK+cTeq3g2ZrR4lCEM86+GdR4mZb7EpHTZSCKA8W+rLSHsghAgG40ImZCSlLewpodQs08a9NdOUOie/TgL06kM8b5aTnliVpxwv/yxnCypnzWcagmYMdvpDN4V7cx6GiePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489540; c=relaxed/simple;
	bh=3Br8De3rsbk5eXKIjNmSvdHO8Uz1uZyZg2mMvLBwt5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqtJRLKgQ9URON6iWbqhNPhziB1vmtGPWg8CY8SXFQquxBakJJskMmZSJVUYT56etIByGAvmI1O8aZBYf3n2knpQltz2wnXXmRPv+g9PbK/igRtKCbJkbkCNJfVecLouZ3vlV2vtrg6XJfLT7b1s5CKX1ULnXtCcUz1fVVzJ3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PQ6t27+J; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P4j5jJ001538;
	Tue, 25 Feb 2025 07:18:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=icybtQtm8VTLJVPt
	AfJ8hZ7tG9SIv3LwIg71SMmRhM8=; b=PQ6t27+J8rJd2k8VbOw4CR62VkBGaNaj
	wD3SLPYg3Y1Ptkj0fFRWQGSx8jOuNm3cEdwlpJtOamtVPkdNh1S/ZkTWzqxg+8Kr
	1sZ4Fz9GNvgaPPgiKIrGDYC7MazXr+vDgYGHRE0IFdqpbjZ8sHlah19G5AfeAMEk
	84jmiIjY1726LmozPiqXj5SNfjXkRUTuk12SNRhTqxIKa+UBKiVOlxDtv2DfMs+p
	VxAEHMIPipYxQci5mrSBmVUDOsyREYj/EgjojhyBml4PsiNZSDdqnuD0oOm1YdRC
	M2Skag3mNgR4Y9Ch1ZLagpVxbSolfEZK/qWi6uA+oWtc1k7v01IPmg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44ycv5ptdu-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:18:47 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 13:18:43 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 13:18:43 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 43F6682025A;
	Tue, 25 Feb 2025 13:18:43 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 0/2] ALSA: cs35l56: Fix for races when soft-resetting on SPI
Date: Tue, 25 Feb 2025 13:18:41 +0000
Message-ID: <20250225131843.113752-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HoqMG1TS c=1 sm=1 tr=0 ts=67bdc337 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=oBivd6-D-XcVIxPnMd4A:9
X-Proofpoint-GUID: OVvdlIHVe5Z_bjjltr5ErmOuOVfJK4kO
X-Proofpoint-ORIG-GUID: OVvdlIHVe5Z_bjjltr5ErmOuOVfJK4kO
X-Proofpoint-Spam-Reason: safe

These two patches fix a race condition between driver and amp when issuing
a soft-reset over SPI. The main problem with the race is that the driver
could read the amp status as fully booted, when in fact the amp is about
to reset or is in the process of resetting.

This is mainly contained within the ASoC driver code but a small change is
needed to the HDA driver.

The first patch, to cs_dsp, is to remove async regmap writes so that the
cs35l56 driver can call spi_bus_lock() without breaking firmware download to
other amps on the same SPI bus.

Richard Fitzgerald (2):
  firmware: cs_dsp: Remove async regmap writes
  ASoC: cs35l56: Prevent races when soft-resetting using SPI control

 drivers/firmware/cirrus/cs_dsp.c  | 24 +++-------
 include/sound/cs35l56.h           | 31 ++++++++++++
 sound/pci/hda/cs35l56_hda_spi.c   |  3 ++
 sound/soc/codecs/cs35l56-shared.c | 80 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56-spi.c    |  3 ++
 5 files changed, 123 insertions(+), 18 deletions(-)

-- 
2.39.5


