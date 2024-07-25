Return-Path: <linux-kernel+bounces-262331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1E293C42D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA6A1C220C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8619F478;
	Thu, 25 Jul 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNJYFXcE"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9319F464
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917690; cv=none; b=piWyg/+90DEb0XeoBSb5gbt4IolGXBhL8odLM0ViLz1KBUzDu2boewAmIZJkWJthaVwerMe8z4XoMBtEX9THGu0tEIPoSER+BMr52UicDhfFdscRL00h5nyyP2UakfoW8pseuAG41OuVgALvrkHTWIkwy+sGmj2bOQc5OoEYPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917690; c=relaxed/simple;
	bh=hxLniq6yNyNznDCTiHHngqdhzx2YJRtVONgjfGpwTUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bTL+8OmnZIo+ZsA1Ys+tJMgglJXm+9b16oKtDGyuGTS3lohlvq1YnoDU1OPQhgK9tG2IaEe5mk7oiEPpAtr9+ZwiEjUmBAqLD6bXCzpZX6nz1wFnpggdn2bR5pbMJmenDTQGT8iMZL/QJDun/pAlDxeyIZHrlC0fjvJOpOaAn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNJYFXcE; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2f01b9ae749so2289671fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917687; x=1722522487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzfkxy0T49pCsBww7qtAhWzqmcnTx5hmWNC+BQlP7as=;
        b=uNJYFXcEqi+9YtcviH6OfCATs8IRavf6Otl3I4+jNeJPWpB2mtSwLwBK6fY9KRIU4M
         yvl0LllVU4wC0VNdBzTEmhHNWN4XazqoGDCPyPhILB+U0SK3wr0EyAhf4tBPXiCmFdrP
         nql2LVHNR/C1Kzg9kho242k20sx01/K5ZQDck5TAJ+nKvYR4Twg6yIfjOhBWdzJ5FPHl
         hXGT0he1KsOnfnZU8ny8zSs6XMrMUJsGnU1tAn//N/XZoulLak35HLogcfwb/GyxEY8r
         0ICZrFJTNLt58mhSIkKi5/SFE8CE0i+DCR4wqiQekQXO2wZm/CCNwJT4EGzr/614GxDK
         d/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917687; x=1722522487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzfkxy0T49pCsBww7qtAhWzqmcnTx5hmWNC+BQlP7as=;
        b=tLEX/azBzx28wktgYbWWLLtk7yUb3sSjFaTiA3PAEQVoVSVRWz+Rd8xgpCEDqBimOC
         4aHXHa46da5gKR6u0Rr8Lgd+s2rSSr/iy+A2kQYGWD1GcbXOscN4Eb4jfgxl+79JxbdV
         Uwg4Xjb/Uen/5T5nrjI3RvNaOZWhsE3GTOiEEU1ZhCwxqnv5bIscEPWnt5pXf9CBUPHN
         KCnF/XQ25uc+s/GzQ2NXnJHwI+bS8i74qiz7wqgfcyDUH65ZABVgXIFvQDzUs/DajP+g
         6KcN0O+Y3jbhmO7dlpvqT8GrqFLOV1X73r3hnYywqPelGWaGT8Y9Nv9E5QWdWULhKh31
         UfgA==
X-Forwarded-Encrypted: i=1; AJvYcCV+V5zwgRH7DpMWr9gjjxFpqcvT0fdlNR19GEHbqI357OGDCAg0HJ8FBEQ+UtY/0NYmoSlzdhHV+yNt6c4IxgPsaW7GMZZn5GjFgkU2
X-Gm-Message-State: AOJu0Ywb6w2iOc2NqF0shgl2DEhdK2TXe2eMFZP7icF5BCqiyeHuTNkH
	3miRW22k3pcodTpLOD11fQMaGJFmxGuJ5kUfoaba5fPL5kx2FoFCGcZay3yCifqA0GYfDjLNrSe
	msnsBO7R7nWPh6g==
