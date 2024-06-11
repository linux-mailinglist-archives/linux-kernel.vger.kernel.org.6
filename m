Return-Path: <linux-kernel+bounces-210070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBCE903EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1C82897FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CBF17D899;
	Tue, 11 Jun 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IjkI2Vs5"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27A17334F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116695; cv=fail; b=DdXPkXRDFRug5TOzF0MWpisFJHE3YmWoGhYjqIm5eLhKRxpyZ19zagks3NNyax1G8Khcz2UCzCYVs7cTfwRGIb30lEUYFEjahJj3R7InByTV9QXD7WDDFe7oXsGiv0xieTqROKg3o+58gqNukXGRquCEyuSPHenh62Xq/+Yn7ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116695; c=relaxed/simple;
	bh=UIrIj662nhcGL4waFdk/hrYTcGyjV7U5+O4Pf2ns5pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rxs5ju/FRnStU+5WMSyNMjf4d55Ch6D0y9psxJkgSyPWEaPhcM1w9TPfbk+h/mLhbXFB/sdT/686ld4CTCGREul8YHRuxaJlrXkSr5VDHf8FUKRIjgQo1oUiLVa0DmzS0Ydc8+aE11h6Vvk6iyXWkZfggYelLeWbprIbd8JWe/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IjkI2Vs5; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTC+r1Tny0PaX/JgPJ9KvwqtKQKHMvLYMOv9ctRwQBhKrOPNnErC+7hDLmKFZV9bov0LkRu2SZ9u242LJNXbG4C+miBB5/D0JGnZyoem7mn8kRQeqTNI7njJXjERMBw/D/sGIQNkI4g0Ji0621IV9MY+g8z6w/339hhfMKz68AmHUrGqBDuQQR3uaOYp6gMrFlH1crZsAh4kDnGeTpZ01uapN6bNFo4ySD0Z0KO2GI+7XlM5zY898Q2smhzskNMw8AqV7jtZ69j/2X36E1eA6t3pTJIms1DEDMmSpqUwls+hPQaO3Os4nijLmpSvbeOrkx+1U0b4OH+QZfmfOJcFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljOb2QiVCyHacu63hWli3jWyjEwWxzLuSJ7hzKRaAYc=;
 b=Li+j2HBJRIUqJAsK7RdYWVixxbsMfV4hvpCxxg+PLmekuy3f0CRbrhxKGZ/AVl45rfw2rJvS1ZvAnDsZ5a9RT23GRZxtMnFzvKRGmcCvOrceORVoXBaDqcQwVG1J6YX/cgWmptMIrSpUtS0vQDpDG73C+MMmch2i8xqi3jNJCQUFNIdD/F8eUfGdFeYWuVvnLsYOZtJKJeeoJCCMBOl3ub2a8pVo6SPFhPtXuriCE5UX+mcF1UipfvUMUrb5OKqdJpRp+m96Zkg2JbvIjTcddZUxUKsX/vschtb+Q4IY8QMi/EkUPsxDz8CDf5S0VdmF4LdltrrfoPKrayMsy/DaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljOb2QiVCyHacu63hWli3jWyjEwWxzLuSJ7hzKRaAYc=;
 b=IjkI2Vs5k52pxKT5R/hrvhVhalJs+P7EoFpR6uj1UIUBFdZ+9HaDXFLEUofydAZSCGYpS2a+4tgbDnSM03UYvdzqCo5zEnH0HAAV3YCuzphnStb5XKFhGm/8/4KOZzckYE79I9rk19AVYc2YGjixrUuxzcVuu1wI5b0USgyzHTVz8VQEOSnkqngc2zYFywW0Ke7EHBZq0jCT//6fEbpAilPVGOXAx3ClKNwO0XEicvIwKSz3Ac5wNf8YkYwi6UMuMKJ1/pbIYe7Jfc8XjktiOFwT8pjNaKGG7ELoM4Y+BKO5f9uVjiKyaR10ceCPaGmUmKDGHPzP9AI4UjtdUMjmmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Tue, 11 Jun 2024 14:38:09 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:38:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] mm: memory: extend finish_fault() to support large
 folio
