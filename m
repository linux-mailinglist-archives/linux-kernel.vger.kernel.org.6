Return-Path: <linux-kernel+bounces-376079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CA39A9FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F981F227BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E331199EA2;
	Tue, 22 Oct 2024 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PudrKM9j"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D11993AD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592071; cv=fail; b=F/EW2B6I3qloX+e3GQlYqAfPrXJAQNsVJqwUhmfq2Me3LKTdE4JVb0wH3Mt6iwMf5JA48XpbLq/tuCH0W4/aGWbXcIqeUybTAh2jD5K+zJqLJ7dXbLsx+Af4xbArjOrmGmLD863/EUu8gQy9Ycxt2tSDpuVoX1qnflqOMNrc9qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592071; c=relaxed/simple;
	bh=zpTl0ic+x3fMU8Mzek125plxCnw0N0hPv3O0o+ftof8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M7sk5spUJe31hizJnGas6TKBI3qwOl6E323eCjjpIGe1K9wFY/hh7y6e5B9/cklIAYBObkKiNrSigoIdSqTkmFyi8fDkSoFhPMT3LFu5mqClgchPU0f/YWXz184KSsp5QeDNyMReMPGa/0uKUnT4Acd/Fx5d4XOkbv66iyLOdHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PudrKM9j; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMlqbdHtSQ3lc23pOO/jjgknb59pPpHflkeDS/MX6JE1J8T/KgE0wkGRgo0/RIjzWRzCiEbBXvJPIINZKS7RvZSLtDgdlTTwiTJFte6QyotIbXBdsCxd1xXS0tdyJxmENfJZ2l4KVcZl9RiXXXiSvb0SAi99bW2BYSWMRyanvP5dBMa14OxjhGxlId/lnIqx1pW9o6dFiWAEVTWi3yXqJPNyiMMBoRzViDt2o0oW/a6lzG6SFa8ycITUWKtIrzo8QT2R6TJnvf9zZBUXMwGLZdYFc1ARd4ShPUvUcfrmJiLwu3uVUmPRKNhu4tK2+YtlnCfzg+TKojF+jkGP/PbQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/tnU3iMiN697uFqRdeFJxoDC/m0fTJKt/YJfCaexlg=;
 b=Qqfu4e46G2W17or4aDx8I16vfZ9tjjSM7uuXZuVFQicBjObsc7FRNzhcoa041PiMemGlj7xKctiIuA64lTz+LHArjMVEArPvcSsxQDICsCNUQBQ3d3JO3SVIi2Gpt1+SWKQGOrQUC5wId/asWAEb6P8pu8eurLxwXca8FVrFS0cN5EtQZ5wwn+jECGgwlbSwjIF4HptxT+jEAQcTZMSBuqtaAWfDb50yB4rqeah3yQOnv5Va71nxbDqvYnsOz0PuCTcykUg3ckYJ5K209/8C+KY9I1Fxtxnr/kqBZX5FoFRXMrwWM79eUUFztcppJ/BIGIn5R5lqjdmDvj6ok8MYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/tnU3iMiN697uFqRdeFJxoDC/m0fTJKt/YJfCaexlg=;
 b=PudrKM9jAQCx12vYupZOHqLKcFvdo/XKDEq4N2S8gWJ5OnToGDuCS6D6LKaUaou3yrsmK+o5UbmRFVJr0xhvhXgi7m4EZJ498BpVj+fGOOHZB5M4RTYUuCGtT0QP9j5LtbLUbgw2skSaDDJMbTw5t45ZPcEe1S3q5nXXMd23+g7N3v9Nb56y0VSA5XaVxBRdLspeDdenKiPoRtZKtka3f8ckzdV0dCdCUQ3QgPz9uNcDAqX0uKEAaTygDnJ81YmRMfc/79yBC8bB4fNhCmDmh5f4f3wchR/ut34uUmaQUvBGYEZ5txXTY9uvHX9tZmL3ZXlKGo4E19yfpr1mkbT42A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 10:14:26 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 10:14:26 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: Introduce LLC awareness to the default idle selection policy