X-Google-Smtp-Source: AGHT+IGMbYL743+8/f8aXkoRFyolwZ5ePIvxRon1wwAiXAJH8YagdZ9h6BmGjEVzAWoim1DdrpXGZy73wicRty0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:960c:0:b0:2ef:1fc0:4d76 with SMTP id
 38308e7fff4ca-2f03dbb3977mr26511fa.4.1721917687296; Thu, 25 Jul 2024 07:28:07
 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:41 +0000
In-Reply-To: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7281; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hxLniq6yNyNznDCTiHHngqdhzx2YJRtVONgjfGpwTUY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDby/cEnK7Sc3xSnl9qOhF0JYGj7Cgmie2Dv
 V9lfMsFii+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg2wAKCRAEWL7uWMY5
 RvzxD/0Treg9TICf5sVlaSfn8QrEHJeWCwWsFmDjsPoF7MrG23AgH/jscw9UdOOttRCNorzjSrd
 MwTqJdrviwyGPOkuQRW6YpSoBPYO7mdwsO/DesiKHAYuxIkHP5L8+ANkA4ykcaw14jvvJU92Dkf
 L7zUAM3G306HHXe8NOzWBg2GaQVGe82TmGC/SOGkgBCd7BKw0eEm8y1gXhZEGtWO8zdPse5s+EM
 fvlYYGSQ+49IOCRaqBxGaRivQErUXEDzW09H80iOlFU7STISVGswP6yMFTkd8l0pox8RCb9scsd
 dINXdl2UWPEley+IJ9pjKVydctoguOaePp8aI2uSH3P3L9stE6pik+3m0Si+2f4z4OLKm2osUeA
 iKqfNlaZbSjWyGxwPYyOhCaD8YI7ukvNLwPRkygv58tt/M2sB4dfxzmEVSxkvRymbCziSL+auJA
 nGHxHKHBreL28etKawqkFXp8/aH7Pu4faYWoq0wuCuT1pby0hYDfrDYUitH0wbn+5S1BQeuFyBN
 vjOEV/88jtyTgJUTCxa4HTT0nskGmNwk9x5XcsVuC8Oo2f04FSV4sNKCfZDr6vApHvsPH6xakIP
 R/9o/E707c+ItugXiZQGxr6PjAhC+JONpMlSHuFBStJXDas62cIHFQ05i+kRhm6zTqgIeEL+pa/ iVkjEr1mf/FLliQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-8-55a2e80deaa8@google.com>
Subject: [PATCH v8 8/8] rust: file: add abstraction for `poll_table`
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
Cc: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

The existing `CondVar` abstraction is a wrapper around
`wait_queue_head`, but it does not support all use-cases of the C
`wait_queue_head` type. To be specific, a `CondVar` cannot be registered
with a `struct poll_table`. This limitation has the advantage that you
do not need to call `synchronize_rcu` when destroying a `CondVar`.

However, we need the ability to register a `poll_table` with a
`wait_queue_head` in Rust Binder. To enable this, introduce a type
called `PollCondVar`, which is like `CondVar` except that you can
register a `poll_table`. We also introduce `PollTable`, which is a safe
wrapper around `poll_table` that is intended to be used with
`PollCondVar`.

The destructor of `PollCondVar` unconditionally calls `synchronize_rcu`
to ensure that the removal of epoll waiters has fully completed before
the `wait_queue_head` is destroyed.

That said, `synchronize_rcu` is rather expensive and is not needed in
all cases: If we have never registered a `poll_table` with the
`wait_queue_head`, then we don't need to call `synchronize_rcu`. (And
this is a common case in Binder - not all processes use Binder with
epoll.) The current implementation does not account for this, but if we
find that it is necessary to improve this, a future patch could store a
boolean next to the `wait_queue_head` to keep track of whether a
`poll_table` has ever been registered.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/poll.rs        | 121 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d7f7ae109e6f..809112fd73d3 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -16,6 +16,7 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
+#include <linux/poll.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..bae4a5179c72 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 mod condvar;
 pub mod lock;
 mod locked_by;
