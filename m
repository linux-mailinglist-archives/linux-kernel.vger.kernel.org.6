Return-Path: <linux-kernel+bounces-422750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182DF9D9DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0490168789
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0AC1DE2A3;
	Tue, 26 Nov 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZmJIwtzz"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58881DDA0E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647543; cv=fail; b=YoP8T3WqaNgbYDRyphKGZ3ABkLbhpF4THsbnMRYYe5EvwBM64iwWLDuQwR6LpFNh/KuYuBD1x9D6AVTmrcbMjPZoEr1g3G/wWpmf0ILdq2oIJba4MUSu4fSl3h4F0/aaJAtKVhyucMhSNlFVP2/i0pkE7I6PutTY6vPw++8avDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647543; c=relaxed/simple;
	bh=VLjLFbRMzl+gjXdiQLN+yWQph64Hbrsci8+IpXaea0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WyeDXuJghzTykuF2xGNi8PlmBhqHGjmusHR86nUffutnmWlWgF0esM0twXRFdBzKjvUyTE9GZ/+zaRsa4dCDkpfI9xYTES7ia7y6lQqd1AkjEnsMVI0UvH9+OshvzNOwetBiviPnceMSK7OPSOynAmx5i1M28nUm/tmtzZhNlxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZmJIwtzz; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G41Alc3UUJUNDWgqVCTjN98sj9yxX+UdxInHLxwpjkJ/E8751/WujDasuzROPkPeB4es8CAVn5bGYbubYcMtUOpgZUtVPkQVr8ovzawANCF70tS3zg/b/c7vEv5KFyu4TOrpZjxlcRkCjAV68avVgXRrJykjNSlrDYbeNT5VyjVZJSKxpMzrTAHQ3hrca6fpNItoDksLreAqcjSE+dIkt8O4reYlBPpNg68PQwCfjsZ9bsSt/MAmek5JTFku4Q2nkeleGJiLfqi54CauEyLTqz+lqaRMtJvZPtm/WwzMPVSsGXuaiaMK+S/zu+2iJSeSIKhSqdZImAmouyoe5p+RHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkOHSqbEuu4QqwaKHJb6i/LznXpvgtxaFsmeJH81qQ4=;
 b=CnUPl5RruJd/vqpH4/yCSMXpxV8DpmM2DxegecI9LhDMsBgpK2nhy4b9LoSM5nBr8ui+evZHwPn/cOX6lC41Rc+iuC3tsmpyoLctsiQDEWX8B7C9395co+1adByKhFWqpPbs+NYstzNd4W/Gm9W6ycLm7exWyivHc2cWMK/ie93UHe5qYQUHi7PKaZA9lZqhr4tSTiYd0/GZNn88VL8u6+0reOpkhtwUVh7uUkAYVprogAKDQA+A2+pcvrMl0y+SVoX3fyPmoSrojXLsxthZyFoIztw2PDQxb3GkJu2gk0zEfjeEYDZyXgZk3y9Ig5rV3ppENYD2qekk92lBlmrD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkOHSqbEuu4QqwaKHJb6i/LznXpvgtxaFsmeJH81qQ4=;
 b=ZmJIwtzzEawxa0cRn/V9FnNgL5J/bxMUwgXzgKBdqMMS6EuO3CWozBt5Ol3fj+i3j+oaKbbIZ13+Q7c+0bpl4OVMoYVCv1OAMlejxGttrdBdQYWWKoMuh+u0FjdenbV2UKZ68th6g6IUZTujb8KYc6jzJWMbgZgH+XYWKPyu47dBY2gbEYGv+Wm19XbLfwQjpeTNgotCgVHxtDLrxR2ExLDx/upXvvZcGrPBwtcBA6uFRBGjpKzliGed5eoLSaXpCkBfJeipk7mOMadl0JbcsnfrS7iOr/qDjf7U4NlKfqWOjfXpey9FNddkPn3i5YWIsxhQPNosxHPhBwC7m6EYyw==
