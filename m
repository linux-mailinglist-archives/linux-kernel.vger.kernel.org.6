Return-Path: <linux-kernel+bounces-260993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B1493B14C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279D81C237E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF9D159217;
	Wed, 24 Jul 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qstCRrGE"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD9158D7C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826092; cv=fail; b=PwTQ10hZ3g/6/yak69s8FPz9eGNON99sok4alsNlTkIL4YdGQoqZLe+3s/tu0Ji1xh7RPsByob3hhWBdlSOpU+iZYa70Up+a4thhC/zrRWKIo1LhdYsuzO8WQMC88pgxAbF/9o3kdl/slBhHt5fwDZlCa6Paw61EI8cRdFtvA64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826092; c=relaxed/simple;
	bh=hu8kH3FF9LZYABQo4ls3hsYgu2TMYUZ9hPuHSoWZMx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jICJqkqexUTFbj3w45TK8V4zsKvOlnM8rj9cTwXiCA5DDR8Pd7b4W49tls1uKIfOvqEAhb45MEVuGgHyyBDmyUWf4XH8xNRronOliF2xOg+b1Fc2xJe8B2Rhvlvmzk3GXkVb+y8LRJw/D2VV5B3X/w/8NlLxjR12VDTKtZh20Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qstCRrGE; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQUX2ghHrM5OKpN6mlllpqbSjxg8AGuU1bv+7m0T7GZGWgOQwpe5419hI5fWhexQkCqYSUMc9Z4zwePSm7Z91Lf/Wij8D+mDONilKyZDnjmBSEauhyYRD4bScgQ8BSjWvzQya4tHKNa/UO5XnnbdsmubbnJV3hP0ne2ABNlK19L1boakZCA2iBOz45RhaoTAvYF7NEmWzIRzMtT48m+AYmLTPwLKa+DdnCYA2GdkJpv2zbYH8vcUE6NZ4RQYMz/9Tqs4sLOgZ/+807ODB2NROvxKBiQxmOLaTGBA5HVwTZbZd6EMGGU1LUeW3kj1b+s3y7r2gZtezGR5sEZECdaVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de3HtV97/3HfU1Wwqz2WEK7UWyyj5aobEIaoBUZtd2I=;
 b=kh9GUWVzbVpJHzbVLeQM6m7Q89u59cKJA1TKEkJDX9jEA1OPiYKK235KD0mjjfLeP1+prh1NjaLk5N1k4vdh6VmYBwBgTXz8YYxFKs477+AnNY5CQ6AjF00K2QZw1bRMGMC8lcUJJqhs5tuECF8QbiguZ6VQ1OgzE+3DblFLBTgQ31016Ky7cq/EdsGIMyaiCeaohYmvTn+F92Cyv1MiG0Aq0IZs2qCY1g9EIX39ReFYUzDZNci7vObDJzSvEucVelVeKIjw5dSpLRimo8Kylf+35ZGHkzJ6sjRumXzNXJ9Oxi0ogFzTsfYk1tM07Tftwf46Xs1a/BWO+HNbYyQK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de3HtV97/3HfU1Wwqz2WEK7UWyyj5aobEIaoBUZtd2I=;
 b=qstCRrGE4Nx6o0ooMqjKn0DTR7PgDBleyJ8YHQUw+b94ShTkW+s7TR2GEPiDgrz7g5nc/7SgRkgt+mQrTlzQsO8IVwRnG9gyO74cJBFXNIxBjKcNWWEuszzyJwM9e4fP491l7R9RQkiEFZAzR5Gw5mcJggdTre4SPzVBvRLGs0599uG0xumkiKlUbePnEoxG+T/8qPXEKn+uC/1hKan+7GgmYs9+WixZj0zzYJxtckZmWrFVNqA7NKtK95uchfg4qypMtGUJJ6HohkMjn1Cu6TZDj7ZzYq09vM1JF/YIjzHupshyoC+s5rw3BOjY0cyJCmXay2+j6bQh1lmDpTTgqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 24 Jul
 2024 13:01:21 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 13:01:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 2/3] memory tiering: introduce folio_use_access_time() check
