Return-Path: <linux-kernel+bounces-570438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC60A6B050
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5815C3B9E52
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E8B2222C3;
	Thu, 20 Mar 2025 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r5Nq5ori"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010351EB1AE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508520; cv=fail; b=mPp12514n5H/Ae6UWxrauCqVcGO7BP4JcmiqPSeVtehjFsRk92BvVmeqfDBJJlJrAt4lLHr3ADpYiF0c/ICGMOFHNxc1IFMsPnMcY/WjuTRM8HL67n/zdveiBdeUuIk08lGeIt+mOOlnxNVkjy4knqEZ5D8byTrxFrT0x/lydeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508520; c=relaxed/simple;
	bh=zcmjBxdfszFZUjEZRDke7z6d4eZP08BKnXXNkYzCZjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AxpdH3NTQIE42h94jLvkFkoO7EYTxVZsN2n+Dxw4l0vVG4Rtzr38duDVfZvnBx23BY9P1mwgjxlqBhAVoY369jIgd/iqsQLLuWZnp56Ss5jbCoIv67xOcDbzjN/u/IUqCpZHzrcHFZWO2zSITucYZbcHM+inqd63NRgvqKhsnBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r5Nq5ori; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URQHj01AxmN/W5T4EzxPfQAS67z8KAFYHHVSAScuyYMRJ8hP+9BObyOo6kRrgv7LuTXl65i0ok4q75thhUcw4t6lgIvhSyPHAocwxs/qK5aRsxf8qeBxJOTjkjlJ9A1z6ujMOgvjZt0NP6r3kvhqfklMCEyl+hYPk1l0Ycy8tM5qYfHJVgtLTLFLVTE41mA7vDRrgBMEivf392YhRL2HOCD81C0qRx0YW1i2XF5qLuUW4ZzWL1WTgspRa/qHvx977r5+SBkc1MWIA3OAyWzhMlAO1mObyTJbDBK4EffrAkAbRc4u80ecmSUXSRLY00kTE4Kr2fM45I+RBzBrabIndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gtNFVUq3hHCbrc0mAfYcbcFW3HjoIs/be9N7vSZkQk=;
 b=D4XeL+CLab/4mA2AGoKZkENU7wBOxiU4iZq0yChJIyKP4lJeKEl6h2OlXp3Vv4x0F+ujDrdUoWr45vXNYhGhZTXWgJwqzgNsuAPMdqGE+7m4rDpdxe/eVOywtAMMFS80aeDtrvEuNTHoUdRXQpeHrAYTswb/PW6IuNPvjP6oCozhxqrg2i5nnT3M+Mfy1yISX8IvbAXt0vTAM2hBOjhbf3Qu2epsQO4KyEgFxG4M9eR2NH/XHSGy8KxBrkLAdXEwrRp1CjZW+kBC5+bYnoZIdji2RytP/QY8nqgYc7CUheCUJxeTYCSbxQGUlubBVeyJbrdycWU++gzLbVU8Z4c9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gtNFVUq3hHCbrc0mAfYcbcFW3HjoIs/be9N7vSZkQk=;
 b=r5Nq5orirO4axLTSFhBSn6EWpna4jl8wIuwh046EoCc5dFQo5QvxhqVYP4tW/arPkSMnVw2toMYJyb1NhOi+z8PPguNDT342yATggU8ifNmfb7PRTXaz23RLhOc63AJtt8IagsDgHb2RzUB9EnrhdF7gU5Ouy6yXRAPueuJ9u96eUw7VDtsJEzIn6mFdG7HClD6EYItOIQaE+tQo4rb2Ed8iuC27JCjpO5INkxB3CwGnqPELItjkHkMtyMzsKxtfkx/aIVl7Pnr3hMVl2JqCQlxb5y6xE19Gc/wHFYcO09Mz8Ly+jEuLb+wgd++Ms67+C6yx6NHQFq4+HWzAV0FLHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 22:08:33 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 22:08:33 +0000
Date: Thu, 20 Mar 2025 23:08:21 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sched_ext: idle: Extend topology optimizations to
 all tasks
