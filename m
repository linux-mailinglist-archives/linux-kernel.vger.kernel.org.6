Return-Path: <linux-kernel+bounces-177427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018758C3E75
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07641F22375
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC42148FE7;
	Mon, 13 May 2024 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7vWJCs84"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B7148855
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594262; cv=none; b=OeibzzRZ/rhYt8EJ1L0z480dERi5IJ1x56suEVs8VLcUL2rhx+QawLZgn0nrMGS0Njs3mW6Faa2QrO8jdz8NIz7fKqYY+M6rrOaT/rmgmoFLB+PxL062DF5b/f6q6g/g+OYwNEZJDOD+1Rdh+gNdifzw/qrKaCmZe4ahb61Z58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594262; c=relaxed/simple;
	bh=KB8ZPj7qGCmYVVnyX8xsYlo2d1oCfPT81GQMWTChos8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBslzS2c8gCmX/B+B7YM0KHK4q8R79FCfe6Tm8FIylymP+031gr/BkRwrm5kJBRpT70s4FaxfTOxPs9TwqGRnWszqJUnaRh33byZDTLdsKPXXNotXcatUnZ7gOJLJ0TDo3qnp9SlX1HdZDJJzUErAyOVxid2DoNkGFx3vP62kJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7vWJCs84; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D43m4I008069;
	Mon, 13 May 2024 11:57:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=8EXwyohCc219RSXlxVFLCGJqw0He7msBPhrXvYeZ5H8=; b=7v
	WJCs84Ks5uBCCgePSuhzXlirtx41xQQBGc4teUPK4tmPNqdQDL0Uyzelac38cyGC
	iz0/g8LcVA5xrWhSLyNS65CLZ3YNP0ZTsmSSAti5ge2XP6UY8sQk/7XqujJuVNA3
	osnaY1ZASGkihz+BP2fJbthsjuDmQL3lMxGQoeZxFTLYisI8uOhS2xjBnJbjFIyH
	re3vZAYz+zFZV8r8gnjXxYrW5WvuHV/CaYgXSAFB9sKrLb4Qk4lUo3sb+O4fv0Dd
	3Sq21XoTMznu+BBdpyrxDF+uAsNOue9rmIVYSQkCAi7HheMid67tw8XgjEo1PQ0e
	QFTzqHPqV54tIYWBOM4A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y1y8n5sx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 11:57:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CB1564002D;
	Mon, 13 May 2024 11:57:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1A7F3216611;
	Mon, 13 May 2024 11:56:34 +0200 (CEST)
Received: from localhost (10.48.87.205) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 11:56:33 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: Marek Vasut <marex@denx.de>,
        Patrick Delaunay
	<patrick.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3 2/2] regulator: stm32-pwr: add support of STM32MP13
Date: Mon, 13 May 2024 11:56:05 +0200
Message-ID: <20240513115601.v3.2.I04ec53442753147c35efad1307b6ec133f53b471@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_06,2024-05-10_02,2023-05-22_02

Add support of the new compatible "st,stm32mp13-pwr-reg" for STM32MP13.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

(no changes since v2)

Changes in v2:
- Add new compatible for STM32MP13 and change title after Rob remarks
  V1: "ARM: st: use a correct pwr compatible for stm32mp15"

 drivers/regulator/stm32-pwr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 85b0102fb9b1..b7aeef6e09e7 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -166,6 +166,7 @@ static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 
 static const struct of_device_id __maybe_unused stm32_pwr_of_match[] = {
 	{ .compatible = "st,stm32mp1,pwr-reg", },
+	{ .compatible = "st,stm32mp13-pwr-reg", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_pwr_of_match);
-- 
2.25.1


