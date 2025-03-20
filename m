Return-Path: <linux-kernel+bounces-569253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC069A6A092
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3F16C223
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E88D1FC7D9;
	Thu, 20 Mar 2025 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DgXvdbyu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA61F78F3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456399; cv=fail; b=SVz0D++E3Kc0VKd1ttQ9/gnvqAPBzMp+YDRyUR28KYyy8Dnl8eUdHw2x/5s9fx4i0rMGskc1No+hEh07p9nyTNxMQb5g9docpEoMRJc7ojxQ7sx/L1vfOrH78yp4s1A+k9T+8RX003eckHRTFPvVU8QBB4zzVMV5OLpucM+Qb8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456399; c=relaxed/simple;
	bh=C18IDofFdxJlzTJGnqI1t1Kou0Dou+RB4yI5AnN5j0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fs5xfjmKPFFy/1Eeumm8fjrjy28+QvbaragrCVfR3GjydcmTKV6w2F5ADFZng04fEn7UeYGJeHFFsuH56Vj1bqTVcPOAxQfF3QuXKlgeVmuPH2z6BAt5+KjPzx3M2AIYgA81N/FOS6wCt/ylU4Trk5NMFaxmNFctr0J4gSAOKxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DgXvdbyu; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHLuMnP9xpRkFBEit8NQnZtXioZ5nEezYaAwUg4BNgL3I8XcjZYOBXrqN9q+lttTs4oC69EJN/hKLQLI5wV9nRaJGG7w9Vya8V4sZqP1B3YyWxTr/ksWv6OQLEQQgn4NDDC1VjU0rPsA9cZne3tOX2agw448eWKkXQM+dOo8maSLNpobnTbOxZ/tT6FScw3LHOCYhP+ab/Fj2Yf5K022Bj+VLNrkPmQrAeLryC9WPslXZw69CK0uTvcuhgubpAhdKYhJHXkTlVjfO9q7OAelBFSrOKYEJhoL5cFFDV74KMneWvvMl1m0CcpVzstgXQ31WDHeOYgWkbfmONVdCmQweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMBkb7XPindwCOEeRAoNCIAGYbWO7etKW1KjxfGW1w4=;
 b=MnwtnmcyQAk6x3kugFQLoGABF2LabtbRE95RwrOgGJz87ilf6zUUUilfe2AVzL0N9bd0z542tGc+dDX7X4kyCHxMRODnSq9FdBOLllrYAtnWkI8bBuHFchLmh2OKU80qH9viI73GhiO7gJ/LJ8vjCFzXPxqb238Uv8yZzoaIW88nzd7s3OeHjZXJ4WuHlwXPD7O9G6or+ZTT6Qty5xyIBXwghyJrxjbxaDEJDFsJYHy0P4lZdF5Ao93W8xLVJvn86Vka49DU/U0rohQTVry1gCwbdZDzKs/kdKGQzw0sYvlVmzVTJSNZNtTww2Yx6r4Smsk7hLG1StE7FxV39h7KYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMBkb7XPindwCOEeRAoNCIAGYbWO7etKW1KjxfGW1w4=;
 b=DgXvdbyuxF2+N5L6nnB/ssMw3g5ZUOxtecWnH+HWmNSiLhToj02pHrp38M3BAoAhnm0YurLKfL8Z9HzPQZAiR0LLD4dSx0HzTFmQLLpQIwyWvX6PWWb7klk+bS3IJqE//Hqzk1yxAGw+yhEOcXIMAYiwIErAm0fN2QcF5fdJSj+OQYsHfEaKwwhcQpNQ5KasNj7u0iw6FMXOpBn3ZBnwkGVQSF2jdibNzYdUUPwc5GXEa1ulAQ3Tu8+oNZ+CktijHSvTu7eEWB2QTfSkIHeJW5d0kA2zzsPAuLc4dGargIOE58PpwWEjba2VyU/fvtzfLq6Q++xajx4hWO+eRGfHfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:39:54 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:39:54 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
