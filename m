Return-Path: <linux-kernel+bounces-214278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A76090823A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C571F2394A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578B1836DF;
	Fri, 14 Jun 2024 03:00:23 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D2314533F;
	Fri, 14 Jun 2024 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334023; cv=none; b=D+E9aqw+LkOWawf0t5G/wUJpXSikOKzGTKnyn6swUIMOAHKzFwrEjY/fCM+qxSfivy8lg4B1Qf619rEZFQBvtpAYRXkdzxoT4CyIWIqclQIa2tN784wHDA2NuLZwN3TI5eOWlxdp7/KwTouWi/nQ9hCP47Rlkx2MilR6F1ECPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334023; c=relaxed/simple;
	bh=zH9/26bCnqQ1D4kgrGaATCsRHHQL0Yv8+lKkx1Ua+NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4+HLK/WcWzsd3WYPcdgiKA+rgQvXZepmk4ZgJPH+tOjtMSdlnKdwyk7KInZETn9BdrtcaMJEDIVMyBTzaVqD7iW7VVqAwl4n60zXwchGetfP4W5nJ8F7x/c34rts3w6k9rxxr8anJ6uxuVCs6Z8MfsyQXR14SiTVyMb1d72Zaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-2a-666bb2426825
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
Subject: [PATCH v6 1/7] mm: make alloc_demote_folio externally invokable for migration
Date: Fri, 14 Jun 2024 12:00:03 +0900
Message-ID: <20240614030010.751-2-honggyu.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnka7Tpuw0g0V3eS0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6MKacPMhd0clf8nbqavYFxPmcXIyeHhICJxM7Zz5hg7BsT/rCC2GwCahJXXk4C
	inNwiAhYSUzbEdvFyMXBLLCBWWLSuRdg9cICYRIrNq4Eq2ERUJV4NzEZJMwrYCrxbMFZqJGa
	Eo+3/2QHsTkFzCSmH7sHFhcCqrlwZSsTRL2gxMmZT1hAbGYBeYnmrbOZQXZJCDxnk/i8/R3U
	IEmJgytusExg5J+FpGcWkp4FjEyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQJjYFntn+gdjJ8u
	BB9iFOBgVOLh9XiWlSbEmlhWXJl7iFGCg1lJhHfWQqAQb0piZVVqUX58UWlOavEhRmkOFiVx
	XqNv5SlCAumJJanZqakFqUUwWSYOTqkGxmV6skvDtzLGMOz+uGr2JY8d1719w2L+Ji/lCZZL
	yuM8ceKh3a/VgoUlbHMy41+WXjw2d1bjqUsnO+q6Hn9IYyu1ULVZ9nBfcwFX6LbjB3fK/dQ3
	aZ4gYu5yfKWCaSzrOYnS57efP31Zv+Swy4HTR2u2LZqdPut87JQ/TAYPjm4uZWXa7HKq96IS
	S3FGoqEWc1FxIgA2o4WdfQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNLT9dxU3aawbfpNhYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDKmnD7IXNDJXfF36mr2Bsb5nF2MnBwSAiYS
	Nyb8YQWx2QTUJK68nMTUxcjBISJgJTFtR2wXIxcHs8AGZolJ514wgdQIC4RJrNi4EqyGRUBV
	4t3EZJAwr4CpxLMFZ5kgRmpKPN7+kx3E5hQwk5h+7B5YXAio5sKVrUwQ9YISJ2c+YQGxmQXk
	JZq3zmaewMgzC0lqFpLUAkamVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIEhvqz2z8QdjF8u
	ux9iFOBgVOLh9XiWlSbEmlhWXJl7iFGCg1lJhHfWQqAQb0piZVVqUX58UWlOavEhRmkOFiVx
	Xq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDY/J99qDw/+uES49InijWWbLsYtnezvwkYDQVZl5k
	LvQvO7rwyrQ5mxad5b4hoTDtnqFJ+I3cHw279vzY9GXff/NKI5nltdOfiHtkyHpfzj0rtD3I
	74FSc+Oat85tT4O67hnPnTe/QCrjVVX8PFb+2KjZ67pD/n3clrNU69mkM2+0oi4da+R/osRS
	nJFoqMVcVJwIANCeqNZtAgAA
X-CFilter-Loop: Reflected

The alloc_demote_folio can be used out of vmscan.c so it'd be better to
remove static keyword from it.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/internal.h | 1 +
 mm/vmscan.c   | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..b3ca996a4efc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1052,6 +1052,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
+struct folio *alloc_demote_folio(struct folio *src, unsigned long private);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..2f4406872f43 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -916,8 +916,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-static struct folio *alloc_demote_folio(struct folio *src,
-		unsigned long private)
+struct folio *alloc_demote_folio(struct folio *src, unsigned long private)
 {
 	struct folio *dst;
 	nodemask_t *allowed_mask;
-- 
2.34.1


