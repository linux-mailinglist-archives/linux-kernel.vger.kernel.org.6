Return-Path: <linux-kernel+bounces-336608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F23983CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A678B1F23058
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56C512D1FA;
	Tue, 24 Sep 2024 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fOBWK81q"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3917F460;
	Tue, 24 Sep 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158741; cv=fail; b=sg25FSyXZGIxPv5cj2Va9dcz+PsdvzXv2uTLQQb0FJj/9jTx1hu5j/gSpcGwnmEMxC68Rkx2zftyG5XxDyYD6RvA7j900KM7rrdUM16Hf0Z1yApe5gUKEpEr+lC0knxLlOmeR0UvrfUJfDCXd2YRnlZ3crxyto8vik/d/LJWeDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158741; c=relaxed/simple;
	bh=hOezVq1+7iN2CEX2zu6ii4h12kDi7pUnqfq+F/a582U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gA27iHnSxIYPm52J8MptaED1rmPaDXrY31bcFXKFaoQLdula69PwGBRFsgWxUE+e+Cia2lurKfZ9BrvF+oIYagHiFPLvodj945mrn1oKRxoXUuxVJYe4BhQmfn4l0C2XZbrXaU1vQvafDvMoJk7VBPEQKKrHp5q3ATtlzZUlk+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fOBWK81q; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN5sbvDCzUvkPPKjE/jbo4IygQSJym2aivmoveu4C6lJRZnonaKI/8uIxFPk7U9DbPtk2nE4KUIuucdsbhMvPJSBY7a5nJkpUI2ER/xxDxDC8GErBBXcluoquS8WzWfIXdnZcQoMAj5rsRIeHhZ6uE/Q4Q8dxcx9VZv34E8B8NQBJt9i7tCM2cJ+jWX/toKXi3QWfwf863yp5A54ZQ54tKg6Gxg8ZGFeuAdy31EgpqFgqFAYN4wRVP5n6ODo97aApDxEXCf/wFQMtiBuQFoLEssizVCkbzBSWMdW5MVZPPmSxQKdl8W0tvpJc/WhbXiVWqs2wwEcNHDJYKELZDoe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DbNpM1+Et8OoKgJBCBnOtnExxvpnwQEy2lpYYAnl4c=;
 b=aZU/L56VuuoG5jifHXE8z9WBrBxmu3X9oUjp9AjavAMdITzjt6pNG+4nSM5/FvRekEM6dzb/zvxn0Z+cPh0HqBsA3Odz85CSnTlWXEfaZdNy/PUEGEBFnTJqmj2QtsES0RSOLw9OU8LXVMlx7HbhNyPlZlTr1hfipXhji9xXLrmodk7Op6bIMEJvBCAXo9DIoLmIf6sci6F+DzauK+kLWmUMt+2tm52y1NABQTTplfnk9x6rPzE3/xTy0cdEeQx+/Y/0qjx+eRif+9EZrClFuIaYKqV+EPuoc31B6IPnS43tIQBBelxHPQUCVoGNNDFSBGJzmptaxP9+ML0S2EKFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DbNpM1+Et8OoKgJBCBnOtnExxvpnwQEy2lpYYAnl4c=;
 b=fOBWK81qihbSJSsNj3khjyBRd2309lTlEqz5Md1uH7dTMKU0/Hw/cwc/p5XtGDPzlkoi0v+X89YDuiNf1EUWlEXgF30q+hs1Q72sjhwWo3zBUKlEIDEcB3zzgYLn9IuQzDnccsh7wjdIj8ScpyvBSCHxftZvWrPevZ0zzyM2ORI=
Received: from SA9PR13CA0042.namprd13.prod.outlook.com (2603:10b6:806:22::17)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 06:18:56 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:22:cafe::fb) by SA9PR13CA0042.outlook.office365.com
 (2603:10b6:806:22::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16 via Frontend
 Transport; Tue, 24 Sep 2024 06:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 24 Sep 2024 06:18:56 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 01:18:52 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 5/9] ASoC: amd: acp: pass acp pci revision id as platform data
