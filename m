Return-Path: <linux-kernel+bounces-278927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B3994B6B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB8B284266
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCBC186E5F;
	Thu,  8 Aug 2024 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZrXA6FCh"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEB186E51
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098501; cv=fail; b=acZPEdtf/iUBwG/IQ6BGMxQPtwr/sfLQ/iB0i9nD8cxuST3csfS+Adlsq+ovRcLBkC760z32bAGC9bgPzUWKaj8yVJm15aVLXAo6JDqY/s09e1Ms8TFVr6ukxOuU/ebL3DHNTX0rcdP7Bfmvn4bQNUJ7IhZVRGpzPZbqsbgn2mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098501; c=relaxed/simple;
	bh=kR/ahMFxNzUPi2vGEleP8hY1tPBGzPgbhxKlxkZYBdE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=PfMjJJ96vrepA5H/Zk04nnSwuc9W1YsjitIihltTpHpla1IsblSrfiYtTaCdwVi8i9ABJ7zjU5Uh+MuZBEui5rRjKm5gtW89CwqbJpGtbbfo0lndhTc1aPvKJ82sKgE3+tdhdg93pxDPllrZ9h2tnOwk/+bHcbhrNWtOKB3m0xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZrXA6FCh; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiMXbOScBQcrO9w5RZY3H9mH+oBA/9w1VVWhvJS5siRjQu1lZwONN7TfwwUz++JsfJy2qkMMh/97ZoqGC9fknAl5DxQC35WnSoigxUwG0wsj8bXiJrVe6fcaCXoRjo907tpkNxZz3qrlP1Jo6Zilx9EnqFqIJc+9U6uaTScSZhjPyVf9zIoo+R3F9KKyp7gL0rlsf1JTU71hZP+yga0GXiOSJJpQ8UyLGfXFBaXYEb4ceV3bogNSByRb/V5f5Si0PZIf6pmLUHEamBumq582QEn8ZssWs1Ah30DW4EbvQx9SmxplII11vDx5qLBq8VzUs46i+M/hW550kSkixs1sAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsvI3JLKcvrIwEWoUlDjvm/a1fn8JHIcP0Q6Sxt8TaA=;
 b=j2HbBcHhHr/Z9dwcx6sDYXmKC6SXVN3IC22Tcga42RYQnddbpuMH3Igzg+XZNu8znUbOyWlPrmhxjYtp6YIbpuKZwYxV3DunyWJ92aSAL/GOV1D8XSNEOn6pmNrL2dSczYTdzR85u6GNRRb5Y70eiweYp6EI/VI/2ZHnGdAP+YQ6EEwPP33FmWq5bF6adkBpFO4zOh/dkA6Xmfxgx3cfoomf22kMXSgPWnR00Enw+9QpoG+Jq2BUuKe27LnTWCb9DTiR1ntGlOYllT+Yp6xzdW0MN7Hv/mx5+rZdmFhpCdYff3Nx1rWGkhjJnm5BwftrKlAQeflhLlwgYQHDq92QTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsvI3JLKcvrIwEWoUlDjvm/a1fn8JHIcP0Q6Sxt8TaA=;
 b=ZrXA6FCh95nY5g6TZWPxL3dbBK3PNL5bZ6YjVVaGnukRH+41200MD99vfgwcwThAuxSwXzcZtiEvisK/p3FnmD5nI4bsmvh//adjlj8J78rRf2/D5y7TOZfxWqwdA2RVbNYD+bENHCaHLrctwGFWTjalWqGKhqRN3+FQGJ3CGukfOm4skMxv8JjNNOT5cfZ1O6iGefBrQvIE5K8r4qaXyhL/8VTfiIvOBYbvvbvdqRLXEDX2zkQbICwJLQ8lgK6AusO+4Q1ocqO6I7v8eEVgbt20YWi+1onRp8+sgmlwo4ig4BsAZAas9hapzCzFfevNj244h0Ce6aN9U4wQKkaCuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 06:28:17 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 06:28:17 +0000
