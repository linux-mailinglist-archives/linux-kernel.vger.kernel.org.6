Return-Path: <linux-kernel+bounces-432430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67A9E4B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD65B1638AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0B1714CF;
	Thu,  5 Dec 2024 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PqyAdWMn"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277C14A617
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357947; cv=fail; b=G7dC5Mz52qoIcc2U0LgXUWW1d6sOR6gM7fPB+hOeOQs6bXYN3nbNPzXEV66yaN1TNbq/7ldRoNwtci+gRfeOyGr9XskT6ATaYYXty/rjvleFgSYOLJy3A/UVzpH5NaDenxXlJHvG+LvU/IvhIWwwIkXDZjCZ3Tfi4nx2i9RL1AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357947; c=relaxed/simple;
	bh=zPGR7jKRPB6tJMDs2QTqlQCPHl5sLzjWxqmoVUkf1Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IN9T2fnYwfPFqVdCrG8Rm1tsLm5bD0JJBSAV98JxSmU4zRJf6InKzBsp20hC1j3+VDyyTMtOiAdGl2HQmauHPyluREHzE6rlRbeBz1Ym69pqbLjldEC7I65Y/1jVeKw4i6ufKfNk9MbMfzY6x21LqEshO9ACkbfBwhql0o7Eg1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PqyAdWMn; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHNUzRVgwFg8A4RRgWviXnzlu+ZiI6wYj3P2+KdOgo4MjQwA6DKE46EN68lvrNLR0WFI/DKGQR0F1XoXHMI+gP1Pe3WT8ttzOHTZPbkJmeA0udt7TezeSpEALsIffb7gWaGAsdyC6NhkaaA1FTlluAwSPA735It/+Q/zRXOnF54pANvoerxMqL3znt9dgQcnYBq6fhhF6bQayjaepWA0/3mwlFAJigAauo3H4uJKubmtLNU21kKANNxx1z3xqOq+RQYswVDlMnZpa8OFTpU8rPdP/6cWiCgEwG7PSdkNufPSUdyy1MqBSlUqPk71lsXFuta/GuOyNzEyKgEzNL28UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vfodItUcrcyLrOMU+QPVr1fQyMNwn6ddi+gcaz99x8=;
 b=pVUOiejGDBxT3abvIvFFUReqImlZaG4i/Xj8n3VInt3kn8Zsod7cFPO1x/BKgNTWuEwfnueeA5Wgz0brE41VzO56ZiHJ2biaPNQYgt37esWcGDPymPNsrBDwZHuz01jHRNR++li5i9jrSLaW6c/A6x21deTCrIkLs5ymXhPEhazqXihX+MKGkOMI5orwP0knmK5/p8hK8JvVQ8rcm3lNQCrZXfTDdQnEZnZBVyt0onI/lmW5cTEZ2ZJIUwFKZQzQd6uJAYQi+88BmyjQsNrTeKsS/optIWlJyZ/jz6Q1428Aeai8YZf/qd5C3J506y2O/jwFAwHYv2HGtAL7VXakmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vfodItUcrcyLrOMU+QPVr1fQyMNwn6ddi+gcaz99x8=;
 b=PqyAdWMnljyW/pwUeOuZ7+3jjCNQWCKvDEoB/OaKaN4G+0+yhyzLH76jbf8vNReTYicbV732Cc5bsYGX+zLgkjXGv65VtNVwV0TKupaSMJnk2Pz0KRtpheuUvgfoJCP2nI858xDKtdIWpwkYX8E7/86rDkfCKIWO18xrPdkh6qXlPIm12Jg/4DeVjWzAgnCGQbVIh5WhcHAJxDY7Sq+Vxlhbt9/MDQVYBW8W6KzWCg3b0jJrbYH26TK6WYx3lM1bpbLpbAfjGexGaEr85svABG3w2zDd9S9EzJ6wg+cuvPxE0GB1ZPMaUnSRbUTaOMVp5astPdXI1rn3OSF9y0x8kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:53 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:53 +0000
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
Subject: [PATCH RESEND v3 9/9] selftests/mm: add tests for folio_split(), buddy allocator like split.
Date: Wed,  4 Dec 2024 19:18:39 -0500
Message-ID: <20241205001839.2582020-10-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205001839.2582020-1-ziy@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:208:36e::11) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ab22a0-e71a-4537-e1b7-08dd14c266d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hViy2l2HHk7GFDeu19JPbjRzBLsxo06U+Hs0GZTs5+dEZtLxdtI1nRx8F17F?=
 =?us-ascii?Q?jUNlItriPF6bVLLcsDM81mnYa5TF9S6ISh3SE39m8VwMQ3Us8hXfFjIabHkm?=
 =?us-ascii?Q?ErvYGCv7HNLgjiOTsPfnq28D9ZUK+Las/iE7AJTDOP+bG/orBTaUmeksYnIa?=
 =?us-ascii?Q?fZB1qnDIbTMPfi9wLKkljP/3DhkzKp5+xeUjTXtTbSpwDm4lcnob03j6khg9?=
 =?us-ascii?Q?0hvFXcNv0hAqPfeF4OIeA5d1DKVJZg3/YJ+wRTu+Wyu42xG5infkSz4SDLaZ?=
 =?us-ascii?Q?FdbRViAV7knUxQBLeK6oMMJJU8F70jMlsHHEjwb/QwDPzZAPFi/YQV/CT8mX?=
 =?us-ascii?Q?KMN0nnrxlqvso66KmLyrHI+RqQJdB44yq4WxDZwsWn4uYRO5gQXHhaY9fjcS?=
 =?us-ascii?Q?srWevhDeOBZwxr5Yuy8EMoLXeCDGwX06ynN6NlsLG6UM8s6y3mXnPgLXnKSb?=
 =?us-ascii?Q?cwhDAqJ9WEG5auENoLs8Xmq/n+JAc2cuI1rhPY6l0Kyyq06CadJ2sC0sGjBO?=
 =?us-ascii?Q?x7X59Rx3hiHhQ5gVBPQ82Gnybnbu8Od44ZJQKtYNiuKi88XNDwlDaV2rRpcm?=
 =?us-ascii?Q?TzIldI0n8aCGuO+JSVsiy7knUOXoVLaUjgNouw75mLaUAhizfNCGGMLa8vLV?=
 =?us-ascii?Q?jsn5jOX3/7ussqEXpj2wyqxNrj9pQxB1+uNe8E9MAoZndcnRcUjFW5d4mTe0?=
 =?us-ascii?Q?q4K37CShjubIs2y47voYsGIM9diDn2A/QYl+HECN5jpdHSXy7YdGtdG/dowr?=
 =?us-ascii?Q?fgvd4d+UWPWfPQNMZR4+WNSJ3pjQKcGwHrImHlNBx/3+EQGXIFYVpJ5U4etI?=
 =?us-ascii?Q?9eO4mrW+7IrR8YpvKdNgfavnKZ3T+gFzQM5mjpAOxzlm0+eeT3qj3dkGptAe?=
 =?us-ascii?Q?M94UjtgsHVqzSNh5Ea9wWZGMaw+QnWqVFghOpnKJC6m+i/8yuLGqDO82anGn?=
 =?us-ascii?Q?2u1afl9vlVrv2hFV8CxnxO5OC7IkqKsXOloLPUBuNElstMMRosBkW+6GZqw4?=
 =?us-ascii?Q?JgJK4rmlv0EcdH5+dQlYAlb992tl3kyAh1MiG60wo60xiiFEW60SqHNHlJ5i?=
 =?us-ascii?Q?Ih6maRxGbVpYWDFOniB2jJYh2PqdAG28Ls9Pibs2Uo34QVh2MeKUh0Dy9T45?=
 =?us-ascii?Q?WgYSQXbvIlSDnqsq5A8SjBWygCdMjpjphhdq2HBd8b9WWe0qdJTlvsZp0maW?=
 =?us-ascii?Q?4cL+qDzOU1JlJTT0MTjK5Rql09OzawJMjAbEkdoFISz2BR0TIkIL882bYJ61?=
 =?us-ascii?Q?zRS7Nl/V73zqdxpS4SY+iszkGF2CFKjYAGKKha+TOX8Z3jnXThFaaUelcGZK?=
 =?us-ascii?Q?5hJWoVDJg9dxcszD4Ii4g5CeLmRWG0O9VgK7RxuYzPjWGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2wQNE0WbdANjHio81QVMoE+EzdpQglpopbIPcLOVsjGGU4HPKBeIrr8Kd8pS?=
 =?us-ascii?Q?9d61ydyqEkQEhe6siBoZdIY7QwtcoAyj49rtEXvugxnjiSlgUzD3iZmS2IMz?=
 =?us-ascii?Q?iJXQRYaeM608H1bmh2N1/rVORVNHI2yDIp9yi2sSQvfm7p2O2VNRJSAuJZCS?=
 =?us-ascii?Q?q+PCGd+/nXSoVJFm06uxTMUNCO1aSbn986jo8Udg9hd4ucQ2r2dhzDmkR7ke?=
 =?us-ascii?Q?mULo13VIQy5ylR8u0n7QP0QzUJSTF2W6BRuibtGaq22j44u3BTexnDscpykB?=
 =?us-ascii?Q?GZxJV40SoEiLOMzT606eLXG8rdbC+LPFWcU9ioV8nFbVPcfedhUpyB575L3V?=
 =?us-ascii?Q?4RoE2cI/5t48JeQ97MrE65/zEhKMoYoHTeEi5qYpe4Sm3QFVM6tv+C1cAYfp?=
 =?us-ascii?Q?bOUmiLpJq9qPp0XHI5ALMxgPgDN0Jh0dwsVYxrNklb6jqZJh2yKOhYdhLrpL?=
 =?us-ascii?Q?nO25NTuOMIJiRbqLbnCB0A3oKRZeyPtqtKxWelx5BLPiZ8rZmLmCDmHOMF/G?=
 =?us-ascii?Q?mNYqsgyLUhuux1OrfXWDqu2p8q4AfbnXo48MukQ5cfX9a1TJSCc6bBJ5Aiz/?=
 =?us-ascii?Q?uRfwn/tKl8NprP4sD3oR6TJervQDNVKesIErCVKCcOCB5yMafJ7j19t3DJ6o?=
 =?us-ascii?Q?WxvAoo01OoeJZtvK8H/Hjz8rFMfQQaSdfMD2DERNZdpr8sTYLP+8JhAaSsJO?=
 =?us-ascii?Q?udcp2ZwnfH05yUGn8gDmklbjy59tUsiiAY1WLXAT+GVcYdjQMGwoCEicJ7ad?=
 =?us-ascii?Q?uEt1KFNOS/vkn4GKPorWHIQS4cfk8MEfd5x1ZUg/wrBuk9KnADyDDtbVII6r?=
 =?us-ascii?Q?1AIW1xBmriRaKBi21fWILxkl636MCbtFFwg5OW5mKz+qFusmW/efTndzOXxb?=
 =?us-ascii?Q?npLsWKLynseJ1EHiVuKcbI4VzJp4CO4kfAQG//cVLoi9TJtXhbiAVimp78hG?=
 =?us-ascii?Q?QRlMoaxaCyXBy5d3sxiD0vD37EqxvyNUWb8kyxUrD898appulatGJGEjiP8s?=
 =?us-ascii?Q?c0Fs5q1ATNQScQcmm4tOY98QDBoG4mrJIQ93G+duhBZmGpy329nQtIvEEJHh?=
 =?us-ascii?Q?xiNUK8KOlFw5hE3Wf6mOt3JiC/oeprgP9R+J+phHKDyNOMlCXzwb7gmNQUms?=
 =?us-ascii?Q?I9mu6+trwVaJH/Y+87/Ja1uV2L/gFWmFt2d8TtuAczB4ggpncRRW3EOfMG6R?=
 =?us-ascii?Q?R+n0GVs0BhJYRSiFFDUe7W8BOP6V0d+2C2aV9dfY4UUHGEK2fYYdLL9318Q+?=
 =?us-ascii?Q?MfZPlMBycRXOVN446aJsxZ9RdVitst87A73fkX9CMwIpNI8BZayjS/HBGyFi?=
 =?us-ascii?Q?vhVBKbkjBYSIQDSvBNWbKtj3VFdCkCdwCittwaD3q22SWPS2jLUUv9gMV967?=
 =?us-ascii?Q?b0wolzSKRCJieBIThEXhVYn8zgWFp3wv56liZlxGngs9l/HCeQ9Bm3tug6ne?=
 =?us-ascii?Q?fC65c0LZF9hnwcDI0b5aLXKLgekBo10yqLw2vURJD7oiUvoufT5sN31qFxbg?=
 =?us-ascii?Q?qmkbTfElupuhXRO7x01mvFdvux8J1Osu7JOEpX18HF/GX+j4+wP0ZpY21ZYH?=
 =?us-ascii?Q?/kuqXmvC8hld7ICN79nkyd+L/yXNBZQeBLdU7+GK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ab22a0-e71a-4537-e1b7-08dd14c266d2
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:53.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6nem3fB92JhKy0W1Zd6VXfj2/MxjMENbZoK3BbSQLTMM58MmqdmsD8sEHHHVUEj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

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


