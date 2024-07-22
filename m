Return-Path: <linux-kernel+bounces-259263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDAD939334
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7471F21CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19B316F0E6;
	Mon, 22 Jul 2024 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ksPGxcbn"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929216EC00
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669371; cv=fail; b=C6NOVV8hezZrwHjvJOX4xYzomrPbOEuLf9DQBkZgBmRnEm1M1gdDFdY4Fw95W/GLSXcmGuIsjCGDifwiSfCWY3CsKNm9xy8HjWqCENwCWQWY/szAwbMfqMFGYxuBZZVktfykJxyIBYlg/t7XkvDfHOt9wZVTzS/1yUbYUxM5eik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669371; c=relaxed/simple;
	bh=P7SG/dYg3I1gsa99WZX0tkkol9/i2ZQpXEfD1seSNu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSu0Xa7SSBkvFLA2OzHQCEgHUKperPWEjFphVestpCDMI0HuOc802d9INimCpqssWjsF4ZkvfayhioxW2lFH6PL6zYCXfbUIUCmRi5Fapb+/Lf2YbygG8WY3XI2NHoe5D5uFgtrqOjWmdtcLv8j5eYeyCP3Ytwp0pkQGRahQq/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ksPGxcbn; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbGLR68w2qxynFeG+2lTC8gCCmE9L1yWVJstD/dW4/Gq5NDzmC8JyRkWD84MDATQOYaYXEF1NaxplTs1fHtequg+ZG1Y6iBTUJ32O1AfJFC429Odft6kjpo77KOT8TZSpw7Nm0ewC/qap1lxOG3p9kpT/lMQ/tEsm+vVJ5+JrRJY0Y+80YYV1vHJ4VuoAYMaGqL+9JSaZPn19OkrNfmq0zlxKjgYcod7RC99QfG5H/VohhxfEcLfqpLt+YfpNV+6iuVBFxPMuXUYJ3FMgZk8TXXCc/97I4kQYaCFtROfYe4UbWS1Lwq4pvSRZl0H/C0ArjPAc11dlJvl/WF1TGFV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77dpwOV1mf8CfX1TKVYlaP3iGgjjwq7Xmbx0eFVU8xk=;
 b=vCvucg15FAmhNs5+K1KGyGL+rZexPLdj3zIn2/VfO4CKJG3dVosv40NeRJhBjAO2cKcT7vV9IYzbyNBARQZ+fPjldYRof+UloOiSYGkQ5C5kqltDt6I5RzJNcbf2bqCn0MJ3S26mqzlVD1IRFHcWBFZ3XuJ2qzeBwGT0Q27Djo3pmt50xHUyDDXtmviC6mMAGKBckH/33rTm16/sXEg6qZR3onIAEe5vH3h+z+qXN9f/VHHoyOLLgA2YvkbnU4LWslWo97TP3dL/APfDGytjwKKKHbKXn+ItjnPLYl+oCyx+Y9mLLu9m/12nmdJUpTMN3xzo9pjU3dY/yv+AHUusCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77dpwOV1mf8CfX1TKVYlaP3iGgjjwq7Xmbx0eFVU8xk=;
 b=ksPGxcbnz5maQoBUsWSPBvZA0nn+4dJESTSRH6LzEsUgYAFJUOu7JAI/RkMnzlDoer2ouYFYjCCha9PepgAV3r9G8RN91lOjhYndRuj8lRXnojV5yS3doAxfgOWvLWcYOWg2+ztwhC9Lj7w7wGCTw5Tv3H7GzVN0E/8SY0gxKbISyjaa12M2vkjgJJv2bHOVAbrtyB+lw3ViOFR/gSY4nyZYVNoZFyo3m4GarjIG3F/aQ8F0oJPBwsPXahSYD5Cu3iXuVufNPEH/lZR6cVfb82whXwzwDprbUG5uQTsTbDA53vAjgzkJBO1xg4CTqGFyEJlZekQZz3kn3c3P3d6aDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 17:29:24 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Mon, 22 Jul 2024
 17:29:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 2/3] memory tiering: introduce folio_has_cpupid() check
