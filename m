Return-Path: <linux-kernel+bounces-384928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66D9B3048
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D51B22F98
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08F61D54C1;
	Mon, 28 Oct 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="kkYcr45z"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3918E03A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118621; cv=fail; b=dRC3TivTZcbcWubGQleV4MLOZRlQiE/E2c1X9dNnMzBwnY4HCyVedwxPspoMB+xeid40t3SZmLKkXuLP+hJHOy4NT1TpuwifBBJgekR+HAefo2o5I6eAUyeRT7AkNQFlaFH+XH5ij1NHSK2nQWrm5M+rx0m7RdsG+EH+4MucaB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118621; c=relaxed/simple;
	bh=acZccZRi4gk/JOzmflueOgJhERlyu12iYAx6n7OBSR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=dj62FE9nOfY/ZA/Zg7aZEvF1Any7An6KYJ2Y54VLT8KrHTip7pJyd6wQooxXr7NjVB/revHv/liSmVChFkzM2bdOCKO4eqeSALtIDfsl0pYkQUF57CixbGBr8jUtFCZML0PNKwthOovc1O6jkqKhXKaxoKv4c7L18Go0np27e1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=kkYcr45z; arc=fail smtp.client-ip=40.107.247.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiDaDhf5lyeEclrsOW7wpQ7HAjbCeHbNvC2IF0WZLXFwMcHD4/+N6J7T6fO+oCmSKw5iFvIeWyhaRA88ZvMYM20k+/ubiihiUDXOvRZqQgChRM79ua+LGYK4nALwHD23J82JSiB6jpP/1ceBQg54QNTzWhF4OxcQxfQDtfjjHBBhkmEFl2KEBVcIOGVMY8K1boxrRUYpaHY6C1rgRbs/Qv3btADbBO4hSY72DczgxyWCgUj7PGo4qpLPsa8XAUEEscFvdZId0Y5aIwXeA78mhDj9AvrS01c0tAopJalxxOu9JgXQujkZPsAZGwUuuwPnw2oCP3T0b93tRy9fdzKQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3KTuonrKtSGSm0xBpIwdm7k89mp4toHb4cbvWw83Fw=;
 b=gAzi+z41sw/2FdscD2YEA6yqnm7FaFXQD9VT6RgRoN36VWbOLOzddru5P4RQKshF9C6UA/jskbSRqxS7PGSdyrnUVPozx2IVVwaHb8WVeraS6IJWx8PlDU4Alq1LQq53UVGA0NYUAYNePY9fJYh8K2cYVZMtQz6EUNPYF3cZt0XI2sElO5SaM1gem4nvfFd/28LV4ZvOTWiMfhy+PMKMe6tXYnTBDoKIjtzbkm/mfvDuwuCJXDJyOMBsIb1U5sWOhuhb1W+tk01R/xK44N73RxcxZLWd3SvRdEw2XI0QrQXbdFh7sYfg0VvccdhWG+HU3wJT4CmW4coEcQN51x6TDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3KTuonrKtSGSm0xBpIwdm7k89mp4toHb4cbvWw83Fw=;
 b=kkYcr45zf1QJBYKkEaD/7wZjA0+qlL4A75pgaH53ARRbD+3pqxnkul4WK0xh2AnvBbZ2EG96Bv6lOP54pgDjWFu+CjR3HpnTrge1uLIJqCctmxMYeqc0DGiqVihnajmas9YcEPA8ZqjUm+xCNnQS5nwWZmbBdBxUNNmeZRkaTHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI0PR10MB8982.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Mon, 28 Oct
 2024 12:30:12 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.007; Mon, 28 Oct 2024
 12:30:12 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Tejun Heo <tj@kernel.org>,  David Vernet
 <void@manifault.com>,  Ingo Molnar <mingo@kernel.org.com>,  Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Ben Segall <bsegall@google.com>,  Mel Gorman
 <mgorman@suse.de>,  Valentin Schneider <vschneid@redhat.com>,  Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [patch 2/2] sched/ext: Remove sched_fork() hack
In-Reply-To: <20241028103142.423153706@linutronix.de> (Thomas Gleixner's
	message of "Mon, 28 Oct 2024 11:43:43 +0100 (CET)")
References: <20241028103006.008053168@linutronix.de>
	<20241028103142.423153706@linutronix.de>
