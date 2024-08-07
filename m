Return-Path: <linux-kernel+bounces-278416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5F794AFFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDE0B21285
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF39142E60;
	Wed,  7 Aug 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FETmy3bu"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485471419A1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056472; cv=fail; b=iM7rAsqs4ukuLfScyjROqJPHZsCNQtEXDRVww+AWqpnle6QZluK88gs68UWO5fxv5lEVFr3EJuJpvg/q9ChoR1FT171eTPhfbk0wuk22sIghSN8/Ra85hHueSDGNsg3K0V2205+8S7sui6Kw8rqwUjBAoiwUzIMgt/joCicgdG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056472; c=relaxed/simple;
	bh=F7FVosElILQIFJHEHADUyxNWezGPRESfS06VoZUDl7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSWmk/W+lghgMg2RRywWjKyomrNmJKkRBELgw0XaM9s1DkI1sBOzKM9ufBA4tNU5i/bl3NRE+vZb3aJFMiNZhbjlTlNkELwDSUKHHSPuHCaJbGsFdPmUf8x5OlaOxn4LF85EzFAg/aFeOpFBUBpqai+VaSeY1kR/nFlG8ZgO2fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FETmy3bu; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Esb0IlDmlSIiHbYnVOm1uKUg4Tij+M8Imq9tIA53QrRYtA+IiSkDlnZJknslinig7+spOu7CGER/3ZEStsRBzA6NDpXCyNm6RQjKF1ztiYK30Gdsbcw/D4ugbJCnz8RSg+aP4hZtc95hDLiPClOtUsGWJvdSMPkucKKvXGRPVyactceccNOgRNGOrHQjVA4Nx3g3wDv/jURupUqSSwJB38r1NLVGSausfDxfZvpu97I8p32pSBWmQajpkjEamt21SNIMPuRf7sF4r84Juyd55J5bunw0vnCm7WjFlM1V1moOQCmcWQFzfMg9GWRcL1b/2bnAT/ZwoEsZ7WorJOiW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT/pQGYcgUuRIzmbUBqNmoaaYENPUPT2ty2iiEUcBpY=;
 b=jQp9yjOw7HLIwp6d8jG5Cyt4rv/bF3U0QlQ35nWJsZOJm35iX4pcmRAlcnAAsNtLKye9/Qe0hja2mbLkPeilvYhJ9AMO6eSHEe3j2+uV9dOvnS13asRyCAScexjQyGa53+eaoGvtSZQ1h2VjY+E6A9Ip5JuBQZ2vqHS574iEU905DWd6Bt4bjKYTvCFDOvAbl0K7uao1DNlCmLr4B2c6D5PB6iESuY1nMlKl0RBIG4exNNyVvasVNvZ93Tu8ejP//j2zHuU9iZsViwpr4wbLrfSrVK08imE7j3pb0wITp7ZpGDQFUaVn1yUS5MCSIEulbig/a9WKhWXm4suLZeEjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT/pQGYcgUuRIzmbUBqNmoaaYENPUPT2ty2iiEUcBpY=;
 b=FETmy3bu+fvUxmX4s4qz6FHF52IHVY9gzpv/i8qmvu376j0UUpsoNLEdAvoIrWh8DHF5K+c07FNvOyfNxTK7dO1R/UmF7HBmuq4ful7TJQeeHHIxzacIKmoNPL71VuwsiQuxlFghgJx79nKbPYJHtAalCU5Kxq73K04s4L8psZDGpOjsodXNNQkNJlErTgyiO63ejnQqiAWo05Jr4mUh7+jGSz9b5oLrI3Ao0I/ycAoySXrplq0reDjldnxzfdakyRqjDSwGF9kq0pfUQE5kvHQpIvgUpS7YKGQR4bx02/wfXifgf+1R72dhh1Cl9GP7XKb2hQlSOVTvOoX9nscNdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Wed, 7 Aug
 2024 18:47:46 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 18:47:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 2/2] mm/migrate: move common code to numa_migrate_check (was numa_migrate_prep)
