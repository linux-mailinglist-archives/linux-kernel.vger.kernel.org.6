Return-Path: <linux-kernel+bounces-437245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 691219E90D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E3F1883E57
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C240E218823;
	Mon,  9 Dec 2024 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xz7IBI1A"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB6216E00
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741211; cv=fail; b=o4KnUrBd0BRsJjy0bmrEWNVZ29h6sx2ZDWbz34hqJ8yao66065Sak3cwiCTSA68AtKQ0kOrWyVAcBEJBO2kGzMyPI8RzXmPtUF7FbI6CFtfjqMKt0BIR9WNQeB3bn+5ptCJ4J34+IcCwliANagsx4UuP2kfaF8xsQ5NZHIBA1ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741211; c=relaxed/simple;
	bh=+GXQvEOMn37dYIlHOfq/T1TBwmVcRCg84JgwcCaf1fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sfLDDZeipoIIjnzUqo2GP2HVIzVjZlVD+NJBXhBGiq3cZJE61kkDuWDXNido0/k0JTlolCC/DhTGxwYvXTJCCL6f6OIUxamBw0/vRsiTDeIFbbpxOmAUOyw3BeY+1odoF/ow9RI/pvHZHoVKomSV0KfxvL5qLZKKjoOwXypyL94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xz7IBI1A; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBNBNMaegt0KosbAkb4jXTXy8jeghJmzFlg+Ovbut7SomS61cgASQP8rygLpeW6OeBjHZlLVv/plie/uVJSYiKkxLXidn09KOAMGfPjeZtEig+gHLm8BQTsM+58+9DTSszBhEYMQWGc54ExQLdPnPps+SKp8juHDN8vRihd6HIT/JAtCJzraxgs4oY12dbOKgw7q5o0kIbWgZgHIROmDPfYTZq6yzDXeAPoYXpsFb900VxQckvoQsEmxj671Uqibvg4sv2pI195n/1jZDzi71wOugoCruRciUgWTbWsS3Cdr7QtvW4W6AuiTJDSWENoPpu38gm3Nfo1LzfjUTm/0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo0ltBXhc9vnRKivw8uGR35YJFwIvzmZFzkwKiPvYZM=;
 b=El1UTiMf9YlPTofrtuVj7D2Byn+r+1VoxI92NViSzPyKGUTKyaPTf9+gQoHrnKBmyDuGI6/O0pY/8u/8MoKnXV21putAsDC9nAWGvyMWzwu5Tn0nfeeE8SCO+8sspqvxv762NWu4MY7UeB6KFoLy2WxxIwguQbJmGMOkysnDoeiFlAWVlKfcXjaNeFL4Jv8IDR9sTWCQEGGO11x9yndVWAj1oA5ebEBRzeJVAYlxGuwyuhsJ24Hn+Vf/mAI3lyvoVmDRPbFgNZkH44k9MDV3xsonWxjYk9+VEkp9n/2PtOpkJ7lZQ104LAwbNO+xFCLQ5lkZehyTDg+rOvRmDU8Whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo0ltBXhc9vnRKivw8uGR35YJFwIvzmZFzkwKiPvYZM=;
 b=Xz7IBI1AipX/DRe+CrLih3fpPGjSnbm1AzGz6S6Nvq8UgiJX0xF95yu6gPkTJcnCsZR+b71vVD3xEogWhQq459WPK/9jotst9733Tk1IN90oz72bf7MQhYvT/kCfAoe+26ktws39mVcNbmnq3b/b+PXLJEWpVRYWoQJN/6/VtCSrhetUus63RQzaSC0s7cykqbhZ4HVvBwMZOdPKRlnTJF52Otj+zwNsfmBBu7+R2BU3MMinyEVkRQx1qFRgBd317AM+q8pQfXt9QFrQwJyLs8UakjwGTFa+EMwE3I9VgwSGTRR0Z1K0+yUbavj5IZRA5Vr5Xqwd5OrO3PS8469kmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Mon, 9 Dec 2024 10:46:47 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 10:46:47 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sched_ext: Get rid of the scx_selcpu_topo_numa logic
