Return-Path: <linux-kernel+bounces-376436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426DC9AB187
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6187C1C2139E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB81A257A;
	Tue, 22 Oct 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pA23cVOI"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A119D8B4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608961; cv=fail; b=HlHor64Oh2hfmmEuLUUW2mqJ5Yp28+/1VCrUZ14iJxZNLu43vDWkYFwuj4PEpB1I9ouyLm7sSEnOAEORFslr9BvS6epR9xcr1hh8scmPhUL0MaSLhH/OQhqBERwjmtryjwarU2+MRuPTZewwvLWwIjhJE+4wWYNg3LZsrjUDptA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608961; c=relaxed/simple;
	bh=ySBmSSAvV1+qg80KKkbbu2EM1D699QiY0TwfbzODdkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pT9bp4jChm7Xf0+9fpdk2BNGiWZrGLxN4t46gUopsunsZjy6f/25C/61/Qenf1FC5uflYxBxVMOIVR5N0l+qfuHulDKozrmtIv1aIKsluABoXa/d3kONbmNnvsxL2cDUB+AxHvtrtruMO37F0I5kOgLjiBBg1dr2iyATUg1J62I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pA23cVOI; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHYRRbe5bUGlpI+JsowU5XxVjeGfVHKo4o4EAhkCuGvr5hNUMlvqVJvtXnQV17DSqY6/fuJWo34x5imUOOy3gYZb21cXqstMC57N70Gxp0WzqCK1kFSlG4iQhW0MmKDqS76S3RZidx+MnEQ9MXthC171ty4wl8FKt7zWTVwceCX1V0D3GQbE1G4kudHfyHFUzQxrRvo9vgqCELhlrP9EcfZ1qKFI6+ta7ly4wDgxlfWaXNpGqEQInf0NvoKCj9WmJao6kCE4Vj7qohaay4PenfFWWS/pfRHPlbsnFdr91WUeaHDIruolID6I1HwTRi/EjaRwYb58sqfzU6xkCvsr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyuEY8hQtCBBMsqxniRXFHNZAmlg8/vnn80oF4DZUFc=;
 b=b7hyAFHr8uTP2TRZOqGDQ5rhKILdgYMsjbyAWU4bTtHmeb9qgN26F6kKrdtBtckP3VNkOy9Wb4GVndGr6ywSDHVTsysclB/6acQk7OOx8lY6xTddJ14SAdd2YNNakcSf/nmU6yLZUxIT/NJ+8rJS4foPY30bjo7FqW3eFY3OeIg1udn9rexRjdevF34I2VLlRrgxKBVh2qvbW2XJBLVWLm+Ji4VKcKC/G6phZOifFRXQV+iXge/x2tVHbq8+DwAf82CYjT6qMJKZfDQrxKQ5LwSEMrP1jhhIgkNVkHKvToZK3dhj7JK8Q0wsuO8uYHcAOyaQEWtaZ0YOUxrksYbgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyuEY8hQtCBBMsqxniRXFHNZAmlg8/vnn80oF4DZUFc=;
 b=pA23cVOIpVtq5BtDecP7TBMKjowlWwhi3wxL2isLKIr9BkJbTSQQQxIj3Q/RNSY5UW88nMeXyLDlNy0Ch6jXTHOB5Ezc8oxOHjMeiMS0u6xRwg250FfBn3It4P25kbBaPjHAoLF9Nci0oBknhG8o5m67cSoShArGHcstbA8qkEuWozqQVdMRxhKFw71tT3gHd5H3DG3zeScmvs8+d2f+XHMonhi3RQcVQT2U7GNxqXv5b79QH3R7JS4bFrTx41qigV8C8EUJlVjx12q9JMkHd9yKEUh0x6zxRuDWpxVl0/eDxZ0dff5QWP8Ubg6gCpJrchK+lJtPbiKEHCM7xYuFYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 14:55:56 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 14:55:56 +0000
Date: Tue, 22 Oct 2024 16:55:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Introduce LLC awareness to the default
 idle selection policy