Date: Tue, 11 Jun 2024 10:38:06 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <DF94C669-963F-4BA7-81A1-B25031D2365A@nvidia.com>
In-Reply-To: <3a190892355989d42f59cf9f2f98b94694b0d24d.1718090413.git.baolin.wang@linux.alibaba.com>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <3a190892355989d42f59cf9f2f98b94694b0d24d.1718090413.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5D0B588D-92B6-4D60-92FB-B03AC35FAE69_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0036.prod.exchangelabs.com (2603:10b6:208:10c::49)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: c4491e0b-8cc9-4de5-4b36-08dc8a241d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LPs7Vbb8hdlfgTJivnmmwSWpinXcMd9Hd+xI1s54Z6qAsrjfRVYGQBS9MNtV?=
 =?us-ascii?Q?QKhZ4ruS0vBTsYD/+cGEWQX9E/pts7EWFYC64zGafeLtXrM+y4J1aGnrt7Wh?=
 =?us-ascii?Q?2auT6mUNa5hfKpXfUjvr2vM2sexrnbduMHE/HJjcOLkhOZeAuufyG0tQd2rI?=
 =?us-ascii?Q?r9+X9TMtYkK+oFqWhaO6Tx7aGxNYdPbwZSmERK/u4Fxqlpq1AzEHit1w3GIe?=
 =?us-ascii?Q?U5vuEMIzugecJyeaAY8zqitdq0Oyk+41Vp04WPcPipxyY44wWnkB4Q9eajn+?=
 =?us-ascii?Q?tdyAmr2hnRUN4ZHkvWm8nuQOJuMwBFHub+GYqJ0SGqwbE2KgQf+SIv+9/pD3?=
 =?us-ascii?Q?fWW9trKqtlpJXHZeQ3G/irFbjphwtFFmnyZrJ6oacMSm/i92wdi/oLJ2sUdd?=
 =?us-ascii?Q?ZsTwuJil8CVtlRWQj2iwHl+SIANYh50RrwpaMIiyZ1sMyWLUbhhN0R1CJLVS?=
 =?us-ascii?Q?mywIMxCVTELIIDWCwo/YDSgOXkbOUwU9TR1xx5b9y76FMwjNIGiMTRE6c9Gm?=
 =?us-ascii?Q?vSOJYQAEaxl2o6Ev0zrVUFxxdkcLG4TY1eYpf/BDuWtx8KiOeZVOdvnFkJOA?=
 =?us-ascii?Q?UxDyB+18YegUZLNHjrzMI9ohiYDzR+FWGIEljO8X16SA4HHuiPqzShv0lJ5v?=
 =?us-ascii?Q?VGuIuSbM0MSD2PHznqfT4mPFqZfiwrCt1zMvGzZpUSyMyPhl40vbuS5/Tstx?=
 =?us-ascii?Q?deAmJ5rJFci1ML104bK7qGW96ZvI6ODIpieyo7G3B6A82Pt/nZZxJwm87nVc?=
 =?us-ascii?Q?2WRsAPEmuRq4YHc2WgI5ieTkLF3DhK3rx8XRf7usrqAyxxWU1roysD++jlh3?=
 =?us-ascii?Q?Q4t3HyI5Clf6VLcSkSRPz34/MibOBCW7CCG1NG8vdR3fcDYalH/7dNKVw6/F?=
 =?us-ascii?Q?X2Dr47R6jalHLTkoMOyNjbAlRIy5bU4Wca/JqrvnT5dPfFFly05Y/Th9bbUA?=
 =?us-ascii?Q?sc10gMqHILIwiJMQPaxDX215G9CXlfDRgigkRoClusqblo5beu+6F+SP4Q53?=
 =?us-ascii?Q?gZX+p5AXxVOnO60NPDzK7piDUNqvJSq5xrgEdw6pF6XMtNMFw7YlLvuVmm0N?=
 =?us-ascii?Q?1gqW3P6H4Om6PVkrsve2rv2Z4uq2o0JyCy2RxEJMfW0VOG8Ai5gSEQh2Ypf5?=
 =?us-ascii?Q?71/f4P8sVF3vG9mwJd09LCvf55G9mST3bHz/DYds5UzWCoyfU9D5p2a5IYNT?=
 =?us-ascii?Q?uwg62TeRQy+wj9D0ZWR3vS2l83uILEzMZ/da+I1J53QuLMyO04vRDh1MX7A+?=
 =?us-ascii?Q?r/0tbllPPeyWIg8PG3k5dAgNCoz4NBp3ABu3She/WPS7wSXJR+0fArMW9bAx?=
 =?us-ascii?Q?GMmvzUWIqdkg3XrGallUzOcO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S2t5w3MpvZWScS7iYdK+JGfCmNTwjwyPAm5CMEaAdlitWgmYUP3aS8j7jfAu?=
 =?us-ascii?Q?6EwMP6i+WXGRV50z2bItZefW60lzUhQEKhT7HLTf+hSGfTL/FZ1bxiL+7rGH?=
 =?us-ascii?Q?2TFA5Kt3DiRYuU4McFVvZo+4IpRAjSnVF9qZjYLnr6VtUk+prlHlRqK0EuW4?=
 =?us-ascii?Q?twgTkspX6p3ANwy0z6njber4o3BicEkPjKnD4I+EfmsE/P9yyZQF9uXsLKef?=
 =?us-ascii?Q?X0AGqQfSJM9ghpbgrhQSM7N+JhXASPkaXEs5srDhuPnT3m1LCwdLVIuilk/h?=
 =?us-ascii?Q?prY2KF0CKsczEM83eEJsy2F7GtcmdHlQJHT6X2gsJIxS2j4qkB8fKuFiNiJe?=
 =?us-ascii?Q?CZG/iyU5373HlfujQNFwbRsgJ6NL9DZa0YhflvjgAUVVCv9zJH1n0VuNl1Km?=
 =?us-ascii?Q?RsArbeaQ8ilu9vNH+6WN8vB8MLTNKR1L+wpZ+ack7ss14d6p2qenUW9kDe24?=
 =?us-ascii?Q?YPlc2elV9+FWOK+UtDR1DbQpmyB23bYt1BDOwhGVCVBkxW+wmmrKnPDunXBA?=
 =?us-ascii?Q?zaEwK7oFCJsqsgBQRYNKuPvF82/mbs5+gm++Avz3DNFmuaim1I3yQwrNkFyO?=
 =?us-ascii?Q?wW86VJgTlrRtlbDHkv2T7F9TEiyZaNBCz0HJrxf0LVt1poJLYvYZxcPa+OJT?=
 =?us-ascii?Q?RCYe1Hypsb+HuTw164r3PET17NNu27Z0tixHMuhyVcUkCWKidvcdqLgL14Sw?=
 =?us-ascii?Q?uBJnzWpQrqR1W56ZYhiO6toeUUrE9JhRUuCemQ6bb7W+ux7k5Xc5pfr6wydA?=
 =?us-ascii?Q?xbtagwKkQ67h8h2VSEXJ0nW3sNZG9ptEOePKmODzc7+qsqa19FiIQgqCrylF?=
 =?us-ascii?Q?oMJfmZOwtUqqBswx1KVlAbG3BzeWqe00sEf2w7QN1XN+o+kDAHeKbD1e5Xe5?=
 =?us-ascii?Q?VjyfhLkF/8IcbdJpu+IZDkxQ+2zIwi0rkQNotMt/mg7Qvo/cLwGlxfWd/pV/?=
 =?us-ascii?Q?Maj+bKoOvSDaYA0S/4nGpE+3J+K+w6+loovlxSErn36kx3ltDzNY/MLMfP80?=
 =?us-ascii?Q?/aS3CsWooNQJ5cuSMUTN7S1KOTkgEMsDHd8gt0fYgYBPLmjdWejh1CD5CPrF?=
 =?us-ascii?Q?XdVdbCJc3fW0LV4lsDkT/hoeQq5O9/vv27YKMrnvwQsciW3afQRtHkEgFRp6?=
 =?us-ascii?Q?EU7rG0UqA8WKnwhCP/tzqheva+XWCwNZ2NOeet363JjTyDp1XtrOMpl86xGV?=
 =?us-ascii?Q?WRdDIZLlTiGqnQQHdenDToibrwZFB+kN9BScShAZcKHsdBNvf4RXTHS04h7S?=
 =?us-ascii?Q?K0FwMynhHexAtM5qJzyUpOyJBx+4mnfD3cAehQyAupwJlihmtC4+FdtOZI/W?=
 =?us-ascii?Q?ZhO88H3YX6HZZoOTwceQFh04xVZ1dc49+kKWRqzh0qQVlZ1bRo8Tkk0xDyvg?=
 =?us-ascii?Q?kf5C6tEgd1m41wW8fYoey7inZHsm5KAj2UJRzii4GJ1E92+tSUf+D839Ve+K?=
 =?us-ascii?Q?57MjJlahrAt3eVsV6VNV8dqxOI3UrvBm81F/7GgyNyQUYPUfpu3TzSeEh+W7?=
 =?us-ascii?Q?Z9ZhtpmgHG5aK5QtU5xHi5K1usrUZ1FBNgm4yxu5VJuFkEvirAtOddxahPy3?=
 =?us-ascii?Q?WtzAuwXdKaSXprtmBZ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4491e0b-8cc9-4de5-4b36-08dc8a241d01
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 14:38:09.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llc8P1FX/WeQqlyTGj9Ymd4L2/FMyz1wvEIPwlFTDzIIPLt9keUbXckMHodD/7t5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058

