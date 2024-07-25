Return-Path: <linux-kernel+bounces-262075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250393C07A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6244B20FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F21990DE;
	Thu, 25 Jul 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5fGXOppS"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3B7CF16
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905038; cv=fail; b=oYYC+ooZTUlftBSJG3C2aDQwsbWUtHvkU7sxR6GR+ZZ7Ry1oTlYmN9A2LMNdOHCTCApTufLFZxn1hckYeFg7E8Q/NOvm4cRViy7ZSYXYSeWZvjBYmJ4bUo4aKWzVv6ur6Zh0ay8SakTLHZijCN7m5BkdUTnPChS05Sf+95HmZks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905038; c=relaxed/simple;
	bh=tN8XSXudxkJEmv8hguRu3zr7BP4AeyOAHMFhEk6KQTU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IHhT9rrYPrP801dBHjFlPyfiyoWhr1uQqey5o86d0T7lGsE0ZNRf5mFekbVRxUgF9G6EYwVp/DLKMa2ovJc3xCdU/7GqwjLAnh6dC3c+NdknUCbeVICxXdSZRvhmsCm9PPi3Xvi2hl5ckYzE2i1HSj2tR/JCNnPBxmPniVyqg1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5fGXOppS; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DX9d6gV4urvEfJitsw3FY6R1rscA9jlmCRZDgUw7hgBs8sc55jD6Zqhyp2+zuyGFBY0W6rF9v8neExrKHbZp7K8rfI3kS/hqy265cyu849jv5NExCruvQs/GBWZxyr655BZdpi46FvwzYQoUMWyoX50Ce0i879deAu7i7kXxobzi4HJk2o7TER4K7dry8jtwQo3qcqaiXzGL6PxuvmSxUCJnU6aTdqoysakojyG9rrI7eB6o6+hrc9Y1anQWRg2e0fv4m7cqFwVsVjpipU+GhXxeAnM+9WQcym8Nok81/ZfsiKbs7B0V0vrpj+SaYsuH8L2Ak6+HzaCytgCo8ezt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF44TkvbQjejf4C0rmC8LLHrtpXhCjEZR7KxT/EdJWk=;
 b=Emxv+/ecKbMWnzo5bosVGvywD6dC28ucGEUKcBvZYOVik5RHVyEoCwRd8ZC7Z/s5MWsx8dUCQj3EHzK2fcx6gDsyax/rK67qBIbQE7yHO5K7rYAYZAB3VfrKJIgR2mJFkY6RsLNFgkuQGoAcEzhaa/+RKYr7xGdf1pmg5rbJq3wl0Zv72ckR7SvNMAkHNXgtYbMtUvEc7ytUlielnf6E6CIMTGWw2XJBtaD+VMwqyDY7LBbZLsqYJAwmPVZ23RRcZEodiC3dzlajcYOXAoltRYmvHpSQ2B+28QUZCwNEf7+HlFRGoPm37mm4zCj2dnE47DAtxQVZUyM1K4J2KsmvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF44TkvbQjejf4C0rmC8LLHrtpXhCjEZR7KxT/EdJWk=;
 b=5fGXOppSMLMViCYpV3W7MAMrcc8lrP2z9TBpJbIOIrZMTF9c4GzmHg5vm7hk3zATDecKf8w/neP3NsFWn19mhLm9wTdRA7IwGdQb52h4iUm8HzWUvRgzFGEzOaOcSzES9r7kpIttDlCBU9G5Ox38e5sxc0pSONbwCbKWG68FoAo=
