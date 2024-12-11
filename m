Return-Path: <linux-kernel+bounces-442087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F159ED7E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AC3168B74
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A67229688;
	Wed, 11 Dec 2024 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pVelPOqo"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA042288DD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950553; cv=fail; b=LPc17UclvXqZZy7quteNTPSGjwRmv3egoCCcQFWDwTus3I9PyrL3zwFgjVO3t6ibzL0uAljPfCXFuG972r9BO05gX2zd1knsMB8KvP4C5wOhOvF4lPV0UfdZgoPnKfx1PHqKrDZ1XTaXN4KqU9RDwvfHEA0uq33qoC7FUGmA23A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950553; c=relaxed/simple;
	bh=nTOL5UhZMWfPSbqhlwelXJh2R2Js3im3satd7iSTPkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RVr3RF54QSpFrrwZFS4h2tifJ1IV5lPFvyo5QQxyb8ON7FhGmig6hyXmY/CplgkQh1g6zaHEZAbnRN3I6hqeSak59xOwHvS337cRepaZRI29tlxJ3HGPf/24jarbn9c4n5oQ9t5hm12K1e3wgov4H6nkhuSm1QCugnl2de+0RNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pVelPOqo; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFtX5xqizvuE6QTQaE+6LpWVb3Ov6MG+5DuWZZ3YvrRin41fEYnlTGtnmWlf7cJRgxBrJnJHByIWGBk179Xi6lGTidRvdZv+b9P9jxi4sAXfgT7EqOGf4/x1UBxXTYOtmn9IIM5KfduyaDdeXIKb2NUIS7rTcgM/FiDV7RkL+ml4VpFLvIlzD3XP3YZaA7mvXNNy4WhUx67Ec9dnPw+lNnRPYtSS+RaQRLc/aAy4qTHuH0iTa2Kcqp9bRtuEiW5OtsvkkkzJo6r4xc0hhGpUCW0DeR0ocbC6yZ2c+X911AebL2rEwr+IXZW+flIsxwqKfFaW+Z16AxMsoE3SEfJBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouk/p7NpXooZkVSSvi+ewsAr9O7fhG905VCH3JHJg54=;
 b=Qs/KZsp6E4GWNVJPjUJURtztHK3vbp5X/V9BYdGrM2ggYnpMm2U0wc7696mowLHqRbgF8YRIO/LAJ6Salc2UZlS9QBntOLNKshlDcsw+2npTm8cfkHw1kTjeaLDk8bHzHs5BxiKOE3Yuf8efgqX2xvtfbZyI+S2/JEgnkyWKt0A5KIu+95+770yHK/kMQzHt2G4G8zEU44fpsTzoNno6gy863TE8XFEdKsRdn1sgT2FTao+6mTrKUX9IGQEbOaE195m3j8ftUDmxJWNLcADoNCebAQq87SjXbAG4iElzeDr/Pj63L8XBwfKDVygdSMzRDCSo+UNmed0Ani2mb3SmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouk/p7NpXooZkVSSvi+ewsAr9O7fhG905VCH3JHJg54=;
 b=pVelPOqo5DLJeTHw+sJ2WVl3B2RK7jdise+n30Dlu3A3pSikIxydNKhVgdbuseyJyxvUCi1pgMszxs0D3M5smvOvP1ZmGrRH5F+lB7T9BtvjIlI7aNjpB9g3iJJo43wwjPFC3ZGuE7LbjiE/V2PKVoQVLj5njXuLKIPSCFRkpDTRJ6JgvpM5XeVR70OEYJ10StOA2lk9akGUrwFPuwWJl0DhU87c7Rte+j6o4SNZP6/ECKft9O7F8h0k/k+u5e7Yix9YHtJgOKM68Q/yJUknCD22Huu+WKmqYaSAWv5LaalKTKnmryxdyBz/bHRjdJ9xBVxs/qJz9FvNRkxFNuFhKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 20:55:40 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 20:55:40 +0000
Date: Wed, 11 Dec 2024 21:55:36 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched_ext: Introduce NUMA aware idle cpu kfunc
 helpers
