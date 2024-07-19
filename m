Return-Path: <linux-kernel+bounces-257386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D993794E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D9D1C21100
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49B3126F0A;
	Fri, 19 Jul 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rweOgWAC"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46D31B86D6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400196; cv=fail; b=ua3UYKm1FLpRVPClL7pT00Be7K4lhvTuxstrr+1qp/h6me8FnVi4hizxfYpKFcZVJT157/o/+KOMnIqZ9tjGkR2rFJVlt4qD6+UM0Lu2zsJsCD2EVNiNzXCCz9s06+729il+VYuql7w7lK+NnsVM5UIidM/v3lmYnJTCfgJiyOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400196; c=relaxed/simple;
	bh=95scMESVezZP5unCqyRsT9Rzsv9eLtASOlHR5CafA4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CiT2yS1SQBqgVbty5tcPiFlUABpDWm9Z7UxtHNXgrM1aKYQK5O7RAv5BqpQIbd3DFvN5qlqTUWVt/4lwKbRuTcsMP70+dP9Qm8u+j2zU6LpunrYTQF2467J83eKFoTIU+LBUpw1PzHJX3aRUx4jKsnbZ6+ZmXxDNlooJQ2csB8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rweOgWAC; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqxLZQSjT9EX4VdpruIkiICEMs0t4bO7abTNiAllwnh3LfxdbLIUG47udIjCbSSbNXzejybnRHvk8yxJnfdxQZR60tsLeWmo/0sFFgNU2zloWDPUVRTBUUiJxaHG9VtXEIbLCL+e7LqA9i6zdnZH+qJNcFZrfK4Is/+VLI7T0ZsSPgrfTk71Q81P3qcCb2ROJViYgoGac3zc33C4z3ge3YaIH5Xa7vxGrdDguNI4eMW48loeIqdlXldISew3zpoiXiQKiKpmpX6d1phH7r7+hmBBAVRdlGhJzcDINMAKmTVeZ1zpsy61dbflVJwEMeUDhCZY3BQSjXXgrlFARbc1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7ArFvuePSWI2SLkIisr3FxXyJh02NNwl14vvvrY/bw=;
 b=GULG3zNCwYrH6VBbH44TZKq5v5LgE44S3cYDZ2DHBYFJmKmCYwRge01xK7b79tn9UPTsgSslU+ZBbF/0N3HsKLhPwO81htiRpKDqbn7aLGOW2b0vI/VqqA33vCkNxWppP+7DlL0vHkSsOd9hfONdTr7+c7dXsw36/7vpKQFhm20P+AyybsypmauecZerjgQWtIBlGPyXhfm0fUKOdnoUndB6/wy4d9DM2hQIjYXEiRiQgoNyWmfs5n56Bsvyx1aaxAp0FXIKyJ4F0a3Xe/lEan1bsx/XoARcV3cRGfFfw268Rbi5bwQgQtkniyhA373SmdGELr7YOrb/yjWDoF0EpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7ArFvuePSWI2SLkIisr3FxXyJh02NNwl14vvvrY/bw=;
 b=rweOgWACw7miKnvht3vAmCN393VSYPNFD2ViA0qRn16sCbnEM//96/gBYjxG9ueFZf+K17AU2DahRTg5BetcJA18xTTPapZF5eytKLQeBarn9IyDNaA/0K4G/TDXQED60AwLEbtXxaIJ8eWshAF27PL/wo3Mq6PEQcVbKODwYZqI1nrxzYBW8J5ibg0GSdNvw3pltLV5mcRtNPilOmrOOIIYLJQOeAdTqsz8FDYnVr26BxrTnQgr8bY+SESZIUS3ynkLHXAVBeOlMg61KTq+vGVLN8yIVf6bt/WNea66Bd1scBzZOSDEklt7nXoMkwDLcqwyrjO/dzHn/apLEzOZSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 14:43:10 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Fri, 19 Jul 2024
 14:43:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 2/2] memory tiering: introduce folio_has_cpupid() check
