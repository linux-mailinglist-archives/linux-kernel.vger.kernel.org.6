Return-Path: <linux-kernel+bounces-569251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF1BA6A090
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B62918956BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48D21F0991;
	Thu, 20 Mar 2025 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tNEpsWbi"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3615C0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456386; cv=fail; b=G3UhFpDqXwwUI+gU5pQSV2WOso3dV5IKELRWHiuQ4KfKJF3NPQNBlqYn5W/7MfjD0XeL+fB/PGV9Qf1INd4tID0pMzXtCL6SwQwHpio6amm+6kN+9MgshR2/AF1s0hlAMahfmB+cL1JRkTQZJGwAWfRs976f2S0RFP91fkqt38s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456386; c=relaxed/simple;
	bh=daxp2b3Cog6aCmj1wQ0OdmjfBGQHqvM25tSTHIQ7zTw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dyDRigJRsJbkOi4vPpHMYvhFKiGLDc5z0pQ4+j/p6ZZ5jxCInEz507nF7JhRDStzM+aGzT3bx5ejbw0K+uNMhkMg7nkIMzoX6cMevIJugUnFX5Gf1LTfEUKYeVZcXfKjvA4BbdxET2cwvTbL6baZiBVhTaHtgXjElp+93JLroCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tNEpsWbi; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtJbBrMiCdlycrG+yNtvxcOBjZMCSyzpp+K6f7tiHfrwYSguaJEGfHp4MeCABKdQgzkDg3EhljpEcUSjDCfU5M7lWD65WyvFdzEA+1cwp5Y/6IJK5LoVxOnWV6YtxiaSEAw4gQb883AwpUt+Zwp/XqU6AlR8gxchllRO6jHrK0qbSL4yR1EmjeI7PORd1LNKCfoO2UIg57vIxNFobj9cD4kzNSxECr9+aQmU8SDrLeGzCUhEEDwCOPH/14zd9fSFEt5tYgLG+/Iv95+fSBDuZMckmIoHtSm2IbblTkr4P+xxFHQeLv256W5NwVOm3+BgFbvvbuV+YsCK5GV7a8Upmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX0W5P9HfN+bC9888lkxsQxs8cCqw6zl9hDATO+ofQg=;
 b=cihPS7zuHcUROqO8kKBGau0Yj4isTpP4pEQ66o4vMQlXUObNYBgfVmnPYcMfeZjTwX4N++HMiSIDMpKehkf/C6tJZG7BzZef0irKv/cjmCwzJNoWZU6WIAwSFVO0HcRJXrEfpf6n/vaT3cLRp/2ZElWUsCAY/S/SNvG5BEid9uL7bUomGojKnznnnOKd9hTMLRYUq28Y6Ft4n3vRGWC33/I8GVHwCEm+Lul85oAH/imFJfYFOyn5tKh/L9VqfQkHlYACUnxtfI70IhBlC4H4WHCiZo8GLouoK0h+9IEJyRz1B7fJaS6De0n2xNoX7OFXv1h4VEIm8ejSAQcxUQSwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX0W5P9HfN+bC9888lkxsQxs8cCqw6zl9hDATO+ofQg=;
 b=tNEpsWbiCBw4tTUhey2LveXwD/iSdabbO8vPEvVaiZpYfTpYtQosBsE4VWSRN3TUQe5EKj12UJ94i7nxE6+w/2f2ncjW73exDwfiuieJ+DaI1gL1G/snu1okm11E+WdURoA29yjMGhSB+7AB43X5j0Sd7fVKiiN0YDfh/L3NiedIbstg8J2JMMrsKZBjzzJYqPX54OCLAZcZLOqXeNy2p00QJ6vMK9yueyUoD+xioe48qSAuSr9KPKhuWut81RlkmKdIZpTfrz9SPeVofgoVmOHsS3S0LepQGkeD7JaiJLF49lacUwq2E3R0hD49qYnXE3F9dfv5goyEVcsYXD6ZOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:39:40 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:39:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v5 sched_ext/for-6.15] sched_ext: Enhance built-in idle selection with allowed CPUs