Date: Tue, 24 Sep 2024 11:48:17 +0530
Message-ID: <20240924061821.1127054-6-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: d049b8c0-fbce-43a9-4663-08dcdc60c543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eIf+3O/YiyA9uY9ZwQIvebocyquybIMzEKVw9iEyyTe8vzlGpd0ilp/FREJp?=
 =?us-ascii?Q?0lE6d2Fxvnp8/Bk9Q/c5loutUcWtIEtVhRWsVMCoxvLQ5wVsAQXSJ9Nxmv4f?=
 =?us-ascii?Q?0oesTp0zeJTNZWsknsdj/ynWJoPshhaV0wuRX8s7+/mXbqoG3gOnv9tlD1pR?=
 =?us-ascii?Q?jPwfFZhmOtHmcvdiLcfGAWeu1BNtjudu2J08YNTVx4tG9c0iRZLODlOAUkv0?=
 =?us-ascii?Q?xhwWMXSgicrlE/AeVa1IGi6weYQWQCF0enpgyEjWf1p5Xmx2njQAan/HskNH?=
 =?us-ascii?Q?fGGXwTitpfBTfBYhjz4+FKnVg0Azruch98Wy90HMatjCGqXzrtAHqtM5ebU0?=
 =?us-ascii?Q?Y4uXUXV4GDjmOPuPiovqteLoGOzv5yXNdcJvythN/CRpGoCA8rHPqUFaBTu4?=
 =?us-ascii?Q?kgk4N9l8Alu4p6eAyBPz6GdhvEZ3HVgYs85gE3KdAk4mjGC/kDii3msbWsl2?=
 =?us-ascii?Q?pggSN0OJk112JguyJHSKTyA16FidY+GxFaTuYiQPCOwb/b1B08wnYvDDr7kM?=
 =?us-ascii?Q?uQBXiUr/BhJrBIK6OEntbniKAnIZ9PvRHy+FWIiylP2kduuGUfJWhhfRX7mT?=
 =?us-ascii?Q?GG0hj8Et9kFAQFXz4oVICzj9dCtuC4PoHKHQG7jtou/w3Z58rHNHQZcYjuFp?=
 =?us-ascii?Q?ArXsUCjfGtH3ed3iAtnIIGiNRcLAD1s3VHJsZ2e6yPtbKmxXxnOW8NUyH17m?=
 =?us-ascii?Q?Jkv6DxHr7nlgsurQfKoa0n2rTL9Xmha591CEgsd5cz0gc4NWKZy866CDSuDU?=
 =?us-ascii?Q?iGuyO0kZwixA1R4OdRHc/wAOjNkiLiKOcVWsDunG0dnbxu6UrqQutCaQIlNv?=
 =?us-ascii?Q?NE++d+/XurWqWfzsXdEhSjWTwTPAfqN5mV4bSbnz1J/8eoOrRM84Vr40dwfW?=
 =?us-ascii?Q?9hD2Gta6DAeT2nnWWShEBfLhixLJVYNJ3aTH3ChnMFIVHimGndKy5Q/sfKg1?=
 =?us-ascii?Q?WKoJTXYJU9ZbnWISM4aKkwMPIa6DgeI051UtsYem5ZY4EyJwNfDnl+ghJq7f?=
 =?us-ascii?Q?0vjsnpWDIIiYSfYBnnWlpphxnWS/w/O7x7LWTbzZAve0xjkMmRq3qTnQ+UGQ?=
 =?us-ascii?Q?5H3iZn9IeW/KSVCbvXc7i+0d6WK+m48EiFxE4QSz1CG4bu1SNLE+JAouFxTV?=
 =?us-ascii?Q?KLOk9p9JmtLmBTnVVxC32dd4bW8ml7NlVwk0/g8+4KsVa6lnK2Tqb6fNnfN5?=
 =?us-ascii?Q?gKxIpsaSO8/r6vjs8zFWqpcp3y8JG7plhgIBI8O5sLfZMRSmcxqkOju0OcL8?=
 =?us-ascii?Q?LGS1xAo2/SjeIiSJD6/pQ5STxqDb6qF4Jn7U6QsTUDI1xoDO0r99rVuXzFD3?=
 =?us-ascii?Q?MJNwTANdMVDks8KDttYd6TYYh6H8caE7CE3MCYUlddeEhiok34DZnm/IY9zB?=
 =?us-ascii?Q?oTUGy/REvtgMqFM5ihvIJkjXeGViczYS1W9LnQwAgjIkKaAIAkdZn1b/OA7a?=
 =?us-ascii?Q?86+cCIHFiN1gPag01k3l5XXlRgupesCT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:18:56.3321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d049b8c0-fbce-43a9-4663-08dcdc60c543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

Pass acp pci revision id as platform data to machine driver instead of
'platform' variable when ACP PDM configuration is selected. 'acp_rev'
should be retrieved from mach params revision id for other configuration.
Modify the conditional check for the same.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c | 5 +++--
 sound/soc/amd/acp/acp-platform.c    | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 2a59f7916e15..3526fbe2c84d 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -172,9 +172,10 @@ static int acp_asoc_probe(struct platform_device *pdev)
 		goto out;
 	}
 	if (!strcmp(pdev->name, "acp-pdm-mach"))
-		acp_card_drvdata->platform =  *((int *)dev->platform_data);
+		acp_card_drvdata->acp_rev =  *((int *)dev->platform_data);
+	else
+		acp_card_drvdata->acp_rev = mach->mach_params.subsystem_rev;
 
-	acp_card_drvdata->acp_rev = mach->mach_params.subsystem_rev;
 	dmi_id = dmi_first_match(acp_quirk_table);
 	if (dmi_id && dmi_id->driver_data)
 		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index c772520227c7..a6e5cb263377 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -114,7 +114,7 @@ int acp_machine_select(struct acp_dev_data *adata)
 	int size, platform;
 
 	if (adata->flag == FLAG_AMD_LEGACY_ONLY_DMIC) {
-		platform = adata->platform;
+		platform = adata->acp_rev;
 		adata->mach_dev = platform_device_register_data(adata->dev, "acp-pdm-mach",
 								PLATFORM_DEVID_NONE, &platform,
 								sizeof(platform));
-- 
2.34.1