Date: Thu, 20 Mar 2025 08:36:42 +0100
Message-ID: <20250320073927.216147-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320073927.216147-1-arighi@nvidia.com>
References: <20250320073927.216147-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a184f29-0314-4f54-13d5-08dd6782682f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JPyxedJCgbtyJ+UxPZXWINdY6Ecq/1wIiRR3n6cR2RulnyFkY6hVESORjUJ8?=
 =?us-ascii?Q?272kCjATXVygYl9N2Si/hHCZCgazvIFPEGAFhRZXok5wLa71v3os/tzTF2vB?=
 =?us-ascii?Q?Q1NKFqgVnhyBP5W29/D4t8m71IBYxF334dZNsFOnpNHLwEbUME8qD3Ye2U84?=
 =?us-ascii?Q?jWu/49sjIlg01rfiUKVGILO5xnWNLstitrV5n8SCa1R3MFnE+50tl1+y0pq/?=
 =?us-ascii?Q?S/Uq/fRor2ymyaZWjNuIzQfAe/bAepmgfNX2ECKP412ZrbEEmykI7DZ6l3gg?=
 =?us-ascii?Q?uu/9xtAxu6GCl9fdOPlQVV55MNP6WqoxpwgPCVA3iIdFwcmvAOnGtZFj2R3e?=
 =?us-ascii?Q?IXGvA8VpCO4dyzh47weT76VRGHFwL1UsJADa8GFsMTD5l+F0uU6GE3Dw34ue?=
 =?us-ascii?Q?zCZTXVdWck62jxZYft3XrJVT7HkoIDxR29t8FJ8qtsKhbC366L7PQT6Gv9oP?=
 =?us-ascii?Q?d8jqEIh7ywhHyID7E9vPNFUL5BNJ/rYNNA8OBjIKTme60977HwDbgNcShBR0?=
 =?us-ascii?Q?IDTHMlUNsBgSY9OPb9gVubBTdD0Je8qZtHQhn9DkM/ixm42dlS+L+dPYBWWd?=
 =?us-ascii?Q?YW14nC+qngS6HsQtMm9/VsMVi5IQyaX0eG69LlfU7MkH3d8pI3Rwjs8StN8t?=
 =?us-ascii?Q?Bg7rCo6si/XMy2ZexQTpV+dY5Z/CvgmKGhWekiRRF7VeDtXmyt74JtUBsM7Q?=
 =?us-ascii?Q?q0N3Lk6xpFqf+plaZv95GRTLNF5J8Me9/j5SfDP5xKlIG2RQbTNITsMX4vQ2?=
 =?us-ascii?Q?jgowtWjCSOE923MoFRoB4A1ZzdQVqAoCF9Mu7n8DQ8ebkhgdf9eL3GYBncT7?=
 =?us-ascii?Q?GpYUR/Btd+8LWhkeOhjwbMk97aD2lyYMsUi6z7Z3VcWf9H4ah5M5VFa+I0Lq?=
 =?us-ascii?Q?YeG9nuDj2uz1Ay+4q09ErvkstEfrvnmbf6XtwRTOvhiDTLR/OFNixe9w57yN?=
 =?us-ascii?Q?/s09OTZG6lfR+RwWOnn9Skc3KSsBvPzen1pKhs5i9gXyWzcLu+YYbagd+vYR?=
 =?us-ascii?Q?RFttzizZHeuTqQzg3J4RhPgE57GUs9Q33T4i00DECR+380oxwlUVASVCkVOp?=
 =?us-ascii?Q?+5kq54uEbTUzpFbVxI1CHhjTCSVU9W9ZGJZ1Rxx57oAdhXmFY4y5BmuBKKP9?=
 =?us-ascii?Q?81DSD8c8tdAoBIygymRH4nls+80/NuHlrffxP5GTFqD59JwDd8tWDlLQMI3d?=
 =?us-ascii?Q?ig5alswltS0T5ClBPJlPgy21KWBM5mdMHcU1x6Ge3B2i2QN3dwZ8+LlYZJ+S?=
 =?us-ascii?Q?pr8y545vxgt4XYqvvMY3WH6ppIVc4SpOAZ/MZg2cyq+5hqXkUSwVvPMbvJGJ?=
 =?us-ascii?Q?wQT2TvEXFWwskLUn5Yvro7n/N42TKSQ7KgLcde0qTXLqg59oST0RZ+LWFpxG?=
 =?us-ascii?Q?rsvU/BigAZdoWNgGy3jjeOJOZGQn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZcJ8W2SdaqPOCLjFgYT/bjDFJ6C5Kg2phLoc+IybuOWLjOeoEMCkZUxynpO?=
 =?us-ascii?Q?ayisgAyRrt3Tm6x8OQ/Igk4NH1HDE67RhkO/JFmVT8XwtOLiSqKFY6iAyXP4?=
 =?us-ascii?Q?UFr9haTZIV2XyKUxFZg6gzvgVIyhf8VMosRgFkWBSc1Ln6Kmn+QdM8YpEzJh?=
 =?us-ascii?Q?VuMTlJmYiApnyhShyia3ahsSj97TftrXQCrJSA6Ql7nQJyVjQFFbJFx3MnZL?=
 =?us-ascii?Q?5Rva4jipuh+1F8hVM/9zIZjlvfGL2OkuYEJfY0cMUzcAH8MmLAAs2DeBEGZh?=
 =?us-ascii?Q?eypbWaIA5GY+U6rSdcvP/+vqD8B8jCkSP+xzaaoXOAA1LAHaYf39YLNWMT6Y?=
 =?us-ascii?Q?mT4b3wnG4uX4j2+sMiTEInJtmVhiVAcc2e5jM5DP4JesWdXppbdJKl3TDeAt?=
 =?us-ascii?Q?AIOPSR6R02ZMoZ8k1dT/VxVj1atRlu7jB5oGFPqg8zPQnZKOM1ffOGZaTy04?=
 =?us-ascii?Q?s8zzkM2VEVrIyYQhw3v1PW5W1o4yU1nZAtM64GBRhcQVy+c+xKa6NOcUFqn0?=
 =?us-ascii?Q?zDx1d1cEHk/RfOfpUF2HYhuetThXMkxvPqbVUzXg1dT2RrQKWQ6IKwX26Dwg?=
 =?us-ascii?Q?ysm6hGvyM5/83VZ2ebj/3ZCA7V62yO2UZ+9k15beZ0nyerpB/tc0N+O3s0TC?=
 =?us-ascii?Q?zZjC/6f+epXuF318k1RhUsc8eRUKhtes4Nbx3pwse2PQwEsSHx5hVkclSd+O?=
 =?us-ascii?Q?5FX4SyNHJG1mNmsys+6FVEg+dgxi1Z7qmJmJ72+hkaJV4sJHvmhzObZTlod+?=
 =?us-ascii?Q?zyxciriICFjjXX6JLW/F2N1qzv3U1db7UMtRUnEFgaz9mh3jakaC308+REkU?=
 =?us-ascii?Q?DmEpwRBaX2T0y83r11ML9hbmDLEh45jVMIdebGjB8Z7TJjl1UuGZOjE43j6T?=
 =?us-ascii?Q?w2doMKmO4ZDM3yEvH+mG/JflEkS3wahn9IUEZhqMa5+Ikbbr2hzV7Ec3Mco6?=
 =?us-ascii?Q?pONu9rIFKYuRcjhCRNzfNuu0jbsMOmXmjFqrGoMf78yFa2aMy7LdEjffK4JU?=
 =?us-ascii?Q?JwDxUk+DS2njjlxaCT/+SDYWi018fgF8fGACxH9FSTdopWpKzKxUcpee7itp?=
 =?us-ascii?Q?P4lRNxuMC6+RAzkuZhNaTSbtkAafXPNendq+rAQdLm7s1R7JxuITb0eK49oi?=
 =?us-ascii?Q?s2nSg6Wmryy2m4SOpeJMe9xWOScNaoDaozNytvbkajSDRD8z0WWhfyydVx8Q?=
 =?us-ascii?Q?Unn/A3PbAREJq/HjrmccuEhtawNbCdY6+9v8ddRpELYAkj9a2lQtN/f3V3Ud?=
 =?us-ascii?Q?8wKhgc7umGd61J+uud2tn0umeM9rqkiWcFKk/zV+7/BNKbmjiJydqqA45yrV?=
 =?us-ascii?Q?H/IpVI6JriqqX6aMS+vjrBVPA2VMS4TRmw/UNMsxAqXhQUS9ndYlODL49MWZ?=
 =?us-ascii?Q?/ZnD9ZzbAPxxxPjnp8JAiFI9NKz4N1ewMbR/aKGq/5YIWGnA7uLEkdSTwBNz?=
 =?us-ascii?Q?W63XPRL5zXZQMpR81WzjeKn8yz9LeeJtIODH5v40N/NNHKEQMMb+SbaoFGAt?=
 =?us-ascii?Q?xKrW2bXBraP28jQIQ0SNK6F3FD5u/+drZVeyLq1LPVVvfT/ArnZqfrBP++m5?=
 =?us-ascii?Q?FCSbkXoDwYy/+lQkXhElFlfHYypJKW51eXavp4Ds?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a184f29-0314-4f54-13d5-08dd6782682f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 07:39:54.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhxE0D7xNh5iBKlBDN0RhwZ0lHBJ/6pqmSXz5nrbUIgMlntG53SSKK8W5iiOzRg+983Iwvfd8hElLkTrVRtPVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