+pub mod poll;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
new file mode 100644
index 000000000000..d5f17153b424
--- /dev/null
+++ b/rust/kernel/sync/poll.rs
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Utilities for working with `struct poll_table`.
+
+use crate::{
+    bindings,
+    fs::File,
+    prelude::*,
+    sync::{CondVar, LockClassKey},
+    types::Opaque,
+};
+use core::ops::Deref;
+
+/// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
+#[macro_export]
+macro_rules! new_poll_condvar {
+    ($($name:literal)?) => {
+        $crate::sync::poll::PollCondVar::new(
+            $crate::optional_name!($($name)?), $crate::static_lock_class!()
+        )
+    };
+}
+
+/// Wraps the kernel's `struct poll_table`.
+///
+/// # Invariants
+///
+/// This struct contains a valid `struct poll_table`.
+///
+/// For a `struct poll_table` to be valid, its `_qproc` function must follow the safety
+/// requirements of `_qproc` functions:
+///
+/// * The `_qproc` function is given permission to enqueue a waiter to the provided `poll_table`
+///   during the call. Once the waiter is removed and an rcu grace period has passed, it must no
+///   longer access the `wait_queue_head`.
+#[repr(transparent)]
+pub struct PollTable(Opaque<bindings::poll_table>);
+
+impl PollTable {
+    /// Creates a reference to a [`PollTable`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that for the duration of 'a, the pointer will point at a valid poll
+    /// table (as defined in the type invariants).
+    ///
+    /// The caller must also ensure that the `poll_table` is only accessed via the returned
+    /// reference for the duration of 'a.
+    pub unsafe fn from_ptr<'a>(ptr: *mut bindings::poll_table) -> &'a mut PollTable {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `PollTable` type being transparent makes the cast ok.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    fn get_qproc(&self) -> bindings::poll_queue_proc {
+        let ptr = self.0.get();
+        // SAFETY: The `ptr` is valid because it originates from a reference, and the `_qproc`
+        // field is not modified concurrently with this call since we have an immutable reference.
+        unsafe { (*ptr)._qproc }
+    }
+
+    /// Register this [`PollTable`] with the provided [`PollCondVar`], so that it can be notified
+    /// using the condition variable.
+    pub fn register_wait(&mut self, file: &File, cv: &PollCondVar) {
+        if let Some(qproc) = self.get_qproc() {
+            // SAFETY: The pointers to `file` and `self` need to be valid for the duration of this
+            // call to `qproc`, which they are because they are references.
+            //
+            // The `cv.wait_queue_head` pointer must be valid until an rcu grace period after the
+            // waiter is removed. The `PollCondVar` is pinned, so before `cv.wait_queue_head` can
+            // be destroyed, the destructor must run. That destructor first removes all waiters,
+            // and then waits for an rcu grace period. Therefore, `cv.wait_queue_head` is valid for
+            // long enough.
+            unsafe { qproc(file.as_ptr() as _, cv.wait_queue_head.get(), self.0.get()) };
+        }
+    }
+}
+
+/// A wrapper around [`CondVar`] that makes it usable with [`PollTable`].
+///
+/// [`CondVar`]: crate::sync::CondVar
+#[pin_data(PinnedDrop)]
+pub struct PollCondVar {
+    #[pin]
+    inner: CondVar,
+}
+
+impl PollCondVar {
+    /// Constructs a new condvar initialiser.
+    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+        pin_init!(Self {
+            inner <- CondVar::new(name, key),
+        })
+    }
+}
+
+// Make the `CondVar` methods callable on `PollCondVar`.
+impl Deref for PollCondVar {
+    type Target = CondVar;
+
+    fn deref(&self) -> &CondVar {
+        &self.inner
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for PollCondVar {
+    fn drop(self: Pin<&mut Self>) {
+        // Clear anything registered using `register_wait`.
+        //
+        // SAFETY: The pointer points at a valid `wait_queue_head`.
+        unsafe { bindings::__wake_up_pollfree(self.inner.wait_queue_head.get()) };
+
+        // Wait for epoll items to be properly removed.
+        //
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::synchronize_rcu() };
+    }
+}

-- 
2.45.2.1089.g2a221341d9-goog


