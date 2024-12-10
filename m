Return-Path: <linux-kernel+bounces-439753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED529EB389
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751B31883B88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD6F1B6CF3;
	Tue, 10 Dec 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DTY8dtjJ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2321B4221
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841460; cv=fail; b=AupzZqIgrtWPtWZ3Xe8zPQZ1Dr+8CunZdZHNL8dK04HIQXOWaTSh3VXemETcg1IMJYJ8LyiDOshNVXVBHWDBhYixPF5MqlM2o8cQXFRAg2RrRtGU7dzIQgJOeusKAeUSOQomzxE5L2OMPSWmR39zZEFXEK3g4Rv515vEBSN7xcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841460; c=relaxed/simple;
	bh=fK/5p4e6tWHL9V1EaFAnJMn0Wk3/CwmbMs3HDRMWEdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gRHZtZrUCI3+G1KfnGYJPxvyBHZFJxPm4c81viv0uVLZrSZVRTeD4d1uU5syiweIu4aEoB1T2FYPF44knDD704GSJQZ6n4ibDxfVl7YxxYMrahxYUdOoxuBRejulME1frkeRhXiVSDVJ2ayhmQubz/RpYBdCcQyAa0wVozq9Q6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DTY8dtjJ; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/Nkk1hMp3psyJqQ1A5g1orJrEYOEZzbYx086xYXwywcKhg1sB74i7punU0zj2oM7Mo4l4CWLUi/6X55LzoBEJQ40966ANHWfHTfxT34sghzEFTeEfAuqEuhJwYSskhM1oRsHX0VXPkouVpHVRHFDTgR6oJG2F66D1YKNFlPnnNsdD9m7R9ZtSsgdydKh28vUW/zfzYys5v1FjSoAU48eVKYuCyO7za5se/61+u8s7B5g4b1auLQions0Pjca+VMKh+BOcawZ37B+wXhIWhIpPVkp4xohGmLWwdtSJ3qJAg3f2V1HpOekLbu1LYNLtHgG/xHRJoKlumEtgS+fl+yDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY5B9DTJiLep1GTgQ53ODyS73LhOa9grM3xNmy2JI0M=;
 b=Tnk69mTKapRh/dLuy6ZDc86eD52kJgKq3knEWfy7O4ZXv5mhWRWBHO1bDm0HCruTGSVKYSLA/On3FsEMXvIJ31YtRh3s0lZ64xuBb2W58ZIXFc2DhP2WAt+PtkTlZBRyOQgHFC5Ie36OUJ+bORFKUR4of8Vs1a1z0GNFtNAEkGa0dYJh4+uyeJjaJ7BUYLH7G4B6oogk4oOYSllVp2cm8XBCq/O76QkIEK9n9SlsLHY8Lg7e4a3x1Fart8CBa8v+JU/MxqCOnsZUmMvY8ntYt8sBU9esruZxF2yo49yLzwfb3VI96X58k3RpLrQpbdcSGxPJnIu8ifb4D4qtA35o+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY5B9DTJiLep1GTgQ53ODyS73LhOa9grM3xNmy2JI0M=;
 b=DTY8dtjJxPFRG5hO2DrFtYN/zXdb4mPBJ4wPB8G6pgG6dg1q8h3XVUl9Des870GlgT/3BenALipIJLb2xIe2T7EyxcFNdrN6TSZFJS2TREyHSBf7OOcAzFkuDiNl807arZ0ENZeFqTrJN84JonVJl27fJO3sq4q2jMIGFFvwFaIjdSYW/iRXmDItqz1kCyG6s2fBOLS2blHXmmYiuCHIXL6nsVuLrBYCwj6T/hiuumMaykM8l2L1Q/6z6HC73T1SMoX88tKUWRhGMeI6B+YT7KoIovNklK+WkMpj1ckO8/NOLCMCu3V8o22BFuBCwKITZCalCIbxO916bC0JdYz+cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 14:37:31 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 14:37:31 +0000
