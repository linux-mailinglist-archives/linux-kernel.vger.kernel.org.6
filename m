Return-Path: <linux-kernel+bounces-390095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8FB9B7568
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CE11C24C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8589D1494C2;
	Thu, 31 Oct 2024 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AzdPY9rN"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F7146019
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360054; cv=fail; b=URBwUYYsT+B+WkJF4W9Sy9+co98ISmv17eTpPK1z9SEqLmSbb/YLt4SfJnxg8zSsB3BbCiLxnXEGK2/2dc0alkY6e1OYDOQ/5oVZTw3Ax5fsKdmeyyb+NnRMuBEgCvD4z8lDm/siQaqCYj9etwRLaVmkR8yZ77ksqua52f4VRWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360054; c=relaxed/simple;
	bh=pQCc6EOLcjbNtJJCZcf+8VMkL+OEseuGMeVpviGi7XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C44fqABewd3KLYk9LWmREXTpFuLpbY35wxt1HtPsv/BdUbhN0ci1clC/IspMAlYDro5djUdGf/jnQ7aE0DGF4fkKGI0CfGVoC8oVfZoNRV+bm1uXrmo4YcUOQudKkclNtWYfeYy1s7zpwKutp4pm/zkzsWj7cJAIlJqgMct1W+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AzdPY9rN; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMkvzlxRnnINVamtuAIGHIZJAFjoPrm1/toJajWZhQ01bpe1Y8liAL9mTRaf84rm1PGT7b4AkT7V/pOm3e4meAcZDa49TMflqLRlsmXrGW5T4aUHIcNLRk30kQzC7WhGk68pztNJdOdzY7tS5Q4R5EAljsJ3PR/W8kF4PQ1BP2EN5iHjAOROKctnbCjuWgz4tti6y/iIv6VqLzwBKNcUuUXQT5H3/F+Uc26O8DADzR3tqWCiLfj3kKf/A+iyUFghprLMPHio7yEKp/ASTgExMT5dDRt1xJbdWes54LKKGS3q9FjYY5MILJLU8XUExk4mZgAvBQd35Ku4wHwyM5HyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjwCbM6OIVyax3G6r/RuXw5H5BpFZu7xIJJ9ZgZugbc=;
 b=hNOyIfKXu3PlygEug4sYWsCfodL4iw8dEIvOOlzhIEDXBThOieSeCH+ZzV/8C3x6Od+rcFh8eL5l/qDxWfmWjnFRl87cQndaABODz0+lO+qe371UbwxWXj1JKQY2lJiY/6edXtWZDtLLfMPqIP043Ydr3Z+TfOAzRgYfVSxuzHOfG4eV/Nqkgb33dX2di3veC7R+LemIckJPAkUyS1LWh23ipuMgD0F2COzyV9bP828qkrqTeSEASFVVR5VFsXIJTuzWfJqlGtPvuB+hnGa7i4pkDlJMmYCmZhd8w0ZNI24p2dYe9HlK+RwlN5pXQ3tZzuakqhacTuHn7MILAU91eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjwCbM6OIVyax3G6r/RuXw5H5BpFZu7xIJJ9ZgZugbc=;
 b=AzdPY9rN4UYpz7uaOQmnRHdqdNMptzjNacMeg+Ci2JbBog6Eapgq1WBzseqPYN3GKSK5Im+r/EYjV+pf2Kb8S2jnLOsUWf8SVKmYZh0sgvf2sEs0ND6DpmUBvzEVZEorVScwD8IxKhpaTeB875aVVIwbvyqgizsul4ZDiSD8wKrAjhTXhFdZs5QjDSwOMXfQd4Xgjyn7u0tJtlCdB9BeZKaZZ2JFDJ/0IEUBvuhdoPgrunQO5XBvV5KhhTS3co1sxGG72Prx2UZ7G9V7nDS4bOKaBX1yeTlFzNfAxCqjcCCD/19bwdO8IaPATLyR/TQJXvV9FcaME7DD8wMVLtRLhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:34:08 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:34:06 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA optimizations when domains overlap
