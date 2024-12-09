Return-Path: <linux-kernel+bounces-438529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76D49EA25A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59C81625FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA67C1A00D1;
	Mon,  9 Dec 2024 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+XKgV9u"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B619F438
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785382; cv=fail; b=E31ppXaW24NZuolsg1jQvrJNl2AjZED+zjXsy1WKGJac72s8t/RF2/lqbxbJ0pOjFVMyU/dFUl5iv9JXH2sH9MND8iwb0czPFss99OJIQZq9z/v+R1txSYF+3wjbRRK/Xx3DmMaZjheiDU9ba2beL2QEgxPuOmQvEGWpz4NgwGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785382; c=relaxed/simple;
	bh=dUHlr8+OLoQ928sku2y5SEeIkqA/f9pQqZK7wKP73hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m3cPVLcLsdRhfHGHUqE08PlgW0xKvFl7OczFuoI9SVNCKHYzZKhJcK55gTbVpnTGQ3905FgpKntfvbz8GwMwV7sWEtESUro3xrgmDUap2udEWvz1mcKtTIUUunN4MMImGLDSw27XQUKw2BD3dpecnZT4LE2hTCSomIg7l0XgAvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+XKgV9u; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbZbu03IANrB1NISuVDAz0bvIt6YbpxhHTsYLFTuWZzwv09EVDOP/aNRN6szzadm8LQtae8YSHp9L6uP7lRpj1sL7ceDbldIw7N2hqGF5fGWCFxmNYJJHj4EsYihOzsh9S383+cg99hd6GdAwZ2BtFrF8yP03DPa7lteNNQOkI00gK4xnpOgS7BG0yX0/+vqWyApL/3fRnt4k323APlJtuxeBvbgcdn1y2Yrv6ex79CTlndyhlRRBy3TG3EescbcnpaXGeoT+C1hZ3F604bbTOqCFL7zlMtYzXfGbc2qJecnHRzLPJFjc1SzjvP7jVkuAl5LRf0RT9NZK8l8H6i9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M1tdGI0aoTrbDHQZnm5Hj1r5nU1NgEPdpJqeUZ2jf4=;
 b=yYto4lsWi4kaRgT6BDPU1jknIQHXZM8Tl/8JkTNjJx+w65y9MNs1ToxuI0VWzpnDUH3mriYiOqv5eCCFvTP7/s8MXYIIU++jW6SG7gYTYs18IE2nJPYC2HOvQAkP0E0kBkJaI3vSTjF/bPdoQLX7bQeKzBpW949Z9+u5H4EPbq4a7ztO9kYd2y1wV4HRT4uy02wJQroAfGnVhk7xWmNZbncNMPrzHgonJ4hp0HgQbQT6Z/PzK+3Ia/DUF+iJgP9cmiTp2sJKucs4A99LXlHt6XmLdRPaKG4Xl3WDK3HNoaszEAMlw62e9+v28oC6OpOYZyhYgjD8cOPBaGTUGFTPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M1tdGI0aoTrbDHQZnm5Hj1r5nU1NgEPdpJqeUZ2jf4=;
 b=Z+XKgV9u7vOKaXzypskCYJJegfWgPYFQ8x4YbCcuTjLUHFS8kJQB7Wx3lxE+AUn7lCKiyEObC/DLKdrzWdmip6kZ74Z/LktDM9GpgRb1d9A53NwbMnKY2cahD2X7iQHouO9cl0YYU9sq10NdiBgLsfkLMWjWvc+aJLThn4oEHmoo0VrZ7KvMJSR4VTCZ8pWjZ6fKQ1GaKwGBn1AzloKAUS08MLfcEDlumo1AZ/8Xugx8EFh5HIoJvWS2b15LrvzXrvRqYzxGFHzyRB5h5Lm5oRMS64wkG7uNOhdohE22yC4OUsGoCQyvvzZ2vQ9/2idWCUIwnf6tEOMzvUww0+Xpnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 23:02:57 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:02:57 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] sched_ext: Introduce per-node idle cpumasks
