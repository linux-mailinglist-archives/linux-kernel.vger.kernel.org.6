Return-Path: <linux-kernel+bounces-270985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E41944810
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED39DB2113A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B117191F88;
	Thu,  1 Aug 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SfEBiPyP"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD1184542;
	Thu,  1 Aug 2024 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503972; cv=fail; b=B3BDn8nCUM5xEc1zR74Q1vRErJF1kD8iykBZ/KOnmApUPSFZw6kImOkNp/O6jQmgv3VYf+B01r51mutHHTT4jEA/zHSvoHVUBow6QwV8I9TB7oMYFOPnKc2EsvegeDiEevhRcFxl6qOzlcd3qEcCFgEZJJxZHGAf78F5tbVxqMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503972; c=relaxed/simple;
	bh=wn3Jq4xtXK/6EdLFmKyHGMbG0b6DR9OJpXRhch1t0b8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQGrq7b7W6MZsp3m5OEBNjFwDzI9O6Uuq3ZyN+5y0R8Oqy5mzOpFBfkvy93N3MbdZtZ2DYJgw84JvakB+Ph73/Rku4WbqbipGthSGgNE8+xTjMYd3/UiC92l4nI5W160WmpuBcmzAmV7nIg3SqLo2k1gZSN9S9rJdl4sbWH06Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SfEBiPyP; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrToDbGfLpXEnd5ggDpzcXQkjdXCV5EQ1haffADpZ9zgi4ZJ8HJhihtplVfWV1i+TAPf2M08ROZ7lZ98efWfTQ2u32u3Et580BpMsFPfXPJot0wJe6BoXUK0G8fPmgwmgSIhSoYXQDj1DyYAA6/YNxh7Lz5MMpfF+tERMR4aaCHYV+6xWpbLMHcPAn2G27GGi5QdQkJZfgYxXvdyLRQX16w4zgfmfzBYmq2YnefxpmpTVcUwhrASaOMy80UABEO89LIiAk+K8/SrHbAej83H4IzuxhwjFozpei31TQCQ4ooOCfjdMZtpcHwnpi4ClmhGCtubT8Fq+92YQbYt6XYS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n32lpJGaVISCUycsy6PmNSawqp2e9DMRtw/J5CxqmaM=;
 b=ZA5q0jningCRVGmgOFfpIYR+gYSRbx1eiwx11nW1aYTXKbUA8iurUOxOioaXnNeRIYZ1EBUBjiqWaVzYnlbUlbUiV+e3Hm3NephmmmTn5DDWYFCzV2cNiTPClLY3oV9biJZbqb4THQF0FtPduKmqfb7bSOHerhE0gwfp56qbe4bzc03tAf+9RGxWcnmXngpIcbke6Ble7NnTzWVRLYnqNa6lunlOBuN0NiOlSMj4qektcKiV3NxtNzW2shTBYcJdi2Wpob06JlcUr2o/j1kSP29LdPm30DhTGYPK91b+m44BXk516eJYzMAivEZnxPdNT1Vd3BzuCo7SOUzSiKxmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n32lpJGaVISCUycsy6PmNSawqp2e9DMRtw/J5CxqmaM=;
 b=SfEBiPyPsYoARrvuKG7E78Fa7lZswa7++hu9mO5bfjiW/r9kdr7pvAXC/KsEXmUFIH5Q9zj2FkYtSntDK8+JP45+dpHn8FrG8N0P5UyAotDazuyc4ZnZcjODlVev1JlsgpDBvB7OmNdPb5PlQsWEKyOxhEE7TI9nd7kyrElrohQ=
Received: from MN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:208:530::11)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 09:19:26 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:530:cafe::59) by MN0PR02CA0004.outlook.office365.com
 (2603:10b6:208:530::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Thu, 1 Aug 2024 09:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 09:19:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 04:19:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 04:19:25 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 04:19:18 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <pierre-louis.bossart@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Cezary
 Rojewski" <cezary.rojewski@intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Brent Lu <brent.lu@intel.com>, Charles Keepax
	<ckeepax@opensource.cirrus.com>, Maciej Strozek
	<mstrozek@opensource.cirrus.com>, Chao Song <chao.song@linux.intel.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 10/31] ASoC: intel/sdw_utils: move dmic codec helper function
