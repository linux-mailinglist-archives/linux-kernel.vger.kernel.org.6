Return-Path: <linux-kernel+bounces-438531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A698C9EA25C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D9518837E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D31A073F;
	Mon,  9 Dec 2024 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C9GLxyTB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE51A0711
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785390; cv=fail; b=fbjgRqnzEYa52sI2c3krVgxXiNR5kYj9J0CJh2Ih/OTVsp47NM8lCj5+R8FNGzdNTUi8GHHTtRjAufrgy9Nhy4lYkL5sYRBuPUR31iSqJjO+y41tj0QQz5Ypj0luh3EAoWQnHo5ycoH1RLaWTEbh/j+IS+0B2mG41qtiJwJwsgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785390; c=relaxed/simple;
	bh=AWeAK2Nqf03Wf85mY56GeR5fiQGTRuLYTUT9hLaYvFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXK51rRKPZULpcgIHMwlDdwfd6FN10pCGgzVF2rj2kdRaE0C/+n4OD8moppXfbluRo3JZzwcHLztTYJpFXcpxxjXYOm8SejSGZpMjwlMx3tjjZQcBv/LrDBHMtD2fR1+X7XWCW6JO/Sz8Y38oA2hahqBFe86iPQ0g9j/bdOu+EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C9GLxyTB; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbftIRvOEPwS6LmU+rUm0pfflOE2roywl9nonwpFyZL6wtH0u03Wx2qhFhtU/h0dmIcbKRYpJ1KTFu4lfmZe/ZZfrJuWc8x2OFoVklYl6amRp9XIhfxMFVvGT9UJZcjVIEWPB9tLgD0yhgnsbokfy+v29v0CklMT6LGXSoPCFl5AuHX0PJ1LID313IA3GkBvXW58QbB4huve47N3pUDaRZ6/rRPqfC1CyhdcZEmznjpZyBYKGRm/IK/nqtOFktcoTeF9bdmqKHhxYAz3Kk+DKtIaMvft5Om30JMO0KL5pxGdtFs5kcUtyzpqh1MsFM2cleT+az11kSAV8zb/vQS7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9yQKrO1aLKTfNKEGYnqBFEIsxR48WwNqg8p+Mfetu0=;
 b=DaDPVV4JJFtQty9CGZ3199hsqNlTM41Pc73B0Dr+zknw7isJ7suJr1Fay9lVzCn7QO2ya3L52Ppuj+gdbryyNh3HQZuTDyTkEEK+VCOVTvjagGoHnUE4395nyVY+EM8nMlAgxD4qtUZC+OSS8qDsKsrla0ovrQXvLa0g0AKRedwGhYMlVeH6Si5e8K+F8R93sLo9gtxf/qh9NKKla0smUw/DPZhQUhrSUQrA5V0I+MDHUBMY2fbA0J3tYrb3jyGwbWXQUz7e/uugC6R/B3goNhhVAul8ks0vUWRkg8bm8h4S+QQtd3aTRC0mN0sjx+TMWcCGxiVGFFn2AN5kG5OpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9yQKrO1aLKTfNKEGYnqBFEIsxR48WwNqg8p+Mfetu0=;
 b=C9GLxyTBFOjeoREaNzt+XUp78jDC/aqFFOsHU5vqJwz2UflD6GLS9/yq9M6ncy2KdHzug71wPTVzpqjKzVAk1HZKr46h6LRnaqnTzwTEQFsQ5cqt+QaoEI8uHvFawkNYa77R5PzNurl4gHqLjGB13iGrsy+E+trrTMRJYp1ysA/ybWXQfpTy+suZCzAeYY68LqR4VI66hijV4a4cGfJlBe2LbttwSPMctagZ6v0IUHujG9G+bpKoWKIrL1rd+en1ygkTw4UTwE5ktTeCwyYAV5guORhr3dYvnSseZ0WiAzPli9OK5DReG+lGuXiK6sNH5sqtOCMWR2395hOtZgsXLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 23:03:05 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:03:05 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] sched_ext: Use SCX_OPS_NODE_BUILTIN_IDLE
