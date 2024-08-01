Return-Path: <linux-kernel+bounces-271000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C2944837
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF4B1F2063A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2721B184540;
	Thu,  1 Aug 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W0y8WmOP"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791516F910;
	Thu,  1 Aug 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504270; cv=fail; b=YnN7lqjljJgqgvNjkd6riJOUL8Mn4HPLRAkp9g9P4V6mQedixb/LEZYxR+27wF98SbXmNjPe6MfbLc0pANkqpnRp1S8A1GkswGiG1SN2ZeqAMo3QOXe2rW3O7L0Xj4ZGQ94A1YC9uL4bVPQ/NLXTO+s62tYKh+fLNaBOo+MW4iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504270; c=relaxed/simple;
	bh=99tx3e05MDyfL4o7hhPthNzNR7WFUko4pk2+NFAhRmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTlIUERLjj/QexE+tz3v9j7k6WalRQj4NmyJXC8V//FtNBoVNL8MIqzwomeaAq5t8GwMdCw8w8jM19KcxIj+tcPBHQ3Wd7TIYZrkes4pW1pzdAoXwKCYb4tVShX56d+YNlLjPiciR7j/RW0yeK0QKemWsoVnaVs6RQ9yx3CqGKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W0y8WmOP; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHEnjYTNcCZDTrodUVAHPNmarlXVViMU1pRwlk0RyLC1dUr/ht+qrnVlJZOwmuziypPzZfl+8T0e5pcMcQxB/8faZMvaw8gveJc2bz2xJWyuW49X48RDEEnXww8/ZfCPvoid/2P1UWg8mWTc3DCyNvmTVQIRDmmy/3mjqJPLOkhkvqUfz6eU7JyO1WpjIxFkXsAiXOlRwTQGcRbG487PvSfddFuhR5eSqdx0A1jO7XVlSY+16gx1UMInSPlCNEYbvZcdyYu6U6DNkMbForl0p0AhIfjy0CIqRMjXrCy3tVg2oqJuCZg0ihJyvY1Xz8x4heXPVQeUeRWl7bMk8Kg1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we75CDPL7ANvzTnjyftxd/aOT+5qqjwvgSAZNMOidSo=;
 b=GT6lSe381cLvKm9P6/7qa8OgpXK240IdxjCy17W7l/LcUsopBi9cKL6qVEyEWRw6M+1vk2xf0tVL7mzxSIRmI7gHOWcvYXE5PHKv2XJNAY4wkk0pvdcVK1c95YF4y9oaPMfUer8M9419bq1+a8i+4LezUr2ZkJGeP2cxaVJ4FULpm3m/oT0GydDgi9eOcUaGwYdIU3/UmCqgDI1/Wck8nuGG+rlgE+kJPa7odsYUJvyg67eeSyEuoWdOQeIGYQIlyMaZp78Q6I8WR85uhTISBApkfGU/Llcn/FC8uRr6tJACBZIkEqlSW6orffMsAh8AFDNY5luBqIzdCLFnKuQhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we75CDPL7ANvzTnjyftxd/aOT+5qqjwvgSAZNMOidSo=;
 b=W0y8WmOPT5g5+3LwrLoL4xgb1hqehEz2Ehke51fKKoGh+ilyN4BEyMObnWzqjaaw10cxGoEw9OqP8C/C+WcU0VbBMbLaU44hXHErhuq+BCoGJOfdYFPR56gGIvmPqCqme9KtzjEefO2nsksVrbQq4iOSPT65ORcJhhVg50Mswdc=
Received: from DM6PR14CA0041.namprd14.prod.outlook.com (2603:10b6:5:18f::18)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 09:24:25 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::38) by DM6PR14CA0041.outlook.office365.com
 (2603:10b6:5:18f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 1 Aug 2024 09:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 09:24:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 04:24:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 04:24:23 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 04:24:16 -0500
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
	Rander Wang <rander.wang@intel.com>, jairaj-arava <jairaj.arava@intel.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Richard Fitzgerald
	<rf@opensource.cirrus.com>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 19/31] ASoC: intel/sdw_utils: move cirrus soundwire codec helper functions
