Return-Path: <linux-kernel+bounces-417349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49279D52DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D4D2821A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759461C8FB3;
	Thu, 21 Nov 2024 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SH4eZC1U"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5951DD0DC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215174; cv=fail; b=EM3caPi6rT9k3+LyIjzmBwy4/NuVnJ6OhDLI6XrQjZ6Jw4jiRtcg4hOtPQjYrdqnbB5WlXiupKwAvQfKKcw3s99FCHI/BAIS2hJJ9l7oSuIF0sldSYgcVnWiwXV06CcZG9OXigdpb9Vns2yjiIgAc9YlETAJuD90clcMAjNBqWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215174; c=relaxed/simple;
	bh=cSAUK/yZ/DwlhsMaY5PAROSuKyoT1axfD0PnzJDnsLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0u+lNrDWx/g2aKo+P7/3hNE6GmW+Z42da85uH93p0V7/52Yg/EAwnSbk3VvEzcqtJ7cIwIawAQY3o81II2GQNscpdwB4P+7fj6DShO7OyFs9aITjOQHMuzxVeMNJZbOXXzAj2gWSUwltCeLYkf5DVXa9RCXAnY4dxIPvJH7XH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SH4eZC1U; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/Csw/p1X2djkp11x+DXYWz5U64lzS1pdBWgTZaB+kA8LF1KItXmpyG7vS6P5CsVM02QV0R6hcer/imF+VYQNB4svxj1AddlK7ZjxLOHEO7QIMtL0vFggL1pOSuk2UxvDcnKo/P8DpNSlrGRa3wDckFu1f5CsmVT5jMvs0PnPyXSSVj/+6sWcQJ/t1bh1fj2XHlsAVtnv66kjKqU2tTjjf2R0QCSfFJlk+v+qzf9l8PHHqLMUDL6iDToeIKtFm/75M/VFHF2CBVBgxeroq9yFryrImBfjPD2pjqayCFeCmWA0Wv002w3kjnshOIVCYppkRsV+G+oVGNleQ8FPLSzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lwTVNAVLwi1gyG41osM9o7VeGen/aJvxEZw1mntkp0=;
 b=GoMHTDNsokudkICn/molsWr9HuDYQ20jowzaWuorlfBfWgNtz88rtvB2AkNHeUgOoRQneh+1wsBqbvy8T92+K3kJTKLEtznRK6yy1/vfaTEMFoTYUOqLcPPw7jfKJNLUyV+UzA9UFiiPFmb1um8us62mPNNqdcjNpa4EONDC2YeKjyU52VDLXYeL45v35mkIOlpL/7wYAC9i9sMwN2iwkKjxfgnvlGstz72kCH/c2lF/kZglzOOkoVe75J0rqSE1LoaEEmTKRtwhU+BsCuObg4W+0cKhPNXi6zFYSHrjnUBtmtIN7nzekhJhzOLiMq60M62+2KpRVj+IQ8DFHKl84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lwTVNAVLwi1gyG41osM9o7VeGen/aJvxEZw1mntkp0=;
 b=SH4eZC1UK3CUgL+gw+idlVvaE9IgqnS0Y2Eet5ao7yPf7TLy2H5FRm1PJ0UoLTkSjJzJXDsMiUIZDOuZltnsm3Ezae6fgB8fVX/by5de30hnO1iIZR84eDU9XNSkT85DhnMiNT2HIU6eZwyzJoiTrdbms9uVkkXUXj8gfVdZWcaOqNpJxk3zsKcIakGx5nLJIuPCTZPPxEy6CYsX/H6Vn1cdRER8MIyKlFcqFICje68EhUmzHEPJEU31l5azCbZ6bGWdP317NBODZ27p7om9CPq8Wfqf6d/Z82lywQeCTd0uw/xy9XRseMz1i6Kx/ELIPlh2HSb1Kp9j43V/Q6sqSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 18:52:43 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 18:52:43 +0000
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
Subject: [PATCH v3 7/9] selftests/mm: use selftests framework to print test result.
Date: Thu, 21 Nov 2024 13:52:18 -0500
Message-ID: <20241121185220.2271520-8-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121185220.2271520-1-ziy@nvidia.com>
References: <20241121185220.2271520-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::11) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: d48a6741-3745-4f7a-e94f-08dd0a5dac20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pB3ONJDs5zd60H8/xakzSjH5dZRXBpNR6cjS+uwRL5csa07lkVJ6BclVILoL?=
 =?us-ascii?Q?vBc4tKdMDwLh35FObhdj3Qliw+gMbhdMRNt+9RHYEygJFrkMvc2sPRWfpr0/?=
 =?us-ascii?Q?EDJSPfFT1yzoOlJBxgXwgUTI8pq+sHX4TBwDdkuX8OJufmRHh4B4vxmhXrIc?=
 =?us-ascii?Q?4U/gJnGM+rGM8FIzhRUbaVpSAOpUvyMdpQ7pDzyx/WZX1o0fQKtKsXKgOxDc?=
 =?us-ascii?Q?5rbzrhEgsG70EazuW3jt/FZdxRtiXlLTAtlINKj6fH3lasd+ImKMJURTxjbJ?=
 =?us-ascii?Q?kxo94XVSDObV3GLQwop7YQZJMnny8JmMsb8bHk/kLXORpRm6f61RRXnVpTg3?=
 =?us-ascii?Q?VGq1OcMaHBpkyiDv43KUNXfbwaopPl4Wo92Gn6JNurr3ZssuC4Jpl1C4R1s5?=
 =?us-ascii?Q?DfHPeZlhMRyS7RbE8cTI1/1mZIMlcPPIgrl03kRhNWuABwpT7xk4O01z16gC?=
 =?us-ascii?Q?IJLIXQQ/6JBPdBogdyGUZ3PyRHTwCabE23oONb4ieg/Gi/Ak2O22Ztql2qyI?=
 =?us-ascii?Q?5kqNte7TpPT8NLQXhBK5UoxRv1b/97edF4hKY4rWowicqgtT8HqdYeI4UhqI?=
 =?us-ascii?Q?BZGumuAUJWH/MnIKiPRiLMkDhvNCEFTCCttjujvaztBy2YzvdeWtTQxhRv01?=
 =?us-ascii?Q?Ea074M4U99MKJDurLRaF2ffzVf++08lGPZZWwPUTy2MpHcH4w0823ehI1wtj?=
 =?us-ascii?Q?0s+yjYoH/ClNmQclm5owwa8BVnERRkm5yK3P/BMzkPRaw19vmSHx3ov7Qaht?=
 =?us-ascii?Q?UZ47vkQnwZuaMUp61lncmiJ95t/JxMs99H9ZjPFLea+aakyYt6dMSaPBlIIu?=
 =?us-ascii?Q?Wx7dUqAz9aj0CoDbtw9BiwHBwkbz/ypUymmDhB0vdTU8ikql4p7Hd6/mKRm0?=
 =?us-ascii?Q?JisqLlR0ZHCW/2hqdUfWJsoarMOnvpDLyQZsYpDFbHX6tdMbVZ6aXz12se33?=
 =?us-ascii?Q?JYRceeGCWtQt895AnfQqTJp6iz9f1kJXqZfPWJzM5bkK3uvBBRpNcQYi6i0J?=
 =?us-ascii?Q?VIXECBXFAdS9wwRddGOY6uJhVY2ApuTHZsdUKkfum5mbJ3X1wEc3shrzl+9Z?=
 =?us-ascii?Q?dtr1UEoL9bM9hyM9L6g6VtWMD4zR09iDpln4i8bzx+xPPbQwqBP0ut5jQBDh?=
 =?us-ascii?Q?qjWwsrx8tbc0RF06ZevJSTThG6oLsZvZpB7qMBGxVgnF2xXQrLB1+M8ULhpn?=
 =?us-ascii?Q?IYCJS9O7Rv2Na4EjCPv1z+197j/hG/HOJG4BF+/ZrrNw2Qoapf4iMEaRlY3L?=
 =?us-ascii?Q?8XApAVNdHDTJqB8eb1dLlGfn6EWiDbs2JmW5Gp0CfLLaooozjI8U1mnEeiuR?=
 =?us-ascii?Q?TlCeE7+ZHxYIFvRSpkf696Hz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1nhxEJx3Wd0Ai6GJe/ZYf7yyDCQY4wsy1YFGLbRu4/8O6OhuktHVG6Js4KM2?=
 =?us-ascii?Q?2HXNuoWon4g5PESCs/vOh/disjjdVr4tqiFFIVzkBpjNC249wFZ79YOq/zzn?=
 =?us-ascii?Q?/iTSsv0v/wk8YYNlc6nJBlwGr7zqbsyjwAXk38rlg5pE4f7BcWaOXGnaeD75?=
 =?us-ascii?Q?/zGCWvaE/y4G/zT1hINLlsGjqJcTognFbDRKNkcQ9cnrQGn1Vey209KgIp22?=
 =?us-ascii?Q?kIKBaWqdSSf/q9nb/Q5a8Zf8nQc1xsER4jeVLjDtbfc2Tx1RSDEq+RbFw8KY?=
 =?us-ascii?Q?mYrSTSeHw3E1OPG6JC9+vxjt5iWWDyEx09l9IYyblGt0bx2h1Y+NjQZsFa/1?=
 =?us-ascii?Q?3EEMuCU5umshNk1ix08jODvnElmhxIZHsCjHssfSROuQFPIn4mr+YBcU7ckR?=
 =?us-ascii?Q?7Q3aoNtKayIeij0oXcxbFGp4vco8e8t1evvzNYZb9aXhO6TTk4GJv147R30Z?=
 =?us-ascii?Q?6BIZMbxI0c0fAJ7jhJJZ9/lEpYkX1wiujhELH8ARE3pd30s5Z+NKKb6XOhhD?=
 =?us-ascii?Q?YdP0sgQlINQsYAV8ovYyexDUdXJPZXZCzr3E1cjFN8i0nUvZ29kcus3DW0lE?=
 =?us-ascii?Q?x1iTdmLStwa4f1/A5ptgjPQRYrRTm34IWbHo8BC2aj3zMyIMwqxk1i5Q8buA?=
 =?us-ascii?Q?VERGEhIab8EpPS+eLPjTYABQf57K7727XsJO9N1TKf41WxotMQX4a5KzHGiQ?=
 =?us-ascii?Q?bqkoUaIxYESSUmCxN1M7oHFCq8FU4QwOCBptZI8268BUBneqkfG7qgeMpgOK?=
 =?us-ascii?Q?x3hg2NtX9P1816oD9hreSlhpaOlndSoQcBT2ZszWMdxg0f1Zko2izdmqVr5G?=
 =?us-ascii?Q?NRlLplQ+hPyfJNy20Rxd1Ono9YBwcPCa+hqAvatWTtxcG1qRUumyXax1pm+f?=
 =?us-ascii?Q?FBBH9vgOzSCR/ZzJpxMJ37KGleJ8b787zm2HyFYJ1RRj5Vilxq4ORwkf2muB?=
 =?us-ascii?Q?LcSog8qbAX6hdZHR4mfiqdQA3EfbzMzQYs0zdIV1hyLtg7l9OhCuTDDbrVAP?=
 =?us-ascii?Q?R56o6RtnTeIBwZZ1+opvx3/fZQ9wsYmgrCywyV2NzCvblR9uMKbg9BMI+YVz?=
 =?us-ascii?Q?iIUi4eZmFWKROL0IUwAX3n6JzCooPXpxlw8TjNnIwLxUgfVuimp8VHwMfjvG?=
 =?us-ascii?Q?0l+h7gQw54k9uU57sevc2f9ADRW4T0L/j0rLni709jjjnu98IWQJ37PUQ4Xw?=
 =?us-ascii?Q?xGRxpKc0KP8RCMBPgY32Ln1lzfF7a6lOEFYUKBxtpG2S2b8Ne38DRnf72FKB?=
 =?us-ascii?Q?ULQ5hsKy2MsubwVc7jERNtS5g6OhKk5yNOPUAdffDj2J1H8yNuc+0IsrNILR?=
 =?us-ascii?Q?4XUWljjPfDkZRc3EirmE/PRsVYN85SzOz94ufH8Tl1iC136ys2JW/nLCsqeE?=
 =?us-ascii?Q?4G/56wAyde+3yvjDd0PSX0brKG3sbCTn92EZJ4nYOZxTi292a10SN1Oee0Tq?=
 =?us-ascii?Q?90B53HqeaC8z07hkkhvDL7t+WZdqn6i6/fFRBv8QzORxvf8a/Kp1xHqe92kz?=
 =?us-ascii?Q?6ZSFF/7HZoWGdxrVEffKvLB3DWh1RcT0aUqApFZDISDAqmrfRjRH4BaDzevU?=
 =?us-ascii?Q?48hUAnuM8+MN6X3WiQs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48a6741-3745-4f7a-e94f-08dd0a5dac20
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:39.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZIhmcfuYvT8fu46Ma7DfRlkkI1vlnm8bNek72lUnzJhd5sNKCsfdLhyqMAOv7LY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

