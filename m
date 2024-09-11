Return-Path: <linux-kernel+bounces-324607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17792974EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290AF1C21A60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721AD178388;
	Wed, 11 Sep 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OqlzOlaK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B831422AB;
	Wed, 11 Sep 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047379; cv=fail; b=JR4snFp+YEZLye54pMUAaImsTtaQ3n7IEqHv1uLgEkadXoH/9XJPb8+vS+aShT5034EbI443BoMW+dIQrUIUcWBbZUo+bcpS99HhVTZRd5tUFwdJtPawG7B1FvmwXXe+WEhj0unzu/m5S1FpB3IQavT+UKrCW02jV21o2dXBHwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047379; c=relaxed/simple;
	bh=HWWFHq0qDk+f9kptFsNfcVKUZHt3aTpI2KhLKEybHkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sRRc076u18XhyHRmnm4myTRYFqtn7H3wW8b44n4MwS0+c0z3t5ekaw+79grdlxXTupQZ2HpXtK0sLwoZgL5z+tt5BpS6U4lj7XcOGouoJcD4xM7b0H1XZj1Nx9qDRnNfrO2gbZ3XJFShtcCe2fFS22otUsNFZ4mF8l+Ckjo4kY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OqlzOlaK; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otM6emOXUHf1r/eLEiQ7IzuSxFMjITFDNj2yr9TFm0NJ+j+O8UR0DdRI5SY7MzMjnxq1M85J0Gnh9Mnv5hh/XXRUVHm+jk3yRU6VNNqk8r+LdoD8Or+K3WM3esaeo8kZDfOPkoO/XKHJOCwLkbRRfwg/UU21RKSZqOmytV13PTC4mbgZf7FPiDuM6IRDpz+VVqp3B6vVjMHb4v1TcLmvEjvcPYFKwJ0p90n6j/LCSwZINT4qB38HXWxsWxzsPQTS8mxX5QcLx7ciRw231l1to0SDgYdFIg84R63lj4ks6rsPsm9QuOIvvqou3m2atKFryFY52dlreU1cdCptcDAHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Nh6CW2WHjFxPH11IE5KvqZJElJEG4jrqR0ag9f1Tcw=;
 b=BZdPbiFQ9ijgXYVKsuQa4xqAOkHvHQsD812m4MgKicWM+lPV/pTngV6BwOfRIApLVxfMPSBaJh2vTlTe0ytAela9zCFlJcTYCq9kFjzWfNYsCma7DYSaT5l45msVeophwUDSjnX624otihYGC1b6Q6G8WfVxfcMCGLVVREnp17ibDARvvtRiXpDXyxuzerDQR+fMwIR2QzRNEAH/k0y7Rd7XQA1QQidD1ZSQ50c3h8HvqUFE1m99uLuvN+91d0ipQf8+JoXZZPUAbXtjwJdhvLD7xsslT2jDS3/+XzKnDnivFPGaVkwER5KC0JuS8KUeU8fKkTdXjNNQZYHVjT1B0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Nh6CW2WHjFxPH11IE5KvqZJElJEG4jrqR0ag9f1Tcw=;
 b=OqlzOlaKRW3MBDAswYKo6YcS4yeezKbaq2kIM54MoZSoOjmntNJcIU5KK4/OuiqdrZf12B2k3rVau1OGZKD4KSY4xgrx+J7UzmmKjEXYejXx5zYa3rY1LF7rSmjNCKzbXqVp7ko00SH1n4mPTeI0SSJ5rDsQjHSHlOXUd4eA+eA=
Received: from CH5PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:1ed::6)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 09:36:14 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::8e) by CH5PR02CA0024.outlook.office365.com
 (2603:10b6:610:1ed::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 09:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 09:36:14 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 04:36:10 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<cristian.ciocaltea@collabora.com>, <Syed.SabaKareem@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 1/2] ASoC: amd: acp: remove MODULE_ALIAS for legacy machine driver
