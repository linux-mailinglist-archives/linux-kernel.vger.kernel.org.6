Return-Path: <linux-kernel+bounces-276356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F5949276
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E432813EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42262205E20;
	Tue,  6 Aug 2024 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LveUpjO1"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C61EB49E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952780; cv=none; b=IF7tjHIffe5V74nmlcDqzGoe5Bpg5ko2V2HRPUN0o4Yf79jigXHml2uQjdz6n20bn/aqFLkRA7BQhl7NqeatLlys4dmW91mtBDIpkuzHb3L0e1Vx2mTYuCuQWNqSRz7jo5HBf81314+wfCKahtG4qFcg81EbpLxoywwD/UJWDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952780; c=relaxed/simple;
	bh=24+zPg1hM+JfZs8SjokP0Q5m1qxn5IqRmOm2SzNaij0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=skQjvQXYNLgVWyLpa4gJ0G0S+56EYHMBuuApENEuLbRdbDQdj4QZOEKw93qW6wrTbfnVbAw5lA7QZ7azLM+ECwLAT1SA7MJNrrtYpuBiDmQip+03tjF+7IXrcjB2qBsnVXD753KSspa2NA1GeaQzcPtkvqcpYErCukVxz23zTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LveUpjO1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05e3938a37so1034326276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722952775; x=1723557575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mjKIRQEP0h51pKM/XyArnFXlqwAOBzE7RmnKZZV9HO4=;
        b=LveUpjO1zTC3JS9KBse/n0VRsDi9t+KVlxqszN0Y0jh0skmB17yILqQnlA1AL1ek0j
         90Yx63/KK5DMlr4S1aeaDMh9EY2q1eFy1x8isTt3zsRL/+rTD+UQPJi5TNOBpehPZfTI
         7Tn3MIIIwPBokyMU1OzBxK4KxiDAoSkhmswWPBE3DADd3zLoEfkrokdxq6BZmPJjVhEw
         5cgWgMHcF34rDxo3ZSw1oTZWSPJFB6sw8QWYxg0yPmsESlytuGri4IGvHkYyk5a53pXd
         JIjLV3jZRxYAaQCDZu/RmHJ8pnsPEyPJBq/4KJm4c6mzTuyhCSXQhELQ/io8XziAAEv8
         IWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952775; x=1723557575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjKIRQEP0h51pKM/XyArnFXlqwAOBzE7RmnKZZV9HO4=;
        b=gFsQUkskcwpdjMpOECI3zgrZKyDPQL7RylVZeJkqnKAFtkFL6EYSWtK/NPgUtqzO3P
         lRkgbGJ2Tf06aOVUQ60gYmErAN+zyjL6mMfEjz7Wj4ThcsaqiniK2ibKzFDeXuDiPcqH
         8Wz00dudEVIF1rAfyF6tfveEuMBOGt+A1Bt8qevvkFLa4dZpATE8DjVf/FuFK3vSBNWH
         WIpHk6PU5B53oSY3sXNnSuoCxuG1KAlN4OzXg8hz2feWCQ0Ck4K2t3OILfrdYdUEAOYa
         LLu6LSTHrPgLXOStfEGRwuYHqFGKDWP2rlPO9jrIwDY/0Uy1xPS5s7xnaNWjXzE68MTT
         tdIA==
X-Forwarded-Encrypted: i=1; AJvYcCWkB44DUbsKppvmoRKaH5JUwJAB6jXf2TIKAqOaZ2CgwjJ0OSZqpCzfMhf3NpOCOOhVjzBMgVlmBIpEsPe3hh7uYFQdot6DhpklKV5C
X-Gm-Message-State: AOJu0YyxiNDYb9El6+kq6XUB5oNuDQY89uZGKgSJJuD1YVyGWZg/YuWt
	Yz67Exfb/S0YjrXELRhJF9Ioe2aCeJXOVjv69+5TwcptIFMLhnimhj5+PyGQRFNH3YQqIfUbkMq
	Xgeq4qLKyBBbEpw==
X-Google-Smtp-Source: AGHT+IHI9fqZyX8w3wgfTrqWljUctuk7nUi2QibBgVq4K8JVS9b/OWAEOK0LTxJdeRJdaULpx3tJ0FBFdMvYylw=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1881:b0:e0e:4841:3a7e with SMTP
 id 3f1490d57ef6-e0e48413c8cmr168660276.7.1722952774866; Tue, 06 Aug 2024
 06:59:34 -0700 (PDT)
