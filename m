Return-Path: <linux-kernel+bounces-441277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DB9ECC41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660E9286C19
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C422914F;
	Wed, 11 Dec 2024 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bH2OZSN4"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF1229124;
	Wed, 11 Dec 2024 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920911; cv=fail; b=T02MhTODCzvZlDi8wuSpLlf6kwy8or9NgSU68Wqu8e1Dkj+1J9VM4vmN131b4AWgHmhq1j1DcrGvqjc5DAxfIkbB46NEKZnew2qi0mmIFjI2KnDLo33ovKyIuXzuEwPzRGhn68L2IRisxL6BaOqZomu2jko4JJPtsux/H+9U7ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920911; c=relaxed/simple;
	bh=xacJ66fk6uB2sDPj5wM0qqur8XXBqRH/0MJF2aBCVok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VmK9OjoQ7BdNJQFOqQqsAy2v4VI/z0raFxchHWHM6N8BZs7Wo7HP3aVMfEMLkcgBc8Eg3jF5Zv8GMDufpD12SGKJD7ux4vJtfXBpmeZbeFfRCqdcgr1x9vGOvooEAaXpRi1PfbocaapCCwlVX95FPgohXGYtJkkC9GAscDpjrC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bH2OZSN4; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHjP6R1l6fs5/yYHBb5wRtp+g26Jmpz/ZRsJuoF0qabu4xKQUCXJpmCL+KTAHQo/fdiZUU9yWEa9cwveW06OxKoqVkqASkSJRUsYMi8XSBYgWzgzvo36NTNpIwf8KT5aLwZKd9/vz3cjsAfml/cf4bEbiRTZ4ZzaQ9VTjPJ8YN3bOQnC8Zedlo3AWYI1aptTNSCNLjZJJHm3P4X7ZOxxhtSJPuUIs9uxNxu6QPjuG5miX1FOdqSQFNC/C8KR6psYnPgcqTBXJ75nq1V6ibTfRYklJ7r9FK1EArgrKCE9IFPIHbJStkRrC4aS4CTmS6y4kAxRhrMiSggXwQTisfW6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PqJ8uD9J+sGy1zN+DvyxT/uZQbc5ojLhoMVE55H4A4=;
 b=AUj/beDPZuQJ1FmamWj/MpgyqbKnl5egdyiWT0kGsW/y4WbyI4q7wzVyUnQyGV63KrAvuZPynDoYNtz1Sw+lCw9t2YHr5h3GVDMkCEieD1TJybdmmoJTV4NX7mbnGp+AdoE63X+xAtFUzsAZPUqbqN88Q4g18XR/2cDzEmyzgNta2JBOXIvupsCVco1TI4MTcJ29K3A90lS0JKJRoepBDT2m7dSNGfAKqvny7mG4f3UElP5uzPTHnQDPqbH8VCPqNXJ9chszxHQ5kp72zlGnhs1+Qjpo+cqxwSEOqpzK4+GnXFVOJaWQu7Mu6Ggv0WrmhyT7gsxrC/q9WJK5tGHdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PqJ8uD9J+sGy1zN+DvyxT/uZQbc5ojLhoMVE55H4A4=;
 b=bH2OZSN4SXR5jJaUllopW3b+m6b19V8oHIcfx1FW3lPK2bWyatqMpM8NhJk+vgVKYf98s17SkkrAtvehxPv7RLxutbE4usD84xRX0ZISKGC0teUo3vgW5MVmlm7rdDd8utdGDz8TOTUsNwNpx6gWenRovxe8aspfb57eoZLjfOI=
Received: from MN2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:208:1a0::29)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 12:41:43 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::e2) by MN2PR07CA0019.outlook.office365.com
 (2603:10b6:208:1a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 12:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:41:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:41:38 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 00/15] ARM: zynq: Sync DTs with U-Boot
