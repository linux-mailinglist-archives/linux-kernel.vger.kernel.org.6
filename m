Return-Path: <linux-kernel+bounces-576524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01616A7106C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373003BC251
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC5188A0E;
	Wed, 26 Mar 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QFY/4UFs"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443DC5383
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969342; cv=fail; b=oMbVOSVkocbcvgK+ZeB1iK58M7bIDS+ojAY3rTihCIoiZSvgDzhuaQhZrlLRnzDp5xzJFqqyr1bFyGuSq4Lwepdd0tbCiLRNhB4V/8qpVcicubctHOqRs45egKjGNxhyg2EwZoh+7LJbsJu298BOgtoh+fM8wNKSBLajn6Jp1Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969342; c=relaxed/simple;
	bh=jHeIY2YaJTD7PV+VA/+7udkPSz2LtN/umBMVm2oi2XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gqTM1ysI5Es9Dqd4qIOOb7ecGzKg9nrzZPL5tl3KAJN1NgoA3aM3XNt4/2G8fX8SxXrWnqMnhz/iLdQS+YvolarE0Nd4+ZbYBzETtCN1JNFwMKk1VwZs+JP1BdxycZeb65YklYApyNUetXGJX4eM7PXeYOFMayjoX1HxXyw7Km4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QFY/4UFs; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqNQ7qTCv3UjHE63YAvzqp/JcHZ0L+QurdCneLhAHPXynuoYiyI02OCToH4Ofn/LNSBtmiAKWNm3E8qNwbHicNCtSieqbZlsgVsG86QdZ4jMhNuy3iRv9cQRAkDf/qSBxllkOwhZu6+gmcMXitbLO4+oRSL66Dhw+zA1L7N5UNPnWJSnW9N5tnbOGUPxFnrIzEXQycCDPvGllI5Ep41FqgK5pQ1ZcyXSHMHTAlejxFtWwlHMMTaG1pr+MGCi9U0ucXQHzpRA530oiXh83tUBzAKP8KUAh7+msk/7/2A5G6sMo9erKgavfE1a1bgZB9Oy8VmR3wUXHw5axE7DyJEuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpLzdXDV9SljxcUGjkfo7fbHjsHTu2UHjyDCJVrKtYo=;
 b=UO9UDuX5E1g3ktUTtLePQnk5YtIWK3yPolMEVsvEVIZejwnc7t3Tx3aNSQ3PK6sH/NgHVsstEAMuSWxu8t4ep1jXoriVbp4qncz98laHEVmJfRUy9e/fkbvhjUwxXVvbNkO0s7WZiyAmADMzWUyGdAwTSKY4ohAL2jnNQhCRLy6V+vEZpcXBQdyQgUMKkoiTK8rxx01NMTFriBeNGU0hDXdLYECLCQc8J9BQTQALRCAA577g2Yo5pc5L05ljFOrPFP8f6RqncommqITJ2TGhOLgWq4/BcpLeK2VKBEApfef7QMREbXYepab30WIMlUWegIviiQ8+9g1UosBw8MFnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpLzdXDV9SljxcUGjkfo7fbHjsHTu2UHjyDCJVrKtYo=;
 b=QFY/4UFsIPHSbc5I/x5h+dCONbMjSNtcfgnVS734M1po96B3Q95eegeKfsK2ne3iJlTGyhpaGirBYhgePDhA493vvYuLuYTCjwC+yluWhThJn5egi32gQ9ENHKTMGdS2DHCJpNKyZbuGvtLCWNo5SgiyluednY0HXFcZZIHmnoiCAsJRz2/cCk+RxYiFcC4hUByI+lRlxmE8/KHJuT3K61J3B9I3Qn7+j2mJXEjZ+D+TooiN4VTVpGHGJnQlI8kOJ/8BYt8tkqmUfoRdB2X0+6EtD+drASk5GOaO0KPq2+mcpOsiPec0M7PLtbUzCZIyr9ph3CRj98Ph8Tq4lBF8KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 06:08:57 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 06:08:57 +0000
