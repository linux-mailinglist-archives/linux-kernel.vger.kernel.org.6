Return-Path: <linux-kernel+bounces-213338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8159073EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C98B28A083
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407BA145B2B;
	Thu, 13 Jun 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nbeDsZIQ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994D145B03;
	Thu, 13 Jun 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285895; cv=none; b=LgC6uA77DdMDYEeI9c9bGScjB6Z/Rt+pewxeh/XEtM97k2cZTRcVAaWcnN/5O3hc5MIXsv62tpMXE+5juo3AINdpuhsutl9F/xcaPQNKat3Y78YgqMm2PcNpGMq4jDAl1prO/U24zgBaDccvS17RoJqN0YA1Xl67YVR7be02WAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285895; c=relaxed/simple;
	bh=Rsa9LIJVLCfEEDfRcJqmUcTi+WPu7QmEWLsbETwevYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kc8DU5uC1oNY+JV3euTR2o2d+cvpCiWRJuFcnSVmoOZLj1SjePBwJMbADNOQyNvS0OBlwgz5TeGBG2GpR/dUywcWR5GddbOCa+2qes0tst6v9QI4xYtPSFbj8btNE6nnn8RTUJTSXf4rpCV0D/R35mauAnr07yfof8oM+kvVcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nbeDsZIQ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D4iWlr013712;
	Thu, 13 Jun 2024 08:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=S5+j64neUDQ+dJuwRMUcq1jrgKa4cIarmoNF4x/Fz/I=; b=
	nbeDsZIQddeRfaSxJnGNOMQlWBLcT4pfNOpyMaYtgwmEiMgnvwne4fLeeAb88rTT
	Dm+kr2BqXufz8MASwbYDF4m3AHgN34Vq2gt4wISw0VvmJyckS7J/MP0hgTyfo7BS
	Dvy27/prA0ApZB1wqlpVUQ9DXFAjK+BxXwFRZpJ+wmfH/HOQ/GIqmGSJ1+jKk9CU
	hDiDfEiLNyZ/WO6Cn1D5qtbHJdUOo6wJJzbRUvFwYvDqsqmLXuLCRSer11I7M4Vi
	kXRKjRbK8A36KDR/77YIhauP5QSRB9CLIFemY4ZTEM7pJpcbS1/2y2wt5ilpOiKP
	UN5ICaN3m2O5os433k864g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yqskgreva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 08:38:05 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 14:37:55 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 13 Jun 2024 14:37:55 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.41])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E4790820248;
	Thu, 13 Jun 2024 13:37:54 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 2/3] ALSA: hda: cs35l41: Component should be unbound before deconstruction
Date: Thu, 13 Jun 2024 14:37:12 +0100
Message-ID: <20240613133713.75550-3-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613133713.75550-1-simont@opensource.cirrus.com>
References: <20240613133713.75550-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZUQfwjpz7gjGbeVXX6N9VTg_IYKDCY5r
X-Proofpoint-ORIG-GUID: ZUQfwjpz7gjGbeVXX6N9VTg_IYKDCY5r
X-Proofpoint-Spam-Reason: safe

The interface associated with the hda_component should be deactivated
before the driver is deconstructed during removal.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d54d4d60b03e..031703f010be 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -2019,6 +2019,8 @@ void cs35l41_hda_remove(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
+	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
+
 	pm_runtime_get_sync(cs35l41->dev);
 	pm_runtime_dont_use_autosuspend(cs35l41->dev);
 	pm_runtime_disable(cs35l41->dev);
@@ -2026,8 +2028,6 @@ void cs35l41_hda_remove(struct device *dev)
 	if (cs35l41->halo_initialized)
 		cs35l41_remove_dsp(cs35l41);
 
-	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
-
 	acpi_dev_put(cs35l41->dacpi);
 
 	pm_runtime_put_noidle(cs35l41->dev);
-- 
2.34.1


