Return-Path: <linux-kernel+bounces-429792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B339E2498
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB85D287D71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0BF1F8AD4;
	Tue,  3 Dec 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UeqD7mj5"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A511F76BE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240985; cv=fail; b=o1xuH7PRleD824ckMvq3iAhqKAe8Bh2nYH6fa0pVV3luN58Y3J+RJTHgnA6Q+VwI7AA/jGNKJTKCuw3YW0JdpVS5/YcQOLKU2bRID4H1gMTpntpYmvQ2mfAeloUm6lwrNUaNCYWJWbRZx++wkocQzZ+zI9GbJo6J51lvNBS1WRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240985; c=relaxed/simple;
	bh=vwyiuqA48jpGohHI42jXwQUPNtCfOSWPfx3XrkE3dS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOvANQz/y1IsFcJSrzA6l8x26ei8OQzFgtINymom4xGkU5TZg8QMSW9na8f8OJ9P62ZcbJCuT/aI1COYqFpn6HO2G+iL7SSYxTQwemODjQ6hpIwDcq8XluXHuVPUS1j4jat+VW9EKT0yQbw0JlmD6ZstKbKvgqMB3vS+Rq37Xk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UeqD7mj5; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj+v5/kyZClKMCs4YysRH835Sb07My8Umz6J72oOMWkzfVfukE5BSbl2zb+eIS31ENSRFBO0FyW2BHKsugdarU8CpTTTbK4bgyrb9rtxionG35taKWcRP/JIuyZCL2ms8fd+DfeGIQNZcLID/XuPnXzNn9Dbq7/hZLAv7zO4gxXgP6E+gf9hQ6UNDmBCuA1dT6ySUHA++Rkzb7CUwU44UuiHOgrWohhUokN+lmcr/sB8YlBjRKCQpXaW6VeF52+wJrhyn/hFx/x2NXJEY7QBuhvjUqaCCDeHLub7VYyi5k4sqoWF9E81X5XsXPOYjd47ZP4nND2nBBEUu6QWNjY1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrkQVF3P9oDi9rxdBiIVdXsEL/zvI7HOzzDX5rBPKIY=;
 b=FUZElkMSISY+q88dqbpNJ9/PaUP3RVjjC7a3XbFibAZ3qG7GUNTcRt5Gx+5YiW15hmbpKk6EddFaS9oMXh4s9bIQc9cMhCHxfuvifQgj+ZfpItgMGLAW8xaVkjaI48NXVplIR+7AYbb3P9M44sApQvFpgy9drnBtNIRLiuYbcLC0fURFy8iv5v1fMnn2DRVSTQ+iLvHV8ZJpLOOZMbSMqjSH5N+dNV1U8USEZoOMk/XE3u/UdzHoEDRwK8apW2cB1IZXSQc5+BxRfos6A2T4dKUnEUcVL16u9MOdgG92Pl5NhSLxDitjlIJTYc41vjN7xRr97zTTks6sjUnF2sTdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrkQVF3P9oDi9rxdBiIVdXsEL/zvI7HOzzDX5rBPKIY=;
 b=UeqD7mj5eBCRxlUkrRUCq3gzBKFE4Dj2jjAeYgwrx9seE78sKIfkYh+Wzykgyx6CBN7Lh3Kn/IQ0B3J21mXQ/qlQMEJZTRNU6MfUq4mQkwKD0MwWJdO2fnOXv2LAyDzF1TRCRi1Y7mAH60KA2uZjT2Bc//nHcHoaBnUkuoXXFT4YgPp7ld4+Z8uJjcN0DNp5HwxYinuXkl8pLdz+/fmdorNztuJhOg/HjYXOHLdoCGg79nkAHVgSpcMcQ7h7K40LUx3zQzw+nydcrCPiPNKOCloM/iRtJbStT/D5ox6GAAoNSt1MYxUbZZw5JUvg/j5SZiSFhrrCB00tCr47A7eDKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 15:49:39 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:49:39 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sched_ext: get rid of the scx_selcpu_topo_numa logic