Date: Mon,  9 Dec 2024 23:56:28 +0100
Message-ID: <20241209230242.775225-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209230242.775225-1-arighi@nvidia.com>
References: <20241209230242.775225-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8c7eae-f6bc-44cd-e0de-08dd18a5a376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NsarlPtyCa2gtc7qAW2bmEVzUAlUm/T83D+P9+pqt5INFJAVUUQdrY077zJ/?=
 =?us-ascii?Q?8gDSZAMCCoqBCeCVjLQc6aj85Z1Pfdid5PKKUxwHBr8TobhQKqnWhwuzkBNz?=
 =?us-ascii?Q?6TweqSYclDckpXABmI9+kLax/bXMHHRD+XaeirvCYmmXPOnDcRU8oOr/O2Ly?=
 =?us-ascii?Q?XCnpjuHcdyZX67rXqMeYhLkVS++thO7GZEWKUtbS8Py3t52k+aLrvptv357n?=
 =?us-ascii?Q?qjGgBeekJT28M9jqM9ib70ApDQRL4895EOKIoOKW51HRlNuFhLoz3W+zSuGL?=
 =?us-ascii?Q?w8adDJo6KFavp6cXiVfvYjiWBZOlxdIxRyLjd4ruCH2o1vSJYdanadr3ClRu?=
 =?us-ascii?Q?a8bDGgtOZ4jvpJFUsuMAZ/Q17F/bQxN3XqO89Z+pYZTN4aKOAC5nstlX8rlw?=
 =?us-ascii?Q?wXhGUHzQh1C0R1PzE1/6yu5y46+bwFO6N5jYYF+ufbYiKDRV/9+MM7chhHqq?=
 =?us-ascii?Q?s4a6vlioDGtpwMThXPkFfMCKP6qtAmTy3178jvpbONkixdC2U7u0bpOy+RMd?=
 =?us-ascii?Q?KqvlmImWBzNSh/FpvTVg9QO/vmiUgN69KNEjoNblq713KPbEnP+ryAXFkrei?=
 =?us-ascii?Q?meGH8dWpb060CbxiNdknQbTKQwS0n+pbDgnJihAG5HY3ePn3Us0GPCX5Q9wD?=
 =?us-ascii?Q?EmmyjwrV5uVmSFZiB81zPbDoMcMtuhGCf2l95DfHJsFtsp9tQD0geG/mxwlP?=
 =?us-ascii?Q?tD/h0UoH3rz2spyh8o/LgASlgXcZ3MCpR1vdJJ3S7GiDUZoFS2e+SsL5ix5M?=
 =?us-ascii?Q?ZIcw1EQaQ9GDxHc9wcapq37dVU5wHdoMBA9BQuhITGKtSPNexpmhXG5b/M+0?=
 =?us-ascii?Q?6rK/s4fXcl37KWHpXdAmjHEwdwTPyJQJT3NNksAbKsXzHXRFTBFxIH0i0pv4?=
 =?us-ascii?Q?c7p4YK1z0S8PjgR72AVH2ofl/mbu+msojvp81evb+WUj3XLCBB6b6Y9JoOUQ?=
 =?us-ascii?Q?lYkt7N+GgF3KSgMpLr30Z+W/E5gtCLqHfqsxt/XVwaAQHUyn8i7yVN+/n6t8?=
 =?us-ascii?Q?ULtiqJuAUjtLaa5kvNZ/u9jk4A0CjI8eDL8WYnBXtUAilPB1ZAx/TjFWVuIP?=
 =?us-ascii?Q?CXDgTDCZv3LqBJ53LSqkv/dMfKqJsAc1OgvKB9FEiz4fmW4S7u6EszTyybgJ?=
 =?us-ascii?Q?qBlnkWdPA3ctJkWoSfxqlkSqFd0klKfgwrGxIX/vB+xhTDE4F6yl61dXV601?=
 =?us-ascii?Q?3hn5g3K5B59OSGBq7rvFb6TZLnLPV+xZfOhkDHXKkGGZbNq9/YOAfaGVfi5W?=
 =?us-ascii?Q?l5JYtDuQMJf4ZDL8eoVwT+i2IXSptp6hqhX6tqQv1B3mPE9U2EteHmFY9Dr/?=
 =?us-ascii?Q?V+Vf/aCPQic2RfWztpWNtcC3i62ewfCEtVm1QM56PNkXwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5H5fiHO07avGRRO7lb9FTZChVneSno9rvh5cPh5evdspEjFh2qGzPcOIN7zC?=
 =?us-ascii?Q?k6D3UN2aJmyzeDnO9Q8VQz+HMS4lmt77pmQ09rK/VKQpCDcBx7WvRwibotds?=
 =?us-ascii?Q?cb6KuEQjHMF7wSx63A+woKBDjWF34t2N3rJ6UiIuFmo2a1kyI7p2R6L2FtVd?=
 =?us-ascii?Q?Hz95W3iTveFd2cuUWY8lCb31luhj3XdED/21y4v6VMrVz7k7FTcAtaYay8F2?=
 =?us-ascii?Q?DkCfZoceX6BNz28YT5MVj2pY5I5GfUnwQmkH4COUAZuGgqS+8rTsoNf2AZBq?=
 =?us-ascii?Q?vijQzlnIiPL1b/d1uGjHeOSQEQB65CMIaY7K0GCS2EV6/lpCZWUcdVaZWGu4?=
 =?us-ascii?Q?pUlnNalufo54lx05t+jRds4VFRMMpI90g56a/SwmpqsPnrMv8iBVo8zEwvcW?=
 =?us-ascii?Q?AODQpbKDXTfAAP9yS5KMAwAUoF54VZTmKtbtgTpGJquDVeZY3laYfhOH6kfL?=
 =?us-ascii?Q?hxhKx3QxFhyG6oMhcUB//fa0RCWlnU8myeZOpNS9c/2wl4+bBY2lbL6c7zUS?=
 =?us-ascii?Q?vtJYulZWVNwz1II+OJkYSjYKJBUDH8xAKIh54KsK+0XSgOtxvQN1V9YO9GX5?=
 =?us-ascii?Q?XqvVMAjIP2vs8tFCuolBqjUsLaBgPtwdKAHCg9d0btN45jVPwZDtmGu2psS4?=
 =?us-ascii?Q?ML/pxwtsmChZrJpYzL6QUW11z5b/Thq5dzt5IAz8CIKeDugcrwDIdGOpQTVB?=
 =?us-ascii?Q?e9oj3gwyIygeUJpRlod3wrMIfTyxbBUllXSf2boLxzNAjzMRGiupi6SGBV/C?=
 =?us-ascii?Q?Qe28gcl/3Re5YQcUswR5FuQw6SeyaOgIgoNmxPkxUCvzyFHQqF2kegJe0srQ?=
 =?us-ascii?Q?v1Nrj4ZCHSCsFxUNCGMu/GSsR/GV6Qmrk2PHQ4RBkqGPqcHy8RQp/M78opxt?=
 =?us-ascii?Q?/v6bUoXPi6en2zyCPlE828O7opmQHwdoxsBTJ5Eku9e6Gs+3N9a8oL9fW34w?=
 =?us-ascii?Q?AvirxVi3F2pPxrnn6UrCL6i0Ev1C3AQ95qfN6K8T3RBgLDlCqowxmchW0Wbk?=
 =?us-ascii?Q?9tKglaUDXUsBZAdM86S1exNNPaTxgVegvX3sYGvTQwne3uajK0MNKFBlXKt6?=
 =?us-ascii?Q?kMiH7/8fpuG+BU9NO6V1XQ+qFRXwGzYBoJgngdKIR8M60jNGLTdnhLLw9tnl?=
 =?us-ascii?Q?QOEibpUFWmuMJSccMZgZsFGObUf5gc5Y76ffLVudW3ZOK0osiCHkoQyxqkVJ?=
 =?us-ascii?Q?hmNC/c5cJ1JsUWgTys/XAwkFW1/tL6DJ8prk8ibyJG8DqZiPMHEwNTAbrR9u?=
 =?us-ascii?Q?9P3XkGZpBGJCrMK/o1UwcTYf+8K3eUFclPdOdM4U8PEVvxDtGRsFOVkXaPDU?=
 =?us-ascii?Q?RKEGbD/iFmWhVy7q32KFwG7lyXvpe6l8Re8tpRSTGY8KZo16T2JA4JuQ4jur?=
 =?us-ascii?Q?jRANlajMN2ALbODWyvS29OggmuxQS1rD8pYu3diQijCIpGejR+2lkdrVgyv5?=
 =?us-ascii?Q?iDl3BuDvOJZd1j6CZhpOZvmGE/dn6F/wrHQGTJVB968z30z+HMMyKDRXrvDF?=
 =?us-ascii?Q?6xtQMaTjrXGU/cyw/W52Nith5CNZiLQMDIk0hydV7wuIpT2czTudUO6m3mxM?=
 =?us-ascii?Q?Rd90vh//sbEHIEuQbivhYLZs6U8gtr8677GgBKUg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8c7eae-f6bc-44cd-e0de-08dd18a5a376
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:03:04.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5XmApUg/BkIKfAAg7GTQoOUj6j8lFSa1TOvvrjbJzyRllVs8oV+IhyBNSN+9eaOq6ZuloKVlnYx8mTHhUopzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

