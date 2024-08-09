Return-Path: <linux-kernel+bounces-280669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E494CD82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3090CB21946
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1857819148D;
	Fri,  9 Aug 2024 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KOqyTCFz"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BFA17BBF;
	Fri,  9 Aug 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196742; cv=none; b=onlsZ/niOaNQkqDIzLAZJSpEAgoOo80qyY8qifGZB+elSAFHkXQ8cryA6U60rR+p5JP+xOLlNG9OdXyCXdQ7cUmhUxE9bLzyZ0bthdG99ay9UKJi2j2j8/TWQty3mQ2e+fU66TX9aEocdOItTUTBmx+akP47Rr3k3QFKGfZHFEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196742; c=relaxed/simple;
	bh=w8T7lsApA6svrAuvtshNa9LeKFflqUAghoIsAdOaPks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lVUwaJYBYLWLqE7x1VWxThZNRbzqliThZ2MG6U8OCiTpBRK10hAcl0sn8tPm1io+sCWskFY2k82wq2IlBDCI4ML9t30VnBVdyoMjBs4F6uXCq6wn7lEAmSAX9sMu/FQLnaYq7L/ALEr9PmvgFKTWIV2NrnrWot/rMvajJ7rLK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=KOqyTCFz; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4795uS42022095;
	Fri, 9 Aug 2024 04:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=ABji5ez8kAW4QaXe
	rx8aq3yBKVa5LoFmQeD5LuEz/cA=; b=KOqyTCFz8DqqHLuANoluYE3NwKl6uMpG
	scc7sJETo4DTKp0ffEjCk0623paPpDnDMzDzOqvm4wMrnUxkh9y3OGHYmzxfbkZF
	D+hHzZmV86VJfEU2PblJW2qyWjkU0eQLS4RKjecJed/Fsd9ICcEl5FjZrqJSTVSc
	wWx/p57Gi/OWXIa5mAOBPmwHYWFyCFuD4TU9VxTHF4yqWAhdJydKi3cl0IqoK379
	lu0yLhZhdlffIxAEcqulee1WysBAuTddBcVqLvWx0ovDnll3RPoiQDVj0pQRWIBL
	G3NrT3oTIe7+r7OxElSRuAVrYzKPS0YVHUPdBG8wajtEqTq4HTwhuw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40vu8q1c7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 04:45:33 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 10:45:31 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 9 Aug 2024 10:45:30 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.170])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A44AD820241;
	Fri,  9 Aug 2024 09:45:30 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Remove calls to cs35l56_force_sync_asp1_registers_from_cache()
Date: Fri, 9 Aug 2024 10:45:27 +0100
Message-ID: <20240809094527.10229-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: j1P5eSj0YF2dE3AQEA08SykUh20_haVo
X-Proofpoint-GUID: j1P5eSj0YF2dE3AQEA08SykUh20_haVo
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Commit 5d7e328e20b3 ("ASoC: cs35l56: Revert support for dual-ownership
of ASP registers")
replaced cs35l56_force_sync_asp1_registers_from_cache() with a dummy
implementation so that the HDA driver would continue to build.

Remove the calls from HDA so that the stub function can be removed.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 96d3f13c5abf..bbfd68a572bf 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -151,10 +151,6 @@ static int cs35l56_hda_runtime_resume(struct device *dev)
 		}
 	}
 
-	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
@@ -1095,9 +1091,6 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 
 	regmap_multi_reg_write(cs35l56->base.regmap, cs35l56_hda_dai_config,
 			       ARRAY_SIZE(cs35l56_hda_dai_config));
-	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
-	if (ret)
-		goto dsp_err;
 
 	/*
 	 * By default only enable one ASP1TXn, where n=amplifier index,
@@ -1123,7 +1116,6 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 
 pm_err:
 	pm_runtime_disable(cs35l56->base.dev);
-dsp_err:
 	cs_dsp_remove(&cs35l56->cs_dsp);
 err:
 	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
-- 
2.39.2