Date: Mon, 22 Jul 2024 13:29:16 -0400
Message-ID: <20240722172917.503370-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722172917.503370-1-ziy@nvidia.com>
References: <20240722172917.503370-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:208:329::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed615e1-d660-41b3-4ea2-08dcaa73d4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?thTG0HbTUUzV20Qf18YnacBVhWtbTuk94UKVeyYXQrrz/LmXzXpJJBKqE5Rc?=
 =?us-ascii?Q?WUJhYkIIU9YrzVERZDN+pzrLEMso/HsUPCPjnQET2JDwPd4EaUbF72QcEw6N?=
 =?us-ascii?Q?+xOf0PoMvi5sfNOKpYIFEkPwm3QBZU/qCG9LMxWSfvwRLdN2iL/2eKV/VHRH?=
 =?us-ascii?Q?wD87rx/1U5ZhIUJD2Ceh9/UwxGjii7/FOLvIcXg/HyJzonGyOAZvJRldCJRu?=
 =?us-ascii?Q?qSmMJvMT/0LQya9QZZVzM1dU4N4kpRBjp1vU2IzKlyyWSTrR+ROENGjEsrZg?=
 =?us-ascii?Q?nBMYuUyEGwuj0d9UyPsggPRavJ/xOO3RjiDuj/eioQSzVUCcb+q51yb9iYfA?=
 =?us-ascii?Q?S25dN0cRMYX6PpabeuAJIytzxOY5H3LJfAXT+PIN5XUYZR3iL4zFstPhDYrs?=
 =?us-ascii?Q?wEf3EVwX3zinty1oqG6f6FK0NRNN8oCMvI8UdA9GfxjQI8worS6d8MOJKfiV?=
 =?us-ascii?Q?6e7ssNalLBmauxRllKNK8vCfq2+kJDcEVFW7LIyq1MO+pWqYanaOI5ivv6gD?=
 =?us-ascii?Q?HN4eYKRJhnOv7FfGaWlhHIzLs7gn0R4l2aKP7RYM3I2X1+G6N8zRRIJSriOr?=
 =?us-ascii?Q?CmpYjiwPKf3TyWTwBwA065HlDhkIpdimXeJgq8OOqwZ32n8RMMLkeCQUZgRM?=
 =?us-ascii?Q?z2n951oH63z7VfNhDKQNliDznr/8noVMbuFYh3ufU0wWNklBU5KLpMvJL1Ge?=
 =?us-ascii?Q?ZVTI2ysEEegw6OPvVcLRTWMr2B91TQp7nC+Q0PfG7IltORpOgroBYpMBjHeA?=
 =?us-ascii?Q?5GM/R0kE09tVqHbikI3HvTS6MipfQu4k2lVq5X8c9jF/MI6DImYK7WT6SVJj?=
 =?us-ascii?Q?nNtFLaWgBmQYPF0j6JD66IrmsQqSs3Ioo+H5Hvrkjmyovl/xSXbr1gIXHxQQ?=
 =?us-ascii?Q?xlrsjgmUEGlr42Nk4wFhkKA/62/JojNpIDDhnX8xXhWDSzHvYaljx5ZwtsQe?=
 =?us-ascii?Q?MondBRBawTnWp8kJa01rlPGOSn58bSa05qvuEcwLYKmh/MefxZxFDqzwNmNt?=
 =?us-ascii?Q?liVlD1wjzqB/m29xa/nBV+cSqPlXckDjm7I+1RtGyvC7e0kKUddsuNm8ZzoT?=
 =?us-ascii?Q?b/EKyDgYli7XgUx+jxHLWI9cmUQqfqXbOzzOqN8ezuUYfNbtfxis09j0byZp?=
 =?us-ascii?Q?Gjy6CnRoVx2M+vSUIBD1vqgo2w1JNsICcZU3VwVxbGQCr74NInnszUp/n2cV?=
 =?us-ascii?Q?2gQYAlVhKjxpkADn1tZQLP0VA23mOC+A37RROt478PZdpVRcfOMAjGkZ6sxG?=
 =?us-ascii?Q?reXYWk0dYVv1bRKrTND/ljS5UpgL5pUoMpNLsARZNw8lG9Crv9kC0R56E5Os?=
 =?us-ascii?Q?bkxFPlGxglTHbajHojf+dw3w06qPVKxh1qYgYT1uoNpIEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+37r/LRMNW2pH/Ju/uEK96NOThkceTG0otMZgkgnEtSLStSsW/XvAlOn1/oz?=
 =?us-ascii?Q?6M8/If0xKoJLgPWNCX9zf0zmTj9A6ls2V78JQEhVfvYAesXOCAwOLG/6anl7?=
 =?us-ascii?Q?uvZM2hluSM16yfuD7Y/dC58CRtOfyf9zP5aWuWJPaHWVWSsxHtzY+E1Iad6G?=
 =?us-ascii?Q?z4YKZfZ/PvzW49MaHEtih53SI8LPkvaGaxYJpNvaXn8RTNWS8hV3V18QC4fE?=
 =?us-ascii?Q?1DRtLN+0DyVaHSzKTziRh835ahJaOJw+RA/wq0D7nTAyNnRJ9tDccbuM7Rdm?=
 =?us-ascii?Q?t7THNbMmFz9jdcYMgF+4It/mUlvPLSCBO6oa4aGn5eD5NWwZAJAvOZzt3x31?=
 =?us-ascii?Q?WJrPQjskQRITskbUn4K+dYT5vkhNlZJZ5CGr8xHehJomlaeZdwWE5CnoJLLZ?=
 =?us-ascii?Q?5oa9X6GbIujNSgqc3NJftE7svDkJbYQPqo6UTIUfL3ZeBzjBqsQIS8gF/mlR?=
 =?us-ascii?Q?MsBpTrXQCBl0Zk4JVrKNK+GiTM0xpuktOuWugMb8rMuQEWXXqrfDfwTb6zuk?=
 =?us-ascii?Q?VVE8fFBXr4S+XMpvQL6lv9GVMQ6YaQQ0nIDw1Hn8DdCM2ahOJWv+w2bRwruq?=
 =?us-ascii?Q?+M9JKPDAKf/CfDENu+j8IFWO59XOP4n49HS7wbZ9Uh1wDbc52k3bELGfWitk?=
 =?us-ascii?Q?Z3ShHT2w15pVRTQZI/7S0eokJKrJPeTeyBlMeF6Q5Kgfg55co0FqISsYiXkE?=
 =?us-ascii?Q?7kvaAph5DAb8uEz7VClD6pIcqAxNlb7ujtKvUjRdz/UVYdW2vJim0Eb0ONC4?=
 =?us-ascii?Q?dASMDcDkCyQe7MI3vJBsEzKHmo09pKmPyIj3N0D5vU8K0ZOeOxPRoMgZYISY?=
 =?us-ascii?Q?d1x6gubM9+rSJh+3XZvuSvgjBAn4yZenYTckdwgVP6j74e7zJgj6YLn7t4jT?=
 =?us-ascii?Q?ifgUDcM34YrBfpMyNMkqQyo1GIpLiQ3AsasLyK/Uta+2h4voNxusvTIDHQFW?=
 =?us-ascii?Q?RfPhs1xiWxiLkf04dJRoeKEEMyrLadQcg2B3ZzOevo+bOevJ4YyffdsHx4Qq?=
 =?us-ascii?Q?FgQPbdvHmLbSLEcyIryPcf5c9RS2xDB2XUFQtLAU69JiO22LLm12nTDK3vIw?=
 =?us-ascii?Q?2AMay8Xvm8hHzv5fA3u8exxKT4Hd8140BjNL/4W5iSfcERsIoT7QadSh2eLE?=
 =?us-ascii?Q?Hx90xKtQDAOZ7/EnbRgMJIck6r2O8s4PKvepDjOxUrZlZVk4yWs8cETExx1J?=
 =?us-ascii?Q?AqiUSGgPzjMEiC3z99TOE6QWFpkvDb6k2xkjCNEsQyp9GLMlqnsCmmPgy/KK?=
 =?us-ascii?Q?+JZ2a4bUgzCPnKLeGjYy8wdhVNiIoQ4zlUB9wwHDGpYm51qGjW1RNRJMIsFB?=
 =?us-ascii?Q?bKf8RiuGymSOk99Zo+OhPuUHz5qgKy6xCxmiuyHiQsR7OY25164LcIja2y4m?=
 =?us-ascii?Q?Z8hfYU4yI4aB8QLL94uhO+OPSxc1ydi7QWkl305GL/5IMKOBekneXWjsmGle?=
 =?us-ascii?Q?hs03H18mxduMpXZcDwk4dP/Y/Dq9kgbDVEABpJDvlKpSH7BOAOnznSBphzW6?=
 =?us-ascii?Q?mezjW52FWJW0Nnq+TJ5vVkBiuRsp/jeYWfDxRxDUfhLjnp+qK9X8rEl3gjBQ?=
 =?us-ascii?Q?VuD8xL4qT3ssSEAHh1E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed615e1-d660-41b3-4ea2-08dcaa73d4b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 17:29:24.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNFAjMLwiZGC8QBP1OSwHuAebtZPTYic+bufBp3c6b3MH+2molyHBb3ibdXisQRZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

