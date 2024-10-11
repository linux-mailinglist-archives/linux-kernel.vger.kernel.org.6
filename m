Return-Path: <linux-kernel+bounces-361350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257F99A71B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718E71C20B80
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39171A269;
	Fri, 11 Oct 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gyicmjCB"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8C39FD6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659000; cv=fail; b=ERZlKHA5JGTbr0FmUuol8GU3LL3Upag7ZFBl9WNc24puzEAGYL1BLCAiGnQbWHGKtafm2VyJrevFAVO+ToRrbNK7EsVxv2Z5r/0ZaAf1PTFfXppmKGScXdjO7hmgyOmAfSTVNWzfHsshRWvCwAOSpgHm513habCkkIkr2j7Iv/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659000; c=relaxed/simple;
	bh=p2sNzm7AIQINhFvik3uTVwyToJEEWUFlWRMBnEksTAM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rcoXV706zYDLixFc1bhVQ60B6TIkTkohSTvvxSBFgoye/tn3JufIEPkOVqdD4pynY8qGm3IFhbtDW4AVYpCUyHd7OmPZRi8efw27o0FHr2sqyBHlQBYbara8KaiV5FIs2peRN49d+gUKV+HTsPfDGzQS/TiPxNUQUbeOsp3OvfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gyicmjCB; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkEe2XI4ETyo0Lhr6pJfa6BIRMv4pq1kelGAJPaZadbf89bEYcaYJAEGAuiJVZicsN6psKesfoBNlygq6E4TwVPxPzQsUk678NvSQY32mF2veLByipklKi90SnvoDgd4qLbFMGzsGL9Shnw8/fBuSTyXZoiQa7RDcYM/RiipfzWxHvvpTSNC+iVzV3z0vHT1KzA+5abrbmwY222Fprr+FLqLlg952J8Izh5n3jNyamGcb+O6fc8krAQMKiHkuV/DmJX+iVGfwahARFyl/BrTFbitSnOzJWkbLq9UlfUdvFOO5iLa8PN9LFHxNOsqFY6kmBDGcmBXiKt8X+kJbQEwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI3bTfA8oCD7MS7gEe8h7SX+aYPspElrPFvEqxHqj3Q=;
 b=Wz7ueWboDK9a8OK5csU3yywRhtFy1lGssgtYjBGWSP9apM5YCohCkm/MSXNUXhK4i26WaELkNk8ukWkxzWaeMkS681QMpadPnGSwta4K3p7DUG5DNV+oXr3KH67D+WYdIDpwYC3NisD9gxPAXqyqLWQDENiSDqEwluihRTTjxEaSU63V63jniEoxiJeH9w4zoC/w4zlMXCL92Pmc9dMRhlrNdG6eJN1umN4ZK5rdHJlyTRyl8rx9S8bTtlkr2ssYZrgoeQLOgIKHjohAVQj8AR6kA2L3HQcQ6Wy4nVIEQARiXzbf1NY5kXaGtCE0LN9A9pr1gfeyyGsjThFkNB90Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI3bTfA8oCD7MS7gEe8h7SX+aYPspElrPFvEqxHqj3Q=;
 b=gyicmjCBKR/Pr4t6kRVVAprZPXDvS7wPDYJoKiP38bya2y7Wq+9eL29Ud3/teeO6PItAuwqRM9awDtZYGT47xr1OuQ67t/H8NqvSvj9864zlpKDI9IvO3gnSbZ1S8AHmKfxJaIp2KKE9SpdCs1l2Y7LV8+uSrwi9J4LUgtT8+oBXWFVYERnxbgxa5imBKo19KQIwin+mJm5KJlkYFqwOg4R44l/V/WITq4sU++Zdhx5SJ2DXw9owrDujgh0RJgzDmKBhAwYADawx+u+/kmUayYwyKLJ3wRJ9mQZjOZla4hM2NQE7FiEpLyv9urhRvyd3j1ID3fqrSn+l0mn3csUEMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 15:03:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 15:03:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm: avoid zeroing user movable page twice with init_on_alloc=1
