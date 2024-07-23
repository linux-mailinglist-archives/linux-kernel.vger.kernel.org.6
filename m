Return-Path: <linux-kernel+bounces-259741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D0939C87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA6BB22882
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240114BF8A;
	Tue, 23 Jul 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhxu9ZOD"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0314D2BF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722981; cv=none; b=A2AhW0732YHTPPo0Afng4T+FjPmppOONJX7fhl05nJh27Yg56A6Gu6co0t038HFeoou630Fy4ztsqF16AxcVjWuMOVHUJA+wQop4AgEUIzE8+cfgqjUIJ2rsIFxJqD6XSNLxE8zNEuTT4UTGSvwgfyiTJQ+ByW1vlh3bx9dEV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722981; c=relaxed/simple;
	bh=7QBxj3G7eNnMrpH1QwSGuLbaH+rnOpkyLTVPVID9iqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RQ9lwj2w8CYfKFF7ACYdCIY/yz+97eQE+3bzTTaqLzfZpzm/zZBV3IysjWoPsV1Pel1gz5673M2hXzxpUZMMZukQflNLwwq/M7Q57NZf8DBeMDhr30nUfhKvP5mITOku65NqrufiBdKt4wR2geJFjgjI5a8ISrr6mtENLjuG+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhxu9ZOD; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ef286cf0e8so23517001fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722978; x=1722327778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLYAKBvuWpY5x5DnpD4W5b5CYD2QiwkREiBpRLQtnks=;
        b=bhxu9ZOD/yzGSZK/EeKgRQNRbU2EjwrfM02JWwsS8ahHU6qNVjEEw3hPDP+5tXWDTk
         /SHtbtN7bpSAxpPD1wyONSu/bI14pQpRAPlaTPVMTLxO+eVX3Gu6eDA2NGRCnQmYdjq6
         kBmUWYUOZBIiwLo96dvS/RDpceynw/Gl+qgq9X3TSbbVlCvALOsU3k4jXnFK81mwPDMb
         4hmmkWFhu0hClu93qINaEhKvpw06WRebROidkbPpgMFL6jdpXD2Xa+I4Sh2vQ8YL2m2Q
         na2oaA7B2zXJ5Z3TEISKW4qhs50/1fVs1BL1LQZkuDiHyUpM+sgHNHoFQcM52wHGqZ6+
         gFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722978; x=1722327778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLYAKBvuWpY5x5DnpD4W5b5CYD2QiwkREiBpRLQtnks=;
        b=jPxA03hLIcPcaqIkBw6ZwbVNKLe+FAlENnJc0TNEzr/BIEP07zyGfcWQWpp6DBt92a
         oXEg117P5c60HuwvgHja1r6kvQNqwPRkyVh71vpdnkb03IEfI0P5dt2nQmlp5qt0OpIv
         RV/dxIdrbWXF1ZaY4dqbEIXxZR3TsR3Nr0J/RuLxvko5fq6VpWG5hs0WawncrxigTD9v
         QjtvecTWCVnXQHX7vrlkUv3wKqxxN8F0zjKLLjcZkO1j4nXsaTCOGtB2QszArZyzY83R
         hf8pGoaSKH847BGeJ+xk3dZuhHw/ATLiUGmVhXXukS4rHldzPskYaDE7itqv1VyhDsro
         yFeg==
X-Forwarded-Encrypted: i=1; AJvYcCW/VuswpzRIdI5xiKwQ497UouScmHk+oSJt/yLmGReEi94jT6ziSZsTDl17fHNvbHX87j0aUle0VSSekRfXrWpGZSPzfrSoskupgiyx
X-Gm-Message-State: AOJu0Yw8uqw3IBIlPHhh7ZbKe2DkjjudYnDh0rdAJ7yVd3jA7riiUt5W
	dDk150mJ9sQh0gvJMCjefFUisIzPwZPc3kpOeo8M7TPczyJ467dObGgckin/JTkiZ9eHS8mYymr
	otLaQMGEMzA4gXA==
X-Google-Smtp-Source: AGHT+IEO8SpdGUGkTq9ihGkB+gkwtcZg628hiSP5ggAEz7lfi0uu/C9yBYi6hwcIZUK/XMCX8KNa6yz+Hw5hkVY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9611:0:b0:2ef:2217:4fce with SMTP id
 38308e7fff4ca-2ef221750c3mr102991fa.8.1721722977599; Tue, 23 Jul 2024
 01:22:57 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:22:03 +0000
