Return-Path: <linux-kernel+bounces-255588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE093428D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281AC283896
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5871836F7;
	Wed, 17 Jul 2024 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eNZOY+2h"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E3017997;
	Wed, 17 Jul 2024 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244251; cv=fail; b=Sl0NXDgdkpDJxj6ULJ6KeMmT6MXNoZ8GRDUrbJzYYgXnsTPGy+cbK/nypgl0p276jxUKqe90uK00iMHO2S2cO2Z7bqFiF9aj4HDpPDBG+k8SEzMvG3mVVj4E+PlL9lny3/EP+x+t9JP3iueZb7ZlE3vl1ymnTwtxAbMF1ujIHYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244251; c=relaxed/simple;
	bh=gpGeNQ2IUQJtFUczQR82KwRFVoYMdN7TZ+IDxmb+9aU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q9HUYmoxrszZjnBYrmm1xRtzu60YA8st7vpPvvq9YDz00qeNUWJY0kSzrVnafEjJLn+phCGB/xeCD8ARVcD90/7H8g6Pu0fwXE2h96L0COio7/pQBcPbTzef7XMWh8y+PxKfGjWlYtZMuOmZyfIR2oiV26JKnkg3aDw+TvLswDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eNZOY+2h; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oitj8Ew8tixHMLwP6YGCOYDlqRq7WQkSWuHBbm/MCHeP7v1ku7MXRR8MeruI0x5e42A+mfZjAzHv7fmm8dbFo/1QEYwMQqm7vvta/lYpWMP/VTsHPacj/nDlkgZhFQKh4/Oe+vdOhfHk/qJkW/5labIC6X9k2NtjS5BAPTM3m0B2t8qgZWjb9jGs5H4MhfSaBDgU9icd0jkos347Z43JxK+clukqFcFKWSlgA9qz7pkbStTj/AZFLj8aaZuJ8AYLdu8SJyC8IDC+CUsVqabt9FIBDRNCsyhagQpdklqeBZ9GjyUE+hevhcijK/pRAf6S7KmuQTv+dWmzvydAElLhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Pc5173zGvTZuTH9UkkIFuEatctkFL36q3TVWVpsf6M=;
 b=h3QlmwWYuJS4qlgT6PJ+TNaLR/EZa1V+xzLEQgeV/0Ef934w5XT6Jio08b1hgsMVqSTJ3m8eYPSrchwp6t/GSxCmkFh3ENnktjt4QeqyUxcfP3yMNdBST1x0ccdQcWX2h67hCuhFCz4R5Ut+YO3FUDtTG8KP5dfLbQkZwNNjVNvUTbElpg93HNv26FvnMaEZwFh04e2jlarmFX4XN1vGgT7EQAVQeyW6xNuJBmHN3LYls3kM8e9h/MxfGmX2WwX0x0xo3VGsoeWvvH2hv2wcSSVkCDJVjKJQW88qDOAe1U5xsxIl4Vcl5/opPnpCTCeKR48y30vFKQ21EHDAu7Udng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pc5173zGvTZuTH9UkkIFuEatctkFL36q3TVWVpsf6M=;
 b=eNZOY+2hG833wGDoYliXcGjaJQIifZcgKuFyj5zIDc5+Xc0id+gjbnRxybZUYSeArU0mHm0R175KhKJDxmqgSqVT9XGkOFjKfLWDPcWj/fsBP9En0grVKIZgUqB1uyHAxA4pdP6sR3yAxYw+FAhF2PUlwMA/QetATJQCyB2gBOI=
Received: from MN2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:208:239::6)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 19:24:06 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::98) by MN2PR08CA0001.outlook.office365.com
 (2603:10b6:208:239::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15 via Frontend
 Transport; Wed, 17 Jul 2024 19:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:24:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:24:05 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:24:02 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<javier.carrasco@wolfvision.net>, <benjamin.bara@skidata.com>,
	<macpaul.lin@mediatek.com>, <linux.amoon@gmail.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2 0/2] usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus support
