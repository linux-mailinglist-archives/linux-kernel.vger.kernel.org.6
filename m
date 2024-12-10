Return-Path: <linux-kernel+bounces-438609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888DB9EA37C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF98282B90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46D4A31;
	Tue, 10 Dec 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJXm1vZ6"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBB2566
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789697; cv=fail; b=Wkzcd8GELTsW7zkkEBumXM9gIm2OFLCy55KiDtHNNiPdWMq0A1U9j3dMDDtpEATDFKsm8Gpg2Vi+CV8SlTmj3m+qLfSRbFgbYKWdjRQwEw5OMhcY3eb5ZaoJreBB1UzhQJp7lUpgZywssR9a0EGIcW8fQAeAh0WpBfTySRx6aPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789697; c=relaxed/simple;
	bh=yPqdOWb2690Ll9XSZEV90z1H0GGBhIZcExoNTZO+8o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bXL+L6nw/d7OrvG4jgvIeZi3u4T6hA2VfZJCiJ9efjgcD03tZDOAxUaIMSKWDBLqIp5nkhVALTVduPVJfHSIKYabYiuPRHA5JsId1nQ8BIlNbu71f4HTuZrtWlQCNUbhpyqeZnvQlr6aLDf6NcCYBxe+sjOjADNgEIcExeA6DzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJXm1vZ6; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyk7TExd/TcJLzdiyCis8PS2Pq7Eer3edualdkaMiEa/Z/WOrcb6EsrN+1MaHy+bYGUEAMOtEnrsjBnQ77x+d7GmbJu6P6rQ7T3yA27MJdE/aCDjeM5AevEop9NKnE2AM9O6JmZbTm2cGB9FzfIFbVpqVbUMe+Z8/3nyeX22mv4p91gxew/2CSyMbm7a9HyKFqiQXlXqmBRM04Qerk9wzSq763DcOKZKvl2Y7rtOu7xEv4skrBBkYySBSU6N4X5JnVjRg2WPSXppgIu351Vc0XMxTLBP8UMSrp19EA7q89llKHszexGiFr7w/qGoaAsGrncnTxnzTGndlQNmJNHVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSanktczi+gJT4qbFYAgr63HfodHtev1EQhsfsdp7Tg=;
 b=IuYq9Y6tf2Rfp/Yf8/JRE0CcoOprBUJhVurvMnF4797E1n3sx9421cKKGjWfdAlg04CZk2BSWHDSJe6evXEtzVKKxhaGHzqab85cUy203RrMCFvCmS/bGmn/UugfrPzzK6aG82GopNb1oLpWquhOJ5e94GDJEwCKHqFl37Kd5pd/Ms2fcwXNJ0hYawLNUAlFYJif6gV3Oyx7J9n3LcSKUTthZFhT7jSu4+xtD3kn1PdLNX2tYJXzmPcTB2/dvkjZu1Viq1otsPpO+KgenWlKp6eq8f+IgnWC+NXGMK8Xcg32T0WE69n2Z+XITuuO/XGDC6hE25SXQbiXhaGOyNSN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSanktczi+gJT4qbFYAgr63HfodHtev1EQhsfsdp7Tg=;
 b=aJXm1vZ6tRdYJdaohRgnU5Hd4RMwPLK1jEecn/QOBWXauo/kWUwOL7GdzwOKnT65X7u2tmCfB8NKKmoAXH8CDCRLEH/+B7CO5KDVdqcsjul9KUEkzH18dfsQm9oNGFoMO4/15ZwOy6n6R6Rn1dyF9Xi40hiEYaXRj2/QZvhrvzHz0No8g4EBlzNmvEGblXtUyjmXUJ5bjv3aEt+1kGUaaAxh+vJ6KSVNuCK+ArduwuOV4DI1sKNZ4TUieyJ16avB12N0MLGnCv/EtmImSnkbOoq+41xZK+B2ahRQ5dRGlNyoBmRVBbPbmJtaDh/PEZjjDMzy7hMKfXmkUs1ZpgGeCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 00:14:51 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 00:14:48 +0000
