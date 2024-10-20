Return-Path: <linux-kernel+bounces-373502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A69A5779
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE7C1F214BA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B70C2F2;
	Sun, 20 Oct 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kdRR5lt8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC019005D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729467012; cv=fail; b=dpb5j4pPwYY29Q5gu8q1Bp1gwico4Snjq13ROZqnEjrfNvswY8tKHhtZgqyflXpE/tQuVQ9ZQdRGa20+MYUqQJKEKCkrs/a9rbhpjeAPCkEpRlYjFB+g7OTjh8qqhKyOWcDcrXMXyYH7mhJx8bOeovMqhWrbiYbo4kfD9NGf1mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729467012; c=relaxed/simple;
	bh=QgLzRJNYG8eqYvh4YI+3mI7E+cm06pgI64gs6+UqdSc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=kTZE10F8MK2/DZaySv/PAy37+ZG2i4lY/ry+U/lSiNnaMFf4Vicwh1kUA9zIbZuCrAR9bb0baEA0TqDr0aPVpevp1bZhWebpzTIKSPEGy9IKuzPVzbro/ew1UItoNkii/5h9wA3eP0t3S6uPUFKDXbnBnKC7YnKeaSvvvYIctes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kdRR5lt8; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6p1EaKfWAV8esNwS5EqWtLBLe6zN5oVWvM/FSUMGwikzvVgeRGtvXFBl+SrRQXcvhCCSqzgkktB37ZPoj89k09W48npMHdvLwXcVeH9wqcLc2vIO0vDjlHT1O2bIYDUQNf0bps/VunqaGVYgptXCXQXLnj96jgSsM7s+gV+SeC3ozzKSgk6rIS80jRfAmoGtrA9z6mUko/t4uak2kl7KYPTTONF//PLbYPksTpMvxewfIUgV9kaU7Jgmy7NlK4lKNABcLgl2YaJVgzSDoIwzOeIWqLq4+08nfgNQqnPLYY0UOQkMC5Zs+meXfXuR5YSxTLEU5ocHtYIoVHGTH0zZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8kO3SNutLVQEUcMJYqYU9LyFDyxn/aRraupOuyUWpk=;
 b=xERVlJJoPhMxCkFQqOn5Wyu/gmOBPBRP9+jX0CcIQS01IuvpAfAwBep8dmFXM6qCnIHjf67UdaOUt6Vfl9fyNpXQduQ250lgbbD8dPPKMcOsTBZSaMjrKRgd3Kpe7KVeJJbLE5E9yOoZMYGttUEPIw6xaQbSVDyLyqJOAY9EwFNQox/SilhWevqYA7LzoMMwAI29ALLqPx2MCPllE9Svn4oLNFq/l0J0wL/xvnFgDjrXSxICX7UBrqZCiaezXD19XR2XUZ6XHR7vC4IQiY59Hvt/MMVn+YruJaMm+52OTFv6bIy0YkH4iqeDjK9ftgcfJn3xGffihnz8T1VIFg5/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8kO3SNutLVQEUcMJYqYU9LyFDyxn/aRraupOuyUWpk=;
 b=kdRR5lt8ANA/J64TvsLquYuaST/+g6YVjz0xlT9p3PUMem5QWFvhRgKgrgq+AOgCs90NstW8dEoIdt4uycQv/s6IY8pj+VJBbY0a7EeAXTb+Boif+Soz2ESFxqd+Js0U0STLdeCGxlkQuIE1YSlpJm3HccJnF7g/53SLlg3KNPorLne+WOk2mbSVdT7Lne/psHCN2FkFD4gX/cyloRSRXubShW7B7t3dnPzrSHVNddauh9uw0FJnaeHacWRrTkw1AtNkxDtyczKKxPQIooAn+GhApsY5h1WDadTsmCO+1pypJF2ml/c9975n2w452PJy6T74SNMxUBAU2Gnjtf0avg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Sun, 20 Oct
 2024 23:30:05 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8069.027; Sun, 20 Oct 2024
 23:30:05 +0000
References: <20241018223411.310331-1-jhubbard@nvidia.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, David Hildenbrand
 <david@redhat.com>, Shigeru Yoshida <syoshida@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v3] mm/gup: stop leaking pinned pages in low memory
 conditions
