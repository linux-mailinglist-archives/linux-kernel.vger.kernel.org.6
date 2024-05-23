Return-Path: <linux-kernel+bounces-187856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6755D8CD9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973061C21568
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF65C7E79F;
	Thu, 23 May 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NOfJKFwR"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37332F9F5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487550; cv=none; b=EIJsZ09IpMGtbSuZe4c8eRn1mlClvxu2U9F7e8UK2Ac85Y/EYctW6f1ANlb6N8wSdq0zcLT579lAZZC6eS1ff39D0b1QNolE6pkaZQn2/qmli8S0ibWDVrsSb0F3UwqWPpvv/KbCimjnNEE0aWrFMFF2fnNAS+HCmaC/CvdkVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487550; c=relaxed/simple;
	bh=KB8ZPj7qGCmYVVnyX8xsYlo2d1oCfPT81GQMWTChos8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSAH+dxIlZgLwfbXMm/tcYkm2ov+2eiyEV1KL9mqeCsc1EsM6d57FMxHbSKI9Rr32qbjbfCpmk2RUZvvZ7vLm6HQAO81TCq6Yp6fXDXTsdKV3bHSJxa9xbOIEVWyfbFKG3AWwqWzGeteHSeU754ktZvXc1YDMuR8F10oZeOSmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NOfJKFwR; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NHUP3x007181;
	Thu, 23 May 2024 20:05:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	8EXwyohCc219RSXlxVFLCGJqw0He7msBPhrXvYeZ5H8=; b=NOfJKFwRNV2bDNOg
	O83z0bJ2q0K8fgIORwY3cKRIrw18a4zhnCsT74MuNvCHGZDqn6NdDVv1hwQZMYsE
	zPHG+XWAvBIG8VVrrH42VnuJM0nUAij2g+6RxSHP5bA4WnUwjEiEgla5wFlhmQ7y
	f1pEXhviSV1JmSQYgqV9jAMoOl1K9JB0dtLBkKYCeokaiyepNzgV16afR1lqbfW2
	UBKWJ3N/fkSaXO7RJItQ+Md2cJ67nuscdvuRjzebsGi4PBnlYyajyGGt4jXpJKMd
	fIr0b7VejlN84KcpbZ7tOq30pv9Jy1qKtZLdMvv6nyOF4xgbdYZJ1SHs38msEBxm
	RbJwnA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yaa8t02cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 20:05:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0324B4002D;
	Thu, 23 May 2024 20:05:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A9A32232FEE;
	Thu, 23 May 2024 20:04:40 +0200 (CEST)
Received: from localhost (10.48.87.205) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 20:04:40 +0200
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
Subject: [PATCH v4 2/2] regulator: stm32-pwr: add support of STM32MP13
Date: Thu, 23 May 2024 20:04:34 +0200
Message-ID: <20240523200353.v4.2.I04ec53442753147c35efad1307b6ec133f53b471@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523180435.583257-1-patrick.delaunay@foss.st.com>
References: <20240523180435.583257-1-patrick.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_11,2024-05-23_01,2024-05-17_01

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