Date: Wed, 11 Sep 2024 15:05:53 +0530
Message-ID: <20240911093554.2076872-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 333142a5-3bee-4faa-6e06-08dcd2452df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vnD9Pr+o9AUEZX57UV7OAiVCmc6pw56NghJxZOOJthM6a7c/P7Z4ptla3ern?=
 =?us-ascii?Q?bh1bexduNPrWOyzc8aUVUn0A9/gKcoMYUHF1RX+9tHRVWttHQ/n0vmdr8pKJ?=
 =?us-ascii?Q?kBdmaOTE5Ym/XLhct3mcGQyRbi53KoTQwJkKDIvBlzHBkZgH9Wr8+dtKfO6D?=
 =?us-ascii?Q?FI70nxaPz/VNULYbnjkYAPXv3BEwSEKgEuEpZvAxXays5rgu48PEyuMv42vL?=
 =?us-ascii?Q?XwPtl+elwFQ8JetSf4a32WF1IcvDcF8oVXRzgmxyg7IvT8H2ZkFXI3kQ33rv?=
 =?us-ascii?Q?rJeVQUcLTYnvZr2LAXpBuR5miAKafLkw1v0d6zmK7OcbLHcDI1DtqdP7zWz2?=
 =?us-ascii?Q?Spi3VYOfnikdNxNdWADxMc4ISd4frNeBoAVSNjjOo4ZZ1RSLMgoK1zw0m1tn?=
 =?us-ascii?Q?Ie2yg4P76Pz5sTFQa/D5d+OsBzF0fDcjZWZynWwcTdiruvo+2Q7CdMlhCCzK?=
 =?us-ascii?Q?b/FHmckmgpFfq3bZE0q/i0qjY+LB3sgGdonjL65UTxmfCBz/Zp+3FjBCeUEk?=
 =?us-ascii?Q?DyIEOFauizAP38Uz82hKYCo2CsZvGnDN7o3ZiOLsOfByeyrTGrBjc6KSSDxO?=
 =?us-ascii?Q?NOcN2Qij4M0NjoWAjPzLAfUpmcQChpjUytcvOUusphrirR+9HjeRAjvCc1Mx?=
 =?us-ascii?Q?ZzQ2GZw/RWC6281stKnwav8EqtWQH1eNg2RO0A9hCO8M1NPI+FwAcSdM20rc?=
 =?us-ascii?Q?ZCHgEnNB5zEwxEPrT/jHz+McVwNPUP4o+9lHglZxZ5CSCLEOrib+SOCBkmTX?=
 =?us-ascii?Q?QNETZCq59z8RBUSlpf3Ll0JbrBmbAG0Cp9pnCRxNO/WZQdDNdpmDLtg/U14x?=
 =?us-ascii?Q?qTsG3lr6Quy5gey0KdBI+wmlysjV5hwOIa/Kr7Re/49OpBvTxFR5y49Fa3ta?=
 =?us-ascii?Q?kkpE8cPTX6TMtxMoAmxvn9AgGA8DJGe8LBK/E6nrDzTIYJ0ZpdiACTsBcg7z?=
 =?us-ascii?Q?dTHMahNvux6IwdTdnYTC/3julONdE+4wbAPo4Cxtw0Wk+QvUnYWaSUIalNDu?=
 =?us-ascii?Q?Jjug8HS0cwhqvLISIaiHKRYUELEEaJWlQIL5SR4UJ071PVmSdWoQZ/pWmx58?=
 =?us-ascii?Q?YA9MJIV4D3flWVGebSiUFNtWmszrgMDzOBT3MkPlrgOc4Bt3UA9JJ6tsAB5N?=
 =?us-ascii?Q?D29+NZAIJPw+XCiRJklKBQ2UKWNo6wZcj7DF5j6soy17JQRfMCql00hRkltJ?=
 =?us-ascii?Q?UkHj7oxkfbbJxAo2osTppdPhmxCzt+9TmxwS2EG8FXOZZu4jz/bIJ+tIih76?=
 =?us-ascii?Q?Es0KGl+uNnN9mWjy8i/2jBGmixe08lP7eXfqa4DdBlg4+Ctjcttjn9yFB7y2?=
 =?us-ascii?Q?PPTAdFOTnYzujr1KySwLb6kWwoIIlXXjK6HBp3WWlaHqo3NYGdvvMQXcuJKs?=
 =?us-ascii?Q?c1K9azGzRQFQhGW4Dj1OlAcaNUUl8Vg58YcNBKdl6sTOsM+3RrPY2JeGaUOZ?=
 =?us-ascii?Q?pDyR/Q+avJV4d377ZSJEVOyD8X7F5C8r?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:36:14.4244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333142a5-3bee-4faa-6e06-08dcd2452df4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

As module device table added for AMD legacy machine driver, MODULE_ALIAS
is not required. Remove MODULE_ALIAS for AMD legacy machine driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 0d529e32e552..d104f7e8fdcd 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -242,11 +242,4 @@ module_platform_driver(acp_asoc_audio);
 
 MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
 MODULE_DESCRIPTION("ACP chrome audio support");
-MODULE_ALIAS("platform:acp3xalc56821019");
-MODULE_ALIAS("platform:acp3xalc5682sm98360");
-MODULE_ALIAS("platform:acp3xalc5682s1019");
-MODULE_ALIAS("platform:acp3x-es83xx");
-MODULE_ALIAS("platform:rmb-nau8825-max");
-MODULE_ALIAS("platform:rmb-rt5682s-rt1019");
-MODULE_ALIAS("platform:acp-pdm-mach");
 MODULE_LICENSE("GPL v2");
-- 
2.34.1


