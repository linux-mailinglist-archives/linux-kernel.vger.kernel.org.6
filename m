Return-Path: <linux-kernel+bounces-303281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6387C960A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01864B22441
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7A1B5803;
	Tue, 27 Aug 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oISbGJP+"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62719922A;
	Tue, 27 Aug 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761599; cv=none; b=RPuxVg7BKAT1WMsogoYzsUG4xpvINshYTX9jf/qat8m/FqqyBMNRut3TnJtZ8UwaoGhJ5Ivs1fAy92jJI9HUAqFT/6wKVUVkZVtXDj59evE+wE0vTJf5LjnsgIWXkMbUzrk4wm3mBia1U4JXCUQ22RP1Vu+bzzhrvH8bMW5R4cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761599; c=relaxed/simple;
	bh=96kw8P72d9gzY4hB0TBG8RkglfN1ceu0NH450keWjsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQT0EvmEahATcmNTXP03cwtZrsO3Vjl9Vr+m5/t4LqZ2Vdvq8caaoEMR8FVXTWnUJ0eIahJddUXKdeETXG1hlGNb847zIVSHMHUpHRdAvVxj24BZYXN4fzqLxPTMSrQme7v61ri5LzqUvip8Hn0ZxC28dSi1imb0D3mtF8/wtBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oISbGJP+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RAZcVc018614;
	Tue, 27 Aug 2024 14:26:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=MTkvu1DrSeJOWwBLrkpClM
	7Ev2RqstQuHoTEgAEyciM=; b=oISbGJP+2iVPBDbHoCB/YD4k0+TUU2BrnsypM5
	Pz1qj1l9X1LmtU7jaBTReWVKfzjmEh6uNs1Au3aJwJiB7J2CO3q4ok3hl83M48ZW
	0VVidMmRhGIMO+3wDGsbK/umvjuZOCcOZBCLY3s+vqRB7u7aBcU5YDX9Ed6pO3W6
	AErcN0M32uDa39r+DLB4+AN0v8BXRwJ2pWeEKMvRhF01zhyCVtVGa3zjdMe0ePEb
	VCptViheJFi5B/nRwcjXS1Fg4bUE11rUk54FTROj4MpBy/jj8IMxaY8YLMk8avU3
	Lg5x2VjhU34b0RudKst8+NLXRwVpdoAd2wF3Eh6EGcgngcnQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41796km64c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 14:26:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7B29440045;
	Tue, 27 Aug 2024 14:26:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3573526333B;
	Tue, 27 Aug 2024 14:25:22 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 14:25:22 +0200
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
Subject: [PATCH v3 0/5] Add STM32MP25 USB3/PCIE COMBOPHY driver 
Date: Tue, 27 Aug 2024 14:24:54 +0200
Message-ID: <20240827122459.1102889-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_06,2024-08-27_01,2024-05-17_01

This patch series adds USB3/PCIE COMBOPHY driver for the STM32MP25 SoC from
STMicrolectronics, respective yaml schema and enable for the stm32mp257f-ev1
device into which it is used for PCIe.

Changes in v3:
Address comments from Rob and Krzysztof:
   - Reorder MAINTAINERS patch
   - Drop wakeup-source from bindings (should be generic)

Changes in v2:
   - Reorder entries
   - Rename clock_names and reset_names bindings
   - Rename and clarify rx-equalizer binding 

Christian Bruel (5):
  dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
  phy: stm32: Add support for STM32MP25 COMBOPHY.
  MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
  arm64: dts: st: Add combophy node on stm32mp251
  arm64: dts: st: Enable COMBOPHY on the stm32mp257f-ev1 board

 .../bindings/phy/st,stm32-combophy.yaml       | 144 +++++
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  17 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  14 +
 drivers/phy/st/Kconfig                        |  11 +
 drivers/phy/st/Makefile                       |   1 +
 drivers/phy/st/phy-stm32-combophy.c           | 607 ++++++++++++++++++
 7 files changed, 800 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
 create mode 100644 drivers/phy/st/phy-stm32-combophy.c

-- 
2.34.1