Date: Thu, 20 Mar 2025 08:36:40 +0100
Message-ID: <20250320073927.216147-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::29) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: b122399e-ddaf-45a7-906f-08dd67825f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?izgUUQUwHDbkCS623OfIkt5k2gRDRlXIAPLuUgh4FW0EKVaUU6qK2ok/J52O?=
 =?us-ascii?Q?ZH3cp4tiHlKOIUkWFVdAblb1wl9QVOT5Gs9vJv7XMcBIDCwTlqatrOYohWZF?=
 =?us-ascii?Q?sEZhVD3C1o/Mndq5JPdzRYtjzs/BQYZEH0ap54zMhqQED8/chA81ZzUDsLTP?=
 =?us-ascii?Q?R83XQ5wDMLAIetI8hJlD1twiaDHlTFRTMHcz2snzZH89o3li7MDkHbOwK7+4?=
 =?us-ascii?Q?M8lv7Q70pgJ/wLBLt5y8JxYs5DxXbvsvCebxJ0SHG5basosP0OtV7GQGPnKO?=
 =?us-ascii?Q?nug88WOJhrrQk0kb/TJy+fkah+n6M3/eY9aPNmiI/e6ZunJE59EE6Tpm+GWI?=
 =?us-ascii?Q?XSLv6h3brLM3xHQCeKPf5EGnk9fMleLBA5DtmQNH0z09yEW4kYrpRqrGxS4L?=
 =?us-ascii?Q?RcrVSw+8wYVDexKlNi5LwAPL3pQBGT6zlKj2WTVElyAQc7kKhCLESoc9qN+s?=
 =?us-ascii?Q?fn9v+MznSjeQsDOJDN6puH3WtK9O8coXBZYGhc3nlDOTfz6wRJBmQplN7lIu?=
 =?us-ascii?Q?tZYTAaIeRBK7zEWbXQ3MgJIRCCrO3ugj5TahaP3Im5LTgDX9GqsvnyGJ2CxU?=
 =?us-ascii?Q?zSm1f6VANRsdeYIQQu2mRYdqjguRvJrjaVH6onV23gtsGupxukXixDvHNmSE?=
 =?us-ascii?Q?sc9NZWc2JDScPaDEyUxRf9DlpRkfzY8QKFZpt/9UbO8w/w73Uk+MTmEKbMwl?=
 =?us-ascii?Q?lYXNGtOYwauXbK/IGJFvG8C4vWv+p0AZb7D7FvdzCcVj7QP+w8/vyYbLZgRp?=
 =?us-ascii?Q?wYbk7KIVIVC3dPGhGnHhJsSgh7P0FYLpanqOf4wa1iyQaQzrMkWtuXFIH0NP?=
 =?us-ascii?Q?fK04qR+4PVwEFfxheG+s71Z54YzeJAg0/UjQoWcQA0nEgvcJgWB7kEwbNk54?=
 =?us-ascii?Q?OR7SJ4YD8oov2pmM7UMjpARwxMJaBc0euQqDvgAe8TTCzc/ViIqFQlMYFDT7?=
 =?us-ascii?Q?na83kkgCkblionPTMrU8vGNMfsSoGJRvonQW1Y+jpEEJGI420t1qw7Hhch3T?=
 =?us-ascii?Q?dKga9e5V4VtHOsxOGenQgi3k4usa4i4gwaB+vqtrQLtvGpbvzEEcFHF2HJvd?=
 =?us-ascii?Q?i2asJ/vx5MesJR9b8wJf+U55+3GN5RS7Sbyv+d0ha0vUGyc8r5u0t50mq34+?=
 =?us-ascii?Q?m4xZj1XeXsGW0/hRIdf4lmA5jdHIxKwbpCOBYCNrnIEkmA1HUoRNZ9mopN/d?=
 =?us-ascii?Q?6uQ/OYSXomVvvk/5qyvriFozf+XRfe1ERhvfydij/J/U1S4VCuROhKMXki0r?=
 =?us-ascii?Q?Rhf8kvu2Ym3v0cssX2P78fC0Jq28oWiAi+ZAjiTjqxOAJySSyORPZgB/Bq5P?=
 =?us-ascii?Q?sOXjP6a/qEfFQBAPnbBCfg8AYKkXUEGXediojUns1Iw0+xcrXFXygc5r0jnM?=
 =?us-ascii?Q?fta2fzf+ds/CzAngZubILfM6KAbb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KVTxjwWpyuSyY2IaIJ067DgiUdBlKB3YkKJssKOAK/tE8fZOVA8ZbMcueqbH?=
 =?us-ascii?Q?uJJHVW4adAzPMDZPcjYg2Rg6lwXK0Wt7aa7hzlV4ASPrATIj2fANb1fGK2PR?=
 =?us-ascii?Q?xHcFMkmLdMJVgapMSC/2Qx3nFfDI1uf5I0ZvL/b7QWN0vAwDruTSlc5NsWk5?=
 =?us-ascii?Q?rfU6Z0ngkaYBe59t0540XcuJ3sc5L5F7vXXN1Sl/6k+Zb9uVyft+UUgSFKkO?=
 =?us-ascii?Q?laV5y6mJHzDRReU3ve3vFKCdLKPObUe9JEFWmKr2jxjiT9tcpqiPfzA9utwW?=
 =?us-ascii?Q?g3TjgK1diTnyg3ymX/nXBndq0rTfO9V2bG3pJFyYGNS4qndvv68+u4yzYh2+?=
 =?us-ascii?Q?KyNwuBwjRWlH9wceTyTKJCa5hFEpU2W2yJOZXhU6pKIGyENXe9IIaiunmVv3?=
 =?us-ascii?Q?42vazllLUT/XkUqg8L4kTHjYtTYsLklhgghK5APX+K7t7+QJnbYRWojII0mF?=
 =?us-ascii?Q?RaK4oVx2gG8YLB6WRUVna8EWnuk5ZqtQ7GGSXdxSlo1e5Nm7D2mkQ+GicecW?=
 =?us-ascii?Q?eoWbuBxXs6IDQoddPFxvOqGVdrGqKbU7fPt/L1AHiRQxR66G92yRxJA8pYHq?=
 =?us-ascii?Q?/2f6Btxgixxj0ZZOPAhT7LwxUn5eoZ+6bDNiqJF0A/Lq+8zOAlctUyCDp5Qg?=
 =?us-ascii?Q?M/21kFrLeqaSp1sqkFKOOQDjyMEBeHzzHIEfg9Hu2XFKGzDBOJyh8QAupaSB?=
 =?us-ascii?Q?gGsxmA96tK2QcxKBEU/tbrqy0QP1gh+XFfrpZtxqDT7N0jyxsWzeiVSDqa7+?=
 =?us-ascii?Q?JiPWWOB2lu5Qfkdw/Cav2PJ5d3jDDD0NgLmEed1pF4IE+MavMOD7gzUNuYaJ?=
 =?us-ascii?Q?Vt7wHEjcz+n8r+n4s38Asm1s8L6fpVqdgGrxHTC9WH1bFGDUDdAWEm0NXLfi?=
 =?us-ascii?Q?G9TEOc5W+xVGbZ0CVNyig/BaicmX3bvKSg/+9AJtyQ98575miBpMKj+vj2dE?=
 =?us-ascii?Q?M62Z9L2c5p5RMQoPpOrLx10BSoXEqMZxgrh9vD0W54v3/1mR7GWMAPv7K4WW?=
 =?us-ascii?Q?WZMv7tBP8Es9sb1Y7sop66FcEPAUiTc6Txnpp5Zc8IjK+nCGJUC2gql/IwhC?=
 =?us-ascii?Q?6/YL/i8XA14D40+z0zx4JvvHiaWrn2N+4wv7DvYSdrvqIl43nHNLZfM7iEAi?=
 =?us-ascii?Q?N2balGwRMPi8p883kzt/xtGGw44wym2h3eTKx+ZJIud8SYCJegqpIznw7d4T?=
 =?us-ascii?Q?+7BNTVivXLBieAYV4AVfRmP3eCgxehT6Qjf9+yWLMTDwhbZAxkox6bpGZ9QX?=
 =?us-ascii?Q?QuoRLPIzoQyXyOQxzvlpbVfbBbXldzfshlkznLCzFBNVlU3rXqHSPWaMHizx?=
 =?us-ascii?Q?uU7H0UTBqpia5Jx3t9n7f5+IfnN3BuJd2GQQmtok23NYLsmurvDg9Iuq5L40?=
 =?us-ascii?Q?47VQBUMpBWecKbniGaCSrImJ3JicgABM78ObuWRRoQEIdqpGDBPHOWKb2Q1X?=
 =?us-ascii?Q?6aGcYTGMEKgjTRJXzzustH1h3uShgMxfnlxIJgH8jnr60wkDCzsRK0cve8Nl?=
 =?us-ascii?Q?qOKzJY9ubE7acPUJOXXECXXGWRyJRC6o2pp4i9mYP7MZhuxbtvxxB9LLnACm?=
 =?us-ascii?Q?m4yejhlluWj3Wqp3ldQmrbyjrhnP4BCezPHK7d1F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b122399e-ddaf-45a7-906f-08dd67825f72
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:39:40.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYM43pNU+NClZG5tFxogrvpXiEMCwM8HqOaFCojDC9l2yFhXUdkh09aBd/OcGFbkZlo6sTZPu2ceeNR+VxE2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

