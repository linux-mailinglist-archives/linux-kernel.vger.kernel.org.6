Return-Path: <linux-kernel+bounces-312891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A69969D36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE80284626
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27051D61B7;
	Tue,  3 Sep 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XFVVCikL"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702841D0970;
	Tue,  3 Sep 2024 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365691; cv=none; b=Uyufs41Ty5c9DOVCD3YOl0Xeov+UGF4rK7ayQgfn/8b7Rujxx8JyQnQofvjgTGwBzkT/fqZIAwHaN0tGmhAOgG8iaMcAAxCTzKTyjVQto4Q/j8qr/EeqhhMyNbedBb9PZxOE+lQ5IcKnCatu7FATJiu+Vajsv28ty5a48ObUgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365691; c=relaxed/simple;
	bh=L8RRnWihN4ho/kOUuMPXZ7VvrJTkc6VO/Kbd8ZkUROY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SiyWbiiVfwiAJ39F7thd6aTycJ1EwgyL40MnToCEZRLcU7ImOW2ytSzpnpvUXioB9gXU4jJ8n+uhHUBdWOrBMbOc+wtEr5OxNXY9K4V8sWjn+sRbERqBH1ARkSGV/t8CXOUc/bq3xGicLLESSpgsLu2LrkRrh/ueYUwjnjzqNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XFVVCikL; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483BjWrH029157;
	Tue, 3 Sep 2024 14:14:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=JXSvegFYtTN90pjhfv7KPP
	8miO/vxkxO0WY7Swryz28=; b=XFVVCikLW110y6jLA4puq0FuvCVmzi4OAQTxCX
	PJbVjdBVKJyKpWINGpqpTr2gTE2m57i0f5mxptUbpDdDQtdjRb7okaHwKQaYXw4b
	Dmre05zUPOdn025pxwt6CQwZgNOAolOmPojP6/HXWzPvxr3uVcajdc/NMqYAiPKB
	HnQXWex6XRn8WS/fIMyhTu+d26i7hAeecC7uKCj2Y1NfZKXuxHcU9TjeaOicap7P
	qV/wb3R3FdgkyFbQpnJOyYfWHj+PoH7VCVCfn+9ZQLL2Tdi6Cosz3k2vfRZUXSYp
	g0gxxbf4H9gHT4BCd0xKO+JCUday2ju3KuGd93Cd/oiYBk0A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41brkg4pm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 14:14:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9AFDC4004F;
	Tue,  3 Sep 2024 14:14:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A85C224E1F8;
	Tue,  3 Sep 2024 14:13:20 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Sep
 2024 14:13:20 +0200
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
Subject: [PATCH v5 0/5] Add STM32MP25 USB3/PCIE COMBOPHY driver 
Date: Tue, 3 Sep 2024 14:12:58 +0200
Message-ID: <20240903121303.2953150-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01

Changes in v5:
   - Drop syscfg phandle and change driver to use lookup_by_compatible
   - Use clk_bulk API and drop stm32_combophy_enable/disable_clocks
   - Reorder required: list.
   - Fix access-controllers maxItems
   
Changes in v4:
   - "#phy-cells": Drop type item description since it is specified
     by user node phandle.
   - Rename stm32-combophy.yaml to match compatible
   - Drop wakeup-source from bindings (should be generic)
   - Alphabetically reorder required: list.
   - Drop "Reviewed-by" since those previous changes

Changes in v3:
   - Reorder MAINTAINERS patch

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

 .../bindings/phy/st,stm32mp25-combophy.yaml   | 119 ++++
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  16 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  14 +
 drivers/phy/st/Kconfig                        |  11 +
 drivers/phy/st/Makefile                       |   1 +
 drivers/phy/st/phy-stm32-combophy.c           | 590 ++++++++++++++++++
 7 files changed, 757 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
 create mode 100644 drivers/phy/st/phy-stm32-combophy.c

-- 
2.34.1


