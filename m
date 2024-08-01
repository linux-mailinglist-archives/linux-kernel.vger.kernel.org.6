Return-Path: <linux-kernel+bounces-270014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E14943A02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70427B22B48
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948452F32;
	Thu,  1 Aug 2024 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnKAY9mZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C24A31;
	Thu,  1 Aug 2024 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470856; cv=none; b=squCywua7m9Ut31tM71drTIoMYLf6ozSz6/Dcj4uC5xGtFhGUn2o/02gOhKxrfpojdtWdpAAok9AoBzMLRxeGO0d1gzB/gs8C3jX0jCRDO7oiFAs6oEEndwcoM8o9rrqtiz+V1ZShtniuaAiJDYcrwGTgbsqD3VvXh0PACa51Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470856; c=relaxed/simple;
	bh=5FSlmk8uiC802CZQ4+q6oRgODjrvttEYMjmd4A1Q0DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XROG/2tUBn5f9Ym1sYTA0hXCFtBTuXsECe2ZeVeZ2HkH4afTIoTBB1NcJqiUDrZv1brJlDD1UHXrh+Zs7NM8prPicTVlHFSJ6dSmlyXy7xxdzX2WFcyAd9kITEsHrhCWcA9q2a648FPOAJ+XMmnZF3guYyJAJGfqazv7+E5FUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnKAY9mZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BCCC32786;
	Thu,  1 Aug 2024 00:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470856;
	bh=5FSlmk8uiC802CZQ4+q6oRgODjrvttEYMjmd4A1Q0DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnKAY9mZbcsCbF9DQaUa7rRNVkMDSwbsrxRFtaDrjtQt3Z/cIgbs1zut+BbliJAdK
	 02zGAuUF/fWyyxTRKQsHtznT6ozKJVeCvoW6+EVV5DfMN/BsmrXoW8MDT4rnA6yBHa
	 /xgrWKbCzvTKFyWD5m8918wkQETNmEB/b782b6+QRu1BaCATYSzYyk6WxBBcOYirm6
	 Nh09pNPRyA8MaYDBRunWAOM1xS0zxtrXTYOQ8xxgNDWI3Nii4kDZsDh38BsVlJmtMW
	 wMRyTscpofeJMM43u+vrlx/0ibjWjkfqt0hOGPoqEyR1vFiX/wae3AYVEDy9JjsDw+
	 S2pfumYJIRWCA==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 08/25] rust: types: implement `Unique<T>`
Date: Thu,  1 Aug 2024 02:02:07 +0200
Message-ID: <20240801000641.1882-9-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801000641.1882-1-dakr@kernel.org>
References: <20240801000641.1882-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the `Unique` type as a prerequisite for `Box` and `Vec`
introduced in subsequent patches.

`Unique` serves as wrapper around a `NonNull`, but indicates that the
possessor of this wrapper owns the referent.

This type already exists in Rust's core library, but, unfortunately, is
exposed as unstable API and hence shouldn't be used in the kernel.

This implementation of `Unique` is almost identical, but mostly stripped
down to the functionality we need for `Box` and `Vec`. Additionally, all
unstable features are removed and / or replaced by stable ones.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/types.rs | 183 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index bd189d646adb..7cf89067b5fc 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -473,3 +473,186 @@ unsafe impl AsBytes for str {}
 // does not have any uninitialized portions either.
 unsafe impl<T: AsBytes> AsBytes for [T] {}
 unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
