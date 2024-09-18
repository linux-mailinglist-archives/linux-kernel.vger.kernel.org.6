Return-Path: <linux-kernel+bounces-332290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA397B7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22FB1C222AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27C4166F0C;
	Wed, 18 Sep 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eynLzljZ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E56215EFA1;
	Wed, 18 Sep 2024 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640367; cv=fail; b=psDFvQ3tG3dBQfpx+KgMkpZmiKPk6KlgZKAtdXo/l1io3Q5Nb4mKmtzm3UaHgYNcfmFv/sWXz5IBJHlZNJkbwMGAmZXBhge225jzHf1rhaWbQzK3zitppw5eDUmcGbaadXATyuE9BPjmKUap59EErUQg6hwnJl+z2EktRmkXmkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640367; c=relaxed/simple;
	bh=PEVLJXQU6KRun07b6HhrFMfLrce+M0wlO03pfzhboMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5I4/CmeASU1wh6/ryajF/7RxsnyRVfbZNQpKvQAw4fUjGqFgw00ToPCdhlLwdH0nmKYNMdlkx87j7yX+ekP9mrfYVWfC/ewtxHUOl+Iz+BOZOGphZf7L/IVEhglS5R8rUpy0AYaqR0KVLU7kY7uIA/Lxg6OLjP/owbinrSuJLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eynLzljZ; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfSOGOu3MxbTtp1dgNYyMJrSiKJPLDTDFPxP7FPlg6uJHiHc88GnquE1jIL2mCpmG7ns4KilWOdhkOM9hLVI8Ff6YQFufrBz6KKyfY4ABGZTaKkvQABra9tiMdrGArTJbFqRRj/LAlYMLPUdRNhyBPaL+7Gk3/pctKyL/L7B/k7LrEnLjSQyOmC3RqrWnvtFCma1hXK5G0h16Qq4p3vWFHylIcCyWV/uZE7hsqp3m29HJMg8FITIJPZ4uqiOcEwjmaw3hJIUqn60Cz5konyYS/x1IrhIsqhP/wwPt8/hfXpPdiN0uPCwN8GFmEcO1cYQk0FHJHuUhAb3L4gn9CSxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbMtsb0Y98ZJcqNBWX4z+r9vW2AG6RYWKe+IgiqUbYY=;
 b=u2j2V9PgmBfQxy8Qk53L9EwTSaT8MGVDzopnn2BKwBWUcTHmOBff70qUVlT05Z7diCEJHrG1ZIdx9TUzGcgdAuM+JXdd7wedvXp0eJwVYX0+rIic83lTg+RbDsYkfz8jlFZV0AHtOT+cf9Sweq3n4CX188ibypFkzupv8d5lEJFS6N7Hh/tlIl8VMYQa3iMp1Ymll9KzvW6O1SWqGNacvOqk76DVF+HV6ktrEpmlQiZI3WlPfC1Hd2RAbgBLG+4tY1HI1quA2E3xyRW1F1jAVSEpn+56cyk7V6VFpi0rDkaSg+jlsO/YKK0QF7y3uXYgS6NWAPI+drgG+SJ+hwAHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbMtsb0Y98ZJcqNBWX4z+r9vW2AG6RYWKe+IgiqUbYY=;
 b=eynLzljZ51MD20BVh1O8DKOa8yxCFE6cUtb3SzJWmISt2j+NhGgjlGJNRcFxOd3wgq2Tp6mOzixHOTQ9aLoYdQ8d0Mdz9iIiYJ2gTXIAOcTG0Ty/HGnY4p+UoogVzu3xiezPoWs01gYaRyKEBX7tbeopnecnznMnFiFWxbBMvbo=
Received: from SN7PR18CA0007.namprd18.prod.outlook.com (2603:10b6:806:f3::27)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 18 Sep
 2024 06:19:22 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:f3:cafe::8f) by SN7PR18CA0007.outlook.office365.com
 (2603:10b6:806:f3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 06:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 06:19:21 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 01:18:58 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 4/8] ASoC: amd: acp: store acp pci rev id in platform driver private structure
