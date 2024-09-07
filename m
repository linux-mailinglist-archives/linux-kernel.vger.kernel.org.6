Return-Path: <linux-kernel+bounces-319894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F597037F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1031F21F29
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13606130499;
	Sat,  7 Sep 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e8GcO85b"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF8165F0C;
	Sat,  7 Sep 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725732214; cv=fail; b=tTJYveO0PZf2tN52JYYa2VoS+iNUfhGBAHXlnVrXXSVlIa+96BjpKtti2gQVQeSpTxg7jRMF45022MJPlPJbxVFME+LuCfm40KLl8c5OPgqXTBM9adZmUk46GncX2OJfE646Eqf6BJn2WmVpLUXsHC01I8PXJaFBRyzMsvfwKh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725732214; c=relaxed/simple;
	bh=JRjtY37yqIswM6oG3LZucS1mrXl3R04wDbJGRJcQZAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuhSS8Kq4xkr9NIqKVsjdwsypItNL9oeru6kP2CVRMFAiHbl15N+1y7jbdwN661sL4KiuWachT4N1YXcEqZawGuIpw0uBkeciu2ni5t805lOUx5EnUWCd2Sg/f3AMBW5uWZq9+t5xWW+a7Wpvxd5dvczzzSLs7XdIxTJmaAKFnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e8GcO85b; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjszbKdP1aG3ImN2P/WGCiPtIHhg0/jvqLEjqJMiPG26piLrbHaGNV/KrNePz+Po15YMxTw2JssOcavx+BxkkGRkUlbkqUXZtmyQMtaZ9CFUBETF6sDxpVHN/kpY4ZcvIhUss0SGwlDwzjVyExBhvvjHIJeYBrwYSB3ZGJzJkx2n6VkexuaSrYstDdcqVkkdmeDc2sF2LMg5NLLBxydZbTWiYRvakGB7p7kIMP9nBHftD3Uk5jTufAlmwdhJP9QO303X0HQ8JVzVUITWn1Tkj1WDBlMc4a8mudzDk/SK6M6nWJXD//RJLXGdpj7a2x0ar9Jwju0rNjLMYl9fm+mUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt1H5c2T7g7kBtmeffaAKpa2DolgGlcvqKhKHKRayVo=;
 b=DwzJxGwWMHNOxmYxRlLUNXPLVTBl/vI/nYUtdt7UmM41gkbo/v+9U17JGW3jvX37niznVSsJ37HA3GBxRLJ25kRaKLMOxk9cPv8WYU9v2QgXqLHgstipExv9ObD5NbRdFVO4mz6w7bhmUvvTycQIufIFG+8FoIbtPA1pTSXIqSUyDSDYTVUY3BGz9rkUbqnmRAHxM1jkuCNVmeauFfV0/wxclqoT/SMXZbd2TGxeZ4QtvZkNyC1zNxqNRpJQaq6QlKOSOxbbaXrdjt493cyXe8LOCs4lquvGbVde0iFYIjn8fmeNDZOTB8mIg+u6n1rBxSQjxQDSQOgWl2Lf0ybDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt1H5c2T7g7kBtmeffaAKpa2DolgGlcvqKhKHKRayVo=;
 b=e8GcO85bTKjhQsq0z3pLCrpsSmm7GQovTEXJrDJ4/pb4/jTvBTGm7H0D6/TPY5EtVK2ToJtjgrxAwLj0mj2Kxe0gOxNZVvdwdPJOOOfZ5k9HH/sDFfiuzC/zKIxTFpc7c29mF6/cpEFQdz7bYwHKtYRskKEaHsJmnRZKuCe8+qw=
Received: from DS7PR05CA0044.namprd05.prod.outlook.com (2603:10b6:8:2f::10) by
 BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Sat, 7 Sep 2024 18:03:27 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:8:2f:cafe::1c) by DS7PR05CA0044.outlook.office365.com
 (2603:10b6:8:2f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20 via Frontend
 Transport; Sat, 7 Sep 2024 18:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 18:03:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 13:03:26 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Sep 2024 13:03:23 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <frieder.schrempf@kontron.de>,
	<macpaul.lin@mediatek.com>, <stefan.eichenberger@toradex.com>,
	<jbrunet@baylibre.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v6 1/2] usb: misc: onboard_dev: extend platform data to add power on delay field
