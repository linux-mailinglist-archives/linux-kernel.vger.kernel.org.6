Return-Path: <linux-kernel+bounces-190334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17948CFD04
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D518D1C21D42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787613A407;
	Mon, 27 May 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KSC/C42I"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D513A3FE;
	Mon, 27 May 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802470; cv=fail; b=udjrFIwd06RxDcbBasbpq/esxsUyrONqBbkcLqewuNtpN3/nK8EaLFZb/1DgZDVrnMZGyX955KRUkCr/JiwNKhUK0I0QsgjQ+EfQM5RMLjjhxLowgT1f+w18Gvo7N6JpxR4gEW3Cl0wCXkgeAdFAZMZqN4t3sx0yfv9yjFuvO0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802470; c=relaxed/simple;
	bh=cLUvMN9C5cb237NWsWPhvxV1dGdR+kG/hwqdqy57ekM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FBdTMjYt+p8Yhg7l4elaICRlaaJsSwc0G61ZK9VVhqCk+ILBd4CZAnnhD0mo0e2SDOTFW6DrAVLA3jDn7PfTU574r2Iwtv8VwgLTyU1K8buVFEdEdBP7yC/DEgQgpvuti8hRmlqbgdPt+ifNly7n44GGMYw6V1n/2sxS5Dooo8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KSC/C42I; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxFExEDRvqhhB50IRTEy3HvFBYyvVB+zninv/rOIUBKFEHg32uw4dhMspB4DsMRKY3soKr3JdZ79hXpFRluB+QIwCSGCOc21CzNa6dwLivJmugH4ZohDQYqsBoRCE6qM0nLqM5w6X47I94GQe2cmFJVpxRgNxNXTk71DiRNsVCJIHqjtPLDMMzVTgQwahQ6UXwFwcNPA1VMouh6nZU7WJBOeG2alqONWC/UD+rV1CeVkSazJhz+q1qHNi0Vzp7vOYoFsLTD1QCFDIjJ5HQ6DJoQBgNpM/zlZbx6igURPx0GtBvLQBiOBSeSXzgitx/muTq0CA+OhCrZ97huoLOQokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jDmP8/zJcCqWuI2MFC6XZKPi1W2Resil/Di9/ztmqM=;
 b=Lcsg58EeZTocjoD3QSVttPu1/iKoEOdYm4EKJxqBfQmelmOafYbB7jST1Xn2rAI5XbwHF1NaimdjkHwuyZyfMlDLwr9n0r2Sa3I8/I2O8AHOICSP0gE5jwIuIsDeshqUOAjdgcybojTRqEibNjbshsZYnHwMOODquzJiLzH6NonMO735kQQgWynJPZiGMtSuScJJxIjJOnjevwQkw/x2xTkik3ieod2NfMulQh5F3bi7FOUQv2tceH6qpuQZwXykP4U5h/4FTI9s4Q/lfuy13JeE4/GmaFmvfO2tRIC3jkwE+hgWBbWhZA7i3FKH0/zTU7LcPOXl0zGqKm3O+V1Plg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jDmP8/zJcCqWuI2MFC6XZKPi1W2Resil/Di9/ztmqM=;
 b=KSC/C42IMN9Tu2fuA02q/Ji1IETo79mIqQaQHxHrJwj4xpBEuGu6ySkogZqxwoXl0cx+3pVVWJY4wFCL2uICnYfvrpyKHUYCCSowef2QBQ35fHnGj2SwfOwTDgYUjMHmucItUChBtbee9ycjrcfKjtZPqEg/iPuP1Djturvrk3o=
Received: from SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::12)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21; Mon, 27 May
 2024 09:34:23 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::2) by SA1P222CA0092.outlook.office365.com
 (2603:10b6:806:35e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 09:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:34:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:34:21 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 00/12] arm64: zynqmp: Update description for Kria
