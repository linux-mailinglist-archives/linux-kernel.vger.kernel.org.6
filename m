Return-Path: <linux-kernel+bounces-446927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 118A69F2B02
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A39163CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E571F7094;
	Mon, 16 Dec 2024 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqlfAeWM"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2A1F4E4F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334709; cv=fail; b=tx2pIi2pqrTeqYgyWcUCLoCSIaDQkEBv/lC42fmtV2AIG4nzpupCZTdmQl5EaENMK/acXinlLZx0+auxDbw8J4WbUmZjkipWTF29t5MDa5mMczo/Tm9YQnW6RVuPlU4LPKA9VmndaC3ydn3sj7Lk4q9CgFIstecD4ShdEaxWQAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334709; c=relaxed/simple;
	bh=d/WKw9fLzsZ2uJbaGmh/VLBzGuN6i0cRrxIBJ7DgoNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XgkYBkLvmvfdOnXpeiFfUG1cMupHHFl8dpEa9ZXPc8NNlGFUKAcZ1oZRLmMWOYTkANoyCg0c6s5gjKKjHIdUnNroox2W4SS6wbpQiFzSNfiGiOBfB8oqLFkHgtnjnjH33DrBX7bjyh6N1ieSrn+b5FYgsyRQ2YwvQJqt4hFu/Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqlfAeWM; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yh4FII2M48FvW/++X58tSYzdE+LhbYzdhN7zqWLr2tsW+BNJWCldYWzVoM9+oBLZdW2j4CfCzWN5b09910zpiq4BEyDrvkPKlsYJprBs2a3j+/ZInPwXkMKokiHO1qz5sd0DZrEWhGMJXaxF+cyFMrGmQEcJaEoqS7cKNRRm9uAQ+ExFgZLKiAWhF0FtiNulBQ6wn5hXVSAkErJxiesNLDOBQT6AR55hgnuW+Ar9on+IXLFsS6K+5TZ3c3eSmhtc3KFGTXfnleFtBheWxCyeGKBnVxF2QcSs1ATFhaSlduzoIjxxtQKle/x07vafp+84i1Ml31sf6/6f+3JfFFhTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X8ScgFucP0rdlkH+gU5MREOYtr3/onavQMctfIEYHs=;
 b=LzUGn+BYSk/XuguztvAeBmhAOLlBYrGxlBXL5mATIDhzCSowYCDT5cShFSiuq2i+hZRl0eqlj+NM9odlOSg7r4Sl1jAdbKutTdmczkkzraad+Zbl8zYxlWUDIozzxVcJRqUEJ1O/D6+2tiv5I7ZxuPLGVtWlqIpcYT2cqw++QWk84D+9o4tZftkEQFQN9PFik0EMrbSjSDjkNMrtxGNJeHIH+mrf0T3JA4qaIt4iD1csy6tcif8/DsJYvEluTbisLufdodoHF3eSx5G13LmoDrI/sNOT8OEfjB7cEk4wnfuSPfoNJAn4rDXJmyHdd6qhL0/3ppYx38k7ApqRfIliqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X8ScgFucP0rdlkH+gU5MREOYtr3/onavQMctfIEYHs=;
 b=uqlfAeWMkpULx7FmqZ9aDSNq1KF/Dm6f9IJIfYOmW/7Daz4YqFALOjuwBB7tMONEK8XsDRwYKf47ZHKAyQAYS9a725EBcSaZLj76qqxrpzKLyl9LHtUzgf149HQmTxB0M77yaTbxCD/HvigZxvrTaR5TW2qK3aAOuj05A5TJ/86GzyuuJV+m4+l6OOBhE/ahwUtzMbm16dyxJRTf9AsR/pX/xMlwJv+JuKgAQz27aTiGY74EW0IxjM5m+TM3sOxOQoCScsoCA0yozD+afTFR4D2rc8hrfsoZjeCRI0oAzdLqDOeAbrl6jCHhEFiv6S9+X8gOBqcp5eo5ryqs3jTnfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:38:24 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:38:24 +0000
