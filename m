Return-Path: <linux-kernel+bounces-198988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3E8D8025
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FA928A4C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F2185264;
	Mon,  3 Jun 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FfxWepnR"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003C82C6B;
	Mon,  3 Jun 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410951; cv=none; b=kT+HML8bC+x6+uuz4eYNcdOMnYeLhbeft67KAE2bNodoCsTkP5eZCdzz6AowSImibky1oNbWvtJ+4yfG6AKzbfdZH9RfZk1rpRTaJbF5udWblUUuXU9n6LwoR5deM0WPeBTGriYpOhRp1G18L3a3RHgGdxj5PDWchhbJMlGwEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410951; c=relaxed/simple;
	bh=L7mPsWE59fLvt2m/9tRf4t9eVGbAAWQn7bYALXOm/6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+fNQWxU4aYu0NTDgF9siaXS2r7Hx1tS5PoLfJkf5z4lBi5ktdLM+cSq88i2iX0h+YibzwwMoDe7CZ6AA6/umxu/BCRzo+3smFtKOsYM551DZJdUSSGFKblYhKw5A83MfjUnRg4dOOHMi5QWFolGsfdrXak3HPmEQE0AMS13zhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FfxWepnR; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4535l7pb018316;
	Mon, 3 Jun 2024 05:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=VxH3GmQdzZ7kvCvsSqTihyPEgS2wEiWRURtVFqWL3f8=; b=
	FfxWepnRYN8xgX7v/vrigGIb+xuDHa+B4dTc1PX45i5IJ3AZ3GSSlF8wfjTRsSWD
	Bbcbxj7kZcSMmRgauqwsK/dtWllGuuEL83GxHppWISvVRfYAI8+3J8flbOUAGsKh
	Tqtk4mQIIKfxnqfvHYI2sDP8YqNpuqsSPn8aPXDOowfIKAaAKsoZPjgdZ8DN6XKt
	PQdB26YD+rljvuttOeJJ8PPaR8A3eZVK08mkQ5Ir9Tjkj6KZ2i8bxc8DXdDaro59
	ViYouuarIPoDyvatN1YkHdxc+tThYFVSKM7mzRfnIb2ZVRh+invHNqf+D4z8RsYu
	GtaM3SYRz4pvmGhHs5CLTg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yg11xscbq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 05:35:30 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 11:35:27 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 3 Jun 2024 11:35:27 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.64.166])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 496AF82024A;
	Mon,  3 Jun 2024 10:35:27 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <kailang@realtek.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>
Subject: [PATCH 3/7] ALSA: hda/tas2781: Component should be unbound before deconstruction
Date: Mon, 3 Jun 2024 11:35:20 +0100
Message-ID: <20240603103524.32442-4-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603103524.32442-1-simont@opensource.cirrus.com>
References: <20240603103524.32442-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2_eWtm-DasY4CugLiLYehl-6UxDlDY-J
X-Proofpoint-ORIG-GUID: 2_eWtm-DasY4CugLiLYehl-6UxDlDY-J
X-Proofpoint-Spam-Reason: safe

The interface associated with the hda_component should be deactivated
before the driver is deconstructed during removal.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 75f7674c66ee..fdee6592c502 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -777,11 +777,11 @@ static void tas2781_hda_remove(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 
+	component_del(tas_hda->dev, &tas2781_hda_comp_ops);
+
 	pm_runtime_get_sync(tas_hda->dev);
 	pm_runtime_disable(tas_hda->dev);
 
-	component_del(tas_hda->dev, &tas2781_hda_comp_ops);
-
 	pm_runtime_put_noidle(tas_hda->dev);
 
 	tasdevice_remove(tas_hda->priv);
-- 
2.34.1