Date: Tue,  3 Dec 2024 16:36:12 +0100
Message-ID: <20241203154917.123419-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203154917.123419-1-arighi@nvidia.com>
References: <20241203154917.123419-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 993b66e2-5e95-47bb-0cef-08dd13b2186e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7dvEnE3038pUGy8nYSdnodQrGQOSjzo+dOjEmvbDYl3Q14DQChFYCPEghVJU?=
 =?us-ascii?Q?59VmAsrsDN/vlE3GIbPsS2Wttc1chD5+hO+Q/mRgvfO32HpFSQbW4YNlbqk6?=
 =?us-ascii?Q?e9nwGVns0MkVBdlW9KLOoAGjB1A2cL1UTUWxzBNVblPIziAGGtefXFPRTeM7?=
 =?us-ascii?Q?1BCqky5t9PKbCmWQ/gjK2riNX5ewX+6JFYGm129P7H0JUJ7mpgzqxFwCLPD6?=
 =?us-ascii?Q?u13spdN5LQVh9UyBFcGXKhgO0capfPLGFO8Gad5O+DYUr+ou80+v3rioF8NW?=
 =?us-ascii?Q?SW3BkupPmlbL6kyj0NNlJAKgv15KVhR/wix9BymYhYsrTck6ckWoa6oI870K?=
 =?us-ascii?Q?Mh0MFSCQ6fFS5xhl55I0XMURDahj4/WKgOKG/T5TyYAfulyWB4iIvDzj+ywo?=
 =?us-ascii?Q?jLmUKtbYaVL2DWnaovkkiZOUbJPFHmeNRjtCFtBp3fFsmFvoZZ++sA6z5LFx?=
 =?us-ascii?Q?B//ApiOMgkqDtRewuktgALfbz9Wy+Cnfh3LeUfeJdDgaWoOMOWzm0bBDc25d?=
 =?us-ascii?Q?MA1mfuFz6U7aiDYy2vkDNt0kAOWPmGundNrkT+fbTuVMkS/v3v3VmB3KIRl8?=
 =?us-ascii?Q?4TXoh07Nm4xkCAp15Iv54mq1wLMswZEyeKym6KFXWCg6Ab4kWvD0fSjGGelr?=
 =?us-ascii?Q?tzTeyQhby/Z6s8RjAYOY6ap5GwNJuK/M5wzHUPXAqh2gooJC/emyXAASgmWh?=
 =?us-ascii?Q?lSQLv88AceleRujK7S69tgJoyMjFX0yoLtGU/5lK+v5pVcXY3XmpE1u+Kc/l?=
 =?us-ascii?Q?06kP3odB9yqf13OCSbUTV9KsxyDi1Sy/ckWCimhMcZRLe6tN9jIl/5gNuz1c?=
 =?us-ascii?Q?6I5uttqJDIiYTwlsxs7nd9/+3TZzBInx0EtWLuWlDBxlKttjuhgUchXXMXy0?=
 =?us-ascii?Q?sBGBTatKNlUMxQ/g6EGo4CMK7U4mrGumxMbfuK65K3xyoCYYebeL3LStyG3K?=
 =?us-ascii?Q?0vplpeVOhHoVkvOESlWzfmCq1aFaBuyw3qxyd8XiT8QuxSpVSzgJ3FnU84zn?=
 =?us-ascii?Q?3jk/0piD2AOLyrmqPwPj3Vw8lXOvFk+Z/33w7Rqq1cHeG7468XPt1tUrR+2L?=
 =?us-ascii?Q?TsbB9BlwciVUqRzMMX4kSelWRZ6BN5esSHgVXBXKQ8onF9n7EEkPe9SyWMgb?=
 =?us-ascii?Q?G2CzeUWgjeHrrK3Ngh9e03rN3VSAWYZxfW9TYc6oej6CPcXLuKB2508AfjEv?=
 =?us-ascii?Q?hoVB3cPTXTAFhDWYGrGiS1Q3ruQhVblIbp57muGzUDSv6KE8ieMKA1WAv4/1?=
 =?us-ascii?Q?jLfAtgZWBL26EcxxTTfI/698KSyOWszuqv1yYztka8lsXHSWAiQ/fudaitIt?=
 =?us-ascii?Q?b5sQFKd5MJkssvQzmfxc/zh/laVQ93xKdqqvreQQqWdPTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n8mpSPSfDp6Ccn0eJMfgqY3AoO9oIvUM8QdEGIpZoL20egPMLAG4x8Y6K8Kj?=
 =?us-ascii?Q?bU8fV6IcDh3zt4t65Jtgvn50txB8C6cBcsiCQapq3nuBXciw0evwbTGvzwqV?=
 =?us-ascii?Q?/ok9AlqQw+SMfVkcdVI359HkCBipks1xH3KiIC/E7krHmHc8EKdylQKB7QhG?=
 =?us-ascii?Q?6H3NOr13r7ftlaqNigTLdOIqOzVZQqydxQRsx2rTvTp+4suxoP6iWjnqg+yv?=
 =?us-ascii?Q?/I7spdkIK/TGhAKo4GVnFVAw5pBmQUbmyh1LLM+nLV++OaYcb0UMWnbad4em?=
 =?us-ascii?Q?C3FZyXccARjE4VQop+9rUbOmFCWu5shc3Wf2wE8RF/LAhudPwd/WhNxrcQNp?=
 =?us-ascii?Q?G/m8wD1Tnv+UegwzEv5lBJx1zIONRUPBg1yHm34BDV9vxQNOcXjPj1ZsOhmY?=
 =?us-ascii?Q?Jmd+05lYz2ezKiw1UDTZqNgw86qUtL0RX9kdNgjbJJdolS4dm/tplGRtjVA2?=
 =?us-ascii?Q?/fonbY6ZLdOWFpzPxVd/BYI+cpuAkOdspduN4qop0oKCbYJ7Q7C2L00hesNd?=
 =?us-ascii?Q?Gm17pCoN+WE9lVRx0BH3VkmPhu116iK1M+k2RXz/m7j2Y4sqpwcfzuNTlKLI?=
 =?us-ascii?Q?xwkqp3SD9w8P2Y2X6qjILM+L+Ft55yI4gtYbNFKKWJ9omeRm2lxaJjGZx0k0?=
 =?us-ascii?Q?axBN38nXQzm19RjtDyqAJSDQllmoON4la9Ah/5a9nJylqYq6h8pgP1AP9mZi?=
 =?us-ascii?Q?qsmh6gQfx/0b1YmMxZAuId+5Z0SOyNAnBj2f2LEnQGOxxVViUWzuYtyzMY1F?=
 =?us-ascii?Q?VN/JnryVOVnbofe7iA053eKjUylG5pjGE4KsSC5QbC+dZ9MQXEEB9Ieyg3Za?=
 =?us-ascii?Q?DmmNWDnvZvXIhJdGdZUVB4BmU1/CE/TZSqNo3oRU89bqOjUUxG4dOPukU0Wq?=
 =?us-ascii?Q?fJ1Yz2c+42n+pNqGYzmX8uImb7N7dkvQU6Hdc9BJ/j9C4OEiXZSqbAKFjXmN?=
 =?us-ascii?Q?8aBcc4cvKMUMmo/ikxVVIpzm7E/Gu4FA+3PIFjam6kqIkgqJWo7TuzloOPIj?=
 =?us-ascii?Q?oG0hh24WV2GjGN/N+7Vs/O0MfmTKHWgnRIvZWkGD2by6ese2vjFjbR1/XreY?=
 =?us-ascii?Q?X30FcBD0eihkWZ2fQdowwk5Zqpr6s5AL8FIFBafqnSb3LHn0BuWMTcD996Xg?=
 =?us-ascii?Q?eNrrdoOYiIGJUCsvYzPsCNRzLJJ0oe4EVnZOX8rWVW5j8fkPQrsLac5gYxqq?=
 =?us-ascii?Q?vp1unRuocrZPsFbVOPQDe2ECwZtYyq80V1YDuXGz5kpu3XB0Gn+6liLV/IGb?=
 =?us-ascii?Q?2edPfRE8SzfxeWoiStULP+K7aAtRd4NHeKcj7zUM274nsGAaHsi+AVuAAead?=
 =?us-ascii?Q?UWOJqWB4QLlKngpWvRkM8YyYOdNMQN5/lc+paf0RQl3B82A6egegdWbsgC0P?=
 =?us-ascii?Q?V3m4QVUBtlgeZ6hVz6+JI9YUHf2UEZIIzGd6WRTQ/Sbz9bX2TzmKXEX6uJ/c?=
 =?us-ascii?Q?Kkc4alxMiuL381AakZFU3ZqTQ8vfVPkEWPK9v1MFTtdePto3DYFt3fAX/lpA?=
 =?us-ascii?Q?UKxQUttCha7oLtbPRYswFqCWp759V2qx4bIY3hLO+bGYjBTKYU+HJulPp7ne?=
 =?us-ascii?Q?EEsszWiHwppAG5ueOeeG+B1rGNlt7aGZ1Ra5rt82?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993b66e2-5e95-47bb-0cef-08dd13b2186e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:49:39.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MmogYXobgaQ3OP4Z6+T6BD8vwiH5jjKs/reez14qPpZdaa3Z25i7G5cYlB61MKJTudLyAIchyNgenmK0hs/UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466

