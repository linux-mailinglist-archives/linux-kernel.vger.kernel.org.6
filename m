Return-Path: <linux-kernel+bounces-407496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4789C6E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3906B26632
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0293A200B88;
	Wed, 13 Nov 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1xxKJ9L"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068320127F;
	Wed, 13 Nov 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498783; cv=fail; b=GSCu/icni9Mr9QXjo3kU1hQi2pyrWgXCKF38gAwgAeOCdIt8ADtMwRTun7RwynFT1X/hRHNCGdAy1UmGVvpJFkTgLPAYz/vHHjJoXABkMOqOTAakizQAVrKeg/MAgxEg5C8YtdD1dw1COtAWUhsyv3XnYRRU/oBNoQ9lZvqN8Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498783; c=relaxed/simple;
	bh=baO/Jyx2PEQT/zbHVAZKCewu+Snhh4LkEhDZxtBpbWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqIRJGW5XWYy3rRRZ5I9/xC4efk6/WlsDUv+OHdSgXMT8ARZZqHq5gaFns5GmhrqPM/YT04YoB7x52jIjEle4fw97SUtuitx9WbJ+EyA8vKVSxwhXMmfMoL4nwMUuTihml1qcFtn8ib4PGlVRovm7FYPkOVVc2FIk1ygqQ0hKrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1xxKJ9L; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZiuGlAIxl4hskKX3XTNoNh2nfYqcKGte/J0gJPI26lNtSt1+bN4tTWE/8BDBY0EN9MlfhYbE8qK3uaJThO2yKThcTlQoFjJ/Oi+n+ucOlCCgNdnQDT2oE3nRlKj+Mfoa3kHPI+KWslr0hzT4OXtJygS2Zk9O8eGvzz5soLbCRaANJaQjawPIMIqMRVE7b01iAghe+HYpzbTEcA7XIlmzrZhmmVWFq7pM0+S0AFu2bTGbAZVjR8IpAO/3aUbMuhPMTZkgypzZUv47kOzyXFxZWljB94hy4V0KYbTBlHG1TTeju/AYY0ZHwNaAVr4eNGsIkpkDokWNUFXFTR1a1h+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0jKxVnJ8L/+NhJd9LuQSDeXcLIk0CkNk7yi4xX6TbU=;
 b=OfZoAQpNeaX7UrZHx1ydc7zrZXmKm5+60uHQQlmKmLv7JZGDT6IjWk7eeNJwm1NeFi1sVUvzIIb+L5KbJIO9H6iyebNfK82Wxo8eQHrHFktmBGysqdaFk4aqj0PbCWUOD9WXhgvEx+D0PWNXUNfitwx9IV8wb4tjOkDEQ85qAc//Qs8ygcuMf/ANRPztE5cpORuF9JXuoqA7JhGg+ywJ1QDODvyzMrY3L5yunuOUAIV4RmNSPTxzqn7MAGv3kQLzoj2UMhqyTay4wsB5ghpui90+PbXJHQz8NR0f/man3MlNYEKMs647mAnJ4FKT0q7JKAIM/XtlN/akiMuH2i/X3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0jKxVnJ8L/+NhJd9LuQSDeXcLIk0CkNk7yi4xX6TbU=;
 b=s1xxKJ9LET129Zz9fBnHKh3cqLl2mzPjZHRKenv7SQnEdm6+HNaYiLS6gPlJJmxqbPvW7RZ4QjQBua8la/jJgT1h6tKgCCWGwCwdud5upg2Pvc4TAQeIfXdRVrADdqq24vPdp8oJpVeecUmwW0ALwLRUriQ9aI6M7Qn0Mq8oMTo=
Received: from SJ0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:a03:3a0::33)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 11:52:57 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::f6) by SJ0PR03CA0268.outlook.office365.com
 (2603:10b6:a03:3a0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 11:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 11:52:57 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 05:52:53 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 4/6] ASoC: amd: acp: move get_acp63_cpu_pin_id() to common file
