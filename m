Return-Path: <linux-kernel+bounces-318723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292B96F218
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8967284BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB71CB15F;
	Fri,  6 Sep 2024 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="acaXcOBu"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947114C5BF;
	Fri,  6 Sep 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620446; cv=fail; b=kJAG6YcQhZpXa0gFLNnCw8rVfERB/7iybW/faZrxD3g4uWr4m87A86a6VVjejsQXw4vkpEf3LGYC1PZ1yu/z5ge9xQ0NAWsYFqwm1Ll/iHNhSxlXdTcxbS8287RHcAksGDmB4IgnblIpfUKApKrVkY+942kTJXuLcIClwXeZ8nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620446; c=relaxed/simple;
	bh=+YQCWDGma6Mpyd2pv8ixFFfAb7ApM4bYYc8cscjZMY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjXw29dwAgsyz2v+E+PxKRgWkqtHbevAAgmLnm4/Yh+1osP6hVTjRQ/jzQwm46BrxiZlFadz2qavP9q5M0/7lBMlr4wcpf2lWUzzetYPgfqj8xXxwIPvVoqFGa/vhJjupogIgjIOJMsmxgjI/ssagpzV3cJK8f+dSf+IgB0XB0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=acaXcOBu; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=do8Pkhqp8NFJkuJpQYLfLdJp93eocqW6PEq0YQrH6XUKOyfO5zAZaDvmMHxZ6fwNnPEJ7C4NbCpaYlXHL2oRM4SZfP0Nxb2i3YxX117I1Q8504XVF0eUTRBqUxSiDtrqCOuX9kz9xbCfovYaMIHG6UZ3iF5qoAsabDHYA5SdRKxm1Y/U2CKneMm0HQuU014fTi2BbPsOg1tgVAKYZe+2InaMsVm697MyvWXgeZqpQBrAfzUNmfEc4JBUB6IVPYKjTchUYPyqVbEn1/sfhcYXLodZUkA8JxZClcC1EBe8uDxNkvxfcRT3vbIA0XCGFZFG7osDaDlONgxgmlJQq+ZG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK/q8uJurRSBTYRzviE2yn4wIWBdYISTD6zdKzYGPcE=;
 b=iak4jQL3wRISolQOAgJxHELKWjdncP/2Sn/eqIdVL2Ic9oa3iNL3/vNo5oyW4TnSXIQP8TDJJ7IwTMSsMdm1Xf7o87HLRFSIbhFmqFLn+I3gQ8pTYYbzlO0u9zI+Ckz+CthTjii04a08eG8yWU3jsjl6tye6/vMM/uuck9kyyOl81SPuCEHi8RZz8qa6rdkiUmMfuPMkhP6m8zYsMiQChYLx73gKgnAxNYI5eul36EzG6RNyb1VpnYuZ90DCYLoz51Vi+4iqw3P3WBUFitKkraElxuRyIZ99s4pzJHbz6o9gqMhGEgN7ldq5G0Zjj6/dLYz4ETY8q/tfEfhgbsY5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK/q8uJurRSBTYRzviE2yn4wIWBdYISTD6zdKzYGPcE=;
 b=acaXcOBuQHRHTGhqcwovEHURJp51k4kt6GsOWrXeOhVliNQOPP7DVIvDEobJ5odyQDGlYoleVlv4wZr+aqTvoq8CF2xcNRVVydFRPbYiIGbjkq3cG4bRHabIv6hEnSZ35y5SHS1tL+J46YwVCAz6X8+onSE9Owukux3Qi04vTSE=
Received: from MN2PR06CA0013.namprd06.prod.outlook.com (2603:10b6:208:23d::18)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 11:00:39 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::4c) by MN2PR06CA0013.outlook.office365.com
 (2603:10b6:208:23d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 11:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 11:00:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 06:00:38 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Sep 2024 06:00:35 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <jbrunet@baylibre.com>,
	<angelogioacchino.delregno@collabora.com>, <macpaul.lin@mediatek.com>,
	<frieder.schrempf@kontron.de>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v5 1/2] usb: misc: onboard_dev: extend platform data to add power on delay field
