Return-Path: <linux-kernel+bounces-270729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B33944489
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4334C1F23157
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D84157481;
	Thu,  1 Aug 2024 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lU4X4Mzv"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51D15748A;
	Thu,  1 Aug 2024 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493974; cv=fail; b=q99FFqvwoyOAXMAHLiz3d7iaXJs3mdelbzxxbYlr+wPQfJcyc46iVi9b/E5JQI7r1X0t9/oK7S3wj+XNDvnzhPs/c47eQ/noNP+hGO3qTAuO0tz4zzoPjqdkw9wXWiKt2YmLt/57whhLNGIDpRq8HHuitJ8qQLLMt/rczWHQ4HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493974; c=relaxed/simple;
	bh=mO7YQ+kpTp1+yWnA682z7NdxMzu/Rh2XK0nHxXaUbVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lG4yr/+0hbjPWiz+N+1I1QPCrwLpjeXLvLZPzxnCDkDDFfZiN91rsUaSKp9z0edEQAtUbkdJQu6h9XF6OfcfH6nCKqG+5zDcN4uOnTOu5bWO+j5YbzaYBfHh/Oqb++mnsVjTjTnkpgjcDMjkfL6UySyVv2ScqIucKZHnxFoc08o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lU4X4Mzv; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH5OzYT8HFDxnHYQLJL5CO3ypneD+nFzGtXlyNhO+SQPH1tdB2V6LOwjGoe2WBvarllRTjS0jzDnZtdjAZJu3AKmWCnFSJ9vpnCA6NlX/A2ZI/BN5d7sauoTPUZItFS8pnbQf+l0zSPXNGh1ID0PIXiUDU1RJa+QO/EXWw8CvNyEqUdZx9vEgtNZeUCP6Yfc3nyCJX/DJBo8xauFJc0z0tUMyEtZ9dQ0/w66TFwIxZQMJuht5gfNy9Vs29KdUdZY3WjsESHSJCrf0Uf61av7ABSoJAURb71/t1J7gq+2logiHVvj08k+L6G2fY7WkLsaRkuUJoNdJGcCRC9Xjxz47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbozI4ddjgSv9+7bNOMeGoYJHbEvkkiHespHtCIOw/0=;
 b=Rkx7HdeOs9DGpPigWjuAoS8qU6m/V3p3DC1ouBZBWzoHTDEUqM1MiCitzbb8H9zCW8MbQ3FrWsLFHjpQOwErGdHky7BdTmnnINYePNTtXCQEEZbAGue4T0TSXKbcXidGcn7an/oCArKq9R7M53GgAdl5aKT0ZJvzSLV8lH2lakTXl8ZIqp7CG5wfhSrWcdCaN5f+mz+9pCAjLeljMk5Xat3ZEvzx6Ls6eiqcE1bBhOm4P3sEiNwVnna8QJ/NjTUuKIf2AcXSQJw/vXMbnbPJiEdfQFu4dpEAH5LJIlp3PQoc9t2kLJPse01Eyhz5NAykMVl1Nl3GoM930rYpz19vmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbozI4ddjgSv9+7bNOMeGoYJHbEvkkiHespHtCIOw/0=;
 b=lU4X4Mzv5B7lmKUzIdzc6Haanfh9Ld2t8n3yNmwjlsvoLRZv3Yu1Ai5kRSczsjhgKr3DxJInjo7DE3GBN52FYWwkY3EuBUiYQY7wGzTIeLW/lwF9Yf3bsxEhg3dgA5HrHycPmz07HyAf58BlV6xRAC6Kd28m4nPkvOvDpZQ4eMU=
