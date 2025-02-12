Return-Path: <linux-kernel+bounces-511303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8377A3291E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2033D3A574D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C44210F6D;
	Wed, 12 Feb 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J7vhFIBc"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51718D65E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371866; cv=fail; b=pVX7YPs7Bt7rtMw84LF0/4fZ+pHt0MbLvlSUqekk3oIC6wgqGBvuGiCbMH8HiUispa+ybNWyvR5z78xYykDqWwKS9N4Ee0DOQ7tlE+brlkH4cqWY6AIZSpyDvbuB9iytaJ4CThT4+2vdO1bn8Di4n3BF5yELaGawOsM0E/j0r+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371866; c=relaxed/simple;
	bh=Hxmh8LMiBEU1CfH+SwzbhS61jA2W1GRUmSNB3+tla6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YK/xW1a66Stg5+ZoGeRcFTF2Fkx8U4Fbb0lNiWQIo+0RYgLvwSBuDx4z0MlQi//lQuzaExDcT5owSuavmLVJDFsJ9XvUTAfdUR8i4i48EYPWOOoID70c0BpfZ67yFD5qscfGgCcW3X86UWEtlJFof/tu6OvnilDGXvwmDVzR9HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J7vhFIBc; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYZHplWrPL5umPk/xL2DxhgCavxkdNxTz4ocujybpPn+QPMLj8EUtxNdEAEOUEOmup2CKwX59HR56DoYAiHCYCkjuvqBCzK6AvnrKyfrf50GhdL+cLcDiQwtNVAHdspuEuwegdV0ZN9gUVbyDtUyGlOA0pBOWhkR/iigLIWNqe1pl9z4ONQUxfClyqY1EExzCl6xifphk1PEQx2tsFZb9aSBEqm01076RQzDBZ6bUOs6/5GHoT2Md3l5mkvLByAJ9zk7JZaU9DXqkEOHbLl/EXmHW/N6LzxZWZVQ29WGh8y/ryJXxfRKHtmsBBwsZloc+udkHMii2wPyz9Ybi+phuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRSopWYw6PNov/8VivI0IhcVqc8e658Y3s4SsKuIqdI=;
 b=P4HH8Kci2DUDVC//Sn7h4EDmswJTuj2EDB6O/gbcCU3oytUcXEd+qJK8bNh3uIhappkkvpRGbU0+jRYpWucCV7IOiJDuOzVsm96aj7wIcw1oekm4zibGI2vBJlZbkGKlxsxAqtUrpjjbHcw1DN2Yg0L2AdX+fCAuwVgtCTJjTwVtabShwkWUK3taqawOK5bzC9eudi+65OgQHs60xQvCOwpGnyB61TjzncdfnMECJoHmuEdBiz2rAZpyg8fIHDcPBAqFG+NZ0xQ7WqV0jgamXMWmpmv2ZQBGLLc0CtDWfF4+w2Iex1w7MjHhBWZRm+rsL5Zn4deKw1GrbZ3e+gXqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRSopWYw6PNov/8VivI0IhcVqc8e658Y3s4SsKuIqdI=;
 b=J7vhFIBc4S7yxJni0AiZhuUWgItp44IGVleGeydD+hHxL2sF3RigB837B4S+xibLKndcxud5c4tFspds6oSuWHCY9yuwqBzy+TFAWfKj3wyZrpWXV+3RfM7/XpHRdY0mYP/P9PJtgGsObwK82k+ksGqIWj73WpFBIKaPjZURjBkSSdK6erb94vdgvrAOhkjUPggcN4G1E12zT1rs8cLV4/iTpoQU3d45mOgNiAeHfqc8x+QHyP0a5ByxIMNKu4pgY1vofxqG+665N1HvE+lU2EE1BAebOrEHSNRX7MKHgjajPcWRwXevm/UZx8rben7i1tXI+dLiesfRJGZTZO071g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 14:50:56 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 14:50:56 +0000
