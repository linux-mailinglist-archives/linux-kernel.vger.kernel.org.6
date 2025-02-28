Return-Path: <linux-kernel+bounces-538272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3AEA4968B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82068188837B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03BE25DB17;
	Fri, 28 Feb 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+A6hsTl"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133525BACB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737047; cv=fail; b=D8jrOBnwewWyprY3gwO8RpX4rORnxMcfxTVHV+nSazQvicit12R7n9U1BEBNJqgX+vGl/xP1YLXMSNBzJpBFc/eWGBjBBO4+O4E1I1YouS9WY5xm7+wou6iEvdv7/sbk5uDsyqnoa6e0UA25/ncln4aiH03Q691GaFELVi4fyQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737047; c=relaxed/simple;
	bh=6GF8JkH0A3e35uvE9JSSyoNVM4imTaOfJoJtUo3DH2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PZN+zlAb1TOGrgDP2KJSU7C01FVoDD8YD3Bxi7cCdll57Wx/8F6hS4CA0lKhK+T7AzmHtijSZXupxJqo6vB7Xv0sQiiUKYl9qr952lUp1kMwJQZgjFBKGLM0nMdZj2ej0cp3jj3ywatgjfT3Legj7tl6kNBvukt2D1O8mA4mJJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+A6hsTl; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ysq7g8DyV4ewK646fLp8E1XIxC1eKhIhuOpoTZUCTBz77xWRcDTd4oXCE5iHd25gjEk33/Usj34iJoDRzh+XhYDGxTnqy0dPi/QwEdlgmUAIh2bw1KR+QeM+r7csuXjAYIEWTcA+rYmUXqCbjoRKas9fAY44I1nTgEfRhhypYY5FISNoRNSKaM+G59CJJekQCu7rSOirWNWMa+40cMPSD1gNyzTBkUQ9bzUIXAE4wXP7jVrjT6PxlQJ9u6621ITxPTcVG8bkgmf12fGcbtiWlcEstg7MjUQUGhx63AowQaK2DMrHOlUtNjhb/wqpx8CeemBjdeLxK28LDDvXmMDJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+YdWOdv5G4wF+yVxOSw3X00F9rHxsMUCLPUjvQpuiw=;
 b=KTm3rkv6qv743k79FaSEeGWgIc4fjNN08mcBCR4RsZIqwmVhjH4Eu8B6Moqn4PpLVrdUKOZ/ldlRLgnkJp/n6C22VW8TDt6+5G8uoGX+C4Gj/pA7Y7ct6O2rrnJdKUPiLA32HuP2/8euGdWQR7G/fFSbsvlNAasF5xq7+pIHgpLuIzk13ii/sN8cRsWupRkYWtfNzTkGAZ+s24FtURWF61ZIzFHiJe6a9lwfY8SxRjjTURB3r7qHfP5q+1N3QYBz4PAGs5Bo+gDSBkNpmCsPX5prCkBWOb9lpoMwP3HcR0Aqu/kWogjo07CUKNzLTPR1VdN2gO/K3M/DTK+rRi2oEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+YdWOdv5G4wF+yVxOSw3X00F9rHxsMUCLPUjvQpuiw=;
 b=t+A6hsTlQ+bq6fTtlTSURhjNTgyXGt+X2VqOOYlcxitIb0yuh8HAB2GDE2MC13KmttcPaI0jlZXSLgmlkdMzK3rRpvdRYfg6X5qrVxfYymW7BGDE/TxsHzeZjvZwAPWau1Bz9S0LPVSsVrN+xhOI5T4lsWFGuAWVk+IuqbHxGTwLyqUED913+lP9SklQWHxZ4WbiwGagA2hhJwxlXUMVwL8ROR5BjIIIxFsjKCjtUsOQONFS4qp4dV2cnD0wr9ey4jX3UoloCKDIuxr4JsYgCo0GDbc4xgxIdUugumx4BRhxBVkQUMuvH9Hz3l+N10Hq6NxV16+Dv1N9M/uT/wKZ7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Fri, 28 Feb
 2025 10:04:03 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 10:04:02 +0000
