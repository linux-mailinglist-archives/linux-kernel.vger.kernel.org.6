Return-Path: <linux-kernel+bounces-395195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 549329BBA30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13755281CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9A11C9B81;
	Mon,  4 Nov 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpJAcVhN"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7271C07F7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737177; cv=none; b=AbojaQ9jy3KgRliBhCDNMAE9Aqm8DzSwmiysGO3UibyNcM5Aq+b5uNKc8V8aj6o1KRHZ0LYHgVPkT7v9LZZfBQa0Xhw0iM43W06gkbVtFTyxB6gDXW4MUomIuuCL/JTdicVC6qaBCd0XwaL7G1R++J1pqbDNtMgO7ITnQ4KJPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737177; c=relaxed/simple;
	bh=2Zf6Wh7WwMTJz5DSSx3o7r0wmY9f2/IMOwLW/s4U3UQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=asfLZxpawLz32cFh/eb/BQScI2+wW9bsVIJaZv30USC/BbNSyuopTMY1sl9tkwc4AODV7wGQEQOZYBxTMsaHhh5fJ2g8/oVJzeZKzCRni5BIj51zLIr5TfClYpBw/7ePfQsW8dZCHKKokpU4tyEGsPdTL6QuyN8+R1oySHTbNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpJAcVhN; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a9a1be34c61so150222166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730737174; x=1731341974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D01NtyTMk6i2oodCmqKoOULZz5EC2eZ4CIhcaLc7Lms=;
        b=OpJAcVhNuDY/xvw8cHPEeBBJktdGIcXB7dAGEs5Lw2+N10jK8DKZP4f1uCbxVHU+nO
         iiWhrtkeeWSkGtZXZ1Q6J+eHj1nuX0VdRLhrCDtSx3WFe0JF0fTmPiOrskuUfvBWV6iT
         LskDZRwINdN4zhirCkT1PkZZpFCDJB6lRF2I7G/vnK7+0txm3Zg+BY6P6+Qt37RmIBjx
         /vmydqSATjAPUxakqo4DMzNMpCaN9NFEC/iCpOobpESZrxQF3ANYm8Uz2/cgEBK88+Qj
         dtruB9c+FLhnPLqVj9paGhbFkdgzUiDd7GY0XoUv6kilgVqqVHWsG89dNzXerbYyZab5
         aHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737174; x=1731341974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D01NtyTMk6i2oodCmqKoOULZz5EC2eZ4CIhcaLc7Lms=;
        b=Va3sYkCmu4mPku9cM+bpXOzgN50CMeDhDJWl88zA8CygeRjiX7UM1HT0Yr2m95Ipc5
         W1mMcv5h/aXAR5LBZOkevQKIIxYzOb6yuiZxqjNodljA/KgqU7+J2TrDfXHXfItQWgPu
         90kmcTyfmRYHRhAz4Y4xPjcHLTiPJzVP4mcdBbNBH9bQnV5Xks4YmHOaZjClSIWvSBMd
         3R/OAo2dIOE8U4dFxz8RIaGIR9RKiirn8Es4HuwN3ljy4nwXTX+7gQlp1mM9Op/a5TyR
         LQe6Dup5CMaeyvao0RWPXMudKEB793Mz47bNmXiYUv8yFutrYdSybs+Q76oCdfc3OORM
         GltQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjBL/5PgIMUjEw6gVMTo50d+9jYe6HQwBIF1lGbdXmEzmF23kT8DV7gBsLsi7BCIS7mGtdNkjh2s9hd34=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5/QYzzop/AACFn5nJnIMHA5gu3ub5G+W4+xYY8xT52fnnZx7
	GMP2rtgEuFfJyDJlFmR1icepza9OxHCjZSo+HHdccck90dfqdYHOmXluNU/BC+FNUEjqhRv9+g=
	=
X-Google-Smtp-Source: AGHT+IE04dEG4Y5MUmrGycRsDe0dmIy+dy7/bFzFTwDynvSgS0Tjs/YvxNAZJ2cTxdozb20CkU05HfKJJA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dc4d:3b27:d746:73ee])
 (user=elver job=sendgmr) by 2002:a17:906:c0c1:b0:a99:fa8a:9783 with SMTP id
 a640c23a62f3a-a9e654bee59mr296866b.3.1730737174017; Mon, 04 Nov 2024 08:19:34
 -0800 (PST)
