Return-Path: <linux-kernel+bounces-223761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B01A9117E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77AF1F22F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955CD15BB;
	Fri, 21 Jun 2024 01:09:12 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1610F2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718932152; cv=none; b=DLuwWG04NlS03n+OYohTZzbjNg5ZRGTQexBp7enoK+PD4kCf1WfE5FZvS7jch7Q/sZ0SNF+Z0OP7nA1YOAJbBdz4bCZzXvdAofRfkffxqyyLdWvwgp1+CkRzcGTCGKs0ZFjx7tDyE1cYbUVu+FQIefdkX6z27jA3IBtRyWPTInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718932152; c=relaxed/simple;
	bh=u8geJ5k3uGov17fXFMZYp5s0fMiVhV31L/wveKna3Gs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GIexmbWWsiJqfX37ATmrEgRw8+03A/HrLBEZ8Tic1JDmyJ8UVgTBvYkdMGPpCxezW0HjHeu4ADsRDUyi4zCmLmN/b4TqJWYOVvKlGcVHcG7GumhCrKGtlQs3vOjvTSITFHjDdPwWX0XQMJ0WsD0n7P3THKU512cHW3NyvL5Xj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45L18f83070744;
	Fri, 21 Jun 2024 10:08:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Fri, 21 Jun 2024 10:08:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45L18fsN070735
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 21 Jun 2024 10:08:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ef22d289-eadb-4ed9-863b-fbc922b33d8d@I-love.SAKURA.ne.jp>
Date: Fri, 21 Jun 2024 10:08:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Axel Rasmussen <axelrasmussen@google.com>, linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] mm: mmap_lock: replace get_memcg_path_buf() with on-stack
 buffer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 2b5067a8143e ("mm: mmap_lock: add tracepoints around lock
acquisition") introduced TRACE_MMAP_LOCK_EVENT() macro using
preempt_disable() in order to let get_mm_memcg_path() return a percpu
buffer exclusively used by normal, softirq, irq and NMI contexts
respectively.

Commit 832b50725373 ("mm: mmap_lock: use local locks instead of disabling
preemption") replaced preempt_disable() with local_lock(&memcg_paths.lock)
based on an argument that preempt_disable() has to be avoided because
get_mm_memcg_path() might sleep if PREEMPT_RT=y.

But syzbot started reporting

  inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.

and

  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.

messages, for local_lock() does not disable IRQ.

We could replace local_lock() with local_lock_irqsave() in order to
suppress these messages. But this patch instead replaces percpu buffers
with on-stack buffer, for the size of each buffer returned by
get_memcg_path_buf() is only 256 bytes which is tolerable for allocating
 from current thread's kernel stack memory.

Reported-by: syzbot <syzbot+40905bca570ae6784745@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=40905bca570ae6784745
Fixes: 832b50725373 ("mm: mmap_lock: use local locks instead of disabling preemption")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Only compile tested.

 mm/mmap_lock.c | 175 ++++++-------------------------------------------
 1 file changed, 20 insertions(+), 155 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 1854850b4b89..368b840e7508 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -19,14 +19,7 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
 
 #ifdef CONFIG_MEMCG
 
-/*
- * Our various events all share the same buffer (because we don't want or need
- * to allocate a set of buffers *per event type*), so we need to protect against
- * concurrent _reg() and _unreg() calls, and count how many _reg() calls have
- * been made.
- */
-static DEFINE_MUTEX(reg_lock);
-static int reg_refcount; /* Protected by reg_lock. */
+static atomic_t reg_refcount;
 
 /*
  * Size of the buffer for memcg path names. Ignoring stack trace support,
@@ -34,136 +27,22 @@ static int reg_refcount; /* Protected by reg_lock. */
  */
 #define MEMCG_PATH_BUF_SIZE MAX_FILTER_STR_VAL
 
-/*
- * How many contexts our trace events might be called in: normal, softirq, irq,
- * and NMI.
- */
-#define CONTEXT_COUNT 4
-
-struct memcg_path {
-	local_lock_t lock;
-	char __rcu *buf;
-	local_t buf_idx;
-};
-static DEFINE_PER_CPU(struct memcg_path, memcg_paths) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-	.buf_idx = LOCAL_INIT(0),
-};
-
-static char **tmp_bufs;
-
-/* Called with reg_lock held. */
-static void free_memcg_path_bufs(void)
-{
-	struct memcg_path *memcg_path;
-	int cpu;
-	char **old = tmp_bufs;
-
-	for_each_possible_cpu(cpu) {
-		memcg_path = per_cpu_ptr(&memcg_paths, cpu);
-		*(old++) = rcu_dereference_protected(memcg_path->buf,
-			lockdep_is_held(&reg_lock));
-		rcu_assign_pointer(memcg_path->buf, NULL);
-	}
-
-	/* Wait for inflight memcg_path_buf users to finish. */
-	synchronize_rcu();
-
-	old = tmp_bufs;
-	for_each_possible_cpu(cpu) {
-		kfree(*(old++));
-	}
-
-	kfree(tmp_bufs);
-	tmp_bufs = NULL;
-}
-
 int trace_mmap_lock_reg(void)
 {
-	int cpu;
-	char *new;
-
-	mutex_lock(&reg_lock);
-
-	/* If the refcount is going 0->1, proceed with allocating buffers. */
-	if (reg_refcount++)
-		goto out;
-
-	tmp_bufs = kmalloc_array(num_possible_cpus(), sizeof(*tmp_bufs),
-				 GFP_KERNEL);
-	if (tmp_bufs == NULL)
-		goto out_fail;
-
-	for_each_possible_cpu(cpu) {
-		new = kmalloc(MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_KERNEL);
-		if (new == NULL)
-			goto out_fail_free;
-		rcu_assign_pointer(per_cpu_ptr(&memcg_paths, cpu)->buf, new);
-		/* Don't need to wait for inflights, they'd have gotten NULL. */
-	}
-
-out:
-	mutex_unlock(&reg_lock);
+	atomic_inc(&reg_refcount);
 	return 0;
-
-out_fail_free:
-	free_memcg_path_bufs();
-out_fail:
-	/* Since we failed, undo the earlier ref increment. */
-	--reg_refcount;
-
-	mutex_unlock(&reg_lock);
-	return -ENOMEM;
 }
 
 void trace_mmap_lock_unreg(void)
 {
-	mutex_lock(&reg_lock);
-
-	/* If the refcount is going 1->0, proceed with freeing buffers. */
-	if (--reg_refcount)
-		goto out;
-
-	free_memcg_path_bufs();
-
-out:
-	mutex_unlock(&reg_lock);
-}
-
-static inline char *get_memcg_path_buf(void)
-{
-	struct memcg_path *memcg_path = this_cpu_ptr(&memcg_paths);
-	char *buf;
-	int idx;
-
-	rcu_read_lock();
-	buf = rcu_dereference(memcg_path->buf);
-	if (buf == NULL) {
-		rcu_read_unlock();
-		return NULL;
-	}
-	idx = local_add_return(MEMCG_PATH_BUF_SIZE, &memcg_path->buf_idx) -
-	      MEMCG_PATH_BUF_SIZE;
-	return &buf[idx];
+	atomic_dec(&reg_refcount);
 }
 
-static inline void put_memcg_path_buf(void)
-{
-	local_sub(MEMCG_PATH_BUF_SIZE, &this_cpu_ptr(&memcg_paths)->buf_idx);
-	rcu_read_unlock();
-}
-
-#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
-	do {                                                                   \
-		const char *memcg_path;                                        \
-		local_lock(&memcg_paths.lock);                                 \
-		memcg_path = get_mm_memcg_path(mm);                            \
-		trace_mmap_lock_##type(mm,                                     \
-				       memcg_path != NULL ? memcg_path : "",   \
-				       ##__VA_ARGS__);                         \
-		if (likely(memcg_path != NULL))                                \
-			put_memcg_path_buf();                                  \
-		local_unlock(&memcg_paths.lock);                               \
+#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                    \
+	do {                                                    \
+		char buf[MEMCG_PATH_BUF_SIZE];                  \
+		get_mm_memcg_path(mm, buf, sizeof(buf));        \
+		trace_mmap_lock_##type(mm, buf, ##__VA_ARGS__); \
 	} while (0)
 
 #else /* !CONFIG_MEMCG */
@@ -185,37 +64,23 @@ void trace_mmap_lock_unreg(void)
 #ifdef CONFIG_TRACING
 #ifdef CONFIG_MEMCG
 /*
- * Write the given mm_struct's memcg path to a percpu buffer, and return a
- * pointer to it. If the path cannot be determined, or no buffer was available
- * (because the trace event is being unregistered), NULL is returned.
- *
- * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
- * disabled by the caller before calling us, and re-enabled only after the
- * caller is done with the pointer.
- *
- * The caller must call put_memcg_path_buf() once the buffer is no longer
- * needed. This must be done while preemption is still disabled.
+ * Write the given mm_struct's memcg path to a buffer. If the path cannot be
+ * determined or the trace event is being unregistered, empty string is written.
  */
-static const char *get_mm_memcg_path(struct mm_struct *mm)
+static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t buflen)
 {
-	char *buf = NULL;
-	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
+	struct mem_cgroup *memcg;
 
+	buf[0] = '\0';
+	/* No need to get path if no trace event is registered. */
+	if (!atomic_read(&reg_refcount))
+		return;
+	memcg = get_mem_cgroup_from_mm(mm);
 	if (memcg == NULL)
-		goto out;
-	if (unlikely(memcg->css.cgroup == NULL))
-		goto out_put;
-
-	buf = get_memcg_path_buf();
-	if (buf == NULL)
-		goto out_put;
-
-	cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
-
-out_put:
+		return;
+	if (memcg->css.cgroup)
+		cgroup_path(memcg->css.cgroup, buf, buflen);
 	css_put(&memcg->css);
-out:
-	return buf;
 }
 
 #endif /* CONFIG_MEMCG */
-- 
2.43.0


