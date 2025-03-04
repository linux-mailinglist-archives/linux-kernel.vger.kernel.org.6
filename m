Return-Path: <linux-kernel+bounces-544133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B942A4DDBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61F31779D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39420298D;
	Tue,  4 Mar 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="orxJ9YkB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C8202976
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090838; cv=fail; b=pYeieqd7LwCX2/OcKL9rzm29jes54RNu6q9I8AmAAWIpZ5noXIAG7Lp6poSPAXKUGi3GJyg/a92yMhxwKpHgcazbcr12lL+iPPwaUHONpuTTflDcvF2BEnv9U85dgmhVIGyssZrNPe/Ua6vvZhrScSMNhVhddCIDezZp7iIVmkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090838; c=relaxed/simple;
	bh=fYR/5nnEEipEd6/JTgzMwgiNkYT+yPJs3GnEjnm7t0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dGxlgfkLQrV2j/f5++iJdrXmGCD8gNVIkvVQGlpUhyNsIcJSav2hAmAHDtWV5SrTVgIV2XBT9tj/0yTQf2GoWH3l5hHy0aWX+m6VB1l61kJfFxhcJ2FFkvPih8mdcCIwKJYbOQaViyzmSqmiLNxcKB5dV4CyOqdWeVhGooP3vjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=orxJ9YkB; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xekCJGaHmZal1jdU8AC/qbnZaB9lDGTNX52WwPzYHJObI/M9ROPGHzOF0Fd+PDZMppISBMLplSwvSKn8hyneTk7vdEVFmnM4kzp5sWyX56QStdyo3B2fG2V0iB74BfzVTdzTkUmi3JkvQ2Zxu2UbJWGkndvyvpieDYhhElNtqwA2uie3qSRM8sBdRrV1zaYT8p+uZi/r45bY8HP30yyxJC29I1QdRFD6odyYMK6yr6HmPi48MUhbYoC3c/PsncZD0CZxhX102+Co2AB3CX8T2bMmqazouHb8Uc37sPv8bfl/qulMGMxrq1LuU3iaDNzyVJWPuwwQvuH+/uQ+Bvmsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bhBZk5IilMPWIUsdUxt+ivch9g3EEK5sqBH6bGfY0I=;
 b=pY5/fzukl/7SywnXj4wHxtFmkzMXG/3e90mr2NcovV3iPcwZlexFs5ivJgLhdFfu8leV+0ufCnsomofWnOj+ORCpCK2akhF4S7Kuiffz4792O3NlsfAf4qWht+qw3e93i0akjQGhKm5zB2Yf6dxNGergtWKWsSkqHrF6FGMRb/f1ed1SAngS9CtjScuP0iDpigZ8w/tcGMF8F/kJ2LPZNf3R4+uWqUP6ewxpi8tr0BXv9Q6TEWK/nERgslsJ3k4Czvg99RJhJVFY6zx+RkZHdDUuzmjJxXtuNrj1q1d43AmkxF1dwr14OWKmcPlBX8aYmf3lpd0WDFpfjf4K6q156A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bhBZk5IilMPWIUsdUxt+ivch9g3EEK5sqBH6bGfY0I=;
 b=orxJ9YkB7e6GGf/vqhlFWIybT+PGemU9TMS0JY/jlpsrYhjobc68X7Gr9DQOfXfOqVXjV9ftFFjdI9Y6P3w+RCvLlVi8uv+MW2Ta0LTK94p94qXjGWoKnrkq4X3igjpklKols9ttYo0qYe0YIL5UuCEz4GLarOVqR54l3p6TJ/+/dfD3IVXWnB7ZQGcKO8+PTNiTrI4kMan+I2EMzPMAEnyFijBaTcoKsDhv38zFbnyo3YZ0veXFSgWz6a6eZgaA2dNdo+3TwOiuke0klLaHkterNONdMrJ9SlemZ0XEaYEj6M1UwfumPsrZXp0FnA+RZHDRDpAr11pRzmxMmYV0Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 12:20:34 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 12:20:33 +0000
Date: Tue, 4 Mar 2025 13:20:17 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] sched_ext: Add trace point to track sched_ext
 core events
