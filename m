Return-Path: <linux-kernel+bounces-270720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5F4944478
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CDBEB24C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C691EB486;
	Thu,  1 Aug 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Amxm29we"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F87157A67;
	Thu,  1 Aug 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493809; cv=fail; b=Yn9BTeQKPc1NPrCkpbbuPqntkPZhvRtyN8fLb/Omvr3FDCL/DbGyXeaUiluVsWxGFs+VZMEZWteLcipNxRAu36WlaiCnoA6Xg45cOlM9JpPvdhbPDV38mIgVfKcWHZhSJPLiwLTMiElXtLQ0FGSg9Imop/4hKfeqi2VFqlFMfTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493809; c=relaxed/simple;
	bh=rx6H9awCtEys0PBAaSFFEHLXcC46ONFHPeHOOordOes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3eZMpu3nRCs+NRxIF665i59NMYUsOnNW5flf557jK2FJCs/OsDkJZR9jt7X6Rm8rA5ttv812j7QxNZyWv97qWo3AZzChslXm8EEo1b0iY2XD7WpJ5B6Gx8Ys3lC2dy/BTZ/BwXst548kEEEgouob3I7aRRxUdqKyV66nYEFHX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Amxm29we; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9pm1rW4jdH52LH8Avr+wu9eH2iXL3ysberevnAIxKqHevPTDFw27exZ/PXahQ2/4IHM7Cfv8ltk1XxFi+DVlyXWvEVYc1JpPQaZ23E3esL/WmKJnAFe+LzFwWrEe7ftZ29HhPcGchOtsLKQCEYAXLIEqiHLgT8veEw9O9vsJdS6YGW5pruGoGVhuQI3qAzlKSGAqy0NxY8AvA3P0B6OQUFHm5muGBoXcylZ7pbbkGUKSA1uxbXTcX3A2NGmIOaEmMTeBIIEy/IPfG+wpG/iBt5TiE2Wo3XJ3QFjpAUMLQhaBBjMrGSyRyzXL1RfKSeJU6ccjoK31iXO5v2hFfmYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUL0WKFSAgQUSTbpbD6fIs0hWRhgtQ0XCpq5Iu9xYc4=;
 b=G5a7aEydiH69seZ4RRgV3GaGOTmfQwrLig1hbodEyVHr7H2nn0jMXmEeY0xaBgoyearU/tWahCZ1juIAedaJ9hQrhMWACzDijjoAIaWKIknBHb5GlUd3hecuTjHFq+xpI4oYTIlHsJIZhSlxdWBJF3ZrnV+HxkzPRHbD2Kwzm1wm1AfsZhHM/Nfe9QEr2vsOgNnxsm7gpqA72BsUUeUCSD/rk3uemIlY+G1A+K0FwwCiuTVgXy0k7u6OYhybhhoyCGpRRQOsElEYITEDCun9HQp7dHbEYRMGLBQbDo3I0vR6RvXWfvodROZC4yRBrTUSQ+QWuOIMRUS2yWxCIS+dPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUL0WKFSAgQUSTbpbD6fIs0hWRhgtQ0XCpq5Iu9xYc4=;
 b=Amxm29weqp0tdHSjhO363llMp8q9C9opqcXLVtTH8IHMV1ZcaFC60qKIBi1/EUsFCgzriu16A+SujL0Vk7pbYJF3jyUTmYFkFJjew6RwDM1SvQmiww7Jnbw+7K77xoEPTE4WXFJfS4ZqNGPNx4E6AS63Co2UiGrcIDJ1Dj3CkaQ=
