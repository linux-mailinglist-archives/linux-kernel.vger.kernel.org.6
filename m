Return-Path: <linux-kernel+bounces-385568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF69B38C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CEE1C2151C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138891DF73B;
	Mon, 28 Oct 2024 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UO1ewc1Y"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495A1534E9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139001; cv=fail; b=XxY17gXYJSLYP2qMoKtIWaBbEYEqMtNWoWsFvAMPz7TeRQk05WFM+ut4a4oZGEEosjI4KTevJ+9DYhQVWni9mxnODCl13S/wGjWmYKz16PPJ64qgWl7XPOUdieEnPqhvRhxQCV/BQ8I1S9X7gHnCBOZQeSOSVKJWudftMSTK7rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139001; c=relaxed/simple;
	bh=c3yu3tF20rAnD/1CVLxqMCSIrvUZiD2DLr//JJRCnCA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L26/OoXEf4ShRBah7a/n6pLkUzdu/gzCJ72TMOF/knchp3RopvzIYr6VUdc5HN4UPQh37wkKyhH0Fvzvazpv7jKDiUChKtmr6ccIINPGUSuiZCRyRxQg4Hpeq6DQNANFn+EF3JU4uZ0SvzkurW5wYBt0eOosITbHOZ2i2tQHtlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UO1ewc1Y; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8Z6nEbUCz9V5kZQacygwwdLpL5oUlCwmfNv/gm9Ondi3klb/UuH/OTHo1Rh6QEJR3YhhS2b6+NZikwo6QeW2ZeN5xlrFjoZOWCrqaUM6NNqTfcGc0bLp3t11dIBGR6YSiWH2f+84DkJLdkgyd77kidOO1GAmaxLcfNyE7X7wQIfGnDtaZ9ZGX+GqqlSFHAj9FBHvyoojx1xAIs63nAFru71ZNHwPnT9sxBwrfGFonXxfQc98UEH5U9/QQ8EljC0oCWWkvjD/SFyFuSgPSwOdxa8DJHU9OUnnU8eg4CJ83OZIuTdZclw3HiHimv5KX8aUjK+9px0N4I0C5/2TbH+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhNkdqspcPomZkV63jkM28jRLYXSPL4aGY/j8a9zQs8=;
 b=oeGio1ITn2cFeOfmk0L1VhZ7qQAxZTyqFCpiKdbvaLoU4ntexz64Pc5NjtxCZvGjb+3gTTfZBgbwSZ4cyWWyFwrVTN4PyzFiO5kul8bu7An9LXsCudybTewhngfCgp2Wmd7Xxr+Dyf8zFq/OPwalS4SVVDsvCVwJMlzoYwdbiubdKHfRXuYqAfsJHJHo3VuVPnYL8c8lfIa46oLuUPmrHIwk3POUAQ53R7igUbMgLPNQTR2eb+KvSVZnEldxwH7bls5ts9KKu5mD+4Vxg5/Ne9xF4IMb0RvcGoFgqUWo+7DWZBxSYgs9+cDSmgKvsDtrBG2P0O9ikpg0Gc0lrTvvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhNkdqspcPomZkV63jkM28jRLYXSPL4aGY/j8a9zQs8=;
 b=UO1ewc1Y8npkvtZsO9QL8kbOCf7OEMTSipwBYPU6cuBc/mlmgrdjMGMIKRyCTi58RTVVbjYvYLPdLJE1IkTdRpUnPUjw9LL4rAPO1yHWDuEOP874hfH7Vp0i4i853DUYQwpuma6IbrwYnl/keFa6qa0BOhpNEbTQeuEZ5OPW3lMYGk3cC85LHCTK3aebYDEhRUbW91Hp6bREPdnVn/U/fGdmmEsuRNVlUgTy4xl+rBuQiXO25k50qf9Fp0p82YnN+2YLqoygqsxkXg11Ryy/eU6S4+D6GslDxLpb1hNvzlZrlvH3ZYzgxWz/QeVFOmza2WH8KiT0E0Z9WrBm29OEGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Mon, 28 Oct 2024 18:09:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 18:09:55 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 0/3] Buddy allocator like folio split
