Return-Path: <linux-kernel+bounces-310212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D477896765B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D52A2820FC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F973170A10;
	Sun,  1 Sep 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hNlr8lsf"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F0166F28;
	Sun,  1 Sep 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725192538; cv=fail; b=jcQG+dXRdd5jhL3YFahmPN/xJ6xPzIVAu+5R4SAFDB2cc5r1/PRdRc90zZOkH5UgadYTM37gR67WT7duMDFyTB00KOBERxy83zSbGsK4wUfT2seUZ0ByEMmvjN5heTbp3PRToECwMoj2lds5zbO1lz0HPUmeqWL7gpmQMAifUvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725192538; c=relaxed/simple;
	bh=i1nehX9q69wSImAI7/tKFoX0G0zLrylKtfARjmcsWjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjgVP0mp/LrL/I4aYA1+3M0tfSCPmrgi7SdwghANeZNyQtpmrUagVsIEs6mOT30grLpqBoDrm7Zod+TUp+E22rTDZKDuDaa13wg8kXiDpRvVZcxKcAOm9RDKgmWfgPbK4jozSmaeUaBPqxlhNqOxPQrbzI1Rn5VZRkGqT/3JgL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hNlr8lsf; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4/isCeFH6j44hUqV2LXCexPVchbBjDdJsz7yMdc6dk5GvN3sDkCOvPnV65c3tV59x3yzLzVFsAvT0YFF/12wBajLQ+sZRYYPHUuTf4/lRToIe1zUgwNUGHwLroTFQJcAsZ/xwAOAIHCh/0WveOmf4isP5KNzCgUn+omxtAQCkU06d5v07/G09TGAlfrZ85ASX2yfwHnupFfJcoJtPg3w65MXHfv6qjEQZ5v0PeKrsi1mxO8nItxStJg7X3j1atDM4FhZyhNu5hEpxHb4RcvFL+Q1dIRtHPYAWt3lkbWSMtQsNGpliePlkHhi4SPS/A1t74vTvkmWYQB249EY3bpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etp56CxO7r95eVfAg0QeXfFKGla9mkaROWXj0ODbOkI=;
 b=qi/6UXue0teeVM/YZ22tjzDDqhbey4ZgjGO0TSrzI85snhH95eX7J8pwn+scddFULVcV1/OUtKXg9c4eZqHJ7NRMXVkLFdt/bccWlO+wM0+NBNr5bCquuLP2ciL+uXfUkVITUs0ffc+X/qkJCQOnevysYfxlajMTqfwZNJJ0cre+V8Dqwg3nVyiLfNxRASJp0sperSOGxVqNPZTLEIZJgs5qqR8+7SnEl+Zeaj8JlLvoP8vZKF05Y+oiLeHl4k7TccIBBOYy0CoyADsNrCHEMKoXHxbK/xp5sedmv9dUDBCyLEhReLAPWo88TRhLiMTKeghUxLOe80EPkYXr8FuO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etp56CxO7r95eVfAg0QeXfFKGla9mkaROWXj0ODbOkI=;
 b=hNlr8lsffMZrT50p6tDP4DMtmnbYSkqtkVC/U1UsMHRdxJ/oS+EhMMplwIYKRu221pyKisgXOtxQSfCybT0GDLWrpjY8HGTNvgxhGIE9iYxMedzebN55dU5sbVzQQJTrB6yyUMArNn5/BvRJw3j8LHfQMyLAWYXcdgLSgnfBhMM=
Received: from BL6PEPF00016412.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:a) by PH8PR12MB6724.namprd12.prod.outlook.com
 (2603:10b6:510:1cf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 12:08:53 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2a01:111:f403:f901::8) by BL6PEPF00016412.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Sun, 1 Sep 2024 12:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 12:08:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Sep
 2024 07:08:51 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 1 Sep 2024 07:08:47 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <gregkh@linuxfoundation.org>, <mka@chromium.org>,
	<sakari.ailus@linux.intel.com>, <wentong.wu@intel.com>,
	<javier.carrasco@wolfvision.net>, <stefan.eichenberger@toradex.com>,
	<francesco.dolcini@toradex.com>, <jbrunet@baylibre.com>,
	<macpaul.lin@mediatek.com>, <frieder.schrempf@kontron.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v4 1/2] usb: misc: onboard_dev: extend platform data to add power on delay field