Date: Fri, 19 Jul 2024 10:43:06 -0400
Message-ID: <20240719144306.258018-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719144306.258018-1-ziy@nvidia.com>
References: <20240719144306.258018-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:256::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: d87e9ce8-72dc-4a2b-3113-08dca8011c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ryJqqZP6Lab9I/2cgGFFWYR4yq10N79LEcRCmfi08pTgYMCVRPNsBdRP6bfv?=
 =?us-ascii?Q?eESEX28v9RKHgMb0sSFbIsviHqhITLDNNiYp01AcbpvXK7E7Hw3nYz1ALprr?=
 =?us-ascii?Q?EnnKfDKGhrYcVFRLSJXvx7dLIhk0D6FTwwRuLzWuPtk1xa0miBpRVSE99eK8?=
 =?us-ascii?Q?GFgeiR3Y7C5hiUEoMQYCMsEIQb5Tn8DZn6LjgtFPpgC47ycc0YwhyT/H/HlF?=
 =?us-ascii?Q?N5Cl9WWPqcIaFAOy29oi0T9XioFtCvBOZ4a0y5dGyUkiUgbq3+ud22qqJlWM?=
 =?us-ascii?Q?rw0QcpowF/NoeBev74F4p86F94nvEpyGLIDDY9KQzg1rfWJaBycca1fe/Vdd?=
 =?us-ascii?Q?dLTVMxyJW3B5CjUtQxO67+cGjlMPRBVMSP7VfI1xMHG/dqKXSlbXBWi3oJzV?=
 =?us-ascii?Q?8MLYHmvzhJhiadfes1PP4oEiEBIjn6pfx9k6QLlhewy5jT56cmVQxRARhT/P?=
 =?us-ascii?Q?tL0ILweobAJtSsmBGuT1T3sxZyIIDTafoYEvbc2UVoaCS97jYN1m5IhQ6NUw?=
 =?us-ascii?Q?hlifggBVNmyAauUqWsxDXbsT/gY/PDUtmoFgToIz3BAcAeAkC54j6pEBqYy8?=
 =?us-ascii?Q?iLw8VLbFxrmt3lN/CpkTymzjiT0XDEoLHBndI3VcGeQJE+yKlERcS7jO+Xwe?=
 =?us-ascii?Q?l0V7TQmJJn7DXLx7OVrmoZXMAOi3zlD0CizosXH4BJsfMUb8bt9yzefGfkZS?=
 =?us-ascii?Q?AcpBw05enoMROEIbZel53JfzzvenMecEryICxiTS7L+rxZZkcauRPtZ77JHn?=
 =?us-ascii?Q?PgbvWXi0/c+ya4/cxO+juym/MPeq/Ww6mpGQ+kMjTUXs2lrLxNKiBvuKyiyK?=
 =?us-ascii?Q?V+qwu6++iikjF7JGOYDSI/WElNDpH0uEzPkzhvsmA/MWQsKn4OWkLrUfDn5b?=
 =?us-ascii?Q?B/DwxSQVTB28DkodS1POO9qM49oCtqgahEJzMqVB2GXjUZ4L2a449VGhMkTT?=
 =?us-ascii?Q?Y80LH0GvJX37UUY0QVS/Fzx4K+wF61CDQqVT2uZ9f/OWaVR1fQVY+dZCQzqh?=
 =?us-ascii?Q?f3ZuzvxK/FQrhRjcEO2Bu/1Arge5nXwYVVItFaZehtlCNu/GagswVEViCXfT?=
 =?us-ascii?Q?2zZATMpIQXAV034OinyyDnwJsYJhNcswxznIki1WHw4xYcGQ8vhBfuTFdWm+?=
 =?us-ascii?Q?4eQWc3SKIyn/YgReaNgHAMhgCYfYVN747OFrOsQ3YINkEs0TusytwUEm2Plh?=
 =?us-ascii?Q?GPdDW/VZqYUpgtV74hPg1Gbp+wj224hSJlFQs7rrGdVgIKdn35Ebs5T6KsW8?=
 =?us-ascii?Q?jQwm4wXJ/hdAPNIRmJQqkGRcQ8WRrLSYCQSvFLvJb1fuzTNPWxCXcbBgTOpy?=
 =?us-ascii?Q?Utyo1XedITsCHdLCO/R8OxF4F6h6yyu51cO0hbQ/NcN29A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JBVHmu/dkNfBDuqmJY7/Xv6PuOrl0wI6wcrJGKMqf1CQrNvuVSz1kDoHukKt?=
 =?us-ascii?Q?h+c092eqyGM4hpR/POKc5jaF3ACnEHkPVk7UswGDAoeEUyxdAkgp3vUSv6qs?=
 =?us-ascii?Q?UX0mujFXsPk2xKMizrnwqMkCOoX5sYnpxVNZ1Ko1YvXTEFnoatM5pF9efDub?=
 =?us-ascii?Q?afF0NbC6XK5TtKkaViGZirm1P3UuOEq+//ZPILCsDUBZLNBEo1u35KaET0Bt?=
 =?us-ascii?Q?YYAtYmTXPWD/lPXjG7TDLTcHAvQKDWz65S8/CK+/y/cUkKhfxPByr+CLai6C?=
 =?us-ascii?Q?cL9P0CPoGl7kbVG3sxqkuwqYkIO0E8htA5d49xLR1rTczQyVeGTlrFNYY9Fh?=
 =?us-ascii?Q?pyiiBTkvka1/V3TeDZ7RPKmU8WdpGnjK5LcAfI4znTKopSK/wwPLljkEnLDP?=
 =?us-ascii?Q?1ntcSwkdoywW3RuAIM8yYKVfFGCNZhuXmSqKnC8xukIuWh0050rRCixvG3Yq?=
 =?us-ascii?Q?o+yka2a+k6ip4tunK4BihhYK98UASrcRm+D0SPzpPZ3clnZm8akZq6ImdmP0?=
 =?us-ascii?Q?6MPfS3MDJOQndF/VTk5sN4NEnVifXoowlnTf4RwUdNHhg1VQa8jK7pUVEBk1?=
 =?us-ascii?Q?PBMheuZbuuELmqXCM16NfiFY5QNquQVwofn8qPO92PJVE1ssQk4lbKSqRfIT?=
 =?us-ascii?Q?2/uVNMFcyBIo5PhJ4w1k/PwZYHoIG5spo/Rzd8XxXymjyRbDrBirpTdhGTvH?=
 =?us-ascii?Q?ZnCEb+y5CpyQYDUXwDk1m/S0eZ/ju64ECEsN4Km9X2yU6jw3/vGSPWeo26An?=
 =?us-ascii?Q?z+t82gQzZZfcNu4NIrS2/M4phv1QhTlzV5Y+xOTbY6MI7BUj/Rjm0ivTsHee?=
 =?us-ascii?Q?O8HbBU9PaG3bncJjZDi8C6kmJGrxhPRSJGAO0PM9zgt4ilk03cIIvilQdutl?=
 =?us-ascii?Q?Z3s8xnrvmZFP6NC/dNr6jl3bxDwsGbuUIHQlZZrOlSkOUNymLgtQzT/51dj4?=
 =?us-ascii?Q?owROgsO7cB8oX0F6PMK5aDGgPRsQ7d331UsuEligBFBbcMsBbaYmU/ebUDCH?=
 =?us-ascii?Q?C6Vq6iKazsTnceaewEM11OOaSQdQCm/fdAU7+awzBoukWPuYwft5v9PtIzFS?=
 =?us-ascii?Q?o4TcaJElX6X6nIuz5+L+1S7eQRk5Km0Wf3tFrPd9/6to1/CLcv6IRdb024Rx?=
 =?us-ascii?Q?r7PI/rHVj+95I0cmxERY5RIrYArrzCulblaGiefx6C2idyzfeShoao+Px0EY?=
 =?us-ascii?Q?FB9mdI21dgyn0c1LK7X2Blpztt1YhWH1bWszhO305mDbuZheuYd1Rsiju2rG?=
 =?us-ascii?Q?BD5dl9N8rp2fWt9OKZ7whj/Awy5rccuvIoOS5P9OlgbnUOIe46y6tJfs4aVd?=
 =?us-ascii?Q?Nt43taRuwcNt/QvD3LPfvAc2HWaTzkT7h/IYM38XTvlAJjbAsiz2zHeDVXsG?=
 =?us-ascii?Q?HL1JgS9/GUwx2GgrAVyIuyq/UojzsBE8S8YREPQqV9RH2Vj+/IxuHji90YJ2?=
 =?us-ascii?Q?dsDFYJwv7gBskL/Xmft0LrnAY6/UGH6W7KFKQjuJ4pU+A1L6mzb+2ehblyIZ?=
 =?us-ascii?Q?ra7DcKkXPS/Is4Z30EXjW5pWnf53CT9lQnIC7+hQYrpn42q4HVHwOSQZx4Kf?=
 =?us-ascii?Q?GVqUtnFvfg0sbkG7aL4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87e9ce8-72dc-4a2b-3113-08dca8011c6d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 14:43:10.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfCvhpCFUX4GXx0czpa9OJZuNZAI3M+AOXSjRw9tP7vz9PBMxpwzmNDk9osuL7nC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079

