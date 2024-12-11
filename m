Return-Path: <linux-kernel+bounces-441281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BDA9ECC49
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51A31889252
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279322336A8;
	Wed, 11 Dec 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ra2PTpwM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47FD229132;
	Wed, 11 Dec 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920925; cv=fail; b=JZC5eBbLHO9QZYlkXM8pX9VG88+yebWHawjfpa+Q4q6IUNhZRLQTpMMzviE4oqsJfbWPFW88Hd6NuyUikB5Pgt21tsT91znZSOQTXvZZjlyyl7B7xObbYLDV3lkCbTzT1klQ+r+L6wPQGteACBByxIZLWgJ0sLFU6vnwFyaz2V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920925; c=relaxed/simple;
	bh=usR7Cq/gLig5rw4mEBEJjPc0IIipydLk/618u4l3Qkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uChWKcJAEMdZCLDTUrRhd7eNxmeuKuy1JaSEnFvRZsbgRRWHtj/eYHJcRt/VqOaTM9msxRv7Uj/2/8hgw9kySCnzjc0Xrk1hZnI3Qu8nl6H0N73cy0xJQHGDxQuHvKijHJBaHKFyLxW8xP9toQRiKqzNvyy8Gxm58OwLofdnqGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ra2PTpwM; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMM6OOA18Uz6AKxDuvU2RGlvgzWGhLhrKc2QjZ+2crZx5mlL4rwSum0yBDvk6Z++8uPlDGIq7qXugS+uqj/3AWeaUbodFAtNVcjX+WMDddcnig27rqBvzpHfdDNeFJ5fkBS56JY5ZZIBGCX0HKDzxcwBu58Cv2/CQYpRCEEYt+V5bxnKWURjFlfFoYiYt01unTRPsQ9Yt+AeZPrt48MrDx8oozRut9wjDRXUD+FyrR3NfgrUgssmfZihza01AGA49Srhh6GpnZ1jb5NNOnWcvdKEmYTvpK3IkqSfb07SGAaUy3hXXk+NC/DOSBEeEdKZqAXWNhY5cZxkAdUSuOikhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKhqV/Kbp5XDa7jO5EboUSXTM142twzk6b4NXk7dVAU=;
 b=KbsTr8dy4mZme7JFKEuIlypfr+0OQGsH9mvXWaNnt5umG66szg4Gxp9bIsHS5g0XuSm55OoYfYve6Yg6xwc49hOGRBF+E9u+q72WlEN0Cj2fvUAObeX0xBVAgXw5Qn2B8cSjIeFOkkx5Oszx9pg6pto/+P2kDfbpiqV0q+/d8mkyFr0Ka0kZ2Hc7yhJeJQOZABgmqIRH3I1JE9ptSLNDX+4IR8yRWZtfRvoLRiOlEWnZpiawXaH8I5iYwsh05q2JNk4SPBleFokdiJpNTe94tA9xgfSU6SDorfHDfrUYSr9u3ZpnelOh4fXiqF2itS84ap2H15/bGMgF3IyGH66YCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKhqV/Kbp5XDa7jO5EboUSXTM142twzk6b4NXk7dVAU=;
 b=ra2PTpwMphNDHwIzXDMTqmPMcY6jMNWXQ4H+HgfOmslrEeYLLc6Nw2ZdJEHDUHYKOe+kJ89RaJ/HZQRkCbM51UbAqjmss/D+Pu2NerKUAEkISZAfdNMZ+8iMs4Upm91UyjPAd12CWWf2Rc/I/fkB8AkLatTIC0N+nE8ha3+esHw=
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 12:42:00 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::a1) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.28 via Frontend Transport; Wed,
 11 Dec 2024 12:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:41:57 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 05/15] ARM: zynq: Do not define address/size-cells for nand-controller
