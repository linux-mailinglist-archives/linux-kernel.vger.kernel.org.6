Return-Path: <linux-kernel+bounces-289719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB02954AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731911F2351A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86C71BA868;
	Fri, 16 Aug 2024 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2qP+8X4h"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C119DF85;
	Fri, 16 Aug 2024 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814570; cv=none; b=V7jrDEYWTS00FHz7PMi61xbANIvXxiiLR/wwVNi+qLrGJ10wHAcEGlNbqexmgAJtjtiVmY+brv1zRciNQD7OLiquc0lcrxhimTVcK/HH6Gnz/wKihrexsbLNFkF+e72R29Bj2cSudiTXnnKxV0i6kmSCkj+rYxoFhEwPKFk7yes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814570; c=relaxed/simple;
	bh=JaDfB5LbT2d35GBa/JrhTbYkMKfz5yOQ/gC36nll6rc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTQZhuQjDLF9V1Kr+PVV7oZqI8UlI8sIthrhrVl+SwjXc+LCdQG+nuXnEvbdkexf+UaG50lMTowiKenDm4GJcRUPdbagXss6uI4mzTRMvD3rHi4RaFZ1cDfwN2yPPXYr5ul58NV/D3QB7GgGOahCD4lDg0ld2+wo28IcgPXvT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2qP+8X4h; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GB3eOb007662;
	Fri, 16 Aug 2024 15:22:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=N+RTuMITKav8svMSG7///5
	muEWq1usuZqZIJk8FR7FU=; b=2qP+8X4hjNsGxJRU+OWVK0d8UVu2eovFjrpX+Z
	H/QIvOD6SFEq/bWnF2oRd3dhXMv03ufJIB9ccAZdxqT7BoodEdJSdqQgvY9wadZZ
	m/G7d+hxJ/s7GHcEi5ILNt+63N3Hg+Gm0ovK3pa2PyzGTZJqraff6iDXwnlmZ81l
	D7ieS9LA6RNK93g7NFePZaDTBBfwzCZOuEj5FTHYcCnJSogpWBYOP3IqS0M5eRKH
	8NsMD+NvbIW8EXYBGYpluzog+Hp2DhAEvPCe5SxhU290DUzFA/+lg5ZN3vyTkmdu
	iD75bpTPwOPK2Jh7WNjzm1Nm/Yr1ky+kFSU+72ky0Zdga2Aw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4121pns97n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 15:22:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 542E940045;
	Fri, 16 Aug 2024 15:22:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C175A25C5AD;
	Fri, 16 Aug 2024 15:21:15 +0200 (CEST)
Received: from localhost (10.129.178.198) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 16 Aug
 2024 15:21:15 +0200
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
Subject: [PATCH v2 0/5] Add STM32MP25 USB3/PCIE COMBOPHY driver 
Date: Fri, 16 Aug 2024 15:20:52 +0200
Message-ID: <20240816132058.920870-1-christian.bruel@foss.st.com>
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
 definitions=2024-08-16_05,2024-08-16_01,2024-05-17_01

Thanks Rob for your comments, addressed in v2.

This patch series adds USB3/PCIE COMBOPHY driver for the STM32MP25 SoC from
STMicrolectronics, respective yaml schema and enable for the stm32mp257f-ev1
device into which it is used for PCIe.

Changes in v2:
   - Reorder entries
   - Rename clock_names and reset_names bindings
   - Rename and clarify rx-equalizer binding 

Christian Bruel (5):
  MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
  dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
  phy: stm32: Add support for STM32MP25 COMBOPHY.
  arm64: dts: st: Add combophy node on stm32mp251
  arm64: dts: st: Enable COMBOPHY on the stm32mp257f-ev1 board

 .../bindings/phy/st,stm32-combophy.yaml       | 145 +++++
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  17 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  14 +
 drivers/phy/st/Kconfig                        |  11 +
 drivers/phy/st/Makefile                       |   1 +
 drivers/phy/st/phy-stm32-combophy.c           | 607 ++++++++++++++++++
 7 files changed, 801 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
 create mode 100644 drivers/phy/st/phy-stm32-combophy.c

-- 
2.34.1


