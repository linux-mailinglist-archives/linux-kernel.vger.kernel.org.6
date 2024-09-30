Return-Path: <linux-kernel+bounces-344995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D098B108
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31303B23198
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44451A2560;
	Mon, 30 Sep 2024 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPgS2KWI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5311A38DF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739565; cv=none; b=IOn8AzHXuk95wqME7Pdm75ELOVLbw/z/rtAOkrgxSp+wN6gANimINP3+feN3Gcon7wEqhFoQoQf9qX+ceLPPLsqG0Nnt5UrpveCM9Fvu43A7/kdzWCLkjsORWBBRn/1Mz5/GLq5KPk5GQQTvS5A/bQx6eB9Qt6RybOFQTj9jCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739565; c=relaxed/simple;
	bh=I0obSSRkGvNi4rcCDvMtLslcL/UTp1Q3TyltqWPYEis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BglnPOfNrJCnPVNJJUBK1q9pD06mC2xRvVKpo6avtsiqzs3hH4q0m/fuyekhj91POrDdTLoQ79ivhPkrb43gRXJ2DxoP1bLAKyRhnUh47d3JBXL7yt/3aUwQJAdLZ61SOJte5hBJ5eAjuyHhC24QCethjy4XiqZEsKT0bLaBoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPgS2KWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZR+Oy8+dZBZO6+3VRxhqxljsi2SG5GmfYhJRwKT9SBE=;
	b=cPgS2KWIpuYjMogBGaG2rLjIGYGv3Gt5DxluI1vU7B1e8CqVlkRKptgkz7b1zJo0LXXY+4
	AeMWusaZyor5FQv+Lg7KzbUkh53U3t/PG90Y8bVPByAbank5wU1Gfnhpv7bMCrprGb7+Eu
	DS/ld4vr1Bp3czRL9/Hb8EaQ3G1mG6A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-rkaPSSVnPBibG5lQR8OeMA-1; Mon,
 30 Sep 2024 19:39:19 -0400
X-MC-Unique: rkaPSSVnPBibG5lQR8OeMA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD146192DE39;
	Mon, 30 Sep 2024 23:39:16 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A94FB3003DEC;
	Mon, 30 Sep 2024 23:39:12 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Cc: Asahi Lina <lina@asahilina.net>,
	Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com,
	airlied@redhat.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org (open list)
Subject: [WIP RFC v2 15/35] WIP: rust: drm/kms: Add OpaquePlane and OpaquePlaneState
Date: Mon, 30 Sep 2024 19:09:58 -0400
Message-ID: <20240930233257.1189730-16-lyude@redhat.com>
In-Reply-To: <20240930233257.1189730-1-lyude@redhat.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Same thing as OpaqueCrtc and OpaqueCrtcState, but for plane states now.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

TODO:
* Finish adding upcast functions.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/plane.rs | 143 +++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 3040c4546b121..3ace487316d46 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -217,6 +217,43 @@ pub fn new<'a, 'b: 'a, const FMT_COUNT: usize, const MOD_COUNT: usize>(
         // SAFETY: We don't move anything
         Ok(unsafe { &*Box::into_raw(Pin::into_inner_unchecked(this)) })
     }
+
+    /// Attempt to convert an [`OpaquePlane`] into a fully qualified [`Plane`].
+    ///
+    /// This checks if the given [`OpaquePlane`] uses the same [`DriverPlane`] implementation, and
+    /// returns the [`OpaquePlane`] as a [`Plane`] object if so.
+    pub fn try_from_opaque<'a, D>(opaque: &'a OpaquePlane<D>) -> Option<&'a Self>
+    where
+        D: KmsDriver,
+        T: DriverPlane<Driver = D>
+    {
+        // SAFETY: The vtables for a `Plane` are initialized by the time that we expose `Plane`
+        // objects to users, and their values are invariant throughout the lifetime of the device.
+        let funcs = unsafe { (*opaque.plane.get()).funcs };
+
+        // SAFETY: We just guaranteed that the opaque plane shares our vtable pointers, which means
+        // it must belong to our `DriverPlane` implementation. As well, all `Plane<DriverPlane>`
+        // objects start with an identical data layout to `OpaquePlane`
+        ptr::eq(funcs, &T::OPS.funcs).then(|| unsafe { mem::transmute(opaque) })
+    }
+
+    /// Convert a [`OpaquePlane`] into its fully qualified [`Plane`].
+    ///
+    /// This is an infallible version of [`Self::try_from_opaque`]. This function is mainly useful
+    /// for drivers where only a single [`DriverPlane`] implementation exists.
+    ///
+    /// # Panics
+    ///
+    /// This function will panic if the underlying [`Plane`] which contains the provided
+    /// [`OpaquePlane`] does not belong to the same [`DriverPlane`] implementation.
+    pub fn from_opaque<'a, D>(opaque: &'a OpaquePlane<D>) -> &'a Self
+    where
+        D: KmsDriver,
+        T: DriverPlane<Driver = D>
+    {
+        Self::try_from_opaque(opaque)
+            .expect("Passed OpaquePlane does not share this DriverPlane implementation")
+    }
 }
 
 /// A trait implemented by any type that acts as a [`struct drm_plane`] interface.