Date: Sun, 1 Sep 2024 17:38:38 +0530
Message-ID: <1725192519-3867920-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b19993d-f40b-4dad-b2f1-08dcca7ed895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2faBAo7rqXgiwZUIwjf3aHmwvBwjLmVxIm82JJdQpq1LDmquMdv8AY9x8j8B?=
 =?us-ascii?Q?+YEXL7Loq3HLbCIcVXodMrJKt0aGn+/NKmyiYU/aR5wZcFnOjmBHtbIosIeZ?=
 =?us-ascii?Q?baPmalc6mSaQsQZim2u+zN/QRY5EQkkg101/VncXKC/JbfKtjiyF0DrG+hpb?=
 =?us-ascii?Q?MouYz+YExe6AsbXAZix9bI0oWL/jw0e0uw7kFl+u+5p/bMQwvsS6iRqx28Ep?=
 =?us-ascii?Q?TKKrDAei8OPnBUgu0O10tAJO5LsYteYiCymzfvx1atyvT9WaAm9qMwJGZyUE?=
 =?us-ascii?Q?fbsN9W0tkoMWS6pDIFgi4Jcs45ll0DjCmwx4uRh8mZ5fzTZ17ZeHWSIJf9iJ?=
 =?us-ascii?Q?SVaN6twuoctoQRoJYBbdkkJwIIlnvNkew5qploprV1UT30qjcKapDT9cKns4?=
 =?us-ascii?Q?8ZVR2ULVSTTdkaMnmPT0BDco39gV4IVehVTSbJRuOmRSh8hivvRNy7sdTdwJ?=
 =?us-ascii?Q?nl5+oLgD+a5Bp8yc/RbgKRKASp4s7ir4c3t0r0OIXgggUY2BbczImT0Guzax?=
 =?us-ascii?Q?HWrZj/S8zv6MCHbkyvh+xssBBVl1gaubseaIP16wZMw4GUHxGFKSDiyqoohO?=
 =?us-ascii?Q?6mgh2RhxiGc/RbrcYEcb2VtxGvMab0fqYg3Ialdf/xGSIBJITVge7U0aK4Ut?=
 =?us-ascii?Q?jlKCjWuFjPgqZPYWuaEyWqKOhZsFbQulsEyFFzZyYad0qIz+0QR8W8jw7yhQ?=
 =?us-ascii?Q?pz3mXLh6OuFahXYUIlcYnGzEgRyvjFv/NotMDsfC4GH/Uz5+9gdzPHEtg8jf?=
 =?us-ascii?Q?CllF0/HO0O1x+HZsEdRK6vxv6mHq1U/Fleoj0VupO85/3G6rLs6ybxDLsmI8?=
 =?us-ascii?Q?4LF9rT7qXjuH5obGjQuDALo2K33YSBNL0T6JYAeNGVkfmn5rhyhskx/9kw8j?=
 =?us-ascii?Q?Hd0MGaiRVDu7I0vn6FDaGgQ7C18ZvZAE5OJCL9UJuCODmp0wWfGe/GGWNJax?=
 =?us-ascii?Q?RzstkbABaBih+oLQ9b5pra78rUs3LZ+p21YcEJYD8Jme4g8hQjbpKXqhBd5/?=
 =?us-ascii?Q?zGkYMGMl7ekAG0flXKHNDkOvXFVEzIjboCJsv/5cSI6wiQ34Zrr7qTsvalyI?=
 =?us-ascii?Q?aipUJAt9B17D0Mvjr69d515yKXdbqIYLS4EEIMt+RHpPf3LvqcQfCeNYciFi?=
 =?us-ascii?Q?1OpUp+vNSYTws6g1gm6mqjpz/q9ua/BE2mtpHGZx5UlbheU+Ykf27NS+7JVJ?=
 =?us-ascii?Q?pIMPo/zN0VPKtVElHSFJ659HXV5SfZmhaZxGNRNmEoy4LRnM60rPTvCFr0Dn?=
 =?us-ascii?Q?zHKMYF1/8cJO7DL5ijU/Z//2tysFYEisz0gJ/28yPDA5cY1ChyyQ0QhU2rhP?=
 =?us-ascii?Q?Uci7qFmIXAw0NDS0Qcw9nLSL8Xj7y2wcPR6i97ZVi4kDreVSuIcjDanuC7en?=
 =?us-ascii?Q?8JG4FoMRZitnka4RcTKHF84tG5vC/FBN/JmHPsLH2DE5qhZadPrELg7POEtQ?=
 =?us-ascii?Q?Sz9XgRy+XXbH1fYjrzawhheJ7b1nkTR8NdXH5GLUvW68KQFicsdvcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 12:08:52.5803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b19993d-f40b-4dad-b2f1-08dcca7ed895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

Introduce dedicated field 'power_on_delay_us' in onboard platform data
and update its delay for USB5744 configuration. Hub itself requires some
delay after reset to get to state where configuration data is going to
be accepted. Without delay upcoming support for configuration via SMBUS
is reporting a failure on the first SMBus write.

i2c 2-002d: error -ENXIO: BYPASS_UDC_SUSPEND bit configuration failed

Similar delay is likely also required for default configuration but
because there is enough time (code execution) between reset and usage
of the hub any issue is not visible but it doesn't mean delay shouldn't
be reflected.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Suggested-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes for v4:
- None

Changes for v3:
- Modified power_on_delay_us comment.

Changes for v2:
- New patch
---
 drivers/usb/misc/onboard_usb_dev.c | 1 +
 drivers/usb/misc/onboard_usb_dev.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 56710e6b1653..da27c48fc11d 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -98,6 +98,7 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
 
 	fsleep(onboard_dev->pdata->reset_us);
 	gpiod_set_value_cansleep(onboard_dev->reset_gpio, 0);
+	fsleep(onboard_dev->pdata->power_on_delay_us);
 
 	onboard_dev->is_powered_on = true;
 
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index fbba549c0f47..317b3eb99c02 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -10,6 +10,7 @@
 
 struct onboard_dev_pdata {
 	unsigned long reset_us;		/* reset pulse width in us */
+	unsigned long power_on_delay_us; /* power on delay in us */
 	unsigned int num_supplies;	/* number of supplies */
 	const char * const supply_names[MAX_SUPPLIES];
 	bool is_hub;
@@ -24,6 +25,7 @@ static const struct onboard_dev_pdata microchip_usb424_data = {
 
 static const struct onboard_dev_pdata microchip_usb5744_data = {
 	.reset_us = 0,
+	.power_on_delay_us = 10000,
 	.num_supplies = 2,
 	.supply_names = { "vdd", "vdd2" },
 	.is_hub = true,
-- 
2.34.1


