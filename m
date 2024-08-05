Return-Path: <linux-kernel+bounces-274595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52894947A87
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842601C211E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0E155C93;
	Mon,  5 Aug 2024 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hIw9WVBM"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611318AED;
	Mon,  5 Aug 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858153; cv=none; b=Qk/1wQeInv1KTHeNkjuOY06Ik/KrK/X0X1X2I74tL/qFORGElZ8HOVOUSCiHOkqkDDOWzjRGbE9cUK0hQaTnEwCx6D8c+d6J2I07hEpylIVnAIBKshK0hWPcv2jjJgzEKSmh6M9w4NELSeeY0cvC8EppALlgLKJXebf8YQwx1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858153; c=relaxed/simple;
	bh=4z0M2R4JiJ+SyDB7UbcEAi664qo4Fec6Ap+2AtStB2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QZoCWZyp9awrREnYr7gFjvggncPvITPREu//FvX9hiyJO7N88E5dEyR/1sB9xr2W45GtMkyBumdJBV7j8TsHqO8z7kQRjFHy8nIwrSmfMgAFhx44mnVq7QIuoyEQMKwz1V3IULDM6KphAw7Kmeq8/EgSUsPg1qpbpsYz5wCzfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hIw9WVBM; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4755ACwi003089;
	Mon, 5 Aug 2024 06:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=yNYvzNs1aoTggef5
	QXmM6n7pU7FE+xHnqi8tCUb8CsU=; b=hIw9WVBMISaOlWux73eKqNJF8/Yzoq5p
	SJNtTPI3eZhvx6peihBEekjwFJrEDK49WolVs/60n4RQJqI/EALpLGjRnuYW5qUo
	XWkx2N3NffX4fHVFvnm8qIFOfE56bT/u4ECtl4CL9avkhr3+qn3yJGXMLDxUhOFv
	Fj4ly+dZNYChnxbBlcx8ukCGX+RqAq3q9suD532Bro+URY0amDc5zXpIGOfvL8v2
	j6eNu69IfoDfTCkpUOFnhk/CarlFWgbJrQvPIbz9mcTEBIsgNlpU6KX2zYSFXuxc
	dsXFABPMqvS3PQbqqNLKdrv7lkXxh1TQku6T48p6wjLxtYTSJeDLCA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40sgyhspje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 06:42:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 12:42:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 5 Aug 2024 12:42:25 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.170])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 14E50820244;
	Mon,  5 Aug 2024 11:42:25 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs-amp-lib: Fix NULL pointer crash if efi.get_variable is NULL
Date: Mon, 5 Aug 2024 12:42:22 +0100
Message-ID: <20240805114222.15722-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YsvfqrW8OBPHoRA9i9afmOYlXCNcGWZg
X-Proofpoint-GUID: YsvfqrW8OBPHoRA9i9afmOYlXCNcGWZg
X-Proofpoint-Spam-Reason: safe

Call efi_rt_services_supported() to check that efi.get_variable exists
before calling it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 1cad8725f2b9 ("ASoC: cs-amp-lib: Add helpers for factory calibration data")
---
 sound/soc/codecs/cs-amp-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 287ac01a3873..605964af8afa 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -108,7 +108,7 @@ static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
 
 	KUNIT_STATIC_STUB_REDIRECT(cs_amp_get_efi_variable, name, guid, size, buf);
 
-	if (IS_ENABLED(CONFIG_EFI))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
 		return efi.get_variable(name, guid, &attr, size, buf);
 
 	return EFI_NOT_FOUND;
-- 
2.39.2