Date: Wed, 18 Sep 2024 11:45:36 +0530
Message-ID: <20240918061540.685579-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918061540.685579-1-Vijendar.Mukunda@amd.com>
References: <20240918061540.685579-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd128db-4d4c-4a52-22d8-08dcd7a9d5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCtPrhF2S6bIHdmUmjA38mnigMpOvReUlpBzxP89e3I0KyAwCor7+dZucrDU?=
 =?us-ascii?Q?W+CAHqZkb6QpK9vrvIcJ8aoalCmnG0lOUxKTn5Ww9kB3zKecKrc0QufrMkw3?=
 =?us-ascii?Q?WaUf5vnks2b602oSQngmzKNOG2eEFkNLCO9KddnKNNvb4mau6T5mkEDK7Vl3?=
 =?us-ascii?Q?wnV13UKiG3uKOOAq075Q2SD3ugyoZzNyfEPbec6SJ7XWYfcIRtOFE87p0+qM?=
 =?us-ascii?Q?iBvaeRqMsEWo3Gpp4bQ8/zQYjLuqFkCilOQ58LtCQZQ//+PeYo6uX/6um0FM?=
 =?us-ascii?Q?v0mM2NlxvtN8g2uJ3jtDVXToI6YwQuf6N5TD5YchfRkCZ/IqhDjM3hWsghm2?=
 =?us-ascii?Q?swjxbdBGxjiR4kY0ySk35HmFXX1VpmT+ZsBXp4I90eN5/J5Fq5YAWRy1RNaB?=
 =?us-ascii?Q?PZ0s2QxmVZuf0t4TAvXlfqBdP6fBj4Kx5R18TVLxibN3W1Y0EMKcXzFf/8P5?=
 =?us-ascii?Q?ehGxaMW+XfcRh3C+xU5atFiLwMRbIS30eqZ9jmri9qWeSnQLnsZqnqDEU94/?=
 =?us-ascii?Q?+Qd/FWC+b0ZxxNoKYkSioMMvy2rm/Cbufzg3IwpVMIAY1Nh8/xMXPYb2k35X?=
 =?us-ascii?Q?pvGiDflgi0QlIXebZZ22v0LYelbnHLw+cG7hTDwvOvKbI6+m8nYnBLa/lbMa?=
 =?us-ascii?Q?QcObWGWgMom/fvr0qx2Dbqj59hNNB9uFY83JOdM+9bKzSbea0StuoGG/DWy7?=
 =?us-ascii?Q?2ITghZGHPXjr2nk3MycWTWL+W4EXgJqu0FyXNHFwOt/A7vKzAYxOfH2o6Saf?=
 =?us-ascii?Q?34pbWqc1xYvCI5hRdRWSm0qishbVaqhrMByU6OratXheqcoWr9pDYKaU1v5w?=
 =?us-ascii?Q?v+IsZEO8NIdEeJnqbb8qHv7DH8H57nxlmdD0dzVK5dfJ370izk25xhbxo/Mn?=
 =?us-ascii?Q?aBkb1W44qgOqwM1Pe4vrLRmrrTr3Pv6vgi8tjXRiIHhzyXakzWB7ee/mVcya?=
 =?us-ascii?Q?18tHss/39JxXdXSTDEKa6QP+TRFXJQJsWCsy+Bwhpu2ma5Yem5Cd0lL5QwOZ?=
 =?us-ascii?Q?oREyP/poKqborsjR8liV5bczBbSH2bEJYvU4nCeO3fgvomxW3DCcUziumwiL?=
 =?us-ascii?Q?CBxL90nNSN0Qm6Lxj8Geps5DyEO/70gwoK4QpwpXZ/5+IQPVl55F9SoYb8Qs?=
 =?us-ascii?Q?LDhNLNmx3BTBg3Xn2UXL+ROsB24QUgTHCAKYjU7GfUEHUIxriQqiZu7uyCFR?=
 =?us-ascii?Q?OER2+Vd6uFxC2VZ+tFwKqSF137adX9w4AFgbTQ9bNqhOQa+Xs0gjGhAnYgoF?=
 =?us-ascii?Q?XEFJXo7LkvqCbqGTwj74KqndTfzfpt8idGc/4q9BYaHBMyGfMOem+AAV48/i?=
 =?us-ascii?Q?jwRTMOjpHgKXe6JFC4AYhNPr1BAqR3mt1jQSqpyhqkjrcqjuJka9yIpLjXje?=
 =?us-ascii?Q?D1MnwAbw4eHwt02mGgyCYfiXVFJd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 06:19:21.3693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd128db-4d4c-4a52-22d8-08dcd7a9d5b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079

