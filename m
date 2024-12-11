Return-Path: <linux-kernel+bounces-441289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DC49ECC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194A428981E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE6232368;
	Wed, 11 Dec 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CMDSaPs2"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C622912F;
	Wed, 11 Dec 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920950; cv=fail; b=gwCy9tOZxxyQtHSao3aStepwhnJiXfXwdpHSFaYuzBeCXF0IRaIrA+Sh/yG3EeeIPwDHIJCe1ytUpGejGg6NV7shnGxVtQFlG79bO47B/CcomxyU1lJfrknl0ihRqqIeuCNw4AkEHXjcifNtySbuS9K2Rtco+lCj0WAZr5LFc9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920950; c=relaxed/simple;
	bh=lfUAF2bk4Z89GD+8ZfnuGE7Bi3gdJnMqc0lK9qKi0jM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmYZBI+dehUFWXd5mTmD5JvBehePCSHaLX+JKFc1nFb34Ao4fgSLaTq83IjsXSEL9Z4zOoR4ZKv8xylLPxdvY6EY4zje3/jLH72xBFHHnamWudzQG017MJk73ZqoUPRiSXniL26U1QzqTqoOMiC9YgelFWWPF4flvFIpEyn2s/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CMDSaPs2; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP70XGGHEC3qTRYmEt6kWJL/GakWSa7w47xPdH5NLcFLS5F2cy0Ft8pIlpqqzfmjkxyQDoabGA50ZB4xGeB2cxTREK72aYB7bqAyhcyUlAsG7PvCFONgzXKoaO6cuSOvSzFSnWtoIXWUdHYcrkaGMQPbRkgAke6elWF69BqQDqAPpnr06kBMOAF4ZiGrCjUJJ1biuwKeYAwuTsoz6j7kpJCoUzdfkm+p89WYvlURKUimNWehRCyLIZhK13+VEMgiyMlT7l3gSQSLepdNcvzWrMMYlYPw1KuwG5xeZctHsIV/lypxy0J18v1H5TlT3b6UyLJHoPVOy8IOG3RbR4xSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EULne73EL/ClErgO1J3u3BNrI9OoAQNIPVpakXSq6xw=;
 b=sE3H8ipKtuqnBQQFyFUghhiLgP3C0+HTkJILNrajKm/MElUuFPub/SHEmja/71nBOsBx7IQZtHd8RjQ85RvWUdi0wuUOEbk6JkFURd8uDjFNpMxpf9MG7KHZn0zLNnGZ0Rsi81NlipIaq9QVne4hsxuATVvwJ0pIIjpxWEi1YwASEWg1jKUyF03StSh9RgW95YmfGrSl5zbMHaObvFZzfg1z89OPIRs3EevutGA7LJfwT+aZbrXIzrvnqgQGhqxtmayXHXdFzSUafc4k2aqoIgxQjbPEeWMcWcM0So3xQKGqCM9C5wuurfJ61FR+FWVWvQm6mJXUdMv8Dp5kl+LF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EULne73EL/ClErgO1J3u3BNrI9OoAQNIPVpakXSq6xw=;
 b=CMDSaPs2qcRf3apc240fMfjvTZAU6HUjSiSO+dKXVG8pa57rcM0fvKIjBxTVaFZsvjtCWl30OBDXhzvLRr6GjpItZVikhLz/lw18nJoaPtxQ5OHhLSKKmL3FXa3iGQdjnigTNd0yUhJXR5PQT4j36iD1oastKxkGiFSbyuLarZY=
Received: from BL1PR13CA0393.namprd13.prod.outlook.com (2603:10b6:208:2c2::8)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 12:42:25 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::cb) by BL1PR13CA0393.outlook.office365.com
 (2603:10b6:208:2c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.12 via Frontend Transport; Wed,
 11 Dec 2024 12:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:23 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 12/15] ARM: zynq: Fix fpga region DT nodes name
