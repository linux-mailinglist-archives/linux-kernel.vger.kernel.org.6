Return-Path: <linux-kernel+bounces-417347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5949D52DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4112281E43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB61D9A6F;
	Thu, 21 Nov 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RujNHeDS"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5491DA2F1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215170; cv=fail; b=lPtbH4a02VdwX+3oQUx6PbN46NBrOiXRPL65W7yPfXOX7G7yzRhcjyObX1Cc8CE8kXvNFmpdwR114bdRVJT+27CR8DEA18849oy9Tg8/LAFisdwTqQDS9vh4nKKQuJd1nxcMEuy1VQ3RIGGLTacamQFvGC3XMQogLCS170ABTeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215170; c=relaxed/simple;
	bh=4Zw1R0HtvnXeB7PudjwI1pYEqqIrKCiMLEQsNwehSDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s6YuRPjBiXcUH3ULTdGyg7c/etfuDnbLUnoHQCFCreMBwlPZK+87uuJX4hnsqeSXTKKB1yPG1fYJNhaVHUU44LMpI4kQMrF2aHBUcP8JRUfTBuifblRArBi2JcoiFL0BoB8iIWWdDa96NJOIUol1mk1ywUnajoVJgv92DiGh+EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RujNHeDS; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSPv+fs9iJ2unUBNZipOgTdN4vfGnXEKz6RKMmQTP9x5SZ0ff/R8OnuTQ6SLqRTP/qQAZQrynSQ4pQicumnyKGiNTP8E6+piyttsKLQhK0SY/ENbSM2oBGfEcIA0t+Z3inZj5nnEuh1ISS3uBg5AdbuwFTlfkwBXhwvTUvTGNP+gsFT7iPdKbER4DMA1Joozd6cP5zu3uM01QFJPBJ5+mwqDwv7sbl4GJeyZTI6RRM3u2s6ndtgxLRnhVBTuu3pEMbDqbqBLLhc/d0buKYMgm7zu2jR2etplT0Nya8/x+IQnsTEnKAFji8xMUzvZ1iFNcLErYrf/w1JPE55BX2KPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HGXumwoHzdRg37AsHGRuosvSDyN0mCdwuWzz5mHCIU=;
 b=iR6XT8D/0/YK6PwhWF62hFU/08T0oN9NeHLLMPNP1kXE7MDxFRDoQCdINtmmFajzfaDaa5Fuj8RkzW0pNbHIvwh2fedZXBaIdj1QFHiTxiVhFHkViKc0m4RpootfTzsBLabxBokD8dD4nWSP6Q7AcPA1rDYLleLTSP05QqZkOZtl/WCcfK8Na5p/4fMnTb5tYrbGLzlgXkOVRADn+f8NHgysAsQwj8omGV1w+regJkvKIidsPo+s2t8v1eo9KUHNcoqfQ/xCx1VLDdIb2QNvl+FTEYbFTDa23l3L+y/xspHOOxrVcbhOYy4EDbzz/VlvnKa3pPB0oyxCgct/8Jct8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HGXumwoHzdRg37AsHGRuosvSDyN0mCdwuWzz5mHCIU=;
 b=RujNHeDSdEzoxgjtTvnBnE04SwFeh15hhhyZBKLYsMsqInU3UYEaTp3eIaDqYCHP1G8TsFdRUVXOcUBQziGOljICzEXPshqyRimt3Oc7pRwMJE6d32tT0jyIKm8FOgihsLSNXt9PSmcUsxtouV8J+mVjsQ9sU9rH9EIPdn3hMVTfckcSPOQSjjC6pA8eMFtDxMVpojkanYpjTp1NUolE3O6/Cbta0rKox5bxJpu4DohqY2V5cAqH3UQJrE0C+dtJKP3sOkmfMWvML399ykXD06+93shWZHgQ7sP3Iahm4v7slRThEmGZOJfirDbHZzhWDvGHPt5ONia60FyZddKeiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 18:52:37 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 18:52:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 5/9] mm/huge_memory: add folio_split() to debugfs testing interface.