Date: Mon,  9 Dec 2024 23:56:26 +0100
Message-ID: <20241209230242.775225-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209230242.775225-1-arighi@nvidia.com>
References: <20241209230242.775225-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 964b5b03-6f11-4770-3dd9-08dd18a59eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ny4RkaGfWXak3lZ6MTkIPV5VJoZgK0rejqRg4mPcfUToBlYaPWGEwERrJHnn?=
 =?us-ascii?Q?ATP1Vgy4cR/tAgu3FibZ/1IBGwzrhozLS1gof2Wv8TPUp+o4ltXIWpgsUCTY?=
 =?us-ascii?Q?jC7e1VLbBA5T0ZK5RejZ1G4ybzAD00G/p7U9RR6VS//6fh/bWNnjU+QAj3m1?=
 =?us-ascii?Q?LAWe0D+BQHAbTkjGgiJa+fx+b9MbiYOUG3fYQjTjZ6oAHB8FfQsoOvVuSc6L?=
 =?us-ascii?Q?Z7s/A8F2GtBE0LrCwtdcri9tAWZSpM6mUV8BYOxqGJE+PFTDfHt1653QX8t5?=
 =?us-ascii?Q?HBWkxGCT4q1p4i/ctTPKQQE/Js5gvRkcUAfSxnkATF7ni6H7vM091p62DjIK?=
 =?us-ascii?Q?J//CwnWWq6EDek6bnzwSdubipMq4GXZbm0mgtmum5ZldAj4wLbSB5XFT+mPb?=
 =?us-ascii?Q?b3lIvDhMhoNZJBKwhCA9K4tdzWwj0WWFtR+LwdOzzpjsQvaMxnoY78annScs?=
 =?us-ascii?Q?M5eRX+7dmZ/P5rdX4mS0aWqVeIEbSA4QeV58TlgZYsfzsMOvpcMyRd3tYkrH?=
 =?us-ascii?Q?9G7AGco0it3tk8PZ66E3pxNffWxf4eESuNKUj6ZLXwnJ6pS27EujDk7RYuGw?=
 =?us-ascii?Q?F9PuPCFcutFDlebYey7TnV8krsI03EoWPhnpdFeufdovklfugNt9SmLmTaqc?=
 =?us-ascii?Q?AUYsCNWZ2R5GHhIBvr2zuWRXja61YggOvzA9C4s6rykj/dp09KXtHR8dpm43?=
 =?us-ascii?Q?a+VyWz1hfD46S7OvCwLlvY+sId8hea83Bzp13jNubeJX4CHZkYkNAVoXC0E7?=
 =?us-ascii?Q?O2Pk2+q6C9q33JDqqM9KQs7iIp4k9fY+OGchfVAfcCtSwIkkM6WRngFRwgo+?=
 =?us-ascii?Q?lVCEc9GcFa8KHFCJ/ld136/MleMXiSaG0CK/Z9IDfh/yRtcRs8rdudGXCEM5?=
 =?us-ascii?Q?9U44S5GpPbdzsoL230va7TiBR1wcw2/eKL78k0J+s57k1s/OcHCxpfz1m1Um?=
 =?us-ascii?Q?bSbWCdRiAeM8GzZgPJygYrSYm10Aci/dBiLPGAWnwyXLWR6yowF42GBnN9vv?=
 =?us-ascii?Q?wQWpWM69t4SYLFXZlBN2LjKjWMFJtw2XPr0Jkg0oiwn41iYdVfqZQnfa+S+z?=
 =?us-ascii?Q?sZG0e1oVmNTunumk0GvSbsfJFoM0zmwJw92phGl0hQjngKgIF1yX0jySAi/N?=
 =?us-ascii?Q?/42TVN2D6Rem8v9Q2HFcVFfVdcn6XaZPgREAyIoNxPK9BhFVhyxc3MpugH7U?=
 =?us-ascii?Q?trFYNT2PIM6JO9c4zf1sRIZEkgxsCyjOeOzJkRLZCMLbkCgXzDiiFW7mZKl3?=
 =?us-ascii?Q?EwecpM+vPIj6J11LSJMj+GtQk6yC1bpZAc4sU68Zh3wuVZBjNkcgvB90AJ75?=
 =?us-ascii?Q?nJi5bv/eZweh859Mq3pmyJ1vA2SiEqNIzSRfvmxXjsl6IA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qqt/+5QEhGRTivUzlNBSTvY65eBeHjwZLRqPJUbfvUKtaDgvRlr9Lt7PJuqB?=
 =?us-ascii?Q?q7c3R52CGz3DSoMWy39kDaj123e30PxYkFSubb8CIXntPIWxx/3E5GcZgUbF?=
 =?us-ascii?Q?SlDtZJdcr2FFWiD9MFLyG3K7jFwwqv5jLRZ4kT5AkAtnxCcXEdIxTMDhAJOU?=
 =?us-ascii?Q?6P9OwksnsRIyLlX44KhjFA/omhspd5pnoUkROP2OcwKfybBy9CD/m6qNk6UF?=
 =?us-ascii?Q?NdClVkPvU20iuZS2Wl+5DUU14y2GaTfEamxi+vHi0+qdiaLFysFQQ4r1T1gl?=
 =?us-ascii?Q?iDGANyKCOn9EJGbKuRVGfLnYf9Yq8OFW962UFqRnAJaCAJq/CqKDhZbz/0/X?=
 =?us-ascii?Q?z6mZP9dF2Pzac2bZI8QGqxKMZBz8Uq7UbfRUbYr3KpgB9waBjTM4VGbRddlH?=
 =?us-ascii?Q?13o3EFTzKyC6mznA7E9v61saI0BMZ+72aJmLpXALBwHEZHP2YBRj95r69zk4?=
 =?us-ascii?Q?C3vGZJ7FqHHx/kBpHtk+4bBj1sLENuoUwqLqM5VxHenodT07MftyICAIgITL?=
 =?us-ascii?Q?/xlNRf/SShyNVy1xq07zydVtAl3+wIEt5o4eVLmMJh+oJWFtDWucUEida5gj?=
 =?us-ascii?Q?By/5CuQYLcky46kLMzhfYHArzbJESuOdwB+kcriFv/p6wBLf091Y7o3HR5Bb?=
 =?us-ascii?Q?QQIZ0YYCzZKdzIPB//gMmxMt5vr8crKpvp8pPnllUc5Ju/5pn4aIlLB7oqA4?=
 =?us-ascii?Q?hEqA7tSvYXJR326MkevMQroYBQpiWx5ipmUhD7m3cc2QxWp9KoTcyCVJ9AER?=
 =?us-ascii?Q?H5fm6LMXm/IwykxcdUn3r+wodsEQUZBvoG04ru2epqPBz5ARJM2tO+gbxCKx?=
 =?us-ascii?Q?WchVILdrPJbMzOlzDsGGi1GcqKvzjC7kSjAXb35cky/CQGjFdLh/eXT63fB3?=
 =?us-ascii?Q?0rR85X0Ab/ntz6hf+q1DxwhBc1McXFHZKqxG74DD+PvGWldNUbo7yKgGm7GP?=
 =?us-ascii?Q?oNIM4vmupn27Lk5e0wdk58PuInYEGelvgSBK7CDFSbIp/5d9/hozlSDg0cAL?=
 =?us-ascii?Q?NGLIapSj+TEVhGAJsbE6jQOblvcnJrrGgE7sEZUqws9/2Qvtmp9C7hj9/U3u?=
 =?us-ascii?Q?BkHUvY7uWbjLDc4pfTIIviBGf4NkXvTP+WAxXl0dbsZLwptD3DG1v+QRM8ys?=
 =?us-ascii?Q?Cx7xx7ZBhLS6XUrnf8Y549Pd1aKt0GEKvalqL5CzhC98h3k1UdiVlLnYmEuC?=
 =?us-ascii?Q?QcXp1/KhiqnVobcHYAhzSlb97vHGiNB/hNAoIKd49ieCYkGxuVZaym1mioeW?=
 =?us-ascii?Q?GRQ7EW2zmPYiILcs/+lJyYLlnSdDhXJI1Kyo0QJ3VVnTRBAyEfaye2RhjGzc?=
 =?us-ascii?Q?sQPR1cP/7yLWLn5Vd38Wx20eSxv/xiUUqxPLG2oxtDXBuD/KGgdwXBCICkxj?=
 =?us-ascii?Q?+JaoLGRhXIfyiX3NssnaSjMYuhRs9PY6/zqW7+Ii7xEZppAmkjkm2LE5EBOf?=
 =?us-ascii?Q?yvpzWo814mox64dn8B5wlnqf98N3A8db9P0Zm/TjzpuwEhX3LScKRUSXNnSA?=
 =?us-ascii?Q?z1L2qu1qsfYp+UsGAJuLye2Ghl2ca73YJiGusmhGdL6G1xCwAhHSHaAk38P2?=
 =?us-ascii?Q?RB9jk95GYeQLzp0X/mfw751quUz9AMV6OR731xNc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964b5b03-6f11-4770-3dd9-08dd18a59eed
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:02:57.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mt7Z6oZcNP5WcZ16r83fvjbgSGRqVqY2vn636Dny/t+aYJzm4NXOKctDxn3FHz0qz4gLfduaDIDB758tBjajiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

