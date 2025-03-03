Return-Path: <linux-kernel+bounces-540983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAF2A4B72F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5244F16B8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707DD1C3BEE;
	Mon,  3 Mar 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UnhTAPA6"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18F156C6F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977043; cv=fail; b=kBeE2Ec/1Jk3oCx1Va6FDuxdFuappAW1vbhmdg2qeOQUGtVT3hoWnn7K2xULXR5BjW/AC8byaVnLam7MpmLsqBoNL5HpV/79K6DLCWnsjFUNl7jr7iDav/8q1GB7wqysIHYkL9GEQhVoxKGfuxs6B2oeFJJqpi0o4rVPt4tcB2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977043; c=relaxed/simple;
	bh=700xOlKF9uiSVEcu4uniAnBzPvg+A4VGrdNLGlJGAYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WnaBs7cZpsFiVwyYo/H2mYGKu1g2NtAHZKAYdsJpExm4Hs6q5ObzoKG0a4eMamRlvZpnxpTNwBiWZhRc36M3GBwLHw6988NMkmqMszIeLhpmERpDXu0a4Tvnd4mcEK8zn1R5LsIOt1K9R1Yv1eMpBS7IMOfSdyIvS4NvYM6baj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UnhTAPA6; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbcZvkKCDiG9DYwDYsYpWIIA6m6qAoDUU8Xlao/1DZYZG2WIHOwQlL2N7ZWYETAB2bhwo0xTi8G7MHo6XDgBvBMD3E4YllYf6QtFchD9IRY4KQ8VQfxO6rCnWwGVxzpaU+4B03fk+fG5lcR6ANlhkwSAQX+uN0ua7QCXZofI45xl6wL1vxm/e61VodO4cfkGHy8zbKm25Syfv7kfersSSqo4bcO6Odh9rTw07QDblpnx3Sk5Y0zKtKp/8ETm3Twwonb5aHft9EDzvOyM3uEgzJDqzeGjToxSh7JzpbzcVweIwJyRjCHhBPfMHawmyujQXRtQovXzYKfD50Y3mYmYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOhTtWB2Hz5lGzH1KXHktn4YxPfPWD6NLAt0VQa6tOY=;
 b=DbqluWYzK2nIbOcOlo+YFs/wu70ebzlay80BDvUrqNfcdTJrqYe4YfK1tJ5tIY1npOmSYZwaexYj5aWOqrtsu7SZG5TThuHkjl++yw4EZszCag+leZQJXuV+6h5VShzjUQ2djhrLJ4wWzsfcqb7Ft9HZEzc+cTaWUR/mH6FAvDD64yaAlTpXc0cvgjSalmXetK88Fgw0NQBVbYJhkndGbDw2W6yznSPSNaU3ux0WlyiEsQn3erMQwpbMxcFN91x+NQvBmWfeCk51ccqUFYupZXMujMUZG22HGgJbD6Qxr48zzf+pv34t3vD3uDIWAntqzw5xrhJV3Ey0TIhNxTte1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOhTtWB2Hz5lGzH1KXHktn4YxPfPWD6NLAt0VQa6tOY=;
 b=UnhTAPA6w1wkaMboMerI6tByqNKSoOxcmS0Gvb41AbcS/TzjihUhW0nrPnXYrkZpoS4BV1ICZy7fWgfOtmVG9LyObND5bQiva6uva5SICk7qV91GNeAmZmpvtLaUB7dMd71BnlDvK1a5FHJBrAcv5NgtDPHplF0WX/YWY83BeF4=
