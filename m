Return-Path: <linux-kernel+bounces-535750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3650A476B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8167A25C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E93222170B;
	Thu, 27 Feb 2025 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t9VlakRo"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467A21B9C4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641906; cv=fail; b=sOKOZ8+wApCkEop674kKJe53OaQMDliJMC+lQ+MmbQLDeq5rFWQvgrqfZAIv4dCAHviGUSFdWbu8G408hT6DJJlA+RD6s3TiZlrZb6Ag+nCxUZhN0bapJJ0HvKT1MD5uAQC1FvqenPB7cTwTW3HodK5c262R2X1xn3fI+xu3VRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641906; c=relaxed/simple;
	bh=cBk/u0rgUOfAS5qAc6NLJ9gLo5+6MfxNEEX8kJP94c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZC7KFa1+x/GQE+lWhloO3jMCHhlozelhFk6x6qFJk3XqPH5rQYydZwl8+wqpTpZp8xcQwGsm//1gmVf7nQSUY3PgnHBBPTdcvdFsZXy3/CfzCwEGdSuvmDBeh7Wth12KY2Zs8T+6Qxap+CRL4Ct2PVg9wiASH89ipyrhTwcer8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t9VlakRo; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiM74xLzjstGQzD1Gj4UYUm6kCkxBX30xF4KJnUa5oIVXDoYlk0lhqGKFwnSFSHy9BbPRajnU5UO3P+NDFwWyYzdX4qXgJothN4II1VktGyF6cld8NF+tiOzpz4B4PuAnMq92s+etdwtHFsywg8UfVa64DkfvCYNESJKyyY/1UtJ/Bnwn+FMtBQU+NxH7sHeRZvLX8HhUe0eYmZLxDL6ddahP0S4nKWTG/3SwbF+ANeB1fD6pcRglVoeRc67Gal45yDt1LePM2+1S8yxiTVJ+KGt+Hs2Kdrk0jfpiyWCj5v+DBdBGB3e2uOna93uYrQk+I2m7KlX4ss+JONJO9lOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tmMSNklDYQmEMY3gWNSIkU/WjJwe1REi1p9KT23l/8=;
 b=sZsosmSRmC737WKrZ7PGmcsCb76r3OvS57ePX6mW4iQgPHepAdI0gr4M6w/x1DLbjqP3jgggc3SbA00EBay5SyJrL2ocHx0P1nBVnpZXiH6Y46URk3zn2l0Y6cwiKenusT4PTOplkW8vu9rpdCSM4rFfSRFIoxHp8Yxqr4zz+JDFZzC/ViP3xcDQOer6PmjkxtHHanIByo8bSpXQYQMcmalBHKhARIrohzjMZuxFQo0BtCrNM+yLZwp+A955NPPeLTAOFJ7GC2I29v8n3zlSMmdGkOKBq08NNNuZzhwglChW5Zd/eJrpCncV7StGkg08x+9Ty2zdBAlTUyQPmzjpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tmMSNklDYQmEMY3gWNSIkU/WjJwe1REi1p9KT23l/8=;
 b=t9VlakRolTvTitlz0W88whgextE2n3YjBYGBEQ/RE60hC8TxCehKXQh2LNSp8ui04p0nBPyhHrQXxW2fUgg5dyMdnWJdOu6vk7K9hNE8/EawP5bi//rSzf0NtUiDpqIh+JMAobxx43zl0GY3Bb8EoZ/Pp7oHqlmqeC/ZvGCf38B/uN+K/ppHQK/O0SpKquYE3DBDsQhJ7r+CoYC37CXlUn2MK2BXgz1WuNLvP5bXgFVHtlf8KTU6s0LLFnaYaYq5ZIyhkvugifz6LOFHwBKCpNjC8MOnZApceSA0590nS0jlgrSwyzkYL39yQOhtlMe7tDoJ99yWL8myWNQnPMi4Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 07:38:21 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 07:38:21 +0000
