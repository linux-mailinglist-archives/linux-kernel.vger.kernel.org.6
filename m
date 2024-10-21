Return-Path: <linux-kernel+bounces-373758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8539A5C22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4EE281B79
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E781D0F52;
	Mon, 21 Oct 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UdfMRmyV"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200431940A2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494793; cv=fail; b=VhAkdDD+IabOYfXzN8AfLApuFImi0LHLRWgcNWfgASV2nZBMIzMkDoOSIXUGRM6DaEadUHicQAUIGQqXkxLlvPojMwsVidgR7Iez8A0syPdym2TAHG/Sp1Ra6N5I+yJcBj3mjcFpwb5tj9maXn3c2G7NAGZxhIdlKdNX2qcSNXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494793; c=relaxed/simple;
	bh=C0dXtu6UBxMjSB6TDvg/+B4TRet5FpSalrQUqPz0QgE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V6VCGZa2fzAEUVsvjLpGQzglukO7KMGCa5ejVTheNYkkuh3OAkSMatilcs04eJ7W1SA5A0wvoJ2ie3BYdXUvi110UofHJAZs8IAD+3fixOYRVoY6c2bu+J039lobBzgnycgLHw4rzljYlVLEq7UvtRdylYixNeGG9Pj9Q4R2BCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UdfMRmyV; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG8x3Axlsm4cwOcZfKImctZmUxUtx8s6Sqr+/oU2TliRnmwmyfL6GvISgRuPndPewX3K/2sK52uS808wslwdDu1t3VJATldlD/aj+zAqaiMVMaqlbVvVi+Ef26W/hvxxAXWOCF4futDM7IYel7oMkCgWa7l6lEPUEdozAY5AkQ2/CNPjYzsX8zhNofBHSDXd2jpPsoIsjdNNCJcy0EmUwjQiDw7dE4klCY3CbKWlVsLg9952FTlZZ/AY0jUVVOP9LY8qiFPk8o7xqmittD//ZOUisMXPosRUIhiKKCwl9V2EEStZFIwxu60AT+9U8+2kkG4ek0PPt6szjLJAbbxAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQwIo//N+EE/yQdrPwi0i4/hwiugxOiAnXv6eC1r8gs=;
 b=XVh2ZDvyZD50/GBS4anl/HdK0yUagk03WzOPIHElflN9ruH8tZ0IvE4SPDtkO5PuDis2QfMySw79oYihQoAUkX1DibrMEvutoeqSRgnKd2CzWyivZ7k4pX1uJOMyC/69YGw4nstktZK/qSFr2ZV1gRA0sQXQ4h28FiWHmpDJOa2ZviXZhcnnuSxtKas/wk/n2IyzPgW1DsXkf8gySTDPdV/FsdpUB9MYdPgplzUBYRVfQUS7YjECYqJmH3+ZFVThgYm95Yw6mMpOiiPefVGcsp6+x2wP2yiqtRYysR/dqYV8DmY9bmu/9hEqnFRUnSeK7Df/gY7I5eYydWhAWJY+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQwIo//N+EE/yQdrPwi0i4/hwiugxOiAnXv6eC1r8gs=;
 b=UdfMRmyV7ns+y+m1XzsMk2kwqI/lE77/XFvI3bYGiE4IHkjN0crXs8FjiIIj0WYaSC//6q1G14zV9E97MEN0FKI/YszVWAjkKR3oy/KZn/Mgpe/lvgO91HjTJiAJAofw+imND7VqiWeF3QyQjvBLE7WKXBKjbOIpATe4GLXk66/wrHUQHbhbj08fqdW2yz7uf0mXAr42kll3YeMnQi+WuFW052LJLyM2gi6nVyvKVkQKNwqaVi+n2I/pzVYcQKSLUgMvQ/noz/SVY0uC1TzGb6YjfrLCtzwtfy9w5JvMJQ8nIezINrcUGX4wsKZXHOrzSV41XBamew5sYyAe0flJSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 07:13:08 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 07:13:08 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: introduce LLC awareness to the default idle selection policy
