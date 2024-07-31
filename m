Return-Path: <linux-kernel+bounces-269247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAFE942FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8171F21C99
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1537F1B0106;
	Wed, 31 Jul 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pd8CATNM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D02209F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431374; cv=fail; b=TvAYcF3DHubGbNk5zicsToqaaFfQm4ckTqjOfVVH/qOU/1sb3eG4KzOt/M7xGE3FLnCo+raeDRwWDwHzWN4tqgH13v8vE9F1Y84Fn/217ld+1+RYNlFx5wcZt/Hw9V49vgKS90XnFhg0/W7cvEWIUBNmU3eNoyJKz7KYoiqdlGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431374; c=relaxed/simple;
	bh=x8occ2z9MuTsmFn9jMV04OOWqZO3MxoKN3M1cwb7mMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mrcSxjO7kqZ0olshk5wpXbP11+MS4yYVufFXTrqXqb/GRLHBxamE/PtBkgrIDLK/cSRVWqQ3w2Ji+c19Gc/BhsXdJMzrMRTWyQLOyKEs7WAd11O402LVsUEoA7TmXRe8CjM0Mg9teuA/hxJwMHYFjKazwVgzbzO+Z2fPGjtM8wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pd8CATNM; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUx6Ub3Yzio5+q9TeFJGGEP3X/g/QYPyG92YsVf8uGKhjGWwPBhm7uRNikCD4iDN6DtlMF6sGSUD/N7VcjNlm1ShCMQZ37FKlBWyDghwxXJhSvxoH+yJC2sLlM1mEN2nkq+53Tn2Azzsy0d9cbJxM/d2+ZJFHyqZIE/AacLJBzUHERzPKoPNyBBylrc6/k8evX3HbwwXyGHDLlq1RKa6DHkX6u9ESJpA5xk/JE752IONnTiQsJiLvgxB8JEAFzrsAYhbyK91RfEj2W2UG1zWT0eybE/CuYhd20UkeUgcyP5OkCX/AtIhGQA08k0PQgKsjgkVtzybfv1hPki6GGNSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHpse3wwr0JJHOAScOqqt5FGpmMYLOG3oKIiBCY5GXk=;
 b=hbbVcx3CWh9Ni6zif2t6ddeFM2Nu9FPFxoMnAqTdnQ/0/Hssga5iDNSAZg8S7rT6yO399BSFomV9nWyFfp1aI0tYu5VSPKneTreY4rat/I+cfc82hEoqY/24Wi6DaBV4l7KbiCB6k2EBrbQQHCj0NwKJZMunWAO8G62/GDAI6hiSfw6knatzddiSh/S9pioZTv/1fscD5b4ifbc3NAlSUPphPUAzu8tQTV5hYq9MpOxlnpfEXnW+0ayobxPzsBNCBB7lnQIj+4x7eJZ7nD18e+kRE+ND3tGVXuyN9oPZJ2wtPe1wVoSwkUnmsCkJ2oqpGqbDgL6xVakUAf0lwqS5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHpse3wwr0JJHOAScOqqt5FGpmMYLOG3oKIiBCY5GXk=;
 b=Pd8CATNMnlrTeslNp2UUr0b4iKBji0qZE27nBT8WBKhqqOme/I1naRFEoT3HwH6wJFTZbS8KmHn3Wv45WRLsfTFf3BAFcQkm3Z8L/scSg8abCx/Nnvc8ysjVivpIl/uuK1fua/DD3yoGy5K0I5yMM+jhdLahv4mtATO0vhQlXbzbhp/IWbtsjIjXz+MTTRWYbgTZSfvzruQaEXuUQQ7wFc54li3qmacJ+GWyId7g1aK9UNa4Rp3vkBc5FaII+vt29f5+EVgI8zeXHDo5Gejk1DGwO2RQaFlZCu8WYzGzvGp6/XNNsU0eMLiXlLLvlqphZ9GIOhJourbZ9Fg8GFdI6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 13:09:27 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:09:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, 21cnbao@gmail.com, ryan.roberts@arm.com, gshan@redhat.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
