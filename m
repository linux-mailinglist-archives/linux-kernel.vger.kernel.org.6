Return-Path: <linux-kernel+bounces-257387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F193794F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50801C22098
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B8113EFEE;
	Fri, 19 Jul 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2o/fcHt"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0083208BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400198; cv=fail; b=oHJkrl0RA/D/ePWal8rcs7J37Tlx7gMKcOc6kgra1bG1mNbAdPSD57r9coohODYAMxIA3/pg9cz2CWEvVh02oFizJ45UZT65LTNLuVwY5Pm234G3vSVXJLJ3p4ANtZ6qY7/ULEgkrCrnfrFcsyu3kykAXl9NF+xwgzz03yZbq5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400198; c=relaxed/simple;
	bh=oeaEw64zB1I/2Ffe1ZbysrRyvq7dFbKLe+4M/77KO+E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uOxW4q2z8Uh8foAQtSbBT4A37XfyPMe6u/t/3xxN2OpIh0sKNpKPoJBSgWziXN+y9EFVy43LdA094353aqDYA0eJ112hvSwevseCR9n6a0M75e0b8tqC6ZCXOOEQ5Zmfy1xvmqe5+1XSmhaX7QH232CAdfVPMBev+56as9yIw8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h2o/fcHt; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOQQkJnQ0JclTI4QLLBJWL+CTvQpuM92QfOVXbuwvX6OGx76cIMVB+43dIbzUHFomQTCqg9XM43vTbwvjd7k7heIRCox7OYtillSYlCd95BZxq04fYo1/YSz34WN3NEPNWvjGNjY/ezwJHcEBNy+z3iDQZQZum4fL/nvUJQ8lziLZz74GjWHOxtHf3eo0QZkU3TN7TSK9kG2p6OGnK+5kwOc7a8gTpJ2pU89HkoK53bHx865cTW0ub5Yx1S/siS4Bw6jG6FQgIw7lCknHQgVOnK4K+NlhiGSsUBood7+5c2c4iNasgUde6PRnoNUfpJgaDaqvYqSmL0u9EbpU6HUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ok5Z7WUVVc0vxIQhoTCNqnFoukcLJLOjfLxV4AqhyVQ=;
 b=rUZujmKRYpEQZSwuQyB2Wtf309XRM8ZLIe9F3zjDmc8Z9rDDGVKJcvK3q93E/ubP9zpklCLtugPE6UJqD+UgA21eLmlPSCsiQiN1zNR/UwOuooC5+FhSJ/VcZvmhD6TD07P8kUgHu/lwSWAu6saM6NefT5eOkvyWzZmIyCycvV+Fxz2p7u2EJjN4t+SS7QYdPSwFurdQDBcSCqCWTBmB4HAj7gIkLwmOAWpBcjHT929scKV+yAfzYys/YtvRe2fS9H9gPQiBDPTteUIS9/yMQeoXNbyYJVjSUXVSmtAICv55V2Dzg36PkVJLgqPcnZ5y2Te1AERLdpjZi2On1LrEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok5Z7WUVVc0vxIQhoTCNqnFoukcLJLOjfLxV4AqhyVQ=;
 b=h2o/fcHt4rRQDCqoWc8t3hov1XfEsmA+KlHGzpnGwIzy/qma5NA/wue17qmoDGqeI25DelZwyZY0+0gs3J3VPQwKisFmyWlEbpwV60ADwvbx+mzvAfpvQ6oaJnvMWY+en6Ri+//zbQX5Swl6peNwbfNfzuWd+/6KA3em4+zGAyrh0WB50uSQJQ2Ityz/xHP98iq9ToyKvJDHmPuGGnVagHUeDQLjBOW/wyc6qRVGvCy9+OS8BiJSwKKWggqEUddxBIi/3cT4mfXxtsSurV1umMNKunVakp1ujUmjMH6hz+lCffIY89RiNRfbwyAAI2+D5mipVkUzd9J77HL/jRF17g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 14:43:09 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Fri, 19 Jul 2024
 14:43:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 1/2] memory tiering: read last_cpupid correctly in do_huge_pmd_numa_page()
