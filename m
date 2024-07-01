Return-Path: <linux-kernel+bounces-236054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 750A091DCEF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0DD1F219EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770D12EBD3;
	Mon,  1 Jul 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="S6BoX666"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB784A50;
	Mon,  1 Jul 2024 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830705; cv=none; b=r4NHBtTXUEouePTb+J2sMGCEqAEuGtJijQPPP+9NRKgX4niGM5y7+BfqjsivbdP62dhWRcaKxnrto58L9wfENIWYfwFRrduv1LRNIZh5ad4k7t6Vt3ZdKE0oqEnv+xhHmY1b2IkN25RS9AxfJUzr7hD3Om9+kSRxNttRky3L1f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830705; c=relaxed/simple;
	bh=UpSxcVPntx3n4vMZc8ID9H1olcCZrFJBh6e8CLNr8Mw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uDhw9pn+xWTGI0o3SHkCrlOGirkOPm7eFhLQqavKD1ophNv7rloqt16xlRjlDlWNgBHIIeuUf76UVzxO/ibF/AMa7IP+BnW3Bm31WSWMvZ0k7Lc4/jP0UUvbPUHojzyEYCQjD2BH0xyy8hy1pJnLEV05ILZwiOJXQygfJ3ZmPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=S6BoX666; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4614mX4v015862;
	Mon, 1 Jul 2024 05:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=/wiHC4oaRURJNsaa
	FyjCYv+VT+J39EVgcOXEImnRR80=; b=S6BoX666plhomGfCM+GfiN0XGolBVTF9
	agH0/Pi2/NzUs45k//iiXPLfQNTitja7I6tVVOQ7XhzbKPsngWfm6EkpILH97Shs
	XhG8DTGxsbViO6XNNu/dV3kYSbU9JLQYPcqG7geJekxmQHIXzM+yNsjNK+931Ux1
	L6aWKRm6lVzlFl//W5hkEsloFIBmUr6462s7jh4Qv+IJ2dqm60xS5HKLnW14/NuX
	rUpS8QZAKODDJcv7xmGBw6/8ombqDlzbG2v5bu19ufFYW9p1CTsshZNdFrmIATjK
	y9OU8dZ3Lo72/1SMw5wsGlNkqLLN18JVaQdBApk6C3REh96WgfliMw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 402epjabpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 05:44:46 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 11:44:44 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 1 Jul 2024 11:44:44 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 92958820244;
	Mon,  1 Jul 2024 10:44:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 0/3] ASoC: cs35l56: Remove obsolete and redundant code
Date: Mon, 1 Jul 2024 11:44:41 +0100
Message-ID: <20240701104444.172556-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bOUPjYsMgHFBb0XazBy7dUpeROiiir_0
X-Proofpoint-ORIG-GUID: bOUPjYsMgHFBb0XazBy7dUpeROiiir_0
X-Proofpoint-Spam-Reason: safe

These commits remove various code that is either no longer needed,
or is redundant.

Richard Fitzgerald (3):
  ASoC: cs35l56: Revert support for dual-ownership of ASP registers
  ASoC: cs35l56: Remove support for A1 silicon
  ASoC: cs35l56: Remove redundant clearing of clk_stop_mode1

 include/sound/cs35l56.h           |  11 +-
 sound/soc/codecs/cs35l56-sdw.c    |  75 -----------
 sound/soc/codecs/cs35l56-shared.c | 122 ++++--------------
 sound/soc/codecs/cs35l56.c        | 205 ++----------------------------
 sound/soc/codecs/cs35l56.h        |   2 -
 5 files changed, 45 insertions(+), 370 deletions(-)

-- 
2.39.2


