Return-Path: <linux-kernel+bounces-543299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F22A4D3FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C1D3AE891
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A971F4E49;
	Tue,  4 Mar 2025 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1ygHfun"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E301F419E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070519; cv=fail; b=aCjHdo/uOiyHnOQYfY7SUYg4YrDypvNwFxX2BAHME76vwY/Bd7OT7amCaApd8pv5qu+ImuzBAbt3hopQJPQ3zMVPxVM2GQk7ayR48X68dN7Ex27gKmHHOzHiFSLF8I0kFihCvX0juKhZjOZvqz/4IJLNqAhU3Rhcb+R+dST/DAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070519; c=relaxed/simple;
	bh=h7Q5NUSfpknzMbuD9HUsmFMm/D+DxkMgexoxd63iQQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L4YIIc3dsIxOBmYhwjZr0+DXXBLW7Q4B4Sq8cMIOgnnBXA/aX3XPGKjOh0yISYnqqtEIpT8C/G5tHxFWNSLwxV1QOT+N+2Q2hXEutoRfVphFTxVPWgTdI5x1+tHi5aOUC5Dgol6PSAPKOvhAbLr5uXCp/LcJi08hZIYY/K5P8XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1ygHfun; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jemYbtVsuq+NXdnbST2Y3xQmNF6QJBMiVdw1/QtrNm0YmDvqHcTv3Q97nAQB2u6RoYSR561/ulYqN8pO3FZpnS99+Ve0uBsTTjveoUplDITtctr8+9SMsNk91uNpABAk2qCfpyJBMgWhx9QxImmHWyzpOD6Cz53uZfHkjj14aCgn0+eKv069ksUPsZQIa9xVdq/O9pIRs28RiyOuAhbTA7/c9hN8a7Dkf1HoOE0LNIAQRUkVMZLQArF7kpzuvgal3vIy8Pw/pG8walZ1VH0xQpMOdJhMbRdpZW+kJaynLfY2O+ZqA18ABudeVkjXQgS3q7EmW9zsylvTCKhfEhR7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fVVbjIpKA/e+Be7Sx5eJklYroUl6Q0ErvPnymLWp14=;
 b=F4hE8ohjdvOiD2oYeaoJAszUba9PF86qKM86bTyUIi68TTMjiPg917IHQis2S1JHIhG7dz7UVpI5ASvsrtzwZ12MKcXPJ/P1ZatK17gfUs6sDlDIjB3q5voeoYmG6yVchB8RNQ4FplU5+etsFRvAY8PPTJM8ECH5qF10EOjfgq4IXPflY0PgyOSZxrE9DKVOvbWUGQDXuhXmzjzJ5I5ZViTIkbPBMrmsU7A9R7xr8xoqkIIrcbxik19EYlktxJk3BfclBK4MwgGoR4007idvp0VGwTz584r2gMCryJqyp1LoxEm4gK5nUZUYBzKEIRUuIPuM3JURFRhCNd/Kp3On9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fVVbjIpKA/e+Be7Sx5eJklYroUl6Q0ErvPnymLWp14=;
 b=g1ygHfun5fRh+XLnlUJEInMRnnDoMDLAS+XaAyKtNv7ThrRrtaoAGWc0wEOE6vMvbBqNpRiZaf2dPuKe2wIV/8/L3ECSRK7FzaNPnDKzCZAHhWeegSmUg24obrpSR87MFNiz/j8w+DxeGCJcBsjuCWTYpAfMLe1X43zdbwDqdouto89Yklf4HgfZq5gjemIwry4F0m+257f0/9UsShik+ySr75wIVisMIoPb0EhBcQMndyJ+nrDqi/aO6VgqX4Y/am74iQ76FmW/8hR6zXFT0P5zGCkoNDd6P+2fLOwtC5JoWgiOuX/GbljU3ncn27nm1bFh8po8SrFs36QlpXRf0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 06:41:55 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 06:41:55 +0000
Date: Tue, 4 Mar 2025 07:41:40 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched_ext: Add trace point to track sched_ext
 core events