Using a single global idle mask can lead to inefficiencies and a lot of
stress on the cache coherency protocol on large systems with multiple
NUMA nodes, since all the CPUs can create a really intense read/write
activity on the single global cpumask.

Therefore, split the global cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on large systems.

The concept is that each cpumask will track only the idle CPUs within
its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
In this way concurrent access to the idle cpumask will be restricted
within each NUMA node.

NOTE: with per-node idle cpumasks enabled scx_bpf_get_idle_cpu/smtmask()
are returning the cpumask of the current NUMA node, instead of a single
cpumask for all the CPUs.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 221 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 166 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3d13e7975abd..0b9b6627515b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -940,8 +940,60 @@ static struct delayed_work scx_watchdog_work;
 static struct {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+} **idle_masks CL_ALIGNED_IF_ONSTACK;
 
+static struct cpumask *get_idle_cpumask_node(int node)
+{
+	return idle_masks[node]->cpu;
+}
+
+static struct cpumask *get_idle_smtmask_node(int node)
+{
+	return idle_masks[node]->smt;
+}
+
+static struct cpumask *get_curr_idle_cpumask(void)
+{
+	int node = cpu_to_node(smp_processor_id());
+
+	return get_idle_cpumask_node(node);
+}
+
+static struct cpumask *get_curr_idle_smtmask(void)
+{
+	int node = cpu_to_node(smp_processor_id());
+
+	if (sched_smt_active())
+		return get_idle_smtmask_node(node);
+	else
+		return get_idle_cpumask_node(node);
+}
+
+static void idle_masks_init(void)
+{
+	int node;
+
+	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
+	BUG_ON(!idle_masks);
+
+	for_each_node_state(node, N_POSSIBLE) {
+		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
+		BUG_ON(!idle_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
+	}
+}
+#else	/* !CONFIG_SMP */
+static struct cpumask *get_curr_idle_cpumask(void)
+{
+	return cpu_none_mask;
+}
+
+static struct cpumask *get_curr_idle_smtmask(void)
+{
+	return cpu_none_mask;
+}
 #endif	/* CONFIG_SMP */
 
 /* for %SCX_KICK_WAIT */
@@ -3173,6 +3225,9 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 static bool test_and_clear_cpu_idle(int cpu)
 {
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
@@ -3181,29 +3236,34 @@ static bool test_and_clear_cpu_idle(int cpu)
 	 */
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
 
 		/*
 		 * If offline, @cpu is not its own sibling and
 		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
-		 * is eventually cleared.
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
+		 *
+		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
+		 * reduce memory writes, which may help alleviate cache
+		 * coherence pressure.
 		 */
-		if (cpumask_intersects(smt, idle_masks.smt))
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_masks.smt))
-			__cpumask_clear_cpu(cpu, idle_masks.smt);
+		if (cpumask_intersects(smt, idle_smt))
+			cpumask_andnot(idle_smt, idle_smt, smt);
+		else if (cpumask_test_cpu(cpu, idle_smt))
+			__cpumask_clear_cpu(cpu, idle_smt);
 	}
 #endif
