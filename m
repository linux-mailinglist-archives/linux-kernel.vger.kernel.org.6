Return-Path: <linux-kernel+bounces-280226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEAC94C768
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15746B225B4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9915FCE5;
	Thu,  8 Aug 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nQPQ/rnW"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987055769
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160256; cv=fail; b=WLMI0ur4YEREVQ6T7jtJAKGAN/3+kZswmSh02+JvkRQER40HZIVFV3LKw9n0Th6X3tgCHPNSkN7fQWGwuVxTfWdTol6iKNONSzJZR8pnAVfQwu5PwknCfJOHvX4pPJRm4UmmD4sYIMflJCSTM9sebPs1HNprzpFdOtqVAxnZRUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160256; c=relaxed/simple;
	bh=HxN3RBYcqbdvH/vnF3uV1aL220VFL4jtYYG3E8RqyW4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eKna9s02W/IK1060YHmiPFKl0eMyFMzEQf/+dfYjhF39aUED6yDdQPthds1s044ANCYaRlgxKsxY2ji5aEOiqTdmn5xjAcqgLIk9AAq7TJ19C7b4bETDeGwLuHXATjeWnC6/CtiKkyui1j1H6fstlnXELz2tNfNZ4Y7VY7AddAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nQPQ/rnW; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7qnqj5sBcQRATgdLQCzG4doUSvajEV8xswTebcwjV9KaAhv+8sUA5JQfaS2EvxR4EwTfF9zcE3OV+vIwRUq8ZV3WLG+olHgFPUUpyIUkTR8d7yKnfTBHjPCQTvXqRRrpij9V64L34GCLS/lvgtu3M4A6kDFkq0nfJhG24zR4QhF9QPhslnyQ7WxDr3tY8cJjhjrMoxrEB6ISTI6ZYBwtDdqJ+L5ezHyZ4YAzw7tVpfZ0+4OIP5f1M41BaoY7A8Z8y9hZwgrF7diauvI8LfgxBi9Gy5AcSUPsIpnIVRfTHE8rpBIw+3CB0PksQy/ASfmm1AxLM3F+xD7aRKtig5ckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SBpyOCq2nBVCUIqsAnd9mjHJhRIz8EP39UOPaCGWQ4=;
 b=vAbhCssbtnyFmGznilImT5YqoyMR1bDyNbT08Z932pYOrWVJusGuSR2jjV2I2fIqxtWcVtXIGIkWymIan8/PU2mYRE6w98mPIKMrFjWbOgx0loaUpbuwS5mNXv/kgux6chxPRhqTPmsgc/xkJ+veap7bO75mQe28NpmZsePvDbavnQZRDo765JNyP4Cq1AQuA/VQh+YjPjtUjsMVkMLrOIAEq7bm3p7b9In39kwqpm9lKKH0GmiEzlDk+2YvjNwT4vltMzfgrN+NZzHte69rTvM0vPcMxVSokoZ7eoBpNoxP6/wNAb/zPQ+uEvAfrp0KnlFuKoFia1l0JA15fa0x4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SBpyOCq2nBVCUIqsAnd9mjHJhRIz8EP39UOPaCGWQ4=;
 b=nQPQ/rnWs83F6tBg3DDpaJyGWKqa62duUMKvv4nayfxg5EU7bdqSERH7LVr8MPxn+LfQytmQwTWFI6p5eWd2htgntK55eJ1LFsDwSRs7/CLfDCkF10eiYbwo1NeCWLrGnJIO8gzvbTnyaKP+XKtnRRb676hwD4q9KFV9nWoRrRfyWBC8Y+0DfmukZZGWzJ4A4dWPtO8d5dcBsmQ4W+g3p97i1cCTX0MO0XIRvYtiCub3pI/rHtCOUDS9mgNledZqg64BT9j2mF66y8kKUGp36E+V4JvyV5H3IrL4xARbupX1sfFkCY/zaNSAmJUgU9PgOi0EnEP60uI9Cm3fpuqbRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 23:37:30 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 23:37:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2] mm/migrate: move common code to numa_migrate_check (was numa_migrate_prep)