Date: Mon, 16 Dec 2024 08:38:21 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	peterz@infradead.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH v5 6/6] sched_ext: Use time helpers in BPF schedulers
Message-ID: <Z1_Y7WdR5ete7W-D@gpd3>
References: <20241216031144.98097-1-changwoo@igalia.com>
 <20241216031144.98097-7-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216031144.98097-7-changwoo@igalia.com>
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e9fac5-8d73-41a0-4a84-08dd1da49fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sMWAvRX8HCRah1vNv0k0GdYjVPyuo7HJxyer4lN8lrP7Pd9scvGuoFD+omn6?=
 =?us-ascii?Q?y92gF+ho6zjMghgGQDd3e6TbXEMNCJSfD3mDfRXYTygljLnEm2SBc3OBAaZ6?=
 =?us-ascii?Q?qDESI6eqKY/EzaH9ht5fK3rB+xgYh0lo4iYeosfy9KKPftlDaRU3Miw/1ixi?=
 =?us-ascii?Q?45jlWcIbRTg/uMpr0k+fJqoGs6W7JfYMhDot0ciVx+OaBS8DNuccRW5mHvAa?=
 =?us-ascii?Q?c+pYn1fGWJvaovP/kz6hRYnHXzn0tGKKRruYNRi4ky/YBHK7R1xL0qxwl6Nu?=
 =?us-ascii?Q?1B79RKBumNeUWOl8SbQrJjWiNYYGkm5zCAOrLwRxOm1HFdRyhgPEAVXXvJor?=
 =?us-ascii?Q?mLW7Ehh+aVnGfp6AD1MmVYVK/lOgxABHn3AoZ5GBZRJ88G3bWc++vFn9XbjR?=
 =?us-ascii?Q?d6km3ItEvolA/Q5KXXcUBql/EKk1K+Zy5L1MfbcGPwJcah5aTkZMDHKSRmYG?=
 =?us-ascii?Q?YOebN5EgrLQs49eDAfmutJ3pSPdXRMbrSvyRTqDlmS/mg10VGDInqLjLq7qB?=
 =?us-ascii?Q?28RaEEZDZiqNWhsrMm4vFBOj1lJ2qus6y8GPedqqUMLUJMnyPj4SmQR0LOce?=
 =?us-ascii?Q?E4yNr5lTdAu9aacwHWs7RXT/0rgCh7H7pNUYmPEtTr1FyXks9Fh7w342GtrL?=
 =?us-ascii?Q?yscZuUKzHDk3XQayJIjgyvD/hMiddcoHEDxuNtabbD6ReF7jBeU1ChsyUbnS?=
 =?us-ascii?Q?jWn10PM7OpmllsbLbxWsot0uxHRtx5bd02E8/odoAsPjtOZ3/N8QdRGe97Nc?=
 =?us-ascii?Q?PeX9QNGmtZd+gzJtjGVbVnN9WFYxrPLJ+1tX4Ec1NmmgShanjtGvKaRXxksU?=
 =?us-ascii?Q?hEP0bNPCy9TcRZH5h1FBcxbK8vve0OK9bIPoCOiRmNgRirEjoCn448FW+Luw?=
 =?us-ascii?Q?j+wfdgkN3bGRqu2XsZOnIrVR3mCXB1pUZDS3e+5kfIrONg86l7h9zOmoO8V7?=
 =?us-ascii?Q?NqXR18m4fj53JxlEoati9UcVeTOvulaa7M6d2cF78EVSsPEsCAbq7XSgtHTS?=
 =?us-ascii?Q?sx/gixI0V+BkltfJsxcm7OJ3fK7C757X5ZMs2HxrhfO/lqgVBT4u1OBMMJhn?=
 =?us-ascii?Q?S97dNdeRPmQRdniSROkQ4ImUadMK9ze9dbFVTbON4ZSdWnUkNDAeEfx+5uXN?=
 =?us-ascii?Q?RuNyrmAh0thJEF0TDgARQM8DJvRL9lXSUn/I+UcjF/mpaNDa9HLJqe9JFboy?=
 =?us-ascii?Q?pG8wd9Yne+5IDiyhI3wzKq5CrOW7oiGE6kEgS2HShaJij/sju0/nCBHTqoKL?=
 =?us-ascii?Q?w7yZzg6kkS1FnbpqOG5fvLCGIiCzVK6q2xRB6atKY6bfRcUNM12II5c09X32?=
 =?us-ascii?Q?vhscClFlFkgIGdanXut5DeY/vdWDW674oP4mYPioBS1AiZj+z/qfNeH+gQmx?=
 =?us-ascii?Q?PfBzaZZZCCPQBksMLDrgJL/9NOv2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/GFjC6ytcJErJIJCZDOvbjd8NSfCUkhK/cdbLjmX2C5+6oN4CQBlmP3G0/3?=
 =?us-ascii?Q?xYL7FBn00xkX1h2AaVtrROb2ZlWdJ6RSTvZNv7nxnqWVqiyBfA6pYX8jH8b3?=
 =?us-ascii?Q?r2JF1EXUZmK4RiBHXeLuizsrtDPfrbvw9F3nGUjqDfewjbrVsNAtIfYPhp7Q?=
 =?us-ascii?Q?gS+w5lw1kRP/aUsrCcWaNrlFNh3dhcia60JyXDW4g4c5Ox7XJCQM9QoEF+gW?=
 =?us-ascii?Q?wcq4rERBGMISEQ1zb7UCwBL07ext41HKxojTsbLQlfwwIy19tDc157ca1K7V?=
 =?us-ascii?Q?CHLwEDO42jONMOENI593EzcL4ypvKk5T70Y1/wHT3z1gbElHoaGXEExv2S9k?=
 =?us-ascii?Q?xQLbQky6zD5j7xFjxVLwd5hAIfNm+eNxW47jq6/vGy3XMMkTmb7aT7MLUARL?=
 =?us-ascii?Q?OKzd7GTsMC+Lp8/OJHAnshCDVey99PrqNCZUgRw7VfIEgxXrgzrM9tOQrHTY?=
 =?us-ascii?Q?poa0tSD5lDwk7zyBaXjdR6T9LP2bHFusQuovXULoVq40pzGzm6qb2ZtUlKyL?=
 =?us-ascii?Q?d0BiKCxEcQMQSVOIlXZFOvEHfTKQmRIVLMoTtKH1YJxBye9UWTnzdYfeFQ6h?=
 =?us-ascii?Q?dEF8qGGOekKnKqkdcXD4NR7ziOcW+LMtzR0dmC71e51beI5k8piBr0B5gyzq?=
 =?us-ascii?Q?BXypfrsRA9Ak9EnjcIJGiqm5JA/TObrD/Bxyf9C1aZPeTfKP0vEW7cBfEyxd?=
 =?us-ascii?Q?pgkKNHJJUtBG37R3VVW0Gsoda9mUYtB654Xv49BZfCQ+nhGidQcN/AkrMYcJ?=
 =?us-ascii?Q?2SgDZXXaObKtonGhzyaXuriU9PUVyRFBtB5TJbCg4JRFA5J4p6NOeQFVw2kT?=
 =?us-ascii?Q?VS6HFgUy6YWu5Q7n8dS1xBHIcqAc+NwHi972AS5U1uj6xLBUzHwWKmDvDr4J?=
 =?us-ascii?Q?ZPY7q3nmuyeByAZPne3u+iTXRrq1g64TrqbojEUgZ9VNcK6TjGKXrgBXtdXZ?=
 =?us-ascii?Q?tx7BsGYMFjk3IE4yUvOGk7GUWTJGalrPWlSVLm8qJwWyW5Jup8R3YEg+k4Qa?=
 =?us-ascii?Q?hcvCH1seXtSaluLWGaQECGM6dwu70FRbVCTYR0THSd1ZonpTasyEqUcBwzJq?=
 =?us-ascii?Q?7hrFQP9+vGPgvjFVVES5h+BNANfEHmKGGGkDVZqGmepv9YSJ42KV2BP7Yxij?=
 =?us-ascii?Q?do487MC5d1qaSZmxcM1EF3Cz9C1V+AAD/T6XrKExn7Z52/FwyICln8+ym+aa?=
 =?us-ascii?Q?/Qig3uWO+3wnk+8CZ9bc+jRoHSm84nL+VEwZhykegSlHtD8Flw67/Tg7zZ9C?=
 =?us-ascii?Q?vV4rSV5DEH4IoxyMWf3Qd+s8q2Z6E/c3hUVqNHn8xvbv/ivBNCqIkeXpSjFS?=
 =?us-ascii?Q?i0IeBShuUNorysFw37HeLSKRxG4FAydXcQG+DdPiIdFxFQbCxEabKW53b282?=
 =?us-ascii?Q?8jGtn1Xw0wb/WsMsyrC/uXctzQpkzAQ/DDVoySx8mZvdaN//zYdU7ieGGIyB?=
 =?us-ascii?Q?aYiNO2h0ibgJan39r3TsoYhtzGgOddCUdaC93nH/n9a4Df4yNNeuQDpu7P4O?=
 =?us-ascii?Q?kAkXzJMhDeLW2G3l/RUlOQP/Dp4eBG2zbRQxarX1g4V634ah9Ho4+HgQzPyn?=
 =?us-ascii?Q?W8KE2JCAlpcTRqEoJBR69TO7EN0B3F44zNDYnUFD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e9fac5-8d73-41a0-4a84-08dd1da49fb7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:38:24.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lycGRiwvpq8n8ztVbUiQqI/QwzJa+ywSsXi8RaXHjjk0j6z7rX4Cv0iGQal3mYhLC3OljABufCY6mYf5B36cYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

