Return-Path: <linux-kernel+bounces-196752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4438D6156
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02171F25726
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A3D1581FA;
	Fri, 31 May 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WTtiUWul"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17EE29A0;
	Fri, 31 May 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717157314; cv=none; b=TDVFxyn5xS3yLTUiYjnH6pWVr+6+Nl5gLbde8JdkYWyerUJKcQqvL/Ua4uAduGF8+l7OGVFMZA2DdVyRwOcYcN5PejZ880/sm7BEBufRXc/B4746nakuQP4pvwuLhOw2vN5M5PtQkVkv9V0l2NV1Zxl2tCNyLBSSos1QwuROhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717157314; c=relaxed/simple;
	bh=1k9t6jehRo7chIdZq9uoVU5h/rfm2SsMzqY7xyvvVbc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kiwyIHTQudoV4/haLqtHJ0GYJ8+DKPbCD6N8GpxxgB/eNBJECoprpOjgnQwRXN6jUT1Lzvkct4uMyy6OjlwFbpnBr2IY4dUO2BWlS7rTizUMfHjZp9KjAc9kIdTGRCOterFdATTGhTVnwuxv9HcWhIWLHf6v1Ib+bdPqwqrkoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WTtiUWul; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V9Swja003313;
	Fri, 31 May 2024 07:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=jojeGL9NyCQPAKin
	3J/C+KRxMKRG2M3M0NSuFuoQxSM=; b=WTtiUWul1jMchiPb35GkiMk6reG9QZuI
	48PSnH7FRwqA+ufeElYJFPPyAttpKcGEgJLi7YJy5Sx4Bm3dQCDkHkj6BjxebA23
	LvpHU6rrdtntXesH7YLoxoVTnJaUbPFe7wEfBjz9x7niJc2Yxaq/4p4FHd8Ava3Y
	qsEEuxDnQug6fRSZ7po6MhMwny4XNWqBtHgZET1NUhkjyFoe6Z5qrsjg5/vI4b7J
	xnftqLmiUCfAGXmQ/y//2xgH/MfbVrABHyVn0/7KRU4wrRN+GodFF5/G/yIS6mcJ
	xg0Pnl36qQboKIfahQkTgY4mxr9FDX8H2Sq4MByJg3+sxj+r+1gIMQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ybdcwwr9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 07:08:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 13:08:23 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 31 May 2024 13:08:23 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.72])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8B538820249;
	Fri, 31 May 2024 12:08:23 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l41: Possible null pointer dereference in cs35l41_hda_unbind()
Date: Fri, 31 May 2024 13:08:20 +0100
Message-ID: <20240531120820.35367-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kwle0reXsEGM8-ag8K8DUTPDf-O3TQxB
X-Proofpoint-ORIG-GUID: kwle0reXsEGM8-ag8K8DUTPDf-O3TQxB
X-Proofpoint-Spam-Reason: safe

The cs35l41_hda_unbind() function clears the hda_component entry
matching it's index and then dereferences the codec pointer held in the
first element of the hda_component array, this is an issue when the
device index was 0.

Instead use the codec pointer stashed in the cs35l41_hda structure as it
will still be valid.

Fixes: 7cf5ce66dfda ("ALSA: hda: cs35l41: Add device_link between HDA and cs35l41_hda")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 6c49e5c6cd20..d54d4d60b03e 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1495,7 +1495,7 @@ static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *
 	if (comps[cs35l41->index].dev == dev) {
 		memset(&comps[cs35l41->index], 0, sizeof(*comps));
 		sleep_flags = lock_system_sleep();
-		device_link_remove(&comps->codec->core.dev, cs35l41->dev);
+		device_link_remove(&cs35l41->codec->core.dev, cs35l41->dev);
 		unlock_system_sleep(sleep_flags);
 	}
 }
-- 
2.34.1


