Return-Path: <linux-kernel+bounces-331194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 927B497A97E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6D91C26E07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819515746B;
	Mon, 16 Sep 2024 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLTUy0d/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EAF2D045
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726528744; cv=none; b=BSAt30fuYTGVzrUNiRZMniN8fJIaWLvuoJpozY+e6IFGfZ+GqugZsXl83STZtf8XUKikDoZM06FgOY9GeYOXISeKLO0GAjZdjsAA6K4V27zsofkuO1ZFOBV0EXjmiwH/CiDSqTQ+MA0+iAeLFXPtoprVypSta2DeNy/KZ0WM4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726528744; c=relaxed/simple;
	bh=R8Hw8IHOebyRzIJqnmP3bh/QTmjQS8Q+tIPS2n5BhkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ldr+Wh843XxbHws8PPFy799kds7sEIrFHqEeiqTC3B7a1HRrzMYvBWOpbWArXnZ6WPrEKxfbLfAiEAsgHSOoWxvtvT1yl+mPk5Zkx9DXqpRP249wHO6dxpP6GZqI0XPcK9M6O56yfCTa3EFrC94Xv1xGk4R+5G/LdeNeP0gZrRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLTUy0d/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726528742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfB7ltETw4Jc+fgpTyDjkbtnh9ie4DeYsrGzm45G8hM=;
	b=eLTUy0d/GgnzGcy3yVitJfm+gdEjgxTwGDTp2uOyuc8KI/zmsjN7K0Vz+wLL7ZUsyZcmWN
	zM+rqEwnSaOBvfga5/U6khhYWxhUbOVrKa0QtXdwjXh360cF4b0zuukQfvFP2bnWD+3SJG
	S1YXTc8ZkaiFaKImobvXlrm1o32iPj4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-PmtYsDfuP1ih3k21bMDGrg-1; Mon,
 16 Sep 2024 19:18:59 -0400
X-MC-Unique: PmtYsDfuP1ih3k21bMDGrg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63E591956057;
	Mon, 16 Sep 2024 23:18:56 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.33.131])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B32E519560A3;
	Mon, 16 Sep 2024 23:18:51 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH v2 1/1] rust: sync: Add Lock::from_raw() for Lock<(), B>
Date: Mon, 16 Sep 2024 19:17:32 -0400
Message-ID: <20240916231817.643934-4-lyude@redhat.com>
In-Reply-To: <20240916231817.643934-2-lyude@redhat.com>
References: <20240916231817.643934-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A few of the APIs I've been writing bindings for (KMS in particular) rely
on the user manually acquiring specific locks before calling certain
functions. At the moment though, the only way of acquiring these locks in
bindings is to simply call the C locking functions directly - since said
locks are not acquired on the rust side of things.

However - if we add `#[repr(C)]` to `Lock<(), B>`, then given `()` is a ZST
- `Lock<(), B>` becomes equivalent in data layout to its inner `B::State`
type. Since locks in C don't have data explicitly associated with them
anyway, we can take advantage of this to add a `Lock::from_raw()` function
that can translate a raw pointer to `B::State` into its proper `Lock<(),
B>` equivalent. This lets us simply acquire a reference to the lock in
question and work with it like it was initialized on the rust side of
things, allowing us to use less unsafe code to implement bindings with lock
requirements.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V2:
* Don't implement this for all ZST types, just implement it for ()
---
 rust/kernel/sync/lock.rs | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819f..8a74a1ea1ecaf 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,8 +6,8 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use crate::{init::PinInit, pin_init, prelude::*, str::CStr, types::Opaque, types::ScopeGuard};
+use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned, mem};
 use macros::pin_data;
 
 pub mod mutex;
@@ -81,6 +81,7 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
 ///
 /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
 /// [`Backend`] specified as the generic parameter `B`.
+#[repr(C)]
 #[pin_data]
 pub struct Lock<T: ?Sized, B: Backend> {
     /// The kernel lock object.
@@ -117,6 +118,29 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
             }),
         })
     }
+
+}
+
+impl<B: Backend> Lock<(), B> {
+    /// Constructs a [`Lock`] from a raw pointer.
+    ///
+    /// This can be useful for interacting with a lock which was initialised outside of rust.
+    ///
+    /// # Safety
+    ///
+    /// The caller promises that `ptr` points to a valid initialised instance of [`State`].
+    ///
+    /// [`State`]: Backend::State
+    pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self
+    {
+        // SAFETY:
+        // * By the safety contract `ptr` must point to a valid initialised instance of `B::State`
+        // * Since the lock data type is `()` which is a ZST, `state` is the only non-ZST member of
+        //   the struct
+        // * Combined with `#[repr(C)]`, this guarantees `Self` has an equivalent data layout to
+        //   `B::State`.
+        unsafe { &*ptr.cast() }
+    }
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
-- 
2.46.0


