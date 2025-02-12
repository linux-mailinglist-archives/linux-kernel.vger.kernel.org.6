Return-Path: <linux-kernel+bounces-511071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841ADA32567
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C363A7B73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675120E035;
	Wed, 12 Feb 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eECY0Qze"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC120AF8A;
	Wed, 12 Feb 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361017; cv=none; b=p5YeXkmtKQ86xYSk3X7/Cs89LufW64xVO20olAoOveTEP/Wk+0GJg76iaJESIUWIDvs/76DhxO7N7G0F/mStsBVUwzfm4UETN3DJu2n0igIMKuJIEmraDNCQRGVt9JZFQDTg1yIq7NCCQvJCd9s1VWOMP8LP/PQUj1H3PMr3qs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361017; c=relaxed/simple;
	bh=bHMPQNO63K2OKXQk9hyUJHVPRDiR3pcBipZ1ci2+Q7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aD99cmdFp0NxhgPOKKVu7nhq3j+IVALZ/Ko6LvT1DeFrrmDtvNmXQtQ7a4AdvEp3K06TRcKS57UydYED8+yqClCmT5/1bgXd7yrwcmcykLT68m4iyIM/U8VyDztXttjUCc1ggRSsJ8UFx59JfXheBvU9Hw1YR7M2CHZQywKf0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eECY0Qze; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C9g91i024239;
	Wed, 12 Feb 2025 03:50:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	j+fi49iZtFEwvOeYLBx6sfIVBo1eY9k3ZC/VJe1GWw=; b=eECY0QzeWozb0cEmD
	id9ENxquWV0j1SsF22vx8BwH37jzzlp0blZDSGQpfY/2kSlaiyaNoqccQbVTMQZi
	ushxUKXLqXNeoNKC5z7tLCsFBPRbkVdKmk6phceEQZNpoaRCuRU3JjaQvvH3xkpN
	UFhSGddP7m4VYnHX6+cF4bdtLgN7gg8uM17L9olUeOQED2Ub2fN8F9bsSymRcLBc
	W1f6jvREkJMD0P8K8UJjN8KeYfpA8gbajoyhWRHOoSDkmC8sIdopvTD7e0G41em+
	y4MmN5MOFEx79of+DG6Haq3kKad38kH4BfWIpi81Iid9ywYigxMk0qdPj9tFPMor
	H5Img==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44rs80r5yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 03:50:05 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 03:50:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 03:50:04 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 1830A5B693C;
	Wed, 12 Feb 2025 03:49:59 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v14 7/8] coresight: config: Add preloaded configuration
Date: Wed, 12 Feb 2025 17:19:17 +0530
Message-ID: <20250212114918.548431-8-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212114918.548431-1-lcherian@marvell.com>
References: <20250212114918.548431-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 52vXiWtAAMmW09bqIRKj7zqRotbUAoW_
X-Proofpoint-ORIG-GUID: 52vXiWtAAMmW09bqIRKj7zqRotbUAoW_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01

Add a preloaded configuration for generating
external trigger on address match. This can be
used by CTI and ETR blocks to stop trace capture
on kernel panic.

Kernel address for "panic" function is used as the
default trigger address.

This new configuration is available as,
/sys/kernel/config/cs-syscfg/configurations/panicstop

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
Changelog from v13:
No changes.

 drivers/hwtracing/coresight/Makefile          |  2 +-
 .../coresight/coresight-cfg-preload.c         |  2 +
 .../coresight/coresight-cfg-preload.h         |  2 +
 .../hwtracing/coresight/coresight-cfg-pstop.c | 83 +++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 4ba478211b31..46ce7f39d05f 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -25,7 +25,7 @@ subdir-ccflags-y += $(condflags)
 obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
-		coresight-cfg-preload.o coresight-cfg-afdo.o \
+		coresight-cfg-preload.o coresight-cfg-afdo.o coresight-cfg-pstop.o \
 		coresight-syscfg-configfs.o coresight-trace-id.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
index e237a4edfa09..4980e68483c5 100644
--- a/drivers/hwtracing/coresight/coresight-cfg-preload.c
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
@@ -13,6 +13,7 @@
 static struct cscfg_feature_desc *preload_feats[] = {
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 	&strobe_etm4x,
+	&gen_etrig_etm4x,
 #endif
 	NULL
 };
@@ -20,6 +21,7 @@ static struct cscfg_feature_desc *preload_feats[] = {
 static struct cscfg_config_desc *preload_cfgs[] = {
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 	&afdo_etm4x,
+	&pstop_etm4x,
 #endif
 	NULL
 };
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
index 21299e175477..291ba530a6a5 100644
--- a/drivers/hwtracing/coresight/coresight-cfg-preload.h
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
@@ -10,4 +10,6 @@
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 extern struct cscfg_feature_desc strobe_etm4x;
 extern struct cscfg_config_desc afdo_etm4x;
+extern struct cscfg_feature_desc gen_etrig_etm4x;
+extern struct cscfg_config_desc pstop_etm4x;
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-cfg-pstop.c b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
new file mode 100644
index 000000000000..c2bfbd07bfaf
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(C) 2023  Marvell.
+ * Based on coresight-cfg-afdo.c
+ */
+
+#include "coresight-config.h"
+
+/* ETMv4 includes and features */
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
+#include "coresight-etm4x-cfg.h"
+
+/* preload configurations and features */
+
+/* preload in features for ETMv4 */
+
+/* panic_stop feature */
+static struct cscfg_parameter_desc gen_etrig_params[] = {
+	{
+		.name = "address",
+		.value = (u64)panic,
+	},
+};
+
+static struct cscfg_regval_desc gen_etrig_regs[] = {
+	/* resource selector */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCRSCTLRn(2),
+		.hw_info = ETM4_CFG_RES_SEL,
+		.val32 = 0x40001,
+	},
+	/* single address comparator */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_64BIT |
+			CS_CFG_REG_TYPE_VAL_PARAM,
+		.offset =  TRCACVRn(0),
+		.val32 = 0x0,
+	},
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCACATRn(0),
+		.val64 = 0xf00,
+	},
+	/* Driver external output[0] with comparator out */
+	{
+		.type = CS_CFG_REG_TYPE_RESOURCE,
+		.offset = TRCEVENTCTL0R,
+		.val32 = 0x2,
+	},
+	/* end of regs */
+};
+
+struct cscfg_feature_desc gen_etrig_etm4x = {
+	.name = "gen_etrig",
+	.description = "Generate external trigger on address match\n"
+		       "parameter \'address\': address of kernel address\n",
+	.match_flags = CS_CFG_MATCH_CLASS_SRC_ETM4,
+	.nr_params = ARRAY_SIZE(gen_etrig_params),
+	.params_desc = gen_etrig_params,
+	.nr_regs = ARRAY_SIZE(gen_etrig_regs),
+	.regs_desc = gen_etrig_regs,
+};
+
+/* create a panic stop configuration */
+
+/* the total number of parameters in used features */
+#define PSTOP_NR_PARAMS	ARRAY_SIZE(gen_etrig_params)
+
+static const char *pstop_ref_names[] = {
+	"gen_etrig",
+};
+
+struct cscfg_config_desc pstop_etm4x = {
+	.name = "panicstop",
+	.description = "Stop ETM on kernel panic\n",
+	.nr_feat_refs = ARRAY_SIZE(pstop_ref_names),
+	.feat_ref_names = pstop_ref_names,
+	.nr_total_params = PSTOP_NR_PARAMS,
+};
+
+/* end of ETM4x configurations */
+#endif	/* IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) */
-- 
2.34.1


