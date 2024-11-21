Return-Path: <linux-kernel+bounces-417351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4949D52DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8072822F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB271DE2CC;
	Thu, 21 Nov 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OAdKuTM1"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896571DE2A6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215178; cv=fail; b=crvbiSKd8M5IFAsOTTqpdfHda7yVqPBh2cOelMqXGj8344Rz0Q80weTnv7O3wf4YVA7wILU0na9xlW9+8KfOC1sT0EobmHkQblWaq300sxur/ken6Z1zOSMhyrTpaYlovHH2KdAyFP9avW4r2GRpmL913xfiUsM9Za7JpgouO/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215178; c=relaxed/simple;
	bh=zPGR7jKRPB6tJMDs2QTqlQCPHl5sLzjWxqmoVUkf1Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D46/9FjqzjZwnAKVkccY1PbIEUMO5nFV2srzZdZ3RRq6UUZ6o0Y+itUekJxLFXvbviSbGiFM/lo4QgyLGSjxbOu3/Rlgxxgs3YpwlnUr05tGVrdPlVCtMnN87lwPrcEwuESKyAUWaSoS3yq11Z6K+NWpP0An694f+zUtxblp5lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OAdKuTM1; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFHo8moea7rlV4/8uZlcbNdEjHwR57YXRxfF+RtCGWOQlOGeEcdpJ4rY2EH2XHhKjHEXJv5lAkRg2eNhl2G76j7GBCl7AUMwkXUjX99BjuPcN9LnmXDMIY39VanpfMCM82lfiqpJpUhyGF8lDAj77PNwE0AFA62bxi8ZuNy+ogtL6XVvN4wDvHqdN7U4WYMxTwdgrO81/uhHPWLSaqTNReyAZBg68ylM6BZJ+TZLKrQGKFzfWseaXNLrEoc4QyGeRNJiAvwC3cX7s/M/Wwv6TLrnvQ2fo0zuGw9hkihC4KidV8idj/pCjSE5iLCWUlglGHfLr/q7RubryQns5ykfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vfodItUcrcyLrOMU+QPVr1fQyMNwn6ddi+gcaz99x8=;
 b=sVt4O3NoNqV3IY+VnRRuMNM5/TGte3foB9mw5cauoXH4ahwvJonR44TaOkSLqOLHhqFyhN80QQKXzHTy+r5Isva5Sm0Z+oZsFhkIPC75XCgjnXtOHYEa6K16kc7/Fg9P7kjfE1BpjSmoZ4iEXldS9TkyuStYCQH/8MPOWgjF9sa8umE9dXTQShV3FWbMECq5fyj7oJJVucUHMyfsbxFbtYPRZpKbFrm9G/u09H+CWXE3cPb7gqGH91EcQVcCrHhepO+wBJR1WoneNMEFqkgOn/6OH5PQvM090oId/RbhUcualaZW9Xd1q7mLsTuwWUpI8E2CbmMfQsgmIoJu0FN3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vfodItUcrcyLrOMU+QPVr1fQyMNwn6ddi+gcaz99x8=;
 b=OAdKuTM1Ig4jZxUJ69RH0ro9okn4s52IRcJw7+HaNeIXFLfooXlmUJmCRGWaQyBcDNTCaEcbccSxFjyverIj9q6t86jEi3ueQXBAvT+SJxbbTsCnMzQqEA9425yOhFas0WOElaJJfhptsuKclxoJzDStHfoIeTYh5WJX1X40zb2tVbnqX+Or9kOnEB6uvUucDsFNCtGNna6EuiQjAEY/KpWatoc4doDlyYcT2KAJUI8E3v61hd4PkFDMz7PFBhoyuWJIX6HB4oBm59p0yGwHgPJKBEdbHKIIqjzztsOrWrGHiq+8mfo1RZssrgB42qUq+b//uj+KYkrlXwUfOehILQ==
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
Subject: [PATCH v3 9/9] selftests/mm: add tests for folio_split(), buddy allocator like split.
Date: Thu, 21 Nov 2024 13:52:20 -0500
Message-ID: <20241121185220.2271520-10-ziy@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0634ce88-ba82-4fd0-13c7-08dd0a5dad2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ao6xM8paWj8W1BV6BMlXhk3QhR/VThr8iEKeDACvc9Y7fOoBPjN2A2xfG6Px?=
 =?us-ascii?Q?7mw//1i3mMpVEvRC48S1NBHGrCa1DyvjemfUPnNGSEkxZb/Vhscdb9ARX8ck?=
 =?us-ascii?Q?Rki5H2IWW+miJiyhvkAQC9VbmpLAMZuJM6E7BZJ4J40g7LHssvuTk8iWRdoK?=
 =?us-ascii?Q?rlkMeqZTtkhSInBcQJJWTabZDW3kvzI7BxpTK7Xhi1FV/X+cGiZsTUbPIsbf?=
 =?us-ascii?Q?xCOoHfgQTsAgmlrIbsC6vKUJFYH4dS57ICsa+4JpbOdmF6QHSvoptWHOElNZ?=
 =?us-ascii?Q?SK4IzNoyVZdPwkwaQ1u4ogkeWDOwwn/mLE0lkW2B8z80S1x728DyqvnhmeUL?=
 =?us-ascii?Q?oXnBtA1UPGk8Up8FgQYkyWJmaNrCtEjcYWsdoj+2sUw41Ujfps/8vtnmjgxl?=
 =?us-ascii?Q?NVKoInzAwGSmZc7uqhWgje+29Q/gLRyBNBFVLgri+xQf0kMxAy9za9Xa6/Hx?=
 =?us-ascii?Q?Dbzykji3pg+TfZztyeLeJV1l6FnIwlFZB8unuaORP9hZ6Re8HMT7OwhbGLXq?=
 =?us-ascii?Q?cvgvQ1NobiS6lfVKXbA1TZzBuOTIqC2+pVMMTnM554A4slPPLjktX+rDg83c?=
 =?us-ascii?Q?y+yG8eK9VEV/oZpr38PMoXDEFMdweFyx5MnSTefWbJJC57HQTaIebtOHvAih?=
 =?us-ascii?Q?CEe3dfKO7ybiGXoZxpBl2XrtijBR3qFW8o575L3rD42CUf1Q7v6WmeCssIkh?=
 =?us-ascii?Q?lj3bFSQKUgY/1itjZJin8algqvcIdTOrr0p2eDL0yJu0ETmoU6wAzxmAxbjY?=
 =?us-ascii?Q?Uv9je6cpAHZxNxCfyKTUxhDyCVI2apw423k+mz0ng4AuMfSGx0ZqJ72y6rys?=
 =?us-ascii?Q?5NpT9XRfZK0I4q2cQLlBk+mrWhai1UWfsmTWjzwn/idXZYtUr/HAa5m/DYtZ?=
 =?us-ascii?Q?Th82Bi4jtd1ZP+4OVV7dH001va1t5MDk0VTyV3v6M5gB8HqCF1qf50eWUvnR?=
 =?us-ascii?Q?LJTYX6Z6b6RUc6nwrLrR84N3zX0JJ/fo89Cyr87/oyNTKFbHOyHvV9Q2RCbr?=
 =?us-ascii?Q?llZv7+Tp6ntMu/wAlS/0ylHKrzz9xHSWX1ctoe2unjXyr4qRom8klfPl3sHC?=
 =?us-ascii?Q?Sl31DruWDH78nBfjW+drshMnOja90GfTXU/P0SKzDgr3qwRG/nTO66n8+F9e?=
 =?us-ascii?Q?v8gtH5Kp4TMNChV3Cql6TTHA3tRV4ge2c/vLvTV29lPz6sGU+DkGfGmKqW6a?=
 =?us-ascii?Q?rckT0QyadItX6KfcSqe9ENtnrOir9mf4b7FCNKuPEQuiiVKKN4H7ueidM7Qa?=
 =?us-ascii?Q?o6zyTgmyXkALj2xACtS3CFeyUFtXXXqpTlKhOqaeSzi35Cx2aSKJIyuObfMn?=
 =?us-ascii?Q?liC22+rlsYJidiiKy3efv2Ip?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S3AWpXHLvR8V8016XN5gZXJsu6xOaAvvlS5qjELxYLjsFR5JjRilojyEal2o?=
 =?us-ascii?Q?+5UQ4O+fd4zTERhTPbm+/GBeblw5GOY6LtWtFNSttakcQL6rRWY5RhZFecK+?=
 =?us-ascii?Q?y7umaC0BoyjhemVXulbzxmo4HACzunrhMKjLPIAAeDX/rPdi0L8zXCDLU5rZ?=
 =?us-ascii?Q?KQ7fr+zcgj8d0yAj5NbBN2QlQayRyYlg7nOdOY695Jaa0YNE4VJftJVEn5/9?=
 =?us-ascii?Q?7NpbLDRCJiCUis0Wrghx83slWFOOh/RcHWM6a6YneX1HtY3AunNmtuAetQDC?=
 =?us-ascii?Q?478tlK2XVQc/FNKlODiYUt5ZAIttYom1U3NlcZuu/SeFsQ07C9Lkm8N47bey?=
 =?us-ascii?Q?FGH1W7/dKS2blT/4MBlEmV7IVq718RCjF+YsMRbGq+QisWveWWr9kB4YxZvR?=
 =?us-ascii?Q?KVtMsvG8FcgankrNKEZ/FzAMIqbH60EyDLS8wVX7kHqk1ZI98UIAlNwWgwR5?=
 =?us-ascii?Q?H6ytz3tNPdKEUWoYU7xLHOAbqhG1m+n1bmBHb3mzXGTRqN+mmV4tMAUwRecy?=
 =?us-ascii?Q?KIOIhJwm3+orC9b7OMYrIjJN3SFtzsRCWjaafra/xnuNYGzSObxqFi7bYdkh?=
 =?us-ascii?Q?5d4tTI1jLpYreMU6+Pgxh9Z0fGj2xBMy7NAy3eKfYN/qOr7aBkB0S9eJJ0o0?=
 =?us-ascii?Q?Fipiz5vYnmZ8FuY+6U0/CZSGnwOINqCt6KSiVm9ZZTLDLD2NQbPNpFBdgBZn?=
 =?us-ascii?Q?RyfCwEH8ECSIuloAH3FHh+jbWrHyNuJbFkJOyj1mm4GaDCRc7NVi71UmWpZw?=
 =?us-ascii?Q?zX5Qje8lVw1J+i3vLmvPjc2GmC+0MBNV4jxTjZPnINJEyRtK9Srx5aevlaxM?=
 =?us-ascii?Q?WTs/dAXbroTk4OA67iloROqKX4RYCFYVNHy4h6CnqRZeG0i/r3f9LO05/W55?=
 =?us-ascii?Q?qsSqkX9AZyLRVN8h6dHN4TBLOuvqbm9wFherbYXDLEWMWdhEVgYd5wXuXQOy?=
 =?us-ascii?Q?2aof1mMgLjvBgXMFYVdi66WkvzgDrWWWyghzdnN5Ex6VkP0X8QzF9h927bXx?=
 =?us-ascii?Q?MKboRmfgrLzts8H2VHyMPXdSuOZk6IJpLeHbeRVTh9GdSrD+jw6IOcWdUZqF?=
 =?us-ascii?Q?R85dOC8tEW1CtqTOR41bXG5cp2GZ6SFulhBxip5O+cZ67w/0fBLI9LDcldXD?=
 =?us-ascii?Q?Lwa7giybLxU1tsyOQENKWGMM5UUTaVv/9yWrpoSAalmffRTiEEeFcXo1nw1z?=
 =?us-ascii?Q?lRPkZKLjJELYUTO+BCpDMreOjEBQg9zJJ5Pnd3cdiTlSmg1HEYIJkcE+7KCr?=
 =?us-ascii?Q?bF1/X0kXbpgWkB0/f0b+s/V29xu5WIk6vGf72BahIi0bv51YjgPwfdqtOmIn?=
 =?us-ascii?Q?cEo2N+tVLHn65e1wYP5xaR7nSkX9Fe18I36iSb1jDK8Kkcj42yh6FD4zqkBN?=
 =?us-ascii?Q?BcO9qRI1Dp5TCWN9rfR8/85ESbHVv+v4fz6y6hHibCntBdqhNSejSUj9kCvS?=
 =?us-ascii?Q?NFRB0MbTv/KKQb8chvGMB3YHuKZyT0zUG95nwEVqQJnqJYzSkr4gTFRuFRuz?=
 =?us-ascii?Q?LFgSOHsBC+PVaxBdCcORQictG4/vmoxzPRxyndDSbk6t7yk/rBKSE3BHS8Zt?=
 =?us-ascii?Q?O5HN8tLWddhYk3mbvnERYvc0aermuqDNP3HSEHE1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0634ce88-ba82-4fd0-13c7-08dd0a5dad2e
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:41.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQOjIULsQyyZeQzt+x8v5MCa/siBtpoh/RBWlZ+0crFxtyYE4wAd15VwwXj3/G6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

