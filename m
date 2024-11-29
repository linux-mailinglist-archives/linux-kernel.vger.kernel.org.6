Return-Path: <linux-kernel+bounces-425799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9249DEB16
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E255A16467B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290119D898;
	Fri, 29 Nov 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1DsrMgB"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35651A4F19
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897993; cv=none; b=SPbRkq91qMo+9jV6rflGr9YKz8pBcCMJGKQjkIt5L3JEAtOc3/Lo+fn3hByWzu4D589ffkvEsFWHcsv6piLF5eYHCqw6BJE9pRq1UfIDcW3ljBjEvJmBTyHWTt0O9fETkBfNWrltbuWlVfKXKI0F7Uak66ww250cew0XjalIpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897993; c=relaxed/simple;
	bh=UOgti2W3w5pdDKaneEZaDc7ZRGkpusBY1HuaqkaxSYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hp2S1GfS0I4GSbv7uFWozWc6OdQL0uS7okjqDyBcXYT+storPG9NlDSSANSuKjerNSZtOnni6HHhRWTlYVYYYUxDOwMCINgYnSrvUI16DjDbWt8GOuxFnoONlxxuk7AoZRPBPjzCuw4Q11ZEgitdhQMmg5HKBt2OqgKKOdqDfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1DsrMgB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434a195814fso15050535e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732897989; x=1733502789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=khaQBcubSs8zPXHk0UASzgDi1+R5RW3CVTJj7OV4mlM=;
        b=K1DsrMgBOAY468+c8rbOcUOBRAUl/trQxfZJhrMf4IldaIOda1BaDJjMPmzORGH07o
         GBAQh8wchc4s/fiRC9Bk3daCVmkKHgHduM5TpJjj36QGrdECQuUbNxqZQlEyCbAOiqya
         teI8L3+iqAEwm9pJzvl8QAspP47cj3QnvlWiac2PpQ3PlzzfaPowjyvgq+04LqtlJsDK
         UuoeGPHaJIYYTeFcdZb0DfiFFRnu1PZUol5Fz4sa8qTD/4ZTg4cerHRvOdr0sOrflck6
         1AN13Hoa/Io+2NeJKEeReyL7Bxxxwd94n9HRth8MtxNiqeT9nSNaiLO+uKEVQ8LV37dO
         WXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897989; x=1733502789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khaQBcubSs8zPXHk0UASzgDi1+R5RW3CVTJj7OV4mlM=;
        b=Q+OKHlYLD37lPyA5csb4fUtFq+a6oxY+/+XSDFRI3e9XrVIMijm4/xHki/zXhIfmcZ
         GC0z+V/3FlnyMR9fhhaWFX0O/VeWX6Nw4KPl4k0r9VH6tECNoVw8UU+oUBe9VVnunVFS
         jx2Mmi5XX/8h/EeBR6oUPwbALyusblH11BJe9Fpd3WTn3j+VmicYiiYuL7/SWc8xva4t
         tyWE7apnJvi9nbD78uNkjeWlbIvl0i0eJqp3ACtM1D1fRII/4+V3qP/G9lg9HxFdzNVe
         Yf827l8xoPkyIvKPPVctzj+B6xtVnLBY6An049tjL5jUtJTTX76301lBL6M6U68ZcO3s
         vzRA==
X-Forwarded-Encrypted: i=1; AJvYcCUKV0ovfKanRIEK36NRROZqrDFYtwsX6vOkv+ranZrj/lLfzSUxFNaSJWSbw8nPYFFqCKPxEya5uU5kGy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYiIPC355unDj9ZzyGrkJ0XeY5qR+16Gjppe9QeVP9Aju8Xsl
	vEgS6K9tq5lbGFZADmFJQOUHvO+Ajc0uWPogUuRd07IFZn/DxZVpBJsN9Nxeag+onrRWyax6OXZ
	fEsZHr8113h1tCw==
X-Google-Smtp-Source: AGHT+IEBCg9KJJDJe7VoW4ZdyHwyebrajmoBgyf09TNJjFSpDvZZB+3u8dCYzcG1MDbxDRLvGSfQivBbzvIPAko=
X-Received: from wmoi4.prod.google.com ([2002:a05:600c:4804:b0:431:4c36:d336])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:458b:b0:431:5f1c:8359 with SMTP id 5b1f17b1804b1-434a9dcfd5emr120555635e9.15.1732897989312;
 Fri, 29 Nov 2024 08:33:09 -0800 (PST)
