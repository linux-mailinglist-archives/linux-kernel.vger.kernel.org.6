Return-Path: <linux-kernel+bounces-214279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C6290823C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A72A1F23A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6B184123;
	Fri, 14 Jun 2024 03:00:25 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5727B262BE;
	Fri, 14 Jun 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334025; cv=none; b=M2EHwn42m/aIrP/HX7ryVpIZrN71mMEwiApiohtU8hPHoWUG8vsWpwaGlGtqeUGSrmA12rCVJBT730crflv9WS8AtmmzdGVds6aeFB5TR+uv01UAsPtNGlZfFO25siUwv1eC78ukkFoOj3DRFWtvj4HjQnMFIlMIHb0IcYcwb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334025; c=relaxed/simple;
	bh=IfBzt3Wgbf/zIhkvBO8Da/MX9d8tto4nnk9+mbzPZu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGAx4Bns2sV9sFF/O+EPF4eS9aAxhdcV3GxTx7MyyCnq9SXMiF6ggn5yCrc8lLtb3xlUQI58ANGLA+PJViJBiiBg3JM5NXf7m1+rKdVj7O8J72xSYQv5isiHKKrgBZ18bYKB+qqvSgatSYFbboJLD5AKNOIBl8NCD9bNnKksdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-30-666bb2431745
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v6 2/7] mm: rename alloc_demote_folio to alloc_migrate_folio
Date: Fri, 14 Jun 2024 12:00:04 +0900
Message-ID: <20240614030010.751-3-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240614030010.751-1-honggyu.kim@sk.com>
References: <20240614030010.751-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnka7zpuw0g+mvOCwm9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6Mqc+tCrr4K5p+7mZuYLzM08XIySEhYCLxu3sxG4y9Yt8jRhCbTUBN4srLSUxd
	jBwcIgJWEtN2xHYxcnEwC2xglph07gUTSI2wgI/Ex2OPwXpZBFQlDrVuYAGp5xUwldi93Q5i
	pKbE4+0/2UFsTgEzienH7oG1CgGVXLiyFczmFRCUODnzCQuIzSwgL9G8dTYzyC4JgddsEu9+
	XYO6TVLi4IobLBMY+Wch6ZmFpGcBI9MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMAIWFb7J3oH
	46cLwYcYBTgYlXh4PZ5lpQmxJpYVV+YeYpTgYFYS4Z21ECjEm5JYWZValB9fVJqTWnyIUZqD
	RUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBMVAl+daBZSUv92k4rWY2/9t3xPtSzprlk+7c
	nr7dMX6X243Xf2U6Uhn+G6uYv1LsjJ90Pr5I0XXF7W1LePYt3Pbos1T7/MwTbzeqO95tYc3x
	bfCZye81v2f/rEMnfVf8l5+YWjohdOm9C1lzF+zvCFvAsnCH3JynIcqhOjkbMudceR74Rclh
	yRslluKMREMt5qLiRADvcSOMfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXCNUNLT9dpU3aaQe8vC4uJPQYWc9avYbO4
	/+A1u8WT/79ZLRqaHrFYfH72mtni8NyTrBaXd81hs7i35j+rxZH1Z1ksNp89w2yxeLmaxb6O
	B0wWh7++YXLg81h6+g2bx85Zd9k9WvbdYvfYtKqTzWPTp0nsHidm/GbxeLF5JqPHxo//2T2+
	3fbwWPziA5PH501yAdxRXDYpqTmZZalF+nYJXBlTn1sVdPFXNP3czdzAeJmni5GTQ0LARGLF
	vkeMIDabgJrElZeTmLoYOThEBKwkpu2I7WLk4mAW2MAsMencCyaQGmEBH4mPxx6zgdgsAqoS
	h1o3sIDU8wqYSuzebgcxUlPi8faf7CA2p4CZxPRj98BahYBKLlzZCmbzCghKnJz5hAXEZhaQ
	l2jeOpt5AiPPLCSpWUhSCxiZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgQG+LLaPxN3MH65
	7H6IUYCDUYmH1+NZVpoQa2JZcWXuIUYJDmYlEd5ZC4FCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
	eb3CUxOEBNITS1KzU1MLUotgskwcnFINjOm7u1WPxHlM8lr1ftm9Q/63r73ftvf6wuXL+be8
	sml48DYp3z/0QrJay1nHhX94QjLWSVRU/94a2nXJsHuu4ds79+48mpgxO+LNHqtj5jM7TjX7
	ik04xdggOd/7cUnX1JsOpTKHw+12HW7y7A1pvPsr32LvNtMPPVHbCrcuYPSc/+7StYZ/nwWV
	WIozEg21mIuKEwEIzj3IbAIAAA==
X-CFilter-Loop: Reflected

The alloc_demote_folio can also be used for general migration including
both demotion and promotion so it'd be better to rename it from
alloc_demote_folio to alloc_migrate_folio.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/internal.h | 2 +-
 mm/vmscan.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b3ca996a4efc..9f967842f636 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1052,7 +1052,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
-struct folio *alloc_demote_folio(struct folio *src, unsigned long private);
+struct folio *alloc_migrate_folio(struct folio *src, unsigned long private);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2f4406872f43..f5414b101909 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -916,7 +916,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-struct folio *alloc_demote_folio(struct folio *src, unsigned long private)
+struct folio *alloc_migrate_folio(struct folio *src, unsigned long private)
 {
 	struct folio *dst;
 	nodemask_t *allowed_mask;
@@ -979,7 +979,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	node_get_allowed_targets(pgdat, &allowed_mask);
 
 	/* Demotion ignores all cpuset and mempolicy settings */
-	migrate_pages(demote_folios, alloc_demote_folio, NULL,
+	migrate_pages(demote_folios, alloc_migrate_folio, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
-- 
2.34.1