On Mon, Dec 16, 2024 at 12:11:44PM +0900, Changwoo Min wrote:
> Modify the BPF schedulers to use time helpers defined in common.bpf.h
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Ditto (about having the same change in the scx repo), as mentioned in
PATCH 4/6.

-Andrea

> ---
>  tools/sched_ext/scx_central.bpf.c |  5 -----
>  tools/sched_ext/scx_flatcg.bpf.c  | 11 +++--------
>  tools/sched_ext/scx_simple.bpf.c  |  5 -----
>  3 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
> index ea1d853b9dd4..c3b6998ea83e 100644
> --- a/tools/sched_ext/scx_central.bpf.c
> +++ b/tools/sched_ext/scx_central.bpf.c
> @@ -87,11 +87,6 @@ struct {
>  	__type(value, struct central_timer);
>  } central_timer SEC(".maps");
>  
> -static bool vtime_before(u64 a, u64 b)
> -{
> -	return (s64)(a - b) < 0;
> -}
> -
>  s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
>  		   s32 prev_cpu, u64 wake_flags)
>  {
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index 85e33e45f818..2735ec25e511 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -137,11 +137,6 @@ static u64 div_round_up(u64 dividend, u64 divisor)
>  	return (dividend + divisor - 1) / divisor;
>  }
>  
> -static bool vtime_before(u64 a, u64 b)
> -{
> -	return (s64)(a - b) < 0;
> -}
> -
>  static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
>  {
>  	struct cgv_node *cgc_a, *cgc_b;
> @@ -920,14 +915,14 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
>  		    struct cgroup *from, struct cgroup *to)
>  {
>  	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
> -	s64 vtime_delta;
> +	s64 delta;
>  
>  	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
>  	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
>  		return;
>  
> -	vtime_delta = p->scx.dsq_vtime - from_cgc->tvtime_now;
> -	p->scx.dsq_vtime = to_cgc->tvtime_now + vtime_delta;
> +	delta = vtime_delta(p->scx.dsq_vtime, from_cgc->tvtime_now);
> +	p->scx.dsq_vtime = to_cgc->tvtime_now + delta;
>  }
>  
>  s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
> diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
> index 31f915b286c6..6561d400ae6d 100644
> --- a/tools/sched_ext/scx_simple.bpf.c
> +++ b/tools/sched_ext/scx_simple.bpf.c
> @@ -52,11 +52,6 @@ static void stat_inc(u32 idx)
>  		(*cnt_p)++;
>  }
>  
> -static inline bool vtime_before(u64 a, u64 b)
> -{
> -	return (s64)(a - b) < 0;
> -}
> -
>  s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
>  {
>  	bool is_idle = false;
> -- 
> 2.47.1
> 

