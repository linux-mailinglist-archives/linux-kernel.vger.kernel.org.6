Return-Path: <linux-kernel+bounces-259742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C7939C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80523280C33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3C314D70C;
	Tue, 23 Jul 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h69b0fUS"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9814D6E7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722984; cv=none; b=O5pWdBADCtQv7X6RaoSwtRIZ/EgKSSg576p6Eeb8ITXOPkqVYj1HHjxhYSCtAKrkkinEoW0UpuY0BDfLxwB+/YfFDSgbTLWBS21SowRHtrVXpysOXHRVV3DmdeqQwJS3jXD6g4gKzcaGqNTdt7m+WroV86kjk2lR6vsjbbfYXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722984; c=relaxed/simple;
	bh=Y1Woy0osPcWK5Kmhig4YRqu/zdNjMvINHCw3OpMj+9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KZk1JnApSFkgprJQkcf8RTRK7RgXxeBdw6zisd//tAswlkL+KdQSKS35PmtzE6F+nrzx9rC0eTLk3qDVBo0VwEiSQW2sQgnhj+eZ4wceuWBwofg2fSdl/ylQ47ukLEUJhtVrkhIOvGNmY0BcpXnRvozf9ESWoFUfzZYflHlaxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h69b0fUS; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-52efdae5be6so2738038e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722980; x=1722327780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHDHsWSYgO+1s3W4ChtXMwSAFNaQ/mfNYkx1n2oQLCo=;
        b=h69b0fUSvK0UCNMLMAcJAK9R8nJaquPRnKNDMSHGA3j9mm8tTqh9oPkfvehOpXvmqJ
         +ULivbQ5YxLhjN/KjtQ1d8wnRCji9kHTk+/QcTF9x1vQ0eJ5Z/tTToDEix92lNVrAlvF
         JLGBX5plyOdKm0jSplkkVyk6wlc7V8DU7jm0sNJWrDY15pfDmtVUYe8VAfNfOUYUEYmQ
         bmK9B4ANKsF7LPSXlGhA0PhFUXRBDGnKb2ypdmGzrjZv81nd4v0TaelyC8CcO7tthA8r
         2Uap4aQ3u8ZdSct3zLdlR0oApb7IXGf8WF701YELP7j9gy/IklNsQI+iiCbd5pEADGN3
         w6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722980; x=1722327780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHDHsWSYgO+1s3W4ChtXMwSAFNaQ/mfNYkx1n2oQLCo=;
        b=j69us1PX6h5OoS/c+NT8D+rSDOqNw0f5Cbeyw9QxX5Wfkh5ta8fK7yyauGOrFvG0+E
         q1JzqH1Jl/KODvkz7vPwuKe6lRCQU0B9A8iG9X8EAlSQdSp4l8aw7ReqLbh3Z9YBd86P
         w8LoFF2UjMvAQWp5w5TW/6hWsRMo+KEmdNxOIpMjt3jLcw9DjkS0NzQ3Rix82vluMYOd
         4b6dTSvyIQ2T32SSK6VQmKBt2p1Nz4XZXTJV2Dm4R05gDQln5gZ61rZ0rMbdgItGB8Nc
         0AU9noRDQF9c5GBtmbq8qsLBTYPPtyo7iSJ5+knNx4RZYC08j7bZNF3rQR0NcmV2kPyM
         MAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKXLSYa1CW20yxVNroKgW4ZMuTPeh+yZHkuk5LvKQyJy5vpgZjH/DGccHEeY2aaY3zrCgQ6PhwJGtmivaQMOHbkvCBz/LmQwh0iFiR
X-Gm-Message-State: AOJu0Yy/LeN75yYnYTmjZ1/HSlbk6gg3QGYyrR7Kh+nm5KrP8n1kwj4F
	JpQduJCNRjpo0eEUrTdlM2xXWJtbZt6EE9GhFgGwTbJSx5tSt6iTY7nyMFkIFr3h/oF9yGmjWyQ
	vYKQ2zlVLFStCpQ==
X-Google-Smtp-Source: AGHT+IFNKKI2GTN02KrPRt5I6wTM/q05wiWB4MWiYbz7ant2rLVvn5VAbuvtigwsIHeBNgM33lyRTIMZ15/6YBI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a19:6a16:0:b0:52d:b097:e11b with SMTP id
 2adb3069b0e04-52fc4048d80mr3071e87.4.1721722980615; Tue, 23 Jul 2024 01:23:00
 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:22:04 +0000