Otherwise the number of tests does not match the reality.

Fixes: 391e86971161 ("mm: selftest to verify zero-filled pages are mapped to zeropage")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index eb6d1b9fc362..cd74ea9b1295 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -108,38 +108,28 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
 	unsigned long rss_anon_before, rss_anon_after;
 	size_t i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
-		printf("No THP is allocated\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!check_huge_anon(one_page, 4, pmd_pagesize))
+		ksft_exit_fail_msg("No THP is allocated\n");
 
 	rss_anon_before = rss_anon();
-	if (!rss_anon_before) {
-		printf("No RssAnon is allocated before split\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!rss_anon_before)
+		ksft_exit_fail_msg("No RssAnon is allocated before split\n");
 
 	/* split all THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
 		      (uint64_t)one_page + len, 0);
 
 	for (i = 0; i < len; i++)
-		if (one_page[i] != (char)0) {
-			printf("%ld byte corrupted\n", i);
-			exit(EXIT_FAILURE);
-		}
+		if (one_page[i] != (char)0)
+			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
-	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
-		printf("Still AnonHugePages not split\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!check_huge_anon(one_page, 0, pmd_pagesize))
+		ksft_exit_fail_msg("Still AnonHugePages not split\n");
 
 	rss_anon_after = rss_anon();
-	if (rss_anon_after >= rss_anon_before) {
-		printf("Incorrect RssAnon value. Before: %ld After: %ld\n",
+	if (rss_anon_after >= rss_anon_before)
+		ksft_exit_fail_msg("Incorrect RssAnon value. Before: %ld After: %ld\n",
 		       rss_anon_before, rss_anon_after);
-		exit(EXIT_FAILURE);
-	}
 }
 
 void split_pmd_zero_pages(void)
@@ -150,7 +140,7 @@ void split_pmd_zero_pages(void)
 
 	one_page = allocate_zero_filled_hugepage(len);
 	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
-	printf("Split zero filled huge pages successful\n");
+	ksft_test_result_pass("Split zero filled huge pages successful\n");
 	free(one_page);
 }
 
@@ -491,7 +481,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(3+9);
+	ksft_set_plan(4+9);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
-- 
2.45.2