Date: Thu,  8 Aug 2024 19:37:28 -0400
Message-ID: <20240808233728.1477034-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:208:178::23) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a3eeaa-c63e-4dc7-b708-08dcb80311f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OO/tc+AHGV0H2YeEIQHBbMGSUbiNKhppi5agyB0SBDxGo+1HrJ1qXwke3XDV?=
 =?us-ascii?Q?Dk2Ze8tVt71kGLioCdV8X89/5rzOgxL7+RO1XZuVAsZ6oGbMtD15xXMNdkbn?=
 =?us-ascii?Q?BHuhvsqcjywEcsjrkx7Ofi/yg76tmdybbdhV3XNrZIryLlmg0TgZ3v1rCiih?=
 =?us-ascii?Q?5XO/16nl4DLVmiF+45KOgPPMDTywQB6Lw5oUiaq49t3OJfX4HH0etl2BYC0m?=
 =?us-ascii?Q?7QgYrz1QTGhfd92CJmuo6ZmxGGL8ECkBjiDEy5MHutLbXZISCsyazpn/1ThR?=
 =?us-ascii?Q?6G9Y7gNWBQcrrw/R68D3e1O9ZElYmR0z45y7k/94uYJXGzMdRraJ5QNBsU8J?=
 =?us-ascii?Q?UvpyYS8/ESQOcviN4Oe45rUea694z9iFMNh1dvT8VWnjtOimHWmC4zzeJfxc?=
 =?us-ascii?Q?Hos+mXZrZbBBG1ag3KZsT3D07DaR7GPxwWt+AOAw1sxx3F8Y25nTb9yB8/PV?=
 =?us-ascii?Q?XUyo2q6/TWd6agODwybwuufN9pvRSwumBfZ58i3gQ9Ixk1DaEnn/Y2QMQ1w7?=
 =?us-ascii?Q?A3LonETp+n7FqZY1njkGdiyt0qEAV0VRpAnbqHPFvrWAfnlKeeYGw2U9D2GC?=
 =?us-ascii?Q?pcC/6suHgedDKhepYQM3Bh8wxvPPcT8+fARTwBoC7rzzy45M9eXeW5F1HvtT?=
 =?us-ascii?Q?0pNbOXL55q6lJlJgjDD35VeOzHyBwTxqw5NIQMN4CfO7NXYs4MRnLRnoKScm?=
 =?us-ascii?Q?oNjGTDs9kgcB54KMV+xZXdX5fmmRCkqMDqf138bnR6wbZEn+kzRbKeMrsNvw?=
 =?us-ascii?Q?2V5YgeE+Fhlu24iV28b+sY8hvOBxBvGvU18Qb8mgcwkuiKPy+yyyXHgG7eUa?=
 =?us-ascii?Q?H6FyOyz21pGsHg17Mg+5Ylz90rXoZ1TMwiPpz4ymaH2+P8btdEHAEMYHOcpF?=
 =?us-ascii?Q?+MkLRghw3D2i5uM9ba/FcdDrc3unL2I3UnkHlO09BKFV3qeKaix5dU1VyxZT?=
 =?us-ascii?Q?DVRQMLB5fmJkALGZLsIhsCaOUOEBAfcZELx9V/0vj/vRtlHz80evBKht5TON?=
 =?us-ascii?Q?dTnl//xDmrNcQZZYrLxZF6dgLBLQSZziqGLfWdNRdQwTve1U4DpMEb9iqmJp?=
 =?us-ascii?Q?M+aOG2nxwVerVBbPbycmrwCdFQ9VHAY6K1cTlYckgsTxRtBncyAxsphJrrFH?=
 =?us-ascii?Q?RtpWJJNxTqlUU7cQ47IzBVOXJWRgv5267R6fWaSxbR1aoGOFz0pI6b2fKrOQ?=
 =?us-ascii?Q?euJ5j8UHjFtT7/PzaBY0OtuR3IoAss7gFW6ihyqruo8sqxRaUZSrMai18DTq?=
 =?us-ascii?Q?YqaKRgN/PCiJCvb+OYAtL+zsJHx9mr/MzlRA8MjbTS0LZHK8ZEIt6ziR2XmT?=
 =?us-ascii?Q?/ATYWoVhRkkifE6lWd0R/SPksmKevL6hYCd4K4Vyiz+h4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/EVWsqO3kZI+CsP4jQxwVlUuB+KK9658IF7JdronmbNlyuwQ4t8bIiw9FK7r?=
 =?us-ascii?Q?Ib1rMclduHjHOAs/g2FlnZAUShfBpHWOU0p3ZJfvcoNG4F+vBtNHYR92q7NP?=
 =?us-ascii?Q?f2DGzdiyUn+4dAY2FBio2ZP5qEPRvkrZdrHmMBEMYN+BzQUpv36YS6ziLHqK?=
 =?us-ascii?Q?QXyn/rk/wVm8ou2r9WjxlsyX1rhuFaPd1NhV2q8t+GqUc6lcKtahXyUwjQb0?=
 =?us-ascii?Q?8bR+RGu2/qsi4cdHbTsVa3Yid2SWSkPl5noD2Qqj6hNjdZzi5RIUAYEYuAVm?=
 =?us-ascii?Q?+U+3kdGBZNZ5Z0bYeJnfmiav+H0iVJSo7f0g9yf/zkqLHAxIOjuq2lTpuFmO?=
 =?us-ascii?Q?4dUco6P79++IVoR6tqUsSq4GfvTRQvK0VAMIgSEU4AxJCuQPUMBy5DVcdCZt?=
 =?us-ascii?Q?lY4riGXQs8+2yVIClpqaZt0hxMEvyNRQH8/5WAlRf0weAsDepwt9mmzgsB83?=
 =?us-ascii?Q?H22yPGdZcV4Fi6DF3cMdUInLak3bLARml2uAnnWnrNWEv1WCkti491gCBxP/?=
 =?us-ascii?Q?BmXFvNfDHrl0B+AE+hKwOnDNF2Uv1jxYDZj98tNN8wXyOOH0rPm1jLNPvn35?=
 =?us-ascii?Q?RtAYXG40bHQHbkhTNsbAZMyAfv+GxPO7pTGznlT2Gd6poND58XEdlpCSibjL?=
 =?us-ascii?Q?wBQbcXXVfGKeIh3PmQ7sxKj9m05HWLm0PjYc4xdJ4mEp7b4QqQQeTOU88O4y?=
 =?us-ascii?Q?oqgysvAC3IVUbRnk5Mr0ydb8AR+MVdflgvKAFgzRineXHssfvvBYOgdyVEj6?=
 =?us-ascii?Q?HohC7r83SAdXvCA2hTmjX+jwkgiNMbK2Y9zM6XJICj2+OAxgv/3pqUAh1bSV?=
 =?us-ascii?Q?9UCYtvn7g0u9uYnVSF8rcYy3ImOSoj0Gl1wWBT+mHaNT72XLVcr8SQWtWyv4?=
 =?us-ascii?Q?pkzfw2M4eP9KzlBIIRezZ66tAf+GusDm1cpjp78e0CNNwvVsUx7CmIkdwaHa?=
 =?us-ascii?Q?9hkCuugTCc178YAy0+OoCP/DN84kMlfyFKy33YzArMN7SDhYebt0rgcpoHLr?=
 =?us-ascii?Q?d5VWvLP6yUyp4/ePS2l7caTuTHEweiwKjeL8ioY3GT/DfLSZTovXj2fmMTSZ?=
 =?us-ascii?Q?qFxMEaOvMZlPhmK902XOKXhD6OCKmjxwsLcoi0vnt3PYthloN1CDqQeL3PW0?=
 =?us-ascii?Q?IH4Tbn+uOS8r2ZS4Sw2AQdtxlXHEuhpV7I0tk6XWof/w/h2Qk8jaugW0/aX3?=
 =?us-ascii?Q?cZ5EmTIHbEt9UoUYc0l57DVnKG/0rSZZQY7PLyn8mpMIZ/11tbUTmQUOwu3H?=
 =?us-ascii?Q?p3oozg61G06GRu6ZU/eHkAvz7tNip10WdADiYhfCHF6AkYW37dRLHfLyr1Ni?=
 =?us-ascii?Q?iPFVBDcAK47B5bBP6a5FtKj5/fKyLWOeSX535MJ2EGCPhy36ykRci0MLGnXT?=
 =?us-ascii?Q?uxeI8td55NJzkG/N3onrwjnoLVbMr9IAdOptfUt7VWGd9fAW3Y0F1d08kGwX?=
 =?us-ascii?Q?t4l5eXKihvII99+sFoOxrv1rnrxSalE124u5FYXlr0htCm3h5krl3k/5aWCb?=
 =?us-ascii?Q?Ggt3NenS3ZMSFZepl/bg7ZTB0yaOWTy0Xj82mNqTEW2eyDNA64RcPV4WblyW?=
 =?us-ascii?Q?3l2wRK2GCJ07qB8XsBk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a3eeaa-c63e-4dc7-b708-08dcb80311f9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 23:37:30.7489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0qa1zOQZxiGjFqUyGvnsigjSudsi2is6Baax1xLYoD+ja41Bv41zCEOCy5jznEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056

