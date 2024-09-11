Return-Path: <linux-kernel+bounces-324720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835F975024
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8851C20C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D610186617;
	Wed, 11 Sep 2024 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7R+RzhNy"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64002185B6A;
	Wed, 11 Sep 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051891; cv=none; b=merPA48K3he+E/KszFyn9gfPfQWssjaokw8ITMGdKrpM84RInbOTLqMNqkcXBYLseo0Kt0WQVxAtlwce7Vc3MoED9AORd6HHMVBFbnipMBD5Tnx9Y8KQ6x/ClGqHIEj37qlvnixihNAcZgCNeXNui6RAap9KpRwKDx7xy6ztt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051891; c=relaxed/simple;
	bh=tHbVgbECrjEKGgf/k/O6P4n6Jh9+FqOWa6EJcNN7FLU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KXsazUZab7p+8RTukVgGvZb4Xq+zrGv701LTIn+0FmLQnsyWvE7whn/rvdee76GC4l8QJ1Em7RhgOKRIovnUSdnHgsJnGsk5jTu4pdJ78Ep6qzahLIs7qOcoTWHjF+WzRuV+gSX8iXJqUqq+GWRyzEDgOsru54prtWXbVaGL1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7R+RzhNy; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BA3uad027275;
	Wed, 11 Sep 2024 12:51:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=0WzLc6q4m7ThCYCCO39O3y
	qSLr+hElZixPi6UArXKN8=; b=7R+RzhNySdANufmrav6Ysx/IC4URkBP9Z/qseB
	M3MwB1j7XPt8S/QRBBeUJ6bCBUrqtuZKcG3t7Q2ct+VQtSqW4cFLFC4uVySbxXmg
	lh2kW/2PLbgNbVEQVqznsZ20mTB5Vpreu5SCqPXN/8waZNEXwfaEmJjTyIrNnsQw
	2/xwi3z7Vw0cxnrCfO84W1qap5X+7VKf96nMWgB5ds7u6H48I5f8FAfOnJF7kuak
	jB3LldT76QnRJ2hVNvETUTh4z3L/qU11MwbQr15r/AehaFYSXJrW/S8yi4uX1o/u
	gFVEqmsdsvaXgClI77CWXz8TNC1kP1pkUmsNouy9Rveo5/gw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41gyaux9nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 12:51:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D612C40069;
	Wed, 11 Sep 2024 12:49:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2165925AF0C;
	Wed, 11 Sep 2024 12:46:54 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 11 Sep
 2024 12:46:53 +0200
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
Subject: [PATCH v8 0/5] Add STM32MP25 USB3/PCIE COMBOPHY driver 
Date: Wed, 11 Sep 2024 12:46:41 +0200
Message-ID: <20240911104646.2980821-1-christian.bruel@foss.st.com>
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
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Changes in v7/v8:
   - MAINTAINERS: Reorder STM32MP25 DRIVER entry

Changes in v6:
   - stm32_combophy_pll_init: merge combophy_cr1 accesses and error path.
   - Use devm_reset_control_get_exclusive

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
 drivers/phy/st/phy-stm32-combophy.c           | 596 ++++++++++++++++++
 7 files changed, 763 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
 create mode 100644 drivers/phy/st/phy-stm32-combophy.c

-- 
2.34.1


