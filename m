Return-Path: <linux-kernel+bounces-239850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6100B92660F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B581F21569
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1533183099;
	Wed,  3 Jul 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YEmfNO12"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE1181CF0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023763; cv=fail; b=ZJ3QjuIHEvyiHoBNXyaAyWocDOvXIR3zK9yiNyVMYpwI0DRNydIFWtqbYvGTSPk7nXHaM0dTSNkBHcXzbd+77jk4GVL+XKGd8RBG0gEDvrPjMWDeI5VmtarCAr8rQ4A/sq1LBM0EprgLc1rAG1HqjOqKmbOc8F/pnDkXMk2IYlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023763; c=relaxed/simple;
	bh=jqbGHpBEfQ1rEG2GGlP+FTqs17IWtVTEW3dKUTErH70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EeeHAOiEJIXcyxy8frhmLLXZb+TmlEL7M0/B8GBE+Ei+M3IhLya5y8dBzo5z3S7FAm2bo6KkXEH1Z+EK0xxdt8xLTz5pj/Scb+l4x/UPNF6UuT0GI9+i/n6oaAXss450QoxAeNNfgFkn8LsKShGWUS0ajsGg9zUGEc7dNESAr54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YEmfNO12; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcLcwZQ4iKfWD17U1xUgnwkPl7hntYjmqKQnDAiCCtrcs9RxMWmeoKr8mf6xVYcPSsRxby3S63LMr/GMn3bTrgzn7NpCG5kgGm6FWdlOyyS6Obes+X6IBgwAwflESNtr83b2E0HRqERRqy5JNzdqeIk+ZpzQWIBBdiaQHLM/dgMSLHXDK55m8qaP1Sp0qDVFVJ4KtvEYfya+DU2BQmS4O1+kDzNDR4LJprcVK0RLgi6rvNUfl1pv3DLqMPd0yMgqpYkD6t2VGUI4BggMchK6CZQ+rnSdFnX4ArkNwHaE2QG+CLOFi05GPmaWVOr0nMXlMZo2XoiSZyzG6AUdrurZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX6O6nCt9P6sGYPjwjEgHsDcEYs1a2c2sOt5DqN2Ypk=;
 b=lIvabCLhIbE+1B8B3kcosdvESNmAXvGLlxYrs8yQexkR1tM+5NIWXAthQtvwtCuxdK/8kN4ge9GVibzMATBfGW/R4S/V1pL3ItC/BFfQLFIO9X9h6mJqYVs+zsnpPx6le8GQB99mXVei+hnadhROHtU1Q56wBd/31DAHgjKth1/+0D2MOB7HZdcEhyihi7RmWO/XxdqnuUtOtSqHKSsPJtnsabYs2s24XPY+ENkJb9O3DhskFRWzznvdBtoU2jFQnXmuzjzcVmtRiOG2skGWhV3DxVrtNhVg/Y+m6QhuF0VxksI8IuBXDfDjgW1l11gOdRRv+mUfDpkZxtv1sypDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX6O6nCt9P6sGYPjwjEgHsDcEYs1a2c2sOt5DqN2Ypk=;
 b=YEmfNO12pS05iqdujCUtwqnwYbCWc3+P52LOZ7G7Bcg9H8WYWprkP5i2MEzZLbHfxYgJMRT3OEtYMlSUCNNLUACNHc+kBVbN308yxIiXpuZ/VHNTYpEouFFmlXCF0FG/eqTaxdrp1Aw2rRjFS175/SpFbc1khT5ca/9JGz21Fi7CTjVxZNlJOcPRArPcsQoMGaFa6QiCJx9apqplMGZ6WUvOeFBWaISwCjVRx7SnYz82Py5nRtSU2Ab05pYxM7XnK71wAD1+JuGHGKH1M7BNVnh9oYi6wGTEXh5EfSp98IA4EeQnnjCKe714VAbSZWUE0tYCt8dltTiKEfVW0OhxhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 16:22:36 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 16:22:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>,
 Yang Shi <shy828301@gmail.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
