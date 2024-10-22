Return-Path: <linux-kernel+bounces-377129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1893E9ABA30
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1ABB23729
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D01CDFC7;
	Tue, 22 Oct 2024 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L0tMwDAw"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B81C3F34
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729640848; cv=fail; b=mHZnIIAGubcAjg5mossmYMyd1a/Bn3JhxRz5BdtyPbKNcTYIkN3PgElllVDSi5zf2TD6FulmfAXZAZ/JkHg8Ry1ms/ZTfnhKBgVSeCgVmb8+CxnjDnao2UJVowPviYqFHzJWc8Ij73DJoxmVdWC9sOjTYm8QRaBTSr0qTitQcnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729640848; c=relaxed/simple;
	bh=l5AA9+Jli1cEAGn+CrIjlC6EsFWlLoVR8EYC74jtUIk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hXHbPsOEU5MkYPTzHhzxkPeznwMKr70TbUSimYxgKQ1h8jAoebo9YAvorGks2rad+fOXWwU18xDi2QcpsHEktUOt2OAMw77z8JubDsDNqF7DyD8BsLlkM5fm3AT7GlhBIV2d8pMvdBowHYdekojae9AE+b3wQAj0MOmxvrWH1p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L0tMwDAw; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4UK50eK9w6qkPeRH1gO4mouaK3XY5iYffLh/+de3fvo+HJOv77OLExg6ImSony+eHtvvDJXEhHM9qM7kTQhdkprssCDJFJTWKYrX5hskUDQUvzJYif/S+p5Gf7Oul1l80/ySv/8N9LWQyWLe3AJOEnTzmsYj8Hx3Md7zPA62zedjnrW3toREAbKNCX9Rv4O3ZFxUP3/LGFfJA/evYlTKqnXSXVHbdDvF3GKPkjAaoeghR0rSpkcMKR0cuy/EhBdI4W69GTFT2CwyNsVe8hvTzBy/yLPYUILOUw7L+D52SR/Du1r6N4Cq4nmSEYg9gujo9oyKgrZEH/K/w/ZPg3Cvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI28bTKK3dB+9oDfhqJpgFSEomvGFy2IRO+kd7JU1Gg=;
 b=wbX3GVchlPytrwZ3PS7FntZPWM4jaoD1I4mdberIY+eu3DK5qz3pNK3Ek94unXqqVu2t00em6WPMG7MRKI6VQUaajt99/rSQsds3Ag4J9QkuNLwjTPsANXaHgLts6M9aWl/Og2rjbPybDVw6oqXWMG8p7dDe4Ow2VcLHfrx6x67cHnQZIVmmlR2zYRLkSR8zkLWLcmHdUHrKmKSGfaqRmbsYagQ/0BXitkYjMvMwgh3ljoNnPNeEh998JP8uLJMNQAm/r+VWHSfRreqz723GmCt1UAPNq/3V0dViXkTYpgRLn/RGuABzCcaSdvtJSsBGOlub9YbB5Au7VSXlszsfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI28bTKK3dB+9oDfhqJpgFSEomvGFy2IRO+kd7JU1Gg=;
 b=L0tMwDAwHY1+Nh/YLAh3vgKQOAJ5ybRfcMaOtIwWHbYubYuhIOCgSDe25bXsjXajciw11/oJS2LZbpBl7fstZfhc8TA23IYyRY/l69NuKHgu54a2Gc/m78nYnD4wXGk3sZAmA4l4qCmCbasbVmalojtS1uFNv17V+M1y72+g+cxdnqC4Mel/d787PUeQWiv7ry9lFuFuABPf53tfJlzsmfNxWgRhU2keyWyznCm2EW7JUQwC9gUzTpnuuMLudTS6/MbvXKihU0JXo9RbVRmBnpse0OAinISxkgFgufBFkPYdxM6KOY5RaE9AgAlFFRHL/GTzAISyOzhmxW/HPtIXsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 23:47:23 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 23:47:23 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3] sched_ext: Introduce LLC awareness to the default idle selection policy