Date: Mon,  9 Dec 2024 11:40:56 +0100
Message-ID: <20241209104632.718085-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209104632.718085-1-arighi@nvidia.com>
References: <20241209104632.718085-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c14911c-f429-4f9e-e177-08dd183ec770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjzDLi4wRNX9FIaE2z7LtfkGZUUeqU/siIwIv3NOkde+I73oVmBTd6b1gXHd?=
 =?us-ascii?Q?bokEAIJOkUyOs4O52KOQhPXVm8xNDGOpvGNWzoF6EDLVt/B8nAl/Z4BlSzUO?=
 =?us-ascii?Q?79U9Ts918M6ICMwIbUb1nbkRjgow5rrBM+xsUgylBNXvHTOZcHMVzHSHQsI4?=
 =?us-ascii?Q?AwOo+D07B1QgVAddW8FsQHrayyx2bq3kws6gDjsLVoZHmZVwIH+v/yTiUS9j?=
 =?us-ascii?Q?1tX/7uLKJig3xqXWjKw/Tmu7aKNgu1WQ66z6AG6QK9jtOuzkPBD9Csj+dc4H?=
 =?us-ascii?Q?vAhYiCKZOwN3EYVRgigilpKAroJecnqg3cLfiOxwKdSle4N0Bs55RPAOgekg?=
 =?us-ascii?Q?Pf8VkSK/9Bo4JS+FDrQWkUkEAJltudmeSBLmwHycaP7t1WgEcDCuf18QBfiE?=
 =?us-ascii?Q?GS8fb4KAl/a6BM58FIEqqbgEg8rIMCrjtNdmlzT5GJ3SUok1HPCBHaC0SSl/?=
 =?us-ascii?Q?GSlY+L+vJIBTe3UjFXdJv43kK3Q9znMxMb0rYxKxZr1+jP886d2tJ3jW4xeA?=
 =?us-ascii?Q?SoMM93PNYTVcgjoFkbWM61lXYY1kImwEVOXq4YMLRu8z8kj3s5Vj6hTZQCav?=
 =?us-ascii?Q?+fBzsyWLtPIYISp+ICy+EAcrqoO/+7HAze32zHDXl79Alat12xM+Uqkl0voC?=
 =?us-ascii?Q?QzpVvJ6ZoCxnvshINkVmHKQFraPQOKIZBUU/EnfFuaC7aV5xaUFQWd8p5ddj?=
 =?us-ascii?Q?rt/TPtKiazTZ60O1CLY2QfveED3a3WIuUlG88/WDEFAZp6IxGHM09exGXjP9?=
 =?us-ascii?Q?WNEXbz/F9tzxBz45QDH+ErZyCccu9V3oRqnrCus7T0vJKjp22QjRXHZSAm7l?=
 =?us-ascii?Q?OTvbX9HJ/Fc4IWtXIkcvPW1KPXjScaDErCtHZpkqV8sIiDHgtueHAETGiGNI?=
 =?us-ascii?Q?SiXKzhKcJIvhPyjlous8hdVgdK6gEFYgOh977ZHeYH91uHvJEecJ97Q6Ps6M?=
 =?us-ascii?Q?qAlpY7o3DCLn7zI6y203N4TwoqCSGoIwjzMlTDPhGk9kJk5OvjBBPETX8gi6?=
 =?us-ascii?Q?PIOa/uTRNSJqhfIKr+rhQz/XXuB52NFNHyOoTUs+hk7V4DwtMptKcWD7Ytz5?=
 =?us-ascii?Q?67vCXF8YanEV4RBYdS9Fqk8auvDHgBb5OBh/mAGwbeDyifEG+LMgLY6G67O0?=
 =?us-ascii?Q?cpWsez1DctLv6vmLASTqi4klL8ICrHtiAwa6luCZ+HYLv1T0y0lWcdJTNM38?=
 =?us-ascii?Q?ebc3PlmL4EB6BB7awoustSuQwdaxeHgqXvC1GxWSRGC3m4zik0GsaS6a4nbc?=
 =?us-ascii?Q?f1rrhFkZQmod9fdh0vhtGR3pJBZr8ORt3s+KIxKUIfZIoFd9IlTRrF/GLsBQ?=
 =?us-ascii?Q?uIqtQcs291YAVotkmI+Ug2F1a0RwyAGxjBAzCylUDTNW2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wMesPLj6wUJ9dvN5CSpE0PPqPMoEdiqKJPSH5/OT+WZcRC4zHlND3ofg0RN?=
 =?us-ascii?Q?vJ89o/I7xiiqSu5KDUbWM2Ofqnj6L9cp3mT/CY86U+vQWAfNDO1BK4Gc9Jri?=
 =?us-ascii?Q?4dDGFMmj+WzDZbLupBZjIxBiLe68DCwkhT0MKRjJFxUJ5jEFzOQQfRrDJUvN?=
 =?us-ascii?Q?+qojY0RgbGvRe3FXfw/qVQja8eIDFTQeWjp1jEmjrAziP/ROALt68SXChqvN?=
 =?us-ascii?Q?MQTg4XxihT2PBcwoOT51DGzVDa5v7bdvBWtdn4J5w7nceeqqCAaaj7N3GIOk?=
 =?us-ascii?Q?rE5ZAhRIpVjVA8TbJ0MbcDc3ivP9jz9U9w6eh4Op/3nxTb5Zxwhu9SOt9shV?=
 =?us-ascii?Q?xEHcsBgkz7cHQY+E+vKA116F6xLMNLQXuHGASqvglfRvcQXHlrLJLZRThhpi?=
 =?us-ascii?Q?Z6OBj+D/posCyj9owLqyeqwXYUPa+krEQAnGkj55pAsPEUCThZ5nfmglkKtw?=
 =?us-ascii?Q?qQFQ6Vhqn8acVMYzrav4Nwc5wM3nlAyzeeqJi7ghzHRg8WEbPvT7p3d3deW3?=
 =?us-ascii?Q?oqMjRT/3P4ekytc1D4gJ+lpJRJ0Ns7jEKDg9wiRzoZ1pJXdt7nh6XqWkqxr0?=
 =?us-ascii?Q?DMbMljWR0zHRoEEiamlRzcdRvYC82UPbTnsigvDiZe+OZyR2Pl0OkMu8nZjk?=
 =?us-ascii?Q?fiMI7aVwRkpn9IvNM+6xCPMhrAfhD4IcJU11hcOkC0V7g5zyifZYa+ohqO3M?=
 =?us-ascii?Q?FvxwytIqfdOZvgIq8RIJZ0Gzgl1f505Es7Q8SYM+GzpLH73X2MxxMS3zZ4Yk?=
 =?us-ascii?Q?dMv8I70h0g9yXCl6abrYcdA6LLQV35G9TjsSTL5XDW1/WIV3WN8DQ1mVgZWC?=
 =?us-ascii?Q?3D/l8nhn2oQJ0kwT2yXkxxtMg2pMJWkaXnxdmkQLSl2Mc+H1RvJmVGm1fETG?=
 =?us-ascii?Q?NRUpRPaul9Gt1z7Q6bh7HTDldWhxKNXZvQJuwmu47Cs7Q1n8m92YWKlQvah+?=
 =?us-ascii?Q?TWj9gUzB7aRWWoNW2fXebaxNXzVH8Oy4OGcb4U04biDGn/ums7E3fHS20Qgn?=
 =?us-ascii?Q?Jue94I2U6qQ2vvTL+c37pkiV8MSkwGEHZoAZLPnsxNqvwBGFYeIhuCKTq9Pv?=
 =?us-ascii?Q?wnj0GdHDK8UG7fLUpkiVRqafgPYmF/qjoUtZP+ccpEKxPkzT1dveLcdLM+vo?=
 =?us-ascii?Q?7///p1CtAMeh+jek9RnWOorJCyukNPX2o64DVPoGF7Ms/gA/O2pnc5Ismn+O?=
 =?us-ascii?Q?j3/OfDtUHBZUx/jSjkmZfZ8XGciyGQblAs9f6ruXUpRE9Gj7+myBkmspuxs7?=
 =?us-ascii?Q?yaKTYBGa0OvFN/PYpd1Z+hzMGVDO3Zd6lghDJbArPCSkGWHXbuh+pJjuyAdm?=
 =?us-ascii?Q?KvdYqFp7BeL4Sc+yIyB7lHO3BV/fTn26k3OsXnrFPPWXEU5pTZmLkZlisYEB?=
 =?us-ascii?Q?RW0GnBRiLeD+rVTia+mVgBkgFvRFCc7L0tfHKc3vRgyqnbDMDPRDY/YitAau?=
 =?us-ascii?Q?fCMTYTp98TeurMIaItzEFyFGu2Bj8OkoQYihs1tQuqQ1GW8xhd3qrIG5fPVT?=
 =?us-ascii?Q?OETj8B5+3mZB68bpqSwzHC2EXl2ST6z+mi8jumhtWwPz6v4vKhMR4rRCS/iu?=
 =?us-ascii?Q?zpUpSdv8JwfdjlUqYdBppVmHqOBgzg2omGVNy5U1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c14911c-f429-4f9e-e177-08dd183ec770
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:46:47.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pALFlB86e49uSu6pv0wm284hYUwCErkQ/5EO0eiPw4kUrdh0QFaAasPTF6Z1rrufP7gmsHc8+5EvpzHTIPjSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