Date: Tue, 22 Oct 2024 12:14:22 +0200
Message-ID: <20241022101422.212810-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aec41de-00a3-4044-1e24-08dcf2824ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fB/c4Xz5Z+jZxxc5JhC2uk+7R+ShYx02XtGxx02MB2/FOHqDiE/5v66Aqklz?=
 =?us-ascii?Q?/e0kOGdsxYbFMcXOyRM7HeTW7MzBBIidshkdIbOCcOOYf7DkqpASWpx1VSR/?=
 =?us-ascii?Q?gR0rsF/MgUqStn927cWAhZ/93Fq8AcEiFaRKPHZH4Or1uCi+PHqF+iC7Hu8X?=
 =?us-ascii?Q?WVIvIABixkp1LhMS+aviBQs7s2tYalTlw6t771XSzxMxEEh/ILY7CC+Vaslk?=
 =?us-ascii?Q?hd66RDjpO/jj9yfieowE2i94Bkh+1omCGY/rmxwJ6d5lQ0hBePsiiq6rnyi6?=
 =?us-ascii?Q?7uLnqilEWeycdREEkrERmYz1fl3SeuapRRli24vE4It/K+LPMskLynQ3MpcO?=
 =?us-ascii?Q?yZzHyjzDbVeoNneq6uU1LdM3eBpYE0iJ6ec04EUmySWlCEOSnQRmefb+XeZf?=
 =?us-ascii?Q?29kwu1EVSneM6biFk4YBR0nqsNeQoLmIZfW5Bj+aiBJQ7/rVq56DmJ347cal?=
 =?us-ascii?Q?hxGPomU+wucZICUlDoX8HwrQ2Y4KY+aTeDj/EC5okANk68wtWBdJNN9I8g4f?=
 =?us-ascii?Q?gmRMLqW5AbVyQ8n1zS3/EY6Tq7kHaNZ2NBz5j+E3KwWFVnYvkKKJmArZZcr6?=
 =?us-ascii?Q?s/7VeekOIK2uDYn1bbeq1fE9EjOwQo1QeUhr2xKPzqON3dCYhRGUMElmzmqj?=
 =?us-ascii?Q?7QsNuUL4+4bVjOTzPXzkEhOvn83jdjPiNQt5zNhr5eGw6CCahdcpnX0MOryL?=
 =?us-ascii?Q?H/opBXcVdVMMQxFY/1WBcWyx1UWiJCKpbx6tlg3uCYZRX1bAvDWqZT4E5LUt?=
 =?us-ascii?Q?dmN89xQOCNRkiZN3Ss9hq/gRxpC1Mona+FOQHcEX27lyLKhlRggeYTDS579r?=
 =?us-ascii?Q?rtPI4NOzWrPdnlOJta5CoFy5cXU74NQXQzraKEP2NnCE2CjremxyerBz8D38?=
 =?us-ascii?Q?+tU1140Sb+EIm3qQOSi/XPHKeMQDDRSvdvd5+GG7y0CuDXmtC9yZudiqae62?=
 =?us-ascii?Q?EVF5BDsxxGIJXHn7Z69c9zBQoyQ7z4d8L4FxCtamSh/kHz6S1aAKE4tdRlkz?=
 =?us-ascii?Q?AbOC6irdVEUSH/rWYRkQX1XzdF6sfBSHJ7z3CLSVI6BNfXdxQeaZeKjgkSDQ?=
 =?us-ascii?Q?LU0ZbNzguIEGTKpOGjapczxNS6rWBCReEYD4tYLGIM1NYE5wbSEOPWgZak9O?=
 =?us-ascii?Q?7AppBjvZ5r7FAd3tlN9tgOAQTrFCPBL0FjP+C8i+52/oI8H1nOrbLSInUzHK?=
 =?us-ascii?Q?kYk5h32JxDWiqg6VL1V7FDLG+vxKANQLqJUdBQzeB6TkVi509jxAGdaC04nU?=
 =?us-ascii?Q?QJRIsV6HLl4P3vlZZBp8VYNYWDa6FeZPnt3Ps8W1s5XGLgnWVvLSH9bmK7+1?=
 =?us-ascii?Q?F8x6iNviNTEPrJSh6RiKJmZi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJyPqLhyPNjYg+GC8JPND8iU3srq6ZnkIQgYp/LculhoSsjCStDPUUjpG4Ch?=
 =?us-ascii?Q?ckFkYJ2s6XVLhv+XZzp9n2qMU8sIjcTpMk0/hLOeGyxKFF2Oswt6DSl2fV9K?=
 =?us-ascii?Q?0rfrF9or96QfMW2zOX61C94g5C5vgvWI9uFoT/arX6MdLFZ04Fm8h4wJiZ8D?=
 =?us-ascii?Q?XtZfL2rkLTaoKsTGanruLU5y034odVMNC+kRFmU26m51JPs5o/g5LjtA2oXU?=
 =?us-ascii?Q?oNaPGEEfMLdcUERWt/MI0ST1jUnNOA0GsVIzoAvucWCYZiJwsfvwPdkRc5C9?=
 =?us-ascii?Q?rHFqwMgNserQbqiI/Sebr+PM9BAOx3SVUxO7uJ9NE2ts9HmTCE2wBjnY0Go0?=
 =?us-ascii?Q?7UKbYycJMhc0krV4LZheKgdIB0Z3XSA0Bsyj2lu9kPiQ63bGVzSdDmN1qEMh?=
 =?us-ascii?Q?CJWw/+0ZorPnn2B8SXB/3GtKh6IzB6upb/4fkqUabDr93HoX4tZ1VAX0yzBu?=
 =?us-ascii?Q?NXPOlbMRi12rO6uj2syAjldxe6JyyJLtPnIOoRUyuIqIPxvsoRkdv4HGQgNp?=
 =?us-ascii?Q?bKXR3/1aqcWIX7NE12FcEjKbrYbCaXrSpKR0cFzTzCy/3FjlwoHlqxRS9lbI?=
 =?us-ascii?Q?M5yibBeHqYoYBvq8ECFCfDZNDwWgstJyk9xWd7SNyiw51k0v2IKHWCi3EoOZ?=
 =?us-ascii?Q?QLZM+uPk1BrAbJoYCR7ZYrgcug0faqm7anmJt4JeB1bCGPhVWfmPugBBT6yp?=
 =?us-ascii?Q?TzuN8OeX3AcGehzony4El/bn5DilTaMO2F1sYBLkHUyavEv0RdVPgYvBYZJg?=
 =?us-ascii?Q?D6+FpgACpdzU94QqacnzZhFSm3/dilE4VE1HU+2J17D48yEqKt6kZ32aPkJ8?=
 =?us-ascii?Q?2SdW9/0BQrCad4xzBR6Ctr6QAIfzdBVR2u/gs56/+PHYOQH/YuHvwinp/cs+?=
 =?us-ascii?Q?2h3uGfNIVPQduKgvWNNYk4QwX+Po/5QgZUO/uLMF+8/bXwvMVOAgfavoA/pK?=
 =?us-ascii?Q?NGqdHhx/xTaGzdwgvodrEny1jjif1hj/l19GEXabJui8R6g4Qxzo/dk8EW6e?=
 =?us-ascii?Q?u3UXz7R6YdhLSftZOg7pPkDBHp0Y/zPSrKD7H4iBtpdmzHPEpd/LtEQWPHyU?=
 =?us-ascii?Q?Seiv34ixuWjrvsMs2OZC6R8ghtHslzMCb7iVo4jhOioRSTCoxP3meogoCgpb?=
 =?us-ascii?Q?SHdGRZTGU74w6VGD9uz9PGnZ6hb5+2zvirPOAP7pHNQxDWPWNMKzfMs4FKPN?=
 =?us-ascii?Q?kumtdiLALizhWGH/8Qh4+yv8Tf3/8Cinje5agTh+iYXY7FSkwW8MWBoUh3d6?=
 =?us-ascii?Q?v0u2BSHAAlwXcnmdP/nEK4OOQyMHwQkNjHsQJ5u6EWtbbxW973MxL7sFxve/?=
 =?us-ascii?Q?tZC+SqkBMM8Aj68N2Da62PBEd64DoFawXbuW0amwrp3XJjP++4ZNqa2G0l4W?=
 =?us-ascii?Q?oObxkqCf/uVQ+GUdsT/SXlGC3a2ru3Yd9DjpsXKc8PEiYADcnCKQDKqYokLk?=
 =?us-ascii?Q?1c6yNoluRkgS5gy3zliWqvoagGn3l5V+MoW3BKF/iHmUafhpZiXE+oRjdbAF?=
 =?us-ascii?Q?kX2P/By91SHQqvYIEJKZD6cn5Wo9No66YVpOlkBX8ds4sReG7EvrGa7Xl1HF?=
 =?us-ascii?Q?rmnja/f34cOxCh34tSiQacpfgJIml2djM/v2weNz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aec41de-00a3-4044-1e24-08dcf2824ec6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 10:14:26.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPdyPe+tcGgZJAuqhpyjP7chu37pJM6XoowRdZSzaQvGYAaz1T7UWoZfC6d01E1yKG3iliLmN650qVi5s5zozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