Date: Thu, 27 Feb 2025 08:38:12 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Add trace point to track sched_ext core events
Message-ID: <Z8AWZBtrGN8h76AK@gpd3>
References: <20250226143327.231685-1-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226143327.231685-1-changwoo@igalia.com>
X-ClientProxiedBy: MR1P264CA0171.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: ca677eea-e439-4c71-d3f1-08dd5701b57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gEkXDbJ2ZaySqzF086vxWnYz2PXul8Z1wg138gelMcAP7UcmZb4aDInq9jXB?=
 =?us-ascii?Q?oDOz2aSgZVfMBESa1IvtARBxzCaM6+5NjHME5YiQbPF9+fn3qig4d/m7t4Yr?=
 =?us-ascii?Q?DLk6jDFf+ZCgQs+bTQ7ddLZZqXMlZOcqdeF87Aix4Us35cL0uo6CsKR8pD6b?=
 =?us-ascii?Q?AP++/66CfGlrqp3emJAPpitccui6Voltkocu4S2CqojzxAIEbs2ow+KjKE9E?=
 =?us-ascii?Q?LQfkx0kAZ1dUk4+l/ZrHzkVpUpg/dXfdpC+RL5xmXM8fZKHTwNCoDpf7H6ed?=
 =?us-ascii?Q?+RZGaQeZowx87hFqNs8XYHWOJtUQb5JaI0PpEswLd1WhdLIpiD0U/ke0WJO8?=
 =?us-ascii?Q?cs+YW31jK5QZAkdu+9xt2dVEA4RnlbYz7Ah6OyiP16spWytIGwhs7uAMni84?=
 =?us-ascii?Q?c8gYrEWDWAqjFz7Rafur4ixoAjRwIQwM2q3HS1befulnuMVHeqS+y+DQ5haF?=
 =?us-ascii?Q?7/RvVVU3Fr/6HfpeRcP807G06yLLP2Krpt1Kjcz0SRE87tKrue/siZhBM6g2?=
 =?us-ascii?Q?6SJHA6f5hiwi+xjkipLqwp2fupFBTtoTsPhQ7QG0hhv1WKaXMiNRyPcnGoE+?=
 =?us-ascii?Q?YSrwgYrchGSRLRAWV7oHmBXs5i9s7yM3o5bWUi8nxupKND5sNRuSs2Dfjb6D?=
 =?us-ascii?Q?PRkKHhMCe0d4qRU6kwF/ksn+jp6qLhw9c3mBnlOEmZIAL1AYa5U5+JbRE9yb?=
 =?us-ascii?Q?GsALxizKtBQGBY0/5L6u9QKOFIvjwWkfZD2dMPAuv7c98u9bOghEx/cdTUzU?=
 =?us-ascii?Q?8LeIaahw2kDLU2vXSa0dzRQ6rOIDXOv+qUiHSDi0n08LO+qZGTTmfdd3F83l?=
 =?us-ascii?Q?KSWExf3174McGxAziyLaGX70t8VaiFWO2U+RC+o30QxHotydjSJxSAVMo855?=
 =?us-ascii?Q?Esq3KNXAWSecTOHYUV3Uhafz1IspBeCkUr8eBp1a8O1IFEDYKylxs7ACkdgb?=
 =?us-ascii?Q?KtYqFf+OoQn5iKyIndc1lAtpzaUPWWOvdmG1uk8Klr+J+k8ZvfJQMDqEc2gE?=
 =?us-ascii?Q?VeI5dYNf3KqpIJyOoHIs7OJE6oaUHVR8hFcNa/y86QRjh9+GMBf8ob5xPcQr?=
 =?us-ascii?Q?+9tm615n/mrZKOJ8bqH0JZLkRm7fDcA5LUg9omC9u5GP8iealE4FJLBOdAY6?=
 =?us-ascii?Q?DVVU+ugA5IAQtTtcdieLpHIvabZiF80AenOaplYzLxcVl3N8eGJFZNi7mxag?=
 =?us-ascii?Q?uwdDLQrHK3dsuS1vd/5k/eLkPIqr4+RFMf/1Vt5LCnEEhPMJ8dA9d3r79zxB?=
 =?us-ascii?Q?ucQZAdjp0OmA2ciy1rKX8vdnVnj8UdG2lxOQHFszs9+1WTqrNTAGcnXdtzML?=
 =?us-ascii?Q?HMYOq4CbKubTSCO1nEOUQftZbLZM81d4KnjRUbOhxkcb/3Ie5fcxIWKcRRc3?=
 =?us-ascii?Q?QjOkovRLCRtEj6vA9oR2F2NEdMmr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A7kDaLPPtaOJw+9XSlcPBpidnJFVhhNIWzMRVz1w3joWZbC5Y6MAhrKM+73l?=
 =?us-ascii?Q?9gd/6ucAong+43qerhZUJdRuw9U8vDqpqMCglXmlKzByd/t27/kdMwiLPRQz?=
 =?us-ascii?Q?YIPou7WFLScTfAevvZZ3Z3YscQxt8xF8r3QhaEcQTLuse9FP5W/PI3/P5waz?=
 =?us-ascii?Q?QOmkMUvUPK9aN9m4GnC/ZQOhOsL/znHvCaMX9YE0leK1F3GgwUlQIQK6BnK4?=
 =?us-ascii?Q?/UllCl7kYtmc/9GVbZQ4moz1WnD+RMKhtzTBVCy60+A0l0MzJ8XM9cMXtMQ1?=
 =?us-ascii?Q?bZzrTFqYnKruN6JoxNem7ykvtVEpeBI/062NmDR6aY2LI13UNGq2cYJMiiLm?=
 =?us-ascii?Q?hztK7/9njZvorIRm9RtT9QiCFXUJ8BGGH04gJXHlGfAtjOz6ZHrQbxZUarzj?=
 =?us-ascii?Q?vPGhdQRUHwYL8+K6OHYTtx4siiWnxHKYm0pklAjLJiX57zkf5cfOzZf8YeaK?=
 =?us-ascii?Q?Slq560ekaW0SXzerZNw2DkFsLTwGewqQzDj2jKCjsihd1jRgQ14O7mIt+IRO?=
 =?us-ascii?Q?Jg4XBmo7aZieS2+5J8H2R/mvm00PYN7eFHPY7EDAqHD8hGyyXjaajYksJPAY?=
 =?us-ascii?Q?7db6H66HjZQXyYRU17CsSN24a3jWI4ihpd3PF95tJ2GCclRjOD8V/dav0vjv?=
 =?us-ascii?Q?dacZPemkL70gsYCfhgpyY3U6Op+YXBzbaciCbN62vH5h+ZOs6b71s3HZk5Oq?=
 =?us-ascii?Q?87efNx+SnYuKFSolDIdo4v7UO1zEk8r/ZFc+8Y18e/7U7YWqeXtk1oITJPTj?=
 =?us-ascii?Q?ORO4qg4SpltagVwfdaGS8wGkJ4co4xEX6s8OxousTurgFLId7GtFVO+XAcui?=
 =?us-ascii?Q?FAYAQc2uiUStl61In8c0rlg+3fY3GMKjUw6/EvNiHkxxcG5skg6F0wzPuawp?=
 =?us-ascii?Q?Lgtufww1VrfOSU3n/8OTkYjhUHXjKPLIflCfL3gdZw+rn5vprZL9SuoORFUr?=
 =?us-ascii?Q?EeSDHiMhDiTH5snKlDnJYoCZbkSHz+8t54SsvEcWVmyFYHhSEwB1vlU7pzif?=
 =?us-ascii?Q?ywkiDeQhXQZplN+FgD4kVLSPDnLMcrLVwk36/KMj0EfPnoOkHh+kfaGvFPI7?=
 =?us-ascii?Q?88FNSapIAfKfXmb0Fs7SFmqcv7tY6wfcWK/+GOXOmYA43u7vj3Fe6kJkXVB4?=
 =?us-ascii?Q?UvYksp6sUXocNU/OuiOo1tLw+hrjQEzaOPTWmHnh5sF4a+HpX78sEpT16IT5?=
 =?us-ascii?Q?AKPsSwXqNOu5nl04Eu3W3dmrnEgakvD6UwmbAWwD1egF4re3B1Ulze3Hjedm?=
 =?us-ascii?Q?fXVi7uVsm0hs8ErqychG4Z2cTHwprF9pSPLSKkS6K95vZu7FcpkoQcU/dcmH?=
 =?us-ascii?Q?uonSyy1XsNtuhEUn11u4P4jPD2cGy5smCr+vUD46W7U7lI+oEDA8i/vTk6+o?=
 =?us-ascii?Q?Vi5fCDzQZ0a9WUHi810UQfLj4v1ecnNiEU9ZOebiqmZCK4SPJwo5Ivegp/HD?=
 =?us-ascii?Q?0bJjhi2/Z0IwvH7PolkdOb5HsEWkfETYKoFa562dG0p8mwwoi9BTtTOnahNj?=
 =?us-ascii?Q?F/0oZkHL/IoL9FsOy7dz8Lz6SVZ5CG1q4UlgSE1zb3XU05VJDQh+7u87euXy?=
 =?us-ascii?Q?D1wzGYZV8QRVzPkA+RzV7mA+MEudQaoZph+yy0rN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca677eea-e439-4c71-d3f1-08dd5701b57f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 07:38:21.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiWS7xp2rgg+Kmf3uKuc9xNKcee8FH+9gPRbGtHGcvwv9jaQldrBhPWcnafJboDdws/juEZPsGumuZE5EVKqUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640