+
+/// A wrapper around a raw non-null `*mut T` that indicates that the possessor
+/// of this wrapper owns the referent. Useful for building abstractions like
+/// `Box<T>`, `Vec<T>`, `String`, and `HashMap<K, V>`.
+///
+/// Unlike `*mut T`, `Unique<T>` behaves "as if" it were an instance of `T`.
+/// It implements `Send`/`Sync` if `T` is `Send`/`Sync`. It also implies
+/// the kind of strong aliasing guarantees an instance of `T` can expect:
+/// the referent of the pointer should not be modified without a unique path to
+/// its owning Unique.
+///
+/// If you're uncertain of whether it's correct to use `Unique` for your purposes,
+/// consider using `NonNull`, which has weaker semantics.
+///
+/// Unlike `*mut T`, the pointer must always be non-null, even if the pointer
+/// is never dereferenced. This is so that enums may use this forbidden value
+/// as a discriminant -- `Option<Unique<T>>` has the same size as `Unique<T>`.
+/// However the pointer may still dangle if it isn't dereferenced.
+///
+/// Unlike `*mut T`, `Unique<T>` is covariant over `T`. This should always be correct
+/// for any type which upholds Unique's aliasing requirements.
+#[repr(transparent)]
+pub struct Unique<T: ?Sized> {
+    pointer: NonNull<T>,
+    // NOTE: this marker has no consequences for variance, but is necessary
+    // for dropck to understand that we logically own a `T`.
+    //
+    // For details, see:
+    // https://github.com/rust-lang/rfcs/blob/master/text/0769-sound-generic-drop.md#phantom-data
+    _marker: PhantomData<T>,
+}
+
+/// `Unique` pointers are `Send` if `T` is `Send` because the data they
+/// reference is unaliased. Note that this aliasing invariant is
+/// unenforced by the type system; the abstraction using the
+/// `Unique` must enforce it.
+unsafe impl<T: Send + ?Sized> Send for Unique<T> {}
+
+/// `Unique` pointers are `Sync` if `T` is `Sync` because the data they
+/// reference is unaliased. Note that this aliasing invariant is
+/// unenforced by the type system; the abstraction using the
+/// `Unique` must enforce it.
+unsafe impl<T: Sync + ?Sized> Sync for Unique<T> {}
+
+impl<T: Sized> Unique<T> {
+    /// Creates a new `Unique` that is dangling, but well-aligned.
+    ///
+    /// This is useful for initializing types which lazily allocate, like
+    /// `Vec::new` does.
+    ///
+    /// Note that the pointer value may potentially represent a valid pointer to
+    /// a `T`, which means this must not be used as a "not yet initialized"
+    /// sentinel value. Types that lazily allocate must track initialization by
+    /// some other means.
+    #[must_use]
+    #[inline]
+    pub const fn dangling() -> Self {
+        Unique {
+            pointer: NonNull::dangling(),
+            _marker: PhantomData,
+        }
+    }
+}
+
+impl<T: ?Sized> Unique<T> {
+    /// Creates a new `Unique`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be non-null.
+    #[inline]
+    pub const unsafe fn new_unchecked(ptr: *mut T) -> Self {
+        // SAFETY: the caller must guarantee that `ptr` is non-null.
+        unsafe {
+            Unique {
+                pointer: NonNull::new_unchecked(ptr),
+                _marker: PhantomData,
+            }
+        }
+    }
+
+    /// Creates a new `Unique` if `ptr` is non-null.
+    #[allow(clippy::manual_map)]
+    #[inline]
+    pub fn new(ptr: *mut T) -> Option<Self> {
+        if let Some(pointer) = NonNull::new(ptr) {
+            Some(Unique {
+                pointer,
+                _marker: PhantomData,
+            })
+        } else {
+            None
+        }
+    }
+
+    /// Acquires the underlying `*mut` pointer.
+    #[must_use = "`self` will be dropped if the result is not used"]
+    #[inline]
+    pub const fn as_ptr(self) -> *mut T {
+        self.pointer.as_ptr()
+    }
+
+    /// Dereferences the content.
+    ///
+    /// The resulting lifetime is bound to self so this behaves "as if"
+    /// it were actually an instance of T that is getting borrowed. If a longer
+    /// (unbound) lifetime is needed, use `&*my_ptr.as_ptr()`.
+    ///
+    /// # Safety
+    ///
+    /// Safety requirements for this function are inherited from [NonNull::as_ref].
+    ///
+    #[must_use]
+    #[inline]
+    pub const unsafe fn as_ref(&self) -> &T {
+        // SAFETY: the caller must guarantee that `self` meets all the
+        // requirements for a reference.
+        unsafe { self.pointer.as_ref() }
+    }
+
+    /// Mutably dereferences the content.
+    ///
+    /// The resulting lifetime is bound to self so this behaves "as if"
+    /// it were actually an instance of T that is getting borrowed. If a longer
+    /// (unbound) lifetime is needed, use `&mut *my_ptr.as_ptr()`.
+    ///
+    /// # Safety
+    ///
+    /// Safety requirements for this function are inherited from [NonNull::as_mut].
+    #[must_use]
+    #[inline]
+    pub unsafe fn as_mut(&mut self) -> &mut T {
+        // SAFETY: the caller must guarantee that `self` meets all the
+        // requirements for a mutable reference.
+        unsafe { self.pointer.as_mut() }
+    }
+
+    /// Casts to a pointer of another type.
+    #[must_use = "`self` will be dropped if the result is not used"]
+    #[inline]
+    pub fn cast<U>(self) -> Unique<U> {
+        Unique::from(self.pointer.cast())
+    }
+
+    /// Acquires the underlying `*mut` pointer.
+    #[must_use = "`self` will be dropped if the result is not used"]
+    #[inline]
+    pub const fn as_non_null(self) -> NonNull<T> {
+        self.pointer
+    }
+}
+
+impl<T: ?Sized> Clone for Unique<T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<T: ?Sized> Copy for Unique<T> {}
+
+impl<T: ?Sized> From<&mut T> for Unique<T> {
+    /// Converts a `&mut T` to a `Unique<T>`.
+    ///
+    /// This conversion is infallible since references cannot be null.
+    #[inline]
+    fn from(reference: &mut T) -> Self {
+        Self::from(NonNull::from(reference))
+    }
+}
+
+impl<T: ?Sized> From<NonNull<T>> for Unique<T> {
+    /// Converts a `NonNull<T>` to a `Unique<T>`.
+    ///
+    /// This conversion is infallible since `NonNull` cannot be null.
+    #[inline]
+    fn from(pointer: NonNull<T>) -> Self {
+        Unique {
+            pointer,
+            _marker: PhantomData,
+        }
+    }
+}
-- 
2.45.2


