Return-Path: <linux-kernel+bounces-280459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7377794CAE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BF01F260E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F4E16D317;
	Fri,  9 Aug 2024 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2K2N4DdF"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B42905
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723186958; cv=fail; b=ij702c89Za/vYUOq+9uobLKWfSRbjVBJZ0VNrljr7ghd6rEJGUZ3P2v/7R11u33e8y9ydmSFIEgrfmI/8t/m3GrslgYsZ2X2Lp3EmoalcLzQR24WUpSZ01SiKFq6hPUbWH0bAFVcLLnO9uAjha/SH1AGIG8N/DZji4pT5PZPTY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723186958; c=relaxed/simple;
	bh=PzIX03s7Fcj+Dqoit+ClUnm9ZWoPRv4SwZ8IVLb0aEY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aZQGHJ3MCkDFRudn9N7HfotGpYM4iRPLiBjEBzQAYQiYLd8vEC43Z4LGPiiBXyNTGmmT/gczAqaRxVxAsXE3AWKooUBun9ye7mk+Huf8yem2awTC7706/G28IEWbkx0f2acE/LS6oYa5Vj0UrWHufPkHbX7dJ0YaLv3IRYynWGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2K2N4DdF; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=db7s+QNE3iVl30t4d7x6WbRvZfQyZg1rznlSDwsSrCYkcRkqW7uTHHVO6dw6b6Qs7lkg98bilOWK18aLid926o0JA13wgvpfc0TU3uMf5Ck4AQQxBsXiIZWtccxFidtHdKJs+hvNNaHbIg5uYgDHMv2sHCF/JKzA6K+0hj360+sWePnFO7jivdlIO0ZW18iT8fVErppi1sXt3nv3l6OfSjRs65JmmqYEu2S1vR06jYoTXj3t1D5+RTQbvGuYK7j15wo1er6qdy/of+xtGEp/qP8hpqFRig6docweLvKzG2IZe7ZJq6mavBqfUgF+j1OETVW3Ni8sunoAhc5wPmHrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9ABY4WcgGtyrCiAZVFNiMwtw0Ldm5nr5WqR1vLi4Ps=;
 b=tIpEeaGHD8dCoE000XETJStssceWURWkKne4ZCcRNAsNhaJIOZKpoK3vS4cusVWMO0a7izKqjOA/0hpn/ksYU7Qdhy/hTquZtDjHWPFNc0qAYKmMxN+MQDbFHIBKj0gy2LWWwj9XDfLNX1hOIlFl0Ok7bM4UgWu1cBo9WQnOhi2QkPnoNOZ5Fv7SYIsa+/PO4EoOZF6qhKIyv+nDk3c6AbKwvCHnLVWh6MiItTUnAn7koHaRdAaK4aA5rvfvDkNjZrnmE+n5YGm9yaJ3Q5LEShSIy5HEeYrGmz6OUMqaLRO8NUUqcNTS8OFI9B6dZPavXSDUagYnEDyaJsaTQKUVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9ABY4WcgGtyrCiAZVFNiMwtw0Ldm5nr5WqR1vLi4Ps=;
 b=2K2N4DdF9E1DuLVy874FXnsTt+f+Z3GUiPYyO+p/SskslTVM3bHvloKKFJndoL+sXsgy3a1Vsr57Mst60juElOLwrIVu2a6hKhu+L+/qnZQ+H6B0WivSbWqJLJDNKd+BaYhhdYBriB6jaoo43RpS4Ym23atLOvQQOBAGDYyZ1E8=
Received: from BN9PR03CA0893.namprd03.prod.outlook.com (2603:10b6:408:13c::28)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 07:02:32 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::9f) by BN9PR03CA0893.outlook.office365.com
 (2603:10b6:408:13c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Fri, 9 Aug 2024 07:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 07:02:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 02:02:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 02:02:31 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 9 Aug 2024 02:02:29 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <tglx@linutronix.de>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2] irqchip/xilinx: Fix shift out of bounds
