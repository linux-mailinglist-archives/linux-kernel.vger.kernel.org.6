Return-Path: <linux-kernel+bounces-213336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6A49073EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52F91F22778
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C8E144D28;
	Thu, 13 Jun 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="N5W7o3YK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DF1448D8;
	Thu, 13 Jun 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285890; cv=none; b=rM/SkGkTDeITGiEE2JXMAvNI7HCJrHh5r8vhv75wexaqpvlxRpfX0w4fJN8Hr+mfUAmLHxOsXBzTVY7Vxy2Lu3A+iGKQrDeC+iXSEvOad0zBNIwH2ujNbvECWEARIUKcZ0OC7bjx5oeE4oXwcAF2vSVlCVB6jT3pZOEa+ooFYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285890; c=relaxed/simple;
	bh=UCBTzL1qL8X8ZCTfmKXBbLWhLhxnZdvEMzrhg4rYKu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENxtQui9muzbT58LEJjDBzHfS6QoZQCu+aTUo68Hy/ctno2WJmNDR+usWODzjXn48QKrAzTxnrojJs6cA8q9fQkaLNkEQvu/zcdmwCofNTvhjpGnY9SlVuBFYilsM0hD+gT/d2+SHZfv8h4VIv82TN1E1gZuB9CGARNIDP7k48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=N5W7o3YK; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D4lvcj009171;
	Thu, 13 Jun 2024 08:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=NPkea6m5QVm6o9Dai1C1bE9KqmhX1E2abI8TVNCkjFU=; b=
	N5W7o3YKnv7rWCg37rEQ5lfVydgjpNt4Pt4ncEuwNPDwn8wI9cn5FYpFGtUqoxsq
	XnAhys5+h1+TcV2+F4gDQBEsNKU0ZheuUwtypK6FwqOtP65XgH1XhDE5Cl+A2Qn8
	iad/YVlgfaFeIv7THEnvCJdUjYaJ+IN6fHFpz/7JA7sByiSZ4czgmpbEXzP3jnoa
	/BCth1D5PnQhuKeuRDZJm6yMCnALzdGRHByvEGRFdNYh1XfSmpbwD0IvPMsmzwCL
	yWinBIOslRsGkJuen+2RJ3V1NvVVLd/3D2mn1nQhQ4UJki2i7QhlaQ1SHyprwMBK
	UR1r+do0pA0GORXL2Ay28Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yqb8ehcdq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 08:38:00 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 14:37:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 13 Jun 2024 14:37:57 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.41])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id F01CB820248;
	Thu, 13 Jun 2024 13:37:56 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 3/3] ALSA: hda: tas2781: Component should be unbound before deconstruction
Date: Thu, 13 Jun 2024 14:37:13 +0100
Message-ID: <20240613133713.75550-4-simont@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: LhD2iKBj_iW7K0krGQz1Cvp1ZfsBMFx9
X-Proofpoint-GUID: LhD2iKBj_iW7K0krGQz1Cvp1ZfsBMFx9
X-Proofpoint-Spam-Reason: safe

The interface associated with the hda_component should be deactivated
before the driver is deconstructed during removal.

Fixes: 4e7914eb1dae ("ALSA: hda/tas2781: remove sound controls in unbind")
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


