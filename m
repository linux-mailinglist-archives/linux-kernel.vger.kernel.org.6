Return-Path: <linux-kernel+bounces-248046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA192D7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668A51F214E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62369195385;
	Wed, 10 Jul 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mh4wxhLE"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2094.outbound.protection.outlook.com [40.107.237.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A649192483
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633492; cv=fail; b=phynLnYwdSfHFi9rz1bhFlFqTkR+IjzIjH1QDDAeqWhkz7Xq22jf7ofGMr0LJ3O0zE7lQuMhjBYs3mIHlMUzreI6hIZxuptVHPB+MyVx4TLR9EOj8fN5n/sfNtpfbHPQkcF7pp1o8x8y1YRHNxoPxaTMYDuFmVE31tIlC2dyhAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633492; c=relaxed/simple;
	bh=e7uz6FB1/0VANznG7/SFBDwj1vSAwa3xTaqhFeNFDW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9xRocTu+yLaBdxacI9F5b+wxTXVYyCVcqeOv6izBW5byvjWOqrETRotyMI7MBvpZ2GaCSgGcEtuXFoZYN030BGh0GOcxREkTxMYr2iXuQJwSPlHyI2/SOBWBOPFHPNmKjYZL0INIxk4cKIQC6WRooZbKdU3gmG8iaUwUYqhKms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mh4wxhLE; arc=fail smtp.client-ip=40.107.237.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiyKir808CP2gXUaYSYQVo/pduH6XfmGrU3TXrxrtgrGriDMiNKkWeGpPJ/ClqZQ/UqiBvHFNyo7SYFVCTcP6ALSpTbVXmGKrHcydf27I8CPIRCe6FsN2/0sBBjwxAoXAlOCXSxK/yB8a9PgH9Yo/yeyA+pglpV7zbV1KEpXfCJ7T+nrUqr7ZxTQ3A1EOkZhyjlnRCwW9PoCGzP1qzxP5e+vavuyli/Xr/iwEJWfh2dcQ2NPFCnXnEDB6OmfIK7KMMtXJyk/Fev6tXzFPI9iY36zlthfvMc1CgJK0t6aM1h9nWG+uAkppr5+KmgziI8fOQ33gltJMxxJ+KNx3HZQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAaSeLqmYzLl7YDX5hsYrxkDnlHzNOVu5DImdtffNsU=;
 b=ZcxbDEqMc7JgHndfz62LK0FsHfoGSsnDBxeCrzFPk09ClqDb/R+65hujq9Amd7unE7xY0h/Dj1pt8v8SZ+91bwhy9VVZQOwQ3Cn7q8YBuFbzbLs0BvmcuqWGwXkIQZA8r1CIe3YyXd6izGhP1oju6uk9QzqbGt5oPGrab4GsRfm9PywL6RnEOwE2hU66VYbsa0nSJYPpEvHiRLgvOxrq8l9y45GuvVVPz9wKd1yjRyAmVV462FFkyUh5aHy0Gffq60LZ/ewDKZnM6ceghJFYqKf96u5UvuMiMThBkt46UvQdihCvY5B1u49mH7BskYWIrcckdeoKB3g9Ifjqegy6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAaSeLqmYzLl7YDX5hsYrxkDnlHzNOVu5DImdtffNsU=;
 b=mh4wxhLEtTLlzOkzQVLHlp8dF5s89akzyTKXOcUpZa0rw/1QZbV/Bj3jkP9g7nx7JeYa/jlPA/zMsRBRRwFktRiwEw9etnCZlGraigCqLw+CSuPTPF74m7scKVuJ7IzpmZDdNBeWMvEw6uSWqU+oJlZq89D2TQFlD5b48yGa474=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 LV3PR01MB8462.prod.exchangelabs.com (2603:10b6:408:1a7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 17:44:46 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::a178:99c3:308c:d6d]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::a178:99c3:308c:d6d%5]) with mapi id 15.20.7762.020; Wed, 10 Jul 2024
 17:44:46 +0000
Date: Wed, 10 Jul 2024 10:44:41 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	vincent.guittot@linaro.org, sumitg@nvidia.com, yang@os.amperecomputing.com, 
	lihuisong@huawei.com, viresh.kumar@linaro.org, rafael@kernel.org