Message-ID: <Z1n8SC6Z298E28Zg@gpd3>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-5-arighi@nvidia.com>
 <Z1nPPhe_83lBTna4@yury-ThinkPad>
 <Z1n0KLQcA-F2DVa8@gpd3>
 <Z1n6WgfTBBBIH2of@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1n6WgfTBBBIH2of@yury-ThinkPad>
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 201f46f3-25f3-4936-259e-08dd1a262bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+PBw7DU+jGHK2O82angNVBRmIKc/D9r/SUTSOq/c0iJVgAWF/vE+Fm8f7Wk6?=
 =?us-ascii?Q?oed8pue1YRhKTdw9ud4h5xxA02TS0qkhvvhHZDwOAx52b3Oja0xRRSdSgHLp?=
 =?us-ascii?Q?hUqk/oUkw0pR2Jc1OTyIZRYG8/pM8Fzktnsy+zN2qi7w8dwWV+OgATo7V9PJ?=
 =?us-ascii?Q?QCDxRlyLUY4hLhaCTTdCOJwdn7vY/5OFtCKeLfiLB3j6naNPILw7Xcp3CwP8?=
 =?us-ascii?Q?uy7eLMhgEMEGCC9n7aHMGKbh4/d7hQZ1T/RMFb2rgeIocqH5Z7s4PGEfgQmq?=
 =?us-ascii?Q?uQ5S20uq2fCi81oqGRkoBeGMRny/GiIRA+hBxhL+DPEJSxb30NfJw77j3j60?=
 =?us-ascii?Q?+cgu+VvAhdDnXdx7qsu+YZXYC5h0w2ZB+/be2AIgDL5ZJ7A13Nsm09akbTE8?=
 =?us-ascii?Q?cr/ul7j6fLIhnbP7N730MyTimoCiVGjImyuXcT6vP4ZSAjmrIX6AP+8kHrcf?=
 =?us-ascii?Q?L+vCSeqowNU731Pl15AG4hGUcpOzMWBOkrqtvcMnskm3Jqw5E5gPmUQtRjK9?=
 =?us-ascii?Q?VASBdCxdWRKRAZTvzrHWvMTfGldv6ms7k8GnhjjGh0SSSm6GLBU7+ZQoonEE?=
 =?us-ascii?Q?Cg09fajsQOEPREV/d82k+Kso+Ei1StSAtSyhfk9BsqxQZJvn2vmvGiofgXgN?=
 =?us-ascii?Q?ovDQOcQhoufRz06kpagtJr5aj12kSHhO8kIBVH6RvhxyL7gXAs3WUxF4Q3UZ?=
 =?us-ascii?Q?BdE9wdSKNOXaXVNPWEQB1ZOjpXUFVZisok7ARd9NDJMsN1Blw4TfEo6CnwMq?=
 =?us-ascii?Q?muQu63KR94j12FWTNU3yDs5jLmYNbsKMox864G58wibcWgqwojhiKXuSJcEn?=
 =?us-ascii?Q?FN529lFfAEoExyZw9N9KV7SG88w925TqLhmI0BiJLDUGqe3zTDqU6Rcg3ssS?=
 =?us-ascii?Q?8bfdZmhz44obo8NnOKFLzPcRz3WHj7tp7YtMShoalPHi7qwDNXO8y7gs4t1p?=
 =?us-ascii?Q?Xa/z3R4mXFwcHaBk0nEyQd4PEH4dfLRo4YuafyZrsv5GRg2S87rRVZ+NBr+o?=
 =?us-ascii?Q?5Jke3V+PrENwT9/4qUlV8OMObgH6vM/IEy+RHu5CObAZVSgqATrirv7QJymZ?=
 =?us-ascii?Q?AGFV3xToh6V++b0g4UkKgy6UfhAhQoCs+okZWYnQwSj8DO4KOeLZPLYH9+Dr?=
 =?us-ascii?Q?7apiOjd5J6XojX7NuBGzFM6jvWILTqwqlCZiW4bzoxmTEX1uF79xtjqunPLc?=
 =?us-ascii?Q?aIrTnu6JfuPmRH986uDI0zyzAB4ds81t70sYN275ojBS07JEWP9+bQpyimS8?=
 =?us-ascii?Q?8+4TYOHadmd34TrxjexnMEr8Z9fTpfPptACk3UzeQU7lOdiQG3xANhbLFAhT?=
 =?us-ascii?Q?fzfr2C/2VPqNOi2za4hYJ6TOzcR9fpATV8AmazlNCELoRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wmhun5YGFxqOMxbu+lE9+jBMwKnbx/Luv7a7WhUGViIZ9XFF4FxPBTo9wz+N?=
 =?us-ascii?Q?sZWz3x5qL9K+XShb7Z8ZKefSi+A/Ry/3SKL0w7lzZ3AGJNhfgQR+97qMmdMr?=
 =?us-ascii?Q?Oak0N9618UR5m6IisXC58xzxGxzO6qoWneyZbHQQ2srDX/E5kDR6TV4zSKTp?=
 =?us-ascii?Q?bbcaCQ0V98BW3i1XYCHveNZXKx0oPkgTUROl5C3PJT1mJ6dau7T3EnzF5p7/?=
 =?us-ascii?Q?GNLeWxOC2ofFkYP9J+/GvYQlOkUhtFmM7jij8fe/KPP57xJcRh/DYAB56D0u?=
 =?us-ascii?Q?BViN03IuIIjyJgsJursR7aLt/0iWROlbIy4rDtH9jZHoWcKxjnEqKiUS/8rm?=
 =?us-ascii?Q?L0M7KR6WbGmzUGaRJklIXrd7I6xYZDtdFPSbOYUCF90olFTA4IFKM0j93Rd3?=
 =?us-ascii?Q?zcRh1R1ZtttYODjqu+eU/vAPJSrgDI0MfAIvPWInOJtmX6/swSrPEPtqF4iA?=
 =?us-ascii?Q?mASQVK0lTZM0SYcR0kavPlelZLddumzEVBUjp1Bo+t8y+ac2IFF/5eVaJLGm?=
 =?us-ascii?Q?/xPSxJjKvy3IEInQBP16miA0RwKvGQ3QCnfavAcLKu4C/jVkKXHvYzibU2+E?=
 =?us-ascii?Q?kDv/XUeoyd53B+VSnlXDAYErI/PUtqc/nGYV2cND5Ybas6xjGcnHjgFVKR8G?=
 =?us-ascii?Q?RTrhfhIpzYsjqdh4b4g8natmg1ci60ci1hn0p4BrdSpZ8q8bGtVW24pmnkgz?=
 =?us-ascii?Q?DmGojNNplCJT39HcoesDVJdmVd69tJ6jjpoc8q1KQFII9wxuV9jH4vkmHri0?=
 =?us-ascii?Q?UZfnjYz+ohdzKmU9ZoUX3wEAzkJb+rU/GNBSeBZke3bEYsRkQ5zZvOyguF2/?=
 =?us-ascii?Q?3OfuWqJVEJfreawJSqkd7yOCBhe6uMuzH5oAE/loejqwH/DOAkGXtI4en9Q9?=
 =?us-ascii?Q?twi7jbHe6UjAezDdcOoxO7R04/5sv3b+NYW6SrMzlDn67w3wcaF7rTl4cn/k?=
 =?us-ascii?Q?jXb2j790BIYkASiJHTHIyFyMGaRs6oQUzpyVd5/AS3DzNpaLBak1eiTVh+5U?=
 =?us-ascii?Q?mZ7CUkCYaIIm8A6AT2NlbrW7SKBbiSbD0Dsay1DdFVI2py/+NPmhs2s3NJgx?=
 =?us-ascii?Q?GcpdjShgO9He3X0TWmeuTYJmiyk5ekXmMz0HFc5UfLH9yUWgyFz4HG1Sl/5/?=
 =?us-ascii?Q?Hm17cphefb62VfM+AgtEY323Mq55C/8gRrW6lH/qDtrmRWJE7CxBIQnveZ+a?=
 =?us-ascii?Q?6mIVcV++SMBYU7lay+S4ahGMGzuBi1pZ4C/JZHGib7biUSwBMzR/w8rTPUTm?=
 =?us-ascii?Q?QYGZpUkIfqinFMsYDyAok9U/oUOgsRUqB41KW4HsQAEGZYtjVjpVqrQNhLn1?=
 =?us-ascii?Q?xO2RJPhvZS8syXcEdvNinJKxmCy/FUIxn0CVSgemfqqooQ/lsLUmnz4SCt/E?=
 =?us-ascii?Q?SJHYsBPq0W474blZLy+KVkPPCKHTarqFM2xdlapXDbbvRKbIRQbd/sXK/I5r?=
 =?us-ascii?Q?MgTequ128JZCaI+5B37UDlf36JAUSWLUmh7dL+3RnbGaREnWHU3FH/7t0rMt?=
 =?us-ascii?Q?5eOWoAxZ7TrGzEtxvWVviaCMDObkSt85jlGiKzfuARlklFji4dWlgR2c2eHQ?=
 =?us-ascii?Q?Ki0IYvtOkc8fucAROzfgPuJ95KwXGZk1KmNrmmOV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201f46f3-25f3-4936-259e-08dd1a262bb3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:55:40.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUu9IQDw7pkII42n5hx+PI0lcfvDajQMge//zC2yB+G3oLfk1/56jV/AjfG1FyrYuO1hA6aeCsJDhD7KvblhSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063