Date: Mon, 21 Oct 2024 10:26:45 +1100
In-reply-to: <20241018223411.310331-1-jhubbard@nvidia.com>
Message-ID: <87y12ibbew.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0119.ausprd01.prod.outlook.com
 (2603:10c6:10:1::35) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 243a2957-3857-48b5-547a-08dcf15f2062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QFPFnMaKwAJKXDLvzaI7cbq7GPi68PLEf6NNPWb99ytJQnKLPXFZm1KjCLK5?=
 =?us-ascii?Q?7HArobaF88RwWjCwDyJ7y7RXc1dShtwlwBSQuHK2ox93OcXsm+DQUwjB2CWo?=
 =?us-ascii?Q?4g7mJuQXIiVHDMSUSWGdrt9Va5Y4vAXGgoETc9vTKjSTpD162EugcQMrlesd?=
 =?us-ascii?Q?RJryKIJWE7m572mfv201pMQI2TbTxC7jEcYFPJeOIXJyXlvc2U+h+K0FklQG?=
 =?us-ascii?Q?uF5e0cpN3X0IBaUBj2hQAQpHV0QmsGjkqcSUEumBngrd3Ruz00e7n/FHRlU9?=
 =?us-ascii?Q?ImSMVb/WDzRmkupBrTQh4aYTD0r4Hcpha4CrKGKw0J3GGE0HlWR/n0alvGqp?=
 =?us-ascii?Q?8KJHsIdREjwMa5+g7Zx5C1Khh8PChK/YrKIubzJQXII1cuHB/vx3hl/idO+5?=
 =?us-ascii?Q?wRo9osedO1fhmzxQG1A3c0IPoP5pJXQP9IXJTKvMrj0EbFM2t/zOXvlewZja?=
 =?us-ascii?Q?GgKCZQKcke0qgSFB9sTzk77VrgjjM9uDnOFiPc7G5eTusqqtDBXxDHzuElJ7?=
 =?us-ascii?Q?ynbCjoe9hWi2wObjME97c802DKc+w5OcfQQ7/9+ntI7dal8/879SwCfV61dp?=
 =?us-ascii?Q?oqr8RH8my0kGi+pD7WBj1U9t8iaNc3O2C3w7Y0fpRGXQthbgmPxL2MRX581/?=
 =?us-ascii?Q?DYWhi7DxXpaJGGrFdYJhIrEnHy2mMvJ3p1qytyENuZoozRf0G/iK8B4FPeWl?=
 =?us-ascii?Q?fihJ0EEHIUNmuwMnHwqg1DJLdYeYj9UaEfEUqa0cSSh4+0ofUJkqmfqVB48J?=
 =?us-ascii?Q?twEgVGaycOsZmED7sRsYeKMGYKB4PiphpRgSbPBmk1PrenFrxx/6oUMKq2KS?=
 =?us-ascii?Q?3NU7aGv8jBk2Q54lV80TJEr2frZEfnM/lyGCmdTBmpUcRiag99+5zIX7B33A?=
 =?us-ascii?Q?Ck8Le+HR25OB9+3y0XkA6fzvNr42v//tZ5CwrnDlLdBvSKdrebxus25GjeJX?=
 =?us-ascii?Q?NoseN46fUhtVEbXCjVTd9PTFSYUv3EqMU1DoOBjP/KQE7l1fX984+xGCW1sf?=
 =?us-ascii?Q?TSxu79SqxxDc0bxUInHHA8ksKNU5rCGYcVFwNHkYxsXCAnPoFoWvQrxQbqfC?=
 =?us-ascii?Q?OP5A5F1NxWEM4qOuKHxuV3IaVDkWsiD4Lni/Sw/KFrn74A5/HWhFmIxSuckH?=
 =?us-ascii?Q?O7NYvxTLTROfo8KON3neEMKRTpFL7zE9vc7W2f0BWisLZVydvb0mz0lwcPWJ?=
 =?us-ascii?Q?lQPUxieCltscYLc6L6cTkF3Ya4KDMrVbrdeU/DBGMrigF4yuWtil/QD5l7O5?=
 =?us-ascii?Q?k6ld8a+d/ioIABkVNpFkDqZVOrRNJvW8qyQEySiOFBTJSQj5ky4XgUdDNvZt?=
 =?us-ascii?Q?BmlP3GlhMvFMO4QHFogOYwbZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gtm1QfGFs/xV7Jxw7wLp/7LtMrRgWUWHEobe0a9TX2GlaH7oITw8Ohs3oZ/s?=
 =?us-ascii?Q?ELnu620SF1a4lA16ijj5XGVclSo0c+C2dpt83gpcX5esqBV9cBybEFgF9Lm1?=
 =?us-ascii?Q?snUaRFXskQc09nO9lhiztwSPSAS62qiyCvf5ff1OIHx8z2uDgbJjffsWAAWp?=
 =?us-ascii?Q?B1Tf1yoSUFYE/gLt+jBVRuj/sqT4xWYirg5ILdIOZNGluQO0vRgWYmNPut09?=
 =?us-ascii?Q?KS8Ry3+M27pqW6Yy4Qc49AQoXxbwO3Ui0SyUtrZf9BNathDifnDHlwM72bTq?=
 =?us-ascii?Q?W2pJapSN88h2pKtkPvb545hBd76TjzUgZ3ZTbaDs2CRJmxXtUEQiRdkvD3me?=
 =?us-ascii?Q?aYtYJseD8tEEghDscbePjiH4Khzs9j6quuC9QYH62s7Gc3sD312ojl2lKYBA?=
 =?us-ascii?Q?PTw7Qc4DEb2nbGAXPikw+nfqXsA/ZP3xVLu418r+LsYtUUWsRNi9Thavrs2S?=
 =?us-ascii?Q?6VVl+ik17UxRQFIKAK2x+NDLu4lVRpXuWfEZllmb5Vq/iIGT0B870BIgcNc+?=
 =?us-ascii?Q?oRsMeYvRdI4CMfStqznMUQDH7+XSRp/Ft6EiYn4/hY3GpRDk+DH9944g+B3O?=
 =?us-ascii?Q?xr/9eoiUBEOXkPzSMsB3VgPcjLWRiHRwlwy+heqyPrX1po/AjOVW/CsTsLKY?=
 =?us-ascii?Q?a7r7xjU2QOdds0NLv9aQ65/lhGP16nFlYU8VOLTdS6NzV1My1VgVDZ2zXrcF?=
 =?us-ascii?Q?rftn07b2pZqcdQJYzT5NoudCE3gkCx8+v5mrMu+bAi3B2JsFSx4CJIrURWK1?=
 =?us-ascii?Q?Ct8FIlSFsw+e8gi0sE+zKv+UyXfuvTAaTfANpfDaounRwguqsmHRnSl9NUqE?=
 =?us-ascii?Q?nR50SYYjBZDVSSFqspcyMb7hCopkrA4p7XsFa7yzWO/MxrL7uU7wQTtX5A/i?=
 =?us-ascii?Q?rKFKV76ijN705DPtiHrP1HtxOgw+HfuJ6nMx0myIqut4fFxeQHEt6eh5u1Wh?=
 =?us-ascii?Q?FvSXFxsdfDNgyH/Sdil6praQ33P9uuW7ET7nQkT9Ir2ztl/S8PjLR2WCZEFz?=
 =?us-ascii?Q?w6dIHlabGiFxYxwtKrEnzxqw3nUsdcom1fcUw3q1nPsCl9CwITmK9La4iWun?=
 =?us-ascii?Q?xd9bPkGZ1UpRpNRMH/JAki/cno06VhPVlvAKYvpUwxev4Rnj/IYJUhGDAvH0?=
 =?us-ascii?Q?Hl1oz4axUsa8MytZM1XktKWSGDEeR4KiTLzY1C0pUMvnFxStTzK+slpi2n9t?=
 =?us-ascii?Q?8dWYwsObZ8qx4CBeGnuYv/Dm8ipmn/sIxOVKLBBBEgZhd1s1oNqgVjw7/BZY?=
 =?us-ascii?Q?7+gCxkonqmTCwm9uC15YIqFGtdlPgScWdkNULRtMuttU+gxOj2dmzMUrFD/u?=
 =?us-ascii?Q?temJUpmi6k8luUpCLYynCqxvr57lY3I/GFgUW9bbjLKr6UlpkRxngXrATFoj?=
 =?us-ascii?Q?H+b8d+7Uxt+h5poOSLJGyLtsqktA+ckzrUkDLBYpcQeXckWk1jU/vfwHLp4Q?=
 =?us-ascii?Q?hz1wOVgTWCXPdFCLPkG/3Z2N+EEPlkLZms6l8l5w6rRpf6F5O3SRzAy6M53q?=
 =?us-ascii?Q?QsNoQmTIxebHUPCe5rjSh0+5xD6az4N/mx+SJFmqQgyx1SunXlkVobh4Z2EZ?=
 =?us-ascii?Q?GFMiWwkGjx1ibWhjKdkoPCfU9oEs1x0MMR/N33hY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243a2957-3857-48b5-547a-08dcf15f2062
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 23:30:05.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Z0cskdwuRSHBXsVGm5CqJtHOhhCf0bk3CquOJnCkuSlvHuC2tyLwHgqFhpCoVhrmUg2Hyjue/Q2LerVoqrZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956