Date: Wed, 31 Jul 2024 09:09:24 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <2CE85059-2FB8-4DDA-8CFC-6ADEC55AFD45@nvidia.com>
In-Reply-To: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_81D74342-C21F-41CA-A10B-31F17C85D69A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH2PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:610:4c::39) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: e28159d7-409a-41f2-d2b3-08dcb162015f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YgSM9jIDiwPJTReoxAKjiCoSYjz6nbrnWpagOejxZsnLEh+VUTk7vtS/8irU?=
 =?us-ascii?Q?qD0fy9ZVv4Oq61H4BPZkmurGI05z7ZWyrVy13AYFIuna4nHIgwJizhgWYXdP?=
 =?us-ascii?Q?UygTZ+N+pAW9/5KwHFa3NqDeWYA0JOniIx+QK6/ASsnk926bXAXIWRBPd0lm?=
 =?us-ascii?Q?vFXVkRqjSQSDgbuNt/uyhks/vNeXuMBYN5hFJdweZed+3Sp80vSzjk6lCibd?=
 =?us-ascii?Q?tLhS+xJRaX9EVjVRDP54QQuzm8u6j3i1UHci8Z1V2BbyveJxiCgXEm77e0tZ?=
 =?us-ascii?Q?8YYok/MjRw+t9h1wlI3BZ/QgAaJrQZlMaQXOmA0/Glcrf/kUuOFw3EQ+1pnE?=
 =?us-ascii?Q?LE8Gp+lAR2xWKWwyHMSdYTmzPnN96VmcYFtVWp2zLhG1a7W5oATXVaQRTHv1?=
 =?us-ascii?Q?54UzcCqq/o3biXgSE8W+J3ZzlympUiF1Q7QiJZrRxkjW7IW0FJq7lHjcOWP+?=
 =?us-ascii?Q?I3W34PEAf+xTqW9VjBqmvknKUfhMJnqQHMMa4SJ6seMhGB4s4eN4YLPeF7Uh?=
 =?us-ascii?Q?lkH5dxgbIW/F6IguYnFBlXP0ZWTU7yVN6gzSONua+Mpk8k3V84zT8fZZDBHs?=
 =?us-ascii?Q?QKhdr5xw1tCoxwaAYmfjdtWik578DPdvA0xPcWDpdOI37XjeUzSTibQ9TXXJ?=
 =?us-ascii?Q?gmCbWAf43Fzmy5Zef+tqCIp24VIFDBa63VN/Ieocn5QP32pNfbl9eZ+KY+qc?=
 =?us-ascii?Q?MfzOtclzxeyF3gD2ObxDpGnqi3YqoqoazTQc/F4sIJrkK4k8A3fV2zQF9Ftl?=
 =?us-ascii?Q?sfk0FnE6aSNI10utiQyjuVeJ/Rb4UwSQObhOD5WMH2j8kfiyfdyAUWOlG1iM?=
 =?us-ascii?Q?Jca8UNXVklQHtVz4KhPHZCCQ5IwbApm1G768omyRSXVrNLZ+Tsdf7cDd4PN/?=
 =?us-ascii?Q?VU0SJFBPW+GsXY4G+haZg+ND3dYcShx6F08uHm+A3n9tFJexcNyxamGx+A7I?=
 =?us-ascii?Q?yuFpm4isgoohuY79FRn1xVdEHyfilCEYFvUJGgXPVUif0SZ/VNfk2+FnpyGJ?=
 =?us-ascii?Q?Xfdn0MUrAAJDdSDckXWBUUrzHrSpwosr5DxDG+kraq4+wbR+Sg8NwkVuewtI?=
 =?us-ascii?Q?sXoeXh4jtKmbyc+jiYg5i9eWdzR6l9iejayYxOeCNqxuSCpG5w/VrLJaBcbD?=
 =?us-ascii?Q?06o3YtXRXSXUVYcmC1NCL00p5iM6ei3zvPm/obaBxbtwb3NG/eJOzt+Z4HnT?=
 =?us-ascii?Q?nYHgDDKbQ5gP08EXWsiIZPm9e0o5xyQjb0JVmnIo41sn8wFduPkM4YT5bjwI?=
 =?us-ascii?Q?bEO3wQCrH3mgxjkKm8HY2h1dSLweTikA+vrE3YSndUkzECyQ1iagW6GgIL6O?=
 =?us-ascii?Q?SFYz8vD8eZ5ZGPKAK/qnqRELUYZB5ukrS/ysXT0b780gzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JRav9PLRk3WpamhicvGQH8fkajuqLT5ZkJle4g+rcDHxkdgoZXIduw1QjlfW?=
 =?us-ascii?Q?6jpjCmCv8Hi6XmIg8uLU6bmibwmB3YfAfboVtk+fH/sqg5RtimmmLqBCdymN?=
 =?us-ascii?Q?fECzKRpO8sQ7MCA/+MALp+g1hT/Iw60VQHxL7l6e31naAc+BGP1uas8NPLgM?=
 =?us-ascii?Q?m5JhGcBmJsAfS9LRYnbuEwk3n6ZYoW4y7i5t6dEahtySJNb+vTHsx73cSG5S?=
 =?us-ascii?Q?HTVQsn/PSL8CFfUnw4vCiCrEAYPEY9LB1NCQ03HvyX12imUkeftTWJhf9jLV?=
 =?us-ascii?Q?KU19k7bubh44dW7HcEoktbOVt6sq22UY7siMO2cYgxCZw5ZZtiKui4wHz2Wd?=
 =?us-ascii?Q?swqK9H7PN9ZSBJ9ZxtakDT3tyOXFTbjwip+ZX0/KLrB0yu6zKRoBiHuaFUrO?=
 =?us-ascii?Q?uObfkRM3cgngaYWEPgB5ImEQ7HEBKQMPyILsPkpGFevmqaVXWETUFUaiA/px?=
 =?us-ascii?Q?Kmx2ytpePmbcncZ+UyycEk6rCFNYmOFLraATTh+Y+FuFp4leyvvMe/ZFzTbR?=
 =?us-ascii?Q?fJYL47aI0iysIGhulixmmoKhyiioPPv+qvbTfd+YJGzLg2Z4kMzgxFSzm+Ee?=
 =?us-ascii?Q?2+ieRa3GxW8fVY2Iduo8vp9NWBZd1QRBsmyTZmxb6nK18VkXzjyCAwZDd+xW?=
 =?us-ascii?Q?eHJHxIc2yLidkeE7Hd6vMF0ZeFDL2P2Y5YVt2UmRBgdiJM1lIUfJms3aMgyL?=
 =?us-ascii?Q?/ChYiQzqGrmbolQuT/fRjJXC+qUKAZfrJzoYu9i7cFlFr75vBLoE0bHTE1zU?=
 =?us-ascii?Q?YAdsDkq71HyyEcnajgFCVzLiG2AILdvzCwEtPxtp2XkrtBLNPd04NbwQNEJc?=
 =?us-ascii?Q?+mFjgQuJA7MihkBLlBta4Ym8IIh/vi+akbkiubMnVFMFQ/NPu7Es5NBbWbZp?=
 =?us-ascii?Q?xiOzLAcuxal0PBb1/nbcUQPUu7myT/LRADDmxBs/DdhIZS9MLvxJmbY/N1E4?=
 =?us-ascii?Q?LOurKH+/pTW6ONTgMFe/j3LtSUC8+y6fMntLqw6oW1D1cIU5u+m2uRQpU2r9?=
 =?us-ascii?Q?dC45kMy7/siUE+RpNP5hFNvO8lbgFBPBRxRNdAlQWzR6lVFErRK5OIVy/zQ3?=
 =?us-ascii?Q?tBzH3pLqStiwGaWwWmRjSudcjcX/NAIr0BSpqH7mx4rvI7Xe292sKhUSOxGc?=
 =?us-ascii?Q?PCAIgt6OPCvwtfKBEYA3wU9/DKhc9soTCH6xDltrKyK4rrYsiMjeNQMgXlZj?=
 =?us-ascii?Q?C4eyna3n9IV+/E4dmPtdqNl5hMOQ8cLm1w1ECcrIn3fuXnsp2OhkxAJYOzGB?=
 =?us-ascii?Q?VKzyZy184TPeeHUeHAPuhl/c/3qVlrURMDOsbjiNLmzjP0Z4oPEdmuZE5c2w?=
 =?us-ascii?Q?L4qtVY+g79FHz7+BtsH9jLfp/xHyEfbEXaQPaAF9DVB/cs/jyDLzy65Tv2ac?=
 =?us-ascii?Q?A9qspD+kuxz+7O206cpveG0zZzikjRbBpmJ5mS61oiC40emeJxJyJD+m48Cc?=
 =?us-ascii?Q?VjmQFbq4g+inC7FlyGWYZ5QJXL5nopM1F7ZJJkTtgQD7Pp29mIl85fJok3J7?=
 =?us-ascii?Q?0zk/gC6GYUOOBklILpL5TG7S3fn0eo9rQ47ZicIHbQySIVE8p5Ica28Ic1FB?=
 =?us-ascii?Q?RM0TamCSOGLVMDXk4hvT4IYBqtKExBAqdXeh5UBs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28159d7-409a-41f2-d2b3-08dcb162015f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:09:26.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqPGdIAbrRFX4mbeUi1Oc5Lo1sqn8wp3QP7ivrxyzPFP9eUpZqfKE7TLxTXDM//8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