In-Reply-To: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10712; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Y1Woy0osPcWK5Kmhig4YRqu/zdNjMvINHCw3OpMj+9o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn2hTYfhI4Q2pTIs40yDSDZFa7QSD3UpCd3i1F
 CVTdmlMGBSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp9oUwAKCRAEWL7uWMY5
 RlN6D/43lUX4lRCSiaJw1cbtbwxtpS6dJzfBj1Jm5DG8PNGdjnm8/pTR6aDFmZyjQv9widpD4ik
 OnCRrH3hps0ldhe2hy4g8GcQEHMVmJQILMdW2k9Gu6LYYpMzfDtBJDZaP/AB/nQlgKafLFvIo/p
 1kmM+kKKxRpQz7VJo/HhUS3x3pwCev711Sm4SwO2EE3MOWVd6cpdBhq3rAX+Oo7/oYOKMz0kwu1
 4l5Tpzw8tU2UPmwRpPn5xSZOy1OtmDJZFdGMGl20RtS0rPA8OFWnjxwXEPzU7COWJBM6pPAEWD0
 GUyDAKpge+4iVZv1hwACoG6Hgatpp++Za22sYMEflGe2zmfAyUA2r4N4MLUk0Sag+dlKp9cfRks
 kPquhwWISbG+grDtq1SlTJB5fPC1k3c9gMnuUrKnpP1D8OJdvw82DMXzl4+m37zXKrvgESvGhfy
 EHP7ofuTZZ0nYu2uXBFyaqAQhl5lGQqSD0+JDLN8ynXohknXNgDDlqycvHTSLGEBcAb24HfUujK
 flqiuLyntQoaoS1Y9bCcONH7J1eGA+aCBIc0omtP09pltVmg/DqpzdLCF5TUp8uEtVrN5Aaowdw
 kUE0OJVnGviVGDtF0n0TYQmLlg+Up8mmoKMZ2OnCpYa1MubG3HJGe9iiuknRB48jGAxuytODeIl 1kVISIjaaqC8Yww==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-linked-list-v3-3-89db92c7dbf4@google.com>
Subject: [PATCH v3 03/10] rust: list: add tracking for ListArc
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, 
	Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

Add the ability to track whether a ListArc exists for a given value,
allowing for the creation of ListArcs without going through UniqueArc.

The `impl_list_arc_safe!` macro is extended with a `tracked_by` strategy
that defers the tracking of ListArcs to a field of the struct.
Additionally, the AtomicListArcTracker type is introduced, which can
track whether a ListArc exists using an atomic. By deferring the
tracking to a field of type AtomicListArcTracker, structs gain the
ability to create ListArcs without going through a UniqueArc.

Rust Binder uses this for some objects where we want to be able to
insert them into a linked list at any time. Using the
AtomicListArcTracker, we are able to check whether an item is already in
the list, and if not, we can create a `ListArc` and push it.

The macro has the ability to defer the tracking of ListArcs to a field,
using whatever strategy that field has. Since we don't add any
strategies other than AtomicListArcTracker, another similar option would
be to hard-code that the field should be an AtomicListArcTracker.
However, Rust Binder has a case where the AtomicListArcTracker is not
stored directly in the struct, but in a sub-struct. Furthermore, the
outer struct is generic:

struct Wrapper<T: ?Sized> {
    links: ListLinks,
    inner: T,
}

Here, the Wrapper struct implements ListArcSafe with `tracked_by inner`,
and then the various types used with `inner` also uses the macro to
implement ListArcSafe. Some of them use the untracked strategy, and some
of them use tracked_by with an AtomicListArcTracker. This way, Wrapper
just inherits whichever choice `inner` has made.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs     |   4 +-
 rust/kernel/list/arc.rs | 162 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fb16ea43b2ba..c5caa0f6105c 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -5,4 +5,6 @@
 //! A linked list implementation.
 
 mod arc;
