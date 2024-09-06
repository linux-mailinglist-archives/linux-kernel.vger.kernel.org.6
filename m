Return-Path: <linux-kernel+bounces-318722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7492096F216
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF99B220CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B51CB12B;
	Fri,  6 Sep 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nC1Sr3KX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4D14659F;
	Fri,  6 Sep 2024 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620444; cv=fail; b=gsZjKiQTu/f34TBr+nIrowAIeaU16VdZAER1XUuKr2nKBp7CQHZd1hAimPDKR4t4F2ffuBcMnprMODto8OQHgNYOLCYhdeUw/zccAKAKREjqG432QMpowXz6FdbHgKKg77tsrCjcdBkoyFWe3Hx40sy0iIE5QhdnN445i/CaG9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620444; c=relaxed/simple;
	bh=QYTZxTUdAbWiD40r3FfG6eWkDYNQyUVGPO7dxIIakIY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M0EQF+UpEyWk4IMPaFmVrJduPKAqPgLw92wlZZ/iCJ0ni2go6UbzyVV6qdGVqx2Ou3Tdn2aT5io5Lf7Dtbg2i+bZUqkaU7h0UlWnNXTbw+uFkCtxnJfeJyCtBeTlzwqolmeeQkdZfkZ2FZArkPQW+WycRsK0CcOGWfe5pq5G/xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nC1Sr3KX; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrqG9j0hy2Lup5xitZibqR/DtPOG7iKPSvqLvTgrEyo5M0LhHUw4BEO+OMNfRcoo5BbykBtD+R9YDgVklU4lskL2D0l1NY4nWRmZi2z6pzfIrBtK3QOWFoi1kSU5KB2lSRhnWnbVs6jqqc+VyrWcpq9S3S1pfpNDsh66QKGAAN8YyNOhM8vtNlbAd5HgHp+MYsyhwbHfElqbb0iCTPqzuY5W3FwafOR9g4qZ/yo73Q7DOCGlaxCvasx+hsSKyuxhbZCC3ygWNkUxJn4XWT9GVtmmwwxhJy2/DtJWGdxcGuv4CVYDROQPr3cCpupebMn8SFoZCd3Mdfwvv1oxXdw6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieALsxiw+221rOVcaYjo5nhZrIvSDui8hiRAgLU4NpY=;
 b=Zz6RUN7rM1+C7XVHvgKElxLxGThgobgRQvVkdKEdUHutr1yKX1fD9L3dBuzEaJq57zPEfDnyTKkN655u51eDbBjPWLsyMRJDWJiQ4gq5T3SVPhbNQPtuF8LeoGBUBN2v7cwz3xUej7oyZdCdqM8ufEThoFTzEj+gdnRMRPeoLYCcxnrfzG9AaeLNI3n63u1QdEi1z/mE6UsK4cL/MUdV/Xj8m+CzKZlvXCTexIkF3qomEzUEjrwjbFEciFrJDCtwmsU/GJyEMeR6SGHihCWIqqehhvQkl7UV83ZYndLCs230d+38rgS4Zz067MLLBroC9+GNidG1rcDHnK0M5cQuEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieALsxiw+221rOVcaYjo5nhZrIvSDui8hiRAgLU4NpY=;
 b=nC1Sr3KXwq1JbkXJDgp+a6EaDsDwNlbsYYPlvVBE1kHRNfY3kP9PSeAVcX9/DnTvpurFmXjMzuZeu3rXL+HVsK7vFjoJzqydYXHfrjKn0G/kQmdjAPB7irM/INSxg/3PFhjGZFYnJ+Mu1EGSSVXNQy9boTxENTozteothMaei3k=