Date: Tue, 10 Dec 2024 01:14:43 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z1eH8_rP16IyJ8LI@gpd3>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-2-arighi@nvidia.com>
 <Z1dF6HuEI2nyUD2V@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1dF6HuEI2nyUD2V@yury-ThinkPad>
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 352a2c17-4d63-4047-4a8f-08dd18afa87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yxmhxHbDx6i0zVydHxgaUPalgmm3GwN2NUfpVd6TmE29IuvIE40ovF+Mx5it?=
 =?us-ascii?Q?EXpaW8wLM2btVoZi7PTN2O0EiQw4RaFrLuuOciSIIRfmh+MIFngHjW5mG1Fx?=
 =?us-ascii?Q?W0pHi36s7pU6O3+X/aBRUJcsBne366sPYiNfXrVnP/Is+3BiutaDTALoVUgX?=
 =?us-ascii?Q?AFR8kePj8eqLNF2ckhwuz2n4k276pPSp/BX3w4fk8d3wT9JSorBKS8zVzdq6?=
 =?us-ascii?Q?uOEeN6nsp0/1R6lz2kF1ffWQKvXoSvXbEIANswsm1WcXsU47jRVdpSBsgGcd?=
 =?us-ascii?Q?NnCPXVbEnhdgScsceKvLVLiPbK+JOwZXhXbUAm7Xc3PtWBejWRoWiByA1ngJ?=
 =?us-ascii?Q?l+fAShc39H9FukW/OAZHvG0D4PzHJTdUIkQ+4B5xawU89qtj9ERtxDf4Va8O?=
 =?us-ascii?Q?IET+kooj96vTiDTxtAZu63j6roNl6fgZT39kyW3vLh5hzReITj/YFjo8AYNv?=
 =?us-ascii?Q?3QrPJs6lITwWCo6Ptg207lYj/W6G5Bf0sAO/sQeKnIhHVxhQeHp569VrB1r7?=
 =?us-ascii?Q?Lk0oAm7QWXgYdoQw8avv7snKpnAnD0M0VtKtUlIGu+BgOO5eoy0uLyPOuxsm?=
 =?us-ascii?Q?wyFinRLR9f4SBnJ0tqqXvQU5N4S1UPatkvQCy12hagbz1aFGNVazukMtl4EJ?=
 =?us-ascii?Q?oRsT2b6tpAZaDrWsIZBaOqDYCdqZs0l0+QcLIYn8GfTVmTa45mi8IMoEUB8X?=
 =?us-ascii?Q?LkFQ1eOhHXGQl33KRbCdCRfJZmYqxjCgJKVtaaKsl0NzZv2t1Bis+rNrTNJd?=
 =?us-ascii?Q?spcQ9le3VSOIP5657mCiw/faNXg7Y3n3sM3JBcCAHFI0xj/zfCJta4EvhHvM?=
 =?us-ascii?Q?Hch6CEuhd+ognkjpTHMfrR+j/3Dtbvd/+STRqlPbrVqYWhsdtgbTt2Wjeb8J?=
 =?us-ascii?Q?oPpWM5a5exv99DD31Q6uD9tJ+qh2AM9DLe9VWtdvA1kQi2qd2GbDeIOmdKoc?=
 =?us-ascii?Q?Ss3wYFgixbZPVQVIY9s3IIufWUJATwNj4jVA8/qlxm6/BWDzeBoYwoFkNFxR?=
 =?us-ascii?Q?fqu4aU58r2Bgo1o0gTS2Kkc7INYk0uB9ZDw2r4NhqeSptiL00nSn/03/x112?=
 =?us-ascii?Q?riyYNulls7xU09tzkyaImssM5QcJGblaZvVFxFk7BEWb+Z0QWqLYhTr1TK+P?=
 =?us-ascii?Q?xxMrUXNhhDnguQI1H2eDMHPaoLdgwZyznlgXANLOIOwW8VaxP46ZtEQvMN1Q?=
 =?us-ascii?Q?ZzBKKYr3A/O809ZdcGeHt6zYzRvDqtV7lB9nubG4MFu4XW+QsMymLCHCe2gT?=
 =?us-ascii?Q?8PPtgMr+GIJM7I3p/sd9JZ2uWjjO4PwMd/TQdiKkubzOLb5AvBWZaOjLS7od?=
 =?us-ascii?Q?EUi5eB92hUyIgcyb/1hwfYHQexNKHX1xkq5TYbgXxi9nXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+6KorNo2FYUopVJ0rSREb66Fr0I3M38yYyuyd+qknMknFaCIj/Wqtzbo03O?=
 =?us-ascii?Q?X0vmgrnV1DtJspoBejV29FVTh3iYbXKZkhae5lliv29FkfjJUBSNf/tUl/iT?=
 =?us-ascii?Q?QqqqwjYGWG9D8fuLDcB9dt5I31qLZgVBaP3yNygoI32wcXbaLDMt9yQ8CvFz?=
 =?us-ascii?Q?nBOJA0v4V9OHWbu0cVEA4prImLvxt5GWmCtLHonRz9M18kU3ax4INDvVQYmR?=
 =?us-ascii?Q?bIh6CAonB9dnHk+qUIkgN7aemH/H3AqSoTcJKPgPAzIuh3kUHsEasYgabvZR?=
 =?us-ascii?Q?PJ/+F59AsvgV2T2UrmImUk4V5wX1cF2wzlslRy24HhYltnhqyczv/Dxq0swS?=
 =?us-ascii?Q?9NTDfWckmc/LZLocsZYX3Ta9TP1hnlSzC3QHKsPHNbMdocyQ1dWSCaB1c3F5?=
 =?us-ascii?Q?EdHuZq2opKgvvzeg37G1vjd0XSQ1hvsoQwhbHcxJM3jncZBeJ33LA04oLQTl?=
 =?us-ascii?Q?6QxPAvEOqi0/eW5uyj+ykXoQWozu5nKfR+uVU6BDa0ittiUmCRuk6WnMOKJb?=
 =?us-ascii?Q?EKA3tBXZqfTJSEkNhKkFUl59I5jajANoVGXk5+vjAbGhmRZAHVKwm5mwLJ+e?=
 =?us-ascii?Q?BWUkGoTAwIrCyduTlwkMbcz10PpUneliDkBzKg/tGtYZQIId2DNvrajhbvSC?=
 =?us-ascii?Q?6fZYuCSIbbrFmEEFjA1SZQ8Tn1A6RKBkLcQoQFCa2muCAkXcaiPDa+Xx/G1V?=
 =?us-ascii?Q?SaldeUZfTf/Qs4dV8C6HYH5KeeZbcu3YvCs4t8BKdTTNiCzTjyFl1ETgTO8J?=
 =?us-ascii?Q?ngPZ4RW2oi5lFrXKfAQYOZiidjI2eWWRI0XoeNB5pPlV1xDvKVGgJbnTSfha?=
 =?us-ascii?Q?OMXhY1R976suOAVirlezppCNs5UQH9hHsvXS0P1b1U5Ib9dOw/xKG2i7cdTh?=
 =?us-ascii?Q?xmRuQLWHX+c56dX3jVMSHPnFMTiT9ov26cTPzri/dfH4xdBBDIkDT5Kc12BZ?=
 =?us-ascii?Q?s1mJfMSC3/fCrW/hOSyDCuQJ1GD+0gwcRV7HHUseAU6pX4Aqm26ZsVH34bOg?=
 =?us-ascii?Q?+D2nRjt8CtUVAmy9qJojvSAgdtbdwZWNH156V0q1cpcEUhUb+MQOUnn34MiX?=
 =?us-ascii?Q?sv/Yr0cZCnvKSHsMeU+HiqurqPuwumnBzf56MANzObwIuEmp1ITw2QEXmgBt?=
 =?us-ascii?Q?jtBX4ON/9zU8umtAKm8SV5V+Uw9/hBv68w3KCpT1mE4IOfX9knq3U9MVICq/?=
 =?us-ascii?Q?PlcqItkOMlII8WaYZ4H06jPUsdjC45sbHb/iy84rLASVSO3UFVjk/ZViBWq4?=
 =?us-ascii?Q?Jwb/lu3CvjUEaFMDgYuo8scTDWtxvH9Q5LiAuQWm1jtd50yDYDEfCXkCVcdx?=
 =?us-ascii?Q?4u6bSLUkTb4Wis05TTfWUBwzMtveH/mk7jBIJ8J/P/aBOMI0DiUpsTtsIRyA?=
 =?us-ascii?Q?Ohkr1YIzMmBz/+ImyvSehBZ/C1Bvn3RSVHbEv6y0KLRpQ6nzRFN5BWHz95AH?=
 =?us-ascii?Q?n2UZDT1vbDoeLN4c4HMJcRLyAs2mr+oA+MQK/VEMf5c/C5eEywkHbd7r0/SA?=
 =?us-ascii?Q?dEWWwXVutVc6dVLgbtawklAAe7dynV05myD7SajjJfWCGYdYI4bBfmVHzEzb?=
 =?us-ascii?Q?KDEs1CI9h0V/C5plFdqY5C9ukH5DUCrH0fbK1Uja?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352a2c17-4d63-4047-4a8f-08dd18afa87b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 00:14:48.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqGiNNRfy9xIMm6cezOuyRCYfVNk3ULI4sUGR4rzAJaLAyaLTMcBgLpRkp+WG2P5tmUExyRg3tcXxhRBxv5n4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