Date: Fri, 9 Aug 2024 12:32:24 +0530
Message-ID: <1723186944-3571957-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a66f07-cf7f-4c0f-348f-08dcb8413d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eexP+5668jfOwAr39ZsvhOaf9JFZnAFRYXjMPhFg9ziJwnoA5l9XJpj7lvCf?=
 =?us-ascii?Q?AxRP3Knu1vLEYv2FvbhcZioLWdtsY2o7d/nwtH9YjCtjT/MBXEk3Na5xjyDh?=
 =?us-ascii?Q?brig1AFW90sgFfzt89uG8mQHT2USElYfBpAd1tCO9Dh8VVnQK9k06Pec5hk0?=
 =?us-ascii?Q?VmDLU+NmSdy6+9x6SLXlpi5rmUhDCjKsVPRw348SWwGQY0Oah5yoYb+xG2M/?=
 =?us-ascii?Q?uwI+eFY7Z8WBOii2fRu4wzACouAy7J/l4xSVYXnPJrSCIZswv8dyvT2QFq65?=
 =?us-ascii?Q?vUlGuTQXUp7VVLk+ffVseU5RBSXXNJW3Z6lMhUsAku7vRFbwJNgdhvTfCqRp?=
 =?us-ascii?Q?Q5NitTqiXHmzQO77vGkIillzL63XLRbEhihCtciDkFWKj+yTNE5pXeb6lVmB?=
 =?us-ascii?Q?8qubaeVnSBhjWUguCVDcF/5IruUzGAUjrv9HSugqWdTNCrOwF0gSoh7JEpc+?=
 =?us-ascii?Q?K0CSg+JQZF0e2zaZqTUdyOBtZ/AXQOXLmmtvqiPTTNLgHP+X/hxmu0VbsRde?=
 =?us-ascii?Q?3lBnW9rjRPHUfi9TQbDYg99NONfAYn9vpb7W9QhzMJBdUotW52HC0x8rcMks?=
 =?us-ascii?Q?eB+BhghBudGRZ5RFr3hvoF8yNy9VRzPHoxI17FXt3Bdi7eW8wrTMkXnGNOL2?=
 =?us-ascii?Q?KwaWFyisB88CAFbffKdG3FbSkxpRtB0zggsm357kAv1k+/rx5t5anTmXoFUP?=
 =?us-ascii?Q?sSYGwJBNOSRi2D3AM2bzrou/OfctZmV1LQSVbfDMwlukqCSiolfRGAxQYK97?=
 =?us-ascii?Q?F2TOG3vwbrPLVQtR4T5G93sw6IcnqQlkZeLeM2zXMoVLoCyRf3VR+METCew8?=
 =?us-ascii?Q?SJzgTZsWBuxwwlbXvAS5jNBf9X9G8JiVpIghXeJD5y2tEkFCX7bEHC4ySVHa?=
 =?us-ascii?Q?6arMpnkIWM525gfknZVYV5+9B31IpH2Ute2Fzp9m2nYIhShuIOxhu37QZtKx?=
 =?us-ascii?Q?BfS8POfK7UFCoMWfj9h+6IwG1z9VxKj8eS+q7eC5XehvTfl8WHnC1Wmz/ezJ?=
 =?us-ascii?Q?NPwQZYAGOAP5ARg5Zf8L8qE/JvwDhle3xUiTI0Iqe1/ccrSCkEPSXFl0Sw/w?=
 =?us-ascii?Q?/n78HZFkKph5ehF7m/lYI/kw0g8v6qUFSjuCBEA/S+EMsw1jct6lqtbXdkQ7?=
 =?us-ascii?Q?C5G5P7sX7j6Kfdf1kU5Q0hD1cXK/hX4ejVO5Zt8bOW8n6HLpuicRWrwuxMmZ?=
 =?us-ascii?Q?slQgkYLTobBN1dXItsEg+c0iaF1LPDC7iPrMrEZOpQXyQpW73BWWjzXg1jX5?=
 =?us-ascii?Q?uJ/m2HNw8o9JgYW8F4XRUO0mhTbdg0CHHCezS/5w9sjwZxcPE4Fcc/ZwUErs?=
 =?us-ascii?Q?EShx53fYD/dRwIpG3vLXnWMJtatHjbgzkS/iOU5VSJkH6DpakTa4ozYm0crx?=
 =?us-ascii?Q?KDWXdbs31X+/fHX4gt2Bd6jVl/hCU4qXH6tSUxzRiGgo18GStWwdT630ztaU?=
 =?us-ascii?Q?KxWxyC+Qhy0kqkLsxCttnLUbWAetBVVv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 07:02:32.0754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a66f07-cf7f-4c0f-348f-08dcb8413d6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

The device tree property 'xlnx,kind-of-intr' sanity checked that
the bitmask contains only set bits which are in the range of the
number of interrupts supported by the controller.

The check is done by shifting the mask right by the number of
supported interrupts and checking the result for zero.

The data type of the mask is u32 and the number of supported
interrupts is up to 32. In case of 32 interrupts the shift is out of
bounds, resulting in a mismatch warning. The out of bounds condition
is also reported by UBSAN.

UBSAN: shift-out-of-bounds in irq-xilinx-intc.c:332:22
shift exponent 32 is too large for 32-bit type 'unsigned int'

Fix it by promoting the mask to u64 for the test.

Fixes: d50466c90724 ("microblaze: intc: Refactor DT sanity check")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
Rephrase one line summary and commit description as suggested by
Thomas Gleixner.
---
 drivers/irqchip/irq-xilinx-intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 238d3d344949..7e08714d507f 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -189,7 +189,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		irqc->intr_mask = 0;
 	}
 
-	if (irqc->intr_mask >> irqc->nr_irq)
+	if ((u64)irqc->intr_mask >> irqc->nr_irq)
 		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
 
 	pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",

base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
-- 
2.34.1