Date: Thu, 1 Aug 2024 14:44:34 +0530
Message-ID: <20240801091446.10457-20-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0312fa-fcbc-45f8-af2c-08dcb20bbc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z5xyOjRQoD8R9EASiXehDYhmMoYdGjyQs3Mf7MCQlXETLdfxuKFeVdF0HKmh?=
 =?us-ascii?Q?PX+/OEz5h/PN/AY8mg+BDZ7JUHmTvV5kg21WYGuKQxFtXfrwR5B3bUqbvRRl?=
 =?us-ascii?Q?JEDXLtiN+rs+NCXQYjb2CwSR6GpoVjWld3Ja7Bbt7gsIYt8QyOFLnx6D2dN9?=
 =?us-ascii?Q?aDbObmnEn2GuX8r31sI41ByFTAB1Wn/x3Me2ejjVl/cS6apnYOK9MtICE4f1?=
 =?us-ascii?Q?55Pnh7PLrT3sHUWExPAZSmBxnjU4fCu/8WJ7t7I+iYpRCtvSbLYS/rMHcBNd?=
 =?us-ascii?Q?fQrImwoQm8dDVe1TBnlB4Viw+MKxMm1SLP/neUSd5GnqQrk5KB7ml2EYmEdM?=
 =?us-ascii?Q?3or8vR0H5Z8faoiirJRtU8ryBwEDIJgbXg+9/CKJwL7W9kj+D0iX1Wot171p?=
 =?us-ascii?Q?B749nBtR1mTcsJcskS1Im2OLDyN/79xAWLNy9FKF0yM1hmtY46L2oc9Z6ZmB?=
 =?us-ascii?Q?3snJ3zOe6SCxNMS0U/x/DXquH/uZjqO6o/7IcHMq5iaqml+Ij37S6diHhCX5?=
 =?us-ascii?Q?B8c9L8FLSG2Ou8wE0dfIcz+RlkXkoep627s3KfTVrBSQy5kyQnsxB4e9oIqF?=
 =?us-ascii?Q?bJWbWVl3Brw1lWe6wY1CSlObgy2I1KNgK7Zsclvkhm08X48km7p0jGGv1BCI?=
 =?us-ascii?Q?ZGoycVInTSz7fyYddbhow7iL1wp1GXQRfKjq3gmx4+T/9socWfm6b782ybpt?=
 =?us-ascii?Q?d5kAX2s3WTnzBpkA0GmIVy1sIRhCK6TWSeRYBYZSo01wpWXVDjW+u2INorFb?=
 =?us-ascii?Q?vi5RqAUEAPs6vuNdJdxR6aUkFNSyrj2YpBh7HY4nBnl4Y3NgPG3gZR/YKrhf?=
 =?us-ascii?Q?gHDsgBL0uF50vE8Rkz0imRgBZFBVLnlPNM3fYuYT/eNJcyqXpzFXNrwd/hbt?=
 =?us-ascii?Q?QtWoHSyPwXxILAZcyLUxixBvGhUw3ISjcNE+ElRWeqVcPFxmTU4/BE4Iyd7K?=
 =?us-ascii?Q?4xAFzlpd/Ayy8tm1LXVoA6GATKS5b7im9AaHOMIye92Zga3YSGrN9UlUUbCX?=
 =?us-ascii?Q?n/bXHv5or+hFsMAnNWXcZi3fVasb5h2dEq5HSZmX7WGZg8dpAOq3CJInfWE5?=
 =?us-ascii?Q?43QJ2BiaDGb6lE0mG41U2EInXa1HatweUil9OqBFUs0rJ/1aLutDuWGKoYox?=
 =?us-ascii?Q?CJ0a3EHc3ol64zGnOM16ZXVpJVLcq8BXNHek5APGYSuFpjMR+Y7xHUallSkC?=
 =?us-ascii?Q?JCdOCrBTq1SfDDTB13nXJEJ2C00UxLte+dv2iNrtDr+ASSMYjzmrV8thDtPc?=
 =?us-ascii?Q?01hOF82OXHSUQuJVdIHASjLY4tzc7OHPQVOIHME385JluEE5JxZi7ZIBnHEM?=
 =?us-ascii?Q?RbT8CASmI/eC2p0OZz6iyojKcyoKanGQTlSG3nY44m72/4O+RD6yP6EcJ0pi?=
 =?us-ascii?Q?TfLBIK30G3rK0d3wD2s5bhQX5n/kVE2air+xLOZjXEGrNVXmCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:24:25.0103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0312fa-fcbc-45f8-af2c-08dcb20bbc2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

