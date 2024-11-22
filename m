Return-Path: <linux-kernel+bounces-418430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F829D617C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741CEB24C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D431E048A;
	Fri, 22 Nov 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiPbH8Pr"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737E1E0087
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290084; cv=none; b=H25XnjCRoFLiMZO6Sv1muCKztKrCdoJtva6uKG/V7JvWsdx7I6T9YVqEiGp9HZWBO+nUD5deKLclCBaqr8lW8Z0mS9byQLJu83MjwErgDW0NzllHCM+8Z+Co8quTpXEPTSnrIWPvox7l6g0o6ZdX98B1RO6qDlagmiNITHLYFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290084; c=relaxed/simple;
	bh=ELmBMFzYYsNvMdFa8fNaCj9uRohYnanctvoUqVOPrOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K99o7nUmNjJZ267fGkzP/OQycVQTh4Bax9AyNZgTxI2E9kQO1jrDclNp1ctROcxz2R7YBh/jHHNx2oe+julVlM9hNorYxo+qe2NDq4IonnWFJW7W8zkLRGGCfx0GqRpV4UFQdDCkkxLG3tBN/PbMNG1bBEmFx3eGi0Z6cf1Fu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiPbH8Pr; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3823326e95aso1225162f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732290081; x=1732894881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=roehYhV9fbym2F/vf27bAbe0CuzVSCLFEeCVaGrDIRQ=;
        b=PiPbH8PrSptlYrwL9CMndBBziFdVbNpWofdJowxJDxp43IKr2Af/g3vCnQ5lwZ2Kru
         /01J27MtDZaAdavU6r0xH82AZpe7nYZC1jm6ChOsro8tGLRJfFwnqd5E3WqO9ApaEXsz
         2/UmIe6JTTk3NVdW6hyU320lJw2R2hT6asOBYs7Av6b6logZNRQeFPWG6GwXZqkakTJA
         f+uc5HCgQySeok+dUPQ2eJNxyx9Nl9wUH9cVqUtKytDQqE323wfcuz7q6FB/zkIBlv4y
         uDmWdQVB2cW53R+BQzQPz6YMlFab5QxNbRnFPy9QSDnp6Wq6BVdwwdKE/LiRKwDdIMg2
         g3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290081; x=1732894881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roehYhV9fbym2F/vf27bAbe0CuzVSCLFEeCVaGrDIRQ=;
        b=d1Qd2CXXCnctijjL6+mpHLD7WW6cxgQsR/vcYx18kYh9MxN6l88bMv9Xp3ClIIM9Kc
         yXHADsgVg+DY3FmBZDzSr1Z9tFQtn+hyogIEKxXtphdx+WZh/RSIirKxmhIjjLtG6AEL
         QaFj+YvH7zkAEftHQrUKRZ633wEDWe9Tqi5Y1Md33lblWefotR+9b0eyt3wBxXJsfwZx
         3dGW93Rqd9Oa+akhF0Uv2b6QmwgEgF3nbyEJ05XXO6NLUp2blF6ZOg7sXGvM1XpVyETB
         eVM1VeKXtp9va6QSOqfajLZWu0e6S9B9UcjOY7V1vIFTxZMo3ticiFCk3McVQtpWKaS2
         cQtw==
X-Forwarded-Encrypted: i=1; AJvYcCXu743KLVF+QtBlBr/6zru7ru+LNyeenVvwlRdkdXt2fQu/qALFTBAv8d1lt0HawZt1CBvGpcCNFkkLxO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAaPulzdktb0V6rz5bAc0tNJQXRfZN7ft8VPW15HgvuQSg+ZG6
	9vadJ8SvCMdxcyJKmpvebL7QaF4FAseX6necAseBxw8JQyIrNxeMDXCDp0r7rGeY20q8sWM+Q+g
	+NaKkdER8GTzVlQ==
