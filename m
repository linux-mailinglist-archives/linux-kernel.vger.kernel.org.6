Return-Path: <linux-kernel+bounces-225536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD89131DC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB541F23143
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5298715E85;
	Sat, 22 Jun 2024 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSrKaoiI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBAC13B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719028747; cv=none; b=jP/EBq37vlWE9KdZGPnplpgE87mniPBFNzytluTfJxmakYWPqPbgcll80ykrkgzNrXV2RmizJRmh4vY9Cjwdg3Lv/phXwxMbRu2ogBM50ZBQClee94G4UCFyjl++Pd7+ZGhUzEh/dYqYSEfksWMJyXDyfu8amwIk1BrUCN6jaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719028747; c=relaxed/simple;
	bh=/ufCsQJXWSGzeKck9gEeAyEHT7TWU+q2u595g0WVpMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAcYT19oJ7Gm8fqA24n1bCEYeAUljWg4e/4SN3h9KG5BPzTOEMXG3bG1y3QdZfpzzzGkbdhHwDLGXwrOT7xXnm0s+d67fv2S9j6cGebRZdDwWED+GsB8DD1d68j6c8zaSDgcZzgPWw8Y/WM+Nshpe+MoUEoYTM2ZpEs3xHpdfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSrKaoiI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719028744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gr/4mKEcg1BO/1nqaoL0eifI3AwTZgGcUhIFK99x5ho=;
	b=TSrKaoiIt/CS/qzShgkJYqq4FOLzYCw0sKEi1Y6qUtH4ciglOqKZ1qL3x9eohq9sSr/kH4
	3/Mo20ryTctWOgve1oRD9+Y+IofCouyZdzbawMNtfASVRAGdxH9GhT+Tfp9X4fypaeCxNx
	xxpX/h+PCVrVNYAvhIrWJbLZWd0m1K8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-v2DIr53ZMMi8GRPC2KhddA-1; Fri, 21 Jun 2024 23:59:03 -0400
X-MC-Unique: v2DIr53ZMMi8GRPC2KhddA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c7430b3c4bso2866720a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719028742; x=1719633542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gr/4mKEcg1BO/1nqaoL0eifI3AwTZgGcUhIFK99x5ho=;
        b=R7MFGMTHcNrPeiNYfRFE47mDNL35MjQdu+x/kIsFTfhd9i5pCRtVrIan+2SDfrBo9J
         0BuzUv2WCeX3OWUIw9LyGPf6K0adMM6d+YR4YjNmpXO8ITO2M1rXclEjJUD6YKPp0iMk
         oGOOHgMmT8jmDn5BGCNDY6O0hnp/uelqFH3tjsDt3U1106T7vauohaNEnlKnkwcDSt+n
         tQuIeUQcWwnLIGqzjnd31V3a9+mPnS2b+wy6k/s2mII5zQflPQLK1LFmeQAlj2VtWH4i
         rhTJLE4bsi2r7iW/+oYamx1S7O/2BS40mglD+seFeuZ+7uIoktOZVE76ZBPWtSA6XzlQ
         eUTw==
X-Gm-Message-State: AOJu0YzkgqWm3JdBBknsAp+SZDsySZiAJXLHr/NoixIrf3OBVRXavyRq
	hiMflaNgdQVzHcPAGVVRu/klKob4tmRrwNaqLHPGTgQhsFUrJrtXr9ClruRwMMm5ar9EvU3RyPu
	C8wCtcZ92k3ZD2exX3O22ukOpZFl/o2ScX+RlsQBIQYKzD2zVtCw1l3d6DYGT/g==
X-Received: by 2002:a17:90a:6006:b0:2c3:cc6:636e with SMTP id 98e67ed59e1d1-2c7b59fa68cmr10387325a91.2.1719028742277;
        Fri, 21 Jun 2024 20:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbqsAmN/2usMDnEbfUaqXha6LBh1OFap3JUlsvia0ZFkQTobQ3J2rvz24LicWySb2pIwxdrA==
X-Received: by 2002:a17:90a:6006:b0:2c3:cc6:636e with SMTP id 98e67ed59e1d1-2c7b59fa68cmr10387308a91.2.1719028741834;
        Fri, 21 Jun 2024 20:59:01 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:c138:e21d:3579:5747:ad1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32b9edsm21832365ad.118.2024.06.21.20.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:59:01 -0700 (PDT)
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
Subject: [RFC PATCH v1 4/4] slub: apply new queue_percpu_work_on() interface
Date: Sat, 22 Jun 2024 00:58:12 -0300
Message-ID: <20240622035815.569665-5-leobras@redhat.com>
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