Date: Thu, 18 Jul 2024 00:53:41 +0530
Message-ID: <1721244223-3194869-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: b457be10-25bc-4d45-69ed-08dca696067e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wNhwPyf/RfcE4no41P8H16kK7DjpDMEV996g/+doM/prDOS7/wwfY2wjUHps?=
 =?us-ascii?Q?OzrsO4jKtKEaAXu4IwsgYQH6ORoShSBZlpRg6mfLusbXgvOvffnefV3Vmv3N?=
 =?us-ascii?Q?p4JgLSNMmv+n+9x8SyXBXDxbk3+f8uvoFmPr87EsY4UwszsLIu3RX3fb5g+g?=
 =?us-ascii?Q?ENkxPlVPGNdF2haTO0ZUV35fMsfwMh6qWw1+iHD0LWsAWeVH/jKonPUZywUC?=
 =?us-ascii?Q?a5DlAh52o+VbLPadisBPbAJkxsqRhA5aisTASJvxPv6Xifd6gQ3ybfTV+/BR?=
 =?us-ascii?Q?YumsuMWgNT45P9vZOCx8AT9WDsNEkz26zbAEw0DKaMVXL3XjEnYj4vOPA0n6?=
 =?us-ascii?Q?rxHU8Zo2CmDfnnG2iFMT1f55CReUATQz6XlKuan7XG9ESbqPu+ICrRgonnr5?=
 =?us-ascii?Q?s6kXYcyuGPu+t+uEtifIjAvAu5lEpIQ1op2DKtd38ehSosEGHNYIC7XPqqUq?=
 =?us-ascii?Q?BwJ9Y0/wjQPoEpkuWVgqPoDmGl1zJm3afO47YN3+bwFAQna4WJbdGTvklQ+M?=
 =?us-ascii?Q?kz0CdIZOe4u2+tpdR0EeyYl65NFmZ/lzEs8wuWqBhoJLhIWvifwkBj9TqlaZ?=
 =?us-ascii?Q?eqevOQ6KcMIZbpg/973XW/FTdnT8+17It/B9LgD4k9yb5OjYvmsRRlJHToN0?=
 =?us-ascii?Q?gmWHS/VTPRckzUZl0cE3Wi39QFP1DjJU/a4Pvav2z9eRJlLUlU4fcXOp/kj9?=
 =?us-ascii?Q?AOxu9BK6aHn6tHgUT3P1c4cdIaBWGRZvoboB5/LcU6DAfK/jL66QH3t8bWum?=
 =?us-ascii?Q?cn3+0VO5SEhn706916hbQWie+nWYzfVfSfV769trIMqnxHFI9ks7YT5zlI8F?=
 =?us-ascii?Q?NcSGOlsKE+PDOWnLz48ZRF/QvjQMo+lgG5rLFalEZxXAGZ0py6bpIQaxZYPe?=
 =?us-ascii?Q?0Qd1KOHIk29Q+mvBVeg7tkXme8pN3sHhuqiOmUjasdVptrf7Q2kHKZ+JBkPR?=
 =?us-ascii?Q?KnrqhH+PauSAXisXp4CHIA36clYDDyDyz1umd7wkA/cPRuqN1KtrXa6PU1DD?=
 =?us-ascii?Q?llWPLzsI1A1M5vaCZIy88FPQvwgsqZcIOwtPYCn0Tz8GDr4WNvkzGzl9rzDp?=
 =?us-ascii?Q?cGdhIT9LRAjYQA3GT8RYJVwrT7WlFJEaWpLKAr9lRLaulKs5xosDdFScBtOT?=
 =?us-ascii?Q?wcGmytGpwhDT8PljtaaF7Znp5AQJWbPTF0PwDBuetXUI3xaJn4/9f0t70hAk?=
 =?us-ascii?Q?f5DEPood3ydKVdKKJrzBV93AFKn6PN8lqyYy3dYm2fTqhfrNfbKGfJIkpiHp?=
 =?us-ascii?Q?DcKvyGn5qdj0tOOwR3JQ/85CfCHX9Ji+7cwwzCvsq9GlJLV2nerF2SvBI0D3?=
 =?us-ascii?Q?047pTW1CeHbtPT1Xn6KjDlwrS4c9+UkSN533YU30SW1qONHSZOmZpJDz0Jy3?=
 =?us-ascii?Q?npcOkv6M6AHg9z8OcKQC7/SSzNr4qRSaYFfs+wd8tu98WjhDePzCS8c7v3fw?=
 =?us-ascii?Q?X+VP/BNy4WRWh9ALvAGbf3FA06RMCumr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:24:06.3396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b457be10-25bc-4d45-69ed-08dca696067e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

This patchset adds usb5744 SMBus support in onboard usb driver.

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

 drivers/usb/misc/onboard_usb_dev.c | 57 ++++++++++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h | 14 ++++++++
 2 files changed, 71 insertions(+)


base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
-- 
2.34.1


