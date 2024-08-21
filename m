Return-Path: <linux-kernel+bounces-295071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF0795964F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1891C22533
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705A51A4B65;
	Wed, 21 Aug 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="akldg0gw"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD54B5C1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226394; cv=fail; b=NGwM/cLsuf3NfPRynnit/vEl08szdlFt/tyNNKj33XHsN9fuKcTB6EAl3fhNe3fZvodI+cBmVtOQqbxvOZt90CvWicy4jxt91qVadkNxL0Pt6trVZSlwsn6FORFzTUTSXta7b1oo+aOKH4IXOd44AF7UQ3YEYd2M4j3XczE0eVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226394; c=relaxed/simple;
	bh=eY+3FV3ThfG7YGTvaybc/08wzDVn0FH7jGWTA2CeTNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEBULUheqcqkluoXi1Vrh+CauCPHeWCrgwyXBoO+cPaGlDy4fRzpGGE2kSVROANd5GzaUA8bCcE8N2RTtl3aOz8NnxXEbmfcr6Pi6irO+qi1VopT9oVSbf/agl5bPQ8E4uWqYYBjV4VksDHcQ0KGFRQxHIwV/TUaTXPCOjC6634=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=akldg0gw; arc=fail smtp.client-ip=40.107.255.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZMYjB+wZ87DzkUtGT6Gead1/0b8GkPnDsIm4SCNoC+hTQS200kNZQZNZOqsYxYvQVZ9rl+8Oi590DZcRSccsXUHZl0BZ7XxhKhqb+hdKa5oYwyNow9ZOhrSNTvz4hE/mQyzc9/0DFQUjo8rhEeW8+1LubJ7kThOCms9lsALzTqzBtVlxrutdRHW33IBeLb35OOnayuuAlKVVllknP2YcSrsD1vgOvc2CM6iBkxBHmE1fzYDDFB2EQYD3Olhr7wjIwOCkvs10xmXX3OK+dnIqZMpPc49RUKNTuliA9UcEQcL1uciR5plCVyfHynt5PCtfO5d1q6B3FV3Z0mudw2Zew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA9aZraGuDqJxramZ0QgY1FA0Nn7yW99MlzZpYtrJRQ=;
 b=TXjnXHWegJXZ/jj8nADnZ6jzvIYiU9PGLeiHRdQyIVGtrJcj5xnxqpEyQU+PLIOMgS4z+UY9Tfy2eUvsR1lQE/Z5/j0ewVmSMqldrnenpAkycRsAX7icuCLeAton9SmxIUTvVXufu0KPUxGBFoGLm7MJAjlBp/P43UqVebcszOAs4qx25U6y1UP9jKyommOaAgrw0LsPPs85b883l5ovxp5x4pXgEcWVaqSXsrA5JVb/M5n+4JRTNqoJEm/RjKvdUv7tnUAWkf89YpESaWYg7mjY+HEXbnbSpL8H+LdDqo7Wq6c3k26Rk6chjrKAvfCDhqTqixuGAOfNM9jsmbS2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA9aZraGuDqJxramZ0QgY1FA0Nn7yW99MlzZpYtrJRQ=;
 b=akldg0gwoiBYvWfObCVZmQWK2lEU1ip1nfef5OgBYGqO2qvBBYs5PNuX285AHpP+A7LAPFavUyprq9CX+KQCLbzumnmJrB0ZbiehcG307eJIcWN/i7ytqxmzVaf6TDxtMlF4oyScdkhdtSSK9QKwZXuF+t/DvqbfQwAC97SYAxM=
