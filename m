Return-Path: <linux-kernel+bounces-353043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C273699279B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A0228379D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0818C92C;
	Mon,  7 Oct 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vw6ggAli"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619718C90D;
	Mon,  7 Oct 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291239; cv=fail; b=h0tVUAfj1eNC/znUg19ERLz8UJCEF10p+jc4sY+CJBdtQehvF6Hfg3y4hK67pMGvTZcOd0R+VYmodwwSHJdPfY5iy/vDQY8yUUwYTnkRe06Rg0YwxdOs/3emBBDsMm7qKlS7xXpKy9n04c+T37TCfoaYLMynJiB6LnNn+AZi3Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291239; c=relaxed/simple;
	bh=mm8/IwTATCAwNz4prSgj7ZjPYJo+T9KM083PDT3mE2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=od3G13nnojG3xIvBOmb3/0qWpE3n0bym6y4LOxbRNPpuCdEy97wrRJI2LWGGLCZepOcCDmntu1nMKYCrSYQmqEefqTOsimbMx2iW5AKWxsVr8HgSBysGuYYH2XgUNq1kmuxvwGo/jiDffXOFLZ23NCAiwE/XW8QCAd5T2oVWoeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vw6ggAli; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQXL/z9/6mAHRzEmgGyOOKhDd6Y4Y0eEtRpXbSBOpvLOEnUaYp8YCUm1pejTR7U9VbvsP5m5vV34zoqQbs9+Ubfof/X3kP4om/EPDd/XuIrIV/Dhp0qKpt0KiU0RUEt7JOYwF8t9wmuaVCJIEbgHEbxO4v1GIwBH9TdYQUihPhXCXIMNnUHJKZwZgFOhhxdbsIBGuhdORDmbo1xb0cHDF7lnmtiHrP2yPUF7Kd2Ds2PkNT1rSfnqASbqmKUWQGuZgO3otpvT5ZG7SGAYD+3J3NRuF51FBE0BKjheGS5c7pehTv7g42He+u5FkUMTgCVdDfyMvXUw4zMdIhPzwF3BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGoU34SRobXPbWo+HmnwiIPTl2+Kdedz6q74T+I7PbQ=;
 b=ZUrP/tyDrUectb6IVt9t5kDUkcl0eDybxnS9D+UgBIkZjaduRF+RWNJxBz/ucMb06SRqz5p4ucDMENFgkTtkR3uQ5JrdqAIJ72ToVJn/vmqIi6KsB+xmDNAR1Z8D9tWmEL0mV4JBOl+RzNHTE5gq5pDVOBh9oDCxJn6ACSGaVaPKW4BBJkiEMdLVDY0xZbGR3zQg9vw5QIUmPjWrP1IW90hjZ1hLFFFZxFwleeeyF6RrZO/HwqyeNU1uW7wXLwB/5u6jTMD6LqLpBR4VPciqL/pN5HLzSLYajqps8CXJM6wqS8URIpMauSVZDZwLcb+k2YLmaRO1ec1EZoW/kfeQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGoU34SRobXPbWo+HmnwiIPTl2+Kdedz6q74T+I7PbQ=;
 b=Vw6ggAliDIKdaQrAWpFiLNQEpOz3g3kDDAyU9z2HZOFKowaXMuE96qY3EL8pQz6ZubS7zFoQYjgIBaJahahBRyFwSIgAWUNTp6fjJXDrLEpVU8yVw0ixGY0/y8fcOhw7o2NfFqPhGxizN4f/CmilNyHKHD3lXdq0OV5D6fmOhCs=
Received: from BL1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:208:256::32)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 08:53:55 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::64) by BL1PR13CA0027.outlook.office365.com
 (2603:10b6:208:256::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Mon, 7 Oct 2024 08:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 08:53:54 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 03:53:50 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <pierre-louis.bossart@linux.dev>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<dan.carpenter@linaro.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 3/3] ASoC: amd: acp: refactor sof_card_dai_links_create() function