Date: Mon, 28 Oct 2024 14:09:29 -0400
Message-ID: <20241028180932.1319265-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: c657f5e9-00c4-47f9-0f69-08dcf77bba1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3EzCOrt+oFN/GYfijRWUJmR+FcDllTN4lVQdLUyqWbFKP094nWWaCDMbHM+I?=
 =?us-ascii?Q?oCxPPay+wI7+kqMOstluexO3aXfF+KhxEV5CoDBqKKIdO56LMgMVfg2QuO5L?=
 =?us-ascii?Q?ruq/N16U2DmRPeYPDk3WzEe75RLysSDjjs9WlnCbrDZbJzvwGCtZcp1Msfb2?=
 =?us-ascii?Q?JnJwjrZBdwpQt+OM/WXTJQ/aL11DA/4YYTz7rLSQWuwBru5l7IcFelZ9fw45?=
 =?us-ascii?Q?iMxC64nQYRW0znf0v4DxGIbsNt6RgW4hxdYLpXKhrpjlmzenXdusOxwDagFS?=
 =?us-ascii?Q?dC/FPTyDSiu+Zi5IdoXj6FHCrZWRWpUyf7rv6rt6jdRiwAnfKEoC6xmOyQ0F?=
 =?us-ascii?Q?ohqKsPoOCaGg8xVr6OGYTaM4AagZvFm20eVV+pbBbWPMl/GCoh16CUgKTNJA?=
 =?us-ascii?Q?EcLS+03mQZ6f8yQu6tia/xaY8RyhTTjaAM5T9rAD6tZYTQbWxI2BkSWe9Vl9?=
 =?us-ascii?Q?ol32WirHM35CxKyf6t8ZKJVa4zjg81kMMWUtlW2pKXR1d58LgBp5m1N4dkoP?=
 =?us-ascii?Q?i3gjg2EhdCRsaRZXwgrWLJ6dFxNyR1saQeoos+1/+oXj1Mzid3EPmLwR8MNz?=
 =?us-ascii?Q?K1I+4sgvbZK6b4OVgjfn/2Z9KbT/1CTEULkAimJ7FfGboCi7znJ+Hzah9HoH?=
 =?us-ascii?Q?rcqb9w1/h18F49Aiin37IrTJFXcCiBwjG06fgVjoGEPJKLIONJjxU45fdDMx?=
 =?us-ascii?Q?Q9CMDgwesR0iRithtNpCA0phqvkQLtUJvTm8lyJJAhkAPAbU5Hm0W1vsnLYl?=
 =?us-ascii?Q?feM46skT+wdN+xNS+15sDjdUmt7OCRC7bljX5PocG6raWYEzYgSmb8GPNE3P?=
 =?us-ascii?Q?vj3jgN+2SLhwpqk1MQbufIFWLDAvzb3vcW11SPb3kQqYRPWHNycLf5pUC/Hx?=
 =?us-ascii?Q?oxRGJoWcYsyQUd2B45uJ0S5TUDwu639BjesV8Xw839sVIbImaPz3fsnAnGQb?=
 =?us-ascii?Q?IhyTpZq8bsoXF8cma+Trs0NaV5dQP5pemXQMiD8rldxuXt4PQ0XpYEfKGBsd?=
 =?us-ascii?Q?5Q+a4l+JnGHtRs2HNMIEf9vwRC/cM4AIFNwyLQcumBppm5YUpA4ce4wfKoKu?=
 =?us-ascii?Q?zbjGWKRExS9ne1IgbZSeI66xk0qZHyQV1yZdq+SAg+KiFzfV2BDqrK1tkrLY?=
 =?us-ascii?Q?Znm8BIEwsunCe8oCytCI094YXTz4woq8roSU3/jt9DQ4eVzGvMkcknPtjtvi?=
 =?us-ascii?Q?l/mkVa6UlxUlncpO9OceK511FSKSsXYDnGCCgI5MAlvC2LzDw2OlbjPzIXDx?=
 =?us-ascii?Q?3uNXSO9tDUR8CCxCS4qSOWKGP8EB0/Rwa60EAxWL89gfKfaOOFmZW1x2TiwU?=
 =?us-ascii?Q?JLlA6UIR6QPMvnQmLN7Vt5j8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUkk0owgh7+XO3MyXUnFffZQW6VEhEQZLsxyVXIs9k4ciEamQTUS/RaK7FYt?=
 =?us-ascii?Q?8MCzSua7+cuNC1rOJIyn/nxDYca/utkcQqtv29HjopnvaavHW95ITZugYDjR?=
 =?us-ascii?Q?FAJw19ilcmJgnB9YWvtTvTdgd4n8iqA6SMnfWkUtMQvehPwxGLxglsdCOlsp?=
 =?us-ascii?Q?sCRkH+wooFB9y1/g7LcXwPRkwY+vmpdLE442IKIjkBe8N1quZdikrnLrVuwf?=
 =?us-ascii?Q?etg5QnIsc1M+oWQybvhQP8LGvvB6SZsMIYtvkku2ZtKQ7vmlj2nB6TLisy+I?=
 =?us-ascii?Q?ymaGo9ZqoyEg2nDjN9S7fMU/HqxhQYxXEW2i3TPp0V81JRANbChJYunvUYkH?=
 =?us-ascii?Q?4uetK7Fkade6GpX29uN8JgR0Fiwt0KjR1koR6rVZOtKtfPwLCG+5rbOIMaeT?=
 =?us-ascii?Q?VQdS0IS6SuU8f2EGEb9K+f9hl7XKU5tD0o7oRm1MFEo+pgA55qQk0y0rLhbX?=
 =?us-ascii?Q?JtgEe0DGNNlxLUZ3PDNXEaDvf4az+yniiZlB2wxGMsVIDGSY2YrjaQ4frVGR?=
 =?us-ascii?Q?K71oXpthdtpWZ2xjvK4GoKx8XgFn51dqGwN7JmcnWvYx0AIXJ/zVKkauuZPa?=
 =?us-ascii?Q?x6SVD9X6zaaRnZralVDcWTT2+8jfM5lyxyX/2WqgMRd9MA/VKZAFzmVN1dIE?=
 =?us-ascii?Q?ZiLrHp6Aov2CBQWy6ZRtQ2h8AlHpmkHUexhZm72QvgTuioZK/HQtn4wENiL1?=
 =?us-ascii?Q?6R5B1Gl8BIKIICxa06oTRltUk0U9l5oxNor4HCZ4MfrJEjwSffvtgZCedufU?=
 =?us-ascii?Q?EuUhJ/8e38F2F11B1NwK9VQ6ckBAvwhJL8jK0HE7ULGstGRe7rKpAgNlEmFc?=
 =?us-ascii?Q?bYB6HmoSdyvnS1YmJgvlRhQkoVM7ivLBbMgOJlnaiMJS/1ujWdMjsoDfQ/mm?=
 =?us-ascii?Q?2XiG7vWo99veU7fE88/34tG2+g/6pHIF76Bb0B/AlxLCxbzrAKKq31Ej9Tsk?=
 =?us-ascii?Q?Yt/zTVHwB7bdfJu6A8ZLNsw0m4NktnfFkhTgarPso7gZYej7iJ3JwBgTVprS?=
 =?us-ascii?Q?R8rYvr3Gs1M0koxGHY0R/20mQ6tqEKnFF3PjIWYm8Z7Jetn++0oXVOkhaR0/?=
 =?us-ascii?Q?ChJIWWnCFbvGer/MutKAuQ9tIsMyAKT1BBnZ4/6iE3gSipXYz7C9hyt+IdlX?=
 =?us-ascii?Q?acIh/Ll9ou5NpVyRtVPD8Ueh3ZVWmFT/vIVhBwgmL0PfrVm6XEe4XagRviMw?=
 =?us-ascii?Q?kRewSPRrOjLTXlEjMUcTckkGHjJSUp5roE+KyuDeTRhHX9HvxQChwDDeoK+K?=
 =?us-ascii?Q?JbejXXhTqUTPrTBfwodmpxCOIQ3nKzFAelRDFaNKCrmq7wnktQQc53Rxe6p0?=
 =?us-ascii?Q?z6fTB7YwqLedRzApqXE0QBoCr7gwqCDhOcaaft/j9q0nYc2KUrWlC6dWW0yZ?=
 =?us-ascii?Q?zO0yc6fU6hjatrPMcdzJQPSfEhMXSIdd70gJ3eanIoOuhSDaN4vIzGgZWFmF?=
 =?us-ascii?Q?0apRTHY8XTLbNi6yGckTnCnWmlJvFgq1Nj3wzk8d/Wdckj1IA27afQWVznDQ?=
 =?us-ascii?Q?R9KmduiK+BI+ZAdo1TX9E2MRK5up9o3Px05ntsVvHH6PgPg1YMoU3SNiTats?=
 =?us-ascii?Q?8sKiu1Q6ucpJw6wqi/RfapEgTmVn77rKNE+z3zhB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c657f5e9-00c4-47f9-0f69-08dcf77bba1f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:09:55.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vjw3gN1OnCePn9oakQMSeBRjplftFAo7BsTXS7y+Mtd/JwOfZ34t32kC7H4W4kKp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

