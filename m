Return-Path: <linux-kernel+bounces-270983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376B94480D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573971C20429
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DB818452E;
	Thu,  1 Aug 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zKUKTsTE"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32D184524;
	Thu,  1 Aug 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503932; cv=fail; b=fu+8aEyMGKYf+1PWT6ihlG2SFJpMI8EiTLvHZAk8UJWW9uatm6ZAXW9I5ujvSwPHFSQ/N0/E7Fe54dlxbjDvjd/8oSFGBdlWGVsOW5vMDsPtCsmkkwn26XaUQYnhwsSBXQcQz11iB93n+8V+C7z38AReuR6jx/S2WdNJpCKAF0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503932; c=relaxed/simple;
	bh=KSTYiI0dytWJe6hGgmOuCegbFF0+e1QlYZSeZPMFj+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRAK72Svagu1vvDyLF5mRXeUJxvpj5oFIX+WsJCNZrG/hiaKnzGd6anozelBywGmLpnipwfTlDqN7RSqYoFP0IxfOmsEncZqV1uQLgKwTvXPOx9EC37gKnP4pjjDCSGqzABUunZViEc0kB0PiuL5y2emmSYY7vug7DHtMP6cqCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zKUKTsTE; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXPEVQxrWtK+63qSi58cqvB/hAgRaQ6B51Kvx9iV4eThmRRLfTnSxIXvCD7hzuWPYmhu9SLtpVl3C/kw/tMfsvAtEoLyTvFgXtF4hzEgTYhPwmhfrvAdoPiW6SenXnVAUW0tYxUJ+YIusrW759zeL+jXHM7Banux+p8Z+K8mTQmxgXMkJjQHKllQ5yIqoUPTwmJbJw50RHfTNj+uv0sSxyCTs3QNaY7uZRemlwnEsGU82aEp6UQtCXjuKYLM2+hXFp6QhaQYlvsUBAGXkspZddMYUPtz3QKvGJh/r14zLzJV/0yh3uKV/rPUiGNuAVWffwOwpM9l+GqDvspxKkBT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK5UcSHp7ey5i2K2Zi6QMQt6zdza61rvrmkQU0evU54=;
 b=SVyW8UqlFjHN3q78I07sG3YkfRi8PrBESTz9Brjgcv/Tb8/l8RHawgOK7g7MsNuzPy7voPKm2PWHp3LmjRr74x4oJ6AVbvzm1Wagk9OAlB67OG7eHDwXmOPH4xT59Kv0vNRP4xyWWtVlQcpjw8hrUIeMSC8mr2DzwSHv0UJqJGiO8Wu1w9AZuTmWCyboG7QvUq8B0WVBbhN3LQTISawTFH6lhtuRuYmk+NmP2R/lPmfOtlYNP9PrF39Hbpp3jy9EcXbSG9B8KhiqexT8tR5ScpIbmlFdbAiVNyZwk9GLamhsUeiFz43sHx7tm+xSLpjGXza8VWWKtdOQqYCDxwjLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK5UcSHp7ey5i2K2Zi6QMQt6zdza61rvrmkQU0evU54=;
 b=zKUKTsTE8DJcW14qRSR2zGZ4MTVC0O1PDj6QE/WKcDSICO6SlSXF0q72GsnTOXhdtejwNrfEp8G/pe2Mqa5vWPSgdsWy/vHMR+XnoiEP+FfOolSHMV5i95tQ9b0GNLIfr0hvTUPQ+bElOpvb1SGLLNHM7PK/YELVyy8Riu9XfaQ=
Received: from DS7PR03CA0243.namprd03.prod.outlook.com (2603:10b6:5:3b3::8) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Thu, 1 Aug 2024 09:18:46 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::f) by DS7PR03CA0243.outlook.office365.com
 (2603:10b6:5:3b3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Thu, 1 Aug 2024 09:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 09:18:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 04:18:45 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 04:18:39 -0500
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
	<kai.vehmanen@linux.intel.com>, Charles Keepax
	<ckeepax@opensource.cirrus.com>, Maciej Strozek
	<mstrozek@opensource.cirrus.com>, Chao Song <chao.song@linux.intel.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 08/31] ASoC: intel: move soundwire machine driver common structures
