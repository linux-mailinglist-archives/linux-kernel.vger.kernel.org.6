Return-Path: <linux-kernel+bounces-395194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456E9BBA2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6E3282A53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57BA1C7B8E;
	Mon,  4 Nov 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0gPAIoF"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFCE1C75FA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737175; cv=none; b=f2s73TxzPUlcJBtje1NjUOmmX2GLDxo06NHbWq8Tfmhz1NZ4OMFdxbQpFEnxtCHHdcNgdXRwCQLkx7uEfOJY84I6aQweYuLXUyIbSnveQaXiZczPUmH/IUiJ+ReiqVK6kOLdbdNDAP93lha1u5wZ8W+C6yCc4hcdZN/CVcBy+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737175; c=relaxed/simple;
	bh=Up6Nl7a0O4dGH9BKNaqMISi3+v/Z0UXTsR+1mKX6xTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KhGmMD/cziGaG2nwfarxKIgjAt/dBWyGWuuy3uf6BY94oSvACaf3gNaZdRrSVjkGxHpOqG7pIYfTSaQZHWi2L09Jb71tULy0zbd6IITABbvS/7L+JlaN3yQlnil/v17AGOZcK5SnGKmlxWbKdF2nGr9d/TaXwLgd0YSfq6AMsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0gPAIoF; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5cbadbef8edso2980771a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730737171; x=1731341971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18LLtGEOGzu+73DHRju+ymYzFojyLpzj5nOA/GmHSqU=;
        b=x0gPAIoFxTbBNqkE+RXlvqaV72b26E2WQVWxcUgyEB7904T2ZfA3apDunA2GZT8ZLo
         7jOhUMMEYZQXTtOcZyXOWrkmESRSfEaiOKAYHSCJErR/49GfEEL1qfQZI5jM15LkEMqH
         rLpU+0fDNAVHfVxBG+ZQvpKgG+F8IaBFAOYyAAZ2OWie+xTU2JVHGQLjxbF3BYgCTUI8
         2SPPOyDTHFH2MySx3t7R8wcCqaNfUJuct/qFHdsmMcTf6Oy6OGaDDFIrwtSxKja+xBf+
         A05Qxl15JdNsA1P5ri+Bj/dXhD9j+xoLdXRQe0a0ogBTjFs1eyvqL6BPjllP4ML6fmfv
         Om6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737171; x=1731341971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18LLtGEOGzu+73DHRju+ymYzFojyLpzj5nOA/GmHSqU=;
        b=EwyrU5LkNZGUc++3XHQYCSTwkLxJ6LxRvILSVt4XE7FyBOKPN2mdiuH8bzZ42EQEa/
         /WXkUPSOn1ifn7tWZbdTSR/9ek6ZCAUry9XpVYIEfn41jx5QuehiXLLEWDL5pdmJKNtU
         mTMYqIHzGOBJT0hMvD9x0o/yCw/vSt61q+S7BYorF3ihwYEuxwddqnK+Pmheicckt1hQ
         45YEjNnMAwEJLZbcnkZOU7nni+hxTZsW0lMID8ufaVeQcHrwk/NS3mnoZcfjB0IDAXKg
         IP1HM0leAtSw1e+ujqqqPJxIVI2qeaIs43OZD9XIHm/UCHTMVCLv8kfLb4fPbKK0mOxp
         yfKw==
X-Forwarded-Encrypted: i=1; AJvYcCUCXzzBzf1Nx/Br3guhgukVanCvsu408KfU4jqjH/87OQRLXzJPmsfql+u7nkHjQbzEKHmBuJevVkaRV14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfoeXGpMP8G8pQFvAt59nu8WxPu9fU1cr88vWPgV+wlQWWoRmZ
	QBibcnH9JfYegnjdkKYWFBsiXui7U514EHeR6wURPBK6e4Q+1uP7t/62ci6O6Ljc/RDIASrNnQ=
	=
