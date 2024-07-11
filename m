Return-Path: <linux-kernel+bounces-249888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA5792F12F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4773C1C22987
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72631A01B0;
	Thu, 11 Jul 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UpoFHxGy"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE819FA80
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733636; cv=fail; b=kPT9HgD7RFFgqwa7zmNRDLp+qlgOaRUX+Vwluf+WHypTfsY6FWchKIDjKWr4FPYob8y12BRmRkzm+36Ap58wBrHOOUaBkGqev5fuJ60NxX7PGkFtvHDZljIXc1OWD4/wjTpgfQ/EMnTkkwaHM/aLb6kKrafmqo2yvWJ6Wosldv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733636; c=relaxed/simple;
	bh=i1RtDpXP9JrzF8skk5aBFLBL//sa5zWs2As7nYsNneU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=WhJVe/+MjkThvaVbToXdfoJHoL6+k+4p0MC3ucA0nWu67YY5yTciycOBKPss7CvNKyPxJ2BJVfy61eogZIDzP0PafAzf8oFGPNlSmXWfZLpJHs4D0GIi1wb8MmVheFyPe/cC9uGLQWE4WLxEQXzfV+3UG+tiPlDpuZItBTDMkUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UpoFHxGy; arc=fail smtp.client-ip=52.101.62.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1GiuwCnyRiTeAoINPHJRWINK59z2m9LN7+e92Kx60ruf0wzrQ6TbIx1Fnho3nTJe/kWmrEAdcG8Z+HkTPUn3lwVM760vBijzP8Q5yDGq2L+M09QzvkVEjlD88XGpDYhmCwCe6CI+ePxVHKOYj5X9YhoUzF7Hhk2n5gNMVZiSs/yn127IpRVKmRNAoe2kaBxobNhueKaNng0sPissvba9QypmgjBRtERd9JG25IUWk/Sm5OxVDxt+bJMe7SvmaDN/nKkZiBYwj8/PShtnucS09Lh5uYaGnyesiDUin/3QvMI/U0IMBZvsRtIGqVHxvqnE8aZUtSvyh/ywVKC3qpjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukh9gk9ncvzxKog4GPzuNAs4ohNkUomqvl8v7RiiVBk=;
 b=BDULRqYgVQ5Dvf5xrC6wxj3XtvMw67jlL9//isI+Qss+CU/T3uEkZk60QCFdLKVAjSj8rAy31xFnpLma1ZaMX7XzCXzHgMgCKw3EkR5RjN2+YmAC8jUypd2bvt37NAFiPkPz+70w6r3iuZ4orYNHxzQiN748lygWgPtwlfvrJf3JuwVIwORC0+k2CmHo+yDL+OEVdZmpOLmRasrX20OfJKS/91DZX/38haX0B/7yjWAFvHNlD7bk4n5fsVho2JmDVD17S7Sg2WSFrY1wxPhE58py2v7f9a0vlCI1ADSfPdPx2t8B3nauhHXOmfhzu/IAOOZ5hPNJAWu72/uC11myMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukh9gk9ncvzxKog4GPzuNAs4ohNkUomqvl8v7RiiVBk=;
 b=UpoFHxGys722u5A3QkKqa25uaH7VspDfInXtTBhF1thWifmay/vOFiUUQmP2LiBMls6JpdJ14vgcToC2cMeptuvEPjWyVxyuf7gc3pBAYfY3nGIFMfyp5AHQG7lDOjnenqPldZIyPqPnXcgBrv0Ob5cLa/cSd0On4CtSX8kkuuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 PH0PR01MB6165.prod.exchangelabs.com (2603:10b6:510:16::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Thu, 11 Jul 2024 21:33:50 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 21:33:50 +0000
From: Carl Worth <carl@os.amperecomputing.com>
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
 <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>, James Morse
 <james.morse@arm.com>, shameerali.kolothum.thodi@huawei.com, D Scott
 Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, Xin
 Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com, David Hildenbrand
 <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin
 <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v3 23/38] x86/resctrl: Allow an architecture to disable
 pseudo lock
