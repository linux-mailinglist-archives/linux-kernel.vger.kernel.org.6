Return-Path: <linux-kernel+bounces-324703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC0974FED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE6CB26A22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52039AEB;
	Wed, 11 Sep 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wQHIvsdh"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E818132A;
	Wed, 11 Sep 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051306; cv=none; b=V/egqrg76GM9pYkNqMdXG+n4BsWigfSB3jedbqsoAjwCg+gFY3NbPmDfo5Vd62fLdle6hZ842iYO+THjihVSUumNjs+iJyPe1qb0SEoPJli3yCkJTIrY83iAe6GJBZJ9rdOBAblHPCNgnF3lNyr7naaB5RbLLDS6PQEMLi4+G1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051306; c=relaxed/simple;
	bh=zBbU8ePENeRszcGTCZYPjgDxGoqtTjFfd6KZ1pTPB+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQaSH2x3/2RD1Tit10ZCksWtjK9pgINhGUCXv6mFRUBlZ4fb9aQLinUzdpjJ6rqCOOJC8bXwNUt8CHTOnC9za7thy71JxrnsJpYTDk8XHS0nDSnHauBxS1/0AeHWVHl3eeDT/GumhVN6EQDvmTIeNUMgvSf+4zihp0TppbTaT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wQHIvsdh; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BAGVTN004295;
	Wed, 11 Sep 2024 12:41:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=7yQGd8tUqQpjZky5fREEbX
	XJRpD0khUm4FkcB9P087w=; b=wQHIvsdhqZGmo0GY2GR+tSYdfaJknGQx4WfqC0
	I+OvaxRPtfNy8YDpm8tattgT+OZp3qnkg2ErtnwyLBneiltCj/yV6z9YziFpkXUG
	OZ/RmwMR274dZZ0KRD0lq87Qa73fB1iU3fTTL6KGenUHNMHbDN+neEMfoi6zum4c
	hTnPw6Gx3S0GyEzl3U+dYLDJBPUIHq8h4S/ztY0Lw6F+3I0B5W29G6umyjDaB/0Y
	SQTimuTDtznHWZw4vieCihLgHgsgSsK/jStr2QDspvfrHkb7ILOHsegMdgh4ytpU
	kGvYifcWGYmo4YrjvDbsN0rbOI4SB8nqwb/GbMeiG1qdHvZA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41gy7sejw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 12:41:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E773A4004F;
	Wed, 11 Sep 2024 12:40:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BF0742649FF;
	Wed, 11 Sep 2024 12:37:35 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 11 Sep
 2024 12:37:35 +0200
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
Subject: [PATCH v7 0/5] Add STM32MP25 USB3/PCIE COMBOPHY driver 
Date: Wed, 11 Sep 2024 12:37:24 +0200
Message-ID: <20240911103729.2980431-1-christian.bruel@foss.st.com>
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

Changes in v7:
   - MAINTAINERS: Reorder STMP32MP25 DRIVER entry

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