Date: Wed, 03 Jul 2024 12:22:34 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <36AAFFE2-2506-449A-943E-B7DF13CFA25A@nvidia.com>
In-Reply-To: <bcc75496-3222-4093-a8d5-f8d529e0771b@redhat.com>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
 <B6E5E92E-DCA0-47E8-9217-DCE843BAC122@nvidia.com>
 <bcc75496-3222-4093-a8d5-f8d529e0771b@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DDA456D2-3C9F-4A58-915C-478A93673919_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR22CA0020.namprd22.prod.outlook.com
 (2603:10b6:208:238::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc991f8-23b2-487c-5471-08dc9b7c59bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cn/bCUzEqJ3bUTWnN3icYkiFSMqWqjbWom6OMBVhpCCHD9CMhlPzIhmTr510?=
 =?us-ascii?Q?hvnGHpGWbJunpBByV/TMkJJre4RpEQfz4TuAV6QkuoBBQWuPDQuCtnss703m?=
 =?us-ascii?Q?voUGMoxOocpZlv7H3T5Kvd0cTWytlGLz9nr+Mk+MKfZk+SsimqIUVjUIZe7X?=
 =?us-ascii?Q?l06WMgzt/T0CnsVy+3FkubgzuPn0643Qok3pFXTsTm+lgo7dH35eymgWiNux?=
 =?us-ascii?Q?zFs1QqgpNdIOFa9NP3QghxwgXiIIBMdQTJWnc+J/e+c8mZ/YKfy1pOC4ngEF?=
 =?us-ascii?Q?yQAsStIt0vd4CAdOM5A0cQKlypKKkijYlhQQwz3xWnyHnm99JKYfQ4aYP2AE?=
 =?us-ascii?Q?es6vZzrOSpzGKiFheYvHM9jOXrOd9M3NsgzHiaKD6LK3RUu2rF2YezCDgzaV?=
 =?us-ascii?Q?6p59nUzo7S+6BaI9dsK9TchttP6yYDYROaHIPd5f/rGZuRtzrgFxQ6xGtAu9?=
 =?us-ascii?Q?rFjIsvUJLaw75jSGT3MLj9943z0+1ul7AKPARx+ory/A32Q6cVtaJDruWQz9?=
 =?us-ascii?Q?rwYhpVO4Q7RLwJ+m7CYUQQRf8mUAsGRvwlAIt/Q82BJEKPqoU+h5vkFIAUTM?=
 =?us-ascii?Q?2btWP9IJkpNJU7KZqXR03XX6MyIue/m/RgO1Rzjd9middYzCdQF2J6QuX0u4?=
 =?us-ascii?Q?iX3RGoz56+izIekwxSDMxpkC7wRMbnDYv5L3E5VGrucUmSNGWjTkw5Z6TapI?=
 =?us-ascii?Q?pQmQMj0rij41GiJqU3PZKL56gskH4gaHHsISVqHtD10q0KSUo77BWccjXz7z?=
 =?us-ascii?Q?dfv08e5r8YVj9BW+SMdLXhr5QjuKcm/LAGgt+wKllIPl02zK/efbvlwx7oBE?=
 =?us-ascii?Q?7QsHIh8B1ExMLu6K2CIQiRrApm8GxhXVpx5SciZnYHHN9AXoT3t+UvErV4E0?=
 =?us-ascii?Q?04g38pMeLPdP9sCcAcf+WhOlQ1u5Ecnz6w1MfTAajA9LX9/PLna0aVQw3ZW+?=
 =?us-ascii?Q?lXIRE7O4pdp5FT5SsAKbHfOsP0a2SiWlaENPaxngDbB3bMO1KjJiFS8rPNWj?=
 =?us-ascii?Q?bW6LSKEW9kc3LWZ6XnZVhknEXyQcnfP6OiLadfI9hnpjLOZpzytgm1yofX9I?=
 =?us-ascii?Q?PtHw0niqbo+ls7T8zYr2oF0vCZ4X2XkB0FasAdM/+znBv6ZtzIkTkGWC1kDB?=
 =?us-ascii?Q?a1kfunhUDkgfceWH8XVrg7hzXVjAH7ww34TuzqYBlhiT7NPBTPaEMQ7vaMpK?=
 =?us-ascii?Q?GcCXsjGE4xxGoZyw2B/g9f5IYNu4gjc9vpoZv29b8eQ2PTI47la7V2SN7E1v?=
 =?us-ascii?Q?ffH+Rj6k9lx7hWwNYQ/3os9/dqCuz+kKez/1QBhxrJg8A2rABwkahIkt2zg/?=
 =?us-ascii?Q?bCyXX/zBOyc6XuzOrXgGW/ErJdvXa5pQRtqTGx/B7sc/7ifM5KKwh0CAvmSo?=
 =?us-ascii?Q?SWR/0GM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hlk4KPFpdmpEnnb3AG/gk/Mg/6hNHSIkjeWxg8zokTK/ssFFRQn3QLqAxIxu?=
 =?us-ascii?Q?fn/mTOQDXTcyqlYrG/SWtmukZ2yJAxhUVGvCEZJLkK/CDdvJTsEpIf6GGtX9?=
 =?us-ascii?Q?de5d/f4VraQ/VVs+21o4nc5G/Cbm5Ix6beuBp3mH91r6XFHsxyrGLPcCKhwd?=
 =?us-ascii?Q?0S/o0siZ9Nnk9Tkd+Jp+2VqmeCvIvS4jljqQAJXxHlyesAPpVXkFEx7+VWkR?=
 =?us-ascii?Q?LgFzP2XgpmgdGFwYQKB/AfHUlTUjeZU5PJGX9K3wq5IghWi45CzC5U0v/pk2?=
 =?us-ascii?Q?+kCM4OhVntVGpGLNrGOP7cxipRWNRXd/qHQY/Vqzqo8YIbQxGWpwgyfzDoEm?=
 =?us-ascii?Q?eYXuIt/GIqCA3pScTZddvre7/bo9/emRlcR5u3JAbQ6aVA/bZG1pT8UDDGP3?=
 =?us-ascii?Q?TfdBQX33zRAxNRHS8OCmp1iJnO4MQ4sFwpfdegtGTwkKD6hXHxdN5ekOuR0y?=
 =?us-ascii?Q?9XcdPn2DAaOX40WpX5Dvb8Q3FmSVNJ3wClKnL9T3uCtDLLXH5Z3wvciJkxoS?=
 =?us-ascii?Q?VhU8C2qrW0HNwMPLMDPvdsM1mXbtxk0XK5Eawidf5lNtjkCN0N5ijXiT959X?=
 =?us-ascii?Q?dBCclsdtLVXLesMIZyVxAuazpdDUxbj3bd6iYoVFLpq0g1+jNvRbnrmFpqe5?=
 =?us-ascii?Q?7k2dOwOhKQlLqxze0sHa2KawITohbzJiKlEofH2sJwwOPIieiHd+wP+2vQnM?=
 =?us-ascii?Q?EBP9fuwjaorA3m89iP5qGj3dKOKp+5odhvZ+dbc88RBmj66vokhtfBhiA0rk?=
 =?us-ascii?Q?GQc9BDmgflFOPdgvkbIerckUxRYxN02VtDrw+tdFtwh4b8W450XTY6K8odUJ?=
 =?us-ascii?Q?mfnkyqbPQZ/YoJ087UwlfHD6iBDa2JdkIQR6IrgOaoA5U4aDUp2hwlbTxEbp?=
 =?us-ascii?Q?RSv7mzuIGlGDgGaToMdMc5A2K6ew2PX9XkucSnLWzXyRobIBNPhedxEURjnZ?=
 =?us-ascii?Q?6DC1OToVO7vBbk0AQGLzKl8bh92Vlj9INAPsM3fR6mVOqBz6PCtQEg9oTFVp?=
 =?us-ascii?Q?eeG2IA/guk6evxbUCihIxUXdjSc1raVjWyzni+pTyCXIUXotjbLsBm6PA60q?=
 =?us-ascii?Q?3payuSVtxaOecocDmh3qb2vQtNw/VONX2vr9fO65hQEb4fiNm/LJPDV3I2XS?=
 =?us-ascii?Q?gLm96T1PNokypP9tPNk780jAakomWh1RQjZuUegdEHc3ZMtb8bFkEaOTfsaN?=
 =?us-ascii?Q?hF9tjKNWJILdbMqiQzUCCeIF2Emo8oFmAZ1LbKT1Lsxbi4lYqEIscUdmKM0v?=
 =?us-ascii?Q?jLtsSyf0Sox8qEYMlEZNdcvNTk2TxFUN/itcGmLgCRrwA6rULx6OwGuvD5bX?=
 =?us-ascii?Q?P2QU7Dxgsryl2ePtn/HgLf3Asg+2AQFBxvJKNaa/Wt+d8fQz9kXtj14ifKwc?=
 =?us-ascii?Q?rCBHGEld6HOTgMxN2lgvXJYiJ9YcpClH1YQPSTyAX0wLfDN9qWlpxkqGbigI?=
 =?us-ascii?Q?g6bYbzgj1cURv0pO8+4ld2KzjW4zdktameGGPIRx1bd3NW9r4kvDv8Bynryz?=
 =?us-ascii?Q?LqYdM96gH9VlxRijQo8swM0jnG+WQfzG4FcjBxbqRQ0plgSd3TfxgKBugfHF?=
 =?us-ascii?Q?7k6SQt/Z3QlN7WikQ9k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc991f8-23b2-487c-5471-08dc9b7c59bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:22:36.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGeQOZa0V6tRiE44hGvE+pMCbkX4dJJ6qyPb4O9DYCXmDiXdJE8W7K83RG9tshKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247

--=_MailMate_DDA456D2-3C9F-4A58-915C-478A93673919_=
Content-Type: text/plain

On 3 Jul 2024, at 12:21, David Hildenbrand wrote:

> On 03.07.24 16:30, Zi Yan wrote:
>> On 2 Jul 2024, at 3:40, Hugh Dickins wrote:
>>
>>> Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
>>> flags when freeing, yet the flags shown are not bad: PG_locked had been
>>> set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) == 0)s from
>>> deferred_split_scan()'s folio_put(), and a variety of other BUG and WARN
>>> symptoms implying double free by deferred split and large folio migration.
>>>
>>> 6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when large
>>> folio migration") was right to fix the memcg-dependent locking broken in
>>> 85ce2c517ade ("memcontrol: only transfer the memcg data for migration"),
>>> but missed a subtlety of deferred_split_scan(): it moves folios to its own
>>> local list to work on them without split_queue_lock, during which time
>>> folio->_deferred_list is not empty, but even the "right" lock does nothing
>>> to secure the folio and the list it is on.
>>>
>>> Fortunately, deferred_split_scan() is careful to use folio_try_get(): so
>>> folio_migrate_mapping() can avoid the race by folio_undo_large_rmappable()
>>> while the old folio's reference count is temporarily frozen to 0 - adding
>>> such a freeze in the !mapping case too (originally, folio lock and
>>> unmapping and no swap cache left an anon folio unreachable, so no freezing
>>> was needed there: but the deferred split queue offers a way to reach it).
>>>
>>> Fixes: 9bcef5973e31 ("mm: memcg: fix split queue list crash when large folio migration")
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>> This patch against 6.10-rc6: Kefeng has commits in the mm-tree which
>>> which will need adjustment to go over this, but we can both check the
>>> result.  I have wondered whether just reverting 85ce2c517ade and its
>>> subsequent fixups would be better: but that would be a bigger job,
>>> and probably not the right choice.
>>>
>>>   mm/memcontrol.c | 11 -----------
>>>   mm/migrate.c    | 13 +++++++++++++
>>>   2 files changed, 13 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 71fe2a95b8bd..8f2f1bb18c9c 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -7823,17 +7823,6 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
>>>
>>>   	/* Transfer the charge and the css ref */
>>>   	commit_charge(new, memcg);
>>> -	/*
>>> -	 * If the old folio is a large folio and is in the split queue, it needs
>>> -	 * to be removed from the split queue now, in case getting an incorrect
>>> -	 * split queue in destroy_large_folio() after the memcg of the old folio
>>> -	 * is cleared.
>>> -	 *
>>> -	 * In addition, the old folio is about to be freed after migration, so
>>> -	 * removing from the split queue a bit earlier seems reasonable.
>>> -	 */
>>> -	if (folio_test_large(old) && folio_test_large_rmappable(old))
>>> -		folio_undo_large_rmappable(old);
>>>   	old->memcg_data = 0;
>>>   }
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 20cb9f5f7446..a8c6f466e33a 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -415,6 +415,15 @@ int folio_migrate_mapping(struct address_space *mapping,
>>>   		if (folio_ref_count(folio) != expected_count)
>>>   			return -EAGAIN;
>>>
>>> +		/* Take off deferred split queue while frozen and memcg set */
>>> +		if (folio_test_large(folio) &&
>>> +		    folio_test_large_rmappable(folio)) {
>>> +			if (!folio_ref_freeze(folio, expected_count))
>>> +				return -EAGAIN;
>>> +			folio_undo_large_rmappable(folio);
>>> +			folio_ref_unfreeze(folio, expected_count);
>>> +		}
>>> +
>>
>> I wonder if the patch below would make the code look better by using
>> the same freeze/unfreeze pattern like file-backed path. After
>> reading the emails between you and Baolin and checking the code,
>> I think the patch looks good to me. Feel free to add
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>
>> BTW, this subtlety is very error prone, as Matthew, Ryan, and I all
>> encountered errors because of this[1][2]. Matthew has a good summary
>> of the subtlety:
>>
>> "the (undocumented) logic in deferred_split_scan() that a folio
>> with a positive refcount will not be removed from the list."
>>
>> [1] https://lore.kernel.org/linux-mm/Ze9EFdFLXQEUVtKl@casper.infradead.org/
>> [2] https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index a8c6f466e33a..afcc0653dcb7 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -412,17 +412,15 @@ int folio_migrate_mapping(struct address_space *mapping,
>>
>>          if (!mapping) {
>>                  /* Anonymous page without mapping */
>> -               if (folio_ref_count(folio) != expected_count)
>> +               if (!folio_ref_freeze(folio, expected_count))
>>                          return -EAGAIN;
>>
>>                  /* Take off deferred split queue while frozen and memcg set */
>>                  if (folio_test_large(folio) &&
>> -                   folio_test_large_rmappable(folio)) {
>> -                       if (!folio_ref_freeze(folio, expected_count))
>> -                               return -EAGAIN;
>> +                   folio_test_large_rmappable(folio))
>>                          folio_undo_large_rmappable(folio);
>> -                       folio_ref_unfreeze(folio, expected_count);
>> -               }
>> +
>> +               folio_ref_unfreeze(folio, expected_count);
>>
>
> The downside is freezing order-0, where we don't need to freeze, right?

Right. I missed that part. Forget about my change above. Thanks.


--
Best Regards,
Yan, Zi

--=_MailMate_DDA456D2-3C9F-4A58-915C-478A93673919_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaFesoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUNqYP/izm+o5lFCCDQCb1/xHiNr+ZS/v3dXIyL8jN
oUOLOoz/nyctpdPwW5lPRHvVaV9D8vmNPgEZ7r/thQmEmae82Gbuz8SQnTEq+OJS
Txz6iBC60Zefjx4Ok6nVW344DZp6PjPV5e0G+/8x2VvlSI+PZos+zzXZPoW/3kxZ
RP70dOUhtH6xve1jGlkPJTkBB1mz4ko0vRKQrDJxEVjLTUT0h2z1uabEikoEVuOX
o/99YYl4sb2sgpVffW75Bya9SMQ2KzoTVXoDAzfkHbvXZWVRRNhFrIPUgkdIx77z
M97ebHBrNilrIhcL18IIzXW8irlwOwuHiqLoLycLp2ljq/hGXTAPBg5q3DVWGxkS
9Q6xOcV58t/iZf+0PyWy7fqtf70u5gNVtfKYf0RoSoHY89hg1oAhn4C1stfSSNCt
tbOBD+bJ6vDwDYwKImOGvFKaCJ063MjKsGiUgXh2xle3dNtz/T9Y/T+Tbpl96uCd
7yQpJ5FELLI+0ekBjc2y3bq4Sc7cUKBavIlSo6Zx8iWXotcXgL27IgzBaZL1k/Ih
RFl17tPaqtXI4dMYylV9QM3aRfne2uKryig5semgpARI7UX2O2EktnFLjuVCKxbr
B+/rtGBoFXfGsAOLn9n33/dg7WCgcnvZaU7IuwgwBXBXfGjiMG/Rwss06yK7B0MV
Mokc1hFV
=lFAL
-----END PGP SIGNATURE-----

--=_MailMate_DDA456D2-3C9F-4A58-915C-478A93673919_=--