This change requires allocation of qpw_structs instead of a work_structs,
and changing parameters of a few functions to include the cpu parameter.

This should bring no relevant performance impact on non-RT kernels:
For functions that may be scheduled in a different cpu, the local_*lock's
this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/slub.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1373ac365a46..5cd91541906e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -35,20 +35,21 @@
 #include <linux/math64.h>
 #include <linux/fault-inject.h>
 #include <linux/kmemleak.h>
 #include <linux/stacktrace.h>
 #include <linux/prefetch.h>
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/sort.h>
+#include <linux/qpw.h>
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
 
 #include "internal.h"
 
 /*
  * Lock order:
  *   1. slab_mutex (Global Mutex)
  *   2. node->list_lock (Spinlock)
@@ -3073,36 +3074,37 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 }
 
 #else	/* CONFIG_SLUB_CPU_PARTIAL */
 
 static inline void put_partials(struct kmem_cache *s) { }
 static inline void put_partials_cpu(struct kmem_cache *s,
 				    struct kmem_cache_cpu *c) { }
 
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 
-static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
+static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
+			      int cpu)
 {
 	unsigned long flags;
 	struct slab *slab;
 	void *freelist;
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	qpw_lock_irqsave(&s->cpu_slab->lock, flags, cpu);
 
 	slab = c->slab;
 	freelist = c->freelist;
 
 	c->slab = NULL;
 	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
 
-	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+	qpw_unlock_irqrestore(&s->cpu_slab->lock, flags, cpu);
 
 	if (slab) {
 		deactivate_slab(s, slab, freelist);
 		stat(s, CPUSLAB_FLUSH);
 	}
 }
 
 static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
@@ -3115,82 +3117,84 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 
 	if (slab) {
 		deactivate_slab(s, slab, freelist);
 		stat(s, CPUSLAB_FLUSH);
 	}
 
 	put_partials_cpu(s, c);
 }
 
 struct slub_flush_work {
-	struct work_struct work;
+	struct qpw_struct qpw;
 	struct kmem_cache *s;
 	bool skip;
 };
 
+static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
+
 /*
  * Flush cpu slab.
  *
  * Called from CPU work handler with migration disabled.
  */
 static void flush_cpu_slab(struct work_struct *w)
 {
 	struct kmem_cache *s;
 	struct kmem_cache_cpu *c;
 	struct slub_flush_work *sfw;
+	int cpu = qpw_get_cpu(w);
 
-	sfw = container_of(w, struct slub_flush_work, work);
+	sfw = &per_cpu(slub_flush, cpu);
 
 	s = sfw->s;
-	c = this_cpu_ptr(s->cpu_slab);
+	c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	if (c->slab)
-		flush_slab(s, c);
+		flush_slab(s, c, cpu);
 
 	put_partials(s);
 }
 
 static bool has_cpu_slab(int cpu, struct kmem_cache *s)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	return c->slab || slub_percpu_partial(c);
 }
 
 static DEFINE_MUTEX(flush_lock);
-static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
 
 static void flush_all_cpus_locked(struct kmem_cache *s)
 {
 	struct slub_flush_work *sfw;
 	unsigned int cpu;
 
 	lockdep_assert_cpus_held();
 	mutex_lock(&flush_lock);
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
 		if (!has_cpu_slab(cpu, s)) {
 			sfw->skip = true;
 			continue;
 		}
-		INIT_WORK(&sfw->work, flush_cpu_slab);
+		INIT_QPW(&sfw->qpw, flush_cpu_slab, cpu);
 		sfw->skip = false;
 		sfw->s = s;
-		queue_work_on(cpu, flushwq, &sfw->work);
+		queue_percpu_work_on(cpu, flushwq, &sfw->qpw);
 	}
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
 		if (sfw->skip)
 			continue;
-		flush_work(&sfw->work);
+		flush_percpu_work(&sfw->qpw);
 	}
 
 	mutex_unlock(&flush_lock);
 }
 
 static void flush_all(struct kmem_cache *s)
 {
 	cpus_read_lock();
 	flush_all_cpus_locked(s);
 	cpus_read_unlock();
-- 
2.45.2


