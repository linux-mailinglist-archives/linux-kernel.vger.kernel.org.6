Return-Path: <linux-kernel+bounces-569254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E496BA6A093
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9DC3A7EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3A15C0;
	Thu, 20 Mar 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F8OkPFC1"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A4205E3E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456409; cv=fail; b=QU8+FfzP5eh4Vv/5mEt664Yqbj00KZiytXd0xHuclAdiX5rOHv4bzeWY1aRSIkMm7tStwll8fk3KiKKJCnC7XM2I8+qbP2ueTF62C/S62Lk0/T69ktXEphKkHfXGApjVwZA/WNFzV/PnXZhWo81kcAVLNUT5Q9H154dp1cmDklo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456409; c=relaxed/simple;
	bh=x/mDK55mVDgiwuK24vMyTyJmYyjnfE7TN1Nk4dWs/h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGKd5YPtqvoWUB7eJt+91wPbI2j//Z/4h8jviwWvNYUI7nc0g3sHLoHzSJGQrEIoHNMf2nUP894c3rbLFBv7ri1CHf2iss6V512Zqa41lmX+LPbqkSPhZrcm2XcwPl4fOQV4tO9mZRm4rawQHiuH0GvSW4PuCVIsyXDueBVYREc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F8OkPFC1; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nX5mBGfpOs2t0HDE5NMVBaIj4YPrl61J9rca5Khe68yl+prFJ/sXeXap1PXdJ//ELMkOo1hYES2DfbnoFt0n2w1YEfN5046nkbciHQrnATZCTSbNUPrpe6mZ0kDv/xAjQULHaf/g/n5ccje9zyRT+QiNNxsAG5sXZ7fStjP++BqWXjFOgP4I9fOeTyBqFUDa8EvM2c/8NPjnVxDBH8EaNjqNYcGHildwn/h4UG2nQ2QSs3i4aaxy71SkQVRsjC+bnbH1dXeA8d0byR2KP1djxTq/Yr6Czs2JbXoeKDgd6WqEbJxp6tJxpRndtx84g/Xh8wvgD3WpNPHcc/XmyOjhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDluHRyU+Ha3+9H6Qrp4L+Worjy666WbU2hzgSw5Kp8=;
 b=BMQs8t3ASjB3vgglX9Kjxk8dzHDGiVVlBYdaJQxN6Cm+M+tDQnKfNho4tgDDVO8ucHGBLEiIrRXRhsc9FgOxolVvHWQ88cOQ49h/Sfwc+Xjz529UYjdrvkkZF79R1QUPGyp1bCcXBFmsn68EBLE/Pe7t5xxACxEGrlJf+CdIaY3Tfv2SlhAgSxTOy99IMd+Z7G9tzfsRfrb8bPr+COqnkTUgb8D/9DPUIrQ/Q+4i2Whl9f8o7Sk4odOYjIl7828PJX2GGdxqaFnFsuLkkPRTnR0/dz9q26LAfKd4ARX9jjZ1wDzE6vcWMO9Co+LfNIqpb5DyzU1c+fACuNINsThJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDluHRyU+Ha3+9H6Qrp4L+Worjy666WbU2hzgSw5Kp8=;
 b=F8OkPFC18QA0UsoqSRNfBChVocyTKd7CshQgrKSkVzxhcOb4eTkzKwYNMSfawHI0ummUF3fs8APPoOCCA9cEItALVpNwP535ccDc24Ww24KNHoJCGJ3WvLNCbl9YR85tDdNoMrhAmCJkkdvXYnGznKCjckE87RedYi1/L+KdPVXMhNbI6c2jnsC5uHsSabDoTevDThHJalFbwS8pQ5oZtnafS24ddNGmus10ADlVio4+zogjceifdCBmJRc3Y7Anh1kHHadzY+regS9l8/lOPkK/kyTKnqdyNICP0FoeZ+TwMvlrP3diT4ZWetR91MZXUOCIojH5H/V2ESwkUyhbhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:40:04 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:40:04 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
