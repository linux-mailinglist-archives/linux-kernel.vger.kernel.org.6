Return-Path: <linux-kernel+bounces-417350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198269D52DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910D51F228D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF1D1DE2B5;
	Thu, 21 Nov 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VvLW3z6D"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5051DDA34
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215176; cv=fail; b=IdDtfJflSS/Zq+9MJY6EdEQAoJdYl7Vugb3fgq1kXNMLSoyZlxG0MWkTeeHCOrdsfqU/qZpy4/PvJl/SeWU3szSdZNoIrz9v4IevPqnAKRPfyAqzhamnp5B24/KcFhOh9DJmAUE1tI3fMiIaOxtjrDis/ZqWxWDIIzJl06QC8AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215176; c=relaxed/simple;
	bh=FNrXjigdhvkcFodLMCKqfeCb412QSIHMbfKubGSOS4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=REMx4dYjZLsmw6DxXxZYGfPnULxKkAJfewj2/1IlQ1zNuYJ3Z3e2CN7C6Ql1E9LvzGyIGeUJZlbAFTLB4piJtmTc1pT7Mi5UV8yXSTck7c1K15RhvDwlOO6XO6JkXIyLy9nHCajHYGtKzIhFKkciYokfkG9aRyYwypnR+ukAi0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VvLW3z6D; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6YGtIf913s95DqRdQ4qpMenjI7RaZEGcjzFL0BDpoHpXU5Us9fmNIAXVFlCOXkTE9jXao0w+oUNHuoFe+DMfxtl31yA2IxBPQQQDihaAbvAoLkV/5eXIkZ7lkCGUMxnSY88uhtJlqMo68Tp3pWEGc5JriVpe9W623SZycaTX6endfZM82zf+j+zC6Feyo27b5wJmrwroCSxarJp+xprZqAyPqV9Yl/Xy/yf2BeBOSg9/4ZX8jZ5rhBnbxxj9yau4j63LjqWsxfiYdlgRjZVRrashY9sh6lNPX5arocBQcgyt/wWlSir48vn5Jk4ufh7raOmojwCqFvqMG4XakxTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZxMul1WU308N00KYNlcxD/DyDEr6jnTyKBgAiwblKE=;
 b=IW12Km/Jev2dPiSdRCrrj1sQmX0RbqbaOPyXeD160FD/7SuSU+z3gk6SjRUfBP8QJTG1l8rASLSk6cYax2+GOBj/qhgIqsHAeiMU2Siv9tbEopF30NcChThM3GsUNIuIO+N+G3NGFcaO6NdmiCJQHpo02ve0cku+HSS58P/Ov3O1e+Sns62dvnNHE+d5qmHNEAjdTH3G56PwVPVRb2TQ2PEU+2JXmpVmzpKetOGM/pU/6bL6geKu4vxI/097/pp2J24oMAguyBoRjyy6P2f/LFrJKH+1Bh0UAy0iIgLPGxikzOJEoDbp1qZOHLwo6fIxqzJ9ns8RdgUa4GyS1w8LLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZxMul1WU308N00KYNlcxD/DyDEr6jnTyKBgAiwblKE=;
 b=VvLW3z6D3np/o5BsQn9FpOQw8X7W1MDC+7R/1N/ClAtmpQBIrO2sz2lSYRVUIensqnfYIDRMcS8lW0xtlh/2lMvci2WVolq6vR1GxW2Vp+8bj/5syOHRqPkCqr6pK6kqnQ8laqVgaSKEsa7o9ccyFDH4aAuOvNnx3vwz23eQgUkF2I/t4jCkZaEiX2NIZKdc0xpsaqAjRwzzQe+KZTWaPLfIkmNI43p4m0GxiyYUgrtROrktkJCyE40vBz/+8Xx4Le+IGUkHQ8BzO95HdZhNnUZWnRjlJfh+pDUzeJI/hdvw1RHK0Hvq8fGAR+B53Q3Q1mF+bdzSIc9pAKwuAGblZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 18:52:44 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 18:52:44 +0000
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
Subject: [PATCH v3 8/9] selftests/mm: add tests for splitting pmd THPs to all lower orders.
Date: Thu, 21 Nov 2024 13:52:19 -0500
Message-ID: <20241121185220.2271520-9-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121185220.2271520-1-ziy@nvidia.com>
References: <20241121185220.2271520-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::14) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cd1dcd-20bf-4a0d-9a8d-08dd0a5dacb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4UsN91yzlTcAIIPUjS+LxIcR1At9NZqa+nPI6BGO023zIam/2FCmeeSyFm7Y?=
 =?us-ascii?Q?sTaj/K6NCGWYEldkUxCmkxd2q02by1OMBCUYMlXYsoItQGGay+hgSXpZ4FRe?=
 =?us-ascii?Q?9XOq88qYTyhWHavtdf22wBAec8zIq0fRPvMqjw6mDdtLscwm0oaZZ/K2rwNN?=
 =?us-ascii?Q?g5cQuDixMwdCz21+w0v2kADM2414awntH2X9xbWE9xAYR/hV3upxF6Gg500h?=
 =?us-ascii?Q?NPKqVAFI8XAEAWCLC9yMsWrFzGdIkasw/tLhFQyBL6iYKQuPqd71DdqxSyQR?=
 =?us-ascii?Q?R+k9TQ7CiQ7jsBnjoAl/Xjff7UhyM0s7t02PjikgpbLZDUrgZT5V7vTC3Xtx?=
 =?us-ascii?Q?I8c6K+fRoG6Pe5ak575ZGuH8z8im/DCTino7fy1mUCVy+7zWVROcVlKVOul7?=
 =?us-ascii?Q?jCD1uVwa1rW8a+f/8I4VPHcoQk6OTQ3I+YCUG53rofD5zIHSj+/ZT5rCcnJJ?=
 =?us-ascii?Q?62QVz4/DCp7UebyiqJHbRTb5K/eVmvE3BXxv5mAcACMsboDwSi9HoOJXm5Tx?=
 =?us-ascii?Q?hDjzoBnmgshw0JTfdFQPKW9iyUTKA6I/WlOKiUh/Jm7BzF63j/dnL/iXSbEL?=
 =?us-ascii?Q?kZFJUfBBUbMVDkjCuDxepBG2nKDPBojl0C0VoyWgGXADBf6CRc7L4CK0myQ0?=
 =?us-ascii?Q?QNvQrIAG3Yxuwawyqz8M5cocThUA9bEK6iOfILiDc8TQs8vUMP/X1Mdq7qOZ?=
 =?us-ascii?Q?J8ZiSo60l06lDFT+udjg2Rf4aJzNX2MuKPPgYLHSrAjq8t7ShmWqRuRmdNWE?=
 =?us-ascii?Q?pUZcmm9W6c3PDbGaadneLIomRru4N4utXbKvMf5Mv+d+QjJCSsjXYcmYcF39?=
 =?us-ascii?Q?MItOLB0OSmjOb0rAVdiCPQ6WjrAPirN1W4qtQgJL7hVIBz/ddS/UPgN2XL8u?=
 =?us-ascii?Q?OANfsPds+Ex1eBeTQBvDhlFR8a2Lcd4TKwYgBLollOk52WDp5C6FLlR7jZod?=
 =?us-ascii?Q?qj1q6oY28MgdXlYe41bYuZ4+uuLjh1dZ75aZELSk34Hh0oQig0vYPMEHvEjx?=
 =?us-ascii?Q?G1YIgDZRpMg9xRWFNsR03NsN+/qCGxJfOkUKARa3ofb7LIxjx+DevT5y4GHt?=
 =?us-ascii?Q?T64tqXuHQnphID1z+VWLTsT2JkeXZ+De2vRrankqpbw/qMn2EzqUchkkgs3a?=
 =?us-ascii?Q?xwdPJYD+YPutHLie0rRz/KQb4KVtUJNwVkDAdvWzE+oq/BKBs3B4S2tEtK+l?=
 =?us-ascii?Q?vxrGeBrHIr4VLmwm3OcFsKE/u96LpBg6yg+coQrEs9SEpGmvS3aO0ygmLs2B?=
 =?us-ascii?Q?85Yzw6iAB4xNApim5lmQunZFxVsda0zk1SQ4stSO56Sd5tTZxuoEb9ZtHlDe?=
 =?us-ascii?Q?J1nakaYWMC12A4JTadwjvgLg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?alo0wEYHA4zfFcKYJaglvrWFwITA8oMBdAJna8Co3ZHko+l9TPOPS4yu4T4y?=
 =?us-ascii?Q?mM9jg/jlx2bATKMOm4gW4rvRgFEWuR7Q8D44c4JUdJJjIEkhwC2hLaTbdjWN?=
 =?us-ascii?Q?VAF11upmQFc+Ma7+25BcEArIenjAFuF/l4ZmQ+mheVcq7fLQhnaIu5GNXLsc?=
 =?us-ascii?Q?2lA64JuUH1iLguMzAaw0MHiEXMjMqD8MIZ33Xh6JsclpLBI0LpWFRaeI1Jay?=
 =?us-ascii?Q?LA+Lx+ITAgiVjkZPoVOpDNJ31DOhsbjagNU51884MGw13IrrJSg1ytylLBW4?=
 =?us-ascii?Q?bt0lK5u1vK9vCS37Et98Gu5r3ToaWQlw1SmIITQqJjPWsuxK8DYx4NvIy1Yf?=
 =?us-ascii?Q?SBEWdO5PhA0Q1ZGRdd2dzqakVvNn2ZuKib51QVtNQL422ZNWm/MSAm9N9pC9?=
 =?us-ascii?Q?cdJnVoToebXYSn/lHPAJ80g1Y6UTYvOOExof/ET3iiz2AzfmwY0FZ64USH6q?=
 =?us-ascii?Q?cBo6Jx7J9hLtNeSqGFHe/QR06u9ALjelPsLTCE4TyuP67IZKrYcBG+VdqL1Y?=
 =?us-ascii?Q?avazCDejQkrEoW3nTwFVRSVgvMZx+KRx/BTHzHPy/bxggBC67fwWNpK9fUUy?=
 =?us-ascii?Q?uYafkhtm5gBIAC4TjVXxJCrm7lAEx09Oxnn04Pstha70L8f1Ez3/QzEOc3pr?=
 =?us-ascii?Q?fnMfpMk/sov4z98OrB5UhG4q/z/XjP3JJ1zKndXvbJcaz5kHDJd5AnAFXo8J?=
 =?us-ascii?Q?yTp6ilmYzjAehPTPmoK02yyl2OnTXXhBzTqiRUOXfhuz6Lhtk7hGgazeXvu0?=
 =?us-ascii?Q?JbIA97zlElgRiVhTOi/no70ZwBvZmV2+Jni/ZxQtb1y/g9KXsCLt37g6UjPE?=
 =?us-ascii?Q?e+r0s9OqliYy5E6HxMTjV5VEUbnOE97nnS9RGM8EUV/Ck8XqQChhE7KRuzsW?=
 =?us-ascii?Q?Xy0/m7utuDZxFnQkMDj7Aw0Wph6Gkh7I2PBYZjbYZX0og52LzoxylH1CThAp?=
 =?us-ascii?Q?/TAQOYPmHsr2FLzxw/p39pqT4jnZO1WrM/lLOoImEnOrCjN4l67fMqC2M99H?=
 =?us-ascii?Q?eg6ttjpZr4ub27NJMwRhXPU981BeNYaWMeWLeWwP7dQbIm2HugeQMW6dQ4Ou?=
 =?us-ascii?Q?1AppjN0qGZOhgDSC2F/s+uwPz7NHMgs3Ad6EUYR3Yftfz8+dHfMDwss4fkQA?=
 =?us-ascii?Q?wR+N6p7FVdnqwzrFvLfbhj1V/g6Sv2q633/99RL2cCNgVRcr2qfomNhx4JoJ?=
 =?us-ascii?Q?x0HjKqDsBScB4zqtS7wGYH1ij7qFkm2ywAdX0St3kvyJUt4lkN/vh2IInbxy?=
 =?us-ascii?Q?h7iw55WVTqb8KspYNoVxEoDW3P3ScEXrEUbhkXm1PErLSGvJNMjduz86BcvB?=
 =?us-ascii?Q?0ksFJJE53kUU4EBuABYzMy3UvJuQ8K2SPs/cAbrrMsxZmAmtAVnAVGPl9CZD?=
 =?us-ascii?Q?Pg9Rf3vs2ha0Owz9Y4zzReVH0kXvNRdzF+snpNSZTR1/0lVkg9SRhD1K+lpm?=
 =?us-ascii?Q?qyrQHkEXpknoGcBD4xGH5dSWjJ0njBhuECtGluLD6+JmTDyJOiyHZoOZ1Ryb?=
 =?us-ascii?Q?lzKgBVn6coz79EjU+nsFKsx3wjwLXNjZvh7MteBoMoTR8NFRJpyVyXA9ZCa/?=
 =?us-ascii?Q?hZzLKg37vfCXrS0IaNOX+U6/XE4cUfEWPhxdcAx5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cd1dcd-20bf-4a0d-9a8d-08dd0a5dacb6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:40.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgdbY/S8zC9OIzXqtfBWCkGPO+SA/r8o7Wmabz5lEKYImm/C5/Z1aHSjHfFk78cJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