Date: Mon, 7 Oct 2024 14:23:21 +0530
Message-ID: <20241007085321.3991149-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007085321.3991149-1-Vijendar.Mukunda@amd.com>
References: <20241007085321.3991149-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: ac31f9f0-d22e-4a8e-337e-08dce6ad92f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6IBFNeBrMEKVepfgSNsrMv3VDzTEUiYVNOc8mhRekmyajsZpOMCnEwW+85xu?=
 =?us-ascii?Q?tP1/DyG+RqP1IPMhJNhb5zNUNI+ZowQFgYKimZe4JLGc6DXCNG//u/puR63x?=
 =?us-ascii?Q?hKjMB2lxXbrrp344Q7Xv5os64k24QISxMwMnZ11znRgYth7riLw069/0dAgt?=
 =?us-ascii?Q?n2ZHhmKzG35oK0sFpjyAU6AVtkJ0fwl7b3hxjVT7N1dKM6Hx0vnWvqNDac2L?=
 =?us-ascii?Q?XZJujGgXIAbQ1QWxkJGU2Fu0so+RJodPNUgO117gm23b6I2tALIQZUNkSQvl?=
 =?us-ascii?Q?1RdsaAiHUxmOEUwV1Rjr77AbF7Ocg9j4carD1w7cILGDab/ehGOUPGf28n9G?=
 =?us-ascii?Q?5vw1/y2gd7CjjGUVm0dt3KaIACsYkrLClvyYsN3fRwSaxzf36ljbaRAa6zxv?=
 =?us-ascii?Q?CiqV2UvR6d6aZBguaUQNB/OjU4kLdBgzLbdfSK1s4gXngJCOI6zzVzOFXmPJ?=
 =?us-ascii?Q?w61IbiB0Jxw3uAW3BqT8lfiO4dFZZpcqAoBIuQEOuGU3BrSGP1hNi8WtrBwK?=
 =?us-ascii?Q?eqm8peUaxs01ruHGJbIBLbEFwuJi93Vg/E18lfAhpaee82qVMYHckPH6VmiY?=
 =?us-ascii?Q?6j6r/yRB5TWUS7zqsxOIsxlzZGFFB/poDqNL2P3612QzF0XCKqA0b9xLrUcl?=
 =?us-ascii?Q?sJTBRAltwCinzBhKq+8f/dwGKJxYd+dBqXJZ1vmEFfrLPMMgkD6Q7jiWkDaA?=
 =?us-ascii?Q?7xA10VMK6Riyxb2ZZt8T97q8dpCM/6JlGt61D4HN0RLnUx9lOWtIi9JPnx5f?=
 =?us-ascii?Q?uLI/BgTi5Ejl9uNNPGyS9a9V5JKxtPCILDExy5XV0Hi16VxNBL7E8T5SpAyi?=
 =?us-ascii?Q?dlZLJzi+U2lfcYS8NQma9ON1baLwD3VC9B5+LpwWBPk771jb88bhK0gxSW4r?=
 =?us-ascii?Q?+bFJmO1yogBQXCJ8CSjzjxp9GwyJGhwu/Ua1siwZJ+2YVZ+RljF+3EJSjXhD?=
 =?us-ascii?Q?6Og28u/bOZJ9xGk1WUoAEQWozJYVIR2LOkQHIuHxlVHaj2Fuk+UC4gZuKTRD?=
 =?us-ascii?Q?ZqstXdVMR7F8d/B2T+sK/nukd1jBZ3MkOwm/Lxf6K3hNnOceuSjaBuAoro5u?=
 =?us-ascii?Q?gsnrAZmoemWJz0mciiVOoxT4vpHcgyhz4OxyP7imid3TrH3p26CosZ9dgPqw?=
 =?us-ascii?Q?OvwczgSfQoCgkIhpZxuAYVgPngqcLSx8vlqMo0Fa6BImIxYTaNi2GR10Q0U2?=
 =?us-ascii?Q?Ezpc79aAoKdGZI3jciqbF6BQuugUjEKuvp42kl3+Feac/TmjFHKcwgoK48MX?=
 =?us-ascii?Q?bNSZkx416qmHLVlQDmnHZq1IzzvPWV8Hn1mxHEqZCZN7g1RfjA//Fo2JPDXY?=
 =?us-ascii?Q?fhpfPh+UNiRz2396JdNIojzffyZ+0MQu14nmcvtu1qBitCYEojfcpy45uCVi?=
 =?us-ascii?Q?geGoX0Ajz0StR7NTIJLht0p8gXx2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 08:53:54.8078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac31f9f0-d22e-4a8e-337e-08dce6ad92f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