Date: Thu, 20 Mar 2025 08:36:43 +0100
Message-ID: <20250320073927.216147-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320073927.216147-1-arighi@nvidia.com>
References: <20250320073927.216147-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a57ae0-f942-4cbe-9308-08dd67826dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8C13L55pWQrDfLlcSF8ftclHQ/13pEcXxGx6kXbD/vsx153DixWl6esEaDak?=
 =?us-ascii?Q?VOBVxMqcArlSNX+RYTipmeuCIu+2zG/t0zwhLAZFpEiLHnPAE8A9JzSUv4KX?=
 =?us-ascii?Q?0fBxTnjimcWG4Kgy+8JlBkz4n4JzxIUx1ckx0BuSs2P60u2q2tY6OwNGRb1O?=
 =?us-ascii?Q?fMkxFQeTYy22MXfQveBGF5GTrEC2oKCgz3SUv8XU6OHYUjJNkzpW/FXrMCA1?=
 =?us-ascii?Q?aOpEu0yMtQFzqNQa5ayvxAAc1/7v7PDbr5b6iwHbMnizESa8nGQwjCwc/hsS?=
 =?us-ascii?Q?NKTxwy/VzBimZjFKXP/Yio9zK8IaYLlHL5wck0VNN+z/Ja2IFDc1aH6/2ihH?=
 =?us-ascii?Q?b4HpAD9Ttes3LtJP/n7WiaVUDQ0ZYo28LuFpe8sCDXLJqK/ZXGoocBgsovQR?=
 =?us-ascii?Q?jS4r1BY4nwiFgbvSRZQXBI6MyXw7wL9sEjkOsST2YXijAzNHQ+cU39rkafyD?=
 =?us-ascii?Q?5vabtmth2F+zrol2Dm5iysnMMuqGc1WX4rsennvh+hrpxjZcoIuI3eVCmM/U?=
 =?us-ascii?Q?iCcosmWqxIasG2dQklwrv/w9iNbG7d5O2ZmZiwi1jN0dgqq92llbTWWzS4MG?=
 =?us-ascii?Q?fSN9l1nlvxWvLTHUt52PTqoNnqJs1HijaCN/IASyZYzDz8FrQmHmVq3/Q4Qd?=
 =?us-ascii?Q?v0XjY2IgZGe4Hrgzkczb2/XkW+0yZyfsP4PLvUbmTG+8U+OPOs6Ei+WTmrbg?=
 =?us-ascii?Q?S4Vsl07wsxSdamojdiH8Ru1asiQuH0S1oWxMpayn6904cyEt6pd5nCm/4i93?=
 =?us-ascii?Q?iclBj57SP2aHoT8HavUdJmdNDr9gyscjzqOnJph/TJ1zl8113h/d2+QLEeVs?=
 =?us-ascii?Q?FRUTKBNDmF9qPER+B7y8mLVaBLDdDWbtjV8nbfw75/tZwxfbdf5puSn+GGLD?=
 =?us-ascii?Q?Td/wQ1vshZmcmF+qnvygj8CMiUi/p7OJSzt4YdrOMz3zBsjUwi0iKuhqiFLo?=
 =?us-ascii?Q?j+zXIAMoSPdnoD3UOmPahSNShBXE3+ziL/FS2TIM27THHx1k2OEP2JB+FAzI?=
 =?us-ascii?Q?Fe/MbUTfHJjwZTr3DbNHpVkwrmkt5krXsvhzKP5SLiABz1pX0Pn34WyK+S2F?=
 =?us-ascii?Q?dIIgI0x5HVpApLokTCM//H+nh7ooVL8E9RiS4Nval9zzTKVXrdgI3V4Xgre3?=
 =?us-ascii?Q?DX709a3qn9qRBkqYdWe2c5xdejgVHMe70itsIxkT2xGnD8LQ7XUMuNOCuIdv?=
 =?us-ascii?Q?JBOA/dzeVlXAkoFFZUGI/ar38lZX/axudOg0XOm3bpSSXR/cb/lVECrniS5j?=
 =?us-ascii?Q?bI3oenZnzbQAP5lYUIjoWB4ah/+U8ne1e4bvnSvMK2mYMkZZy3T/pecvFx7m?=
 =?us-ascii?Q?SZvhwWkwbQFfj58X7JwsZ45omxNRZkOIIVxn1UzURfyV8zqoFnLitOuc2bFm?=
 =?us-ascii?Q?0LkcGDyxctSKRORMATeylv0Gi3tJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQjp2b8yG8jsLngM3LulKPBnm+JEIuJYWn9pOsa2omUB9b3mcqljbVVIHaJg?=
 =?us-ascii?Q?Tff2/0ay1KPMqcR07aD+RyMjprxpmyBg4Cr+U8MWm391VIKtk2RsDepH1Lbt?=
 =?us-ascii?Q?JBEL4/GUWJHtY0HtQrFbDGjoIJLobc5OOjDo7c/zdjxktwzJ2XqPd2IUWThR?=
 =?us-ascii?Q?M30rGCqup5CWpI2Ic5g74icxwIOqEtKiW3HddaF+r3i0f0ajl5ZDcdd2eC5V?=
 =?us-ascii?Q?nvJwSrOh3+fIKnU2V3vkpRZkM9K21D0SVmLi92GrqpLyl8DNyDBT17IEHcYv?=
 =?us-ascii?Q?UpLUOvnKPeKP6i68J05tD+Dvo0ZSa1GMz2R6DJijJGa8BsQFyRg5+gqCtWCu?=
 =?us-ascii?Q?oSS80k4FmDnDsGpJW020nISNR2qVVNSjoXio9Q9woE7BF3mxIsXJT4xglNcS?=
 =?us-ascii?Q?8TBqjucfpMpXE1c3QDmp82FBJFej083RNfm/AkR8AOZRARslBJcfngnlvN3x?=
 =?us-ascii?Q?VwtKiD5WCSF91LFixpRAS8nt1GeW3WUrj2WoHqvmR/WzwVLcn8wu2/jEtS3T?=
 =?us-ascii?Q?uxt0rTXwzmo9MBDbnUWWIVZnm4qFO6QzKPo/+FukesPkcDCUd+I3xTflV8pw?=
 =?us-ascii?Q?IDiLrz/rPlAxsbUF/uUYFtd6lNABm7OwurMpRs32ISAaMNuAbV0BNrBpGlj9?=
 =?us-ascii?Q?KlRYZQ4hn7I2Zt5U/Hby1n86WnPcK2Dq3CNOu7r+AXcAGtK6X6kBKiUFtsxl?=
 =?us-ascii?Q?KOqKSsc4HepfSSZhCtk7pnd4atS1Pv46r2fX3EyzE0qRgpSyDg8J7L9Fo6lk?=
 =?us-ascii?Q?94HCubjcuytR6A7Aj+P2jUS6nJ3JT3DGr12jM2hjrz5pr7KDgx3P1rO1Ryyp?=
 =?us-ascii?Q?/6q1yXMnw9Mq+RVhML3hZOxBIN3FOdUsgdaXiO9eHTZL2cOOt4Gr7eVzgnbh?=
 =?us-ascii?Q?5vwQq+lSqKwnhtKGt5Kfg227TBVbHuVDOqS2FbQT866tglJWg465f5G/meGk?=
 =?us-ascii?Q?HOtNmnM0LYdH6O+ewlt5zL684eATVWq6kHKSvMcmqxruqp33peZQPSbkspYG?=
 =?us-ascii?Q?g6/APDmsM6dIWohBnMjd+oqZHaLi9hP7pW+AAvXUD9faD6T/5LFvV+jRrIAB?=
 =?us-ascii?Q?S1e+TNRXYlkKcFBxCp3QzAkia1wL5NKQggvmWmjW/wnXN4KYJMpT8ubnf9u/?=
 =?us-ascii?Q?GbRDXQ7tav+rvhylSil2DaiGrfWPuVM2wIua/WWwHN78rRcpYa9zqT0+Cows?=
 =?us-ascii?Q?EsMPlHfqTmqbJpUInLflqGnagX6xbCWHGPYLlYTJPdCatzlRrKXaT8feajhZ?=
 =?us-ascii?Q?7u2t1UEeg5fj68Oem32ozKivs0KK4ojhm0zu7EqHLFjoF1juIzJiMiCN1dAN?=
 =?us-ascii?Q?nZJDH9BM7dUAQjhAF8ly8nEgkEq/jgs2VfW4vjIPPgfNZiiu5EtRujSiJkg9?=
 =?us-ascii?Q?M8FrM7WGCAqDITRhh9RYobtPUZ2bIUFMVi6ewbr9qr/7tlb9qiQmztAUbplK?=
 =?us-ascii?Q?v/R0HwyZEomHxVahvB1wi4Y+CHyM1raOzbgFUCl88y+jle9DO3UizfGuOOfA?=
 =?us-ascii?Q?SoC8BMRTQwxOu6wb9A4an8jQ152ip6PTFLqF7FL5JgpR0qUoADYNHfGMdnJP?=
 =?us-ascii?Q?XEhEklhAHMV/iDwsuLcB7DfjM2JDIpZrpDuhVxrf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a57ae0-f942-4cbe-9308-08dd67826dde
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:40:04.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmh12DlBUTs1lgeV079Por+wOh+A93QOD+e73Z7ckA9H7311Kn8SUm0yu4MdXOXG7wt2xFykJoRoNj1STQ1Pag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

