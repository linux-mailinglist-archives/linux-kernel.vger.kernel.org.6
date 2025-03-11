Return-Path: <linux-kernel+bounces-556367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D80A5C4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA407AB80D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F925DAE8;
	Tue, 11 Mar 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="IPV75y03"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788D25E473
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705570; cv=none; b=ecWNiHjyA2qbLW/FQt9A3KcDcw3N77EcUTWHseaA4QcA7QmM/jHJ8FlPsNFzi7lol0uzy7gYjMm7pxDRYwJnXkDIjn4mrLhoQ9z7GImoQMu5XHzDqu04Vjy9Nxxc2Khyfhzl+a2MN//QvE58A+OdARu2pNUUVkB5Zdj9ErUYwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705570; c=relaxed/simple;
	bh=dBpq38Olwd6UC4G9g5bmtnBJf5Al41dz5nsCXr3LqKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GczFeqAxdUnmrlPKldHCCq+sED7KYCzYRBphlUAPL6dRJ7iti2GB02jtNuF0ET1kJy2gjOlrgy+D1/wT2e/TJuxX+RwL6bNuhuVqTcF2MEIWzEEPlPe7x9TMZ2yGl4bg8FETyJYppw7sP1LzXC9pmr44q6resn0y7B0fXaKBX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=IPV75y03; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C91A5240106
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:06:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741705560; bh=dBpq38Olwd6UC4G9g5bmtnBJf5Al41dz5nsCXr3LqKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=IPV75y03a34OPW+o2BUW0CLcADmpHj7q/nQbDyqcx5qYeSXHPblPFps4zwGIBiKIu
	 vWAkQNxpAIL4OyE8lRUVlq+tfr2YV3YFod4ojAb2FBY0Vt6eav9Vy7jyNn4YNd/fAD
	 5WVWHNEs1bIp8pPZkw11y8XlPxkVp3iOvx2lxHoX105/B+GaghNAwv9qso0TxkVo2D
	 LpunkZGkX90WQJs7kg8FAkPlczzWkmRntfCa4fydsKmlli1siNRexqTZKj04n69Box
	 5ACQBVQaufycufsGZSoPF6komegnDkP5aoFhaIu+ZreO6vjJxySm0zYVInkWARl28u
	 Hbx1tYMSYzqCg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZBxsf1Rfrz6tsg;
	Tue, 11 Mar 2025 16:05:58 +0100 (CET)
From: Panagiotis Foliadis <pfoliadis@posteo.net>
Date: Tue, 11 Mar 2025 15:05:52 +0000
Subject: [PATCH v2] rust: task: mark Task methods inline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-inline-c-wrappers-v2-1-72c99d35ff33@posteo.net>
X-B4-Tracking: v=1; b=H4sIAE9R0GcC/22NywrCMBBFf6XM2pE8bFNc+R/SRUhHOyBJSEJVS
 v7dWFy6PAfuuRtkSkwZzt0GiVbOHHwDdejALdbfCXluDEqoXmgxIvsHe0KHz2RjpJRxtqMmJ52
 yxkDbxUQ3fu3N69R44VxCeu8Xq/zaX02KP7VVosTZqOEkexq0VpcYcqFw9FRgqrV+AMTtd46zA
 AAA
X-Change-ID: 20250308-inline-c-wrappers-da83ec1c2a77
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Panagiotis Foliadis <pfoliadis@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741705558; l=5016;
 i=pfoliadis@posteo.net; s=20250308; h=from:subject:message-id;
 bh=dBpq38Olwd6UC4G9g5bmtnBJf5Al41dz5nsCXr3LqKA=;
 b=LGrVbOOSqFl3D8TT/zQpc1ma8J474qsuoVrLOZb+D++yUmimnXrNuJgl1OQs3is+hFTfDfgj4
 ls3gW4q3aJ0AtZVv9ZPs5stmo3ex8c4zPLxC7UCOn3hmVYQ3s2PgfE2
X-Developer-Key: i=pfoliadis@posteo.net; a=ed25519;
 pk=/8ch2dv3mwtZ5ygYwiG7ldc/132K6XmLkAZDmIe0aQw=

When you build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
toolchain provided by kernel.org, the following symbols are generated:

$ nm vmlinux | grep ' _R'.*Task | rustfilt
ffffffff817b2d30 T <kernel::task::Task>::get_pid_ns
ffffffff817b2d50 T <kernel::task::Task>::tgid_nr_ns
ffffffff817b2c90 T <kernel::task::Task>::current_pid_ns
ffffffff817b2d00 T <kernel::task::Task>::signal_pending
ffffffff817b2cc0 T <kernel::task::Task>::uid
ffffffff817b2ce0 T <kernel::task::Task>::euid
ffffffff817b2c70 T <kernel::task::Task>::current
ffffffff817b2d70 T <kernel::task::Task>::wake_up
ffffffff817b2db0 T <kernel::task::Task as kernel::types::AlwaysRefCounted>::dec_ref
ffffffff817b2d90 T <kernel::task::Task as kernel::types::AlwaysRefCounted>::inc_ref

These Rust symbols are trivial wrappers around the C functions
get_pid_ns, task_tgid_nr_ns, task_active_pid_ns, signal_pending, uid,
euid, get_current, wake_up, get_task_struct and put_task_struct.It
doesn't make sense to go through a trivial wrapper for these
functions, so mark them inline.

After applying this patch, the above command will produce no output.

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
---
Changes in v2:
- Added `#[inline] to all the remaining functions of task.rs file
- Link to v1: https://lore.kernel.org/r/20250310-inline-c-wrappers-v1-1-d726415e6332@posteo.net
---
 rust/kernel/task.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 07bc22a7645c0c7d792a0a163dd55b8ff0fe5f92..66b845a83acf3a57a59d281d11fcfb9107a214a8 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -132,6 +132,7 @@ pub fn current_raw() -> *mut bindings::task_struct {
     /// # Safety
     ///
     /// Callers must ensure that the returned object doesn't outlive the current task/thread.
+    #[inline]
     pub unsafe fn current() -> impl Deref<Target = Task> {
         struct TaskRef<'a> {
             task: &'a Task,
@@ -166,6 +167,7 @@ fn deref(&self) -> &Self::Target {
     /// # Safety
     ///
     /// Callers must ensure that the returned object doesn't outlive the current task/thread.
+    #[inline]
     pub unsafe fn current_pid_ns() -> impl Deref<Target = PidNamespace> {
         struct PidNamespaceRef<'a> {
             task: &'a PidNamespace,
@@ -273,24 +275,28 @@ pub fn pid(&self) -> Pid {
     }
 
     /// Returns the UID of the given task.
+    #[inline]
     pub fn uid(&self) -> Kuid {
         // SAFETY: It's always safe to call `task_uid` on a valid task.
         Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
     }
 
     /// Returns the effective UID of the given task.
+    #[inline]
     pub fn euid(&self) -> Kuid {
         // SAFETY: It's always safe to call `task_euid` on a valid task.
         Kuid::from_raw(unsafe { bindings::task_euid(self.as_ptr()) })
     }
 
     /// Determines whether the given task has pending signals.
+    #[inline]
     pub fn signal_pending(&self) -> bool {
         // SAFETY: It's always safe to call `signal_pending` on a valid task.
         unsafe { bindings::signal_pending(self.as_ptr()) != 0 }
     }
 
     /// Returns task's pid namespace with elevated reference count
+    #[inline]
     pub fn get_pid_ns(&self) -> Option<ARef<PidNamespace>> {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
         let ptr = unsafe { bindings::task_get_pid_ns(self.as_ptr()) };
@@ -306,6 +312,7 @@ pub fn get_pid_ns(&self) -> Option<ARef<PidNamespace>> {
 
     /// Returns the given task's pid in the provided pid namespace.
     #[doc(alias = "task_tgid_nr_ns")]
+    #[inline]
     pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
         let pidns = match pidns {
             Some(pidns) => pidns.as_ptr(),
@@ -319,6 +326,7 @@ pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
     }
 
     /// Wakes up the task.
+    #[inline]
     pub fn wake_up(&self) {
         // SAFETY: It's always safe to call `signal_pending` on a valid task, even if the task
         // running.
@@ -328,11 +336,13 @@ pub fn wake_up(&self) {
 
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
+    #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
         unsafe { bindings::get_task_struct(self.as_ptr()) };
     }
 
+    #[inline]
     unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         // SAFETY: The safety requirements guarantee that the refcount is nonzero.
         unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }

---
base-commit: 7f0e9ee5e44887272627d0fcde0b19a675daf597
change-id: 20250308-inline-c-wrappers-da83ec1c2a77

Best regards,
-- 
Panagiotis Foliadis <pfoliadis@posteo.net>