Date: Fri, 19 Jul 2024 10:43:05 -0400
Message-ID: <20240719144306.258018-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:256::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c4dc1b-e18f-4458-0a52-08dca8011bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7iokqxxnl5nqHFIvqn/5sEXMaxKsc8QU8zyH27MI4UfGtwqp+Y3MZW0ePjD0?=
 =?us-ascii?Q?b6iYQoPXxpTaBjXuG0rbOHp5Yllp6QvyvQZF55SuTNPwEjD+1vV6UXNPKAuQ?=
 =?us-ascii?Q?w/tWavAqh6Zxt9YHjazokCknlxveapnL2ufghQWDA3Ur6IJDW0Zrgbl+hbO1?=
 =?us-ascii?Q?Pb2I/s3JFQIBjkJrrEA6GmQwN5bjYnVjdTyvpUGhaqqDOlU7Xry8OXHvN9KT?=
 =?us-ascii?Q?8vvh868wt/Fy6ucEWanlC5ugWRsvFXCpqX0fDtU0WACsB2lVyms7kwnAKJbc?=
 =?us-ascii?Q?7a17/9+f2x/sowmgrnLReBNS0EH2srU08GUpMrgpdY68OhbG2uJMHDccv1oi?=
 =?us-ascii?Q?YrRhr8YMazfxMyXxuxglWZYm7vY4N/Ig4fqm4FGWCXI4/ZVkIj25rSuZpzk8?=
 =?us-ascii?Q?QyeLru5+Bvgz28XBqu2toGFtxM4fHvNl2FuW4FcN9YDi8oDAT5qlQjDUHjeK?=
 =?us-ascii?Q?B8S4z0tCnhzmvcGK5Lc71+U5SDFMGPhy1laqZRfh7GAdDOmMmZCRHS0wNg5C?=
 =?us-ascii?Q?RUV9Tdt5YCFz35B23n+wEI8yIufzc/0wx9XR6gtWJx/cuFE3WO93EtXyGksT?=
 =?us-ascii?Q?J4pNTkcuWW8nEogkXAkJVraRyz9ySEb/CfWMwRCaciEDnMHCbXYoYe1N6FIi?=
 =?us-ascii?Q?Orxqjzh0yRX5KNnY6FpIs5FCguXsKZObKzWg1afojjXzx/qcHqxJp6xI4SQw?=
 =?us-ascii?Q?IQcPBSI2rsab1OfqNGqT/LUQ+ud6cGoV7WJDobSYh/r340SjzmPmic8OMiV8?=
 =?us-ascii?Q?9duNxJPMqgH87anC0uVAcQnN0bZ4LvOGjTvOUbhfneqk1GImhM5yZ0fpHP6w?=
 =?us-ascii?Q?XzMl8LVhyh4AM1KEZ1z7WG4TlpFPenafltWqFRm8WlsdPUBRFnOgr3ipg9ZU?=
 =?us-ascii?Q?R7A6YNeuJKy1EhCvXvmgGGAWlDwFsQhJUEjwUhVTWXrNrZLhe1t6ID566Ed+?=
 =?us-ascii?Q?mr3HS6tNgDXDYLd02b176oKLqUC2M28NWdIbFkjnWGN/twgRQPq8tBL05zqQ?=
 =?us-ascii?Q?vXWYTU/PPibeucFIh7HaMNkyruTGDZ3PnXDgHCQXkA2/a7Bmmry8Nt1ME1Ux?=
 =?us-ascii?Q?SfNmOP/Y1nB3Juo9kNLj03mctdzbTZJM+7JI9aAiS1uBE4EWb97tDZpjrZwq?=
 =?us-ascii?Q?55tbtLIsEora4kVnaT5VNI2eepcnI9Lw4eyKyqOPGRKmzAzcmDeIjMnfCC9V?=
 =?us-ascii?Q?IHwXjG9nyzLgaNHaKOYFIJIWVOrxYZ8BvW/SXXIxFJw6Ov0APXW8Ro3r5zWa?=
 =?us-ascii?Q?BF0ek42jzaJ5oEzOJgABKZ/NVWH6yKuxGp3Dbjh+96yNKmsjY/ZPq9TTZONk?=
 =?us-ascii?Q?MxvwbYvCfMGlz/eu4/kmzB0hCYCrEHt8SElG6h5Iy2MGSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?09N2uVU32yBuwAfkSJGDfvkeTW0cTjHSiqVzKmvgtgiteYAQY6uCwHmN32yB?=
 =?us-ascii?Q?M+wa4C4EnYUNpQoL9y895j2AutruB2FkLdbnsQIoSM07vmVGJfqlp5Ljk1bk?=
 =?us-ascii?Q?l6TSnKnOU0uNSFNSS6XxVACXl9G/DR0Yk26d3OOiQmzHvxwK6x0uhdEzRGti?=
 =?us-ascii?Q?np56jm6eFgjqt/dg36gZZKAzlXjknFCGv4xHO7ux667poTBXlHlFppPoMLSa?=
 =?us-ascii?Q?MVKRgKvSWxVlqUjiszdXAD1h1DAJi00yDg1b+m+AWUcZKOm/GHxT6nxfp/kZ?=
 =?us-ascii?Q?1giOGyiLvA2mEnqAT1gWkcAF3V+ATgqgVGMM6SaGtKuACi2uSOCChhlJ9iNg?=
 =?us-ascii?Q?6rJ8dOKCsLZjAcgwHmxifY6furAD3ODv/P9HgamHi41rLWrYk6bP3P3eU58j?=
 =?us-ascii?Q?NGj+WhZQ/NHb0BEjSKoikUoeO0LdUwU+YOpAIp7Kdx2rUJmsjla23ejWJH5C?=
 =?us-ascii?Q?4xmoHvbisNNMNnOjihpinLzSxrGqTUcPVZ1OoGZ65rLdYvDZPYDJO4U+52H/?=
 =?us-ascii?Q?hc36V7vZZT7WwldXSQ0sM/7V2/Yd2HZAcUzbyADoB11UrXV9GInx9977ywy7?=
 =?us-ascii?Q?KXRSEdiTVpULnwTnJFMwr35ZOiQfsqNi0vA9NnI4tRxc0QR70sYM8HSQWj7j?=
 =?us-ascii?Q?8bLNaJ9NGI0R6nLmCkinQIujXP0SehVIa2Tc806xjajfg5BEZKLnFoF7wUQw?=
 =?us-ascii?Q?PGgplTOMPAG3dhy9VaQEFCeVH5Ws6jG4Mj6jorshDWjmO64rlLoQDEHuwWjb?=
 =?us-ascii?Q?jmDm1b5/c6XpBnvcdz2AYVMyVhOdSAtgC7d9PhO1vmCIAmM1+cFwrzUIHjTq?=
 =?us-ascii?Q?eV+vJZgPC9RvXxuxpoOkZPkqKm+dUik5ctddSJrCluwRuaLF4lX8n3ZL7xpP?=
 =?us-ascii?Q?dtL9CscfRLswF13ULtg7pq5Bq6p+TyQz6MVG65GUJUVdZ6VYw7T/bnxUjqgx?=
 =?us-ascii?Q?b2TWcGT6PTiGUw7WYLo+Umr3Qjf3E8sdYkjaztiAwDS3grHmDExv7yCU9+NN?=
 =?us-ascii?Q?H8JMpXT9+XvKBJ+ZolfnGYSyK8DuqhahopjeCnQ6Us0kMDyhYlfAKK+qMoVk?=
 =?us-ascii?Q?R8BuQLLmjuXUT4/FIWP3OH5Q0c0mNJvzm8TwfVekdQtSMpHWTmA6OoyFuGkU?=
 =?us-ascii?Q?TTwFjVwskid9VxzBV07QNoe0vdOOFinaCzYQxvks00BkIUto7Io+E2Q7OY0l?=
 =?us-ascii?Q?j4q8pG+GXuYUtVTtf8MjaHsseQ6FvWM3f5iGunFma/4h5QvFQ4FjWyHniYsv?=
 =?us-ascii?Q?9zQ6tVv3oKD0wBcpoynh51WUq304e2z3P1GzLTmgfRBXEMItO+r5u9DiL2ou?=
 =?us-ascii?Q?jbG1ED7FUKIOJkwn1OlmmgRCKqw4MNkCgCQY9aCBXntMo2FvbQ9xxrVJ+o7D?=
 =?us-ascii?Q?8eMxPj7yut6zaG48Z+YOaMUgW3TNYl5OUbNPU9PPZnVCnSXZC35hPiy3L5H+?=
 =?us-ascii?Q?IO2F2HGbW1bezeK4oY/T16sBrYJCv2ZCWSfOMFPq+S2qIVHgisMuqdxtgq2j?=
 =?us-ascii?Q?ZRSfNaDDcaAwEWbFkHFIjnMoCvdhnIZ/+BfsVJ/1fFIX2acH/i5iFdzLJUJm?=
 =?us-ascii?Q?XtMfLwEYjGgh3u/58Rc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c4dc1b-e18f-4458-0a52-08dca8011bb8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 14:43:09.4650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HIPptyy+Z+Aer4jsZvEt+DY1IMxMDtHe6iCPSJPZJGyhPbC+R6wvfZ/b2Pojs+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079

last_cpupid is only available when memory tiering is off or the folio
is in toptier node. Complete the check to read last_cpupid when it is
available.

Before the fix, the default last_cpupid will be used even if memory
tiering mode is turned off at runtime instead of the actual value. This
can prevent task_numa_fault() from getting right numa fault stats, but
should not cause any crash. User might see performance changes after the
fix.

Reported-by: David Hildenbrand <david@redhat.com>
Closes: https://lore.kernel.org/linux-mm/9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com/
Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f4be468e06a4..825317aee88e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1712,7 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (node_is_toptier(nid))
+	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
+	    node_is_toptier(nid))
 		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE)
-- 
2.43.0


