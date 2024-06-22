Return-Path: <linux-kernel+bounces-225534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB109131D8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27294284B91
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CB171AF;
	Sat, 22 Jun 2024 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaJcBGfi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525715E85
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719028736; cv=none; b=o9orj7PU0UNkHQe44eKjvbDx1CqYcG11ZkLyh7Dv+zh6bN5dPNbMHTw1YUKKmJinT96Fz9alU1IT9aPaYPS5NOyLAy3peawWOBeG1M4bCqGKDE4+aC0lrP5u7WqijDcxsaxMZ/mFJe+tAw3szxog5KdM5kUBFavlkfSur2549y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719028736; c=relaxed/simple;
	bh=AK4cQ6JDjcWZj/DqnoVDPSCWzPANRJ/7p5R4kSbF65w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1rZS5GyaBfv5HHLyfHDN8GzPMdd65nwZ/gPL7leozJABwhNPizszA5s6Tm090VfiLcc+vWHQKdoZDC9o8t3O/PdJDiU1C+Ra7rvNWf8Rr8o4AWijg9yhakfxKu1gU+NpTS6weqCMJafT5hj9L4vEDZ4c2krp1EThd6VRQxJIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaJcBGfi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719028733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ33pz4CG9kAvALadE1yZYVBLwtylkbWD53nilFvhZA=;
	b=OaJcBGfiLFa353ZRK0j6i2ErF5npKk8Esf9Mqi8MHn8LTW/pFwn4aL7kKY4BEmEpDFz/kl
	tfYRlHy7PlQdfrzjSx/fzYXQOdfZyEy7HuuFIA+xdZvEr+9Rqt1lSk/5J46662ggG4+6yw
	dJBCQEKeX2/5FnnsZxs6qm7SyOjJIzU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-EWSWrVJkNhmcLvXKCtPagA-1; Fri, 21 Jun 2024 23:58:51 -0400
X-MC-Unique: EWSWrVJkNhmcLvXKCtPagA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f71d5a85f9so31798505ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719028731; x=1719633531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ33pz4CG9kAvALadE1yZYVBLwtylkbWD53nilFvhZA=;
        b=hnM5cEFhm1Mk0i9fHlq/5ncBZFi55dX4B2uqCtVQSAEANCXtlYuRGuGcJbw9CSgNB6
         kAAuN6rp0BEVIElyZ2Ola8cihSc09TUdAw0dqYe3l6hRFdNkN5N+YivZKz+IYVxlP1HT
         5jckUfwoiP+ZAEtLK6c9ThTRrm3RnO1XVB5hMo6Ruyhe9fILpC/bAeJb1zEY3GjZ84J/
         luuhoBK0D2e6nCrutBwEIqITCTDjx/q2gq2/7wrJCaBcG+hMKY/IYsAwA8DhjB992NGz
         cZ+83su15DLUzuu1PIl6QPtwfQzjr3TRXYbcxgBBaIApCxT6Std7T5K67/o4lYNVLwES
         6WGg==
X-Gm-Message-State: AOJu0YxOI8n5n5OMiJibBB+Reb62xEh/Rrw20KZwb+1V6VFGgoaKMUuG
	1j75ohnk80pHoAolihmqtkU3cH+efHPr8TJ/+Me33oNoQ7Vs43n4tFiec995+Ys32xwALC/xeeQ
	gvdtsgvKxb+T++FEIDox1FVz3qWFhVVo+vFwyOq1lQt1SUdSNZ/SrNvpoDPU5pQ==
X-Received: by 2002:a17:903:1cf:b0:1f9:9d40:c9bf with SMTP id d9443c01a7336-1f9aa4121cdmr114843435ad.18.1719028730789;
        Fri, 21 Jun 2024 20:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt4UWWF8YWLxNNykxeuK6L5NtoG3cPihSQQtBcVaMFhxxpNx9bPrFdzerXafMwk+8wW98i8A==
X-Received: by 2002:a17:903:1cf:b0:1f9:9d40:c9bf with SMTP id d9443c01a7336-1f9aa4121cdmr114843195ad.18.1719028730370;
        Fri, 21 Jun 2024 20:58:50 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:c138:e21d:3579:5747:ad1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32b9edsm21832365ad.118.2024.06.21.20.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:58:49 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 2/4] swap: apply new queue_percpu_work_on() interface
Date: Sat, 22 Jun 2024 00:58:10 -0300
Message-ID: <20240622035815.569665-3-leobras@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622035815.569665-1-leobras@redhat.com>
References: <20240622035815.569665-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the new qpw_{un,}lock*() and queue_percpu_work_on()
interface to improve performance & latency on PREEMTP_RT kernels.

For functions that may be scheduled in a different cpu, replace
local_{un,}lock*() by qpw_{un,}lock*(), and replace schedule_work_on() by
queue_percpu_work_on(). The same happens for flush_work() and
flush_percpu_work().