Date: Tue, 06 Aug 2024 13:58:55 +0000
In-Reply-To: <20240806-linked-list-v4-0-23efc510ec92@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806-linked-list-v4-0-23efc510ec92@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11251; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=24+zPg1hM+JfZs8SjokP0Q5m1qxn5IqRmOm2SzNaij0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmsiw4VpObni12GwUGWximtmn7bTqGGSyX0QD5j
 jWE6wi1eo2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrIsOAAKCRAEWL7uWMY5
 Ro5xEACj6c+vvzJxEs3sAIz/Oi1ZWPE1ZnHnTzkpbTDpmb269S43jwwCfaILhq5GOSWZLitBafA
 XAMOSQkh4Vro/E6ygI2e7w+AjDE8GcpkMfKcaPzNbkordA5TBAVlWQZGq8ppXXbBKqLdNTEHmQb
 LE8EPjGNbwqn6J/TAC1640Us8ckbWhg4N22cZF3sQWpsjLni2UVIsBAzB+d3Bl1eK60hf3x8Is3
 jZ83VnE/2CZF/Irt+ghFN8nmaK0fq/VjiAMBjT7BD/AWsCryh2la7a7gfoZsF52on2m13xiNbnt
 qEvDzqL/3GZc89lUNTkhj6Dy1XAG2xkDbBNIl2rpWZcxrYQrSTNv4AGU4HDXXNCQJl0UaevtiVc
 FRMyGLPiwVLU+rqfU75amHD6pTAcZmfrAMYA3YuzYdivHM32x9UIkuJHNbMfLosrAaLP20GX4WY
 wx75cqlwMPIcWGJkxUp6H4p7BNQMzX0w2KQHOuZzRQSVn8t+j49VpEexoEVF6HaY19vSYBmJ2Ug
 VUYsv1KCo28z/t2+jLpikaOjBmpR02YhFlEPnQtRUH00gOhbYmVltQAd8TJTqhTJZIbNDhXXLlz
 OZLYKl36Tckz9/1h1l8wIs5wfQE+/9DQbL7SuD39VXtrSS1EpHEKYW+LRe9hHkn4qSFeFMK6atA e+H6v0wggKgn1gg==
X-Mailer: b4 0.13.0
Message-ID: <20240806-linked-list-v4-3-23efc510ec92@google.com>
Subject: [PATCH v4 03/10] rust: list: add tracking for ListArc
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
 rust/kernel/list.rs     |   2 +-
 rust/kernel/list/arc.rs | 171 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fb16ea43b2ba..8e1533ee987b 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -5,4 +5,4 @@
 //! A linked list implementation.
 
 mod arc;
-pub use self::arc::{impl_list_arc_safe, ListArc, ListArcSafe};
+pub use self::arc::{impl_list_arc_safe, AtomicTracker, ListArc, ListArcSafe, TryNewListArc};
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index 966076da4a75..c5921a7d5966 100644
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
@@ -48,9 +49,38 @@ pub trait ListArcSafe<const ID: u64 = 0> {
     unsafe fn on_drop_list_arc(&self);
 }
 
+/// Declares that this type is able to safely attempt to create `ListArc`s at any time.
+///
+/// # Safety
+///
+/// The guarantees of `try_new_list_arc` must be upheld.
+pub unsafe trait TryNewListArc<const ID: u64 = 0>: ListArcSafe<ID> {
+    /// Attempts to convert an `Arc<Self>` into an `ListArc<Self>`. Returns `true` if the
+    /// conversion was successful.
+    ///
+    /// This method should not be called directly. Use [`ListArc::try_from_arc`] instead.
+    ///
+    /// # Guarantees
+    ///
+    /// If this call returns `true`, then there is no [`ListArc`] pointing to this value.
+    /// Additionally, this call will have transitioned the tracking inside `Self` from not thinking
+    /// that a [`ListArc`] exists, to thinking that a [`ListArc`] exists.
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
+///   which field to defer the tracking to. The field must implement [`ListArcSafe`]. If the field
+///   implements [`TryNewListArc`], then the type will also implement [`TryNewListArc`].
+///
+/// The `tracked_by` strategy is usually used by deferring to a field of type
+/// [`AtomicTracker`]. However, it is also possible to defer the tracking to another struct
+/// using also using this macro.
 #[macro_export]
 macro_rules! impl_list_arc_safe {
     (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untracked; } $($rest:tt)*) => {
@@ -61,6 +91,39 @@ unsafe fn on_drop_list_arc(&self) {}
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
@@ -205,6 +268,52 @@ pub fn pair_from_pin_unique<const ID2: u64>(
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
+            // SAFETY: The `try_new_list_arc` method returned true, so we made the tracking think
+            // that a `ListArc` exists. This lets us create a `ListArc`.
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
+            // SAFETY: The `try_new_list_arc` method returned true, so we made the tracking think
+            // that a `ListArc` exists. This lets us create a `ListArc`.
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
@@ -350,3 +459,61 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc
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
+pub struct AtomicTracker<const ID: u64 = 0> {
+    inner: AtomicBool,
+    // This value needs to be pinned to justify the INVARIANT: comment in `AtomicTracker::new`.
+    _pin: PhantomPinned,
+}
+
+impl<const ID: u64> AtomicTracker<ID> {
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
+impl<const ID: u64> ListArcSafe<ID> for AtomicTracker<ID> {
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
+unsafe impl<const ID: u64> TryNewListArc<ID> for AtomicTracker<ID> {
+    fn try_new_list_arc(&self) -> bool {
+        // INVARIANT: If this method returns true, then the boolean used to be false, and is no
+        // longer false, so it is okay for the caller to create a new [`ListArc`].
+        self.inner
+            .compare_exchange(false, true, Ordering::Acquire, Ordering::Relaxed)
+            .is_ok()
+    }
+}

-- 
2.46.0.rc2.264.g509ed76dc8-goog


