Return-Path: <linux-kernel+bounces-562571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5BFA62C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 13:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0A43B6D69
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6C21F9F79;
	Sat, 15 Mar 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="ipKn7+Jq"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DA1F866A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742041403; cv=none; b=L8ophrIyfXCiFUAyNTJkl4Sb322z/3pliCDeAjfhC9LnW3yBdTSIKFgnTW6/2zSsjQ+UAvRdkbMgLJERGo9uDoh65pyIgq1IQrBmNfFeS/T79an1CpJyfv3pUBVK73El4gn7/O9MTc9Bk9fDAFi2otscVrAam6iTaHoN1dfKN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742041403; c=relaxed/simple;
	bh=Ukca3/ncqP9vO7wrUJD6tw4YmrjP4fcf9yvG7H3oX8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oHKXe2/DuLnpVsGvVt/oYNBbVsOG8noQWQ/foGfTpTp08y7OL4qoGwrNos8RHcW1DaXocMC4zeT0DBIrDxovFENkP1H9A5S5K5EDiv61G7rkTwbzQlQSWGbWGl4khaGDRaNnaty93Yu65hBsl7jXoQSsOGAsbr3pnGWppS7+Qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=ipKn7+Jq; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id A0979240028
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:23:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1742041393; bh=Ukca3/ncqP9vO7wrUJD6tw4YmrjP4fcf9yvG7H3oX8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=ipKn7+JqX40eMQ8BdC86W/3373kybHFYYmEboQbz0Bq/GB15srSJa13z/LmSqjJEC
	 YAkI2UWEyDE14AbaWDNS5p8TWGipm29J6H8nNZnUS5xADVJvn24aYKNaD5i+usf9Zw
	 zo3qkBYlxP0NPqPj5VxlH6Ym4p620BlUsz7/lAXuPMT9wAZ16OOFTGaQMNFroEU2Gb
	 Gn7iysOnQM4w6qROYf5Y3cSr2P1z9QTLIGWcLzMARwJdfTNdeP6h10iLLlxJVPDc3z
	 OC9npcQYoy+LluYe7kVVZBeiMwa3UPM3ZGHQAWqJZDvT1UHPC4qe2jQRcW5PERdIl6
	 +Ppkv+ffUBNxg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZFL3y4D6Yz9rxD;
	Sat, 15 Mar 2025 13:23:10 +0100 (CET)
From: Panagiotis Foliadis <pfoliadis@posteo.net>
Date: Sat, 15 Mar 2025 12:23:01 +0000
Subject: [PATCH v3] rust: task: mark Task methods inline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-inline-c-wrappers-v3-1-048e43fcef7d@posteo.net>
X-B4-Tracking: v=1; b=H4sIACRx1WcC/23NQQrCMBCF4auUrI0kE9u0rryHuAjJ1A5IUpISl
 dK7mxYXCl3+D+abmSWMhImdq5lFzJQo+BLqUDE7GH9HTq40AwG1UKLl5B/kkVv+jGYcMSbuTKv
 QSgtGa1buxog9vTbzeis9UJpCfG8vslzXrybFjpYll9xpaE6yxkYpuIwhTRiOHie2chl+CblHQ
 CE02K5zqu57pf6IZVk+qVJSKPYAAAA=
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
 llvm@lists.linux.dev, Christian Schrefl <chrisi.schrefl@gmail.com>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Panagiotis Foliadis <pfoliadis@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742041390; l=5384;
 i=pfoliadis@posteo.net; s=20250308; h=from:subject:message-id;
 bh=Ukca3/ncqP9vO7wrUJD6tw4YmrjP4fcf9yvG7H3oX8E=;
 b=v6wCwQhd50JlOIuoLOU8w2aDsC9KzDCmm1LpOPMHGSK9OTPwpSV8WV0szfPYAA2yZNBvDFZnm
 pWEYaYGdRn0CLYOaZZO3FxyQAswTfULjqB+1jLGHA4kda3Eg+fu1vDp
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
euid, get_current, wake_up, get_task_struct and put_task_struct. It
doesn't make sense to go through a trivial wrapper for these
functions, so mark them inline.

After applying this patch, the above command will produce no output.

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
---
Changes in v3:
- Fix typo in patch description
- Link to v2: https://lore.kernel.org/r/20250311-inline-c-wrappers-v2-1-72c99d35ff33@posteo.net

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


