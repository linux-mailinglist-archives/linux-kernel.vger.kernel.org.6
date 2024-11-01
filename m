Return-Path: <linux-kernel+bounces-392421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD179B93ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F0CCB214C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1119DF53;
	Fri,  1 Nov 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fv3O211I"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725C3EA98
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473453; cv=fail; b=bRLlUpQbhxwZ9SqFS0Ex6rZz0pjA1LrvTmoXyqnal4JyAvXSMEDVkv8sKEkaFjcS/LQDQVarj04ycFxCRzWMaTSO2gBHEA5IWrboG4NLkabJqHMWpGfKVApo06JpkwcEUzBaze5h5lZSqqUJmrFsAwejq8AlMOpqpK0lmZRnZhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473453; c=relaxed/simple;
	bh=hwdmZV2WXXuWMtTz4ckkNHZ9jiNyjs43i1d01kjWMVE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LlHkJ3mfu0CA4CjTGqKv9i/V/bSqQBtsXt/Rr9De5DXOo52EAJSvtIaHCpq7CbWRzTLKLTOCv0chQncnuJ4UmpNIyiZHWqVLLnkmgAqU9lnHp//IHvu5fDaSzDTImvaEYKUiFleGe0VSXCg8dP16pCt8nUNwHMCbaP0Vsfm/5/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fv3O211I; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cg2a/sMqRh3CWVbu72a7cQLs7/l2scPTKj/H4jnHcSboF4g8/P0sBMpMk/JIoAkSF7Np+iVPZznA/cNoNPQFJfCupR/okh9rQOKzAbpbPLEnf0PHx1yjwE5r/+3+qyAycESbgJkJsFQDXgj0IkqukuYDrbapoXvy++prFmyxyUd4RwUxr71KF9/Cr/Ifz2rTP38svOUD+FHMCE+9RNTJedb7bB9gjnzqfkzjn9LNkPb7N1kBPqyKlkHYuTOnQ01GNd5H6CSUyOIsrQ6Qcqg+l7qpIdNBRs5zjfpc5n9cA+HEHLlqxCy5manvZSl40RlFzKQ6TLn0k39M1jhsl3DIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgYKFy1DPpaEWc+t7QQstIY1KRVKrN4U3euqIMnQWAw=;
 b=AJrS5hIP2yyt4DClQNk5noMF9SyaO7Ys1L/YqYzKp551nltNnpRZvqC3Y0c1IrcyHMJqCcj6X0jY6l2pJHqe1ZbCE8uM1cB/JpP0EjhOGyON1J6eFcWVUtXEZcAmy+mfiCZEHC3qvsWNKAYld+52mOSRovPQoz+KZ7mAJbUrfxpGy4FfzrHb3Gj9eN19GzmuGJFWFqbza3CmtOggW/N9JxnR8MpzNIclCr/JmAA1Ky5mGmygwWNExpYSBML/+jjCPVvybkZUwpnVW9jeUIHOoHioYs56vwRFwwQ59jmpDiznCAls63dkLFqCuw/plkWuagrehPg4qmM5H2bVViyIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgYKFy1DPpaEWc+t7QQstIY1KRVKrN4U3euqIMnQWAw=;
 b=fv3O211IJ6iXrmAJJobrgRTBYyrQoBoOlBh1u2MqPQ70y9abSbRKsca8NtpxxyG6mP0K77Iowv4xOxmNKR4wn6HtW1dtxKWwTbGh0CgoPl75Ca5fXZNQ5CfqLFNV2qSM2L1tFg5z/wXg4TxlGM5ctSH+qKbg8XDTv3kyPNIKjuT1IqkifVt7S9baRJLLXX6UeulwDe++5D6APFOqWEYXITF2r/RFk4tqyXVxcMVr4o01eP8uY0PEqP2TgDkfLomVCtXXp3R9QlBhFGFHBqVGYKlGYJB8wIphSsi9BXjDZoqik53ETAUvY1ay7Gk13A0tmuluM3JgEkGuLTgnRHFeyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 15:04:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 15:04:07 +0000
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
Subject: [PATCH v2 0/6] Buddy allocator like folio split
Date: Fri,  1 Nov 2024 11:03:51 -0400
Message-ID: <20241101150357.1752726-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:408:fd::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b583926-ea8d-40a3-316c-08dcfa866ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xSXS8XqiqRnLsFjXydiT0KDt8wIbKv5ysnSwVQn0CaUWxmxfk+kfnNKJ4hrQ?=
 =?us-ascii?Q?kA95ZlU1MDGxDs44W7bI6zTeKotUxm9j0AboDbNqOzJRvlPgn+FArb5CVP+9?=
 =?us-ascii?Q?bpWCu4nwiwa5p5Dz2+VmUNWRaJ7BxJAf6ZVpvS5gWcQvb7TZ2jBrYXHKlGSt?=
 =?us-ascii?Q?Kb73r8Aay1y6IeZqo3WyhGwGdC7tU2BktJdwE6MJEC8N3lQn6oRY79/QR4BC?=
 =?us-ascii?Q?fzXq7t/cdzhMH90CjruD3wxVTXYmHZaeY3hVYMLinIOhTBWEVH3ziTOg0Ko4?=
 =?us-ascii?Q?mO9zwLuUgSfuXdCIzonQJo2X+WOUY4a2Bo3TIfmtCs6R8OK15NxpnuxH2VZb?=
 =?us-ascii?Q?OtakE+5lq0hTVNwvCbwl8oHhEYUgYBsiMNJxxuhHbkayZxwAbbsjm/xT7QRB?=
 =?us-ascii?Q?ald+7Gr7QaENB/WjvRJwEuSRqNRxsmR/ybceLuw2JNIHdSv8ekmDhWHxay6o?=
 =?us-ascii?Q?xnATmK9qAB7FLEKadCfR5zasnGPGFUnYNAOzJ+cecU9OQPFXByf7P1G7KyoE?=
 =?us-ascii?Q?miIdYWZvKndo9d5yUjKHgd1agdvuabJQ0ur9I82iXd5jxNLcfQTjbVRj+2N0?=
 =?us-ascii?Q?qZwlZEok+XS42Mab841FnloVUQKrhVjVTZUVYYvcjfjslNUYE9D1AG7Q6JzW?=
 =?us-ascii?Q?ZnXd/V3heLERiYLp0S0hGl908asFGiRWTLuU5tIda8FJsw36+kv9jgyCiriC?=
 =?us-ascii?Q?xL2GsgB+U9Rk3MOHuUY1bBRGkI+Apv56GtPq7cvMhKspr9TxuRHTEi+qGGUf?=
 =?us-ascii?Q?DTAhal4eyfcPIC/woF50CLtO89rEOl6uH0zRlsgrQckUulr4IO3+VF8dZmG3?=
 =?us-ascii?Q?LcE5/ZP+fyN+p4eZI0x+Sv9RautA6J/kyFN2vgrqJ9/hh220wi9yPGSgWYtq?=
 =?us-ascii?Q?JqjD3P6+Ny2MdrLj52LFohNZs7CyPK0snbF5FeaqBKrA5sCLX/rnw2phfTtY?=
 =?us-ascii?Q?5RwjcK5oRptX+NHIhD8rK0FXisUAygOf6pc6YQJmE8PUDkGh8COqi2l6g3eJ?=
 =?us-ascii?Q?mvoggtWC7MLtHRJzBvbHOeQTCMJIMZ0mnYAIyQIDPh2z4Y8PjH5tZPensZbw?=
 =?us-ascii?Q?GmneEKGFfhU15+cPio8fN7BlCkHvnbOD7ccnZa4+7riGvYe08v5w20WD33ET?=
 =?us-ascii?Q?7K9skxQCApt7/msAQ8fCBnEbiON7kpXncn4CvUCS9OJKRM6oDiU5xfT5k3Jw?=
 =?us-ascii?Q?rP7Njww1WxUbqdUnVG9PxEMheXU+JRGiehbv7iPKQzDoo5dE2PCVT6NLkQPd?=
 =?us-ascii?Q?rEwGzv7OXp5DQkkmqUDTAc0BxcBN4TyO9zZlV/e7+WDP3jh6y/+gKHrpq1Or?=
 =?us-ascii?Q?WNHmntmgoCB6NCpZusH1+xod?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h8ocmyNX0hESDRuHDtj1dE5w+RPrqrLpPTKfbJWlnoI7blwX+Pwu/df7k9Jg?=
 =?us-ascii?Q?rELhwnwmOu8yiSDsipB3Yry2yhrePDEzd+x8lSvtogrQ6W6MnORINuVNGR2J?=
 =?us-ascii?Q?m1Jd9JpbsXEAa7qEOKYO0okH4fL6GWvk09hwsrHSqhuG6vgODwyPKs1oIdBT?=
 =?us-ascii?Q?X08ww/1U2B1PMQ5PDc3uprqtX003JJ9Q+SfmhMl640l535ShYQD7OF1lTyht?=
 =?us-ascii?Q?WuHPBr7WnEM7R2XbB1kSeV4x43YM2m42JGW3pK/c5Nqc6j/joYlvTU2NHXOD?=
 =?us-ascii?Q?eW9R8i3oh9pGP4TxtjqcGTA6aHOcjciZM/pQlo1tVH3IpS9e4v9xtxcqolyl?=
 =?us-ascii?Q?7hXYm6sMIGbsoCLMBhDfgYwBlF58kXf6m86pzP7Trf0GQI1jeWBJUlLEBS66?=
 =?us-ascii?Q?eiyZ/0Pv1ac5QRE1I0ADRsO3TkFC3HU8JZZmZtBglPR8ttEo2Y4HnRovgKUd?=
 =?us-ascii?Q?ml6fyyb+qdfL++p5FXT/+J1DqcWLDC14Xtw7YwlkOXfEp5HvfSXElhx+CAJQ?=
 =?us-ascii?Q?RS0SPyUlTDx4uX4DBAaP0YZ3TkLa7p4niQqOHZR5T2hwB/xieYlAkoHzWVTG?=
 =?us-ascii?Q?LwfEBFH3FRlP70zgs8WztfWyhuQmKui6NygsJBMcJO+BLJ+xSTr3fGuKqUws?=
 =?us-ascii?Q?KlAQBA8pvLPc0CnkLmfhjb9beFP/dJHljeeBUiuOpL0qWAD+mxBmqFgRFKV5?=
 =?us-ascii?Q?G2yoZxBu4JhO4LEPeGxTHXNPwplU9GAdnoO4r8Q/OjVavfF9TOBg3Ay44ONr?=
 =?us-ascii?Q?SqDGacyOewZwVi/ZDQFo5ic6X7WQ5muh+9nvnVwModydtK9yko6z/ZrkZmk1?=
 =?us-ascii?Q?bk/PVYIVUm0NPiibd5AFwtRufPSXGzhwdiqbhPCEY0TrFZgAhCwd2dcDEDoT?=
 =?us-ascii?Q?qNs8eKhAiLQw4PAw62edu9x8d3hxVQOehtLYXpBemLFd2pxsGwlrE9xA7M08?=
 =?us-ascii?Q?UXciYMmq0uQPf8CfPzlY/Q5UtXmz1rV/wBpBcje52YNslqQ1wfv+opsYVJLI?=
 =?us-ascii?Q?Iwpe7ls/EqvPtJWwiBsmGVcclPlBLp5Avi2umJhAQBdPB86tTE2rg5OvRpC4?=
 =?us-ascii?Q?iGO+5zI5XUm6G8gEuMfzzoCiNdeUxpjLxBkr8tpMF7evH+zE89ntqW/UxuAC?=
 =?us-ascii?Q?WHN3JXiBi+7ItEySeeJCszPuSSmZmL7vuUEqVPBv3QJkdaDn0YyKHwqr+V2i?=
 =?us-ascii?Q?uBMVmP17iR/ulzsXBpFhPCJtkLSieNrGFv9E12Xvx9zZ0Ywfe/ruqFKPt0M3?=
 =?us-ascii?Q?pAdEvQUehszLItIQisclpkDMa+vyz4LAQXCQb/t8X3LnO9Se0de8UlI87jUX?=
 =?us-ascii?Q?jZYOTERfLDjidOmVDKftz2yv0WTC0FfPcgHydu8/RWT4chRV1feftJgougid?=
 =?us-ascii?Q?fOfji1AtCcacZqMfz61MzYZwqannjLgj+J/Ikm3OoSQmGRsUU06HTj2le9vN?=
 =?us-ascii?Q?BiXKAcZa2J26rnHTjW+mfKO0SI0anIeEjX7h2kqAxe+N3yDPugw6aO6cBYSp?=
 =?us-ascii?Q?5cc1DIbn/N1Tlx2JxRGTA1HHRdaOALOtLnnqP25RJc9GnPxiJB9mXIjjejgH?=
 =?us-ascii?Q?mP0utjF+Dl5j2WdPTbc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b583926-ea8d-40a3-316c-08dcfa866ea9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:04:07.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xI6QOGkDu6heotDdnCvbjiE5Ph73DXYKkf9xbngsAO5RwM08oA8Ra6zPqlff40kN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