Received: from MW4PR04CA0060.namprd04.prod.outlook.com (2603:10b6:303:6a::35)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 06:32:48 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::dd) by MW4PR04CA0060.outlook.office365.com
 (2603:10b6:303:6a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22 via Frontend
 Transport; Thu, 1 Aug 2024 06:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 06:32:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 01:32:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 01:32:46 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 01:32:39 -0500
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
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 18/31] ASoC: intel/sdw_utils: move rtk amp codec helper functions
Date: Thu, 1 Aug 2024 11:54:03 +0530
Message-ID: <20240801062416.2203673-19-Vijendar.Mukunda@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da937cc-34b4-4022-bbee-08dcb1f3c279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jvlkt7w9HqDpheUF4CNxc1ai1WKBO+EPGK+3o0o+jftbdBT3zoUAtI6Vz5l3?=
 =?us-ascii?Q?878i2EhnXEMH8pMJz1fWk6arjFe+V6Yby+1KA72aR19C0gECNaucLrT7G5Yz?=
 =?us-ascii?Q?IFz30Gq5b3swk6fCegqtpegfKtDyNWGiCK0ibeNydzpyzhSleYrA/UinF6hb?=
 =?us-ascii?Q?/B70LJCQakzks7u96md7oy2XwV9+CTnJME8k/LBrqHBoUSfeqaA28Slz0fjF?=
 =?us-ascii?Q?DzHF4k43rrZuhjVcF702YazUWmCdOVYelT2wQw45vAALxBXe9qhjPvRF+JTm?=
 =?us-ascii?Q?BRgXT6G9clg4Twci0hgYVwhYTWWTCdl+LK0GntmnowNWYRl1RVYrfbUnrtSC?=
 =?us-ascii?Q?1Di0AI0HxgQWGQMesyXLE8WWevzjonWOcEk2s9qTJVbqn30LgTUwSqCUi1m8?=
 =?us-ascii?Q?kUl0SnoUrHbHF0FCCuCb1e0vKC/fbN/BCysnIxBMOMzs7tekWlghAk6J6Tfc?=
 =?us-ascii?Q?9YUStipM3No8sgcrU1g5ph2qX3NwO4wsc3x5SL9l7SMuwWiuRy4yzqatr5w8?=
 =?us-ascii?Q?RL1N2hLolcdWwwboeaxxc9goq/kuiXaheH/NvBZhPEgyO4bAFpo1TOTHitoS?=
 =?us-ascii?Q?U0uR9GCElvzaq3mM4IlWVT5pU+Ui/PS3TtxRn9ixUxUrDiwCXf71LNNg5Ll6?=
 =?us-ascii?Q?5Wt8c5KJ2fxQI2pEw17k2rrj/wXA/r1BBnu4q34rEj+g6v58mnWu3Sbc40Qr?=
 =?us-ascii?Q?96RwNfbMunMTNgEsHeyKJ9EyzL5GVhAx7aBMuGrM/PmrGsTRXdlKQ3X39GlE?=
 =?us-ascii?Q?swP7ezg7OccWCGirSAbgdGnUPeTh9Dsd+Cua/bufn9WKLmZ7JUhW2EjTHuvm?=
 =?us-ascii?Q?0e0P+6N5ggFW8VkSAsm59k/mhwFNLPpvkeT4QIfuUuIIJ0sY6PNbRyGnu/aK?=
 =?us-ascii?Q?dpDGsQLmz3Vn8pO5VmuxbJThVze2Efq8qOBXzhbkF23OseJcafgaX8aNAo23?=
 =?us-ascii?Q?LB36t6xeWcdEmjYqP6/6yyTkMURTkkgwl8dmNEJe2iw+izakCJ9A0RWOUP59?=
 =?us-ascii?Q?qT2HYs5D09Ghq/OzYoWchN6PTBO+HOVafe78AfLhMYK0WYn+Xepc8wfSCEWu?=
 =?us-ascii?Q?PGYhdTnD4CyNhXa+cUbduC2gpMl1LgOmsD8vI0Ofu+U8WD0YcGaiteYlGLJB?=
 =?us-ascii?Q?kLHCgzL8x/C+NEDfm+KTjmfoLgI3lkXrTjFAAle7cZ1yZeJ8J3koFbo8/qd7?=
 =?us-ascii?Q?Y90a0m6fwI4gkoY5lECqH9EhM2Zsiea7qsPcRD9UmbkvJqN3Z5etaoJfG9so?=
 =?us-ascii?Q?xeINSd4lLueXkl8HLU1MRGiKLghNdMQNr0vxzvf62W0l5UD6XibYFAfw/jUk?=
 =?us-ascii?Q?LoWok5WaK9qu2ViOX8mUanj6RA9OV15VcISalYc2IOJTxqcDV/O6e7so4cEI?=
 =?us-ascii?Q?4EubuPxdyAxO6gUp7A2/UwQuPU89?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 06:32:47.6132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da937cc-34b4-4022-bbee-08dcb1f3c279
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253

