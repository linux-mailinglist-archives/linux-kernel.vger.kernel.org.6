Return-Path: <linux-kernel+bounces-216827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3890A717
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B131C223CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB8218FC9C;
	Mon, 17 Jun 2024 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WG1Rg/K6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EF18C344;
	Mon, 17 Jun 2024 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609347; cv=fail; b=WCfbsBk6Rk3b0QwT5M7mw24KpZJra7SfmFzJXy2yZtxbTk4w9MajZ/ITcpV1f6KfeHwD4rDWleHZkaMJULbkjqRzTTVdHfdqPjtvGwNLeWJzkTjlhZaHkZl9alHK91nbs6hWHbX75f8ja0gXZcw6aLjIf8kOzkA8oGAMZgJ4A+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609347; c=relaxed/simple;
	bh=rTWwRqkKpBVqpE5QLSm6YPJ6TaDJ5OR8u+UjfyROwCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXmcpbdg3WLcRAP/6lGfPP9O9JdO+n6y9H4ggKtWjaO6QwxOZB54Wl6u3bk/Xa4EdsAdCA1aho27xhSwgeicQPmTcPS9gtkG7S3H9ac610AlqFOg45lJwjZAprBkq/hRKqY0Fgo+DDw2behtRYdVCr14q0Nedj8n6mjWrjpiNmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WG1Rg/K6; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHkvv4tIpKRAQNUIiZRatoulLw+sIWC+fIJxa6qEZrwgB+IIP5SSGnSHcRP0YzZ+TZElmTvghPZkZbpHv/8To80DQObrJCTVAVlWH9e5BMd4TdJUPfzpk6buHVHk8gNiARHeX7woVbwA7x19Gesaug0yZuzbDe80huYtH4Gs5ohZm2kL/dHC+1LXILb/ceAOxvmcmJS5QscG0qzMtsXtvkm91in80nMHYHc16Z8Vcw94hXOKtIWdRbCOxZxzHWIMx8MYrQGM+1DRZ4ZV/VhytLx4JDL7eRJoBBwQD76hTIu9IthdUdhlOZVyX9IHETt5TRT4YBMCknh0A9R43lx/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9nORu10sitJPP6VOYhI1H4DJoOq3U3LrYpiy5JMAos=;
 b=TtzPiRvasqJPkvRZKyBl7boIDJIUsrifwQ5qarqnrjWHPxrN+NWtM4vi9VAKIxZ7ONFW+E8tdj4r4aY6MkoPmy4B63hdx3iDhhDxBrmq3Qww31lYhUDwy210/5bhg3xJ8zWBbyZLS1+wGZXQE0oh2XGKxPXovitHYRBCWVPvdDxMymlACE4iPsLEWsO/C1xjVb4fl4fyfWyErt2eL6+ecqXiPWnFl7Yd+XLGuByM1YjtaWzkUVgtFkRo/BAHnLyNJvVb9Izy8zRUC2cqkcy1A6w2pIp23W/pxK/axyW6BMILrMEqIVT7c4E3IpNkVxzHwLtySe9jMcPVgjZV+X4dIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9nORu10sitJPP6VOYhI1H4DJoOq3U3LrYpiy5JMAos=;
 b=WG1Rg/K6BK4clA8zs9gAAkR93KePiqaLwjnwYxIdrmXxRSqEPvtUYC/mhkotMSxQo+oHxhYT5LLTOkcrd3dVfC+HZxitp9njjDY73breKszhc1Hn+MC+8HuglJT7+6CnQkLGjwEwgoBE/YCV19ncAEEkUVmusVMNdCeTdzVOVUM=
Received: from PH8PR05CA0015.namprd05.prod.outlook.com (2603:10b6:510:2cc::16)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 07:29:03 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::5a) by PH8PR05CA0015.outlook.office365.com
 (2603:10b6:510:2cc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Mon, 17 Jun 2024 07:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:29:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 02:29:01 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 17 Jun 2024 02:28:58 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <venkataprasad.potturu@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] ASoC: amd: acp: move chip->flag variable assignment