--=_MailMate_81D74342-C21F-41CA-A10B-31F17C85D69A_=
Content-Type: text/plain

On 31 Jul 2024, at 1:46, Baolin Wang wrote:

> Similar to commit d659b715e94ac ("mm/huge_memory: avoid PMD-size page cache
> if needed"), ARM64 can support 512MB PMD-sized THP when the base page size is
> 64KB, which is larger than the maximum supported page cache size MAX_PAGECACHE_ORDER.
> This is not expected. To fix this issue, use THP_ORDERS_ALL_FILE_DEFAULT for
> shmem to filter allowable huge orders.
>
> Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/shmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 2faa9daaf54b..a4332a97558c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1630,10 +1630,10 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
>  	unsigned long vm_flags = vma->vm_flags;
>  	/*
> -	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
> +	 * Check all the (large) orders below MAX_PAGECACHE_ORDER + 1 that
>  	 * are enabled for this vma.
>  	 */
> -	unsigned long orders = BIT(PMD_ORDER + 1) - 1;
> +	unsigned long orders = THP_ORDERS_ALL_FILE_DEFAULT;
>  	loff_t i_size;
>  	int order;

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

--=_MailMate_81D74342-C21F-41CA-A10B-31F17C85D69A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmaqN4QPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK/68QAI4bZHhdaj70vkXq5+MxnXoffpl7M9Vzebb3
3oMt5dcTPRbCJaLjWOxvNaWAfAJXjOA7wY+IjyedOfgnbYYT9/5PGQ3sqK2znNaw
rknXilp9690fInX/fLH7Bsc6PCjlVt83lisOA/v4UuPfkysBV7+/yqwk1mMuOg3P
gdQrkeuuhtBd5z4HbejLdZ1kJD0qV19LNv4/yB1c+uUmM1GwHixVXOPrwXnf4v+G
XyKHyOJaHwG0Vm8zUpsceiH+qPE+rY99qhfPxU03eJJrH+1mSN8qMeYe84GkvubU
X5Fu5EfCJ92g3sA2TNp/DubEFUPRUSbV1tahSQsDrHwELjVbLpRUn4p2/zBuMcKS
i9ig6Nmzi2/CuBaThXi7uCmug1y+zTT5Va+vixH02IbxAMWEhF6WV0AW+22gni6Y
sIqrI4I3ImtzhFn+Q8yvcbyPSKm4kSXwVpBLW+AO9jK+nnempBLDqhpG1B4LatuG
fYNt+vX4XrO0BIYGMGx9xtBWxi8CqKWHLBuqD+o6uvuTD6MOGHyyTbSoeJB0x4do
fKP+V6Q/kDYKx0WjVXeOhTV5UewG5JVFd6waftHtuXz9IFYoZ1oqr1rb3PSgsOoj
gkizjz/w0MuV+EHrJhcXheNr+GANCwEcFs/kQE3JlN6mqWlU2o3fzGl4ihk2zW63
ynkemE/2
=GBe3
-----END PGP SIGNATURE-----

--=_MailMate_81D74342-C21F-41CA-A10B-31F17C85D69A_=--