Kernel already supports splitting a folio to any lower order. Test it.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index cd74ea9b1295..5bb159ebc83d 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -144,7 +144,7 @@ void split_pmd_zero_pages(void)
 	free(one_page);
 }
 
-void split_pmd_thp(void)
+void split_pmd_thp_to_order(int order)
 {
 	char *one_page;
 	size_t len = 4 * pmd_pagesize;
@@ -164,7 +164,7 @@ void split_pmd_thp(void)
 
 	/* split all THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
-		(uint64_t)one_page + len, 0);
+		(uint64_t)one_page + len, order);
 
 	for (i = 0; i < len; i++)
 		if (one_page[i] != (char)i)
@@ -174,7 +174,7 @@ void split_pmd_thp(void)
 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
 
-	ksft_test_result_pass("Split huge pages successful\n");
+	ksft_test_result_pass("Split huge pages to order %d successful\n", order);
 	free(one_page);
 }
 
@@ -481,7 +481,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(4+9);
+	ksft_set_plan(1+9+2+9);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -492,7 +492,10 @@ int main(int argc, char **argv)
 	fd_size = 2 * pmd_pagesize;
 
 	split_pmd_zero_pages();
-	split_pmd_thp();
+
+	for (i = 0; i < 9; i++)
+		split_pmd_thp_to_order(i);
+
 	split_pte_mapped_thp();
 	split_file_backed_thp();
 
-- 
2.45.2