Instead of open coded check for if memory tiering mode is on and a folio
is in the top tier memory, use a function to encapsulate the check.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 include/linux/memory-tiers.h |  8 ++++++++
 kernel/sched/fair.c          |  3 +--
 mm/huge_memory.c             |  6 ++----
 mm/memory-tiers.c            | 17 +++++++++++++++++
 mm/memory.c                  |  3 +--
 mm/mprotect.c                |  3 +--
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 0dc0cf2863e2..10c127d461c4 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -73,6 +73,10 @@ static inline bool node_is_toptier(int node)
 }
 #endif
 
+
+bool folio_has_cpupid(struct folio *folio);
+
+
 #else
 
 #define numa_demotion_enabled	false
@@ -151,5 +155,9 @@ static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 static inline void mt_put_memory_types(struct list_head *memory_types)
 {
 }
+static inline bool folio_has_cpupid(struct folio *folio)
+{
+	return true;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..03de808cb3cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1840,8 +1840,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
 	 */
-	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-	    !node_is_toptier(src_nid)) {
+	if (!folio_has_cpupid(folio)) {
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 825317aee88e..d925a93bb9ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1712,8 +1712,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
-	    node_is_toptier(nid))
+	if (folio_has_cpupid(folio))
 		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE)
@@ -2066,8 +2065,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    toptier)
 			goto unlock;
 