Date: Wed, 24 Jul 2024 09:01:14 -0400
Message-ID: <20240724130115.793641-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724130115.793641-1-ziy@nvidia.com>
References: <20240724130115.793641-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:610:76::12) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 82296d42-9d23-40f2-3fe4-08dcabe0b6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?apb+s7tSbTXjL5nvvoIW4QtKIEZTFkZ57bc7CpbmYIo63CRLAKtkBcffFr0T?=
 =?us-ascii?Q?3yhdMUPrtzbLXuoUx8fRXvX2OR4YKScJNujVU8N1PV4Y9cwENCQ0Br0Bx9Yf?=
 =?us-ascii?Q?kZRbzHNH31oqiVFcuq1TwBU3LWZ5YirmJ85/wYsXhP/8pctF/Z2V/zs1MEqR?=
 =?us-ascii?Q?W5E38SxmC4QJtkgMLLwaSvtWzcV+6cXeNUkdThS/zPJ8mvsAO6qHudGdhjDJ?=
 =?us-ascii?Q?bD8zKDfAwJyNE5N5swQTPZHkjZL9BidbJJ7JPa7c9GvIMApMAH2bmH14fdh2?=
 =?us-ascii?Q?Qry+KP1s+5/+i4mRXG24KBi4w/j6QNY43zR3jGYVqArxxT0H2iOQyaxPztgA?=
 =?us-ascii?Q?2+yd9ooqHJuHlnMtnvqHxFPN5AXJiX7T5bs9Njvqvqm5vm48MtN/rwFstCmV?=
 =?us-ascii?Q?R+hpqNOIDi5vuZrmXTHyIdAkb1vaB9E0uCCwMOujCsNbXCnQwaqKriOXAxt+?=
 =?us-ascii?Q?8mNPemmWwQtm7XeAnnH8xkj/BuOZO235OPRr5doGBucoT5agrNIfcV4M92Cu?=
 =?us-ascii?Q?mSmEtJaMD5DPfVygzRjlNNBqMnzeOKYUDEtQVyh+hRL2g+HcxEOYeRwUMur6?=
 =?us-ascii?Q?PP3lUH2F4ybd0OFF6p2tbztVzgw1wGnX0mDFM1RCn+1mt5DHGe77byvKmaoI?=
 =?us-ascii?Q?LapWKV0HPd19jgde8nDVQxNcJAkJ3BEPIsuGATD+Jza8wl68rTvDziFduTOM?=
 =?us-ascii?Q?YKap7uZHtu7mOUr+NUmwIcA+6fjpLYiplF6W5IoLuln6DbPOLuc9FCLPTruD?=
 =?us-ascii?Q?q81I5PPbYkM8TnhuoET/zxt+mrbpPWCxqffO/ygIAe7aNzsmOiN00JJAYGF/?=
 =?us-ascii?Q?iyRYl6KknEBWO0r7QFIktk5M0o5xCgbt5i8xyLfBIRVEG9j2C70qb76E5oYw?=
 =?us-ascii?Q?e2bmsqZjnwhjDKeITbR5Ma6TxBDa3mYP7/KuPN1LraoCeEznzIGsm+TQmll6?=
 =?us-ascii?Q?Cu9NJKNOJvIY9+oFpMEXM8Q6E3QqND9BiThOwHGlpBAjlrnZJlBTVJ/xMhrY?=
 =?us-ascii?Q?0/kix2RXDowBnZhF4+1Be4idDNnN7VqpNCiMr67Yph9LNhGqO7zAuktol5pK?=
 =?us-ascii?Q?RgQROYB72VBzTWvL7lGLpLAy5CQLpqSpZ20uEJNygEygR//qR1A08z0J6vAK?=
 =?us-ascii?Q?xHI/gfCygtNlqSGwjp6FGWzucwR2JwObxeqMTA6NWfso3jZOkxLkgO3Qi4Zs?=
 =?us-ascii?Q?GyvubY8RgP28YBfATRahY1pmDnwOpcEmEnMlaGpAlp1nXPML/Z51jH6p823T?=
 =?us-ascii?Q?Qm/JY72u62jbTyBK5Aedf0oG7lGnA4cOsBwP8OKvYuX6dYo/AmvuBOFLkO7N?=
 =?us-ascii?Q?8goAEslJFYDU0Hc8s8K0YpHgHNzLM4VqMmELpe0UKyRMAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M8E3r/N+6BRIya+hBsfajwiI0IXubOWiFRwJjr59foP3qFoYdEWtyIP2RSFO?=
 =?us-ascii?Q?dE9eZH2CClhiVquNue0zG8oRtY/SSAxlzzgNGzjjK9KBy+LN2GqDNqAHC8hM?=
 =?us-ascii?Q?+YYabIv+t04a3rCVomkNmqTMGKECmoCr2NVwYciukKrgz7hM251zZkiiUBEj?=
 =?us-ascii?Q?aEGduxwgrz0wTVBMvWJul9zwBYVDyqYmphhDywye8odnR7tLluLyH4VAtabn?=
 =?us-ascii?Q?ora9r/U0/1eJp/jyIUzI5wwPJBbCO0f4eOKK38lfwl7T65meHdSjq1do19L/?=
 =?us-ascii?Q?WpfpQyEIm2hmj+1Yz/2DD2hoZMy5Yzs5jCWFmtUxORmlbpKHI3V6u7LNWfEq?=
 =?us-ascii?Q?yqH+ISluanX+njeFtwT0BlKkwAL7z4TBhnOE+k2kpVReVtGQk5Afw27MAmg3?=
 =?us-ascii?Q?nLsHeQBcOT0G2PoleJ15sJNi/zUs51tohPQS8rmxb+dX/Ot7HNH+3TGKCq+l?=
 =?us-ascii?Q?9Y3wMMu1exs/OdJzOLCj2KJMzRBaF32V6q42VfzLCWBecTldUHN6H4xWUKNT?=
 =?us-ascii?Q?6FV1C4UpkDDU7/vixkABzwG3wEIdMEtnY9IFsjRSK0mqrqgytqFU89zok/BA?=
 =?us-ascii?Q?v6f5YmxL5faLsxDciSYWY4FD3bQiA3AA6QzBBzpjY4BCZ/bK2t1R1l8+Xqfq?=
 =?us-ascii?Q?o2PXfVYHYIaYom9Luve9CHREsgBL+C/kc6pVsWnFHCTz0jgmPJowg8vBClo2?=
 =?us-ascii?Q?p7X56gwxwWmdIePxufXwZvFzBtNKreTkevqhhAk7gY6ukdTxghjCww8fBNfR?=
 =?us-ascii?Q?LLXSp5QV34Mbv5ZH0BVrPYl8eWCjIrEq9kWE59TdYHU9MpEYAGsS7Lw7bLcD?=
 =?us-ascii?Q?sx3YinXO2UuqQp5oyoQpvLdRyua84JVtnLETLiSmuY2ehdR0vmFx0AO3duUh?=
 =?us-ascii?Q?amrhyOzd6hyaVzKhSBAUNLaOW9/PH6nB6g19c1eWTL/y9CVoPlHF8fffrZkT?=
 =?us-ascii?Q?fveVL29HNIZr5Afa1SSsfSr4vhkGQ042iuDKuD3FNLhFqnj3VTNOLHHHT1g8?=
 =?us-ascii?Q?Jx9ANa+zgQk8W+2Vpdj1HbTas7l2XmXV6cO9qf9HOnAnmZe4RfeTwZ2aXNTe?=
 =?us-ascii?Q?Hi46rh2lZiO7jB023QXVZmHzRLum4RvKv5mzvzj/PGHJhCe+VE7KPovFlxX/?=
 =?us-ascii?Q?UrWBZbxmrjLHddiZViB9nJtzQarlbwXx5Q7NJJuJuWkN2qUHSMGKqCwoSY0y?=
 =?us-ascii?Q?Lgvd3GAoK5gZiR6DN7LgtM/TMIGv6N0IAj1QTCTyek9hlNEHKlyzTAaERhtJ?=
 =?us-ascii?Q?k13KKt+1PgRhO27wRKYv3LZfr7KX9/PKvAsoo3ad8enLFH0iI4XIkSXbL4ed?=
 =?us-ascii?Q?btZwx28B9oGg684AR9fVpUbeM9wG+a2dfpEapquv0dk3NV+ya1L4Ap+E676e?=
 =?us-ascii?Q?LuyswF6wg1rnpULw6nBx/326t48oLUrZX2EkDPni/nXX0+uOEJfgEo7JoDCM?=
 =?us-ascii?Q?ytlZmOvqaZ1xOYp50MqrzHnD6KrGyjBRo+ijm6/pne4pKeWt5/z1eghZC/xP?=
 =?us-ascii?Q?ZrLTu4ikXq7pP8DGADmpnV43A2/6Ev+b0d/iVwMrE5GdVcuM86VKkG4Hy1/+?=
 =?us-ascii?Q?M8flo/Olq/QH19jCcqQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82296d42-9d23-40f2-3fe4-08dcabe0b6d5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 13:01:20.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBpMoBRiLx/QDGcrqF6nwlt+WjghURwjXy7NFjFHORPQSiX2HCw5Oo5OYT8gv441
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709

