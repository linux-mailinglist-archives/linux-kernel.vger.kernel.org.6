Return-Path: <linux-kernel+bounces-547950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5655A53E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DDC7A3B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A4A20B810;
	Wed,  5 Mar 2025 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlPhZoiP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3220969A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216026; cv=none; b=hPSkkATWeoYdquS3TPKxicTs63xocBPA8WHSoqgY8j8HnTwxfV/FX0MSR12HYV/ZIQH5q9283gH37v/TMD2t1hraHfJaP24lIQVKgIxrrjT1Jj5EF0vshTDxdTfZ5Io6mjZXyPt/H1do6PeumSKel0u8M7A/ulPV6LXjp5WVREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216026; c=relaxed/simple;
	bh=8a/sOBocUbocUe2Kuyw45pC4czgM+u4rG+43tLaFscA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEqp+iS7EINkF0lqxJBUnJT81SxM/WNuqJ0BcOsGx/FvzubuQtKTVFGV01h2XYOGleGNMp8/VWOo7TTjhqCoFBytRIHhFtUMaugjaza57AXeAlp0AYJQU8VQZCxdNiCfY5FXFjFtALOMwQB2HLume8G5WZ7W8KnVcEQAM3bITiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlPhZoiP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGhdforG/hfsTGcf1d8lWIscR/N9faUXID3wN0fe8hE=;
	b=VlPhZoiPTsuFTAwbnyqvEN1GjM+htUWbonwFZOgd9PgrfF8DZRVMs/h89tv+nDUymVxzAP
	q1fqgxyb1nGVBcpGeIuN+5LNrKxJOMPmxhjcLsc/QEvOsXXSsrQmjVE4yR/LLo2y250BQV
	WaQpr1zY9MzZHLRiNrWwwHpOhROoPsw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-7XKPghc_PD-C1h_03dlyvw-1; Wed,
 05 Mar 2025 18:06:58 -0500
X-MC-Unique: 7XKPghc_PD-C1h_03dlyvw-1
X-Mimecast-MFC-AGG-ID: 7XKPghc_PD-C1h_03dlyvw_1741216016
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ED5F180025A;
	Wed,  5 Mar 2025 23:06:56 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57C33300019E;
	Wed,  5 Mar 2025 23:06:53 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com,
	Alice Ryhl <aliceryhl@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <sima@ffwll.ch>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC v3 17/33] rust: drm/kms: Add OpaqueEncoder
Date: Wed,  5 Mar 2025 17:59:33 -0500
Message-ID: <20250305230406.567126-18-lyude@redhat.com>
In-Reply-To: <20250305230406.567126-1-lyude@redhat.com>
References: <20250305230406.567126-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Same thing as OpaquePlane, but for encoders now.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V3:
* Add safety comment to ModeObject implementation
* Add safety comments for AsRawEncoder
* Implement try_from_opaque() and from_opaque() using a macro

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/encoder.rs | 91 +++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/kms/encoder.rs b/rust/kernel/drm/kms/encoder.rs
index 2e4e88055c890..9ae2ff8eb5d50 100644
--- a/rust/kernel/drm/kms/encoder.rs
+++ b/rust/kernel/drm/kms/encoder.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/drm/drm_encoder.h`](srctree/include/drm/drm_encoder.h)
 
-use super::{KmsDriver, ModeObject, StaticModeObject, UnregisteredKmsDevice};
+use super::{KmsDriver, ModeObject, ModeObjectVtable, StaticModeObject, UnregisteredKmsDevice};
 use crate::{
     alloc::KBox,
     drm::device::Device,
@@ -219,6 +219,25 @@ unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encoder) -> &'a Self {
     }
 }
 
+// SAFETY: `funcs` is initialized when the encoder is allocated
+unsafe impl<T: DriverEncoder> ModeObjectVtable for Encoder<T> {
+    type Vtable = bindings::drm_encoder_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `as_raw()` always returns a valid pointer to an encoder
+        unsafe { *self.as_raw() }.funcs
+    }
+}
+
+impl<T: DriverEncoder> Encoder<T> {
+    super::impl_from_opaque_mode_obj! {
+        fn <'a, D>(&'a OpaqueEncoder<D>) -> &'a Self;
+        use
+            T as DriverEncoder,
+            D as KmsDriver
+    }
+}
+
 /// A [`Encoder`] that has not yet been registered with userspace.
 ///
 /// KMS registration is single-threaded, so this object is not thread-safe.
@@ -311,6 +330,76 @@ pub fn new<'a, 'b: 'a>(
     }
 }
 
+/// A [`struct drm_encoder`] without a known [`DriverEncoder`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverEncoder`] implementation
+/// for a [`struct drm_encoder`] automatically. It is identical to [`Encoder`], except that it does not
+/// provide access to the driver's private data.
+///
+/// # Invariants
+///
+/// Same as [`Encoder`].
+#[repr(transparent)]
+pub struct OpaqueEncoder<T: KmsDriver> {
+    encoder: Opaque<bindings::drm_encoder>,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> Sealed for OpaqueEncoder<T> {}
+
+// SAFETY: All of our encoder interfaces are thread-safe
+unsafe impl<T: KmsDriver> Send for OpaqueEncoder<T> {}
+
+// SAFETY: All of our encoder interfaces are thread-safe
+unsafe impl<T: KmsDriver> Sync for OpaqueEncoder<T> {}
+
+// SAFETY: We don't expose OpaqueEncoder<T> to users before `base` is initialized in
+// OpaqueEncoder::new(), so `raw_mode_obj` always returns a valid poiner to a
+// bindings::drm_mode_object.
+unsafe impl<T: KmsDriver> ModeObject for OpaqueEncoder<T> {
+    type Driver = T;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: DRM encoders exist for as long as the device does, so this pointer is always
+        // valid
+        unsafe { Device::borrow((*self.encoder.get()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose Encoder<T> to users before it's initialized, so `base` is always
+        // initialized
+        unsafe { addr_of_mut!((*self.encoder.get()).base) }
+    }
+}
+
+// SAFETY: Encoders do not have a refcount
+unsafe impl<T: KmsDriver> StaticModeObject for OpaqueEncoder<T> {}
+
+// SAFETY:
+// - Via our type variants our data layout is identical to  with `drm_encoder`
+// - Since we don't expose `Encoder` to users before it has been initialized, this and our data
+//   layout ensure that `as_raw()` always returns a valid pointer to a `drm_encoder`.
+unsafe impl<T: KmsDriver> AsRawEncoder for OpaqueEncoder<T> {
+    fn as_raw(&self) -> *mut bindings::drm_encoder {
+        self.encoder.get()
+    }
+
+    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encoder) -> &'a Self {
+        // SAFETY: Our data layout is identical to `bindings::drm_encoder`
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: `funcs` is initialized when the encoder is allocated
+unsafe impl<T: KmsDriver> ModeObjectVtable for OpaqueEncoder<T> {
+    type Vtable = bindings::drm_encoder_funcs;
+
+    fn vtable(&self) -> *const Self::Vtable {
+        // SAFETY: `as_raw()` always returns a valid pointer to an encoder
+        unsafe { *self.as_raw() }.funcs
+    }
+}
+
 unsafe extern "C" fn encoder_destroy_callback<T: DriverEncoder>(
     encoder: *mut bindings::drm_encoder,
 ) {
-- 
2.48.1


