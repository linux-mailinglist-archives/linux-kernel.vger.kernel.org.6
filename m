Return-Path: <linux-kernel+bounces-444316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C049F04A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D57816A7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C918A92F;
	Fri, 13 Dec 2024 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0C0rF3iG"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0B1547CC;
	Fri, 13 Dec 2024 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070318; cv=fail; b=KCbCn+CC/L+ugUFov9xfJOX3mERMSpbP4Exp3CXE/0zOfwTab4baTWslwYYfMSODjXp/MvT75KiA5DmwSOmzFuWC/nraZh4SIW94XMCRqXayZ+QK1LNI2obUdKUKf49Gp7UKNSsOY2VB4fxXSmLW66fgHIIUSgiDz6JWPyYLUM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070318; c=relaxed/simple;
	bh=0BlJ1MLrGAoh+EplO+Qa5A8YtvcQly4RhZfw3jEp4WU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTUOviHhWHz1m1ZLQ5+AMs19FuVkCO34jq3RxZWjr3b0+MpdwD9A4YJ62X0vYx/2NbOf4/wM2U7xrYxY0AbUajmYYV6jnFY+reW3VndYuTVcg+O/hqRqKesAmmS69MDmUHi2R3dL4WPxrlmvakk4LWjiHK/45fO6g33hYuw98uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0C0rF3iG; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8AJh8qibnR1GbHOgMC+BOoD2UORgBMdeDoVEeP6MSMJ46EZ2s/4vBaM66ktodSsSSWT/Z64ZDWYEeGfrEsEm7C0mvNhQHV+JWwm/IHCM45X6Lth7FzO5EwYjGCESpu0S9dcA/nyDRezps/jJFPeU58oBWye2EVDM30Uh5Hn3suQ0FaOoncywQe7CF8oDOVDd4lelcSWJPbScp8aAoLrhAbu26igIaz4j8gNyWZaq/xCQSXJg/mIt8kbyBN8GKXHp8SX8pj/6/nYUio1PG0UgEyPhgNKmSfpffM6o2o2QrIkgUCLm+F91l0v+bE8oSLVOKm4NkvC5UuQH95gYH1B9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iojgeCIrd8Fb2m2rXVr3FYC8X3NT3dmkZsZ4UJ67bto=;
 b=S4FjNlJHrJj6cax4mJHYcEEpCGAy7y3rh8W4swMyC85+bYtZtiEbfD7iOcnt31VxfB2s6t0IE9TLC7gcuYWWj9WAw1lIZOyuqNHOCxsMt+uk0u3IOgqETw/tNzDXGhboy6DT381yE21g/14zRqfDKWwAoPyR166YRGheOlM9R1vg1hhJLg1DP0auzZjSlBsCuW42J6WcqT7qSFzjIedcWmRfHDnMiiGkhpH3Rgh5Ha1G2ryAjZ4OjK5puVs5lYVVeR9vA8xFyIqk5Sr3qtfpfUorRm/BpQ6f39p2V7xKYaq+2vClX6iFIpX+pSn7Wsuxo/7JHvt+ebzc4fhnVGRt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iojgeCIrd8Fb2m2rXVr3FYC8X3NT3dmkZsZ4UJ67bto=;
 b=0C0rF3iGLIV6NY/zDM7kJ5Fb3qvBdf0LGQTqy31oAz+fWDXj0C/IR6sIXWqt+0JSZoglBD3+GqahZC3+djnU+m3INnYfXtk/WF45O2pdLrYpjoS8mfNiXN6GGCvK4MpUb2kJ7OlYUHNATnx0BFIuNeYGXzTH+uiItRQxL9gtMzU=
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 06:11:53 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::23) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 06:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 06:11:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 00:11:52 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 00:11:51 -0600
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 00:11:47 -0600
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <mario.limonciello@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<syed.sabakareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, =?UTF-8?q?P=C3=A9ter=20Ujfalusi?=
	<peter.ujfalusi@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: ps: Fix for enabling DMIC on acp63 platform via _DSD entry
