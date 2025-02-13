Return-Path: <linux-kernel+bounces-512757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7D8A33D69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9696188E091
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5E2163AA;
	Thu, 13 Feb 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONBjn6hG"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B52153FA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444698; cv=none; b=svcUGVGz6BVDCz8z/ctbPUOc/lxseqU6SnJKdTQQLfHo++oPxMWl7/ijGXu3OvaFQVHEkKIwjff/vXd9ClUbuC+2VaEGj0Luu2ptso9joKpD1+iv0OEcKsCPFxc1tV2ZQ/+nbdEsuIAt+CgRtK3o/mdNWat9yVmh8zgiRNKle2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444698; c=relaxed/simple;
	bh=1zv+hEEHUtoRrSeYtVG9cnUb/jaHdXXVk6Pmq2XF4w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oSsnw8gV9s51t8emJkUrhUqwFQsMuoBoBdeK3Uc30ygCBrcmZJF3rAgr4HrHeyY6w70dbqlJqSZHnUapeq3MXRZSB/0AgQxEyEqD/gJ/vvgoJubfVCSwi6G7EknbTAoUwhMe3tMkGlw+2dt1+MWRqvCVCmYocxvjcWNVJKZ4dNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONBjn6hG; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38ddee8329eso407468f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739444695; x=1740049495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pggCn+rSttrAyFGqOyOJWEZwQTAFQJ/uxRrTgaYt6Zw=;
        b=ONBjn6hGa6JtXpgnJ6zN8yEaRMzHlBfdmFHBjKxPeVYPmfMlDAwtft7EK4lOUO7Jb/
         6PimiXdkPK3DS7xzpiKXBEOa+lZh4kEFAayI1DAkkG+/0Sf1Z5wVA4a2k3LGn7ZyCKEz
         robkYchdw5RRhZDHI50NB4VgiP1p5bL9CW2e7rteU35MEbYQ3h2sEFLDcMBTbtMxTCsz
         ffphDdAF6Abr+7212uLIVGrufcYWZgu2N+kjWt/WG+oUK2rbyJCsgPjJdH+rwCDXYYTh
         CxqujGdjZeUdNEhC3TbkgD0WD6IQW9rZs1OdoSQT4gKI2H/qS5CsBHvCg1pqjQJooOz1
         DoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444695; x=1740049495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pggCn+rSttrAyFGqOyOJWEZwQTAFQJ/uxRrTgaYt6Zw=;
        b=ZQe+wxY6jtjAbOmO8/YlMRtgeRFwF5B9BMv4MkaPWDXgLjTrCy2fWuFq0J6RtiNaDq
         Lvqtm3NHuc9TBf8eIbkhxM5Ec5zvRe6gDkT61ARTbp/ZdMU13+fmsYISaQGlgJ8raC8s
         hxbiYlNooaJBv9SaMKNZBTvWG3fCUYir1qNp2jZhbcLzXg2WVaiDbTlB0zwQgf1iOz39
         P1qtBloy1d7btsIJ1anr7+9MvvKXdRyARVIR0f9ldyNmPcq3Chhcu9YQ3KrcfvNZeU1s
         nTtcjir61qAOpHA57bCgFXyTrn2HV0n2jIoeH1oOFPQ9+/QbMHcS1XdcfZYnumxVSHEb
         yY7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXriguTIVi1JRC551YAt6YtVpysOspqhnQuksk5K/J9EkHwNRNjUxaO9uzqZSsynULNa/36xkNEyhn4js8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUNV5gf6Rw1Ysda5+bwPLt4/OeRcHfJbrL4T7p1wXDw0pi13+
	IlvRcToSNA20aUtix2/WGcLtB0hdgyS9x3gkGNMhS11haROljF8/G2BSBLdlEoi32ZXF/Re0TEv
	M0qnXzBZLIKn0sA==
X-Google-Smtp-Source: AGHT+IGOn6Mt66bw64HQ0WkAveH41wrxH69hatXUdAVol6d4fHE/vHEGMWR2wYfjVsRWmOaT0jjiIajQSSSAjtc=
X-Received: from wmsp21.prod.google.com ([2002:a05:600c:1d95:b0:439:4829:ec32])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:e4d:b0:38d:e61a:bc7 with SMTP id ffacd0b85a97d-38f24512decmr2550555f8f.40.1739444694761;
 Thu, 13 Feb 2025 03:04:54 -0800 (PST)
