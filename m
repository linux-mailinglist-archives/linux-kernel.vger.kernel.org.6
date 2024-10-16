Return-Path: <linux-kernel+bounces-367256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9869A003B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA441F24C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFC21885B7;
	Wed, 16 Oct 2024 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KVUusk/M"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8663021E3BF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053383; cv=none; b=hoIQNHCAnJAQ1+JVM0TFhlVU8iZTYh9nHa6CKfN1zkWrpRDKkcGr9e6vnwS3T/Ju29Tf5Y0XpxwL4Sbg9cuwGBq2zM/Fyec0k5lYvnWo+BeBQmNi9fbWpo5l9q5gkxuLTUJ53nEMLWctetxVTnx7qQIf3G3zst9Udu7H+MHpdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053383; c=relaxed/simple;
	bh=5Co02av+8KsGWIZGjAv5K40HJLnWMr5BF9l7TTxcJgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2v06P3lKtV5/4Rm3XvqJjvPb+XXZOpXNC2EYdo93hOOM0TjxRDb7wmz1CiP2FWtDgxANFH7TIEmmGm2tmHt2wCvUjdTOG7qRmwDS1WLwxHH/AqEUa8O4Mif3yddY0MoLiWSqZ8guEJxJiRv6QEDTan8qdMD91fiKsjSS1D0jVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KVUusk/M; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e4e481692so3602766b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729053381; x=1729658181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nF3Zt0gxviNAj6W7zuplHnOejMHjOAOwzub01HWozw=;
        b=KVUusk/MUY5/TCqagfkHgOu0GZKbK6+s1esS82wM86VmA3FLxVvC+rZyKNSgFb/qQU
         ftFrXnSM9+F5qK3wI8/kDw7GqnFyqUmn/HZPdJaMnL3uLeKDoxzsyCQj0dQ1EWi1tfYG
         +BPA1hIG4hhQkjN5EZ1yWDC20I/0Om2MzX3Z4eZ1bPn/jalyNqmKCjKyFh8aklBJL/La
         6DUPH5v/7Qn/YITe+UEsEtlIucKa/wEzAtsuo3BMRiAW9auzvMrWMA3uw/sCn4doFkH9
         p9dlWJWlenRUOM8+F4tK1ddXDmZFX9ah24T+e0o02wGQ/3XjtsJbrYBE98Brrx8WnW2x
         gYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729053381; x=1729658181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nF3Zt0gxviNAj6W7zuplHnOejMHjOAOwzub01HWozw=;
        b=MBuqIR7J3TJbg1EYiQNudh0ifM4oTJvrHLMhSq1jD2x8f7KPuK+xRDeIwyJHIVVX5k
         99D0ZSYuy7oamAiQxI6U6MG1iKVRwBwDNyGkHYrLer+fjRshtnDluThnwlr8aIelN2rr
         MZEtgWK0t87uMXb9+OTxNXY6SOX1XT4Bmr57+gsoIG1rckiHXNppb9TRdC6B/QusDkmI
         T3DrIJheFXhzRMkBOTaea27hKzeHO5QXZ6asEzkXkcNcs2qmXncHgo7/ibIEnA0Prdsb
         jsiFdtBm1UVpPPA0U+RvcoJAZjPHWZNHBa7/G6Q6/ZtkbOQY6uXp+sFUD9joKHaaIVPT
         lcqg==
X-Gm-Message-State: AOJu0Yyacqk3XolmPTRfhUig3s+ziQ1KdbUsZcF6naJ+cg40Ty/yAkwP
	BDGchifPuKNE+0d1NgypZ3zg0yiNQYU//JsEFoNVMOx+jtyBvmBD8T1/XxKKhJs=
X-Google-Smtp-Source: AGHT+IFczFz3ErUrY+fjvYOL+NXV28+0Iu8qbIMMGYJw/5xJ5jVf0FYBW/ESLdbc+kY+vlNNDpmfZQ==
X-Received: by 2002:a05:6a00:10c3:b0:71d:f012:6de7 with SMTP id d2e1a72fcca58-71e4c1cfd6fmr22325426b3a.27.1729053380740;
        Tue, 15 Oct 2024 21:36:20 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77518a76sm2189192b3a.220.2024.10.15.21.36.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Oct 2024 21:36:20 -0700 (PDT)
From: lizhe.67@bytedance.com
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com
Subject: [RFC 1/2] rwsem: introduce upgrade_read interface
Date: Wed, 16 Oct 2024 12:35:59 +0800
Message-ID: <20241016043600.35139-2-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016043600.35139-1-lizhe.67@bytedance.com>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

Introduce a new rwsem interface upgrade_read(). We can call it
to upgrade the lock into write rwsem lock after we get read lock.
This interface will wait for all readers to exit before obtaining
the write lock. In addition, this interface has a higher priority
than any process waiting for the write lock and subsequent threads
that want to obtain the read lock.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 include/linux/rwsem.h  |  1 +
 kernel/locking/rwsem.c | 87 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c8b543d428b0..90183ab5ea79 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -249,6 +249,7 @@ DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
  * downgrade write lock to read lock
  */
 extern void downgrade_write(struct rw_semaphore *sem);