--=_MailMate_5D0B588D-92B6-4D60-92FB-B03AC35FAE69_=
Content-Type: text/plain

On 11 Jun 2024, at 6:11, Baolin Wang wrote:

> Add large folio mapping establishment support for finish_fault() as a
> preparation, to support multi-size THP allocation of anonymous shmem pages
> in the following patches.
>
> Keep the same behavior (per-page fault) for non-anon shmem to avoid inflating
> the RSS unintentionally, and we can discuss what size of mapping to build
> when extending mTHP to control non-anon shmem in the future.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/memory.c | 57 +++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 10 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_5D0B588D-92B6-4D60-92FB-B03AC35FAE69_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZoYU4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUBY0P/j0UWFAUDT7rr6YC4L6lxJE/Swa8I2CZnL0d
X8XGiOGKVHLPIE9AjnsiThFaZvYeT1aJ3nmlLGESNA7aPNHMzLWcv3geBNZXbzhM
hIz8kR9dLk7JCiFoivW6exkTaODz/K3AJlpbFg4BQzMIJuQf2UM53Zn4SaSvFBn4
ljZOhw2anwcV29+Li+6CFCLwbYtMmPjzEPhn4Af2jCrcSdJyiopi0qjpLM8lnKtD
rHtntj4o1hdvggDIb+Tx3nv2ARFdlbiokZSDwW4gqfLj7tX7nxp+MTA6YOlr8BgP
4niFweX1Ow4ELWPt0p8uZ3agwXd7eYqqBVOqMar5sdz4XvmZyqBOmW+HhYZrlCvh
z/o1IVWk2NtycU5KrDbXeUb9U/D8wa2mMvDDMoAdsaLfj4Dut1EcIdlgGybwXaUa
2SBxYjFsLj2R/A0BZKpLVqHj8VAK88WXya/NZJt2Z0+OCAA0x39vjOTJ3Q7Mh53g
yhQeFQ0NqJ04pNxwJbJfRq59IsRmuhvgmzwoaT89BknPsBMlvGCX7/hcH3zgiH1e
2ssMSH8UIcx9hdppR5Qa2T6KW8NGQuUIcvz7C2OVxswtFV7zuzUvxKxFTPTa6KxD
di8WJX+9ZaRr8MWMbniq75NwTOtvA+dzwwVK7wtBlDGwbJ1OC/tvhk7KU2Tg7V7B
DSyqwM2L
=wvFq
-----END PGP SIGNATURE-----

--=_MailMate_5D0B588D-92B6-4D60-92FB-B03AC35FAE69_=--