Date: Thu, 31 Oct 2024 08:34:01 +0100
Message-ID: <20241031073401.13034-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0475cf-981c-4416-c2d9-08dcf97e669b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWZBC+sZ3aiC8zm3al+/xPJoLp/EynmSCVeVprbfAJM8Ys35ZgegDkEQ33RV?=
 =?us-ascii?Q?9cpK6TM0Hw+B2ANTymmnAovZTC6VVgPLHzP5ivDGo3STQfNL/ulOiO/EibcB?=
 =?us-ascii?Q?ttg5dDkJLpJlC4bMFE9D9mt8PcA8MzNMq4e3gRcLCXL8wTVRK0gFRSyTwe97?=
 =?us-ascii?Q?E5OqyBSbNQGm3Ol6iYv20L/CcaFSU7l5G2HFqJ9VvIwmv8uBjyf47bqZiVzh?=
 =?us-ascii?Q?B637r68uT6079eh1s4RWa19+bBjPV0YTwuxyWYIXW6RWwZmvmRBNfMAaRXsG?=
 =?us-ascii?Q?zw0mukH3WvF5Zdw3Rp3QwAN/C1+Y1Hq0Ol8b38OYxIl1JqU3tv+UtTEdtmMB?=
 =?us-ascii?Q?a4Ug56BWAidElZomrLjD4lZKc/Db9pjuPbugmZrEpcOU2L3z07GyHKP3gkCN?=
 =?us-ascii?Q?PQE7Do56gAzWMwYc7oC5BGq8K8BeP3uPhd/+0fc18X6x9it9gZRZw9DsLENL?=
 =?us-ascii?Q?qFahoCxspReN/neKm+uuTKAt+xgEuV9kGi3t6Oj9oy/wEaHAhut4BNL4a8qj?=
 =?us-ascii?Q?GEfgpyshnhYc5yjV/FibcWVomIFL3drb/fn9Q5KvTf891GyJNujRkjOQAU4L?=
 =?us-ascii?Q?7ZwmK372PlwXKtsf62eT+eyftHWVrom8ZglJ4cOUx1dAuSsYto1vmqs26jRr?=
 =?us-ascii?Q?tftneIonyFWP0fldo+f6F5P7Iwhlf/FX650Jeil9pwB3QiwG9wAiioLmAAJv?=
 =?us-ascii?Q?iSJmmQSX8kgEMOc0r6JpECpMlYueoQC/QcS+T+VynN+sEgyqdtcVywWTrr+U?=
 =?us-ascii?Q?Od2gU3HR7INTybDTVcei5uwK5Ub3s70axBlN7OnPSr34+9mtnaHWG6G+kpA9?=
 =?us-ascii?Q?heG4W5f2Q561KZ+biBfuG9gJpefU8ob+mNximpYx8OlzG6EzD33u9NWWxQHG?=
 =?us-ascii?Q?be81z1W7dol70qJ+1+MihxiTKK89FSpyXxtsNmjcUgjKwcJXD/59XvsGy8JY?=
 =?us-ascii?Q?QG3w+GWFfps9NQqrJ8aTWjM2tHAvRsa2XW0P/mnnC76Aej0YxoAWlaljkCVc?=
 =?us-ascii?Q?7sjpl/P7iYH1sYWidDEuSwWMimDK5wFHlX+68ea5yDgptcquQ5xm0XMzRx3V?=
 =?us-ascii?Q?hjbJNq3vLl3cI4e339fAG3bW7QdiagJNzvIKrqxqKs29iGIcAx58ZcW1e8st?=
 =?us-ascii?Q?6USdQZm8p9F43rcRx/fLVjR8WBXCcwJAz/BCXjkTEiMIGE2VhuioEHVA+LhY?=
 =?us-ascii?Q?FLQL4AV9m/5uq33Egi2xvR0XbXAUlLZc2tyqSIo51WQ5QsHApiz1i0/4yfCn?=
 =?us-ascii?Q?WojD21FSNxJuSiJ6NbXODt5eElTGDeZVocRWzFSYq/q6jnHK+9kkwhkibXtS?=
 =?us-ascii?Q?jfY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vt3TNiwgtJ3S5AUfC8Kc8YlTTmTLawlzcQcP7g1Rn5Q+Orl+A4Phth5iZ2SO?=
 =?us-ascii?Q?GPXiq7/HSCcHPzuseBGemsX15Y4nQCiIsJK7FUjfRGzieXBT6BzSl6XJXAvO?=
 =?us-ascii?Q?ENY5MDhKA/JX3GEuOwzumXaKP30SHB1M6NS1tmmDEb0faDJPF2er8XUpbmzP?=
 =?us-ascii?Q?gOxzdtIZzmlcOMiSuIkQfNouOKcFZpJLEh5ZxdlsvmyJi3cHcm+Yuo7hQ28h?=
 =?us-ascii?Q?T2cEarJXR+A5f2IhQldChyDtkAWWKBqOuWAo2M3ZNaUT90UTxGB8l+B3gkGA?=
 =?us-ascii?Q?3k5mF9m51VBcDMmA9kVYlll6b3rYLxHx6KeWOO0eMP70lFVoAvaf+PYhW/AU?=
 =?us-ascii?Q?Ybnu6EuJxTcSMDIp+0SKC+0iknPtN6/opB5wEVqQX81BzxypvvEdb3/98D38?=
 =?us-ascii?Q?AE2dcxC2an/qN1vNU2ctB/HzGJKIpmU4ohNNRv5djbVZsDGFCC0FYq5fqTqd?=
 =?us-ascii?Q?o1YknYgjJD33Bcdr7RwT+/cFgmTRr6H06+KA8y/lAtbadoiMRcnFjjnw6+0C?=
 =?us-ascii?Q?QwKW4sPC5n9aQ0ZAGufa3eV9dSG6lAQLQLAhWKeC/bB9Z3IsAUKTDzAXJnT3?=
 =?us-ascii?Q?KxTc9IpbZ7QWhn+6ExOBPOLUpI5okKyCgzV8qxmvOz+lQ7LH2HBmcVra6IlU?=
 =?us-ascii?Q?tg4Ye8epAXCyQM84qq8iC64k3NVp8ymlstKdD+iV9e+ECmXmLZPmk6TqQLNK?=
 =?us-ascii?Q?NFcna5MKwCHp3HHN3zZeGvL2WUJqdkqoV6jQSmDiSLArTCRcDuBuhO1ijHbQ?=
 =?us-ascii?Q?QTbxYBggZarlUWN64p/Z22/u0heJf/wwM3wzz0W9ibCyj+zFOE/jNnC1jyQL?=
 =?us-ascii?Q?ZhyP166BLLdLPOpQjsDcAWPIMpM7L+0DIy57jHwB3zayVbqjSrk4RgM/nmAo?=
 =?us-ascii?Q?uK+b08zNErgozClaDLP5sZgYzoRU4PLomahRD08/wNrXPzQZTqoHbQYCWJW4?=
 =?us-ascii?Q?vkk78QZ+dQmNqvUiFnRawFMWBY3bpo7IpWKGTsX6JQ7KdgcIdyATfkMnFSYi?=
 =?us-ascii?Q?D/PqGWkiIinc8oa15yTvoBYbaPpc4mVO9aXaN02XtWnEIHUEYxf/NTmKO0bB?=
 =?us-ascii?Q?dUCUjG9VQCjF9A2WSw7FmpXWVbSb2Eu9/JgzHsgzSMCk7hxNMJTRXOx3CS2G?=
 =?us-ascii?Q?fh+7Ef4wwu/IYa07pgv4hw4gJaeR+pY11sv/7mm8RziOKgUEWqpwruYQL4ii?=
 =?us-ascii?Q?eMVR6SmeaVBbHqanCuUuMO8fCXx7rL+nb00ZGfJ0uu2PgA2fyfp7+iMGiaN4?=
 =?us-ascii?Q?jNg7zlNL09qLtnIdKZRYLJjVvHy8Vd67/dg4hV9g/qcJw4BoBSxksBj+/UZu?=
 =?us-ascii?Q?pC0wXDU1K2mzClCgnFyfUcqSs78K4T8QBaTYm60qrLmM0L5PB58pcaImKU4d?=
 =?us-ascii?Q?FiNezdPDCaKI3WCTGG0PjOXfvR7FjukTm2fCGAwptHDsUd6MoaeEONlyDHYH?=
 =?us-ascii?Q?BG7CtrfO+Wkdi0JaHzgDaMhW8SkNRdgtEHPSo3mQWPWlaX2dq2I56VqqGUkI?=
 =?us-ascii?Q?2pQrdwy/swvH7ORLFc8xiwGuj4TBr12guLoTZ6hbEdJUYp7Eud/hKmv2OfXM?=
 =?us-ascii?Q?1Nh7C1Eoj8XnbnFgFd2vQvOC4wHF+TdjB3/aeLr/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0475cf-981c-4416-c2d9-08dcf97e669b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:34:06.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bu6Cf3FireRVh5fyodsqUzYZgq2aWcp7ayaKlRYAmn/JeuT+cxjFlrQ9aIooCGBwczEO8xB0j7pMGFbmucZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

