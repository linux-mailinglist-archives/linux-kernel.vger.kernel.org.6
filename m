Return-Path: <linux-kernel+bounces-432428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED79E4B0B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F368C163B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D913774D;
	Thu,  5 Dec 2024 00:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/CEDCJ8"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436878C6D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357943; cv=fail; b=WqbY7IiOHDOMdapIMVcd/2e2fYEDzKIoot8TOpBcLNZA6S7ECfEFQqyIdLm9NTvSlB2Cz8jbHQOa9oOe+dvahxgsqYkYUB1YAapKNWQ8mAlI/T78/KZAno8KFIrb2tOTW1ayRhWSDMGK/EWTxxpGEdzppIUlN8OkJy1Orv1Y0oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357943; c=relaxed/simple;
	bh=cSAUK/yZ/DwlhsMaY5PAROSuKyoT1axfD0PnzJDnsLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Smq+i9i53wNlMU+WAmoQnyCFraww/necn8nNksd2ojLa6o/6rZ3QG0/8jr7adGsP4snjEoIbIb6NRxQdOc6zwDoN6jDBc3VIRHFAhNMWgAzCaHNu4h8UAFtQrtWjcpiVlcxUA30a1kZIaSnNMtIK+ryVU+PWzE/ijG0Kjr86Rjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/CEDCJ8; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbfzLZsX8Q+jDDOh6uEnOU+DG4B1JHRJFHn0vwij6EFymekfceBtHORnz32JpXJSMs8z/Bhf5qAtjan1/0nvP4UkgZcdnj30Q5Cjp45JAwKhHzgIG5kR4i4KCWTvR0tkls/VVp2xYrLiu73HY8ywL4yoib05rWIcslK6VbetJeKbSsrgMR4Fpa84vKHHVXcIKsYMzo62bAapcqoiK0KyVbTUy7KrEKNYnX5gjN29d3/3TPPXPGzx8ncXOeaIn+sUDih+WJ7Mmbfffm4DF2vArNiWkB5Fpo4jSIvk6tup+fmbwWOr517S84j0HRC/dBJfVJZ22OepbBfcUmiNKU2acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lwTVNAVLwi1gyG41osM9o7VeGen/aJvxEZw1mntkp0=;
 b=t1KoGDx2lWHh9HBvy8ZG3X9/U1xE6hyYcZyetorJYhYHotmtFfq/bYRRx0LCMiqcDttMYS6IceEHAUGvV47hukFt0Bf4j4kZw1yYFev6H3rEgzZfydrmevXvZJZsxocZBBs97P1Xx4mN3OQLeraGKvb7X0TP/dvk4lqDFOuZiGLB8VH2z/V64DPqmAU9NECf0w12hTeLxibFm3FQuDvDt8XIWw+bIKo4O9on1Ho1HMlsiIoq81a16QHFKEK9YQq+/GPey085APyEUUSGWAecSRGpGleoHMVJFzw5J6qyVtEhQfcnLhDgRcOQVLVZMCTPx3PqI8YlT2RUHKoOrMWDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lwTVNAVLwi1gyG41osM9o7VeGen/aJvxEZw1mntkp0=;
 b=E/CEDCJ8Mpv1c5FJSBZnYgl23WxGntcmd/x2t3/mBBoCRpzzRaqEag/up2bqVCh9EO81uY2zREP+g0tPD5ntr5jaU932XNeyniiwBNpLNBSYgyWuhqI/0VSSi447fIXSJegHZ0V4ap2PiJerX25ukiA0+RDgMYMJOJWWyYBb8oflOT/opuFzE9yBrDjNAOaxpgiSdKuVd3usJK/YCRC4GHTm2qfzyDIg44F4DPfr1UxYO89zwPn18b8dhmakD9k9qPEIxpodPBJHDxnyyk0p1mY2Yznj/sBDQ6LGduIGgewNqQ2Vczx16r+POceeg7gEWK6rt+mNjUM7RDOISzKitA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:51 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:51 +0000
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
Subject: [PATCH RESEND v3 7/9] selftests/mm: use selftests framework to print test result.
Date: Wed,  4 Dec 2024 19:18:37 -0500
Message-ID: <20241205001839.2582020-8-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205001839.2582020-1-ziy@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:408:ea::34) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: abc82ebe-cb1b-4d9e-9500-08dd14c26566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nOI9qPciSE6Ax4E3KhmQJgr9XBlzJdscRYTQdjRAjAmLFZRg5gBQIqPJiNLM?=
 =?us-ascii?Q?/5PYs0s5I/1QXNsJLVmkgiyPF5gJ8QctkGx8ovmEIZHVgANcqKo8rhCjr7Ai?=
 =?us-ascii?Q?G3YOn1BVPo27XJ0V9E0wIqgzgzIpsQaMY+oNmrYbrUWerlnxm8Cn4HJ1mkxG?=
 =?us-ascii?Q?j9XuzlYTKVbMemUEe4XuMJRCye8LI2pdHg6M15T68TNNFOhTBRRE6NQaCqpQ?=
 =?us-ascii?Q?BTDBkMx5p352H/WuHL4RdxEu7V7aINKur2WQLK73KAFDzyg74aS/Ur41ChQT?=
 =?us-ascii?Q?SexL1GukmG/Zkfd9VzLzN2I9/TetCRZFTL+de6U9PZbth++LeaHy6KtNXVLB?=
 =?us-ascii?Q?YxzBKqUmDkN/9n8i+b5+1bFTcSYiG0OHksH2+BpsvOWA/fLmw8cQVGeID8V4?=
 =?us-ascii?Q?uY7ymdMojFwuovsz8o+L5HDKRbWUmlewmOJd0V2w22T0piOiX7kTfNVIwPJQ?=
 =?us-ascii?Q?CxcrYK2NqVvV04+LgQ0K4PmxvLQGcOP9czDjKWx1f+UpCfDh24kKzSOL99ba?=
 =?us-ascii?Q?O3I9dHXwx2RpmuFnKqtil5tBGVT4rq/EKB/As/I/s5xGocLixawF92XFxjun?=
 =?us-ascii?Q?lb69KREgxn5fRgnl7DGi9Rw8wyonj2t2W4F4eWvaYRsgZAJ61Esprh84FiT7?=
 =?us-ascii?Q?8h5cIi5vO6JrTDzkbAvmmgve4PCZt3nLF6nvlH8LJJlZ5NwRaIFf2nYwswGu?=
 =?us-ascii?Q?stJfhce+SUCHl1g2RdWOPaf7GXkZvmWxq8lt1MR0u3KpEBIJbCUPCnLUP+/k?=
 =?us-ascii?Q?GAD4j0os46QJwaYlwUGTJuPZRp/+0SjdwAWN8RLZRwv4C2AP32atRqEwmFi3?=
 =?us-ascii?Q?Yfh7Nr8i4yJCLIK5mkvS7M4BK21Fr7eq3FQ+XOU0UELTHb1S6nrfHNaF9fZE?=
 =?us-ascii?Q?C1lOBSc7p2xPssSAKTYHVLHGd1id0AUfuXIiAaWjWW8Qb+nAFCOee+4klnl1?=
 =?us-ascii?Q?pqQeRpZAdO2oAb4SudHTK7+prNAKG0x1Y54GV/D0nLWW2FLrysYIV3UxaT+z?=
 =?us-ascii?Q?D2/cPkUbVZxJocw/S7XC5698S4peRzfTmwSJ69KdmuQuXD2qQqD4lO4dn+8Q?=
 =?us-ascii?Q?YlTPTnkoCCZXlbLWoyuQBQT9i0wwbyqeH3o37yUKyzEnCjnhcM4DR/nDBBgG?=
 =?us-ascii?Q?QVFo4C6//FP7nkFGS/YVbsI4MMghcB+eOyVk06q3ejDxCKjeSW+oMl+WUcQe?=
 =?us-ascii?Q?u2XPLmwYJg3m7O9pz1wRRB6GDMUYoulKuOu0eE0yk+/JCGXywbX+EZcWBWHL?=
 =?us-ascii?Q?THIHmPAbi9+LCdnV9k0RJAvYFj3la5oL93pX1uxS2AvYQZdU1C6qBpjdZswm?=
 =?us-ascii?Q?k6Gg9vpR8lbWx/DuxMT9QCebDM2D7ZYEWSj6aFPH0z933A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B5vCxJJSYYVqDOnAWmSHa7qFuwFjiW1IwkzoosVU65PrJqbBBKYsnxEP9Qry?=
 =?us-ascii?Q?A3+ey6NYwP3T442SeUBEL2wMd29trs7eE6eLZS3GS/14iXhLWj8agsv0QN2o?=
 =?us-ascii?Q?hlvDuPAtWbjp/4UhAWMZkVX4utn5g1p0iP3TJdLNfGgEdWB3yIAUVDt4JDGJ?=
 =?us-ascii?Q?sjuwCTRKoNAqRBewCVsmhnPtYemUkz7FVGa/3pJ/+6/QQuwwSzGNsz97I7jB?=
 =?us-ascii?Q?7dO/sBD3trPrBUvs7QeFy0gppmumL02PMIQm7hZ7Wk5coBPSTTZq9xjbCT4/?=
 =?us-ascii?Q?hyMIJjSB4jZUUWWSqTJSdMdeiUz4kJf7TTj6CWUlEjPSKlV0QyTxrxMeK3Wy?=
 =?us-ascii?Q?c7SoNAJbk6uHDhFXDNbOUimKclHaNTRpdpNoJl51mPoY3r6PAN55ew9vGRpl?=
 =?us-ascii?Q?F44weIwkuEo9wx2X2qWFFeAuMcCdmg4JPnFT9R2cevC2iFi2rmlKJUkeEyV8?=
 =?us-ascii?Q?C+fDYgxDtXEySKFVDc3pFQFKjhk6AsvyNDPWTOj/e+GzlFWAbyHUb9RBcnOw?=
 =?us-ascii?Q?hpbKvJ8nAefAejWz+323fBCV4nKDVjDUE/9nDOyzTaxQAJ8puQsx049TB8Ib?=
 =?us-ascii?Q?VGB9c6QDp/gC+OyVKiiAbFIxBxLe/E7xeweuoNA4hSpFv6p7nFAH9MDRr3Xk?=
 =?us-ascii?Q?xvSwW67c3brJezSdptoHrFVkfQTCLRCJ13xA9mAcOpccv/H4ORDeU7H26whl?=
 =?us-ascii?Q?3B2dpXfaL4NK/r69x6j/HrqI3nnmTrtocvmc8pyM2P30DGtpJkmBJhdomi5b?=
 =?us-ascii?Q?O+0Adp7ziWAzC3Z1YMkOirkplmRWPVSgRmPNMbxk3gus2uGjAQClCRFX6sJb?=
 =?us-ascii?Q?dY0wwzjYwECPPdgnTDJyIdAOGwAMhtmEWYbNqj/ocex4nMw0uaMWoMKGd5MP?=
 =?us-ascii?Q?YjghMoUBNPKGjDqx88GknySW/RVGEEsbvvgyUsnR72T6dvFmpx+fqmnmOF/I?=
 =?us-ascii?Q?lSJfz1Fzu06GNtjtiIx0SnrdqRjEy1bLCDEdO/xvhV1jCv01SZumWymODQfN?=
 =?us-ascii?Q?Zq+6i3xNOIb0ArRAjMODNt243oBdXKaG3XCwZP/d/ntwRHjsO4+RU5sZckoP?=
 =?us-ascii?Q?CXoJKjJZFJA1ne08mYUZBsmNtAzBzahN8E/Q+tkDLDSmuPpStLQeFrEpOXGk?=
 =?us-ascii?Q?bgdtC8HzT92tq/oD/FNAs7jUttsru0pW9LIYSZWBgDVTIyZt5Bz/hs3p5bBb?=
 =?us-ascii?Q?1YO5OChoDHYOBV6gGhmpzHe9vBdB7WH0A6QYr0GA+99jr+PGFRJPQy90MSnH?=
 =?us-ascii?Q?YFZA/+yN3xwHKYKEUP3TaLKsNCtZ/HCOcf+VUnqeapU/zLpsfMyJJoDbxJSh?=
 =?us-ascii?Q?nt1V0zeP1CG3YbtsYQZ/4n9tGbMF5tAn5uTNZ0YI7CFb41Tjh0FFUe/aUOsc?=
 =?us-ascii?Q?qKaHHiCC39tJHJctNcajIup+GlsUH/GD4yDVSl4tPsjsxjc9mi0FcEB3+rvs?=
 =?us-ascii?Q?2Hlbm9LV89q/h8O79hIflBxvsWjlIlYNLgsavHjol4qnqwSaOLMB7kb/W5G5?=
 =?us-ascii?Q?t1zuce7ynFqQgjTtACuEsgBUt8xIbrUCqjwAJw9e0EseupTuQdNSpPPtrRBP?=
 =?us-ascii?Q?rRYV0lNTkPmIastLWta4hsKM4qoWWXo+bu5wLBua?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc82ebe-cb1b-4d9e-9500-08dd14c26566
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:51.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Vc4AQyCBTkQqPySVU7RAzV/kLcSmkKLDMB8ttIk3NZDJ1bi7Hssd1nHHEKOWtOF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

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


