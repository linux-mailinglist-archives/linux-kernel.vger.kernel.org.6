Return-Path: <linux-kernel+bounces-553860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B057A58FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9FF3ACF64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B74225761;
	Mon, 10 Mar 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="HjYiFA7F"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50692253E1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599624; cv=none; b=qltCmoLjTUToMBxKC9vnycMPmvNz0bNgqd9Y0ZmEjnqIS9WcG6QquKBqFXrmpNbVgANgUTs69eUo4BgZ0+sGFDQdswp13orYZ9mF9gqNHYjbBYJ7eU5wp6DmpADf+04jyKB8iu8utrmqjRpcXzBHlQmLmwlNvefQvd1ZJHZN2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599624; c=relaxed/simple;
	bh=+0wn6CEZBMks82wBoIPLAtnrHTCR+LvgWxO/drTJy2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CmIU4FMM/wygl8dMbEg0uRAUBRRBc0C/RRCW4JX/u9ZF9ppsre0IdprIZ51at6Tdy8cAofVRLKpAmDbLKGXRLOoK/gZPJ11oNSvCdzvkqziHFNxcleAY8t6ceyoRzB456BzgfsIP3epJvV/mu5yUTK4JhZ8gVVU8tHGV/OfdhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=HjYiFA7F; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id EA05B24002A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741599620; bh=+0wn6CEZBMks82wBoIPLAtnrHTCR+LvgWxO/drTJy2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=HjYiFA7FUOhEeK6QNoDusYHrF7NqumYMc2pTgtGqANSYErV7CfVghhEdfLXF0gb+6
	 AyBVl8ILXOyVgZZ5hCQrK8MNrAzTN/ZKh7emJ51agDWxniE7an+qTpNEVo2n54Hns9
	 EjWx/3ZIZg+JYvJw2hAbgB9K6XipWd64anzII64B5pa2m8U4yHkuTNi1EnY85OJCzA
	 B3CbmWbvg5PRrw3gqxb44vnOqNwGdQcpWrxEbvRECpBcW7LpiSSiub3T67L5BfUmX9
	 3h+IaMawrDXdB6KbtXZuHHdFtqfI6V4SQcTo82TJQIqVzBA3abEc7Ln+H4+pWhxn9c
	 fshze9SQECPPg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZBBhK6GQdz9rxM;
	Mon, 10 Mar 2025 10:40:17 +0100 (CET)
From: Panagiotis Foliadis <pfoliadis@posteo.net>
Date: Mon, 10 Mar 2025 09:39:15 +0000
Subject: [PATCH] rust: task: mark Task methods inline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-inline-c-wrappers-v1-1-d726415e6332@posteo.net>
X-B4-Tracking: v=1; b=H4sIAEKzzmcC/x3MQQqAIBBA0avErBtQI5KuEi1EpxoIkxEqEO+et
 HyL/wtkEqYMc1dA6ObMV2zQfQf+cHEn5NAMRplRDcoix5MjocdHXEokGYOzA3ntjZsmaF0S2vj
 9n8ta6wevQw8GYwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741599617; l=3618;
 i=pfoliadis@posteo.net; s=20250308; h=from:subject:message-id;
 bh=+0wn6CEZBMks82wBoIPLAtnrHTCR+LvgWxO/drTJy2c=;
 b=va5T3sB7VN1Q9VHEsh3uaHTGU4mG5/H7vyeKhbV9ow08fFutaBADQBRBBoxI25knuJk/WSbvd
 lcQNwKQCGwqD1x0sQrVwXOE8i3+IRZRxnESvJFR88YHq6gC+SrYXHQa
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

Most of these Rust symbols are trivial wrappers around the C functions
signal_pending, uid, euid, wake_up, dec_ref and inc_ref.It doesn't
make sense to go through a trivial wrapper for these functions, so
mark them inline.

After applying this patch, the above command will produce this output:

ffff8000805aa004 T <kernel::task::Task>::get_pid_ns
ffff8000805aa01c T <kernel::task::Task>::tgid_nr_ns
ffff8000805a9fe8 T <kernel::task::Task>::current_pid_ns
ffff8000805a9fd0 T <kernel::task::Task>::current

Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
Link: https://github.com/Rust-for-Linux/linux/issues/1145
---
 rust/kernel/task.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 07bc22a7645c0c7d792a0a163dd55b8ff0fe5f92..996d7c96e48689a5752817f9ca196c021865291d 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -273,18 +273,21 @@ pub fn pid(&self) -> Pid {
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
@@ -319,6 +322,7 @@ pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
     }
 
     /// Wakes up the task.
+    #[inline]
     pub fn wake_up(&self) {
         // SAFETY: It's always safe to call `signal_pending` on a valid task, even if the task
         // running.
@@ -328,11 +332,13 @@ pub fn wake_up(&self) {
 
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


