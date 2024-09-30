Return-Path: <linux-kernel+bounces-345008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C9C98B11E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FE6280AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A1188A3E;
	Mon, 30 Sep 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgiJPPwJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836B1A38C9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739662; cv=none; b=pW27/OG7+Nvo+N0c+oHEn54nk+SgRV3ZZkXZQU05/mObCwB0llOxZgOa10MyBm89FUHB40Ai3YlIR/7ZKdN93kiVsF7b0NonHGz8UHTc2LlUzkn7eWyFLgFDQrnz9CmPrOArFbFRC0CbR173/9x4cuKOKQLAv7odKKbQOV6/ozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739662; c=relaxed/simple;
	bh=hoMN4I4cPtj9FPPo9HGRXkZcZRhemeuLwnG0V1+H/2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUjbVrEXT3S8KoYCwmGiEUkNQNKBWezoKYiN/DNxXbPTAkIHZI052jeChZWEdLShVZZGyHLqI+BI7BSghe1Q3KVEAHQLR+Wp5teL3Ma4KN5CIWfsOUPTroe7t5UwhfSqorxAvb/vN2O9SU+OSfWsnwAVxvGR87tkWeN6wYxWpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgiJPPwJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JS1c0OCCFpRlXiQX91H1LkrlyJCKWK3k0GLCh/QD2fY=;
	b=IgiJPPwJO+bqiBjikJB6FAp4Tff4qee4S0T1Dl4a+FGbuL0Fi+BaylaU2TV+ZI9my16gIG
	in6YsbA4IxkXnOAYIbuMau501gnHNXFp0OVfEck9WNpjTe0DWtjzTqXolX7rmoFJtO4gtH
	6StAjb13TWSkhmfJifGCQaxDfhwTVZc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-mojEH0EhNHi2ABqV4vN0Nw-1; Mon,
 30 Sep 2024 19:40:56 -0400
X-MC-Unique: mojEH0EhNHi2ABqV4vN0Nw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A954819626FA;
	Mon, 30 Sep 2024 23:40:53 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E4333003DEC;
	Mon, 30 Sep 2024 23:40:49 +0000 (UTC)
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
	Danilo Krummrich <dakr@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [WIP RFC v2 27/35] rust: drm/kms: Add drm_framebuffer bindings
Date: Mon, 30 Sep 2024 19:10:10 -0400
Message-ID: <20240930233257.1189730-28-lyude@redhat.com>
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

This adds some very simple bindings for drm_framebuffer. We don't use them
much yet, but we'll eventually be using them when rvkms eventually gets CRC
and writeback support. Just like Connector objects, these use RcModeObject.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/bindings/bindings_helper.h    |  1 +
 rust/kernel/drm/kms.rs             |  1 +
 rust/kernel/drm/kms/framebuffer.rs | 58 ++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 rust/kernel/drm/kms/framebuffer.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7695f11f4363c..7c324003c3885 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index 4ab039d67352e..3edd90bc0025a 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -7,6 +7,7 @@
 pub mod crtc;
 pub mod encoder;
 pub mod fbdev;
+pub mod framebuffer;
 pub mod plane;
 
 use crate::{
diff --git a/rust/kernel/drm/kms/framebuffer.rs b/rust/kernel/drm/kms/framebuffer.rs
new file mode 100644
index 0000000000000..bbe408c187670
--- /dev/null
+++ b/rust/kernel/drm/kms/framebuffer.rs
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//! DRM Framebuffer related bindings
+
+use crate::{
+    drm::{
+        device::Device,
+        fourcc::*,
+    },
+    types::*,
+    prelude::*,
+};
+use bindings;
+use core::{
+    marker::*,
+    slice,
+};
+use super::{ModeObject, RcModeObject, KmsDriver};
+
+/// The main interface for [`struct drm_framebuffer`].
+///
+/// [`struct drm_framebuffer`]: srctree/include/drm/drm_framebuffer.h
+#[repr(transparent)]
+pub struct Framebuffer<T: KmsDriver> {
+    inner: Opaque<bindings::drm_framebuffer>,
+    _p: PhantomData<T>,
+}
+
+impl<T: KmsDriver> ModeObject for Framebuffer<T> {
+    type Driver = T;
+
+    fn drm_dev(&self) -> &Device<Self::Driver> {
+        unsafe { Device::borrow((*self.inner.get()).dev) }
+    }
+
+    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
+        // SAFETY: We don't expose Framebuffer<T> to users before it's initialized, so `base` is
+        // always initialized
+        unsafe { &mut (*self.inner.get()).base }
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
+impl<T: KmsDriver> crate::private::Sealed for Framebuffer<T> {}
+
+impl<T: KmsDriver> Framebuffer<T> {
+    #[inline]
+    pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_framebuffer) -> &'a Self {
+        // SAFETY: Our data layout is identical to drm_framebuffer
+        unsafe { &*ptr.cast() }
+    }
+}
-- 
2.46.1