With the introduction of separate per-NUMA node cpumasks, we
automatically track idle CPUs within each NUMA node.

This makes the special logic for determining idle CPUs in each NUMA node
redundant and unnecessary, so we can get rid of it.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 57 +++++-----------------------------------------
 1 file changed, 6 insertions(+), 51 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index cff4210e9c7b..6a91d0f5d2a3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -886,7 +886,6 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 #ifdef CONFIG_SMP
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
 #endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
@@ -3235,10 +3234,9 @@ static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allo
 
 }
 
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
 {
-	int start = cpu_to_node(smp_processor_id());
-	int node, cpu;
+	int node, cpu, start = cpu_to_node(prev_cpu);
 
 	for_each_node_state_wrap(node, N_ONLINE, start) {
 		/*
@@ -3319,9 +3317,8 @@ static bool llc_numa_mismatch(void)
  */
 static void update_selcpu_topology(void)
 {
-	bool enable_llc = false, enable_numa = false;
+	bool enable_llc = false;
 	struct sched_domain *sd;
-	const struct cpumask *cpus;
 	s32 cpu = cpumask_first(cpu_online_mask);
 
 	/*
@@ -3337,37 +3334,18 @@ static void update_selcpu_topology(void)
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_llc, cpu));
 	if (sd) {
-		if (sd->span_weight < num_online_cpus())
+		if ((sd->span_weight < num_online_cpus()) && llc_numa_mismatch())
 			enable_llc = true;
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
-	cpus = cpumask_of_node(cpu_to_node(cpu));
-	if ((cpumask_weight(cpus) < num_online_cpus()) && llc_numa_mismatch())
-		enable_numa = true;
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
@@ -3388,9 +3366,8 @@ static void update_selcpu_topology(void)
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
@@ -3399,7 +3376,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
 	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
 	int node = cpu_to_node(prev_cpu);
 	s32 cpu;
 
@@ -3422,9 +3398,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * defined by user-space.
 	 */
 	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = p->cpus_ptr;
-
 		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
 			struct sched_domain *sd;
 
@@ -3494,15 +3467,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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
@@ -3528,15 +3492,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
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