Date: Mon, 27 May 2024 11:34:06 +0200
Message-ID: <cover.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464; i=michal.simek@amd.com; h=from:subject:message-id; bh=cLUvMN9C5cb237NWsWPhvxV1dGdR+kG/hwqdqy57ekM=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4MnL1x7LU7j/6ven5eorpUuWXn/Qq3AupTP3Tvk/j i9Sr0XdOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEElQZ5mdyXUqOY4wrbGcU PB78vX1Gdy9XCMOCli3vHdXZzhbdXD4v++FV21f306tTAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ba902f-dbf9-4a15-1a00-08dc7e30316a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u484joR54hpVZdH0FW5rd5upefMdjBZmq2MYOEISpIA206rvQjXE0t4RcP41?=
 =?us-ascii?Q?LinZGIIwTvjsDU2fCqyXnywUPih7mC5Myyfg6uMRo8ujSUjM4Zk/lsc6aBcR?=
 =?us-ascii?Q?SVYnVybrLNjrTYAswDLI65xojgF+LiD1yelzatEXo7AZpX8J1G8AXg2hFUdP?=
 =?us-ascii?Q?8rt/O6d5pxpMhlSqDQ+4sxQcuJVHPS1vHLv98j8BCZAw68MkEpyoMWlm3E9J?=
 =?us-ascii?Q?GfVxJ6cIg+fgAOTLLd+l2pVhhy6nLb0qCzDNAPJpq5pWGTIE1IYYuXY3mk4e?=
 =?us-ascii?Q?VkpzZizPO0fOZvIN5qZffZOP4FIF/7xovyE4lsft1b0jt+26cxJm1o9uCmCf?=
 =?us-ascii?Q?w/hbAYlA2cNj+zjGA8gVFkc01ExLT2pai8EZ5Xb3D5BFn64BQEi3mec6BlN8?=
 =?us-ascii?Q?8hnGdJeKJ8uiOgQe8E/A13+knynGB0alwowxr4B4DyfwRz8LvyQj7jGCZEuO?=
 =?us-ascii?Q?x7nDz+bgFpwtTmSVorrXTzB3dXIl8eT67z9C1z65hLXog5Udq57G97I1zIRs?=
 =?us-ascii?Q?t23vzCwRSjCduCzFzioh0YL0DZ62+V5xXlZ4QTNVr9HiBbijoXFQiVnpbqWw?=
 =?us-ascii?Q?EjzEWCzZyWpLw6Kpkk/zEsgfcQIQ6Uss6gS4g93ttTrw8hb4YoHhUVBOU29U?=
 =?us-ascii?Q?A6q6CyTq1Q6XZo5rssGRgLyI39A0NsCfYsbpU53Sh6VI+sGlYg4pBHW9SoOn?=
 =?us-ascii?Q?TDG51HH6YUWRPodFoCGmTyRHCQuOG9S/QhykxDA35OmNEz0EPbucrhaailaJ?=
 =?us-ascii?Q?QTH2FAcauBASVYhDmX6tG1CTYqhx5jN3fGDY0hcyCrBiZcmu6t2tmSkFLDd7?=
 =?us-ascii?Q?sfledO6t2LiIwIlwlnAG7gkpbUDUmEHKdozyo/rW2/AVwDsYnTXw3agylgbb?=
 =?us-ascii?Q?ooIv9fyCAlu+tQANG42cphexR/Hro7li5czSo01NQmKQA88n8N37PuUObtn8?=
 =?us-ascii?Q?n5nt2Mxn+LKCyB++dvec/iOa5ZMv1MyIxRK5AYrXuljInkzAlBBsnmC/LHiE?=
 =?us-ascii?Q?QTY5ays5Z1rWqxqvaabRFyNsMvM/YG9Qi6QX6NkNlLi16ZxGwesMFjUM45r6?=
 =?us-ascii?Q?3zOuMU9rPekkYsJ1bL5JjzAAEWhbrzWVKcV90dpou/cdvVYQrjH4tPH5iDSv?=
 =?us-ascii?Q?KiWdGAvfdKWQ7lkH2FMK8aw2YZ3saWTG9F0Iay0YYn6h22mmEc4DLPev/Plg?=
 =?us-ascii?Q?4TryDqyMo9C5A69MTqvSFANjPOyK7egUNkbbGP+5q2MamPkQwd0bpIparVih?=
 =?us-ascii?Q?7bB19AqXKHiZU2ziuGtp+TUp/PGHym67k9HBddQLMkcM2+nW7zLO9tvK6M58?=
 =?us-ascii?Q?hPn1lHdJvQRuiJXCJRQWkzA9eZCgwgOJkF0zwyxS3TN79e6T1uWITzSs8rx0?=
 =?us-ascii?Q?p04P/uwqg3sCA5dqtM5b2aS3klC6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:34:23.1709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ba902f-dbf9-4a15-1a00-08dc7e30316a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014

Hi,

over last couple of months dt bindings have been updated but dtbs didn't
reflect it that's why I have created this series to match description used
in U-Boot to be able to switch to OF_UPSTREAM for ZynqMP platforms.
There are still small missing part regarding usb peer hub and MTD layouts
for other boards.
The rest should be in sync already.

Thanks,
Michal


Michal Simek (9):
  arm64: zynqmp: Align nvmem node with dt schema
  arm64: zynqmp: Use fpga-region as node name
  arm64: zynqmp: Add missing description for efuses
  arm64: zynqmp: Describe USB wakeup interrupt
  arm64: zynqmp: Describe OCM controller
  arm64: zynqmp: Remove address/size-cells from ams node
  arm64: zynqmp: Add compatible string for kv260
  arm64: zynqmp: Add description for ina260 on kv260
  arm64: zynqmp: Add support for K26 rev2 boards

Tejas Bhumkar (1):
  arm64: zynqmp: Disable Tri-state for SDIO

Vishal Patel (1):
  arm64: zynqmp: Add pwm-fan node and fix ttc0 pwm-cells property

Vishal Sagar (1):
  arm64: zynqmp: Describe DisplayPort connector for Kria

 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 19 +++-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 41 ++++++++-
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 19 +++-
 .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  8 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 91 ++++++++++++++++---
 5 files changed, 156 insertions(+), 22 deletions(-)

-- 
2.40.1