Date: Fri, 28 Feb 2025 11:03:54 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Add trace point to track sched_ext core
 events
Message-ID: <Z8GKCkWNVN_Pbcc0@gpd3>
References: <20250228085944.19451-1-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228085944.19451-1-changwoo@igalia.com>
X-ClientProxiedBy: LO4P123CA0598.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::22) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd9ab2e-24d6-48a6-0fc2-08dd57df3a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?29wjvyO6qlSgi9bMupwVL01Aw+JMBaDOHgFETGkgXyD0aSvj5Sx0qqccJ6pz?=
 =?us-ascii?Q?Ui75gsa4s+4JNvFGD5Hm+5/aLFTY7Ucc6cRmIxNAXoZY6lbKB0IPTNDJcw7s?=
 =?us-ascii?Q?iKpNW62Dg5NIFPeb4BCNR7nSwZ+OHUEhStA11IqBtNoSkNwcke26dx0iGIhK?=
 =?us-ascii?Q?nfQsz7V/Kj/eZYx8TBMDUN03OPLVl4bihnmInUoQ8ZfXDidgRNt8GvQHsIM/?=
 =?us-ascii?Q?doq4c2mbIz4YTHX9dh7gt9BJBBMBKJrjK5tx6N/IDmLVLF7FTv4n7o52XiED?=
 =?us-ascii?Q?TskNRh2g5hxvQB3AibqDNcijB/64FKm1ZPQCNGeUDZauZTuLjJbjO2YwTGRq?=
 =?us-ascii?Q?nBSlDxTTZ7tHwt4K7jAuIcRzYne0kqJqFcY/d4txo/srEewg1rLMvZ4VaX18?=
 =?us-ascii?Q?O5emqAUeXEAPP972f5fzFI4K0gHHvL85euqP3Vj/Vzdu9NLzOcwSUuV+tK+P?=
 =?us-ascii?Q?BztZMiA0ufUzzmo7y6w+I8Td4F1Z5KBBoBLB+mk0CbAZxdqka+3Ro4ihMM63?=
 =?us-ascii?Q?Hvb144wYmW9OuR4zVhQaNiR97cKW/nRHZFNoRBRp/YEqEmORYNiSlnJ0c/Y9?=
 =?us-ascii?Q?XcGliKiYS5d1jPoyr9qn3YIoF2oAivEMhnk4v0rXZW2Ji3EN7Z/ewyypaoaE?=
 =?us-ascii?Q?mO+fnua4JSp9Pd5n5WJz5kXYelFhKj78G60sJElJzn4aTkRfZgDz9gn7zWxi?=
 =?us-ascii?Q?Ww+9w1EaggOZ/mr1eM7k4+nJwOLn1YzuGlxX1ygKUFBhY68e/6CusdlOA7dI?=
 =?us-ascii?Q?OwJA5RsFFkbKrjX4EHqfSDexByBiODsqonvbujHHTnVShTJQHsg2UXG21wVk?=
 =?us-ascii?Q?KdzT/mSAczpcUIs5X8vXeJR+7AK/JhcvS4JIu8+SdtHQGieiqJwBInWTLKpx?=
 =?us-ascii?Q?c90Nx/YYu9sAwulis+eOCxnBtzuPZEOVXNnnWA69Hr6d+QYiuoqF/XcNQ50M?=
 =?us-ascii?Q?F7jM1O9djOemyCSKUgca96yuiXHCA7ukT4zx8QbguF0ysDZ0MoTxBZlt/jr1?=
 =?us-ascii?Q?VJ2XzMk+mLElBAbU8qpTTgiHAKTxLf1e8R9LK2U4MOeQOEXB5coZg4vOFrZB?=
 =?us-ascii?Q?eQPGVu8FvVhXAtKWjW7gnkgY27Bx2jKwDSjyqitsq5R8o3Xm6vJS+NvFYB6q?=
 =?us-ascii?Q?qb0VRCGfXIjCfV3owHFBKusKIwMWLv/LhJjnXDS79hNn/PVGSEWefmjWTn/W?=
 =?us-ascii?Q?PpafzyxKiUvdMHJQScgiaQwXV5VVIN+RZMflSuCdUjpXGJVLSRFiQQldT+ff?=
 =?us-ascii?Q?zAPK4CmBJsTwL+8ta7dJW5bfLjnYlGcEtzo1UeW55gv/I1dS46n4+UfLmACR?=
 =?us-ascii?Q?Pub7j7X+OuAODG2VN8VcO6yJoQKNbdFQbzYuCM8+Ro1ZVI34Qtg/VJ2Zgql4?=
 =?us-ascii?Q?N+Frr/Zza5AXIXsZFre3sn2T/vE5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ddLJixWYnJqidI+bLMLez6dxDzelCaYpIyecXT0m1DIXJHiAvwpt7USBl+CX?=
 =?us-ascii?Q?5akHvOztrJI1h2dbw0cD1IA1QPLA4nweNq9DajarFa2vlVXNT6uceEaPeyGn?=
 =?us-ascii?Q?U8wRXsKcF3cxuiGL+m26hQQfmOU+oKhXvJngkx6gvxy9a3MWBcBsJUc7KFpf?=
 =?us-ascii?Q?o3YKfxoYMKEdZ+CWpIdxwp3huMN/Wn+T6dIibqfQgWdFZmkgUQvJOaRQzenk?=
 =?us-ascii?Q?UHs/lLW9xCmLeFhkCepVDWrA5fEGQM9OfLalF2UyjfN6nby7V4utTv5GqdGd?=
 =?us-ascii?Q?SQ0xkIb6eJWbsA6/ni2X5GrVYYnnjyb216ZFwRXqQBcgkh9YwB3yXCYdkhSz?=
 =?us-ascii?Q?sVYuuvoYae0wpBDRodlk5MyLKhU3sxyMff3gLmnZUdbumZmCc80mf95GiGKU?=
 =?us-ascii?Q?ipjtDOhNcRL5J64jY6uY5ndrcpD0Vt+FzBDHRKEBulnHj6mAiePhP0KKvzTR?=
 =?us-ascii?Q?MpOO/jNM6TDo/udfCEe9hVLpqqJ77n3ACHmk4NVdLsuhfi+v2fADm8DfLsu8?=
 =?us-ascii?Q?1eZMWJyyX6vDq8u6UPAxv1dGtcRvlyoWZFoIXMN09tWyyUm4tn++L6MuVdgt?=
 =?us-ascii?Q?zyV5yjR3+KF6f35qrBQYq69Z9Mh4YCG5PFAJ15dIA4yqnCHmtp2vDFoR8jmx?=
 =?us-ascii?Q?5FfoDXC1DyZImc0c6C77hlNu3IiBySxy+JxVnYyS94kZ1iT1ZSCUTvvNrZA/?=
 =?us-ascii?Q?wIM79r4Fxbqyj/jXN+JTjBh7hDPhkGaFuVAq6O09DAXrZ6C48S1SAcZx6rzV?=
 =?us-ascii?Q?ywW7kX03RS4zCRq50xIG0+ORHfwU8CSSF77yLNdeV2mQG4UG5WBuva6nXFHN?=
 =?us-ascii?Q?ecqT+f6hCX4oB7tuXZ5q6G/c+OosFlIzSXznB5xGMllgLcIUkbcpqAVjTu1O?=
 =?us-ascii?Q?kaymT+1VuObROTaRstnn3VWaqHi6I50Sfpg6hp7LCzuvoyJ6Bq3bcYiNnWss?=
 =?us-ascii?Q?Pz9C+4f6TfxHpVVEBokmHPUWitTUQHOT+phHObQekGb0xIjeHzbUJguhJfhA?=
 =?us-ascii?Q?r6fTh64TpW2NF/QpLgZxx6o/EJA65YwU6nrsc+J4hzHL2ai9eT7DELCZvWTb?=
 =?us-ascii?Q?vTxbKYXKLmw3ChCCOEVGDtX2cacF1QX40ud377CdamSJeM0Zjlae6EcRYaXh?=
 =?us-ascii?Q?SbMoZTgmajKtysDUHA2NRIrQ2JM5LmWwemFF4Y/eeV/LHp2noGq+A7fpsfnJ?=
 =?us-ascii?Q?YPR8rUWA8C9TI/59yLmKpd5k7YQM2qqHVDm5sx/aLq/5McJZVA2ZZReU3GXA?=
 =?us-ascii?Q?1ue/eBqgwQ2mqNr+WQ1TB/LUKqn1VREAro59dNEYk0wuRKRhzbQXdGT5TyxB?=
 =?us-ascii?Q?7B6PzAZDCaK4jsdZMaeUESwu4s3JCf6Zwp29qtXoiB711z1aOQnhwbRxbPnc?=
 =?us-ascii?Q?OM01lpxFwrpay+g13D/Vxf+UgdxR7DxwjxnpIMkiRUgixrgGYg64e2JrQ+k6?=
 =?us-ascii?Q?///XXvhcrDwURjnp4fRvIoZMgJNa2Z5ZcztoJbuuNasW4xhzf+PCYgTd4RBC?=
 =?us-ascii?Q?K6Z1vo8zpyUKpehkIPlr5WgzyymeXtKkG6cQ6R0yz+cywRbvJqpkqB6hyQV1?=
 =?us-ascii?Q?lRCXUGCnSOEB+I7gg19vI1KBb3TufNvBPzMIKiW+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd9ab2e-24d6-48a6-0fc2-08dd57df3a88
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:04:02.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHIfV/uWpKWxVwjBWZkT7fEIeHnRzvAI1JGhKjD+B7ent16QmcI0ql4Ehd54P7HrkALOe3+wcDS8YWjx8GU1nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