Date: Fri, 11 Oct 2024 11:03:04 -0400
Message-ID: <20241011150304.709590-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f946485-5e2f-4368-c491-08dcea05d493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fG0cYSP/+3/DWXF98pXe/xtgrpn0nvEZaP8+Mg4DMJDJSnf+KyqoPZXJGQlx?=
 =?us-ascii?Q?N68vyJBwOcYHJNdUPqazfwhFoWBYYZ6m/Ry5opO7In+TbK0QSTFXCGhBuKZB?=
 =?us-ascii?Q?xKqbixvnT2jYGZZmjdIHeGCseliy5VerUft54fEvbqwh4KFz3r4EGSk5pbFp?=
 =?us-ascii?Q?4pAEWAtiM9IbRGwXHE3x+g5VZPMIHwstotmnF58cltnOeVx3aBMd1HzRFt8G?=
 =?us-ascii?Q?BI3AGtuZbTQVFOQz1TAH8WbDql5LiXxyINntJmnmVQI/9uni/Zfa7WGEqIad?=
 =?us-ascii?Q?MwRniMqNZ+tkukTe4tljdM9qLwGvleW2uWWrI195PnaPvnFXxCQ0xV7wGpkj?=
 =?us-ascii?Q?zSSDwCtEysmuS/Z55tcpXnRfo07OB5KIhDmkH8j/WIEEUrpGIJ1B+s+BpHVK?=
 =?us-ascii?Q?OthsdSPFLBxxtFRXLrCaFfnu7Wh/GkCbE9B5XmiMkWYaFKGCKvs4Fjssgi4S?=
 =?us-ascii?Q?6FcZ5wxEDKnJ46cWNZsM596ghzkLm9MUGFLQgP6+zSfRMfxGxIdGFegelcPG?=
 =?us-ascii?Q?FgDCFeDjUOOHk0Kf797RHGhopYv7ES6yLP723LDftV/05WJe4ZqV0T627jzh?=
 =?us-ascii?Q?0bKhqIdbxoM0Gf6KFSnotnx0wnB6Gzg0/6GhX72/lbd9mrgneFz93rmnqQ0c?=
 =?us-ascii?Q?P30o4lvD+CQUlL0oUJ49PzM+HVhmq2LF6gUNCb72djIC37yAr9ooATfeSWHL?=
 =?us-ascii?Q?q+ySiuKBuP/r1uPmfgwO7xj09ei8PnseQlZjwHkXi/lbSfXyXTVnyWqaNv5u?=
 =?us-ascii?Q?nGBseRre0mYUYE3UE91GwMuWpWRcBTs1KJsqAasW0wOYMDN7EczCzC4qhatM?=
 =?us-ascii?Q?6trGcZCHGlLSn9xRVbs7Pwjrv+H5TezanwcCWUZddjcHSsR0pwyuayMWakYr?=
 =?us-ascii?Q?4F9rFsF9O25Ic+uZZIEVc7qY11QNffJPtaY4WF6lk/wXafR7ti01FCzC4WQh?=
 =?us-ascii?Q?GtfM+VK+yaJydvQN6R0zKTsHOuZvnDyhYVzkgZqPvWrSejsf+4zCn6oPFrOT?=
 =?us-ascii?Q?/IAu1esFTv+d9wpH5xWHuE78WA7tkCH6lcKNq9TwNjwqyjx8/JbUOPmIdbSq?=
 =?us-ascii?Q?2DRT3pY/nwEwAiTxFXz1eNrl80O8jfhZ1ofwFdHIV7z42+ejrsYlLZUs4aDV?=
 =?us-ascii?Q?RWB2lBDR8AovSpPNYs6ixKfnvtRhh9TBCeXmE9Xl89ovuFXoKwqy1zWAHf7S?=
 =?us-ascii?Q?TI7B9NCYWLTKdH/mp1EuW5s/oYkLrv43HDv+N+sHUf8MiiqCk+2Dtb/xaDN1?=
 =?us-ascii?Q?/HpPYOFNEMhDw2NrHnM6DCrLYeaVpz7UV4HThq79tQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BR8YS6hx18AU+xwmCrsejWeKc76vcYoui3az8jFE4iKYjKzTCHqCT7W/8nRk?=
 =?us-ascii?Q?wz+QVygM9Qifd+RZRXCB5rtE+Ua22HgWqbnv74XQ6WER7DKg2v8gx4Y98ttU?=
 =?us-ascii?Q?AyDAKOfGOxFp0Sq4h1H79eumDm7QAiv6RW8RFZ08t4vdAABiMEG/yC5pGKEi?=
 =?us-ascii?Q?yaYM9RLpTw3w5sL9gS5DRBiUvHtmKHZZrhVZ0L2bBttTUYJ9B+nQKWokKPON?=
 =?us-ascii?Q?qRgTvdmPBSNZUNAs226rvs0JupFVXUzpWbhY8UxTh5LCJu9T1uKTxUi7/vkK?=
 =?us-ascii?Q?RQvPfpTXMjKvnRnWoA/E51c7JK7oRkfMoe/jI8//2oI+HjBQKUZcs5Fh1gBM?=
 =?us-ascii?Q?rPGiHR7kbG83bQ/wzb9KiA500syx49nXr/aFvohXXW6jriaFa+511upk6gng?=
 =?us-ascii?Q?HiuRk82CQpsQyYDaq++keUqLTU2SPacnAG0esIs8tGW3+WFd6WjX7f6LZHAe?=
 =?us-ascii?Q?O6cbOLeZmEXyfRyV3POgg4YEIAj7sK/LRAaQ407XPWpbUrN3aDBnKbfgjkDs?=
 =?us-ascii?Q?3Wm3eWE5zNZCcFSxDeUl+mQhGE91nQbNycl4W97by1yOIE+QGLuwPL3goEMk?=
 =?us-ascii?Q?qSpBLlBH+JfIGnQOpAfNnS/NDbepHD1mkwUjx7GB8ipacF4LOrXm2S0SWXX9?=
 =?us-ascii?Q?VCXARhkrhOe7G79hWyq53o3qld2uKljAgDR1+63XPNiY7AFODihdItEOctgW?=
 =?us-ascii?Q?mTT5XZi0iFk11XdKZe940EPfwcHTxsGhnHNRrWHiyCMfk35uST4wDAQxB1QF?=
 =?us-ascii?Q?DR5WdPHAznZp2DBai2Tu/FfOwzXuHKGDyaeqsYc70dakLknWkh+cnyhc1mFf?=
 =?us-ascii?Q?c+Au8Ydse21RKyciMnXY2JCtp6vDMni2Nvv4jBfG996+lF9fF+/AAFvEDfgo?=
 =?us-ascii?Q?uXt0k93wiLrkam3MO/dekbXJjk31je/bGJtPtytawkeOeXH6rhKLph+F5uin?=
 =?us-ascii?Q?2Ep/N/6mQ9EJTGrEZmKEQ0SON31tgW46ZTMUl50g9/8CkVYqzgCmnJX5UNUH?=
 =?us-ascii?Q?m7UpXNf2GL38J3HOC4/z/qnzD7NCGiesez3lVCs88YhEYTerXqrDbq8Dw0EV?=
 =?us-ascii?Q?Ni9Me2VBugK5ksx6A+/owp8y+QQAib+A9aPBNNo/sbVOvM6lJyYnfLAvDRRi?=
 =?us-ascii?Q?Whlv4vxuDM4jbN7UCl1Q8KbiaNWCG1e8qjsLBqb8TV8dbncZtVMwbxjjVg41?=
 =?us-ascii?Q?MCAq0PXnhZy6sk5BxUOVzgrjtvOYl/mk4jioFNXpSFITeG8m5dNBejEXEIrs?=
 =?us-ascii?Q?icvWUrKl8hqcl7pthk25lJ1FADibCoe0cYULlI/Pws0YX3Flu3vhGbW0Srdn?=
 =?us-ascii?Q?FcYECeiGdPn5La0haWBJf77z8sUEDeaIVTpe0VMPvXfLLzM9ymo/QJomiNco?=
 =?us-ascii?Q?OOrERq9p/6KBvWIXYH9PzpkPcWkCv5hqwTQm2cOIKdQIWaPIf15xAhONtpcF?=
 =?us-ascii?Q?ORHcnCiATS4KXFwdclvDvCSdH4XQ0fJzwKTI7VFBKwymtD79R0x4lGqH8J+E?=
 =?us-ascii?Q?LG4QQOvECWk4nOZPYWhFSk5OBgmemjrYLImjlDRrhz6d3G5D10WJTfKO4WQZ?=
 =?us-ascii?Q?fzVL8hTcz8yzchsLGw8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f946485-5e2f-4368-c491-08dcea05d493
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:03:14.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 148YgHeoR0jtCr4wHvsjmFFTfubXlI2yEQ3meywJizIOI2Ydh7IjtDcNGiPKurR9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776

Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
init_on_free=1 boot options") forces allocated page to be zeroed in
post_alloc_hook() when init_on_alloc=1.

