Return-Path: <linux-kernel+bounces-562696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D1A63124
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10ED175B45
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69178204C13;
	Sat, 15 Mar 2025 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSf0DNEm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CFE14900B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742061413; cv=fail; b=OfpD/Q8GM8Ugz52qhVt6UJHyqEFv/xU7M5YSXQ/6ExUd6OcDUhLOV5kCw46xcX3RwgPr2VPe7W0ztcgiMu8YL8i5iBgIBPA1+FMo8Ygm9mHTlU6NrMU7pRxZUalKG1yz9wjMMdRWiC27j2ojHEJSSMdNWvvvmUKagkz0P07uh44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742061413; c=relaxed/simple;
	bh=Mrm6oFh0ClUTGi3NDN1rAyTHwQTgZLEQXi3n3FJy6tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tDMLfpHF+IKxy1w8JcuCWr3tni+kprWqRxl1Fnqp2HevjMfa3nLUTGj0OG+Q3XyWWKyuu8yfxmYOpbyKqujv6oQKqGp3hQGIRtkZSIc8eIcZxeA3Zph4UgtlrlS+TNiUNekpRyaZ09ghF6a5zfosL91mDYm5TKZMebWU3rTfuS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSf0DNEm; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOv2SaG2v2CcysQ2rRG1XxUDktvzCrV87vb71PW57n/AS/v+LVG6U88m9aZbR9Fv+fYUflYNbbpnQcKz+6CtqGQlhLSzv/UCW7nHm++5uiy+yDErAs7rMHff3wENfYE1Y6BzVaf23xgPNZ+m2gTfth1CN5lN9dXmh5gS7naPmMy/8QQHUs70rtIbturcmMxVLK/BYKNjtyaj4GVmSnDK3Q9EsaVXsrACezSioFP5LbCJcmZS+zvHaN2umxQkm1YVrFLrxV69djOB1JKYYJaLq8ArVtA9OPYVDgKXHhWfqU2TzFZTaHeU2A+gtGdzbU8X8Pzt4l+REt0vITqKfevFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se0qYmdsPGqef75iQofgdH5/OX5WopEIb86SMpAkOYY=;
 b=CUPCMnw4lnxFDqmoWIfY9IiAfKVvinMGgIQzzinnzJR4OMTH6o7rrCdgcJ8rOhd7oBNwjYi4h8ZELDsSA/pjWyzX5yd4faPkYfdnQbQf9Nmi1u8a/S/LdS84lK7utzFUc89o/tCWMTiwFcQEyoVZNX9FacG5ZDqPCT6HFh8AcrRvb/x17+SOoJqdiPN0UXTZfksKBnf7OhfU7wEVHpQvVpPvQS1RciI7E4qkmryaJyCSVGNro2y5Bubhhc9YglwYh1SM37COXMhyE4CcIFFoheB37njjSBQ6W6mvBboL70bpiz6eyOVZclibJ8qhtlzvjw66nlURrMeL/xgiSbpofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se0qYmdsPGqef75iQofgdH5/OX5WopEIb86SMpAkOYY=;
 b=PSf0DNEmu7Na8cTZfy0x+QFASUFfOlvoMuqkvbxhjjQFx3BGd24yKS8rk5AZ8jncTaW7g4G9VqW/q5oXofzFzWNIdIjFbHhJq4KNtIm240fh0zQ0RdMzCGWe4Ph7ILhvmz0RyetgH18S5+8e9fqVGHZLxddEBK9zVPqr9KIjJ9WP3mOdxOp/lh82SvfFHBKJgj8WRmv0+OkaUrxZmH0QYBnnsgA5oFe9XgWnrJgE18dbWqm+rNaGVIwG4jgECMx4l4cctxF8KnuyDDvyr8pT7DHKsyEcuZrKMSR5wA2Rf2Dki8skve3maAHDgLDdrFh5nONnhf7p2pGix5AAuz7JgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 17:56:48 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Sat, 15 Mar 2025
 17:56:48 +0000