Date: Thu, 13 Feb 2025 11:04:07 +0000
In-Reply-To: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=18134; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=1zv+hEEHUtoRrSeYtVG9cnUb/jaHdXXVk6Pmq2XF4w4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnrdHChHUOhGpI4kDYpztj4GO15xSiXl+k7bnvp
 CTKdHXzRLWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ63RwgAKCRAEWL7uWMY5
 RpsID/9IhzcWTdhOJEwojq4rxoACbbWSGPJnIkg4Xqt8Z7jN+BB8275YLTeMQ2fTbUkO1YnoB3d
 Sx9n5XV7G6Qma/705uZT7hBgknowr8Xo4FTFBbq1fwvQL7ejohMfGL5AwIvq1JnwYVE+zTSMgIi
 XKB9Ns+kQptPUcCoUkh1QjAAeG6V2z+8CXWmGhUOvERJykv993uwCUoGCLbvrAiwRAXdOEjcAV7
 kA6o7e2+YfzICSW5bH1oknNqqL0k1Dp3xGKhyyjAdHLOX2zE8EVa4YLc29kD48DsQxPfwLzaRE9
 wD9uxsXNC4P334w28jai5myCnwLGpz/5tIoikO+c1xVGBKnT301+jPVpyDLjllPZ3ZOdoFcJsVu
 zlIkdsCh7NZ3SQ2ig+hWlxKxnSzNolA+nVZb1XVGhkKD/65ibdie4XhsChw5PFnNzSxsDYDww7q
 9BIuzwUZhlz/D2khqvYzGvxkUinoljisuNHOXnGzeJgxcWCHHE+znWlzkQ096dVVwiW80hNLVaH
 rg5XXmvACrFBh2NXLfYjf1hJk4e+nEWq7eqLKb9aa1cwFRDOTW+otUz0mwQD/v70U2IhITltU1E
 dykuskCSfHuXfjozqyyMPBI46BoAvm/3+rSIz8cXlsfGPaSummi/Mf3wCn1IZ/wYyox67ikph9q u/9avX3d36Gpqfg==
X-Mailer: b4 0.13.0
Message-ID: <20250213-vma-v14-8-b29c47ab21f5@google.com>
Subject: [PATCH v14 8/8] task: rust: rework how current is accessed
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Introduce a new type called `CurrentTask` that lets you perform various
operations that are only safe on the `current` task. Use the new type to
provide a way to access the current mm without incrementing its
refcount.

With this change, you can write stuff such as

	let vma = current!().mm().lock_vma_under_rcu(addr);

without incrementing any refcounts.

This replaces the existing abstractions for accessing the current pid
namespace. With the old approach, every field access to current involves
both a macro and a unsafe helper function. The new approach simplifies
that to a single safe function on the `CurrentTask` type. This makes it
less heavy-weight to add additional current accessors in the future.

That said, creating a `CurrentTask` type like the one in this patch
requires that we are careful to ensure that it cannot escape the current
task or otherwise access things after they are freed. To do this, I
declared that it cannot escape the current "task context" where I
defined a "task context" as essentially the region in which `current`
remains unchanged. So e.g., release_task() or begin_new_exec() would
leave the task context.

If a userspace thread returns to userspace and later makes another
syscall, then I consider the two syscalls to be different task contexts.
This allows values stored in that task to be modified between syscalls,
even if they're guaranteed to be immutable during a syscall.

Ensuring correctness of `CurrentTask` is slightly tricky if we also want
the ability to have a safe `kthread_use_mm()` implementation in Rust. To
support that safely, there are two patterns we need to ensure are safe:

	// Case 1: current!() called inside the scope.
	let mm;
	kthread_use_mm(some_mm, || {
	    mm = current!().mm();
	});
	drop(some_mm);
	mm.do_something(); // UAF

and:

	// Case 2: current!() called before the scope.
	let mm;
	let task = current!();
	kthread_use_mm(some_mm, || {
	    mm = task.mm();
	});
	drop(some_mm);
	mm.do_something(); // UAF

The existing `current!()` abstraction already natively prevents the
first case: The `&CurrentTask` would be tied to the inner scope, so the
borrow-checker ensures that no reference derived from it can escape the
scope.