Date: Wed, 12 Feb 2025 09:50:54 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
Message-ID: <20250212145054.GA1965539@joelnvbox>
References: <20250210001915.123424-1-qyousef@layalina.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210001915.123424-1-qyousef@layalina.io>
X-ClientProxiedBy: BN9PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:408:f9::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d3004b-781b-4eae-844c-08dd4b74a808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVplQOK4odzPrRZF3F1Yfllm8IqpfJfg0+9X1xPiSed67xCTGMUde+XLCegh?=
 =?us-ascii?Q?jH/Fk9wBb8N60WmMLEutxUKFpkGlqIl27dnavuI6FqOH+yhiBGBUX2aWcVze?=
 =?us-ascii?Q?2LxskaZzETdlRox6Y2HDayUI47ub4k0LWtBXfBZbRSva0QlT2COVadi+Rqj4?=
 =?us-ascii?Q?+v7uBKaJUuIT5E+FHHDuh6UeJsmEcz+qaW6yQCT84+tBuIOX+G6fkezEk3EB?=
 =?us-ascii?Q?DjkJ+7Q0uSbFhTZxO6GQyYTHjdwiK5e1YuXR4jI3/lZ/KN3Xu9Kdh3I70dfH?=
 =?us-ascii?Q?inXy9OQDnL6btV59rmRLXK6N45tAhDG+0MrVEQ27yYaSz+D4JvYcubEpVPQ8?=
 =?us-ascii?Q?Ryt+rluTNHSHcmsHBzNxasJMdVmvjhBKhKBYhR9XKzLWTbJCkfgzThr6W4np?=
 =?us-ascii?Q?ZXcPbWIABANhnPARJjMSieEBgghrYEKS7wY1/54aTlxHe/vdmExPozNChgTB?=
 =?us-ascii?Q?GxCZ2LFvKlJyWuGc/gC/MJ9f4jU7dse7D2RYByoRYA/lGMBx9qBt2eaoZdXO?=
 =?us-ascii?Q?6lecK35Y+rk6x7k+D+PyvCh+EII/Okl+MbjRUF6Gzgvy8GKzK/CqyMawViVa?=
 =?us-ascii?Q?B1sPkmRvqrcVGAhB2vgyJ1WB1DBnJHM7hNtjVHkGVuhjJ8HJ8tCzRQepTs99?=
 =?us-ascii?Q?x3DyuZj+3DTCDmsPDBaO7M4PfybAFim0x5KVtqwbcfqScb/+YZWBx+uygsJG?=
 =?us-ascii?Q?By0nqRywxmywaNIU5SFuiKGB5xevqnyB1fhO/amkOVrKyVh9rweam/NPDxP/?=
 =?us-ascii?Q?tAN5n3Datd1G+ek+UL6eyNVpp8h+i+YR7YPzLoVUxyIDsi8avAiLyTp/xKDu?=
 =?us-ascii?Q?qlbelJoV9eiCLsEfKk6x+4/NHdBFYct77mZlV3pQv3cp/qb9JGev7hxtLBvx?=
 =?us-ascii?Q?5UALED0EvDtS5Uqj5iPDAQFTPCgT8zNu6nIkj1q5hqa8tnUgQ39yjOeXzpW5?=
 =?us-ascii?Q?ISSV8T4pLIK1gecMviCXLMd9SnLUT3uxS3/gOwvqDNY1oVCq77pFagB9I/70?=
 =?us-ascii?Q?rP/y2z7BcMdJAW4svHcbbxHLStRRaygcmuaUwBSjkPZNATNf4Ue+LvOcyPyr?=
 =?us-ascii?Q?7vubk/J7ikJh6aza26fZGoDNQoifdYlWuvE4abwzGWrERwyqyPv6lBp0voNi?=
 =?us-ascii?Q?6dNu8IBw/+getdpXYTdDBRbOClYjzpYI3p2fccqFHH0l65dtf7Zjw5cSgo3X?=
 =?us-ascii?Q?E+6rxr3sdsZOl8fEvAJ3WG9SwizcV93N9yYGsA9mGQwCQO/fpppmQ6PfWDpd?=
 =?us-ascii?Q?uY6FUHPUQYATsc3wkMcLmC1JmIG+QxljrVz2cDZgw/TQKN5CLAzUPOa/EjgS?=
 =?us-ascii?Q?LNaxONBVtUmQYbTTTRQe+XQMeIYVG/qrwy2Jq59nz8z67CPeMVFin6ma1hAI?=
 =?us-ascii?Q?IQ9b2V0UBOLMJT2wpZAid5pVhc/I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWEJevnF4sgYrOnwaRppnQos3SCvb+ek/d6ZXFjYnEaHYW/PPABBQF7UmXzi?=
 =?us-ascii?Q?K7XF211mekN/q3B/ueNe0sQRt/mM44omdo74X9sY8FHFFXuSdZJuqGxaZ2rv?=
 =?us-ascii?Q?idXEKxuKfxejhxe+BZxp9uG8PhHIyS24OIwEPg5Gxy6RAf27X5QtN6nRy4T+?=
 =?us-ascii?Q?jULuYILOt0hk57OzbP4pg7mu1y34PeRBvw94ANGzKz0nwHF2v2FQHsF4kDD7?=
 =?us-ascii?Q?appuq1svf4ZQAjy84GwXatv9rflJ7mLDwaxd5xQA1WJ+Z6DA8/gbGKd1NOQ+?=
 =?us-ascii?Q?g9vgfCstqdDoFOcfdzifHf9x/P7fIRx5QJ/UEklOCGUziS0voGIlY+RYYBr6?=
 =?us-ascii?Q?QeTjUyRi8HNPBDuviaE0g0ZupTPSUKdCEOTI4sRglLvTiMsHd06CcI6q9EGv?=
 =?us-ascii?Q?y/F2knLrU9ymG6t9daSXqoYcSnt72pTxAfwHOnTxSF17NNQTKrw2KElWePLS?=
 =?us-ascii?Q?uW+fK5vFcf13JhqZFw1vJ7b1JEMQIeIFNvyS7pqqURBhoRVLd/iXKhKOy3il?=
 =?us-ascii?Q?sTDVzGcpmZQ5QepkP4lB+pYBRWx51X7eHx0GJR8mHuy2fa+KM9zB1ip8yWi8?=
 =?us-ascii?Q?VQGh65phoGcALQk8lcUaX5bPcxbGuY1WsA6V7aTiiwlog/L2+TIiV9nSaOLh?=
 =?us-ascii?Q?DfgKsYRKmzdYRSjVO1ChrzXJ2iJ6o/vS9ibu2aaGzTqdnZkcMWcu2yuB7e5d?=
 =?us-ascii?Q?KKJ7I7wRnUck61WxYtgVH/WSkxWDxV+oy+P0MaOggv0+oTNeoPWbRSayXVu2?=
 =?us-ascii?Q?E9bVGlQC63WxrwuHM8Km4uWzwyICm2waJPWVLBAO7n8iq+HR9e1JCPHzkaBs?=
 =?us-ascii?Q?E8g4rnN3vKixuWn6vuc/QDCL3VIV0Rb6UMCCXlE2DUc32PWuGqUA7dSDQVs0?=
 =?us-ascii?Q?cQGNiKOPjOB4tD449K3JI8MRdnjy5T+Q6rV1hRkF9TPCDf7fOHYPgstf9tIq?=
 =?us-ascii?Q?ehpprbjcf36S++DnYJE/fz7IuprhO2bbqZ7O2VNpG99yrpT2tjze1Egz+5sO?=
 =?us-ascii?Q?eNec3uoRA3lVIZxZSBNkaPQV1WSY4C0+spjgxh8ZUd4QKXmbFPcdRrF62gqW?=
 =?us-ascii?Q?gAaUbPmljHtX7sT7jgnpHX4BjfaMHljnutXO/QT0NXww+Eq0lgaLQhFjA6cq?=
 =?us-ascii?Q?Z82GYWUxOwzZ8hKfwx8EDRYZ0HMlFLoS+Oi8SRJjHG5vkhkecluJB3MkNktH?=
 =?us-ascii?Q?gGJgU2Q0PmQlrY+4UARZRuhthJxmblExJtjqMSmKqTRwY4niM7ucv8rHdvk8?=
 =?us-ascii?Q?B3Fhq+Ey1bS2MgsrDGNHACJR+9i9Cl7UrOYjr4v0TSrwCFY8BpnGd+VlqE0a?=
 =?us-ascii?Q?djzZj1TtSnR/t8gXVQf38PhPEQ442wBGIDs0tprmbGgLbllt55zKPzWr/L8i?=
 =?us-ascii?Q?+uCVzMIMJkSz9OaAbgnV+OHpxWfONgic552qJQJdSh+87pItvHLC4i/aDBZC?=
 =?us-ascii?Q?Cm8oEONcebxQbm0qeR7OR8UrX02jkimBd8Vwt8QO7gYh3vPBMJJ85rri+evh?=
 =?us-ascii?Q?Az1lF9DLoIcCaVX91GvBQXSmPocPhzIoRJthH+3SB1YWy3gskrX7d3kE5lju?=
 =?us-ascii?Q?Acsif88Bcla0uM/AaeYaGrO1GgX4UFu2fCQM7awN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d3004b-781b-4eae-844c-08dd4b74a808
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:50:56.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaeSwfkIvTgspuJA10jDFqnQmtbkvebq6vc9MRA/aCN7Mx7L+xQgEI6zx4gXFpyQj10UZKQFEYCqdtCeK7lnpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