Date: Thu, 1 Aug 2024 14:44:25 +0530
Message-ID: <20240801091446.10457-11-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801091446.10457-1-Vijendar.Mukunda@amd.com>
References: <20240801091446.10457-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa7d8ae-a113-441e-0ff1-08dcb20b09f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pKwr6Ja+EY3SIOUSS4r4f6iRNKQolIRG1+M/XXPP411e1KPsmwugxi0/GNlM?=
 =?us-ascii?Q?Qa8TZkM6bQmHshA6JywewB/kM7AsrMBWSeYv4XvoOIg+TzD1u4WDv6ivyg2M?=
 =?us-ascii?Q?hgZmCFh5Ni0TdjzWA6KajH35dv9ssGS4qrPq2UC3cZJtEV/0nte8ohlkEUcl?=
 =?us-ascii?Q?LWt/hFjZtqIEkaDFbNeZFetXjVPBu9DZvw8lY7zU7DZMWi7m0tucDrpmm1hM?=
 =?us-ascii?Q?B1o0Idb22h37I6lT45w/RZTdEjXhefFZuOeov6QvJynBgyi45YaSuvMUocZ9?=
 =?us-ascii?Q?FEdbwaeWmMTmBI7KIbpFgAR1Laufe6DJ/VONvVh1JXUU1CM0rYyxfu9J2J46?=
 =?us-ascii?Q?94ArTUO+s9Ztx9CmKLQBuUxjqtzwzTRbdHQK3CmAt1H9SMbamgtS06G5E37K?=
 =?us-ascii?Q?WBqW+xkyaJTULwewfeVrNGYr/0m/LAZFkjZAkdnFYP6Zfq6M5qGRubdbaf8M?=
 =?us-ascii?Q?RpVF8Hnan9z+eJx4PPnHwbaeIoJRwafeUlN5r93y4cGG38+JTh5SVYrb3adu?=
 =?us-ascii?Q?SUuDRj9EBfRIGBqzIsaTp99r9N62O7Dlvix5jRG5bIDFnZrltMVm3Ds5DNEH?=
 =?us-ascii?Q?959f6cF4B6vPH565yzB8oQbwVwYRDBhA1awDZuYMjiGftcNmeJ9mIQ0+ADaz?=
 =?us-ascii?Q?QgFU36McPOvlsQE4I5rQYhMIMIGLHRwT8DVBd+gKcIJAhB5jFdGB46IDXVUe?=
 =?us-ascii?Q?mLNINXH8b957dg54Wgzx8hVKCpv6uPI5rzt4+y/2eu6t5AQtZeeNMQPxegyH?=
 =?us-ascii?Q?d2lxqNkJ/2UUkjpNTNVefzo3pj/CePDGCCW5gZH5SA1uQmJPGIlC/h+ikQxn?=
 =?us-ascii?Q?snt+AbXVfbtVWf+9tqZj2gYIK10XHaCk8n9/hcyntx8HmtpJZL1YGtzqqTrc?=
 =?us-ascii?Q?j3tWpoIYw1qBma9l0+3F3q5zuD3JKYlo5J7p68FBEaR0WH45KJg9tw011MeZ?=
 =?us-ascii?Q?ns+G8Q7d8YluE3ZZHscop+5+5n8gtn3fYb9xoXZ5c7VQW5F9dVXa48/gYtkR?=
 =?us-ascii?Q?igZ1bcPdkQBQAmDoEYSdg4AiyaLRDKGltCKdapRY7IxiR1jpXyUc39Xua8ta?=
 =?us-ascii?Q?8S1BSPOUT3ITtOF+9bJxMQxNbYv7JYsgUgZoMY3HQSr6lbRx5DcgDwAXOhgL?=
 =?us-ascii?Q?O7xlkJ+QVhTq0aifLfOiT5e3s63nnxwOGNGYchwoeQu05XGEiTkbw4ts9wzJ?=
 =?us-ascii?Q?dw2EPqFQ71MeAVBsrUougBJhb5xcaex2atRSsPI5Nt/4d3DTuK9fNPvPwz5o?=
 =?us-ascii?Q?ko1GlJFvojFcqBdJ+eFeXFflXXk9/752Tu5suYiU/Ymnqip1JBGjSxYfIlGo?=
 =?us-ascii?Q?2Ms7UTY+t6CsM2B0H52X3YT7wd3lW5wCtCAYZLr4efYcu77BsGLy3aBtlt8B?=
 =?us-ascii?Q?kIdetgzEMU6TxUTugpJfYdaZveSpCQmc0T8MQR1EoX5x+L1AXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:19:26.0385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa7d8ae-a113-441e-0ff1-08dcb20b09f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143