Fixing the second case is a bit more tricky. The solution is to
essentially pretend that the contents of the scope execute on an
different thread, which means that only thread-safe types can cross the
boundary. Since `CurrentTask` is marked `NotThreadSafe`, attempts to
move it to another thread will fail, and this includes our fake pretend
thread boundary.

This has the disadvantage that other types that aren't thread-safe for
reasons unrelated to `current` also cannot be moved across the
`kthread_use_mm()` boundary. I consider this an acceptable tradeoff.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/task.rs | 247 +++++++++++++++++++++++++++-------------------------
 1 file changed, 129 insertions(+), 118 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 07bc22a7645c..0b6cb9a83a2e 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -7,6 +7,7 @@
 use crate::{
     bindings,
     ffi::{c_int, c_long, c_uint},
+    mm::MmWithUser,
     pid_namespace::PidNamespace,
     types::{ARef, NotThreadSafe, Opaque},
 };
@@ -31,22 +32,20 @@
 #[macro_export]
 macro_rules! current {
     () => {
-        // SAFETY: Deref + addr-of below create a temporary `TaskRef` that cannot outlive the
-        // caller.
+        // SAFETY: This expression creates a temporary value that is dropped at the end of the
+        // caller's scope. The following mechanisms ensure that the resulting `&CurrentTask` cannot
+        // leave current task context:
+        //
+        // * To return to userspace, the caller must leave the current scope.
+        // * Operations such as `begin_new_exec()` are necessarily unsafe and the caller of
+        //   `begin_new_exec()` is responsible for safety.
+        // * Rust abstractions for things such as a `kthread_use_mm()` scope must require the
+        //   closure to be `Send`, so the `NotThreadSafe` field of `CurrentTask` ensures that the
+        //   `&CurrentTask` cannot cross the scope in either direction.
         unsafe { &*$crate::task::Task::current() }
     };
 }
 
-/// Returns the currently running task's pid namespace.
-#[macro_export]
-macro_rules! current_pid_ns {
-    () => {
-        // SAFETY: Deref + addr-of below create a temporary `PidNamespaceRef` that cannot outlive
-        // the caller.
-        unsafe { &*$crate::task::Task::current_pid_ns() }
-    };
-}
-
 /// Wraps the kernel's `struct task_struct`.
 ///
 /// # Invariants