Message-ID: <Zxe89zvC5uhI7ZxG@gpd3>
References: <20241022101422.212810-1-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022101422.212810-1-arighi@nvidia.com>
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: fc283d8f-78c5-4aca-ef96-08dcf2a9a233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i30h3htcT8cXpZX4/L8QdnQRcOmOZniaJa5EhPGWraw+9Pd8Gey+O1BmW8y9?=
 =?us-ascii?Q?pCEXH/SOQ+u4Vpgp8A1ZMruFTZlmaVWsYURNyW7lLGgx6MgpdQTM+k92xpT9?=
 =?us-ascii?Q?VL9sszLQompGrb9CuTVYU9Zf0J+4pm1LmiVfHGf+69DBdebynaLt3rswabgz?=
 =?us-ascii?Q?yu4rhi6/3AuycJeek45yN575NhLQ/QgRnwHn3XXhQzc4kk5lF6q0c24vsmJS?=
 =?us-ascii?Q?nmDFppHH+RObWOPabstzqXSh07IGowmB2vuUmTmSZgpVCmOJeXp3AJJ6E42H?=
 =?us-ascii?Q?aaCZ3pUDc6zO6OjsJINRICM4TrKRELcOUUGGK+UFuOenb7tKqWu0FaLtLT80?=
 =?us-ascii?Q?RWPcsLr+5V++UsBIVLCKUVjnTUSup7oBKUUTqS23k8+6lTfodZyjI15iiRJM?=
 =?us-ascii?Q?bAQ80dnlv4r1TuzLyR+G8VFBy+ChhyCFEuN1EpUcrkDw8a7AU6MDhO3HdpSY?=
 =?us-ascii?Q?P16Hs0Hi9NsLRTqrEqAckrYcSZ7c3wzLB/a/ZbRhvR6ny+IPNR12d9ZxlKTN?=
 =?us-ascii?Q?qmgtl/5yIhwMSgwtv0LqXI7JoXDN3tTuczLqskNfqbTPjO77oHyDqZjoRwCw?=
 =?us-ascii?Q?o3N2Y+iuvpfTBcyRELu2rYzeMKWISH5jzCHy6TBC7mhVtDfmQtODmtXxqgrD?=
 =?us-ascii?Q?0wJkuOJxPRpTJAT46ewu6S5TMlpzJuzXC4fD/UyjeF/v/Ysdtpgq2UEOkcbl?=
 =?us-ascii?Q?fecJ9HBXIqwjW+l0O6FPPKBaCmLuY2DWg7xEdcfBoGcN8X9oHbR78zd3erzl?=
 =?us-ascii?Q?MAFnFAEvI2Y917pyU0twB+egkLnoUdMi9PpziZVrXZ6g100LgiQpDPYo2wQM?=
 =?us-ascii?Q?MhHnP0jegglDnT7d49YpggS+R3brsj4C+TymrV0yz4gMo8Y7NifBeyeoWMGV?=
 =?us-ascii?Q?E8TolVP+8XSW3pwYg04D5BFe4E+PCfx3gxDL4u99D3C38MM2nkkmYVWXffRE?=
 =?us-ascii?Q?VKmYLLzP5Ef5UBln+PtrEWsmKYE/JB6xgnaoNSAJhNv3350G2Q+V4G958kSo?=
 =?us-ascii?Q?ORsyGHAia0sK8c/pKv5YuQAfysSbz2l4Itro5g16g2/athysuRqN/sY4yGB7?=
 =?us-ascii?Q?y13QZYzcMYoR4rXpT5J2sno+Fi/t0STKHS2/s1s5G11MI/gESYNChjRFPZzd?=
 =?us-ascii?Q?kfhailUJuuvolURqt+rG/GdD7ezOHvkiMt5VJm51ggupwkTUgoRHbAb2qWTC?=
 =?us-ascii?Q?zSUSS/GRY7u4pNYWDObozUFP1nHkLEYIIhI04j7wkTExkRSSqvz5MlpBdWif?=
 =?us-ascii?Q?fwhuOSDh3Q4vWvQO43lqSTJbwznCIiyOqq++lvFlg6tRH7uour8TN+KrWoEL?=
 =?us-ascii?Q?cN5M2qhsta4PcW8rcatzMqbp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZgYG8WpHyJwdKtxSWYIwnEBRISsu1meMoIfwSADhxBKXBSbXy8TIgANWwwbm?=
 =?us-ascii?Q?22HFSZtRdX0vXY2FXGSpNTNkZF2B9CY5F6Tj/ny3pBoVEGA1N0+SpU1TIen9?=
 =?us-ascii?Q?/rpKZgOcjtG8sc0Lg1gacfNwij5R/zi2RNNUIJ+C/SrJ0tezr9zfUpk6+EOi?=
 =?us-ascii?Q?7ZZrr2LJ9bjoDp4bq7w697BRKmf5giMpgxNeIij7H4FlPtQkQ7zia+chdyiM?=
 =?us-ascii?Q?zTivu/YQoJHSm4psodgjPz6Qam9vVK76pf3A3DHfAy01D9dre0R/rslMUAoM?=
 =?us-ascii?Q?4P6kXjWnX35ZxJWY9X1Ra0PXgSGJ+rO3TN2/llS7V8pqPAXv+mBNv2p+zNgW?=
 =?us-ascii?Q?n4Z6aXdpLwAeU8ckZ4tEwc6/AG0KGETlWQvXIuS5Fs6eDKQsDWQIWIpfnqlo?=
 =?us-ascii?Q?I5r7rp0QgBKFtTKl7breqxKX6lIB8Z64BIjTYxQky2lK3eHFpekkahGoddZU?=
 =?us-ascii?Q?iMobaen5O+dB9fVyux3Q2RXXkA3+2Zuet2MrkQrOu63NC749C5DCOl2KgZYy?=
 =?us-ascii?Q?DQbXB8DZQJC/ksi5TSU+IzhOMaNpoG4BqrKKpXfx7zYPNu55ii2xECuHG2kl?=
 =?us-ascii?Q?uXBv4PN6ZAnfS9RupUooesG7ZTgDFzxrLgeiTt+DMxhKX+m45ZzwdPXVSlla?=
 =?us-ascii?Q?eecdmGz0oQQQ4Bj+ESUsUQkxoi6DJkPBp8xizwZbEDNTj/J6Pzk7zGj6gcgi?=
 =?us-ascii?Q?QTIUaeUeuDzTOv0uVCEBCMw9lH7/QNA13fMFRIVdsIHpWEal7SIXxmCO57WW?=
 =?us-ascii?Q?1b18eSWsfM43U7szJdvvurYaUhIlSxqJhOqyVabvEizewsLz+j/ke3bwC1jH?=
 =?us-ascii?Q?zf7y+wm9hSzdnix6awyzfrraMPMC1xy3gl7aMJqorRetQHFeP0biBCeiZ5y0?=
 =?us-ascii?Q?/OtW2DeSQPlS+znrRBC86PDBus5bN2vUTAKoRMxkXpkqYhP8uVd07JMVj3HW?=
 =?us-ascii?Q?DhCb95RyCkqNaU557kPV7doF3AUvsu0B2M2tQPgLmAasKfwFG1+ctfyZ5dOX?=
 =?us-ascii?Q?gGIIbkaIv+phBCb9hdUirOb41Ikk/4H6BkeU8wJBF9pjpJynCS49VCq6jFPV?=
 =?us-ascii?Q?cBi9TltdaM/JN9Nm9GDpdbB/AfaRbSURtiVBhgSkL31hXKt+KEoIhbk6Rh8H?=
 =?us-ascii?Q?jnrsCU10kAiKagl//KBqxyRTNXK/dlFEbNCEV6II8TvfWIsljL23cPG9mh6x?=
 =?us-ascii?Q?zQanKpWKimlynRAi8zPphqq/GPnUBPdXH49/x5bSRdlGaBybrdu3KHMPp13J?=
 =?us-ascii?Q?huRfLYDsN0H8sod682jX9oD2MiQbPY0P4KLO5hsH2HPoPkLGIf0bGoEdZz5i?=
 =?us-ascii?Q?Sq6abbjuQBSgjra2fw88LorIin8qlO7o53/5JAReLsLLz9GgQjBHdEd/7nze?=
 =?us-ascii?Q?MdILrLSY8GcMJp6iWgWXWu2aMLFGgxRrUmwVPouRs8vZsCIzMhRri0fTPf8T?=
 =?us-ascii?Q?ZnJp/8F/KefxsBevbNjjNYvsThYrxXo7X7Tvi/KqfgmkD7DNp4FTha9X3fB+?=
 =?us-ascii?Q?EdSbhm2lG8RwYauMv9lbfp3e5cw27Dh41u5dE4Og7ixaRiN9mY6MiIyzxXkd?=
 =?us-ascii?Q?GleQkRdnEeAo71wO5IWS9k8h+w/H31hX+8z0rBSY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc283d8f-78c5-4aca-ef96-08dcf2a9a233
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:55:56.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpFPC2VENTkKBkFqYQpjwM5y3Rg9mt1awwgLEWmHMCeYsbcCskte0kQi0+gDliRzLfiJw7tlZ3ZU1w3HWR8Gvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359

On Tue, Oct 22, 2024 at 12:14:22PM +0200, Andrea Righi wrote:
...
> +	/*
> +	 * Determine the task's LLC domain.
> +	 */
> +	llc_mask = llc_domain(prev_cpu);
> +	if (llc_cpus && llc_mask)
> +		llc_empty = !cpumask_and(llc_cpus, llc_mask, p->cpus_ptr);
> +	else
> +		llc_empty = true;

Thinking more about this, we can avoid re-generating the llc_cpus
cpumask when the task can run on all CPUs (likely the majority of the
cases) and it's probably more efficient to check for
cpumask_equal(p->cpus_ptr, cpu_possible_mask) and just use llc_mask in
this case.

We could also optimize tasks that can only run on 1 CPU, but we never
call ops.select_cpu() for them, they're just skipped in
select_task_rq(), so I'm not sure if we should handle this special case
(maybe I can add a comment, to make it more clear).

-Andrea