Date: Wed, 26 Mar 2025 07:08:46 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Jake Hillion <jake@hillion.co.uk>
Cc: tj@kernel.org, changwoo@igalia.com, sched-ext@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: create_dsq: Return -EEXIST on duplicate
 request
Message-ID: <Z-OZ7tJWhRZbUk1l@gpd3>
References: <20250325224041.14088-1-jake@hillion.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325224041.14088-1-jake@hillion.co.uk>
X-ClientProxiedBy: MI0P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::13) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa37832-f241-46e4-51c9-08dd6c2cb179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YR40I5ge3LLFFav0kvltu3rqVskgdgPTIA4LooXm+amUWB9UqORXtQImkJbY?=
 =?us-ascii?Q?glPxnHtjDsz8ddoxgqHsbv+9XxB9Oe2gqNIAGlKCXJYsoKA05E/wO4HiY1S/?=
 =?us-ascii?Q?gH8HbWcsdk+OT3By4eiVLB8fiMAdaLFtXy+Pc6eYQ1K+8aoJMGolFSKXtTDC?=
 =?us-ascii?Q?7diqIzH8T1fSIPAuXGY84mURTiLub6SJFTTa4KMXXaYEvrF5JvIYpy+1cjp3?=
 =?us-ascii?Q?ugPEjWDs2i7m9UOMUJdqDq/wzSpm/omH7f+AswH6eneJrPj1h9El0vVoErFl?=
 =?us-ascii?Q?od5pU1ZIzWdEOvF6sE47fFIB95uaFRbmwoWRilnBuxpWIGOtnNEC9J9ShiCk?=
 =?us-ascii?Q?W7iegvxA3Ujnd+CH1U6iq0WXM4mZ2EIrslKeJhHL1c6ouuQrW0v9Rt2V7mF1?=
 =?us-ascii?Q?w+F3JgObyErw3Q8taSwzFL+TojnwdCL8D1xeLOTRboEw3DrjZ3HVMmifgGU5?=
 =?us-ascii?Q?3uP0j/PZcTlTN6f789j5QsnbZh70iyKP7MNjyt5CuuWQaacl5HnZEEzFfOqo?=
 =?us-ascii?Q?HfSMGZoGl8fqApLuQQnhVdxoX7eJldKPMGDSsP2aza8pW9SbyW6Ha0SS24IL?=
 =?us-ascii?Q?zMWHKYlkrd56Jc+h6Sno3q/J9RL5OP2EWDofdBpBodxoUHTA5BgTourCQJuH?=
 =?us-ascii?Q?G9gMbW2XrXTN5Pva9TV+3GIl+wlNRBWn6/S9/xQAyiTsNfsw4vsbLxr3FKs6?=
 =?us-ascii?Q?e617THcJEdhgWm29MKxnrXkKFA2frHfCsJQgfAYP6FYD3k0fcrGRasTXmjXF?=
 =?us-ascii?Q?/P7JPdaVDvssG8vLlyhx9FBM7SH7PUp5JNVYVe3GzO/H15YqVFT84m4gWdz/?=
 =?us-ascii?Q?nYaRGkkSCyjw8PbH7q4zKVpHvWKcRX7D37T5/PxbAgiAcnnWDwZCuBcbOJQA?=
 =?us-ascii?Q?S61vtM+GAfS4f2OmKPRierh4a4fKCtBuR9r8IYXsYJYVCKURq9z8HPj5G5P4?=
 =?us-ascii?Q?I9KcrOQCBQdy7EMiHJyiXsNGynSrf5uALJ6os3BC62LNoGqoC6OeMB6Pz95N?=
 =?us-ascii?Q?z9t7u/4xQySHG0gFGEjcN3Hd0pi7UFW1fh0Bv11MqmzLx/HIrxSa+F4FvyIz?=
 =?us-ascii?Q?YhEC0LMMwB/27fDgCKDzW9ml0Vfl20yV1ANj2Wahu7IsCejDQcnsUPa7/csr?=
 =?us-ascii?Q?MHV0eUgKMM3P9dk5C3q5gI8F9OwhZFXEC58hz1Gk5DS+0WofWG95+ugUebZV?=
 =?us-ascii?Q?BDLKXzENPWGcpOpFRVz8gQC58aH0xuQn3tpjWbKtsJ2T4FCOQ15bvIPVgdF/?=
 =?us-ascii?Q?EUNs5LACMMFxIOGQUNbPNqIKvKP4ZQIt2ZvNEJ8/Ee6x+j2hsWGvrp7DAaUq?=
 =?us-ascii?Q?mPC92+H0iMMhmccmE+wPby8OC/wrTDfP2LQ8iWg4qUquntKhenKYICXx0T9s?=
 =?us-ascii?Q?kV4/PEM9cx1wWV5g0/LW5AkKUSW1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X8QFgVBSvKZtL4p23MRyWJHG24maqo05QXze5j0glBccX8QqM1bl+E1Fp9s8?=
 =?us-ascii?Q?vctmFcp8w37Hbf9ZBOTzyaixBwCk+TRw6VJgwZ/AzF/7jHVLy5gcjFsOGmoR?=
 =?us-ascii?Q?1gy4C5lUr12kjwetBFBS2TKVb4g0tI2TlKBSIFYssVNFXJIiEa3iJb5BapCv?=
 =?us-ascii?Q?VW39+cHg1+c2wGomz1egyTXy38zmDRR5ZHXfw3gbzeX7R2UBVC532sqwujzE?=
 =?us-ascii?Q?ldMEq2o4Pnd28r6ULJgbD29/ugEwKby1BFargVMfZuM+jCkxzbQhLC9pDD77?=
 =?us-ascii?Q?TkrJ2kyp91NUuix5IoDpnJ0qz8wJcf693kbUhpIdNPTyRnQSUjPIRKJ2MRsX?=
 =?us-ascii?Q?a0oOC8GFywkcZn4Db6nyBkcvihu6MmYJ9NSnJ2sY3Rho5BPBJeM43qpa0chP?=
 =?us-ascii?Q?451MU2pjbcSwYDU5hlkfjfLudmbtKwAvtNzX2l9NKsSlnzLWygjgmpnemT1M?=
 =?us-ascii?Q?d8NRDxnWBfDYH/jnID6QrZDhx8tBgZHFcaqsZyXJX3u7Q/OH58UuNlGqPkou?=
 =?us-ascii?Q?ljsDSiE95GLr2bt9MI3KBFb1DzKYwt4jODX3e45DLGLMAAQoNt4ooEU73slo?=
 =?us-ascii?Q?8m1z01xiPEibUvrgB+0ArDbdHgH+2qYjZerocEngK0Z4f/5t6TQuMNZ1yUU+?=
 =?us-ascii?Q?P4lYXA0s6wMH8OocF+i3KYA1R2AjC8135pTevd+xMLm5Ds1FNa/1+XHw7rM0?=
 =?us-ascii?Q?9wcfa7VT67oXZSUAx0LZ+8ND1xK1RXFqhe1GHBhTogvft762GDVk8oF0cl1P?=
 =?us-ascii?Q?NszNiSS3KtzEy99aHjwwlEEK7Qhak9WFbg2IMhtdtQEJuO5xF8A7TJNE1P/G?=
 =?us-ascii?Q?wrahktA1nnTbU5Lrb6r2BTLdbC0mEZnxCaI7j9b7zahfDWXzvaDbtRStkaia?=
 =?us-ascii?Q?pSwqYTcVv8apnYnUIbos4F2RbMpcOu65EbjMe7/YZ7AQkTQD+PX8BhBPtNws?=
 =?us-ascii?Q?6WxR82KkU2qzvCyHiX72bqW5ZNAl6n4YLlms4f/utHoi8ZFbP2+KqaBpXqn3?=
 =?us-ascii?Q?+IJD4ygwCEf/HZGTokkGiSQCrkZuLy1YwxE6rep4EqHc6cgJPImG+vsODXVk?=
 =?us-ascii?Q?/TLQnxCXgC29+xdlGEbDrdHVqrBQB2/4oP/hNz70232YHat4Ememk5Cu1b9k?=
 =?us-ascii?Q?PKvTMhBMLTBPvYnzuYKlwXbqQFMwXODndjuD9ne3qce/eux/Cjh4gM/dDVpZ?=
 =?us-ascii?Q?wucqpO9MR+jOKLS3/TO622f4VSamZyy4Wch8mabFmBpWEwBGlP5AD+n0CQij?=
 =?us-ascii?Q?SPsADP8/tuP9mxD3D28ePYh6vs2dR1odyLMj3IHQflp0vsyQokvYG/PNUO3X?=
 =?us-ascii?Q?OBLYWqF5Z+8mrM7gSCZfgSFN5HDQdLugBO5TeSNZPi+fWUINV5TGCRYehFz2?=
 =?us-ascii?Q?2wwUD/WLKm29RLkpiOAymxFUFVmk1SHRA8tcW1UIRQTe2cV6cRkXD/5XOEhW?=
 =?us-ascii?Q?m6FqEfrxF//Wzp/DB9wBO8BU59xFVtwDZUrIKbHG+OlG+J7YkdN2ba6lb9t0?=
 =?us-ascii?Q?tmzbFnrCx7gOBhJT1NgS0x+Xb0DRvhrUpeJqQRKCjrioFYCuopQaWZ6mnizk?=
 =?us-ascii?Q?RFfn16T+f+9Q15Rnra1J15t6JvCZ/ovC+fnhux7+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa37832-f241-46e4-51c9-08dd6c2cb179
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 06:08:56.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDWB66QwQkBVK9916cnYJZm21E+admFLaM5mQullH8r+3m556Sh/Su8j5cs8YT9XF1LPBQWxwo5evwcecEi+dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825