To make it generic, move Cirrus Soundwire codec helper functions to
common place holder so that it can be used by other platform machine
driver.

Link: https://github.com/thesofproject/linux/pull/5068
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc_sdw_utils.h                 | 40 +++++++++++++++++++
 sound/soc/intel/boards/Makefile               |  3 --
 sound/soc/intel/boards/sof_sdw_common.h       | 39 ------------------
 sound/soc/sdw_utils/Makefile                  |  5 ++-
 .../soc_sdw_bridge_cs35l56.c}                 | 38 ++++++++++++------
 .../soc_sdw_cs42l42.c}                        |  9 +++--
 .../soc_sdw_cs42l43.c}                        | 20 ++++++----
 .../soc_sdw_cs_amp.c}                         |  8 +++-
 8 files changed, 94 insertions(+), 68 deletions(-)
 rename sound/soc/{intel/boards/bridge_cs35l56.c => sdw_utils/soc_sdw_bridge_cs35l56.c} (73%)
 rename sound/soc/{intel/boards/sof_sdw_cs42l42.c => sdw_utils/soc_sdw_cs42l42.c} (88%)
 rename sound/soc/{intel/boards/sof_sdw_cs42l43.c => sdw_utils/soc_sdw_cs42l43.c} (85%)
 rename sound/soc/{intel/boards/sof_sdw_cs_amp.c => sdw_utils/soc_sdw_cs_amp.c} (80%)

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index 450542eb3ea0..d5dd887b9d15 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -16,6 +16,19 @@
 #define SOC_SDW_MAX_NO_PROPS		2
 #define SOC_SDW_JACK_JDSRC(quirk)	((quirk) & GENMASK(3, 0))
 