Date: Fri, 6 Sep 2024 16:30:22 +0530
Message-ID: <1725620423-1758964-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1725620423-1758964-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1725620423-1758964-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b565b9-1808-4889-efb5-08dcce632490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/z9fsMb0AAPAEHqFC4NTSaqkTl7Dn646lQj+KSVvxc40lk3r+CvGHvrRQqbr?=
 =?us-ascii?Q?RMe692cEhbWXuCTVMPwEnE893/jcTHjrn9J58Lb41ClY9rTKCpa0IsA3LDmL?=
 =?us-ascii?Q?uijCESpobh1CYUZBx0IxjZgu+h/XGyE1k2uVYmqB2yScbBJ6Bk9n0koxOFq5?=
 =?us-ascii?Q?7oJltLEUz9/y4A/15O+opTOFGf5EMoN1n/FTUS/XDpcb0NGS+hCHh4Yh/sI4?=
 =?us-ascii?Q?tsD/GOfI/BIHWtzLEuDtAhhIzzu8hffsftZw4+KnupaG4SHY1CrnXrL/VBe9?=
 =?us-ascii?Q?/Wuq/xfrhL2Isz3shf02ZwKxRJ2yJ0Vp6cO4aqtEGvirE6tCUK2cGBnlwTSC?=
 =?us-ascii?Q?/7zOff6t/r+jmx2O23sNwCfXJ3Z2uyDmXUXSre4m+T2+j1cgB/OEqMn4YA6e?=
 =?us-ascii?Q?sP4TISaAWNZboTQ7N5C09S4EmKGzuJFVcMOtg+syq3NaF+MzU1jmxUe1npRg?=
 =?us-ascii?Q?v/KJMKe8PsQSyf/pDJoxq7n4+jwTtqKnyo5w/d7wo5zP7/4rDNGoOdL+S5eF?=
 =?us-ascii?Q?iUve+C5PlTGO1nKmvZPURn9Y67LLkyNTpZSSo03G2mZsD5qdPFPHyKRFbkE9?=
 =?us-ascii?Q?j6VlIc3yBoyC757pCGSTvJzbnByEvatrTFeNDvRNbp01jKBDgJu1fcvLGtHo?=
 =?us-ascii?Q?YK5kVw4SmnmsNWLQKhzM+QDO48A48BsyQf1VQSAAQP8aicIFsGRp4O/UjpQG?=
 =?us-ascii?Q?C3apX0HeZRWriYxt5SAZp1PqAIQcLS4PB7ofZnWUUCr27jnPVT+vWJENAJcb?=
 =?us-ascii?Q?5LFPqYmbcH5ymHoGleVNqsj+NLeE2hpAGdAP3VzLGLiMVlD/ZK2yHxFEniGQ?=
 =?us-ascii?Q?WvZs3r30V0tAwa3MzU0SDwNMmQaMOJff2BAEfFGgr+1RG/9LuEDR7drIkQfn?=
 =?us-ascii?Q?+it/F5uaHuHOLKGyc5iejOCf7uCJuTCUG8zV/RYFo0t5CLVcJDyHoU6im/DW?=
 =?us-ascii?Q?2aYGmmgwOw1eyQyYeYzA4JZmZgD/e63MV+OOvmikggc0ewT0TPPJmsy8MH7O?=
 =?us-ascii?Q?CAcvWe+RCWrt+OL1yGT5rzl3Mk4LeDcPZB5kEMbRn74T/kJ5u2f3gAF3u0OG?=
 =?us-ascii?Q?fJRsTCP2+uZlYcX9HZzB1qhZk2+CF6V1teFLbebCUu5DfUOGi1rhK4rufvJ5?=
 =?us-ascii?Q?Okrwx5CgBt8H0Ui39EoP26W4nTYIbD1NgfJmjbU3aSi8eM/VHUz+k28+V0gv?=
 =?us-ascii?Q?SDkC3bvlJOqwrm2ctBP4XRmNqTQ0weyRfBD3oWgF2jczRNf7gppgVXtPzvYV?=
 =?us-ascii?Q?cYK7uLJ8zdUXBofZE6nHYftssvzNgE5mRdR2ca2/6hJUjTvAS88NT+FepXZE?=
 =?us-ascii?Q?M41Qm6sKaxc1pTrmrI8ko/D+hdu5pm27Ir1wZqeom7woFL+45r5lYMrnVNWs?=
 =?us-ascii?Q?nwjMGhRPEL6o63PxBGfT2WtE/4kap+bEdetHdhiKO4xP3EKiVp+YpITT6xHi?=
 =?us-ascii?Q?Oq0MIfuLZ9XWp3MF/xHGLWl6+9ohwS57?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:00:38.9705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b565b9-1808-4889-efb5-08dcce632490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209

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
Changes for v5:
- None

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


