Return-Path: <linux-kernel+bounces-271161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BD1944A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B1B272A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72113189539;
	Thu,  1 Aug 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P60gXjuc"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FE189BB5;
	Thu,  1 Aug 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511215; cv=fail; b=nBL6QWCqs7KHYI0HMI3csqyGbMfjd7Yjo2WPIWkg2FsSWbmy00Tu3gFYQp33dUHcJw8Rv6rY4WbeVtS0ITo288LMtpwgWJ+NNfIejGPe9MTarAHBDALq/SrAoDngdKXL8hFxvnjVCGgaOZzwrHHf2agsdY580aGkF3NzODcsGVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511215; c=relaxed/simple;
	bh=S3n0J3owHJ+g3wrYyT2gKOndf+1ztgwZfxHeUsjXfu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYNZOv0AEPUxn90lDhGxLXhUX2s2fKA2dpdl/RO0mLcKDU/G8aljcDrVVjkGF4CSz6+HC2iD4dJC9dGlxL5uwvlFgDOHMuNt+zxfhIoOk82K9/+RriC1GiFpMd7/Zqr8ig4jIZBjW+UZ53TqdMWi2Os4EmSKIdKQkWSYOjfsqdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P60gXjuc; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jv4FYud7OcyiiLk5DkD+O+GeL6faLiK19jLHiuzN7IEfvkpjcv2iBjsl6hHhsOXF/KRheY26eD/PF8jgQlKBx/8DrhP7bo9bPHAPBfNDguBR9g2pVh2BMNjQqB9ZTLb375gK2o1wJXotorGFR0ZqqniYKVyPvygmMSke4haTE8/anJx5HbDu1Y3gTIomSUj0KtA1NXa2ex4fWsQ7NhwJEWYH0t3DuVpVsrOQ98fqMWcMWW+JWVgNsfiDnwVcCfwtJxcUch/vTcTPncA73ohZww25VqGIT+Ah4/RdTjEQ0oI6A5BqmwbJyDo9ufmvl+ORe5a3y0NdmjpNji8LGfe/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1d43oNOQj4hNey9pwcUOZAYE4Ujn1MA45S+NeAiJvg=;
 b=YyyNlyxCRkJ3YirX+zO3FT+wDkwiZuP8O4WdqV55ZocOk0DCywXv34/juQpdVGdsi58u/MyBKSpW6FqHE6xLidyVHJmsi9N13mO4/Eot7ZAwwn4vHFw/hWVaHzWyqV9sFOiw0p9s1xK96+UmNFSzJ4rPFXK+nu5lK6NQb0yqXBoL9iLdSoub2IehusweNONPcTHFxQqYPVbftaCI5z9jXfpfZGgCdiI/8HqskW/RVeawEZAQL9K2Bxw2c1GRo+D284lcvNWeobkt8GqxDOUAqtt2ta8tGIHAq/7UUOvfF2Fga95KZAbhVymw/Oc1XpV+2oismK8C4dtH1N93LzqKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1d43oNOQj4hNey9pwcUOZAYE4Ujn1MA45S+NeAiJvg=;
 b=P60gXjucs5py6HXNM/rjY4dzJGvRbZHelNnigj2t/+l6kinvRlC1rvWQ9pIf/R5jyn7Yt5a6PQDKQwy/3DzVwn+74IRpNhRfPxE+liR5iGBn0MzSTXQQqUEOGLtyC7V/SbPWwepkXO1o9X+XXxBICg/x4/6CZ8zTk7UMVj4XW7o=
Received: from BL1PR13CA0330.namprd13.prod.outlook.com (2603:10b6:208:2c1::35)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 11:20:11 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::4c) by BL1PR13CA0330.outlook.office365.com
 (2603:10b6:208:2c1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.14 via Frontend
 Transport; Thu, 1 Aug 2024 11:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 11:20:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 06:20:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 06:20:10 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 06:20:01 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <vijendar.mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <alsa-devel@alsa-project.org>,
	<pierre-louis.bossart@linux.intel.com>, <venkataprasad.potturu@amd.com>,
	<yung-chuan.liao@linux.intel.com>, <linux-sound@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 27/31] ASoC: soc-acpi: add pci revision id field in mach params structure
