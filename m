Return-Path: <linux-kernel+bounces-554888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB7A5A30B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FC5175C33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9689F235C04;
	Mon, 10 Mar 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m6OvEhLW"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FF23371B;
	Mon, 10 Mar 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631622; cv=fail; b=o2g/25TGAxiSTCkBOdWwaepm+Ib25E2PYh+wxrrUrMjO2vmHU72DHRcYrpeqFr6H1M8ScJF7oLbMEoLwk+i1BftiXa0TCU02/dHu6MAprpaVHQQ8KOAgCbNr06beMR1p8AA8XzHQ6ksI1UYekuPigJsT4djgoDLFxUZ1oeFK6N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631622; c=relaxed/simple;
	bh=3w9maMIZum9wqhr4sZeY4a3pMQIqOX+ccsInpBY4nBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GM39B8JDjD379Nh2uz/PLEfcpT6o+EE96Qi6h2d/G16YvXdN7a4M+yjSJNia6rbxF50vu3uDFQaZMJd61Jor6vQPaWdotM0bjKlRXy1gaPzT1wf2gdVxF7G2C+K11e4rFtUI2juXiij8szv46GefbJVHA4AFHRGzMVwlnt8M/VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m6OvEhLW; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkIR0sKeSUqSra0vNMoXm+ryvEp8n0OBOaIfZu/xnxJtaEgvmX/zZisgjmL/jBXPe3R8PpqZ6zTNiS4zNJCNU6MobvaktBndZrR6UPjFEuBwrFdFAme2v1mUAggUMecWXswIq+PG+LWHrenRIGP3lbJdJ5yQZFQ/qwPgNh93mYNsam3iPJuZpvk/aML6tDg4eqtiC7oBrqHvg00jmOFeJnpNfzJDFZ6oWGWvJWnPCXZK/nyaJ4zWprfle3IFTtmj1ECCko2Ja5VKU/sx+LK9z0/jGm5gvvLhPVy1I5klxriFgI8ioAppIF1/sB5UrksoBX83ZstjTzPNqo94j5RJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZmVQN71zI6jWbN/ROBn3bnpIPN9bJzocLKfj9XbPzU=;
 b=NVEo8SOwA5q2PJOv5rBXMMxotGUrUR5PdpECPZuur5QAUYAbaolmOIrv8e4z9wihqzzVZeMkC+GoFzwDNG9Ky0zyg5ih1DKtN5B+XfvZtrSabWAooFqTTC9YRg2lh93piYEfXAKizvfqQJXSMbyZ9H/Wjk6bhdnFGrr7kQJsFj5sbFJWE+9I9wN+TiB7c25V4Zag8Chg5bsbLi/6imDi1iFo2MW6qLUFZkZFJ8y29Lbbm9x9odm/EV4ElpXeWmCdcKuMwVC2fcqvxePpfDdHdXIcsMBYOYqOB9jHticQjckd2dd2gtMRyjkJOQZ9J+dkMrZBjFqtoJk4Beiy1PO7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZmVQN71zI6jWbN/ROBn3bnpIPN9bJzocLKfj9XbPzU=;
 b=m6OvEhLWIt0vRMUF5YzqokQKlkqnQDvBn1cc+AbqT/EkJrH2CL5KuHwhY/+HwQksHa8dVHKsPRPvZkzx1AD57AIOOA7OMY/VBsHAERKsFEKrwjzE/qNuGuntHVCanR/DGWa1unNcff17HaJCx4Uwx2CxEBWIGNCfJnA/JGRUCj4=
Received: from MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::15)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 18:33:37 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::5a) by MN0P220CA0004.outlook.office365.com
 (2603:10b6:208:52e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 18:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 18:33:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 13:33:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 13:33:36 -0500
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Mar 2025 13:33:32 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Mario.Limonciello@amd.com>, <Vijendar.Mukunda@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<ssabakar@amd.com>, Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Greg
 KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/14] ASoC: amd: acp: Refactor rembrant platform resource structure