References: <20230810100011.14552-1-max8rr8@gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Max Ramanouski <max8rr8@gmail.com>, x86@kernel.org
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 linux-kernel@vger.kernel.org, jniethe@nvidia.com, jhubbard@nvidia.com,
 linux-mm@kvack.org, tglx@linutronix.de
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Date: Thu, 08 Aug 2024 16:12:49 +1000
In-reply-to: <20230810100011.14552-1-max8rr8@gmail.com>
Message-ID: <87wmkr4jgj.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0050.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: b195d8cb-8f69-4fc1-1945-08dcb7734a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5b4ERmuU7O5apWmROoXFeMZ2XOHcFH8XCeKsk8u+5HZThCjDgRjzWVriPVjf?=
 =?us-ascii?Q?8UV66szhSjlw0BkDeEi4HjgBLFgr7geT8/40NEWnvyq32Aw/ogBAuTU8zQoc?=
 =?us-ascii?Q?cQVM8DDxFDmpfngjdr/b9gmbMvaBlqY+g4Nsfy0CqJ1YkCDkdpovyFNnnWVU?=
 =?us-ascii?Q?FJ0JVEHLD1cB4X5mDPukiI3pY8bPtd2la2ezb5bR7RD73B48UAWSj4cB93tO?=
 =?us-ascii?Q?GpGjcIA1ZDm9W4VBx/Yh09fBVgZT2Mw5Txm7KoRTaFKqu/xgZugOYpY4qbWU?=
 =?us-ascii?Q?UIdh8i8MfrwTD7CaicIX7YbswmhSViO/jnB59ZyEy39iqx7OOI/tvCd70PvK?=
 =?us-ascii?Q?YIO9fuKE5WxhHUbQWTqkDcrZWW7WyFmczvTjAlJ+iyR/VDSAJ26f2ZcaMNff?=
 =?us-ascii?Q?DecM3GixW8jvIxd58sU6wIUbcN5xhW7GPbA64tKljmi4KxyNKC7T/YU8Pvm5?=
 =?us-ascii?Q?/atgmJaQ7ULgnsu8Atw+Q7WGqq3Fe/uXwbB7Pc5wXkp8VSrgf1Gt6dvjdFms?=
 =?us-ascii?Q?RCErbi/aLblkYMypjMah6qEMDDQiWMzn03KuuksqzR8URUsgTzILJHI3TvOd?=
 =?us-ascii?Q?zkRhZUi9eiRdmt1CPhALgSYetCruAwBAfVKViDNBHjyCptNMU+A/U+SZi0DU?=
 =?us-ascii?Q?EsaPFZ0kzcHWorW5yYMgcdGx0Eaq4TzFsA7f3oYQ43XwgBV0e/LbSAxdguoP?=
 =?us-ascii?Q?DQMb7U9HxP33vsMuznTs6Iro22iGCuqxAc+y1yUPe04v82dLIp9KvhJFy5xQ?=
 =?us-ascii?Q?KpA2VmC1EQyj1NRECblzzf+o4rF5qEtgE3beCd5YOE4CaHZzq82gATWHK0Rv?=
 =?us-ascii?Q?HSiW3JAwAhMewN1bmo7xcJx5t6BzHa/V+vbz3Yl9PBJV12qmcYM2R5CD2e7w?=
 =?us-ascii?Q?qPbWAQTtO063oLOMCttPnH7K9+dLN8xy0llFRFuhbKhvlUoXZyKrJsRFpbTz?=
 =?us-ascii?Q?EmnQHfOZf84GTPFZdQn+7ps6eCgkn2Fayib1Tbk4W6wIdiwjbRC1KJWRhE36?=
 =?us-ascii?Q?uA0oZZsQn5TikgOKTA2DrSftn/Ij46zterWlSsGTpCOuDOup1aUitb9SkV5i?=
 =?us-ascii?Q?Mw4Y9nWBQ4JJRXOW1KP1p4Dp7MDy3iDN2f3jLIimOXth4hKbZ9oEMpTCus1k?=
 =?us-ascii?Q?0v071w7Ska2D+6siWIbxBbLGU4EjfWrrNio0EVoQsZ2DZPR+jeFwMZW3yVnR?=
 =?us-ascii?Q?219o2svx/ALbtkhg04R9NaXmMn0g+md7Rds0DbLFXEr+1jkkdAdzY2+45z8P?=
 =?us-ascii?Q?vEwOSVFAX/DxHd1bt6ExJXV/LgmnmPTWAZZtPk9Cw9ls7SZruP09EcWXXDDH?=
 =?us-ascii?Q?+RCa6QNrUzvJwyDhBAArJum53c8jHX+z+h1LXiCLX0/UyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ShM4+DAz0MjYiZN0gBDAVbMJTE9hS/HP3BMRleZILGy5pYn/J3i971CtZtJ?=
 =?us-ascii?Q?qr8r+jWCXkPuWvd5rluLYO9F5mZU2aMEQX5PBky6oMnEpwRcz2i+OaWsC3oQ?=
 =?us-ascii?Q?kR9dr1K1seDmmsy6Gwa4PIgkGhk4HawlJ4/2QtmmxI63YpqbnBdxvbWsFTpD?=
 =?us-ascii?Q?CnBREg0c5pMFj52JugLnff2IVh+rJmOCTA62VINK4WAOlUmOaASPdxC4yBQK?=
 =?us-ascii?Q?5urdgT6Q1gXuW46HXeTVIyEnLgyv6hz3bADyTvSQnlq3E8GejGUZQCV7SM1n?=
 =?us-ascii?Q?E+fCsWDVIEcVTtKHQ0voQTYeVW4U9In5pSmdRHkPHmv0hMofVovqV188OfDk?=
 =?us-ascii?Q?ICEYdl5yqK8/OkeK36DZiXgqIBZrVTkoJ4gdqLU32iU+IBHi8o6nVtrVYzAy?=
 =?us-ascii?Q?ZaMX5/W8K13+DwddjfrsIUGWdnDbeUZmnUVNXjyjEDDYv1ScNjlac/HPK/1C?=
 =?us-ascii?Q?gFZlvoyCC06FZZzm5scPfuLca3fElAvM4fLKAM0xexp0JghIZGbxMqiPQSNP?=
 =?us-ascii?Q?xuJQZrddBx+Be9XENFbrUGOgcOz+LXSd2/3Y1JvvCyblh0+9Ofj7QUH5f7Kl?=
 =?us-ascii?Q?Im6jAnkcrExw09KZ4fNTjH3kXhyYznJUodEh8pDWHsfIWnA7zyqPrip4Nln0?=
 =?us-ascii?Q?C52ep1BvMRfg/xGMYnye+iE/5ysOfkB/FwF/BcqGzR+oZHXBrSBOIK7K6VSy?=
 =?us-ascii?Q?ONaIT+045rIyVagrZLpEgKTyHukQrYvndoLP+MO2lsywc6h8jn4G37wQ+bfg?=
 =?us-ascii?Q?CY05JEqcbyUaaC2Aagk0l15wK7V/UVG42MurDdR22+C++IDwGKQVt69/iyaW?=
 =?us-ascii?Q?FmINfqrp9/QQtIZFZE8vQTQeQK5jD+EtM86ntRcGcoIMusHcddy5F8BvkEAx?=
 =?us-ascii?Q?7wg4Ho8qvSJ2HdRjhKojBrX8KMlb5ro4lG7q/V8LvgB2HXxFijQ5a9iE7oE1?=
 =?us-ascii?Q?ZyGU7TZ0HIu7PEbzwgA2Iw/H2+e5JO7g8WIb2rJeXLNZM2SkiRtgBobY0QBF?=
 =?us-ascii?Q?HVR02VfLyiRKlVUckuQUGA5jt6/dSw7puSJQpsJAeRX9ASPFinhK6Y+0n+x3?=
 =?us-ascii?Q?YZzpRQw6TqJLOeg5Rk+BSTyqHUgdlMVnDB/AWIpenuJlAz5JAdm7kxlLb6qQ?=
 =?us-ascii?Q?u3HSBYiIb+Q3wC+qcG2jwat74hC2eIcU06YJMwZnIKSFHRQP/RBm4QG+GU+s?=
 =?us-ascii?Q?61waRlxIHHLXbT5XHi8r70SUHzsNkJmbBJCoQFEFhsfZWaarcdu1fLWKUqig?=
 =?us-ascii?Q?+Vcl59zFLJFbS+MENWml2UEroSXNxpZkJ1RcmXuzP8wF1iDVyHnUIrsUUQC+?=
 =?us-ascii?Q?qyVwaqMj4VNhOkTeoZK0qexqqk5r0UsPlqlYnsJLJYO/qPDK+mblM0NYNhiu?=
 =?us-ascii?Q?3bSBox/xutCq7fXvxDnfeyGb8leyqrYHvd/Yo+BQwHiOTM1WY1IS1MXEBHlJ?=
 =?us-ascii?Q?XU7EyEXHLTa6wm0BIajK0W3KZ9PZsTs81pUMMok7/xfnToBKNhaA+AvbQHV9?=
 =?us-ascii?Q?/ts1W8Ce8QfJXvVOTlqLaN/SAOmSDKDNkx+aqz8t0nmcLiBkLXWr76Vhz2hS?=
 =?us-ascii?Q?qANZycxgPR+mfefQ1HHPJi9RO13mIsALGRDpi5w8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b195d8cb-8f69-4fc1-1945-08dcb7734a28
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:28:17.4347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+cq+Qwmc5Dh2/ZGDhO1S7bvoDtE/mlAizmTG6HehJ49Gy3GvOjCwrM2atSbMuhf/Dog85UPjIQLzrvchxiacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081