Received: from SI2PR02CA0045.apcprd02.prod.outlook.com (2603:1096:4:196::21)
 by SI2PR02MB5514.apcprd02.prod.outlook.com (2603:1096:4:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 07:46:27 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::7d) by SI2PR02CA0045.outlook.office365.com
 (2603:1096:4:196::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 07:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 07:46:26 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 15:46:20 +0800
From: <hanchuanhua@oppo.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: <baolin.wang@linux.alibaba.com>, <chrisl@kernel.org>, <david@redhat.com>,
	<hannes@cmpxchg.org>, <hughd@google.com>, <kaleshsingh@google.com>,
	<kasong@tencent.com>, <linux-kernel@vger.kernel.org>, <mhocko@suse.com>,
	<minchan@kernel.org>, <nphamcs@gmail.com>, <ryan.roberts@arm.com>,
	<senozhatsky@chromium.org>, <shakeel.butt@linux.dev>, <shy828301@gmail.com>,
	<surenb@google.com>, <v-songbaohua@oppo.com>, <willy@infradead.org>,
	<xiang@kernel.org>, <ying.huang@intel.com>, <yosryahmed@google.com>,
	<hch@infradead.org>, <ryncsn@gmail.com>, Chuanhua Han <hanchuanhua@oppo.com>
Subject: [PATCH v7 1/2] mm: add nr argument in mem_cgroup_swapin_uncharge_swap() helper to support large folios
Date: Wed, 21 Aug 2024 15:45:39 +0800
Message-ID: <20240821074541.516249-2-hanchuanhua@oppo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821074541.516249-1-hanchuanhua@oppo.com>
References: <20240821074541.516249-1-hanchuanhua@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|SI2PR02MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: f50ef5e1-ea48-4af9-47cb-08dcc1b55d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+lHhGpDOVJ3W/iSj+Osr28etKWP81DKD+g+cAOtlFqBUDFsSLD4Bi2J/2Njs?=
 =?us-ascii?Q?QpiqO8Z5UlcjZB+0ilWSOufRzE+AOSG/qYrKfytVUbQ8t5zbI/SrrTCmHhM7?=
 =?us-ascii?Q?dNdb46XAf8JVRmRNMOckoF7ozz6vNIcTnyDDgot/huSlsRp5Ce8iPIIGAfVu?=
 =?us-ascii?Q?LqZDjqofTzZoiAiy9V+HUV0848h+IJyqn22bcvbOFYX8RIfVRQfEcsjCcePR?=
 =?us-ascii?Q?7viwII6RlQeXThBteozHNW1zJyh/g358EU4OrHk8OneSSOKiJiEflasRFoOC?=
 =?us-ascii?Q?eKXXlX9S7YSR96QEzj79zn1Qmk9r7+F7V+rKrf7PwCFVH0xj+wcOqst0MXCp?=
 =?us-ascii?Q?89tAspsjtXZog4FzKozw3feE1TkVSedImitPFO+9ttvGr7jtWvqnJ3O2ch47?=
 =?us-ascii?Q?h2PMNIpr0RRy8O9hYANNOr295pAi+EXVswc+EFz3HM5yETHGILWuOepbCDZZ?=
 =?us-ascii?Q?W7E4fNAqKyBStNcEy2vtbFjbi0rMqqcQBUZ8qxNV1RZAXQfWDgJcViQeLHLN?=
 =?us-ascii?Q?EZ2rPdyDaUdnvrHaUHmDxd/8CNwPVKVjoXdOmkLFdVG6VrMSfb3trEgPgVlr?=
 =?us-ascii?Q?afGicuXFf6pp69AiGuJKsW1kQ44wkoDWXqA5OYO00HSkhZP0DXAX0mLq+MOo?=
 =?us-ascii?Q?Ybz98bocSnDYT/hsriWNSFMGPZw3HMte+Ap0z+V9Ez+b5mz0sOq/jMNSUUKW?=
 =?us-ascii?Q?9FJ6nFRgBugDCcMsT90Z/Nfwxx5HhJWGAmQ323ZF6fHotMQPGddT6YTIsggC?=
 =?us-ascii?Q?M36kT8xQbX0YlFzfSN/o6aUxqvIf8BbGiUEgOS5ogz3TAGGdazWfmGAD2zlL?=
 =?us-ascii?Q?AwWeuSEc0RIsMARcWsnsJMI2XajWW5jUugYpj/lJDgsX5NfszNO3gcp7tDUB?=
 =?us-ascii?Q?HpPGYCa1wuxFIyVewr6ZcalWrUw4uUcur2zB/yqNxZlT5hnrwLyBJ42o8DWr?=
 =?us-ascii?Q?uM8mFLVbzbViGD9Zz2KkdcOKf3ChsJI0aPjqEphgAAjksHJwNORAjhP98KAB?=
 =?us-ascii?Q?zHhiAzNaPJqy0q7heHrxn82xFMX25tg52xJqq2GCwC08LGamuDzr4toZNkv4?=
 =?us-ascii?Q?wE7gzFhMJVC4Ray1im+6iag8diX1LdChuyXELgTW0LEExJXKfWZsKQZZu2Uf?=
 =?us-ascii?Q?v0nBnogLa6HlzN/0sYLlKNj1y08US2EzdVNDgjp2MsLXbMWiL7sBETnsatds?=
 =?us-ascii?Q?rbystk9dGJMZxBXZr+ItwKuKMTpeeiJXsJ534ZH6snLt6rCJiRiKskkzePsK?=
 =?us-ascii?Q?HPaP5OzSQZBUXNKbpGnUqo36eKN8GYa8Vny+lMoa1HzEznXEIZmNMfqjBx89?=
 =?us-ascii?Q?MS8u8eVTI1inSi4EV4SrnjS/wucGOKNCdtB3YWzck7nBbvFi1rStUONPzVnJ?=
 =?us-ascii?Q?vBJqWHP8ctjNPG9H2Y20qrB9Yow3rACxUxBTzKLX60D9fHwmGaeLZZ9hjlDj?=
 =?us-ascii?Q?Kn0qUxAMh7C2O0szO1rRm7wt10gCzeIH?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:46:26.5123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f50ef5e1-ea48-4af9-47cb-08dcc1b55d0b
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5514

From: Barry Song <v-songbaohua@oppo.com>

With large folios swap-in, we might need to uncharge multiple entries
all together, add nr argument in mem_cgroup_swapin_uncharge_swap().

For the existing two users, just pass nr=1.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 include/linux/memcontrol.h | 5 +++--
 mm/memcontrol.c            | 7 ++++---
 mm/memory.c                | 2 +-
 mm/swap_state.c            | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fe05fdb92779..780120f7b9dd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -699,7 +699,8 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
-void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
+
+void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
 
 void __mem_cgroup_uncharge(struct folio *folio);
 
@@ -1206,7 +1207,7 @@ static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 	return 0;
 }
 