X-Google-Smtp-Source: AGHT+IETLznCWJ7078mtEN2zw0LHcGVF522oHU07UWHIjL8ZqDdYAFPjAmLuAomnIYwKTJ+LzM/igFJm+Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dc4d:3b27:d746:73ee])
 (user=elver job=sendgmr) by 2002:a05:6402:2350:b0:5cb:c081:92b2 with SMTP id
 4fb4d7f45d1cf-5cea966ac74mr5044a12.1.1730737171303; Mon, 04 Nov 2024 08:19:31
 -0800 (PST)
Date: Mon,  4 Nov 2024 16:43:07 +0100
In-Reply-To: <20241104161910.780003-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104161910.780003-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104161910.780003-4-elver@google.com>
Subject: [PATCH v2 3/5] kcsan, seqlock: Support seqcount_latch_t
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

While fuzzing an arm64 kernel, Alexander Potapenko reported:

| BUG: KCSAN: data-race in ktime_get_mono_fast_ns / timekeeping_update
|
| write to 0xffffffc082e74248 of 56 bytes by interrupt on cpu 0:
|  update_fast_timekeeper kernel/time/timekeeping.c:430 [inline]
|  timekeeping_update+0x1d8/0x2d8 kernel/time/timekeeping.c:768
|  timekeeping_advance+0x9e8/0xb78 kernel/time/timekeeping.c:2344
|  update_wall_time+0x18/0x38 kernel/time/timekeeping.c:2360
|  [...]
|
| read to 0xffffffc082e74258 of 8 bytes by task 5260 on cpu 1:
|  __ktime_get_fast_ns kernel/time/timekeeping.c:372 [inline]
|  ktime_get_mono_fast_ns+0x88/0x174 kernel/time/timekeeping.c:489
|  init_srcu_struct_fields+0x40c/0x530 kernel/rcu/srcutree.c:263
|  init_srcu_struct+0x14/0x20 kernel/rcu/srcutree.c:311
|  [...]
|
| value changed: 0x000002f875d33266 -> 0x000002f877416866
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 1 UID: 0 PID: 5260 Comm: syz.2.7483 Not tainted 6.12.0-rc3-dirty #78

This is a false positive data race between a seqcount latch writer and a reader
accessing stale data. Since its introduction, KCSAN has never understood the
seqcount_latch interface (due to being unannotated).

Unlike the regular seqlock interface, the seqcount_latch interface for latch
writers never has had a well-defined critical section, making it difficult to
teach tooling where the critical section starts and ends.

Introduce an instrumentable (non-raw) seqcount_latch interface, with
which we can clearly denote writer critical sections. This both helps
readability and tooling like KCSAN to understand when the writer is done
updating all latch copies.

Link: https://lore.kernel.org/all/20241030204815.GQ14555@noisy.programming.kicks-ass.net/
Reported-by: Alexander Potapenko <glider@google.com>
Fixes: 88ecd153be95 ("seqlock, kcsan: Add annotations for KCSAN")
Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Introduce new interface, courtesy of Peter Zijlstra. Adjust
  documentation along with its introduction.
---
 Documentation/locking/seqlock.rst |  2 +-
 include/linux/seqlock.h           | 86 +++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index bfda1a5fecad..ec6411d02ac8 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -153,7 +153,7 @@ Use seqcount_latch_t when the write side sections cannot be protected
 from interruption by readers. This is typically the case when the read
 side can be invoked from NMI handlers.
 
-Check `raw_write_seqcount_latch()` for more information.
+Check `write_seqcount_latch()` for more information.
 
 
 .. _seqlock_t:
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index fffeb754880f..45eee0e5dca0 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -621,6 +621,23 @@ static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *
 	return READ_ONCE(s->seqcount.sequence);
 }
 