Date: Fri, 13 Dec 2024 11:41:46 +0530
Message-ID: <20241213061147.1060451-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: f58d2468-3271-483b-2399-08dd1b3d09dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IQMly5ChsgniHtstsBAnVazIk7GjETsBNvdQXxJwGEv+L/84DLvhcGJ4LfJJ?=
 =?us-ascii?Q?nZab8qBCU7tAfvx5RvcZEt0r/k2hV/R637U+k/3RoOrT6xOHoad3LDYhihLn?=
 =?us-ascii?Q?kLmmpjVIZ8QmR9sBae3dQIZK55re9m3jzVc9dNic7qZAQUXE3a23WOIb+ckD?=
 =?us-ascii?Q?t3hU8XjSFrLmJShCl+ad4TF1xCp6klyNMbKFWJ6dya4Qg97oTfJVlcCqc0RM?=
 =?us-ascii?Q?4hRnJJK/yWftqpLqZpG5TfZ11O3nGDRalzyKEVLd89ybvaVeTBgkHi9YlJMg?=
 =?us-ascii?Q?vKkvFWoCGCpoVdiAqgQ81td9R7y7C4V7e+dvqGY9how/sUdCDm3QgdY6LUVu?=
 =?us-ascii?Q?TZaDrsbKD8uiramb9bmSQ/Qwe/jfgtXgBrv/4Hl3qPARWzViPt/epzl839wO?=
 =?us-ascii?Q?h4EAlgXBpd7LC3pRyb43nlHqSDrsMdrwTApL5hrCfQ76p6thpQvoIc4T5irD?=
 =?us-ascii?Q?OmQvs13FnnalUyITRHr3o/GR2hUnz8SpwX9630ydTfE6RqsWuLOY9bt9ihWw?=
 =?us-ascii?Q?XZEahb9ozVx3JQQ2TmaTK6QJhc/UCkj3bBuwOQ1BfyPqb+zl2yuYAFGh0WGG?=
 =?us-ascii?Q?ieNQcPp3mzw4HEPis/EWAxnzqg0L6ciK8AOq+W+zcDrYY9/RJz7HHaFeFF3m?=
 =?us-ascii?Q?uO62MUC0jIgRfsnqmeEXNftlEuObyPYhfdj2fwgf9YJWv20lKGTHWbIxyVzW?=
 =?us-ascii?Q?9yChA1ACssI/UVuL69tsaoaA97XZ/D9wMFIbxyH2ffCiLEsJBLFifQ5usyi8?=
 =?us-ascii?Q?YD6qWFDpW6ow76N4jcJBXg+ZAHbCyi/rM/z32rsV9bJ0bWMVo3DCLpwYKGQ1?=
 =?us-ascii?Q?j3H+sM0oFmCslyrIr36LbIsm6R5T9VzeOfWe7qQF8ggm8mMESZrwPRyehAvd?=
 =?us-ascii?Q?ZKsTQQViIteyN70885TxrOi1aUPKXNjGlWJ1RUWqBbkXYFWdvvEVuMO/4Kc9?=
 =?us-ascii?Q?ygQaNQ/xp0znNHimpBHZVmaSY83WjD5zeVFS3YKDJkwys4pcy1naN4/pudg1?=
 =?us-ascii?Q?FQwOmpUgCr94Z9Ij6jCi4KlBEESf6IVUKFjk7HzwTVdoFOmpQYW+m+UwtF3C?=
 =?us-ascii?Q?g3GFt/3mLKEEpzuDyOGxTGiWc0c4hIGM5ej0B5yS4Z/2m7stLRsMxEWTqntQ?=
 =?us-ascii?Q?1sHZgzFQiKoKPDfN2AGpsDhV51h3PnX1vGhbeqjMHB99h3kL/WOOlLYb1Eii?=
 =?us-ascii?Q?bXikus1P952qdAuxwQCGYMDAuICHwtjjx3Yhha49haAIF/E2LL5ZS/FBl9sS?=
 =?us-ascii?Q?RDCrOcpak96/8qwLTj4n/I1qXyiJqjYf0ugT0RKY/w/Hq8UC7xslpS1DfNhN?=
 =?us-ascii?Q?A/4IcK73/r57Y5VLdlz1oroxFcy8fzUuEr3CZoYMaz1jLVBflUbO1126JIMT?=
 =?us-ascii?Q?SH7//7m2EV4LHDhxMlxFEZAaB0RHeIZ183+et1A6wIGEqfGDL/HUFAYC1DGK?=
 =?us-ascii?Q?VUAZUzn0h8/mOHsOdGo12avxjy3Mfam0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:11:52.8074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58d2468-3271-483b-2399-08dd1b3d09dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

Add condition check to register ACP PDM sound card by reading
_WOV acpi entry.

Fixes: 0386d765f27a ("ASoC: amd: ps: refactor acp device configuration read logic")

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index a7583844f5b4..983d7fa13938 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -374,11 +374,18 @@ static int get_acp63_device_config(struct pci_dev *pci, struct acp63_dev_data *a
 {
 	struct acpi_device *pdm_dev;
 	const union acpi_object *obj;
+	acpi_handle handle;
+	acpi_integer dmic_status;
 	u32 config;
 	bool is_dmic_dev = false;
 	bool is_sdw_dev = false;
+	bool wov_en, dmic_en;
 	int ret;
 
+	/* IF WOV entry not found, enable dmic based on acp-audio-device-type entry*/
+	wov_en = true;
+	dmic_en = false;
+
 	config = readl(acp_data->acp63_base + ACP_PIN_CONFIG);
 	switch (config) {
 	case ACP_CONFIG_4:
@@ -411,10 +418,18 @@ static int get_acp63_device_config(struct pci_dev *pci, struct acp63_dev_data *a
 			if (!acpi_dev_get_property(pdm_dev, "acp-audio-device-type",
 						   ACPI_TYPE_INTEGER, &obj) &&
 						   obj->integer.value == ACP_DMIC_DEV)
-				is_dmic_dev = true;
+				dmic_en = true;
 		}
+
+		handle = ACPI_HANDLE(&pci->dev);
+		ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
+		if (!ACPI_FAILURE(ret))
+			wov_en = dmic_status;
 	}
 
+	if (dmic_en && wov_en)
+		is_dmic_dev = true;
+
 	if (acp_data->is_sdw_config) {
 		ret = acp_scan_sdw_devices(&pci->dev, ACP63_SDW_ADDR);
 		if (!ret && acp_data->info.link_mask)
-- 
2.25.1


