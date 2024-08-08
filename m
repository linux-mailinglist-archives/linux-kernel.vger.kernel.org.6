Return-Path: <linux-kernel+bounces-279682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FBA94C06A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F06B27C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98818EFC8;
	Thu,  8 Aug 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JIsabRXD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD818C912
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129173; cv=fail; b=IpKAwgx6EI8P0ZiwH6xhJaXT60J5E5pNEcTNLu0jlDQ+O5sNNYBSCxuXhfMyc2gBKj7VmnFXPkuASaWHrwunPOGJ47js6tcHz1xx3/DieHcMsb9UNHd/CuCamrQtkHQMMCNtrNGoUN51KJCNuD4VukrWR1joOnHahem55LYzgtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129173; c=relaxed/simple;
	bh=K2tpoIS+eYNkWipBvLZa+qD9ZnJ8ZntW9frUkTf91SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sm7G0b4nIBVXVDFWrkNYpRKUsnKTGuuIlOlLE0nA4jGS5b2hblulNd4HgcKDj9bic/JpHJN/awHUu4KvE31ksHiJJ425SN2DLkgPNxtTSh1dkiDw6orkcZSukZwFPJlIF6+E0W5eyE7QikC6qzj6lCd36aapmZWI8torv17kcGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JIsabRXD; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2JQr8MNtHPFEyliCHxqXgFAJ9gdW358DL2DFooplxdTiEDVSj7WrCSf1nBCkqKO0H5tl0SkixFBYw4t9V7J1RnSTO/feoJpTJUVozUtnZkQBlyt3do0D3I/Rg94/JE551sgX90Qvrc09h8cm0KEDr8tzaJcYBQv+zaTn2ppch9Kgk4QJVahWCWs+rPGGKhT04ILXKwQhPKO3eVjXpzj74ncl6rOTU4AjmoFjqfNcBLAJFtcCoR/+yZ5IaFJxJtCAuohNfCrxtfE7UW/MbThy4tM+dC+s5gIP4WHdws2RrH9S+W23vb1DDaoxs97qYUFzVYVq9X74+nd9QpO1AUMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HveeJi3UMmYGjQZEizWfWAkezk/WTfo9Y9bR+Y/c7g=;
 b=LiBfIjMcg7BqWQm+TYtkMUPMZVysY2+SBYkn6iOjuRWHMzxdSiVct7h3gbktbbLcEA+B/0pdvUCCVbdXv8I3EC5ZIgJwZIg+arjem0svTSm0L69sb7KjJvG0PX+v4IE+yiQDxOk5om4UT8gqV0xBYXmsV8lKT2ivS14DJTfQDjNnyDkDOFPb1ya8tANIaXIs6JNz93GgtTyTHnu91DrMcUKhTf5DjAMnjYHUMizoloCMwoeEtub01Jv/6pECy7PpaZf5HDtq8dRf00I589lb6qGXx/2AQxCr2xyQxVLkQpt+1dvSGPbQGgbhu9o47MgFPEY3gLgyzHpZOPa4edSCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HveeJi3UMmYGjQZEizWfWAkezk/WTfo9Y9bR+Y/c7g=;
 b=JIsabRXDqocY1hnjLaOB6QLfwmN/XKCRIn2E6BVDkWf9XRKp9rNSQX7ZaorkE7ocFa63yRzIDo6VhEhi1z7sTOtrW5W94E+Pyrli0OHLKS84LMSMFWiWuT7A/w5b9RaTTmxSTmN2q6oaU1tBHyBYcVMyK2HvBMcatmAaj6vvhfgSO/uh8mxUE4CJV+PMWxM9NvkVJ7LdoQdOknxRutpqp7iPRmw7PI0adk5yWfsAp5oAivSQYsd3n1ptWPkHaAhWKM/qh+BQfpNG1KA6te/8KvPriqTMOBbObLywNKzo9AJoVXikSIteFup6O5C4qjl9E861k9lvCnkyvQYvkaYEYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 14:59:26 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 14:59:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/migrate: move common code to numa_migrate_check
 (was numa_migrate_prep)
