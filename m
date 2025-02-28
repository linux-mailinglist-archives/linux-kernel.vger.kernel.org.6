Return-Path: <linux-kernel+bounces-539041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B9DA4A017
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B58D1895BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FEC1F4C96;
	Fri, 28 Feb 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gkb2XnjB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36491F4C89
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763068; cv=fail; b=aN3PvLeKcA4z9iI8DlWI/hVdOeuxxP43+UPyRCuoqZGfG7UX79PpQv9gr/lyPr+rGPm80VtS9tP7upos+sQhQOGHI8nJa/ocJjdwxQzFp8M+um/oZ8lJGyAf0rCEH2rQsDMfJoVBYvn2ITn3njfykhMz6A/IDhiRG2kix+3bftY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763068; c=relaxed/simple;
	bh=LjAYPkS+rRBiMlyOPLjUvAAAe9TVUQ8ezzVT06z8luY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4oAmr2QaHOPL4tSPrtP02kizEhxiNNyHUREP35rqqnCxDMfx20xvSGBg0dwBIdJ0z543jxMnvl0cjNIrMOqJlzp/gKkYyNXLtPhUFQRHX8UayBe91U6T/EMwmbYhj1utwwpTtlM6YI0ZVhRcMYV+n8Mv2fB3JCJhZ5B99FVnYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gkb2XnjB; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLeAM+EQ/bzjoPM2lkoxBpE415vvzR+ldrPmIQ3dc/ZguNt5aIWAkSFUI8MIWVqsV//RV+f+UwF5wH7pgCMh18GDyc1RKACyCQL77etwaWoHda9r7aTOi+GSGUIOWK9+/z1G0sbqGfQtulsT5TxrC8mzjS9pjaEaZov9/+vSvQNaVX+Gk7pzXEBzzI7scp/IWH8lkHE3lv1ZG7h+T3aKjdBoH55OQSf4IZXK3D+NlVB4OPQuW1iHxijuiij08NhZAC6brX18l6dR4iRNZcYCYiZAf/tyI70UidwEdIEYVW9cPEmRTMHG2Q+tUoyvnu/nHnK3sfwIYDcSJOYRoZ0YAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FX7iZEic2QMuXeZKyXOWxz8yIuOz3fRqrm6AJjy2pY=;
 b=vaHlC92VSFmq5nIVtc/QiopZzGtpXAIewh/ZRl71srnT5Y45/ym35BrglckvwIBVnwXahwarwtdx93cQ0vg53DmgnTNQX+AsFq2iL+kXJ76d1gRFyXmjIiNOSuhKDPD3k9zgL21xbe9Z1b78CZkTmzi1jh3WXbUJUY450IkHNcfjFbYrH2WJaGAC3fR7d9jZZNTK45IZhSXxHFGomDi9fLULj7FU95jFu6AXFQ/tVsOlISLIX4umyWUuly2JYEkxHnWrQIaEDxpg5KUWowujkQZaUUhh0HaHF06yPN8Tfh1NBEmsGMraGHulV+ulJsHjSFtzSvqL64w9fks/mbvr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FX7iZEic2QMuXeZKyXOWxz8yIuOz3fRqrm6AJjy2pY=;
 b=Gkb2XnjBxLO0to+sx7vnF5NqkLd2SpRS5bIdT1C6vWlsrQc3mp7311XgyNd6vrllpjaAuD9h+wufYvIwQNrvdZbt7OHtw58RqnJK9G12PDWDXJ+D6YsBCaAFgR8aK2pNTTWO5ViDIOupbqhmM9h+tRaLn9gX8VR3RTSeN5cKf10nRWJRp81vABhFr3u91wvA9BEVUY/IRgIAGtjR93KSGmD3sOZxWrA5UXgeXyxXID7JcXdNkTAuyrCJ55t6wgiJS/H1lz1MLmrxAhPPa4/azG83s6nMjzVEu6mvYXD8G662kg1MtUd8cmKi6H6KkCXLj832G5c/3rLENJSqHRYF2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:17:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:17:43 +0000