Date: Thu, 1 Aug 2024 16:48:13 +0530
Message-ID: <20240801111821.18076-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801111821.18076-1-Vijendar.Mukunda@amd.com>
References: <20240801091446.10457-1-Vijendar.Mukunda@amd.com>
 <20240801111821.18076-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a74b3db-931e-4b49-396d-08dcb21be842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2U05r43wuv0ZMuNyi/SwobU0HOon7eZ4es44m1oj6QnfwLzjNfMmcffvDud5?=
 =?us-ascii?Q?xuSFcSc2aUOrHWnzA7K2Jz91pO9RDvotL8eIJEPmu4HY7wu2BEtRaaWi3DUf?=
 =?us-ascii?Q?t0oTnVwqpBUxU6hld8LxCIHCNdMpo2AKPqs3dyEowhgLZKOPLS2aUuRpPVBJ?=
 =?us-ascii?Q?3ZQl9AQSM8kbB5ZWRBWjVd8dIodfA1nC9kxSECU5hLoUBV8ptDGmxzK/kVLw?=
 =?us-ascii?Q?v23U2ut3XSaeADFi+WaP1w+5GGqywMDJeWvnxbMKFRUklRF+EfDEZNBbFOlJ?=
 =?us-ascii?Q?81GHlt6jhMnQQIW+JJM9CFmTp3i70hA+7B6xYeEzkEQpijB/dg4zkeIzsQZS?=
 =?us-ascii?Q?Er7p1MHGFY1W/Ge3x9Gyw+DLOkopWqZIhdCHOp67ycHpCsqE2L0OtsfM+ZGC?=
 =?us-ascii?Q?/RIa3rRSxLv8aKQr71Xe6nfRfhSxpFEzBxTBKy0Q6TYRxVmfoE4PiDuKWON9?=
 =?us-ascii?Q?/+Yn+zqHeJShw2BJuFuAbiZKAwfu1x7uVd3RA78WJlwl06iwNnQZ+EiUCsL+?=
 =?us-ascii?Q?kZhozRgyU56PX9Esy0W2id0Ov+1kWbQTxQgyrjpj+YrCOYp95CbUdiXCU9jU?=
 =?us-ascii?Q?TjulpgkfuX3Zx8oYjztwVlaqrfWTzg8KZ4LzI82r4QHxW7UltWm57Cj6hE1j?=
 =?us-ascii?Q?EFT1tsBD8C7awxJaXT9wbsmeH0KtnFjVIsV9E9DHG9Rl0cAlGPuvvgBNmy/e?=
 =?us-ascii?Q?YpmmMLDaCyf+z2s0rljQjDhZRXxjmxG7jfpGElY5sGc7mb5EqXKYFnzZUVVN?=
 =?us-ascii?Q?lyejksLnBYrtWX9f1W/+N+ynYZ30r24QAuQOtz7orZrkq57Fuf7WDQaq+3lw?=
 =?us-ascii?Q?uS5TD7vOrpDTJ4xrAEiw6dIv25VOISfB4SSdHkrhNOqJOb1oLhgm8fXXHCgS?=
 =?us-ascii?Q?kLg7fYlL4VTGehBozeu/GU0OVY1DO05pFcFNKZKxD1BH6vydnzSG+6azgOvO?=
 =?us-ascii?Q?msKgDFhkOGWPoGd+jm8xgg53J3zFdUagFLMvMQbOTncolpXL8swujsiz0ZcK?=
 =?us-ascii?Q?HVB+thNSD6mu/f+6tRWF7jPKnE4bdYzyrTztGcay0HzHi1rGTBQA9JhSLrCe?=
 =?us-ascii?Q?eeFusDWYLIa1oCTwjQIYEPoDN0Ql8+4jmWDI3qe/i4sQfPGFTaNmFoldjOvJ?=
 =?us-ascii?Q?ZODTM1fylQovJhvKUnid1UDfmaglphB/8TLSfhxmxajIKdJkRFZtJt8z+OJI?=
 =?us-ascii?Q?B3ua2o0XK1SH24t/Z3FVn7A9Ec37lo2dgZaA/bgeTPugijy9oAuwrmloQxvW?=
 =?us-ascii?Q?FJJmQIGTj6k9tMNVmbSHUhaYaPcWwc4C6ik1B6Eie/AO++N0fZxR/NUmF8mI?=
 =?us-ascii?Q?H2kZIqo3MZwzdBhD37Z4iQXRK4gZ19p0Qg56SZcESo+6nI6Wsgc+HM1nRgFA?=
 =?us-ascii?Q?KUYwbF7G3bYTbIq0CnKNpjxXXhdWFpURtt+sEukkMuBwpJC0mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 11:20:10.9658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a74b3db-931e-4b49-396d-08dcb21be842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283

Few IP's may have same PCI vendor id and device id and
different revision id. Add revision id field to the
'snd_soc_acpi_mach_params' so that using this field platform
specific implementation can be added in machine driver.

Link: https://github.com/thesofproject/linux/pull/5068
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 38ccec4e3fcd..b6d301946244 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -70,6 +70,7 @@ static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
  * @dai_drivers: pointer to dai_drivers, used e.g. in nocodec mode
  * @subsystem_vendor: optional PCI SSID vendor value
  * @subsystem_device: optional PCI SSID device value
+ * @subsystem_rev: optional PCI SSID revision value
  * @subsystem_id_set: true if a value has been written to
  *		      subsystem_vendor and subsystem_device.
  */
@@ -86,6 +87,7 @@ struct snd_soc_acpi_mach_params {
 	struct snd_soc_dai_driver *dai_drivers;
 	unsigned short subsystem_vendor;
 	unsigned short subsystem_device;
+	unsigned short subsystem_rev;
 	bool subsystem_id_set;
 };
 
-- 
2.34.1


