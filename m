Return-Path: <linux-kernel+bounces-260991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1303293B14A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368FF1C23157
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795FA15748D;
	Wed, 24 Jul 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tchEVv18"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1C1DDD6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826088; cv=fail; b=kYsn8imNBzQjYIL15Ze4FAHJLSFQcEfBFDuA0NulrCK9ZZI48xrmV6mBmn21TUdc1isUS2J7OATxAO4zt8uuVffCybEUrSl9zpdWfEaPHQivq3RdTouwYA6BiCA9JfS3kpzLieYJ+CWg3g5m7OTNhi72AwfTYw5rdtq+Pc9J6EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826088; c=relaxed/simple;
	bh=4RL53TyXABv+z09SL25+El5InSf0tHke9Q0yZXBGtRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pMOE5OxtQetcrdAGxHZr9UKLVdwJB4mVzQVrpTqiXGcqNWLoMbUN4asvoyqMFg5+9BcFyztw4yaUxKeFMvmNncfkhPYO4DWwte8OUw5Do630QKLt6HUQUwSuEepH2kENYS0trp9nDkjE1njJG8mzn0FW6wmbQTdlkaagwBRYGGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tchEVv18; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9z4ZGbwwXS9S5F/jfmyudOgkHbciwouJoRA9UBNHyMGJHgOag1t3mBSVDbw1zAgsN3jpj+3ypfPbQRnbzIHq+NHW4j5xcgLFvxQUTAERetUbVzP9NPXr3kmDrILa6N5nsACCyL0BYrGbGV6mu08a6Lz69cKZQcdwtZtnM0sdxiQgFmfbNRYVa0D+2aEdJK4RAtzhW9yhewLtwlAJoGXsC4BzJKbAJx9oX7fd6myCQLaox1THurIGxdcygQvcK8NS5AGDSej06MNSRTWj20A9r6UoNCXgNHjA8qeKs3cL0/QAA6KaYA9nikPX3ivAQ8bOkXBALL6aEXXmGtnv9TF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF4UiEA4wU82ykwfKNn44Zy0CR5GrMNLSl7SIWdKIUg=;
 b=yolt4R2LgHQOAJsaubsZMxi6ppuEk8m1FucJ7dTBrSDYkWYpJ9JZeOevhNbausPa5vbvEhUXnnPmDVoEcu6J2WlpbUmcw5peOBz41+FQXOcN9nwNhc4ZKpETnMYzOmiUr1aREglRqaGRkyTrIZnL6M4EGnklN/JTxFO5aCqH0YqbaSrJaFyhZwMvrw0msNQC1ue0Ol++8AIztVhAtq4So6LYFY2ttrOFbaLJ/hBftXtpwZ3abmdh1s6NFBTYytE5FlJp8Lsn5NUY4LWv7HMs/l+QcZn/kQMaLiBkX93bv3dETZ5BtKgkMj4ijCCOUbW//a5QlXolLwPxnuVm8MwIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF4UiEA4wU82ykwfKNn44Zy0CR5GrMNLSl7SIWdKIUg=;
 b=tchEVv186QOETpCUKilziV2rEPCKlCE3Zlb9yx33o1d1GMK8TPpOwxUEfm+aySITGZy8Fcyo02kBC20XhNG5KqPuHBay5UAhUtj38j9jS509/lAX9/av6eshVNw9hhS+CWHOJ3Gf2KgMZsr3xAvqYiMIJYC8fI9LJzvKcJxn5wbi0562NYf+8tWIKvgElupGE3tCd3ygQfUMuIG8lHyDdiMnJ8CdViy14Lh1uqCwZNURXTRU4ss38eXRXl/TpwfGPik1HpksN84WP4qj/Kk3eZdUUVMMhxeSqQ9A9p7jPh8Ni6yAe5yTiLs526V1/7dqHu+jFg59FT313poKNc4QrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 24 Jul
 2024 13:01:20 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 13:01:20 +0000
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
Subject: [PATCH v3 1/3] memory tiering: read last_cpupid correctly in do_huge_pmd_numa_page()
Date: Wed, 24 Jul 2024 09:01:13 -0400
Message-ID: <20240724130115.793641-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724130115.793641-1-ziy@nvidia.com>
References: <20240724130115.793641-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:610:76::31) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1ca61c-409a-49d5-ee69-08dcabe0b601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4lVY2L5sPY1vBz9ZJcog+R5da7NaPth5CGMN0oPa96S1yTjWzAOk8x9MFe2P?=
 =?us-ascii?Q?t09Jn6rCxxdEvcP/omH9NeBPebdJJcASeSki8KwMELHn6OCcg8MroyB2miUN?=
 =?us-ascii?Q?pT90EqABIV2fHF5YTkNppsKIfJYtUWTp6Ir9h5XhRyYobSFNr3ZiqedSSih6?=
 =?us-ascii?Q?OB+yY6cG/YKDbZxVvdmNAiXNJO8yI8jdIbNUOy4DBiuCgbMJHDMyCizBWxmc?=
 =?us-ascii?Q?ezAR+5eRvuSPP+cRBTkNjBqlVgBacwIbE+7Jc+h5K5nTuGLmXwYu42PyHpzH?=
 =?us-ascii?Q?hmo66o/D6fhuMPkT70X2I/qQLi+zX6a/Zv1FyLaZcPzGXmCVac4mN2n5ioyD?=
 =?us-ascii?Q?q++0R8/GGgZtkkZXronYuEYtAlgwGDW8lFVv/L8+gNSDCOtZqoHnKseehiwH?=
 =?us-ascii?Q?cIqScRCzzYBCWNcv2/AIf02Q6Newiqb65G4aK1BirUxZQe8cA/4X3HMlrkGi?=
 =?us-ascii?Q?g1JC3ehhEU6Jxv+aZT0Cpjmhiuwm6PGZzONRFQnKgppGibLGi1jLOcteWozn?=
 =?us-ascii?Q?lMCv/ABfPoUedP1SNSDW7ZDxLoTxLMzq4IDQ/+Ixbcy27wVFxhtLz7FmgDyR?=
 =?us-ascii?Q?WydtdKHG8E1EmLUyMvhTnXyAQMkENPNuajVk9Q72j/uvLeRErXfxwrPzm9Hc?=
 =?us-ascii?Q?BGV+C8TJJNvg/tQee4DHo8Tvr4NBczYaauW+F5WWFBCr2XUw9dspGDckx8kr?=
 =?us-ascii?Q?au7CDoBUjWuWJJ8UzyCJN4/86qQEDLu2/kgxu+9Xel3blB5Uh3Kgz2+79BGb?=
 =?us-ascii?Q?LPwRNHTmZjYH4u4y3t+3IEWTNc5QfEJYcPfCeGmeKE1Mn/0iruZun39gmWse?=
 =?us-ascii?Q?Mtt6pRxfRRPZZbrExuPUBpbXzmfB17108FlnLV6+plIrIk10OHxyZYjY4S1b?=
 =?us-ascii?Q?eE9tu2hGhaROkglSU0OxvHhXPwkPW6w40L1bU4Ref69CHYCo9Yw6pi1U1fk2?=
 =?us-ascii?Q?ko371enplLTkpSlK+kVXo6gFmlxh47kf5WWXRJlnw+HSS+HvFxeio+GjKHG1?=
 =?us-ascii?Q?ZUypD9CK0Y2C8RkAo9qIJECdQkqvXAWziLPJiGnKHZeAHNvdFVkMSkL/pOJ2?=
 =?us-ascii?Q?KvHYHxXIWJd3Ut17wGkPJTO4h+db3lhcrdleMK8u/8S643M7Wg1X7oLfGLKt?=
 =?us-ascii?Q?hvc9UO1FxF7clvM+KQdbW7NTpVybBoh35iDDWRspTNVUe8QZYMMzel4WOCs+?=
 =?us-ascii?Q?Ku/WdZN6Nm+D6JHPM0A6CQUfJKeSho00feS4q37UHCSKl7GNrcea45wWSfM0?=
 =?us-ascii?Q?FTbtx/cCipdliHMeJUlesUqLecG1+HxwrXLd/BNZ5Nv2dim3xAxKH6UpQytD?=
 =?us-ascii?Q?HI18xXkdH5N2/QhZgod4LLHqCeVvnJSL2La5PdXyEsdJAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+BradzlQMkJcPuGzShRCMifRUJo8E8VQeYwim3XTATTZCxESEU0RslJvtih?=
 =?us-ascii?Q?nZcZmPrWv6jDT8OttmeF6Fstowlfe+ll917bPcfF+wXS83M2bzG6m8YZIoxW?=
 =?us-ascii?Q?dT75VA2dGvXSgcdGok9X5XRKDXPTfHVE/6tQf9LuHUplzcwW/9MVUD0iURx0?=
 =?us-ascii?Q?Hyhqf5ZavxBtshF/MkbttYMvvyAOZEClIb43fi+HShotCkyrGN8adInWUTDn?=
 =?us-ascii?Q?RXbwj+/GWHMwk2wuiJVS1FdlzHyVajarX7bKi6TC+PZ5UDB+BIofRWitZNMZ?=
 =?us-ascii?Q?bGUlIAhK95AiPp6JvSJwLNX6RM8jDa3mCeqUhytdvNJLqb7MZF+fY1BxVdiV?=
 =?us-ascii?Q?bccIc0uBfcEK3fPoVBlI8+QPIhPxK4eOZbr1P7Of3oVz/4p1ufNZWguQmnWW?=
 =?us-ascii?Q?CEQMV/xNWzSFOShPwRDZzGXexW4H16/1HwI2Oh9dNcKeJe64dYY3946ZWsIX?=
 =?us-ascii?Q?Dgz8i6hdvIqSJd/9+4zOK1wYvAt1GxSZJS/5ujZRS+fc3acVn0KUOP+2/ZoD?=
 =?us-ascii?Q?rVfyy+7C6sIsiqWclWTsTXaRgKBxinXKAht8S8dGJF4F/QdFq03diNe/n4AK?=
 =?us-ascii?Q?BwNXII5toDvinKS62KXH/Uiw7cKAlVlgisYWz3CbbSUZiPxN3j9Q2juDe8qk?=
 =?us-ascii?Q?i3RvAe9SZg0a/jbSVYpK1dRvYOIMpeqd0S2Tp0JPlzrukWGOfiOfOfk4MoJy?=
 =?us-ascii?Q?heFMGjMEl29MbRz7hBhiSjl+FRWRPr9eCmSAqErHLNjs7mzmN5wasLpVcdUo?=
 =?us-ascii?Q?ZMVr/RD52RLToa65sjiTJDRQLTS6zyCjgWZ8Zlx/8x94ign1IoIi6HtJG658?=
 =?us-ascii?Q?aq4OECtWzZb3NG0AE1VEPqFZPlCzEIorQ+A3eRvIIsZW6wHyDbKz3Pzc+KCC?=
 =?us-ascii?Q?lQjIzm8iIkcFMR9iG6qf2vfjCZ8RTPLPYfmW9AGAc+eDWWyGKQSIxhGc3316?=
 =?us-ascii?Q?xqNCNjdkc+TPtLItpRFjQKQWvsJHeZ3vi23Xheb8TWUgDPWFUF7vnySF/Kvq?=
 =?us-ascii?Q?zLg++SW0Mhzc80o8Il+Yn0jYnRTf7JT38cBpnwvvj2xJswp4HVNWvvpcXXuZ?=
 =?us-ascii?Q?nu9BWIplXAcjS3B4DYRYsbH5nKCvRnKU048idoueRJjngS0YGB7jgSjszOmm?=
 =?us-ascii?Q?6Qg14cfkD32LlAU1TLVSL5Dvi2AyAgTvoeBfTwzPJnPQeiSB5rgcF69sZg2G?=
 =?us-ascii?Q?mmlH4vDRL/w3Vb4aycSfNRKWLsIGy4PPcg9Q2pPuHSXcVxYNzgcUGbSo2Qn8?=
 =?us-ascii?Q?6mS/2AwxmmPGMoUdOcMn0Rm0lX95cNaJDPpG3VZd3x/WkwD5YCNo7U5VBYSY?=
 =?us-ascii?Q?V2wT2eKCyqIg14mvG3CVWx1OuuhmRJ2OUHO2AF1py41onQ89ZkcN4VdUbDqO?=
 =?us-ascii?Q?hC/K6ftwh288xxZ6LhXVX7Hnu2X7XKQ1ffwxAXLqu/f7MAGcSiv2G0NrlcTI?=
 =?us-ascii?Q?mjimbjQtt5iZUHdp65lIV1ItGFsgKSSS3jBnFEZR0BdXXEpQoa4RTAmSoKcH?=
 =?us-ascii?Q?Pl1rIM68a2dj1PkT/te9GLjHEDfTHXTVSbJ9xaH/Ct0wUmo+6iHA7PUthiog?=
 =?us-ascii?Q?vuJf3xFxMpdhFOdNK1k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ca61c-409a-49d5-ee69-08dcabe0b601
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 13:01:19.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y6nMqlNhwrk0oEiD/g1cVpkYSBaPTJTKg1G9uvxozmeVdRr2wfQCH407TShuFGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709

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
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 88dffc0023b5..15234b2e252e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1707,7 +1707,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
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


