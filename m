Return-Path: <linux-kernel+bounces-448969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF89F47D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473E9164354
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96DD1DED7B;
	Tue, 17 Dec 2024 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mdQB5MjH"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014D1DF992
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428555; cv=fail; b=tcDYT9rsyR7CFb0EIjLTOz6z54lgrujM0jQmiQBOBphySUNS/hvhIl01i5TJTbFK7W05Onp6kbjO7VIc/cHxbSwvpiH618/AcP7WVqSpsHpsW5wSK6yO/449ZQFUcf/dmmAGo04NHMJoMF5WgLVx3s/6SD0R6w4JPVscMFAyxuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428555; c=relaxed/simple;
	bh=odw/HPAZswGEU40bPV3UVzJf/2tGjclPlv+rw5+rPUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIKuO3WORfwAy0F2a6VK/vQJtDdzr2DGu4vmK54GgrG0rREEJ7ZCLSmuOh/G+s+npV6IOaXoqfssrUkZTFMUkk3ST106Li9IWA/JEYltit9LwNbwE9xgxJIrTlkI56yFHCADSVfof9eEnkoCFuZa8Pt+XliEcLoPQlID3cEhloA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mdQB5MjH; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5fHt16UXOe9IHyJ7+GUCMSylOdrXSBhJZC4yqNebpmkTwinsvS1d8NdotC3ltMmkBlRZHlhWt+8ua9E7r1SJSMUB+PzIF17lk76gyLIVEjTZMPT77E3Rn89Esn3ZQFPwhUsccIP3ujCZ6qkJR2+tDd4gJo7uh9Qq2DISIdTjkl/oH/dgXBtEhMN215yq11Vuj4sM9ixQzAN3VpXOxtW6yNnOWbF7ePwBQSrdCRx7loMRrEzOZR212FO+Kiry70Ang7coL9yBGBisqJt53lwCRHH1UV8emTnQeRWUB3vtg/xygv92utkdq5n8w0hC7WMrSUige3s7QtYta1uMveIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptmMPOPSmNZKUX90DVleF9dtQEOgsJ5/dUFzySoInSY=;
 b=fjAgUbhwS+HPPbgyjSlh874gHM+37MPhiTS14sIv4wNQ73yrzreKIC52yyaToAwF5nmt7gm/kaQKVk3dsl5ZoRzDTWjI5nQX1i+oG90mLghW4nLq8TiQkgVQvOe1TiNPJy1Wt1A/xykXzDZc4+knx7aDj7Flq1rAhwltlLYXDQWtcWDHBUjkFvNcUnaNXldFLPuTSgVRnc+5tZQh2sLNBqlzTzfPDiBJFTvXx1BE2a7/nupEq7ATzPAhblHLLYr1WEhDduFagd9jk9GQFiA+2DSEbx4xpXxKorYpPppRcbsdFptMn8pvDfHhOzq7MXnMAx3d6vY64lc98XzpDSJFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptmMPOPSmNZKUX90DVleF9dtQEOgsJ5/dUFzySoInSY=;
 b=mdQB5MjHCIpnOICehee6WlNY92uC1bhS5HHwti+6e/FYwoDrUJajJVX8rtNgvt6eeb4Fz0l7vsw7XkuMJvyzNdSxY3FInbX7lL+OWu/r8gOeope+myTt/8Ibn5Wgyq0K0fCkBwfC0Rtxg6271zJyGmZoJPIYx6RAT27BoXIfqKA7OSAS3qt1pBjS1AQxqjVGf661SaisBpo4xxl+D7tcLJ79XGMBnci8MP7LqOVJe5LTf5SiDNEzyVUtBmX7DBmnFgRuBs3ANAfXynI9wqR57nkCnkqUtl31c8JP1ALo3SqOuG1AimlXk4zcMaxjF5rmVBd7XUVWDGznBobqNCC8nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 09:42:31 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:42:31 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] sched_ext: Introduce per-node idle cpumasks