It splits page cache folios to orders from 0 to 8 at different in-folio
offset.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 5bb159ebc83d..1af8d6fa4465 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -14,6 +14,7 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
+#include <sys/param.h>
 #include <malloc.h>
 #include <stdbool.h>
 #include <time.h>
@@ -420,7 +421,8 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 	return -1;
 }
 
-void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_loc)
+void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
+		int order, int offset)
 {
 	int fd;
 	char *addr;
@@ -438,7 +440,12 @@ void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_l
 		return;
 	err = 0;
 
-	write_debugfs(PID_FMT, getpid(), (uint64_t)addr, (uint64_t)addr + fd_size, order);
+	if (offset == -1)
+		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
+			      (uint64_t)addr + fd_size, order);
+	else
+		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
+			      (uint64_t)addr + fd_size, order, offset);
 
 	for (i = 0; i < fd_size; i++)
 		if (*(addr + i) != (char)i) {
@@ -458,8 +465,8 @@ void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_l
 	close(fd);
 	unlink(testfile);
 	if (err)
-		ksft_exit_fail_msg("Split PMD-mapped pagecache folio to order %d failed\n", order);
-	ksft_test_result_pass("Split PMD-mapped pagecache folio to order %d passed\n", order);
+		ksft_exit_fail_msg("Split PMD-mapped pagecache folio to order %d at in-folio offset %d failed\n", order, offset);
+	ksft_test_result_pass("Split PMD-mapped pagecache folio to order %d at in-folio offset %d passed\n", order, offset);
 }
 
 int main(int argc, char **argv)
