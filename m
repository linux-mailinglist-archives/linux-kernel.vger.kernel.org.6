Return-Path: <linux-kernel+bounces-169620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E428BCB4A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E89F284B57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14548142E93;
	Mon,  6 May 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sV8frdUW"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AC142E80
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989233; cv=none; b=qvtzbA/GOI6S5JvaFrXIPZI/sPznPgF7BkCvzf25A7z0cBmB58MjN1/Xz0kQLHJfAqqbLm2pizOfG+Omhe94uYOClV5dQc3jiq0BFriYX8K+syee6EbMhQSZZ4/VKgMCU6hg5YgcNaeJDQtqOt2Xxpn2E+n0/7Y3dwzdkQTbD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989233; c=relaxed/simple;
	bh=vHnMYoARsaSwT4DBkFiei47dRFIRkgVi3GBnqZ7Fb1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cRdHI9EBZ74+bouLeG80MND1TArvrS5k9dZM0yFLARRgiWwe0Uh+67C8Bp5DmjjDXzCzwogTdtCobIYWKpaP/6B9U+Z8A4iSSdKiYr60YVuExrmXfAeouXFy34OTdKPm8essFegQY4rmz45tmtvUkIGiz+2hIaAwi8y2a7RiXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sV8frdUW; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2e1f38cb631so17535601fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714989229; x=1715594029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvEL2vDi6KBnvXakxenmg+ioXoslEEuGEzVw09QDssg=;
        b=sV8frdUWghkhT9OtYi5oVlclWG4DKg+bph/aJQ9D1PeXreXyvBqeCwUlUxObLq+jNN
         ubXE/0YWXTkRayTO7pyoAWFB+d0u0j2SD5CEzkHAOHzQR5XRU8/WfkvL/ldAgOIf/pN1
         bMhCZ/u9Vz9ONPwwV1fIMrmOFR+4EQYF0FXnuq1tYFO5d+fvcVn9n2L1qk9akoJbJK4I
         qc30CR3Cw1zY3Uhe1iMJMe0DzRMSEr2ag/eZ/Z++et/PCnT1fp06XbPRDxa2/0y8FLok
         USKFNru8XphnNfsu//VA/oiripVkntGdTMekNTfJtjRze64cgpFJvE+OuVUZIa7mhajv
         c/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989229; x=1715594029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvEL2vDi6KBnvXakxenmg+ioXoslEEuGEzVw09QDssg=;
        b=irrRu5OpiiNTeg08RGulcElZZ9rE/KpZYO7qGl1gRSrU2AoZsGh/3IbBUxX1XAhmxY
         mxr354GYKUwLnJ6vlo/VSVRcNmO1cbhgpwpxwQKUWKMnKPN51bahrlH+nQMPfnRvOAv+
         oJ7Q+VsiUbXqKlEuxz0KxSiHK6+joNg3RfMmvyBTU8MHWaZixc+VSTFCrd3W2RuX6D9U
         aghMJcWfHr7uXg/lGO5hSP6bVXAzamb3ORiGOmkYwK9qXfcOVtuoUc8jFXb3GcOIOncK
         Xb/tsXANo9G+252YXeqvfLgjb7Y1UqNWk7KUHQQpduMNr6PgLrxMs0PJb0EeLk9phFjW
         CgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaUbvJyWVfC+03cEeGYQYdXaR8VaB37NBMBfAvAmzpBJFNLn97fUXdHzkQt3W9nuHBym1WxOsI2dmou+JASWkO3HWKycwjBsUBtP6s
X-Gm-Message-State: AOJu0YxsdU+07b2za/HGE11feINZFPrnF0Ak2T8FwMLFS8rZcK/sFMF7
	UChHzMVbjvoh1Ten0M/yb/lHOc9KoT/LHq5mywMDanoPSiXty+B9HkgbTXLp/CTywkrUQupI36c
	rzHzaUIUGUFSbKA==
X-Google-Smtp-Source: AGHT+IE/oSzVgMcC4kNH2suZnzNw5/b25lli3XqL0pN4PbmbDnGAC3sRdslzfO4l49/NkAHW6PR9czmnLadXzC4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:5f5a:0:b0:51c:f898:60c7 with SMTP id
 26-20020ac25f5a000000b0051cf89860c7mr9433lfz.2.1714989229548; Mon, 06 May
 2024 02:53:49 -0700 (PDT)
