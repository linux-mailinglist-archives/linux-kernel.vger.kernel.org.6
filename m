Return-Path: <linux-kernel+bounces-336604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17A983CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99FB28207A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E57F48C;
	Tue, 24 Sep 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VX60uGXK"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2D79B8E;
	Tue, 24 Sep 2024 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158727; cv=fail; b=EUVbRWtuMtfcYz5jsm/Fokg9OV1bGQ7kZ4bMevlvy3qrDQZZdCXf7c2lUWuql12cfLzkzVwq2Sb+5gqt6MUFnnbTPLgWwG1oSrrHm2VaGX9htBILqbY9jI0CeB8D7ChAnAhb4kNr+vd8ympKz/VnzKxtaMAov8QIa6q63pgEQoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158727; c=relaxed/simple;
	bh=1Bd7wwGG/QVQcvhWSYSxbiBiNP3ENN/9T320Rmspy+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOfRvX7gnBR52mrAVsVIYUBKcSYy19GNvuZM4Izt3A2W4uG6Bj8mlbN8Y+2d9kd1hBRNcO00XtAP3TKFJack7HvsxDVbh8okU+YIrJvcdp/9TV/FVyFvram5Mnft8TetXq33CxHJBDMcExF7PxTAtzHuLmi5eMwI9O+4EFtargI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VX60uGXK; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/Mo+QQqSM6DtW0SY1RTl2X1uSZiTt5DGrqdNpPDOBGpwief1/i6ovNfADeZQfKGqvW7f9spW4U1PTAwxKyN5lz06JmZVWvqxuIdCnsyYvFuYS9DLK1ZRHLR84h+ZSf3PrFHjogRmB8a1y/uWbERV4REEqPDyCu+Uipksi+Q2CszLGRCv/EiXDR6RvTVPW5NJcmxVA5OqDDquv2mHseD/d/hQXfK/p/N5Zt9EISxvuAvOYSraJmh3x4dpho9c5nY5Ng4STxoPUtCgFKuPKNC2pbqcKG1o3g90ZmAIQk0ljRmfSiaLRfvj285B/vZTmskQS6EXuFRqyXz75cOyGP1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMPd7XQtbsy8edkYKpkZR+rJtSF7bSxWXMLhWhpYXaQ=;
 b=gV0R/gQQBSyatbnZINHkpBm4Z9gPQ77XKcTrtnzTy5lRLsCsYoZ7BSJKDeb+SRyKDV6Hxd+Lg5utNq+nTMjDisoebFr3KVJmpRlILl28lET4h3HMpYvtg1T9QSaf85eRPKirBEqI8t4T1KXsvPm3e4jjXFED/cYqfoNIEiQRk+pC8safRohzQwromtAxBmh1KsdRaRdxhjzohDHjTZfq/hotuOLix1W3JJsF3SNBg09q6yQjmLlLsx921E3pMn3ioxFJqDqreK6JKUFgv/DXiV4RM5igt26cQ9LqpX1BtZWvXmrjY+oVKq11d5uzLq48JCr9v3LpjvjbTho29rI1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMPd7XQtbsy8edkYKpkZR+rJtSF7bSxWXMLhWhpYXaQ=;
 b=VX60uGXKsYaSnjVjj3yQ0OZXBXIVsJVYCQHqSy54ZP9NFVPqPdIMKXb5d1OjX0pnzul+4JjDFHtHDqtIPAjx0xmtZiheyQBs4aSlbRCJUDTrP+2cQ3xZVpVfMQm19p3VVCP50BJD+Hb4ndvGTYhnsyem9FnIuDphWg1rWWj11b4=
Received: from PH8PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:2cf::9)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:18:41 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::f6) by PH8PR07CA0036.outlook.office365.com
 (2603:10b6:510:2cf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26 via Frontend
 Transport; Tue, 24 Sep 2024 06:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 06:18:40 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 01:18:36 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 1/9] ASoC: amd: acp: simplify platform conditional checks code