From: Zi Yan <ziy@nvidia.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Liu Shixin <liushixin2@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: fix shmem xarray update during migration
Date: Fri, 28 Feb 2025 12:17:41 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <AB942ABF-EC14-4CF3-AA74-D38738A21B22@nvidia.com>
In-Reply-To: <028f5f2b-ec42-4704-b82b-2f604fd11cf8@amd.com>
References: <20250228154219.2214149-1-ziy@nvidia.com>
 <028f5f2b-ec42-4704-b82b-2f604fd11cf8@amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 77546580-8fe4-41c3-244c-08dd581bd039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zko31fFzdpbYtuYz9+I3AemHEPJi0763Jl0HGw1S/m6dS/wnJyzl2EBjqNZ3?=
 =?us-ascii?Q?qHUd/HDNWVDhyoH5XiXPsndV9lH9RLRzC2OhMxjUdCqFGpkjzrqRGPNd6vki?=
 =?us-ascii?Q?mFTCrJ+tNO2QV2dqJUGp5csMiJQtrFyKLuNauRjB591ph/sCUdQ8LyS2vptz?=
 =?us-ascii?Q?CRYFh42rXLgxSgttXvCqTytaHgIBK1zE4g0lRtMA3WxDaTFK4y/C/Ry146cU?=
 =?us-ascii?Q?yJTvXFUhHwcenFhiIE7J9dM9yiamAiHlIqTDJsiAzIxskj74m/OGL+ntXwx5?=
 =?us-ascii?Q?0uJ3phRjGqwJJgm11EV7UKhFHwUubIZRbwCuXQYNKwCD1x/42F8mqpiOM+x1?=
 =?us-ascii?Q?2ropNQNmWzYukvCLz/Nq10GPZLlCNoFlczQ2Sy3OP3ludz2cRCnCXeHkWrJY?=
 =?us-ascii?Q?qJ2JPmfNL+Bltgi2W3mC54grM/nuVomPzNiXaoZqV71BsSgURdVDNfiYLlFC?=
 =?us-ascii?Q?avfEXP2w6zqHLdUEKKm4PS/Eo0fwtZNWbwBUmslzafdZTKsTr3CPHoBjvrZo?=
 =?us-ascii?Q?gfJ0+hCR4rAYrCoW0u96yArligS9MgjSyPuFoSkMToPiVG7KGJ5oUXO4c3zW?=
 =?us-ascii?Q?+oa1eRBKs4RtqitABd32ZanXcbqRGuaymwY7rn0e1y8yM8ct1eMga8cooJzf?=
 =?us-ascii?Q?8iaDbhn8URBudspRR06f1aB47Rhu9xppcLy9IpfF4Ue2lYBAGr6WUI48rxA3?=
 =?us-ascii?Q?XOFRoowox6Iei6xAmnNv9T2cnBo9zqelnweGhDo/veAlhkCCQWz/A2tGfwRY?=
 =?us-ascii?Q?DbCQAoCBK8pJn8qcT9bJe6JcC97/QA1L+t3gWavhrV7A0bpZLpK2FzeDkbsd?=
 =?us-ascii?Q?4FjAZm5Blf6cx34G+zMsaSGHR1uUpiK45nL38A09bMnPKK218GhpU1wCnq99?=
 =?us-ascii?Q?V0oWeDJi8afJ1CgKLCCNIIbhUpWK86EBv5St4BtDnI6ZN0l5YZx8v0kyc9aU?=
 =?us-ascii?Q?pdY3FChwTiSoBrRM5Q8Sl3sH0TUhBBiCsUAhYl8M9L6Bp2QX7/KOxZ3mU4cx?=
 =?us-ascii?Q?EfdsGLsFey94yoXpTccU9zCB2HdzxsczHxdyUojt7By9exVFBwDiUx94CjAI?=
 =?us-ascii?Q?WEYBfyYrvVKf7QTc4jh9RCoX5BRIRB5gGU4s3yfuIzkRwvWBC96oy6LjifOJ?=
 =?us-ascii?Q?5dcKPqQcVAOH4AGqt2yi1wNugmkyczejxk8IxF9b+6s6x1rEAL56T4LnK7aA?=
 =?us-ascii?Q?rAVx58rXrq4k/MXj10iVPXpXJtPzNo9MCae9rJPMwQ9E4N6WL2Uanoykeh4+?=
 =?us-ascii?Q?aLpHLO9ffVcAhcsl0CZWMK8dXYVFaAx7AoSd/mh9t6vOZzdZ6WwGQSl+McH2?=
 =?us-ascii?Q?DAunWjknIN1LXDCdl7pokxIIBzbD9e5JYH6Dsex+yr/P0m0pEo8ZyDjBgLVt?=
 =?us-ascii?Q?z5IFbLOJPfWbetxfZd4MeWxhAOFT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1f0oNWYNp3NcL9qVJKUNW0e7Ep4P8gs8VQnl62CHKHK7c0SyMRlaC2UG0WR?=
 =?us-ascii?Q?vRNKilaMHoXaf7jVUywvPvjyYqHXxTb8BEB+Oj78L3dcb8ysqCqbQ5KK4YYm?=
 =?us-ascii?Q?2zpp+YAIIk/qUK1Urcrq3/eUAREdgQwaNIge+RwWZh252UbxXAd15v3V8I3s?=
 =?us-ascii?Q?4IKpZawl0tNEH3SesWnKKGxgM4Tbpeh020LOyqlLc1HTW6sIYPcsvMUmXxrf?=
 =?us-ascii?Q?SKxW1Q50TPltYGv3iPZj93mkWMpXIm8PdJjkgzjSRG8u74289Szm3G/l63I+?=
 =?us-ascii?Q?waPMfpNjR8DI0UYmH/JY1vyfgJvuOp//o6gz1vVDH4TMf4asTT9kHqFDkfIg?=
 =?us-ascii?Q?M8ABrGrFjWXneiOkK5NFeVU/pEhxqxQDV+Y8ifMtPCJCY2rLbTcB1KPQeoAs?=
 =?us-ascii?Q?g9IGqNpXJ7GRESKWs0dX+eCU4/zcWExkmIo1JtX7HMyOoF00E9Gzc1GID5jq?=
 =?us-ascii?Q?7hm/P4cFI4o+5UgNFZVI/7SQaqvHKRG/ONdz6ConkoJZ6C5REJDhkd/ZNeO9?=
 =?us-ascii?Q?ORzV6zcbFIUlwUWTB2Bwos0KqtonvpM97uS0Fp2emW0aJv8iZpEwncxFGA2u?=
 =?us-ascii?Q?X4d1zVWqevpy4DUntsJloHRSVjpt9jQmtjMODWHXJXCmwYQvf6tiUQFXjJuf?=
 =?us-ascii?Q?t3sJ/cJxg4WtK+rJrd6Grx23eOnQ3/0gJBXkPxldIytIrg4CYInrGBoYWtlv?=
 =?us-ascii?Q?fquuIF34VrBI/7iPpTeaTAzFkNyRiZO4NttOpCbk3bJAHq7ZQJdiUUeU53Zd?=
 =?us-ascii?Q?m2UCUqtydUkB73cqp1wTA3MKf4sqAWX3ApXA+8e+JhTCsbtLjrlXeTMOPivr?=
 =?us-ascii?Q?jTfJJ3QZ4oM3UiG1K3V6485otcyddn9jlceLw0oE5KCS4L6KuSFXkGT55QGk?=
 =?us-ascii?Q?PnpuCLvmsiu573zOW/AYl1c79HSAlIh3oBhzc/B9lojTaRdjMQHKvWLo/ml+?=
 =?us-ascii?Q?QN/eNsCsJFt9KIlHLP2BGUiKYdI+HCbYbNf6OC9FtZI2THJ9LRIMyNVPWRQB?=
 =?us-ascii?Q?xwILYe5iAR0fRlaXrOdfGkW7S6oHN4XgDGtzEPtq+gtI4elh1deAJ+rVeqRc?=
 =?us-ascii?Q?s4PpOPEvi2BZU/Wrr0mIhzdawN7gEspMPbk0lb+v1mwH/wwUbvo/GbA3aOe/?=
 =?us-ascii?Q?UjQzO68TcHaXfvQdoOKpJVIJ+YNhgro6nvnuqm9EgMuuzGcD0MlXBxtutgPT?=
 =?us-ascii?Q?fBerQF4PCBfHvFzHg5qkEY1dWFZkSAla4Rw+WFQArxr/fPvtkXUoJs3g+dFn?=
 =?us-ascii?Q?vh/19FTIrIUVPlAeMK8Q9/gWwyz0nrzsnKW8/sLb5amc5IvBDKor1tpDUHO3?=
 =?us-ascii?Q?TTqcl9Vjr6Oq3ix8C9UfS+xOA9tjder402Nk+JKV/gAw7kRxygxJn2lL44Tp?=
 =?us-ascii?Q?ppHkiX/X0YReihKN1yXa9RZgdArOmgfn1LiLVYMteAfzceOjwB9y4LRno9xL?=
 =?us-ascii?Q?6Zkj2sVF+LG1wOd3b5KCGTbmHSERpOckb/rC6hsgF4SDLLFFBNmwyCBqIKJG?=
 =?us-ascii?Q?cJn7D8vSKoMpGWUCjbnMzQCH/ojRCKzDd00mspu+yVWi7GlSpmyYdRyJkUxL?=
 =?us-ascii?Q?raZA4cdRQdV5MOoUj0XAdKEnFi1ykkh3ly/pUXyz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77546580-8fe4-41c3-244c-08dd581bd039
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:17:43.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYiCjungZuaEEGwyytZUFK/Bc+0Nn8FuSCQMfzCP4o5Mk/kELm42ZOppIAbA6WoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170