Date: Wed,  7 Aug 2024 14:47:30 -0400
Message-ID: <20240807184730.1266736-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807184730.1266736-1-ziy@nvidia.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN6PR17CA0043.namprd17.prod.outlook.com
 (2603:10b6:405:75::32) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a17b7a-36d5-4a77-b070-08dcb7116d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZYBk/ff6knOYXlfLXHc2FeL9GEqvsFfv3LsEowfxpIryswFtIEgzsTWKwjE?=
 =?us-ascii?Q?ZpSugmDJR++IvW5BvLdbPjcqfAI6SnSEZ6E2azzpz/MVVfnakUOJ6b9v/tO7?=
 =?us-ascii?Q?/x38hycTSRV3/6fjlgjFXMWHE+xI5NN9KvLpNA3jCXjB4SGUZwXyi82Rpg9p?=
 =?us-ascii?Q?V7zRLzG+1dcROtSxKEFIOF1RzptjGHP9Qppyv3BKb1sE+4mNsvFIVadBae2Y?=
 =?us-ascii?Q?DxIFa/8NDZqjUJYrj4zUPzU6TANTDnN95Jo0F27OdLKyHGw7/tbE0zN+SH0w?=
 =?us-ascii?Q?wXZ6qzVn6Pqglr9Fasqyu0rD5OH4oG7ko0VTuFy4UzLEBExAKOjE8qSj9nn6?=
 =?us-ascii?Q?OpVyrcQHwX/XWNP8Mod5/Ck/z5O1HvCP4U58Cy5rZWYyehy9OIC8wCW3PbuN?=
 =?us-ascii?Q?ZGl/mr+JnBL9DwDCFp2OqRiaLfh8ijDRPSnuxCCp7eD73K/lyB0DEiGNuxBu?=
 =?us-ascii?Q?rqcva1WCKA9pIRluxLwpRu1LmPcKtoZLkrdXynydicIGBgQ4XYT9nzdNiC8W?=
 =?us-ascii?Q?IUyCiDNITq+gifcrZ7kYqkj0sr3iSi3uRSlKEFF++zTAENS0l7EbeCv5MQt0?=
 =?us-ascii?Q?4ekGRYPuvpjImPtuHpag4C3MtUCFzP2S0ubb+7sdQnziJW19XtE5tjbMblYh?=
 =?us-ascii?Q?TyAxtBgy2vwbvyD+nusddewfaoMIGR2eR8Hk1SUbCO9UGQoGeA++mnc8u76R?=
 =?us-ascii?Q?SiJYpT2TWSS5/mQCQY6sIfieqM8oPIXOzY7mkrlcbI5GtdaqZO1+833twDwi?=
 =?us-ascii?Q?jVKJxciYE3mJ7GizuEGaC3HX0nQq7JkIXbKcTHDyg6alfq1aBO4L6F9md8iX?=
 =?us-ascii?Q?4iHjy5FSOM85UrPtPotEZMSM8ZrfwQwGUr77ZipqX9ye8a31PmmSEHxW3hG7?=
 =?us-ascii?Q?Eo6KfheEw4rhF5XjqBDnkPF3MlsCQ07bjs4bMSLAwuR0p8NtACKjpTN8pXe9?=
 =?us-ascii?Q?eCqA8Pat53tjdeY/KQ2A5OdCvWGNEmeVLHMlvhD36WO19O1dbi+BSzrBAa+K?=
 =?us-ascii?Q?7icjqo+oVDQ4ZwQUiyFHN4+Kpid3nL3YTVwxpQ3dmAhPnoZL5ukTNl2fPTiY?=
 =?us-ascii?Q?ftVyA5gI+2vHIZB8yhdKnryhkk1E0BK12/iRgL8/9n52LlbVekUw3dFHH5Go?=
 =?us-ascii?Q?QPalD5gsyePqFQ8l0G2EJOGoLdceObGSXI2KnvsreMoLEdSm2CcwrxIlou5B?=
 =?us-ascii?Q?tfM6+1PBMG66C9n7QL7owmLPAa4CIRZGNGJDxj7Wz6wLx/zWWY2okKVQw+99?=
 =?us-ascii?Q?PcrtUP6tjf80TcXJZ4sVbi3z/+dh+UPk4QdIeEPxU9F5Z/VieoWGE+Niv+Sp?=
 =?us-ascii?Q?aD8rTeHXfCLE4pEUhIePmqLhlQk1aj3NkZxFVkpDppdQDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N4McOZpF1LlApirnqA2VCh2saTCVvUAyDFm5H69aSkdnMc+cHdY3NJW+E1zu?=
 =?us-ascii?Q?Dy9+8oiw50W9u1Hb719ATZ3I1iFKp1alozJEEbriNH3L7isdh+JJ/Zp20F6/?=
 =?us-ascii?Q?GqtEthnlYv/5viMHReO504JV4eqm5E4qIDGZqIVRzIjrML3hvr9mS8h6E9n2?=
 =?us-ascii?Q?4p8PgEicukExfI6+SuD4dEb3y4caz2TeRMJVmN+T9j9GUM+oJJPiwUMvtCiH?=
 =?us-ascii?Q?Ss/gJ6jTV/QOqwbH8ji//jyvRKFesaxb6hFIVIghN33Af7qTuOwBd8c3/KxW?=
 =?us-ascii?Q?jALqAb4K0J1R4LXSJRAdCc24yeLw8uGPfMECnIPOe7Q7zMmbulsomj5HOWDx?=
 =?us-ascii?Q?X9KESaupmKRKnF3dX4NdkuMCZWfZN/r34fLCEpxsIx/+gFJTt98yG/mKLQSz?=
 =?us-ascii?Q?UBh4ObhtW5tYpzYXbcmn9J3WeGM1u0shIZB+zq3rUwD+Q/WOS3dDpTHL/mb1?=
 =?us-ascii?Q?4lpj3kQtKyMOEeukVjkf16XdVLDXvwUpFmR+QwSUpz5hEkuR64KInJhtHKM6?=
 =?us-ascii?Q?KpMx7vXfj339UIWRUjCxbHmDxw3CXU25hMl6UF9Na321DgggoY1RtlV3UkER?=
 =?us-ascii?Q?cOXaxlzJ+7/G8nxA9NBFWi8LDpDnnWAd3YAUGN4M/OKAefxNKrXq2yJxU8cL?=
 =?us-ascii?Q?uXq3U5FbevbXXZohF1sCecHdeEWLL/7inM/D3YZNPlvj2YvMtsIX4QZQyf/5?=
 =?us-ascii?Q?3ShKpESnzudo0YVpOj4Bsa/VdmZHxAGy3sbszCZrjyoZfAnGVF4DKf6lwgLX?=
 =?us-ascii?Q?jMQIzokxm1HJNlqnkI+POXx4pAe4987AvnGPG4qOn6ItziCnFtqeeebyoXSD?=
 =?us-ascii?Q?npwNODR8DEZiRJe4QpMYTt0ypYApvxXtrMZIJG+n2ddFFZX7KUNCjhACGr8f?=
 =?us-ascii?Q?Lkhupq/Za24/BaZgYOaKCdgTzzZkXIjK4iwfyUpPvZxZV0AYGU8JPv02m22r?=
 =?us-ascii?Q?tnJjlQAPpEDqbBXEAQE2QabB9HOdOmwlCxL7Mytx9Pe+VTHwCPfvz2IU3DrL?=
 =?us-ascii?Q?85sUjMS0oLiwRqmXXCW2ni2pKQyiuc7AjJdr725mPNFp4Vnq+CNK5716nGfn?=
 =?us-ascii?Q?uSjEWGziXJJGZY4e53bGrujg58xVhDNwhqrdDI92IGlXzoTQcQLsGrY5cuWb?=
 =?us-ascii?Q?yyVMPgPkk43T3xPv2xZsaeYpLC8esSu37mNPAUvedYwS8Pic2D1MVYxB8a4W?=
 =?us-ascii?Q?u7l4mddOECfrqfuJ9Pqjm2AHMKo5gos10vaRfvFvFaIeH0cERyEVCp4A30Y1?=
 =?us-ascii?Q?hwyoMgxJDXzBaV1fscXyTktVXC5yMekWx0LTWauIFJnW3KeEH++0ksV9OmOU?=
 =?us-ascii?Q?8Ue9IXpULO1loCuHSlir5oBcmw0bpnVJ1U/ALzxf/j1jtTOOlkDVA6Vd31Rj?=
 =?us-ascii?Q?Qph9iqpsrYi41lxs3fdS2jOZ/1zebO67W9PfUjeGHeo8g8PN+iipWOWi/w0W?=
 =?us-ascii?Q?aQgiNtTRTyYYurWemWx33yOn1MkGCanclhd6o1ypKINi81fm6pMww9hDGyQS?=
 =?us-ascii?Q?TulyP02wOwVySBIOmGKNlGPFmLllBeqHkLlMk/3mB8X4YqMXOUpUczwup+4u?=
 =?us-ascii?Q?nAjhjoS24W1QwriqTK8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a17b7a-36d5-4a77-b070-08dcb7116d9e
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 18:47:46.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSCqx9jh/4r1uvFvLHtnHKAyzZdaBLygxR3FDGXha4CdGLVvNAqSMcALkfiLCe2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185

