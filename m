Return-Path: <linux-kernel+bounces-426303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27C69DF170
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823D2281597
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995419D884;
	Sat, 30 Nov 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dbkA4Lnr"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A33199E84
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732979609; cv=fail; b=pMDatVE7sWRH1bND+TwmTn4wppW7Q4dp1aYv5ntCzMQrVGjRJ0m7T7jhqqaYJaXXfxo9P5qDGMSOT/K008G3Ko1pzQBXC3ZAJL+irMjDehGfTIKfQQFNzuzAU5cSFuUQpJI4d5K1xrcMtHVXbAkR656jtzL1AW6RMDhMx9r5o6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732979609; c=relaxed/simple;
	bh=XNSz2ovXsYpLVAB8AzEi25lZn+x+qO1Wsm23sqN9JQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LCcuDGnl2NVjx7WGMt06hVSU8oiR1nx3coyCL0uGTnsav319J+fZjuSBxf729OGmwiwYqWr7mF26xr3xZORc04hOfESsyFCe7LVDWLjveofC2iIBZrGMAkXAdIaCdYpYF+arZplElSNDeLjsop2O8hYquuRFdAo2fyGsIlX1KI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dbkA4Lnr; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzFcwqRHIUqp1hlPgB/JqP5vaoZNMA6XdNxRZxiv9IIVGGy1wIMf8eV2z8wdicTPVlkgZGkVJuf12To9cjadozt+eFItCixqQ64l1uw2HgkutQQfR7nb0XIrReoPTpWTns51yM3Br42nR9o4UgDEmuSIVm1uzZ5mJJfZNaLuyEYPVRfSwzcmEExTEZU6vFsnC1R+E6kML/ByHI38OqwQK1lmTgen7AwZuiXaG1nGEiz3ftZGVmHsWQubogNWiFlBEYsZkanmcO+pLlcHE+3V+8aN4UKEmXCcEB6V/F7PlIOsj19WDYYpOH1fkQ5fjRzOpZVG49jMtth/vSXwr4NW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlmoBjiv+HhpY0Q17KxpzPzWW5fkUgSrJaQz/qXMb5k=;
 b=n6fHzQXSskASYV7mTt39xnaQBu3/uOZ4MHPv7ew7P0hUOIvBTSfKZ7Vsnv3qU7CN23XXAh3KHNfef2rv6G9FUiQucLsWkZmnDMJmIBNGvAn82fDVvxMcTst95Xx9TxK++IZUXqM4OEtz1bUvk/VenfNwQ57LloF7XdzF6pf054bgVQSk7G1TUzYhDMPjllHKIHQ9idc5afKRb9lxNc39x5DdGddmFS0/8TiH6441yR+Z7YJ2w7VQ3GLkJO5g/5T3piymRJoBbt6dhbQ6dPZOtTBNbgFzBoULlFbmzWFOp42F87Y+YG0NTbQJCh5qNZECG/K3vnVkrZVSJtUCwTA3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlmoBjiv+HhpY0Q17KxpzPzWW5fkUgSrJaQz/qXMb5k=;
 b=dbkA4LnryZU6nhygkCRQdKBKVytili/dv1QYNVFB3jWWlCmlzbVdTjMv5CovGBN/1uyC15o1J5/0f6bssuo6oDYJmTkmS7jy5v/tJVOZbyTPYmrNN6D4RuMyp1GqE91fnIiLcsMbTCtywAduiBi/MrVpAP6DmIdtKKqiiqoW5/Yz2Ts63DHsIz6z1JSr1eSj66EjMbiZoPjvxTHqFFe3lPSOhIEhq+vjib0x8xc26GsV8PAyrn8ksWazUlAJiBVVBTR79pHhb2kpRlxkSGL64O9biM9sh93S9VkqQ1/aPvstTi7SbpWWnFFrmhzSzJRZ2Sg09tB/IXgeH06YwMW6QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.15; Sat, 30 Nov 2024 15:13:24 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 15:13:23 +0000
Date: Sat, 30 Nov 2024 16:13:20 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nodemask: Introduce
 for_each_node_mask_wrap/for_each_node_state_wrap()
