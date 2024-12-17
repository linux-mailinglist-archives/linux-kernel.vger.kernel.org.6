Return-Path: <linux-kernel+bounces-448971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E6B9F47D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2748E1889FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1A1DF27F;
	Tue, 17 Dec 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/zOlhJe"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1931E0E0A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428563; cv=fail; b=OIdn7vkaIOLdi8i6KRiZ+ul6kkujAVbw9Av3VHq1hXFgkny51H9mZi+a7+d6j0NSPhHxFa1lTMS7X07KPpA8bY4XI/+ZT8H2CEk/wrnF3rmBa8iN5pseuQLaRl3LpiF+iSd7r43V/6KAh5NeZGH85mEFcQkn5Bf0+bZ3WaVhNvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428563; c=relaxed/simple;
	bh=/J594g1Mn5/HeWhcGVBaUL2qogs0LvfFfte6DPrUiUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwkNeyeCz0MCQkX8CMs1ZEtqde8kdf9NQViBRY1YPItbaAmxhYd0pa9oXspuFdhQpWlS4Vzmtn3TYHo30Um9BsiU0b8SVCJBXrCwZoneSC1jLmgkeZWab43Myz6os45pSYS1t6eRqzIpLyUcN8CwQTimSMmg/PAkOlhPgS/rd0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/zOlhJe; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdlfQcvU+W3k/8G0mW+csFPxkz+6J130L1aKL6yrqJ6I5wQIVF+/VnVGoi7CE54+SAFAV0h4G0/gGJhejITglCUaTrAHUEjlJvp/CH7Vlq0ODVWS2N1ddOGAnccpZHIsxiPWvt3Mvh75eR7E5N95m/Or4B6zgKSxLTnwQ1bcBYWXGGJdRzjycu9d0UOi4BJXDqz3u2Kd/XdajCzP2+HZdtNkO7uUvVQic2E7BjVtd/gBCAuKxahoq6wNSvCM6e+ZaiYCPSBvupYDO78ldxJX3GRbt5D6svcKHZIJnGcHVA9lTJBWDyxVEUFCMN5iac9Zt0Cgj/GWBhMfW3K9tCJocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSjMGF5oPVsCe3xGm2M0Kw9s2hmvdvYILfpCLCJADZ4=;
 b=SjuAQjvAuE56J3VWTuuVlvMPz80XTM74NydlT49QldlxWhiB7aIMApkB8SQIbRNA2D8HsFG2sVfeF04yQtcCJhPg3vAqCwWDFQcUEEJLGGnhrUVCDAyz+6USsFolFJbtH5d7nRBsPbv9AntY4EwaxJjkH9NUEsUXSyO1nwpItqOLBu/A6Yz6G945Cutw8jJUXLcscRPpSf7rxL316JohQVOTfBZop9N83BFTR9a2/Kq42p8v2Q/mrEgcxduVsrzFNlQ3ZLVeryG+asr9HNvqkUD++Z/aPPStRoTkG2IVv7fO56Xr0wpcLf8vTj7L9i8mpTufipjo6Vzc/g/5RUqGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSjMGF5oPVsCe3xGm2M0Kw9s2hmvdvYILfpCLCJADZ4=;
 b=t/zOlhJe3vhD61jkmtqht6o0H7pwZELA7D+G9HujJ5H7Mj9aG+6tPheeJyhdFBwASZPeu48lcYYiu/ccHi8sfdIPAkCZ3jOuvBPgHIz4904ceZ5fimg8hU7NBB63kJOOQ0sa764FmMQyg0RT0xsWgWx1HtSa4b4WMvZIzUs3JssrCjlMs4zg9uCHb6mqCgVd9s41Z3om1ZKXEXxAFWxnQf2X1dX/rSDwN/K4cY/fzfHCXHt3Pce0p27tmBrd+mbIpSjEBL0OsOYlJ0IdkStVRsLFWn7kMGajlFRnC2Xo6FdZymKtEkzgnp8VfvlL4xa9aV3553DZRRaV6nvQ37sg5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 09:42:39 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:42:39 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] sched_ext: Introduce NUMA aware idle cpu kfunc helpers
