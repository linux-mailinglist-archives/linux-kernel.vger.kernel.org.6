Return-Path: <linux-kernel+bounces-204315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05E48FE71A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48811F26444
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125A195F07;
	Thu,  6 Jun 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SkuJynWq"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F29195B34;
	Thu,  6 Jun 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679185; cv=none; b=HUzb98xLZzb0bO3Fi/kSTIhPdfAxQWxl6S97L/e5Y/6E6aCTI2lxHxgjze/Sr0o7YocfGfRAAra2nwcaWUsr8QzCQt3NnyKHk10RPDOApdjb6VZ+sT/PFWuFhEeLlv+WejmeDEuWGUVFrFi5i1fh1fl8leBQX27/e/zZE4dM7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679185; c=relaxed/simple;
	bh=vzv7fzOnv1xAOkXEu4BYsIBQKuKerxMCA5GOWF98fJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=papWcw7ET7fS9tAvnfjsAtnf+9JNyT8Uz2eCdK89Y/PmsvFIXDbxoGACI6xLlRql/uF10LWVwb+cjMQNzaln7/pWC3+L8nvEIHuJtANvpEL7Fj1E0Z1OboiM4V6pbFQFfRWvmfMDXYN9BK3Xjij8T6XooIZlhEa6wtpYLTw55EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SkuJynWq; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4565uen8010646;
	Thu, 6 Jun 2024 08:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=F233C1P+w3bhjzR7UkxNmcjydh72Lcx37IOjcnR3h0I=; b=
	SkuJynWqWhsxDXzzHDm2JN3JZOItxD8SoseiTV+S93kJ/Iu0Rnp/R4VjP1nW9Jyu
	4YHriI13KnmHIXNG0bWk+Uwe5G8H0JV0toxheSy5CpOvb21TvsfXl3Bs0Rz2Aco9
	xCnQV2reTZYhDYu9n3ycEPS+1BXX76AR2Hci2S6X0PzHG7mBj7dCYvXpTdgpvpL5
	8xQvMdbI8WTMSEIFTOEegmFTrCDe5DhCZTVPH25FHGO4WRFD+BY6hkpP7DhEycDv
	HG+BCOs5M4I/0bKQIEvtYBiv06Vs3X3z4OxkedYsrIugdljGfSBxk72iqlSO9TXz
	8IpFPwnk4J6AxoRE7+4ZbQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yg11xw66m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 08:04:05 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 14:03:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 6 Jun 2024 14:03:57 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.44])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id F40A6820259;
	Thu,  6 Jun 2024 13:03:56 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/4] ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P Gen 5
Date: Thu, 6 Jun 2024 14:03:48 +0100
Message-ID: <20240606130351.333495-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606130351.333495-1-sbinding@opensource.cirrus.com>
References: <20240606130351.333495-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BN6R2ycMVBwHtGE8ytKA-ESAw3kbfeL7
X-Proofpoint-ORIG-GUID: BN6R2ycMVBwHtGE8ytKA-ESAw3kbfeL7
X-Proofpoint-Spam-Reason: safe

This laptop does not contain _DSD so needs to be supported using the
configuration table.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 6a7a6d486916..046a94250683 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -128,6 +128,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B7", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38F9", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
+	{ "17AA38FA", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{}
 };
 
@@ -529,6 +531,8 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "17AA38B5", generic_dsd_config },
 	{ "CSC3551", "17AA38B6", generic_dsd_config },
 	{ "CSC3551", "17AA38B7", generic_dsd_config },
+	{ "CSC3551", "17AA38F9", generic_dsd_config },
+	{ "CSC3551", "17AA38FA", generic_dsd_config },
 	{}
 };
 
-- 
2.34.1