Hi all

This patchset adds a new buddy allocator like large folio split to the total
number of resulting folios, the amount of memory needed for multi-index xarray
split, and keep more large folios after a split. It is on top of
mm-everything-2024-10-27-03-16.


Instead of duplicating existing split_huge_page*() code, __folio_split()
is introduced as the shared backend code for both
split_huge_page_to_list_to_order() and folio_split(). __folio_split()
can support both uniform split and buddy allocator like split. All
existing split_huge_page*() users can be gradually converted to use
folio_split() if possible. In this patchset, I converted
truncate_inode_partial_folio() to use folio_split().

THP tests in selftesting passed for split_huge_page*() runs and I also
tested folio_split() for anon large folio, pagecache folio, and
truncate. I will run more extensive tests.

Changelog
===
From RFC[1]:
1. Merged backend code of split_huge_page_to_list_to_order() and
   folio_split(). The same code is used for both uniform split and buddy
   allocator like split.
2. Use xas_nomem() instead of xas_split_alloc() for folio_split().
3. folio_split() now leaves the first after-split folio unlocked,
   instead of the one containing the given page, since
   the caller of truncate_inode_partial_folio() locks and unlocks the
   first folio.
4. Extended split_huge_page debugfs to use folio_split().
5. Added truncate_inode_partial_folio() as first user of folio_split().