@@ -85,7 +84,7 @@ macro_rules! current_pid_ns {
 /// impl State {
 ///     fn new() -> Self {
 ///         Self {
-///             creator: current!().into(),
+///             creator: ARef::from(&**current!()),
 ///             index: 0,
 ///         }
 ///     }
@@ -105,6 +104,44 @@ unsafe impl Send for Task {}
 // synchronised by C code (e.g., `signal_pending`).
 unsafe impl Sync for Task {}
 
+/// Represents the [`Task`] in the `current` global.
+///
+/// This type exists to provide more efficient operations that are only valid on the current task.
+/// For example, to retrieve the pid-namespace of a task, you must use rcu protection unless it is
+/// the current task.
+///
+/// # Invariants
+///
+/// Each value of this type must only be accessed from the task context it was created within.
+///
+/// Of course, every thread is in a different task context, but for the purposes of this invariant,
+/// these operations also permanently leave the task context:
+///
+/// * Returning to userspace from system call context.
+/// * Calling `release_task()`.
+/// * Calling `begin_new_exec()` in a binary format loader.
+///
+/// Other operations temporarily create a new sub-context:
+///
+/// * Calling `kthread_use_mm()` creates a new context, and `kthread_unuse_mm()` returns to the
+///   old context.
+///
+/// This means that a `CurrentTask` obtained before a `kthread_use_mm()` call may be used again
+/// once `kthread_unuse_mm()` is called, but it must not be used between these two calls.
+/// Conversely, a `CurrentTask` obtained between a `kthread_use_mm()`/`kthread_unuse_mm()` pair
+/// must not be used after `kthread_unuse_mm()`.
+#[repr(transparent)]
+pub struct CurrentTask(Task, NotThreadSafe);
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
 
@@ -131,119 +168,29 @@ pub fn current_raw() -> *mut bindings::task_struct {
     ///
     /// # Safety
     ///
-    /// Callers must ensure that the returned object doesn't outlive the current task/thread.
-    pub unsafe fn current() -> impl Deref<Target = Task> {
-        struct TaskRef<'a> {
-            task: &'a Task,
-            _not_send: NotThreadSafe,
+    /// Callers must ensure that the returned object is only used to access a [`CurrentTask`]
+    /// within the task context that was active when this function was called. For more details,
+    /// see the invariants section for [`CurrentTask`].
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
-        }
-    }
-
-    /// Returns a PidNamespace reference for the currently executing task's/thread's pid namespace.
-    ///
-    /// This function can be used to create an unbounded lifetime by e.g., storing the returned
-    /// PidNamespace in a global variable which would be a bug. So the recommended way to get the
-    /// current task's/thread's pid namespace is to use the [`current_pid_ns`] macro because it is
-    /// safe.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that the returned object doesn't outlive the current task/thread.
-    pub unsafe fn current_pid_ns() -> impl Deref<Target = PidNamespace> {
-        struct PidNamespaceRef<'a> {
-            task: &'a PidNamespace,
-            _not_send: NotThreadSafe,
-        }
-
-        impl Deref for PidNamespaceRef<'_> {
-            type Target = PidNamespace;
-
-            fn deref(&self) -> &Self::Target {
-                self.task
-            }
-        }
-
-        // The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
-        //
-        // The `PidNamespace` of a `Task` doesn't ever change once the `Task` is alive. A
-        // `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)` will not have an effect
-        // on the calling `Task`'s pid namespace. It will only effect the pid namespace of children
-        // created by the calling `Task`. This invariant guarantees that after having acquired a
-        // reference to a `Task`'s pid namespace it will remain unchanged.
-        //
-        // When a task has exited and been reaped `release_task()` will be called. This will set
-        // the `PidNamespace` of the task to `NULL`. So retrieving the `PidNamespace` of a task
-        // that is dead will return `NULL`. Note, that neither holding the RCU lock nor holding a
-        // referencing count to
-        // the `Task` will prevent `release_task()` being called.
-        //
-        // In order to retrieve the `PidNamespace` of a `Task` the `task_active_pid_ns()` function
-        // can be used. There are two cases to consider:
-        //
-        // (1) retrieving the `PidNamespace` of the `current` task
-        // (2) retrieving the `PidNamespace` of a non-`current` task
-        //
-        // From system call context retrieving the `PidNamespace` for case (1) is always safe and
-        // requires neither RCU locking nor a reference count to be held. Retrieving the
-        // `PidNamespace` after `release_task()` for current will return `NULL` but no codepath
-        // like that is exposed to Rust.
-        //
-        // Retrieving the `PidNamespace` from system call context for (2) requires RCU protection.
-        // Accessing `PidNamespace` outside of RCU protection requires a reference count that
-        // must've been acquired while holding the RCU lock. Note that accessing a non-`current`
-        // task means `NULL` can be returned as the non-`current` task could have already passed
-        // through `release_task()`.
-        //
-        // To retrieve (1) the `current_pid_ns!()` macro should be used which ensure that the
-        // returned `PidNamespace` cannot outlive the calling scope. The associated
-        // `current_pid_ns()` function should not be called directly as it could be abused to
-        // created an unbounded lifetime for `PidNamespace`. The `current_pid_ns!()` macro allows
-        // Rust to handle the common case of accessing `current`'s `PidNamespace` without RCU
-        // protection and without having to acquire a reference count.
-        //
-        // For (2) the `task_get_pid_ns()` method must be used. This will always acquire a
-        // reference on `PidNamespace` and will return an `Option` to force the caller to
-        // explicitly handle the case where `PidNamespace` is `None`, something that tends to be
-        // forgotten when doing the equivalent operation in `C`. Missing RCU primitives make it
-        // difficult to perform operations that are otherwise safe without holding a reference
-        // count as long as RCU protection is guaranteed. But it is not important currently. But we
-        // do want it in the future.
-        //
-        // Note for (2) the required RCU protection around calling `task_active_pid_ns()`
-        // synchronizes against putting the last reference of the associated `struct pid` of
-        // `task->thread_pid`. The `struct pid` stored in that field is used to retrieve the
-        // `PidNamespace` of the caller. When `release_task()` is called `task->thread_pid` will be
-        // `NULL`ed and `put_pid()` on said `struct pid` will be delayed in `free_pid()` via
-        // `call_rcu()` allowing everyone with an RCU protected access to the `struct pid` acquired
-        // from `task->thread_pid` to finish.
-        //
-        // SAFETY: The current task's pid namespace is valid as long as the current task is running.
-        let pidns = unsafe { bindings::task_active_pid_ns(Task::current_raw()) };
-        PidNamespaceRef {
-            // SAFETY: If the current thread is still running, the current task and its associated
-            // pid namespace are valid. `PidNamespaceRef` is not `Send`, so we know it cannot be
-            // transferred to another thread (where it could potentially outlive the current
-            // `Task`). The caller needs to ensure that the PidNamespaceRef doesn't outlive the
-            // current task/thread.
-            task: unsafe { PidNamespace::from_ptr(pidns) },
-            _not_send: NotThreadSafe,
+            // CAST: The layout of `struct task_struct` and `CurrentTask` is identical.
+            task: Task::current_raw().cast(),
         }
     }
 
