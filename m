Return-Path: <linux-kernel+bounces-441292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF79ECC64
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FE4163AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB0236939;
	Wed, 11 Dec 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TZ2EjNLs"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B1233694;
	Wed, 11 Dec 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920962; cv=fail; b=H+Yk9zZVBQspsbTlx9Wc5xnGsrsI2I/CPXMfcT77S2SZaXx609aBHwQZZ7IQRbK10oDpyLUVPl/NX4fwSpiEvOlQW+Ppw36+C+gort2H06NaH0XTrpvo2vxCZAOI2ZkzVe9KazeFphlC/5YDh5MsrxQuV+q8kYMBnfKs8MhffAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920962; c=relaxed/simple;
	bh=0cDB5t4fad478ZDrN9Gfy8tp7OjAsQt2Dgzq+oCfAkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyOfgf6ImwdrlGPmhF7Q2QYmDQxUQwyt0DhyZXV19P3xFrrYLwH/d8416fqbQiANluhZqNpKDKTFZOUFkeCAwlFBVonw1Oh2qnwdB/6rfaWkc5qUt5o1j5wLWp87BU9cbQDsEeVz7KPobsSd0dJWd4oVGoYep+Mve/a7mbE0Wbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TZ2EjNLs; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+dElBWofpmCK+kz0ZNKGQQXfriZk5hKHl8oT1kD1W0N8H96fQ+VvsT9BLBZNdB8Kr52yn3M6nIujYsqfe+0LCrol8cjh7Z38u9b2xpAADtkg3RB/dp7CSODSplxScwfUEZzWVsm2uZjVHSdG5B6uBSAlIAAXWcTT7m3WkqvoFk1Lu5rshJlpz4lmQM9OyfB9K9YLxkpanTr7bhnw1U2QGChC8mlDv70ZL3Ce4F+XOhbpLUcitMSX98vWd9552BS++CeN+tBkptDeMk6rJd3QFO2JKJ3yZi5s9SUlwi+J/gT7RqkSF2i7xDfkIHd8hIlu2e+GgRJHj4qYS1HumF0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU4PnLr0xM6YesOm9M7wAaflPh6sfFOkv1urXv2k+Fk=;
 b=qgIL+X3uBzKOIx/fpCQc+F5c8XHWv+1F3EsvhogM7AlMV/hziv9mRz/4ScGMLLEPMTVZTVzSvUPkg7c541mcDUozPY5idDHdHjLL9rhR+y/a9TKNZ2XMwL4VOhRYbMHYY7LwD2DMbWmUyjK4MW9vlA4y3an+Lkg+VbcIBAiBZQrV9bpskEn2iTDLyW6tRJ0/ZlAS9PU7a9wROyCFtHDXVLqksZvPeXh4B9nIHCa5gxQ0OKgEjwxiHZrxt4bm8FSLHFPzrbz5R433sBAmQHhvGmSuEKtwuF2OPS6QV7kKWW+Q5tENmFhyt04amw/tMj51v6wa7r3Gf3knG8XkbvWdWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU4PnLr0xM6YesOm9M7wAaflPh6sfFOkv1urXv2k+Fk=;
 b=TZ2EjNLsHGGuKBwoMEAk4kV8fYW7EYwKXhUM0wo2fqOf2uMf3W7nmHjBhAG808UMRg9OPx//LpDJKL9uZf+GJZcjmNoZmqTosIzhcTGQUQBmWljC3TWv0qmCa2uECmGQ33rrzehfWTxteQYkJcBByutpUj/nU3mAI/rbwWJNmPI=
Received: from BN7PR06CA0050.namprd06.prod.outlook.com (2603:10b6:408:34::27)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Wed, 11 Dec
 2024 12:42:32 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::f3) by BN7PR06CA0050.outlook.office365.com
 (2603:10b6:408:34::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 12:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:30 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 14/15] ARM: zynq: Add sdhci to alias node