Instead of open coded check for if memory tiering mode is on and a folio
is in the top tier memory, use a function to encapsulate the check.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 include/linux/mm.h  |  6 ++++++
 kernel/sched/fair.c |  3 +--
 mm/huge_memory.c    |  6 ++----
 mm/memory-tiers.c   | 17 +++++++++++++++++
 mm/memory.c         |  3 +--
 mm/mprotect.c       |  3 +--
 6 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c227f22ba810..048b2a56d8a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1738,6 +1738,8 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 		__set_bit(pid_bit, &vma->numab_state->pids_active[1]);
 	}
 }
+
+bool folio_has_cpupid(struct folio *folio);
 #else /* !CONFIG_NUMA_BALANCING */
 static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
 {
@@ -1791,6 +1793,10 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
 static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 }
+static inline bool folio_has_cpupid(struct folio *folio)
+{
+	return true;
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..03de808cb3cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1840,8 +1840,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
 	 */
-	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-	    !node_is_toptier(src_nid)) {
+	if (!folio_has_cpupid(folio)) {
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 825317aee88e..d925a93bb9ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1712,8 +1712,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
-	    node_is_toptier(nid))
+	if (folio_has_cpupid(folio))
 		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE)
@@ -2066,8 +2065,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    toptier)
 			goto unlock;
 