Date: Tue, 17 Dec 2024 10:32:30 +0100
Message-ID: <20241217094156.577262-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217094156.577262-1-arighi@nvidia.com>
References: <20241217094156.577262-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 89707d14-42d9-4223-8662-08dd1e7f2546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pDbaOF+wMO5o85v/0A9cQ4vo5MECYaFbPGqjAnuthwsMJ4F69ovWhYbRPzp1?=
 =?us-ascii?Q?ZNi2kkzBBcLtPhQgZdZgcmxfVLCDOdx73jBlBY0E4wRxrueyHgM/MHVK9zPT?=
 =?us-ascii?Q?AS74r0K0Mi+pIyVCx6b2/rJGfGDpUBPVsulxp3CZtH20rg6Z+vr+Ozbl1SQb?=
 =?us-ascii?Q?/r2rozuILX3EEHiuaUDrHXiHnUml0+B9zb5kC55aMBPgFIE+QDiboFKFyGTA?=
 =?us-ascii?Q?lF8l8GG1+iZ13pJ9aD8E9BEzfGVoSB+eWdqcYfshFHEN8LBiMlXVkCde6WFi?=
 =?us-ascii?Q?DQbgeswWCIVnojGqwI52eKCInOc64KyaP+QLGrPU2vgYSVtbYik71wdoIe5q?=
 =?us-ascii?Q?aEQWnMA3bClRhioOZM8BAU7vL4IT1vyIbBOlBCtO7ukEH3WtfvH/gmmNVkkg?=
 =?us-ascii?Q?KfE7xxXAQ0qCqmKDnmZUwbzPk3KQ7doUgyKIrwua3LYXFEmgdRzjqG0XARN4?=
 =?us-ascii?Q?51hln2Q+vrfMkY01/LXRw8YzMv/JKhgMTp5zW0kSVdEYnibl1qEktsRe89sU?=
 =?us-ascii?Q?nLhhurQsOK6JHwPkZJzGMrGhVLSqMaT3r89Nfn9HQUTZNQRI8Sk0ScM/csLc?=
 =?us-ascii?Q?tQ6z1IrO4twejdQQArHHAgPHmuWzVWV861gLrJZ1P5TQmCRXXz2NsnHZt29y?=
 =?us-ascii?Q?klsXGLXcK39uS0PCCfSGga3QX3OU6pAB5Vla7czUXyDfDWdEMAfKFEDHcIxw?=
 =?us-ascii?Q?C6VwAyixvz2CALDrtw5w2a/YuaI8pMKURlfLfepOsvs+nJw4TLg7yqbq/8iB?=
 =?us-ascii?Q?dW8s5djX4gl4NXeCQL0yGojVtN8mg+j5Z/2sjSsAppnVSHRi/FE8BFNigOS3?=
 =?us-ascii?Q?Nk89kPVk+P6IVtmnCncAejrxGMFOsFZgfptnS4EDZgP3r2FyIJJBEuQ1VENC?=
 =?us-ascii?Q?iWlbZxrm670na7ShbwDqlrkAqfEbq4JJD8v4Vgv6j3uY61GXe1o9lp5xid9v?=
 =?us-ascii?Q?3NcWTC96honQuH5mDCbqWMDNmZpWeYmi0cyK/iPucHWsAcFlyyMCTFSOPsyx?=
 =?us-ascii?Q?e27rrkRvUz6jFfGv9KIzMw6bkRl0P/ptGO1nkaOD5p9kDN0W+dg7owviL+gR?=
 =?us-ascii?Q?nnhyQi8S55bBzAGE8lYb4gW7YY5souJQXTv7TXBKoCCLDuTCwJ9EyRuvsce1?=
 =?us-ascii?Q?ZJtm+UTP4l/jI/X71k6eIzDhAxpuiE0PTF2yfrHQZxwCkUkdrGaV7G4I7IFt?=
 =?us-ascii?Q?8YH5Ejht/BJgDgPgzI67HaZjw6b3ZawCKGFzEYIApZ6/0NWgdfRa4rd6RM1v?=
 =?us-ascii?Q?UXyaBoe9mTluAt5N7Fby4fXvTbaK9aHR7UwE2QrbB078w2JPy567HGqo/VjP?=
 =?us-ascii?Q?72mfox/zvBGcFQ97iesMVJK8OKkrvH4MfE0DZEWyb2uV0KsXaIZhSwwulufs?=
 =?us-ascii?Q?TU++AmAU+43gA3qG8m9fHwrtUOMj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ll0CO9oF6gBey1FnpCyEIshoEvG4Sk/6Bx0uwD7C5YpNjDmC0oinjvPV139h?=
 =?us-ascii?Q?C1tnFm76PwZq0XlUBmc58dysP2sRiHWeqgMV4aShM1p7q5hzKreui52SizEs?=
 =?us-ascii?Q?4MIntv09Qd9Xa/0TO8v8PFJ+s1AoEaYBsbdnA/RCmajIvTaOU7/erovs0Ea8?=
 =?us-ascii?Q?bHdNpVPQnJolfAXKVj0aFRyq/xxkDPU4EuCu7uDnBcJcaRnP0ZRd3xk3aCZc?=
 =?us-ascii?Q?D+kiNLYJe5yMbW6GjKt+oHPQ85X8XteLMIW0Wzs8TVkBsnJ/d4Z8cm9pn2qq?=
 =?us-ascii?Q?69ldtioZvvenuMBB6r+HYxf09k63+Ch6uLhgt5C+RCh20wY3BszCGy/Riacd?=
 =?us-ascii?Q?7FvwPy41L+mhAHeazVNXoOKkTc4V292uYaDMMmdyO9nuGDwqLXsWZGFre8WO?=
 =?us-ascii?Q?JLmjf8UtmUHKZg6Cf+7lCquYEGEHYPlJWeQJuMEWjwZdd5XY9EP0Og7S8cmE?=
 =?us-ascii?Q?428YYbl/DqnRfPXklAMU0pcfGbzogruIHc+QWwq3HHtTurR2wTOtNRyu8831?=
 =?us-ascii?Q?45/LvGrmxY34ZkCkCLXurO6SfxLb+ceiLZZT7e9UVQMj/qC3aud1YqDtsIL8?=
 =?us-ascii?Q?pf3UrC35sdihjIoI4bsSZAxoYMDe1RVNzdpS/d5NPs7sBAwBLgEPDEFNDJ/d?=
 =?us-ascii?Q?GvnkXo0DUqRolWockg617KELjhPH36++bfW70sSD2znA7OJ/V0UB6NnLW8Cn?=
 =?us-ascii?Q?fdKmQG31ZEqHsDmBNVl8sBOc9furNt0DwLUCiXm1co9HV5FRDUfbRSsPkPOH?=
 =?us-ascii?Q?COFkBRmq7xYGpmFzZjXYRf7GWkrOhsJ6ohbLgoFeqRQbTfTrUd8yPOOFVUmi?=
 =?us-ascii?Q?F8/0lgX67JJBeC7aAcp1MfemrjCSnPKN1u977SlyJENYkvPZ010QALTZZbSp?=
 =?us-ascii?Q?7ukFnvpp11Q8dX5eZIQNPxFpAd/C1QqWbRFsEZjfOK6OaNdrVZba9U0dI/Mj?=
 =?us-ascii?Q?e0FejnqA/jXw7lo0+VaFExiVBWlaOwOVLXeRFi57PWvGBzLoG+KLN63ztzQ+?=
 =?us-ascii?Q?+LTOOV6YF5VPP5ZtmAas/AIOvYScNn8Ny1VcmWBcOZgCvhdPNWIkidzuiXy4?=
 =?us-ascii?Q?08br0PcKZR90AMjFl0XF52a+7RM4Dem+xjpE69O+jiSwiwwhpGjO2evAknUR?=
 =?us-ascii?Q?rJ1nN8O5BKFZZ6MGz0or0+SQKxG6eSwKJZCrdvckPhbO99P+KiFOv6MNOz08?=
 =?us-ascii?Q?WAH+bXBV825MtYr2NfFXxKpCErgfORPfe3UxDZUCUaYYIBpUHuFlgNIUg6iU?=
 =?us-ascii?Q?/GzOMsJR9cY5449lGVhVyOOAKLz20XcwBVbRzGKBDJ3IZQPkgJ0iCDAtprje?=
 =?us-ascii?Q?NJqnU+QFMQjg5nFBTYcmiY1Gg0uvKL7i3Evgow1IJGVl8Q9+OYVsSGHUoNjO?=
 =?us-ascii?Q?22i0GDidAFrcnCwCJ8lb7exsTHPbqH2EnTHC/YWAWb2Dv0WjSOSnKY06vu2A?=
 =?us-ascii?Q?gh0+uTIE5jz+xKdInBWZGWWoEXIY0JLKKttEAj0j2p5pUQjYNXXzSkmFsSkK?=
 =?us-ascii?Q?cD/bz684OkKTuFunaxwx4sNV9cLrKyIYdne8uFZ5Pfm3jwMUXmhjUGqhHYwB?=
 =?us-ascii?Q?84BO1JgA6z+1CpyhSKqYfeuft6Y1OK961TEK7xag?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89707d14-42d9-4223-8662-08dd1e7f2546
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:42:39.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChBnyijPpEVHEN3+6EOTYMDQ/GlIyiRmhFNKvIn8afB0OxtShfAUlh/bDjha67RNE2fXcdRKqo3xvKX5vh4Nkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