Max Ramanouski <max8rr8@gmail.com> writes:

> On systems that use HMM (most notably amdgpu driver)
> high_memory can jump over VMALLOC_START. That causes
> some iounmap to exit early. This in addition to leaking,
> causes problems with rebinding devices to vfio_pci from
> other drivers with error of conflicting memtypes,
> as they aren't freed in iounmap.

This can also manifest in more subtle ways because the conflict does not
always result in an error. Sometimes for example it can cause ioremap_uc()
to actually return WC mappings if for example the early iounmap exit
leaves a WC mapping behind. This is because is_new_memtype_allowed()
returns true in most cases.

> Replace comparison against high_memory with is_vmalloc_addr to
> fix the issue and make x86 iounmap implementation more similar
> to generic one, it also uses is_vmalloc_addr to validate pointer.

This seems correct to me, but I'm not an expert in the x86 memory
map. However it does fix the issue we observed that lead us to finding
this fix, and it doesn't seem to introduce any other obvious problems so
please add:

Tested-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
> ---
>  arch/x86/mm/ioremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index aa7d27932..0b596a1d2 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -457,7 +457,7 @@ void iounmap(volatile void __iomem *addr)
>  {
>  	struct vm_struct *p, *o;
>  
> -	if ((void __force *)addr <= high_memory)
> +	if (!is_vmalloc_addr((void __force *)addr))
>  		return;
>  
>  	/*