For order-0 folios, if arch does not define
vma_alloc_zeroed_movable_folio(), the default implementation again zeros
the page return from the buddy allocator. So the page is zeroed twice.
Fix it by passing __GFP_ZERO instead to avoid double page zeroing.
At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
define their own vma_alloc_zeroed_movable_folio().

For >0 order folios (mTHP and PMD THP), folio_zero_user() is called to
zero the folio again. Fix it by calling folio_zero_user() only if
init_on_alloc is set. All arch are impacted.

Added alloc_zeroed() helper to encapsulate the init_on_alloc check.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/highmem.h | 8 +-------
 mm/huge_memory.c        | 3 ++-
 mm/internal.h           | 6 ++++++
 mm/memory.c             | 3 ++-
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index bec9bd715acf..6e452bd8e7e3 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -224,13 +224,7 @@ static inline
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
-	struct folio *folio;
-
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
-	if (folio)
-		clear_user_highpage(&folio->page, vaddr);
-
-	return folio;
+	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr);
 }
 #endif
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 82f464865570..5dcbea96edb7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1176,7 +1176,8 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-	folio_zero_user(folio, addr);
+	if (!alloc_zeroed())
+		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * folio_zero_user writes become visible before the set_pmd_at()
diff --git a/mm/internal.h b/mm/internal.h
index 906da6280c2d..508f7802dd2b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1233,6 +1233,12 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 	       pmd_t *pmd, bool write);
 
+static inline bool alloc_zeroed(void)
+{
+	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+			&init_on_alloc);
+}
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
diff --git a/mm/memory.c b/mm/memory.c
index c67359ddb61a..88252f0e06d0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4719,7 +4719,8 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 				goto next;
 			}
 			folio_throttle_swaprate(folio, gfp);
-			folio_zero_user(folio, vmf->address);
+			if (!alloc_zeroed())
+				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
 next:
-- 
2.45.2