Many scx schedulers implement their own hard or soft-affinity rules
to support topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., running certain tasks only in a subset of
CPUs).

Currently, there is no mechanism that allows to use the built-in idle
CPU selection policy to an arbitrary subset of CPUs. As a result,
schedulers often implement their own idle CPU selection policies, which
are typically similar to one another, leading to a lot of code
duplication.

To address this, modify scx_select_cpu_dfl() to accept an arbitrary
cpumask, that can be used by the BPF schedulers to apply the existent
built-in idle CPU selection policy to a subset of allowed CPUs.

With this concept the idle CPU selection policy becomes the following:
 - always prioritize CPUs from fully idle SMT cores (if SMT is enabled),
 - select the same CPU if it's idle and in the allowed CPUs,
 - select an idle CPU within the same LLC, if the LLC cpumask is a
   subset of the allowed CPUs,
 - select an idle CPU within the same node, if the node cpumask is a
   subset of the allowed CPUs,
 - select an idle CPU within the allowed CPUs.

This functionality will be exposed through a dedicated kfunc in a
separate patch.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 110 +++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 41 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index a90d85bce1ccb..faed4f89f95e9 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -49,6 +49,7 @@ static struct scx_idle_cpus **scx_idle_node_masks;
 /*
  * Local per-CPU cpumasks (used to generate temporary idle cpumasks).
  */