Rely on the scheduler topology information to implement basic LLC
awareness in the sched_ext build-in idle selection policy.

This allows schedulers using the built-in policy to make more informed
decisions when selecting an idle CPU in systems with multiple LLCs, such
as NUMA systems or chiplet-based architectures, and it helps keep tasks
within the same LLC domain, thereby improving cache locality.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

ChangeLog v1 -> v2:
  - get rid of expensive cpumask_copy()
  - depend on CONFIG_SCHED_MC (there is no point enabling llc awareness
    if the kernel doesn't keep track of llc information)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a13a6461a290..370493c4d109 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3119,9 +3119,56 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+#ifdef CONFIG_SCHED_MC
+/*
+ * Per-CPU cpumasks used by the built-in idle CPU selection policy to determine
+ * task's LLC domain.
+ */
+static DEFINE_PER_CPU(cpumask_var_t, __select_llc_mask);
+
+static void init_select_llc_mask(void)
+{
+	int i;
+
+	for_each_possible_cpu(i)
+		zalloc_cpumask_var_node(&per_cpu(__select_llc_mask, i),
+					GFP_KERNEL, cpu_to_node(i));
+}
+
+static struct cpumask *this_llc_mask(void)
+{
+	return this_cpu_cpumask_var_ptr(__select_llc_mask);
+}
+
+static inline const struct cpumask *llc_domain(s32 cpu)
+{
+	struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
+
+	return sd ? sched_domain_span(sd) : NULL;
+}
+#else /* CONFIG_SCHED_MC */
+static inline void init_select_llc_mask(void) {}
+
+static inline struct cpumask *this_llc_mask(void)
+{
+	return NULL;
+}
+
+static inline const struct cpumask *llc_domain(s32 cpu)
+{
+	return NULL;
+}
+#endif /* CONFIG_SCHED_MC */
+
+/*
+ * Built-in cpu idle selection policy.
+ */
 static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
+	struct cpumask *llc_cpus = this_llc_mask();
+	const struct cpumask *llc_mask;
+	bool llc_empty;
 	s32 cpu;
 
 	*found = false;
@@ -3168,27 +3215,66 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		}
 	}
 
+	/*
+	 * Determine the task's LLC domain.
+	 */
+	llc_mask = llc_domain(prev_cpu);
+	if (llc_cpus && llc_mask)
+		llc_empty = !cpumask_and(llc_cpus, llc_mask, p->cpus_ptr);
+	else
+		llc_empty = true;
+
 	/*
 	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
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
+		if (!llc_empty) {
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
+	if (!llc_empty) {
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
@@ -7250,6 +7336,8 @@ static int __init scx_init(void)
 		return ret;
 	}
 
+	init_select_llc_mask();
+
 	return 0;
 }
 __initcall(scx_init);
-- 
2.47.0


