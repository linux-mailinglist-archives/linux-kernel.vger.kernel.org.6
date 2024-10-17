Return-Path: <linux-kernel+bounces-370632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F12E9A2FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11BD1F230D0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B29D1D5CF2;
	Thu, 17 Oct 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CS3P0gIy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960E01D043D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201003; cv=fail; b=WrQjZyy37whE2kF0qBF465q2kDQRtkfepYDyX/QcqueTp2t8GG65ukSLUJALqTZtYsFFa5cFrXf7RzTL/axjGo2fK9auotgxJ08bY6kO2RunE/BvkUcE2adnvNXvadmBtR/Ix1yLUm41Z2JdxWnOJuHDsN+0NYli0N7B7cGvqMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201003; c=relaxed/simple;
	bh=SGIQ1PsPyGRNxNo49jWESLq5C63rmGK2nUuqXdrTy/0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ASb6SiknJpwc0UtL480uRVSRKTKpSbVGVdTFc34pAeTy65DkaBXthM9lhET1HEqqhcEArQukR1HHj9KJAPcUEidaNeeM2rNUYyjnwPFGlgvo9Du602yz0Q9kLHUJLlvPDOA2n9L3sNtQmg9vWvW2fNRku7UKS7L1MVsRqTStlR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CS3P0gIy; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsWkJtrR5/EfgBoqMTEjTZbhGtTt5NzscgP4ws7nxtj8h1JEwi3gDs5DzPgow5gUzDRaR9V074lHM8Urdl8gsdkCXm1TsLCHrBvniSPorMfg6T6dxdCm7HCDrLWC+U8ISy2PujFi/8ym5IqNEViMcu93q6OYBlHWA/KpzeURh6ucU1OUfyNYSN/bF6bFF39ON/2LBZgEwbe/sk8DZmhtv/acFig93DIGkjLhtQB3Kzl7pSR/wBSdIykGXFHW/8vTcKAciUNeSWrZiEPUh5Cf+rZGvTseVpWOFqqth2RCeu/Hqw/xlipzujAgz05+Z+IHbnshc0b3aIA4HS0TZRpQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxWkzc0g0f2KSlIOhpNLyPqYY4YVl6ynEXNzTCbrGOs=;
 b=evCydw3pFpcP9jQ9bMYnzKcWc5DgIQApbvizS8+AMitEz+rLBNA3bMQlr7U+dpwd2Gqi324S3CzNvCRbi6nf1a2lnIw7vwAoEyaAkSuLN0hT9ZWmvYlhuv9qKxAlePqVxGMbk+21p2Dp6TKWEgnSK7TGIUnWzlpbNfFzWulCgN64r6Vtzl7EqdJ2aKxzUuLwjIN2AGRpJZJtzJqfIOqlc6bPQ3dAcUJDFImir10ICy708UdCg5NSpfUw7HGM/ZAQ0wYFESOM1y0YmzrRbaYCeINYSv9QR6DBR4xPUoUWimXYS7IggTSR1wY0stDjb5gRaJasDUmXFEIBukdBNW1uEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxWkzc0g0f2KSlIOhpNLyPqYY4YVl6ynEXNzTCbrGOs=;
 b=CS3P0gIyPQ1Ydutv2f8GLSmUg7LjEHakuvuEzod1UpGMIDt8QmGPCx/6zBINWYjsq8ZZSVD2vI+DIs1ILWMK2LIF4B3opByW3dph5/s9+XzU/S1jiw/tZzDFsxYbLKRpOWTzXH0/mkGK9vaf0IfpF/RzlqBWRYaTde6nELJMCJzAdxonk6lRwKUuOvTIUT5K5ES34Yk5baj0mIELRpvkQJqMAZYYKGycKiBr7iMvdmLneRvxBAsvewWcvDCjFl1pKd8A3jMiGpckl28514tKvJMpeJ5/8WaWMwRkmvMPTDeduSlsBTmDJUeH1CPQpsEOZGbu3FmaTzFR0ZXPjjRf7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 21:36:34 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 21:36:34 +0000
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Shigeru Yoshida <syoshida@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory conditions
Date: Fri, 18 Oct 2024 08:28:49 +1100
In-reply-to: <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
Message-ID: <87v7xqmmxt.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0138.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbafa1d-55c7-46d9-7a8e-08dceef3c5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t3JEj8ahSnvcxby/tnwCrxcvMU4ZP34j41Pay893yU2g7NU1U5QU/9EwVMy6?=
 =?us-ascii?Q?Twpxx0gRHYDwR55eeVVEL4P0bDkdPAQtTA+j4hFFXDlWomjnDsV11tfrmP9T?=
 =?us-ascii?Q?AQgjfObKrVZ4zeadr8qj7Fu0Jghi8+5xjgI1DoefRrRmwEFDmp7s5Yhck+dz?=
 =?us-ascii?Q?kN5TQRG/3B7wOvJtNUeauMsJl0lh7mVq8TqcK1IGSXegOnHMyUDSgn2KkVqJ?=
 =?us-ascii?Q?4ZQycCLpV/jA5OcCZje/K5xgLaYuHOsfLVFs7llvoKSRQCuHlM3H09QE6joB?=
 =?us-ascii?Q?vW1CQvnArGlsrRB9XoUGPyB4HEK9/ttWLwL7HUXddDWf6fnrin7VLS9pdGL6?=
 =?us-ascii?Q?4e/Kr8HRh3QSUQo+Uedme5dSAdpehiZQLBKM7bnrFqbip5sXI3oodhEpgwSy?=
 =?us-ascii?Q?xWbeK0x+gdccBxnfPyqaYhPKg+ZmhQvP94GjBPzY7/rbPUbUZ0K4o6Yr0Vs+?=
 =?us-ascii?Q?MGnD7UdgSzJAJ7UQOZK0bjtz6VE1jG6GPezZccSt7h4r+RbcEsrqBItofOUM?=
 =?us-ascii?Q?6Reyw10/T0qFqAoUr3+uAzuEc0JjMuIjquKbDNu5S+pC/2QUCizElGjRYj5w?=
 =?us-ascii?Q?1Q39WbIGhQNB+sagaSKQRsKDDx4Odrat7eRuTzxUbMNf+f0B7fotKVsuruZQ?=
 =?us-ascii?Q?Nq85t7Zijg9nY8G1AS9Gicka8osjU3q0vLIa+J6l54pKXYm6OJTicepSR2jN?=
 =?us-ascii?Q?0GgXv1/WrBMUwn/leIzfre9kpHTH0z1XlWhPdwpn5AMLBIJ+/zsPlnAlDjS+?=
 =?us-ascii?Q?W1DUnzzLsbO/tPTaJjdI3zyya1US9XiWTWtxNA89KKBskfgs1RyBnFAPObfE?=
 =?us-ascii?Q?7fFa0CxzV9o99lZ6uPuekqbDSBoK3PMCYI3kLsEoUGpxxX8/u0wb7HrlncEg?=
 =?us-ascii?Q?YOBTvm5l4pqhViASnTMZnyEBNwz30EDIbUSBAdNs3Fd2OgFK6bh9sLVBr9zu?=
 =?us-ascii?Q?xKKpsk4nC25M3MU6j07fear5BM4oxSxRCtTGrEnZpSqq1Ov+JoBNUC4aipbl?=
 =?us-ascii?Q?KsAS4n1UCFWUW39QH5HYG6frQEu8GSfPLlvKzwpIb5vI0kLy8dJgm3q/WZ1o?=
 =?us-ascii?Q?EX/DmDpCvd2447rMT2fksLA8FveNcmn3bZ8MXCScLytY8Znxy9z+FyCHPHNE?=
 =?us-ascii?Q?BVkSNFFd9+lj8uBp3iXMsoX0bA/BpabRPgD7lh8imwzAmHvZB6GpKlIyFFdl?=
 =?us-ascii?Q?dfy/+tywlc4pPpl3ufxFt4bWZvI16WpukmJr554EBRomsGoDoWDDJDf5a8N1?=
 =?us-ascii?Q?WE5FjKHM9FXpE8U7jNP2dwveux/ctZHe4oulIqA9tGtA0zgKWM5ZPCVJ4dJ7?=
 =?us-ascii?Q?djXEeLibd+pdWqW3pRi7JE/U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OmQnYDT4lmVt3rYLYa48/gmhyTW4w/T7wu631kW1SO+uMViumQCn1kO0fIkl?=
 =?us-ascii?Q?pBhY4LFUrsm2LXqnjLjZVbEKCRpapcs9tHyxt189uR42zu09TgdS4hh4E4TM?=
 =?us-ascii?Q?ZAyaPi9hQfiyLS0rsvcaUfM6yGerjTzq2Hpz76unq1s5HZeceILpc+JwEYRu?=
 =?us-ascii?Q?UfJMuljSDxZJXM+RVe0JoZqgwoL0Rb+0cRv69Ev8yH0nIw9FPNXD76IaFEaS?=
 =?us-ascii?Q?bKVXBjE/DAht9tgVI9JMn+c8UBqu2bf+fTfpgzB1QDCJl+kuboaZEr3CL0US?=
 =?us-ascii?Q?LS/ihfkHEPf/YsVrMbf/UzadHLt5vOwtjuVUv0gL88kH4RMMIdBx6npFPO+E?=
 =?us-ascii?Q?ZBM8pjX5Ug2jZaGknWWJvT29SLWuGc//yU7lxKpZcB79b75lYD8a7hwbwOT5?=
 =?us-ascii?Q?+XwjscWMWWYinQE6rMaftS9B6W0Q4sDE+s/cMoEzlE6BFUeHf2nN0OAXYWnr?=
 =?us-ascii?Q?4bJe7JK0HQjQWCSWwda1N/VAdw9e1b0thgFsvU9trl6e81oiPM2DcULja9iX?=
 =?us-ascii?Q?WyVKRL4onE85JoTzKEykeLTgdkJp6jERSi53+bhKt3Yl3QsMlZSSeqovzmuu?=
 =?us-ascii?Q?E75+sWDfpq33PRaDBe37sy3KZS7qIZX5UrqEnvKY/i0g9f/kht6W9IQeTs4l?=
 =?us-ascii?Q?HQ61mye17fHdHWSzuCam+eBktTIdfULoa3I6iNhV9lg+/Hn0ov04KfmxqfGK?=
 =?us-ascii?Q?LU5YHNDbTDgcBa8NNymYx6wVRuzRf3pH5BAaeuUrVyVtzagsoS4wwHMTFvB8?=
 =?us-ascii?Q?Tmd9PzmYUZkjlWfVr/1Iq3DZdseY0w9GXmtNrYSLiFK21DI4tiS3bUZWwtFR?=
 =?us-ascii?Q?6O17DXmoTn6Kdfh6sw3zmE1OepLUkXsUSBKYbGX7psgdlYOctFbFoIppi+Hr?=
 =?us-ascii?Q?n1Vdw6g9pMZNCMI1h+6Z+S7HHajA2PROuae/39K2snOrcU8ycBnSELp3DScd?=
 =?us-ascii?Q?qouiuWH8MrqocEZymubNhucCpalNMHdAOpv9pLFySvwwe6mROWYV4ywvU73L?=
 =?us-ascii?Q?HvSE0rJKmRGxJCm9MvuxnSo4yD6HHC9NiQL2i9fIpi+5+WE22i0g9lcRoRzs?=
 =?us-ascii?Q?dj07b4OY5WfyJjHn92BRBni20Otf59UVfe8N8rDMaVAMkGbWJTYTKns2zl5k?=
 =?us-ascii?Q?2P2lttYTNB8vcpmaEMWI+9HdA83OiKktE1SrWbuOiicn2RhritUSsiIqZvs5?=
 =?us-ascii?Q?rUhaBE5FNnaCxjPgwjTEF71Aobolq2Juzk19b87/JwtIAKCzGqoN1aAtqj09?=
 =?us-ascii?Q?Gu9aQwmMFRvQ5MjEwVJ9HJvDd7YGjpQDkyZimOWQMvgoWjKd6iudlPW21MaH?=
 =?us-ascii?Q?4z0mdjbOW9fTdnxfjWajPND/xE3FynERwscfOIqeZ2uoC9Te8gIC0cCT+llk?=
 =?us-ascii?Q?r8FAVm4s8zhSj/Cjbcek6rVGlxEN6su6b8Mi5xsjMgg4II8tHwdaYO+kpUTf?=
 =?us-ascii?Q?wR+9t1nd0YLTc04bNBI1MkGEXu1x8pXcvY1Z/B/mtV28jBkhyAd2YrwtAvK+?=
 =?us-ascii?Q?0MA6wGYdwBK9T05p6c3hll1QXZfyLul/i7srDskGhXBJT04A+smQ9ynI93Uq?=
 =?us-ascii?Q?7WFXLpcGMcPMDoDc+MN6+zOSyE7WSAY0QZoB0G1J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbafa1d-55c7-46d9-7a8e-08dceef3c5c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:36:34.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk2Li2Ad5HO0cw6g7QN8eE4vUvXlqEJqS49E7PVjrH/D3+yOczfUG7ksJS70UEp+yRjhUZAnk8LTW2n56RR9gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282