Many scx schedulers implement their own hard or soft-affinity rules to
support topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., running certain tasks only in a subset of CPUs).

Currently, there is no mechanism that allows to use the built-in idle CPU
selection policy to an arbitrary subset of CPUs. As a result, schedulers
often implement their own idle CPU selection policies, which are typically
similar to one another, leading to a lot of code duplication.

To address this, extend the built-in idle CPU selection policy introducing
the concept of allowed CPUs.

With this concept, BPF schedulers can apply the built-in idle CPU selection
policy to a subset of allowed CPUs, allowing them to implement their own
hard/soft-affinity rules while still using the topology optimizations of
the built-in policy, preventing code duplication across different
schedulers.

To implement this introduce a new helper kfunc scx_bpf_select_cpu_and()
that accepts a cpumask of allowed CPUs:

s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu,
			   u64 wake_flags,
			   const struct cpumask *cpus_allowed, u64 flags);

Example usage
=============

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		   s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
	s32 cpu;

	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
	if (cpu >= 0) {
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
		return cpu;
	}

	return prev_cpu;
}

Results
=======

Load distribution on a 4 sockets / 4 cores per socket system, simulated
using virtme-ng, running a modified version of scx_bpfland that uses the
new helper scx_bpf_select_cpu_and() and 0xff00 as allowed domain:

     $ vng --cpu 16,sockets=4,cores=4,threads=1
     ...
     $ stress-ng -c 16
     ...
     $ htop
     ...
       0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
       1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
       2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
       3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
       4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
       5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
       6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
       7[                         0.0%]  15[||||||||||||||||||||||||100.0%]

