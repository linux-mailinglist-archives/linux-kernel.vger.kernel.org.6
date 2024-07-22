Return-Path: <linux-kernel+bounces-258942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB40938EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446C91F21C80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5400016D4C2;
	Mon, 22 Jul 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GqD0Cep6"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDA1754B;
	Mon, 22 Jul 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721650766; cv=fail; b=BGTvB1W45svBy24vqKQaoenVw9rQ6TZgOzJJzSuLblXywVscDotCUbphIZcUSPHDXPoed2sE7CReV52fN/yls9qLizszbDNsYzxECnbuUGkTDCbGezhVo4hykvd77g8wADG1eMCaksZ2eovQhFMuNVHfO3emuZME5RHgCtAxoYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721650766; c=relaxed/simple;
	bh=r5478eT3TK+fDj9xuzHMuYoHZiYYWt+n2EdgNOBbA/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCvUYys802lDPPprYC9KUseKNPGBnqjvb8q63DJYm9vjZst7+VSbZdeK3zlqR598FwqVwkrXQt6WylMFDSeOCcyRoSY/SyKqz1BQ6kKzkZZbipGIjQh9W3q/xXfwqpX2NkcH0KzaoXC5N/QrofMHEUb6BODzEgod6qh5myhpddo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GqD0Cep6; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZH1up5mjBzh8+XISYXSv79HZrZ7f/av4xaR360BBcQaVTohJ/spqNcTFNi4SvGiIopZPNMEfoELTiOn5wwLCmAVvmPAvhr/B/O1YPyqp5oB+59HbqLbJnFZfDy3m4s6TMgEpvQEjIlcvJL50MwG4K2LcRTUobE8Ua5vfdXsapDArsaJ03vMMCyV/gR4Gz9QHNQBYy/LhTGgDFs1xhfVQ5knZusbCJE9XM9/djfYip9rmN0hTcYYej43PGiaNiqDvPNM1Pv/DBXWwfdmm4Gub73sFqw379DAOGXet761j+9r7XCWw9vUhORD/cVzOoVjPhfUgK4mUm3HuVp0jmQxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb7HkxB/TtxbirSGIeZigLKMvtBDNy5WIoOkcrVGA6c=;
 b=se/TP//Zha6R8cLCbV3wgPp8D2fb981tc685o+tBT775vnNydi/FTpQoYE9wIP7ohiF9ZUr7jrD32n+QJc7wvtv9FrAq37KPr2hubX3kG2XNQF++mT9N4TPreu6fz4iAoEWfAulpU1xs+t1t5oH+hEEi08RuOWbmvs1AnEGBYrQXPyDAPf6MyilFyN7BliGRMsx1LXot6qBcw8Cf+IwhwlFKsRpVItB0hZIiELoBF7J7En0S9gq8prbIrlh3eo916YGUeZQNIKCIc84R/ANcavLBLfavqzJUDH03UPVrkn3PK5TcRk3tP4cHmcWUEvisV7+YUk+GQ2VBB330IpBdQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb7HkxB/TtxbirSGIeZigLKMvtBDNy5WIoOkcrVGA6c=;
 b=GqD0Cep6/YH6VkSoGvYbH6xoldNYSMtnIxVPsgdfRxbAmjqKuGT+XTqnIdWTpUIcVCeYQ4YSrIC6/kGDkEfu2GDB/nVdwD0/lZSwIM6yP5aqT3HPEmIOCAEur/XyS397poXaR/p0enFLUp2BIg+2cVNfGFk/8vQOYVdkypndEnk=