Date: Tue, 17 Dec 2024 10:32:28 +0100
Message-ID: <20241217094156.577262-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217094156.577262-1-arighi@nvidia.com>
References: <20241217094156.577262-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe0da36-149a-4c07-abc8-08dd1e7f206d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G7S8N3iP453eY6syfBbDJlMUXhaZl7rU4kH8cN1E6/2brjiHdozMrb3zaOHD?=
 =?us-ascii?Q?c266Wqhde2EJKaZ2Sp8zOLjNMDuJTRWiolP1sK8vCyomVrWA5fwbYMo/THeM?=
 =?us-ascii?Q?ZJ94bjwr4927qmIhry3Iz5DeRieD3jUMf4g3i7Avkb5BS61vYvk4gZo8m2Bq?=
 =?us-ascii?Q?QHlPXl3r83zyA/C8JUMWNZRPI/pcWb59X4ag+R4cELiD7XWJLIkucRuLN0mD?=
 =?us-ascii?Q?MSfxGFasZKDbiYvsnEQ2p4MXHwheYLqJ5nu51BnpQYPzyGLNzpL+OhOC2FIY?=
 =?us-ascii?Q?HIXifVu84Z8Mgy04d1Es8iffoQl+9nCdwbACsHn8RSVQxi7P5uuHn3HlerRb?=
 =?us-ascii?Q?AFv8H9WKSqgLB8utONXdjJFz20DjZPlNJkVzFv3dLKd8Zv05l+/1Gx97xwLc?=
 =?us-ascii?Q?m+Ltdd+c/HLtOoY20pIYLNaeBgKJ9r8AqRz8mR79E3NxOAyts6aNZNla9cMV?=
 =?us-ascii?Q?/waboxagkvfQ5+8WOwfRQYc0lLA/eLYbYOpoUhc0Ee39R5EdwUFZG8dUB8lC?=
 =?us-ascii?Q?Nuk50lStdkokgTRlxZCKwwt8ToHrw/SURhohYq4EOVN74BQGRU1e5uIGRHLl?=
 =?us-ascii?Q?hpAcZHkR+PQ73tUGBG8s4LIsctQzaQm7bd5V+JzJwGMrLFGp0QXwrN4bphdB?=
 =?us-ascii?Q?moojO2jIpSXPhp2Mwqm/kjuO5UIRaC8ZPSzsOW7S/TKrbwQDBTauAZTFjEPu?=
 =?us-ascii?Q?WJ/2jfPwukxjITD32YQ/zKw8uhxm7LOS/WzL30XJeZQPceC846vjQWHngzEO?=
 =?us-ascii?Q?7YuzuS0bTBW3lQEskMrYhvMwo2ggYRhTD8EVvxU2vO+gwsnpsrluHASZXdHh?=
 =?us-ascii?Q?zwVevDm5FfThJeVqQBh+ZrE9t+JuRqjj/asHhXAadz5P5Ggl9djDJa+lT2GS?=
 =?us-ascii?Q?H/0oxi2pa74sCQbm0fV09OWg/sDr3F640e5lDgsJvPghzjJDcmRYmPA35bZp?=
 =?us-ascii?Q?yupFrv772lmVCk3u1kEtRpzhpHKfNW4fU/zLxzHbBXraZCK9q1XoEgtLKTLB?=
 =?us-ascii?Q?jEbEhaVPI+P5+irfMZswyrEVKqs+gM0n+B+4DLmPL7jbvspXOUC2K5BnnrLk?=
 =?us-ascii?Q?E7zh0QBNIP4d90LkTRy4w9o/TtR53atIQJqbZAZnxViokWoMSKhcY8GI6K8u?=
 =?us-ascii?Q?bShPIjumK2YoqB4kmHs3OauUgkrdkaePHV8el5wc63TaNmXr4DxcwZK7GZt3?=
 =?us-ascii?Q?cqbwmZNZ5/rc+zx7Am9pKecgqoYBWc3eRbz/T66Nn0RLpXmNxGYy7sjWh5Xz?=
 =?us-ascii?Q?Sl4c/v4wfDx5Lu/TEjL/ipIf2x+KA1vPU9F3UFIh/x+Uctge2wtSxKeLVXrq?=
 =?us-ascii?Q?8uvOHyToNxQPUWDbTY9pJkadFiW6LjmCdMg7LNyHkru/8RjowGqJmmmotna5?=
 =?us-ascii?Q?9i/mx/82G35UHGDzovWuNVFMg3KT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fRoDAFR/1RetPBZwi51KD5SxokHmh4YGgNJMNFBvqDGfNqxYcthnak640KA?=
 =?us-ascii?Q?Sp3b8LcnhZL28vjxj7uTlY3M3HphbayCXhF/p3eZ3mivd3Aba78s4oNQNHMl?=
 =?us-ascii?Q?YXyosXA2sypRcY3bjPqPWNfKsRlLkqRykF6wI0hZqQ3FFFHKJfKfAO50Ab+H?=
 =?us-ascii?Q?TfV6Tv/kEnirniK/rg5ZJmHLVlFkk/3zWiaFV+e/6iIXQzoz4rHOvyLVlmKN?=
 =?us-ascii?Q?X4P4MB0Gh6EjnPmAhC96yBVjDQNvVUz1BBOjAlJ5oYxUPjVB4CecFGGFO87A?=
 =?us-ascii?Q?B+GFNz03H7ztzksRYE6FL5Ebi91GZkTpI6UpyzuUD6lkufmi3L5w6ToDDPB8?=
 =?us-ascii?Q?SuMmyzELn7xjy0hJ5TG82GNa5661HcR0pwr3Rbn7EXqM8L+RaauNV5Oa10x2?=
 =?us-ascii?Q?/cLB8jDZbSU/8apM4JNCOUyjA2WQPoQZcpxFJcDi0cwBIQedNyVN74m3ghww?=
 =?us-ascii?Q?BMKksY+hk4vSxU5+1/771IzRtpOriPVe0gTktSKrPLOnAOie1wk+jtEJFBI5?=
 =?us-ascii?Q?uFEIFLSYCPq6eKw1tlnP0dOvOfIlNMJm+YxfEhSL+ABkaoPAsRwhEcbuA6wI?=
 =?us-ascii?Q?59kKTCRrthdyVl1X7V+9jq+q2Zx5/wZlMo5aMOTKyj9J+2MiBtwrrs+4RUNg?=
 =?us-ascii?Q?oFs4/DpVvNRpbugSRVi43k/2V7ElJ6whvOYinS5wDg/gZCNQnHFJ8UzyktZS?=
 =?us-ascii?Q?CNUNqmwiPkK0mG3kghtw/sHYs8C+ZgwU8YXLrEnBcoJgQqcG5Bu92jXWse6b?=
 =?us-ascii?Q?n6VaWwG6I2y+aD0Xeh+5yBXxVuImu54hxV4M3QlWHRRXWN69oBXXhMUrrGi2?=
 =?us-ascii?Q?iA3t3zCm9Ng1JKZkQJ3d6WcUQRDTWc++qAo1wCfsqUywdq2NLmZfuTHPZhxl?=
 =?us-ascii?Q?aDKct0P2WhqDqTtuY9PvAoBGg5b29M7C+Iqjz8R+80ic0XLpubpE9aIxdixb?=
 =?us-ascii?Q?9VabTwvP3z1UMZW1E5V9R578otPN1LfkWAACvdXSGURe3UuZ3JT6c6SpZH2q?=
 =?us-ascii?Q?ABHYVByYrbagpKYzfmC3xI6EZUi3cFt9FISytumENDsYCbSf05DcXnO2cdEt?=
 =?us-ascii?Q?UrOM58DC8oPdRQSMEXZHyHxvuZV2uFLxvYQN85+yVUG+vptkkGl+gDqwMJ04?=
 =?us-ascii?Q?fG1lJaDOCSuu4yN9wwGVBR1pnaKxGRlFk1u/rqunxiG1te5tEIYtPm1+QKvY?=
 =?us-ascii?Q?5NAj32abCEuURKPsVmC6DZH0Kpk1YiqpI0uXxUv+OC/pdh0P06KQQavtgpUb?=
 =?us-ascii?Q?BaliID5oMkgLCl3Q4+a+inPpJyiYEFn1jZBb6py0P90hWRJ4bBVmkvKHZztI?=
 =?us-ascii?Q?DAR4EVpWXmLFmtAYLjNCY7tDvo9HJxSIECTHmmJ0UTHStTLCqDdD8Xmp1cpJ?=
 =?us-ascii?Q?sCXfooS/FmUTdxrUm+pm4MTRkNBAgoPs08AThoQTwexabp0gDTv3I7c5GLTF?=
 =?us-ascii?Q?My8rU6t4XQlZp268I6Spd63n92rEujMlrX+TD16tKiweakW3Q+qro1itAR8e?=
 =?us-ascii?Q?0zIg2mUm87Y9Wzl6nhXIZCd6OvSIovW68WRnIogVmnkhKRfBfeYDD7v608o3?=
 =?us-ascii?Q?dzn4TdNRIPiIs/cSclgrEstKTA3TnhULx5d/Pwax?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe0da36-149a-4c07-abc8-08dd1e7f206d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:42:31.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKm0+8+yZky1vWjsJVJKIoUfn6NRv6YUWx2xhWj3q4olerDmHBU092BoEnpo5F6UF7z6az9jMpRslFLz1AlwrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