do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
reduce redundancy, move common code to numa_migrate_prep() and rename
the function to numa_migrate_check() to reflect its functionality.

Now do_huge_pmd_numa_page() also checks shared folios to set TNF_SHARED
flag.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 14 ++-------
 mm/internal.h    |  5 ++--
 mm/memory.c      | 76 ++++++++++++++++++++++++------------------------
 3 files changed, 44 insertions(+), 51 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a3c018f2b554..9b312cae6775 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1699,18 +1699,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
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
index 503d493263df..b093df652c11 100644
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
@@ -5442,13 +5469,13 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	pte_t old_pte = vmf->orig_pte;
+	pte_t pte;
 	struct folio *folio = NULL;
 	int nid = NUMA_NO_NODE;
 	bool writable = false, ignore_writable = false;
 	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
-	int last_cpupid;
-	int target_nid;
-	pte_t pte, old_pte;
+	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
 	int flags = 0, nr_pages;
 
 	/*
@@ -5456,10 +5483,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * table lock, that its contents have not changed during fault handling.
 	 */
 	spin_lock(vmf->ptl);
-	/* Read the live PTE from the page tables: */
-	old_pte = ptep_get(vmf->pte);
-
-	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
+	if (unlikely(!pte_same(old_pte, ptep_get(vmf->pte)))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		goto out;
 	}
@@ -5479,35 +5503,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
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
@@ -5529,7 +5529,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 					       vmf->address, &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			goto out;
-		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+		if (unlikely(!pte_same(old_pte, ptep_get(vmf->pte)))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			goto out;
 		}
-- 
2.43.0


