Return-Path: <linux-kernel+bounces-344999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A198B114
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C806B24976
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6231A2558;
	Mon, 30 Sep 2024 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huJZ+wm1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85918C904
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739589; cv=none; b=tjLIbwDcPmPJTd6w/gRS6rqgQfXA2TCNgt/+PKR3JP4nnUW8ucnnhfee8knxEYHEmr/XOXDbKHnXDqL1yNrLErHsJESkEAZPhX/khWZ5RFTULvNC550XUeXz2a0YZ6a6rgLcmKP0bfeGalukDOzIllU9YISoDOZyrSm4Blje6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739589; c=relaxed/simple;
	bh=dY2aaYMcIXAQKgv7ToUl/izH2dyscbvgkI6v4CKYfTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZf5Av3ldLDOrm1HCbYI45RgodC3n4LgdsiU/uqEkGcYGyK4SQPKm8zxWcAXka1mdZpdg9KGS3yLeYXFpza8Vejv4v5pxD1UE8OpTD56ZNvW16mu3tBe9jsAn3Voixcu8+VlzNTunG+8uOBbBLGBDHU6EYq5ByvaDIVhqolMHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=huJZ+wm1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqJVQxO6y8ZjBezncHzbNZEVz53Yon6RGUEUFxdh8z0=;
	b=huJZ+wm1SRV2n9YXtyBSao1VjZGO6xu+fldVq5/h/yV/uThIJ433iSKREJxOxt/qfuHqmz
	ghyQ8XjEqxnYTe27P+ZnwA2sbh7R0A/wHULWUyd3AEY6iZWW4hyPPhSBusFxzHE1dc8jVU
	vUev31RkVJnUii2Fj9rCA/rmzYfKtk0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-kU9cTNeWP_i06bB4I9LCDg-1; Mon,
 30 Sep 2024 19:39:43 -0400
X-MC-Unique: kU9cTNeWP_i06bB4I9LCDg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69712193EB0E;
	Mon, 30 Sep 2024 23:39:41 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53C1E3003DEC;
	Mon, 30 Sep 2024 23:39:38 +0000 (UTC)
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
Subject: [WIP RFC v2 19/35] WIP: rust: drm/kms: Add OpaqueEncoder
Date: Mon, 30 Sep 2024 19:10:02 -0400
Message-ID: <20240930233257.1189730-20-lyude@redhat.com>
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

Same thing as OpaquePlane, but for encoders now.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

TODO:
* Add upcast functions for this

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/encoder.rs | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/rust/kernel/drm/kms/encoder.rs b/rust/kernel/drm/kms/encoder.rs
index 3ae597093645e..71fae45d2d651 100644
--- a/rust/kernel/drm/kms/encoder.rs
+++ b/rust/kernel/drm/kms/encoder.rs
@@ -235,6 +235,61 @@ pub fn new<'a, 'b: 'a>(
     }
 }
 
+/// A [`struct drm_encoder`] without a known [`DriverEncoder`] implementation.
+///
+/// This is mainly for situations where our bindings can't infer the [`DriverEncoder`] implementation
+/// for a [`struct drm_encoder`] automatically. It is identical to [`Encoder`], except that it does not
+/// provide access to the driver's private data.
+///
+/// TODO: Add functions for upcasting.
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
+impl<T: KmsDriver> ModeObject for OpaqueEncoder<T> {
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
+impl<T: KmsDriver> AsRawEncoder for OpaqueEncoder<T> {
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
 unsafe extern "C" fn encoder_destroy_callback<T: DriverEncoder>(
     encoder: *mut bindings::drm_encoder
 ) {
-- 
2.46.1