On Mon, Feb 10, 2025 at 12:19:15AM +0000, Qais Yousef wrote:
> The frequency at which TICK happens is very important from scheduler
> perspective. There's a responsiveness trade-of that for interactive
> systems the current default is set too low.

Another thing that screws up pretty badly at least with pre-EEVDF CFS is the
extra lag that gets added to high nice value tasks due to the coarser tick
causes low nice value tasks to get an even longer time slice. I caught this
when tracing Android few years ago. ISTR, this was pretty bad almost to a
point of defeating fairness. Not sure if that shows with EEVDF though.

> 
> Having a slow TICK frequency can lead to the following shortcomings in
> scheduler decisions:
> 
> 1. Imprecise time slice
> -----------------------
> 
> Preemption checks occur when a new task wakes up, on return from
> interrupt or at TICK. If we have N tasks running on the same CPU then as
> a worst case scenario these tasks will time slice every TICK regardless
> of their actual slice size.
> 
> By default base_slice ends up being 3ms on many systems. But due to TICK
> being 4ms by default, tasks will end up slicing every 4ms instead in
> busy scenarios.  It also makes the effectiveness of reducing the
> base_slice to a lower value like 2ms or 1ms pointless. It will allow new
> waking tasks to preempt sooner.  But it will prevent timely cycling of
> tasks in busy scenarios. Which is an important and frequent scenario.
> 
> 2. Delayed load_balance()
> -------------------------
> 
> Scheduler task placement decision at wake up can easily become stale as
> more tasks wake up. load_balance() is the correction point to ensure the
> system is loaded optimally. And in the case of HMP systems tasks are
> migrated to a bigger CPU to meet their compute demand.
> 
> Newidle balance can help alleviate the problem. But the worst case
> scenario is for the TICK to trigger the load_balance().
> 
> 3. Delayed stats update
> -----------------------
> 
> And subsequently delayed cpufreq updates and misfit detection (the need
> to move a task from little CPU to a big CPU in HMP systems).
> 
> When a task is busy then as a worst case scenario the util signal will
> update every TICK. Since util signal is the main driver for our
> preferred governor - schedutil - and what drives EAS to decide if
> a task fits a CPU or needs to migrate to a bigger CPU, these delays can
> be detrimental to system responsiveness.
> 
> ------------------------------------------------------------------------
> 
> Note that the worst case scenario is an important and defining
> characteristic for interactive systems. It's all about the P90 and P95.
> Responsiveness IMHO is no longer a characteristic of a desktop system.
> Modern hardware and workloads are interactive generally and need better
> latencies. To my knowledge even servers run mixed workloads and serve
> a lot of users interactively.
> 
> On Android and Desktop systems etc 120Hz is a common screen
> configuration. This gives tasks 8ms deadline to do their work. 4ms is
> half this time which makes the burden on making very correct decision at
> wake up stressed more than necessary. And it makes utilizing the system
> effectively to maintain best perf/watt harder. As an example [1] tries
> to fix our definition of DVFS headroom to be a function of TICK as it
> defines our worst case scenario of updating stats. The larger TICK means
> we have to be overly aggressive in going into higher frequencies if we
> want to ensure perf is not impacted. But if the task didn't consume all
> of its slice, we lost an opportunity to use a lower frequency and save
> power. Lower TICK value allows us to be smarter about our resource
> allocation to balance perf and power.
> 
> Generally workloads working with ever smaller deadlines is not unique to
> UI pipeline. Everything is expected to finish work sooner and be more
> responsive.
> 
> I believe HZ_250 was the default as a trade-off for battery power
> devices that might not be happy with frequent TICKS potentially draining
> the battery unnecessarily. But to my understanding the current state of

