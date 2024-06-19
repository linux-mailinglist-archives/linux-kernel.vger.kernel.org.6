Return-Path: <linux-kernel+bounces-220710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7334A90E5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288941F21E86
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457367E0E8;
	Wed, 19 Jun 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qfALhzJL"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EDB7C6C1;
	Wed, 19 Jun 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786248; cv=none; b=Y4pMmfkrsRD3EC6uTrF53Vehj48LzovQqrfg4WHzgJrEHhr3Dj7J8dQt3BWIGt1fbzN9mDx0i7xH8gLkqlbMeE4b1ZeD7OXIoXgvWQyvAa/L5kALjn6giBXvYebQDwEbYxRarQFz1Ulo5y/w3POTWYVlGdkXYgKG/yBDFEjRTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786248; c=relaxed/simple;
	bh=3n4ybvOboaWmCPxPYF9JaDhbuBNKJSiOEOAlF18cCao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNoAEfaKUERq9X8ZlYLfbZnd9r3+dzx0fZZKPUpExiTmBMCnaQ+UCsQXQKoqeYF8dAVRtxCsLrTAFlmqbfYJuvv9kMBDkZ4XyMY06Z5iGzHDtzZ/OAJ7EWkKXL1ebgVbrbl8rJ/LUp35mNAybJRAnsWJ7xyHJWk+L4TmEsPcK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qfALhzJL; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7SgTo013430;
	Wed, 19 Jun 2024 10:37:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	wRMG4qwA9Dbv46xH+h26yQBQYduRI5IcnQPPuE4Kx50=; b=qfALhzJLj+lkQZum
	5lNSNIROaUM38QCtFBIeSo+ceMxPCMGDXc/D1aqxMFzZs8069SrzuadFxVsM9UI9
	1p24QSoSfn9FUlS4nBStSz7LdvXCRip5NXjQz6adwKNbxr7atzNaTVZg2s6AsQha
	IaTo3KqpAOIonqfayXSmIyzGu6aSTjx69st9n17XeDaNW6Vvf9oXwxheSmwX0cus
	+mSvLx2tGMWJcUiSkkTmaytGGLg/Bd3gdbhxD7DxF9TQTrR9u0gpPW08Y0M724R2
	f+iquYLWsnJaaR+QPzbLxZ5QPG38K1a8Av/WoiuJ5kXMR37koHh7lxnVIdnm79Bi
	OA1QhQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9ua3b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:37:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CE1E840048;
	Wed, 19 Jun 2024 10:37:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E873320F554;
	Wed, 19 Jun 2024 10:36:10 +0200 (CEST)
Received: from localhost (10.48.86.232) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 10:36:10 +0200
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
Subject: [PATCH 1/4] dt-bindings: add STM32MP25 regulator bindings
Date: Wed, 19 Jun 2024 10:35:59 +0200
Message-ID: <20240619083602.33007-2-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619083602.33007-1-p.paillet@foss.st.com>
References: <20240619083602.33007-1-p.paillet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01

These bindings will be used for the SCMI voltage domain.

Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
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


