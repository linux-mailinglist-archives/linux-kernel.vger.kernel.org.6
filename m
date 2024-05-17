Return-Path: <linux-kernel+bounces-181932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133EE8C8384
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369A11C206FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED12E40D;
	Fri, 17 May 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWJZ0o+8"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886218AE0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938290; cv=none; b=Gl/RKfXPoW9EYnZ2gnL4Rz5BXmBK2Ev2xrGPf5al2yzC6hNzG5TzrRC5uCnLXJS3AMr9uwsMwk/sqaiKK5kN7x3Oy8F5B1ALV3p2Fle8iQgI9EyG4B4jRdv6I7CZcgRZ1k/2JZNBfDkJ4rpjhMi5IU/aZw7iGRiv6BOcGyt5HWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938290; c=relaxed/simple;
	bh=/7NEMInZUBlajLECH0gruHcSGsQCKeH4XQtsBofKfn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+HXZ2tZ0Yvq7zxl3p2kmrNXGo/T+CutLAyizkpKnf0fH8Xs6wBYM263vCvKG2OSIDyB/3t4U3oGPzF7Qvya9gZy2/BFEq9lg2/pw2GAxxsdVZ815PbaR5nojdDj9L03lSFPWbvPl4VUQALQdmRFAPBU6RPWNxEQwJL/OBVNNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWJZ0o+8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bed763956so167752397b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715938287; x=1716543087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TF6sCJ4G2uTP9Y58FzbVhi9qVLdhtJ2Sdz511uEZjA=;
        b=OWJZ0o+8a1BS2nRdJ/zSpqH6tBRUUV+mBRDtaOi2YORRBnxfVxIAmpeiSs/XpVzt4W
         7749yuoVWPkTsPf+93lCcpQ53L7Bsse7V7SoFTWiEERJF3bk8Kk3zvHGmgQXes16/lJb
         vPtQcqGG7CpifGNPxjd+x13gD9e4ziWOqtKJnx7Bb+8jOvXMs1lrXBIC/IsCri0q4vX3
         I2LGt140+ooR+fRQGVUIy47Zv6cbmClGrY8Afi1eGlNKzdG5syC6DoxItzXABvEk+9Ze
         3XxsdahYIBVYppIGGbfOWzj2WmW3uXF/U1gRblITlySR7122BaGGoR46/9/ksvENOYfJ
         uNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715938287; x=1716543087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TF6sCJ4G2uTP9Y58FzbVhi9qVLdhtJ2Sdz511uEZjA=;
        b=vW/fxPQBdnox8puya+loRGGN5YhfpnDxQGdj5CfFXTJRUHF3fWvxvvbPGDG0jwAxKH
         4hX7vAK23gamjpkJOgoJQxFnsWjPB27wT6iWM1SLpBEyejVnt8O3cDnKG91DxdP5muzo
         RF6fLoENfU/Ypar8FNcwXMjEjFkJViFLVK7LWOUudJEPUffGUF5QiBkaoi32b+Z/BqtP
         0o9MGmTBz+aWOlmhPcTe6HUspQ9Mw+IBMySYzpdW5rAmB4o3zrUL71DQaVOdHm0xCIIi
         xv66sbqYOiIPFMj/tcdS/QwDB+rnFtwDJeQkqD92kkAnpEEqr+LrHl0ZZd43Jnvkc94w
         zCdA==
X-Forwarded-Encrypted: i=1; AJvYcCVRGuPPlRHSkKeN3SS6K2hF9GFpUuITnZxKQWxMea+KQc1Q4mR1M29B5zgdWbSHIhngFg4FydUCw2oH7qj9mUhQmbHRumvrkRVvUv9o
X-Gm-Message-State: AOJu0YwTGjZR4yWUJkJYYEB4LCkukTDIgJaJsyn/OEBPbY7txxhZQuhd
	t2bLGDVFlAgWA2VpzDvc+DqAEMKLeCefW2+IgyOyuf3a9owMOhQfIrpIe55WrV+gZaaAW7h0uhg
	C5Ua3LC/zZZ9ikg==
X-Google-Smtp-Source: AGHT+IGNOYLNai269TaY7GJzi1Ju1usNLj/fodart9vzTfc+qhLnz0WIdXNTW3Ezeyf9dlNXDsn8jBKSH8ANWl4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:c10:b0:de6:1301:600a with SMTP
 id 3f1490d57ef6-dee4f374414mr5332717276.9.1715938287269; Fri, 17 May 2024
 02:31:27 -0700 (PDT)
