Return-Path: <linux-kernel+bounces-525855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB1A3F654
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEE517BBCC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A24C20E70F;
	Fri, 21 Feb 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYI3ZRvD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66320E327;
	Fri, 21 Feb 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145747; cv=none; b=klMfmAnDGpvfWNIiUwcAfT5BVN+kkrY7iwq2Ope6wkdW4zUmw+S4eDe9ebWakK0xdTWDlFBYFPeiB9kLiX+uFVA0CsriulOMFc74hFLPTmgNChKzdGXQuWGmXv3kcjcFJsTvQ5dQdi7HoLWll/WMiEAKy3dJXFE9RWTGqg7sihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145747; c=relaxed/simple;
	bh=0iNsPS01vP3ua/6DjsJ/YHAG8fnILRNzO8D3XnR9sKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttoNE81tQ7TNYIyI4slWqhECoRnJ/jPYrBJReGp0zbwUVdcwZ6T8omBigjie3wJ5Pgzgba6iRP5MkJe0QQaxZbFMCjVVEEGKMHYX8mDm6AyKrBdR9p+nLVQlZZMDohWpIufxnBXZLOgqynre35EhBw+gAZI+s/3XA/K5ZpP7aCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYI3ZRvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38DBEC4CEE7;
	Fri, 21 Feb 2025 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740145747;
	bh=0iNsPS01vP3ua/6DjsJ/YHAG8fnILRNzO8D3XnR9sKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rYI3ZRvDUX+tFgklGKPOFhZeNIEWYQOmxFK0i8jyJVlttLadz4q8TFQuTxYwi8UEY
	 4aFQiTtrZLYyuPsrc2ZxMYngNko4UY0OezSibUX5IP8ui4rJHLHJaxg51ZdGhoVg1d
	 Kxv+nRtYgxtGyJnydcFjcIgqg5dCfuVEggx0WGW1xPkpqn1tS9ik31Gvw45sBDKCCJ
	 JSnJsndZpTAjXVRLREmIDnYBDPZ92F6rUZBL3PVvcXgzTNeB028MyjUhkzlAVRo285
	 g4QEpDdOq5GwkLdBcSWJ160/lKzQew2+2E0J0vfu0KMHHVEXeeVy/clvKSq5IgHHC/
	 UG32FdCY1Q9yQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2812DC021B5;
	Fri, 21 Feb 2025 13:49:07 +0000 (UTC)
From: Thomas Prescher via B4 Relay <devnull+thomas.prescher.cyberus-technology.de@kernel.org>
Date: Fri, 21 Feb 2025 14:49:03 +0100
Subject: [PATCH 1/2] mm: hugetlb: add hugetlb_alloc_threads cmdline option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-hugepage-parameter-v1-1-fa49a77c87c8@cyberus-technology.de>
References: <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
In-Reply-To: <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
To: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Thomas Prescher <thomas.prescher@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740145745; l=6157;
 i=thomas.prescher@cyberus-technology.de; s=20250221;
 h=from:subject:message-id;
 bh=HpOhYCnQyPIjVEHgimpeR6bfXmBvvCC82GS66+KuNpc=;
 b=c6Khcn66ph6MIR62Cg3BtSzEpppedB0VFMShAA2aJRKUTNalEouvy7dv7m1IBSaM/Wo7P8KVA
 MJBKaB/iE83CE21NyCBi/qnj0i5DkkRq0TdT43fSmJsI7nFbHnPzQcm
X-Developer-Key: i=thomas.prescher@cyberus-technology.de; a=ed25519;
 pk=T5MVdLVCc/0UUyv5IcSqGVvGcVkgWW/KtuEo2RRJwM8=
X-Endpoint-Received: by B4 Relay for
 thomas.prescher@cyberus-technology.de/20250221 with auth_id=345
X-Original-From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Reply-To: thomas.prescher@cyberus-technology.de

From: Thomas Prescher <thomas.prescher@cyberus-technology.de>

Add a command line option that enables control of how many
threads per NUMA node should be used to allocate huge pages.

Allocating huge pages can take a very long time on servers
with terabytes of memory even when they are allocated at
boot time where the allocation happens in parallel.

The kernel currently uses a hard coded value of 2 threads per
NUMA node for these allocations.

This patch allows to override this value.

Signed-off-by: Thomas Prescher <thomas.prescher@cyberus-technology.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++
 Documentation/admin-guide/mm/hugetlbpage.rst    |  9 ++++-
 mm/hugetlb.c                                    | 50 +++++++++++++++++--------
 3 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8582b8750d7e014c4d76166fa2fc1..812064542fdb0a5c0ff7587aaaba8da81dc234a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1882,6 +1882,13 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugepage_alloc_threads=