David Hildenbrand <david@redhat.com> writes:

> On 16.10.24 22:22, John Hubbard wrote:
>> If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
>> family of functions, and requests "too many" pages, then the call will
>> erroneously leave pages pinned. This is visible in user space as an
>> actual memory leak.
>> Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM)
>> calls
>> to exhaust memory.
>> The root cause of the problem is this sequence, within
>> __gup_longterm_locked():
>>      __get_user_pages_locked()
>>      rc = check_and_migrate_movable_pages()
>> ...which gets retried in a loop. The loop error handling is
>> incomplete,
>> clearly due to a somewhat unusual and complicated tri-state error API.
>> But anyway, if -ENOMEM, or in fact, any unexpected error is returned
>> from check_and_migrate_movable_pages(), then __gup_longterm_locked()
>> happily returns the error, while leaving the pages pinned.
>> In the failed case, which is an app that requests (via a device
>> driver)
>> 30720000000 bytes to be pinned, and then exits, I see this:
>>      $ grep foll /proc/vmstat
>>          nr_foll_pin_acquired 7502048
>>          nr_foll_pin_released 2048
>> And after applying this patch, it returns to balanced pins:
>>      $ grep foll /proc/vmstat
>>          nr_foll_pin_acquired 7502048
>>          nr_foll_pin_released 7502048
>> Fix this by unpinning the pages that __get_user_pages_locked() has
>> pinned, in such error cases.
>> Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix
>> check_and_migrate_movable_pages() return codes")
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Shigeru Yoshida <syoshida@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   mm/gup.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>> diff --git a/mm/gup.c b/mm/gup.c
>> index a82890b46a36..24acf53c8294 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2492,6 +2492,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>>     		/* FOLL_LONGTERM implies FOLL_PIN */
>>   		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
>> +
>> +		/*
>> +		 * The __get_user_pages_locked() call happens before we know
>> +		 * that whether it's possible to successfully complete the whole
>> +		 * operation. To compensate for this, if we get an unexpected
>> +		 * error (such as -ENOMEM) then we must unpin everything, before
>> +		 * erroring out.
>> +		 */
>> +		if (rc != -EAGAIN && rc != 0)
>> +			unpin_user_pages(pages, nr_pinned_pages);
>> +
>>   	} while (rc == -EAGAIN);
>
> Wouldn't it be cleaner to simply have here after the loop (possibly
> even after the memalloc_pin_restore())
>
> if (rc)
> 	unpin_user_pages(pages, nr_pinned_pages);
>
> But maybe I am missing something.

I initially thought the same thing but I'm not sure it is
correct. Consider what happens when __get_user_pages_locked() fails
earlier in the loop. In this case it will have bailed out of the loop
with rc <= 0 but we shouldn't call unpin_user_pages().

>>   	memalloc_pin_restore(flags);
>>   	return rc ? rc : nr_pinned_pages;