Message-ID: <Z8agpJNFR30DmJG4@gpd3>
References: <20250304012740.35473-1-changwoo@igalia.com>
 <20250304012740.35473-3-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304012740.35473-3-changwoo@igalia.com>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a2d9cd-e842-4a1e-9665-08dd5ae7a75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhemr7N0gy+ohNxFU34rQW07UAzFKVwUvQcQwBqCsoFPD9UTlm+MR+H0ShEP?=
 =?us-ascii?Q?zLLvOfR0lUI2sop7V47pcfQ4LzRP6DW+X7B0iTwRWt7+XNu9gOiooLQwbuSV?=
 =?us-ascii?Q?OkFUiyj9OeQFjM/NEBGX5f1iHHrIS1lhRKjIWZ4BT1IBlx/l8Clz7lWlhvTq?=
 =?us-ascii?Q?9/tLrS0I9lvGoLoWRdev73slTfAEV3hkC8jxNK045nmf8hNTsNJlo+iXx3I/?=
 =?us-ascii?Q?G5YtbJBEo3Zr8rm79r0aY5Pht1QXrS6ixynFQpR6MBOhjxy5Gho4RyLbJnra?=
 =?us-ascii?Q?ByNQwtIHqRX417/rXamvnqEGknzlh8DyrH2t2mGT4FwB2nMtKOJKixSlRd/Z?=
 =?us-ascii?Q?7uhx1MT/58fLLy4CaEC0giXtkxrX2C1fnMnwvC7cRyT77H74peAIdK1bDT6t?=
 =?us-ascii?Q?6mhq2BPj4HGEK62XBsOJyelUDVlW2NNI3SXXTww0d+Q5xF2NqkrhXxwz0bwr?=
 =?us-ascii?Q?f3Kxt8dJk2h96fnunKbKO2KY6wvYeuPIVeP/W+cwhJeh0BWRRU6zw/WPfQ5J?=
 =?us-ascii?Q?k6tTrVcsQmYlP/gz7nY+SvBVTBMU+/W4aulbzcbkVUHYp6mHWDhotdpfl8WB?=
 =?us-ascii?Q?ZaIShyv10r0sYx/e2/O0EfstDIGLuB1Oikcc+EBS6n1BDq4ZaVJV6uhHHVlQ?=
 =?us-ascii?Q?mNGU7nBfRNfMfhQZFDNLYD1Arg1zVI27T2fcSg7cqtNBksVWUg0KXpGRDi3L?=
 =?us-ascii?Q?Aa11gki7GKcQ52n9XliU3n9YgXRoDB7UlEVA64MwTAeq2sgvXx7iztZvFOEj?=
 =?us-ascii?Q?b4WirgjA5sh/eDWoX6LW6WAyZbGgiFHnyPQWO97EfTB1yHNsyjRJqmip+y6V?=
 =?us-ascii?Q?lXT5Mln9VVuHuUPq3q/eyLf3Q9QpW9YapcsCwdYW1uzeTytejF7DLTiPm9eq?=
 =?us-ascii?Q?QTDD1EvKC6Sfd7tMAoF2r04Ak58RPL1aXTpzP8eDfZzLPdKef+KNA/5DFosx?=
 =?us-ascii?Q?2fGLZNFk6oTNhtVXwUE6I1OD1Tb5UhZeJmq10rnp0sRpec/MNs5DMRxlenx5?=
 =?us-ascii?Q?wj2gX7ubTBOv2RbeCyq5ZslqRZD9IxkEiKGX+F7FE8uxeyWSPKhgPipZL3Vj?=
 =?us-ascii?Q?npZciNexDAWaBzvDfysjvbTpg9sQSorX+JcE10YZhLpXGQT0qJ+NwQfw5p7e?=
 =?us-ascii?Q?MJTjLzZknlqDBsVQ6SbDzaa05oAirEUnBpPadkS9coqUHO/NlX4lBXZX9sTG?=
 =?us-ascii?Q?QjWhpPfOfohc3wX14VErXKn7iLMUX4zdq7WRXAHKH8HxeDwtvdR/u+ERtDq8?=
 =?us-ascii?Q?/RBIcui7wiYzk9uq+8SVJ1UgZsXm3zkmQLitfVZfh30IhodBpGbauzh+Wkyt?=
 =?us-ascii?Q?ksvrq4f0j/l81xzUAk47J5aFpDmIfqNeG0vmH3s3b8oSg+VbZ3ckvtiU6cJF?=
 =?us-ascii?Q?W8HORx3qclq4PjX2lUwynrkL8ZhF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7VchECb5rNOrPxeLVXRwj9uVaPGEi0GslntixCo93TdlTTTL3FlsYUmhdN7c?=
 =?us-ascii?Q?3X7z4ySaK45AiTnFDSJ0ZxfejrWDehIRgekAsCjGZmOYE8doTrv5yUSD1g9D?=
 =?us-ascii?Q?kuamuq9sdb8xKSrwGUKEGL3ZUOUfWVPR6rums/UgrhykEv91uJ1IixU1ac4J?=
 =?us-ascii?Q?bKwASCcfBgCdxkI2qdiFhcilZmNrAA5afHcDIjPjYC5aOJKAFKzw58Z4RMkv?=
 =?us-ascii?Q?w81goDCIy0qKHjY7fc/uK23/xnkEIXNvo618/17Y0EDNKUJYkFY8W/MryqNI?=
 =?us-ascii?Q?VMiVkUJIyBbGQAGwWhcqCm3YNGnmFtVmeICk5LMi0G+iuPZSFfIsoiQ4lRDF?=
 =?us-ascii?Q?bAmEk8Lx+QEK6ZrJtHj0vebY+CFgQkdRgSX0LlAtl7T2tcmzEUW2uhveuG2C?=
 =?us-ascii?Q?lTCRGI6HfzXxVYhImMZOowE7H5UF6vKQheLEGwbADM6EmZju1lMv2UacIV3d?=
 =?us-ascii?Q?hprbgPC7C8F6XGUuzKonXYT7XGYW6y0NBIaXQKoOUuTWg0LzlAgFmtm/Rbl6?=
 =?us-ascii?Q?cpiG4ba7fStzWRz1H4IZDgeUB9PvqbNz/uaMXeAPd1HbsvFWaPOZyD22rGrP?=
 =?us-ascii?Q?lmW3DHfQ637uB/QDENqLjw5FIbCsNRrNefK92xhT+DOsfv6irrdlGJVrT8Eo?=
 =?us-ascii?Q?ipSSXNvl4SzNUJ3hYuEvgjtzpujwv6YcWtx0dVG3pHzDq9UUn+SNSD5ImS77?=
 =?us-ascii?Q?r+ynqdwzRqzj/AS9IzNj28/pp/ULinSJANybKkTRiu3UFJ4V+XjGT59YoPZn?=
 =?us-ascii?Q?DGeUmeN9rN4gS7KAl32iPPcEHzd7KX0s6iJI5ZeHurYNt8YtdrAlBGLN+0cG?=
 =?us-ascii?Q?vS35HPMvTRP+yt1zk88Z/+r7aTwLCAWmwrYqOjMQ9NHQSYBURX2nYDq0Q+xs?=
 =?us-ascii?Q?Ste0x3hhZC4pcnl2h19YoHVJM/ibg5FwsLWdfUsR5O2QXpir5A05Uetj4QKV?=
 =?us-ascii?Q?U5ZTW0oyj7FdpVBHTC3SlWBifIiG+95427zLQTM9BkeqOPjSK4P2M15/n2we?=
 =?us-ascii?Q?AMph4Trc4CI+pj+LUxhTNY7ZqlX/LXxjkdRfXj34Id6fQQ/r3ao54T24JY/b?=
 =?us-ascii?Q?YDRwnZBz95u/7m4alNeCuiagCnCseCA+G5F4H78G7ikoV+06kyPhW+GBzfh2?=
 =?us-ascii?Q?nQginpz+m4OI4N7Pvi1bIbqZLF0c7BhAY3u/GpJkSjME2fExxfdUwYG9HJsE?=
 =?us-ascii?Q?Trphf1Yr/8OQVbSuowmUbzw9309BBKFnt2F0qWfoyYQ7fDv9UcBFID77BjJI?=
 =?us-ascii?Q?F071UItro+r3WvlT50SKxH2rQmPp1S5XE1CLuvhO+RDLM6ONFQKWNZwosNRi?=
 =?us-ascii?Q?jwsSsvM0VSVYc+jE0X8cmHql8QIrq4grtcGggDiOC1Op3AjVn5ODGwUxUqEX?=
 =?us-ascii?Q?YyZfUHxEydFR3q4eFbxfFUqRlTfS83DOKkgQgM59/t8ojE7eyREyi/Ffyv/Z?=
 =?us-ascii?Q?rvu+8mEtJ9AV3f47WYMySpqUBcBSs4V3yGFCjyBb/BkKPBluEfSxl/RYuFOD?=
 =?us-ascii?Q?KZTM4OtydgbrurWQfd1JU+lw3oVkks0nfmL+9d+qQAxCpShh+R80cXp7/biG?=
 =?us-ascii?Q?PbhjWjl0vQTqn9R9RzWfErQHYdXJXxYXUFG3OGe+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a2d9cd-e842-4a1e-9665-08dd5ae7a75a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 06:41:54.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8Uw2aBOa35g/qxNP1OkCkZJkuHBnlUdpJs67EhH0JSv05jxvEHZwSJcuRLBJ5gFupKSC3us45TrEG7irW+p5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112