+/* If a CODEC has an optional speaker output, this quirk will enable it */
+#define SOC_SDW_CODEC_SPKR			BIT(15)
+/*
+ * If the CODEC has additional devices attached directly to it.
+ *
+ * For the cs42l43:
+ *   - 0 - No speaker output
+ *   - SOC_SDW_CODEC_SPKR - CODEC internal speaker
+ *   - SOC_SDW_SIDECAR_AMPS - 2x Sidecar amplifiers + CODEC internal speaker
+ *   - SOC_SDW_CODEC_SPKR | SOF_SIDECAR_AMPS - Not currently supported
+ */
+#define SOC_SDW_SIDECAR_AMPS		BIT(16)
+
 struct asoc_sdw_codec_info;
 
 struct asoc_sdw_dai_info {
@@ -109,6 +122,28 @@ int asoc_sdw_rt_amp_init(struct snd_soc_card *card,
 			 bool playback);
 int asoc_sdw_rt_amp_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
 
+/* CS42L43 support */
+int asoc_sdw_cs42l43_spk_init(struct snd_soc_card *card,
+			      struct snd_soc_dai_link *dai_links,
+			      struct asoc_sdw_codec_info *info,
+			      bool playback);
+
+/* CS AMP support */
+int asoc_sdw_bridge_cs35l56_count_sidecar(struct snd_soc_card *card,
+					  int *num_dais, int *num_devs);
+int asoc_sdw_bridge_cs35l56_add_sidecar(struct snd_soc_card *card,
+					struct snd_soc_dai_link **dai_links,
+					struct snd_soc_codec_conf **codec_conf);
+int asoc_sdw_bridge_cs35l56_spk_init(struct snd_soc_card *card,
+				     struct snd_soc_dai_link *dai_links,
+				     struct asoc_sdw_codec_info *info,
+				     bool playback);
+
+int asoc_sdw_cs_amp_init(struct snd_soc_card *card,
+			 struct snd_soc_dai_link *dai_links,
+			 struct asoc_sdw_codec_info *info,
+			 bool playback);
+
 /* dai_link init callbacks */
 int asoc_sdw_rt_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt_sdca_jack_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
@@ -118,5 +153,10 @@ int asoc_sdw_rt711_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai
 int asoc_sdw_rt712_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt722_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt5682_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
+int asoc_sdw_cs42l42_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
+int asoc_sdw_cs42l43_hs_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
+int asoc_sdw_cs42l43_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
+int asoc_sdw_cs42l43_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
+int asoc_sdw_cs_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 
 #endif
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 70c56bdc180c..1ee903e12249 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -36,9 +36,6 @@ snd-soc-ehl-rt5660-y := ehl_rt5660.o
 snd-soc-sof-ssp-amp-y := sof_ssp_amp.o
 snd-soc-sof-sdw-y += sof_sdw.o				\
 			sof_sdw_maxim.o 		\
-			bridge_cs35l56.o			\
-			sof_sdw_cs42l42.o sof_sdw_cs42l43.o	\
-			sof_sdw_cs_amp.o			\
 			sof_sdw_hdmi.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH) += snd-soc-sof_rt5682.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH) += snd-soc-sof_cs42l42.o
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 7f856c6018aa..b95daa32e343 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -52,18 +52,6 @@ enum {
 #define SOF_SSP_GET_PORT(quirk)	(((quirk) >> 7) & GENMASK(5, 0))
 /* Deprecated and no longer supported by the code */
 #define SOC_SDW_NO_AGGREGATION		BIT(14)
-/* If a CODEC has an optional speaker output, this quirk will enable it */
-#define SOC_SDW_CODEC_SPKR		BIT(15)
-/*
- * If the CODEC has additional devices attached directly to it.
- *
- * For the cs42l43:
- *   - 0 - No speaker output
- *   - SOC_SDW_CODEC_SPKR - CODEC internal speaker
- *   - SOC_SDW_SIDECAR_AMPS - 2x Sidecar amplifiers + CODEC internal speaker
- *   - SOC_SDW_CODEC_SPKR | SOC_SDW_SIDECAR_AMPS - Not currently supported
- */
-#define SOC_SDW_SIDECAR_AMPS		BIT(16)
 
 /* BT audio offload: reserve 3 bits for future */
 #define SOF_BT_OFFLOAD_SSP_SHIFT	15
@@ -95,35 +83,8 @@ int asoc_sdw_maxim_init(struct snd_soc_card *card,
 			struct asoc_sdw_codec_info *info,
 			bool playback);
 
-/* CS42L43 support */
-int asoc_sdw_cs42l43_spk_init(struct snd_soc_card *card,
-			      struct snd_soc_dai_link *dai_links,
-			      struct asoc_sdw_codec_info *info,
-			      bool playback);
-
-/* CS AMP support */
-int asoc_sdw_bridge_cs35l56_count_sidecar(struct snd_soc_card *card,
-					  int *num_dais, int *num_devs);
-int asoc_sdw_bridge_cs35l56_add_sidecar(struct snd_soc_card *card,
-					struct snd_soc_dai_link **dai_links,
-					struct snd_soc_codec_conf **codec_conf);
-int asoc_sdw_bridge_cs35l56_spk_init(struct snd_soc_card *card,
-				     struct snd_soc_dai_link *dai_links,
-				     struct asoc_sdw_codec_info *info,
-				     bool playback);
-
-int asoc_sdw_cs_amp_init(struct snd_soc_card *card,
-			 struct snd_soc_dai_link *dai_links,
-			 struct asoc_sdw_codec_info *info,
-			 bool playback);
-
 /* dai_link init callbacks */
 
-int asoc_sdw_cs42l42_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
-int asoc_sdw_cs42l43_hs_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
-int asoc_sdw_cs42l43_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
-int asoc_sdw_cs42l43_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
-int asoc_sdw_cs_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_maxim_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 
 #endif
diff --git a/sound/soc/sdw_utils/Makefile b/sound/soc/sdw_utils/Makefile
index 7851af9b8593..c15b08f3ab0b 100644
--- a/sound/soc/sdw_utils/Makefile
+++ b/sound/soc/sdw_utils/Makefile
@@ -3,5 +3,8 @@ snd-soc-sdw-utils-y := soc_sdw_utils.o soc_sdw_dmic.o soc_sdw_rt_dmic.o \
 		       soc_sdw_rt700.o soc_sdw_rt711.o 			\
 		       soc_sdw_rt712_sdca.o soc_sdw_rt722_sdca.o	\
 		       soc_sdw_rt5682.o soc_sdw_rt_sdca_jack_common.o	\
-		       soc_sdw_rt_amp.o
+		       soc_sdw_rt_amp.o					\
+		       soc_sdw_bridge_cs35l56.o 			\
+		       soc_sdw_cs42l42.o soc_sdw_cs42l43.o 		\
+		       soc_sdw_cs_amp.o
 obj-$(CONFIG_SND_SOC_SDW_UTILS) += snd-soc-sdw-utils.o
diff --git a/sound/soc/intel/boards/bridge_cs35l56.c b/sound/soc/sdw_utils/soc_sdw_bridge_cs35l56.c
similarity index 73%
rename from sound/soc/intel/boards/bridge_cs35l56.c
rename to sound/soc/sdw_utils/soc_sdw_bridge_cs35l56.c
index 55e5cfbb2f14..fcc3ef685af7 100644
--- a/sound/soc/intel/boards/bridge_cs35l56.c
+++ b/sound/soc/sdw_utils/soc_sdw_bridge_cs35l56.c
@@ -1,6 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
-//
-// Intel SOF Machine Driver with Cirrus Logic CS35L56 Smart Amp
+// This file incorporates work covered by the following copyright notice:
+// Copyright (c) 2024 Intel Corporation
+// Copyright (c) 2024 Advanced Micro Devices, Inc.
+
+/*
+ * soc_sdw_bridge_cs35l56 - codec helper functions for handling CS35L56 Smart AMP
+ */
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -9,7 +14,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
-#include "sof_sdw_common.h"
+#include <sound/soc_sdw_utils.h>
 
 static const struct snd_soc_dapm_widget bridge_widgets[] = {
 	SND_SOC_DAPM_SPK("Bridge Speaker", NULL),
@@ -25,7 +30,7 @@ static const char * const bridge_cs35l56_name_prefixes[] = {
 	"AMPR",
 };
 
-static int bridge_cs35l56_asp_init(struct snd_soc_pcm_runtime *rtd)
+static int asoc_sdw_bridge_cs35l56_asp_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
 	int i, ret;
@@ -73,7 +78,7 @@ static int bridge_cs35l56_asp_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static const struct snd_soc_pcm_stream bridge_params = {
+static const struct snd_soc_pcm_stream asoc_sdw_bridge_params = {
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.rate_min = 48000,
 	.rate_max = 48000,
@@ -81,7 +86,7 @@ static const struct snd_soc_pcm_stream bridge_params = {
 	.channels_max = 2,
 };
 
-SND_SOC_DAILINK_DEFS(bridge_dai,
+SND_SOC_DAILINK_DEFS(asoc_sdw_bridge_dai,
 		     DAILINK_COMP_ARRAY(COMP_CODEC("cs42l43-codec", "cs42l43-asp")),
 		     DAILINK_COMP_ARRAY(COMP_CODEC("spi-cs35l56-left", "cs35l56-asp1"),
 					COMP_CODEC("spi-cs35l56-right", "cs35l56-asp1")),
@@ -89,28 +94,33 @@ SND_SOC_DAILINK_DEFS(bridge_dai,
 
 static const struct snd_soc_dai_link bridge_dai_template = {
 	.name = "cs42l43-cs35l56",
-	.init = bridge_cs35l56_asp_init,
-	.c2c_params = &bridge_params,
+	.init = asoc_sdw_bridge_cs35l56_asp_init,
+	.c2c_params = &asoc_sdw_bridge_params,
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBC_CFC,
-	SND_SOC_DAILINK_REG(bridge_dai),
+	SND_SOC_DAILINK_REG(asoc_sdw_bridge_dai),
 };
 
 int asoc_sdw_bridge_cs35l56_count_sidecar(struct snd_soc_card *card,
 					  int *num_dais, int *num_devs)
 {
-	if (sof_sdw_quirk & SOC_SDW_SIDECAR_AMPS) {
+	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
+
+	if (ctx->mc_quirk & SOC_SDW_SIDECAR_AMPS) {
 		(*num_dais)++;
 		(*num_devs) += ARRAY_SIZE(bridge_cs35l56_name_prefixes);
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_bridge_cs35l56_count_sidecar, SND_SOC_SDW_UTILS);
 
 int asoc_sdw_bridge_cs35l56_add_sidecar(struct snd_soc_card *card,
 					struct snd_soc_dai_link **dai_links,
 					struct snd_soc_codec_conf **codec_conf)
 {
-	if (sof_sdw_quirk & SOC_SDW_SIDECAR_AMPS) {
+	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
+
+	if (ctx->mc_quirk & SOC_SDW_SIDECAR_AMPS) {
 		**dai_links = bridge_dai_template;
 
 		for (int i = 0; i < ARRAY_SIZE(bridge_cs35l56_name_prefixes); i++) {
@@ -124,14 +134,18 @@ int asoc_sdw_bridge_cs35l56_add_sidecar(struct snd_soc_card *card,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_bridge_cs35l56_add_sidecar, SND_SOC_SDW_UTILS);
 
 int asoc_sdw_bridge_cs35l56_spk_init(struct snd_soc_card *card,
 				     struct snd_soc_dai_link *dai_links,
 				     struct asoc_sdw_codec_info *info,
 				     bool playback)
 {
-	if (sof_sdw_quirk & SOC_SDW_SIDECAR_AMPS)
+	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
+
+	if (ctx->mc_quirk & SOC_SDW_SIDECAR_AMPS)
 		info->amp_num += ARRAY_SIZE(bridge_cs35l56_name_prefixes);
 
 	return 0;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_bridge_cs35l56_spk_init, SND_SOC_SDW_UTILS);
diff --git a/sound/soc/intel/boards/sof_sdw_cs42l42.c b/sound/soc/sdw_utils/soc_sdw_cs42l42.c
similarity index 88%
rename from sound/soc/intel/boards/sof_sdw_cs42l42.c
rename to sound/soc/sdw_utils/soc_sdw_cs42l42.c
index 3ce2f65f994a..78a6cb059ac0 100644
--- a/sound/soc/intel/boards/sof_sdw_cs42l42.c
+++ b/sound/soc/sdw_utils/soc_sdw_cs42l42.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// This file incorporates work covered by the following copyright notice:
 // Copyright (c) 2023 Intel Corporation
-
+// Copyright (c) 2024 Advanced Micro Devices, Inc.
 /*
- *  sof_sdw_cs42l42 - Helpers to handle CS42L42 from generic machine driver
+ *  soc_sdw_cs42l42 - Helpers to handle CS42L42 from generic machine driver
  */
 
 #include <linux/device.h>
@@ -15,7 +16,7 @@
 #include <sound/soc-acpi.h>
 #include <sound/soc-dapm.h>
 #include <sound/jack.h>
-#include "sof_sdw_common.h"
+#include <sound/soc_sdw_utils.h>
 
 static const struct snd_soc_dapm_route cs42l42_map[] = {
 	/* HP jack connectors - unknown if we have jack detection */
@@ -87,4 +88,4 @@ int asoc_sdw_cs42l42_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_da
 
 	return ret;
 }
-MODULE_IMPORT_NS(SND_SOC_INTEL_SOF_BOARD_HELPERS);
+EXPORT_SYMBOL_NS(asoc_sdw_cs42l42_rtd_init, SND_SOC_SDW_UTILS);
diff --git a/sound/soc/intel/boards/sof_sdw_cs42l43.c b/sound/soc/sdw_utils/soc_sdw_cs42l43.c
similarity index 85%
rename from sound/soc/intel/boards/sof_sdw_cs42l43.c
rename to sound/soc/sdw_utils/soc_sdw_cs42l43.c
index 47d05fe7de53..adb1c008e871 100644
--- a/sound/soc/intel/boards/sof_sdw_cs42l43.c
+++ b/sound/soc/sdw_utils/soc_sdw_cs42l43.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Based on sof_sdw_rt5682.c
+// This file incorporates work covered by the following copyright notice:
 // Copyright (c) 2023 Intel Corporation
+// Copyright (c) 2024 Advanced Micro Devices, Inc.
 
 /*
- *  sof_sdw_cs42l43 - Helpers to handle CS42L43 from generic machine driver
+ *  soc_sdw_cs42l43 - Helpers to handle CS42L43 from generic machine driver
  */
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -16,7 +18,7 @@
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-dapm.h>
-#include "sof_sdw_common.h"
+#include <sound/soc_sdw_utils.h>
 
 static const struct snd_soc_dapm_route cs42l43_hs_map[] = {
 	{ "Headphone", NULL, "cs42l43 AMP3_OUT" },
@@ -37,7 +39,7 @@ static const struct snd_soc_dapm_route cs42l43_dmic_map[] = {
 	{ "cs42l43 PDM2_DIN", NULL, "DMIC" },
 };
 
-static struct snd_soc_jack_pin sof_jack_pins[] = {
+static struct snd_soc_jack_pin soc_jack_pins[] = {
 	{
 		.pin    = "Headphone",
 		.mask   = SND_JACK_HEADPHONE,
@@ -73,8 +75,8 @@ int asoc_sdw_cs42l43_hs_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc
 					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
 					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
-					 jack, sof_jack_pins,
-					 ARRAY_SIZE(sof_jack_pins));
+					 jack, soc_jack_pins,
+					 ARRAY_SIZE(soc_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "Failed to create jack: %d\n", ret);
 		return ret;
@@ -98,13 +100,15 @@ int asoc_sdw_cs42l43_hs_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc
 
 	return ret;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_cs42l43_hs_rtd_init, SND_SOC_SDW_UTILS);
 
 int asoc_sdw_cs42l43_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai)
 {
 	struct snd_soc_card *card = rtd->card;
+	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
 	int ret;
 
-	if (!(sof_sdw_quirk & SOC_SDW_SIDECAR_AMPS)) {
+	if (!(ctx->mc_quirk & SOC_SDW_SIDECAR_AMPS)) {
 		/* Will be set by the bridge code in this case */
 		card->components = devm_kasprintf(card->dev, GFP_KERNEL,
 						  "%s spk:cs42l43-spk",
@@ -120,6 +124,7 @@ int asoc_sdw_cs42l43_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_so
 
 	return ret;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_cs42l43_spk_rtd_init, SND_SOC_SDW_UTILS);
 
 int asoc_sdw_cs42l43_spk_init(struct snd_soc_card *card,
 			      struct snd_soc_dai_link *dai_links,
@@ -134,6 +139,7 @@ int asoc_sdw_cs42l43_spk_init(struct snd_soc_card *card,
 
 	return asoc_sdw_bridge_cs35l56_spk_init(card, dai_links, info, playback);
 }
+EXPORT_SYMBOL_NS(asoc_sdw_cs42l43_spk_init, SND_SOC_SDW_UTILS);
 
 int asoc_sdw_cs42l43_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai)
 {
@@ -152,4 +158,4 @@ int asoc_sdw_cs42l43_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_s
 
 	return ret;
 }
-
+EXPORT_SYMBOL_NS(asoc_sdw_cs42l43_dmic_rtd_init, SND_SOC_SDW_UTILS);
diff --git a/sound/soc/intel/boards/sof_sdw_cs_amp.c b/sound/soc/sdw_utils/soc_sdw_cs_amp.c
similarity index 80%
rename from sound/soc/intel/boards/sof_sdw_cs_amp.c
rename to sound/soc/sdw_utils/soc_sdw_cs_amp.c
index 6479974bd2c3..58b059b68016 100644
--- a/sound/soc/intel/boards/sof_sdw_cs_amp.c
+++ b/sound/soc/sdw_utils/soc_sdw_cs_amp.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// This file incorporates work covered by the following copyright notice:
 // Copyright (c) 2023 Intel Corporation
+// Copyright (c) 2024 Advanced Micro Devices, Inc.
 
 /*
- *  sof_sdw_cs_amp - Helpers to handle CS35L56 from generic machine driver
+ *  soc_sdw_cs_amp - Helpers to handle CS35L56 from generic machine driver
  */
 
 #include <linux/device.h>
@@ -10,7 +12,7 @@
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-dai.h>
-#include "sof_sdw_common.h"
+#include <sound/soc_sdw_utils.h>
 
 #define CODEC_NAME_SIZE	8
 
@@ -44,6 +46,7 @@ int asoc_sdw_cs_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai
 
 	return 0;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_cs_spk_rtd_init, SND_SOC_SDW_UTILS);
 
 int asoc_sdw_cs_amp_init(struct snd_soc_card *card,
 			 struct snd_soc_dai_link *dai_links,
@@ -58,3 +61,4 @@ int asoc_sdw_cs_amp_init(struct snd_soc_card *card,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS(asoc_sdw_cs_amp_init, SND_SOC_SDW_UTILS);
-- 
2.34.1