Design
===

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

The split process is similar to existing approach:
1. Unmap all page mappings (split PMD mappings if exist);
2. Split meta data like memcg, page owner, page alloc tag;
3. Copy meta data in struct folio to sub pages, but instead of spliting
   the whole folio into multiple smaller ones with the same order in a
   shot, this approach splits the folio iteratively. Taking the example
   above, this approach first splits the original order-9 into two order-8,
   then splits left part of order-8 to two order-7 and so on;
4. Post-process split folios, like write mapping->i_pages for pagecache,
   adjust folio refcounts, add split folios to corresponding list;
5. Remap split folios
6. Unlock split folios.


__folio_split_without_mapping() and __split_folio_to_order() replace
__split_huge_page() and __split_huge_page_tail() respectively.
__folio_split_without_mapping() uses different approaches to perform
uniform split and buddy allocator like split:
1. uniform split: one single call to __split_folio_to_order() is used to
   uniformly split the given folio. All resulting folios are put back to
   the list after split. The folio containing the given page is left to
   caller to unlock and others are unlocked.

2. buddy allocator like split: old_order - new_order calls to
   __split_folio_to_order() are used to split the given folio at order N to
   order N-1. After each call, the target folio is changed to the one
   containing the page, which is given via folio_split() parameters.
   After each call, folios not containing the page are put back to the list.
   The folio containing the page is put back to the list when its order
   is new_order. All folios are unlocked except the first folio, which
   is left to caller to unlock.


TODOs
===
1. xas_nomem() is used in buddy allocator like split like Matthew
   suggested, but I see kmemleak during its use. I would like to get some
   code review from Matthew on it.

2. A proper error handling is needed when xas_nomem() fails to allocate memory
   for xas_split(). The target folio should be put back to the list and
   all after-split folios should be unlocked. (I realize this when I am
   writing the cover letter)


Any comments and/or suggestions are welcome. Thanks.

[1] https://lore.kernel.org/linux-mm/20241008223748.555845-1-ziy@nvidia.com/

Zi Yan (3):
  mm/huge_memory: buddy allocator like folio_split()
  mm/huge_memory: add folio_split() to debugfs testing interface.
  mm/truncate: use folio_split() for truncate operation.

 include/linux/huge_mm.h |  12 +
 mm/huge_memory.c        | 650 +++++++++++++++++++++++++---------------
 mm/truncate.c           |   5 +-
 3 files changed, 422 insertions(+), 245 deletions(-)

-- 
2.45.2