Date: Mon, 21 Oct 2024 09:13:04 +0200
Message-ID: <20241021071304.27856-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 537cabb7-8a93-4b0f-6d9d-08dcf19fd05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZrpqsV4TMCqyo1ysK0y4AQ6Ouj0rXDSrDgAVxZLqpQ20L94TtOsrMfS0Fa6g?=
 =?us-ascii?Q?GaqQRBnJlRwIItMfJE+exsBOO06zc6/kMCd+Uk2DUD5idm9IuAG6owmnFMBW?=
 =?us-ascii?Q?96oim+dm93n6M0bTNIytSJRTjplZjwRgwxtNeAC0MiISewrB8W4/UwPgek6F?=
 =?us-ascii?Q?A+ggcNa5NJTgTv3Ef1ZbXpSIepL/YuXmCPD69mpV8j9Tmy0nnz9/hCHfDb8y?=
 =?us-ascii?Q?KQ3IRQuhepAjd37a4p7WmKlJuDWDxTAjqliyj6pEnqgOOjGLwU02QUOvHdKg?=
 =?us-ascii?Q?gGN9oU0iqPF25Mxl6ISTAHKAN5KkgviT+jpFtjTb8W7nxO6daEFLyAMydBCx?=
 =?us-ascii?Q?wpX+OE1G8gRFgrvewALWUNyFd/cqNsvaxQdUx6wdVZvwc2PTGXZmzBNuQbRE?=
 =?us-ascii?Q?pz9FYS3nSKi4n7+oK8LcT72pAalQjUh34Lh3AxzMvfZLcl5QNCSueY9Xbl8p?=
 =?us-ascii?Q?xKlWWqZj7ctWT2lItCC6mawxPiLEqOODWiRN/v4rkEJjgeAEsfn7JcThF25N?=
 =?us-ascii?Q?1gW9zpdkuJl6QTWSTyZMFxNUqBOcJ/rzbfhZpzENnIaACnRq3l19yNNxg1OO?=
 =?us-ascii?Q?2uuWjIvoMWOHi30Dhk9DNMPicfCcXa89C1V2W/w1QxGTbLWhLkYwA2pf9cUD?=
 =?us-ascii?Q?SD/02ExllmfxlEgflhOiH2lxGuTRLNu/1iB7GjAbMBZejIavcQPP6R0SFdae?=
 =?us-ascii?Q?7JisqzrAjQbZ97wLBF10o+phj8WjkyooGX8GTbpvxsvBEpanslKA0nzprooH?=
 =?us-ascii?Q?oKIthKECGQDbJbuESOkwnWHGaNNGtv+A7Dw/H75K8q0e0rFoZDS2aiUoP87+?=
 =?us-ascii?Q?nWqSAB8IcYMGhvx/luvcc5lIYuTCNlVClSV7Y9MaH12RVkVmN28Kf+93zZy/?=
 =?us-ascii?Q?hYZSsGQJRKFYw63/kDJUERz/g+kABF/vM9YLFa1Cj1ZrPWdtWbPzQ2krfJp5?=
 =?us-ascii?Q?xxpPCS4xH0/OhQCwngwjYsFqMn83GEkT6OhO41DRY7ZJl1skWBvxVC8Js2oo?=
 =?us-ascii?Q?oDFL/9rtURR7cryy1NPYHsa5zpPosdYJadmrHMzG+CYSIP1ltlushvQ8PhPN?=
 =?us-ascii?Q?eBH/lU0b5BTc2pstKu4vQ/Z98wlOnGXP7gDorbS9EL/nxr63pUh/oEZ1nHGg?=
 =?us-ascii?Q?XhX9ObPlFwJT2nPBbos+GaOirJ+cOxlmJZqZHYj9IFBKlvizRRfq8BG2eKNU?=
 =?us-ascii?Q?T6D+dX4nQfxdvenf87wKdO7Dqbmm5BLHp7KG3iNeag2bY0OZyrxuGr0RkyN4?=
 =?us-ascii?Q?7390ukicrKpdbLL4+eUcu0QZJ8Tn+fYd1SwcaF3rR2xkExCC4PQl9EsVZCgG?=
 =?us-ascii?Q?Zb577Tubr8PwRbk+rdqzg+o8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0RKx8AWdAUAYMFUlKMvDJ2SEckcq9paFPgHvAXc9y2/JBKwfC9IhM+DZxL17?=
 =?us-ascii?Q?BiPb9+sDg9SiwG+jfC/UVDKelE+h+5Tmmt8EqdO+S4rD+uJE8pLj9SfDPA4o?=
 =?us-ascii?Q?DbrLKZGFXOwtRkQURj75w8xQdelE+dFBSQXCd696UfQEkFxAHEbPMw7cb0zE?=
 =?us-ascii?Q?Fr0ViCzpfbWyzJuY0k8Gy45VAZwjz+jMz3EmbpFsOciN3nNbIsqLOcnpdRHu?=
 =?us-ascii?Q?XqffoW19w9pa73wlXgDZUKw1/WTJuAYQ4n/ClTcLHKh4BSWRUPeku4lI0X7h?=
 =?us-ascii?Q?Cm5CzkeXS1Li4wakeK52a8SR7Ik7hZBZz2U3SC4KNYwd/kOUqvZvzVL3tt1m?=
 =?us-ascii?Q?L7WuAQ9RFR2tKUQIm0WFQnl+XNY1OLigLFmibRV+kI6rTWhks8nQAkgz1LZL?=
 =?us-ascii?Q?fYByQGin4q9voxTfqRoAVlLpdQ2JgwfGFZnJ5NrSwuP9vT2Jp3ePJXqJmeef?=
 =?us-ascii?Q?PL4qXG8nDjee4sX/XzTslvAEJjPOVxULx+meiF+uq5HxCtU5FpJHfOSHjQgX?=
 =?us-ascii?Q?OIqCiu/vrQ8CnnQFew5ffmpAa4EZAJTCnKjax1Y3MHDBLo8nogq0wyFc6BGF?=
 =?us-ascii?Q?NN6gFC3xS6ik1kAhpnq3aKS8werZH8hCtO+oSEQ3MKWjJTP5XZRBNq6djZQU?=
 =?us-ascii?Q?i7NM8/ILn0Jrwe/VD+2bxl8nxCl80kIuLunU0nCT6KkljiTiHBD0mJ/cEsk8?=
 =?us-ascii?Q?7TqnM9U1JsOBru3sxBms7Vsi3SO3t0t5Dw+7DNkq4cEVRfbngusvjP6x1fZR?=
 =?us-ascii?Q?0H/LAOkZ9ijFzArM350s8ScwLXPwmQXhPdzdWRzNnO7+1k6zBnxhKRS92EHZ?=
 =?us-ascii?Q?fa3ojxLm6o3J4UVxPS0tgKYgdl1CwkbCCMeB4KLUpvAM5MUEOB5d/cUSg8Jn?=
 =?us-ascii?Q?ri65SvJZu5rTpilh4nvr4rNlq0VuwMJHHrQVg67Vlt6NaAIDxXkldUU0uRHd?=
 =?us-ascii?Q?te9tRoCKlMS4ko0yK7zFsyJtuGoWS9OwbcyMpkOFhg8DOp8yIlTKM9O8hxXH?=
 =?us-ascii?Q?4JlNZ3aJqih4e05Md7C4eEPyo+NaPJCD3v/r0b0abzcQ6sDdGjgVx2GUzwaL?=
 =?us-ascii?Q?mpmF/zxLYEDgNrQl0cB/2ErqdiEyWCtjdxrXbXLwWwJT0qufw63U5ru9yGn8?=
 =?us-ascii?Q?ny07bN2HBcoS7qjOlz2t1fSz5/hPiIygGP0m1TrgNiKFFAgRY2rvyf90/0tf?=
 =?us-ascii?Q?+JTJIdz6ZHSZVslO1TedesF/ImDyHFRkHdxDU3xMyQGN6JYCOV7lAIdv5TD0?=
 =?us-ascii?Q?65OYwDV/Vskiwc5rz3IcdiNw2KPvFxvOU/lsn4r092zIVOEekbLjvEPdesam?=
 =?us-ascii?Q?lbzOw09aQkEwnctO1gSuu0AVNswQSIITmTX4b9hGiZdhZ1hGdpR31PFU2lJr?=
 =?us-ascii?Q?EdYDaRC/ZkXaXIFpRjSU/m/hQYD1tZxeDwkyT2YWIPHuiW3VxeIc7i+h/2QH?=
 =?us-ascii?Q?QdLSD+EqCHlmPHQMiO3VqJ9nmpuk2vGx8PauPstvhLH637B5vtUvkynG09dX?=
 =?us-ascii?Q?cyE/fa+rMP7zKRmPVDlgBV1CkibOaAe+wnctUggOv6NW2mfpfkDdhdDXvazN?=
 =?us-ascii?Q?7Hlo79UYTupFH55xJSRcFmfcAIFw9AYNXOD1gFwJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537cabb7-8a93-4b0f-6d9d-08dcf19fd05e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 07:13:07.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKjwC10YftC30J7uwghm+K9WwN/an6fb7jJx7HIDqF1hRCmxN+QJlU8xvhmTdI5pURRgP9qqawuikgIoYQzjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476