Received: from MN0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::31)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 10:57:13 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::dd) by MN0P220CA0002.outlook.office365.com
 (2603:10b6:208:52e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 10:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 10:57:12 +0000
Received: from BLR-L-SHIVAGAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 05:57:09 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <vbabka@suse.cz>, <hillf.zj@alibaba-inc.com>,
	<mgorman@techsingularity.net>, <hannes@cmpxchg.org>, <shivankg@amd.com>
Subject: [PATCH] mm/vmstat: Fix placement of per-node stats in /proc/zoneinfo
Date: Thu, 25 Jul 2024 16:26:26 +0530
Message-ID: <20240725105626.824-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: be345bad-2640-4e88-65ad-08dcac9889dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ix4YwE59UCITS1WdiVfv0yvV0fKh0zD+gY6cHzsapG2gx8Wdg4QKkBmozLXg?=
 =?us-ascii?Q?/osVK3vble+xZSgf/D7xgOs+jRY+pVloE8zisJADyTghPD+xsiAoF8KSHzTG?=
 =?us-ascii?Q?6XTAhiLudb/4f/ebE4B1lfaze3QAJXUxeUMPWDN0QNGBKrpZi3fO6I+tT5Li?=
 =?us-ascii?Q?j+Vly+YPDNj+DhjMxf4gjzYiKjUk2ukiMN5HRkC5d4rMwctx9T7+Xe/MUL/y?=
 =?us-ascii?Q?VUES8/N0Hi6nSKu394VOx9vWLegYNcUmM61p/3tX62i79lopOeQL9RZBUjgG?=
 =?us-ascii?Q?djdpQ6K2RpRU1eHZ2t+oj8tuDJaP2Kf1SkVHjGAcii3R/5V3mXv2/Gx71on1?=
 =?us-ascii?Q?jjjOM4jHnPi94t5zvDiDZzradfl2YRaUm3c+/D2fbXq7T1Vc2RNa52/VZ+ie?=
 =?us-ascii?Q?V0JFbTyO+e6m4fxFdk2ONe8xZ8FAhT+MT7gkXrXH2QJU2/WtoHztn4ILosA/?=
 =?us-ascii?Q?bUbZ43Dr4bdquVnHzXXpg0g9z+1ZidztYvuDhdbvsSlt60h5/R+T+Q9zW2Vx?=
 =?us-ascii?Q?Q9NmEIvLTZgNeQd9psuDFiG4dqKu498bwRU7oG8iYTyhTeV/SnC6mmeI4aO0?=
 =?us-ascii?Q?HGyVz0NepowaER7ZddvXFVPwkIlu5qG1eeECbL9aHLZPoJ78pproXUI+LPxc?=
 =?us-ascii?Q?feAriotnY3eLOQF8MsNyYWzGSHrb33VWCfflvWE4Tdx7CKVRgf2kjqAvFTsC?=
 =?us-ascii?Q?hHIMWHXVKF7DKL2zqlQHtTFK/tEnMq6dXLXDUXE7snyRNMGv8HfNUmA+G7dO?=
 =?us-ascii?Q?sXYS/KhKpfQWgsVt8gLO+7b0zf+2AuqoZm5+kBmK5Crb8rWsjxyBqgUD8w6y?=
 =?us-ascii?Q?bkupWxu3N/Ot/hYl8aof1mZ0ChmETgan0fwFN+R9tSYdm0lTeBcfW0+VNIFZ?=
 =?us-ascii?Q?QyA76Q6FV4fDVTze3SGnz9TqQv728I1XRnz+lAgklLrfdGZluO7SbUHzyNAt?=
 =?us-ascii?Q?ctsHJkeEoJns8IBr44o90AiGe1b8qt/4OIU6WcGK+bikRs77pWwcDds+PTQO?=
 =?us-ascii?Q?xJwdc9DQx/7tXF+Q9evuWf7eXCyM70IrtKIB+CgiOroZxBCsF7cebUDW5AXE?=
 =?us-ascii?Q?eLoIrtYafyyTq5x6hUDyx/mX5ESCNQlroUHWOGMecEDNERubY9hDb+VKfVJa?=
 =?us-ascii?Q?1b8g4i88TM9ep79+WZN4cK9IxkRnDt2RtLVqKflF94ba13n9o/zPPzc0sphU?=
 =?us-ascii?Q?rFvnL2w/kIRCorXk5bMO703fbX4a2q9I3ZymLOn+sMUarf1Lpgz8pY6jY1MV?=
 =?us-ascii?Q?au6m/C22aLhXve1HOTeWmPtsFNF6DrORSfBb0oC9nrr7HehnSVybeE0oqQJD?=
 =?us-ascii?Q?YUCcEJVE4V8fOBmK1TdttsnZg8J33Mvr9y9dx7MGEumSnYfzMjwcimBqE4zv?=
 =?us-ascii?Q?BWegvoib23cIk0pe6gTfPa9xfJpUZLe++212NfKwFQA/u6BpAI3jLBPCLTi8?=
 =?us-ascii?Q?9JN+Egf4v5wDiALf1X1WyoXLJrDPwTBn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 10:57:12.6915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be345bad-2640-4e88-65ad-08dcac9889dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

The per-node stats in /proc/zoneinfo output are incorrectly inserted
between the first populated zone title and its specific stats. This
creates confusion while reading or parsing its output.

Output of /proc/zoneinfo

Node 0, zone      DMA
  per-node stats
      nr_inactive_anon 2096
...
  pages free     2814
        boost    0
...
      nr_free_pages 2814
...
Node 0, zone    DMA32
  pages free     357384
        boost    0
...
...
Node 1, zone   Normal
  per-node stats
      nr_inactive_anon 87606
...
  pages free     51836334
        boost    0
...
Node 1, zone  Movable
  pages free     0
        boost    0

This patch relocates the per-node stats at the beginning for each node,
followed by the individual zone statistics. This fix results in a clearer
and more consistent output format.

/proc/zoneinfo output with proposed fix:

Node 0, per-node stats
      nr_inactive_anon 2783
      nr_active_anon 36
...
Node 0, zone      DMA
  pages free     3584
        boost    0
        min      46
...
...

Remove is_zone_first_populated() as it is not used anywhere else.

Fixes: e2ecc8a79ed4 ("mm, vmstat: print node-based stats in zoneinfo file")
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/vmstat.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8507c497218b..1b32fab265e1 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1663,36 +1663,11 @@ static const struct seq_operations pagetypeinfo_op = {
 	.show	= pagetypeinfo_show,
 };
 
-static bool is_zone_first_populated(pg_data_t *pgdat, struct zone *zone)
-{
-	int zid;
-
-	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
-		struct zone *compare = &pgdat->node_zones[zid];
-
-		if (populated_zone(compare))
-			return zone == compare;
-	}
-
-	return false;
-}
-
 static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 							struct zone *zone)
 {
 	int i;
 	seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
-	if (is_zone_first_populated(pgdat, zone)) {
-		seq_printf(m, "\n  per-node stats");
-		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			unsigned long pages = node_page_state_pages(pgdat, i);
-
-			if (vmstat_item_print_in_thp(i))
-				pages /= HPAGE_PMD_NR;
-			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
-				   pages);
-		}
-	}
 	seq_printf(m,
 		   "\n  pages free     %lu"
 		   "\n        boost    %lu"
@@ -1773,7 +1748,18 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
  */
 static int zoneinfo_show(struct seq_file *m, void *arg)
 {
+	int i;
 	pg_data_t *pgdat = (pg_data_t *)arg;
+
+	seq_printf(m, "Node %d, per-node stats", pgdat->node_id);
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		unsigned long pages = node_page_state_pages(pgdat, i);
+
+		if (vmstat_item_print_in_thp(i))
+			pages /= HPAGE_PMD_NR;
+		seq_printf(m, "\n      %-12s %lu", node_stat_name(i), pages);
+	}
+	seq_putc(m, '\n');
 	walk_zones_in_node(m, pgdat, false, false, zoneinfo_show_print);
 	return 0;
 }
-- 
2.34.1