Received: from DM6PR01CA0005.prod.exchangelabs.com (2603:10b6:5:296::10) by
 DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Thu, 1 Aug 2024 06:30:04 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::db) by DM6PR01CA0005.outlook.office365.com
 (2603:10b6:5:296::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 06:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 06:30:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 01:30:03 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 01:29:56 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
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
Subject: [PATCH 13/31] ASoC: intel/sdw_utils: move rt722 sdca helper functions
Date: Thu, 1 Aug 2024 11:53:58 +0530
Message-ID: <20240801062416.2203673-14-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801062416.2203673-1-Vijendar.Mukunda@amd.com>
References: <20240801062416.2203673-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b70eaa7-6169-4088-74e5-08dcb1f3612f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iWIZeeeqUKWLzlwfImSCfszR4gYKYnZZYjzkv5ljkgChwMLObb2Zs+7yt8zB?=
 =?us-ascii?Q?/WLeuNm2ug/tkahX6r6jHMOCdbLN2unyolbB7Ja/nsOz7rmjzlC2l5ZUQPce?=
 =?us-ascii?Q?VTZ22yamrbDYEDDEr9lD2hEGy51JVUw4nmjW/VRiiNxMz7WKL7kRmxh+uLg5?=
 =?us-ascii?Q?eQEQr1N3OJpx876wVNPqCqtR8hLYqPkiyDrNfxuIcJCqvCfGG1KAaFH5iZE1?=
 =?us-ascii?Q?+w8kj50ehY3pHee4PhKlxFjvLUV+pvAmaIJtF2mqtKkaDKEi72lJuyDSlRtI?=
 =?us-ascii?Q?dJ46nRwDRUw7JJMPGz5uV7/Yuq1WNMb0x5aVMOv3CQXw/adRFOabQwxm64rT?=
 =?us-ascii?Q?+9c8tyRMcxejjqPNStqzJrY2JNQhKu6fkXl70Nn6oVj/8hr0eSqiqPb9DUY0?=
 =?us-ascii?Q?8mBdwYBlRqaTdnNB1EeHKkWi0bl/dVlzPkpJeUNdM5zlTBIkCY+y4+Jg0TLu?=
 =?us-ascii?Q?6JImHj7pCSNz3Byzu2rYVaH9+7IkwgTLkKwYP0BwoxxDbTPn3T8yrIPTPpuI?=
 =?us-ascii?Q?MVRtTkuv7VRv4gnAWJr7tx8DXLkXCPaX/MSzH1D+APFdrBZzWfJgwJT6lXG7?=
 =?us-ascii?Q?85EDZaGuKaKVvizJh3V195PXX51G5mas8213ns9RKPz8zPOp1+EvDLMp86SE?=
 =?us-ascii?Q?tkWl9LktEW4HinVGiBXwq05cFnwh+YPJx3A2kA/7xbp19bou+Pv0goubWnDh?=
 =?us-ascii?Q?WDcAJtCRfldbcI0X8GJpKPRyxK8fxdGdAJBfS+px164otS2jUh7gY1TnHjGo?=
 =?us-ascii?Q?Bp3uwCzNCoEH9ZuOrnrcLF865XVMji3staLOIrlnkGfkm6667mI7e58okrOO?=
 =?us-ascii?Q?mu2T0zjCvVNFh34Rs3r/pXEzV/6na+ylyZ+1bnHvzv8/u33Z/A/KSTbHTjng?=
 =?us-ascii?Q?CayvcncfE+Mw6+cNiobZMTkii+FSgQbQ4HJzr2E4t6OQaMnBuheyp9eh9NCi?=
 =?us-ascii?Q?D+9sv5TvDCy7gJZpsq93rrMQhRpV1mF0EIJt5x3ajIZk1vdYrhmlfF1/nEf7?=
 =?us-ascii?Q?JyYumjj+IHErYnanFUjUvFbxki8ll5ohvPhNeb/n8E8D9W5wHckiaOrsVhPv?=
 =?us-ascii?Q?ag1I6ZeRKrsyoAws8BgPezO7KXTkpxB2NA7ytXAqLZQkM/njek2WhEo5GiXg?=
 =?us-ascii?Q?lW4/9r4cNhvVNEN9LG62SaIgNuQI4844bY8eDbsCcFkJpJihs7R7qzeyxR9E?=
 =?us-ascii?Q?ITcf4xGBwfHLF0HgL4tu081o/QN+pY6ZbSy7lToXKZSRSxQORSKq+pWv1YBa?=
 =?us-ascii?Q?1H8ZZhqQ1mLlqcxEeMAWQI2sBTn1k9ShjoQid2ykEKxMo3tZn/Nf+tyaxGQD?=
 =?us-ascii?Q?EHLN7YsqYUYGOZmwmvghtboLXw6ZjInBqnIJ2hRGnfvsPoru+GtnUzvUs6FO?=
 =?us-ascii?Q?ggthici0LkJJYI5CV/cPsFKMjZo0EK29J1SeHGo/YMm6lHan1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 06:30:04.4343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b70eaa7-6169-4088-74e5-08dcb1f3612f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

Move RT722 SDCA codec helper file to sdw_utils folder to make it generic.

Link: https://github.com/thesofproject/linux/pull/5068
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc_sdw_utils.h                             | 1 +
 sound/soc/intel/boards/Makefile                           | 1 -
 sound/soc/intel/boards/sof_sdw_common.h                   | 1 -
 sound/soc/sdw_utils/Makefile                              | 2 +-
 .../soc_sdw_rt722_sdca.c}                                 | 8 +++++---
 5 files changed, 7 insertions(+), 6 deletions(-)
 rename sound/soc/{intel/boards/sof_sdw_rt722_sdca.c => sdw_utils/soc_sdw_rt722_sdca.c} (75%)

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index 6fd305253e2a..5bc2a89bced4 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -75,5 +75,6 @@ int asoc_sdw_dmic_init(struct snd_soc_pcm_runtime *rtd);
 /* dai_link init callbacks */
 int asoc_sdw_rt_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt712_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