Rely on the scheduler topology information to implement basic LLC
awareness in the sched_ext build-in idle selection policy.

This allows schedulers using the built-in policy to make more informed
decisions when selecting an idle CPU in systems with multiple LLCs, such
as NUMA systems or chiplet-based architectures, and it helps keep tasks
within the same LLC domain, thereby improving cache locality.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a13a6461a290..a301c4d7d49f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -874,6 +874,14 @@ static struct scx_exit_info *scx_exit_info;
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
+#ifdef CONFIG_SMP
+/*
+ * Per-CPU cpumasks used by the built-in idle CPU selection policy to determine
+ * task's LLC domain.
+ */
+static DEFINE_PER_CPU(cpumask_var_t, select_cpu_mask);
+#endif /* CONFIG_SMP */
+
 /*
  * A monotically increasing sequence number that is incremented every time a
  * scheduler is enabled. This can be used by to check if any custom sched_ext
@@ -3122,6 +3130,8 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
+	struct cpumask *llc_cpus = this_cpu_cpumask_var_ptr(select_cpu_mask);
+	struct sched_domain *sd;
 	s32 cpu;
 
 	*found = false;
@@ -3168,27 +3178,62 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		}
 	}
 
+	/*
+	 * Determine the task's LLC domain.
+	 */
+	sd = rcu_dereference(per_cpu(sd_llc, prev_cpu));
+	if (sd)
+		cpumask_and(llc_cpus, sched_domain_span(sd), p->cpus_ptr);
+	else
+		cpumask_copy(llc_cpus, p->cpus_ptr);
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
+		cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+		if (cpu >= 0)
+			goto cpu_found;
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
+	cpu = scx_pick_idle_cpu(llc_cpus, 0);
+	if (cpu >= 0)
+		goto cpu_found;
+
+	/*
+	 * Search for any idle CPU usable by the task.
+	 */
 	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
 	if (cpu >= 0)
 		goto cpu_found;
@@ -7189,6 +7234,19 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.set			= &scx_kfunc_ids_any,
 };
 
+#ifdef CONFIG_SMP
+static void init_select_cpu_mask(void)
+{
+	int i;
+
+	for_each_possible_cpu(i)
+		zalloc_cpumask_var_node(&per_cpu(select_cpu_mask, i),
+					GFP_KERNEL, cpu_to_node(i));
+}
+#else
+static inline void init_select_cpu_mask(void) {}
+#endif /* CONFIG_SMP */
+
 static int __init scx_init(void)
 {
 	int ret;
@@ -7250,6 +7308,8 @@ static int __init scx_init(void)
 		return ret;
 	}
 
+	init_select_cpu_mask();
+
 	return 0;
 }
 __initcall(scx_init);
-- 
2.47.0