Date: Fri, 17 May 2024 09:30:34 +0000
In-Reply-To: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5311; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/7NEMInZUBlajLECH0gruHcSGsQCKeH4XQtsBofKfn0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmRyPkfkXeHKiUjQtLtH23EWYt9gyKxdClviY8i
 Ap3cKw4bCqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZkcj5AAKCRAEWL7uWMY5
 RpMuD/9bBxfu7JTSxssxyf5VoD4gvbwse5RFD8yWDH15D7muI/nOVvpJsopARCWZq7TZW/kpeBz
 sWVctNdyfQnIROD5ZaKm+MWIl/3oH7yhnLstGhBN9JpY1WKSmx52M82m/UZQTo9LHnZE8wOJWd6
 KUUkk7b4kYTqfoPUeiyS4nUGzlcyq8Q7JAQZ4MSIn1dV8UDA5hMLOJ+NeQD39FJmW6/1DWEXDyZ
 bSE6zvwbSvtqPI5dQ7aaEXadRDwhZ/C9q/Sd3A+GE+PpzzhPiPBTqwAExPmWpi1LsHxdM6Cje97
 Ue0wLgKwI8G9jbUodQH9OxZFH2ucaIV/r471ZXO+/K0U6HzlJkSlRfusPHO2NZMP6wAiAxJmjwy
 IMQC/SvnNVLMsnPJW4KRBtS12oGQg4w9KuPRnsRcyIen1WJKbdurGUEY3yl3HUm8DOWkEnBs9nE
 WsEHuX3AFql5EGgsgRPEYvTFI5gRQaKzgq66rMeKT84PDx+lIWpX7khz85wBZldMz9MmNvnMvWB
 N3phQQ2m34SXc8hinA2eF/oTTxvfIl+ZKmbk0pLgH0Y91mPJTHlU8k2bpGoqi9GS17mEpf+pJHw
 WNqbE0rg/ajCYqRRu9ZU+ktIjDR3bHkCWe6ikt16UwoPoX9WPdRyKbJxfV1xwt82vwA8CXGdOQ3 Rc/1WIdH1qmbomw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240517-alice-file-v6-1-b25bafdc9b97@google.com>
Subject: [PATCH v6 1/8] rust: types: add `NotThreadSafe`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="utf-8"

This introduces a new marker type for types that shouldn't be thread
safe. By adding a field of this type to a struct, it becomes non-Send
and non-Sync, which means that it cannot be accessed in any way from
threads other than the one it was created on.

This is useful for APIs that require globals such as `current` to remain
constant while the value exists.

We update two existing users in the Kernel to use this helper:

 * `Task::current()` - moving the return type of this value to a
   different thread would not be safe as you can no longer be guaranteed
   that the `current` pointer remains valid.
 * Lock guards. Mutexes and spinlocks should be unlocked on the same
   thread as where they were locked, so we enforce this using the Send
   trait.

There are also additional users in later patches of this patchset. See
[1] and [2] for the discussion that led to the introduction of this
patch.

Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [1]
Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [2]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock.rs | 13 +++++++++----
 rust/kernel/task.rs      | 10 ++++++----
 rust/kernel/types.rs     | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..d6e9bab114b8 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,8 +6,13 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use crate::{
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    types::{NotThreadSafe, Opaque, ScopeGuard},
+};
+use core::{cell::UnsafeCell, marker::PhantomPinned};
 use macros::pin_data;
 
 pub mod mutex;
@@ -139,7 +144,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
 pub struct Guard<'a, T: ?Sized, B: Backend> {
     pub(crate) lock: &'a Lock<T, B>,
     pub(crate) state: B::GuardState,
-    _not_send: PhantomData<*mut ()>,
+    _not_send: NotThreadSafe,
 }
 
 // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
@@ -191,7 +196,7 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
         Self {
             lock,
             state,
-            _not_send: PhantomData,
+            _not_send: NotThreadSafe,
         }
     }
 }
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 55dff7e088bf..278c623de0c6 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -4,10 +4,12 @@
 //!
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
-use crate::types::Opaque;
+use crate::{
+    bindings,
+    types::{NotThreadSafe, Opaque},
+};
 use core::{
     ffi::{c_int, c_long, c_uint},
-    marker::PhantomData,
     ops::Deref,
     ptr,
 };
@@ -106,7 +108,7 @@ impl Task {
     pub unsafe fn current() -> impl Deref<Target = Task> {
         struct TaskRef<'a> {
             task: &'a Task,
-            _not_send: PhantomData<*mut ()>,
+            _not_send: NotThreadSafe,
         }
 
         impl Deref for TaskRef<'_> {
@@ -125,7 +127,7 @@ fn deref(&self) -> &Self::Target {
             // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
             // (where it could potentially outlive the caller).
             task: unsafe { &*ptr.cast() },
-            _not_send: PhantomData,
+            _not_send: NotThreadSafe,
         }
     }
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2e7c9008621f..93734677cfe7 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -409,3 +409,21 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// Zero-sized type to mark types not [`Send`].
+///
+/// Add this type as a field to your struct if your type should not be sent to a different task.
+/// Since [`Send`] is an auto trait, adding a single field that is `!Send` will ensure that the
+/// whole type is `!Send`.
+///
+/// If a type is `!Send` it is impossible to give control over an instance of the type to another
+/// task. This is useful to include in types that store or reference task-local information. A file
+/// descriptor is an example of such task-local information.
+pub type NotThreadSafe = PhantomData<*mut ()>;
+
+/// Used to construct instances of type [`NotThreadSafe`] similar to how `PhantomData` is
+/// constructed.
+///
+/// [`NotThreadSafe`]: type@NotThreadSafe
+#[allow(non_upper_case_globals)]
+pub const NotThreadSafe: NotThreadSafe = PhantomData;

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