Date: Sat, 7 Sep 2024 23:33:15 +0530
Message-ID: <1725732196-70975-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1725732196-70975-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1725732196-70975-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7dfc54-332c-4822-2b27-08dccf675f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mE6Vhxb2B2KUWsEpkRisMJDbgu0/gvcc6xux/OkSeYrpnbaeEbePrrb6YijF?=
 =?us-ascii?Q?6GFLyxIAPNfy/NK1Bv+DB+fHo3w+pQpnM5AbQMWIk3KBcvgZ2rkdBSivtmKE?=
 =?us-ascii?Q?Y80YiHsxgV/KvrMbKinuw9uHrNNekgsx72r2tZzez2C/EkDyozhBBk+Q0Ihr?=
 =?us-ascii?Q?EWlaQXeG89SOhSmQLBmqeq61WDQmLgTqynQs6z6HlFqQwG4GM84TcjQWNB/q?=
 =?us-ascii?Q?djXEnnwOP6I8U6LciD6tG3e9cnOd/T0Kae2V8k9re5xFKYmd6iIRpKZ6/AIG?=
 =?us-ascii?Q?gEu5sHAYfmNQG5wWxt9DIDV51Tp7zdFAQqYI+yCuuogyB6aKjDol+KWcGClx?=
 =?us-ascii?Q?ZZZETCZFwbjs8pMLh0OPKRvQHmra/IjeGYVJUAZNyN4YZGtf98pKtaZX6i7Y?=
 =?us-ascii?Q?dLyKRQavOasyaGCOy9t9nGhucfU9ecwFghi7OrbLNf4IPEx4bDmnnexI7JPb?=
 =?us-ascii?Q?HinSdkrzbABUEX+cebY6M9D5p+k4OdkqhTXXFZyvzAUqAZNM5Ti4M9UJdhT0?=
 =?us-ascii?Q?xY8UZbXY7LjdOIZ1l2vS/7bcEscJOQOLzG39R86Oc1p7cvtrnggQRpFIHQWU?=
 =?us-ascii?Q?Z0MjqauwSdrvca3Yy4hmM4LyVvgd1wG/O7s1I79p8CzPycZMX4sclZHXIREV?=
 =?us-ascii?Q?DIiLuef5/wVKawEjp8hjNafgy4lMslK8Qnmdi8ybia+a88TtMw5blZ5B1SX7?=
 =?us-ascii?Q?AhiaEAhKyLsu8uwP05dEgSM4qUYkWUv6veZdV4dn2Adt5a7xfTejHQ55M8ii?=
 =?us-ascii?Q?iApCdtp995saqOUdn9g5kjywAwTyABgdK4Q/Lxjbt1lD6fL59xxJYlQ/KiQ5?=
 =?us-ascii?Q?3RsN51A8T1JW8S5LB4uAuePaTq/zLs+PBwX2lefHQoxJ4qIc69IWFa+610bY?=
 =?us-ascii?Q?sC6ZM8OOdYNinJYRw+RxqoQmoev4Is0qqUNXsH7tewzVOxOXcWqk/dOO3ZXy?=
 =?us-ascii?Q?j8tlnwpUSZvv8nTQzmqGivF1xe8i9tParzbmFlABngJRgDqBrnJ8lKDNeco1?=
 =?us-ascii?Q?QsmmovKaS6D63Z2uEL+H1EnWz0YC5tgDp6BQzJKs70YcnHopB3iKaZk3c2FX?=
 =?us-ascii?Q?9D/l1ryFUWat99gzfQGiAHXHSkSWocjIfNtbDUxql3jB/zj3KZP92gGEQbQn?=
 =?us-ascii?Q?J4pHHxXOOgHgI8ANRUM9xpInAKG1bx8kvSHpVlZa+h974+7Vl15FLBt9Qsqx?=
 =?us-ascii?Q?oZt7rvPF3Y9boqUDlHiNXBJjJyuAtCFIsjk6lUbCr+wxoCXK99XqmA4Igube?=
 =?us-ascii?Q?pSuOVjot/vnUroTchqll/Vna/ldrDfzGPg5t/uchEDwSgGkbjoP11F45tGEf?=
 =?us-ascii?Q?roawoeYHyK4Ld67xpxuxQwJCqdlOJC8ouyKAuJ7xvN1P7HqInst+XfDfv5TG?=
 =?us-ascii?Q?xaIVvLFCTQjJ+NQauI9WLSY/Qt4KqJXMJK1QcbtHwvPi/SkCrnWSStA1+nsQ?=
 =?us-ascii?Q?7H8UeqpFCOJqxbw/GnD3eCXneGUZeu+9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 18:03:27.1128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7dfc54-332c-4822-2b27-08dccf675f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445

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
Changes for v6:
- None

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