Store acp pci revision id in platform driver private structure for all
acp varaints.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-rembrandt.c | 1 +
 sound/soc/amd/acp/acp-renoir.c    | 1 +
 sound/soc/amd/acp/acp63.c         | 1 +
 sound/soc/amd/acp/acp70.c         | 1 +
 sound/soc/amd/acp/amd.h           | 1 +
 5 files changed, 5 insertions(+)

diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index af6005888c82..065ac13b2220 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -228,6 +228,7 @@ static int rembrandt_audio_probe(struct platform_device *pdev)
 	adata->num_dai = ARRAY_SIZE(acp_rmb_dai);
 	adata->rsrc = &rsrc;
 	adata->platform = REMBRANDT;
+	adata->acp_rev = chip->acp_rev;
 	adata->flag = chip->flag;
 	adata->is_i2s_config = chip->is_i2s_config;
 	adata->machines = snd_soc_acpi_amd_rmb_acp_machines;
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 65782023435e..f372a56a0a17 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -186,6 +186,7 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	adata->num_dai = ARRAY_SIZE(acp_renoir_dai);
 	adata->rsrc = &rsrc;
 	adata->platform = RENOIR;
+	adata->acp_rev = chip->acp_rev;
 	adata->flag = chip->flag;
 
 	adata->machines = snd_soc_acpi_amd_acp_machines;
diff --git a/sound/soc/amd/acp/acp63.c b/sound/soc/amd/acp/acp63.c
index 099e2df5558d..f0c516ccf96b 100644
--- a/sound/soc/amd/acp/acp63.c
+++ b/sound/soc/amd/acp/acp63.c
@@ -238,6 +238,7 @@ static int acp63_audio_probe(struct platform_device *pdev)
 	adata->num_dai = ARRAY_SIZE(acp63_dai);
 	adata->rsrc = &rsrc;
 	adata->platform = ACP63;
+	adata->acp_rev = chip->acp_rev;
 	adata->flag = chip->flag;
 	adata->is_i2s_config = chip->is_i2s_config;
 	adata->machines = snd_soc_acpi_amd_acp63_acp_machines;
diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index 0cd3daf677f5..82c26e4fefc1 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -209,6 +209,7 @@ static int acp_acp70_audio_probe(struct platform_device *pdev)
 	adata->num_dai = ARRAY_SIZE(acp70_dai);
 	adata->rsrc = &rsrc;
 	adata->machines = snd_soc_acpi_amd_acp70_acp_machines;
+	adata->acp_rev = chip->acp_rev;
 	if (chip->acp_rev == ACP70_PCI_ID)
 		adata->platform = ACP70;
 	else
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index c82e438a1712..dcfc29b2f072 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -177,6 +177,7 @@ struct acp_dev_data {
 	struct device *dev;
 	void __iomem *acp_base;
 	unsigned int i2s_irq;
+	unsigned int acp_rev;	/* ACP Revision id */
 
 	bool tdm_mode;
 	bool is_i2s_config;
-- 
2.34.1


