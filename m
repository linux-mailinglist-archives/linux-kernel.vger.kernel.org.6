Return-Path: <linux-kernel+bounces-558202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFCA5E2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852093BD10B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6398225A349;
	Wed, 12 Mar 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NaswTpnV"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652925A344;
	Wed, 12 Mar 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800160; cv=none; b=mn7Tccx5ZaUxFpAzsTdtUT7ikvLvarSrvFOcmeMavFkiRltxFFqgvYpFNAzyuQmISvM651RiCKXUFBVQlPRIMfnjFLUleKAqaujnFMtN+yVIkQZe2M4/QE3TzKaO7i61NKt0z23XQ8bgSv2gFPHMjafzNwHAdkreNDoxnowW8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800160; c=relaxed/simple;
	bh=aUB4p2r9VziNMv+6tU2P16USbB/VJKpNkg9Tjn63oKM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PNcrB9lvHzSV93UVH+ehk6lGI06Xl8xuXs5EPsyVW+hV0uwW6QQlORb1nSoQO9x+Dw0Tn/58eVHPT2abctAtxG+Bf1twVQMyXrcvYQDYMqqXpbT5xPxm8hXtWw7EK+qtz6sZt2Ly4Wtz+evK5ZYacqarHB8IOGiS7WDTdyGe5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NaswTpnV; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C5qIHp028516;
	Wed, 12 Mar 2025 12:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=QZ1oYCH7dmhOAMgu
	JmG1oiUWYqdqMU0cpXZvSNc0130=; b=NaswTpnVYy2DocZdJOb0+YPv8E6gXSFX
	+p40RLbb+U0yqCaE615hnfhTBACsY5D5QbVU5i6Z68zp15pUW451Yl2s/1RLJYtI
	Q99WByz93c94RlDTeMJN4PdycW5lWam8BEJI0Im5iRdgR7to5wMsdm2WpGxVV0Qc
	LToCKono9yChejKEm1BaGlAbHgyIplUDNn61uhkAEpSWl35+cbue34b8M4v/cGor
	fnXQSXhrhHIyZRXTHY3FQuGVCZcs2wrUliXVK9qzmH8YFn7RrSWENkX7CibMBxPj
	oQwK9oEaMrQSFKQ98vP63YQNUY5lde6+gJfvwR8ZAklZhfUI2A6wHg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45au85tfdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 12:22:08 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 17:22:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 17:22:05 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 14EF182255A;
	Wed, 12 Mar 2025 17:22:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <pierre-louis.bossart@linux.dev>,
        <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 0/6] Some minor SDCA preparation
Date: Wed, 12 Mar 2025 17:21:59 +0000
Message-ID: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: smmi5pFfKkLVO0H943xScw7D-p-wfbn-
X-Proofpoint-GUID: smmi5pFfKkLVO0H943xScw7D-p-wfbn-
X-Authority-Analysis: v=2.4 cv=fv/cZE4f c=1 sm=1 tr=0 ts=67d1c2c0 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=eUhnBPTwBiYOtZLqkKQA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Reason: safe

Make some small fixups and add some minor missing features that will be
needed for the next major part of the SDCA work. This series doesn't do
a lot on its own, but as the next series will add all the ALSA control
and DAPM graph creation it's probably best to get these minor things out
of the way to simplify review on the bigger stuff.

Thanks,
Charles

Charles Keepax (6):
  ASoC: SDCA: Tidy up initialization write parsing
  ASoC: SDCA: Use __free() to manage local buffers
  ASoC: SDCA: Allow naming of imp def controls
  ASoC: SDCA: Add type flag for Controls
  ASoC: SDCA: Add SDCA Control Range data access helper
  ASoC: SDCA: Add support for GE Entity properties

 include/sound/sdca_function.h   |  90 ++++++++
 sound/soc/sdca/sdca_functions.c | 374 ++++++++++++++++++++++++++++----
 2 files changed, 422 insertions(+), 42 deletions(-)

-- 
2.39.5