Date: Sat, 15 Mar 2025 18:56:33 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
	boqun.feng@gmail.com
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
Message-ID: <Z9W_UbeDXUok4D6R@gpd3>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315022158.2354454-4-joelagnelf@nvidia.com>
X-ClientProxiedBy: BE1P281CA0325.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 55de24bb-a3b8-4024-930e-08dd63eac1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gi+swcJAciO880stZxauUV9b3QxKt6NkzxgRsrquJFu12MUWgnHFzb8+bYKS?=
 =?us-ascii?Q?DDyhtl7k28SKhQow3/Zj6PX4B2rSWvCJsxpxTBVQzZf926nUHhNariLSKP9G?=
 =?us-ascii?Q?Brz2Vfv97G71TpCaKed7pv2pXoh0qGc8nJ8G+qlXXfMkzZuC0x+PRE8HIKlR?=
 =?us-ascii?Q?c5UTnSCjmwozk70Iseqzo4ME6Ha3/Puz+FqESaVhzqBGFxMerDW0csbBoIbW?=
 =?us-ascii?Q?RK65fMqzoOECLeoTrjzCdCV8Inmx1nUMRLtF2FJJS4TRvKXfac8chqM8ofco?=
 =?us-ascii?Q?NjdkXG1M3XiL1NsHiPLj1AGPFtRhqYUbuYdIUFD07JI2V/JbYRQIoc+0MRWb?=
 =?us-ascii?Q?Qx7COsV8OaH98vL6R8lC/DsB4WaY3zaIPZEDHGLNgZwKXGHiHscrTcG+YXRc?=
 =?us-ascii?Q?SVMoTFJmRCItbBN/oWJ+z3drYWySlh9WTv2ovu9zc3soBt6HSrSlBfk4PRDH?=
 =?us-ascii?Q?ZtCIJC8n90ny38Hp5eDDU7vB9qFh/bK3Ff0zKf10JOmmGKHz54egkt9RK1Yb?=
 =?us-ascii?Q?vbk+1GD/YrbK7oDPeYwjTbRKq4qMcyvRjRVI0s/OhUPGFW3ie1LA5VCZBghj?=
 =?us-ascii?Q?544pRSpuq8rFd7fOQZUlxa6lQMiKz37RlrITlAkXNQFzKhZadFcj5EAHSfUl?=
 =?us-ascii?Q?Jd6xBuqfM+WaK+oY2AFgF27IDzVqleNHuk26pveQ5RWuFdBW9gIc2+19H9L+?=
 =?us-ascii?Q?sL8lZAMf4kl1Cey+3xQuzmGqUr2ukTH2iP9EFNq8d8SWA7PL9KRgWSHHQQ8q?=
 =?us-ascii?Q?U2zTkY0mGLeKxU/bCvW7SIlAh8/PJs4dfmIXQ1tKLhgLXJ21hFDFFl/jHdlI?=
 =?us-ascii?Q?iFF0V1FZLMTp6FqSp9rzD49b86Lb6lPiUepxOGDR5n7Filum+7MEYN1/6GZi?=
 =?us-ascii?Q?v54v/D6F9lSOgg1CJEBrKoni0F1h+ttuMZ7G3EfrMFhdtfTbZ1oXO5XspdYz?=
 =?us-ascii?Q?g5TWyDsYgf+UdrECmy6W6y0UPyDx1VV82NPyAaYloC8C9qYNR3PG7x/+LFXw?=
 =?us-ascii?Q?PQRQSZJCYjGk8Zcbd6WA/rfI8YiQlMvYO0YqXRiKSxLXUV41+cBrQK6z6W2l?=
 =?us-ascii?Q?r9V4vpdqqovfWCEFNe3iRO98hMDWni8XTADSzpp0UFF4u8irsB88+jwHrr5l?=
 =?us-ascii?Q?hw8aVbZKFh6hk/Oe5xPMKXCbLOAYl5ZxjQ9aqDvKfvf/wTAB/tZhWGb24DZk?=
 =?us-ascii?Q?VGTtk7PfNROAZcp0c9tkCsDnauHR0e0wDPc8tSmIxrMK0FHK7fdD+sMn4no2?=
 =?us-ascii?Q?SUtAlcPlxZjCb8Xz+fcFbEBcTl+fI0mGuXgCqdxZm33DKjArZUT75Z5yl8Cw?=
 =?us-ascii?Q?MbqoZIL5Vw1wdSdef7ZHBSes9owzGbLEtN1F/6Z1HpoExP4JMGHYJ98KuRU6?=
 =?us-ascii?Q?GhU6mj8ZSD/Bvvu9btOEb1yYRSoK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M8u+pV0/9teFtR1VyzkB7pdTr5DkWkVudinPoZSUrQ3lQEDsNFngXYJUaPb0?=
 =?us-ascii?Q?zfbsfl84YRNX6V/FMece18ecBvZQkweldsiwc2lRnoR/A1+pHfNwW5qqy2yy?=
 =?us-ascii?Q?p5k3D9QIehII7Srx2z28VwelOknLfBe5cdKFPUgJueQEunroUXLfC2AOThyD?=
 =?us-ascii?Q?bGjObpGDeMkG6fE/pp0bg1cwGM1k8uuA6qNJqPtrVYfMxd5J1vWmEzng3gej?=
 =?us-ascii?Q?X+4YcAqTlI/Hke28DsVFYkjJ7Y6TXoiG2tb6Wt2gaogmIDwoGaPe4PI4uLb/?=
 =?us-ascii?Q?KvjwR0oyxdGzaqH3smJwUoh52NQjHjHPrS1CV3NacWEa9wiLqU5C2KLIpxhX?=
 =?us-ascii?Q?rA6dMoqchhpgXg6D8SPfRH4IrCaoEF84xVoqgn6DaIaEFuqCBHZGqU3ubFVr?=
 =?us-ascii?Q?4nTg4CAcZNRLagZvFZj6/JCdHFWuoNzur2mNcmFXhW3abrKVj/XwuYZUDeCi?=
 =?us-ascii?Q?7CWPZODAFeHcKvv2wopCaLcNo8zOsMsgGlVq6ZYGjspEVL5dIUNP6eJSIihP?=
 =?us-ascii?Q?oiuBihIcckl2OnGoj1fpLyqLL1HJ/oAD49hgx1eOrny6xSODcPxWSTg562AM?=
 =?us-ascii?Q?XFrcMtbOunDpezt8G9N46juAw0gg1kJ3Yy/txZr0rCMs0lzv4kq1Kgwt1b+R?=
 =?us-ascii?Q?GEVYYTgaGEY4RenBqOVOn0Pm+2lTbFkecinJAwHlhT70C+eZekuy16KRMQzx?=
 =?us-ascii?Q?6V+GDj/N6kpwm1BEb49ue6J7b1OdaVYZmB4DG12FUWmDOAPTDrjd8tyn8kUi?=
 =?us-ascii?Q?ig8PaZzcm1DciZlr5iafQsfCWatqfpx4TEDtYUtdiJVi5LM/H4lEyGgWZEVq?=
 =?us-ascii?Q?SfL38zKkz/lKyBfJOguPa9+NuqpprexqofwYyGhdybgDUCES6Hhmon9HfKyF?=
 =?us-ascii?Q?9m9dm1OLxyJR0fa5XLpII0IdXhuYjR/tUMMmQiaOs3zn+jJePfDvh/w7P1G5?=
 =?us-ascii?Q?ls/Bz0gaDRNDPYNT2e/IlZpQh0U02cp4LI9ILP/hysrUFyjmycoo/dW5MFre?=
 =?us-ascii?Q?dBFBLY+cUtHOqHQiL/jcLG2NoWJreLehUnpogJQgaRPZIQNnpZMle4RV7OzT?=
 =?us-ascii?Q?mhNnc6qfq+SlMQ8ILPeL6eHHNKKuclYBhasBqcFH14/Snlgiyl3h0tYaR2aZ?=
 =?us-ascii?Q?LLAoCkojnLftQIFnDMmQnLjdw+oXJD6P6FttdzNTAR4YxkpsUHA4v9ICpmv7?=
 =?us-ascii?Q?GLbOTmb/XLkEt+2oyM8f8k4N37g6eYy9pc2bUk7RGlD9GPTjCTlfENAXM5zW?=
 =?us-ascii?Q?PMOmG+z3Rb/NAGIuaNnH7Plh5jGpr3FgvQSk0EivgSqdYBsTsTpoKAFM7l0E?=
 =?us-ascii?Q?GwT4LSTsWRu8c2i9APnvWkN1Hg0c+xWcfGTSZcnv6UHKIeQyRxlGh3MOvtwH?=
 =?us-ascii?Q?kcOJCMRfi9u1HxrWnW106CzQhIdRnewg2lQ9lF8rwcYVvo/e9fdxdgzKp0K6?=
 =?us-ascii?Q?dly8Kbnxw0qPzm0p5RpY6VsoAJO2vzJGDK8YI+GqmRFzso+7nIW2aEC2Ab8U?=
 =?us-ascii?Q?BsOjLxXsa7FTQU3Ut4wuUm+sn/6Hbzftv4TKUu5Bz9DxLPjRFz/28QT2UMe6?=
 =?us-ascii?Q?aHFYZi/0ot44PJgi7XI9jglBuqSEKikNBnSoJijm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55de24bb-a3b8-4024-930e-08dd63eac1a8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 17:56:48.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHqkHr4M222GMVc7/1pnfTjb74H7ysX5fnJ4wyAJbHq28l8GCWpZQhhNHmI/x7g7/Qc+cmadzIYuAfA1QI4e/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

Hi Joel,

On Fri, Mar 14, 2025 at 10:21:50PM -0400, Joel Fernandes wrote:
...
> @@ -7793,6 +7819,38 @@ BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_now)
>  BTF_KFUNCS_END(scx_kfunc_ids_any)
>  
> +/*
> + * Check if ext scheduler has tasks ready to run.
> + */
> +static bool ext_server_has_tasks(struct sched_dl_entity *dl_se)
> +{
> +	return !!dl_se->rq->scx.nr_running;
> +}
> +
> +/*
> + * Select the next task to run from the ext scheduling class.
> + */
> +static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
> +						void *flags)
> +{
> +	struct rq_flags *rf = flags;
> +

It'd be nice to add a comment here to clarify that we need to call
balance_scx() before pick_task_scx(), so that we can trigger ops.dispatch()
and consume tasks that may be pending in the BPF scheduler's DSQs,
otherwise pick_task_scx() may not find any scx task to run, reducing the
effectiveness of the dl_server.

> +	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
> +	return pick_task_scx(dl_se->rq, rf);
> +}

Thanks,
-Andrea

