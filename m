Return-Path: <linux-kernel+bounces-255589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C639E93428F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3892DB22A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4931849EE;
	Wed, 17 Jul 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GWiMaOJK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B418412A;
	Wed, 17 Jul 2024 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244255; cv=fail; b=aV5oxcw6S4ODThUCWEwggR0ulfNZhfJGt0DqXrheVXw/Vkof+z7fA+pDLDuWaWUKFjeUJCZbzazF0kpWS6dvYuAGW/FE61d+yRRKk+Mk8E9h2Tdd2aT9NdimUpdHxU7TFYwX5aW3dns/IvBdDDwz6fkXJhKinHWeyyHEFo4pcig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244255; c=relaxed/simple;
	bh=kIB/w/qI2pIyBYLzDGmW5gqVX3AvvvPMvJzTXcwyS+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEx8gQstFzhCQk2RLb7ipzXlHrH/IQA3+2WwOcNufqM5e7vmdtwg/vQepIDCvCDk+rP7tX3M8nD1yYbLAuE+bD+NRBt5a4XIY4egd8PyjsdjC4M7QpM1ZxVbJV9C70h8tDVr2T0Tr7mIqo2KCzQ4VMH9xaR17vpnW5z9a0nmmIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GWiMaOJK; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1E37q3i0kroZ21ELEYwtS189BO0117njFmviJWcFREl/wywOBmbp1Z9uD7bziFv/brHnPW6DyBUGbcp56JewFeVmPU3NFliS6pYK0H4NLiCQenVIoZT1N/dDZDfhc4hMA8Pw+qSt3ZQey8YDGpg7wqyvB6z2qAI5HvtP+jemk67jyaI5ENbFRj5na/S0JYXDv42SMc4xCsCwYeqKZ3QsbKyiWKT4nJQ+fgb3b4snPTJW+aLhbcvE881EawjbgmEP61g32ZyqZq6kG5U7gpGgceHx/KdXvEvRb+MGCZuRbrmlaYDSpFHXwqMoW3ANtwd6Ry0tF7fliJqBX6jQfXSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq2hnXQ0Eq5wm7XH8t7gTmZ5TLOHemVYv5gqIxcAudQ=;
 b=XVDv8+ShGKRBpzmmbKh3ezovuCF+bzu+2Uuys6tNL0LHoh4w9g0nVKHpo3ylSv2k3AbCwG3nqBHaaHbuEuhlBSPL0n3bVmOL9hl6qEvaIAcElDghfQW8NVw7WX47OJ+fbNLW+TYixNEG/GQ9LtP1cvSNzPTpVcE1mQ3rN6/Z0vpg/AAYcu0RQiK0W7aPmyp8Gm67NILExPaFUHw4SaRE3Wp/OhGxCGYzytHiNCkOFmegRldD9daH0EOEvRoYq0r47PNKC+6NzSLjTDVbs3tsVWmBZUghDuWNPDOCzhEy0FxQ4mi2vdoc7YAhuKXU1PDzorU8OtU6342L12K9nfTxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq2hnXQ0Eq5wm7XH8t7gTmZ5TLOHemVYv5gqIxcAudQ=;
 b=GWiMaOJKseKc0Ih/VMgDhfX8Ex1x2/v6YotaWyeVTbzk/ZpJo3hHXEA8qD8+GOEw5MZO0/LBbSTt9FAfWp1+WdUlMhrzBFi7FYPViJrw/K604035XGQ92z82rKRTXwIU4kkGg2FZTRcYlo29+LdwA+0NweYT3ROJ7NqCipVcBUM=
Received: from MN2PR08CA0011.namprd08.prod.outlook.com (2603:10b6:208:239::16)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 19:24:09 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::e7) by MN2PR08CA0011.outlook.office365.com
 (2603:10b6:208:239::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15 via Frontend
 Transport; Wed, 17 Jul 2024 19:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:24:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:24:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:24:08 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:24:06 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <benjamin.bara@skidata.com>,
	<macpaul.lin@mediatek.com>, <linux.amoon@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2 1/2] usb: misc: onboard_dev: extend platform data to add power on delay field