Received: from CH2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:610:60::28)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 12:19:20 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::8c) by CH2PR14CA0018.outlook.office365.com
 (2603:10b6:610:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Mon, 22 Jul 2024 12:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 12:19:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 07:19:18 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 22 Jul 2024 07:19:18 -0500
From: Naman Trivedi <naman.trivedimanojbhai@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <michal.simek@amd.com>,
	<senthilnathan.thangaraj@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Naman Trivedi Manojbhai
	<naman.trivedimanojbhai@amd.com>
Subject: [PATCH V2] drivers: clk: zynqmp: remove clock name dependency
Date: Mon, 22 Jul 2024 05:19:10 -0700
Message-ID: <20240722121910.14647-1-naman.trivedimanojbhai@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: naman.trivedimanojbhai@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: fda4c429-96c3-4cd5-eb0f-08dcaa4883d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXUuglnkJQSipvJLyOoOC4TE/XQpczk/T2uB9MUOn5eBQn0Id64iXTwvB2Ow?=
 =?us-ascii?Q?PZQmUzyJc20B3OVD8wP90ts4rY1ZdS0WAltHBmlJZOUOEHuut4QpV3H2+4SY?=
 =?us-ascii?Q?aJFxnGag7iuO19+Bta/K5QtZv8GpgYGY4zy/Q3QptrJIkqS4iZwJqaLkSXE+?=
 =?us-ascii?Q?W7QY6cqzndguv7avaph0byrt0weXwPXFfd1obWoyDIuHcul4wrinx/MnBHPl?=
 =?us-ascii?Q?zh8PAop0kFpfez0eoKeJrglLanz5RBWWWMm8y72X1qfn27qpRNbIgDe2vDVT?=
 =?us-ascii?Q?yzmulsdEUbk977L7VPkT+/YoxFL1xhqIAyOJRQaj15NEymSocDRr5GEKUUKF?=
 =?us-ascii?Q?lMVwz/laqyJlW6CMyg14QaC8e0cW/nC++8lTYDCvbpHVUvhU21CU6Zrsxd10?=
 =?us-ascii?Q?iumlcxLBAtlXaxQhVCTWFAzSfrUQ8jfhzZrjpf+BRA+XDn1wBdEAAEkxs1u+?=
 =?us-ascii?Q?a/SMklUChfut8aBIVGa3l+GHU8TADWC14DAZfVO/prLBP/sYjqs91ZryQMbf?=
 =?us-ascii?Q?cznCjRU3OUFvqkrMrTQNqb/SW54tOFsGfaqGn+WGKhG6eDLAKr8OyYBcnntw?=
 =?us-ascii?Q?vmUGbJDbIKVZt6hcOmBqSNVCjZ0xHankI/qXvctf0adP/CZuUNqXL/0U8dmL?=
 =?us-ascii?Q?bWUS0nzv9F+FkAti4yZNy5jLwn/uebtHBUiBo/Y25zPURBDcS0W8r6z4xyjZ?=
 =?us-ascii?Q?/It8u73K6goCtI7OvSOinFVvw0hueErPRTiAepZxDceWABj64CuO18Nxbkao?=
 =?us-ascii?Q?bLQC38qkKa2l0C4/YQs+tUk4h2mbpiZ9Aa5DxG3EWpvVf3+UL+moi3172yXz?=
 =?us-ascii?Q?ozQDOsBTUQasm8bpC5Q7p9vrG9zD0JEBJ1ziM//T7/ceEZvrKdJrXaHRZH7Z?=
 =?us-ascii?Q?VeAuBPPQwNj2YBtDObQ/geG2nKs3+v8CN7/rBK5Usfjkrg4IncybM2ZucOp0?=
 =?us-ascii?Q?a4CvXrEwGaSXagWPtNChYKUp13pZO0+N259b3D8LTNLIzCs5lk6eX8fwWhbG?=
 =?us-ascii?Q?LgG5wZ2JqwBCXvpswx8HTPg/2nH/UbgHiPtgGg4FwjguwTk+UVa3qAJKzsN5?=
 =?us-ascii?Q?UrLH+HvXLO675zorPmQ6BuoBBLpTLO3xZrELaazwuoYwFkSNun5FvkbPtky6?=
 =?us-ascii?Q?MnncfjMI/9vI4yBam581gLOyblNa3aFbLyiivec3j8iDd3DXO/PaVE6zpW0H?=
 =?us-ascii?Q?h02gDFrXJTc6Rlc1M0Q2bMaZuZpqEPMeDk0s207d7c29h19ML6hKogrwEycB?=
 =?us-ascii?Q?kvYTp2ZPSvOTanPebCUyjIm9xVvPh/Zgqbbm+4U16RdydqzVsTxt3D4t6cx4?=
 =?us-ascii?Q?X90cZ6/wTss6vzlbPW8MgpwtHJeTCIXEsAhflpxtkobO+8IGRpari42/vPOW?=
 =?us-ascii?Q?ZUscg5tBJAtZAhMKDmJq/5KAW8UuKxuBzEsLd8CwnrTHQ3mTlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 12:19:20.4926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda4c429-96c3-4cd5-eb0f-08dcaa4883d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218

From: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>

Use struct clk_parent_data to register the clock parents with the clock
framework instead of parent name.

Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
---
V1: https://lore.kernel.org/lkml/20240103072017.1646007-1-naman.trivedimanojbhai@amd.com
V1 -> V2:
- Used struct clk_parent_data instead of parent names to register clock
  parents with the clock framework
---
 drivers/clk/zynqmp/clk-gate-zynqmp.c |  8 +--
 drivers/clk/zynqmp/clk-mux-zynqmp.c  |  9 +--
 drivers/clk/zynqmp/clk-zynqmp.h      | 26 ++++-----
 drivers/clk/zynqmp/clkc.c            | 83 +++++++++++++++++++---------
 drivers/clk/zynqmp/divider.c         |  8 +--
 drivers/clk/zynqmp/pll.c             |  9 +--
 6 files changed, 89 insertions(+), 54 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
index b89e55737198..6bb9704ee1d3 100644
--- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -104,8 +104,8 @@ static const struct clk_ops zynqmp_clk_gate_ops = {
  *
  * Return: clock hardware of the registered clock gate
  */
-struct clk_hw *zynqmp_clk_register_gate(const char *name, u32 clk_id,
-					const char * const *parents,
+struct clk_hw *zynqmp_clk_register_gate(struct device_node *np, const char *name, u32 clk_id,
+					const struct clk_parent_data *parents,
 					u8 num_parents,
 					const struct clock_topology *nodes)
 {
@@ -124,7 +124,7 @@ struct clk_hw *zynqmp_clk_register_gate(const char *name, u32 clk_id,
 
 	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
 
-	init.parent_names = parents;
+	init.parent_data = parents;
 	init.num_parents = 1;
 
 	/* struct clk_gate assignments */
@@ -133,7 +133,7 @@ struct clk_hw *zynqmp_clk_register_gate(const char *name, u32 clk_id,
 	gate->clk_id = clk_id;
 
 	hw = &gate->hw;
-	ret = clk_hw_register(NULL, hw);
+	ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(gate);
 		hw = ERR_PTR(ret);
diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
index 9b5d3050b742..30daf1f77b4c 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -128,8 +128,9 @@ static inline unsigned long zynqmp_clk_map_mux_ccf_flags(
  *
  * Return: clock hardware of the registered clock mux
  */
-struct clk_hw *zynqmp_clk_register_mux(const char *name, u32 clk_id,
-				       const char * const *parents,
+struct clk_hw *zynqmp_clk_register_mux(struct device_node *np,
+				       const char *name, u32 clk_id,
+				       const struct clk_parent_data *parents,
 				       u8 num_parents,
 				       const struct clock_topology *nodes)
 {
@@ -150,14 +151,14 @@ struct clk_hw *zynqmp_clk_register_mux(const char *name, u32 clk_id,
 
 	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
 
-	init.parent_names = parents;
+	init.parent_data = parents;
 	init.num_parents = num_parents;
 	mux->flags = zynqmp_clk_map_mux_ccf_flags(nodes->type_flag);
 	mux->hw.init = &init;
 	mux->clk_id = clk_id;
 
 	hw = &mux->hw;
-	ret = clk_hw_register(NULL, hw);
+	ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(mux);
 		hw = ERR_PTR(ret);
diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
index 60cbc0674a9e..6343cfb57a4f 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -67,31 +67,31 @@ struct clock_topology {
 
 unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag);
 
-struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
-				       const char * const *parents,
+struct clk_hw *zynqmp_clk_register_pll(struct device_node *np, const char *name, u32 clk_id,
+				       const struct clk_parent_data *parents,
 				       u8 num_parents,
 				       const struct clock_topology *nodes);
 
-struct clk_hw *zynqmp_clk_register_gate(const char *name, u32 clk_id,
-					const char * const *parents,
+struct clk_hw *zynqmp_clk_register_gate(struct device_node *np, const char *name, u32 clk_id,
+					const struct clk_parent_data *parents,
 					u8 num_parents,
 					const struct clock_topology *nodes);
 
-struct clk_hw *zynqmp_clk_register_divider(const char *name,
+struct clk_hw *zynqmp_clk_register_divider(struct device_node *np, const char *name,
 					   u32 clk_id,
-					   const char * const *parents,
+					   const struct clk_parent_data *parents,
 					   u8 num_parents,
 					   const struct clock_topology *nodes);
 
-struct clk_hw *zynqmp_clk_register_mux(const char *name, u32 clk_id,
-				       const char * const *parents,
+struct clk_hw *zynqmp_clk_register_mux(struct device_node *np, const char *name, u32 clk_id,
+				       const struct clk_parent_data *parents,
 				       u8 num_parents,
 				       const struct clock_topology *nodes);
 
-struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name,
-					u32 clk_id,
-					const char * const *parents,
-					u8 num_parents,
-					const struct clock_topology *nodes);
+struct clk_hw *zynqmp_clk_register_fixed_factor(struct device_node *np, const char *name,
+						u32 clk_id,
+						const struct clk_parent_data *parents,
+						u8 num_parents,
+						const struct clock_topology *nodes);
 
 #endif
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index a91d98e238c2..b791a459280e 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -12,6 +12,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -119,11 +120,10 @@ static const char clk_type_postfix[][10] = {
 	[TYPE_PLL] = ""
 };
 
-static struct clk_hw *(* const clk_topology[]) (const char *name, u32 clk_id,
-					const char * const *parents,
-					u8 num_parents,
-					const struct clock_topology *nodes)
-					= {
+static struct clk_hw *(* const clk_topology[]) (struct device_node *np, const char *name,
+						u32 clk_id, const struct clk_parent_data *parents,
+						u8 num_parents,
+						const struct clock_topology *nodes) = {
 	[TYPE_INVALID] = NULL,
 	[TYPE_MUX] = zynqmp_clk_register_mux,
 	[TYPE_PLL] = zynqmp_clk_register_pll,
@@ -307,14 +307,16 @@ unsigned long zynqmp_clk_map_common_ccf_flags(const u32 zynqmp_flag)
  *
  * Return: clock hardware to the registered clock
  */
-struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
-					const char * const *parents,
-					u8 num_parents,
-					const struct clock_topology *nodes)
+struct clk_hw *zynqmp_clk_register_fixed_factor(struct device_node *np, const char *name,
+						u32 clk_id,
+						const struct clk_parent_data *parents,
+						u8 num_parents,
+						const struct clock_topology *nodes)
 {
 	u32 mult, div;
 	struct clk_hw *hw;
 	struct zynqmp_pm_query_data qdata = {0};
+	struct platform_device *plat_dev;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 	unsigned long flag;
@@ -331,10 +333,19 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
 
 	flag = zynqmp_clk_map_common_ccf_flags(nodes->flag);
 
-	hw = clk_hw_register_fixed_factor(NULL, name,
-					  parents[0],
-					  flag, mult,
-					  div);
+	plat_dev = of_find_device_by_node(np);
+	if (!plat_dev)
+		return NULL;
+
+	if (parents->name)
+		hw = clk_hw_register_fixed_factor(NULL, name,
+						  parents->name,
+						  flag, mult,
+						  div);
+	else
+		hw = devm_clk_hw_register_fixed_factor_index(&plat_dev->dev, name,
+							     parents->index,
+							     flag, mult, div);
 
 	return hw;
 }
@@ -543,7 +554,7 @@ static int zynqmp_clock_get_parents(u32 clk_id, struct clock_parent *parents,
  * Return: 0 on success else error+reason
  */
 static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
-				  const char **parent_list, u32 *num_parents)
+				  struct clk_parent_data *parent_list, u32 *num_parents)
 {
 	int i = 0, ret;
 	u32 total_parents = clock[clk_id].num_parents;
@@ -555,18 +566,30 @@ static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
 
 	for (i = 0; i < total_parents; i++) {
 		if (!parents[i].flag) {
-			parent_list[i] = parents[i].name;
+			ret = of_property_match_string(np, "clock-names",
+						       parents[i].name);
+			if (ret >= 0) {
+				parent_list[i].index = ret;
+			} else {
+				parent_list[i].fw_name = parents[i].name;
+				parent_list[i].name = parents[i].name;
+			}
 		} else if (parents[i].flag == PARENT_CLK_EXTERNAL) {
 			ret = of_property_match_string(np, "clock-names",
 						       parents[i].name);
-			if (ret < 0)
+			if (ret >= 0) {
+				parent_list[i].index = ret;
+			} else {
 				strcpy(parents[i].name, "dummy_name");
-			parent_list[i] = parents[i].name;
+				parent_list[i].fw_name = parents[i].name;
+				parent_list[i].name = parents[i].name;
+			}
 		} else {
 			strcat(parents[i].name,
 			       clk_type_postfix[clk_nodes[parents[i].flag - 1].
 			       type]);
-			parent_list[i] = parents[i].name;
+			parent_list[i].fw_name = parents[i].name;
+			parent_list[i].name = parents[i].name;
 		}
 	}
 
@@ -583,9 +606,9 @@ static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
  *
  * Return: Returns either clock hardware or error+reason
  */
-static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
-						   int num_parents,
-						   const char **parent_names)
+static struct clk_hw *zynqmp_register_clk_topology(struct device_node *np, int clk_id,
+						   char *clk_name, int num_parents,
+						   struct clk_parent_data *parent_names)
 {
 	int j;
 	u32 num_nodes, clk_dev_id;
@@ -612,7 +635,7 @@ static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
 		if (!clk_topology[nodes[j].type])
 			continue;
 
-		hw = (*clk_topology[nodes[j].type])(clk_out[j], clk_dev_id,
+		hw = (*clk_topology[nodes[j].type])(np, clk_out[j], clk_dev_id,
 						    parent_names,
 						    num_parents,
 						    &nodes[j]);
@@ -621,7 +644,10 @@ static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
 				     __func__,  clk_dev_id, clk_name,
 				     PTR_ERR(hw));
 
-		parent_names[0] = clk_out[j];
+		if (parent_names->fw_name) {
+			parent_names->name = clk_out[j];
+			parent_names->fw_name = clk_out[j];
+		}
 	}
 
 	for (j = 0; j < num_nodes; j++)
@@ -640,9 +666,14 @@ static int zynqmp_register_clocks(struct device_node *np)
 {
 	int ret;
 	u32 i, total_parents = 0, type = 0;
-	const char *parent_names[MAX_PARENT];
+	struct clk_parent_data *parent_names;
+
+	parent_names = kmalloc(sizeof(*parent_names) * MAX_PARENT, GFP_KERNEL);
+	if (!parent_names)
+		return -ENOMEM;
 
 	for (i = 0; i < clock_max_idx; i++) {
+		memset(parent_names, 0, sizeof(struct clk_parent_data) * MAX_PARENT);
 		char clk_name[MAX_NAME_LEN];
 
 		/* get clock name, continue to next clock if name not found */
@@ -665,7 +696,7 @@ static int zynqmp_register_clocks(struct device_node *np)
 		}
 
 		zynqmp_data->hws[i] =
-			zynqmp_register_clk_topology(i, clk_name,
+			zynqmp_register_clk_topology(np, i, clk_name,
 						     total_parents,
 						     parent_names);
 	}
@@ -677,6 +708,8 @@ static int zynqmp_register_clocks(struct device_node *np)
 			WARN_ON(1);
 		}
 	}
+
+	kfree(parent_names);
 	return 0;
 }
 
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 5a00487ae408..7c0905be2f26 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -269,9 +269,9 @@ static inline unsigned long zynqmp_clk_map_divider_ccf_flags(
  *
  * Return: clock hardware to registered clock divider
  */
-struct clk_hw *zynqmp_clk_register_divider(const char *name,
+struct clk_hw *zynqmp_clk_register_divider(struct device_node *np, const char *name,
 					   u32 clk_id,
-					   const char * const *parents,
+					   const struct clk_parent_data *parents,
 					   u8 num_parents,
 					   const struct clock_topology *nodes)
 {
@@ -293,7 +293,7 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 
 	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
 
-	init.parent_names = parents;
+	init.parent_data = parents;
 	init.num_parents = 1;
 
 	/* struct clk_divider assignments */
@@ -311,7 +311,7 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 	div->max_div = zynqmp_clk_get_max_divisor(clk_id, nodes->type);
 
 	hw = &div->hw;
-	ret = clk_hw_register(NULL, hw);
+	ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(div);
 		hw = ERR_PTR(ret);
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 7411a7fd50ac..4bd93efed9f2 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -309,8 +309,9 @@ static const struct clk_ops zynqmp_pll_ops = {
  *
  * Return: clock hardware to the registered clock
  */
-struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
-				       const char * const *parents,
+struct clk_hw *zynqmp_clk_register_pll(struct device_node *np,
+				       const char *name, u32 clk_id,
+				       const struct clk_parent_data *parents,
 				       u8 num_parents,
 				       const struct clock_topology *nodes)
 {
@@ -324,7 +325,7 @@ struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
 
 	init.flags = zynqmp_clk_map_common_ccf_flags(nodes->flag);
 
-	init.parent_names = parents;
+	init.parent_data = parents;
 	init.num_parents = 1;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
@@ -335,7 +336,7 @@ struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
 	pll->clk_id = clk_id;
 
 	hw = &pll->hw;
-	ret = clk_hw_register(NULL, hw);
+	ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(pll);
 		return ERR_PTR(ret);
-- 
2.25.1