Date: Tue, 10 Dec 2024 15:37:27 +0100
From: Andrea Righi <arighi@nvidia.com>
To: David Vernet <void@manifault.com>
Cc: tj@kernel.org, sched-ext@meta.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, ihor.solodrai@pm.me
Subject: Re: [PATCH] scx: Fix maximal BPF selftest prog
Message-ID: <Z1hSJ_ixBomdOJeR@gpd3>
References: <20241209152924.4508-1-void@manifault.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209152924.4508-1-void@manifault.com>
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: cd19625f-b1dc-4856-b176-08dd19282d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?czhJJdJ6y8qhG1xyN1/flfMEJBWtL7NteQCAS7P1OkFTqkm2/8HOFCFsJt07?=
 =?us-ascii?Q?pyN5INo3SvIikbPKhL005wE13VlcFgOLCfiBJwiHsvJxKQAxaWISszqREtM2?=
 =?us-ascii?Q?ze5w4XCLMxA1SCvHRR1I/fgCPQgepkOEsgyHpDXVrFRct+2fcbaPh9TlBkcx?=
 =?us-ascii?Q?QXDDevMHRm59alYLCKr/qB7RlBPO9jwNsqPTc6jgtJK3OqwcvtSi1z0Qollj?=
 =?us-ascii?Q?1anJkAsfLbTNaCR7qX8R3KB4FjJg8UY9Gs9fgwoyzfcASetpKxtoa4WGvSoz?=
 =?us-ascii?Q?RoH5JnWl/uIHs78az7Y5wXhHrzWT+XJ+E56h3tUXyBjGmVc+i8NY8XZ6VqC4?=
 =?us-ascii?Q?j5OfPFdUso+5yijqxxGy828mAm0VzbQx2Vc0P0Jado/fyXDnSguC0tjZgn70?=
 =?us-ascii?Q?s0wxNSVZCdvFQ0d4mnQZs7H+OmnVKIN+dETBN/lTrLYDfRv/bauICiEwpAgY?=
 =?us-ascii?Q?JHr6ZOLvwJearAkmU8GuINjHS35vdyYbp+K/t8HC/4vl5/SrqDlOz5Fav7oc?=
 =?us-ascii?Q?WtIs5DpDPjZH9LXsQxuNXwPPJQMiMpnY3JMGnAbBjLRCrdDV7obbWxRvs6lv?=
 =?us-ascii?Q?jCtyDsi0ae1vv+irh+BGaHVZSfzcw8lzGFS9l8maeC4yILOCMq6tFZIkbZx/?=
 =?us-ascii?Q?9s2NfYG5VzH8SzEySex6fQ1rRj0bu1W+GxZs9IgNLBqjk/O2wJfGjNZy9/ZF?=
 =?us-ascii?Q?EZhUciM5NRCMCjUw9zR2btiDyt14HSmCf+dMXsGpFQlmLzFc6lb0o/9qzV5c?=
 =?us-ascii?Q?wRVeeHLbpH23yal4tB3aRDrso5/wLimaXd3OJ4kqfEbxp4OfmnO1QpY0el1u?=
 =?us-ascii?Q?7ageGLjNMcFiEaxUB2+/oJ3xodWbdl9yUdsqqJIrvj05KtfvHSQbuq1GFntK?=
 =?us-ascii?Q?O3LXZYEkcroElA65JfKWsCNoKmZZbbP+Fn3xjSBajtQP2TY7mhaSBx7kuPmp?=
 =?us-ascii?Q?s89w4sFRXp1FDmZfgE/DLFJK4CmWLp6BrSIQL426eUq3p35okBu6e20Cgjtf?=
 =?us-ascii?Q?cFIIwwng99oYt+Rg3c8nD4dGL6HHiywvsYEsNypjZsw1uV3r8NzB+PJV4YQO?=
 =?us-ascii?Q?lPC0qDOeyfkLoQJFybsTJzbbxv4QesKXrsO5aS90UFUFL9lWTU8roRXfSBMl?=
 =?us-ascii?Q?tIR27+WRlObTN1vwEGI29Nx8aypsquictAxvFCylPrbEff6urWUxJ/uW5f+y?=
 =?us-ascii?Q?c0dWV6215ARIcU3KYtp9MhnkSlrkcXHGpij4FN5DzUj8kzQ5OtyJgsID++Uy?=
 =?us-ascii?Q?svgOfl383ZpzEnL+W74WOm+QSVntkXBgugfgh5KlPlalvxwJvsn1spMyfLzV?=
 =?us-ascii?Q?VQuuFgW0n2STs/5mK8ZHQX5tS1WbH27k34ADxtUYaImd0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d+KnxsMbh4weS+4NRqT5miNkzDkPhamr2yct19yer31ZGSD4nfUas2bj1s2V?=
 =?us-ascii?Q?3ag3RgdCLdFF9MAAmSYom9uB0EH1g6mHvrwHmJ5vY2JMzCfoucy4K4hKs0tP?=
 =?us-ascii?Q?SMc8VeIdU4J6uh49JpY6DE+IezpGSRdLbIYpPkM/CYC4oIBj4WSqZ6mEdv4D?=
 =?us-ascii?Q?9JfSCDG4kM8CAS15xXUPxiA2keOKildgmc1+Dx/CXrjJEung/+k8I6/zG/kR?=
 =?us-ascii?Q?9yoXo7beqrF5dU1mweUDjjTCVyi7Ud8uo+sEp9Iq4RM4cyDKLvHqQk2Ca635?=
 =?us-ascii?Q?6agx9OYKk+76z5GevNeZSfEvHcOhfW2cYDjzb4H0aEME/DvVYQ3pvw7Blt13?=
 =?us-ascii?Q?f6tvmU5MbaBrBFshHCThKu8qGvwDXKUO9eEW0IL2J8zJl9DCjipkSyIOfcpL?=
 =?us-ascii?Q?99b4mQogrn9QW4v5F1HOxu6Va/9ofSmStbNZ2WnLgA0id9nYwT0zcMY0xk2N?=
 =?us-ascii?Q?5u2lFv+VN3ZbBuH7O5LgY/5ANINzBgjkOxd2fqUeu0Uy+t+p6V4+jDqaS6wg?=
 =?us-ascii?Q?kEaLzqBw4f7HGy+hwF3RYgEwgD9kg4XO/bn5pgNLAW+EyJ2CmqBbgI5JIr3b?=
 =?us-ascii?Q?SGByhtTMBNXfnbFv4ORxnwHMZLhXac22OHQDoX6ONjP7OP27B+oAZu4R5+01?=
 =?us-ascii?Q?o43bDksdo193jZuTxSxaXsyC55TxPjWT7XsidklvX/DGcfSG8QAiB65ZSuda?=
 =?us-ascii?Q?egXSl2lQ+NjZtY3aHGRgpYoveJaKiMLLRZCtDKwSgMX4G3uYpVfwshzrBstl?=
 =?us-ascii?Q?4iCYZNuP/zxfDOSypZBP7OOrxV0hbkLuej4If7bv18SnQpcx3PSyvyRXXxnZ?=
 =?us-ascii?Q?66tKHEaxOTl09YW5IvWBiVWbGlaOd0sG+Nlsi2NsIq11Vqos3TUADjlLXY6d?=
 =?us-ascii?Q?ZCfAeFKs4iosM4PWHfCB9aK2s5lQMVsFhO5YICeZLM1kv3b5zDySZpKNow8r?=
 =?us-ascii?Q?ElX2XwTy0l3LJLSJHuFOMVw2XOPvClEBCeZd32sl37pqpLIYAFqJhVUxuojn?=
 =?us-ascii?Q?jMlqc8XrTK6JZvVqUChoisaLI3MSoJVSrH2BzS6Mb4ulYMrd3RCKAo47by8W?=
 =?us-ascii?Q?8ALVEN4G0XJoZLR8re+bbnkriXZ7BQ7uOB6KkyBTLFGf8fegcqJQkk2tqRWF?=
 =?us-ascii?Q?PKRuYUGxoiIXoLU1Ets+rph7/s8CreGBLKwv4S5fb7jid01A00Opi8Ce+MK1?=
 =?us-ascii?Q?gEszn0Hr/uau4o7oK8eLsS9ShtB3DGhtZ+4MlgCPu9gotiQwVcYOHQ3F1Z8J?=
 =?us-ascii?Q?bV6sk+EWxiuCgVhDuwC4jAu+O0QnmwnusXZDnb4BHW0EiBg+bxm1DPdOGxIe?=
 =?us-ascii?Q?iBUT8yWzYOUKcytyGTf5D2iQf/2n6z6vOTvTvFye7NDvCfGWg6vp71XJSVTL?=
 =?us-ascii?Q?Aco9YaSPU8546ODhdfBNz3CkUJeWrPL7xIJa5fgmev1KCJP1jU/6+3hjInGe?=
 =?us-ascii?Q?cm7iXaKKAN58B/707IZlwAfWglKiVfkahvHfTuoiVbbKR9OrxqSpFCUCyFG3?=
 =?us-ascii?Q?vbxfpKLsqRoxkCwWFBdTdNJNZq3MTOyn3RuLAFJnmDiLNimSRi+94Dx9ec0u?=
 =?us-ascii?Q?BecH8JLGnALAzB76J+yNe0QQLYnp4WMnOsYjstoT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd19625f-b1dc-4856-b176-08dd19282d91
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:37:31.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAK6L6hNfyvRPElCAwMn8STwy5OkME8xldgAprf0kjj/rjPMtg3e4j8ZfJCYUUEtwd2wU3CqI3SLFCp4Kl7KMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307

