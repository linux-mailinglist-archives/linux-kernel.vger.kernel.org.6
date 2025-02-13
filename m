Return-Path: <linux-kernel+bounces-514031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7695BA35186
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DF8188E71C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0C27FE89;
	Thu, 13 Feb 2025 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwrsBOjE"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059627FE6E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486842; cv=none; b=CC5TumrTsoRS096hapYEF3yEi18cN5ixQgjxB9SjsRM2EWq1fGXx1MbwsguSuR611v3yBvZrQ+osqZJENy34nkBen6FuBVXTgTT2x8vZA7mDlWHmHTCt9MK7OhCGwWV6I0NwnwwQjFQT/IWBn44/QFGrxV56VD7qcOys9rk4ihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486842; c=relaxed/simple;
	bh=8Us/4Sut55vL/Q+kFzZMiRWAFIlHFVPIi/mXDPDz6vI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JmZZlXza5KjOg4jgUDdN55UdF4I9cHNwfLyI54P6sh77j+KPJTT+j2nnF2nLUSByO3WB5VeQLdHxrW84xwmj5c5eJSmJZ4T+IylHdT3VIsYJEihbZwjxV4mPsvhkFC2bTpUnAo8NiuEYAo1Fpjto9WW+7biF8rEIDD4CPQk1/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwrsBOjE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220e62c4f27so22488725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486840; x=1740091640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3RwEBR7WcDA6C9/htn1wwdAW8BOhyJsqS310jozD7lM=;
        b=kwrsBOjEvM8c8+JaDKacp3jI/4fyBQbggsjAJlUbahQ+1nEDFLjbMe8RPtmlaeuVC3
         em/aC18ylP0M+HU3fNhkzktEdKPWon92P6hpKwiLqH8CUdij/Ok7pyFt1VmO5ShtDs1e
         tdXnZj5eNCPAOmD2lYDV0z0KvykBqOOS67epO4AH3PLmfUIBv/xEpkx+/n4OR15XTMt3
         9G+jjQKfXBseVg9bIHHe7yZDyden0wyFFHTOfMsu2wIcKrSUQNkJJC9ICkvMfrZf4bXK
         +wJQiTaupAKXTHDK7x89J1xYMmXl9JIGkR2xut2BRA9PI/pY29sxUc46Cy5b7e27jgOB
         IhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486840; x=1740091640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RwEBR7WcDA6C9/htn1wwdAW8BOhyJsqS310jozD7lM=;
        b=Rc1QIu7Bv92v92BxW+1QBhwAxWx5rE1ERmeMuGIFGU3x1C4ZkZesJv9dHlf0wDDmSb
         JMCexcmuj34pFTskN41M7hb37GvHg2G/maWrEqJV5WOLndOvowmfmrxUNW6ZZsZ13Um6
         wluT4lfHr32OyZB89yV6GJYK+jMuC5KUJP30AmVNzvwXG2PSMCRmRfxzIeLXHP4fCgy5
         ZgPVUcsF28o/7N+VJwb3C/BNGO5c9A+c/2CzeYnGbX50co7QRt5jUoLVWzwQpwiQaLwq
         xz4c0e3b9dwKQGEd0NRF1bRT4RFPilD6HK0A+aPf0QEOHhLU8Gwkl8OEhNUvCnt8Bpk4
         0qkg==
X-Forwarded-Encrypted: i=1; AJvYcCXS6VYrCXGdYym4nOz+36eMONpB/nGt0C1OsKMRQ2GwtWlGpSUh+dMbKunkptve12GOBoWdBuorQB5MR50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxUUIH9PkbHOuNDDEI/5ygjcsNia6bX+CIDCU8mTIASjry4fmP
	Fh7IAOMpqHbZzrQfUl1N1ojrLhXI79BAoRAr71/+tU3jDpgbOERFv4wJisWOsp2xz8ZgcXMY7gd
	MRQ==
