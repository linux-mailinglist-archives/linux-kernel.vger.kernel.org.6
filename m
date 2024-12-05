Return-Path: <linux-kernel+bounces-432429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C0B9E4B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1892819E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AE11547C3;
	Thu,  5 Dec 2024 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eFHdjs+R"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700A86250
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357945; cv=fail; b=no3FKt0egdYb4LhpkGMkM4DFGXqy2nvfNmyUPLiv6b3YItlKcWrUaaK0dLTJEPbivi9/RKzcyHqO+JasMZSptrENXIqIgRJEpHOgfZGdvZR5RA3oLZKXAvTFYfswsOkU152a2srN7VgqXP20K3THQJwKvKvLy1nTBOicNXQYb3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357945; c=relaxed/simple;
	bh=FNrXjigdhvkcFodLMCKqfeCb412QSIHMbfKubGSOS4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HF3zotVMmIHhwcuEOvN34fNIXRfggyh7ZsEyjRwTf3//2Q9CCTd7Z2WVanDnaJey/T7j1ZR5CSTchpcgT2MXBWxQiCb3URXH8jAatLTEaiTiNDvkeyGgHlGHIBTlTbShAMscI9GQA0WsqQvK1KkBl1Xw+76vw+/j19KwECFYxjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eFHdjs+R; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqtA2kC5x8kCmRjmBrPZpGYQYbBmEeEPpzufMAnjHz5waEzkopJXpm+wBjvC7iwcvyq1r24RW/TU4hoaMnmolp2y4k6fT1gT/WD0mt5Vt+JzL+pKXwe/uyaK6u+JFbMOMuf2zxOEgUqpElYGpOXzexDiYDDg5QCI3oaV228cdYJtWVWVGyk9nvvwy9M98yjtAe7q7DA5HVM4WHAlpS7yVDPKcgoujCf7ykUEFsAhwtOrHEt56HYLVmNPzRZc16NRpKLz5YDh3bhcIcwN5eksw1q7Z7EC6QU1u8kCgtdY8l2kGcgJ5L90Is01Qg9i39k4od6a60qa2nvlcKtcDQxbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZxMul1WU308N00KYNlcxD/DyDEr6jnTyKBgAiwblKE=;
 b=psvpCPFnO+tnf9Y49zocp1Ogdh9VmArxS6Mc0Qgl0dRKXZhfIsoRlv1pREYlex7ae2gobW11Ip5yojbZ0MIRr/A9OkSwuvFOvX4NpjQL/iwE4N4H6S2pR2OBM2TXAa9vl0KCV44zVtQW4DfOeT2Kf/xH525AMC8vIqDY3lHDyKvjqWY05fVmd09RMvpVuvfoLWsxGSmKNW27xNrH0zGTFv5OyO8SjcUB7oCFjuVE3VsY0uYDEernhCQa3yyFiE7EDNdY10XTzCD1SNrTVuXGjYOnfQ0h78se+E+B5bihIDC/aAZoZW2RGgn1hfaUI4x7FTay6YVViDaxzaN8EnlSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZxMul1WU308N00KYNlcxD/DyDEr6jnTyKBgAiwblKE=;
 b=eFHdjs+RZe3gDyB1rGV8cXic5AZvT//3HL5kVkRhQzKGS3gyCrZMJ7fcL6PUZOxE/SV2wPPCLKl3uy2Q1rUxIxUGu6+how62O8q2udEHQpqIaL7QDF5AG4mL4LBRE17O4fQmnABrMOhRpgdexC7+aAb0Dc4NdO7wQDWaRmtZT2F95ds707gA7nizj0XB/cNEpjTuca3Xj0ViEdFJEZHsts1az8dWlp4goMG8JVFczA+pYa5b/D+2L4EoMTdf16pCMTIYHdpDWJ2IA9ho5ju+6E26ndmchRTumKtbNWnD/9LFO5QBZosZR1FYp86gEeCuIWpqbfg9Erf7/t4TtV/CUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:52 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:52 +0000
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
Subject: [PATCH RESEND v3 8/9] selftests/mm: add tests for splitting pmd THPs to all lower orders.
Date: Wed,  4 Dec 2024 19:18:38 -0500
Message-ID: <20241205001839.2582020-9-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205001839.2582020-1-ziy@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:408:ea::20) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c2ee51-40c3-47b6-a3bd-08dd14c26606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2BL0nui5mvzM8czRcS4cP5DUQzQ5dM/JhuNsRgmHyYtq7inVqUq6MTDUN9h?=
 =?us-ascii?Q?d5e7O7cu0qwZtHqxWQou3w7NX3WZLzYVNY2KRUHwUklSHDQm9zctkgqwcPBi?=
 =?us-ascii?Q?sbiYjo/l5wHnSoZVO1+s2AHfkeMvRr6bVBCs+wO3Vg9eHJh42nru8rluijdC?=
 =?us-ascii?Q?1BrxbCq7ZFDOMZ4fP3Jqx53jINwHE7EejYOuo7gafLH8BKQFIuZ2TpgxOxHK?=
 =?us-ascii?Q?UtpiHgmxPlc/NCzARSXHGqGhjchKmRmYTs3N08xGMg1lJSeJlSerZfRKzCgv?=
 =?us-ascii?Q?Nt795Jog/4oDMyWPAhoW35p7wJ7MfVBko0gV4fdOsC8tf0p9q4YlrcYeDx6l?=
 =?us-ascii?Q?smFBs998jSw+GEdrDf9VLl9/UgAwklkz+pBJryernXwYpzDLeprIsbFWOKDj?=
 =?us-ascii?Q?4i2zg4Gc/H3MXfYJy4Fh+dUiAfWrHja7MJSMP5scQkbMGiVwousiEmPRiHeM?=
 =?us-ascii?Q?ILmBbxOiRaO0m7xv9FGJ/yaVyNJGDedsXdTwTABvs33bCjIb07L2t1IH8IkI?=
 =?us-ascii?Q?y/J2c94XdWF+i+YHwMzAOF/TIu+e8QMjAq7+53ZA1t0ogjRCqCCJxgWiK7v7?=
 =?us-ascii?Q?40MZImWTqe3VfC1UJmmCIa6EtEN9ebBT8T5w1nVXj7T+l6kwPPg3ZSPzvcB1?=
 =?us-ascii?Q?EVR5soZP5HLAIYaRIueJehI26w3dHKQJQZ8xF0/H3uaBwr0Jl1AOc67jg/cn?=
 =?us-ascii?Q?/RwDwZTCQRkQf5z+QgtnBZPLaJKrHPWlBepXYn+KknBAHK32r89USkD5Ifd+?=
 =?us-ascii?Q?x992/Rhppdfu14SfpsU2O5NSL6Jvr+772+SnrFos2gFwBpHRbQKMG1QEZpON?=
 =?us-ascii?Q?zL/pnompw7q6BqNrcfXG5G1UvEbhh8ZXMd5Ntyd4KzOE4gZSFjnTBmdoL+zM?=
 =?us-ascii?Q?KqzmkFsLuKyYp1N6zm8JS8bWoJe0WnONPon6Qi5m/of8bkeVmsOJ1cP3ScQz?=
 =?us-ascii?Q?WtKE5qHUFDTFi9r3rM2gpJ2GIQbCBKHQlSumaYdzbngVWfS5I2OGBZlT745g?=
 =?us-ascii?Q?RRN+VrXlGtaBwy90siSuUX/Oo8DF8MD+W1KD0R9Ih8ih5DnPM9RWTLDwT6cH?=
 =?us-ascii?Q?aptRGHaR8LO3tfDdkgnLNQ8wyCvTBHZN7S0QZOdIbMmiq/xiLTFOfmcxXi8n?=
 =?us-ascii?Q?flWYSRbZa5AekYU7C2DWmfFJZ3rXSE43+AXUe0Tv6RoiRZpZh17NPYQW30Es?=
 =?us-ascii?Q?GOYEjGYiMsRpb125thHoL6mXGJlUPdmrXiFvG1+pOr5+xi32uktXwzvaQkWv?=
 =?us-ascii?Q?Tk3hQsLxi7QdP9HDJI9XkMdfR6kIXRSK5xCRTw5CyJ5/mI8+rIflrognT/2M?=
 =?us-ascii?Q?5Lztd30e0Qnqs7HskzQba/0qabTW/IcGdyO/ik/4iVsTCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vVDlrDfsJsVE5jB5WAkGQPNomvbfZFjcKqldYjCwADcHUlwyCKk1aBb5XX/d?=
 =?us-ascii?Q?IZ/qGyyHZWk/ypmZVnyY+eXbVWk5femJ0MT1+WZy16i5yOD6UZy0ju8VAsMv?=
 =?us-ascii?Q?alq1Dm/X8/zZfnZCGvp2HLkcnGKe09LWmS5KgLitFyFBt6BED9jSb7odIKLi?=
 =?us-ascii?Q?2bXpITs/LHj8N3h9Y/6wbIihfvh0uCUMv9ex6cEOIITI1bYnNsW6vH14NKBb?=
 =?us-ascii?Q?2xFt9veFX9vivqT3cAffVJQEd2AixWEN0d4jT6xDahDQcujx/e2z2spOspjR?=
 =?us-ascii?Q?RU0qa3Vo4eYwy4LdNEpgWkeDMc8AAHGYKrlLdMV5jxaK37Ikeo7hHSLDUYIM?=
 =?us-ascii?Q?iWMy44OjsDdYCxF0v5+V/aLGTqdiXivDvoRZQLK9P2BfKRR/cjTZdcBsJiAL?=
 =?us-ascii?Q?2fyiEJXWYENPJQQyxYQrAST/ihPqVF0T/HlfqGeYeyIfap9QDFBT7vGHViAK?=
 =?us-ascii?Q?4c16snTZDNE7ywM4v0eDOxGCIUrsaFJp3ovDAMTHQXGdZzOvaf3+w4PIK3uH?=
 =?us-ascii?Q?1562zHErQIqd2qYQUIuDvstqcv3zJsJYir11PN259ZXvN/1/aMhA9WVT7DJx?=
 =?us-ascii?Q?reNPIOW5BS4TiN28iUYfGlFrDgcGSWX3OPv/Ye6+pzf2nVVkhHEfwKNC7lq5?=
 =?us-ascii?Q?CVkaryhPA+2etm+TuCUsB1ryUMEFqSIWJ79HDpk9qr/uJqooxYEJit/3yXrE?=
 =?us-ascii?Q?tch3ezRmRRovyBW7B29mn73jk2MOgycneyS9l8vDt5+ZpBIGhUyZNSxmzNLh?=
 =?us-ascii?Q?zAh5Ul4xUodSzzgiNysqd3mw2zot6zHnX708aFIFogdBnd3dm7ha3Fjzj+K9?=
 =?us-ascii?Q?ykTW0peQ7Mi+9VaIyTWQX748ejoDVtSW94fcfrWPhNvswuIEkBfAK6ze6W50?=
 =?us-ascii?Q?L2jQI3+MulA1E+xOv2SuJA6aYvEpzu+YlibBFIVovPwha303RlktnuZGbSm2?=
 =?us-ascii?Q?4cN0sbKcrkfFDGzxmWDhqB7HH3CJq8ZOwnWZ0ansd7VAI/UfoOPUgRt/GDG7?=
 =?us-ascii?Q?khi1pph06RvFzSiJIEDyNSiAVrBvZkDo6NMPehVuiJnDDXcDBiG8QT3M2T1l?=
 =?us-ascii?Q?nW8vFVuNF15+mGK9khUyveTMPk/aFANRJ0+qyRnG0gVs28ULvFzhAUGrKxq1?=
 =?us-ascii?Q?Sn0qFQV5IcznO903mrbWTQMQDpmYShJxlQsbeketQB2z0keHuEjCJA6d0SEw?=
 =?us-ascii?Q?LMZl12GdLTjon0MbGE7kEtsPPqKVm8Im+MsKh6rKeL9syh4Oo11lRuG0l/pK?=
 =?us-ascii?Q?KwdaHLcEGNR7PvA80xycvKiUb86PtIhO8HtaAOuGadrEqqleCdEaNz4ZxhhL?=
 =?us-ascii?Q?ACHJj/UOG0Lcw0Q96yFECvbbN6dx6Vd6qAVIjPxYiVPaiiWF9CBgJHy4qC9J?=
 =?us-ascii?Q?1cy+A9cW69LTAMAw11vrdvWS3KdIDPpdpUvHPkoX4ZAmGJYfjopr1dKQVWcs?=
 =?us-ascii?Q?eU6+cq2StzGsMVEBQGp50uhVXJ8s6M+hurIeHQ8piUfDCkWsoywWxbQ2RqvD?=
 =?us-ascii?Q?b/2ranZUoBH1CodQ134p9pjCQoaPT0daMgmoEUeDxOrQ3cI9djoKUxlSxXgz?=
 =?us-ascii?Q?U90E1S2YqPifbxzhVrd2Efi6RE52rr0SFv0f89ed?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c2ee51-40c3-47b6-a3bd-08dd14c26606
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:52.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM5wsiLeIf/f6wfb5R7a/NnCXOti6ztmCm5r/QX/ruhKduvJtKc0x5bkfB6gEhKe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

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


