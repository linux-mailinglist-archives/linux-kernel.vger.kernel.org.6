Return-Path: <linux-kernel+bounces-322027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9DB972308
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655382852C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BAF189F39;
	Mon,  9 Sep 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C4S5s+fK"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010008.outbound.protection.outlook.com [52.103.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4606189916
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911782; cv=fail; b=eBxuK+ehCIgDinBi6WkYj6SeMN6Era/bN9c1Fqa5RpOlWTvn2Gt/OOgz9aG6j7fNvehJVmkSSMv5yLIZhCTLfvsF1dUE1bSTzcdG0X1L0RyC6IpY10thaQSK5lHspV4fM0G1i/Rof+nvZUyCKVGIYa0tFVDxuN0nmNbnYjz89Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911782; c=relaxed/simple;
	bh=oSsbxPh5P0+1b31iMy+168RVmRI4ZmWGhF3ipo9W3b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Re5wNawzgsEC+asfylVDkSEKSaQqX2wsRxz37Qi4LbCTr5OMYUwCVCnqf+1FyG1d6TTX0PD2VAZnrHQtaHHkTND3zU/xebMtIX/UPIMe5x2Dm1Wu1eV/tJo2ySeRsEXqreUVs8ISryCD+aR2nM3zubWnvtZE1H5RUVQesQ9foAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C4S5s+fK; arc=fail smtp.client-ip=52.103.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6aWxEKTXwEDDDXCX9i0oLsfnIAqpgeKoj8MEGF/FRifTES9nvfI9qOCEAFgjuMwSnXxje3tJ88LzIz73UHnjVDT4muuXsKmjcQKPEk/pP9zug/5tWReLrj3Lo8qjZaSK96l0/zJW/ZgU1AhEtIKLD2QI7MsXcj2PLzmtfrcvNr47LWqEqUodn8Pe8hk2UjdbNCZ5DjqGWs531ykDZ8LhQNpXV3wbqHZFHTmhm2h06kQ4vag3N7kcuJ0UTK3jtquzGhBclT09yhMVtHU99MMIesi5yLmsLhyuwhgUiIC0mZjNfx+hrFvtMHxu8T3dZpFR6Edd8TAqEJvYdhM937eDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSsbxPh5P0+1b31iMy+168RVmRI4ZmWGhF3ipo9W3b8=;
 b=CRu3UZI04CFJLyQI4U7I6KV9NETGTHoB2/Ai9KpjDl0ncLENZvs1J0DCzod5RGcFkgA3bEs9CcBTehDYHM6nIBT/RCjgoEY/cCl+hBTBc22md0XwelShSykOx3ZCA6/rkSoEG4yxsZgG4vmUh2F7sh0moRKTC72GqIHObekMiosyVyHjMN6My0M+rdBec26SfDB749EkfRrt3GnT9xgJFpXrvmiMZu1UHYrEyvUlgpXd9QOvYKMWSDKfYMvGWy9BX/YuDLmffMneCpwnIVgHTNaqx0kwM0u3azvQDBIxUBe+4jBlLbIY8UrtQIEz4OAUe2JQPyzJYQ2I10WW8Erd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSsbxPh5P0+1b31iMy+168RVmRI4ZmWGhF3ipo9W3b8=;
 b=C4S5s+fKXd7TBi5Ht0GQnmJIh0HAJqQO63jR3YCTg3840symQeEjemr4jtvtKPyd347azVhvO/WfJLTVTSniqqTTkmX+mtRMZQoa6jmTxwxVXjDx1YCyP5n6CHuWPvaO+aibh/M8q7eOEpLWQLAtnZqJfHz0jD4utnAD1CHmTzX+Vg4L1ydAhuWrl4qSFNLaz94Yk+xRd+NoslShEqCIEGdeY17ssgA/QXDl92IsWIrQaEnNPUCVpC7Dhtr31391eN9cSOPVTkvEc/DpDWC6JZwYkkK1zG9G6FkwZzighx5vnV1P/D3z9Ar4H6C9D3aux60sI3w5u5wMxaMy6pAlAA==