Date: Tue, 11 Mar 2025 00:01:59 +0530
Message-ID: <20250310183201.11979-13-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310183201.11979-1-venkataprasad.potturu@amd.com>
References: <20250310183201.11979-1-venkataprasad.potturu@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkataprasad.potturu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb4e605-e53f-47b5-b6c6-08dd6002122e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qlm+2asK84W6F18gYNwDiPMzN9M4hRy99w0VB1EfgXWURoE6WD3/ZI88Bhdc?=
 =?us-ascii?Q?OnYM5g0usmSOfSKiTrxnOahpdPEixcS69ro+Lksb4olbwClnaFDDDqIlW7Ou?=
 =?us-ascii?Q?jDLVjPQgMakBdAa0vyy/YGmRyPHX5S1hUk6ey7V0p3RKc7LZYJYvkXDyXU2K?=
 =?us-ascii?Q?PcZLf9KUsrymHae5Ls0PaQioxBrw1X/1aikyD94RRXH4LyKFCkF58ABXu5GG?=
 =?us-ascii?Q?yWHryjkz3hmGU9e8DAOqnqWD7aJizlIgszlbFbdPPbcjsCm/WxQpfVOB3XC5?=
 =?us-ascii?Q?ihD12KMLgiJXZSYUMvFqONAexj+X0+dWHF0PELH3CcKO9JOb/s9nb1A/zWo6?=
 =?us-ascii?Q?r8R1F8FvU/5cTHN1zES1+8PDF15uBl7e+LRLJRg7sOCPd0HNxQGAXpiiaCeJ?=
 =?us-ascii?Q?+gILfspVZdg3gno465CzhvBdG9n5bqLw+/UxV5Yt/Yxy5NvA8mET91XVNKqO?=
 =?us-ascii?Q?mzROGWmnFV3h1MzdR0wA8FmtnNvIUEgXe/w2fHnR2ZaGRCfaTEgNwdbkHhQZ?=
 =?us-ascii?Q?76gVktoYWS8e3LXokOvjFPvklI9zT0BXTsuwq0ATGR/gulleYXL76Du7ZCA5?=
 =?us-ascii?Q?9ODvwVu5AQz7bHRNMPU1yETFI+jsnNSd+zUDVmJruOEneCBkJ/E8noEceZd8?=
 =?us-ascii?Q?cD2CNOQcq8lu8MQ4G4pnYU2QV/L0kHU8KFeVw4HIijJjRM2VO9gaa/BdaQ7V?=
 =?us-ascii?Q?sCMfJON5mxN5X8qT6CROpz0B07nRGWhW0QIHgghzzKtrd5Ni98BTyVr4b/Ht?=
 =?us-ascii?Q?xY1Oul3HHWUbWEdSv+MN8jr+J48NpQxRDdnoShll0fizdB+0rIb4OuuH6cHN?=
 =?us-ascii?Q?+baTvOIXVFw+9vQk4mKDARz4gPzT4kka6YiN3AXWjS6BmUuUhtByw2BaN2Xq?=
 =?us-ascii?Q?bPjmTo/jRxTV4aycdcXUPJ1+1nHnWkLfUJa6z0OoyATZfVCMccA3Hi9kkHRM?=
 =?us-ascii?Q?a3erUNe1GTxUWy7BBXDJyu0jZGsLCplDWKFy5iSR+LqRZz0XVmeR6o8n3giw?=
 =?us-ascii?Q?bL0yoFJbEBAXtv/hyc1ZPGzY4fagawpvsNHLjtXXFkObE5Kh6Rv+bijcegno?=
 =?us-ascii?Q?d2vjxzvDjrtiRNzPy1afYH1vViAN2UFaJuBPhNpLbrBQ9OIRUi/FM+zkV6El?=
 =?us-ascii?Q?HbH/Kk3LlG9TZVe3FRQ5KNbl1B+zmNRY6AbSKCYmfnneuFqFzNVejDRGspSl?=
 =?us-ascii?Q?C7Z1D6zav8DHedpa4dMbeCVsYRp4uTMtSTdL9GchxnagS0BhiC1fMl0KjQsN?=
 =?us-ascii?Q?6AOno+grF2f6Ny+UWwGP8f77G12WoA9D3U/yXMs6yB3YrbUDqqvpIsJK3kOn?=
 =?us-ascii?Q?Ay1vaBJmRoW47oIbXbw35deRSgKZg0EW+/EHz2VDekMuIXjHnskgZyhPR1o+?=
 =?us-ascii?Q?QPRkfeF8UGpciRbME35QxXMmd8dqmf0TFHzDzHsn9ORx1sJAWLo432NRJFRe?=
 =?us-ascii?Q?Xp9+Bp+YSHKs3qCUb6KTx5gc0BLFhA4/WOIFMA3VqrHKoMfoFTec87wQ8wSx?=
 =?us-ascii?Q?Eq7v+ectE6rgzEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:33:36.7262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb4e605-e53f-47b5-b6c6-08dd6002122e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821

Refactor rembrandt platform resource private structure to amd.h
header fle.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-pci.c       |  1 +
 sound/soc/amd/acp/acp-rembrandt.c | 13 +------------
 sound/soc/amd/acp/amd.h           | 10 ++++++++++
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 3df665ca1b0b..6dd905e75f1d 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -140,6 +140,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		break;
 	case 0x6f:
 		chip->name = "acp_asoc_rembrandt";
+		chip->rsrc = &rmb_rsrc;
 		chip->acp_hw_ops_init = acp6x_hw_ops_init;
 		chip->machines = snd_soc_acpi_amd_rmb_acp_machines;
 		break;
diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index dfb18d5cdc7a..21614e2e1b6c 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -34,16 +34,6 @@
 #define MP1_C2PMSG_85 0x3B10A54
 #define MP1_C2PMSG_93 0x3B10A74
 
-static struct acp_resource rsrc = {
-	.offset = 0,
-	.no_of_ctrls = 2,
-	.irqp_used = 1,
-	.soc_mclk = true,
-	.irq_reg_offset = 0x1a00,
-	.scratch_reg_offset = 0x12800,
-	.sram_pte_offset = 0x03802800,
-};
-
 static struct snd_soc_dai_driver acp_rmb_dai[] = {
 {
 	.name = "acp-i2s-sp",
@@ -171,11 +161,10 @@ static int rembrandt_audio_probe(struct platform_device *pdev)
 	}
 
 	chip->dev = dev;
-	chip->rsrc = &rsrc;
 	chip->dai_driver = acp_rmb_dai;
 	chip->num_dai = ARRAY_SIZE(acp_rmb_dai);
 
-	if (chip->is_i2s_config && rsrc.soc_mclk) {
+	if (chip->is_i2s_config && chip->rsrc->soc_mclk) {
 		ret = acp6x_master_clock_generate(dev);
 		if (ret)
 			return ret;
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 075659fb3314..0cb6d2abf832 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -238,6 +238,16 @@ enum acp_config {
 	ACP_CONFIG_20,
 };
 
+struct acp_resource rmb_rsrc = {
+	.offset = 0,
+	.no_of_ctrls = 2,
+	.irqp_used = 1,
+	.soc_mclk = true,
+	.irq_reg_offset = 0x1a00,
+	.scratch_reg_offset = 0x12800,
+	.sram_pte_offset = 0x03802800,
+};
+
 struct acp_resource acp63_rsrc = {
 	.offset = 0,
 	.no_of_ctrls = 2,
-- 
2.39.2