Message-ID: <Z0srkJcbnGFTx4Fc@gpd3>
References: <20241129181230.69213-1-arighi@nvidia.com>
 <20241129181230.69213-2-arighi@nvidia.com>
 <Z0oVqfrfsMjmvdZX@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0oVqfrfsMjmvdZX@yury-ThinkPad>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 8526061e-5735-4c4e-eb40-08dd11518868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xcLu540lfRMRmpvnycXqZihTUsyeh3H49wJsHT5+VHiVkON+7o0EBn144CZD?=
 =?us-ascii?Q?TFS7T7tLbX6pCePc/FHxlqtGBqfVsi3IupF+/9lmWUw2PvmQbKHB2sf9YMkV?=
 =?us-ascii?Q?ecQmR6GDanCtdZ7CTiysjS8X0zNGKCmHKpU3hvc+EBqhyYi/qJrQdGM6pqSK?=
 =?us-ascii?Q?s94qfGEUZgrHdUTTN1oS5ogleVyluewxTT6Si1Sv7puHESsNTLt8DV6APyRq?=
 =?us-ascii?Q?70DlwpEbo8WEmHMdMcPRV3ntnlEPDCiEx2F/sWtFlx9RwG4Z/2t2j1Fz8VVq?=
 =?us-ascii?Q?n7qUf/zv+6FB9EOGWJbFQ7NhD8yaS4KrqNpLWyjnSaVD93JtfYT2NCtfIEIh?=
 =?us-ascii?Q?suvzw5eMarud+g5Q83TbiT062zWiNqY+u25JPKr0JEPz2HUZ0ow97e18c1xK?=
 =?us-ascii?Q?2Nn5W8FLh8f2JPiXpjya1t4ZKWB0ymfAZ/pjVGx5Af9mp7EsBb/Fyk1wwKza?=
 =?us-ascii?Q?xetD7m4ExtOfRjStdSrazvQwQsuHaOVFqkEvoq5voh64+aTxAwIa8/zIM1kk?=
 =?us-ascii?Q?3kgvAiCz/yEokmFFoZ/tlWbeawQDTGnR2SdDr+dUtv39116XdaC7k02v5Ywo?=
 =?us-ascii?Q?dkW9eWWTqpPnPBEwSCWEiM9JQSFwR8iucO/a2H706c7taG3Xc/eR38e5NW0E?=
 =?us-ascii?Q?KGCB2VUDYvWtcbmAVfefkaiVtZKjbliy7uTHLCttdrq9aGegelo1Q0tzI98f?=
 =?us-ascii?Q?0HSNYyTA+fpqOBNt2GSa9sOjFZUXIRxlMLAbV2ytsRZxosCrLRjxfNKGPJ4K?=
 =?us-ascii?Q?MhSy1PHsiqI9HC0+uCOqOXKLiY+AjPpIN18c7grCFJw4/UUejUAfk9ihT43U?=
 =?us-ascii?Q?xagu67QPpb3GMZDTBq1GPae1fCir+g3AATAR/KOjYOi2ckn7ECK+35Mqw0RF?=
 =?us-ascii?Q?a66+llvBasf4VEGyp/d1ajdLQcXKM/8g5TBxNQVMBz5H6XcdjMoPcZt1ekd3?=
 =?us-ascii?Q?kyIIEDOeccNumtD0mERoEBrVIMh3csw79Wz5xS8Vc5fKaphGJ6oOKJVX2qxm?=
 =?us-ascii?Q?IGKpAJCJpFmLKg4TqXleubQq3daCwd/youa9K6YuJrPOfCaucbsbD/iXr9qf?=
 =?us-ascii?Q?UB1DWlm1mEzqFYkZ7ByYx5YwnwYy4KfcyZrM32+mPzXLn7Kt/DgG5FMHU1Vo?=
 =?us-ascii?Q?7PV1+L5A60Wc8VJoiAXxBCffJW6iTG2pruGRXeKvjezQJuFwAYj2u6tr3jbn?=
 =?us-ascii?Q?E+Afihd60pLAXRxm18j+PhfA+/bYK7AxkGrreqBcqC0HhHExN/Q8XEq+Iyko?=
 =?us-ascii?Q?dSogqzPJlfkjOqNK3OPiKhv73U2G72YjoNJfUrDykM+LPZEUOreGceX/OHLo?=
 =?us-ascii?Q?qVPSuZlp6KZEhb9lK7X4ZQkzqvwcJeSHZYF0quKbLS6HKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eowEIT6RWP//4gq77T4Yd5aqPMiFZet4o/PWu6aCckHSSIF2QmzfLHfRIYAB?=
 =?us-ascii?Q?FreVdkYLORTQiHOq3+/4vjANcNpP1jqb8xxtkN6iTKaUtLiDGezVFCWJC2aB?=
 =?us-ascii?Q?eS6Rx+WwvA4bxRGep4g7WcT1qnPr3ISuwwC+mOHOBPVlP43d3PxKrT1MEOq5?=
 =?us-ascii?Q?T5yKah3VBtmFtYoUgg9rkUlRataM/N7IgOMtSsv7psMjhHrploi8cAqUwtWh?=
 =?us-ascii?Q?1PRzySBE1cp+yRJFvnt2AnWzSdmsGgo1t0Rj5/z+5oBtw+CJ+BahFVF0qgyf?=
 =?us-ascii?Q?rTxGDp87sMyGIrtOnpl6bm9PJKOFLy6VC4WWMXBck7wwbyyISxf1VcOBIBxV?=
 =?us-ascii?Q?lRLTSiYpCfPwuttFUUj9GSl+VTlnb/9RhnlWrVu5HwB1AaWjBtnlLZwmohBg?=
 =?us-ascii?Q?ZmaKyc/4Ydv5yO0WGJDCl/0C3CXlUh/V6iLoLe3KkIGqrV4x/YuO9UBB1R34?=
 =?us-ascii?Q?DQODMUGdsuNF2k4orltWmfnxoiE66c5V0VX1HCxd0qVV4II3+vtoGZ3A2S9o?=
 =?us-ascii?Q?cJ4NtfK88stqA90gKFyArVQFpfqa1KcD+R6xRzmaxF2+APE8c5eZuhCtv94u?=
 =?us-ascii?Q?K7AU/6jYk7+cNCb+PiYoJG46vnhvvWc5SEqs0vq41aKsn+9Y5kpLj8OHJtnh?=
 =?us-ascii?Q?yi3XB/wxwNspOt8+gvYOkhF/TlG+X+cj+eXq6nif1SoUNIwd0EzV/d8YUz66?=
 =?us-ascii?Q?nZGvelI1hP6TFHhia7WN6Tl8qYgCwmJkwt6OUCgv2Dls+D0IO2tc/JWPjk5D?=
 =?us-ascii?Q?mmC1VECGfVHpVhFGvDeyi4g41FNIpEIweTFYxSUa2LLFvj4cqM/3uDlMAYVa?=
 =?us-ascii?Q?Q696h2h/DQ+QKEs8o4d1R51CPIgJ2ySxji/Z5J5eLvxFQBj9F6j8KLL74pQY?=
 =?us-ascii?Q?Uqq2z+JXjr/bapSd1KL05CN68M8E9CHbphSmuFU7l7H961FC7sJq8BquVh4n?=
 =?us-ascii?Q?ndCAm7gr6UT+t8dzCosmsPMToHcGZERCY9iIA3u4mnhrJbsAn0hB8e8/ytkO?=
 =?us-ascii?Q?ryKYJsqVE/ue/xDNxsRbrXqFiG0Fs8PxR1d9OcNJ0dAdNsGQg2Jmpk64YoLG?=
 =?us-ascii?Q?9DOrmVZAGz2Aj34ASSakfjoFaTygjJLpCak31ykP0222thbawjLx82gsp5w6?=
 =?us-ascii?Q?8jcFKM7L+qPfSmqG4+bYpmHpioc9IkSsWwV+poYXvcG+Wr9Z/LyiEGCajDqE?=
 =?us-ascii?Q?OBUzWV3ZVF0qPnwXCqLiymhABJf6EBJaVYexrbO8nsZyHnFKyOc2PuX1X83W?=
 =?us-ascii?Q?HNuI8hf8eqzvqw4oIDxbLmOXNWCnMeAV47v93G3RUSBgrFbW3gGK1UigSB2v?=
 =?us-ascii?Q?wDZHWWc/AQQ8EL3g4Hw6+JZk+Al0dasrtzyFc2z0gpvQY+AiJgw5ao4QEEmz?=
 =?us-ascii?Q?Fqja+FqmnNiqcuSnxGGW6LdOQoK3z2kAuwBuuJdQIB+ufGcTe8sQ4RDRJ7SY?=
 =?us-ascii?Q?UtcsamWiZlmrIJcLUbDswp+ml1ZGjkrZK2wpkzeL1d+p4F8iN9r2hpTTaG9n?=
 =?us-ascii?Q?LdJY5u3N7EeISILD+Sqm57wxX4jpCnvC8xf2lHYP9Ky6C4QBNk9C8WWh0yKa?=
 =?us-ascii?Q?Pig1hL0xgdIBSfAJkGQkxTWmTQnpzzd3cGu24LM6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8526061e-5735-4c4e-eb40-08dd11518868
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:13:23.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4cA0ny+QKUhv1LcgaYbFjx5vR3/MYHlnfdO2XEJ5fiIcA9NfBf/AgYVuouO+32TcapPI1FUddcSJ+5SB9X6sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288

