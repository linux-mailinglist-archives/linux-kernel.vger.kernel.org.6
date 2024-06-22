Return-Path: <linux-kernel+bounces-225533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB139131D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E191C223E7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9432944E;
	Sat, 22 Jun 2024 03:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlaAp8kK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701BED30B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719028731; cv=none; b=nr8CIru3PZrSqcPEwO0NfOGTViK9J8I5XlaZjwTQHKkkSkyMfDUIXPNSubrlgpXSoJ4B3CiaLHUBXHO+BAyADNgYOvubPWLgnGTrdww1Nx9ekITTEqNyCXKv9U0v6Xke+AKr5Ps40uDgJIFCjKA5erelzw4DSMSbHs+HYANvADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719028731; c=relaxed/simple;
	bh=qbOY516tJsuzI4bbQSlbHnr2zLlW6uAY5SR1yexXpx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPEOw6Muysumf1y/D0583axCutS1qJWz14CSd1RdJ9BokkwQ3Z5rkTuKijIhbgGMpY+yzcDgeO0Sg45J378XeRnDtjVeZlIFV22ACcxyHZEuqcEUGeStZx70yK31fWy1V/nEJzhiDV2IIWhL3qozwZ1DQ/yqNAYuwOse8GgeOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlaAp8kK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719028728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0Dg1NIU4Aju17NE5wHHed1iDaZiJauMtlBEOZtTK7I=;
	b=AlaAp8kKoRXQZjcb0yp3eg1jW+vAp8LBARNfAUl7DwAXoCYU1MT/Fjn0f/TC0AzjuK3+Fl
	DNEKvIhSBuOSV2oMzSoJVab4HE3L7AJCF8hCeRwl2bBgu363dvH3CzxQX6LEJ6UB13JkOU
	hIw3XJoog80O5Nb9ALz6kG1Ss+AgKnE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-jISUu8HkOM-yj133N73ZTw-1; Fri, 21 Jun 2024 23:58:46 -0400
X-MC-Unique: jISUu8HkOM-yj133N73ZTw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c7a6b95d56so2609695a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719028725; x=1719633525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0Dg1NIU4Aju17NE5wHHed1iDaZiJauMtlBEOZtTK7I=;
        b=vyy1zQffiikIlQUDnrve3/PPZENd6lR1rvGMEXOwtGq5qLBI4mpTYxhR7rcvjD7/0x
         ttWlFHIa+hWUqBFtj9x/JDRAyuWi4RigIIL4AqfVNrFZiyjy0L6nlx5dA6dNt1sGGzLz
         s1aZkVkRouff0v7Bq7tc7MNarYA75hwNucuwhpbumoJotX00LaBM7tFDDqFFvncu3nT5
         Yt4bJnsJw7sVVdz51ozrYoljETT9Gd3bGOFL5TSYcx+ek/sQoS1yaLVZF0I5F/beYWeL
         O05tiBcSoXsftIeqmYTwDPKtObE3VMczHzmqghiR/OZjmBcZIeoKRm8anSga8gpJ43Ep
         P7Mw==
X-Gm-Message-State: AOJu0YyzNovgg+DBvAcnmyMQZR6n7ka7Lrbfcun5q6OT66TwP7uIuxaS
	na5hmF/3zHuhLtdzkGwoSJhKR1rPxEu8SwVH5HcdBIaPDTMojdUF6saaNHIJG0HDziqYWxLOq6V
	cIIWrzwW1Z9819PGXKC4D4qn/LoQMijjDFJe9qzYQn7mDTwpf0x84vUSUlm3i4Q==
X-Received: by 2002:a17:903:2444:b0:1f9:d0da:5b42 with SMTP id d9443c01a7336-1f9d0da608amr58943105ad.46.1719028725074;
        Fri, 21 Jun 2024 20:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+Z05JsNeYced1ZM2XKeZjLOv76WXxQ8159J4vFgdL3RzUnlY7H/PhH/+1Ug253Ae9W8bh0A==
X-Received: by 2002:a17:903:2444:b0:1f9:d0da:5b42 with SMTP id d9443c01a7336-1f9d0da608amr58942855ad.46.1719028724605;
        Fri, 21 Jun 2024 20:58:44 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:c138:e21d:3579:5747:ad1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32b9edsm21832365ad.118.2024.06.21.20.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:58:44 -0700 (PDT)
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
Subject: [RFC PATCH v1 1/4] Introducing qpw_lock() and per-cpu queue & flush work
Date: Sat, 22 Jun 2024 00:58:09 -0300
Message-ID: <20240622035815.569665-2-leobras@redhat.com>
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

Some places in the kernel implement a parallel programming strategy
consisting on local_locks() for most of the work, and some rare remote
operations are scheduled on target cpu. This keeps cache bouncing low since
cacheline tends to be mostly local, and avoids the cost of locks in non-RT
kernels, even though the very few remote operations will be expensive due
to scheduling overhead.

