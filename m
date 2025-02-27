Return-Path: <linux-kernel+bounces-537464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B16E9A48C47
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF4A188C70B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3A026F47B;
	Thu, 27 Feb 2025 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkwUvkVW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315A27780C;
	Thu, 27 Feb 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697332; cv=none; b=TyTHGljyEAomuuRpV3DJEWBze5ZmTxXhoc+Jrm86c0QkopAuRWQ8zKj0X3MxVVedKswqcb2qfu+fI+iIvZTGX2428pr4zjdODsv6aEFUqVe7Zg3hRJiBfbIlHDS97cUxM2ekCdHnUFbgb2pBae1zjfQqJuX6a+uqkAeKv0vHM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697332; c=relaxed/simple;
	bh=grcGQ/+arIlEAKZaRyhVKHEzoTjlNo07p6Orhu/Q7Hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b44LC8g+b1m9+4BWt5nI4xT28IHStWFMGQ9tNe2aZhdCIzC4UhWP35BMhcPvBP8Ac15ZCzk8W1wt1JMcAzJuCcBTUtloPwpBcwAEAE4EG6YmO8cpyrhmtJenwHxwWxw5hi+pSsBax5/z0HtTFAFlhkZhd0Dd1kH+QRK+GXyp5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkwUvkVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9FFDC4CEE4;
	Thu, 27 Feb 2025 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740697331;
	bh=grcGQ/+arIlEAKZaRyhVKHEzoTjlNo07p6Orhu/Q7Hc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bkwUvkVW/TEczE4myTyrmmeFtmvcTcq0Hae2JqCI4DmQvaXRWN7jaBlvQL7Cwnuso
	 mxhIOmt56z4hlsXQNIHyWNmgiYkn91QbThCFHZ58ePNDhydglcqq/ucuoJRmLZxzUz
	 oCp8/13smeaAae5B/yxLV42s+egNOa34MDG1Ct6zDcw0DowRAXLNd0r7ozhZrUpz/+
	 hHsgzYWmd4aaA6uCTCUbDNMwMKH1U4XUYXWJyE4NQ9zkong488yKq77vxD+nt6URlu
	 ockCxJcYp0NEIV8Dh8Unp4bYIP2PSD/OyZ/JGo1W3AvWcNUKVbBX5iYJz9BKC1cOkY
	 bVG5U7/vDlu0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E231C282C7;
	Thu, 27 Feb 2025 23:02:11 +0000 (UTC)
From: Thomas Prescher via B4 Relay <devnull+thomas.prescher.cyberus-technology.de@kernel.org>
Date: Fri, 28 Feb 2025 00:02:11 +0100
Subject: [PATCH v3 2/3] mm: hugetlb: add hugetlb_alloc_threads cmdline
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-hugepage-parameter-v3-2-2628e9b2b5c0@cyberus-technology.de>
References: <20250228-hugepage-parameter-v3-0-2628e9b2b5c0@cyberus-technology.de>
In-Reply-To: <20250228-hugepage-parameter-v3-0-2628e9b2b5c0@cyberus-technology.de>
To: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Thomas Prescher <thomas.prescher@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740697330; l=4838;
 i=thomas.prescher@cyberus-technology.de; s=20250221;
 h=from:subject:message-id;
 bh=/OuX4vllZ9DrhNgACxdiUGULgJjK6Nnwd9N61kSfqhA=;
 b=plgqK9FRmX14NZYx5n6BIStbjlTw2JlRsmYOuxhiFjGV95BR4FhopQxq99CpBwNWQ+78eFYmB
 U7Of9U+aQ3dACUsAM7MTCS3k7oh6/dFlYcEawYMIR1uou0e+RilLHoZ
X-Developer-Key: i=thomas.prescher@cyberus-technology.de; a=ed25519;
 pk=T5MVdLVCc/0UUyv5IcSqGVvGcVkgWW/KtuEo2RRJwM8=
X-Endpoint-Received: by B4 Relay for
 thomas.prescher@cyberus-technology.de/20250221 with auth_id=345
X-Original-From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Reply-To: thomas.prescher@cyberus-technology.de

