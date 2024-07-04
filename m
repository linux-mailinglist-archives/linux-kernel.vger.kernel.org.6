Return-Path: <linux-kernel+bounces-241468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18CF927BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B872884B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341351B47AD;
	Thu,  4 Jul 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+zZsr9P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA51C092E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112935; cv=none; b=Md1clHZqVxRwpRiQcghJos/wY+VG38lsuHPyr/SYvCFT3Xa3c/4TjLufC/WnLI0d1/PG3dv++/k1NorbML97JfCXnrBZOs/9u4OQpa0ofaknZ0yo/VANSpTgwg+y2ZaRq65hkMj9MoTCeVdZw4jhhw7Wx9HXagopDqL4hFk+Ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112935; c=relaxed/simple;
	bh=dGm8d+PRxMNqkrwuSVGI4AqzVqqw/jVLlF0OhXEGCEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ijv+yYrsfHmadgtvOiO752Rvs6uY54VM+VKhJmZUVNh2vIZd8h6MsWCJu7onlAEcaC15hwVQea3fuCEDA4FNBWELWpOfbkUbAUbvR0DAaLaemFm28Sdt8L4EZ7kmq5c0+HISbAEVz8fDVgDslg6DmdQPs54BwIKUysAJhJngXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+zZsr9P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQxAYuE6n+/DH+OguL+f/xlAy+kzOF6Lw0v+HCA+hEE=;
	b=G+zZsr9P4VjgangClml5rN0ewlr9S+wL20maOhTV8UapqWRPVTkPTkb/U3/3/d85iOQrh2
	082215Uc3KgdBfdkdffqR5/VUV2SQYpSrkLsOyvR1yV9hO0b8t5041K0g1+GCwH0GuOUzZ
	Cp1QB0Cx8eKtQXnilqhLNCkd6WPkE7k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-l2T3D9uYM5mwyT9f8kttpQ-1; Thu, 04 Jul 2024 13:08:50 -0400
X-MC-Unique: l2T3D9uYM5mwyT9f8kttpQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36710f4d5c9so579990f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112930; x=1720717730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQxAYuE6n+/DH+OguL+f/xlAy+kzOF6Lw0v+HCA+hEE=;
        b=il1+ka5DMVRoBK2ntUCI+z7CB4HI7ctniJwWUfhaqVc7m+HU0ykoXZpnrM73b2tIbF
         8+cpb+U2lUkYOYplQmAxzhBX56ngfzE7v3HiQ8voHJ4bMyZWwvfro0BN82b/rdhHAyLN
         HVuiqQA6tvsmeiWtTc3OIDk4Ii/HJf1dlRvgagdsseR1lZf0ojvk26tS1zYMOc9M0ZiE
         O20HZHH7vVxDeRWlxjeO+QgIDFJJXh7GlcF9FbzLbgn0SUGiqHeZm/iWyfaIOJN0o9tn
         6txSdeV/KoOm7Y9LsxbmGaJuC2FXXxSehr4tZ+hlTJQMsDe4Rp5afF3NxhJIaybrhoSb
         0rPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc48HBh8ZHsR6UeVV6r00f8tNzsc26P5LJBSWz0zpbPRpVId9nelyDVQB8KG3qjrWS2SXHC4U8GZcqZgKFjLiU6pPfUJwlPctiTmRj
X-Gm-Message-State: AOJu0YzLMyHdFhxulBnnW1j1dRC8fl791MYZ4SdsRHLRTjwwXCs9tYrS
	TMQCWfpy6iVMld2OH5K/21bOY/yKjzwtF02lPqGFKrROozpHBZh9qRXoGaIOAr6xeU2jVc/5VQT
	ykVdxqnsJfK+kRNk8Fx6CZuVZE8gXYHqk2c5F6ac/QohFPUEW0Ob6tcjUMaML+g==
X-Received: by 2002:a5d:4747:0:b0:367:2945:2bfa with SMTP id ffacd0b85a97d-3679dd63b64mr1747373f8f.52.1720112929686;
        Thu, 04 Jul 2024 10:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Oe8sBg1g3jKnRqqLj6OVJ/BT6D4UfPLf6dc0y8CTqERAnHlPHdZGQfd8llsP2TaSJQUN1Q==
X-Received: by 2002:a5d:4747:0:b0:367:2945:2bfa with SMTP id ffacd0b85a97d-3679dd63b64mr1747351f8f.52.1720112929339;
        Thu, 04 Jul 2024 10:08:49 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679dfae9easm1973191f8f.87.2024.07.04.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:48 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
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
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 09/20] rust: types: implement `Unique<T>`
Date: Thu,  4 Jul 2024 19:06:37 +0200
Message-ID: <20240704170738.3621-10-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704170738.3621-1-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the `Unique` type as a prerequisite for `KBox` and `Kvec`
introduced in subsequent patches.

`Unique` serves as wrapper around a `NonNull`, but indicates that the
possessor of this wrapper owns the referent.

This type already exists in Rust's core library, but, unfortunately, is
exposed as unstable API and hence shouldn't be used in the kernel.

This implementation of `Unique` is almost identical, but mostly stripped
down to the functionality we need for `KBox` and `KVec`. Additionally,
all unstable features are removed and / or replaced by stable ones.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/types.rs | 176 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2e7c9008621f..281327ea2932 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -409,3 +409,179 @@ pub enum Either<L, R> {
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