Add the following kfunc's to provide scx schedulers direct access to
per-node idle cpumasks information:

 const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 s32 scx_bpf_pick_idle_cpu_node(int node,
                                const cpumask_t *cpus_allowed, u64 flags)
 int scx_bpf_cpu_to_node(s32 cpu)

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       | 98 +++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  4 +
 tools/sched_ext/include/scx/compat.bpf.h | 19 +++++
 3 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 80778d660be6..1edf4206aab5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -433,6 +433,7 @@ struct sched_ext_ops {
 	 * - scx_bpf_select_cpu_dfl()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
+	 * - scx_bpf_pick_idle_cpu_node()
 	 *
 	 * The user also must implement ops.select_cpu() as the default
 	 * implementation relies on scx_bpf_select_cpu_dfl().
@@ -890,10 +891,10 @@ static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 #endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -1004,6 +1005,11 @@ static void idle_masks_init(void)
 	}
 }
 #else	/* !CONFIG_SMP */
+static int validate_node(int node)
+{
+	return numa_node_id();
+}
+
 static struct cpumask *get_idle_cpumask_node(int node)
 {
 	return cpu_none_mask;
@@ -3813,6 +3819,10 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u
 {
 	return -EBUSY;
 }
+static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
+{
+	return -EBUSY;
+}
 static void reset_idle_masks(void) {}
 
 #endif	/* CONFIG_SMP */
@@ -6400,6 +6410,15 @@ static bool check_builtin_idle_enabled(void)
 	return false;
 }
 