Received: from BN9PR03CA0544.namprd03.prod.outlook.com (2603:10b6:408:138::9)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 11:00:37 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::5e) by BN9PR03CA0544.outlook.office365.com
 (2603:10b6:408:138::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 11:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 11:00:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 06:00:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 06:00:34 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 06:00:31 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <jbrunet@baylibre.com>,
	<angelogioacchino.delregno@collabora.com>, <macpaul.lin@mediatek.com>,
	<frieder.schrempf@kontron.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v5 0/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus support
Date: Fri, 6 Sep 2024 16:30:21 +0530
Message-ID: <1725620423-1758964-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b84400b-f3c3-4236-8947-08dcce632338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vk0yQPyHm2nJjF54X8Dx3pJsmeonlg/OfJXxVs8/oqBqflOsPvkRlmf8VNN0?=
 =?us-ascii?Q?zarMrFJc1hyS61nDcXjIGUSugkUCoofSIN1fC7O1Ic3QO4F1d//qAuRqst17?=
 =?us-ascii?Q?g4xmBgtbu9viLG2g3D5ztGX3Cz5rGkGbnNxeBP5W3uvS/YiEN1z3glewQ+mP?=
 =?us-ascii?Q?a7Jeoo5/RPfW+/Fcz8XVCni6vYTqZMDyk0yuioC/KlwulcwUuEtMa8INohRs?=
 =?us-ascii?Q?FgxyxhmGpHuySXwf+ewgME3NfbpJBk7OtGnfV8bKFCX5jgUkvHoklkvge8W8?=
 =?us-ascii?Q?lcUdo3qpG49y8XNdtiT5b2cZ20fQhjH+Q9IhkboS478ktlagriGX95XTjwkV?=
 =?us-ascii?Q?B28YV/AdzGb28U+HtU7ZplA55ZL1LYKoVfn2TBbXHysLlaVMyFlACCsumch1?=
 =?us-ascii?Q?nRg7RuZI7YwKJzJAuaG9rNQv1AyoscAgM4IULeAK4kNCu4hQ6I0dQFcY0rek?=
 =?us-ascii?Q?IaL0uEF12VnokSWiebzHxeUBwAYDVIZqUDE/CFcg4B/gH26pLO1u9Nd/z2P6?=
 =?us-ascii?Q?aYry4wZewTrO4yTrWHiNbeMRaZzz2QqP2y/SERaMfbmtx+DGsSZhXrtF9kBn?=
 =?us-ascii?Q?utBlTnoyJ+E9oFUmU8qHdD+w6lhDck9hYfhpbFNTK8xh5wTfILHzGqPFYRZY?=
 =?us-ascii?Q?WFazFRIfuZ8VdjI7UYXvzMY2QbVThX5KG2Z6fqM4FCAt8/kKQNF3Bvgbguuj?=
 =?us-ascii?Q?O+Ts3m/O6TfjCMflQQSZOIeONYA55D15oVmHmjE//g8XpmlxI+sJGJPWAzF8?=
 =?us-ascii?Q?8p3AJP+g0pUeOmRp/SNqUorooo/6gTmezH9RG6ydoi1vnoTsRuAEeH7ADzkM?=
 =?us-ascii?Q?IdrBSuSQVDd3Pjzt/f+HBgXnMPHCj3Abh9qCesdxMRxlqrjzQHQwCACbm3de?=
 =?us-ascii?Q?kfc6pNcy9SoIPv1kvTNbeZza2buiYq4J5HGZBSVPu+WSOTb4SXjfxkcQfMFB?=
 =?us-ascii?Q?uTkqYETIcrduS2yyAIf1c69/x/NoJmKzxZ5x7DdeuLIls0kNQGNFiarPxljy?=
 =?us-ascii?Q?uB/767DnKo0Rss1TTyfg3ysO2vlCEFanD0rAHqPBPYaBIjr6G0xVfpewo9tI?=
 =?us-ascii?Q?GovYvmMWxWDoHkFh+SFTr3k/vCG8zWeUyXyb9sXtAIe78ndi2I4lgT5+b8i2?=
 =?us-ascii?Q?TNC0PgxHarhTx1SyanoIXRgpfhdJxRCSu4FVn4Ob/+JbigysOYe4URl1+20a?=
 =?us-ascii?Q?TcBfrl4xoqlhVZc/SEEnRitXil7AAg4kOHJbRIENluipYvNZ/XLbOwaL0z5U?=
 =?us-ascii?Q?fZ7KyrWTtJQkyoeNbIGHRMC6d6OqCKfhPzSjLbroWf3K5mIdSqmrFQ4ztA4i?=
 =?us-ascii?Q?6hPUlIPm2vv6MzO05kfdBbJeZAhZ+Los5OdnM/LmKFT+039SJPEGVrDMP03L?=
 =?us-ascii?Q?w9a2P5QQh1Cz1yTATH65cxA+2XA253P8fmmEKg/19eEn/KKiKK70WJkzctF4?=
 =?us-ascii?Q?KYdWZ68BgZoBv8VuQwd5XlhLoCEAg6Ig?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:00:36.7134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b84400b-f3c3-4236-8947-08dcce632338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

This patchset adds usb5744 SMBus support in onboard usb driver.

Changes for v5:
- Drop Kconfig I2C_CONFIG dependency and instead put the _i2c_init()
  implementation inside IS_ENABLED(CONFIG_I2C) check.

Changes for v4:
- Fix error: implicit declaration of function 'i2c_smbus_*' APIs by
  introducing a kconfig dependency on I2C_CONFIG. This error is reported
  by kernel test on v3 series and usb:usb-testing 20/25 branch.
  https://lore.kernel.org/all/2024082503-uncoated-chaperone-7f70@gregkh

Changes for v3:
- Modified power_on_delay_us comment.
- Add comment for UDC suspend sequence.
- Drop USB5744_CREG_MEM_NBYTES and USB5744_CREG_NBYTES and replace
  it with literal + comment.
- Move microchip defines to source file.

Changes in v2:
- Fix subsystem "usb: misc: onboard_usb_dev:..."
- Change implementation from introducing onboard_dev_i2c_init
  func pointer and do i2c initialization based on compatible string.
  This is to make onboard_dev_5744_i2c_init() as static.
- Use #define for different register bits instead of magic values.
- Use err_power_off label name.
- Modified commit description to be in sync with v2 changes.
- Move power on reset delay to separate patch.

Radhey Shyam Pandey (2):
  usb: misc: onboard_dev: extend platform data to add power on delay
    field
  usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming
    support

 drivers/usb/misc/onboard_usb_dev.c | 76 ++++++++++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h |  2 +
 2 files changed, 78 insertions(+)


base-commit: b831f83e40a24f07c8dcba5be408d93beedc820f
-- 
2.34.1