Subject: Re: [PATCH v6 3/4] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <aasc2rpfqtqis74hsrgv2nurrz5uumh3pgfuwbwbntlgvtavzh@egisja6opuuz>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <20240603082154.3830591-4-beata.michalska@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240603082154.3830591-4-beata.michalska@arm.com>
X-ClientProxiedBy: CH5PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::18) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|LV3PR01MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f474eb-eb73-46d4-5d5e-08dca107fca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XsRk5NoYiujj8MJA18lxdo3rLbSgk6Bw1ZMHXV/A/Taa2vhbRLi/SxaOE3Ug?=
 =?us-ascii?Q?9Sfd6rvSXI2EZSgBvRTwqwifUYyJqaS16PVlrPz94VNC6DwBPDdxYx/EPjTL?=
 =?us-ascii?Q?33ZqO+IBwkPJUtofNt+izia7K18JnYT74i9S+1KXeJszWDVKtBTnzQdgmWL0?=
 =?us-ascii?Q?CWF8awvOtzXKsmpJ2QmNvl9eWbHdfEBe4uMJdSz6xAZamdJgpHOw/zYiRoEp?=
 =?us-ascii?Q?F1yb8E6I5tCi3oI/NCfVLeIRQucDe67SjPPNs8hlEy3920sPG/32xbyjxeWr?=
 =?us-ascii?Q?gRv8clR6cG84NbON4ICyRIJn0Uzz9RS4c2I0hY6F/zTYtQGYel3KPvxsr4Y6?=
 =?us-ascii?Q?QYBBtS7878en0QrCNsc42NSRT/xMcskRd9WxrTSGkkfLcOP+xA1Hv+g9wUEX?=
 =?us-ascii?Q?hjYN3WMGRx/Zb6PYIj3dVLpLLdMwxY/quLhJjA3vDxQSyQHslopG6TS6Vz3G?=
 =?us-ascii?Q?IerlhiPZYlo/jvEiERKTcX9oYIr+O39WSzIQ9sfp1QkoHE3NLYPmWMC7K8R0?=
 =?us-ascii?Q?/oGINqf2slBczrUtQIbJdE4j/5D19VJIXqFxN0TCurVajNYOXPc5kiIDrecN?=
 =?us-ascii?Q?AyDPHG1MhMUizp8HZQNL5GcPGS8MB0cbDpJWtvLq2vdvH/WtPaU1e8Mip9qN?=
 =?us-ascii?Q?riQky25csqvdB+5FEJy/AcZi/xdTHid8mOhlElcKlLI8hUrhTESEa8LBZJvB?=
 =?us-ascii?Q?YySnhsxo2NMsBLSSqz7pGTIyIdrP3wB5krM2JZuPnc0sMVX/9rov9gCaX8sS?=
 =?us-ascii?Q?n4uIc8hJKfWW4YJgTVmCDOVwH5qTh31xxvIlsoAMxJldkDmcHy/Z6arPjMG4?=
 =?us-ascii?Q?M9j4YpgRCbS40ldIw8KN754V7XchDsIs9No+TRGRKxW9FY0mpdhC/EbNZqlk?=
 =?us-ascii?Q?+AD7ldaweJflptpkf+RVvOkzwehRvH7QCoBbBGxOT+gJEp34wJgJNrhG9kld?=
 =?us-ascii?Q?gOrAJCwGncsDxlgFimwQhXnheUMbeiQ9O5HXYJkuAOWprNel6YqkQ23virXj?=
 =?us-ascii?Q?kY2zhl1PjGCe4B2gElTAd/RQatha0iUuq2K0SgQa5fD7MzHhC7qeeU19Z/SV?=
 =?us-ascii?Q?nuFmBz1LmV1Z7f2F20gXZLnFnhootz8Sgsaznhgfr6Kz0c8QhEyuxzY3xUwG?=
 =?us-ascii?Q?aTAkXKHrXeeI8o7/Mq/YswBWecOtpg9HKSyKQmXjWMxTqqUZG1wDvbpLULM2?=
 =?us-ascii?Q?AK6Nw8k94KOfLMPxF/er5yEX8Pd3PyQ00dNasAb7ZE3l+3HsXPI8eZnnuYY2?=
 =?us-ascii?Q?LTlr3He/RvbpXHSgKeNUm7AWxzrnJPrgxPfM7HUZJnbJ0EbxBQoq6aYE/G6o?=
 =?us-ascii?Q?anTKZUK6D1RP8nmOhhY5lrugs8GFX7vz606koUWWEDaihw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?08fAILIWtAdXl3HXz/hCvT5Nt+hj3s8f65++qNQozDASFd9NRJK6e3upYLoB?=
 =?us-ascii?Q?g1sYqTui1yJI6deYCy1PF9SxXIWf7AgBuAemOwKkSzzgvT4JD58ReoVKNwB7?=
 =?us-ascii?Q?wTxx3b41O4A3YSRYkeUoSxAFO2cBJenGBW5oVFPQX7nnxEP2J8Wjdb2XhiU5?=
 =?us-ascii?Q?gStxUu+jkBFDvcxkeQr2JPsyvYTRdGxyDiiBk9R+DBkpovu1w5Ds5zXpsmh1?=
 =?us-ascii?Q?coLfuoeXoPVjY6RkiM93rFs1/ar/vGbxcVfZmn4LaxFf13smJnXnA41JyAnG?=
 =?us-ascii?Q?lByOeg8/RwfgtU7E1xjb8IuZ2s2eegmw70YkMfMaEY8FJN9/ReDDIO9cFb7o?=
 =?us-ascii?Q?yrOZleEaRIrUwrP7xL1Ycs/CjBMCHBkVolyIMeDslBcBi3xO0jmW5Bxe0RH7?=
 =?us-ascii?Q?8khe1NCxVjHfW2lVnGO6lqvJ2imBV5LyqQZ0w7mnHSLat5ohwtEKicLNnoWa?=
 =?us-ascii?Q?GsjGpbxDe2C224stTVvbqJ8W/klS5CqNKl/k2tAPSLbbDkkkD+m+YCEyjQ0o?=
 =?us-ascii?Q?7g9n90ujRyeDhotxuqvc4yalE7pqqlekB2kglGSR9QkFJJDGngm2d94P+wYW?=
 =?us-ascii?Q?EkbmZYH34Hkv8XfHzR+uEq3rlCPbcINRRxT5fxIDYuFMYeNnRD/iwaFIi2S2?=
 =?us-ascii?Q?15I2YjVKceCId0fjNLAqGF7PlezDJegqDGsZzLAcfElePPE2b2G8U2DjyyZx?=
 =?us-ascii?Q?irtQQCSdbB4OfMSTNaezJ/Hopm3HM0W4Si3tsZagEuE8l9VU8LCMHDrnFcgx?=
 =?us-ascii?Q?gCxIajd+VjZrfsYdP9Cr9GF4vVwQL2u3uTtIweFTh14rq6fK+wf/KLwdaK7g?=
 =?us-ascii?Q?9PE0BOaartXyBvQ6g7NbESG7dk23ozNQtDHt2YCQ83J/8m6EONbIfH6zw+jN?=
 =?us-ascii?Q?5VNDMNgQRggTh0/8PXD+GidKIkU3jCUKXDg1bhxlFftPSRnmAPrr7B4QdfDA?=
 =?us-ascii?Q?amAKpdQzNXd7XRzkn1TiuG1T3NAPf1jXY72FdkC/muo1lun9lG0nSuEn3O59?=
 =?us-ascii?Q?mFVtOmSu6d8V3qGWoXvMo9GzUrE7VUEoKCU1qU5kWJSx4Gt1h33evtqkQ+Id?=
 =?us-ascii?Q?PFpH9fHJuSuvAxnJSsgVcbDkwLbOKgzKlBgFxPJ/OKtp3YOJKEkxGA1PtLRW?=
 =?us-ascii?Q?1h5ftf9EFZ+7ZMspmufSeyMNNOLHSDQqZrU6BAL4KxXTemwSOEcIwm9hzw3k?=
 =?us-ascii?Q?F57b/NEaSR89bjDVowfmAn03mdu+ru3IHOFz1twzknF5wBaLmDHLOE7M/esF?=
 =?us-ascii?Q?bo6EHHY2UhE/KBmGFn45KlAoOyQCs3vzCWoqHKBnYJP9QV3G+WoyJMBc4lYB?=
 =?us-ascii?Q?GBBE28sGi7NF6edvPjPowb6M2bbuUEipK6ahLj7IunOAWJ/SGYavyAAARQfa?=
 =?us-ascii?Q?twHsqFd7ci/k+LUt86qG5NLoIG7no1QQbKdOH7pT5E7Smt9SSt6cWY+NHlCX?=
 =?us-ascii?Q?tnhyNaGMRA3hVgYIEQfJacg002qGSmLZdflLTb31LfBjoMqR6vIVaub0ylMq?=
 =?us-ascii?Q?2CtdiUwvyexbom2Xttiu3LM/sC6rIx19w+IXO8nSG7IrJi+SZE6DAFFh+ZP7?=
 =?us-ascii?Q?Li+5K76hfAZitPVn1ihHbLhBQVlMcmSHKmcH382d3ahRvKfAHvtOzFl+4+Dp?=
 =?us-ascii?Q?fDJKPfMyo87TTiErTFF3M3Hp55fP4djtGN6fickji2Eb?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f474eb-eb73-46d4-5d5e-08dca107fca3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 17:44:46.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bL6ikLWtUQQbg4Zv/mfAz4zKqyWs73zR48dgLfplGQmWDHiP93AKqkvKulJSP8/x3lbivJJw/xpvLGUskBojYnEfbNCkApUbNjZgH2wnHnw7ZUv6A44bfMlyyL8jpWd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8462

