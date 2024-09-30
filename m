Return-Path: <linux-kernel+bounces-344983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C1798B0E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769231C2154C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA4199927;
	Mon, 30 Sep 2024 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRdexgwx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF947199928
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739468; cv=none; b=JV4moeb43Lt1VK5ntlozlP+cQmxhaYxm23mGxIQT8pXHnsPGQ2hWEJVBr7pbachzU6X9XXTg+vQaJstXW3r9doJjmMfDx/N0asfPu4XNLgBqk30QfAmdQ+Ns34OMB/oo6O8Qu3YkoE72Xo9saM5Yd0qlxgvX4DwqwUTZBKNUA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739468; c=relaxed/simple;
	bh=6oadzVRYJMluDp3FrVWgAhZQWOR4wrk9OXD6s51O0aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYDV26DMeC+kaCjZxkqN3ELm9cVAudD5umL8ERlftt1pG6eSF5emt8sfIrQGA5EAm1eP//fkHzgPTWMzUVcfcsNwGfc38D11fYBmhrBMOYpZTLO64eFRPMJcLizi9D6iNArOOHoSSgZXbmzj2pShxVYE2dE9uYGhgQw9dnJcpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRdexgwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Zb0rBlFBS6DnNXycQrkSdH1hnOzRIIqb3zhPvtIptc=;
	b=PRdexgwxr8Ff5JiHik4JwvmKQ26HWj0b4csdcC/Mb+FvVxrEureomUqMyaRCG5Gn7e0WjC
	4cl/hmBwg6mDEtKqFbvsiet+QqWK3l6ar9STq/Y3n0S0cOiaDo2mv8r+KEkPWAHDc5dHNX
	tBV52YLu9gXrKG6F9LNUg+o2opL8yfk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-OoxvmIacM-WG0ZEoppEFHw-1; Mon,
 30 Sep 2024 19:37:42 -0400
X-MC-Unique: OoxvmIacM-WG0ZEoppEFHw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4735196A40C;
	Mon, 30 Sep 2024 23:37:39 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 738DD3003DEC;
	Mon, 30 Sep 2024 23:37:35 +0000 (UTC)
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
Subject: [WIP RFC v2 03/35] rust: drm/kms/fbdev: Add FbdevShmem
Date: Mon, 30 Sep 2024 19:09:46 -0400
Message-ID: <20240930233257.1189730-4-lyude@redhat.com>
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

For drivers which use the shmem based GEM helpers, they'll want to use the
relevant drm_fbdev_shmem_setup() functions instead of the
drm_fbdev_dma_setup() functions. To allow for this, introduce another
FbdevImpl that such drivers can use instead of FbdevDma.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/bindings/bindings_helper.h    |  1 +
 rust/kernel/drm/kms/fbdev.rs       |  8 +++++++-
 rust/kernel/drm/kms/fbdev/shmem.rs | 33 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/drm/kms/fbdev/shmem.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4a8e44e11c96a..9803e0ecac7c1 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_fbdev_dma.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
diff --git a/rust/kernel/drm/kms/fbdev.rs b/rust/kernel/drm/kms/fbdev.rs
index bdf97500137d8..a1035d948949a 100644
--- a/rust/kernel/drm/kms/fbdev.rs
+++ b/rust/kernel/drm/kms/fbdev.rs
@@ -5,6 +5,12 @@
 use crate::{private::Sealed, drm::{kms::*, device::Device, gem}};
 use bindings;
 
+#[cfg(CONFIG_DRM_GEM_SHMEM_HELPER = "y")]
+mod shmem;
+
+#[cfg(CONFIG_DRM_GEM_SHMEM_HELPER = "y")]
+pub use shmem::FbdevShmem;
+
 pub(crate) mod private {
     use super::*;
 
@@ -17,7 +23,7 @@ pub trait FbdevImpl {
 /// The main trait for a driver's DRM implementation.
 ///
 /// Drivers are expected not to implement this directly, and to instead use one of the objects
-/// provided by this module such as [`FbdevDma`].
+/// provided by this module such as [`FbdevDma`] and [`FbdevShmem`].
 pub trait FbdevImpl: private::FbdevImpl {}
 
 /// The fbdev implementation for drivers using the gem DMA helpers.
diff --git a/rust/kernel/drm/kms/fbdev/shmem.rs b/rust/kernel/drm/kms/fbdev/shmem.rs
new file mode 100644
index 0000000000000..16c3533ad2a0f
--- /dev/null
+++ b/rust/kernel/drm/kms/fbdev/shmem.rs
@@ -0,0 +1,33 @@
+//! The GEM shmem fbdev implementation for rust.
+//!
+//! This module provides an Fbdev implementation that can be used by Rust KMS drivers using the GEM
+//! shmem helpers provided by [`shmem`].
+
+use core::marker::*;
+use crate::drm::{gem::shmem, kms::*, device::Device};
+use super::{private::FbdevImpl as FbdevImplPrivate, FbdevImpl};
+use bindings;
+
+/// The fbdev implementation for drivers using the gem shmem helpers.
+///
+/// KMS Drivers which use the GEM helpers provided by [`shmem`] should use this for [`Kms::Fbdev`].
+pub struct FbdevShmem<T: Driver>(PhantomData<T>);
+
+impl<T, G> FbdevImplPrivate for FbdevShmem<T>
+where
+    T: Driver<Object = shmem::Object<G>>,
+    G: shmem::DriverObject
+{
+    #[inline]
+    fn setup_fbdev<D: Driver>(drm: &Device<D>, mode_config_info: &ModeConfigInfo) {
+        // SAFETY: Our implementation bounds are proof that this driver is using the gem shmem
+        // helpers
+        unsafe { bindings::drm_fbdev_shmem_setup(drm.as_raw(), mode_config_info.preferred_depth) };
+    }
+}
+
+impl<T, G> FbdevImpl for FbdevShmem<T>
+where
+    T: Driver<Object = shmem::Object<G>>,
+    G: shmem::DriverObject
+{}
-- 
2.46.1