@@ -326,6 +273,70 @@ pub fn wake_up(&self) {
     }
 }
 
+impl CurrentTask {
+    /// Access the address space of the current task.
+    ///
+    /// This function does not touch the refcount of the mm.
+    #[inline]
+    pub fn mm(&self) -> Option<&MmWithUser> {
+        // SAFETY: The `mm` field of `current` is not modified from other threads, so reading it is
+        // not a data race.
+        let mm = unsafe { (*self.as_ptr()).mm };
+
+        if mm.is_null() {
+            return None;
+        }
+
+        // SAFETY: If `current->mm` is non-null, then it references a valid mm with a non-zero
+        // value of `mm_users`. Furthermore, the returned `&MmWithUser` borrows from this
+        // `CurrentTask`, so it cannot escape the scope in which the current pointer was obtained.
+        //
+        // This is safe even if `kthread_use_mm()`/`kthread_unuse_mm()` are used. There are two
+        // relevant cases:
+        // * If the `&CurrentTask` was created before `kthread_use_mm()`, then it cannot be
+        //   accessed during the `kthread_use_mm()`/`kthread_unuse_mm()` scope due to the
+        //   `NotThreadSafe` field of `CurrentTask`.
+        // * If the `&CurrentTask` was created within a `kthread_use_mm()`/`kthread_unuse_mm()`
+        //   scope, then the `&CurrentTask` cannot escape that scope, so the returned `&MmWithUser`
+        //   also cannot escape that scope.
+        // In either case, it's not possible to read `current->mm` and keep using it after the
+        // scope is ended with `kthread_unuse_mm()`.
+        Some(unsafe { MmWithUser::from_raw(mm) })
+    }
+
+    /// Access the pid namespace of the current task.
+    ///
+    /// This function does not touch the refcount of the namespace or use RCU protection.
+    ///
+    /// To access the pid namespace of another task, see [`Task::get_pid_ns`].
+    #[doc(alias = "task_active_pid_ns")]
+    #[inline]
+    pub fn active_pid_ns(&self) -> Option<&PidNamespace> {
+        // SAFETY: It is safe to call `task_active_pid_ns` without RCU protection when calling it
+        // on the current task.
+        let active_ns = unsafe { bindings::task_active_pid_ns(self.as_ptr()) };
+
+        if active_ns.is_null() {
+            return None;
+        }
+
+        // The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
+        //
+        // The `PidNamespace` of a `Task` doesn't ever change once the `Task` is alive.
+        //
+        // From system call context retrieving the `PidNamespace` for the current task is always
+        // safe and requires neither RCU locking nor a reference count to be held. Retrieving the
+        // `PidNamespace` after `release_task()` for current will return `NULL` but no codepath
+        // like that is exposed to Rust.
+        //
+        // SAFETY: If `current`'s pid ns is non-null, then it references a valid pid ns.
+        // Furthermore, the returned `&PidNamespace` borrows from this `CurrentTask`, so it cannot
+        // escape the scope in which the current pointer was obtained, e.g. it cannot live past a
+        // `release_task()` call.
+        Some(unsafe { PidNamespace::from_ptr(active_ns) })
+    }
+}
+
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
     fn inc_ref(&self) {

-- 
2.48.1.502.g6dc24dfdaf-goog