Date: Wed, 13 Nov 2024 17:22:21 +0530
Message-ID: <20241113115223.3274868-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113115223.3274868-1-Vijendar.Mukunda@amd.com>
References: <20241113115223.3274868-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b5c104-f051-4c00-9c38-08dd03d9b77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eec6gU+32nLMXyDmNYzSmEcVS3cBolQ1wpnDWo9rKAf9cvzswobByK40I1zX?=
 =?us-ascii?Q?QjVMBJ7w8GJPm1OJ9wZDbeC0tYyTv17tBsnVXieDWc///77OPtcoWBQNdk/u?=
 =?us-ascii?Q?qfWe+YbRGCWZ0NzXZPN5TkBAonL2H92MPIEd81FPUnsa5GD9uCas9lwHVOQ6?=
 =?us-ascii?Q?e3Tso4KW3MlK2ROtISoetsCZWEL8jKeWi66ZGphXRZ0rHHrdzSAqfDBXJJk+?=
 =?us-ascii?Q?iZaG1txuV0PhC5qDvy5OoIEcdas3DmKA/S/WrNQGArkty8xVv6xoinB9chET?=
 =?us-ascii?Q?FUs94DS2qK6z3z4jbjQXrZNQ9YqyASw+mjZ8ra3d+AFs/Vi76b4buNNlJorY?=
 =?us-ascii?Q?wRYeM+KdOYRwzLOwFeeuvaqctNvDhL7TXNbZSyWUfa2/G6Klxn2tbJPXGRvA?=
 =?us-ascii?Q?H+Yrx5lwi9KtSu/FFlJ990PE9TvbacQRLMC/Rkk3e0bs8Qr6pNAdeED53P3g?=
 =?us-ascii?Q?V+JByirCq2IksAmw2Grc6s+Azs0ooL6xyehWHKNJADSULpsWmRq37R2M9FzW?=
 =?us-ascii?Q?HqnWK61vsITvw8N5oXnJFT/FlU5MlLQl+FsUOO1faAUbJL/Slztetjh3bkYA?=
 =?us-ascii?Q?0UOudWNSpSd6h+ULhYgD3yx8PpH8+HuDkbzHRQEsf1T7q54x8GBrS7RrLrYT?=
 =?us-ascii?Q?nHcB01AdvCT/FTezkAOl2VtascsF80DPP60hk3fL/a+jw7zR26MQulRXrafZ?=
 =?us-ascii?Q?wcZPIuQptC1TAwrxg0tmvU6e7IiOVijxp8OIQbEw9fu+L7zse9p80QXmmKfw?=
 =?us-ascii?Q?ohDKHov6EXc0jkU8heFtzZeaMmB16YTPL6tukhtNTRlOEiouvL67VxsyJHdC?=
 =?us-ascii?Q?AgkJnF+xYG9PNzN11AhfapwWS3i+/+6rXF9Mmgup6xGoDVJYTZ2X3khp34gA?=
 =?us-ascii?Q?YEpdkZOq3QZSJMam+njqOTnGbusUY89DZrhPctLmH8Vb1glQukP6wREFTj33?=
 =?us-ascii?Q?Vk6LVvnPcA81vkbUVA1MnGJ0Milwv+rt/XYSfVPaGuGvA6ZKEBv7jz5mrNBv?=
 =?us-ascii?Q?C2sFA1xhlF0mEIsAOIrAlH2o/TwTSc70Na/00Tlp6rXs1ux0B0AKAcdq+x96?=
 =?us-ascii?Q?quyM1MoBYG2OOPbKB1fy5wpXxXCw0HSZJRu8lt2WdBjQmJ4NY5sTBGJHJkgu?=
 =?us-ascii?Q?teqCKru1zmEil8Zvhd+0HKDpHxub2gSboUXGtaq2NlIyomQOCG4X/HgDsEO0?=
 =?us-ascii?Q?DVCCgiLYphQnt+J4WMMnxTMjdtB8V2XOzKJ+zWPVOdNz2348CkL79rWkv5dK?=
 =?us-ascii?Q?wLh0pS4BblivrWtYeQNzQDn24S/zKZbtAgtb+pYxkqXYwykx3xiIQxl3s1XM?=
 =?us-ascii?Q?+SMT3Np19pDvyn6gQfaz2G8XDnwkwNjRIZdy4v3DzIkmyWGHbR+doQCNP54H?=
 =?us-ascii?Q?st7cY+vrmdyJ9wOKgU/ULqaJK7CAmRbTZOjO8mvI/iAtTV9grw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 11:52:57.5943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b5c104-f051-4c00-9c38-08dd03d9b77c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