Received: from BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::9)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 18:58:58 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::82) by BL1P223CA0004.outlook.office365.com
 (2603:10b6:208:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Tue,
 26 Nov 2024 18:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 18:58:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 10:58:42 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 10:58:41 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 26 Nov 2024 10:58:38 -0800
From: Vishwaroop A <va@nvidia.com>
To: <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<cmiquel.raynal@bootlin.com>, <thierry.reding@gmail.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH 0/3] Add support for S25FS512S1, and MX25U51279G
Date: Tue, 26 Nov 2024 18:58:31 +0000
Message-ID: <20241126185834.1130949-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: be7ec3f4-4887-4c21-94ca-08dd0e4c61f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CNkEaXhbB2yX7fhQX64jIQn35el1w9qU/bm+1XZneafbkttr8n/flSyXVoh+?=
 =?us-ascii?Q?bA5sntG4cjyuBA8xfKqQzMqpPoAtRMfH5NJhQw4ypH9Dq6qSCW0Rrv1KbFLH?=
 =?us-ascii?Q?YtL1BZ2f42FIR08hD5Y5yOLjjQK2liyIDz5EDUgwD9mcdfvXZBcVBEur6iaa?=
 =?us-ascii?Q?aqcNZBgI6qFZqQ2xwNK8n2cWo19+6toZkdOmZxpMez1T2NBVslQbcGLq/ZqV?=
 =?us-ascii?Q?xbCeBO0cn5S2zZ/iTB18JDEIW9zSJJDqG1l1SmbALFqAxHleH4T4Z3dnBC+K?=
 =?us-ascii?Q?I/RkleS1DbrP6TRVme9iNmMHl5O67vbxZNn7Fj7+LKme4B0LWpuL8q268j+U?=
 =?us-ascii?Q?1hYgXMobnnAos4f/JwBZhu4vQKQxE8uqzXrafBNjZGeHT+los+uJEdcoO38H?=
 =?us-ascii?Q?U4mzTuS4SK6+L/4Cx6FcvtmiXdHo7FZYaMAUZSaWf/sWgMz2ie/S4lNIct5f?=
 =?us-ascii?Q?tnuiUJiXIUMnFJrbk1iZygpotYKj2Jqm+kBvDJmXvDR08dVcn3u24cMl8pqn?=
 =?us-ascii?Q?Jwfun1ogT6OZJNePW7Xwr0TYFoO0e3lOF4OZUOZ/enjgPLALe9LdOHnZQvPs?=
 =?us-ascii?Q?9SNU2kJ0OFqzzeGbS6DWDZYPovWoFJILgGzShFMx2g3G4ZgGwR2CcxdGXRFh?=
 =?us-ascii?Q?Ja+U/5oUmKunn+hlOYj/ZTPMQQrsY1X95DaLRATUZOlvzeNESUeAC41Ki93W?=
 =?us-ascii?Q?BozhgrE3L/AQvu4ssYdEu1dIyX7caadedCxEprpa4s+PQfDMl6DGV/+ehEy/?=
 =?us-ascii?Q?QplXamIY6kMlXAQBsUyyj1XpI05Q0+ByC6qXr0FkLnjuPERXwg2IaURUXQ74?=
 =?us-ascii?Q?w/pYEG898WBCYdIdiUhHtkwuC+pNYs9zM0hKpcqGAe1bO5F911mnZpb7URW7?=
 =?us-ascii?Q?PmDVvPzNQPZFRXfci+tGoeDsH9OX5/uEDqeeFWNMS9R6oE1XopL4JHIzuG5o?=
 =?us-ascii?Q?veSrastnPgTmx+DJ2TCK8vWmLepsxGj9IFdi4HkIiPcB8Mhb42FHMmzh92Gb?=
 =?us-ascii?Q?IF9wnJ6WL4cQOQLER6sWx2dKak8NDz16BbeMoOLXL0P49BInXAXPM5FqKu0e?=
 =?us-ascii?Q?zi1ME/2nJq8OwHLWkFN3bqxLSECfbheTSJ6TOB9L7ZEYB5gpdQad69/G3KgZ?=
 =?us-ascii?Q?IUn3dZGpOGhh+guu7t8RJLEpcROlCEIg2rETpI+SQPsul2Zor+1p/6flKfS9?=
 =?us-ascii?Q?bSPPfHdtSkPWnRDjbCuw1PWOxghytfGRVCuJeU4jsPHoMtcmXZO4/HRB5IJn?=
 =?us-ascii?Q?+aUCFLldF+S1dRly8pWhs2/PaI4WiKfW5YlleCb39pAhNDktNqAE5/rCoe7K?=
 =?us-ascii?Q?5ywEpHX0L9z9m2WIKY4vN2dgGC0DsOO2zz7X2t8OvvZHUxlYlPowKn54f3v3?=
 =?us-ascii?Q?48lKzVJzsztjjSYuvwEnV9n+Ci/FG+v4se+TBYQpVyESzj4zuqYg13lrSlre?=
 =?us-ascii?Q?Skbqo/NnAKwWfJKVj/i3MFOyPhz64AzwRXoXswGE2Zzkv0K1hO1bsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 18:58:57.8391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7ec3f4-4887-4c21-94ca-08dd0e4c61f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463

This patch series adds support for three 64MB SPI NOR flash devices:

1. S25FS512S: Add a post-get-map-id fixup to address an issue with
   the SFDP Address Map incorrectly reporting map ID as 0.

2. S25FS512S1: Add support for this Spansion device, including
   dual/quad read capabilities and s25fs_s_nor_fixups.

3. MX25U51279G: Add support for this Macronix device with 4K sector
   erase, dual/quad read capabilities, and 4-byte opcode support.

Vishwaroop A (3):
  mtd: spi-nor: Add post-get-map-id fixup for S25FS512S/S1
  mtd: spi-nor: Add support for spansion s25fs512s1
  mtd: spi-nor: Add support for mx25u51279g

 drivers/mtd/spi-nor/core.c     | 25 ++++++++++++++++++
 drivers/mtd/spi-nor/core.h     |  4 +++
 drivers/mtd/spi-nor/macronix.c |  6 +++++
 drivers/mtd/spi-nor/sfdp.c     |  7 +++++
 drivers/mtd/spi-nor/spansion.c | 48 ++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+)

-- 
2.17.1