+static bool check_builtin_idle_per_node_enabled(void)
+{
+	if (static_branch_likely(&scx_builtin_idle_per_node))
+		return true;
+
+	scx_ops_error("per-node idle tracking is disabled");
+	return false;
+}
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -7476,6 +7495,16 @@ __bpf_kfunc u32 scx_bpf_nr_cpu_ids(void)
 	return nr_cpu_ids;
 }
 
+/**
+ * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
+ */
+__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
+{
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+	return cpu_to_node(cpu);
+}
+
 /**
  * scx_bpf_get_possible_cpumask - Get a referenced kptr to cpu_possible_mask
  */
@@ -7506,11 +7535,26 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 	 */
 }
 
+/**
+ * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask of a target NUMA node.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+{
+	if (!check_builtin_idle_per_node_enabled())
+		return cpu_none_mask;
+
+	return get_idle_cpumask_node(node);
+}
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask of the current NUMA node.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
+ * kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
@@ -7520,12 +7564,29 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 	return get_idle_cpumask_node(NUMA_NO_NODE);
 }
 
+/**
+ * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask of a target NUMA node. Can be used to determine
+ * if an entire physical core is free.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+{
+	if (!check_builtin_idle_per_node_enabled())
+		return cpu_none_mask;
+
+	return get_idle_smtmask_node(node);
+}
+
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
  * per-physical-core cpumask of the current NUMA node. Can be used to determine
  * if an entire physical core is free.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty cumask if idle tracking is not enabled, or running on a UP
+ * kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
@@ -7570,6 +7631,33 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 		return false;
 }
 
+/**
+ * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
+ * @node: target NUMA node
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
+ * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
+ * was found.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
+ * not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
+				      u64 flags)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return node;
+
+	if (!check_builtin_idle_per_node_enabled())
+		return -EBUSY;
+
+	return scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
+}
+
 /**
  * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
  * @cpus_allowed: Allowed cpumask
@@ -7704,14 +7792,18 @@ BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
+BTF_ID_FLAGS(func, scx_bpf_cpu_to_node)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 858ba1f438f6..0ad368401579 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -63,14 +63,18 @@ u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
 u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
 void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
+int scx_bpf_cpu_to_node(s32 cpu) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
 void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
 void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
 s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+s32 scx_bpf_pick_idle_cpu_node(int node, const cpumask_t *cpus_allowed, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index d56520100a26..587650490743 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -125,6 +125,25 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	false;									\
 })
 
+#define __COMPAT_scx_bpf_cpu_to_node(cpu)                                       \
+	(bpf_ksym_exists(scx_bpf_cpu_to_node) ?                                 \
+	 scx_bpf_cpu_to_node(cpu) : 0)
+
+#define __COMPAT_scx_bpf_get_idle_cpumask_node(node)                            \
+	(bpf_ksym_exists(scx_bpf_get_idle_cpumask_node) ?                       \
+	 scx_bpf_get_idle_cpumask_node(node) :                                  \
+	 scx_bpf_get_idle_cpumask())                                            \
+
+#define __COMPAT_scx_bpf_get_idle_smtmask_node(node)                            \
+	(bpf_ksym_exists(scx_bpf_get_idle_smtmask_node) ?                       \
+	 scx_bpf_get_idle_smtmask_node(node) :                                  \
+	 scx_bpf_get_idle_smtmask())                                            \
+
+#define __COMPAT_scx_bpf_pick_idle_cpu_node(node, cpus_allowed, flags)          \
+	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_node) ?                          \
+	 scx_bpf_pick_idle_cpu_node(node, cpus_allowed, flags) :                \
+	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.47.1