Date: Wed, 23 Oct 2024 01:47:18 +0200
Message-ID: <20241022234718.63258-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 91300ef0-a2c2-4f39-5bf8-08dcf2f3dfe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swFBIPC/of3Jz7JyuLQKbBULn4A40VsFzLY9e2P2TF49hRA2q1Yor8a6raq1?=
 =?us-ascii?Q?Bo0MaXhBQzM0Pc1xI7COlXULDJha+TALOsyz3RxSciFAyt7tG7dilob2NEkl?=
 =?us-ascii?Q?DxCwfCLH6+X4Gt1b3KWwi27T4x4+17/d4RijOuRLdiCyixpzVetgtUHLwySu?=
 =?us-ascii?Q?/XMhpU83E9wYQYZTPftsZb8OxMYsEXZV/o8BJXrVD73wYKQQX6Sg27Tk9Nlz?=
 =?us-ascii?Q?u6ewGznqabH9SfMCr42njxmGSZUaiWM9zFvsSj+MJ9LhfgFjxkyB+w+aKiRW?=
 =?us-ascii?Q?WcALAsdUSteMGW+oAa7Cs+B3KVZzjZDzC4hRoD/Ab8yDDJERylTzWEnN9DAn?=
 =?us-ascii?Q?PLhf0dw5xOGzdRkjJgTZAATo5u72QENg1arWep3P2A0sxKL6UhJ9KcUc2w2Q?=
 =?us-ascii?Q?zN5AqJJbFTPrcdmLK2oHux0BxOGpyg3w0dRH1YjQT3gw+VuLwh94kGhD2Uu+?=
 =?us-ascii?Q?XLJ1Ds8zMag1GzjKgzk3g7pBHYCNS4ZhvheGKTpPP0TMwrjEJFQgId3ECmkh?=
 =?us-ascii?Q?lbyAoQpEgYEC0ysTjW98xaC74S7HAAe0HjL8f6PnnLHXHB/5aqbzDL4MMAAm?=
 =?us-ascii?Q?lwJRXUdxATM21d7wX2BOGJyPhaII0Qr/1Mp5J2AysfnFltaTsW6zXq23cfp3?=
 =?us-ascii?Q?KkAjhjno9BAz3+gntEBKLMfcPq9+EJh6n30XYrVko8OM+v3WmsCLBR6ckIlK?=
 =?us-ascii?Q?MXF4PxicyfBNnPe6xA64R1zae+e2LzDETuU95p65N53vpPFEkE7dhcijDp/v?=
 =?us-ascii?Q?V+R66tysZpKbpN8H4z1rxP2Itp7DCZgXasNFOPlM+A5n4JYsl/ZX3ZczoiIO?=
 =?us-ascii?Q?Y31PPILs6e5T1sW+PhYfrYQxdHM6njdK6yCLEnByqvXKVC9u2ouVVirM9+AD?=
 =?us-ascii?Q?Q+r6TqVf4gxuQgLz3UXjK11ofWQpEZqzVDPbHYwMccCvWvi+my+HUj7s/zCp?=
 =?us-ascii?Q?nkJ9ZGGYBA9m4CyZZ/lAnSrZG1slFik7NnWBXngKecSaclCyf1+4QXEySVuy?=
 =?us-ascii?Q?FcaN9uoCnLqwVxKrWhsK95Drr+fL7Ya2OHDIKPRJvntgb9MC6ZelfjCeYUWl?=
 =?us-ascii?Q?GMTE2c4SLyydPp/l4NH4r0U3Wy+UKmkceI6w6BCv4sgi0bMyoFqBfgP8tvIl?=
 =?us-ascii?Q?Bl6BCAMfHhh1ZrSoS4xLqZEYOYHIbwB+NC36amHjqxZg2iGcfrdrVFgSFFZu?=
 =?us-ascii?Q?iQoULTZd4/tcoTnWjrt898pQQ5b9y8fAV7RVewuWa+ySx9YBobj3uSt0phpn?=
 =?us-ascii?Q?t+WCX5ve2SFYF6M/OTASBR8gcaCHfaR9Zag4ldXge8TyirDT5M5OWMn00s1R?=
 =?us-ascii?Q?eLHQAAihePR3d4e9llegaakP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YeXk3qsQ7ADHFWAj4x+HYBrbLGA46TUCWbhYM/OnbbiwZ/ZpeNiUs8LAXNGx?=
 =?us-ascii?Q?jTaFc5ngaxH1KP0/T5XKJvM67TkEiEIdgMfG48Njpj2ivuPxnZVm1WqsRjmy?=
 =?us-ascii?Q?Ch0tZGr0Haqdd5Zn+dT+F2otZ+huaNnwiV3mIb3u9rtyo/Gi6TmdV+JTMSAE?=
 =?us-ascii?Q?QaIwL7+FzWsHsKI7FeOE0PmWeNy7O6NIVxg5F0tg3nluOYoVpYICoYNQ2JVN?=
 =?us-ascii?Q?JA9c4YWxcYiT0IF8mk72H5p0M4qhH3hNB1E1KYyLthij/iOsoD3zfKvRTLe2?=
 =?us-ascii?Q?sRFta3XGunzYCRXoIRLLCo9vYAasTNJfOlTgKbvGeaLrYaZbEMj93Zr0vLUi?=
 =?us-ascii?Q?Mh4GEg1kuOmENMa2cURvHYmljFCQ4FYm+EuHX/mt0WsH+/9LFLd0Vyx0ym0N?=
 =?us-ascii?Q?6ciRDoy+lICHMQVLWG1GGJiXV55JKIl6LAP8NQfd2gfcchfL0g1LskZLT2Wv?=
 =?us-ascii?Q?fuQDbHo3pThNbOV6qjLJ6t47VxYx835DgiTrsWw3vegkDzcdMFgI+th6fxjX?=
 =?us-ascii?Q?ZoeFlQ/Rb2ob7GS2Kt6G+o6f+rdguI3NE5ZKhqd63b22h+5br0zMbyqnMIla?=
 =?us-ascii?Q?d+dwo0ZQ1KewrO02u6RqOG+QpyKFpG1Ao5i4EJ6SKVPKdwwCuv1+EnuIpB0Q?=
 =?us-ascii?Q?ye0BJcA2m/zox0VZ30Vt5WaRD08iqb6Gzae2+VVo6tsofE5j2h6+G+iFHnD+?=
 =?us-ascii?Q?y5GUy617M7+ILAvSwezvBOSz9WuaVrqYCmoE4tpdoQU1/yuIk2p05felH5r4?=
 =?us-ascii?Q?V7cHgGCpJ8Izbbd9JRzVWDEBxL1lDSZ5xw+Gw/IKnb6DnGlrXFyhiXZbwxHQ?=
 =?us-ascii?Q?qd/9ADxEQkFGOUjsjTwnCmgoBwmQNa3Xn0e5rNzb3Znhu29StlN8VlprHGQ3?=
 =?us-ascii?Q?pTFGY2DNhtIPdm0UcLcpdw/frugwB2AdfWtDNuqdxh2sY/05U1900MdV58BK?=
 =?us-ascii?Q?44T+izAPV2Yy08nZPPkuqGYRXmqpkgWBTpMqCpMtwi9gVfCoQSNPJTHVfUYs?=
 =?us-ascii?Q?HJvJlxEYtBjx9UnRdDZBdGXZTGWvflyUkFjNxOSgjXT2LipZRZcSVHJyZxie?=
 =?us-ascii?Q?jOvu/JKdRgDtkGb0IKSwai5gVxxTvEG5FeGdQMNyRUtgz/ukoERpIozde0+y?=
 =?us-ascii?Q?cH73ty3yfv1b60j5Wjx46+pTqxVon1ZExzcKGWAQ8xPnzwWuP4ozenoFhTdP?=
 =?us-ascii?Q?omi/tWe++HurDfImU8CZsLPzPty8UzAjvoU1+5x+IfTrsr2bYwp1DqHbiuHc?=
 =?us-ascii?Q?GkSrE5tB26BKYOZw03y9POvr3tOdnRBYH2OBIT24wAv5ykgmgxx1Rkx+YKbT?=
 =?us-ascii?Q?O1M8xI4X+tlc1SvCfmKX3u31jBg9bQNxCVLREccDX6P2Ovf4RdxWg9uduCMx?=
 =?us-ascii?Q?qmRZFY07wScB765rD8Dw6rrNufBV1V2jHLjtpov41oPoY+jYATDxrRlINQtx?=
 =?us-ascii?Q?wZ15ITyb9+EDp8FeSiEJ548H28ouRm90oMETYcPDr0psnD3beQIiKcs1HZDZ?=
 =?us-ascii?Q?JDXKuJpSiK6cKl+PlMqzhnK2XcxuT6+AMLfqVsRTpoQgdRHPOspftGlDxwHw?=
 =?us-ascii?Q?am3lZY0vJAXrc5OsWxrQ3+HZ7HH/EhAzJWz5+Q+x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91300ef0-a2c2-4f39-5bf8-08dcf2f3dfe8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 23:47:22.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbgK9m7ClK5TOiovoYOnVB2EydvMsVGNP6riN1JtrR11O76Lx+1O8Pqwj1ZUr+hM28ZbmcrXVhIe3xfT3g8Btw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080