Date: Mon, 06 May 2024 09:53:22 +0000
In-Reply-To: <20240506-linked-list-v2-0-7b910840c91f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506-linked-list-v2-0-7b910840c91f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=16225; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=vHnMYoARsaSwT4DBkFiei47dRFIRkgVi3GBnqZ7Fb1o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmOKii9/z6QHpyaVxFSspJkvrMaPZ96AW1Gljrv
 9wCTEpUG26JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZjioogAKCRAEWL7uWMY5
 RjjnEAC6QgXCJfcFEPJXzUmNrSQ1qzDpfSmQGgwDSt+dPpsh+fZHv3cqPjj8da8nqSvCrcl4bnD
 h/eHUGG0wToYyditiT7C5Yz7sVVmuzjxMjLsYMkHyseLHx4QH1G6MFkEhLiTMTJ1vegz/ekBfMC
 zSkQ3KK90ix/BWWjsnT+AGWR3spr/td+DF1Rwy3Q0qYScbh48Dg5+s9qWCkCZvoN8FGDSujeCQ2
 cJLHvCMb+jtJSD6Oh9Rj+YNSaCanyVo66w9KzIb4fozuKEcbGlhPgcYZdh3E7UxnHrGd77Z1xDp
 0W3sHxc4wzhPhyymyZW71vgMczveXWrQJe+wuI522qGPR7FmNfc9a7fBFt4Zm6hdQzuadcVYQM2
 eKlTgE3a0raDADTRWC5wnFkTb3O1L9rX8UNbujo2ok4VwFg7YBVagoYoJ8vN2ktrQe1ncVCpR7I
 SBYsRfD587lfXubbRDHELeL7cSwlI4m+kPTDYX41Xhn8zZiQHSV6YtySsvmG1IqUydi24pBdhg/
 dnzTg/rdunBO7Cu29SuOs78N/Vdn2C27sjXDd90AO9LM8WUJV0AP/QDIoi/yUyIJyGPwJ6yhy97
 B0rAFj55Bf9ovMZTIQnera3OWdUrJZDkxloljG1Vm3Mb88zkG44CfZ4CP3SsNmFkqxEAEmMiojZ MH6Rx5Q+2o3wQOg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240506-linked-list-v2-1-7b910840c91f@google.com>
Subject: [PATCH v2 1/9] rust: list: add ListArc
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

The `ListArc` type can be thought of as a special reference to a
refcounted object that owns the permission to manipulate the
`next`/`prev` pointers stored in the refcounted object. By ensuring that
each object has only one `ListArc` reference, the owner of that
reference is assured exclusive access to the `next`/`prev` pointers.
When a `ListArc` is inserted into a `List`, the `List` takes ownership
of the `ListArc` reference.

There are various strategies for ensuring that a value has only one
`ListArc` reference. The simplest is to convert a `UniqueArc` into a
`ListArc`. However, the refcounted object could also keep track of
whether a `ListArc` exists using a boolean, which could allow for the
creation of new `ListArc` references from an `Arc` reference. Whatever
strategy is used, the relevant tracking is referred to as "the tracking
inside `T`", and the `ListArcSafe` trait (and its subtraits) are used to
update the tracking when a `ListArc` is created or destroyed.

Note that we allow the case where the tracking inside `T` thinks that a
`ListArc` exists, but actually, there isn't a `ListArc`. However, we do
not allow the opposite situation where a `ListArc` exists, but the
tracking thinks it doesn't. This is because the former can at most
result in us failing to create a `ListArc` when the operation could
succeed, whereas the latter can result in the creation of two `ListArc`
references.

This patch introduces the `impl_list_arc_safe!` macro that allows you to
implement `ListArcSafe` for types using the strategy where a `ListArc`
can only be created from a `UniqueArc`. Other strategies are introduced
in later patches.

This is part of the linked list that Rust Binder will use for many
different things. The strategy where a `ListArc` can only be created
from a `UniqueArc` is actually sufficient for most of the objects that
Rust Binder needs to insert into linked lists. Usually, these are todo
items that are created and then immediately inserted into a queue.

