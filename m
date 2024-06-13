Return-Path: <linux-kernel+bounces-213337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FCB9073EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82431C22ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6F145A16;
	Thu, 13 Jun 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qJLSehwk"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555771459E0;
	Thu, 13 Jun 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285892; cv=none; b=JCbJ2ADPnv0plqYrbimrsmKY4SBdQ/E6dEzVB270B0+GbKWh1lwN5y//juZl7LrF5hQXQbkd5o106jrSVd1/E4GhUpfFIapsT0bHyCJYmT5nz4jOJD/CCiQAqqMS8JThIcn00EaVHZ8OYbtAxqg+18v6vG5WVrG9xZQWKqZF7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285892; c=relaxed/simple;
	bh=Lwy6HFEz39WeBa2VaGtb1Rv34jXLY5ZgoXJfpQDommo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0PpIS8aY4FdoMWO5grhsBDIPFw1z81bqMrZevYahOWDKu6Wmn43UOdWRU558WdD2KlQpAeYrtXnwTi0wq3xQWAit3U3mT660wkAniG5k7whmG4zf/9FoCejtcjAj6gHhCeqLtnGFnlBp6fqr98+XU4SAcv0ojrPnt2RAOqJDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qJLSehwk; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D4lvch009171;
	Thu, 13 Jun 2024 08:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=6WWYE9TVIgmEpxhrHtH2XIwJkHDI0lwDzKrfFPemTm8=; b=
	qJLSehwkz47lbcZBCQWJJ63jVsxpXmawzZ5loXD54jGvKLlFpNRZYkxnSWMQK4Bv
	SvC3lbsq9pT4xXkOGA0iY2ceDTMswQRwFqY+HJ4kwRQtz4UuHY45h08F1JnTgnlB
	x/HOGCoKI+oqMpCsCW7wzKnwQjiXfGWt7pkhqUMerxsGc7RjRtjA6PZtFdd3Mb63
	VJdiae4L3EVUE6UcNgptEacZAh/jbopJGd/ilmnTvdm2+qTrohJ8OM9VO1K0WUtt
	cEOd4khBPADt9j+RD5o3qmSoQPd5tlggoTQJ7oqcR0LuSGnZ85JpekX3YaOOcI1m
	cZKEv6OAIfdFIQ6yOfDakA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yqb8ehcdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 08:37:59 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 14:37:51 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 13 Jun 2024 14:37:51 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.41])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C2679820248;
	Thu, 13 Jun 2024 13:37:50 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 1/3] ALSA: hda: cs35l56: Component should be unbound before deconstruction
Date: Thu, 13 Jun 2024 14:37:11 +0100
Message-ID: <20240613133713.75550-2-simont@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: QbWChKkYjmEn4W1GZPSUCiQa5yDNTf3P
X-Proofpoint-GUID: QbWChKkYjmEn4W1GZPSUCiQa5yDNTf3P
X-Proofpoint-Spam-Reason: safe

The interface associated with the hda_component should be deactivated
before the driver is deconstructed during removal.

Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 0923e2589f5f..e134ede6c5aa 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -1077,12 +1077,12 @@ void cs35l56_hda_remove(struct device *dev)
 {
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
 
+	component_del(cs35l56->base.dev, &cs35l56_hda_comp_ops);
+
 	pm_runtime_dont_use_autosuspend(cs35l56->base.dev);
 	pm_runtime_get_sync(cs35l56->base.dev);
 	pm_runtime_disable(cs35l56->base.dev);
 
-	component_del(cs35l56->base.dev, &cs35l56_hda_comp_ops);
-
 	cs_dsp_remove(&cs35l56->cs_dsp);
 
 	kfree(cs35l56->system_name);
-- 
2.34.1


