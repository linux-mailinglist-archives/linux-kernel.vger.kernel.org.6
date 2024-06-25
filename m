Return-Path: <linux-kernel+bounces-228994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A1791697E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83DA28165C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4916EBE3;
	Tue, 25 Jun 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzwXSsVt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFC16E863
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323587; cv=none; b=HVTnriE5kBInQFDyZXkrYIWBDLJmVLzqwOUBm95YOLJJ5JmMdP+TkOv0ZM3glbELHOdcgbOMWvtCewinQ1RdMiYsq957NpTpQ7L+UfftRTzmXIBYkSv/vXa5iR1XQLBZdUmVBu4ezCoxq8eMoU0QylD+PkxuuTbdsySMq3uHnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323587; c=relaxed/simple;
	bh=DFr4TRqKLmfPFbF2NSC8zCtiAY10KyWLCkq+RiflglI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOSfFwoGIGUZuPXIYvvHq91oUj0KzCvnPTw19BMJt9U89VF2i7chSczkw74GIWn5eiAVMNYp4hjDyH4A+ESg9r2rNpu1OWnNl96HoVPLfUIH5FTNqhrf2Wv/kc85azvLNXK6EXcuWdhNsW9J8wS4OojDC7GyPicdM2Pcrapsjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzwXSsVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365EEC32786;
	Tue, 25 Jun 2024 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323587;
	bh=DFr4TRqKLmfPFbF2NSC8zCtiAY10KyWLCkq+RiflglI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzwXSsVt2voH3OzqD4MFTzuqtShyjCtLb16dy5HNsoUN5HmLY2v1hdFbu3jG2+c70
	 PO4HNhVlGAVHA/sUkr2H6CEnI49KwAzLn9DSQgjC8mIrDOe8RAJ2DpRgnYac4P+JTP
	 l2bW6ZTJg3XLEaAwrlEWJsNJzurXlMn9+FTOgV+4MxAOUemX5/XputUuuygW3Y81xz
	 mNMTh2us0uqpF+3CSYPZm6auUY8cqFShmA0DjtXS6XUSIf8d9Uc3mh1ormmR6s3eqr
	 T8AmNwQbu6vDs1/nYuyZsm+4KwDoGm9Na41rriSfWi0WUREiBl3U2whvATQh+i/9De
	 URkGWbQuD25mg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH 6/6] mm: Drain LRUs upon resume to userspace on nohz_full CPUs
Date: Tue, 25 Jun 2024 15:52:44 +0200
Message-ID: <20240625135244.20227-7-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625135244.20227-1-frederic@kernel.org>
References: <20240625135244.20227-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LRUs can be drained through several ways. One of them may add disturbances
to isolated workloads while queuing a work at any time to any target,
whether running in nohz_full mode or not.

Prevent from that on isolated tasks with draining LRUs upon resuming to
userspace using the isolated task work framework.

It's worth noting that this is inherently racy against
lru_add_drain_all() remotely queueing the per CPU drain work and
therefore it prevents from the undesired disturbance only
*most of the time*.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/swap.h     | 1 +
 kernel/sched/isolation.c | 1 +
 mm/swap.c                | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index bd450023b9a4..bd6169c9cc14 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -393,6 +393,7 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
+extern void lru_add_and_bh_lrus_drain(void);
 void folio_deactivate(struct folio *folio);
 void folio_mark_lazyfree(struct folio *folio);
 extern void swap_setup(void);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 410df1fedc9d..68c70bea99e7 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -257,6 +257,7 @@ __setup("isolcpus=", housekeeping_isolcpus_setup);
 #if defined(CONFIG_NO_HZ_FULL)
 static void isolated_task_work(struct callback_head *head)
 {
+	lru_add_and_bh_lrus_drain();
 }
 
 int __isolated_task_work_queue(void)
diff --git a/mm/swap.c b/mm/swap.c
index 67786cb77130..a4d7e3dc2a66 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/sched/isolation.h>
 
 #include "internal.h"
 
@@ -521,6 +522,8 @@ void folio_add_lru(struct folio *folio)
 	fbatch = this_cpu_ptr(&cpu_fbatches.lru_add);
 	folio_batch_add_and_move(fbatch, folio, lru_add_fn);
 	local_unlock(&cpu_fbatches.lock);
+
+	isolated_task_work_queue();
 }
 EXPORT_SYMBOL(folio_add_lru);
 
@@ -765,7 +768,7 @@ void lru_add_drain(void)
  * the same cpu. It shouldn't be a problem in !SMP case since
  * the core is only one and the locks will disable preemption.
  */
-static void lru_add_and_bh_lrus_drain(void)
+void lru_add_and_bh_lrus_drain(void)
 {
 	local_lock(&cpu_fbatches.lock);
 	lru_add_drain_cpu(smp_processor_id());
-- 
2.45.2