On the other hand, for RT workloads this can represent a problem: getting
an important workload scheduled out to deal with some unrelated task is
sure to introduce unexpected deadline misses.

It's interesting, though, that local_lock()s in RT kernels become
spinlock(). We can make use of those to avoid scheduling work on a remote
cpu by directly updating another cpu's per_cpu structure, while holding
it's spinlock().

In order to do that, it's necessary to introduce a new set of functions to
make it possible to get another cpu's per-cpu "local" lock (qpw_{un,}lock*)
and also the corresponding queue_percpu_work_on() and flush_percpu_work()
helpers to run the remote work.

On non-RT kernels, no changes are expected, as every one of the introduced
helpers work the exactly same as the current implementation:
qpw_{un,}lock*()        ->  local_{un,}lock*() (ignores cpu parameter)
queue_percpu_work_on()  ->  queue_work_on()
flush_percpu_work()     ->  flush_work()

For RT kernels, though, qpw_{un,}lock*() will use the extra cpu parameter
to select the correct per-cpu structure to work on, and acquire the
spinlock for that cpu.

queue_percpu_work_on() will just call the requested function in the current
cpu, which will operate in another cpu's per-cpu object. Since the
local_locks() become spinlock()s in PREEMPT_RT, we are safe doing that.

flush_percpu_work() then becomes a no-op since no work is actually
scheduled on a remote cpu.

Some minimal code rework is needed in order to make this mechanism work:
The calls for local_{un,}lock*() on the functions that are currently
scheduled on remote cpus need to be replaced by qpw_{un,}lock_n*(), so in
RT kernels they can reference a different cpu. It's also necessary to use a
qpw_struct instead of a work_struct, but it just contains a work struct
and, in PREEMPT_RT, the target cpu.

This should have almost no impact on non-RT kernels: few this_cpu_ptr()
will become per_cpu_ptr(,smp_processor_id()).

On RT kernels, this should improve performance and reduce latency by
removing scheduling noise.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/linux/qpw.h

diff --git a/include/linux/qpw.h b/include/linux/qpw.h
new file mode 100644
index 000000000000..ea2686a01e5e
--- /dev/null
+++ b/include/linux/qpw.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_QPW_H
+#define _LINUX_QPW_H
+
+#include "linux/local_lock.h"
+#include "linux/workqueue.h"
+
+#ifndef CONFIG_PREEMPT_RT
+
+struct qpw_struct {
+	struct work_struct work;
+};
+
+#define qpw_lock(lock, cpu)					\
+	local_lock(lock)
+
+#define qpw_unlock(lock, cpu)					\
+	local_unlock(lock)
+
+#define qpw_lock_irqsave(lock, flags, cpu)			\
+	local_lock_irqsave(lock, flags)
+
+#define qpw_unlock_irqrestore(lock, flags, cpu)			\
+	local_unlock_irqrestore(lock, flags)
+
+#define queue_percpu_work_on(c, wq, qpw)			\
+	queue_work_on(c, wq, &(qpw)->work)
+
+#define flush_percpu_work(qpw)					\
+	flush_work(&(qpw)->work)
+
+#define qpw_get_cpu(qpw)					\
+	smp_processor_id()
+
+#define INIT_QPW(qpw, func, c)					\
+	INIT_WORK(&(qpw)->work, (func))
+
+#else /* !CONFIG_PREEMPT_RT */
+
+struct qpw_struct {
+	struct work_struct work;
+	int cpu;
+};
+
+#define qpw_lock(__lock, cpu)					\
+	do {							\
+		migrate_disable();				\
+		spin_lock(per_cpu_ptr((__lock), cpu));		\
+	} while (0)
+
+#define qpw_unlock(__lock, cpu)					\
+	do {							\
+		spin_unlock(per_cpu_ptr((__lock), cpu));	\
+		migrate_enable();				\
+	} while (0)
+
+#define qpw_lock_irqsave(lock, flags, cpu)			\
+	do {							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		qpw_lock(lock, cpu);				\
+	} while (0)
+
+#define qpw_unlock_irqrestore(lock, flags, cpu)			\
+	qpw_unlock(lock, cpu)
+
+#define queue_percpu_work_on(c, wq, qpw)			\
+	do {							\
+		struct qpw_struct *__qpw = (qpw);		\
+		WARN_ON((c) != __qpw->cpu);			\
+		__qpw->work.func(&__qpw->work);			\
+	} while (0)
+
+#define flush_percpu_work(qpw)					\
+	do {} while (0)
+
+#define qpw_get_cpu(w)						\
+	container_of((w), struct qpw_struct, work)->cpu
+
+#define INIT_QPW(qpw, func, c)					\
+	do {							\
+		struct qpw_struct *__qpw = (qpw);		\
+		INIT_WORK(&__qpw->work, (func));		\
+		__qpw->cpu = (c);				\
+	} while (0)
+
+#endif /* CONFIG_PREEMPT_RT */
+#endif /* LINUX_QPW_H */
-- 
2.45.2