Date: Tue, 24 Sep 2024 11:48:13 +0530
Message-ID: <20240924061821.1127054-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
References: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 645d06e5-0eb0-466a-5c5a-08dcdc60bbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ykAnYZU+/CWw18PG7zI+ELbRlLcBiV63i+2lNaeMX0287kgHVVuxtl//zUo?=
 =?us-ascii?Q?AiS5ulXrBZ60zs32zknd6CQVKumv7OjnOJqO+5jmv0MnQYiqMnaQbptoliHM?=
 =?us-ascii?Q?SN27SHPpfvcp4sq5v47gu/t8F4XC2U8m91AgXcofbWMsbWf0NTjwPGqiUA/K?=
 =?us-ascii?Q?sB+LjZWZdrVhZW92EftLquWQI2YPK76flQuct9+fh6mAmk9wTXfT1m93Ef7w?=
 =?us-ascii?Q?u0PQagikcix51EeVQchkuIf14nCiXy5CCmh0rrfmImaonDtRN1a0EUApEGkV?=
 =?us-ascii?Q?kOIccAxZgrB/sOKHfgp8DPJPw7KbIxyDIpSzQyMw5YlJGxQCvClHJMXPM2zz?=
 =?us-ascii?Q?eQ+XsmyFsYrzEYO1ruSBAH5cbud4Wd1NrVvYDKrfV2k2WYIG47m4l5ngQnQ9?=
 =?us-ascii?Q?oynde69xZ+b+TLbJA7UHsOKl0i58HYi016dD05+AHrYC6MDIi0YzW/z3prDw?=
 =?us-ascii?Q?wZf74kociZL6OwgP4VX9tZQM9TD/8TumKI7dc2Yc6QRP6xMhEMaKR75+N8l8?=
 =?us-ascii?Q?7P4hTOqhwlSpJ0w79H0KcFcTEQG+IrwWxLCAm8SgzarXYUl6Qa8sftE0bEBs?=
 =?us-ascii?Q?tLhe1ur3VWXkxT9PlMEEXFLi3i2Wh1XXXcbSbhQPEpJXFjtixWvVsNYMuoPP?=
 =?us-ascii?Q?V3NcRX5V7SZ4YAQKGhTEAJOXa3nivNwagUaYUVuhM6nbN23Dhhl2SlgNpbR9?=
 =?us-ascii?Q?fmIKhrN761MjesUmJ+GXPWT7opJh/3t3vCNaXWc1GhvymJieD3g2sgXod81c?=
 =?us-ascii?Q?dgegTb16drYny2g/QUEepBMQFhz+vxl+thw8IHYtqOiG2IiVYmN9MNp358nP?=
 =?us-ascii?Q?vl0enNJ8vt0w0YE81EU+MRSPziBuY8cosGeCotbWO/UN0/yLnhtRgBljo9X4?=
 =?us-ascii?Q?IYUjdKfNkfEepR+skar+OQfM9agCnE+ptdACeumkwAiitUm37/Gsa9u6IseZ?=
 =?us-ascii?Q?kZU21wReXLHlogOTTmlGep1lYKJoI3rX0HJmAMOrHGUk/FZ0osOj3Blsdi+T?=
 =?us-ascii?Q?WPINXuVZ6eqmHHyrAJL27pd+47UTNJcfxTnLWSPC4yuRFrj2srWbT/w11sH6?=
 =?us-ascii?Q?PNxGJtGXE2H0dX9SVoHhczShQ3VrE/LpOYDyApkpuqtiUZhCc8Fhu9cFzbN8?=
 =?us-ascii?Q?Rukhl94rHcehv2S3Xy9j+9h1xuTfqDTinjevYXdPRdmJcK51aokUhC7Clz5S?=
 =?us-ascii?Q?mzMS64rgeIie9vcs1uBgexfJYGnwIjMDPVMQScVuz0esARAxhYyeNd3hv1kQ?=
 =?us-ascii?Q?fblh77UWDSYywRjMBTXQE/ftGz2F324+dx5lmNjO/3QYfFoEkPCSRpyeXRYO?=
 =?us-ascii?Q?XLs4LcMau0kyym8cVrmS7U+Lk5bSNfVDglIM+/vUDzWzjzMrse61GtzEOIKa?=
 =?us-ascii?Q?xsQckA3SpIiPHhJG3XDvW8GkxFx7FUtmVC7UagZ7U6tncMxHhX4RLq9YSG5U?=
 =?us-ascii?Q?hjVV2EpWx5WqLdY3QL9jbAkpgte8iGTf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:18:40.3943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 645d06e5-0eb0-466a-5c5a-08dcdc60bbc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978

Simplify code with switch statements for platform conditional checks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 36 +++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index e9ff4815c12c..d4c7a7b79177 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -1647,16 +1647,21 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		links[i].id = HEADSET_BE_ID;
 		links[i].cpus = i2s_hs;
 		links[i].num_cpus = ARRAY_SIZE(i2s_hs);
-		if (drv_data->platform == REMBRANDT) {
+		switch (drv_data->platform) {
+		case REMBRANDT:
 			links[i].platforms = platform_rmb_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_rmb_component);
-		} else if (drv_data->platform == ACP63) {
+			break;
+		case ACP63:
 			links[i].platforms = platform_acp63_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_acp63_component);
-		} else {
+			break;
+		default:
 			links[i].platforms = platform_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_component);
+			break;
 		}
+
 		links[i].dpcm_playback = 1;
 		links[i].dpcm_capture = 1;
 		if (!drv_data->hs_codec_id) {
@@ -1714,16 +1719,21 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		links[i].id = AMP_BE_ID;
 		links[i].cpus = i2s_hs;
 		links[i].num_cpus = ARRAY_SIZE(i2s_hs);
-		if (drv_data->platform == REMBRANDT) {
+		switch (drv_data->platform) {
+		case REMBRANDT:
 			links[i].platforms = platform_rmb_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_rmb_component);
-		} else if (drv_data->platform == ACP63) {
+			break;
+		case ACP63:
 			links[i].platforms = platform_acp63_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_acp63_component);
-		} else {
+			break;
+		default:
 			links[i].platforms = platform_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_component);
+			break;
 		}
+
 		links[i].dpcm_playback = 1;
 		if (!drv_data->amp_codec_id) {
 			/* Use dummy codec if codec id not specified */
@@ -1760,18 +1770,24 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		}
 		links[i].cpus = pdm_dmic;
 		links[i].num_cpus = ARRAY_SIZE(pdm_dmic);
-		if (drv_data->platform == REMBRANDT) {
+		switch (drv_data->platform) {
+		case REMBRANDT:
 			links[i].platforms = platform_rmb_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_rmb_component);
-		} else if (drv_data->platform == ACP63) {
+			break;
+		case ACP63:
 			links[i].platforms = platform_acp63_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_acp63_component);
-		} else if ((drv_data->platform == ACP70) || (drv_data->platform == ACP71)) {
+			break;
+		case ACP70:
+		case ACP71:
 			links[i].platforms = platform_acp70_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_acp70_component);
-		} else {
+			break;
+		default:
 			links[i].platforms = platform_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_component);
+			break;
 		}
 		links[i].ops = &acp_card_dmic_ops;
 		links[i].dpcm_capture = 1;
-- 
2.34.1