Date: Wed, 11 Dec 2024 13:41:31 +0100
Message-ID: <0fcce9f0fa4fc2e170a7c5374d0b4063fa0bbd71.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=michal.simek@amd.com; h=from:subject:message-id; bh=lfUAF2bk4Z89GD+8ZfnuGE7Bi3gdJnMqc0lK9qKi0jM=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjrqD37u2q8m8ftRVbbm61+/ppWqWXysP87lUygT6l 747XDavI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkgTjDXIE1lg8vPnE5xDrn zDwB+XDLjec0QhkWzMqWUbY0WNStJ698Uu/YqaV8rEt/AgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e2ec0b-47c3-4b5c-d508-08dd19e143cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oHBTAdZA5EXTP4KGHiYEk8G3K11pcWUR/3DhjEPGdZKmilKRRisliNibFlqG?=
 =?us-ascii?Q?tUkZpAYa7mEWhagLYnmNMB5Uagsp5bl9mzR0q7S2jY47RHEsatpoRx9C7XBQ?=
 =?us-ascii?Q?W7n4cIVlTB9pYAcGQ0+e9en8ILdwnj3GkLfRM2dbF77PEMGjvvmV7StoGSFj?=
 =?us-ascii?Q?U227Tosb8pOtGWnQQv69yFFL3ugmgtxz4K+GhZqDtCqJ1YRm+pQ0FC4f6lw/?=
 =?us-ascii?Q?PoYG6Pjvs83TpDyzSv2k9fnweL5FGklRiPyP3oAANemgWny7kdeZRXbJM3Ln?=
 =?us-ascii?Q?Ilwg3Mjaa5B4E4ahdwA5dKKd40wtrrf1YJDLydzDNqVaG1d2FjmcEECv9Nmq?=
 =?us-ascii?Q?QXU8anAwY8QiQ7vV3og5zOHuVXIoXCev9iuHUYV0TrJbpQ6ZfVXEfC2PzDTs?=
 =?us-ascii?Q?vF2AF4f5/43irWcfpSTYTZDy740xAh71BqcM2b6h9ks+aPhFQ0eJ6E4hyTTF?=
 =?us-ascii?Q?ncElbDFLHDyA1D5XGY/U9iy2Bmc5OgaMVNOJ8b1HoDzpa7kMsW3XkhHjXLJl?=
 =?us-ascii?Q?9jUshlPakHXI9Xhk5WmEk6wVOJuRfoCKD0P82DtZ3DRViqKvLro94j9PAE7n?=
 =?us-ascii?Q?QMjd6Nufa8BRIiq4HK5FC0qGc2wJQS4o3DtEqpLvVgb+ZqpIcYuHw6xYsfTT?=
 =?us-ascii?Q?uM8SyVK4tjx6FyPOOd3Kd6CEPYyRknXjxZTtjyCjGC97JufBfkBpwLl/2LCj?=
 =?us-ascii?Q?ZVOLK/+512A7MF6EAsFN7xGOuYBhazYLfi+wPHpx/+KkCPCBYQnBR6mpHUFE?=
 =?us-ascii?Q?4kYPNLeeRzK1cENSIbVFIO+vFx0864v1n382r3cEdzxtkTNdmhqW0KmZAHG9?=
 =?us-ascii?Q?Cv8uRdNszW9D1aVVCI4Uci57BR1PDeM9QwElYrMkE7GnJKbD4wlHg3Ser2zR?=
 =?us-ascii?Q?FYWgVHXqBOwWIoEE4IzYwTe0j/3Ro0IxaeldedwYTJ4FCbMkA/rvgaEzoV3f?=
 =?us-ascii?Q?QW4WT4dMDLJVLEjUnOyEp0AheFabN2WWrXWazR6mnQGwKNMPEP193ud/W11y?=
 =?us-ascii?Q?nbVuvAW2yqi3WOKlgYf9Uya0YCKI3502a8QmOXr5WojCo6vh4vEj2T08KR6N?=
 =?us-ascii?Q?ZEXYLz+EFqXvyGO2RpWoQDEY0ePqOlAw48kbdPTKnPbx4g2MII4c8c1XUmZK?=
 =?us-ascii?Q?9EZ3D+c5EdkK7PxGkFzHlrERMtuwWpQ18uvnOjukv07RjUCsaAybgp1LHZ3z?=
 =?us-ascii?Q?CDDgmwnSWG4re5hQch5UI7ObVVp7p8IRHnDNIFnIQcye0TsdLkBJm76D0fn4?=
 =?us-ascii?Q?CqL6s6QhGBTxHidj3kW2vy2HeimeAjS2GVj2578k+vy7C2pXv08EvLyWa4R9?=
 =?us-ascii?Q?klEw6bbt9H+iu05grn/X3mRSVjmkdRDmsnGEN7xeDr3Royz+65ksPNgURv9o?=
 =?us-ascii?Q?I+zyfFifAI1/yv6+0k4XQnYut/whne5+HE2TzbJxt1EFsS1GMzDnHGs+fbMT?=
 =?us-ascii?Q?WDbDPG8GqNub1GxHK8HgADC0vucjfOhk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:25.1686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e2ec0b-47c3-4b5c-d508-08dd19e143cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588

fpga-full is not aligned with the latest dt-schema. Generic name
fpga-region should be used.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-7000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
index 46182a5690b8..153b8d93cbee 100644
--- a/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/xilinx/zynq-7000.dtsi
@@ -41,7 +41,7 @@ cpu1: cpu@1 {
 		};
 	};
 
-	fpga_full: fpga-full {
+	fpga_full: fpga-region {
 		compatible = "fpga-region";
 		fpga-mgr = <&devcfg>;
 		#address-cells = <1>;
-- 
2.43.0