-	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+	return cpumask_test_and_clear_cpu(cpu, idle_cpu);
 }
 
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
 {
 	int cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		cpu = cpumask_any_and_distribute(get_idle_smtmask_node(node), cpus_allowed);
 		if (cpu < nr_cpu_ids)
 			goto found;
 
@@ -3211,15 +3271,66 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
-	if (cpu >= nr_cpu_ids)
-		return -EBUSY;
+	cpu = cpumask_any_and_distribute(get_idle_cpumask_node(node), cpus_allowed);
+	if (cpu < nr_cpu_ids)
+		goto found;
+
+	return -EBUSY;
 
 found:
 	if (test_and_clear_cpu_idle(cpu))
 		return cpu;
 	else
 		goto retry;
+
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	const struct cpumask *node_mask;
+	s32 cpu;
+
+	/*
+	 * Only node 0 is used if per-node idle cpumasks are disabled.
+	 */
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return scx_pick_idle_cpu_from_node(0, cpus_allowed, flags);
+
+	/*
+	 * Traverse all nodes in order of increasing distance, starting from
+	 * prev_cpu's node.
+	 */
+	rcu_read_lock();
+	for_each_numa_hop_mask(node_mask, cpu_to_node(prev_cpu)) {
+		/*
+		 * scx_pick_idle_cpu_from_node() can be expensive and redundant
+		 * if none of the CPUs in the NUMA node can be used (according
+		 * to cpus_allowed).
+		 *
+		 * Therefore, check if the NUMA node is usable in advance to
+		 * save some CPU cycles.
+		 */
+		if (!cpumask_intersects(node_mask, cpus_allowed))
+			continue;
+
+		/*
+		 * It would be nice to have a "node" iterator, instead of the
+		 * cpumask, to get rid of the cpumask_first() to determine the
+		 * node.
+		 */
+		cpu = cpumask_first(node_mask);
+		if (cpu >= nr_cpu_ids)
+			continue;
+
+		cpu = scx_pick_idle_cpu_from_node(cpu_to_node(cpu), cpus_allowed, flags);
+		if (cpu >= 0)
+			goto out_unlock;
+	}
+	cpu = -EBUSY;
+
+out_unlock:
+	rcu_read_unlock();
+	return cpu;
 }
 
 /*
@@ -3427,6 +3538,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
+	int node = cpu_to_node(prev_cpu);
 	s32 cpu;
 
 	*found = false;
@@ -3484,9 +3596,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
-		    !(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(get_idle_cpumask_node(cpu_to_node(cpu)))) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -3500,7 +3612,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask_node(node)) &&
 		    test_and_clear_cpu_idle(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -3510,7 +3622,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -3519,7 +3631,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same NUMA node.
 		 */
 		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -3527,7 +3639,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Search for any full idle core usable by the task.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3544,7 +3656,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3553,7 +3665,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same NUMA node.
 	 */
 	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3561,7 +3673,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, 0);
 	if (cpu >= 0)
 		goto cpu_found;
 