Actually, on x86, me and Steve did some debug on Chromebooks and we found
that HZ_250 actually increased power versus higher HZ. This was because
cpuidle governor changes C states on the tick, and by making it less
frequent, the CPU could be in a shallow C state for longer.

> NOHZ should be good enough to alleviate these concerns. And recent
> addition of RCU_LAZY further helps with keeping TICK quite in idle
> scenarios.
> 
> As pointed out to me by Saravana though, the longer TICK did indirectly
> help with timer coalescing which means it could hide issues with
> drivers/tasks asking for frequent timers preventing entry to deeper idle
> states (4ms is a high value to allow entry to deeper idle state for many
> systems). But one can argue this is a problem with these drivers/tasks.
> And if the coalescing behavior is desired we can make it intentional
> rather than accidental.

I am not sure how much coalescing of timer-wheel events matter. My impression
is coalescing matters only for HRtimer since those can be more granular.

> 
> The faster TICK might still result in higher power, but not due to TICK
> activities. The system is more responsive (as intended) and it is
> expected the residencies in higher freqs would be higher as they were
> accidentally being stuck at lower freqs. The series in [1] attempts to
> improve scheduler handling of responsiveness and give users/apps a way
> to better provide their needs, including opting out of getting adequate
> response (rampup_multiplier being 0 in the mentioned series).
> 
> Since the default behavior might end up on many unwary users, ensure it
> matches what modern systems and workloads expect given that our NOHZ has
> moved a long way to keep TICKS tamed in idle scenarios.
> 
> [1] https://lore.kernel.org/lkml/20240820163512.1096301-6-qyousef@layalina.io/
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/Kconfig.hz | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/Kconfig.hz b/kernel/Kconfig.hz
> index 38ef6d06888e..c742c9298af3 100644
> --- a/kernel/Kconfig.hz
> +++ b/kernel/Kconfig.hz
> @@ -5,7 +5,7 @@
>  
>  choice
>  	prompt "Timer frequency"
> -	default HZ_250
> +	default HZ_1000

Its fine with me, but I wonder who else cares about HZ_250 default. I
certainly don't. And if someone really wants it for an odd reason, then can
just adjust the config for themselves.

Acked-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


>  	help
>  	 Allows the configuration of the timer frequency. It is customary
>  	 to have the timer interrupt run at 1000 Hz but 100 Hz may be more
> -- 
> 2.34.1
> 