-pub use self::arc::{impl_list_arc_safe, ListArc, ListArcSafe};
+pub use self::arc::{
+    impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryNewListArc,
+};
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index 3b7072e58256..97bd9d52b5cf 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ -7,9 +7,10 @@
 use crate::alloc::{AllocError, Flags};
 use crate::prelude::*;
 use crate::sync::{Arc, ArcBorrow, UniqueArc};
-use core::marker::Unsize;
+use core::marker::{PhantomPinned, Unsize};
 use core::ops::Deref;
 use core::pin::Pin;
+use core::sync::atomic::{AtomicBool, Ordering};
 
 /// Declares that this type has some way to ensure that there is exactly one `ListArc` instance for
 /// this id.
@@ -47,9 +48,30 @@ pub trait ListArcSafe<const ID: u64 = 0> {
     unsafe fn on_drop_list_arc(&self);
 }
 
+/// Declares that this type is able to safely attempt to create `ListArc`s at any time.
+///
+/// # Safety
+///
+/// Implementers must ensure that `try_new_list_arc` does not return `true` if a `ListArc` already
+/// exists.
+pub unsafe trait TryNewListArc<const ID: u64 = 0>: ListArcSafe<ID> {
+    /// Attempts to convert an `Arc<Self>` into an `ListArc<Self>`. Returns `true` if the
+    /// conversion was successful.
+    fn try_new_list_arc(&self) -> bool;
+}
+
 /// Declares that this type supports [`ListArc`].
 ///
-/// When using this macro, it will only be possible to create a [`ListArc`] from a [`UniqueArc`].
+/// This macro supports a few different strategies for implementing the tracking inside the type:
+///
+/// * The `untracked` strategy does not actually keep track of whether a [`ListArc`] exists. When
+///   using this strategy, the only way to create a [`ListArc`] is using a [`UniqueArc`].
+/// * The `tracked_by` strategy defers the tracking to a field of the struct. The user much specify
+///   which field to defer the tracking to. The field must implement [`ListArcSafe`].
+///
+/// The `tracked_by` strategy is usually used by deferring to a field of type
+/// [`AtomicListArcTracker`]. However, it is also possible to defer the tracking to another struct
+/// using also using this macro.
 #[macro_export]
 macro_rules! impl_list_arc_safe {
     (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untracked; } $($rest:tt)*) => {
@@ -60,6 +82,39 @@ unsafe fn on_drop_list_arc(&self) {}
         $crate::list::impl_list_arc_safe! { $($rest)* }
     };
 
+    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty {
+        tracked_by $field:ident : $fty:ty;
+    } $($rest:tt)*) => {
+        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t {
+            unsafe fn on_create_list_arc_from_unique(self: ::core::pin::Pin<&mut Self>) {
+                $crate::assert_pinned!($t, $field, $fty, inline);
+
+                // SAFETY: This field is structurally pinned as per the above assertion.
+                let field = unsafe {
+                    ::core::pin::Pin::map_unchecked_mut(self, |me| &mut me.$field)
+                };
+                // SAFETY: The caller promises that there is no `ListArc`.
+                unsafe {
+                    <$fty as $crate::list::ListArcSafe<$num>>::on_create_list_arc_from_unique(field)
+                };
+            }
+            unsafe fn on_drop_list_arc(&self) {
+                // SAFETY: The caller promises that there is no `ListArc` reference, and also
+                // promises that the tracking thinks there is a `ListArc` reference.
+                unsafe { <$fty as $crate::list::ListArcSafe<$num>>::on_drop_list_arc(&self.$field) };
+            }
+        }
+        unsafe impl$(<$($generics)*>)? $crate::list::TryNewListArc<$num> for $t
+        where
+            $fty: TryNewListArc<$num>,
+        {
+            fn try_new_list_arc(&self) -> bool {
+                <$fty as $crate::list::TryNewListArc<$num>>::try_new_list_arc(&self.$field)
+            }
+        }
+        $crate::list::impl_list_arc_safe! { $($rest)* }
+    };
+
     () => {};
 }
 pub use impl_list_arc_safe;
@@ -201,6 +256,52 @@ pub fn pair_from_pin_unique<const ID2: u64>(
         }
     }
 