X-Google-Smtp-Source: AGHT+IF6HBbIQggNCbWVHzfdpf5qfU2oWZDDUICEvmMpzMP0kJSXWVx7hqPiHvLxeddSVZjHgvUjH2UBZr7vJN0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:adf:fd05:0:b0:382:49ff:ef75 with SMTP id
 ffacd0b85a97d-38260bc27dcmr780f8f.7.1732290080932; Fri, 22 Nov 2024 07:41:20
 -0800 (PST)
Date: Fri, 22 Nov 2024 15:40:33 +0000
In-Reply-To: <20241122-vma-v9-0-7127bfcdd54e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5755; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ELmBMFzYYsNvMdFa8fNaCj9uRohYnanctvoUqVOPrOk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnQKYLQtIIMMayOTF0V1fptgYQ4tpbvUzXCBxvI
 JXOixUouJmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0CmCwAKCRAEWL7uWMY5
 Rk7MEAC8HmptGWWIAH1NODYFTSG83oi5q2l+ljeKmvdiUHP1c39MD8JUUr8ZQY56Km1mjeH+R45
 Bb+bq62Q5v4yR0Bmrf1RlL2cPshEqIV3SaIF1AMB972ROETbmB/IEny0owtXKbAJE8nuaGxBiW9
 +Ni0SAFbcP30X2a80Cb2WQGk3ItYkrP3LfPzt43YJ52Y/9anw8UIoT3Q2tLGXMEaFRJ1qOqlsOh
 2FxJkSANzWvBix5B/6xqMTf7BrLH60791UzrqLbz0FwyO2GFLZptvL45fwTdb8VCQAONjeNC6Px
 Q1YQnxM1+zc2qDrMjuFIaJ32y7wOsJNtrLDek249qEOCPFs4y7HYAUbOSy3fNlNcw8TLo7k48Sd
 4+RbUJdtj/5k/Vw22wFASM8UZVyfIkvGegvIh2ETxFgNYbg6kFuOAVrxZJBBLN/TdeUgoZDOwpJ
 sACEu6DJGOnIWvhCKW0OVnw8hrEitbQC5tQz9YVTx2ejH9bDVn96NOSyhlvdNefp6z17zABlNUF
 4qyGR6ezIJwaFa/6wtS0DYVYNM8+gGHWc2VjK7VLBH4KUkkAsFmk9F0xl0I87cgYZgWdh44pyge
 jLxj5Oa4qTkuqPfIZGEV8t+xZFHHKjHnp4P7oWDrnqJgAG26hj0Nv+fEuSr0tclsMTN/ap3OBJC wNxW0WcRdIeDHWQ==
X-Mailer: b4 0.13.0
Message-ID: <20241122-vma-v9-8-7127bfcdd54e@google.com>
Subject: [PATCH v9 8/8] task: rust: rework how current is accessed
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="utf-8"

Introduce a new type called `CurrentTask` that lets you perform various
operations that are only safe on the `current` task. Use the new type to
provide a way to access the current mm without incrementing its
refcount.

With this change, you can write stuff such as

	let vma = current!().mm().lock_vma_under_rcu(addr);

without incrementing any refcounts.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Reviewers: Does accessing task->mm on a non-current task require rcu
protection?