On Mon, Dec 09, 2024 at 11:32:56AM -0800, Yury Norov wrote:
...
> > +static struct cpumask *get_idle_cpumask_node(int node)
> > +{
> > +	return idle_masks[node]->cpu;
> > +}
> > +
> > +static struct cpumask *get_idle_smtmask_node(int node)
> > +{
> > +	return idle_masks[node]->smt;
> > +}
> 
> This implies that NUMA_NO_NODE, which is -1, will never be passed.
> Is that indeed impossible?

In PATCH 4/4 I adds some checks to make sure "node" is valid and return
NULL otherwise, but thinking more about it, it seems better to return
cpu_none_mask.

> 
> > +
> > +static struct cpumask *get_curr_idle_cpumask(void)
> > +{
> > +	int node = cpu_to_node(smp_processor_id());
> > +
> > +	return get_idle_cpumask_node(node);
> > +}
> > +
> > +static struct cpumask *get_curr_idle_smtmask(void)
> > +{
> > +	int node = cpu_to_node(smp_processor_id());
> > +
> > +	if (sched_smt_active())
> > +		return get_idle_smtmask_node(node);
> > +	else
> > +		return get_idle_cpumask_node(node);
> > +}
> > +
> > +static void idle_masks_init(void)
> > +{
> > +	int node;
> > +
> > +	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
> > +	BUG_ON(!idle_masks);
> > +
> > +	for_each_node_state(node, N_POSSIBLE) {
> 
> for_each_node(node)

Ok.

> 
> > +		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
> > +		BUG_ON(!idle_masks[node]);
> > +
> > +		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
> > +		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
> > +	}
> > +}
> > +#else	/* !CONFIG_SMP */
> > +static struct cpumask *get_curr_idle_cpumask(void)
> > +{
> > +	return cpu_none_mask;
> > +}
> > +
> > +static struct cpumask *get_curr_idle_smtmask(void)
> > +{
> > +	return cpu_none_mask;
> > +}
> >  #endif	/* CONFIG_SMP */
> >  
> >  /* for %SCX_KICK_WAIT */
> > @@ -3166,6 +3218,9 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
> >  
> >  static bool test_and_clear_cpu_idle(int cpu)
> >  {
> > +	int node = cpu_to_node(cpu);
> > +	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
> > +
> >  #ifdef CONFIG_SCHED_SMT
> >  	/*
> >  	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
> > @@ -3174,29 +3229,34 @@ static bool test_and_clear_cpu_idle(int cpu)
> >  	 */
> >  	if (sched_smt_active()) {
> >  		const struct cpumask *smt = cpu_smt_mask(cpu);
> > +		struct cpumask *idle_smt = get_idle_smtmask_node(node);
> >  
> >  		/*
> >  		 * If offline, @cpu is not its own sibling and
> >  		 * scx_pick_idle_cpu() can get caught in an infinite loop as
> > -		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
> > -		 * is eventually cleared.
> > +		 * @cpu is never cleared from the idle SMT mask. Ensure that
> > +		 * @cpu is eventually cleared.
> > +		 *
> > +		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
> > +		 * reduce memory writes, which may help alleviate cache
> > +		 * coherence pressure.
> >  		 */
> > -		if (cpumask_intersects(smt, idle_masks.smt))
> > -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> > -		else if (cpumask_test_cpu(cpu, idle_masks.smt))
> > -			__cpumask_clear_cpu(cpu, idle_masks.smt);
> > +		if (cpumask_intersects(smt, idle_smt))
> > +			cpumask_andnot(idle_smt, idle_smt, smt);
> > +		else if (cpumask_test_cpu(cpu, idle_smt))
> > +			__cpumask_clear_cpu(cpu, idle_smt);
> >  	}
> >  #endif
> > -	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
> > +	return cpumask_test_and_clear_cpu(cpu, idle_cpu);
> >  }
> >  
> > -static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> > +static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
> >  {
> >  	int cpu;
> >  
> >  retry:
> >  	if (sched_smt_active()) {
> > -		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> > +		cpu = cpumask_any_and_distribute(get_idle_smtmask_node(node), cpus_allowed);
> >  		if (cpu < nr_cpu_ids)
> >  			goto found;
> >  
> > @@ -3204,15 +3264,66 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> >  			return -EBUSY;
> >  	}
> >  
> > -	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> > -	if (cpu >= nr_cpu_ids)
> > -		return -EBUSY;
> > +	cpu = cpumask_any_and_distribute(get_idle_cpumask_node(node), cpus_allowed);
> > +	if (cpu < nr_cpu_ids)
> > +		goto found;
> > +
> > +	return -EBUSY;
> 
> What for did you change the error handling logic? Can you keep the
> original?

I changed that to follow the same pattern as the one inside
sched_smt_active(), it should be equivalent, but I can keep the
original.

> 
> >  
> >  found:
> >  	if (test_and_clear_cpu_idle(cpu))
> >  		return cpu;
> >  	else
> >  		goto retry;
> > +
> > +}
> > +
> > +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
> > +{
> > +	const struct cpumask *node_mask;
> > +	s32 cpu;
> > +
> > +	/*
> > +	 * Only node 0 is used if per-node idle cpumasks are disabled.
> > +	 */
> > +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > +		return scx_pick_idle_cpu_from_node(0, cpus_allowed, flags);
> > +
> > +	/*
> > +	 * Traverse all nodes in order of increasing distance, starting from
> > +	 * prev_cpu's node.
> > +	 */
> > +	rcu_read_lock();
> > +	for_each_numa_hop_mask(node_mask, cpu_to_node(prev_cpu)) {
> 
> This 'node_mask' misleads. This is not a nodemask. This is a cpumask -
> all cpus in the hop. Can you name it 'hop_cpus', or similar?

Ack.

> 
> > +		/*
> > +		 * scx_pick_idle_cpu_from_node() can be expensive and redundant
> > +		 * if none of the CPUs in the NUMA node can be used (according
> > +		 * to cpus_allowed).
> > +		 *
> > +		 * Therefore, check if the NUMA node is usable in advance to
> > +		 * save some CPU cycles.
> > +		 */
> > +		if (!cpumask_intersects(node_mask, cpus_allowed))
> > +			continue;
> > +
> > +		/*
> > +		 * It would be nice to have a "node" iterator, instead of the
> > +		 * cpumask, to get rid of the cpumask_first() to determine the
> > +		 * node.
> > +		 */
> 
> I'm not aware about such case. And this one doesn't look like that because you
> filter against a cpumask (cpus_allowed). Right?

I'm interested to get the node id here to use it with
scx_pick_idle_cpu_from_node().

> 
> > +		cpu = cpumask_first(node_mask);
> > +		if (cpu >= nr_cpu_ids)
> > +			continue;
> 
> for_each_numa_hop_mask() doesn't traverse per-node CPUs. It traverses
> per-hop CPUs. The difference is that the hop may include more than one
> node if distances from a given node to those belonging the hop are the
> same.

Hm... I was missing this aspect. Thanks for clarifying this.

> 
> So, imagine we have nodes 1 and 2 in the same hop, but cpus_allowed
> has only cpus from node 2. With this configuration you pass the
> cpumask_intersects() check, but when picking a CPU, you ignore the
> cpus_allowed and pick node 1. This is wrong, I guess.

Yeah, that's not what I would like to do.

> 
> Instead, I would make a single check:
> 
>         cpu = cpumask_first_and(node_mask, cpus_allowed);
>         if (cpu >= nr_cpu_ids)
>                 continue;

Ok, but at this point I'm not sure that for_each_numa_hop_mask() is the
most efficient way to iterate NUMA nodes.

> 
> > +
> > +		cpu = scx_pick_idle_cpu_from_node(cpu_to_node(cpu), cpus_allowed, flags);
> > +		if (cpu >= 0)
> > +			goto out_unlock;
> 
> The code in scx_pick_idle_cpu_from_node() is written such that CPUs
> that your picks are well distributed across the nodes. Your code above
> always picks 1st node in the hop. I think here you should use 
> 
>         cpumask_any_and_distribute()
>  
> like the scx_pick_idle_cpu_from_node() does with idle_masks.

Right, that's because I was (incorrectly) assuming that each hop was a
single node.

> 
> Another problem is that high-level hops include CPUs from lower-level
> ones. It means that you will traverse the same lower-level CPUs again
> for nothing. So, you need to mask them out.
> 
> Another-another problem: if your hop has more than one node, you should
> not jump to the next hop until you tried every node from the current hop.
> This brings another loop, but doesn't increase complexity if you
> carefully mask-out all visited nodes.
> 
> > +	}
> > +	cpu = -EBUSY;
> 
> This hides the actual error returned from scx_pick_idle_cpu_from_node().

Right, scx_pick_idle_cpu_from_node() can only returns -EBUSY at the
moment, but it'd be nicer to pass the returned error.

> 
> > +
> > +out_unlock:
> > +	rcu_read_unlock();
> > +	return cpu;
> >  }
> 
> And altogether this should look like:
> 
>  int scx_pick_idle_cpu_from_hop(struct cpumask *hop_cpus, struct cpumask *cpus_allowed)
>  {
>          int node, cpu, random_cpu;
> 
>          do {
> 
>                  /* Pick a 'random' CPU in the hop */
>                  random_cpu = cpumask_any_and_distribute(hop_cpus, cpus_allowed);
>                  if (random_cpu >= nr_cpu_ids)
>                          continue;
> 
>                  node = cpu_to_node(random_cpu);
> 
>                  /* Find an idle CPU in the same node */
>                  cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
>                  if (cpu >= 0)
>                          break;
> 
>                  /* No luck? Try other nodes */
>          } while (cpumask_andnot(hop_cpus, hop_cpus, cpumask_of_node(node)));
> 
>          return cpu;
>  }
> 
>  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
>  {
>         const struct cpumask *next, *prev = cpu_none_mask;
>         int prev_node = cpu_to_node(prev_cpu);
>  ...
> 	for_each_numa_hop_mask(next, prev_node) {
>                 cpumask_andnot(hop_cpus, next, prev);
>                 cpu = scx_pick_idle_cpu_from_hop(hop_cpus, cpus_allowed);
>                 prev = next;
>         }
>  ...
>  }
> 
> Not tested, but should work.

Makes sense to me, I'll do some testing with this.

> > @@ -3636,17 +3748,27 @@ static void set_cpus_allowed_scx(struct task_struct *p,
> >  
> >  static void reset_idle_masks(void)
> >  {
> > +	int node;
> > +
> >  	/*
> >  	 * Consider all online cpus idle. Should converge to the actual state
> >  	 * quickly.
> >  	 */
> > -	cpumask_copy(idle_masks.cpu, cpu_online_mask);
> > -	cpumask_copy(idle_masks.smt, cpu_online_mask);
> > +	for_each_node_state(node, N_POSSIBLE) {
> 
> for_each_node()
> 

Ok.

And I think I haven't missed any comment this time, sorry about that and
thanks again for the review!

-Andrea