With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across all
the available CPUs.

ChangeLog v4 -> v5:
 - simplify the code to compute (and) task's temporary cpumasks

ChangeLog v3 -> v4:
 - keep p->nr_cpus_allowed optimizations (skip cpumask operations when the
   task can run on all CPUs)
 - allow to call scx_bpf_select_cpu_and() also from ops.enqueue() and
   modify the kselftest to cover this case as well
 - rebase to the latest sched_ext/for-6.15

ChangeLog v2 -> v3:
 - incrementally refactor scx_select_cpu_dfl() to accept idle flags and an
   arbitrary allowed cpumask
 - build scx_bpf_select_cpu_and() on top of the existing logic
 - re-arrange scx_select_cpu_dfl() prototype, aligning the first three
   arguments with select_task_rq()
 - do not use "domain" for the allowed cpumask to avoid potential ambiguity
   with sched_domain

ChangeLog v1 -> v2:
  - rename scx_bpf_select_cpu_pref() to scx_bpf_select_cpu_and() and always
    select idle CPUs strictly within the allowed domain
  - rename preferred CPUs -> allowed CPU
  - drop %SCX_PICK_IDLE_IN_PREF (not required anymore)
  - deprecate scx_bpf_select_cpu_dfl() in favor of scx_bpf_select_cpu_and()
    and provide all the required backward compatibility boilerplate

Andrea Righi (6):
      sched_ext: idle: Extend topology optimizations to all tasks
      sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
      sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
      sched_ext: idle: Introduce scx_bpf_select_cpu_and()
      selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
      sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()

 Documentation/scheduler/sched-ext.rst              |  11 +-
 kernel/sched/ext.c                                 |   6 +-
 kernel/sched/ext_idle.c                            | 196 ++++++++++++++++-----
 kernel/sched/ext_idle.h                            |   3 +-
 tools/sched_ext/include/scx/common.bpf.h           |   5 +-
 tools/sched_ext/include/scx/compat.bpf.h           |  37 ++++
 tools/sched_ext/scx_flatcg.bpf.c                   |  12 +-
 tools/sched_ext/scx_simple.bpf.c                   |   9 +-
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 121 +++++++++++++
 tools/testing/selftests/sched_ext/allowed_cpus.c   |  57 ++++++
 .../selftests/sched_ext/enq_select_cpu_fails.bpf.c |  12 +-
 .../selftests/sched_ext/enq_select_cpu_fails.c     |   2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c       |   6 +-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c      |  13 +-
 .../sched_ext/select_cpu_dfl_nodispatch.c          |   2 +-
 16 files changed, 404 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c

