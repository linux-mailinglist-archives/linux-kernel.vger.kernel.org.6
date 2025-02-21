Return-Path: <linux-kernel+bounces-525853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E8A3F651
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610063BC552
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4E20E6E2;
	Fri, 21 Feb 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beyYBABR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFF20E319;
	Fri, 21 Feb 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145747; cv=none; b=F0gzfJlCVYmp68ZASIC2EgZJydLbhYAFKiDvJObLlDlIilxQnI45qxk4ZWpSkTGkWNdSEvpLY08SDXLxl01pl8pTdZfGmFkg80seigggjAoEXAeY6eax//FyWtfrMWQODkSSEdQ3YyNdOTbW4h5fgNe4Usz90n6JWBp0Dxukkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145747; c=relaxed/simple;
	bh=C0EAePF53lIXFleUHeMPzsteLlLG26sy4F3rDVZs/WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HuFQo09ZpD0bYTIoqPPcgDwh3LWdimM+Wzlngxjx4yXARig7DomsoWNRojOWdkr7MuByle1dScuDp9vHWqQjfp1hUvASK2OHRMnKBJZJRGxj6QWxpDnl5lDwQ0izi3yTqvlJAuouNhV5Nor+WdqykPuX3mSNKrUqF04hkCNGINk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beyYBABR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 456D3C4CEE8;
	Fri, 21 Feb 2025 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740145747;
	bh=C0EAePF53lIXFleUHeMPzsteLlLG26sy4F3rDVZs/WI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=beyYBABRNIJEUcIKdaE6ZUxIcbBE06xl56SR6bwRLYN12s/eGS5U1gZSVYnQsEDDN
	 ZHPBzLi8KKjGDwfcXlfc/Dz5VFnVR2c7Z3p5awl4nXLv8aTc+7ViX4SLjsQnJEBM6g
	 JTLYLDtIIZSG4JhI5tAtYma+AlAy2UDkUy3tBs1a77OHFm+KeEnoOte/dNblrSGj27
	 d4PVZQT0BfiHYzwWUnDJkLjHUY3ukqbDdrtgI4rtvR0TbVE7DNAksTPb5By2xxDMVc
	 b9AijH8Kg5o3GgWu6y6sEG3AmVQq/mBq1H6u+H1D5xHLRwPwy53ImwsM1okMXEWrfq
	 5l4/SYly93MxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36038C021B6;
	Fri, 21 Feb 2025 13:49:07 +0000 (UTC)
From: Thomas Prescher via B4 Relay <devnull+thomas.prescher.cyberus-technology.de@kernel.org>
Date: Fri, 21 Feb 2025 14:49:04 +0100
Subject: [PATCH 2/2] mm: hugetlb: log time needed to allocate hugepages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-hugepage-parameter-v1-2-fa49a77c87c8@cyberus-technology.de>
References: <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
In-Reply-To: <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
To: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Thomas Prescher <thomas.prescher@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740145745; l=1236;
 i=thomas.prescher@cyberus-technology.de; s=20250221;
 h=from:subject:message-id;
 bh=+RVZ6u1nzdp1931lwTDAnLSee61rdleZduyoY/lMDIA=;
 b=4+fAS5E5X1tj0juCLlk8wApea1Mw0hFQMhgVoxUvNua6eliTe5IqQoAihZ6t8J1ZOqKoXwCkS
 PyHzdDBHY34C9m3qRY5CD7zL8gr1jDVg1stVn8oZoDsw6CVRLFkgv8z
X-Developer-Key: i=thomas.prescher@cyberus-technology.de; a=ed25519;
 pk=T5MVdLVCc/0UUyv5IcSqGVvGcVkgWW/KtuEo2RRJwM8=
X-Endpoint-Received: by B4 Relay for
 thomas.prescher@cyberus-technology.de/20250221 with auth_id=345
X-Original-From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Reply-To: thomas.prescher@cyberus-technology.de

From: Thomas Prescher <thomas.prescher@cyberus-technology.de>

Having this information allows users to easily tune
the hugepages_node_threads parameter.

Signed-off-by: Thomas Prescher <thomas.prescher@cyberus-technology.de>
---
 mm/hugetlb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b7d24c41e0f9d22f5b86c253e29a2eca28460026..2aa5724a385494f9d6f1d644a2bfe547591fc96c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3428,6 +3428,9 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 		.numa_aware	= true
 	};
 
+	unsigned long jiffies_start;
+	unsigned long jiffies_end;
+
 	job.thread_fn	= hugetlb_pages_alloc_boot_node;
 	job.start	= 0;
 	job.size	= h->max_huge_pages;
@@ -3450,7 +3453,13 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 	 */
 	job.max_threads	= num_node_state(N_MEMORY) * allocation_threads_per_node;
 	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / allocation_threads_per_node;
+
+	jiffies_start = jiffies;
 	padata_do_multithreaded(&job);
+	jiffies_end = jiffies;
+
+	printk(KERN_DEBUG "HugeTLB: allocation took %dms\n",
+	    jiffies_to_msecs(jiffies_end - jiffies_start));
 
 	return h->nr_huge_pages;
 }

-- 
2.48.1