-static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
+static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 42c826eec124..fd74a20f23a7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4574,14 +4574,15 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 
 /*
  * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
- * @entry: swap entry for which the page is charged
+ * @entry: the first swap entry for which the pages are charged
+ * @nr_pages: number of pages which will be uncharged
  *
  * Call this function after successfully adding the charged page to swapcache.
  *
  * Note: This function assumes the page for which swap slot is being uncharged
  * is order 0 page.
  */
-void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
+void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 {
 	/*
 	 * Cgroup1's unified memory+swap counter has been charged with the
@@ -4601,7 +4602,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 		 * let's not wait for it.  The page already received a
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
-		mem_cgroup_uncharge_swap(entry, 1);
+		mem_cgroup_uncharge_swap(entry, nr_pages);
 	}
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 93c0c25433d0..b9fe2f354878 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4101,7 +4101,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					ret = VM_FAULT_OOM;
 					goto out_page;
 				}
-				mem_cgroup_swapin_uncharge_swap(entry);
+				mem_cgroup_swapin_uncharge_swap(entry, 1);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index a042720554a7..4669f29cf555 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -522,7 +522,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
 		goto fail_unlock;
 
-	mem_cgroup_swapin_uncharge_swap(entry);
+	mem_cgroup_swapin_uncharge_swap(entry, 1);
 
 	if (shadow)
 		workingset_refault(new_folio, shadow);
-- 
2.43.0