Date: Wed, 11 Dec 2024 13:41:24 +0100
Message-ID: <37057526d8ee14416f61fb6e2b82bed65bde5d3c.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=711; i=michal.simek@amd.com; h=from:subject:message-id; bh=usR7Cq/gLig5rw4mEBEJjPc0IIipydLk/618u4l3Qkc=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjuqsx0x+ea6GdglzpqS3bG8ys5+zfssxjuPblj65v kPJ3ta6I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzk+RuGeeoq31855R4RtgyY Lb/eq6Eg/QXTHYb5eQ+YvNYee6b4xiwy4q562v3L74MnAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa73253-d60a-41d4-8455-08dd19e134dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qbav/Jyihrbq4mNWylOqJ6WhywEwNME3rMw3VK4JhSsUBvQbtw/vb+UBM+C5?=
 =?us-ascii?Q?rKvYo8xEcuFSZcJo9NMOEuXwAYJzyBBDNI7Fo6NbIWLtfcDRd8yo+kIEEsVx?=
 =?us-ascii?Q?7GmpokuqtTm3G8mWSpYz3hTZ7Z/157TFIRnCbqda8oAuHUU4+BgZRb+jRtKx?=
 =?us-ascii?Q?/qYGUkVJhGBrpb017NHAfSsLOwlVDIPiy9uIjkgtwToKXx800jizdhhq5fgv?=
 =?us-ascii?Q?13z2PxiRQL4FysGcNS+OMdeS0TGAUkjT7ywpeueypv5NUMVN1O6NtliLZkM8?=
 =?us-ascii?Q?q/WZx5HK1Od/vjQvAQooTFmHz9+8VzsgIgMli+mLqvA9y+zcTJDAMrqrZ709?=
 =?us-ascii?Q?RzcL89cLJLzP/Ny8NHYOQDziuL9PxCjp/YGsp6V8tgIURsYIQI/j82y0zGqR?=
 =?us-ascii?Q?XCC4VS6b4Y/GVeAI+YxOEDK6ogYjUlcfoj6JPyk9Jh8nqiiO5jSss6ZFqIef?=
 =?us-ascii?Q?siMsQCPUVPR2s9I/51r7e5gSRycsPWnlxtYwZdN2dvOM2MXvUPlsl7fFvsHM?=
 =?us-ascii?Q?yogBJThVOLhonDFb47FAfihaZ/+M+GS2wSbkdRFCKPcY11o8zj6cqqtoAQuJ?=
 =?us-ascii?Q?d+3Tcq+vRjYZluZhAkauVHev2UYUdCWjY/c78kxpC1vE7p0YMUw3o4fTp+Cu?=
 =?us-ascii?Q?hT1mr9WplJD1UL3moURpK9olpvixzrq69i0O9sqDVhYjICN6sfXFQhvi1fzO?=
 =?us-ascii?Q?PvMc3vc6GPgQ4HhfvZolOx19Jq9qQl8RB6wObZp/diClKyAb+na0dLp0s0nC?=
 =?us-ascii?Q?w45aDi5i00dzRUbDAH32jue0iU8b5fLQlXKHI/6FLSWQP1tSFIwIgKM1+bPF?=
 =?us-ascii?Q?OB+Q/SheKONa6fWYi3W8wqOhIKVZ/5M/CZDLPt8rmXJ77kqb42Euof3FNBaS?=
 =?us-ascii?Q?WyHt8wkZrwUXZntepA3Y3CEYjvufIR2JVtRUs1Y/RNVJEBdl3JZEd3Kcqz2+?=
 =?us-ascii?Q?0FwWaOKYW/Xf8XG/Wilu5JCguOG1egMEXqTiaFgX9WwwRFCNPIhqiv64rzlO?=
 =?us-ascii?Q?SrRhz3Ccbr5fdRqpUtbiP4x60E9zG0UOP6tjjI9cUEtz6LQhsrfL839Jqf1B?=
 =?us-ascii?Q?KeHHfkwpfdCQcMFL7J7K5amF/tMzh/CESri2l3+UGjE1itvXu3KltDerHmJ8?=
 =?us-ascii?Q?wJ+N4Btwuq+eqQjW/+ZMK5UK0+7ewSEp/PCp4t65t5w/3aOgakl7fYKRgOuK?=
 =?us-ascii?Q?ztfTC2xhxnBY21P756guLqgwB1aK01rnAjRSIIjQCykyHMiaA0CuE9ItfCNh?=
 =?us-ascii?Q?IRKwJkyWF2n0QvxUqCYgcwfuh5KSTjDjRhNOdql0AoLFIHHfaNAD7zls3mtC?=
 =?us-ascii?Q?l18RWq7uSqEkoCLBka9pU1CuJra4dr0N26CFaHSBDtrm1gdWC2k4AxZYsVTU?=
 =?us-ascii?Q?I8EO+K4bTvSIdvhLS+X84tQXdQFHS9V4uoY49EmeJFkxHKYDVHXftn2p9hUX?=
 =?us-ascii?Q?GGohpDSRh4LQWnHRgqf8eEKOb9ej/g7T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:00.1056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa73253-d60a-41d4-8455-08dd19e134dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720

There is no reason to define address/size-cells without defining child
nodes. That's why remove them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-7000.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
index 0dfe2ddd0b5f..d334b5f75c8e 100644
--- a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
@@ -294,8 +294,6 @@ nfc0: nand-controller@0,0 {
 				compatible = "arm,pl353-nand-r2p1";
 				reg = <0 0 0x1000000>;
 				status = "disabled";
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 		};
 
-- 
2.43.0