Date: Thu, 21 Nov 2024 13:52:16 -0500
Message-ID: <20241121185220.2271520-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121185220.2271520-1-ziy@nvidia.com>
References: <20241121185220.2271520-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::29) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: c79adceb-998a-49b0-a5a1-08dd0a5dab0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vXnuoGP1qawLOa608c40GaFw2jPpUhH4xvp/3WjxceXrk2vidFz8bX8IUJTn?=
 =?us-ascii?Q?GggqrZAbeU5S0cpflC6ybnElUGzoeHFzG4KOPjRkAGyKIuwToLBvOBvh7Hd+?=
 =?us-ascii?Q?t97Kj3vh/EAHh2kjzLQEHuz+W0TqZAMStYUgvIFG9J9x8N+gCHaBXy/RbeWL?=
 =?us-ascii?Q?iZGiDAuHc6ayvaOcnFducgixf5GTipvdr2LHfL0zuy9+mdZBR5BO1IiVVepL?=
 =?us-ascii?Q?I/BHHspcdoDBOeeWfSLS7q8BFPpH0w0zQA7xgGAl3Bbk1f+wwKpnBsOc+HnA?=
 =?us-ascii?Q?2uh8hP4HZm163OTe/bXnNhbFXivH0MYc45tM2HehsKwappIUIEYzUxiTozIo?=
 =?us-ascii?Q?xn/Xi1NJItg1sE5MivdQe1y+lGPWBPv6HHKeyOO+7MqYmvtafDqEzu/zEO3D?=
 =?us-ascii?Q?UFXsLMWbK7JuhDGLxq4jSYqaLuGQBjIYDiYKtZy7t9uYfkLPmzGwOcugouUH?=
 =?us-ascii?Q?W7Y8BsOonw9wSdsbcLVihC8sMuSiBb31AvKf4MpEj4xVj/ZI2sOgatIBbCKr?=
 =?us-ascii?Q?LTWOkbEK9I+Y8z4nA0/CYWR59zqmb/B2m+8b/NmckcGocNNnlWQg8G2UJywS?=
 =?us-ascii?Q?rvXkB3w2rqj9Urloptp9mXRCTZegBoCWyHQQjUQxP2RZTn2h/KSjOUQ2Nxkm?=
 =?us-ascii?Q?YrZJXE79a07OzNU9d1JZqC7asR5rJ6CovTDM/xdBl84nMZ6ZfJzxbQgOVsht?=
 =?us-ascii?Q?42exE9bCPp4AprljRbJXEclTQDo6nlgF3K6Fykp2wWoKavX5FruAfadHhHxi?=
 =?us-ascii?Q?unkB3Dbmx0hay0tcdbND1JGY1RO69hWWwWf3n98lN3GQ2au+AF6klMqxXBY1?=
 =?us-ascii?Q?lOcGmStOH6tItyXB6RcJyVs54UrjZpeP5OhovrjFZk2OOoml/Jy0LBPclKmu?=
 =?us-ascii?Q?4k2SMrSIAak1xV1YBMdPFv7QY9SMyqYBh+4rps5ExtAGxQYBa14X+nriuzys?=
 =?us-ascii?Q?vhiRtREEBzlOTm9TNGOXLi+QRE6YxI8ZRTzd8/fZDZxXdwZd3JYLMAVQn8Ta?=
 =?us-ascii?Q?yCct5hjItpFa/tlwAnUBfVaGcXFPFENttVN9ujI3t4Blgqa8y1EqtmmX0HkM?=
 =?us-ascii?Q?lpxnYioXSJhn/kSthC2hILG0602svfW8uoPm+CK5FYGrQpgU4XsmzjH8JQlz?=
 =?us-ascii?Q?mnPXkDzZv86wloUlHkkiu6uN73RMkt03fIc7wFVkg23dhljb1F7HWmAC4rEF?=
 =?us-ascii?Q?YB0qfcIMehvWd+m1itsXqjcM14Lf7iNiwvCkde9Zlgf3coFWp0MFjD/3sO9h?=
 =?us-ascii?Q?1VW1vVPCKS4XJwKECmpsRfaJy3KYEPnq5VYjqptt2gdFvRwSklikGedXhxiP?=
 =?us-ascii?Q?suGPfj9ZQo569ROXzQ3ja3rO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gHTBYSsW0QqfK5I4Nse5wRvUlbX500dPo/0Ua7K8ySIszewKNJl4Y76UUoR0?=
 =?us-ascii?Q?M96anZ1vQ7aF5N/ajw6oUN2RoeCkqob0gyiV7xvWYZ+UfOL5P8wbpf4Q/vcE?=
 =?us-ascii?Q?fEmhT8lvo2zzctHe23ZgBl20DJ125cDCe5l4XOf9Cr/NlPdXhPXiDL/DrGEg?=
 =?us-ascii?Q?4L1KmUqx65Z9T2CLrxVPy+GygSH6AAs0ySfApkKecEjOFKxsA92cDPsD5IqZ?=
 =?us-ascii?Q?Go77K7WHcbqP9Lr63JOOsVIgctSBLwzlYkILYfB9adPdrd93G9V2/mTbip4L?=
 =?us-ascii?Q?jdboz0p6HWl70JAA1H9QpLfaZOKbceF7ai8JQd4eOMRlEH8kkoG/7EFhW+wL?=
 =?us-ascii?Q?R3QE6k6QLICiDg+jixSmYqGBLW3qOc1f5YUQ2cOq+wPvKzW1/tkEYLtEC67I?=
 =?us-ascii?Q?i1XjJ8Uhcodn7CJpT+qgYMRsxWjqYUTLyUGmiudtCb94PGEiHIwQZLxFewUg?=
 =?us-ascii?Q?2VbCRnBQMUHpxvtVYdQ6z9WEDUIqldqc2pNtimyaBhRCqOp/Vcp4W0iLf/ay?=
 =?us-ascii?Q?TtH4slQgSTPCAfzzh7PkPa6caRhlgDE/e+1I8zE8nKS/K3xiVd3DilKTSen1?=
 =?us-ascii?Q?oDfN6mV6Ngj6VbePp7EScD61YQd2eTVctaCIvaK5tCJoBmqloPaYUDVNjVV6?=
 =?us-ascii?Q?CI+downl0hkkgB8V07vP2NmsqLbQnrZ+mRFXuqjpvfyohFArfqVXH0yL892q?=
 =?us-ascii?Q?rnSNuNSAu8wYts11U7i6NXx+M1c8VxqUWK171NJR1uUdhxhM/6GuGV5+Kqcr?=
 =?us-ascii?Q?hRZ0ctBWzZ/mB1sYvKNvHu94zPqG1eENtvNOHWziE0iJOP5BSD8KNAsEmmxu?=
 =?us-ascii?Q?N1Pb6L3oz8xmpvZUNITp3klKVTXgg0ZSkbnCR+ICho+e2y7PfhcnkjuQzXga?=
 =?us-ascii?Q?an7AJ/R1VpF6NduM42V7O2V0ZG68ZVHh2VNQ7+7LfxKJRh6Y9hptd9hyzLsp?=
 =?us-ascii?Q?lYXZbFQD73/L/7caiOULdIZzLUMdJfYwSivnYJ+qi17smrddXf41uc45lOKt?=
 =?us-ascii?Q?SU7LcmC974Y5fJX01VEpVbikBTjkCPgKE00sjgMMZrlzCyUQkQ6vqq+X7fJ+?=
 =?us-ascii?Q?TKvvXyTWKDMMUW2SlTZdxqUdV3XRq1UgVuc2KX7kEPWegK3fSdjbebo2qzsC?=
 =?us-ascii?Q?lbUlENKqyeO56JelnaDMpuML/oJDvYapVgkC9/4S4s0kGIsa1gVDevMHA7w3?=
 =?us-ascii?Q?N2KethlHPwDpeB/cWtYYL5DhzDqJjdqi2MbacylA5HEJJBjN7zGCinjORgUw?=
 =?us-ascii?Q?bar/71zQGMNVbJsCtGX4BlKkNwnxdOK65clN2K0J6zB5DztPtZBqJQxqWjLM?=
 =?us-ascii?Q?ytr5+5nNkIOckkR9t8d680rBHlj8cB/WvN6g9su5KQE163nTsCSF4+FypCXa?=
 =?us-ascii?Q?6q85Whv6L/MbFU9xySud0N3Nqo+pIiDKA0/xuAWIcrJD/i8A74ivYrIeyAY+?=
 =?us-ascii?Q?+a85p9IjsfDEfGr8Dei11ZOqf0ZPe2fue9e4/o2AeJk+t31gpGv/hMlWMe22?=
 =?us-ascii?Q?RSQ1XVUqQ/wldvlAysq1/vDDQ9vOmOypWzHxzmQsgNiPocCrJ/ImTHMV4lcE?=
 =?us-ascii?Q?zbUERZSuYsrbK0KMDGs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79adceb-998a-49b0-a5a1-08dd0a5dab0f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:37.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOKdW++/Oivdqv9sxCtzhrb5sD1Z6Ax21qBrLEQhyb53LHoDT0sjAd0Yn6Ufksm6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