+extern int upgrade_read(struct rw_semaphore *sem);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2bbb6eca5144..0583e1be3dbf 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -37,6 +37,7 @@
  * meanings when set.
  *  - Bit 0: RWSEM_READER_OWNED - rwsem may be owned by readers (just a hint)
  *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
+ *  - Bit 2: RWSEM_UPGRADING    - doing upgrade read process
  *
  * When the rwsem is reader-owned and a spinning writer has timed out,
  * the nonspinnable bit will be set to disable optimistic spinning.
@@ -62,7 +63,8 @@
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
 #define RWSEM_NONSPINNABLE	(1UL << 1)
-#define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
+#define RWSEM_UPGRADING		(1UL << 2)
+#define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE | RWSEM_UPGRADING)
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c, sem)	do {			\
@@ -93,7 +95,8 @@
  * Bit  0    - writer locked bit
  * Bit  1    - waiters present bit
  * Bit  2    - lock handoff bit
- * Bits 3-7  - reserved
+ * Bit  3    - upgrade read bit
+ * Bits 4-7  - reserved
  * Bits 8-30 - 23-bit reader count
  * Bit  31   - read fail bit
  *
@@ -117,6 +120,7 @@
 #define RWSEM_WRITER_LOCKED	(1UL << 0)
 #define RWSEM_FLAG_WAITERS	(1UL << 1)
 #define RWSEM_FLAG_HANDOFF	(1UL << 2)
+#define RWSEM_FLAG_UPGRADE_READ	(1UL << 3)
 #define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
 #define RWSEM_READER_SHIFT	8
@@ -143,6 +147,13 @@ static inline void rwsem_set_owner(struct rw_semaphore *sem)
 	atomic_long_set(&sem->owner, (long)current);
 }
 
+static inline void rwsem_set_owner_upgrade(struct rw_semaphore *sem)
+{
+	lockdep_assert_preemption_disabled();
+	atomic_long_set(&sem->owner, (long)current | RWSEM_UPGRADING |
+			RWSEM_READER_OWNED | RWSEM_NONSPINNABLE);
+}
+
 static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 {
 	lockdep_assert_preemption_disabled();
@@ -201,7 +212,7 @@ static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 	 */
 	long count = atomic_long_read(&sem->count);
 
-	if (count & RWSEM_WRITER_MASK)
+	if ((count & RWSEM_WRITER_MASK) && !(count & RWSEM_FLAG_UPGRADE_READ))
 		return false;
 	return rwsem_test_oflags(sem, RWSEM_READER_OWNED);
 }
@@ -1336,6 +1347,8 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
+	unsigned long flags;
+	struct task_struct *owner;
 
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
@@ -1349,6 +1362,9 @@ static inline void __up_read(struct rw_semaphore *sem)
 		clear_nonspinnable(sem);
 		rwsem_wake(sem);
 	}
+	owner = rwsem_owner_flags(sem, &flags);
+	if (unlikely(!(tmp & RWSEM_READER_MASK) && (flags & RWSEM_UPGRADING)))
+		wake_up_process(owner);
 	preempt_enable();
 }
 
@@ -1641,6 +1657,71 @@ void downgrade_write(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(downgrade_write);
 
+static inline void rwsem_clear_upgrade_flag(struct rw_semaphore *sem)
+{
+	atomic_long_andnot(RWSEM_FLAG_UPGRADE_READ, &sem->count);
+}
+
+/*
+ * upgrade read lock to write lock
+ */
+static inline int __upgrade_read(struct rw_semaphore *sem)
+{
+	long tmp;
+
+	preempt_disable();
+
+	tmp = atomic_long_read(&sem->count);
+	do {
+		if (tmp & (RWSEM_WRITER_MASK | RWSEM_FLAG_UPGRADE_READ)) {
+			preempt_enable();
+			return -EBUSY;
+		}
+	} while (!atomic_long_try_cmpxchg(&sem->count, &tmp,
+		tmp + RWSEM_FLAG_UPGRADE_READ + RWSEM_WRITER_LOCKED - RWSEM_READER_BIAS));
+
+	if ((tmp & RWSEM_READER_MASK) == RWSEM_READER_BIAS) {
+		/* fast path */
+		DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
+		rwsem_clear_upgrade_flag(sem);
+		rwsem_set_owner(sem);
+		preempt_enable();
+		return 0;
+	}
+	/* slow path */
+	raw_spin_lock_irq(&sem->wait_lock);
+	rwsem_set_owner_upgrade(sem);
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+
+	for (;;) {
+		if (!(atomic_long_read(&sem->count) & RWSEM_READER_MASK))
+			break;
+		raw_spin_unlock_irq(&sem->wait_lock);
+		schedule_preempt_disabled();
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		raw_spin_lock_irq(&sem->wait_lock);
+	}
+
+	rwsem_clear_upgrade_flag(sem);
+	rwsem_set_owner(sem);
+	__set_current_state(TASK_RUNNING);
+	raw_spin_unlock_irq(&sem->wait_lock);
+	preempt_enable();
+	return 0;
+}
+
+/*
+ * upgrade read lock to write lock
+ *
+ * Return: 0 on success, error code on failure
+ */
+int upgrade_read(struct rw_semaphore *sem)
+{
+	return __upgrade_read(sem);
+}
+EXPORT_SYMBOL(upgrade_read);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 void down_read_nested(struct rw_semaphore *sem, int subclass)
-- 
2.20.1