Message-ID: <Z9yR1TYxni6wddnE@gpd3>
References: <20250320073927.216147-1-arighi@nvidia.com>
 <20250320073927.216147-2-arighi@nvidia.com>
 <Z9xHK8xgnWjXQ1-p@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9xHK8xgnWjXQ1-p@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ba051d-cb79-4dea-643d-08dd67fbc131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W10hN6QkDhUp/oZ+Hhv8VfYYJvP1vdH9/Omf7i1kCb31I/0OCBdkulR99x25?=
 =?us-ascii?Q?bNext0ysahxCd00L1xbEyLYuWgH5S2Pdh/U/lTFADkELIv/j4e8tzMt5APfq?=
 =?us-ascii?Q?RJk4W+SW3yMHtsfLOCfHiGcK5ufsZz9HDHHMSdTPnx5rInSrhb+1vMutxh+l?=
 =?us-ascii?Q?Fwr9ZIhLvZt02dols6jXpKEDgr6/8TF6cebB6t9UNHi1f1kiXyBioUKuoqm8?=
 =?us-ascii?Q?J4eHn8ZziJKO7iGR4Hu0vouX7Z+/1sNiQRC4qiLVU+NPkLcKLU3rDzJ0fbO3?=
 =?us-ascii?Q?uHQvfCaPbHxhmDh4Yw/LdHLxGt2WxVb2RBuFtLMpEV5orcZlvwVgtgIYq67R?=
 =?us-ascii?Q?jD6/DpAOPbGSYpQ9lyqQqsAZfdSPeyNkqVj+bofACKCpaCB3kGiR0Y0+WfR2?=
 =?us-ascii?Q?QynST7+MOdCH6BDwmgcHeyipHvLj1mzyv+O/CYOzcH8SMGFaE1POA/h8R9MJ?=
 =?us-ascii?Q?JLjgk4lDqKa03QLX7HF1tqLBrEqNYi6mPj5RiEcr0erg3PCcgG/05aeuYvGe?=
 =?us-ascii?Q?ES3PT2cQi35GX+G1ebLyp6nkcDXTGT9/PaaBOFe516T2t/T4C6srYhT8X8ru?=
 =?us-ascii?Q?B5UPeA7gMvhvDKSXeRYf8U/TJrALZ9Pot9Oqe70h44rBHIoaI06ggTLCV4lz?=
 =?us-ascii?Q?xqxALpxMX4ky38vGzvt5lvnToLW5tLWFw7ZN/1yc495IO4EAozn+dwOHk3dP?=
 =?us-ascii?Q?RUlI9JYEkIKZmuNhlaAAg3yVzyTkvdpXw1rciAKH8Kh2Z4UuWAXtI+I9wAr9?=
 =?us-ascii?Q?rDOG0peQ/3pVKuitbirq9I0/KOQbMjUFz5qDiBEhutN2vwBarzQZAEl/+2k9?=
 =?us-ascii?Q?LxrmVfS8eblWkj97CTatkrkUUR075wAwTh8VgoV/495yApZWfuxTXEawH7Fo?=
 =?us-ascii?Q?QTt9YKnWJwXqc0DzZah7FNXAo2P3IxwtBpxTfMJeUuBevKEkg4437Gc1d4bE?=
 =?us-ascii?Q?66zelrrbB3c2lwF5dBVN/PhXK2xKx8nS+FlAhoiEtX2FX69Ou8QFgvJo7J0a?=
 =?us-ascii?Q?Tdxct63cCqGn9e4d55Dq5o4HxFRAxDxh/8QhYNB7/LWAI0faev9rABFOXmbK?=
 =?us-ascii?Q?6easCPY5fzaeyYjXey4dmIhhE1lYLmlyDuSaZXsI3vTdUJMo/L7JqEI2uv7K?=
 =?us-ascii?Q?+ak1LBR2mV6Ok4B7DlfOE4CIWZ8ws2ENIP33GD0tf65BJa+cLK8ZPcpJ+Xe3?=
 =?us-ascii?Q?g3FuHrXxl4c1QWwddQ5IR7+ydhx/CY1YVckv4Q4zWpkVmddtaoc2zk5M6K0G?=
 =?us-ascii?Q?vyOVQCgKce1e99mHMjTS+zddo9LSRhJis7TRjNSwI1YNn/kuQmLtBGL6NkFb?=
 =?us-ascii?Q?JRAFIYgFiKpvlteJLDfO62vrsuD4KHVd+0hErKFwq0pl5a1aeZWAj6nVhhNq?=
 =?us-ascii?Q?8PEPnFakVoH51NLptjUFnE7Cq1II?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fhnnU9lkI8goIcPZa5SS00K4PBWAyDDBe27VBwUq9gdavTp0Vm49BsYfjUaB?=
 =?us-ascii?Q?voIUZsxiSaUfRgsi/4Arv7TxqJfZcReEWcAyge6l7gx2NNzj6ZblVHma17ti?=
 =?us-ascii?Q?sDhAu3CSa/hHZ/JbQiFzBQ4YHfQggODB6ow1I636MVHLJ6a22WnNEmw9LMog?=
 =?us-ascii?Q?TT5DIqTLhc9lcH9+/DIb61S4qNxHylrVszIatUhZHxQGgAQx7S3DPPj9mqP0?=
 =?us-ascii?Q?oDPu9wYgVO9aQ3KwyTFt+ipDgHcHctAAxAiwzhUc+uKYX/TSz3VGiCscc5rk?=
 =?us-ascii?Q?dmvez9tzZghqFSg6XS8FcpG0lzUc0XcWff7O2G5ZYoruk+TWsX8pTzac5eLH?=
 =?us-ascii?Q?zGUvMvHmGVU9Mp1rEvFBDSC4h1r5UJfIgHTtAlJvN2cL+rJNJAfs0ufNbOpe?=
 =?us-ascii?Q?XI2JHL6qKv8WJJwoSD3ixacuAfhqS2jXW+5G9T+NwU/GFHYzeoHqJqW2gzWl?=
 =?us-ascii?Q?EbxY8o2MhXaXTe3L0fGrOvmCR4P6P95z14G2Sgg+cLGzhN5DSvzY/G1LT6PK?=
 =?us-ascii?Q?3GqTIj4+W3Kwc/OkSwSASyLd98w6JoIGEfv0ib4XgatxXe/jdLnf+H/c2JU0?=
 =?us-ascii?Q?lcaV8TAUZ3bj/gMfnG/0tg40Z1t2U/pwUs6O2Bz1SKmk7uNYzQPHlPHaLUBV?=
 =?us-ascii?Q?ZN+VW0beZPEoB0ao3ZXO8zXcwnhqQbFEhM36P2ZoPoSIm/upbp5ZVeldSS/X?=
 =?us-ascii?Q?yOgwlGCjWYeEqL7z2oECce8MWAFNLsYlJbpXLcytnVG3YbNlA3gEtTykLQFJ?=
 =?us-ascii?Q?GmRSHtPrnHhmc0eBndj7lVtr7QMI0Z0jD08PCYQztZfgtqLJpnnRCxNMeNVW?=
 =?us-ascii?Q?uxHWp/HKx2W1pH8ciIv4XRWmZLGKCQlIXyrARf+ablT3C45fsajnKTB/xL/b?=
 =?us-ascii?Q?odCabZzAyqTLyZ/VvV8sfJH6g670YpnTnAIg+FoJYi86d3SIsMr3j0J1kDFq?=
 =?us-ascii?Q?S6i5X1+s8xIH3LGLPDtshgnD4FcWhqSNFraCcPpxCXmm71UilSgVfEETHsfc?=
 =?us-ascii?Q?gJ6UdfvLiYu44FYhUJL4nVkRDVniE5GG9hbfk56pOdoSmDHyBjclrhDi477y?=
 =?us-ascii?Q?pHdJSQ52qcWRzIWEYaKIbZgMlZT5QDzQBqx2UoRNrVjojzyohyzBylQm+6oL?=
 =?us-ascii?Q?h9CcacKY8KKCjumPi0L7wYZOzGHHEdkBEnqfwXPehVCjkx6cI8cE2VmH7Fvt?=
 =?us-ascii?Q?48xUuyiz8y4cxHAby2k3rkFFmCmH2CpnT23artWCtHB81apjOk13JGz5IoF+?=
 =?us-ascii?Q?x1fPLY4YfHOMtGFoa/nQoXbDpIk+1a+Ga3xze/YkOfdYWuzigdgRDoHcDRkw?=
 =?us-ascii?Q?DuTd+jB8E4v4zMkRtSK8cIgY8XHnKZ5NYFb3eSflMiiCDIyX1DMOGeJ5fonz?=
 =?us-ascii?Q?iKT9FJ3RJri+dhoNryuBNvotwlklbUwcNzImQJV26F0ZXy9MeJjdTouVDp1u?=
 =?us-ascii?Q?yTMa0yuHzU4lG5QLzpRJlDxasrh0SuVm6Rtm+Z8NpJr4khHeoYdNwCtDatRl?=
 =?us-ascii?Q?7WhUyf+8VKrQR0tBuHA9y4Wc1XU/Q46378IwmAQSWey8OKhJDQ9DeZQ/HTS5?=
 =?us-ascii?Q?rTiaq7HarjkuHWT1aMglrq56FQYRgM9ZtPgJVxo1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ba051d-cb79-4dea-643d-08dd67fbc131
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 22:08:33.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdUjFPD+cuIzLJ4DmwvqOq5C8ubHuw5Dm0yjCnQcoDNeUYsrz6amaGlH+SQYKuGqFikFxEqEFC862I4H5A35tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8

Hi Tejun,

On Thu, Mar 20, 2025 at 06:49:47AM -1000, Tejun Heo wrote:
> On Thu, Mar 20, 2025 at 08:36:41AM +0100, Andrea Righi wrote:
> > +static const struct cpumask *task_cpumask(const struct task_struct *p, const struct cpumask *cpus,
> > +					  struct cpumask *local_cpus)
> > +{
> > +	/*
> > +	 * If the task is allowed to run on all CPUs, simply use the
> > +	 * architecture's cpumask directly. Otherwise, compute the
> > +	 * intersection of the architecture's cpumask and the task's
> > +	 * allowed cpumask.
> > +	 */
> > +	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
> > +	    cpumask_subset(cpus, p->cpus_ptr))
> > +		return cpus;
> > +
> > +	if (!cpumask_equal(cpus, p->cpus_ptr) &&
> 
> Weren't we talkign about removing this test?

sorry, it's actually removed in PATCH 3/6, but I'll clean it up also in
this one.

Thanks,
-Andrea

> 
> Thanks.
> 
> -- 
> tejun