@@ -470,6 +477,7 @@ int main(int argc, char **argv)
 	char fs_loc_template[] = "/tmp/thp_fs_XXXXXX";
 	const char *fs_loc;
 	bool created_tmp;
+	int offset;
 
 	ksft_print_header();
 
@@ -481,7 +489,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(1+9+2+9);
+	ksft_set_plan(1+8+2+9+8*4+2);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
@@ -494,7 +502,8 @@ int main(int argc, char **argv)
 	split_pmd_zero_pages();
 
 	for (i = 0; i < 9; i++)
-		split_pmd_thp_to_order(i);
+		if (i != 1)
+			split_pmd_thp_to_order(i);
 
 	split_pte_mapped_thp();
 	split_file_backed_thp();
@@ -502,7 +511,13 @@ int main(int argc, char **argv)
 	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
 			&fs_loc);
 	for (i = 8; i >= 0; i--)
-		split_thp_in_pagecache_to_order(fd_size, i, fs_loc);
+		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
+
+	for (i = 0; i < 9; i++)
+		for (offset = 0;
+		     offset < pmd_pagesize / pagesize;
+		     offset += MAX(pmd_pagesize / pagesize / 4, 1 << i))
+			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
 	cleanup_thp_fs(fs_loc, created_tmp);
 
 	ksft_finished();
-- 
2.45.2