Hi Changwoo,

On Tue, Mar 04, 2025 at 10:27:40AM +0900, Changwoo Min wrote:
> Add tracing support to track sched_ext core events
> (/sched_ext/sched_ext_event). This may be useful for debugging sched_ext
> schedulers that trigger a particular event.
> 
> The trace point can be used as other trace points, so it can be used in,
> for example, `perf trace` and BPF programs, as follows:
> 
> ======
> $> sudo perf trace -e sched_ext:sched_ext_event --filter 'name == "SCX_EV_ENQ_SLICE_DFL"'
> ======
> 
> ======
> struct tp_sched_ext_event {
> 	struct trace_entry ent;
> 	u32 __data_loc_name;
> 	s64 delta;
> };
> 
> SEC("tracepoint/sched_ext/sched_ext_event")
> int rtp_add_event(struct tp_sched_ext_event *ctx)
> {
> 	char event_name[128];
> 	unsigned short offset = ctx->__data_loc_name & 0xFFFF;
>         bpf_probe_read_str((void *)event_name, 128, (char *)ctx + offset);
> 
> 	bpf_printk("name %s   delta %lld", event_name, ctx->delta);
> 	return 0;
> }
> ======
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  include/trace/events/sched_ext.h | 19 +++++++++++++++++++
>  kernel/sched/ext.c               |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
> index fe19da7315a9..3d04b9819548 100644
> --- a/include/trace/events/sched_ext.h
> +++ b/include/trace/events/sched_ext.h
> @@ -26,6 +26,25 @@ TRACE_EVENT(sched_ext_dump,
>  	)
>  );
>  
> +TRACE_EVENT(sched_ext_event,
> +	    TP_PROTO(const char *name, __u64 delta),

It shouldn't be __s64 here as well?

Thanks,
-Andrea

> +	    TP_ARGS(name, delta),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(	__s64,		delta		)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		__entry->delta		= delta;
> +	),
> +
> +	TP_printk("name %s delta %lld",
> +		  __get_str(name), __entry->delta
> +	)
> +);
> +
>  #endif /* _TRACE_SCHED_EXT_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 686629a860f3..debcd1cf2de9 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1554,6 +1554,7 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
>   */
>  #define scx_add_event(name, cnt) do {						\
>  	this_cpu_add(event_stats_cpu.name, cnt);				\
> +	trace_sched_ext_event(#name, cnt);					\
>  } while(0)
>  
>  /**
> @@ -1565,6 +1566,7 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
>   */
>  #define __scx_add_event(name, cnt) do {						\
>  	__this_cpu_add(event_stats_cpu.name, cnt);				\
> +	trace_sched_ext_event(#name, cnt);					\
>  } while(0)
>  
>  /**
> -- 
> 2.48.1
> 

