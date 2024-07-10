Return-Path: <linux-kernel+bounces-247446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48992CF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A7A1F21741
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC2619755B;
	Wed, 10 Jul 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ig25FVnK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7940196D98;
	Wed, 10 Jul 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607812; cv=none; b=Jrr1D51lWJ8Jud8C4KG5/qc4r2gb5Go4atH1YfItZCfYXH+WyzazSaeXH1awDmhRY+2Kr99jFjOsJ7UDUMSImWIyL/PU4Pa7YQh5Z04AY8Xj+aG4hK0XGN6hTcWCAjURQ6755NObDCk9VvGolj9vqkeeC5hyQgR5eEOK96aFcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607812; c=relaxed/simple;
	bh=mHqoaOo6vsNTWza139+cMFxxRor+QUsYLvnzvaHB6dw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bw73ldisuY4sKPAxHHkX7e/YJyubRwaoX+wigyx6eF66IYptAQHJiqit6ThdTtOe/4SsY46uvxV2RDBJB99rKKSlMwcMOwlvfGYRPGGcoqIRtrLxyKwBwyQ0T2vcKpNtARLRLFTSY5HwPPIBcczd+jgD94AQShLf/6zPhWFhgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ig25FVnK; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4s4Gm006601;
	Wed, 10 Jul 2024 05:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=031IosrvEc4DNF6O
	PahvA9Nf6RargcvRdAHSyE4m7aE=; b=Ig25FVnKbYjrpbif4gv0NYTbcg4+tbPC
	U6YSBKYRcIyFK/BRu3Mb7Xf/tBPHyYF3D6uVF7LpDedy+p2xYFqy6gboaCwxqrn2
	rArgdpRiIZf565aL8YRbkTcNZTbyjdsrSfZeBxSMMgkbEu5YVwQ0u6WP2pMa+Asw
	WdN+dfsejKMtCh8yPVSR1zDMcyHswaTKUlIxdeO4QhD0a8yyW9mPYxg1oIGEMjJK
	CL4Jf1vvr2en4L8y+6Ls81anTp7xjY8k0Pmkg6UHI30N3VzcjiidGfkvkD5OZTH8
	9lRtnEh3iwQY0GP5ljHtWGI480UHBhv+Cr/ZS+buLvsgqbVZNc9C2g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 409c9a8h0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 05:36:42 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 11:36:40 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Jul 2024 11:36:40 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5C36A820244;
	Wed, 10 Jul 2024 10:36:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH v2 0/4] firmware: cs_dsp: Some small coding improvements
Date: Wed, 10 Jul 2024 11:36:36 +0100
Message-ID: <20240710103640.78197-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1I28NVJP8x8VC6P58Xs8YtvxDg7l40wl
X-Proofpoint-GUID: 1I28NVJP8x8VC6P58Xs8YtvxDg7l40wl
X-Proofpoint-Spam-Reason: safe

Commit series that makes some small improvements to code and the
kernel log messages.

---
Changes since V1:
- Replaced commit #3 with one that keeps the wmfw format version
  message on its own line instead of merging it into the INFO text
  message.
- Commit #4 rebased onto the new #3

Richard Fitzgerald (4):
  firmware: cs_dsp: Don't allocate temporary buffer for info text
  firmware: cs_dsp: Make wmfw and bin filename arguments const char *
  firmware: cs_dsp: Clarify wmfw format version log message
  firmware: cs_dsp: Rename fw_ver to wmfw_ver

 drivers/firmware/cirrus/cs_dsp.c       | 68 +++++++++-----------------
 include/linux/firmware/cirrus/cs_dsp.h | 10 ++--
 sound/soc/codecs/wm_adsp.c             |  2 +-
 3 files changed, 29 insertions(+), 51 deletions(-)

-- 
2.39.2