Received: from TYAPR01MB4685.jpnprd01.prod.outlook.com (2603:1096:404:12e::13)
 by TYAPR01MB5740.jpnprd01.prod.outlook.com (2603:1096:404:8057::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 19:56:16 +0000
Received: from TYAPR01MB4685.jpnprd01.prod.outlook.com
 ([fe80::a74c:7635:19fc:8742]) by TYAPR01MB4685.jpnprd01.prod.outlook.com
 ([fe80::a74c:7635:19fc:8742%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 19:56:16 +0000
From: chunpeng lee <chunpeng.lee@outlook.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	ioworker0@gmail.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	usamaarif642@gmail.com,
	v-songbaohua@oppo.com,
	yuanshuai@oppo.com,
	ziy@nvidia.com
Subject: Re: [PATCH v4 1/2] mm: count the number of anonymous THPs per size
Date: Tue, 10 Sep 2024 03:56:01 +0800
Message-ID:
 <TYAPR01MB4685E67999FE3372EAE2CC4692992@TYAPR01MB4685.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20240824010441.21308-2-21cnbao@gmail.com>
References: <20240824010441.21308-2-21cnbao@gmail.com>
Content-Type: text/plain
X-TMN: [Bgcc0WHIwUZXUtKB9nLAHas1P0PMvVVE]
X-ClientProxiedBy: TYCPR01CA0194.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::18) To TYAPR01MB4685.jpnprd01.prod.outlook.com
 (2603:1096:404:12e::13)
X-Microsoft-Original-Message-ID:
 <20240909195601.55299-1-chunpeng.lee@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAPR01MB4685:EE_|TYAPR01MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0ab94c-e963-4e2f-fe24-08dcd10976fa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|19110799003|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	yPGLPXyELv4d8cAvy3ZUa75Prw9W2N1Kcc0flL+ed+9yUW9JvrwF7PtKJqN6NtpZgqreDOfGq3zneNxNApa+CCnFBdVJ+MTLoI0pfRV4hfOSemWOc+cgBrvFHvq5UQPqoVzAHSR+uYN6xtNn7Q1Uwv+u5tb9dmxrDYqDia/q09Fc8use+Y4EUhMFbQlsvL7G9G6gMEfZh6gJpQ4sysQWWQxWLBCXYrlXWGn9+BZbDMof37m220b3TKVJxHz5k+kbGDRthhha9GYopSaMrFJ+Lxv8eaFDE8YCcSA+QtB3oa1cO1fAbjE/l/76gX+GJWFltQ3kwpqQHiwcMb5x3cVr+Gp7zAaUzHIfyUZgd7iPzFvBGr8ulnfctqG8qxZJXDarcF1g5n26sngbGLDYiRVIWXuHiHRHX9b3NHt1bhPzbtTfn0/VBiM9gXVIOC+pCDm2xucjd0UHbxNBIxkapNLYD1ZkQGJ2LrPLDFEYxFS257iRXdYjqTlfBUMCQOYK+CtuMSnv/t3K1A4sjrpr73FqlaYtAZaNxMi7M41ZcWvg0aqdtn1fAlaZyaARCyI1TnzBkTiLlZxRjcItiGnHxw6gLa/bANNJ6FNnCYMhUE02hEO9ifNZ3uXuXZP6gv1aExpqDqFQPb/L2RN7rmAj4vF9wxcz7XxSKssc8QwWoZ/L6y1MRDfqcxh/CmybYHFr2/xSO6e0aHMsowPvVFxZDoiI2Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SgRJyrS7u49ADLvikdXrX4xHtXvONoTBBjQkd0j1GvScuyFtYYEnZAdebrHC?=
 =?us-ascii?Q?9Hib5UZcm7qhIBr4RpTvhRMpDnS/zO4xEaJDET1keBfsYp04pZmU++dmQmXc?=
 =?us-ascii?Q?WY6WtnNhUO6Q0aNIlY5s9FqfdqWKe/B6x/1r8hS5doxtH5ufJiRMKJcU1023?=
 =?us-ascii?Q?4ay/VC9QwkHi2VmzIH3hhl3sREf679obuwHSlaSfFCL+cPpvpyG4sZ0ZV98e?=
 =?us-ascii?Q?q2gmI5dGc8u3nMDw0FGXSP9IeD0o7o2VjqlmCcY7ppt2pz+uOC/xWaMuv2kP?=
 =?us-ascii?Q?mNnDyI8U7ZaDU6I8BGZCWfjL0iNtRXbs8lhjMZw2nzpzVcv3adQ1jTeA9LQz?=
 =?us-ascii?Q?ugULNf3mMJHB19brHraPkTLp2QR5Xe0dIR4RWoPTYI6Ji01MHAp8ab1GlcFo?=
 =?us-ascii?Q?m+VyThdo/tB/QmB+awrkkQ3MQPp2wDDKudIqf8x+PTY9WMxktc8PbiJfK8U5?=
 =?us-ascii?Q?mLpw8AXjTbcRG6KstFMOn4xaPGtGjT/krvZmnXQ94OgtEfHKbn3fgbIpZnlr?=
 =?us-ascii?Q?5DRSH4He8I8r0SgbWm/AIVqs7/ZzK2NCqsZo5Mf4+/lUQauqsOqGj8cm4fQj?=
 =?us-ascii?Q?5dHRFgUBRBeCuujEyT70HQRNuBi7Ps/78QC4N8rugETOTfTIO/N+xs8q7Dvr?=
 =?us-ascii?Q?ImWu5tov2SAN1sRn6+tpgtGSl931re4cD1cHkc6Z0C8cRjFaugHYcog83riB?=
 =?us-ascii?Q?bgf2YcgUwJf64kIv40AnidQnVRV28lXrukALzxiO+YgSooJVXe2MXOjBSqeM?=
 =?us-ascii?Q?yXucH/IHol/aRwB72R6ZgGpGELiXEJRRBR8A1mPL6JQkjtNqGF9a81GzT+LU?=
 =?us-ascii?Q?EbSA5P1QA/VQRX+pmnImfJ5HI3PDJFmYrlHBLbtkD2mZinNZOEAayJdeUSXi?=
 =?us-ascii?Q?P/3A35Zq4SRVLZac7DR0Qzse1lXq+/sC0bw9eiFCEwLpb5eT8hGG8LdGUQ+z?=
 =?us-ascii?Q?lvE9GXUbabfvBaMRqKSjFXcYcoZFSLZQOpPbMWylT+q1o2SS1Mq2drLB7Wco?=
 =?us-ascii?Q?NZPcQwoS2Ubdx7PC1AmHU23I9KFRpQL+vJprMfwecv/joZatEogkWkggO3Zm?=
 =?us-ascii?Q?vApisnP+Xx3uXgnSuQh2BNmjLE1hwXLa0FcbgBr6VPhGMMovtZkT0MlZNGNy?=
 =?us-ascii?Q?99T9Z8mnMtCZ806T+i1kzl2yKT2WNhsRxgheOXEwPd1nY3CsNENnBxBo+5TT?=
 =?us-ascii?Q?dLBLUWkkh5ZjpB7YtB0ONuMphXTiTYNIcKAelkTdSoZ8iaoMEB/49GgHjiYd?=
 =?us-ascii?Q?xhcw26Eg2r5Jzqq2sPrw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0ab94c-e963-4e2f-fe24-08dcd10976fa
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4685.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 19:56:16.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5740

> Let's track for each anonymous THP size, how many of them are currently
> allocated. We'll track the complete lifespan of an anon THP, starting
> when it becomes an anon THP ("large anon folio") (->mapping gets set),
> until it gets freed (->mapping gets cleared).

IIUC, If an anon THP is swapped out as a whole, it is still being counted, correct?

> Note that AnonPages in /proc/meminfo currently tracks the total number
> of *mapped* anonymous *pages*, and therefore has slightly different
> semantics. In the future, we might also want to track "nr_anon_mapped"
> for each THP size, which might be helpful when comparing it to the
> number of allocated anon THPs (long-term pinning, stuck in swapcache,
> memory leaks, ...).

If we do not consider tracking each THP size, Can we expand the NR_ANON_THPS
statistic to include pte-mapped thp as well?

---
 mm/memcontrol-v1.c | 2 +-
 mm/rmap.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 44803cbea38a..3e44175db81f 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -786,7 +786,7 @@ static int mem_cgroup_move_account(struct folio *folio,
 if (folio_mapped(folio)) {
 __mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 __mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
- if (folio_test_pmd_mappable(folio)) {
+ if (folio_test_large(folio)) {
 __mod_lruvec_state(from_vec, NR_ANON_THPS,
 -nr_pages);
 __mod_lruvec_state(to_vec, NR_ANON_THPS,
diff --git a/mm/rmap.c b/mm/rmap.c
index a8797d1b3d49..97eb25d023ba 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1291,6 +1291,11 @@ static void __folio_mod_stat(struct folio *folio, int nr, int nr_pmdmapped)
 if (nr) {
 idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
 __lruvec_stat_mod_folio(folio, idx, nr);
+
+ if (folio_test_anon(folio) &&
+ folio_test_large(folio) &&
+ nr == 1 << folio_order(folio))
+ __lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
 }
 if (nr_pmdmapped) {
 if (folio_test_anon(folio)) {
--