Using a single global idle mask can lead to inefficiencies and a lot of
stress on the cache coherency protocol on large systems with multiple
NUMA nodes, since all the CPUs can create a really intense read/write
activity on the single global cpumask.

Therefore, split the global cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on large systems.

The concept is that each cpumask will track only the idle CPUs within
its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
In this way concurrent access to the idle cpumask will be restricted
within each NUMA node.

NOTE: with per-node idle cpumasks enabled scx_bpf_get_idle_cpu/smtmask()
are returning the cpumask of the current NUMA node, instead of a single
cpumask for all the CPUs.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 281 +++++++++++++++++++++++++++++++++------------
 1 file changed, 209 insertions(+), 72 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a17abd2df4d4..d4666db4a212 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -894,6 +894,7 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 #endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -937,11 +938,82 @@ static struct delayed_work scx_watchdog_work;
 #define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
 #endif
 
-static struct {
+struct idle_cpumask {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+};
+
+/*
+ * Make sure a NUMA node is in a valid range.
+ */
+static int validate_node(int node)
+{
+	/* If no node is specified, return the current one */
+	if (node == NUMA_NO_NODE)
+		return numa_node_id();
+
+	/* Make sure node is in the range of possible nodes */
+	if (node < 0 || node >= num_possible_nodes())
+		return -EINVAL;
+
+	return node;
+}
+
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
+ * from node 0 is used to track all idle CPUs system-wide.
+ */
+static struct idle_cpumask **idle_masks CL_ALIGNED_IF_ONSTACK;
+
+static struct cpumask *get_idle_mask_node(int node, bool smt)
+{
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return smt ? idle_masks[0]->smt : idle_masks[0]->cpu;
+
+	node = validate_node(node);
+	if (node < 0)
+		return cpu_none_mask;
+
+	return smt ? idle_masks[node]->smt : idle_masks[node]->cpu;
+}
+
+static struct cpumask *get_idle_cpumask_node(int node)
+{
+	return get_idle_mask_node(node, false);
+}
+
+static struct cpumask *get_idle_smtmask_node(int node)
+{
+	return get_idle_mask_node(node, true);
+}
+
+static void idle_masks_init(void)
+{
+	int node;
+
+	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
+	BUG_ON(!idle_masks);
+
+	for_each_node_state(node, N_POSSIBLE) {
+		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
+		BUG_ON(!idle_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
+	}
+}
+#else	/* !CONFIG_SMP */
+static struct cpumask *get_idle_cpumask_node(int node)
+{
+	return cpu_none_mask;
+}
 
+static struct cpumask *get_idle_smtmask_node(int node)
+{
+	return cpu_none_mask;
+}
 #endif	/* CONFIG_SMP */
 
 /* for %SCX_KICK_WAIT */
@@ -3173,6 +3245,9 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 static bool test_and_clear_cpu_idle(int cpu)
 {
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
@@ -3181,29 +3256,34 @@ static bool test_and_clear_cpu_idle(int cpu)
 	 */
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
 
 		/*
 		 * If offline, @cpu is not its own sibling and
 		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
-		 * is eventually cleared.
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
+		 *
+		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
+		 * reduce memory writes, which may help alleviate cache
+		 * coherence pressure.
 		 */
-		if (cpumask_intersects(smt, idle_masks.smt))
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_masks.smt))
-			__cpumask_clear_cpu(cpu, idle_masks.smt);
+		if (cpumask_intersects(smt, idle_smt))
+			cpumask_andnot(idle_smt, idle_smt, smt);
+		else if (cpumask_test_cpu(cpu, idle_smt))
+			__cpumask_clear_cpu(cpu, idle_smt);
 	}
 #endif