@@ -275,6 +312,63 @@ unsafe impl<T: DriverPlane> Send for Plane<T> {}
 // SAFETY: Our interface is thread-safe.
 unsafe impl<T: DriverPlane> Sync for Plane<T> {}
 
+/// A [`struct drm_plane`] without a known [`DriverPlane`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverPlane`] implementation
+/// for a [`struct drm_plane`] automatically. It is identical to [`Plane`], except that it does not
+/// provide access to the driver's private data.
+///
+/// It may be upcasted to a full [`Plane`] using [`Plane::from_opaque`] or
+/// [`Plane::try_from_opaque`].
+///
+/// # Invariants
+///
+/// - `plane` is initialized for as long as this object is made available to users.
+/// - The data layout of this structure is equivalent to [`struct drm_plane`].
+///
+/// [`struct drm_plane`]: srctree/include/drm/drm_plane.h
+#[repr(transparent)]
+pub struct OpaquePlane<T: KmsDriver> {
+    plane: Opaque<bindings::drm_plane>,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> Sealed for OpaquePlane<T> {}
+
+impl<T: KmsDriver> AsRawPlane for OpaquePlane<T> {
+    type State = OpaquePlaneState<T>;
+
+    fn as_raw(&self) -> *mut bindings::drm_plane {
+        self.plane.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_plane) -> &'a Self {
+        // SAFETY: Our data layout is identical to `bindings::drm_plane`
+        unsafe { &*ptr.cast() }
+    }
+}
+
+impl<T: KmsDriver> ModeObject for OpaquePlane<T> {
+    type Driver = T;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: DRM planes exist for as long as the device does, so this pointer is always valid
+        unsafe { Device::borrow((*self.as_raw()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose DRM planes to users before `base` is initialized
+        unsafe { &mut ((*self.as_raw()).base) }
+    }
+}
+
+// SAFETY: Planes do not have a refcount
+unsafe impl<T: KmsDriver> StaticModeObject for OpaquePlane<T> {}
+
+// SAFETY: Our plane interfaces are guaranteed to be thread-safe
+unsafe impl<T: KmsDriver> Send for OpaquePlane<T> {}
+unsafe impl<T: KmsDriver> Sync for OpaquePlane<T> {}
+
 /// A trait implemented by any type which can produce a reference to a [`struct drm_plane_state`].
 ///
 /// This is implemented internally by DRM.
@@ -419,6 +513,55 @@ fn deref_mut(&mut self) -> &mut Self::Target {
     }
 }
 
+/// A [`struct drm_plane_state`] without a known [`DriverPlaneState`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverPlaneState`]
+/// implementation for a [`struct drm_plane_state`] automatically. It is identical to [`Plane`],
+/// except that it does not provide access to the driver's private data.
+///
+/// TODO: Add upcast functions
+///
+/// # Invariants
+///
+/// - The DRM C API and our interface guarantees that only the user has mutable access to `state`,
+///   up until [`drm_atomic_helper_commit_hw_done`] is called. Therefore, `plane` follows rust's
+///   data aliasing rules and does not need to be behind an [`Opaque`] type.
+/// - `state` is initialized for as long as this object is exposed to users.
+/// - The data layout of this structure is identical to [`struct drm_plane_state`].
+///
+/// [`struct drm_plane_state`]: srctree/include/drm/drm_plane.h
+/// [`drm_atomic_helper_commit_hw_done`]: srctree/include/drm/drm_atomic_helper.h
+#[repr(transparent)]
+pub struct OpaquePlaneState<T: KmsDriver> {
+    state: bindings::drm_plane_state,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> AsRawPlaneState for OpaquePlaneState<T> {
+    type Plane = OpaquePlane<T>;
+}
+
+impl<T: KmsDriver> private::AsRawPlaneState for OpaquePlaneState<T> {
+    fn as_raw(&self) -> &bindings::drm_plane_state {
+        &self.state
+    }
+
+    unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_plane_state {
+        &mut self.state
+    }
+}
+
+impl<T: KmsDriver> FromRawPlaneState for OpaquePlaneState<T> {
+    unsafe fn from_raw<'a>(ptr: *const bindings::drm_plane_state) -> &'a Self {
+        // SAFETY: Our data layout is identical to `ptr`
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_plane_state) -> &'a mut Self {
+        // SAFETY: Our data layout is identical to `ptr`
+        unsafe { &mut *ptr.cast() }
+    }
+}
 unsafe extern "C" fn plane_destroy_callback<T: DriverPlane>(
     plane: *mut bindings::drm_plane
 ) {
-- 
2.46.1


