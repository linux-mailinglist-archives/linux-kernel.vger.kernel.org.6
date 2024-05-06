Return-Path: <linux-kernel+bounces-169621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA58BCB4B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEA31F2604B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70539143C5C;
	Mon,  6 May 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAASI9gp"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017411428ED
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989237; cv=none; b=Wa5uzgubDOKUf0LY6NPVpMWa2NA7kO6GlGgF08p1FH+Mqn8fzW/XDX5Abqxu8OG40OCVybeaX0CQY6gBhlBzOUnF2+DJDKxeD8SQLWIiTbQgRZ+mQ2whSakoEzfGM29hr7/rhQw4UDbP2x78D1QILmlicaQpZEsqT+ZK+oLYo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989237; c=relaxed/simple;
	bh=wEG/4LvM1FI/4ihCHGAieLrKEgeQtI2G5Vod3tjzD4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nf1gllDF8mJLtArRncQTu65Fd9aoI0IkqzNgqjtx4nEs+zRxfJBD6qnZYPjrWCYswe5mS+PtPc+28QD0VF7QMKmLl+AO3qEj2cShBRamBHFAOnuVOigIMz634F4Mj3JCOAULiiAVUT1+rQ0zdRQ23Edk4dKvMDUJR1d74K7+S7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAASI9gp; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-51faceb0569so1315750e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714989232; x=1715594032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBucNw+Aee/R2s0jMV10I00Gxph4SAVWU7MXoG8D4tk=;
        b=UAASI9gpzr7nHvYXROaviRRih+MjD9MY6xVggCJyIXFMVNv5/5fFO+6Z3YgqgfytlJ
         lT8VoR/sFX8UvLftAsSSYgtYv7zjuZxgyKoKYNNgWMtAYG29tRAK9ltfWTdwjFPl2gea
         GtYhJOh4GDHB+u+BG8GVDtv+5u2/BDy2HiSpHD2hlFwQKYTr7lc/4N6hABAI69vbbvTE
         4tEPkfnmJQIxIEPeUKKgC/7FiPXhrQjkPk/7vLcga0nzz5bq88+9Vk/FBCtppXUeOTOe
         66xRlEl/GVP/tYnyqJMaUCb01Ro1bYm7IL5KzMWGDVMIvie10GRrL4u6iZqk2FV48XI6
         nIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989232; x=1715594032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBucNw+Aee/R2s0jMV10I00Gxph4SAVWU7MXoG8D4tk=;
        b=pHcwB8JUDEb7G0keJjVfNJIw/MONy2XEwdl94YYCIl7DHDRYjsEZmegdBQ+eFWUaET
         Sj8kPySCUlMyCGMx9GyEDpQsMv42iLjnjLXT8VgQ9rpGlZtaDv4MqpJsUnmxqzf4IWte
         MQdKZP0brx5CKULR+bjsV9vI6GyZweUj4Br8lLKsMZsaSReLFQxNQ5bBfAHy8mskjB/P
         ZNLPvj5mHyZVR2iyDQ4cMCGCI1gyzGGs0m4BkABGMIJhZlBow2qR+ejpvKPR34adp0i7
         WpkvhDI9918+ShUe7tiO5uOU/1B94lkXaw4wMOwx1wRKy5S4EX5I72V/+rEHtiiwkaaj
         O8xw==
X-Forwarded-Encrypted: i=1; AJvYcCVSmpQQ4YO7uSmg36Zt5XnD1EYYy6LQ8Tllq0IDAo+mF0bOGvlKXXIPSYkVrDnCKg5Ix7sZnzIHokKwoMlMZbAIsSnvjGabLWSE4uDm
X-Gm-Message-State: AOJu0YzM434j7pu9AnfE9GFN/xZ0kB8Yxu1WVAPdWwFjg07JNIxWcvIg
	uzCWRj2h1jXpbAd+YkVHw2DW9fQr1qhF9efpU6cb850Rr4zSbphYAR4pBFM9bbynZOtHY/1C6gg
	U7ORt7ZDw8GpNGQ==
X-Google-Smtp-Source: AGHT+IGki79q6OvvlZmNS3ZbPOCMYVp/BCeI8OikYiJ7CZF8m6HgC3jU4faWa1+VYJknEc8hSDElMRrazQGQGsY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:47e4:0:b0:51c:58b0:88c7 with SMTP id
 b4-20020ac247e4000000b0051c58b088c7mr8790lfp.7.1714989232282; Mon, 06 May
 2024 02:53:52 -0700 (PDT)
