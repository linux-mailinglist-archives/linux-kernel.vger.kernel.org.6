Return-Path: <linux-kernel+bounces-259745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FBF939C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C8D282CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725B14F122;
	Tue, 23 Jul 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6tcA2aR"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6214EC4E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722991; cv=none; b=TBtArVkLaNw8b8jc8NNchXrX2ImrI5EnEBKQniK6VypUyqflF5SrpBizJ4Gq+eQ+WegJQiNruNVzlUFOG1OiE5PX5jVf1TqEdTKEh/aFdbKhl2Hhy9CoxerKLszW68lwTdEbSmxVDRqH4Bj5NbXoOvgu1rBoz8KCdyqAw23DRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722991; c=relaxed/simple;
	bh=7s+2tpsrG5RKjrFDALseGw6Co5fhy0QWgnewSA23Pbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OgfZZcWz3EmoOapvNMctVFH/54eY/bNEGRf+vQchni6dU+xen6GDb+cyESqzDnyQL+CDVh/wf+SoFiCCJt/upUk0AZ61ln4J7oO/8MRpChckmjgSy8o8Xbqb6/kkTikhBI4wnb0jbUfeedfbCGN/NuVzrkFDV3MwTY6YpISCZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6tcA2aR; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ef1b9a466cso31487591fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722987; x=1722327787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPvnMxM4cw829IqByr7iX9fTi7jPKsJ659JMi5lcAVk=;
        b=W6tcA2aR1Ol6nPoDRJzf09TliXToKCMxJB26Czcb1OMibzzyk7S5PAjFRf67ts9H4M
         Lbgv0+5iajpd6BBM+oJ7tYVi8aBPWa2K+dQV5sVHldAWsJvNXLEJq00jQ+X3rZAFcNYC
         o2sDwel0aE1e/5WeutFE6r2hFaOjRxgNKCAvwzgK+RAd+XhaTAs7OXwHpD75diM39FxE
         kC2VgLFaXcrhxNEfqe76BPtrPc2zA/+sYyn2PVXVidVcVt7u65EZExErP3EtnMkz3XOz
         rMMKVD58TYQNGFZy8yLuFeEHY2tuMZJJJ3dG+AsQH1NqcwbHAkywz61/kyk/vO93C789
         tx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722987; x=1722327787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPvnMxM4cw829IqByr7iX9fTi7jPKsJ659JMi5lcAVk=;
        b=mh5GzGdCTzVhwmSbcNBfP9z63eBieiPpA8ZWi4GN2hTMJciEuCCvGd3ldPr0/ee0Dc
         DXHucYk90bInaA4d3QkMZr3EapxFbwYjrl28ZDR/iXl9P6PrfdMteUDwUc//3D9sacCa
         cLklnFV170CghmC9AmfTHnVevzrQRRx9H6vPHrCFjmTCmcoIaiOSWUYnv3+X1nDp9k+g
         F+uZnn/hI5ozEZrtBhz13iZNFqrBRr8Iovs8jd1j0toF+FHavl4yv5mpn5vd6v+vbp+6
         bic/U1C2HAwfM+Obx+0fdKlgzLevu8EHd94wYQQUoMkWaIg4co2yb4c2FYYx/frPkCaJ
         hNVA==
X-Forwarded-Encrypted: i=1; AJvYcCWHif/oA35/oduvqIwziBq6JsOaAS0kfmFnO8a1zAA8F9kcICi1P3vQip/GZtVvxYKUstfurSnOhRJKFHvuxv0isd8wwufipLAMP+NS
X-Gm-Message-State: AOJu0YwjKe1lALxTCzAy6uOYFYaOq2eEVBiSG5N5L9UIwhtTRIbOs968
	1V1SnVdofQ/BUy3/MZ+JrowreFd5xMWMsb0zGLHM2DTKx2xVev3yGKrvBszCK0C/RDhptIzD3te
	TG89nWpmRUwunsw==
X-Google-Smtp-Source: AGHT+IH2hSq+GI7fpB845GOKVHajbqaKsEZktSCAZr0VxXAu2E0CoHmD9gPZyAlaJxcNjKWgel9HY3glRzEAGkI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:8759:0:b0:2ef:2488:3a2 with SMTP id
 38308e7fff4ca-2ef2488064cmr100851fa.3.1721722986827; Tue, 23 Jul 2024
 01:23:06 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:22:06 +0000
