Return-Path: <linux-kernel+bounces-260280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B723B93A554
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739672819A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349115A876;
	Tue, 23 Jul 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzRMYXdL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749D158A37;
	Tue, 23 Jul 2024 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758298; cv=none; b=YaF0Fo7CYq6pA+CrJSNzFCNCq+HV6GjrbVq30K6UaubtlxfudiQTlXkmqAm18jdjjaRJlDKaWavtc9TSD6/yc7Qt/HT1tqvXVT81RuHpZ2cMSrLgmyvj3emLDIKDP7hFMC3o16NxnCpXx2mVfaJ4ZXkndHy/Drp0EvqgjA01qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758298; c=relaxed/simple;
	bh=EADnfi1fGvsx4VhAV2Fq3TLA5MaiZGvO/PM1XNctkMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNXDaizJE8rYXmO/ytqKaA7V48Au4OppRDanevYm9cKZa2YWuMEdATTe4+s2UhikEIs6gfADVK9o61fxcwkBIqsRAImP+ncf68Lqob3n4+sIE+8LBkEn5Bl3wfEmGrvhC7T5xMW9R85wqIpFtM14mFaBspPnJ7xA8RYfD9PsPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzRMYXdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C00C4AF0A;
	Tue, 23 Jul 2024 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758298;
	bh=EADnfi1fGvsx4VhAV2Fq3TLA5MaiZGvO/PM1XNctkMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzRMYXdLknWKU0suCrVLj8MEFGuTCk7/uXsRG/mzuUaad6aFwdImo0hpVVrtIv7kH
	 0Rv1AXFLqi29AxP5TBXGlkF16TDnKbx4X3Cv8xPp6L3L5gcMSys9a9enKH5QrtEEMf
	 GJWj+dRnU8pYOsxpsuvVbiLkTaJi+K3Av/YRPwhEiiXcDNbenfTiCEhgLVg/NRN6j3
	 vne/BLvKZRqxoVtlZ5qZ+4hIl7cVphYA1vSQMzC9xXLrnOFcCIMPXShVFDDPiSm+ZF
	 5ga/F3VxiqKohPR51k3FZes5jjxBRQtQqLSQ61rf6jJindASfC6V14JtEaD0+fBpHf
	 cwIojKBj2UxmA==
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
Subject: [PATCH v2 08/23] rust: types: implement `Unique<T>`
Date: Tue, 23 Jul 2024 20:09:57 +0200
Message-ID: <20240723181024.21168-9-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723181024.21168-1-dakr@kernel.org>
References: <20240723181024.21168-1-dakr@kernel.org>
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
index 2e7c9008621f..9cd20fe41c20 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -409,3 +409,186 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
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