get_acp63_cpu_pin_id() is the common SoundWire machine driver
helper function will be used for AMD Legacy(No DSP) generic
SoundWire machine driver as well.
Move get_acp63_cpu_pin_id() function to common place holder.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/Kconfig               |  7 +++
 sound/soc/amd/acp/Makefile              |  2 +
 sound/soc/amd/acp/acp-sdw-mach-common.c | 64 +++++++++++++++++++++++++
 sound/soc/amd/acp/acp-sdw-sof-mach.c    | 49 +------------------
 sound/soc/amd/acp/soc_amd_sdw_common.h  |  2 +
 5 files changed, 76 insertions(+), 48 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp-sdw-mach-common.c

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 88391e4c17e3..acd047d558bd 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -119,10 +119,17 @@ config SND_SOC_AMD_SOF_MACH
 	help
 	  This option enables SOF sound card support for ACP audio.
 
+config SND_SOC_AMD_SDW_MACH_COMMON
+	tristate
+	help
+	  This option enables common SoundWire Machine driver module for
+	  AMD platforms.
+
 config SND_SOC_AMD_SOF_SDW_MACH
 	tristate "AMD SOF Soundwire Machine Driver Support"
 	depends on X86 && PCI && ACPI
 	depends on SOUNDWIRE
+	select SND_SOC_AMD_SDW_MACH_COMMON
 	select SND_SOC_SDW_UTILS
 	select SND_SOC_DMIC
 	select SND_SOC_RT711_SDW
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index 82cf5d180b3a..0e6c4022e7a2 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -23,6 +23,7 @@ snd-acp-mach-y     := acp-mach-common.o
 snd-acp-legacy-mach-y     := acp-legacy-mach.o acp3x-es83xx/acp3x-es83xx.o
 snd-acp-sof-mach-y     := acp-sof-mach.o
 snd-soc-acpi-amd-match-y := amd-acp63-acpi-match.o
+snd-acp-sdw-mach-y     := acp-sdw-mach-common.o
 snd-acp-sdw-sof-mach-y += acp-sdw-sof-mach.o
 
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCM) += snd-acp-pcm.o
@@ -41,4 +42,5 @@ obj-$(CONFIG_SND_SOC_AMD_MACH_COMMON) += snd-acp-mach.o
 obj-$(CONFIG_SND_SOC_AMD_LEGACY_MACH) += snd-acp-legacy-mach.o
 obj-$(CONFIG_SND_SOC_AMD_SOF_MACH) += snd-acp-sof-mach.o
 obj-$(CONFIG_SND_SOC_ACPI_AMD_MATCH) += snd-soc-acpi-amd-match.o
+obj-$(CONFIG_SND_SOC_AMD_SDW_MACH_COMMON) += snd-acp-sdw-mach.o
 obj-$(CONFIG_SND_SOC_AMD_SOF_SDW_MACH) += snd-acp-sdw-sof-mach.o