On Fri, Feb 28, 2025 at 05:59:44PM +0900, Changwoo Min wrote:
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
> 	u64 delta;
> };
> 
> SEC("tracepoint/sched_ext/sched_ext_event")
> int rtp_add_event(struct tp_sched_ext_event *ctx)
> {
> 	char event_name[128];
> 	unsigned short offset = ctx->__data_loc_name & 0xFFFF;
>         bpf_probe_read_str((void *)event_name, 128, (char *)ctx + offset);
> 
> 	bpf_printk("name %s   delta %llu", event_name, ctx->delta);
> 	return 0;
> }
> ======
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
> 
> ChangeLog v1 -> v2:
>  - Rename @added field to @delta for clarity.
>  - Rename sched_ext_add_event to sched_ext_event.
>  - Drop the @offset field to avoid the potential misuse of non-portable numbers.
> 
>  include/trace/events/sched_ext.h | 19 +++++++++++++++++++
>  kernel/sched/ext.c               |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
> index fe19da7315a9..b73499981682 100644
> --- a/include/trace/events/sched_ext.h
> +++ b/include/trace/events/sched_ext.h
> @@ -26,6 +26,25 @@ TRACE_EVENT(sched_ext_dump,
>  	)
>  );
>  
> +TRACE_EVENT(sched_ext_event,
> +	    TP_PROTO(const char *name, __u64 delta),
> +	    TP_ARGS(name, delta),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(	__u64,		delta		)

I'm wondering if we should use a __s64 here (and %lld below). We don't have
negative deltas right now, but in the future who knows...

Apart than that, everything else looks good to me.

Thanks,
-Andrea

> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		__entry->delta		= delta;
> +	),
> +
> +	TP_printk("name %s delta %llu",
> +		  __get_str(name), __entry->delta
> +	)
> +);
> +
>  #endif /* _TRACE_SCHED_EXT_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 986b655911df..53729c584b63 100644
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