If memory tiering mode is on and a folio is not in the top tier memory,
folio's cpupid field is repurposed to store page access time. Instead of
an open coded check, use a function to encapsulate the check.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h  |  6 ++++++
 kernel/sched/fair.c |  3 +--
 mm/huge_memory.c    |  6 ++----
 mm/memory-tiers.c   | 19 +++++++++++++++++++
 mm/memory.c         |  3 +--
 mm/mprotect.c       |  3 +--
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 17753a463e01..2c6ccf088c7b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1717,6 +1717,8 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 		__set_bit(pid_bit, &vma->numab_state->pids_active[1]);
 	}
 }
+
+bool folio_use_access_time(struct folio *folio);
 #else /* !CONFIG_NUMA_BALANCING */
 static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
 {
@@ -1770,6 +1772,10 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
 static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 }
+static inline bool folio_use_access_time(struct folio *folio)
+{
+	return false;
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..416e29b56cc4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1840,8 +1840,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
 	 */
-	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-	    !node_is_toptier(src_nid)) {
+	if (folio_use_access_time(folio)) {
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 15234b2e252e..5c0a6a4e3a6e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1707,8 +1707,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
-	    node_is_toptier(nid))
+	if (!folio_use_access_time(folio))
 		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE)
@@ -2061,8 +2060,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    toptier)
 			goto unlock;
 