In-Reply-To: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8193; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7s+2tpsrG5RKjrFDALseGw6Co5fhy0QWgnewSA23Pbs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn2hUhvtoTALGT9zgGFLO5O+h58IEs+USgyyN/
 rVQcrMCDHyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp9oVAAKCRAEWL7uWMY5
 RnlZEACOrUL7PmtfsI8t4NDnnp07TNFzNLwJ8lRiwLfij8uAHzVTgGcbSC5jIHgBdahGrSf9L6b
 Ery0r7C+3YME805BgFEckDVhvbUQd9Z/3PMdPXCW1DD2QIkR4NqYp8gygZJWaTilgwCbt1SiZe8
 1wsvnjV4Eeheez6y/jEayTGw7/O+YXLctN51S9arAJp8q1VOViPTEbArm19b1wGg73j+El8JPGR
 5gkbnFSX3kDuAof4wx9/NoUAQWlrpli9Bve7t8q433OJ5O20HPb/w4F1T20lj2Zvzny+k1Pw9p9
 PSMorq0ji3L/UOTOtLmFUVjZ9463Rk7e48ILg61mXavKtl8nOoeprWx3JB1XBGB8ZM4vIeS9tyk
 HqHB1cfVV/XFJDGEU5o+LiQV7NXVJrCQ1+A8UXXE89/7OBB54y0qUE0GJ+EgsErBQdwT8x/4GLT
 U6WELpUbi916tPKtnmU2qsi7xQ/CTeKPQy35uNaLYgDtU+4J2CibEJWtMgcnfm73QFnCxqXxzeY
 yIN4y5zGUBX6Pzb5mH3FL1LqbuU4yu1QvZrymZfEIwHPArKjEmAbdDscZTwHNruwlnPw8CYtR1R
 FCnRC7aSFffCLPiPyznUf6kLAVqnDxhsluczeVyQXKhyF0k3RgOrhjnmIL3YNDyMUlpTfFuKF7A kSmOUwfyMmDu1Ng==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-linked-list-v3-5-89db92c7dbf4@google.com>
Subject: [PATCH v3 05/10] rust: list: add macro for implementing ListItem
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

Adds a macro for safely implementing the ListItem trait. As part of the
implementation of the macro, we also provide a HasListLinks trait
similar to the workqueue's HasWorkItem trait.

The HasListLinks trait is only necessary if you are implementing
ListItem using the impl_list_item macro.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs                    |   3 +
 rust/kernel/list/impl_list_item_mod.rs | 139 +++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 63e6f6a47964..8fb7d2c13580 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -8,6 +8,9 @@
 use crate::types::Opaque;
 use core::ptr;
 