Date: Mon, 28 Oct 2024 13:30:15 +0100
Message-ID: <87zfmojtpk.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI0PR10MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4589df-7a65-42e8-e9ba-08dcf74c44a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MbotrKrpngpPMGDbi6U7QgzLZFTwv+w4FJM2vrs+po3sQ18gYBOYll93t1bW?=
 =?us-ascii?Q?0bd7iU5ypv51tV2PbPRr9mcmz8bypGzo/HiDT4aLgktfKkGxtCTigh8yx0f5?=
 =?us-ascii?Q?v4GfWtg0khccLqGRtH6aXoGiQsw8GgghjZ+v0mIag5k160RaWI++n+d+K0nM?=
 =?us-ascii?Q?ed6avLPNSuVMYqSZwd4gvWkhegAfaa0mS0dbUzFDAxZqsrFeu6waJ3tP2lz1?=
 =?us-ascii?Q?d7ZyaLywRmSw72vze9CNWNy6cQp+Wo5EcXQItGiTsTsuiT9T74gS58Lt5z4d?=
 =?us-ascii?Q?flrC8rUcDadb606tB4fW+tjwMx14lSOTVSfSlmpwZjx7CCh4IB0xPNCzvyKy?=
 =?us-ascii?Q?H1WPXWm4zDxhcFKCYcqPqvUAUI2z+VZBicx++CjUQWf9u/DEoOvl4i/voIEr?=
 =?us-ascii?Q?1qU39Ij8NM58VR0aKwbIKzR6ow1CsHYXZsLZ/Ke7een6N5VCrB/q3SmsoHO5?=
 =?us-ascii?Q?yzlEsy1IvPc8uHOasT+oibpy2H6uv+zqbNuOC4aIOFyvHswQsgW7xPJDTsZC?=
 =?us-ascii?Q?ye5QjwwaCS8I4t71CCZb7hzrp0RF8q4jg5i0bI2RxO4krz9C27lPMqQuxEPm?=
 =?us-ascii?Q?+g6hxL79Cc5xFmSdUNVqVuMJIkwmYJnm+xxr/+V3cJm4uqFpgLHqh960zoga?=
 =?us-ascii?Q?uwz1iWVPW1ybAq00nHcicrajXqkjVX9i4i+O9fw3lQ+u05mekDVe1Cmg2mDy?=
 =?us-ascii?Q?q1rTQFzTXb3LP3LDFlK8Um7w/iCUdv+RofKxPvv/iArYWuGZkX6J/xdUAuF3?=
 =?us-ascii?Q?1FOS6+bOTsdzpmA+QTnVyrb7S2iIDqCXD8y5c/E84zYKtsoADcvNCAJxaFey?=
 =?us-ascii?Q?BWg0o6vejOgIqcqxbUGCEQ4/3gVamyrHp3wmMkc6v9DjD6zcV7bubnxXGlhI?=
 =?us-ascii?Q?21Qu/1vXuBPQbvz7OG3Xm+1dxfch5E/V3BQYf+Mfm/dbgKaxb71oiSqZ3Y/v?=
 =?us-ascii?Q?io5l5JZke+Eg8eWaWBJdS4v2dFmSRgPEC+4DmANK5Uu5UFbDZsC1mm2AoUso?=
 =?us-ascii?Q?03v4D6R4OQ9ZuedJPmAjDR/ADwGFXJTjBE5P1hP3rgyqYNEExib8QdWLGwr+?=
 =?us-ascii?Q?hNPTvBmdoxJjNyMsHRHsMJPK7MgC0/uHj1rJhWDzKbSdD4YxadYDMv6Oag+6?=
 =?us-ascii?Q?SkVzU0TMTuq6369pL0eok5KPph+BEBL8TD3ogg5Or3FZRALBv7ERzkgoF+n7?=
 =?us-ascii?Q?Ol+fPiVcBKGsAY2/oN9NhIuRVxQmNlXdd0RNBxs+UAJiqyH/jG/MzgQ2DmzS?=
 =?us-ascii?Q?BkSxYtXip6iqTBf2oMgppCZ/8sJ6lIc5xGF4BcXHlVoQ06uaQElIhUeiFYty?=
 =?us-ascii?Q?WvlUNKoKyxjJO2X37E0nDvKBB5jQ1b/ZnjbFyHE1syPEsZwXxiA3v/TanbXH?=
 =?us-ascii?Q?8ZJH5hM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?psgaYUPjEMqrVWo0u8RewWp9YRi06Lby/9y2XAPXlkes2RJSj/+QxJVuVlpr?=
 =?us-ascii?Q?lluEE3RtjOcAZQtvSdVPocAq5ZZephPTrt5n+HtCsAcGmYDXroH/eiOuWveB?=
 =?us-ascii?Q?SjU7lWI4TXolFmvk5EaACD/5LiCJOTRLEHXt/9+o3f77jv8FKpPbDcUt7vRG?=
 =?us-ascii?Q?EE53WPG7Khbgf6tFSF4TpZ7Z4Wln8oY7qalwhVglRpk7CiCxByZc8PlejO3Y?=
 =?us-ascii?Q?8+O37weJJtAZuE5Wq2Wzc11wwRqwcS76O4pPAqUMTweVN8BthpMkExT0iGNK?=
 =?us-ascii?Q?bUgAVqwAgduvdo4Y2JsCxScT7qvGnX3ch96rIROIK+buuJCS5kOAMNCKo2XZ?=
 =?us-ascii?Q?spQDrcGi90QmuDxSHVhq1ybeohIbYVNXWHvZKHQOLL+n76O9AOcVdSGy2xB4?=
 =?us-ascii?Q?VRHFmnNoGZrES0Zx/EdDhG4YvZh5hf6VvI1hZDQzEcxoKRS92I/dYj2otK5X?=
 =?us-ascii?Q?H4WQhL+8lwskGr0jS2rEGgA21iDKvVn3gI8KAS4f+nN7FvXaN9dnGf4kewIW?=
 =?us-ascii?Q?1ecjGXhqZzA5t/keS2d0pWhDmPjloGi27QHCvfKIZyArWZQHL/XjB1Mhcxn4?=
 =?us-ascii?Q?PdzhLzqXX/t+bwnwSnvjMWf00cU40tw0AJv6UJo8kContOdEqvKC03K1oyRK?=
 =?us-ascii?Q?ovt7Te9pY2p7BYSHmOF9+U0FSgzTvxjCqcLCfWpWHDhMrh+9bV/cVrRTafRL?=
 =?us-ascii?Q?zv2EXaG5IJVj+ppBnyLmpm0iRf0cTbeE23EmwwTo/u8GvyTROoY5OF/SgaNO?=
 =?us-ascii?Q?9ASHu3PKGDzeN0wJXDnz7ySRCMxtDV9GSTjRxbq9J/pdO31ExAPWw73RlWmp?=
 =?us-ascii?Q?Dn7kpC+hZqB5hdUnlO/BbsDHcZLngI9cMbavqPVibsGU9aVfL4E60VKjFV4w?=
 =?us-ascii?Q?/Mj++Ijip5oEmemG7Ngdo5dzgxX0ExTtZ2NC+HWP5Q4XphpMEcJhyQOnh2Ee?=
 =?us-ascii?Q?8NSmcDdYSlX+h3LT7spar6MF8S6qfHyLecKez8EM5Bf58sebyvEgvRM0cegn?=
 =?us-ascii?Q?wNL4nuY/gpIPF2mS4w7YG4n1m2mIlnp4AtTifNE+BZ7afTjgIBq/7yvL2VS1?=
 =?us-ascii?Q?J/UXf/d1y70MQMyGvhOQsTl0VT272+B+gjeBOAjgA8+IkTA77EXyO4vTO51I?=
 =?us-ascii?Q?mL5jKn8eViUBwI/6mz22Jfmwi8UmP9nkIbyE+VMfGUyokvV0w7/wPvsBOD3i?=
 =?us-ascii?Q?Oy6rPpS+v0xVIltx2/flUnX7TtDKLKtnAUs7/C3uVTpO3ab/SuV3dMtbNYMv?=
 =?us-ascii?Q?yN9/jkVK0yR1ix/1+41BRoZmgSFc4fvfo1qQ2ec+Pd5buQU4d5ZAFGpqRfvM?=
 =?us-ascii?Q?7mwKd3CXY2OZ0caBHPf3GCrYwPwnFO3o9VNVgyRhbmdJU4izTPEV+p+yH661?=
 =?us-ascii?Q?fl59bO6ojGR0i6Lvg207DR+BIReuArX3rigR68YxpbbbyQgGXK7wuECx1Y19?=
 =?us-ascii?Q?lmd1zggFZ1bvKfjMLyey3ABKQ2afrtP5vyTqsBAo1+fefo7GkYybK1gQqClD?=
 =?us-ascii?Q?RcR40B/n0fw6saCT4LgPAJe+ruyUeTZiArlAMgdJn+vZ7c+J1E+6bUzg9AIj?=
 =?us-ascii?Q?grpn8Ot0tIJS2YhjxPpniW7fFW+YdP0pbZ7XEML0qvvK23Aw5nPO3jhqH30L?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4589df-7a65-42e8-e9ba-08dcf74c44a8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 12:30:12.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pODISIS2EIqkBnktfWpjpro3SGljLqyENMPdnHNXhh5dHfhl0CbQ4aIyQgMnh18dozLOFYy+ORZASOfWmIbX1ipRP6MA96lbthNAg/VvJP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8982