@@ -3643,17 +3755,27 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 
 static void reset_idle_masks(void)
 {
+	int node;
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
 	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
+	for_each_node_state(node, N_POSSIBLE) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+		struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
+
+		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
+		cpumask_copy(idle_smt, idle_cpu);
+	}
 }
 
 void __scx_update_idle(struct rq *rq, bool idle)
 {
 	int cpu = cpu_of(rq);
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
 
 	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
 		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
@@ -3661,27 +3783,25 @@ void __scx_update_idle(struct rq *rq, bool idle)
 			return;
 	}
 
-	if (idle)
-		cpumask_set_cpu(cpu, idle_masks.cpu);
-	else
-		cpumask_clear_cpu(cpu, idle_masks.cpu);
+	assign_cpu(cpu, idle_cpu, idle);
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
 
 		if (idle) {
 			/*
-			 * idle_masks.smt handling is racy but that's fine as
-			 * it's only for optimization and self-correcting.
+			 * idle_smt handling is racy but that's fine as it's
+			 * only for optimization and self-correcting.
 			 */
 			for_each_cpu(cpu, smt) {
-				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
+				if (!cpumask_test_cpu(cpu, idle_cpu))
 					return;
 			}
-			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_or(idle_smt, idle_smt, smt);
 		} else {
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_andnot(idle_smt, idle_smt, smt);
 		}
 	}
 #endif
@@ -3729,7 +3849,10 @@ static void rq_offline_scx(struct rq *rq)
 #else	/* CONFIG_SMP */
 
 static bool test_and_clear_cpu_idle(int cpu) { return false; }
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	return -EBUSY;
+}
 static void reset_idle_masks(void) {}
 
 #endif	/* CONFIG_SMP */
@@ -6262,8 +6385,7 @@ void __init init_sched_ext_class(void)
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 #ifdef CONFIG_SMP
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+	idle_masks_init();
 #endif
 	scx_kick_cpus_pnt_seqs =
 		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
@@ -7409,7 +7531,7 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask.
+ * per-CPU cpumask of the current NUMA node.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7420,17 +7542,13 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 		return cpu_none_mask;
 	}
 
-#ifdef CONFIG_SMP
-	return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
+	return get_curr_idle_cpumask();
 }
 
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask. Can be used to determine if an entire physical
- * core is free.
+ * per-physical-core cpumask of the current NUMA node. Can be used to determine
+ * if an entire physical core is free.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7441,14 +7559,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 		return cpu_none_mask;
 	}
 
-#ifdef CONFIG_SMP
-	if (sched_smt_active())
-		return idle_masks.smt;
-	else
-		return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
+	return get_curr_idle_smtmask();
 }
 
 /**
@@ -7515,7 +7626,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 		return -EBUSY;
 	}
 
-	return scx_pick_idle_cpu(cpus_allowed, flags);
+	return scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
 }
 
 /**
@@ -7538,7 +7649,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 	s32 cpu;
 
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		cpu = scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
 		if (cpu >= 0)
 			return cpu;
 	}
-- 
2.47.1