Hi Jake,

On Tue, Mar 25, 2025 at 10:41:52PM +0000, Jake Hillion wrote:
> create_dsq and therefore the scx_bpf_create_dsq kfunc currently silently
> ignore duplicate entries. As a sched_ext scheduler is creating each DSQ
> for a different purpose this is surprising behaviour.
> 
> Replace rhashtable_insert_fast which ignores duplicates with
> rhashtable_lookup_insert_fast that reports duplicates (though doesn't
> return their value). The rest of the code is structured correctly and
> this now returns -EEXIST.
> 
> Tested by adding an extra scx_bpf_create_dsq to scx_simple. Previously
> this was ignored, now init fails with a -17 code. Also ran scx_lavd
> which continued to work well.
> 
> Signed-off-by: Jake Hillion <jake@hillion.co.uk>

Nice catch! It'd be nice to test the correct behavior in
tools/testing/selftests/sched_ext/create_dsq.bpf.c, maybe you can send a
separate patch for this. In the meantime, this one looks good to me.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 21575d39c376..b47be2729ece 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4171,8 +4171,8 @@ static struct scx_dispatch_q *create_dsq(u64 dsq_id, int node)
>  
>  	init_dsq(dsq, dsq_id);
>  
> -	ret = rhashtable_insert_fast(&dsq_hash, &dsq->hash_node,
> -				     dsq_hash_params);
> +	ret = rhashtable_lookup_insert_fast(&dsq_hash, &dsq->hash_node,
> +					    dsq_hash_params);
>  	if (ret) {
>  		kfree(dsq);
>  		return ERR_PTR(ret);
> -- 
> 2.47.2
> 
> 