Date: Thu, 08 Aug 2024 10:59:23 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <4CC95A65-A183-4D7B-A52E-5AAFB56625E1@nvidia.com>
In-Reply-To: <8734nf1wil.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <20240807184730.1266736-2-ziy@nvidia.com>
 <8734nf1wil.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6A002184-755B-4985-974D-1D85F43FCDE8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:208:120::17) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c29544-ecb7-425e-d008-08dcb7bab21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wRtAhB6xUDLGbXW+QiTT1omFqmXP18u6xKD17Saf0SiFtPifIeHOR+XYhSSu?=
 =?us-ascii?Q?GjCnoHFoF226kcSSegWeJaVYynqXHTdP8jJ7GwyrZdnqiLk7iK0Gs5+P7IlK?=
 =?us-ascii?Q?vQO1CalyqtM1O8tXWn1POL4qv1p+5bF0nhbrCnhhuy7qZDLIvU0OKb+3S47c?=
 =?us-ascii?Q?iuWWYN3ryi3g5sU92GXn4RwR1kx9GddfQcgXQzirInDf5i+thf3IXaTGo+td?=
 =?us-ascii?Q?fe3MU0gr1YMr9zac5WgRDwJweeWedrUfqyoIOGPRwEF/8r5hllT5Xzb2wCzg?=
 =?us-ascii?Q?4OsKWAHpIfdzqMQy5i3LKqAqsjDwDSvQgG1lqWFCqpqjFjQ64KinXxOctSkL?=
 =?us-ascii?Q?1UsDP6WPwOyCNWOiey/Au/qSURnro6U6y1CYzgW5nc3zFdomCiIVnaQkaGuO?=
 =?us-ascii?Q?f31wto6i8CfoQ8XKmetbnRR85q2NAEil4aJy8Ms0HcqKxVe7tfp5+OL8UiUi?=
 =?us-ascii?Q?/VxL8cNFqOoB8t3Ji69/MDj00C+mkp/DXNavU1/yl2JAcyXyHvjZffjbR4eV?=
 =?us-ascii?Q?f/ZjGQ5VbmAzqTLEVDOJuA9cHf0USHrCfmoifdSUtPrNnhaVZ8/rA1c8rzaE?=
 =?us-ascii?Q?3+ClmAMThtgvMCT2BdfIocAZF7gRDu1GkzFvr3p5nK3ng2mPR37qTIo0N8tr?=
 =?us-ascii?Q?NdIxrdnlE36DoIjurIcWHg2IWtzjU0U1HN8tSsrib7K9sDK1RNEqRqfoqcWZ?=
 =?us-ascii?Q?DnvjJQXu1Iqq/YAQO1ux3lcP+EMYMpDJLUF0G3fPP6rXiGGui61qJyCm6dH9?=
 =?us-ascii?Q?KLBMzpR8PMUj0WZkRPxD0xMdK2YxjMrfu1SmpnAsU4xtSfplJRsaRCD2ol+v?=
 =?us-ascii?Q?QZJhimEv+HjBIcwT6AksGGoVCR71EZeSyQ3BgNUrwHeztvoHvz4yPkfqA4pb?=
 =?us-ascii?Q?R5tifmGcrnoxcaPaAcK7BimSkK6zjJdLiCLCZdUvq8xGfTmM4HxnhV655Ccy?=
 =?us-ascii?Q?kVEr0znHdMKrMTDK5JuHJkPdaypo5tvAK70hI6htMIuCYJZY65ERh2JNlcgl?=
 =?us-ascii?Q?5A9r7YA3ZDf+6GFXTJdBW3TyF7ubkuEydeEXLDFMJl1QKrfYJWlKKjEWuYwW?=
 =?us-ascii?Q?l1DVn0dfCS38N+Up7k5RTS1DKh7GLtrKZpwrJgBcx90Cq7Esa8LBP+b6R3t8?=
 =?us-ascii?Q?JwRxtRZo2nYiQdgGZ2ny+8H56r2sSgPq9kCHipBNd6wpSVVrg5lzeTLk3t2P?=
 =?us-ascii?Q?t78R5MMxQy+l0xpzXUB9Y338l86u9QXUvFAvs4HZtdvdHkqEepJwHO0n3mm6?=
 =?us-ascii?Q?xQyAgyN8mk1BqYMndktKRHSZUmiAFYmwg0quIKKux5ETfkllEbcNS7pRa9tc?=
 =?us-ascii?Q?o8tkv90AQC5MH2u+JvYXWeJDJ7s79w/ShTYrfK8e2/1VqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cu2AH4h7Ihi2Ncl5t9ZE4PNOcaU/B+Yg2vEPbPI6NvKkKKenpVnft1OLY6yc?=
 =?us-ascii?Q?acSdjApoC78biVXBxODTzss7oz0ARTGFAcmx0086lHmj9uPYyGaljn72wlon?=
 =?us-ascii?Q?ChTQGbfeNGLyJhcJl7iiwWG1ka0zsL8H61563Yk/MXvEpPcav1YtlV1jtSfW?=
 =?us-ascii?Q?p8NA3xg+b/vvNBxcMR3TdAsxIgfEVeTGbLarsZ3vTvnqPOe2/gsN+M74kpV+?=
 =?us-ascii?Q?10AMtrg70BaAPpHBoi7ofGR1gKUmJS1tc6sMLfyQKuEpEv6eNQSBYAZKFYK0?=
 =?us-ascii?Q?YLErTYicuSk+3fAyuAZAlzOfz7820oSCoEesF9pFfbbO0qn6CRof3a3ll0GK?=
 =?us-ascii?Q?bTynvc3ScVXxXBUojgUKjlzv3qobxJcFVdGVq7MgAV9fZLIRP8C+YWD6JOrs?=
 =?us-ascii?Q?5S9cpWoxWTAkAVArdflARVMUuwwDBvilcbZQQ3oaGyw9oIjDnNZTAUgkgmCg?=
 =?us-ascii?Q?2YquCzIZp7JYTv+ZSxmBNxdTU9iuHWl/rJrIj54Qf8gI3MaPQMQFqru1lA6K?=
 =?us-ascii?Q?fMpu5ooZmzkLldZe9SAaK18itbUPXDlv5/R25Pw863KmA56oIiTctRsK6Oyi?=
 =?us-ascii?Q?zaUz1jagf1XXp/ypT6ztI4tnuZS5RfRgVn4f8SY4H0qvCKNXD4TU/6xzMCdv?=
 =?us-ascii?Q?plEcYVVsvfn1xkzZv1JzFqdmgqg7lt5yRPTDb4jFGse85gaHGH53TpCuhy9n?=
 =?us-ascii?Q?sOzCVpQ+SnKnkPXqoQ9dBlf3lDMfK1jnAR59aOkszT3zm/RqoT9H1x0RqDWD?=
 =?us-ascii?Q?JA+PLpmLTjamWwz21TLjsPbETolJ5mHSUT7BtVtahTYo6pDe9Mp4HnFn5RnR?=
 =?us-ascii?Q?UZ4I4+IcHdhWzr8BjI1E4eCEKC0xECXH51M+sR7h1jfUipX31liRwzBp3v0p?=
 =?us-ascii?Q?POZ5kzNT5QFoBp9rBtSQSYTbjWL8ZMWvusZCdZPea4ZlId9VWWD489B3UR75?=
 =?us-ascii?Q?YOxvJ53f8zFMkSaPVV5xPFwV7qkr4/CQ9qVRS7J6wCD92rY1qorNf5QXmxPh?=
 =?us-ascii?Q?AvBhfCxXFjUVyWDLKoF9IG0zujJkovDIZegaEzfRf0X9sfOL454MJCpwapRV?=
 =?us-ascii?Q?Ep721T/6Qg8rVwsrFKOHyUe7VV2Y0bIZvjqEEPpD1+4HK9kpgR1bsktlY3NP?=
 =?us-ascii?Q?up3SrHqB2gbYltujr0on8hDWvMWajUWQ2VPUhfWMyENk0HlknQE+3dHrrm4+?=
 =?us-ascii?Q?VNXmek3Jwx3E/qgxUCXUdrwZMRxgm9S2+jjuAO5/qODNMpTV6hWGHAdWJXM6?=
 =?us-ascii?Q?WSoyalaoUlRv4qZdayWs/L8J3CJ4Uei7zZnM1aflyHZ1wo6GNTiSjjPfzjSL?=
 =?us-ascii?Q?KEoKwWfXre1e4vuPflidvq9oXME8+v21Q7Q9zPOaKaHxAO8Ci8R/Q0vMlhX9?=
 =?us-ascii?Q?DRQ4YTkz+JrS3clMBn9l3Sj0LHxnuWU8AHaXt6572anq/Yo1pAF8SPLwC2xw?=
 =?us-ascii?Q?H1MgyWi7Of7S8adb2iOQ/xxyw6a3bIUYcbOiX9H9NqFefUGSeWlo3xBG8W71?=
 =?us-ascii?Q?6IF/T3OyIcF6EA67X+R91zlV+c9FiB5GRpBH/2JDqZQeU6wtSdTFrptLDfJI?=
 =?us-ascii?Q?HEdosOoOvnKPQWSVtnIqclrAOSFb9ns7igzM3Nby?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c29544-ecb7-425e-d008-08dcb7bab21a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:59:26.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceP5k3JDkmxRIZPh8bxo3gNLLwDZQQnW1gg5IwPAp+nosQqRsWrDJb89Or4PdojD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040