Modify scx_select_cpu_dfl() to take the allowed cpumask as an explicit
argument, instead of implicitly using @p->cpus_ptr.

This prepares for future changes where arbitrary cpumasks may be passed
to the built-in idle CPU selection policy.

This is a pure refactoring with no functional changes.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  2 +-
 kernel/sched/ext_idle.c | 45 ++++++++++++++++++++++++++---------------
 kernel/sched/ext_idle.h |  3 ++-
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 06561d6717c9a..f42352e8d889e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3395,7 +3395,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	} else {
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
 		if (cpu >= 0) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index e1e020c27c07c..a90d85bce1ccb 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -397,11 +397,19 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
+static inline bool task_allowed_all_cpus(const struct task_struct *p)
+{
+	return p->nr_cpus_allowed >= num_possible_cpus();
+}
+
 /*
- * Return the subset of @cpus that task @p can use or NULL if none of the
- * CPUs in the @cpus cpumask can be used.
+ * Return the subset of @cpus that task @p can use, according to
+ * @cpus_allowed, or NULL if none of the CPUs in the @cpus cpumask can be
+ * used.
  */
-static const struct cpumask *task_cpumask(const struct task_struct *p, const struct cpumask *cpus,
+static const struct cpumask *task_cpumask(const struct task_struct *p,
+					  const struct cpumask *cpus_allowed,
+					  const struct cpumask *cpus,
 					  struct cpumask *local_cpus)
 {
 	/*
@@ -410,12 +418,10 @@ static const struct cpumask *task_cpumask(const struct task_struct *p, const str
 	 * intersection of the architecture's cpumask and the task's
 	 * allowed cpumask.
 	 */
-	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
-	    cpumask_subset(cpus, p->cpus_ptr))
+	if (!cpus || task_allowed_all_cpus(p) || cpumask_subset(cpus, cpus_allowed))
 		return cpus;
 
-	if (!cpumask_equal(cpus, p->cpus_ptr) &&
-	    cpumask_and(local_cpus, cpus, p->cpus_ptr))
+	if (cpumask_and(local_cpus, cpus, cpus_allowed))
 		return local_cpus;
 
 	return NULL;
@@ -454,7 +460,8 @@ static const struct cpumask *task_cpumask(const struct task_struct *p, const str
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+		       const struct cpumask *cpus_allowed, u64 flags)
 {
 	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
@@ -469,13 +476,19 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 * Determine the subset of CPUs that the task can use in its
 	 * current LLC and node.
 	 */
-	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-		numa_cpus = task_cpumask(p, numa_span(prev_cpu),
+	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
+		numa_cpus = task_cpumask(p, cpus_allowed, numa_span(prev_cpu),
 					 this_cpu_cpumask_var_ptr(local_numa_idle_cpumask));
+		if (cpumask_equal(numa_cpus, cpus_allowed))
+			numa_cpus = NULL;
+	}
 
-	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-		llc_cpus = task_cpumask(p, llc_span(prev_cpu),
+	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
+		llc_cpus = task_cpumask(p, cpus_allowed, llc_span(prev_cpu),
 					this_cpu_cpumask_var_ptr(local_llc_idle_cpumask));
+		if (cpumask_equal(llc_cpus, cpus_allowed))
+			llc_cpus = NULL;
+	}
 
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
@@ -512,7 +525,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+			if (cpumask_test_cpu(cpu, cpus_allowed))
 				goto out_unlock;
 		}
 	}
@@ -557,7 +570,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto out_unlock;
 
@@ -605,7 +618,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 * in prev_cpu's node and proceed to other nodes in order of
 	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
+	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
 	if (cpu >= 0)
 		goto out_unlock;
 
@@ -861,7 +874,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
 	if (cpu >= 0) {
 		*is_idle = true;
 		return cpu;
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 511cc2221f7a8..37be78a7502b3 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,8 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags);
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+		       const struct cpumask *cpus_allowed, u64 flags);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
-- 
2.48.1