X-Google-Smtp-Source: AGHT+IG5tsVaIrkzimQ3d73aZezGeIWfqvUQe6a1x7KexmMSk23y9v/qQliOxJeTTumAOAHvlPYYt46pBpQ=
X-Received: from pgid14.prod.google.com ([2002:a63:ed0e:0:b0:801:e378:a64a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2e81:b0:1ee:5cf2:9c07
 with SMTP id adf61e73a8af0-1ee5cf29ed0mr11346671637.3.1739486840113; Thu, 13
 Feb 2025 14:47:20 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:47 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-11-surenb@google.com>
Subject: [PATCH v10 10/18] refcount: provide ops for cases when object's
 memory can be reused
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

For speculative lookups where a successful inc_not_zero() pins the
object, but where we still need to double check if the object acquired
is indeed the one we set out to acquire (identity check), needs this
validation to happen *after* the increment.
Similarly, when a new object is initialized and its memory might have
been previously occupied by another object, all stores to initialize the
object should happen *before* refcount initialization.

Notably SLAB_TYPESAFE_BY_RCU is one such an example when this ordering
is required for reference counting.

Add refcount_{add|inc}_not_zero_acquire() to guarantee the proper ordering
between acquiring a reference count on an object and performing the
identity check for that object.
Add refcount_set_release() to guarantee proper ordering between stores
initializing object attributes and the store initializing the refcount.
refcount_set_release() should be done after all other object attributes
are initialized. Once refcount_set_release() is called, the object should
be considered visible to other tasks even if it was not yet added into an
object collection normally used to discover it. This is because other
tasks might have discovered the object previously occupying the same
memory and after memory reuse they can succeed in taking refcount for the
new object and start using it.

Object reuse example to consider:

consumer:
    obj = lookup(collection, key);
    if (!refcount_inc_not_zero_acquire(&obj->ref))
        return;
    if (READ_ONCE(obj->key) != key) { /* identity check */
        put_ref(obj);
        return;
    }
    use(obj->value);

                 producer:
                     remove(collection, obj->key);
                     if (!refcount_dec_and_test(&obj->ref))
                         return;
                     obj->key = KEY_INVALID;
                     free(obj);
                     obj = malloc(); /* obj is reused */
                     obj->key = new_key;
                     obj->value = new_value;
                     refcount_set_release(obj->ref, 1);
                     add(collection, new_key, obj);

refcount_{add|inc}_not_zero_acquire() is required to prevent the following
reordering when refcount_inc_not_zero() is used instead:

consumer:
    obj = lookup(collection, key);
    if (READ_ONCE(obj->key) != key) { /* reordered identity check */
        put_ref(obj);
        return;
    }
                 producer:
                     remove(collection, obj->key);
                     if (!refcount_dec_and_test(&obj->ref))
                         return;
                     obj->key = KEY_INVALID;
                     free(obj);
                     obj = malloc(); /* obj is reused */
                     obj->key = new_key;
                     obj->value = new_value;
                     refcount_set_release(obj->ref, 1);
                     add(collection, new_key, obj);

    if (!refcount_inc_not_zero(&obj->ref))
        return;
    use(obj->value); /* USING WRONG OBJECT */

refcount_set_release() is required to prevent the following reordering
when refcount_set() is used instead:

consumer:
    obj = lookup(collection, key);

                 producer:
                     remove(collection, obj->key);
                     if (!refcount_dec_and_test(&obj->ref))
                         return;
                     obj->key = KEY_INVALID;
                     free(obj);
                     obj = malloc(); /* obj is reused */
                     obj->key = new_key; /* new_key == old_key */
                     refcount_set(obj->ref, 1);

    if (!refcount_inc_not_zero_acquire(&obj->ref))
        return;
    if (READ_ONCE(obj->key) != key) { /* pass since new_key == old_key */
        put_ref(obj);
        return;
    }
    use(obj->value); /* USING STALE obj->value */

                     obj->value = new_value; /* reordered store */
                     add(collection, key, obj);

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz> #slab
---
 Documentation/RCU/whatisRCU.rst               |  10 ++
 Documentation/core-api/refcount-vs-atomic.rst |  37 +++++-
 include/linux/refcount.h                      | 106 ++++++++++++++++++
 include/linux/slab.h                          |   9 ++
 4 files changed, 156 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 1ef5784c1b84..53faeed7c190 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -971,6 +971,16 @@ unfortunately any spinlock in a ``SLAB_TYPESAFE_BY_RCU`` object must be
 initialized after each and every call to kmem_cache_alloc(), which renders
 reference-free spinlock acquisition completely unsafe.  Therefore, when
 using ``SLAB_TYPESAFE_BY_RCU``, make proper use of a reference counter.
+If using refcount_t, the specialized refcount_{add|inc}_not_zero_acquire()
+and refcount_set_release() APIs should be used to ensure correct operation
+ordering when verifying object identity and when initializing newly
+allocated objects. Acquire fence in refcount_{add|inc}_not_zero_acquire()
+ensures that identity checks happen *after* reference count is taken.
+refcount_set_release() should be called after a newly allocated object is
+fully initialized and release fence ensures that new values are visible
+*before* refcount can be successfully taken by other users. Once
+refcount_set_release() is called, the object should be considered visible
+by other tasks.
 (Those willing to initialize their locks in a kmem_cache constructor
 may also use locking, including cache-friendly sequence locking.)
 
diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
index 79a009ce11df..9551a7bbfd38 100644
--- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -86,7 +86,19 @@ Memory ordering guarantee changes:
  * none (both fully unordered)
 
 
-case 2) - increment-based ops that return no value
+case 2) - non-"Read/Modify/Write" (RMW) ops with release ordering
+-------------------------------------------
+
+Function changes:
+
+ * atomic_set_release() --> refcount_set_release()
+
+Memory ordering guarantee changes:
+
+ * none (both provide RELEASE ordering)
+
+
+case 3) - increment-based ops that return no value
 --------------------------------------------------
 
 Function changes:
@@ -98,7 +110,7 @@ Memory ordering guarantee changes:
 
  * none (both fully unordered)
 
-case 3) - decrement-based RMW ops that return no value
+case 4) - decrement-based RMW ops that return no value
 ------------------------------------------------------
 
 Function changes:
@@ -110,7 +122,7 @@ Memory ordering guarantee changes:
  * fully unordered --> RELEASE ordering
 
 
-case 4) - increment-based RMW ops that return a value
+case 5) - increment-based RMW ops that return a value
 -----------------------------------------------------
 
 Function changes:
@@ -126,7 +138,20 @@ Memory ordering guarantees changes:
    result of obtaining pointer to the object!
 
 
-case 5) - generic dec/sub decrement-based RMW ops that return a value
+case 6) - increment-based RMW ops with acquire ordering that return a value
+-----------------------------------------------------
+
+Function changes:
+
+ * atomic_inc_not_zero() --> refcount_inc_not_zero_acquire()
+ * no atomic counterpart --> refcount_add_not_zero_acquire()
+
+Memory ordering guarantees changes:
+
+ * fully ordered --> ACQUIRE ordering on success
+
+
+case 7) - generic dec/sub decrement-based RMW ops that return a value
 ---------------------------------------------------------------------
 
 Function changes:
@@ -139,7 +164,7 @@ Memory ordering guarantees changes:
  * fully ordered --> RELEASE ordering + ACQUIRE ordering on success
 
 
-case 6) other decrement-based RMW ops that return a value
+case 8) other decrement-based RMW ops that return a value
 ---------------------------------------------------------
 
 Function changes:
@@ -154,7 +179,7 @@ Memory ordering guarantees changes:
 .. note:: atomic_add_unless() only provides full order on success.
 
 
-case 7) - lock-based RMW
+case 9) - lock-based RMW
 ------------------------
 
 Function changes:
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 35f039ecb272..4589d2e7bfea 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -87,6 +87,15 @@
  * The decrements dec_and_test() and sub_and_test() also provide acquire
  * ordering on success.
  *
+ * refcount_{add|inc}_not_zero_acquire() and refcount_set_release() provide
+ * acquire and release ordering for cases when the memory occupied by the
+ * object might be reused to store another object. This is important for the
+ * cases where secondary validation is required to detect such reuse, e.g.
+ * SLAB_TYPESAFE_BY_RCU. The secondary validation checks have to happen after
+ * the refcount is taken, hence acquire order is necessary. Similarly, when the
+ * object is initialized, all stores to its attributes should be visible before
+ * the refcount is set, otherwise a stale attribute value might be used by
+ * another task which succeeds in taking a refcount to the new object.
  */
 
 #ifndef _LINUX_REFCOUNT_H
@@ -125,6 +134,31 @@ static inline void refcount_set(refcount_t *r, int n)
 	atomic_set(&r->refs, n);
 }
 