Hi Changwoo,

On Wed, Feb 26, 2025 at 11:33:27PM +0900, Changwoo Min wrote:
> Add tracing support, which may be useful for debugging sched_ext schedulers
> that trigger a certain event.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  include/trace/events/sched_ext.h | 21 +++++++++++++++++++++
>  kernel/sched/ext.c               |  4 ++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
> index fe19da7315a9..88527b9316de 100644
> --- a/include/trace/events/sched_ext.h
> +++ b/include/trace/events/sched_ext.h
> @@ -26,6 +26,27 @@ TRACE_EVENT(sched_ext_dump,
>  	)
>  );
>  
> +TRACE_EVENT(sched_ext_add_event,
> +	    TP_PROTO(const char *name, int offset, __u64 added),
> +	    TP_ARGS(name, offset, added),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(	int,		offset		)
> +		__field(	__u64,		added		)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		__entry->offset		= offset;
> +		__entry->added		= added;
> +	),
> +
> +	TP_printk("name %s offset %d added %llu",
> +		  __get_str(name), __entry->offset, __entry->added
> +	)
> +);

Isn't the name enough to determine which event has been triggered? What are
the benefits of reporting also the offset within struct scx_event_stats?

Thanks,
-Andrea

> +
>  #endif /* _TRACE_SCHED_EXT_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 986b655911df..825e79863057 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1554,6 +1554,8 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
>   */
>  #define scx_add_event(name, cnt) do {						\
>  	this_cpu_add(event_stats_cpu.name, cnt);				\
> +	trace_sched_ext_add_event(#name,					\
> +				  offsetof(struct scx_event_stats, name), cnt);	\
>  } while(0)
>  
>  /**
> @@ -1565,6 +1567,8 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
>   */
>  #define __scx_add_event(name, cnt) do {						\
>  	__this_cpu_add(event_stats_cpu.name, cnt);				\
> +	trace_sched_ext_add_event(#name,					\
> +				  offsetof(struct scx_event_stats, name), cnt);	\
>  } while(0)
>  
>  /**
> -- 
> 2.48.1
> 