Received: from CH0PR13CA0051.namprd13.prod.outlook.com (2603:10b6:610:b2::26)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Mon, 3 Mar
 2025 04:43:51 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::42) by CH0PR13CA0051.outlook.office365.com
 (2603:10b6:610:b2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Mon,
 3 Mar 2025 04:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 04:43:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Mar
 2025 22:43:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Mar
 2025 22:43:50 -0600
Received: from xsjdavidz01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 2 Mar 2025 22:43:49 -0600
From: Yidong Zhang <yidong.zhang@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>,
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH V0 0/3] Add versal-pci driver
Date: Sun, 2 Mar 2025 20:43:09 -0800
Message-ID: <20250303044313.679012-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c371074-83ff-469f-4462-08dd5a0dfeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?39ortcP3aIY9DSq7ECP1brGCo8oSv0Af2MAZBvzJ0c93A1HHL3sMs/+ty9NT?=
 =?us-ascii?Q?ujeFvPZmSBXyveoZXGhKWo2EAA7Rm0fVaRniWZ8d0p5Ny8MwKc4W+0CR9L6Z?=
 =?us-ascii?Q?8x1q3z6vDRezHH0I19fr4jVvVv93fKNWirNxr9bcPlRQ0arxb7s0hKZshysR?=
 =?us-ascii?Q?i67RuXjB6fE1jvikST8rcQKt/FALbwG2SeHHN3eum1UWKaJNFOt8S+0U+Uua?=
 =?us-ascii?Q?Wf4ptOqP5b8ezhgdxauofNAUC6VXSwbo8cMe2RNGpITZBD3sWMmvmj8SHHDE?=
 =?us-ascii?Q?6WjMpDOc82XZO6FGRmWiIxWNSEdcUtFUQEfXl1wCu2pGt8w31jELWe4usvsb?=
 =?us-ascii?Q?mLMPKnQ6XxJMA7G/VEKWviOvojhZuu3MEwrNnUM20JIlDp6nn2L1pLsxXcKd?=
 =?us-ascii?Q?0JOsmOlQFz3Ru72o2br1TVYAlQcyF0ojWDw+JFgwhj7OU3jCmw3nejH3EVB6?=
 =?us-ascii?Q?ZRUqCpnDOqmlamlNhy7ArxZwn2UgTvBGpe/jwE7VmZHztaseVWJeTdcL2EOL?=
 =?us-ascii?Q?vQcgUOmBRDJR0MHfgi/dvgYxMBh+p7ARcs0q9Uey39hpCdj3SlHPOUY8M9C4?=
 =?us-ascii?Q?wMck/5O/BtWAP+q65dC0t1GyhiYlkeIkM8/cPvVyXPTlIMfY1W6i2hJUQ7hm?=
 =?us-ascii?Q?WIhtmomvXvQ5vPAN+jiveQCF1Z3xE99JQU9lb0uUqpatB/Vz0nVBNjUn7svY?=
 =?us-ascii?Q?BxCI26XndCuk+SUieOHKn6AweD3Ol2Ttny1ISBcqEeZew6sXY/PfHLv1RuI0?=
 =?us-ascii?Q?rDUJdv7Z+CBtazsVFxKfqrTxsqfQ/IaJgLtzg4ghirDrfvnvzesE7FzvpP5u?=
 =?us-ascii?Q?XKNqTTm36IiWNTwgQYs/YYV5IxPR6LCpYw5neWksfllYhHLCFO7yQr7ZJrFS?=
 =?us-ascii?Q?ttUpo4WGsvEWj5vXM+OnP85hw0+aL7lUk9hl/QpvV4phiSiN+GTIcb+DfrgO?=
 =?us-ascii?Q?q9eewi6Z77zOjB8c96ZTTQfv9pTRJVjhMKiO6gG+BNbwTjq6VXnKQV1/H6WM?=
 =?us-ascii?Q?7kyvldfDo5dm2siTUeTRPdhz7l/EOQqhzffGHzEnysmlpo5VqLfK5nt/p9HP?=
 =?us-ascii?Q?5ED67EIi5uGO383es5rjbkvqM2JowaGVWoFzHV392kAJUvRgaxv802d09Sln?=
 =?us-ascii?Q?VkZzjrk+JdYoaIjHZIZzxneaiHI0L3paMDQ4HYO0zGo6eTuhZen21HM63jdf?=
 =?us-ascii?Q?YzjxbUPPTQLt3Z3D+pdF6dVZKcVtkE+vDbLF36OYmMQdFIfcgIViS0+HxFF0?=
 =?us-ascii?Q?ZY5F64qfT+BWNy6b4G7WnJ7upokyoYa4eVv4MMLB6sG9n57TS8kfV1dzbNDn?=
 =?us-ascii?Q?H5M5/z9wz4WyAHr3NCXvBpm8SICJE7QyhuXJAHv5y3gIguEynoT3syTT9SA2?=
 =?us-ascii?Q?DQZHx5Luha/Om1FTl0dbN1ghW72DNbd38VZNrSEwD/WZKfqY/Se4NNPDb3H7?=
 =?us-ascii?Q?sBeF2JZK9VETQyIJ7Wzo8iPhc8c83zIeVOEc9iJMGehc0VdAl/VnhPUGODQT?=
 =?us-ascii?Q?4Z4jJHcqAZEQFAY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 04:43:50.9958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c371074-83ff-469f-4462-08dd5a0dfeb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673

This patchset introduces a new Linux Kernel Driver, versal-pci for AMD
Alevo Versal based PCIe Card. 

The AMD Alevo Versal based PCIe Card, including V70 and RAVE, is the first
Alevo production card leveraging AMD XDNA architecture with AI Engines. It
is designed for AI inference efficiency and is tuned for video analytics
and natural language processing applications [1].

This versal-pci driver provides services, including:
  - leveraging linux firmware and configfs framework to download management
    firmware
  - communicate with firmware running on the PCIe Card
  - monitor device health

The driver is licensed under GPL-2.0.

The firmwares are distributed as a closed binary, delivered by AMD. Please
see [1] for more information.

[1] https://www.amd.com/en/products/accelerators/alveo/v70.html

Yidong Zhang (3):
  drivers/misc/amd: Add new driver amd versal-pci
  drivers/misc/amd: Add remote queue service
  drivers/misc/amd: Add load base shell firmware

 MAINTAINERS                              |   5 +
 drivers/misc/Kconfig                     |   1 +
 drivers/misc/Makefile                    |   1 +
 drivers/misc/amd/Kconfig                 |  15 +
 drivers/misc/amd/Makefile                |   7 +
 drivers/misc/amd/versal-pci-main.c       | 313 ++++++++++++++
 drivers/misc/amd/versal-pci-rm-queue.c   | 314 ++++++++++++++
 drivers/misc/amd/versal-pci-rm-queue.h   |  21 +
 drivers/misc/amd/versal-pci-rm-service.c | 497 +++++++++++++++++++++++
 drivers/misc/amd/versal-pci-rm-service.h | 229 +++++++++++
 drivers/misc/amd/versal-pci.h            |  64 +++
 11 files changed, 1467 insertions(+)
 create mode 100644 drivers/misc/amd/Kconfig
 create mode 100644 drivers/misc/amd/Makefile
 create mode 100644 drivers/misc/amd/versal-pci-main.c
 create mode 100644 drivers/misc/amd/versal-pci-rm-queue.c
 create mode 100644 drivers/misc/amd/versal-pci-rm-queue.h
 create mode 100644 drivers/misc/amd/versal-pci-rm-service.c
 create mode 100644 drivers/misc/amd/versal-pci-rm-service.h
 create mode 100644 drivers/misc/amd/versal-pci.h

-- 
2.34.1