Use the new SCX_OPS_NODE_BUILTIN_IDLE flat to allow each scx scheduler
to choose between a flat idle cpumask and multiple per-node cpumasks.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 49 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a07a76c08f81..d0d57323bcfc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -893,6 +893,7 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 #endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -936,18 +937,32 @@ static struct delayed_work scx_watchdog_work;
 #define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
 #endif
 
-static struct {
+struct idle_cpumask {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} **idle_masks CL_ALIGNED_IF_ONSTACK;
+};
+
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
+ * from node 0 is used to track all idle CPUs system-wide.
+ */
+static struct idle_cpumask **idle_masks CL_ALIGNED_IF_ONSTACK;
 
 static struct cpumask *get_idle_cpumask_node(int node)
 {
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return idle_masks[0]->cpu;
+
 	return idle_masks[node]->cpu;
 }
 
 static struct cpumask *get_idle_smtmask_node(int node)
 {
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return idle_masks[0]->smt;
+
 	return idle_masks[node]->smt;
 }
 
@@ -3430,7 +3445,7 @@ static bool llc_numa_mismatch(void)
  * CPU belongs to a single LLC domain, and that each LLC domain is entirely
  * contained within a single NUMA node.
  */
-static void update_selcpu_topology(void)
+static void update_selcpu_topology(struct sched_ext_ops *ops)
 {
 	bool enable_llc = false;
 	unsigned int nr_cpus;
@@ -3449,8 +3464,16 @@ static void update_selcpu_topology(void)
 	rcu_read_lock();
 	nr_cpus = llc_weight(cpu);
 	if (nr_cpus > 0) {
-		if ((nr_cpus < num_online_cpus()) && llc_numa_mismatch())
+		if (nr_cpus < num_online_cpus())
 			enable_llc = true;
+		/*
+		 * No need to enable LLC optimization if the LLC domains are
+		 * perfectly overlapping with the NUMA domains when per-node
+		 * cpumasks are enabled.
+		 */
+		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+		    !llc_numa_mismatch())
+			enable_llc = false;
 		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
 			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
 	}
@@ -3463,6 +3486,14 @@ static void update_selcpu_topology(void)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
 	else
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
+
+	/*
+	 * Check if we need to enable per-node cpumasks.
+	 */
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 }
 
 /*
@@ -3690,6 +3721,12 @@ static void reset_idle_masks(void)
 {
 	int node;
 
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		cpumask_copy(get_idle_cpumask_node(0), cpu_online_mask);
+		cpumask_copy(get_idle_smtmask_node(0), cpu_online_mask);
+		return;
+	}
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
@@ -3747,7 +3784,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	atomic_long_inc(&scx_hotplug_seq);
 
 	if (scx_enabled())
-		update_selcpu_topology();
+		update_selcpu_topology(&scx_ops);
 
 	if (online && SCX_HAS_OP(cpu_online))
 		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
@@ -5625,7 +5662,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	check_hotplug_seq(ops);
 #ifdef CONFIG_SMP
-	update_selcpu_topology();
+	update_selcpu_topology(ops);
 #endif
 	cpus_read_unlock();
 
-- 
2.47.1