do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
reduce redundancy, move common code to numa_migrate_prep() and rename
the function to numa_migrate_check() to reflect its functionality.

Now do_huge_pmd_numa_page() also checks shared folios to set TNF_SHARED
flag.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 29 +++++++++-------------
 mm/internal.h    |  5 ++--
 mm/memory.c      | 63 +++++++++++++++++++++++++-----------------------
 3 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4e4364a17e6d..96a52e71d167 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1669,22 +1669,23 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	pmd_t oldpmd = vmf->orig_pmd;
-	pmd_t pmd;
 	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	int nid = NUMA_NO_NODE;
-	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
+	int target_nid, last_cpupid;
+	pmd_t pmd, old_pmd;
 	bool writable = false;
 	int flags = 0;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+	old_pmd = pmdp_get(vmf->pmd);
+
+	if (unlikely(!pmd_same(old_pmd, vmf->orig_pmd))) {
 		spin_unlock(vmf->ptl);
 		return 0;
 	}
 
-	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
+	pmd = pmd_modify(old_pmd, vma->vm_page_prot);
 
 	/*
 	 * Detect now whether the PMD could be writable; this information
@@ -1699,18 +1700,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (!folio)
 		goto out_map;
 
-	/* See similar comment in do_numa_page for explanation */
-	if (!writable)
-		flags |= TNF_NO_GROUP;
-
 	nid = folio_nid(folio);