Date: Mon,  4 Nov 2024 16:43:08 +0100
In-Reply-To: <20241104161910.780003-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104161910.780003-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104161910.780003-5-elver@google.com>
Subject: [PATCH v2 4/5] seqlock, treewide: Switch to non-raw seqcount_latch interface
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch all instrumentable users of the seqcount_latch interface over to
the non-raw interface.

Link: https://lore.kernel.org/all/20241030204815.GQ14555@noisy.programming.kicks-ass.net/
Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 arch/x86/kernel/tsc.c        |  5 +++--
 include/linux/rbtree_latch.h | 20 +++++++++++---------
 kernel/printk/printk.c       |  9 +++++----
 kernel/time/sched_clock.c    | 12 +++++++-----
 kernel/time/timekeeping.c    | 12 +++++++-----
 5 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index dfe6847fd99e..67aeaba4ba9c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -174,10 +174,11 @@ static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long ts
 
 	c2n = per_cpu_ptr(&cyc2ns, cpu);
 
-	raw_write_seqcount_latch(&c2n->seq);
+	write_seqcount_latch_begin(&c2n->seq);
 	c2n->data[0] = data;
-	raw_write_seqcount_latch(&c2n->seq);
+	write_seqcount_latch(&c2n->seq);
 	c2n->data[1] = data;
+	write_seqcount_latch_end(&c2n->seq);
 }
 
 static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
index 6a0999c26c7c..2f630eb8307e 100644
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -14,7 +14,7 @@
  *
  * If we need to allow unconditional lookups (say as required for NMI context
  * usage) we need a more complex setup; this data structure provides this by
- * employing the latch technique -- see @raw_write_seqcount_latch -- to
+ * employing the latch technique -- see @write_seqcount_latch_begin -- to
  * implement a latched RB-tree which does allow for unconditional lookups by
  * virtue of always having (at least) one stable copy of the tree.
  *
@@ -132,7 +132,7 @@ __lt_find(void *key, struct latch_tree_root *ltr, int idx,
  * @ops: operators defining the node order
  *
  * It inserts @node into @root in an ordered fashion such that we can always
- * observe one complete tree. See the comment for raw_write_seqcount_latch().
+ * observe one complete tree. See the comment for write_seqcount_latch_begin().
  *
  * The inserts use rcu_assign_pointer() to publish the element such that the
  * tree structure is stored before we can observe the new @node.
@@ -145,10 +145,11 @@ latch_tree_insert(struct latch_tree_node *node,
 		  struct latch_tree_root *root,
 		  const struct latch_tree_ops *ops)
 {
-	raw_write_seqcount_latch(&root->seq);
+	write_seqcount_latch_begin(&root->seq);
 	__lt_insert(node, root, 0, ops->less);
-	raw_write_seqcount_latch(&root->seq);
+	write_seqcount_latch(&root->seq);
 	__lt_insert(node, root, 1, ops->less);
+	write_seqcount_latch_end(&root->seq);
 }
 
 /**
@@ -159,7 +160,7 @@ latch_tree_insert(struct latch_tree_node *node,
  *
  * Removes @node from the trees @root in an ordered fashion such that we can
  * always observe one complete tree. See the comment for
- * raw_write_seqcount_latch().
+ * write_seqcount_latch_begin().
  *
  * It is assumed that @node will observe one RCU quiescent state before being
  * reused of freed.
@@ -172,10 +173,11 @@ latch_tree_erase(struct latch_tree_node *node,
 		 struct latch_tree_root *root,
 		 const struct latch_tree_ops *ops)
 {
-	raw_write_seqcount_latch(&root->seq);
+	write_seqcount_latch_begin(&root->seq);
 	__lt_erase(node, root, 0);
-	raw_write_seqcount_latch(&root->seq);
+	write_seqcount_latch(&root->seq);
 	__lt_erase(node, root, 1);
+	write_seqcount_latch_end(&root->seq);
 }
 
 /**
@@ -204,9 +206,9 @@ latch_tree_find(void *key, struct latch_tree_root *root,
 	unsigned int seq;
 
 	do {
-		seq = raw_read_seqcount_latch(&root->seq);
+		seq = read_seqcount_latch(&root->seq);
 		node = __lt_find(key, root, seq & 1, ops->comp);
-	} while (raw_read_seqcount_latch_retry(&root->seq, seq));
+	} while (read_seqcount_latch_retry(&root->seq, seq));
 
 	return node;
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f4c367..19911c8fa7b6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -560,10 +560,11 @@ bool printk_percpu_data_ready(void)
 /* Must be called under syslog_lock. */
 static void latched_seq_write(struct latched_seq *ls, u64 val)
 {
-	raw_write_seqcount_latch(&ls->latch);
+	write_seqcount_latch_begin(&ls->latch);
 	ls->val[0] = val;
-	raw_write_seqcount_latch(&ls->latch);
+	write_seqcount_latch(&ls->latch);
 	ls->val[1] = val;
+	write_seqcount_latch_end(&ls->latch);
 }
 
 /* Can be called from any context. */
@@ -574,10 +575,10 @@ static u64 latched_seq_read_nolock(struct latched_seq *ls)
 	u64 val;
 
 	do {
-		seq = raw_read_seqcount_latch(&ls->latch);
+		seq = read_seqcount_latch(&ls->latch);
 		idx = seq & 0x1;
 		val = ls->val[idx];
-	} while (raw_read_seqcount_latch_retry(&ls->latch, seq));
+	} while (read_seqcount_latch_retry(&ls->latch, seq));
 
 	return val;
 }
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 29bdf309dae8..fcca4e72f1ef 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -71,13 +71,13 @@ static __always_inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 
 notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 {
-	*seq = raw_read_seqcount_latch(&cd.seq);
+	*seq = read_seqcount_latch(&cd.seq);
 	return cd.read_data + (*seq & 1);
 }
 
 notrace int sched_clock_read_retry(unsigned int seq)
 {
-	return raw_read_seqcount_latch_retry(&cd.seq, seq);
+	return read_seqcount_latch_retry(&cd.seq, seq);
 }
 
 static __always_inline unsigned long long __sched_clock(void)