Date: Thu, 1 Aug 2024 14:44:23 +0530
Message-ID: <20240801091446.10457-9-Vijendar.Mukunda@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 0601411a-4c1f-45d5-54a4-08dcb20af278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dLBXfkNs40cZVwq17o17XXHyi2tt0vXAYQWkJxnJv8+W2JrmRSIso6K4LXte?=
 =?us-ascii?Q?r0mYdgFoL7mU5yrzogE1XuI+jjiRAG1vbfDquOzw8a9bDVbIkHdPNdr08I5Y?=
 =?us-ascii?Q?d29K8Fj9HJ6ndQadpwbtn8v+dxisXhHhNHv/Vtw0ir2zaXW45uedxusyFRRx?=
 =?us-ascii?Q?LEiykzOXu6eAUnwHqQtVl1hQWhKC5TUsWhvABHdV8qMPADzC/GGa6CqXZYyy?=
 =?us-ascii?Q?ecloWrp9G6fVTP/06ek7j6m9rxYu4o2KiqKEQenMACDKyrTdsRb4iccWCpaS?=
 =?us-ascii?Q?FoTLwxkEvm4s6cffsAzvxUTCw8UNINsOQ/Eyvkz5zpkDmlnxhm394nbQg/Ic?=
 =?us-ascii?Q?AV7epj71+2Vff12E49W7znOSSMWDth4bXPnefrAtoYIcdzZi6HausObg9kuG?=
 =?us-ascii?Q?zwLC2pWQthjzhzOYGpJimtDH8ykholtSdoISx9W7Oh23PusYv4wp9CdFU4sh?=
 =?us-ascii?Q?s+81yoqFYyYR1RV0P1iAi5d6F/aB035rxVJla8Slg0APoGGiNV+ySyhgLWtN?=
 =?us-ascii?Q?T8NTXcpYMjW45oHhl1GgggkXCf66vrM268QxGaM+gVB30z5Dw2j98SjSLZWL?=
 =?us-ascii?Q?w9kqefq1EiwB2d8dT36OSjHFAnCwbJggsISzwEaDSJD1AYlNfvOBscGJuZT5?=
 =?us-ascii?Q?5wcCNyS/UjBU8ZduFw7TVdLSkrgPPxumNEESfgkie2YF5lCBrv2dvx5l1YnQ?=
 =?us-ascii?Q?zmulr1iaxaodXBP2BcRC2Ct/pqksgxbjCh0qtdVGMKp0etQMwOfOSsAe0Crx?=
 =?us-ascii?Q?5E1EoX/FpgLZ1g+CFkl46TNZCLaV4/NlI6TZomWwX7fZtgK4soZ/ddav/cdX?=
 =?us-ascii?Q?dKrSb+lyr3cBDlwwvbWBvehWWvrgOOrgxzJiiLiIqiIwDi5TpUxt7PeccT5A?=
 =?us-ascii?Q?Z3S0xTBemaOOLiHmCfrLo6bCpHwSmbevY9h4gRzxJbJrLMm6pDPi6NnVdPKX?=
 =?us-ascii?Q?dTb4xyrPs67AfxUrp8vV4Tb7mjiMn09Mby1/YP/O68B6v8vy74tQ3QoLM2Jr?=
 =?us-ascii?Q?WAC15oxqURLpOqJBx3u/Hvh/IDov/3/pgGthS0i46IGxI7HpB+5ePKy8GnF3?=
 =?us-ascii?Q?i0zfHYHLLRUFHlYxzcIJhKJMRxHPViTdWWAVvyP4MKv5QATDIPHxUPxtH+rk?=
 =?us-ascii?Q?LMoHNq1A4KDnVb8/9UsTQIR9z4AxQwqVDAsApOxdYpsD4LzF5YKkuEzPbGmh?=
 =?us-ascii?Q?mC0P5b/i6Z7DDM6LCkvvT5sZB0KQh+XJLQS7A/M8nJfOXAJthPsVLpmHDvWh?=
 =?us-ascii?Q?5C9rcSwuDhGdosGsfn4CyGFuN/nj4JMSIDGfDDsanZezWdSshf12CseyBsqt?=
 =?us-ascii?Q?q3PRODfjo56NCelabRuEP4zrP9jrrDOpHWjLj2aJUlzZVAFqpchQdVjrMPuQ?=
 =?us-ascii?Q?NMrv+8BME5qU8xa0lNaxnjVD/mtN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:18:46.6063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0601411a-4c1f-45d5-54a4-08dcb20af278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436