+static DEFINE_PER_CPU(cpumask_var_t, local_idle_cpumask);
 static DEFINE_PER_CPU(cpumask_var_t, local_llc_idle_cpumask);
 static DEFINE_PER_CPU(cpumask_var_t, local_numa_idle_cpumask);
 
@@ -397,34 +398,12 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
-static inline bool task_allowed_all_cpus(const struct task_struct *p)
-{
-	return p->nr_cpus_allowed >= num_possible_cpus();
-}
-
 /*
- * Return the subset of @cpus that task @p can use, according to
- * @cpus_allowed, or NULL if none of the CPUs in the @cpus cpumask can be
- * used.
+ * Return true if @p can run on all possible CPUs, false otherwise.
  */
-static const struct cpumask *task_cpumask(const struct task_struct *p,
-					  const struct cpumask *cpus_allowed,
-					  const struct cpumask *cpus,
-					  struct cpumask *local_cpus)
+static inline bool task_affinity_all(const struct task_struct *p)
 {
-	/*
-	 * If the task is allowed to run on all CPUs, simply use the
-	 * architecture's cpumask directly. Otherwise, compute the
-	 * intersection of the architecture's cpumask and the task's
-	 * allowed cpumask.
-	 */
-	if (!cpus || task_allowed_all_cpus(p) || cpumask_subset(cpus, cpus_allowed))
-		return cpus;
-
-	if (cpumask_and(local_cpus, cpus, cpus_allowed))
-		return local_cpus;
-
-	return NULL;
+	return p->nr_cpus_allowed >= num_possible_cpus();
 }
 
 /*
@@ -439,13 +418,15 @@ static const struct cpumask *task_cpumask(const struct task_struct *p,
  *     branch prediction optimizations.
  *
  * 3. Pick a CPU within the same LLC (Last-Level Cache):
- *   - if the above conditions aren't met, pick a CPU that shares the same LLC
- *     to maintain cache locality.
+ *   - if the above conditions aren't met, pick a CPU that shares the same
+ *     LLC, if the LLC domain is a subset of @cpus_allowed, to maintain
+ *     cache locality.
  *
  * 4. Pick a CPU within the same NUMA node, if enabled:
- *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *   - choose a CPU from the same NUMA node, if the node cpumask is a
+ *     subset of @cpus_allowed, to reduce memory access latency.
  *
- * 5. Pick any idle CPU usable by the task.
+ * 5. Pick any idle CPU within the @cpus_allowed domain.
  *
  * Step 3 and 4 are performed only if the system has, respectively,
  * multiple LLCs / multiple NUMA nodes (see scx_selcpu_topo_llc and
@@ -464,9 +445,43 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		       const struct cpumask *cpus_allowed, u64 flags)
 {
 	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
-	int node = scx_cpu_node_if_enabled(prev_cpu);
+	const struct cpumask *allowed = p->cpus_ptr;
+	int node;
 	s32 cpu;
 
+	preempt_disable();
+
+	/*
+	 * Determine the subset of CPUs usable by @p within @cpus_allowed.
+	 */
+	if (cpus_allowed != p->cpus_ptr) {
+		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_idle_cpumask);
+
+		if (task_affinity_all(p)) {
+			allowed = cpus_allowed;
+		} else if (cpumask_and(local_cpus, cpus_allowed, p->cpus_ptr)) {
+			allowed = local_cpus;
+		} else {
+			cpu = -EBUSY;
+			goto out_enable;
+		}
+	}
+
+	/*
+	 * If @prev_cpu is not in the allowed domain, try to assign a new
+	 * arbitrary CPU usable by the task in the allowed domain.
+	 */
+	if (!cpumask_test_cpu(prev_cpu, allowed)) {
+		cpu = cpumask_any_and_distribute(p->cpus_ptr, allowed);
+		if (cpu < nr_cpu_ids) {
+			prev_cpu = cpu;
+		} else {
+			cpu = -EBUSY;
+			goto out_enable;
+		}
+	}
+	node = scx_cpu_node_if_enabled(prev_cpu);
+
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
@@ -475,19 +490,28 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	/*
 	 * Determine the subset of CPUs that the task can use in its
 	 * current LLC and node.
+	 *
+	 * If the task can run on all CPUs, use the node and LLC cpumasks
+	 * directly.
 	 */
 	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