In-Reply-To: <20240614150033.10454-24-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-24-james.morse@arm.com>
Date: Thu, 11 Jul 2024 14:33:41 -0700
Message-ID: <87frsfd362.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:303:16d::27) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|PH0PR01MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e880c0d-4a5b-4461-125e-08dca1f1275d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WS68MEfWXSEpumn+tgxaekVZFvAph7UZ9WrMlVID1Vs6lWQl9NWypDnRNc/c?=
 =?us-ascii?Q?h4aTgkTAYdCt6InVTOmI2uNO5tgY6VHSR1OvRyXxNdMKLCGO8M+8H/NhtDwh?=
 =?us-ascii?Q?dj2kohRC2qw0GneU7wf6Wl5Gd/wJWn9XpUrZShG4bPdgKG0QkU6SZDoA7fpj?=
 =?us-ascii?Q?7rqRcCHv1pCvRPA9vlVVjyMwujDsB2chpVWEIwUxicIMkumFhp7tFDAeeR0v?=
 =?us-ascii?Q?LbwnU01LB0CB8NxuRtDfv/RQLehzR5wJcIPdFft1KOx0pOpdSkXq1IXJHxiK?=
 =?us-ascii?Q?UpHXAXKG4H7c3T5te92PRonT2N5jAiMZK8nd3hcDWwe2hVfsIhTgPCp4rM5G?=
 =?us-ascii?Q?Uh9+zkd53xLaXXLR3hPrqlUClHRRzXGa6US2HGapECksoH3bOEN2W9sss7W/?=
 =?us-ascii?Q?Zc6prc8pgBTZCK+B1rMxXPkS5UTi/Wu/fPPuG8+BJ1oixm/hhuTUc4tJ7jDw?=
 =?us-ascii?Q?68xDjdDJ/8tyWyWMf0XiwfaOBoE+VL9eCnDGM8x3e+Yc1CNXMK+ILOMp7bC/?=
 =?us-ascii?Q?SyMT7/DjIEIS6eXiEwG67h6k3GLqH7Gkhgb3OWu3AtTUZGQILU/zB7ajYdOh?=
 =?us-ascii?Q?5t34r+jdOjuPeAC6olIQkNGh2aqbgqaU/hwSkTvuWMN4b8R2rGgnMJMV8QWZ?=
 =?us-ascii?Q?eoFnrdY8pyBY0TDHQJ4X2Q7yWyYR79JonuQf4SJm2Hcn5BfIXeIwl6HNA6na?=
 =?us-ascii?Q?QKv7AXpWlhMocQAtoNO9zcbn3nNVV4xjfeUcnRy0MqFUo1qiOz/9c4n0zd0o?=
 =?us-ascii?Q?9Uw82jp/ZAg3Y9Yh0u4idYlRpEIpOsOtBv2vjVvCKZKuzj+O0cSKjN3wmx3z?=
 =?us-ascii?Q?hfbXvHj3l/8e095NqAxTRPJ4GkI4MFVhvonfGIGfc00rPTTrGFzkBCBURWBS?=
 =?us-ascii?Q?lRSQNN2vbmlrpiH9wMhAPcf0wmQaTqvQCvaUv6gV2GtSLwwP6SFvvFxbdQsq?=
 =?us-ascii?Q?YBExWrPX1FGbDQHAfUQCxYu6hzSPHdmksTw5vLIdp30oquw3nBYiYpNENit1?=
 =?us-ascii?Q?2UzBbXg1mdUX9zufzeP0ee6j188r8Gnqa9eF2YSpAqUVsAEYwWDdItgApoHV?=
 =?us-ascii?Q?FIwigEUINJKABxBSyemMkTY0OJzLhffngjyvf9y6ueqQAheEeSV6gAZOzAEW?=
 =?us-ascii?Q?AFdX+SvEWD9e8KJQ4ZXMMQYFZnREQ2YSsJBY3dRS8D9R8hoXmxirumUgn78A?=
 =?us-ascii?Q?lpxH+qaqwY2UHJBPC8zOMZLzfMToJNASLbahmonjUQOi/19aDTceieOFEcbx?=
 =?us-ascii?Q?eQtHHMga5hFiJOVveFgmvLQvcSrKkGQlOMc8WP20CU8h8Hi7vrfjAx6DUuyK?=
 =?us-ascii?Q?/YC64Col1PyNbEibot9OrZRmsQW5aGgEqTID2t2eGYbALLRZYJk5ncwgFY0j?=
 =?us-ascii?Q?lR5DJD/NJ0Ro35CgoxKnABW3xdpojrrTXkW5DeZoJmwUPOxs+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Gwna9BHgHOzzyVOo6QHFtljKK/wWRz51TAP6OzfsC3M7ShEHCikcoy2N1JF?=
 =?us-ascii?Q?0AMR1v3B6iigCZsYjEe+KRl9MTsxhWCz1N88aEYrzO+I6047blGUxS83BY3B?=
 =?us-ascii?Q?eS49h5ibA1Rt6aWvQPBcVF+hgnQ8osG+u+rV19Z2eO7Fm4crUyPCUg2vUrw/?=
 =?us-ascii?Q?NMMD6o2Rtk4Sj6530w6xdcPK9JuQBO1NEnotejvHkCluJtM/JJRCm+EweUI4?=
 =?us-ascii?Q?AzL4luED6gXa35T8NwOdw4txqw6p5gOl+Wn7UhddL7Xvip6eCWd441b0iwHd?=
 =?us-ascii?Q?f1SsWMFrurtnduLCq7WGk4y8z9XtTK2uR6RAqYDQOmGNlht2S5BghsX1TBPT?=
 =?us-ascii?Q?wuJNR8hRwESEw41MzMN1iX7Gb9ICs5hn/W10g8+utStcJISsBOVZlWdm3A+M?=
 =?us-ascii?Q?XQDGI9mPMjpaWMbfE82ElueTo1gGiVSsmJyTQA1Bcn1818ML1zYRYq8jet8R?=
 =?us-ascii?Q?iDorQFKarsTWPhbLFSx0ttAiAMa5OOvjD2KmYwE/HAzkWZ/2VOUSL+n8NCK6?=
 =?us-ascii?Q?JnE5du5ZHquYT17bJl2XqUViK7ZCOEb9yVfsr7VB7WxADd12A4jeaOrptsMC?=
 =?us-ascii?Q?rAAjlSECgSmRR++c8BmQA7hVNoTpJNlvOGtI3uVKXhfaBTx5qlfab0RSmnt2?=
 =?us-ascii?Q?sxnEnuDW7iwaNBOz78ST/jp+VJJdpbNDFCo6a1swEeayH8DAqzNRosBvz/gA?=
 =?us-ascii?Q?ClRg5cXec4s/qzrjMD65gimA+6tivllDkcB4+cIxRf3K/Ockfa23ZfSDGxID?=
 =?us-ascii?Q?uI7QZdRthwCJFDbzPI7XSZs/y6npHc6U/z/h969kUwxXJ74Yo+8RTdyXpglv?=
 =?us-ascii?Q?aJcjYB26/0rSKqW7f0Q9SSrLY4GCK3/Hpx6EHgE4pM48YoLkc4+m2pQsPCtQ?=
 =?us-ascii?Q?Hwvhqp9LrWSbweySGKmLZgBnWjNP2LxjZfsZyLg/t0dfLdZcFfxFexi9CsPA?=
 =?us-ascii?Q?pdBXVjNURjog33LqdRNYqZMe0HQFVFkR6HyeKqyNhPnKIOI34QY6ePFW1zpE?=
 =?us-ascii?Q?gh04PPVftNlH+OP86IpCXL5WZK+MVVcP+ADQogpkYDDGsMw6SsU99E7ZakZ+?=
 =?us-ascii?Q?OQn7msKBq6YjZvkYEOFU8dI77aBJ+EMQjXVXa7Bg2sd2IEI6cG5Yhn7m1eer?=
 =?us-ascii?Q?7wM58dm0feBc7Cb/+c+to0zSaWMxw27Iv9GyrBCmqjnV68aBfTiKm1NtePqn?=
 =?us-ascii?Q?SGKtVUuFjHpt+l0zeEpW+DmDAbuyray8scpKnGfnVKVnU4gRN9ELQrm/xoBH?=
 =?us-ascii?Q?nmQtXV7U0eTnHJIn+hMNbrDPLah4FFKnIDP+uNrzDMe9z5wXh7R7S9yXYw4S?=
 =?us-ascii?Q?bE8JroZWIfyz46QCQqfOcnTIdb3VAr9ZOC7bnfCrgSg5Clj/BYePPj+wozHs?=
 =?us-ascii?Q?pZoqKtPSGKohXLEPNaLyRIiFngCiLHL0gx+nY7G0G//COfsvk3kruukTeAlc?=
 =?us-ascii?Q?MY9D7639uEKuOgTkDHLYvmovn2r+7FitiXbez4lUodDjtaL9qDn3moJ7Rjdm?=
 =?us-ascii?Q?UpynKO9k6wLxwSShR/642edHMLn4bvvrloMXEF8sTdAr5GfiuulzR7aNiYwD?=
 =?us-ascii?Q?iSuLTlqX3167w56pnROWOVaImoTJGDyBLYJtDcQ7v2l1bVLh5M1klquw21qL?=
 =?us-ascii?Q?fdk/OhjsZM6oPUkMjh49yB0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e880c0d-4a5b-4461-125e-08dca1f1275d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 21:33:50.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY5hKe8zisbJli5cokfnWEOjXfpXWvF8Gp3rVRgZdDm+7yKe2XQhpqpeTCvizp5Mj3K1ACVYcCOrP4QsA2uZWZYWQhWScAUI7fOpx5CuxxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6165

James Morse <james.morse@arm.com> writes:
> diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
> index 4a06c37b9cf1..0c13b0befd8a 100644
> --- a/arch/x86/kernel/cpu/resctrl/Makefile
> +++ b/arch/x86/kernel/cpu/resctrl/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
> -obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
> +obj-$(CONFIG_X86_CPU_RESCTRL)		+= core.o rdtgroup.o monitor.o
> +obj-$(CONFIG_X86_CPU_RESCTRL)		+= ctrlmondata.o
> +obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
>  CFLAGS_pseudo_lock.o = -I$(src)

Now that pseudo_lock.c is only conditionally compiled, the work it's
doing to define tracepoints, (that is, #define CREATE_TRACE_POINTS),
should be moved to monitor.c which is unconditionally compiled.

And then, the CFLAGS line above should be adjusted to apply to
the compilation of monitor.c, that is:

CFLAGS_monitor.o = -I$(src)

Without these changes, compiling without CONFIG_RESCTRL_FS_PSEUDO_LOCK
will fail due to undefined tracepoint functions.

-Carl