Date: Mon, 17 Jun 2024 12:58:36 +0530
Message-ID: <20240617072844.871468-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
References: <20240617072844.871468-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 11146ae1-d1a8-4d59-8f26-08dc8e9f2975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R1bgmWLSBLrrWeQhM9E4nAfkwh2OfstV6GquudJBmhkcktOm9u0QHzxIUZyg?=
 =?us-ascii?Q?RQpSGixYKH8rmOD0em8JPGFc4788vMCbjW5x2kgmx6TB8DSzrU1pXddT34lB?=
 =?us-ascii?Q?TJT7AQMtTjsy55E/rcpiw8Flr5hxv4fq22kFuoCV0v0mEudCg6enbUjXiS1P?=
 =?us-ascii?Q?YZReNAxKj9F778xdv7iPb/rgoN42ceH/G7UEyI+7LtYvu4dpQcgK3kXzWbIr?=
 =?us-ascii?Q?m/zykgxT+LK4xnRF++9S0AsXPNHCzU9veRnAkQtGwQ//6BeX2BWnHYHByo5V?=
 =?us-ascii?Q?CkI0T3jLp0PVA4eYXq/MMbdevox95sz4AYv7BXoJhFOLZRNjW4mKrlGntgGN?=
 =?us-ascii?Q?wcQIk4C2eeY9ELzqEiQpYd3NQn5NAK94AjszdeP+M/XqhtWk0wDhonDa6MvD?=
 =?us-ascii?Q?t3CeZAZs6ofliOZBf2sW7DKtv4Gvn6RLq5QWVNelSUZ/vaJhiNKWaYJeMxgS?=
 =?us-ascii?Q?DMNeuz0/5IM/SVIHxnsgDokWQS2Xx66DGMj1rY/COELsplaLQILqTWZgY5Ra?=
 =?us-ascii?Q?JmsSzeidWluUjJClElUlTXPOy+WHf4ftBVNYNcJf9Nbz9U6Ml2d0Tg8vNLyV?=
 =?us-ascii?Q?ZnRKgQoI8U/n4J6OmEDZfbHSowVNHGHpPPyP28e4rUSDfnc/pB1jH8bWKqm3?=
 =?us-ascii?Q?RgCgPQDqmUlrKvrR0OOGjWfzRQ3jVr2yxlv3NJFo/j7h18DIUklYIhx4TpUF?=
 =?us-ascii?Q?98vya+ls6K/MJihtTwc1MHR68fXxJat3MSq0xCxjax8CMzerGa89D0b72kQp?=
 =?us-ascii?Q?KOIO933TT2zhBkhLm6leNJu9ppRY4+B7cownkvmnUZyWgxj51/5vDCBVweGD?=
 =?us-ascii?Q?e13VGncPpH9OTItK0Auz5Gt6ZdUD/3hkxZp46kxi3CO5G/IQFRdty1TOZQ/e?=
 =?us-ascii?Q?6x9kksPPdjnY+NZSQ3cfNu2cEU5e4pJ73KC86lSbv/0Ga7noMnyXrXvWLccI?=
 =?us-ascii?Q?UdRy9ddM03fd+AQi6nazE91kiAj0HpnNXfgQl46LsUpAhGw0kJZQB/6tEm1t?=
 =?us-ascii?Q?jDE2TigTZxbdEPnLYNLssAyzlRg7C9PJuJGnq91M5IL7hZR4fojA7AIvsqqH?=
 =?us-ascii?Q?HJWEMoTin0Ec8WREszwe09a32QFuM//XHwo7aZDW3SIhNg+v9OvPrUWraEd9?=
 =?us-ascii?Q?c6/z1az4Wg2U/JFME6QZJq4NHlehZvp6YD7sBN76mI/WB/Wl0FLl2Kxb8GFg?=
 =?us-ascii?Q?tJYOL/ydtqtE5STzY7W1TjkH5hqq90wXaN7wDc0CogiV/iyS3bciMHsCsivj?=
 =?us-ascii?Q?m1baCZmdUZQrjIkBhKxgqar3SF2ptecVh1TYDfKvy3XzNarUqrnn1FkYvFyF?=
 =?us-ascii?Q?cz2z6dldM0gBdrtVjgEODwm1aM8JILvW6qXY0YWIjDeYN6tJUO7rTbj/ggD/?=
 =?us-ascii?Q?PbP5ZqVVI1POLL8aeS11Lg61vbNZlGOuzILewCuiCtkdOP/Qig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:29:02.5032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11146ae1-d1a8-4d59-8f26-08dc8e9f2975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273

chip->flag variable assignment will be skipped when acp platform device
creation is skipped. In this case chip>flag value will not be set.
chip->flag variable should be assigned along with other structure
variables for 'chip' structure. Move chip->flag variable assignment
prior to acp platform device creation.

Fixes: 3a94c8ad0aae ("ASoC: amd: acp: add code for scanning acp pdm controller")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index aa3e72d13451..777b5a78d8a9 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -100,6 +100,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		ret = -EINVAL;
 		goto release_regions;
 	}
+	chip->flag = flag;
 	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(dmic_dev)) {
 		dev_err(dev, "failed to create DMIC device\n");
@@ -139,7 +140,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		}
 	}
 
-	chip->flag = flag;
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 
 	pdevinfo.name = chip->name;
-- 
2.34.1


