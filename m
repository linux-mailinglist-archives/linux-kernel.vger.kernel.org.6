Return-Path: <linux-kernel+bounces-233638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FEF91BA97
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D78B1C2389B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446E15099E;
	Fri, 28 Jun 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VxZca3uo"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5914F12D;
	Fri, 28 Jun 2024 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565171; cv=none; b=ll/J6AJ70Ka6RRWmDXqY8GTR+F0QEjkd+GhWGCUT76iTVwe7nfjufM/lSD91tCxLK0o1wlZw+TOC2Niuc0dOCgi4nfoBhQ2/1uiCRccqnpLpYyQ+fxD+Bs7+YsCw6uJtnCvuDRtVmeiyx/UcpWLy/8vN+/pP636G15LDIf5hx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565171; c=relaxed/simple;
	bh=x4eAbpC/g+Yds3Ly2t/Xrrz9Yi+TS8rO7V4YcWi34Qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfdIfsqi5bzAoCQ+StAmybsqmqYzii/fO2ddW8OY3W3akyPHKyzWAsWZeWVprD2YRCAeGT9rUp+xMd+UJiCW6ZcctUUJcLRF4BniTYizPBfZvHb70OL2SWPt7mn5HQIrEwYPO1PEuBGSwDNZ4LwRelenLtoXtDB4CCwK6Ex9Dxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VxZca3uo; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S143UX022293;
	Fri, 28 Jun 2024 10:59:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4/XNROgheAaG5E622Z9jFC/AgeGAisfMs+xMXlZ+JqI=; b=VxZca3uo540aAxt/
	F2vhi1gwP/b8Fdqb4OLz83FhpF2fjBrI0nqycZQyIc+b+c5/qRIb1R7uDZI8wzcL
	bHdPSprRIlMvPFEmHlEG4OAM74qu14/+j5NAEx3oUQp2SsNhn+twEU5V7u0k/Ng1
	1awduYg3ZzxlEmhBJ3k3TiIAKWvF9QZD0TEbhpGm1y/ZKX6mvBxr6aO62bQfSEDn
	CsnG7v1X7ud2PzPi5Rrdbb5zp0l7zm2VwUlIxeFJNrJdSHfZDaWB1Wai74HA2X66
	gYEDPUNTk4FzmTlyKGozn68+7wwrJXa7At5vpJ4gvDv6hdoO65nefHR2+AJjAe1a
	nim2GQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jjpgcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:59:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C85294002D;
	Fri, 28 Jun 2024 10:59:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D4C5B21195F;
	Fri, 28 Jun 2024 10:58:20 +0200 (CEST)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 28 Jun
 2024 10:58:19 +0200
From: Pascal Paillet <p.paillet@foss.st.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC: <p.paillet@foss.st.com>, Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v2 1/4] regulators: dt-bindings: add STM32MP25 regulator bindings
Date: Fri, 28 Jun 2024 10:58:11 +0200
Message-ID: <20240628085814.1586186-2-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628085814.1586186-1-p.paillet@foss.st.com>
References: <20240628085814.1586186-1-p.paillet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_05,2024-06-28_01,2024-05-17_01

These bindings will be used for the SCMI voltage domain.

Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../regulator/st,stm32mp25-regulator.h        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 include/dt-bindings/regulator/st,stm32mp25-regulator.h

diff --git a/include/dt-bindings/regulator/st,stm32mp25-regulator.h b/include/dt-bindings/regulator/st,stm32mp25-regulator.h
new file mode 100644
index 000000000000..3c3d30911dd0
--- /dev/null
+++ b/include/dt-bindings/regulator/st,stm32mp25-regulator.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
+ */
+
+#ifndef __DT_BINDINGS_REGULATOR_ST_STM32MP25_REGULATOR_H
+#define __DT_BINDINGS_REGULATOR_ST_STM32MP25_REGULATOR_H
+
+/* SCMI voltage domains identifiers */
+
+/* SOC Internal regulators */
+#define VOLTD_SCMI_VDDIO1		0
+#define VOLTD_SCMI_VDDIO2		1
+#define VOLTD_SCMI_VDDIO3		2
+#define VOLTD_SCMI_VDDIO4		3
+#define VOLTD_SCMI_VDDIO		4
+#define VOLTD_SCMI_UCPD			5
+#define VOLTD_SCMI_USB33		6
+#define VOLTD_SCMI_ADC			7
+#define VOLTD_SCMI_GPU			8
+#define VOLTD_SCMI_VREFBUF		9
+
+/* STPMIC2 regulators */
+#define VOLTD_SCMI_STPMIC2_BUCK1	10
+#define VOLTD_SCMI_STPMIC2_BUCK2	11
+#define VOLTD_SCMI_STPMIC2_BUCK3	12
+#define VOLTD_SCMI_STPMIC2_BUCK4	13
+#define VOLTD_SCMI_STPMIC2_BUCK5	14
+#define VOLTD_SCMI_STPMIC2_BUCK6	15
+#define VOLTD_SCMI_STPMIC2_BUCK7	16
+#define VOLTD_SCMI_STPMIC2_LDO1		17
+#define VOLTD_SCMI_STPMIC2_LDO2		18
+#define VOLTD_SCMI_STPMIC2_LDO3		19
+#define VOLTD_SCMI_STPMIC2_LDO4		20
+#define VOLTD_SCMI_STPMIC2_LDO5		21
+#define VOLTD_SCMI_STPMIC2_LDO6		22
+#define VOLTD_SCMI_STPMIC2_LDO7		23
+#define VOLTD_SCMI_STPMIC2_LDO8		24
+#define VOLTD_SCMI_STPMIC2_REFDDR	25
+
+/* External regulators */
+#define VOLTD_SCMI_REGU0		26
+#define VOLTD_SCMI_REGU1		27
+#define VOLTD_SCMI_REGU2		28
+#define VOLTD_SCMI_REGU3		29
+#define VOLTD_SCMI_REGU4		30
+
+#endif /*__DT_BINDINGS_REGULATOR_ST_STM32MP25_REGULATOR_H */
-- 
2.34.1