Date: Wed, 11 Dec 2024 13:41:33 +0100
Message-ID: <9fa60b57e038d51ae6677fac6628ecd663ddd2cd.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024; i=michal.simek@amd.com; h=from:subject:message-id; bh=0cDB5t4fad478ZDrN9Gfy8tp7OjAsQt2Dgzq+oCfAkk=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjvrzk454ymQW/F+XqufNtaDnsdsnNql/bvOFtlxz4 P/y+OX9jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRiR8Y5meaLIlIyerW9PhQ cPIjh8P2m1eexTLMZpsxcdLSwhkcf0/GTDmqwugb8lzrDgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f584a7-4b3e-48c6-0f62-08dd19e14859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qitk81ZHgP5W2ftGHZ8Lmj5JQ8C5NFT0dQ3hkyDqGIl+fjMi4lfWYO2dZ4q4?=
 =?us-ascii?Q?nYuKoppTawH+o0DR3EKFpDg/rBCvjbj4oaCzH1RIumZn+yxrovebVYXP9qaa?=
 =?us-ascii?Q?erD2VBH4Iso0EtiuKwBmAX0JZ4II+CPNsbs/sRCorytMuDR5yan63ixWwdZg?=
 =?us-ascii?Q?jDJwigkR+JxqPnXYmX6bE/AqmWP/J/UjQV1VkiWflKcf5/nLZ+az1UL+azzZ?=
 =?us-ascii?Q?YgDB/ChSjnENq+KbfY/O4b/fjTE201VAxXkFQLmRS+Ox1uiUxL20LoShXErI?=
 =?us-ascii?Q?dz5QMcnmoAQOZJuP4s857kUCTRCZcZhKiVk1cZFIg0z85eG/qAvd4RVsl8sf?=
 =?us-ascii?Q?pWGojTSiy9jaYata6DoVsUajzDTCtwGe/xJKuk/zswyQib+j8jBefh9PutMr?=
 =?us-ascii?Q?G1aUs+FTrDLk2SeVPvkWBY8uNOAwhQbnHd5uaFvnjJYt18pfup5mgiSAYnFL?=
 =?us-ascii?Q?f7h16hODi26pxAqMvPtRdx8FwDGDptTOlWUcslm3OuWPBGGZOvOFoimAHxw6?=
 =?us-ascii?Q?iqF3f9JZXm3jwpIxlifncv0odEePnd1Qzn59yuxYkqQqi9W4PfXHK3c33rSV?=
 =?us-ascii?Q?gOETaDEijPsb3b+NlZ3tXFaevrHCPgTnLdbki5/GDItc4X0eNaQCIIHAQTTP?=
 =?us-ascii?Q?eFT7Cnt7uw6t8fgKZoEijG67y3/GHavUE7d7uCIEvUsUz+oLcFG//elBQWXK?=
 =?us-ascii?Q?Du902sbBJQLRldqyoXNSulO2yyRh0XzqRTu4/NiASAkkjGADVIb/TcKDPf1Z?=
 =?us-ascii?Q?WnJVCYGbzDtpC0+4iUAK4Q4nTOrtG1MCYdqRFnu/fsey3y03PQOPCi/Yfzz/?=
 =?us-ascii?Q?YckRnGvlTl+Ac+t25yg2s1Oz+cat8WIYfJ7+OHFsyd/bs5Y/mcC3Ghhmr7/Z?=
 =?us-ascii?Q?YpxHuDjFMwKFr7YLPUKBswtWg0HYMuTJRXhbKgdWOJK986XeNSzYUkdAv9IX?=
 =?us-ascii?Q?qnS2QDSRl9o1B675vWgLks4hRlNZBM6fFh8SqaWnafLSuxFXCSrvJYH/Dl3A?=
 =?us-ascii?Q?9DnVIbfsLWpaxIQE230JDwqFIndd0YmvsjwyhRyFwvj3FEmk3QrdwlXhM0RN?=
 =?us-ascii?Q?9gHd4TQQSP8kbXNOnbTqf8t5LapaubBy8pOpKnCEABUVqSvAgDq9nZA5/N09?=
 =?us-ascii?Q?tKsY9kyWBUurHLBXa5DzNUzQ770iBgfpqnCSzbyBEGbQve/j/Wsa216TpMVJ?=
 =?us-ascii?Q?IVetdxvcQ0L/wb6CKBkR9qUOJMrr5+cyfAR7LkLjpGCpOs1V7pXtfG+y3142?=
 =?us-ascii?Q?AlzCqRwSMJx/NLRr4UD01MtgLY5Wb8X9hZ0/xFuYc2qWKYUq1u9N6uUzjT5I?=
 =?us-ascii?Q?Gu+kVfMpPG9Ryu++7K17wYX1n+jXOHLH13Oxlj+aqdC5WpGVx/fEHPEh5xLf?=
 =?us-ascii?Q?Ga4jGAVo8s3wl7yhtifKC6COnCKidzQrI5MPbR7NHo6lnmRije7tmhjglIqq?=
 =?us-ascii?Q?g+GIP0tnXrOip/bCAVeeX/6ZNm61m55M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:32.7985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f584a7-4b3e-48c6-0f62-08dd19e14859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119

Ensure that controller will all the time use the same ID.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-microzed.dts | 1 +
 arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/xilinx/zynq-microzed.dts b/arch/arm/boot/dts/xilinx/zynq-microzed.dts
index 4c3e56980c98..20c04862679d 100644
--- a/arch/arm/boot/dts/xilinx/zynq-microzed.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-microzed.dts
@@ -14,6 +14,7 @@ aliases {
 		ethernet0 = &gem0;
 		serial0 = &uart1;
 		spi0 = &qspi;
+		mmc0 = &sdhci0;
 	};
 
 	memory@0 {
diff --git a/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts b/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
index 5e4247da2285..56b917eec783 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
@@ -11,6 +11,7 @@ aliases {
 		ethernet0 = &gem0;
 		serial0 = &uart1;
 		spi0 = &qspi;
+		mmc0 = &sdhci0;
 	};
 
 	memory@0 {
-- 
2.43.0