With the introduction of separate per-NUMA node cpumasks, we
automatically track idle CPUs within each NUMA node.

This makes the special logic for determining idle CPUs in each NUMA node
redundant and unnecessary, so we can get rid of it.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 77 +++-------------------------------------------
 1 file changed, 5 insertions(+), 72 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7e7f2869826f..ed2f0d13915c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -886,7 +886,6 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 #endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -3375,25 +3374,6 @@ static unsigned int numa_weight(s32 cpu)
 	return sg->group_weight;
 }
 
-/*
- * Return the cpumask representing the NUMA domain of @cpu (or NULL if the NUMA
- * domain is not defined).
- */
-static struct cpumask *numa_span(s32 cpu)
-{
-	struct sched_domain *sd;
-	struct sched_group *sg;
-
-	sd = rcu_dereference(per_cpu(sd_numa, cpu));
-	if (!sd)
-		return NULL;
-	sg = sd->groups;
-	if (!sg)
-		return NULL;
-
-	return sched_group_span(sg);
-}
-
 /*
  * Return true if the LLC domains do not perfectly overlap with the NUMA
  * domains, false otherwise.
@@ -3445,7 +3425,7 @@ static bool llc_numa_mismatch(void)
  */
 static void update_selcpu_topology(void)
 {
-	bool enable_llc = false, enable_numa = false;
+	bool enable_llc = false;
 	unsigned int nr_cpus;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
@@ -3462,43 +3442,20 @@ static void update_selcpu_topology(void)
 	rcu_read_lock();
 	nr_cpus = llc_weight(cpu);
 	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus())