On Mon, Oct 28 2024, Thomas Gleixner <tglx@linutronix.de> wrote:

> Instead of solving the underlying problem of the double invocation of
> __sched_fork() for idle tasks, sched-ext decided to hack around the issue
> by partially clearing out the entity struct to preserve the already
> enqueued node. A provided analysis and solution has been ignored for four
> months.
>
> Now that someone else has taken care of cleaning it up, remove the
> disgusting hack and clear out the full structure.
>
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Ingo Molnar <mingo@kernel.org.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/sched/ext.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3548,12 +3548,7 @@ static void scx_ops_exit_task(struct tas
>  
>  void init_scx_entity(struct sched_ext_entity *scx)
>  {
> -	/*
> -	 * init_idle() calls this function again after fork sequence is
> -	 * complete. Don't touch ->tasks_node as it's already linked.
> -	 */
> -	memset(scx, 0, offsetof(struct sched_ext_entity, tasks_node));
> -
> +	memset(scx, 0, sizeof(*scx));
>  	INIT_LIST_HEAD(&scx->dsq_list.node);
>  	RB_CLEAR_NODE(&scx->dsq_priq);
>  	scx->sticky_cpu = -1;

Should the "must be the last" comment in include/linux/sched/ext.h also
be removed?

Rasmus