From: Thomas Prescher <thomas.prescher@cyberus-technology.de>

Add a command line option that enables control of how many
threads should be used to allocate huge pages.

Signed-off-by: Thomas Prescher <thomas.prescher@cyberus-technology.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++
 Documentation/admin-guide/mm/hugetlbpage.rst    | 10 ++++++++
 mm/hugetlb.c                                    | 31 +++++++++++++++++++++----
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8582b8750d7e014c4d76166fa2fc1..1937ee02c1f883ecd910bab33cdb9194bddbd9b1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1882,6 +1882,15 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugepage_alloc_threads=
+			[HW] The number of threads that should be used to
+			allocate hugepages during boot. This option can be
+			used to improve system bootup time when allocating
+			a large amount of huge pages.
+			The default value is 25% of the available hardware threads.
+
+			Note that this parameter only applies to non-gigantic huge pages.
+
 	hugetlb_cma=	[HW,CMA,EARLY] The size of a CMA area used for allocation
 			of gigantic hugepages. Or using node format, the size
 			of a CMA area per node can be specified.
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index f34a0d798d5b533f30add99a34f66ba4e1c496a3..67a941903fd2231e6c082cffb4c9179ee094b208 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -145,7 +145,17 @@ hugepages
 
 	It will allocate 1 2M hugepage on node0 and 2 2M hugepages on node1.
 	If the node number is invalid,  the parameter will be ignored.
+hugepage_alloc_threads
+	Specify the number of threads that should be used to allocate hugepages
+	during boot. This parameter can be used to improve system bootup time
+	when allocating a large amount of huge pages.
 
+	The default value is 25% of the available hardware threads.
+	Example to use 8 allocation threads::
+
+		hugepage_alloc_threads=8
+
+	Note that this parameter only applies to non-gigantic huge pages.
 default_hugepagesz
 	Specify the default huge page size.  This parameter can
 	only be specified once on the command line.  default_hugepagesz can
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e9b1b3e2b9d467f067d54359e1401a03f9926108..98dbfa18bee01d01b40cc7c650cd3eca5eae2457 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -70,6 +70,7 @@ static unsigned long __initdata default_hstate_max_huge_pages;
 static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
 static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
+static unsigned long hugepage_allocation_threads __initdata;
 
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
@@ -3429,8 +3430,6 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 		.numa_aware	= true
 	};
 
-	unsigned int num_allocation_threads = max(num_online_cpus() / 4, 1);
-
 	job.thread_fn	= hugetlb_pages_alloc_boot_node;
 	job.start	= 0;
 	job.size	= h->max_huge_pages;
@@ -3451,9 +3450,13 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 	 * | cascade lake 192 cpus |   39s |   20s |   11s |   10s |    9s |
 	 * +-----------------------+-------+-------+-------+-------+-------+
 	 */
+	if (hugepage_allocation_threads == 0) {
+		hugepage_allocation_threads = num_online_cpus() / 4;
+		hugepage_allocation_threads = max(hugepage_allocation_threads, 1);
+	}
 
-	job.max_threads	= num_allocation_threads;
-	job.min_chunk	= h->max_huge_pages / num_allocation_threads;
+	job.max_threads	= hugepage_allocation_threads;
+	job.min_chunk	= h->max_huge_pages / hugepage_allocation_threads;
 	padata_do_multithreaded(&job);
 
 	return h->nr_huge_pages;
@@ -4766,6 +4769,26 @@ static int __init default_hugepagesz_setup(char *s)
 }
 __setup("default_hugepagesz=", default_hugepagesz_setup);
 
+/* hugepage_alloc_threads command line parsing
+ * When set, use this specific number of threads for the boot
+ * allocation of hugepages.
+ */
+static int __init hugepage_alloc_threads_setup(char *s)
+{
+	unsigned long allocation_threads;
+
+	if (kstrtoul(s, 0, &allocation_threads) != 0)
+		return 1;
+
+	if (allocation_threads == 0)
+		return 1;
+
+	hugepage_allocation_threads = allocation_threads;
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