Date: Fri, 29 Nov 2024 16:32:41 +0000
In-Reply-To: <20241129-vma-v10-0-4dfff05ba927@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241129-vma-v10-0-4dfff05ba927@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=22122; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=UOgti2W3w5pdDKaneEZaDc7ZRGkpusBY1HuaqkaxSYQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnSeyys/aPXUMqJz2reACEhC4F6C968B9ndJ6+v
 TtfUjZpYQCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0nssgAKCRAEWL7uWMY5
 RsyPEACl6aaN3iihdjb3Lukz8wuBKhz9hO4mUk4ShWSq1Gpm8ui6yPKbk7FwrE7JRP1d+z4oyqX
 Ag6s7Vc6MWOSon5OgspWo9ddAWb/LGo+KkA8q7N2mhDrckQKdxIK7roASRVIUCH86nSSGEQdFUW
 tSv8ZBtT0UbQQ7OpTt/6iCzUEDNxx0UsWXRnkgya3zoeOktB/WFkJ4waQyQqxpQ2rB81nJKIXWm
 QJNGX4yatpPYp8gQ0QHtpeaArKJOIOCZgX6qeevc9UArg3n4hGcIIf9oZkG8xWeszpoue4XftpD
 mypcBaFsy12CTFh5Dq36HI3UqSZlZDwQWWCdhRIyBRFhAQ1COjZsxlvTTS180MBmYPREbunV4Lx
 IAIiOnCg0UOrOZG1PnnTnsPQj/VUBKqs+v0zTGyaKZcBYaKuD2fF7J/VvvmWeP9c0XS6yGHgM2p
 XEoicgR0hnK1BYVISv1pD7CVyDhYK9A9M40ICECur+GMwggsOCP+iWLd2+dVylN2QGpVQTYySCc
 BJOkxjWrDU7BHOT++OsYZZ8GtddUuVNZLKkbv1MKEy6dpaHYi3/g5i2uN2agLiaxYPRneEsteLa
 dX+Upt/nbs3CnGjySWD2cGfEI5e4nCPAeCY1dXAiVt05L0DObOG1EpIyZqC/JtfYdEqv1zapIGX JOeRJO5wY+7nO8A==
X-Mailer: b4 0.13.0
Message-ID: <20241129-vma-v10-8-4dfff05ba927@google.com>
Subject: [PATCH v10 8/8] task: rust: rework how current is accessed
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

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm.rs   |  22 ----
 rust/kernel/task.rs | 284 ++++++++++++++++++++++++++++++----------------------
 2 files changed, 167 insertions(+), 139 deletions(-)

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
index 07bc22a7645c..8c1ee46c03eb 100644
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
 
@@ -326,6 +273,109 @@ pub fn wake_up(&self) {
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
+        // The `PidNamespace` of a `Task` doesn't ever change once the `Task` is alive. A
+        // `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)` will not have an effect
+        // on the calling `Task`'s pid namespace. It will only effect the pid namespace of children
+        // created by the calling `Task`. This invariant guarantees that after having acquired a
+        // reference to a `Task`'s pid namespace it will remain unchanged.
+        //
+        // When a task has exited and been reaped `release_task()` will be called. This will set
+        // the `PidNamespace` of the task to `NULL`. So retrieving the `PidNamespace` of a task
+        // that is dead will return `NULL`. Note, that neither holding the RCU lock nor holding a
+        // referencing count to the `Task` will prevent `release_task()` being called.
+        //
+        // In order to retrieve the `PidNamespace` of a `Task` the `task_active_pid_ns()` function
+        // can be used. There are two cases to consider:
+        //
+        // (1) retrieving the `PidNamespace` of the `current` task
+        // (2) retrieving the `PidNamespace` of a non-`current` task
+        //
+        // From system call context retrieving the `PidNamespace` for case (1) is always safe and
+        // requires neither RCU locking nor a reference count to be held. Retrieving the
+        // `PidNamespace` after `release_task()` for current will return `NULL` but no codepath
+        // like that is exposed to Rust.
+        //
+        // Retrieving the `PidNamespace` from system call context for (2) requires RCU protection.
+        // Accessing `PidNamespace` outside of RCU protection requires a reference count that
+        // must've been acquired while holding the RCU lock. Note that accessing a non-`current`
+        // task means `NULL` can be returned as the non-`current` task could have already passed
+        // through `release_task()`.
+        //
+        // To retrieve (1) the `&CurrentTask` type should be used which ensures that the returned
+        // `PidNamespace` cannot outlive the current task context. The `CurrentTask::active_pid_ns`
+        // function allows Rust to handle the common case of accessing `current`'s `PidNamespace`
+        // without RCU protection and without having to acquire a reference count.
+        //
+        // For (2) the `task_get_pid_ns()` method must be used. This will always acquire a
+        // reference on `PidNamespace` and will return an `Option` to force the caller to
+        // explicitly handle the case where `PidNamespace` is `None`, something that tends to be
+        // forgotten when doing the equivalent operation in `C`. Missing RCU primitives make it
+        // difficult to perform operations that are otherwise safe without holding a reference
+        // count as long as RCU protection is guaranteed. But it is not important currently. But we
+        // do want it in the future.
+        //
+        // Note for (2) the required RCU protection around calling `task_active_pid_ns()`
+        // synchronizes against putting the last reference of the associated `struct pid` of
+        // `task->thread_pid`. The `struct pid` stored in that field is used to retrieve the
+        // `PidNamespace` of the caller. When `release_task()` is called `task->thread_pid` will be
+        // `NULL`ed and `put_pid()` on said `struct pid` will be delayed in `free_pid()` via
+        // `call_rcu()` allowing everyone with an RCU protected access to the `struct pid` acquired
+        // from `task->thread_pid` to finish.
+        //
+        // SAFETY: If `current`'s pid ns is non-null, then it references a valid pid ns.
+        // Furthermore, the returned `&PidNamespace` borrows from this `CurrentTask`, so it cannot
+        // escape the scope in which the current pointer was obtained.
+        Some(unsafe { PidNamespace::from_ptr(active_ns) })
+    }
+}
+
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
     fn inc_ref(&self) {

-- 
2.47.0.338.g60cca15819-goog