Date: Mon, 06 May 2024 09:53:23 +0000
In-Reply-To: <20240506-linked-list-v2-0-7b910840c91f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506-linked-list-v2-0-7b910840c91f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10280; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wEG/4LvM1FI/4ihCHGAieLrKEgeQtI2G5Vod3tjzD4o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmOKij3g4OFT2vjHtirVw93Wukb7vYghJioTnxF
 oCSYdMeoOaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZjioowAKCRAEWL7uWMY5
 RvYyD/9PL8DfWduNHmw+Y+m9V/9YiNHtFIkqzLxmcybWkzVE5ST4lhnrE3Hn8FU6TnlXNTLm+dx
 HBBGfvhYzPOQfrMfuIiEsPa62+ZW2o946w79uZBuSlawfG+0DTg72sErwBxaPI8PtyoUqwmfmzU
 ch1y9fyPdhh77DzzK9ZwFQDF564vQMVS+Q6cg8SA1hQ1+RlBLb5FX4mJBtM8z+XW9hnZG+eB4rl
 aNIRGeiNgAqH9Z1qMEIwjn6Vrdqd78AY1UkR2Bs5XFHEK71ZR8IWAhRNP9OhMMxfdKlcFehbasf
 OQPhuhbd///bOOzcAfNVr5QNyMOD5nyfo2gLmKIX4+AKN1kirul9lmQIyeL30H/sTeSAjvEyGtw
 GzALJMqyouP5CiWtRCCAwGd0bW1o8nskjnfj9ezoFIgcXQVFY7QqdcBvzObGCwCq3nbSZJujZXC
 aaZZvb0yHE5qCdWlAz7mwzH1eWXKkcxZsBSh0eC0K3/Oed+pfT47a1t4Vz/yZ3DGcjqa/KIDiup
 bZUuzkqPv9BSPfEbDWNBH+BER83aJQKqmn9r7Tzhc0Rs7TdGL3CYEJlzWGJbXtXrLG815JhnWVk
 fWKxjoAac8i5rjVqi5DhWrxGNCzhmz99JBDdYfN7W/ca6Vy3SpnnZmjWK5FgO5OVZuQFlrxfofC opaBMp7AOQrvJ/w==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240506-linked-list-v2-2-7b910840c91f@google.com>
Subject: [PATCH v2 2/9] rust: list: add tracking for ListArc
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
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
 rust/kernel/list/arc.rs | 154 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 3 deletions(-)

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
index 560ff07fe9b7..4c2e33f40597 100644
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
@@ -32,9 +33,24 @@ pub trait ListArcSafe<const ID: u64 = 0> {
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
+/// When using this macro, you may choose between the `untracked` strategy where it is not tracked
+/// whether a [`ListArc`] exists, and the `tracked_by` strategy where the tracking is deferred to a
+/// field of the struct. The `tracked_by` strategy can be combined with a field of type
+/// [`AtomicListArcTracker`] to track whether a [`ListArc`] exists.
 #[macro_export]
 macro_rules! impl_list_arc_safe {
     (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untracked; } $($rest:tt)*) => {
@@ -45,6 +61,37 @@ unsafe fn on_drop_list_arc(&self) {}
         $crate::list::impl_list_arc_safe! { $($rest)* }
     };
 
+    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty {
+        tracked_by $field:ident : $fty:ty;
+    } $($rest:tt)*) => {
+        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t {
+            unsafe fn on_create_list_arc_from_unique(self: ::core::pin::Pin<&mut Self>) {
+                // SAFETY: This field is structurally pinned.
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
+                <$fty as $crate::list::TryNewListArc<$num>>::try_new_list_arc(&self.field)
+            }
+        }
+        $crate::list::impl_list_arc_safe! { $($rest)* }
+    };
+
     () => {};
 }
 pub use impl_list_arc_safe;
@@ -180,6 +227,52 @@ pub fn pair_from_pin_unique<const ID2: u64>(
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
+            Err(arc) => Arc::into_unique_or_drop(arc).map(Self::from_pin_unique),
+        }
+    }
+
     /// Transmutes an [`Arc`] into a `ListArc` without updating the tracking inside `T`.
     ///
     /// # Safety
@@ -313,3 +406,60 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc
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
2.45.0.rc1.225.g2a3ae87e7f-goog