+mod impl_list_item_mod;
+pub use self::impl_list_item_mod::{impl_has_list_links, impl_list_item, HasListLinks};
+
 mod arc;
 pub use self::arc::{
     impl_list_arc_safe, AtomicListArcTracker, ListArc, ListArcSafe, TryNewListArc,
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
new file mode 100644
index 000000000000..9b1947371c63
--- /dev/null
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Helpers for implementing list traits safely.
+
+use crate::list::ListLinks;
+
+/// Declares that this type has a `ListLinks<ID>` field at a fixed offset.
+///
+/// This trait is only used to help implement `ListItem` safely. If `ListItem` is implemented
+/// manually, then this trait is not needed.
+///
+/// # Safety
+///
+/// All values of this type must have a `ListLinks<ID>` field at the given offset.
+///
+/// The implementation of `raw_get_list_links` must not be changed.
+pub unsafe trait HasListLinks<const ID: u64 = 0> {
+    /// The offset of the `ListLinks` field.
+    const OFFSET: usize;
+
+    /// Returns a pointer to the [`ListLinks<T, ID>`] field.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must point at a valid struct of type `Self`.
+    ///
+    /// [`ListLinks<T, ID>`]: ListLinks
+    // We don't really need this method, but it's necessary for the implementation of
+    // `impl_has_work!` to be correct.
+    #[inline]
+    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
+        // SAFETY: The caller promises that the pointer is valid. The implementer promises that the
+        // `OFFSET` constant is correct.
+        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<ID> }
+    }
+}
+
+/// Implements the [`HasListLinks`] trait for the given type.
+#[macro_export]
+macro_rules! impl_has_list_links {
+    ($(impl$(<$($implarg:ident),*>)?
+       HasListLinks$(<$id:tt>)?
+       for $self:ident $(<$($selfarg:ty),*>)?
+       { self$(.$field:ident)* }
+    )*) => {$(
+        // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
+        // right type.
+        //
+        // The implementation of `raw_get_list_links` is not changed since the `addr_of_mut!` macro
+        // is equivalent to the pointer offset operation in the trait definition.
+        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for
+            $self $(<$($selfarg),*>)?
+        {
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
+
+            #[inline]
+            unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
+                // SAFETY: The caller promises that the pointer is not dangling. We know that this
+                // expression doesn't follow any pointers, as the `offset_of!` invocation above
+                // would otherwise not compile.
+                unsafe { ::core::ptr::addr_of_mut!((*ptr)$(.$field)*) }
+            }
+        }
+    )*};
+}
+pub use impl_has_list_links;
+
+/// Implements the [`ListItem`] trait for the given type.
+///
+/// Assumes that the type implements [`HasListLinks`].
+///
+/// [`ListItem`]: crate::list::ListItem
+#[macro_export]
+macro_rules! impl_list_item {
+    (
+        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+            using ListLinks;
+        } $($rest:tt)*
+    ) => {
+        // SAFETY: See GUARANTEES comment on each method.
+        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $t {
+            // GUARANTEES:
+            // * This returns the same pointer as `prepare_to_insert` because `prepare_to_insert`
+            //   is implemented in terms of `view_links`.
+            // * By the type invariants of `ListLinks`, the `ListLinks` has two null pointers when
+            //   this value is not in a list.
+            unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
+                // SAFETY: The caller guarantees that `me` points at a valid value of type `Self`.
+                unsafe {
+                    <Self as $crate::list::HasListLinks<$num>>::raw_get_list_links(me.cast_mut())
+                }
+            }
+
+            // GUARANTEES:
+            // * `me` originates from the most recent call to `prepare_to_insert`, which just added
+            //   `offset` to the pointer passed to `prepare_to_insert`. This method subtracts
+            //   `offset` from `me` so it returns the pointer originally passed to
+            //   `prepare_to_insert`.
+            // * The pointer remains valid until the next call to `post_remove` because the caller
+            //   of the most recent call to `prepare_to_insert` promised to retain ownership of the
+            //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
+            //   be destroyed while a `ListArc` reference exists.
+            unsafe fn view_value(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
+                let offset = <Self as $crate::list::HasListLinks<$num>>::OFFSET;
+                // SAFETY: `me` originates from the most recent call to `prepare_to_insert`, so it
+                // points at the field at offset `offset` in a value of type `Self`. Thus,
+                // subtracting `offset` from `me` is still in-bounds of the allocation.
+                unsafe { (me as *const u8).sub(offset) as *const Self }
+            }
+
+            // GUARANTEES:
+            // This implementation of `ListItem` will not give out exclusive access to the same
+            // `ListLinks` several times because calls to `prepare_to_insert` and `post_remove`
+            // must alternate and exclusive access is given up when `post_remove` is called.
+            //
+            // Other invocations of `impl_list_item!` also cannot give out exclusive access to the
+            // same `ListLinks` because you can only implement `ListItem` once for each value of
+            // `ID`, and the `ListLinks` fields only work with the specified `ID`.
+            unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
+                // SAFETY: The caller promises that `me` points at a valid value.
+                unsafe { <Self as $crate::list::ListItem<$num>>::view_links(me) }
+            }
+
+            // GUARANTEES:
+            // The first guarantee of `view_value` is exactly what `post_remove` guarantees.
+            unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
+                // SAFETY: This violates the safety requirement that `post_remove` has not been
+                // called since the most recent call to `prepare_to_insert`, but that is okay
+                // because the concrete implementation of `view_value` above does not rely on that
+                // requirement anywhere except for its second guarantee, and we don't need its
+                // second guarantee.
+                unsafe { <Self as $crate::list::ListItem<$num>>::view_value(me) }
+            }
+        }
+    };
+}
+pub use impl_list_item;

-- 
2.45.2.1089.g2a221341d9-goog