Date: Wed, 11 Dec 2024 13:41:19 +0100
Message-ID: <cover.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=michal.simek@amd.com; h=from:subject:message-id; bh=xacJ66fk6uB2sDPj5wM0qqur8XXBqRH/0MJF2aBCVok=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjsJv39eZ3IrW/HPFoz9MJbnywQtWoaCN8230681f7 bqie3BvRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZgIgxbD/GId6ytRbU0nilr4 ZmvO9eh/3PjPkWF+mNLdBSxq3sVnnvIs2czdPXOXXvoKAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CYYPR12MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 6351f587-028d-4543-33d0-08dd19e129cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGlq4KsJVaLa9bwlXC5W7b8ZFn9V9uWi+FO0N942wbxODbGfXpFbOOTK1fEk?=
 =?us-ascii?Q?xha998lTiqHNux1J7l+iNlYVNA9DnJvzg8ojAgwQ0D3cVhKMryEGQvlTl166?=
 =?us-ascii?Q?hosKtbL/PIqnut2wjXcwHnp/LewaKgWZWmQjf6MjC4kIYPSUCB7dkG8I5aPu?=
 =?us-ascii?Q?YPjcEjFrtLRBxZT5za+Cr7Ed0+7ztWwxjtsrH9TAJItEPDRDc+uAd4Zy7YZX?=
 =?us-ascii?Q?1QSxy9mHvG4G2/MPEMGMjHhjYkycTxA1PlKS6u1d5HZYq93u7Bn5YI9XvGT7?=
 =?us-ascii?Q?ZLY+VC6ZXK7xl+Axa9jZn5a+cWCB87Iaq23dumHBD0Wqk7iD1s1+91BxMGxu?=
 =?us-ascii?Q?PfWzcxOkKFOFsuMRuGq1Ntrl+3QnhLW37Kn7WnW2DE3p9VG56P3pSJCk3QqJ?=
 =?us-ascii?Q?3T+xO2EO+C+77kENG0XRPx6mQkbv2yDzYy90EU3GAGmwW0zAAgBzg6TkbuEM?=
 =?us-ascii?Q?NNV0gDPO9Ca+3Fk0Cxk1jsb4oplwi66P1RbkTgxQbRdG/qHtwbuK85Lj+Y/K?=
 =?us-ascii?Q?wa2p48UJ2BJXbB/Klkh2hBpIkk3zFDT9d1tSYDOnbV4Jp9EURXGav5SQH+rz?=
 =?us-ascii?Q?oBjZRl04or3FhbbFhSexnAvs1wYq7uy7U2H3rgOfS0RHku55cN+5l1MMhnX6?=
 =?us-ascii?Q?K+UjJn0rl175TlVpUmimPRhYwjOseIR5nWSC7r3rZZFVufB/ZU/zO5lCWqx+?=
 =?us-ascii?Q?8Cnnf2DHRAs9CH9nvhTg4JjwMLnLvob+Zf/hB/A5e4A1wLN9SljLceVJpYoQ?=
 =?us-ascii?Q?1CzRd6Q78WsNeiVhiUDwVqhbhN32T+UiNEp4uv5XdANeKP6BwdeQFHArKd6R?=
 =?us-ascii?Q?+ilKBew5hxaZzWgZkXG08+2daD4TDQo10C8vePbWVFIpRWuUWshqXt4aj1QB?=
 =?us-ascii?Q?9xwwCSx+cSxSJ11eec8bZAuN+vTyoolOG9ATm1Et8++8Whh/Ppo5tA9yIH61?=
 =?us-ascii?Q?KB7r0A3oSuTbUX4fNHKMBhrJpGNpGFNKrjm0G7Z0Bxyv3Hf2sUvvHJsShypo?=
 =?us-ascii?Q?SwyObct7tLcdJUeo+gvkdh6FXTKAYb1+YoSJ/Ze2I0a4Dw2ZVLcf2rHTFf7E?=
 =?us-ascii?Q?ZIUThtvCv6nDL6Ilg6p72mhH9N7+Qp8g+G4aoesJNkiQtEH/SxeIQx4iTgSS?=
 =?us-ascii?Q?e2DGiC8SsOOCPXdSeEB7BjqncC+oOkZPyWdHJCryIDekQ5HAhReUiqF6G258?=
 =?us-ascii?Q?B6vTDbzO0erpLcaMJ7ozf+V+BBzTOgIooot1P+purAEt9jGvru2PEOFzIX10?=
 =?us-ascii?Q?8nh04JMujSbfDAvT2i6juvJ2crZ247lAG+cDYXu1oFkqqA0hAtf9+l3HBvlY?=
 =?us-ascii?Q?9OcDUg1wi/bxEgF7hMOuWYK+Gn0OvAD1tziOE/NACddg0kQ6iQ6g6iz7R8qz?=
 =?us-ascii?Q?qenvO8RcNGmpl3K0S/K+U5JF7wDRJzNHu4zSMBgXaYExXCAmwJgXGQwXxItq?=
 =?us-ascii?Q?HoMvgs17W/DTjz7zh1zREWWdV61ic201?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:41:41.5216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6351f587-028d-4543-33d0-08dd19e129cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751

Hi,

over years there were some changes pushed to U-Boot which were never merged
back to Linux. U-Boot introduced new option OF_UPSTREAM and start to sync
up DTs from Linux back to U-Boot.
This series is addressing differences.
There are still 3 more differences but they should be addressed separately.

Thanks,
Michal


Michal Simek (14):
  ARM: zynq: Remove deprecated device_type property
  ARM: zynq: DT: List OCM memory for all platforms
  ARM: zynq: Mark boot-phase-specific device nodes
  ARM: zynq: Do not define address/size-cells for nand-controller
  ARM: zynq: Wire smcc with nand/nor memories on zc770 platform
  ARM: zynq: Add ethernet phy reset information to DT(zc702)
  ARM: zynq: Define u-boot bootscrip addr via DT
  ARM: zynq: Point via nvmem0 alias to eeprom on zc702/zc706
  ARM: zynq: Define rtc alias on zc702/zc706
  ARM: zynq: Rename i2c?-gpio to i2c?-gpio-grp
  ARM: zynq: Fix fpga region DT nodes name
  ARM: zynq: Enable QSPIs on platforms
  ARM: zynq: Add sdhci to alias node
  ARM: zynq: Remove ethernet0 alias from Microzed

Sai Krishna Potthuri (1):
  ARM: zynq: Replace 'io-standard' with 'power-source' property

 arch/arm/boot/dts/xilinx/zynq-7000.dtsi       | 33 ++++++-
 arch/arm/boot/dts/xilinx/zynq-cc108.dts       | 41 ++++++++-
 arch/arm/boot/dts/xilinx/zynq-microzed.dts    | 10 ++-
 arch/arm/boot/dts/xilinx/zynq-parallella.dts  |  1 -
 arch/arm/boot/dts/xilinx/zynq-zc702.dts       | 87 +++++++++++++------
 arch/arm/boot/dts/xilinx/zynq-zc706.dts       | 67 +++++++++++---
 arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts | 39 ++++++++-
 arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts | 31 +++++++
 arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts | 35 ++++++++
 arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts | 41 ++++++++-
 arch/arm/boot/dts/xilinx/zynq-zed.dts         | 43 ++++++++-
 .../boot/dts/xilinx/zynq-zturn-common.dtsi    |  8 ++
 arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts     | 10 ++-
 arch/arm/boot/dts/xilinx/zynq-zybo.dts        |  9 +-
 14 files changed, 404 insertions(+), 51 deletions(-)

-- 
2.43.0