Move RTK amp codec helper functions related implementation to common
place holder to make it generic so that these helper functions will be
used by other platform machine driver modules.

Link: https://github.com/thesofproject/linux/pull/5068
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc_sdw_utils.h                      | 11 +++++++++++
 sound/soc/intel/boards/Makefile                    |  2 +-
 sound/soc/intel/boards/sof_sdw_common.h            | 11 -----------
 sound/soc/sdw_utils/Makefile                       |  3 ++-
 .../soc_sdw_rt_amp.c}                              | 14 ++++++++++----
 .../soc_sdw_rt_amp_coeff_tables.h}                 |  6 +++---
 6 files changed, 27 insertions(+), 20 deletions(-)
 rename sound/soc/{intel/boards/sof_sdw_rt_amp.c => sdw_utils/soc_sdw_rt_amp.c} (93%)
 rename sound/soc/{intel/boards/sof_sdw_amp_coeff_tables.h => sdw_utils/soc_sdw_rt_amp_coeff_tables.h} (97%)

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index 3e55cac33176..450542eb3ea0 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -99,9 +99,20 @@ int asoc_sdw_rt_sdca_jack_init(struct snd_soc_card *card,
 			       bool playback);
 int asoc_sdw_rt_sdca_jack_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
 
+/* RT1308 I2S support */
+extern const struct snd_soc_ops soc_sdw_rt1308_i2s_ops;
+
+/* generic amp support */
+int asoc_sdw_rt_amp_init(struct snd_soc_card *card,
+			 struct snd_soc_dai_link *dai_links,
+			 struct asoc_sdw_codec_info *info,
+			 bool playback);
+int asoc_sdw_rt_amp_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
+
 /* dai_link init callbacks */
 int asoc_sdw_rt_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt_sdca_jack_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
+int asoc_sdw_rt_amp_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt700_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt711_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt712_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 9f92f49cc517..70c56bdc180c 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -35,7 +35,7 @@ snd-soc-skl_nau88l25_ssm4567-y := skl_nau88l25_ssm4567.o
 snd-soc-ehl-rt5660-y := ehl_rt5660.o
 snd-soc-sof-ssp-amp-y := sof_ssp_amp.o
 snd-soc-sof-sdw-y += sof_sdw.o				\
-			sof_sdw_maxim.o sof_sdw_rt_amp.o	\
+			sof_sdw_maxim.o 		\
 			bridge_cs35l56.o			\
 			sof_sdw_cs42l42.o sof_sdw_cs42l43.o	\
 			sof_sdw_cs_amp.o			\
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 1d7e6df02247..7f856c6018aa 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -89,16 +89,6 @@ int sof_sdw_hdmi_init(struct snd_soc_pcm_runtime *rtd);
 
 int sof_sdw_hdmi_card_late_probe(struct snd_soc_card *card);
 