John Hubbard <jhubbard@nvidia.com> writes:

[...]

> diff --git a/mm/gup.c b/mm/gup.c
> index a82890b46a36..4637dab7b54f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2394,20 +2394,25 @@ static int migrate_longterm_unpinnable_folios(
>  }
>  
>  /*
> - * Check whether all folios are *allowed* to be pinned indefinitely (longterm).
> + * Check whether all folios are *allowed* to be pinned indefinitely (long term).
>   * Rather confusingly, all folios in the range are required to be pinned via
>   * FOLL_PIN, before calling this routine.
>   *
> - * If any folios in the range are not allowed to be pinned, then this routine
> - * will migrate those folios away, unpin all the folios in the range and return
> - * -EAGAIN. The caller should re-pin the entire range with FOLL_PIN and then
> - * call this routine again.
> + * Return values:
>   *
> - * If an error other than -EAGAIN occurs, this indicates a migration failure.
> - * The caller should give up, and propagate the error back up the call stack.
> - *
> - * If everything is OK and all folios in the range are allowed to be pinned,
> + * 0: if everything is OK and all folios in the range are allowed to be pinned,
>   * then this routine leaves all folios pinned and returns zero for success.
> + *
> + * -EAGAIN: if any folios in the range are not allowed to be pinned, then this
> + * routine will migrate those folios away, unpin all the folios in the range. If
> + * migration of the entire set of folios succeeds, then -EAGAIN is returned. The
> + * caller should re-pin the entire range with FOLL_PIN and then call this
> + * routine again.
> + *
> + * -ENOMEM, or any other -errno: if an error *other* than -EAGAIN occurs, this
> + * indicates a migration failure. The caller should give up, and propagate the
> + * error back up the call stack. The caller does not need to unpin any folios in
> + * that case, because this routine will do the unpinning.

Where does the unpinning happen in this case though? I can see it
happens for the specific case of failing allocation of the folio array
in check_and_migrate_movable_pages(), but what about for the other error
conditions?

>   */
>  static long check_and_migrate_movable_folios(unsigned long nr_folios,
>  					     struct folio **folios)
> @@ -2425,10 +2430,8 @@ static long check_and_migrate_movable_folios(unsigned long nr_folios,
>  }
>  
>  /*
> - * This routine just converts all the pages in the @pages array to folios and
> - * calls check_and_migrate_movable_folios() to do the heavy lifting.
> - *
> - * Please see the check_and_migrate_movable_folios() documentation for details.
> + * Return values and behavior are the same as those for
> + * check_and_migrate_movable_folios().
>   */
>  static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  					    struct page **pages)
> @@ -2437,8 +2440,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  	long i, ret;
>  
>  	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
> -	if (!folios)
> +	if (!folios) {
> +		unpin_user_pages(pages, nr_pages);

ie. Doesn't this unpinning need to happen in
check_and_migrate_movable_folios()?

>  		return -ENOMEM;
> +	}
>  
>  	for (i = 0; i < nr_pages; i++)
>  		folios[i] = page_folio(pages[i]);
>
> base-commit: b04ae0f45168973edb658ac2385045ac13c5aca7