-		numa_cpus = task_cpumask(p, cpus_allowed, numa_span(prev_cpu),
-					 this_cpu_cpumask_var_ptr(local_numa_idle_cpumask));
-		if (cpumask_equal(numa_cpus, cpus_allowed))
-			numa_cpus = NULL;
+		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_numa_idle_cpumask);
+		const struct cpumask *cpus = numa_span(prev_cpu);
+
+		if (allowed == p->cpus_ptr && task_affinity_all(p))
+			numa_cpus = cpus;
+		else if (cpus && cpumask_and(local_cpus, allowed, cpus))
+			numa_cpus = local_cpus;
 	}
 
 	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
-		llc_cpus = task_cpumask(p, cpus_allowed, llc_span(prev_cpu),
-					this_cpu_cpumask_var_ptr(local_llc_idle_cpumask));
-		if (cpumask_equal(llc_cpus, cpus_allowed))
-			llc_cpus = NULL;
+		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_llc_idle_cpumask);
+		const struct cpumask *cpus = llc_span(prev_cpu);
+
+		if (allowed == p->cpus_ptr && task_affinity_all(p))
+			llc_cpus = cpus;
+		else if (cpus && cpumask_and(local_cpus, allowed, cpus))
+			llc_cpus = local_cpus;
 	}
 
 	/*
@@ -525,7 +549,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, cpus_allowed))
+			if (cpumask_test_cpu(cpu, allowed))
 				goto out_unlock;
 		}
 	}
@@ -570,7 +594,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags | SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(allowed, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto out_unlock;
 
@@ -618,12 +642,14 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	 * in prev_cpu's node and proceed to other nodes in order of
 	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
+	cpu = scx_pick_idle_cpu(allowed, node, flags);
 	if (cpu >= 0)
 		goto out_unlock;
 
 out_unlock:
 	rcu_read_unlock();
+out_enable:
+	preempt_enable();
 
 	return cpu;
 }
@@ -655,6 +681,8 @@ void scx_idle_init_masks(void)
 
 	/* Allocate local per-cpu idle cpumasks */
 	for_each_possible_cpu(i) {
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
 		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_llc_idle_cpumask, i),
 					       GFP_KERNEL, cpu_to_node(i)));
 		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
-- 
2.48.1