+			[HW] The number of threads per NUMA node that should
+			be used to allocate hugepages during boot.
+			This option can be used to improve system bootup time
+			when allocating a large amount of huge pages.
+			The default value is 2 threads per NUMA node.
+
 	hugetlb_cma=	[HW,CMA,EARLY] The size of a CMA area used for allocation
 			of gigantic hugepages. Or using node format, the size
 			of a CMA area per node can be specified.
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index f34a0d798d5b533f30add99a34f66ba4e1c496a3..c88461be0f66887d532ac4ef20e3a61dfd396be7 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -145,7 +145,14 @@ hugepages
 
 	It will allocate 1 2M hugepage on node0 and 2 2M hugepages on node1.
 	If the node number is invalid,  the parameter will be ignored.
-
+hugepage_alloc_threads
+	Specify the number of threads per NUMA node that should be used to
+	allocate hugepages during boot. This parameter can be used to improve
+	system bootup time when allocating a large amount of huge pages.
+	The default value is 2 threads per NUMA node. Example to use 8 threads
+	per NUMA node::
+
+		hugepage_alloc_threads=8
 default_hugepagesz
 	Specify the default huge page size.  This parameter can
 	only be specified once on the command line.  default_hugepagesz can
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 163190e89ea16450026496c020b544877db147d1..b7d24c41e0f9d22f5b86c253e29a2eca28460026 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -68,6 +68,7 @@ static unsigned long __initdata default_hstate_max_huge_pages;
 static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
 static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
+static unsigned long allocation_threads_per_node __initdata = 2;
 
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
@@ -3432,26 +3433,23 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 	job.size	= h->max_huge_pages;
 
 	/*
-	 * job.max_threads is twice the num_node_state(N_MEMORY),
+	 * job.max_threads is twice the num_node_state(N_MEMORY) by default.
 	 *
-	 * Tests below indicate that a multiplier of 2 significantly improves
-	 * performance, and although larger values also provide improvements,
-	 * the gains are marginal.
+	 * On large servers with terabytes of memory, huge page allocation
+	 * can consume a considerably amount of time.
 	 *
-	 * Therefore, choosing 2 as the multiplier strikes a good balance between
-	 * enhancing parallel processing capabilities and maintaining efficient
-	 * resource management.
+	 * Tests below show how long it takes to allocate 1 TiB of memory with 2MiB huge pages.
+	 * 2MiB huge pages. Using more threads can significantly improve allocation time.
 	 *
-	 * +------------+-------+-------+-------+-------+-------+
-	 * | multiplier |   1   |   2   |   3   |   4   |   5   |
-	 * +------------+-------+-------+-------+-------+-------+
-	 * | 256G 2node | 358ms | 215ms | 157ms | 134ms | 126ms |
-	 * | 2T   4node | 979ms | 679ms | 543ms | 489ms | 481ms |
-	 * | 50G  2node | 71ms  | 44ms  | 37ms  | 30ms  | 31ms  |
-	 * +------------+-------+-------+-------+-------+-------+
+	 * +--------------------+-------+-------+-------+-------+-------+
+	 * | threads per node   |   2   |   4   |   8   |   16  |    32 |
+	 * +--------------------+-------+-------+-------+-------+-------+
+	 * | skylake 4node      |   44s |   22s |   16s |   19s |   20s |
+	 * | cascade lake 4node |   39s |   20s |   11s |   10s |    9s |
+	 * +--------------------+-------+-------+-------+-------+-------+
 	 */
-	job.max_threads	= num_node_state(N_MEMORY) * 2;
-	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / 2;
+	job.max_threads	= num_node_state(N_MEMORY) * allocation_threads_per_node;
+	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / allocation_threads_per_node;
 	padata_do_multithreaded(&job);
 
 	return h->nr_huge_pages;
@@ -4764,6 +4762,26 @@ static int __init default_hugepagesz_setup(char *s)
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
+/* hugepage_alloc_threads command line parsing
+ * When set, use this specific number of threads per NUMA node for the boot
+ * allocation of hugepages.
+ */
+static int __init hugepage_alloc_threads_setup(char *s)
+{
+	unsigned long threads_per_node;
+
+	if (kstrtoul(s, 0, &threads_per_node) != 0)
+		return 1;
+
+	if (threads_per_node == 0)
+		return 1;
+
+	allocation_threads_per_node = threads_per_node;
+
+	return 1;
+}
+__setup("hugepage_alloc_threads=", hugepage_alloc_threads_setup);
+
 static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;

-- 
2.48.1