This allows to test folio_split() by specifying an additional in folio
page offset parameter to split_huge_page debugfs interface.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9b3688870a16..9133a69c9245 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4141,7 +4141,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4225,8 +4226,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_test_anon(folio) && folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 ||
+		    in_folio_offset >= folio_nr_pages(folio)) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 
@@ -4249,7 +4258,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4298,8 +4308,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 		folio_unlock(folio);
@@ -4332,6 +4349,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4360,29 +4378,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 
-		ret = sscanf(buf, "0x%lx,0x%lx,%d", &off_start, &off_end, &new_order);
-		if (ret != 2 && ret != 3) {
+		ret = sscanf(buf, "0x%lx,0x%lx,%d,%ld", &off_start, &off_end,
+				&new_order, &in_folio_offset);
+		if (ret != 2 && ret != 3 && ret != 4) {
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = split_huge_pages_in_file(file_path, off_start, off_end, new_order);
+		ret = split_huge_pages_in_file(file_path, off_start, off_end,
+				new_order, in_folio_offset);
 		if (!ret)
 			ret = input_len;
 
 		goto out;
 	}
 
-	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr_end, &new_order);
+	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d,%ld", &pid, &vaddr_start,
+			&vaddr_end, &new_order, &in_folio_offset);
 	if (ret == 1 && pid == 1) {
 		split_huge_pages_all();
 		ret = strlen(input_buf);
 		goto out;
-	} else if (ret != 3 && ret != 4) {
+	} else if (ret != 3 && ret != 4 && ret != 5) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order);
+	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order,
+			in_folio_offset);
 	if (!ret)
 		ret = strlen(input_buf);
 out:
-- 
2.45.2


