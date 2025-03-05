Return-Path: <linux-kernel+bounces-547961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810BA53E38
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2853A7C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE5207DF4;
	Wed,  5 Mar 2025 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2PFf3M2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A15207DF7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216104; cv=none; b=bLDpduuLvXfxaRSPXLoqbsdSS1W12v8FSa1XLCrsujfR8Ws4cX9K7u1hKvEuEVOrV2yWcTSkpCD0l7+hx0QfkuPV8H6Ttv9stMT4gJ7O78YQzhFL0TXCFJlERFm7bwvjygRHZjNAmi6Rt00nCAmXX55j8bCpeMlfhO6RKHZ4vwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216104; c=relaxed/simple;
	bh=soor4M8ULSOlMvWG9ID6XGYJBDSedFNViOqT2GaG0UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpUzHt1x3NDVHz4r9JUxBkbHJf+JPlhgfeT6CSjPcUSCGeGnJmC/Nn2rE9OtuelHrxuU8zuOvw3sDvnUaTItLjxNI6y0H8tg+k5+wcnP67E0kzO5M83jH71jC49XvPU6gEHKCPtluU68MjKlUp33bSmLi0qbEQkNkZ08lZZRCwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2PFf3M2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOW7KDNY/rnfsCrl7d4OXtnM2CoD0PhVS/YjiuzS72A=;
	b=b2PFf3M2BRO7uZz2vsBt+NOneflcmELj07vIYT4RLUSFOprbq4CX7YqMChE+FdVKy7Iblj
	MOwHJeSS5HhWKjd+kyKlgAmQnygkB8rAIk7FZRdkbYBV73ChgHtyYZMDA/vYRm+sBwoPCg
	/FjuOA6PtAjiN90vZMVUyze9mFKEfTQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-SE5Zl_emMbu36FTP4ZVAKg-1; Wed,
 05 Mar 2025 18:08:18 -0500
X-MC-Unique: SE5Zl_emMbu36FTP4ZVAKg-1
X-Mimecast-MFC-AGG-ID: SE5Zl_emMbu36FTP4ZVAKg_1741216095
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDB52180035E;
	Wed,  5 Mar 2025 23:08:15 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCC21300019E;
	Wed,  5 Mar 2025 23:08:10 +0000 (UTC)
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
	Asahi Lina <lina@asahilina.net>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC v3 25/33] rust: drm/kms: Add drm_framebuffer bindings
Date: Wed,  5 Mar 2025 17:59:41 -0500
Message-ID: <20250305230406.567126-26-lyude@redhat.com>
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

This adds some very simple bindings for drm_framebuffer. We don't use them
much yet, but we'll eventually be using them when rvkms eventually gets CRC
and writeback support. Just like Connector objects, these use RcModeObject.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V3:
* Replace Framebuffer struct with tuple
* Add safety comments for ModeObject implementation
* Add comment for why we're using Sealed

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/bindings/bindings_helper.h    |  1 +
 rust/kernel/drm/kms.rs             |  1 +
 rust/kernel/drm/kms/framebuffer.rs | 74 ++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 rust/kernel/drm/kms/framebuffer.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 846eb6eb8fc4c..2e80a62062fc8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -18,6 +18,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index 978bb6712ffbe..429ce28229c9e 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -6,6 +6,7 @@
 pub mod connector;
 pub mod crtc;
 pub mod encoder;
+pub mod framebuffer;
 pub mod plane;
 
 use crate::{
diff --git a/rust/kernel/drm/kms/framebuffer.rs b/rust/kernel/drm/kms/framebuffer.rs
new file mode 100644
index 0000000000000..5a60b580fe0bf
--- /dev/null
+++ b/rust/kernel/drm/kms/framebuffer.rs
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM framebuffers.
+//!
+//! C header: [`include/drm/drm_framebuffer.h`](srctree/include/drm/drm_framebuffer.h)
+
+use super::{KmsDriver, ModeObject, RcModeObject};
+use crate::{drm::device::Device, types::*};
+use bindings;
+use core::{marker::*, ptr};
+
+/// The main interface for [`struct drm_framebuffer`].
+///
+/// # Invariants
+///
+/// - `self.0` is initialized for as long as this object is exposed to users.
+/// - This type has an identical data layout to [`struct drm_framebuffer`]
+///
+/// [`struct drm_framebuffer`]: srctree/include/drm/drm_framebuffer.h
+#[repr(transparent)]
+pub struct Framebuffer<T: KmsDriver>(Opaque<bindings::drm_framebuffer>, PhantomData<T>);
+
+// SAFETY:
+// - `self.0` is initialized for as long as this object is exposed to users
+// - `base` is initialized by DRM when `self.0` is initialized, thus `raw_mode_obj()` always returns
+//   a valid pointer.
+unsafe impl<T: KmsDriver> ModeObject for Framebuffer<T> {
+    type Driver = T;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        // SAFETY: `dev` points to an initialized `struct drm_device` for as long as this type is
+        // initialized
+        unsafe { Device::borrow((*self.0.get()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose Framebuffer<T> to users before its initialized, so `base` is
+        // always initialized
+        unsafe { ptr::addr_of_mut!((*self.0.get()).base) }
+    }
+}
+
+// SAFETY: Framebuffers are refcounted mode objects.
+unsafe impl<T: KmsDriver> RcModeObject for Framebuffer<T> {}
+
+// SAFETY: References to framebuffers are safe to be accessed from any thread
+unsafe impl<T: KmsDriver> Send for Framebuffer<T> {}
+// SAFETY: References to framebuffers are safe to be accessed from any thread
+unsafe impl<T: KmsDriver> Sync for Framebuffer<T> {}
+
+// For implementing ModeObject
+impl<T: KmsDriver> crate::private::Sealed for Framebuffer<T> {}
+
+impl<T: KmsDriver> PartialEq for Framebuffer<T> {
+    fn eq(&self, other: &Self) -> bool {
+        ptr::eq(self.0.get(), other.0.get())
+    }
+}
+impl<T: KmsDriver> Eq for Framebuffer<T> {}
+
+impl<T: KmsDriver> Framebuffer<T> {
+    /// Convert a raw pointer to a `struct drm_framebuffer` into a [`Framebuffer`]
+    ///
+    /// # Safety
+    ///
+    /// The caller guarantews that `ptr` points to a initialized `struct drm_framebuffer` for at
+    /// least the entire lifetime of `'a`.
+    #[inline]
+    #[allow(dead_code)]
+    pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_framebuffer) -> &'a Self {
+        // SAFETY: Our data layout is identical to drm_framebuffer
+        unsafe { &*ptr.cast() }
+    }
+}
-- 
2.48.1