-		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-		    !toptier)
+		if (!folio_has_cpupid(folio))
 			folio_xchg_access_time(folio,
 					       jiffies_to_msecs(jiffies));
 	}
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 4775b3a3dabe..7f0360d4e3a0 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -6,6 +6,7 @@
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
+#include <linux/sched/sysctl.h>
 
 #include "internal.h"
 
@@ -50,6 +51,22 @@ static const struct bus_type memory_tier_subsys = {
 	.dev_name = "memory_tier",
 };
 
+/**
+ * folio_has_cpupid - check if a folio has cpupid information
+ * @folio: folio to check
+ *
+ * folio's _last_cpupid field is repurposed by memory tiering. In memory
+ * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
+ * record page access time.
+ *
+ * Return: the folio _last_cpupid is used as cpupid
+ */
+bool folio_has_cpupid(struct folio *folio)
+{
+	return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
+	       node_is_toptier(folio_nid(folio));
+}
+
 #ifdef CONFIG_MIGRATION
 static int top_tier_adistance;
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 802d0d8a40f9..105e1a0157dd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5337,8 +5337,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
-	    !node_is_toptier(nid))
+	if (!folio_has_cpupid(folio))
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = folio_last_cpupid(folio);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 222ab434da54..787c3c2bf1b6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -161,8 +161,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
 				    toptier)
 					continue;
-				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-				    !toptier)
+				if (!folio_has_cpupid(folio))
 					folio_xchg_access_time(folio,
 						jiffies_to_msecs(jiffies));
 			}
-- 
2.43.0


