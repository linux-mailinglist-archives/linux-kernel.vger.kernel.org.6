Return-Path: <linux-kernel+bounces-283052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DBA94EC5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8046C1F22CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF917A58F;
	Mon, 12 Aug 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="USQvDMeo"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062516FF39;
	Mon, 12 Aug 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464457; cv=none; b=OMEfnlRsIfpXSCXF6v1z2OVwYQWsGHfneGZmjBGMRWBUligajGcp9IUDaVLFvtRE+DY4kz2q5ga+aUUcpqZ7aOylJMTSzhoPajX3XBBn4UHeMKK3vGR7baDDOFoM+pd4Omcq9hKf7g2anvvdRoMQFQiuHSYAbqidiEgLwJmmQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464457; c=relaxed/simple;
	bh=fJlb/0gHtjxDW+DVfqRh4ITMUSx2juv7ZXeoanshWv8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQ0qyIW8VtwggAiE1GhsKdTojPyTNfhgpRCCT3+99jEqYxsAIU8vFbaaNxyF5SWqHEikRVSNlxOgd5ah9WzWSOb2CtCBarmY5n8roteGx23pAb/4XWIFwm80c1SXE+Qj7HOByfO3nHeGFetbo9oL7w2Ml2O4KMAArm1cBhuDXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=USQvDMeo; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C7aX5W019310;
	Mon, 12 Aug 2024 14:07:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=jBFm5lioebDOyXazDkIYVb
	60u9foI26v49i7zxn/x54=; b=USQvDMeoQniI+VZiOV2MqGuQAwc2MC8xmLLnmb
	M8L52BpaB76y82tchXIEMMdQf+YzjnVubLBNG1yEcrDVo1zP/PizUkGEblsFL0v5
	BwBwrGXLAyLNAWVbFYOSfSGz9l2oy10tPEaS7ikKsiDo31JEMR7yQWf5MYhsUtss
	3/yQjpBSlWNqdDt4/G052DfONjRdHp0a/Lxomj3SYcJWzDMyKsW47SSPdcXesPa3
	EHP+S9MvX0B43OHFT0S4wSA1C3/Q5qZslZW8HqvfYL1m4p83YmyJQvfSLX6lpGFz
	wzIMsQ3XegNdR6zQ6iGPMvLT5WtDG7qKIx2XwvlOivj3bVMA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40xk5hm8ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 14:07:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ABF8740045;
	Mon, 12 Aug 2024 14:06:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E57125AF0A;
	Mon, 12 Aug 2024 14:06:06 +0200 (CEST)
Received: from localhost (10.129.178.198) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 12 Aug
 2024 14:06:06 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>,
        Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH 0/5] Add STM32MP25 USB3/PCIE COMBOPHY driver 
Date: Mon, 12 Aug 2024 14:05:24 +0200
Message-ID: <20240812120529.3564390-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_02,2024-08-12_01,2024-05-17_01

This patch series adds USB3/PCIE COMBOPHY driver for the STM32MP25 SoC from
STMicrolectronics, respective yaml schema and enable for the stm32mp257f-ev1
device into which it is used for PCIe.

Christian Bruel (5):
  MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
  dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
  phy: stm32: Add support for STM32MP25 COMBOPHY.
  arm64: dts: st: Add combophy node on stm32mp251
  arm64: dts: st: Enable COMBOPHY on the stm32mp257f-ev1 board

 .../bindings/phy/st,stm32-combophy.yaml       | 178 +++++
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  17 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  14 +
 drivers/phy/st/Kconfig                        |  12 +
 drivers/phy/st/Makefile                       |   1 +
 drivers/phy/st/phy-stm32-combophy.c           | 607 ++++++++++++++++++
 7 files changed, 835 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
 create mode 100644 drivers/phy/st/phy-stm32-combophy.c

-- 
2.34.1