-	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+	return cpumask_test_and_clear_cpu(cpu, idle_cpu);
 }
 
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
 {
 	int cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		cpu = cpumask_any_and_distribute(get_idle_smtmask_node(node), cpus_allowed);
 		if (cpu < nr_cpu_ids)
 			goto found;
 
@@ -3211,7 +3291,7 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
+	cpu = cpumask_any_and_distribute(get_idle_cpumask_node(node), cpus_allowed);
 	if (cpu >= nr_cpu_ids)
 		return -EBUSY;
 
@@ -3220,6 +3300,40 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		return cpu;
 	else
 		goto retry;
+
+}
+
+static s32
+scx_pick_idle_cpu_numa(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	nodemask_t hop_nodes = NODE_MASK_NONE;
+	int start_node = cpu_to_node(prev_cpu);
+	s32 cpu = -EBUSY;
+
+	/*
+	 * Traverse all online nodes in order of increasing distance,
+	 * starting from prev_cpu's node.
+	 */
+	rcu_read_lock();
+	for_each_numa_hop_node(node, start_node, hop_nodes, N_ONLINE) {
+		cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
+		if (cpu >= 0)
+			break;
+	}
+	rcu_read_unlock();
+
+	return cpu;
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	/*
+	 * Only node 0 is used if per-node idle cpumasks are disabled.
+	 */
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return scx_pick_idle_cpu_from_node(0, cpus_allowed, flags);
+
+	return scx_pick_idle_cpu_numa(cpus_allowed, prev_cpu, flags);
 }
 
 /*
@@ -3339,7 +3453,7 @@ static bool llc_numa_mismatch(void)
  * CPU belongs to a single LLC domain, and that each LLC domain is entirely
  * contained within a single NUMA node.
  */