In-Reply-To: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=17666; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7QBxj3G7eNnMrpH1QwSGuLbaH+rnOpkyLTVPVID9iqk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn2hS81+hrsThMQhRbzpZBXuSAvobPcGgINWoa
 zN0Z3KCqNqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp9oUgAKCRAEWL7uWMY5
 Ro/+D/9HDwwzSvrT+5Kqj84VufeAL6EjAQmE/OLhhlRMtD7OfLzlMnKSoaNzuWYM3zn8ZOBVmKS
 e8uWn32DXFKnLpOk+Z7vYIjCrTl1sgJJqzqc2Y0tPbP/p87+QtAOgQgFai5iUaNrd1Ier5MZ+lV
 nMflp/VeH5DiLQVvaVvZw352gby5y3cMSsuY6MrsUDoeLDign5Ft55Jo7XBVNBeZOEmbO02LpNZ
 KcX3Op2lgb98PQWv1Yd3Q43vFwytHnVCdAItaf+VeDAMft0+BSPHZ3hVBGdehEV5P9JW/OawJZu
 PIUU0S/o5WCgCBcMkVZPN5ZEwnQlOWfS3IfK/dw4CSwIJj0lCT+cQ/9S6SNuxHU6NBnNUlVBfHO
 tNMEQTFHlat91pc1z1pkQsJHPGMdosa319H8dJeZm6o4+nU7jUuiY7b+H0OD+vHdSk4C58rrE5a
 zR9v9EQvY+c7rTbmQjwrbVac2Kx1SCY9hmOfLIKrbu5ZqaBZ6m59iuLgksgcm8euEJrsptVDl4g
 1KuwbRAv4uNqGjp4F6UD3vQR5foOgWrC1zCnJXlLNzXRBO+MDzAq0Pk+YNhPcPPXwS4SRQeB8+L
 qiPk3DDcNglM44Z4GMpOxAs7TeWLdLWwNVMQ+Oc4+Q6zFcqHgjorIg7ksU8Q/1g6FAfjW9RYJ3u XtXKOBCuh+hXcuw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-linked-list-v3-2-89db92c7dbf4@google.com>
Subject: [PATCH v3 02/10] rust: list: add ListArc
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
 rust/kernel/list/arc.rs | 348 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 5d310e79485f..662bf6ebb770 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -33,6 +33,7 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod list;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
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
index 000000000000..3b7072e58256
--- /dev/null
+++ b/rust/kernel/list/arc.rs
@@ -0,0 +1,348 @@
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
+///
+/// Types that implement this trait should include some kind of logic for keeping track of whether
+/// a [`ListArc`] exists or not. We refer to this logic as "the tracking inside `T`".
+///
+/// We allow the case where the tracking inside `T` thinks that a [`ListArc`] exists, but actually,
+/// there isn't a [`ListArc`]. However, we do not allow the opposite situation where a [`ListArc`]
+/// exists, but the tracking thinks it doesn't. This is because the former can at most result in us
+/// failing to create a [`ListArc`] when the operation could succeed, whereas the latter can result
+/// in the creation of two [`ListArc`] references.
+///
+/// A consequence of the above is that you may implement the tracking inside `T` by not actually
+/// keeping track of anything. To do this, you always claim that a [`ListArc`] exists, even if
+/// there isn't one. This implementation is allowed by the above rule, but it means that
+/// [`ListArc`] references can only be created if you have ownership of *all* references to the
+/// refcounted object, as you otherwise have no way of knowing whether a [`ListArc`] exists.
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
+        Ok(Self::from(UniqueArc::new(contents, flags)?))
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
+        Ok(Self::from(UniqueArc::try_pin_init(init, flags)?))
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
+        Ok(Self::from(UniqueArc::try_init(init, flags)?))
+    }
+}
+
+impl<T, const ID: u64> From<UniqueArc<T>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    /// Convert a [`UniqueArc`] into a [`ListArc`].
+    #[inline]
+    fn from(unique: UniqueArc<T>) -> Self {
+        Self::from(Pin::from(unique))
+    }
+}
+
+impl<T, const ID: u64> From<Pin<UniqueArc<T>>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    /// Convert a pinned [`UniqueArc`] into a [`ListArc`].
+    #[inline]
+    fn from(mut unique: Pin<UniqueArc<T>>) -> Self {
+        // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.
+        unsafe { T::on_create_list_arc_from_unique(unique.as_mut()) };
+        let arc = Arc::from(unique);
+        // SAFETY: We just called `on_create_list_arc_from_unique` on an arc without a `ListArc`,
+        // so we can create a `ListArc`.
+        unsafe { Self::transmute_from_arc(arc) }
+    }
+}
+
+impl<T, const ID: u64> ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    /// Creates two `ListArc`s from a [`UniqueArc`].
+    ///
+    /// The two ids must be different.
+    #[inline]
+    pub fn pair_from_unique<const ID2: u64>(unique: UniqueArc<T>) -> (Self, ListArc<T, ID2>)
+    where
+        T: ListArcSafe<ID2>,
+    {
+        Self::pair_from_pin_unique(Pin::from(unique))
+    }
+
+    /// Creates two `ListArc`s from a pinned [`UniqueArc`].
+    ///
+    /// The two ids must be different.
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
+        // Use a transmute to skip destructor.
+        //
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
+impl<T, const ID: u64> AsRef<Arc<T>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    #[inline]
+    fn as_ref(&self) -> &Arc<T> {
+        self.as_arc()
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
2.45.2.1089.g2a221341d9-goog