Move generic dmic codec helper function implementation to
sdw_utils folder so that this function can be used by other platform
machine drivers.

Link: https://github.com/thesofproject/linux/pull/5068
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc_sdw_utils.h                             | 4 ++++
 sound/soc/intel/boards/Makefile                           | 1 -
 sound/soc/intel/boards/sof_sdw_common.h                   | 3 ---
 sound/soc/sdw_utils/Makefile                              | 2 +-
 .../boards/sof_sdw_dmic.c => sdw_utils/soc_sdw_dmic.c}    | 8 +++++---
 5 files changed, 10 insertions(+), 8 deletions(-)
 rename sound/soc/{intel/boards/sof_sdw_dmic.c => sdw_utils/soc_sdw_dmic.c} (76%)

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index 7ca3a6afdfb1..0ffbd9847532 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -68,4 +68,8 @@ const char *asoc_sdw_get_codec_name(struct device *dev,
 				    const struct asoc_sdw_codec_info *codec_info,
 				    const struct snd_soc_acpi_link_adr *adr_link,
 				    int adr_index);
+
+/* DMIC support */
+int asoc_sdw_dmic_init(struct snd_soc_pcm_runtime *rtd);
+
 #endif
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index dc6fe110f279..8ac6f7b5fbee 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -43,7 +43,6 @@ snd-soc-sof-sdw-y += sof_sdw.o				\
 			sof_sdw_rt_dmic.o			\
 			sof_sdw_cs42l42.o sof_sdw_cs42l43.o	\
 			sof_sdw_cs_amp.o			\
-			sof_sdw_dmic.o				\
 			sof_sdw_hdmi.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH) += snd-soc-sof_rt5682.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH) += snd-soc-sof_cs42l42.o
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 688cbc3afb29..81b654407651 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -97,9 +97,6 @@ int sof_sdw_hdmi_init(struct snd_soc_pcm_runtime *rtd);
 
 int sof_sdw_hdmi_card_late_probe(struct snd_soc_card *card);
 
-/* DMIC support */
-int asoc_sdw_dmic_init(struct snd_soc_pcm_runtime *rtd);
-
 /* RT711 support */
 int asoc_sdw_rt711_init(struct snd_soc_card *card,
 			struct snd_soc_dai_link *dai_links,
diff --git a/sound/soc/sdw_utils/Makefile b/sound/soc/sdw_utils/Makefile
index 29b2852be287..de8aff8744d8 100644
--- a/sound/soc/sdw_utils/Makefile
+++ b/sound/soc/sdw_utils/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-snd-soc-sdw-utils-y := soc_sdw_utils.o
+snd-soc-sdw-utils-y := soc_sdw_utils.o soc_sdw_dmic.o
 obj-$(CONFIG_SND_SOC_SDW_UTILS) += snd-soc-sdw-utils.o
diff --git a/sound/soc/intel/boards/sof_sdw_dmic.c b/sound/soc/sdw_utils/soc_sdw_dmic.c
similarity index 76%
rename from sound/soc/intel/boards/sof_sdw_dmic.c
rename to sound/soc/sdw_utils/soc_sdw_dmic.c
index d9f2e072f401..fc2aae985084 100644
--- a/sound/soc/intel/boards/sof_sdw_dmic.c
+++ b/sound/soc/sdw_utils/soc_sdw_dmic.c
@@ -1,14 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// This file incorporates work covered by the following copyright notice:
 // Copyright (c) 2020 Intel Corporation
+// Copyright (c) 2024 Advanced Micro Devices, Inc.
 
 /*
- *  sof_sdw_dmic - Helpers to handle dmic from generic machine driver
+ *  soc_sdw_dmic - Helpers to handle dmic from generic machine driver
  */
 
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-dapm.h>
-#include "sof_sdw_common.h"
+#include <sound/soc_sdw_utils.h>
 
 static const struct snd_soc_dapm_widget dmic_widgets[] = {
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
@@ -40,4 +42,4 @@ int asoc_sdw_dmic_init(struct snd_soc_pcm_runtime *rtd)
 
 	return ret;
 }
-
+EXPORT_SYMBOL_NS(asoc_sdw_dmic_init, SND_SOC_SDW_UTILS);
-- 
2.34.1