Message-ID: <Z8bwAdeAuNQgJCR2@gpd3>
References: <20250304104900.154618-1-changwoo@igalia.com>
 <20250304104900.154618-3-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304104900.154618-3-changwoo@igalia.com>
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c577a38-47d1-4870-258a-08dd5b16f648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6Vg3KC6GG1ynZDSf3H0vc5JqwlDsDeQTJf0VI44vTqLM+dKxmD9h8W8wZcw?=
 =?us-ascii?Q?l8YnM0alBgRUXv/KLyMICe5uquNaPsveO8tY9uqu4npg4O8D5UMfqcKNcWdV?=
 =?us-ascii?Q?piBGY10vtayFxkhbp5eCzc7715Psa3DiX37IbFMaYijNdgsWRTNG2cvAxllA?=
 =?us-ascii?Q?4pD08O40iNkvU5okx68JNGz2zjJeGfutvmFIzhCFHEZ66OBDTzJT6/YaT3yy?=
 =?us-ascii?Q?PDo935/LqnUEsKYuCswTe43E/bOvFpf7l2nHch/huHMlIBcABnPZdzmY14JJ?=
 =?us-ascii?Q?m32wHrRQRZWJk/7mTGl+LR1s4U/oW1x6tpoHQJ+Oa2Dbo+bUoFbEdOs9ppg+?=
 =?us-ascii?Q?mkBVrij7QNbS9bwYPJsUkQO796laU8pAgH5Ixs+twKuzt+2NSu0H8tTuIyqL?=
 =?us-ascii?Q?J0Eu70+YB7qn+vE7Uhag31JMvI/RLYTCJFGn53pnnexdqEFU1lzEW5NbOmaJ?=
 =?us-ascii?Q?Ncv1/hiWee8hByQjzNFaQ0n3U7MB02Cf44tAEFAABYUVNjw2v1dVMgs0W4Bd?=
 =?us-ascii?Q?tjrg1/yEzJu3uWdosPzgnUBHA+gZKIcxPTiVe5G6xYS3sRc1fxGZ53HGbKvK?=
 =?us-ascii?Q?V/TcZ9K6v1zWyIQ597JfMBm/b3gvr/7/ApNMQ3g7TQyVA2hoYRLfAewJqWpw?=
 =?us-ascii?Q?VrnNjFCTvSxiyL2xAx3IraTJ+LhxmNxFugjg2RHLMcuEruwPJBShYRcyMHIN?=
 =?us-ascii?Q?wvFkHnx15CCxvh8Ak/H1G+Y00i7J6bUWbqNWuepmD66P8Vc1nsDEbURVoHCC?=
 =?us-ascii?Q?K0G7B6tdEZAacpf86oPKI6vZdyxQLAYefDMWJ4+fBbBvunVt5hlO3fzjz0G4?=
 =?us-ascii?Q?CUTXX3Gtz2uoq5Ek+GTp+yNUoAisrJ4UGTLAUEh9WwJrdASTpoNzstEX7l4w?=
 =?us-ascii?Q?46LGFdW7wtIvAZdPPGdQQt45qQ7RhNiqc2j9s1jE9lWbju5l/sP3c64gtMYK?=
 =?us-ascii?Q?5W0OKURCidym94/XXj0AX0+7k2YgpHp5jWsNKqOrKqpt4qycaQnzwU9uQDPY?=
 =?us-ascii?Q?K8zzw0QPsEd7UKu8B+YjQAQ5KGzNCcTqRKnwCs/Cvi+qWtOU/oOQESTEhgbR?=
 =?us-ascii?Q?XvkdMXvSYMkjo5P/UF5ZLpqM+xYcmmC6mhIfUIWS2c+F5f1eh/u8ePYKbjr8?=
 =?us-ascii?Q?dyKTX9g/wtlsDEXfCYBVsU0HrM/ZXhIQS3jMRhDi4AGvC8NbzcU/LilncDxN?=
 =?us-ascii?Q?KIzdwvC66ywBkWRkxL7JOjTx4kNa+6cwnkw8f4AAky/rEE/yqvvo3NCl/921?=
 =?us-ascii?Q?vtivT/hucaj8sm1lVSTnHAujNXlLj41BFcPTTUOKGySBfRpWiYFZOzJoh2yE?=
 =?us-ascii?Q?ThpbJrd7gwAT7EdEbZN+pMWbrcMhMcgJWfIaBPs1OKtJOcORJ28JXrmXLkv2?=
 =?us-ascii?Q?hNt5ptZyIJLCQp3tzty6uNVxvUZl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?atoPuKpRpt+rzzXKbYT3qjf0C401GbnCAW1LjhNRuIKJaD73+yRgpO1WfSWY?=
 =?us-ascii?Q?LWOn+w0eY+zVR8JjHeLjM7Yk090oYAEhlFShT5Sg3bEJHZ2ZrB0BXOO8cmw/?=
 =?us-ascii?Q?6haUPuLK7vHm0GzrAfUsMa2Cb1aC4WYb+UGYs+Vj/rxYhVIUH5HAaS89kpzx?=
 =?us-ascii?Q?H9qTNBKLtVoeC6Fvg1ZxXn/gahmoyU6aH4v++UgnFJjLISk804BU0gV63GFo?=
 =?us-ascii?Q?0pcT7CjtEo6UAAfcq3lZZYBipntc21z6gkbaJ1I2NZFA1A/9Q21GCPEgrN72?=
 =?us-ascii?Q?1BoO7JwXHauPDYVqBUAuaPwBh5Bzcz1aAbY+k+liKrlKv47wJfEmO+rIbS9G?=
 =?us-ascii?Q?SYJE+CrzQk+N12HqjdMBmTKwq+X9K1tY7/GQ/MIs4kSjUUT4d8jkMVT9TWoc?=
 =?us-ascii?Q?JnXheI0qcxiADWcoWmpwo8Py+QC0ZpWDdn5j8Mra56TaF/S+xrU4I7pn2PcF?=
 =?us-ascii?Q?eKiCtDzB0uM/bIfOm/VtT4XTbzzgI0Ykmj+RH3QaPIaC01I9Pv9f9/wQF28l?=
 =?us-ascii?Q?rdYHNqH+uyekWlklfgw4xL260SSOW3K+p1DM2itfs5nJXB+Nab66ilLwE3mC?=
 =?us-ascii?Q?KHBAGziwEJwI+bx6b1FHKJoatJEWEwOfN8NxoA1gKRypPP+5GJPjnLPdkKoS?=
 =?us-ascii?Q?zPn/kdFZ5GkNXcPbvsV4o+paHJUhptlLX3R1eVjTmz9vxpGcpGfagAu8uxOM?=
 =?us-ascii?Q?8rnm7eQpFbMTwdw0o/yUrQDpyBM/ONFU16ve5C+8XDfUO5g8x6nWoSEsS+L4?=
 =?us-ascii?Q?yGrHsVaboXAMueEEcF5cU2G6o9x8YMhTw4nTLg+VduUlY8pew7ziuUZRvDXv?=
 =?us-ascii?Q?OMoa80DqGg83pWYSrIcQjsUwUt1KbnC7WbS/ar0EpUQ2BH2kCe1loi48RRhG?=
 =?us-ascii?Q?49fQ0STmR3n2YZLoonOnHYSbVEvVSORbsRnoHqVhz1ffVg1hbW558GfKrS6A?=
 =?us-ascii?Q?z0Kvkzrl1TdF1UCxmsGzEvDfo6mdp9MCZxZ2Xme+Yqv7oB3ODTxDm7Z3wmo2?=
 =?us-ascii?Q?K/nsTlwRHnb/N2XBpkgXd7w82tkz9XkJBOcokfMBDwVvEHc4a2glgCDeegLu?=
 =?us-ascii?Q?t2UFMfwhDJzHlmu+hcIttxyAfrDCJQDR3V0vUbJLKTNi4UargrN3iSme6yb0?=
 =?us-ascii?Q?1VRP2IphMTIztjafpYJDpvXeUVdZ9kh3cj7hqMMAfzYPySHjzAxLn3eCku30?=
 =?us-ascii?Q?7oG8UimuEios9C9diNggcy7Xc7IJdhb9bSTPNWtuA8l6X+rG5oFj/2IEpzHX?=
 =?us-ascii?Q?cjdS5Q8JxmbKKdJIwvwBXIFXw02k94meQZeHvE0m9tnlvHABDRQYu+VWvbVb?=
 =?us-ascii?Q?n3I1xRtBJxqBJ99M70h6qLaKMsJSO61KOHHS7xf23sb7vRcgInV1uKuju5Gu?=
 =?us-ascii?Q?y97yCo0diYLMwpO1rH9/x/vLKb68YCVXdlL5kcxINHfZXARpUdgj8YhQk7Is?=
 =?us-ascii?Q?mdi7lJK1V3LvP0A0HI1MRpoL50socUwCL89GCflIIRdQ/+r4Hwvy1cDFyV05?=
 =?us-ascii?Q?Tq/zgll3evDtNeM9lQPHrNUW/Xm5ScsCmaPufhqnHUr/B/X39h0P7Gs2kqhA?=
 =?us-ascii?Q?OE2Z12rDXPiLFDExgz4uOazI5epM2QF14ZaEybIp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c577a38-47d1-4870-258a-08dd5b16f648
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 12:20:33.6917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0X61NeSAOGghRNkLJrGsZWXiXEMSn2sDk977o9qyfmyLaG1RYm63QrqjqyNcMBJG5REmLsBu5K+Dgl/NeJZMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990

On Tue, Mar 04, 2025 at 07:49:00PM +0900, Changwoo Min wrote:
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
> index fe19da7315a9..50e4b712735a 100644
> --- a/include/trace/events/sched_ext.h
> +++ b/include/trace/events/sched_ext.h
> @@ -26,6 +26,25 @@ TRACE_EVENT(sched_ext_dump,
>  	)
>  );
>  
> +TRACE_EVENT(sched_ext_event,
> +	    TP_PROTO(const char *name, __s64 delta),
> +	    TP_ARGS(name, delta),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(	__s64,		delta		)

nit: there's an extra space/tab after delta.

But apart than that LGTM.

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea

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