I apologize for the late review. This series dropped off my radar. I will test
this on an AmpereOne system.

On Mon, Jun 03, 2024 at 09:21:53AM +0100, Beata Michalska wrote:
>With the Frequency Invariance Engine (FIE) being already wired up with
>sched tick and making use of relevant (core counter and constant
>counter) AMU counters, getting the current frequency for a given CPU,
>can be achieved by utilizing the frequency scale factor which reflects
>an average CPU frequency for the last tick period length.
>
>The solution is partially based on APERF/MPERF implementation of
>arch_freq_get_on_cpu.
>
>Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>---
> arch/arm64/kernel/topology.c | 110 +++++++++++++++++++++++++++++++----
> 1 file changed, 100 insertions(+), 10 deletions(-)
>
>diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>index e475ec2705e1..2c002d2c3e0b 100644
>--- a/arch/arm64/kernel/topology.c
>+++ b/arch/arm64/kernel/topology.c
>@@ -17,6 +17,7 @@
> #include <linux/cpufreq.h>
> #include <linux/init.h>
> #include <linux/percpu.h>
>+#include <linux/sched/isolation.h>
>
> #include <asm/cpu.h>
> #include <asm/cputype.h>
>@@ -88,18 +89,28 @@ int __init parse_acpi_topology(void)
>  * initialized.
>  */
> static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
>-static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
>-static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> static cpumask_var_t amu_fie_cpus;
>
>+struct amu_cntr_sample {
>+	u64		arch_const_cycles_prev;
>+	u64		arch_core_cycles_prev;
>+	unsigned long	last_update;
>+};
>+
>+static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
>+
> void update_freq_counters_refs(void)