+/**
+ * refcount_set_release - set a refcount's value with release ordering
+ * @r: the refcount
+ * @n: value to which the refcount will be set
+ *
+ * This function should be used when memory occupied by the object might be
+ * reused to store another object -- consider SLAB_TYPESAFE_BY_RCU.
+ *
+ * Provides release memory ordering which will order previous memory operations
+ * against this store. This ensures all updates to this object are visible
+ * once the refcount is set and stale values from the object previously
+ * occupying this memory are overwritten with new ones.
+ *
+ * This function should be called only after new object is fully initialized.
+ * After this call the object should be considered visible to other tasks even
+ * if it was not yet added into an object collection normally used to discover
+ * it. This is because other tasks might have discovered the object previously
+ * occupying the same memory and after memory reuse they can succeed in taking
+ * refcount to the new object and start using it.
+ */
+static inline void refcount_set_release(refcount_t *r, int n)
+{
+	atomic_set_release(&r->refs, n);
+}
+
 /**
  * refcount_read - get a refcount's value
  * @r: the refcount
@@ -178,6 +212,52 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
 	return __refcount_add_not_zero(i, r, NULL);
 }
 
+static inline __must_check __signed_wrap
+bool __refcount_add_not_zero_acquire(int i, refcount_t *r, int *oldp)
+{
+	int old = refcount_read(r);
+
+	do {
+		if (!old)
+			break;
+	} while (!atomic_try_cmpxchg_acquire(&r->refs, &old, old + i));
+
+	if (oldp)
+		*oldp = old;
+
+	if (unlikely(old < 0 || old + i < 0))
+		refcount_warn_saturate(r, REFCOUNT_ADD_NOT_ZERO_OVF);
+
+	return old;
+}
+
+/**
+ * refcount_add_not_zero_acquire - add a value to a refcount with acquire ordering unless it is 0
+ *
+ * @i: the value to add to the refcount
+ * @r: the refcount
+ *
+ * Will saturate at REFCOUNT_SATURATED and WARN.
+ *
+ * This function should be used when memory occupied by the object might be
+ * reused to store another object -- consider SLAB_TYPESAFE_BY_RCU.
+ *
+ * Provides acquire memory ordering on success, it is assumed the caller has
+ * guaranteed the object memory to be stable (RCU, etc.). It does provide a
+ * control dependency and thereby orders future stores. See the comment on top.
+ *
+ * Use of this function is not recommended for the normal reference counting
+ * use case in which references are taken and released one at a time.  In these
+ * cases, refcount_inc_not_zero_acquire() should instead be used to increment a
+ * reference count.
+ *
+ * Return: false if the passed refcount is 0, true otherwise
+ */
+static inline __must_check bool refcount_add_not_zero_acquire(int i, refcount_t *r)
+{
+	return __refcount_add_not_zero_acquire(i, r, NULL);
+}
+
 static inline __signed_wrap
 void __refcount_add(int i, refcount_t *r, int *oldp)
 {
@@ -236,6 +316,32 @@ static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
 	return __refcount_inc_not_zero(r, NULL);
 }
 
+static inline __must_check bool __refcount_inc_not_zero_acquire(refcount_t *r, int *oldp)
+{
+	return __refcount_add_not_zero_acquire(1, r, oldp);
+}
+
+/**
+ * refcount_inc_not_zero_acquire - increment a refcount with acquire ordering unless it is 0
+ * @r: the refcount to increment
+ *
+ * Similar to refcount_inc_not_zero(), but provides acquire memory ordering on
+ * success.
+ *
+ * This function should be used when memory occupied by the object might be
+ * reused to store another object -- consider SLAB_TYPESAFE_BY_RCU.
+ *
+ * Provides acquire memory ordering on success, it is assumed the caller has
+ * guaranteed the object memory to be stable (RCU, etc.). It does provide a
+ * control dependency and thereby orders future stores. See the comment on top.
+ *
+ * Return: true if the increment was successful, false otherwise
+ */
+static inline __must_check bool refcount_inc_not_zero_acquire(refcount_t *r)
+{
+	return __refcount_inc_not_zero_acquire(r, NULL);
+}
+
 static inline void __refcount_inc(refcount_t *r, int *oldp)
 {
 	__refcount_add(1, r, oldp);
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 09eedaecf120..ad902a2d692b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -136,6 +136,15 @@ enum _slab_flag_bits {
  * rcu_read_lock before reading the address, then rcu_read_unlock after
  * taking the spinlock within the structure expected at that address.
  *
+ * Note that object identity check has to be done *after* acquiring a
+ * reference, therefore user has to ensure proper ordering for loads.
+ * Similarly, when initializing objects allocated with SLAB_TYPESAFE_BY_RCU,
+ * the newly allocated object has to be fully initialized *before* its
+ * refcount gets initialized and proper ordering for stores is required.
+ * refcount_{add|inc}_not_zero_acquire() and refcount_set_release() are
+ * designed with the proper fences required for reference counting objects
+ * allocated with SLAB_TYPESAFE_BY_RCU.
+ *
  * Note that it is not possible to acquire a lock within a structure
  * allocated with SLAB_TYPESAFE_BY_RCU without first acquiring a reference
  * as described above.  The reason is that SLAB_TYPESAFE_BY_RCU pages
-- 
2.48.1.601.g30ceb7b040-goog