Rely on the scheduler topology information to implement basic LLC
awareness in the sched_ext build-in idle selection policy.

This allows schedulers using the built-in policy to make more informed
decisions when selecting an idle CPU in systems with multiple LLCs, such
as NUMA systems or chiplet-based architectures, and it helps keep tasks
within the same LLC domain, thereby improving cache locality.

For efficiency, LLC awareness is applied only to tasks that can run on
all the CPUs in the system for now. If a task's affinity is modified
from user space, it's the responsibility of user space to choose the
appropriate optimized scheduling domain.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

ChangeLog v2 -> v3:
  - skip LLC-aware idle picking if not all CPUs are allowed by the task
    and get rid of the expensive cpumask ops
  - add a comment to clarify that ops.select_cpu() is never called with
    per-CPU tasks

ChangeLog v1 -> v2:
  - get rid of expensive cpumask_copy()
  - depend on CONFIG_SCHED_MC (there is no point enabling llc awareness
    if the kernel doesn't keep track of llc information)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a13a6461a290..34a20cdcec5d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3119,9 +3119,39 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+#ifdef CONFIG_SCHED_MC
+/*
+ * Return the cpumask of CPUs usable by task @p in the same LLC domain of @cpu,
+ * or NULL if the LLC domain cannot be determined.
+ */
+static const struct cpumask *llc_domain(const struct task_struct *p, s32 cpu)
+{
+	struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	const struct cpumask *llc_cpus = sd ? sched_domain_span(sd) : NULL;
+
+	/*
+	 * Return the LLC domain only if the task is allowed to run on all
+	 * CPUs.
+	 */
+	return p->nr_cpus_allowed == nr_cpu_ids ? llc_cpus : NULL;
+}
+#else /* CONFIG_SCHED_MC */
+static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
+{
+	return NULL;
+}
+#endif /* CONFIG_SCHED_MC */
+
+/*
+ * Built-in cpu idle selection policy.
+ *
+ * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
+ * we never call ops.select_cpu() for them, see select_task_rq().
+ */
 static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
+	const struct cpumask *llc_cpus = llc_domain(p, prev_cpu);
 	s32 cpu;
 
 	*found = false;
@@ -3173,22 +3203,52 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * partially idle @prev_cpu.
 	 */
 	if (sched_smt_active()) {
+		/*
+		 * Keep using @prev_cpu if it's part of a fully idle core.
+		 */
 		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
 		    test_and_clear_cpu_idle(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
 		}
 
+		/*
+		 * Search for any fully idle core in the same LLC domain.
+		 */
+		if (llc_cpus) {
+			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
+
+		/*
+		 * Search for any full idle core usable by the task.
+		 */
 		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
 
+	/*
+	 * Use @prev_cpu if it's idle.
+	 */
 	if (test_and_clear_cpu_idle(prev_cpu)) {
 		cpu = prev_cpu;
 		goto cpu_found;
 	}
 
+	/*
+	 * Search for any idle CPU in the same LLC domain.
+	 */
+	if (llc_cpus) {
+		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
+	/*
+	 * Search for any idle CPU usable by the task.
+	 */
 	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
 	if (cpu >= 0)
 		goto cpu_found;
-- 
2.47.0