On 28 Feb 2025, at 12:02, Shivank Garg wrote:

> On 2/28/2025 9:12 PM, Zi Yan wrote:
>> Pagecache uses multi-index entries for large folio, so does shmem. Onl=
y
>> swap cache still stores multiple entries for a single large folio.
>> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache corr=
ectly")
>> fixed swap cache but got shmem wrong by storing multiple entries for
>> a large shmem folio. Fix it by storing a single entry for a shmem
>> folio.
>>
>> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache corr=
ectly")
>> Reported-by: Liu Shixin <liushixin2@huawei.com>
>> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f86460=
80@huawei.com/
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/migrate.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 365c6daa8d1b..9db26f5527a8 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -44,6 +44,7 @@
>>  #include <linux/sched/sysctl.h>
>>  #include <linux/memory-tiers.h>
>>  #include <linux/pagewalk.h>
>> +#include <linux/shmem_fs.h>
>>
>>  #include <asm/tlbflush.h>
>>
>> @@ -524,7 +525,11 @@ static int __folio_migrate_mapping(struct address=
_space *mapping,
>>  			folio_set_swapcache(newfolio);
>>  			newfolio->private =3D folio_get_private(folio);
>>  		}
>> -		entries =3D nr;
>> +		/* shmem uses high-order entry */
>> +		if (shmem_mapping(mapping))
>> +			entries =3D 1;
>> +		else
>> +			entries =3D nr;
>
> LGTM functionally.
> As a minor style suggestion, can we consider using a ternary operator:
>
> 	entries =3D shmem_mapping(mapping) ? 1 : nr;  /* shmem uses high-order=
 entry */
>
> This looks cleaner to me.
>
> Reviewed-by: Shivank Garg <shivankg@amd.com>

Thanks.

Best Regards,
Yan, Zi

