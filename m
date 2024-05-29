Return-Path: <linux-kernel+bounces-194139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678F8D374E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B87D286437
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88CC1643D;
	Wed, 29 May 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UfUFM+XC"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE412E68;
	Wed, 29 May 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988473; cv=none; b=jAqJ+JsH4Qn5q/SGGj5l7E5apeL1JdXtoPFeXZDkjBEh3PQFf+cg6O+isP++OHRun7PbHDKi/pXq95tqzO3Ol7G6Ia5rcwgpr0czlF0Al3hCj4+MtJSTEkIarEsGk55JQMWQP2BYKUilB3Wj98ruSqRIydoY4XyMTp42KgLBT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988473; c=relaxed/simple;
	bh=aXqDgEPjwHMD2PFCnGHgOg/xjWQI0U5DZ7CMG6pHtco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0wph5ZSCffqMa3jhk1mxcUCsK9zg0n4hn03pXPzFzZ9YxJbA0la5tMfSTvI7iTPkRnN6GJhnGtgbHM9UQK5QHCV0o/CMtG8RsGEBYkUxAiv9UqyUG5G6RoIR/GRP20HO9MUNs6PK5KZ8XrpBHuwraSDqwM3GZZDQTSLXZEeehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UfUFM+XC; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TAvDa3027042;
	Wed, 29 May 2024 15:14:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	VDo9KLS5VfcqruiE4K9r2uLa3efLXIlw/R2YAL6iasM=; b=UfUFM+XCvJDFO6BE
	KoAa70vNmEdV7zg0eTL1VHWuD8wI+haTt+EuPRIFZ4bkARVeVopU0rtdrywlU9og
	FxGRalCk4vIVV6+yk0xlUuhG6EpDrim5Io2uR2D0eQSntxWsI3rz7fSkmC/nTdUK
	sS2mSVxQR2auQVDjesm9XmZgVtnYiE9TRbnJOhXAeZmVOdI2rUcJVR1jyVfUI7Ok
	UzQz0zL1+KLO+pwN+jpisTm+aMegeL1N1gTn9aG+g39+kNLSMiOxpL8uuCDyGrJH
	wDJxgIix7985DpghvyBbKuhyLWD3dtH2l3uk114eF71k3iZLHztp9S3eMq3+AMC9
	BjrhRQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ybtxhewrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 15:14:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BF89340044;
	Wed, 29 May 2024 15:14:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0089B21BF52;
	Wed, 29 May 2024 15:13:15 +0200 (CEST)
Received: from localhost (10.48.87.209) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 15:13:14 +0200
From: <gabriel.fernandez@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>,
        Dan Carpenter <dan.carpenter@linaro.or6g>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v2 3/3] arm64: dts: st: enable STM32 access controller for RCC
Date: Wed, 29 May 2024 15:13:10 +0200
Message-ID: <20240529131310.260954-4-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529131310.260954-1-gabriel.fernandez@foss.st.com>
References: <20240529131310.260954-1-gabriel.fernandez@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_10,2024-05-28_01,2024-05-17_01

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Use an STM32 access controller to filter the registration of clocks.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index dcd0656d67a8..602d02efc202 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -441,6 +441,7 @@ rcc: clock-controller@44200000 {
 				<&scmi_clk CK_SCMI_TIMG2>,
 				<&scmi_clk CK_SCMI_PLL3>,
 				<&clk_dsi_txbyte>;
+				access-controllers = <&rifsc 156>;
 		};
 
 		exti1: interrupt-controller@44220000 {
-- 
2.25.1