Move intel generic SoundWire machine driver common structures to
soc_sdw_utils.h file. These structures will be used in other platform
SoundWire machine driver code.

Link: https://github.com/thesofproject/linux/pull/5068
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc_sdw_utils.h           | 43 +++++++++++++++++++++++++
 sound/soc/intel/boards/sof_sdw_common.h | 43 -------------------------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index cf4cdb66b2de..1ae5523bbcf8 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -11,6 +11,49 @@
 
 #include <sound/soc.h>
 
+#define SOC_SDW_MAX_DAI_NUM             8
+
+struct asoc_sdw_codec_info;
+
+struct asoc_sdw_dai_info {
+	const bool direction[2]; /* playback & capture support */
+	const char *dai_name;
+	const int dai_type;
+	const int dailink[2]; /* dailink id for each direction */
+	const struct snd_kcontrol_new *controls;
+	const int num_controls;
+	const struct snd_soc_dapm_widget *widgets;
+	const int num_widgets;
+	int  (*init)(struct snd_soc_card *card,
+		     struct snd_soc_dai_link *dai_links,
+		     struct asoc_sdw_codec_info *info,
+		     bool playback);
+	int (*exit)(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
+	int (*rtd_init)(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
+	bool rtd_init_done; /* Indicate that the rtd_init callback is done */
+	unsigned long quirk;
+};
+
+struct asoc_sdw_codec_info {
+	const int part_id;
+	const int version_id;
+	const char *codec_name;
+	int amp_num;
+	const u8 acpi_id[ACPI_ID_LEN];
+	const bool ignore_internal_dmic;
+	const struct snd_soc_ops *ops;
+	struct asoc_sdw_dai_info dais[SOC_SDW_MAX_DAI_NUM];
+	const int dai_num;
+
+	int (*codec_card_late_probe)(struct snd_soc_card *card);
+
+	int  (*count_sidecar)(struct snd_soc_card *card,
+			      int *num_dais, int *num_devs);
+	int  (*add_sidecar)(struct snd_soc_card *card,
+			    struct snd_soc_dai_link **dai_links,
+			    struct snd_soc_codec_conf **codec_conf);
+};
+
 int asoc_sdw_startup(struct snd_pcm_substream *substream);
 int asoc_sdw_prepare(struct snd_pcm_substream *substream);
 int asoc_sdw_prepare(struct snd_pcm_substream *substream);
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index d97aedeef9e8..688cbc3afb29 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -78,49 +78,6 @@ enum {
 #define SOC_SDW_DAI_TYPE_AMP		1
 #define SOC_SDW_DAI_TYPE_MIC		2
 
-#define SOC_SDW_MAX_DAI_NUM		8
-
-struct asoc_sdw_codec_info;
-
-struct asoc_sdw_dai_info {
-	const bool direction[2]; /* playback & capture support */
-	const char *dai_name;
-	const int dai_type;
-	const int dailink[2]; /* dailink id for each direction */
-	const struct snd_kcontrol_new *controls;
-	const int num_controls;
-	const struct snd_soc_dapm_widget *widgets;
-	const int num_widgets;
-	int  (*init)(struct snd_soc_card *card,
-		     struct snd_soc_dai_link *dai_links,
-		     struct asoc_sdw_codec_info *info,
-		     bool playback);
-	int (*exit)(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link);
-	int (*rtd_init)(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
-	bool rtd_init_done; /* Indicate that the rtd_init callback is done */
-	unsigned long quirk;
-};
-
-struct asoc_sdw_codec_info {
-	const int part_id;
-	const int version_id;
-	const char *codec_name;
-	int amp_num;
-	const u8 acpi_id[ACPI_ID_LEN];
-	const bool ignore_internal_dmic;
-	const struct snd_soc_ops *ops;
-	struct asoc_sdw_dai_info dais[SOC_SDW_MAX_DAI_NUM];
-	const int dai_num;
-
-	int (*codec_card_late_probe)(struct snd_soc_card *card);
-
-	int  (*count_sidecar)(struct snd_soc_card *card,
-			      int *num_dais, int *num_devs);
-	int  (*add_sidecar)(struct snd_soc_card *card,
-			    struct snd_soc_dai_link **dai_links,
-			    struct snd_soc_codec_conf **codec_conf);
-};
-
 struct mc_private {
 	struct snd_soc_card card;
 	struct snd_soc_jack sdw_headset;
-- 
2.34.1