+/**
+ * read_seqcount_latch() - pick even/odd latch data copy
+ * @s: Pointer to seqcount_latch_t
+ *
+ * See write_seqcount_latch() for details and a full reader/writer usage
+ * example.
+ *
+ * Return: sequence counter raw value. Use the lowest bit as an index for
+ * picking which data copy to read. The full counter must then be checked
+ * with read_seqcount_latch_retry().
+ */
+static __always_inline unsigned read_seqcount_latch(const seqcount_latch_t *s)
+{
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
+	return raw_read_seqcount_latch(s);
+}
+
 /**
  * raw_read_seqcount_latch_retry() - end a seqcount_latch_t read section
  * @s:		Pointer to seqcount_latch_t
@@ -635,9 +652,34 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
 	return unlikely(READ_ONCE(s->seqcount.sequence) != start);
 }
 
+/**
+ * read_seqcount_latch_retry() - end a seqcount_latch_t read section
+ * @s:		Pointer to seqcount_latch_t
+ * @start:	count, from read_seqcount_latch()
+ *
+ * Return: true if a read section retry is required, else false
+ */
+static __always_inline int
+read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
+{
+	kcsan_atomic_next(0);
+	return raw_read_seqcount_latch_retry(s, start);
+}
+
 /**
  * raw_write_seqcount_latch() - redirect latch readers to even/odd copy
  * @s: Pointer to seqcount_latch_t
+ */
+static __always_inline void raw_write_seqcount_latch(seqcount_latch_t *s)
+{
+	smp_wmb();	/* prior stores before incrementing "sequence" */
+	s->seqcount.sequence++;
+	smp_wmb();      /* increment "sequence" before following stores */
+}
+
+/**
+ * write_seqcount_latch_begin() - redirect latch readers to odd copy
+ * @s: Pointer to seqcount_latch_t
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -665,17 +707,11 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
  *
  *	void latch_modify(struct latch_struct *latch, ...)
  *	{
- *		smp_wmb();	// Ensure that the last data[1] update is visible
- *		latch->seq.sequence++;
- *		smp_wmb();	// Ensure that the seqcount update is visible
- *
+ *		write_seqcount_latch_begin(&latch->seq);
  *		modify(latch->data[0], ...);
- *
- *		smp_wmb();	// Ensure that the data[0] update is visible
- *		latch->seq.sequence++;
- *		smp_wmb();	// Ensure that the seqcount update is visible
- *
+ *		write_seqcount_latch(&latch->seq);
  *		modify(latch->data[1], ...);
+ *		write_seqcount_latch_end(&latch->seq);
  *	}
  *
  * The query will have a form like::
@@ -686,13 +722,13 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
  *		unsigned seq, idx;
  *
  *		do {
- *			seq = raw_read_seqcount_latch(&latch->seq);
+ *			seq = read_seqcount_latch(&latch->seq);
  *
  *			idx = seq & 0x01;
  *			entry = data_query(latch->data[idx], ...);
  *
  *		// This includes needed smp_rmb()
- *		} while (raw_read_seqcount_latch_retry(&latch->seq, seq));
+ *		} while (read_seqcount_latch_retry(&latch->seq, seq));
  *
  *		return entry;
  *	}
@@ -716,11 +752,31 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
  */
-static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
+static __always_inline void write_seqcount_latch_begin(seqcount_latch_t *s)
 {
-	smp_wmb();	/* prior stores before incrementing "sequence" */
-	s->seqcount.sequence++;
-	smp_wmb();      /* increment "sequence" before following stores */
+	kcsan_nestable_atomic_begin();
+	raw_write_seqcount_latch(s);
+}
+
+/**
+ * write_seqcount_latch() - redirect latch readers to even copy
+ * @s: Pointer to seqcount_latch_t
+ */
+static __always_inline void write_seqcount_latch(seqcount_latch_t *s)
+{
+	raw_write_seqcount_latch(s);
+}
+
+/**
+ * write_seqcount_latch_end() - end a seqcount_latch_t write section
+ * @s:		Pointer to seqcount_latch_t
+ *
+ * Marks the end of a seqcount_latch_t writer section, after all copies of the
+ * latch-protected data have been updated.
+ */
+static __always_inline void write_seqcount_latch_end(seqcount_latch_t *s)
+{
+	kcsan_nestable_atomic_end();
 }
 
 #define __SEQLOCK_UNLOCKED(lockname)					\
-- 
2.47.0.163.g1226f6d8fa-goog