On Mon, Dec 09, 2024 at 09:29:24AM -0600, David Vernet wrote:
> maximal.bpf.c is still dispatching to and consuming from SCX_DSQ_GLOBAL.
> Let's have it use its own DSQ to avoid any runtime errors.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Looks good to me.

Tested-by: Andrea Righi <arighi@nvidia.com>

> ---
>  tools/testing/selftests/sched_ext/maximal.bpf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
> index 4c005fa71810..430f5e13bf55 100644
> --- a/tools/testing/selftests/sched_ext/maximal.bpf.c
> +++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
> @@ -12,6 +12,8 @@
>  
>  char _license[] SEC("license") = "GPL";
>  
> +#define DSQ_ID 0
> +
>  s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
>  		   u64 wake_flags)
>  {
> @@ -20,7 +22,7 @@ s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
>  
>  void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags)
>  {
> -	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +	scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
>  }
>  
>  void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
> @@ -28,7 +30,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
>  
>  void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
>  {
> -	scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL);
> +	scx_bpf_dsq_move_to_local(DSQ_ID);
>  }
>  
>  void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags)
> @@ -123,7 +125,7 @@ void BPF_STRUCT_OPS(maximal_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
>  
>  s32 BPF_STRUCT_OPS_SLEEPABLE(maximal_init)
>  {
> -	return 0;
> +	return scx_bpf_create_dsq(DSQ_ID, -1);
>  }
>  
>  void BPF_STRUCT_OPS(maximal_exit, struct scx_exit_info *info)
> -- 
> 2.46.1
> 

-Andrea