--=_MailMate_6A002184-755B-4985-974D-1D85F43FCDE8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Aug 2024, at 0:14, Huang, Ying wrote:

> Zi Yan <ziy@nvidia.com> writes:
>
>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code.=
 To
>> reduce redundancy, move common code to numa_migrate_prep() and rename
>> the function to numa_migrate_check() to reflect its functionality.
>>
>> Now do_huge_pmd_numa_page() also checks shared folios to set TNF_SHARE=
D
>> flag.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c | 14 ++-------
>>  mm/internal.h    |  5 ++--
>>  mm/memory.c      | 76 ++++++++++++++++++++++++-----------------------=
-
>>  3 files changed, 44 insertions(+), 51 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index a3c018f2b554..9b312cae6775 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1699,18 +1699,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fau=
lt *vmf)
>>  	if (!folio)
>>  		goto out_map;
>>
>> -	/* See similar comment in do_numa_page for explanation */
>> -	if (!writable)
>> -		flags |=3D TNF_NO_GROUP;
>> -
>>  	nid =3D folio_nid(folio);
>
> NITPICK: It appears that we can remove "nid" local variable.

I thought about it, but

1. if folio is NULL from vm_normal_folio_pmd(), nid remains NUMA_NO_NODE,=

2. if migration succeeds, nid is changed to target_nid,
3. if migration fails, nid is the folio node id,

