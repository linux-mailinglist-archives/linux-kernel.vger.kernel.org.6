Return-Path: <linux-kernel+bounces-239169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834B5925776
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0641F26C23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA51422B1;
	Wed,  3 Jul 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lTnWTbo9"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A813F45B;
	Wed,  3 Jul 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000534; cv=none; b=npRV9Z9DBZj7tbtTnuNZ2GWCrYplg8LTacmP0yRMH2kFS8wLJluCGfJ+O3XJ+mka1EgBWq0NSr6jkWfYvXopSEu3SaRH8IRvtPZkZa/msZvn4IpDuATHHAZa88FRWO/xRsfm+34XA6Vl0yhQvWn66JrYfa9wnt6fiDUQd7PHcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000534; c=relaxed/simple;
	bh=MH4RcLU2Ew8c5WvQKy9K80s3b4in5J9rOvq2ovT09vk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OCxj6HaZolsfcJt/tlwZ1a5rKIxWVcExnboHtb+vbdFD3IrXsNpD6eXzj0QLXeDs2JOm2mQcW0fqU3P7E6g26kf/5cDpdJPCoPiTnzeJV6G+pSXY4zIczUbO8WQi5kePwrZIV+hKc8ul65cuQgVAUZruyJDlLjH4gtjFMRb93UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lTnWTbo9; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4636JLf5030004;
	Wed, 3 Jul 2024 04:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=7oWiVqhXfjhbUu+v
	MkJ6zhF4ivh4BhAtnUWD0CW582M=; b=lTnWTbo9wC0ILLcN2CesPxbgZ9AUsx5v
	cRMpPTtvD7vrdpbMF2+LqC130r+xuDHQn9CD10g5ON9sMLsEcF5unaH2bUoMpt7R
	JC+5W1jvLOiryqj+DvKdeVkGUBCq112CIxwhZ4Zy8Hux61OLG6R+J35akgq29KLm
	4iKwebyPxZklLgRAh+IgmUIGLnl+d37PGZ1C+rzo2KgmxkYp96le7cL13gu4aLMJ
	WwRx4sAOm/Lf9iw1O5Zc2szV/T/jpeEwTA7BGMy/o3pSPzKPTzoPSMvjUVEpITyu
	gGoTVW4Sh6tRglCnvv7AmYvcbGz2/laEIH6ICtkAsFCsX++DhjNXMg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 402fnxcq1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 04:55:20 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 10:55:18 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 3 Jul 2024 10:55:18 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E92AD820244;
	Wed,  3 Jul 2024 09:55:17 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: cs35l56: Set correct upper volume limit
Date: Wed, 3 Jul 2024 10:55:15 +0100
Message-ID: <20240703095517.208077-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bVRau-DgwfoTpCBdeRbG4rn1oi8FBUrq
X-Proofpoint-ORIG-GUID: bVRau-DgwfoTpCBdeRbG4rn1oi8FBUrq
X-Proofpoint-Spam-Reason: safe

These two commits set the upper limit of the Speaker Volume control
to +12dB instead of +100dB.

This should have been a simple 1-line change to the #define in the
header file, but only the HDA cs35l56 driver is using this define.
The ASoC cs35l56 driver was using hardcoded numbers instead of the
header defines.

So the first commit changes the ASoC driver to use the #defined
constants. The second commit corrects the value of the constant.

Richard Fitzgerald (2):
  ASoC: cs35l56: Use header defines for Speaker Volume control
    definition
  ASoC: cs35l56: Limit Speaker Volume to +12dB maximum

 include/sound/cs35l56.h    | 2 +-
 sound/soc/codecs/cs35l56.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.39.2