-static void update_selcpu_topology(void)
+static void update_selcpu_topology(struct sched_ext_ops *ops)
 {
 	bool enable_llc = false, enable_numa = false;
 	unsigned int nr_cpus;
@@ -3360,6 +3474,14 @@ static void update_selcpu_topology(void)
 	if (nr_cpus > 0) {
 		if (nr_cpus < num_online_cpus())
 			enable_llc = true;
+		/*
+		 * No need to enable LLC optimization if the LLC domains are
+		 * perfectly overlapping with the NUMA domains when per-node
+		 * cpumasks are enabled.
+		 */
+		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+		    !llc_numa_mismatch())
+			enable_llc = false;
 		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
 			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
 	}
@@ -3395,6 +3517,14 @@ static void update_selcpu_topology(void)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
 	else
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
+
+	/*
+	 * Check if we need to enable per-node cpumasks.
+	 */
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 }
 
 /*
@@ -3415,6 +3545,8 @@ static void update_selcpu_topology(void)
  * 4. Pick a CPU within the same NUMA node, if enabled:
  *   - choose a CPU from the same NUMA node to reduce memory access latency.
  *
+ * 5. Pick any idle CPU usable by the task.
+ *
  * Step 3 and 4 are performed only if the system has, respectively, multiple
  * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
  * scx_selcpu_topo_numa).
@@ -3427,6 +3559,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
+	int node = cpu_to_node(prev_cpu);
 	s32 cpu;
 
 	*found = false;
@@ -3484,9 +3617,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
-		    !(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(get_idle_cpumask_node(cpu_to_node(cpu)))) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -3500,7 +3633,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask_node(node)) &&
 		    test_and_clear_cpu_idle(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -3510,7 +3643,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -3519,7 +3652,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same NUMA node.
 		 */
 		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -3527,7 +3660,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Search for any full idle core usable by the task.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3544,7 +3677,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3553,7 +3686,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same NUMA node.
 	 */
 	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3561,7 +3694,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, 0);
 	if (cpu >= 0)
 		goto cpu_found;
 