all three are consumed by if (nid !=3D NUMA_NO_NODE) before task_numa_fau=
lt().

I will give it a try in next version and see if I can remove it.

>
>> -	/*
>> -	 * For memory tiering mode, cpupid of slow memory page is used
>> -	 * to record page access time.  So use default value.
>> -	 */
>> -	if (!folio_use_access_time(folio))
>> -		last_cpupid =3D folio_last_cpupid(folio);
>> -	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>> +
>> +	target_nid =3D numa_migrate_check(folio, vmf, haddr, &flags, writabl=
e,
>> +					&last_cpupid);
>>  	if (target_nid =3D=3D NUMA_NO_NODE)
>>  		goto out_map;
>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 52f7fc4e8ac3..fb16e18c9761 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1191,8 +1191,9 @@ void vunmap_range_noflush(unsigned long start, u=
nsigned long end);
>>
>>  void __vunmap_range_noflush(unsigned long start, unsigned long end);
>>
>> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>> -		      unsigned long addr, int page_nid, int *flags);
>> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
>> +		      unsigned long addr, int *flags, bool writable,
>> +		      int *last_cpupid);
>>
>>  void free_zone_device_folio(struct folio *folio);
>>  int migrate_device_coherent_page(struct page *page);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 503d493263df..b093df652c11 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5368,16 +5368,43 @@ static vm_fault_t do_fault(struct vm_fault *vm=
f)
>>  	return ret;
>>  }
>>
>> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>> -		      unsigned long addr, int page_nid, int *flags)
>> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
>> +		      unsigned long addr, int *flags,
>> +		      bool writable, int *last_cpupid)
>>  {
>>  	struct vm_area_struct *vma =3D vmf->vma;
>>
>> +	/*
>> +	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as=

>> +	 * much anyway since they can be in shared cache state. This misses
>> +	 * the case where a mapping is writable but the process never writes=

>> +	 * to it but pte_write gets cleared during protection updates and
>> +	 * pte_dirty has unpredictable behaviour between PTE scan updates,
>> +	 * background writeback, dirty balancing and application behaviour.
>> +	 */
>> +	if (!writable)
>> +		*flags |=3D TNF_NO_GROUP;
>> +
>> +	/*
>> +	 * Flag if the folio is shared between multiple address spaces. This=

>> +	 * is later used when determining whether to group tasks together
>> +	 */
>> +	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED)=
)
>> +		*flags |=3D TNF_SHARED;
>> +	/*
>> +	 * For memory tiering mode, cpupid of slow memory page is used
>> +	 * to record page access time.  So use default value.
>> +	 */
>> +	if (folio_use_access_time(folio))
>> +		*last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>> +	else
>> +		*last_cpupid =3D folio_last_cpupid(folio);
>> +
>>  	/* Record the current PID acceesing VMA */
>>  	vma_set_access_pid_bit(vma);
>>
>>  	count_vm_numa_event(NUMA_HINT_FAULTS);
>> -	if (page_nid =3D=3D numa_node_id()) {
>> +	if (folio_nid(folio) =3D=3D numa_node_id()) {
>>  		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
>>  		*flags |=3D TNF_FAULT_LOCAL;
>>  	}
>> @@ -5442,13 +5469,13 @@ static void numa_rebuild_large_mapping(struct =
vm_fault *vmf, struct vm_area_stru
>>  static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>  {
>>  	struct vm_area_struct *vma =3D vmf->vma;
>> +	pte_t old_pte =3D vmf->orig_pte;
>
> The usage of old_pte is different from other use cases.  Where,
>
> old_pte =3D *pte;
> check old_pte and orig_pte
> generate new_pte from old_pte
> set new_pte
>
> We have used this before in do_numa_page(), but not do that now.  But I=

> still think that it's better to follow the convention partly if
> possible.  This makes code easier to be read.  I notices that we don't
> follow it in do_huge_pmd_numa_page(), we may change that?

Sure, since I am trying to make do_numa_page() and do_huge_pmd_numa_page(=
)
use the same pattern.

>
>> +	pte_t pte;
>>  	struct folio *folio =3D NULL;
>>  	int nid =3D NUMA_NO_NODE;
>>  	bool writable =3D false, ignore_writable =3D false;
>>  	bool pte_write_upgrade =3D vma_wants_manual_pte_write_upgrade(vma);
>> -	int last_cpupid;
>> -	int target_nid;
>> -	pte_t pte, old_pte;
>> +	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>
> Because we will initialize last_cpupid in numa_migrate_check(), we don'=
t
> need to initialize it here?

Will remove it.

Thanks for the review.

Best Regards,
Yan, Zi

--=_MailMate_6A002184-755B-4985-974D-1D85F43FCDE8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma03UsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKrYAP/0+vxJv1psi6hC5tuAsOhTyV9gbfTn3UkkH5
eqMXRjt8LrQvIIOgKS3nfwfixy1ZaxsLqb+UArHmj02mJxWqy+w1AmBz8iBau08K
kVP6+8j9eMuLV/ifnKmT0rc1RXsJvx5ZvH5b+w1npov+IvRV5jzCRYHJY5GxFxXU
qrpIxtX7g2PDG2uG8DD16AuRQq9z1dlmtT2Mr81zLKeSS3i6Yl9e3dBB975ZRRRj
cLdUs+rJw4FIMmfxP2B/cuv5A2OCs+SL+htHIbWbBc2v2soh/nprWgm0shBZWV3N
9nkcaXH63TBdxt5aFDPlC9W6rNR3xK73EnHvfxN0SuU03zIB9p+RI/evlZoJ9UlY
2wBxHfAz8rQY+vVy+W4GRrAvgZsSrH+IOyAXNqXmLYdwEO+4rDN2J6VSuD924N6Z
218qW78rT7TyZ1TwKgwWywOf1PrKfoqlAH3sc7Pw9tJEuO9mJVjqN3NB6O1XA2c0
5NWa1vSFk7zzXPkKYRdzUTQFftLxojD/5pbseP0mwMpGt8ThvlBajQFFtZfcNxzW
tWliaEN4xp879elvTPylsyNlVH+pWAsEYfAXAKSQwQpuvTkZDFRP3vqfEqzlBk+9
DrYZw/LwHNJ0LW+lSt3bOIdm0seyCqZ7bp7NVwH9wRO/37kZ5+67DcSXCBu9Qdt+
8De4BdXl
=4LpY
-----END PGP SIGNATURE-----

--=_MailMate_6A002184-755B-4985-974D-1D85F43FCDE8_=--