When the LLC and NUMA domains fully overlap, enabling both optimizations
in the built-in idle CPU selection policy is redundant, as it leads to
searching for an idle CPU within the same domain twice.

Likewise, if all online CPUs are within a single LLC domain, LLC
optimization is unnecessary.

Therefore, detect overlapping domains and enable topology optimizations
only when necessary.

Fixes: 860a45219bce ("sched_ext: Introduce NUMA awareness to the default idle selection policy")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fc7f15eefe54..82acbaffd5a7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3140,7 +3140,7 @@ static void update_selcpu_topology(void)
 {
 	bool enable_llc = false, enable_numa = false;
 	struct sched_domain *sd;
-	const struct cpumask *cpus;
+	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
 	/*
@@ -3154,16 +3154,29 @@ static void update_selcpu_topology(void)
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_llc, cpu));
 	if (sd) {
-		cpus = sched_domain_span(sd);
-		if (cpumask_weight(cpus) < num_possible_cpus())
+		llc_cpus = sched_domain_span(sd);
+		if (cpumask_weight(llc_cpus) < num_possible_cpus())
 			enable_llc = true;
 	}
 	sd = highest_flag_domain(cpu, SD_NUMA);
 	if (sd) {
-		cpus = sched_group_span(sd->groups);
-		if (cpumask_weight(cpus) < num_possible_cpus())
+		numa_cpus = sched_group_span(sd->groups);
+		if (cpumask_weight(numa_cpus) < num_possible_cpus())
 			enable_numa = true;
 	}
+	/*
+	 * If the NUMA domain perfectly overlaps with the LLC domain, enable
+	 * LLC optimization only, as checking for an idle CPU in the same
+	 * domain twice is redundant.
+	 */
+	if (enable_numa && enable_llc && cpumask_equal(numa_cpus, llc_cpus))
+		enable_numa = false;
+	/*
+	 * If all the online CPUs are in the same LLC domain, there is no
+	 * reason to enable LLC optimization.
+	 */
+	if (enable_llc && cpumask_equal(llc_cpus, cpu_online_mask))
+		enable_llc = false;
 	rcu_read_unlock();
 
 	pr_debug("sched_ext: LLC idle selection %s\n",
-- 
2.47.0