On Fri, Nov 29, 2024 at 11:27:37AM -0800, Yury Norov wrote:
> On Fri, Nov 29, 2024 at 06:54:31PM +0100, Andrea Righi wrote:
> > Introduce NUMA node iterators to support circular iteration, starting
> > from a specified node.
> >
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  include/linux/nodemask.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> > index b61438313a73..c99cea40dfac 100644
> > --- a/include/linux/nodemask.h
> > +++ b/include/linux/nodemask.h
> > @@ -392,6 +392,16 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
> >       for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
> >  #endif /* MAX_NUMNODES */
> >
> > +#if MAX_NUMNODES > 1
> > +#define for_each_node_mask_wrap(node, nodemask, start)                       \
> > +     for_each_set_bit_wrap((node), (nodemask)->bits, MAX_NUMNODES, (start))
> > +#else /* MAX_NUMNODES == 1 */
> > +#define for_each_node_mask_wrap(node, mask, start)                   \
> 
> There's a very well made historical mess of how nodemasks are
> implemented. Contrary to bitmaps and cpumasks, we pass nodemasks by
> value, not by pointer. For example, try_to_free_low() in mm/hugetlb.c
> takes a pointer, but has to 'dereference' it before passing to
> for_each_node_mask():
> 
>   static void try_to_free_low(struct hstate *h, unsigned long count,
>                                                   nodemask_t *nodes_allowed)
>   {
>         for_each_node_mask(i, *nodes_allowed) {
>                 ...
>         }
>   }
> 
> That's because all nodemask functions takes an address from a variable
> provided. For example the below nodes_empty() is implemented like:
> 
>   #define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
>   static __always_inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
>   {
>           return bitmap_empty(srcp->bits, nbits);
>   }
> 
> It means that your 'MAX_NUMNODES > 1' version doesn't match the
> existing for_each_node_mask(), i.e. doesn't pass a nodemask by value.
> The opencoded 'MAX_NUMNODES == 1' version does, although.