+int asoc_sdw_rt722_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 
 #endif
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 3bc9d25fc9bb..f3baf9ecfbb7 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -39,7 +39,6 @@ snd-soc-sof-sdw-y += sof_sdw.o				\
 			bridge_cs35l56.o			\
 			sof_sdw_rt5682.o sof_sdw_rt700.o	\
 			sof_sdw_rt711.o sof_sdw_rt_sdca_jack_common.o	\
-			sof_sdw_rt722_sdca.o			\
 			sof_sdw_cs42l42.o sof_sdw_cs42l43.o	\
 			sof_sdw_cs_amp.o			\
 			sof_sdw_hdmi.o
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index b190aae1e093..c7672dc1320c 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -160,7 +160,6 @@ int asoc_sdw_maxim_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_
 int asoc_sdw_rt5682_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt700_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt711_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
-int asoc_sdw_rt722_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt_amp_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt_sdca_jack_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 
diff --git a/sound/soc/sdw_utils/Makefile b/sound/soc/sdw_utils/Makefile
index f9a2baa49617..261c60098e88 100644
--- a/sound/soc/sdw_utils/Makefile
+++ b/sound/soc/sdw_utils/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 snd-soc-sdw-utils-y := soc_sdw_utils.o soc_sdw_dmic.o soc_sdw_rt_dmic.o \
-		       soc_sdw_rt712_sdca.o
+		       soc_sdw_rt712_sdca.o soc_sdw_rt722_sdca.o
 obj-$(CONFIG_SND_SOC_SDW_UTILS) += snd-soc-sdw-utils.o
diff --git a/sound/soc/intel/boards/sof_sdw_rt722_sdca.c b/sound/soc/sdw_utils/soc_sdw_rt722_sdca.c
similarity index 75%
rename from sound/soc/intel/boards/sof_sdw_rt722_sdca.c
rename to sound/soc/sdw_utils/soc_sdw_rt722_sdca.c
index 2da9134ad1a3..6a402172289f 100644
--- a/sound/soc/intel/boards/sof_sdw_rt722_sdca.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt722_sdca.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// This file incorporates work covered by the following copyright notice:
 // Copyright (c) 2023 Intel Corporation
+// Copyright (c) 2024 Advanced Micro Devices, Inc.
 
 /*
- *  sof_sdw_rt722_sdca - Helpers to handle RT722-SDCA from generic machine driver
+ *  soc_sdw_rt722_sdca - Helpers to handle RT722-SDCA from generic machine driver
  */
 
 #include <linux/device.h>
@@ -13,7 +15,7 @@
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-dapm.h>
-#include "sof_sdw_common.h"
+#include <sound/soc_sdw_utils.h>
 
 static const struct snd_soc_dapm_route rt722_spk_map[] = {
 	{ "Speaker", NULL, "rt722 SPK" },
@@ -36,4 +38,4 @@ int asoc_sdw_rt722_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_
 
 	return ret;
 }
-
+EXPORT_SYMBOL_NS(asoc_sdw_rt722_spk_rtd_init, SND_SOC_SDW_UTILS);
-- 
2.34.1