-	/*
-	 * For memory tiering mode, cpupid of slow memory page is used
-	 * to record page access time.  So use default value.
-	 */
-	if (!folio_use_access_time(folio))
-		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
+
+	target_nid = numa_migrate_check(folio, vmf, haddr, &flags, writable,
+					&last_cpupid);
 	if (target_nid == NUMA_NO_NODE)
 		goto out_map;
 	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
@@ -1728,7 +1721,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	} else {
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+		if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
 			spin_unlock(vmf->ptl);
 			return 0;
 		}
@@ -1736,7 +1729,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 
 out_map:
 	/* Restore the PMD */
-	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
+	pmd = pmd_modify(pmdp_get(vmf->pmd), vma->vm_page_prot);
 	pmd = pmd_mkyoung(pmd);
 	if (writable)
 		pmd = pmd_mkwrite(pmd, vma);
diff --git a/mm/internal.h b/mm/internal.h
index 52f7fc4e8ac3..fb16e18c9761 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1191,8 +1191,9 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 
 void __vunmap_range_noflush(unsigned long start, unsigned long end);
 
-int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
-		      unsigned long addr, int page_nid, int *flags);
+int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
+		      unsigned long addr, int *flags, bool writable,
+		      int *last_cpupid);
 
 void free_zone_device_folio(struct folio *folio);
 int migrate_device_coherent_page(struct page *page);
diff --git a/mm/memory.c b/mm/memory.c
index d9b1dff9dc57..3441f60d54ef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5368,16 +5368,43 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
-		      unsigned long addr, int page_nid, int *flags)
+int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
+		      unsigned long addr, int *flags,
+		      bool writable, int *last_cpupid)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	/*
+	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
+	 * much anyway since they can be in shared cache state. This misses
+	 * the case where a mapping is writable but the process never writes
+	 * to it but pte_write gets cleared during protection updates and
+	 * pte_dirty has unpredictable behaviour between PTE scan updates,
+	 * background writeback, dirty balancing and application behaviour.
+	 */
+	if (!writable)
+		*flags |= TNF_NO_GROUP;
+
+	/*
+	 * Flag if the folio is shared between multiple address spaces. This
+	 * is later used when determining whether to group tasks together
+	 */
+	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
+		*flags |= TNF_SHARED;
+	/*
+	 * For memory tiering mode, cpupid of slow memory page is used
+	 * to record page access time.  So use default value.
+	 */
+	if (folio_use_access_time(folio))
+		*last_cpupid = (-1 & LAST_CPUPID_MASK);
+	else
+		*last_cpupid = folio_last_cpupid(folio);
+
 	/* Record the current PID acceesing VMA */
 	vma_set_access_pid_bit(vma);
 
 	count_vm_numa_event(NUMA_HINT_FAULTS);
-	if (page_nid == numa_node_id()) {
+	if (folio_nid(folio) == numa_node_id()) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
 		*flags |= TNF_FAULT_LOCAL;
 	}
@@ -5479,35 +5506,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
-	/*
-	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
-	 * much anyway since they can be in shared cache state. This misses
-	 * the case where a mapping is writable but the process never writes
-	 * to it but pte_write gets cleared during protection updates and
-	 * pte_dirty has unpredictable behaviour between PTE scan updates,
-	 * background writeback, dirty balancing and application behaviour.
-	 */
-	if (!writable)
-		flags |= TNF_NO_GROUP;
-
-	/*
-	 * Flag if the folio is shared between multiple address spaces. This
-	 * is later used when determining whether to group tasks together
-	 */
-	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
-		flags |= TNF_SHARED;
-
 	nid = folio_nid(folio);
 	nr_pages = folio_nr_pages(folio);
-	/*
-	 * For memory tiering mode, cpupid of slow memory page is used
-	 * to record page access time.  So use default value.
-	 */
-	if (folio_use_access_time(folio))
-		last_cpupid = (-1 & LAST_CPUPID_MASK);
-	else
-		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
+
+	target_nid = numa_migrate_check(folio, vmf, vmf->address, &flags,
+					writable, &last_cpupid);
 	if (target_nid == NUMA_NO_NODE)
 		goto out_map;
 	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
-- 
2.43.0