-/* RT1308 I2S support */
-extern const struct snd_soc_ops soc_sdw_rt1308_i2s_ops;
-
-/* generic amp support */
-int asoc_sdw_rt_amp_init(struct snd_soc_card *card,
-			 struct snd_soc_dai_link *dai_links,
-			 struct asoc_sdw_codec_info *info,
-			 bool playback);
-int asoc_sdw_rt_amp_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
-
 /* MAXIM codec support */
 int asoc_sdw_maxim_init(struct snd_soc_card *card,
 			struct snd_soc_dai_link *dai_links,
@@ -135,6 +125,5 @@ int asoc_sdw_cs42l43_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_so
 int asoc_sdw_cs42l43_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_cs_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_maxim_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
-int asoc_sdw_rt_amp_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 
 #endif
diff --git a/sound/soc/sdw_utils/Makefile b/sound/soc/sdw_utils/Makefile
index 20516094f453..7851af9b8593 100644
--- a/sound/soc/sdw_utils/Makefile
+++ b/sound/soc/sdw_utils/Makefile
@@ -2,5 +2,6 @@
 snd-soc-sdw-utils-y := soc_sdw_utils.o soc_sdw_dmic.o soc_sdw_rt_dmic.o \
 		       soc_sdw_rt700.o soc_sdw_rt711.o 			\
 		       soc_sdw_rt712_sdca.o soc_sdw_rt722_sdca.o	\
-		       soc_sdw_rt5682.o soc_sdw_rt_sdca_jack_common.o
+		       soc_sdw_rt5682.o soc_sdw_rt_sdca_jack_common.o	\
+		       soc_sdw_rt_amp.o
 obj-$(CONFIG_SND_SOC_SDW_UTILS) += snd-soc-sdw-utils.o
diff --git a/sound/soc/intel/boards/sof_sdw_rt_amp.c b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
similarity index 93%
rename from sound/soc/intel/boards/sof_sdw_rt_amp.c
rename to sound/soc/sdw_utils/soc_sdw_rt_amp.c
index fff746671c1d..42be01405ab4 100644
--- a/sound/soc/intel/boards/sof_sdw_rt_amp.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_amp.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// This file incorporates work covered by the following copyright notice:
 // Copyright (c) 2022 Intel Corporation
+// Copyright (c) 2024 Advanced Micro Devices, Inc.
 
 /*
- *  sof_sdw_rt_amp - Helpers to handle RT1308/RT1316/RT1318 from generic machine driver
+ *  soc_sdw_rt_amp - Helpers to handle RT1308/RT1316/RT1318 from generic machine driver
  */
 
 #include <linux/device.h>
@@ -14,9 +16,9 @@
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
 #include <linux/dmi.h>
-#include "sof_sdw_common.h"
-#include "sof_sdw_amp_coeff_tables.h"
-#include "../../codecs/rt1308.h"
+#include <sound/soc_sdw_utils.h>
+#include "soc_sdw_rt_amp_coeff_tables.h"
+#include "../codecs/rt1308.h"
 
 #define CODEC_NAME_SIZE	7
 
@@ -199,6 +201,7 @@ int asoc_sdw_rt_amp_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc
 
 	return ret;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_rt_amp_spk_rtd_init, SND_SOC_SDW_UTILS);
 
 static int rt1308_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
@@ -236,6 +239,7 @@ static int rt1308_i2s_hw_params(struct snd_pcm_substream *substream,
 const struct snd_soc_ops soc_sdw_rt1308_i2s_ops = {
 	.hw_params = rt1308_i2s_hw_params,
 };
+EXPORT_SYMBOL_NS(soc_sdw_rt1308_i2s_ops, SND_SOC_SDW_UTILS);
 
 int asoc_sdw_rt_amp_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link)
 {
@@ -253,6 +257,7 @@ int asoc_sdw_rt_amp_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai
 
 	return 0;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_rt_amp_exit, SND_SOC_SDW_UTILS);
 
 int asoc_sdw_rt_amp_init(struct snd_soc_card *card,
 			 struct snd_soc_dai_link *dai_links,
@@ -295,3 +300,4 @@ int asoc_sdw_rt_amp_init(struct snd_soc_card *card,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_rt_amp_init, SND_SOC_SDW_UTILS);
diff --git a/sound/soc/intel/boards/sof_sdw_amp_coeff_tables.h b/sound/soc/sdw_utils/soc_sdw_rt_amp_coeff_tables.h
similarity index 97%
rename from sound/soc/intel/boards/sof_sdw_amp_coeff_tables.h
rename to sound/soc/sdw_utils/soc_sdw_rt_amp_coeff_tables.h
index 4a3e6fdbd623..4803d134d071 100644
--- a/sound/soc/intel/boards/sof_sdw_amp_coeff_tables.h
+++ b/sound/soc/sdw_utils/soc_sdw_rt_amp_coeff_tables.h
@@ -2,11 +2,11 @@
  */
 
 /*
- *  sof_sdw_amp_coeff_tables.h - related coefficients for amplifier parameters
+ *  soc_sdw_rt_amp_coeff_tables.h - related coefficients for RTK amplifier parameters
  */
 
-#ifndef SND_SOC_SOF_SDW_AMP_COEFF_H
-#define SND_SOC_SOF_SDW_AMP_COEFF_H
+#ifndef SND_SOC_SDW_RT_SDW_AMP_COEFF_H
+#define SND_SOC_SDW_RT_SDW_AMP_COEFF_H
 
 #define RT1308_MAX_BQ_REG 480
 #define RT1316_MAX_BQ_REG 580
-- 
2.34.1