Thanks for the detailed clarification! I'll change
for_each_node_mask_wrap() to pass the nodemask by value.

> 
> > +     for ((node) = 0;                                                \
> > +          (node) < 1 && !nodes_empty(mask);                          \
> > +          (node)++, (void)(start), (void)(cnt))
> 
> This cnt is a leftover from v1, I guess.

Indeed! Thanks for noticing it (my bad for not testing the build with
CONFIG_NUMA off), will fix this.

> 
> > +#endif /* MAX_NUMNODES */
> > +
> >  /*
> >   * Bitmasks that are kept for all the nodes.
> >   */
> > @@ -441,6 +451,9 @@ static inline int num_node_state(enum node_states state)
> >  #define for_each_node_state(__node, __state) \
> >       for_each_node_mask((__node), node_states[__state])
> >
> > +#define for_each_node_state_wrap(__node, __state, __start) \
> > +     for_each_node_mask_wrap((__node), &node_states[__state], __start)
> 
> Can you also add for_each_online_node_wrap() to align with the
> existing for_each_online_node()?

Ok.

> 
> > +
> >  #define first_online_node    first_node(node_states[N_ONLINE])
> >  #define first_memory_node    first_node(node_states[N_MEMORY])
> >  static inline unsigned int next_online_node(int nid)
> > --
> > 2.47.1

Thanks,
-Andrea