On Wed, Dec 11, 2024 at 12:47:22PM -0800, Yury Norov wrote:
> On Wed, Dec 11, 2024 at 09:20:56PM +0100, Andrea Righi wrote:
> > On Wed, Dec 11, 2024 at 09:43:26AM -0800, Yury Norov wrote:
> > > On Mon, Dec 09, 2024 at 11:40:58AM +0100, Andrea Righi wrote:
> > > > Add the following kfunc's to provide scx schedulers direct access to
> > > > per-node idle cpumasks information:
> > > > 
> > > >  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > > >  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> > > >  s32 scx_bpf_pick_idle_cpu_node(int node,
> > > >                                 const cpumask_t *cpus_allowed, u64 flags)
> > > >  int scx_bpf_cpu_to_node(s32 cpu)
> > > > 
> > > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > > ---
> > > >  kernel/sched/ext.c                       | 96 +++++++++++++++++++++++-
> > > >  tools/sched_ext/include/scx/common.bpf.h |  4 +
> > > >  tools/sched_ext/include/scx/compat.bpf.h | 19 +++++
> > > >  3 files changed, 117 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > > > index d0d57323bcfc..ea7cc481782c 100644
> > > > --- a/kernel/sched/ext.c
> > > > +++ b/kernel/sched/ext.c
> > > > @@ -433,6 +433,7 @@ struct sched_ext_ops {
> > > >  	 * - scx_bpf_select_cpu_dfl()
> > > >  	 * - scx_bpf_test_and_clear_cpu_idle()
> > > >  	 * - scx_bpf_pick_idle_cpu()
> > > > +	 * - scx_bpf_pick_idle_cpu_node()
> > > >  	 *
> > > >  	 * The user also must implement ops.select_cpu() as the default
> > > >  	 * implementation relies on scx_bpf_select_cpu_dfl().
> > > > @@ -955,6 +956,8 @@ static struct cpumask *get_idle_cpumask_node(int node)
> > > >  	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > > >  		return idle_masks[0]->cpu;
> > > >  
> > > > +	if (node < 0 || node >= num_possible_nodes())
> > > > +		return NULL;
> > > 
> > > 1. This sanity should go before the check above.
> > > 2. In-kernel users don't need to do sanity checks. BPF users should,
> > >    but for them you need to move it in BPF wrapper.
> > > 3. -1 is a valid parameter, means NUMA_NO_NODE. 
> > 
> > Ok, but what would you return with NUMA_NO_NODE, in theory we should return
> > a global system-wide cpumask, that doesn't exist with the per-node
> > cpumasks. Maybe just return cpu_none_mask? That's what I've done in the
> > next version, that seems safer than returning NULL.
>  
> To begin with, you can just disallow NUMA_NO_NODE for this interface.
> Put a corresponding comment or warning, and you're done.

Ok.

> 
> On the other hand, you can treat it as 'I don't care' hint and return
> a cpumask for any node that has idle CPUs.
> 
> Returning cpu_none_mask?.. OK, it's possible, but what does that
> bring? User will have to traverse empty mask just to find nothing.
> I'd rather disallow NUMA_NO_NODE than returning something useless.

I like the idea of returning a "random" node, or maybe
idle_masks[numa_node_id()]?

> 
> > > >  	return idle_masks[node]->cpu;
> > > >  }
> > > >  
> > > > @@ -963,6 +966,8 @@ static struct cpumask *get_idle_smtmask_node(int node)
> > > >  	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > > >  		return idle_masks[0]->smt;
> > > >  
> > > > +	if (node < 0 || node >= num_possible_nodes())
> > > > +		return NULL;
> > > >  	return idle_masks[node]->smt;
> > > >  }
> > > >  
> > > > @@ -7469,6 +7474,16 @@ __bpf_kfunc u32 scx_bpf_nr_cpu_ids(void)
> > > >  	return nr_cpu_ids;
> > > >  }
> > > >  
> > > > +/**
> > > > + * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
> > > > + */
> > > > +__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
> > > > +{
> > > > +	if (cpu < 0 || cpu >= nr_cpu_ids)
> > > > +		return -EINVAL;
> > > > +	return cpu_to_node(cpu);
> > > > +}
> > > 
> > > I believe this wrapper should be declared somewhere in
> > > kernel/sched/topology.c, and better be a separate patch.
> > 
> > Maybe kernel/bpf/helpers.c? And name it bpf_cpu_to_node()?
> 
> Sure, even better
>  
> > > > +
> > > >  /**
> > > >   * scx_bpf_get_possible_cpumask - Get a referenced kptr to cpu_possible_mask
> > > >   */
> > > > @@ -7499,11 +7514,32 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
> > > >  	 */
> > > >  }
> > > >  
> > > > +/**
> > > > + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
> > > > + * per-CPU cpumask of a target NUMA node.
> > > > + *
> > > > + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> > > > + * valid, or running on a UP kernel.
> > > > + */
> > > > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > > > +{
> > > > +	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
> > > > +		scx_ops_error("built-in idle tracking is disabled");
> > > > +		return cpu_none_mask;
> > > > +	}
> > > > +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> > > > +		scx_ops_error("per-node idle tracking is disabled");
> > > > +		return cpu_none_mask;
> > > > +	}
> > > 
> > > Nub question: is it possible that scx_builtin_idle_per_node is enable,
> > > but scx_builtin_idle_enabled not? From my naive perspective, we can't
> > > enable per-node idle masks without enabling general idle masks. Or I
> > > mislead it?
> > 
> > In theory a BPF scheduler could set SCX_OPS_BUILTIN_IDLE_PER_NODE (without
> > SCX_OPS_KEEP_BUILTIN_IDLE) in .flags while implementing ops.update_idle().
> > 
> > In this way we would have scx_builtin_idle_enabled==false and
> > scx_builtin_idle_per_node==true, which doesn't make much sense, so we
> > should probably handle this case in validate_ops() and trigger an error.
> > 
> > Good catch!
> > 
> > > 
> > > > +
> > > > +	return get_idle_cpumask_node(node) ? : cpu_none_mask;
> > > > +}
> > > >  /**
> > > >   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
> > > >   * per-CPU cpumask of the current NUMA node.
> > > >   *
> > > > - * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
> > > > + * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
> > > > + * kernel.
> > > >   */
> > > >  __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
> > > >  {
> > > > @@ -7515,12 +7551,35 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
> > > >  	return get_curr_idle_cpumask();
> > > >  }
> > > >  
> > > > +/**
> > > > + * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
> > > > + * per-physical-core cpumask of a target NUMA node. Can be used to determine
> > > > + * if an entire physical core is free.
> > > > + *
> > > > + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> > > > + * valid, or running on a UP kernel.
> > > > + */
> > > > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> > > > +{
> > > > +	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
> > > > +		scx_ops_error("built-in idle tracking is disabled");
> > > > +		return cpu_none_mask;
> > > > +	}
> > > > +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> > > > +		scx_ops_error("per-node idle tracking is disabled");
> > > > +		return cpu_none_mask;
> > > > +	}
> > > 
> > > Can you add vertical spacing between blocks?
> > 
> > You mean a blank between the two blocks, right?
> 
> Yes
> 
> > Anyway, ...
> > 
> > > 
> > > Also, because you use this construction more than once, I think it
> > > makes sense to make it a helper.
> > 
> > With a proper error check in validate_ops() we can just get rid of the
> > scx_builtin_idle_enabled block and simply check scx_builtin_idle_per_node.
> 
> But still, having a helper is better than opencoding the same 4-lines
> pattern again and again

Yep, makes sense. Will do that.

-Andrea