-		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-		    !toptier)
+		if (folio_use_access_time(folio))
 			folio_xchg_access_time(folio,
 					       jiffies_to_msecs(jiffies));
 	}
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 4775b3a3dabe..2a642ea86cb2 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -6,6 +6,7 @@
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
+#include <linux/sched/sysctl.h>
 
 #include "internal.h"
 
@@ -50,6 +51,24 @@ static const struct bus_type memory_tier_subsys = {
 	.dev_name = "memory_tier",
 };
 
+#ifdef CONFIG_NUMA_BALANCING
+/**
+ * folio_use_access_time - check if a folio reuses cpupid for page access time
+ * @folio: folio to check
+ *
+ * folio's _last_cpupid field is repurposed by memory tiering. In memory
+ * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
+ * record page access time.
+ *
+ * Return: the folio _last_cpupid is used to record page access time
+ */
+bool folio_use_access_time(struct folio *folio)
+{
+	return (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	       !node_is_toptier(folio_nid(folio));
+}
+#endif
+
 #ifdef CONFIG_MIGRATION
 static int top_tier_adistance;
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 802d0d8a40f9..833d2cad6eb2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5337,8 +5337,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
-	    !node_is_toptier(nid))
+	if (folio_use_access_time(folio))
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = folio_last_cpupid(folio);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 222ab434da54..37cf8d249405 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -161,8 +161,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
 				    toptier)
 					continue;
-				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-				    !toptier)
+				if (folio_use_access_time(folio))
 					folio_xchg_access_time(folio,
 						jiffies_to_msecs(jiffies));
 			}
-- 
2.43.0


