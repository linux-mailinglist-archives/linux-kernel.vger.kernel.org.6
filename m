Return-Path: <linux-kernel+bounces-181234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFFB8C7959
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BF8B214C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A9514D430;
	Thu, 16 May 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HA6G7zpz"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D814B97D;
	Thu, 16 May 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873170; cv=none; b=F3OtpL1KiEb70YvGGI+kCHBY7a04bEmzY/z9ghrz2VMPjFUdY+LFAyxB/mKwtOKRWeUTu8WcjjFf3u7pDLNIFhrdgo/NRQqvuMhaOi9cRgPQYXpagTBxvY2C+h7XtmMsA2cCOKmBpMjFQUFAgrfiAO1wy5hlsxs49/2FCYdz/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873170; c=relaxed/simple;
	bh=s+kzo1mIt5kdmhmpjxm0dPVNjA4/CEZktTwadgjJf3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nlxnx7eLSzdwGctqiCZmlas+ELQrCWo9yJk3ki6W51GFLSq3rCaEyrM3qqYD6vpunJTGhqVrzv/IsDkJ/GNeQipp5Jt7YkKr4NbHl885DWNzC0EC3dk11Ctz55Pm+wu/64Pra3G5nBv6RYrMhcg2Td1CIHDyXBuFKzwZGCOC+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HA6G7zpz; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GClMTs020009;
	Thu, 16 May 2024 17:25:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=PIIcNcm
	lMr49S8y8EsAlKjuoQdNzfUVhtTNhE4eVCM4=; b=HA6G7zpz91xWiHvTJgyAUz6
	yKa/upVMmzoRQyBtM3c7ZZVly/Kk29dChQh0z4D8osjh/8KuqmJfBIBLlbhVPr7x
	Myw2raCpBlr2lnkwdTSHAOANqPygHm/7oDwJI/cDbXoP5B/zvbxiHDfM5WEBYGek
	jGYXceuYaGRkLK34StoH+cp99P3ihAh3D63ncCsB3XA+xMIr99jX18HTF08GIbKT
	etYR465hm1Rwd+oaJKDoUEg7jvqvwkpfwpT0iIHsGeQpcYd9ou7cA2iZIgeIlvq7
	NGRlehJKiv8DOHbYmoK60Mb2HBk9H6XGFSE7xWWrWdysJZzP85Vo7n9JlHoVgVA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y4sxvp3mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 17:25:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0AB324002D;
	Thu, 16 May 2024 17:25:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B0F4223650;
	Thu, 16 May 2024 17:24:54 +0200 (CEST)
Received: from localhost (10.48.87.209) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 17:24:53 +0200
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
Subject: [PATCH v2 0/3] Use STM32 access controller for STM32MP25 clocks
Date: Thu, 16 May 2024 17:24:24 +0200
Message-ID: <20240516152427.692374-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Use an STM32 access controller to filter the registration of clocks.
Don't register a clock if this clock is secured or declared as shared (this
clock is generally managed by the security world).

This series depends on the stm32_firewall framework (merged since
next-20240419) notably for the include file 'linux/bus/stm32_firewall_device.h'.

Changes in v2:
  - rebased on next-20240514
  - YAML patch was apllied on next
  - use appropriate include
  - manage the case if 'access-contoller' property is not present in the DT
  - rename DT patch (RCC support part was merged)

Gabriel Fernandez (3):
  clk: stm32mp2: use of STM32 access controller
  clk: stm32mp25: add security clocks
  arm64: dts: st: enable STM32 access controller for RCC

 arch/arm64/boot/dts/st/stm32mp251.dtsi |   1 +
 drivers/clk/stm32/clk-stm32-core.c     |   2 +-
 drivers/clk/stm32/clk-stm32-core.h     |   2 +-
 drivers/clk/stm32/clk-stm32mp13.c      |   2 +-
 drivers/clk/stm32/clk-stm32mp25.c      | 516 +++++++++++++++----------
 5 files changed, 325 insertions(+), 198 deletions(-)

-- 
2.25.1