Could this be renamed to update_amu_cntr_sample() for more clarity?

> {
>-	this_cpu_write(arch_core_cycles_prev, read_corecnt());
>-	this_cpu_write(arch_const_cycles_prev, read_constcnt());
>+	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
>+
>+	amu_sample->arch_core_cycles_prev = read_corecnt();
>+	amu_sample->arch_const_cycles_prev = read_constcnt();

I think it would be better to update amp_sample->last_update here. update_freq_counters_refs
is the only way to update the amu_sample. So it should be safer to update the whole structure
in this method.

> }
>
> static inline bool freq_counters_valid(int cpu)
> {
>+	struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
>+
> 	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> 		return false;
>
>@@ -108,8 +119,8 @@ static inline bool freq_counters_valid(int cpu)
> 		return false;
> 	}
>
>-	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
>-		     !per_cpu(arch_core_cycles_prev, cpu))) {
>+	if (unlikely(!amu_sample->arch_const_cycles_prev ||
>+		     !amu_sample->arch_core_cycles_prev)) {
> 		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
> 		return false;
> 	}
>@@ -152,17 +163,22 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
>
> static void amu_scale_freq_tick(void)
> {
>+	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> 	u64 prev_core_cnt, prev_const_cnt;
> 	u64 core_cnt, const_cnt, scale;
>
>-	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
>-	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
>+	prev_const_cnt = amu_sample->arch_const_cycles_prev;
>+	prev_core_cnt = amu_sample->arch_core_cycles_prev;
>
> 	update_freq_counters_refs();
>
>-	const_cnt = this_cpu_read(arch_const_cycles_prev);
>-	core_cnt = this_cpu_read(arch_core_cycles_prev);
>+	const_cnt = amu_sample->arch_const_cycles_prev;
>+	core_cnt = amu_sample->arch_core_cycles_prev;
>
>+	/*
>+	 * This should not happen unless the AMUs have been reset and the
>+	 * counter values have not been restored - unlikely
>+	 */
> 	if (unlikely(core_cnt <= prev_core_cnt ||
> 		     const_cnt <= prev_const_cnt))
> 		return;
>@@ -182,6 +198,8 @@ static void amu_scale_freq_tick(void)
>
> 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
>+
>+	amu_sample->last_update = jiffies;

Please see the comment above. I think this line could be moved to
update_freq_counters_refs method.

> }
>
> static struct scale_freq_data amu_sfd = {
>@@ -189,6 +207,78 @@ static struct scale_freq_data amu_sfd = {
> 	.set_freq_scale = amu_scale_freq_tick,
> };
>
>+static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
>+{
>+	return cpumask_available(amu_fie_cpus) &&
>+		cpumask_test_cpu(cpu, amu_fie_cpus);
>+}
>+
>+#define AMU_SAMPLE_EXP_MS	20
>+
>+unsigned int arch_freq_get_on_cpu(int cpu)
>+{
>+	struct amu_cntr_sample *amu_sample;
>+	unsigned int start_cpu = cpu;
>+	unsigned long last_update;
>+	unsigned int freq = 0;
>+	u64 scale;
>+
>+	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
>+		return 0;
>+
>+retry:
>+	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
>+
>+	last_update = amu_sample->last_update;
>+
>+	/*
>+	 * For those CPUs that are in full dynticks mode,
>+	 * and those that have not seen tick for a while
>+	 * try an alternative source for the counters (and thus freq scale),
>+	 * if available, for given policy:
>+	 * this boils down to identifying an active cpu within the same freq
>+	 * domain, if any.
>+	 */
>+	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
>+	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
>+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>+		int ref_cpu = cpu;
>+
>+		if (!policy)
>+			goto leave;
>+
>+		if (!policy_is_shared(policy)) {
>+			cpufreq_cpu_put(policy);
>+			goto leave;
>+		}
>+
>+		do {
>+			ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
>+						    start_cpu, false);
>+
>+		} while (ref_cpu < nr_cpu_ids && idle_cpu(ref_cpu));
>+
>+		cpufreq_cpu_put(policy);
>+
>+		if (ref_cpu >= nr_cpu_ids)
>+			/* No alternative to pull info from */
>+			goto leave;
>+
>+		cpu = ref_cpu;
>+		goto retry;
>+	}
>+	/*
>+	 * Reversed computation to the one used to determine
>+	 * the arch_freq_scale value
>+	 * (see amu_scale_freq_tick for details)
>+	 */
>+	scale = arch_scale_freq_capacity(cpu);
>+	freq = scale * arch_scale_freq_ref(cpu);
>+	freq >>= SCHED_CAPACITY_SHIFT;
>+leave:
>+	return freq;
>+}
>+
> static void amu_fie_setup(const struct cpumask *cpus)
> {
> 	int cpu;
>-- 
>2.25.1
>