The change requires allocation of qpw_structs instead of a work_structs,
and changing parameters of a few functions to include the cpu parameter.

This should bring no relevant performance impact on non-RT kernels:
For functions that may be scheduled in a different cpu, the local_*lock's
this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/swap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 67786cb77130..c1a61b7cd71a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -28,21 +28,21 @@
 #include <linux/memremap.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/backing-dev.h>
 #include <linux/memcontrol.h>
 #include <linux/gfp.h>
 #include <linux/uio.h>
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
-#include <linux/local_lock.h>
+#include <linux/qpw.h>
 #include <linux/buffer_head.h>
 
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/pagemap.h>
 
 /* How many pages do we try to swap or page in/out together? As a power of 2 */
 int page_cluster;
 const int page_cluster_max = 31;
@@ -758,45 +758,45 @@ void lru_add_drain(void)
 	local_unlock(&cpu_fbatches.lock);
 	mlock_drain_local();
 }
 
 /*
  * It's called from per-cpu workqueue context in SMP case so
  * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
  * the same cpu. It shouldn't be a problem in !SMP case since
  * the core is only one and the locks will disable preemption.
  */
-static void lru_add_and_bh_lrus_drain(void)
+static void lru_add_and_bh_lrus_drain(int cpu)
 {
-	local_lock(&cpu_fbatches.lock);
-	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&cpu_fbatches.lock);
+	qpw_lock(&cpu_fbatches.lock, cpu);
+	lru_add_drain_cpu(cpu);
+	qpw_unlock(&cpu_fbatches.lock, cpu);
 	invalidate_bh_lrus_cpu();
 	mlock_drain_local();
 }
 
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
 	local_lock(&cpu_fbatches.lock);
 	lru_add_drain_cpu(smp_processor_id());
 	drain_local_pages(zone);
 	local_unlock(&cpu_fbatches.lock);
 	mlock_drain_local();
 }
 
 #ifdef CONFIG_SMP
 
-static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+static DEFINE_PER_CPU(struct qpw_struct, lru_add_drain_qpw);
 
-static void lru_add_drain_per_cpu(struct work_struct *dummy)
+static void lru_add_drain_per_cpu(struct work_struct *w)
 {
-	lru_add_and_bh_lrus_drain();
+	lru_add_and_bh_lrus_drain(qpw_get_cpu(w));
 }
 
 static bool cpu_needs_drain(unsigned int cpu)
 {
 	struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
 
 	/* Check these in order of likelihood that they're not zero */
 	return folio_batch_count(&fbatches->lru_add) ||
 		data_race(folio_batch_count(&per_cpu(lru_rotate.fbatch, cpu))) ||
 		folio_batch_count(&fbatches->lru_deactivate_file) ||
@@ -882,31 +882,31 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 	 *
 	 * If the paired barrier is done at any later step, e.g. after the
 	 * loop, CPU #x will just exit at (C) and miss flushing out all of its
 	 * added pages.
 	 */
 	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
 	smp_mb();
 
 	cpumask_clear(&has_work);
 	for_each_online_cpu(cpu) {
-		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+		struct qpw_struct *qpw = &per_cpu(lru_add_drain_qpw, cpu);
 
 		if (cpu_needs_drain(cpu)) {
-			INIT_WORK(work, lru_add_drain_per_cpu);
-			queue_work_on(cpu, mm_percpu_wq, work);
+			INIT_QPW(qpw, lru_add_drain_per_cpu, cpu);
+			queue_percpu_work_on(cpu, mm_percpu_wq, qpw);
 			__cpumask_set_cpu(cpu, &has_work);
 		}
 	}
 
 	for_each_cpu(cpu, &has_work)
-		flush_work(&per_cpu(lru_add_drain_work, cpu));
+		flush_percpu_work(&per_cpu(lru_add_drain_qpw, cpu));
 
 done:
 	mutex_unlock(&lock);
 }
 
 void lru_add_drain_all(void)
 {
 	__lru_add_drain_all(false);
 }
 #else
@@ -939,21 +939,21 @@ void lru_cache_disable(void)
 	 *
 	 * Since v5.1 kernel, synchronize_rcu() is guaranteed to wait on
 	 * preempt_disable() regions of code. So any CPU which sees
 	 * lru_disable_count = 0 will have exited the critical
 	 * section when synchronize_rcu() returns.
 	 */
 	synchronize_rcu_expedited();
 #ifdef CONFIG_SMP
 	__lru_add_drain_all(true);
 #else
-	lru_add_and_bh_lrus_drain();
+	lru_add_and_bh_lrus_drain(smp_processor_id());
 #endif
 }
 
 /**
  * folios_put_refs - Reduce the reference count on a batch of folios.
  * @folios: The folios.
  * @refs: The number of refs to subtract from each folio.
  *
  * Like folio_put(), but for a batch of folios.  This is more efficient
  * than writing the loop yourself as it will optimise the locks which need
-- 
2.45.2