+    /// Try to create a new `ListArc`.
+    ///
+    /// This fails if this value already has a `ListArc`.
+    pub fn try_from_arc(arc: Arc<T>) -> Result<Self, Arc<T>>
+    where
+        T: TryNewListArc<ID>,
+    {
+        if arc.try_new_list_arc() {
+            // SAFETY: The `try_new_list_arc` method returned true, so the tracking now thinks that
+            // a `ListArc` exists, so we can create one.
+            Ok(unsafe { Self::transmute_from_arc(arc) })
+        } else {
+            Err(arc)
+        }
+    }
+
+    /// Try to create a new `ListArc`.
+    ///
+    /// This fails if this value already has a `ListArc`.
+    pub fn try_from_arc_borrow(arc: ArcBorrow<'_, T>) -> Option<Self>
+    where
+        T: TryNewListArc<ID>,
+    {
+        if arc.try_new_list_arc() {
+            // SAFETY: The `try_new_list_arc` method returned true, so the tracking now thinks that
+            // a `ListArc` exists, so we can create one.
+            Some(unsafe { Self::transmute_from_arc(Arc::from(arc)) })
+        } else {
+            None
+        }
+    }
+
+    /// Try to create a new `ListArc`.
+    ///
+    /// If it's not possible to create a new `ListArc`, then the `Arc` is dropped. This will never
+    /// run the destructor of the value.
+    pub fn try_from_arc_or_drop(arc: Arc<T>) -> Option<Self>
+    where
+        T: TryNewListArc<ID>,
+    {
+        match Self::try_from_arc(arc) {
+            Ok(list_arc) => Some(list_arc),
+            Err(arc) => Arc::into_unique_or_drop(arc).map(Self::from),
+        }
+    }
+
     /// Transmutes an [`Arc`] into a `ListArc` without updating the tracking inside `T`.
     ///
     /// # Safety
@@ -346,3 +447,60 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc
     U: ListArcSafe<ID> + ?Sized,
 {
 }
+
+/// A utility for tracking whether a [`ListArc`] exists using an atomic.
+///
+/// # Invariant
+///
+/// If the boolean is `false`, then there is no [`ListArc`] for this value.
+#[repr(transparent)]
+pub struct AtomicListArcTracker<const ID: u64 = 0> {
+    inner: AtomicBool,
+    _pin: PhantomPinned,
+}
+
+impl<const ID: u64> AtomicListArcTracker<ID> {
+    /// Creates a new initializer for this type.
+    pub fn new() -> impl PinInit<Self> {
+        // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
+        // not be constructed in an `Arc` that already has a `ListArc`.
+        Self {
+            inner: AtomicBool::new(false),
+            _pin: PhantomPinned,
+        }
+    }
+
+    fn project_inner(self: Pin<&mut Self>) -> &mut AtomicBool {
+        // SAFETY: The `inner` field is not structurally pinned, so we may obtain a mutable
+        // reference to it even if we only have a pinned reference to `self`.
+        unsafe { &mut Pin::into_inner_unchecked(self).inner }
+    }
+}
+
+impl<const ID: u64> ListArcSafe<ID> for AtomicListArcTracker<ID> {
+    unsafe fn on_create_list_arc_from_unique(self: Pin<&mut Self>) {
+        // INVARIANT: We just created a ListArc, so the boolean should be true.
+        *self.project_inner().get_mut() = true;
+    }
+
+    unsafe fn on_drop_list_arc(&self) {
+        // INVARIANT: We just dropped a ListArc, so the boolean should be false.
+        self.inner.store(false, Ordering::Release);
+    }
+}
+
+// SAFETY: If this method returns `true`, then by the type invariant there is no `ListArc` before
+// this call, so it is okay to create a new `ListArc`.
+//
+// The acquire ordering will synchronize with the release store from the destruction of any
+// previous `ListArc`, so if there was a previous `ListArc`, then the destruction of the previous
+// `ListArc` happens-before the creation of the new `ListArc`.
+unsafe impl<const ID: u64> TryNewListArc<ID> for AtomicListArcTracker<ID> {
+    fn try_new_list_arc(&self) -> bool {
+        // INVARIANT: If this method returns true, then the boolean used to be false, and is no
+        // longer false, so it is okay for the caller to create a new [`ListArc`].
+        self.inner
+            .compare_exchange(false, true, Ordering::Acquire, Ordering::Relaxed)
+            .is_ok()
+    }
+}

-- 
2.45.2.1089.g2a221341d9-goog


