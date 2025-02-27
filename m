Return-Path: <linux-kernel+bounces-537466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65392A48C44
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC3E3A836B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00F326B971;
	Thu, 27 Feb 2025 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw1CuHW7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131AD277811;
	Thu, 27 Feb 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697332; cv=none; b=BYmfTb5n1jPUeXLMvrloDpVpG2ZPcH3myyVK1Td+AtZqPoml2qT1xuN1N+pwsUSdd9VHwEk4tD7HtLCkOkDqaljWlbBQLgvRTG/z5gRASFqJ9/FBJG/V/r6Jnqf8zHT6P8zMxpzWNdWKEMs8BIZLLdG7SpvDQ1vTcDAab81wA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697332; c=relaxed/simple;
	bh=KtbIzS4AUjDVw9eTyMy+OqLiztibkFAx2Wye0kO3VyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SK2rLCf1JZK0Q9jB0LDbQEmp1UF+sY3HZcNSJM+/VUH+yGECaaqY7wNxsDst8k5wImWgPm7S1oasbmgrjRCxEcTLLD+RIcxq1ejPx+V+dtRD41XAi6sbgu3ZQMav1MELNWWjT1Yovi0hC48xyfY9B2emQ+eRVL9s8g3pS5pXfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw1CuHW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6124C4CEE8;
	Thu, 27 Feb 2025 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740697331;
	bh=KtbIzS4AUjDVw9eTyMy+OqLiztibkFAx2Wye0kO3VyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Sw1CuHW7wC7UUaEn8MQiK4kJ6myfZwRnWMk9gJzFgNN7bevg5DFua5RG9AH2FN/5U
	 m+2rChPhVBPYA5WHRO4mMX22rbQkiJWcZzEpXD8FNXR6eU5UbsCqhC7TvMmbEpn71i
	 xfkTMbu2X+YxmNtRKTxp/KPiLrQVn3kTGZWyVAEJ4rFjFi/9BKeixcmWMf/c5DfHde
	 HB4FPEcTblP2W0qUdGIyyK7OeJtWLtcr425oyBGM+E1GftZcqBT2mz3vDW7sdbETTH
	 G4SBH5jsabBYHt3385+sRp1NN5Al+UgITvOT8gsjv69uqUKaWbrP//51bfqkn+CNpa
	 dmx5bAMyA7RdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EDC197BF;
	Thu, 27 Feb 2025 23:02:11 +0000 (UTC)
From: Thomas Prescher via B4 Relay <devnull+thomas.prescher.cyberus-technology.de@kernel.org>
Date: Fri, 28 Feb 2025 00:02:12 +0100
Subject: [PATCH v3 3/3] mm: hugetlb: log time needed to allocate hugepages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-hugepage-parameter-v3-3-2628e9b2b5c0@cyberus-technology.de>
References: <20250228-hugepage-parameter-v3-0-2628e9b2b5c0@cyberus-technology.de>
In-Reply-To: <20250228-hugepage-parameter-v3-0-2628e9b2b5c0@cyberus-technology.de>
To: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Thomas Prescher <thomas.prescher@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740697330; l=1233;
 i=thomas.prescher@cyberus-technology.de; s=20250221;
 h=from:subject:message-id;
 bh=kVTCFV+/k+LokF7dkdID5wL+yhEPOHMcEjpG7h57QQg=;
 b=nviinN1UkUOO52193TwciC1bmDLsz/73yA7LF21tAe2rtkqUTXcEs3t41sxDWKNPeuMzSfORT
 Amw8zTCZiFNCkhEelV45hTzezgt+y4I9gVdfv+f4fjnpx/kApNWENHU
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
 mm/hugetlb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 98dbfa18bee01d01b40cc7c650cd3eca5eae2457..816e5846222a54255b99515a94e0c1ba9b2b7b27 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3430,6 +3430,9 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 		.numa_aware	= true
 	};
 
+	unsigned long jiffies_start;
+	unsigned long jiffies_end;
+
 	job.thread_fn	= hugetlb_pages_alloc_boot_node;
 	job.start	= 0;
 	job.size	= h->max_huge_pages;
@@ -3457,7 +3460,14 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 
 	job.max_threads	= hugepage_allocation_threads;
 	job.min_chunk	= h->max_huge_pages / hugepage_allocation_threads;
+
+	jiffies_start = jiffies;
 	padata_do_multithreaded(&job);
+	jiffies_end = jiffies;
+
+	pr_info("HugeTLB: allocation took %dms with hugepage_alloc_threads=%ld\n",
+		jiffies_to_msecs(jiffies_end - jiffies_start),
+		hugepage_allocation_threads);
 
 	return h->nr_huge_pages;
 }

-- 
2.48.1