+		if ((nr_cpus < num_online_cpus()) && llc_numa_mismatch())
 			enable_llc = true;
 		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
 			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
 	}
-
-	/*
-	 * Enable NUMA optimization only when there are multiple NUMA domains
-	 * among the online CPUs and the NUMA domains don't perfectly overlaps
-	 * with the LLC domains.
-	 *
-	 * If all CPUs belong to the same NUMA node and the same LLC domain,
-	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
-	 * for an idle CPU in the same domain twice is redundant.
-	 */
-	nr_cpus = numa_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
-			enable_numa = true;
-		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
-			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
-	}
 	rcu_read_unlock();
 
 	pr_debug("sched_ext: LLC idle selection %s\n",
 		 enable_llc ? "enabled" : "disabled");
-	pr_debug("sched_ext: NUMA idle selection %s\n",
-		 enable_numa ? "enabled" : "disabled");
 
 	if (enable_llc)
 		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
 	else
 		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
-	if (enable_numa)
-		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
-	else
-		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
 }
 
 /*
@@ -3519,9 +3476,8 @@ static void update_selcpu_topology(void)
  * 4. Pick a CPU within the same NUMA node, if enabled:
  *   - choose a CPU from the same NUMA node to reduce memory access latency.
  *
- * Step 3 and 4 are performed only if the system has, respectively, multiple
- * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
- * scx_selcpu_topo_numa).
+ * Step 3 is performed only if the system has multiple LLC domains that are not
+ * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
@@ -3530,7 +3486,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
 	int node = cpu_to_node(prev_cpu);
 	s32 cpu;
 
@@ -3552,13 +3507,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * CPU affinity), the task will simply use the flat scheduling domain
 	 * defined by user-space.
 	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = numa_span(prev_cpu);
-
+	if (p->nr_cpus_allowed >= num_possible_cpus())
 		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
 			llc_cpus = llc_span(prev_cpu);
-	}
 
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
@@ -3620,15 +3571,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				goto cpu_found;
 		}
 
-		/*
-		 * Search for any fully idle core in the same NUMA node.
-		 */
-		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, SCX_PICK_IDLE_CORE);
-			if (cpu >= 0)
-				goto cpu_found;
-		}
-
 		/*
 		 * Search for any full idle core usable by the task.
 		 */
@@ -3654,15 +3596,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			goto cpu_found;
 	}
 
-	/*
-	 * Search for any idle CPU in the same NUMA node.
-	 */
-	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, 0);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-- 
2.47.1