Date: Thu, 18 Jul 2024 00:53:42 +0530
Message-ID: <1721244223-3194869-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1721244223-3194869-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1721244223-3194869-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ddf719-1f86-40e7-79af-08dca6960875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9AorfDJqSc873HFsJymHSJ215krboxXnlBeKE1/4lc8h6dMK86+5VBzvnUhv?=
 =?us-ascii?Q?jNMsOah+2RMiaBcEdnQ8qgrYyGVjsVHLUug4xJ02Ok+irOxN2zaIBJdnE27M?=
 =?us-ascii?Q?bUudybyazeX0oTkgcAyYvhj5wDBlv2NOZagoGZi1LQat813vr/uAwTrFY0Wf?=
 =?us-ascii?Q?6eNs7VQcWe3ptNyuZ4NqHTCE2f7nPvBXwZ7+RwWVrH11BbJAfz3nJHEEWiIX?=
 =?us-ascii?Q?cP4itb2AcOqmrOEQxUZy80unxR/gCrVS4bPgYSHatDLsL0Q4VdnXs/PdYF0u?=
 =?us-ascii?Q?D8LMRvqJDlwjqp5xVYay4cZg4zH1E5sOYmJveH4Optor62WnY68eYPEeUDMD?=
 =?us-ascii?Q?IKCGUaFjiY+8JHDGplbfaqUDMFr4a4NFcYUonagmLGSe/iJQ7ZWub3IpjOYf?=
 =?us-ascii?Q?Utg2XdZ987yv7Iv1zis2BTMgFcH0CzddfU7lZrGWUT+jH6K5W0s6KHczoSub?=
 =?us-ascii?Q?8WI4q3JGsgo2iKjKoO/tVcycyu1JksWcrVcDiR1AyKQeMrxqO0nGVOJHI54r?=
 =?us-ascii?Q?lsgarh1YM2dbrwvNB45GhKxsCCHXTHwuSvBfw4tHzOarAPfmqsDg00/pD5jS?=
 =?us-ascii?Q?o4OBTn/wHGcJRog9fagTa3WiOKAciPs1Cu7PufiL5utO/8dt8NOsx+4nKM61?=
 =?us-ascii?Q?BqcrUUpaOo3VuJsPZu4PBXPHELhKZ45risnN8PvPt2ClLHcfuZS0e1zEpn3j?=
 =?us-ascii?Q?kWSPXcGqcs6D0O7cn5Patb4Yk9DdD5HLIUYsmil5S06kYFK0u9CgIGNGvD8r?=
 =?us-ascii?Q?aDLaWrwPL6r9tV4h3WX3J3rh7ZWWCBf8oZ0W9hQt3ot7oj0QysIPNHRoWoJH?=
 =?us-ascii?Q?YUAninkXjcdGiqhooKZxzs2d5Zz1HC/v/L9pqMQzGt8FkeRKiD1kZf14Ksy7?=
 =?us-ascii?Q?zAbpmXAMlakmXfEsITZZcSNXc238ikCCKH8qwQUBbDpaT0ZnHZqvftdcUvOa?=
 =?us-ascii?Q?Oh/cP/7qQVp4ZfHrmcmZBmA0MrAGa+ybJvzgfaYriKilWzbcxXlZZ5c29c79?=
 =?us-ascii?Q?9lfIn9idCwcm/G4bcA4wEXEaJdzq8RYEIvsEluivPKvEfdzDgcF5tv7TwTSH?=
 =?us-ascii?Q?ZYIbLVGfADO67L2ElxbRcRMP0K/4ALdEEHNAHuGhzQ90FiIWWxzlhaCTkaTR?=
 =?us-ascii?Q?D6eDKIMkqGL8Juj6DjjwY5cyL1mLqCSpxm1WF96Yxj48R7nj2/8cokil6alb?=
 =?us-ascii?Q?f+vOhdSDmtb9ym6leunUI8B8DFkVCwsI0Q5SlzkGDv1sUuqSDNRoSs7LQbTU?=
 =?us-ascii?Q?/TqAz7CreQF8ohLZ78iuMD7bvJ10lmLt4I7zEMKwSoaeOl2fPbc5yZslRdMf?=
 =?us-ascii?Q?AHduP4xyapBqLt8tzyTy0LXsTOfN5VIo+lt1y08cL+pJRwEVcZXLCz5kaR3e?=
 =?us-ascii?Q?/tTvP18x98Plr0AuENIYgeT9tM1HNV/cRBoU3Aih0gI4m74Tew++Qzcrch1Q?=
 =?us-ascii?Q?N0ai8TvtqgH1BspDWNiciq307TyZXRCD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:24:09.6364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ddf719-1f86-40e7-79af-08dca6960875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669

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
Changes for v2:
- New patch
---
 drivers/usb/misc/onboard_usb_dev.c | 1 +
 drivers/usb/misc/onboard_usb_dev.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index f2bcc1a8b95f..94d5424841fd 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -98,6 +98,7 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
 
 	fsleep(onboard_dev->pdata->reset_us);
 	gpiod_set_value_cansleep(onboard_dev->reset_gpio, 0);
+	fsleep(onboard_dev->pdata->power_on_delay_us);
 
 	onboard_dev->is_powered_on = true;
 
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index fbba549c0f47..82c76a0b3346 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -10,6 +10,7 @@
 
 struct onboard_dev_pdata {
 	unsigned long reset_us;		/* reset pulse width in us */
+	unsigned long power_on_delay_us; /* power on pulse width in us */
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