Christian: If you submit the PidNamespace abstractions this cycle, I'll
update this to also apply to PidNamespace.
---
 rust/kernel/mm.rs   | 22 ------------------
 rust/kernel/task.rs | 64 ++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 50f4861ae4b9..f7d1079391ef 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -142,28 +142,6 @@ fn deref(&self) -> &MmWithUser {
 
 // These methods are safe to call even if `mm_users` is zero.
 impl Mm {
-    /// Call `mmgrab` on `current.mm`.
-    #[inline]
-    pub fn mmgrab_current() -> Option<ARef<Mm>> {
-        // SAFETY: It's safe to get the `mm` field from current.
-        let mm = unsafe {
-            let current = bindings::get_current();
-            (*current).mm
-        };
-
-        if mm.is_null() {
-            return None;
-        }
-
-        // SAFETY: The value of `current->mm` is guaranteed to be null or a valid `mm_struct`. We
-        // just checked that it's not null. Furthermore, the returned `&Mm` is valid only for the
-        // duration of this function, and `current->mm` will stay valid for that long.
-        let mm = unsafe { Mm::from_raw(mm) };
-
-        // This increments the refcount using `mmgrab`.
-        Some(ARef::from(mm))
-    }
-
     /// Returns a raw pointer to the inner `mm_struct`.
     #[inline]
     pub fn as_raw(&self) -> *mut bindings::mm_struct {
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 9e59d86da42d..103d235eb844 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -94,6 +94,26 @@ unsafe impl Send for Task {}
 // synchronised by C code (e.g., `signal_pending`).
 unsafe impl Sync for Task {}
 
+/// Represents a [`Task`] obtained from the `current` global.
+///
+/// This type exists to provide more efficient operations that are only valid on the current task.
+/// For example, to retrieve the pid-namespace of a task, you must use rcu protection unless it is
+/// the current task.
+///
+/// # Invariants
+///
+/// Must be equal to `current` of some thread that is currently running somewhere.
+pub struct CurrentTask(Task);
+
+// Make all `Task` methods available on `CurrentTask`.
+impl Deref for CurrentTask {
+    type Target = Task;
+    #[inline]
+    fn deref(&self) -> &Task {
+        &self.0
+    }
+}
+
 /// The type of process identifiers (PIDs).
 type Pid = bindings::pid_t;
 
@@ -121,27 +141,25 @@ pub fn current_raw() -> *mut bindings::task_struct {
     /// # Safety
     ///
     /// Callers must ensure that the returned object doesn't outlive the current task/thread.
-    pub unsafe fn current() -> impl Deref<Target = Task> {
-        struct TaskRef<'a> {
-            task: &'a Task,
-            _not_send: NotThreadSafe,
+    pub unsafe fn current() -> impl Deref<Target = CurrentTask> {
+        struct TaskRef {
+            task: *const CurrentTask,
         }
 
-        impl Deref for TaskRef<'_> {
-            type Target = Task;
+        impl Deref for TaskRef {
+            type Target = CurrentTask;
 
             fn deref(&self) -> &Self::Target {
-                self.task
+                // SAFETY: The returned reference borrows from this `TaskRef`, so it cannot outlive
+                // the `TaskRef`, which the caller of `Task::current()` has promised will not
+                // outlive the task/thread for which `self.task` is the `current` pointer. Thus, it
+                // is okay to return a `CurrentTask` reference here.
+                unsafe { &*self.task }
             }
         }
 
-        let current = Task::current_raw();
         TaskRef {
-            // SAFETY: If the current thread is still running, the current task is valid. Given
-            // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
-            // (where it could potentially outlive the caller).
-            task: unsafe { &*current.cast() },
-            _not_send: NotThreadSafe,
+            task: Task::current_raw().cast(),
         }
     }
 
@@ -203,6 +221,26 @@ pub fn wake_up(&self) {
     }
 }
 
+impl CurrentTask {
+    /// Access the address space of this task.
+    ///
+    /// To increment the refcount of the referenced `mm`, you can use `ARef::from`.
+    #[inline]
+    pub fn mm(&self) -> Option<&MmWithUser> {
+        let mm = unsafe { (*self.as_ptr()).mm };
+
+        if mm.is_null() {
+            None
+        } else {
+            // SAFETY: If `current->mm` is non-null, then it references a valid mm with a non-zero
+            // value of `mm_users`. The returned `&MmWithUser` borrows from `CurrentTask`, so the
+            // `&MmWithUser` cannot escape the current task, meaning `mm_users` can't reach zero
+            // while the reference is still live.
+            Some(unsafe { MmWithUser::from_raw(mm) })
+        }
+    }
+}
+
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
     fn inc_ref(&self) {

-- 
2.47.0.371.ga323438b13-goog