diff --git a/sound/soc/amd/acp/acp-sdw-mach-common.c b/sound/soc/amd/acp/acp-sdw-mach-common.c
new file mode 100644
index 000000000000..d9393cc4a302
--- /dev/null
+++ b/sound/soc/amd/acp/acp-sdw-mach-common.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2024 Advanced Micro Devices, Inc.
+
+/*
+ *  acp-sdw-mach-common - Common machine driver helper functions for
+ *  legacy(No DSP) stack and SOF stack.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include "soc_amd_sdw_common.h"
+
+int get_acp63_cpu_pin_id(u32 sdw_link_id, int be_id, int *cpu_pin_id, struct device *dev)
+{
+	switch (sdw_link_id) {
+	case AMD_SDW0:
+		switch (be_id) {
+		case SOC_SDW_JACK_OUT_DAI_ID:
+			*cpu_pin_id = ACP63_SW0_AUDIO0_TX;
+			break;
+		case SOC_SDW_JACK_IN_DAI_ID:
+			*cpu_pin_id = ACP63_SW0_AUDIO0_RX;
+			break;
+		case SOC_SDW_AMP_OUT_DAI_ID:
+			*cpu_pin_id = ACP63_SW0_AUDIO1_TX;
+			break;
+		case SOC_SDW_AMP_IN_DAI_ID:
+			*cpu_pin_id = ACP63_SW0_AUDIO1_RX;
+			break;
+		case SOC_SDW_DMIC_DAI_ID:
+			*cpu_pin_id = ACP63_SW0_AUDIO2_RX;
+			break;
+		default:
+			dev_err(dev, "Invalid be id:%d\n", be_id);
+			return -EINVAL;
+		}
+		break;
+	case AMD_SDW1:
+		switch (be_id) {
+		case SOC_SDW_JACK_OUT_DAI_ID:
+		case SOC_SDW_AMP_OUT_DAI_ID:
+			*cpu_pin_id = ACP63_SW1_AUDIO0_TX;
+			break;
+		case SOC_SDW_JACK_IN_DAI_ID:
+		case SOC_SDW_AMP_IN_DAI_ID:
+		case SOC_SDW_DMIC_DAI_ID:
+			*cpu_pin_id = ACP63_SW1_AUDIO0_RX;
+			break;
+		default:
+			dev_err(dev, "invalid be_id:%d\n", be_id);
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(dev, "Invalid link id:%d\n", sdw_link_id);
+		return -EINVAL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(get_acp63_cpu_pin_id, SND_SOC_AMD_SDW_MACH);
+
+MODULE_DESCRIPTION("AMD SoundWire Common Machine driver");
+MODULE_AUTHOR("Vijendar Mukunda <Vijendar.Mukunda@amd.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 8fce8cb957c9..0d256c0749c9 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -64,54 +64,6 @@ static const struct snd_soc_ops sdw_ops = {
 	.shutdown = asoc_sdw_shutdown,
 };
 
-static int get_acp63_cpu_pin_id(u32 sdw_link_id, int be_id, int *cpu_pin_id, struct device *dev)
-{
-	switch (sdw_link_id) {
-	case AMD_SDW0:
-		switch (be_id) {
-		case SOC_SDW_JACK_OUT_DAI_ID:
-			*cpu_pin_id = ACP63_SW0_AUDIO0_TX;
-			break;
-		case SOC_SDW_JACK_IN_DAI_ID:
-			*cpu_pin_id = ACP63_SW0_AUDIO0_RX;
-			break;
-		case SOC_SDW_AMP_OUT_DAI_ID:
-			*cpu_pin_id = ACP63_SW0_AUDIO1_TX;
-			break;
-		case SOC_SDW_AMP_IN_DAI_ID:
-			*cpu_pin_id = ACP63_SW0_AUDIO1_RX;
-			break;
-		case SOC_SDW_DMIC_DAI_ID:
-			*cpu_pin_id = ACP63_SW0_AUDIO2_RX;
-			break;
-		default:
-			dev_err(dev, "Invalid be id:%d\n", be_id);
-			return -EINVAL;
-		}
-		break;
-	case AMD_SDW1:
-		switch (be_id) {
-		case SOC_SDW_JACK_OUT_DAI_ID:
-		case SOC_SDW_AMP_OUT_DAI_ID:
-			*cpu_pin_id = ACP63_SW1_AUDIO0_TX;
-			break;
-		case SOC_SDW_JACK_IN_DAI_ID:
-		case SOC_SDW_AMP_IN_DAI_ID:
-		case SOC_SDW_DMIC_DAI_ID:
-			*cpu_pin_id = ACP63_SW1_AUDIO0_RX;
-			break;
-		default:
-			dev_err(dev, "invalid be_id:%d\n", be_id);
-			return -EINVAL;
-		}
-		break;
-	default:
-		dev_err(dev, "Invalid link id:%d\n", sdw_link_id);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static const char * const type_strings[] = {"SimpleJack", "SmartAmp", "SmartMic"};
 
 static int create_sdw_dailink(struct snd_soc_card *card,
@@ -491,3 +443,4 @@ MODULE_DESCRIPTION("ASoC AMD SoundWire Generic Machine driver");
 MODULE_AUTHOR("Vijendar Mukunda <Vijendar.Mukunda@amd.com");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(SND_SOC_SDW_UTILS);
+MODULE_IMPORT_NS(SND_SOC_AMD_SDW_MACH);
diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
index f1bd5a7afc8e..eba92cd004d4 100644
--- a/sound/soc/amd/acp/soc_amd_sdw_common.h
+++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
@@ -41,4 +41,6 @@ struct amd_mc_ctx {
 	unsigned int max_sdw_links;
 };
 
+int get_acp63_cpu_pin_id(u32 sdw_link_id, int be_id, int *cpu_pin_id, struct device *dev);
+
 #endif
-- 
2.34.1