Hi all

This patchset adds a new buddy allocator like large folio split to the total
number of resulting folios, the amount of memory needed for multi-index xarray
split, and keep more large folios after a split. It is on top of
mm-everything-2024-11-01-04-30.


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
From V1[2]:
1. Split the original patch 1 into multiple ones for easy review (per
   Kirill).
2. Added xas_destroy() to avoid memory leak.
3. Fixed nr_dropped not used error (per kernel test robot).
4. Added proper error handling when xas_nomem() fails to allocate memory
   for xas_split() during buddy allocator like split.

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


Patch Overview
===
1. Patch 1 added __folio_split_without_mapping() and
   __split_folio_to_order() to prepare for moving to new backend split
   code.

2. Patch 2 replaced __split_huge_page() with
   __folio_split_without_mapping() in split_huge_page_to_list_to_order().

3. Patch 3 added new folio_split().

4. Patch 4 removed __split_huge_page() and __split_huge_page_tail().

5. Patch 5 added a new in_folio_offset to split_huge_page debugfs for
   folio_split() test.

6. Patch 6 used folio_split() for truncate operation.



Any comments and/or suggestions are welcome. Thanks.

[1] https://lore.kernel.org/linux-mm/20241008223748.555845-1-ziy@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20241028180932.1319265-1-ziy@nvidia.com/

Zi Yan (6):
  mm/huge_memory: add two new (yet used) functions for folio_split()
  mm/huge_memory: move folio split common code to __folio_split()
  mm/huge_memory: add buddy allocator like folio_split()
  mm/huge_memory: remove the old, unused __split_huge_page()
  mm/huge_memory: add folio_split() to debugfs testing interface.
  mm/truncate: use folio_split() for truncate operation.

 include/linux/huge_mm.h |  12 +
 mm/huge_memory.c        | 664 +++++++++++++++++++++++++---------------
 mm/truncate.c           |   5 +-
 3 files changed, 435 insertions(+), 246 deletions(-)

-- 
2.45.2