The const generic ID allows objects to have several prev/next pointer
pairs so that the same object can be inserted into several different
lists. You are able to have several `ListArc` references as long as they
correspond to different pointer pairs. The ID itself is purely a
compile-time concept and will not be present in the final binary. Both
the `List` and the `ListArc` will need to agree on the ID for them to
work together. Rust Binder uses this in a few places (e.g. death
recipients) where the same object can be inserted into both generic todo
lists and some other lists for tracking the status of the object.

The ID is a const generic rather than a type parameter because the
`pair_from_unique` method needs to be able to assert that the two ids
are different. There's no easy way to assert that when using types
instead of integers.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs      |   1 +
 rust/kernel/list.rs     |   8 ++
 rust/kernel/list/arc.rs | 315 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 324 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9a943d99c71a..51d007e031b2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -33,6 +33,7 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod list;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod prelude;
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
new file mode 100644
index 000000000000..fb16ea43b2ba
--- /dev/null
+++ b/rust/kernel/list.rs
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! A linked list implementation.
+
+mod arc;
+pub use self::arc::{impl_list_arc_safe, ListArc, ListArcSafe};
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
new file mode 100644
index 000000000000..560ff07fe9b7
--- /dev/null
+++ b/rust/kernel/list/arc.rs
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! A wrapper around `Arc` for linked lists.
+
+use crate::alloc::{AllocError, Flags};
+use crate::prelude::*;
+use crate::sync::{Arc, ArcBorrow, UniqueArc};
+use core::marker::Unsize;
+use core::ops::Deref;
+use core::pin::Pin;
+
+/// Declares that this type has some way to ensure that there is exactly one `ListArc` instance for
+/// this id.
+pub trait ListArcSafe<const ID: u64 = 0> {
+    /// Informs the tracking inside this type that it now has a [`ListArc`] reference.
+    ///
+    /// This method may be called even if the tracking inside this type thinks that a `ListArc`
+    /// reference exists. (But only if that's not actually the case.)
+    ///
+    /// # Safety
+    ///
+    /// Must not be called if a [`ListArc`] already exist for this value.
+    unsafe fn on_create_list_arc_from_unique(self: Pin<&mut Self>);
+
+    /// Informs the tracking inside this type that there is no [`ListArc`] reference anymore.
+    ///
+    /// # Safety
+    ///
+    /// Must only be called if there is no [`ListArc`] reference, but the tracking thinks there is.
+    unsafe fn on_drop_list_arc(&self);
+}
+
+/// Declares that this type supports [`ListArc`].
+///
+/// When using this macro, it will only be possible to create a [`ListArc`] from a [`UniqueArc`].
+#[macro_export]
+macro_rules! impl_list_arc_safe {
+    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untracked; } $($rest:tt)*) => {
+        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t {
+            unsafe fn on_create_list_arc_from_unique(self: ::core::pin::Pin<&mut Self>) {}
+            unsafe fn on_drop_list_arc(&self) {}
+        }
+        $crate::list::impl_list_arc_safe! { $($rest)* }
+    };
+
+    () => {};
+}
+pub use impl_list_arc_safe;
+
+/// A wrapper around [`Arc`] that's guaranteed unique for the given id.
+///
+/// The `ListArc` type can be thought of as a special reference to a refcounted object that owns the
+/// permission to manipulate the `next`/`prev` pointers stored in the refcounted object. By ensuring
+/// that each object has only one `ListArc` reference, the owner of that reference is assured
+/// exclusive access to the `next`/`prev` pointers. When a `ListArc` is inserted into a `List`, the
+/// `List` takes ownership of the `ListArc` reference.
+///
+/// There are various strategies to ensuring that a value has only one `ListArc` reference. The
+/// simplest is to convert a [`UniqueArc`] into a `ListArc`. However, the refcounted object could
+/// also keep track of whether a `ListArc` exists using a boolean, which could allow for the
+/// creation of new `ListArc` references from an [`Arc`] reference. Whatever strategy is used, the
+/// relevant tracking is referred to as "the tracking inside `T`", and the [`ListArcSafe`] trait
+/// (and its subtraits) are used to update the tracking when a `ListArc` is created or destroyed.
+///
+/// Note that we allow the case where the tracking inside `T` thinks that a `ListArc` exists, but
+/// actually, there isn't a `ListArc`. However, we do not allow the opposite situation where a
+/// `ListArc` exists, but the tracking thinks it doesn't. This is because the former can at most
+/// result in us failing to create a `ListArc` when the operation could succeed, whereas the latter
+/// can result in the creation of two `ListArc` references.
+///
+/// # Invariants
+///
+/// * Each reference counted object has at most one `ListArc` for each value of `ID`.
+/// * The tracking inside `T` is aware that a `ListArc` reference exists.
+#[repr(transparent)]
+pub struct ListArc<T, const ID: u64 = 0>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    arc: Arc<T>,
+}
+
+impl<T: ListArcSafe<ID>, const ID: u64> ListArc<T, ID> {
+    /// Constructs a new reference counted instance of `T`.
+    #[inline]
+    pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self::from_unique(UniqueArc::new(contents, flags)?))
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    // We don't implement `InPlaceInit` because `ListArc` is implicitly pinned. This is similar to
+    // what we do for `Arc`.
+    #[inline]
+    pub fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        Ok(Self::from_pin_unique(UniqueArc::try_pin_init(init, flags)?))
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// This is equivalent to [`ListArc<T>::pin_init`], since a [`ListArc`] is always pinned.
+    #[inline]
+    pub fn init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        Ok(Self::from_unique(UniqueArc::try_init(init, flags)?))
+    }
+}
+
+impl<T, const ID: u64> ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    /// Convert a [`UniqueArc`] into a [`ListArc`].
+    #[inline]
+    pub fn from_unique(unique: UniqueArc<T>) -> Self {
+        Self::from_pin_unique(Pin::from(unique))
+    }
+
+    /// Convert a pinned [`UniqueArc`] into a [`ListArc`].
+    #[inline]
+    pub fn from_pin_unique(mut unique: Pin<UniqueArc<T>>) -> Self {
+        // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.
+        unsafe { T::on_create_list_arc_from_unique(unique.as_mut()) };
+        let arc = Arc::from(unique);
+        // SAFETY: We just called `on_create_list_arc_from_unique` on an arc without a `ListArc`,
+        // so we can create a `ListArc`.
+        unsafe { Self::transmute_from_arc(arc) }
+    }
+
+    /// Like [`from_unique`], but creates two `ListArcs`.
+    ///
+    /// The two ids must be different.
+    ///
+    /// [`from_unique`]: ListArc::from_unique
+    #[inline]
+    pub fn pair_from_unique<const ID2: u64>(unique: UniqueArc<T>) -> (Self, ListArc<T, ID2>)
+    where
+        T: ListArcSafe<ID2>,
+    {
+        Self::pair_from_pin_unique(Pin::from(unique))
+    }
+
+    /// Like [`pair_from_unique`], but uses a pinned arc.
+    ///
+    /// The two ids must be different.
+    ///
+    /// [`pair_from_unique`]: ListArc::pair_from_unique
+    #[inline]
+    pub fn pair_from_pin_unique<const ID2: u64>(
+        mut unique: Pin<UniqueArc<T>>,
+    ) -> (Self, ListArc<T, ID2>)
+    where
+        T: ListArcSafe<ID2>,
+    {
+        build_assert!(ID != ID2);
+
+        // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.
+        unsafe { <T as ListArcSafe<ID>>::on_create_list_arc_from_unique(unique.as_mut()) };
+        // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.
+        unsafe { <T as ListArcSafe<ID2>>::on_create_list_arc_from_unique(unique.as_mut()) };
+
+        let arc1 = Arc::from(unique);
+        let arc2 = Arc::clone(&arc1);
+
+        // SAFETY: We just called `on_create_list_arc_from_unique` on an arc without a `ListArc`
+        // for both IDs (which are different), so we can create two `ListArc`s.
+        unsafe {
+            (
+                Self::transmute_from_arc(arc1),
+                ListArc::transmute_from_arc(arc2),
+            )
+        }
+    }
+
+    /// Transmutes an [`Arc`] into a `ListArc` without updating the tracking inside `T`.
+    ///
+    /// # Safety
+    ///
+    /// * The value must not already have a `ListArc` reference.
+    /// * The tracking inside `T` must think that there is a `ListArc` reference.
+    #[inline]
+    unsafe fn transmute_from_arc(arc: Arc<T>) -> Self {
+        // INVARIANT: By the safety requirements, the invariants on `ListArc` are satisfied.
+        Self { arc }
+    }
+
+    /// Transmutes a `ListArc` into an [`Arc`] without updating the tracking inside `T`.
+    ///
+    /// After this call, the tracking inside `T` will still think that there is a `ListArc`
+    /// reference.
+    #[inline]
+    fn transmute_to_arc(self) -> Arc<T> {
+        // SAFETY: ListArc is repr(transparent).
+        unsafe { core::mem::transmute(self) }
+    }
+
+    /// Convert ownership of this `ListArc` into a raw pointer.
+    ///
+    /// The returned pointer is indistinguishable from pointers returned by [`Arc::into_raw`]. The
+    /// tracking inside `T` will still think that a `ListArc` exists after this call.
+    #[inline]
+    pub fn into_raw(self) -> *const T {
+        Arc::into_raw(Self::transmute_to_arc(self))
+    }
+
+    /// Take ownership of the `ListArc` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` must satisfy the safety requirements of [`Arc::from_raw`].
+    /// * The value must not already have a `ListArc` reference.
+    /// * The tracking inside `T` must think that there is a `ListArc` reference.
+    #[inline]
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY: The pointer satisfies the safety requirements for `Arc::from_raw`.
+        let arc = unsafe { Arc::from_raw(ptr) };
+        // SAFETY: The value doesn't already have a `ListArc` reference, but the tracking thinks it
+        // does.
+        unsafe { Self::transmute_from_arc(arc) }
+    }
+
+    /// Converts the `ListArc` into an [`Arc`].
+    #[inline]
+    pub fn into_arc(self) -> Arc<T> {
+        let arc = Self::transmute_to_arc(self);
+        // SAFETY: There is no longer a `ListArc`, but the tracking thinks there is.
+        unsafe { T::on_drop_list_arc(&arc) };
+        arc
+    }
+
+    /// Clone a `ListArc` into an [`Arc`].
+    #[inline]
+    pub fn clone_arc(&self) -> Arc<T> {
+        self.arc.clone()
+    }
+
+    /// Returns a reference to an [`Arc`] from the given [`ListArc`].
+    ///
+    /// This is useful when the argument of a function call is an [`&Arc`] (e.g., in a method
+    /// receiver), but we have a [`ListArc`] instead.
+    ///
+    /// [`&Arc`]: Arc
+    #[inline]
+    pub fn as_arc(&self) -> &Arc<T> {
+        &self.arc
+    }
+
+    /// Returns an [`ArcBorrow`] from the given [`ListArc`].
+    ///
+    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
+    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
+    #[inline]
+    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
+        self.arc.as_arc_borrow()
+    }
+
+    /// Compare whether two [`ListArc`] pointers reference the same underlying object.
+    #[inline]
+    pub fn ptr_eq(this: &Self, other: &Self) -> bool {
+        Arc::ptr_eq(&this.arc, &other.arc)
+    }
+}
+
+impl<T, const ID: u64> Deref for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.arc.deref()
+    }
+}
+
+impl<T, const ID: u64> Drop for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: There is no longer a `ListArc`, but the tracking thinks there is by the type
+        // invariants on `Self`.
+        unsafe { T::on_drop_list_arc(&self.arc) };
+    }
+}
+
+// This is to allow [`ListArc`] (and variants) to be used as the type of `self`.
+impl<T, const ID: u64> core::ops::Receiver for ListArc<T, ID> where T: ListArcSafe<ID> + ?Sized {}
+
+// This is to allow coercion from `ListArc<T>` to `ListArc<U>` if `T` can be converted to the
+// dynamically-sized type (DST) `U`.
+impl<T, U, const ID: u64> core::ops::CoerceUnsized<ListArc<U, ID>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
+    U: ListArcSafe<ID> + ?Sized,
+{
+}
+
+// This is to allow `ListArc<U>` to be dispatched on when `ListArc<T>` can be coerced into
+// `ListArc<U>`.
+impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
+    U: ListArcSafe<ID> + ?Sized,
+{
+}

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