Refactor sof_card_dai_links_create() function by replacing
'sof_ends' and 'sof_dais' structure declarations as
struct asoc_sdw_endpoint *sof_ends __free(kfree) = NULL;
struct asoc_sdw_dailink *sof_dais __free(kfree) = NULL;
Use above declarations to eliminate goto statements usage.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 33 ++++++++++------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 3be401c72270..36e6d6db90c1 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -311,9 +311,9 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 	int sdw_be_num = 0, dmic_num = 0;
 	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
 	struct snd_soc_acpi_mach_params *mach_params = &mach->mach_params;
+	struct asoc_sdw_endpoint *sof_ends __free(kfree) = NULL;
+	struct asoc_sdw_dailink *sof_dais __free(kfree) = NULL;
 	struct snd_soc_codec_conf *codec_conf;
-	struct asoc_sdw_endpoint *sof_ends;
-	struct asoc_sdw_dailink *sof_dais;
 	struct snd_soc_dai_link *dai_links;
 	int num_devs = 0;
 	int num_ends = 0;
@@ -334,14 +334,12 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 
 	/* One per endpoint, ie. each DAI on each codec/amp */
 	sof_ends = kcalloc(num_ends, sizeof(*sof_ends), GFP_KERNEL);
-	if (!sof_ends) {
-		ret = -ENOMEM;
-		goto err_dai;
-	}
+	if (!sof_ends)
+		return -ENOMEM;
 
 	ret = asoc_sdw_parse_sdw_endpoints(card, sof_dais, sof_ends, &num_devs);
 	if (ret < 0)
-		goto err_end;
+		return ret;
 
 	sdw_be_num = ret;
 
@@ -352,18 +350,14 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 	dev_dbg(dev, "sdw %d, dmic %d", sdw_be_num, dmic_num);
 
 	codec_conf = devm_kcalloc(dev, num_devs, sizeof(*codec_conf), GFP_KERNEL);
-	if (!codec_conf) {
-		ret = -ENOMEM;
-		goto err_end;
-	}
+	if (!codec_conf)
+		return -ENOMEM;
 
 	/* allocate BE dailinks */
 	num_links = sdw_be_num + dmic_num;
 	dai_links = devm_kcalloc(dev, num_links, sizeof(*dai_links), GFP_KERNEL);
-	if (!dai_links) {
-		ret = -ENOMEM;
-		goto err_end;
-	}
+	if (!dai_links)
+		return -ENOMEM;
 
 	card->codec_conf = codec_conf;
 	card->num_configs = num_devs;
@@ -375,7 +369,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 		ret = create_sdw_dailinks(card, &dai_links, &be_id,
 					  sof_dais, &codec_conf);
 		if (ret)
-			goto err_end;
+			return ret;
 	}
 
 	/* dmic */
@@ -385,18 +379,13 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 		} else {
 			ret = create_dmic_dailinks(card, &dai_links, &be_id);
 			if (ret)
-				goto err_end;
+				return ret;
 		}
 	}
 
 	WARN_ON(codec_conf != card->codec_conf + card->num_configs);
 	WARN_ON(dai_links != card->dai_link + card->num_links);
 
-err_end:
-	kfree(sof_ends);
-err_dai:
-	kfree(sof_dais);
-
 	return ret;
 }
 
-- 
2.34.1