@@ -132,16 +132,18 @@ unsigned long long notrace sched_clock(void)
 static void update_clock_read_data(struct clock_read_data *rd)
 {
 	/* steer readers towards the odd copy */
-	raw_write_seqcount_latch(&cd.seq);
+	write_seqcount_latch_begin(&cd.seq);
 
 	/* now its safe for us to update the normal (even) copy */
 	cd.read_data[0] = *rd;
 
 	/* switch readers back to the even copy */
-	raw_write_seqcount_latch(&cd.seq);
+	write_seqcount_latch(&cd.seq);
 
 	/* update the backup (odd) copy with the new data */
 	cd.read_data[1] = *rd;
+
+	write_seqcount_latch_end(&cd.seq);
 }
 
 /*
@@ -279,7 +281,7 @@ void __init generic_sched_clock_init(void)
  */
 static u64 notrace suspended_sched_clock_read(void)
 {
-	unsigned int seq = raw_read_seqcount_latch(&cd.seq);
+	unsigned int seq = read_seqcount_latch(&cd.seq);
 
 	return cd.read_data[seq & 1].epoch_cyc;
 }
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7e6f409bf311..18752983e834 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -411,7 +411,7 @@ static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
  * We want to use this from any context including NMI and tracing /
  * instrumenting the timekeeping code itself.
  *
- * Employ the latch technique; see @raw_write_seqcount_latch.
+ * Employ the latch technique; see @write_seqcount_latch.
  *
  * So if a NMI hits the update of base[0] then it will use base[1]
  * which is still consistent. In the worst case this can result is a
@@ -424,16 +424,18 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
 	struct tk_read_base *base = tkf->base;
 
 	/* Force readers off to base[1] */
-	raw_write_seqcount_latch(&tkf->seq);
+	write_seqcount_latch_begin(&tkf->seq);
 
 	/* Update base[0] */
 	memcpy(base, tkr, sizeof(*base));
 
 	/* Force readers back to base[0] */
-	raw_write_seqcount_latch(&tkf->seq);
+	write_seqcount_latch(&tkf->seq);
 
 	/* Update base[1] */
 	memcpy(base + 1, base, sizeof(*base));
+
+	write_seqcount_latch_end(&tkf->seq);
 }
 
 static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
@@ -443,11 +445,11 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 	u64 now;
 
 	do {
-		seq = raw_read_seqcount_latch(&tkf->seq);
+		seq = read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
 		now = ktime_to_ns(tkr->base);
 		now += __timekeeping_get_ns(tkr);
-	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
 }
-- 
2.47.0.163.g1226f6d8fa-goog