@@ -3643,17 +3776,33 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 
 static void reset_idle_masks(void)
 {
+	int node;
+
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		cpumask_copy(get_idle_cpumask_node(0), cpu_online_mask);
+		cpumask_copy(get_idle_smtmask_node(0), cpu_online_mask);
+		return;
+	}
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
 	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
+	for_each_node_state(node, N_POSSIBLE) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+		struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
+
+		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
+		cpumask_copy(idle_smt, idle_cpu);
+	}
 }
 
 void __scx_update_idle(struct rq *rq, bool idle)
 {
 	int cpu = cpu_of(rq);
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
 
 	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
 		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
@@ -3661,27 +3810,25 @@ void __scx_update_idle(struct rq *rq, bool idle)
 			return;
 	}
 
-	if (idle)
-		cpumask_set_cpu(cpu, idle_masks.cpu);
-	else
-		cpumask_clear_cpu(cpu, idle_masks.cpu);
+	assign_cpu(cpu, idle_cpu, idle);
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
 
 		if (idle) {
 			/*
-			 * idle_masks.smt handling is racy but that's fine as
-			 * it's only for optimization and self-correcting.
+			 * idle_smt handling is racy but that's fine as it's
+			 * only for optimization and self-correcting.
 			 */
 			for_each_cpu(cpu, smt) {
-				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
+				if (!cpumask_test_cpu(cpu, idle_cpu))
 					return;
 			}
-			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_or(idle_smt, idle_smt, smt);
 		} else {
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_andnot(idle_smt, idle_smt, smt);
 		}
 	}
 #endif
@@ -3694,7 +3841,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (scx_enabled())
-		update_selcpu_topology();
+		update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
@@ -3729,7 +3876,10 @@ static void rq_offline_scx(struct rq *rq)
 #else	/* CONFIG_SMP */
 
 static bool test_and_clear_cpu_idle(int cpu) { return false; }
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	return -EBUSY;
+}
 static void reset_idle_masks(void) {}
 
 #endif	/* CONFIG_SMP */
@@ -5579,7 +5729,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	check_hotplug_seq(ops);
 #ifdef CONFIG_SMP
-	update_selcpu_topology();
+	update_selcpu_topology(ops);
 #endif
 	cpus_read_unlock();
 
@@ -6272,8 +6422,7 @@ void __init init_sched_ext_class(void)
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 #ifdef CONFIG_SMP
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+	idle_masks_init();
 #endif
 	scx_kick_cpus_pnt_seqs =
 		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
@@ -6309,6 +6458,15 @@ void __init init_sched_ext_class(void)
  */
 #include <linux/btf_ids.h>
 
+static bool check_builtin_idle_enabled(void)
+{
+	if (static_branch_likely(&scx_builtin_idle_enabled))
+		return true;
+
+	scx_ops_error("built-in idle tracking is disabled");
+	return false;
+}
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -6328,10 +6486,8 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		goto prev_cpu;
-	}
 
 	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
 		goto prev_cpu;
@@ -7419,46 +7575,31 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask.
+ * per-CPU cpumask of the current NUMA node.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
-	}
 
-#ifdef CONFIG_SMP
-	return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
+	return get_idle_cpumask_node(NUMA_NO_NODE);
 }
 
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask. Can be used to determine if an entire physical
- * core is free.
+ * per-physical-core cpumask of the current NUMA node. Can be used to determine
+ * if an entire physical core is free.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		return cpu_none_mask;
-	}
 
-#ifdef CONFIG_SMP
-	if (sched_smt_active())
-		return idle_masks.smt;
-	else
-		return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
+	return get_idle_smtmask_node(NUMA_NO_NODE);
 }
 
 /**
@@ -7487,10 +7628,8 @@ __bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
  */
 __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		return false;
-	}
 
 	if (ops_cpu_valid(cpu, NULL))
 		return test_and_clear_cpu_idle(cpu);
@@ -7520,12 +7659,10 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 				      u64 flags)
 {
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
+	if (!check_builtin_idle_enabled())
 		return -EBUSY;
-	}
 
-	return scx_pick_idle_cpu(cpus_allowed, flags);
+	return scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
 }
 
 /**
@@ -7548,7 +7685,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 	s32 cpu;
 
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		cpu = scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
 		if (cpu >= 0)
 			return cpu;
 	}
-- 
2.47.1