-		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-		    !toptier)
+		if (!folio_has_cpupid(folio))
 			folio_xchg_access_time(folio,
 					       jiffies_to_msecs(jiffies));
 	}
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 4775b3a3dabe..7f0360d4e3a0 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -6,6 +6,7 @@
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
+#include <linux/sched/sysctl.h>
 
 #include "internal.h"
 
@@ -50,6 +51,22 @@ static const struct bus_type memory_tier_subsys = {
 	.dev_name = "memory_tier",
 };
 
+/**
+ * folio_has_cpupid - check if a folio has cpupid information
+ * @folio: folio to check
+ *
+ * folio's _last_cpupid field is repurposed by memory tiering. In memory
+ * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
+ * record page access time.
+ *
+ * Return: the folio _last_cpupid is used as cpupid
+ */
+bool folio_has_cpupid(struct folio *folio)
+{
+	return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
+	       node_is_toptier(folio_nid(folio));
+}
+
 #ifdef CONFIG_MIGRATION
 static int top_tier_adistance;
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 802d0d8a40f9..105e1a0157dd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5337,8 +5337,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
-	    !node_is_toptier(nid))
+	if (!folio_has_cpupid(folio))
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = folio_last_cpupid(folio);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 222ab434da54..787c3c2bf1b6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -161,8 +161,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
 				    toptier)
 					continue;
-				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-				    !toptier)
+				if (!folio_has_cpupid(folio))
 					folio_xchg_access_time(folio,
 						jiffies_to_msecs(jiffies));
 			}
-- 
2.43.0


