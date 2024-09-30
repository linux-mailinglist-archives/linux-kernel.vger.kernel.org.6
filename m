Return-Path: <linux-kernel+bounces-345002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEEA98B118
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1387B241CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80831A7AD0;
	Mon, 30 Sep 2024 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj9NjM1m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830301A2C33
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739612; cv=none; b=T1yaKg1BwOSJNySMSmh8J9jWhrUUZhUiapeMk1fnTxuaVW+mWDKvl0K+GjktG6OGtXlgyJnFX1uASlzKzhyJRqSbqO9507LPFkXP7QmizbBZUHAQJ4HSWwcF3uEO7pUtMwOHKSVpYENjdrWP4SJ973GKWu0NjD3p6NnilT0bDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739612; c=relaxed/simple;
	bh=Ec55od2yRLpvSnKMHV5L1zqrXHX/7OhYXk8ssGVeTDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZZMfIJ0cFzb6SwJ+gN7hjsjlpBFOxufsMKygNhj5vk7rejZxepF9Z5Gqh19I9fGZoN7wZONWxk6QlOLhmlpdDqLVdp5YwnfwPFAdpnkjT8wNyeZzSXdXXHVGWmH1eLknr77SCuj/5bk1ognAyDIWfs3hH2YXiroQRN527i+VC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tj9NjM1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXYRkES5IMRSEWy/SdffRUBHVVSOxpQy/XQZZbTshqY=;
	b=Tj9NjM1mny/GPSLefcb9gEwZmSgpR3+rhXNqLYx+0Lb4pBPV0BuidmMNqyvdQXxvwZQDG1
	ziT70FUREbwJmYX8RUMnEulEE0IJoMHPlXp7pWGyWGHvcxI3C8Venl8Q7+kb8wxlndQTIl
	KJSXamhNpirGmR14hT3KegnU45CZX5U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-ZZjrKZJOO3uRfv2nR5MVhg-1; Mon,
 30 Sep 2024 19:40:08 -0400
X-MC-Unique: ZZjrKZJOO3uRfv2nR5MVhg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17FEF192DE39;
	Mon, 30 Sep 2024 23:40:06 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4928D3003E4D;
	Mon, 30 Sep 2024 23:40:02 +0000 (UTC)
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
Subject: [WIP RFC v2 21/35] rust: drm/kms: Introduce DriverCrtc::atomic_check()
Date: Mon, 30 Sep 2024 19:10:04 -0400
Message-ID: <20240930233257.1189730-22-lyude@redhat.com>
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

An optional trait method for implementing a CRTC's atomic state check.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/crtc.rs | 46 +++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 7864540705f76..43c7264402b07 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -27,7 +27,7 @@
     marker::*,
     ptr::{NonNull, null, null_mut, addr_of_mut, self},
     ops::{Deref, DerefMut},
-    mem,
+    mem::{self, ManuallyDrop},
 };
 use macros::vtable;
 
@@ -82,7 +82,7 @@ pub trait DriverCrtc: Send + Sync + Sized {
         helper_funcs: bindings::drm_crtc_helper_funcs {
             atomic_disable: None,
             atomic_enable: None,
-            atomic_check: None,
+            atomic_check: if Self::HAS_ATOMIC_CHECK { Some(atomic_check_callback::<Self>) } else { None },
             dpms: None,
             commit: None,
             prepare: None,
@@ -117,6 +117,21 @@ pub trait DriverCrtc: Send + Sync + Sized {
     ///
     /// Drivers may use this to instantiate their [`DriverCrtc`] object.
     fn new(device: &Device<Self::Driver>, args: &Self::Args) -> impl PinInit<Self, Error>;
+
+    /// The optional [`drm_crtc_helper_funcs.atomic_check`] hook for this crtc.
+    ///
+    /// Drivers may use this to customize the atomic check phase of their [`Crtc`] objects. The
+    /// result of this function determines whether the atomic check passed or failed.
+    ///
+    /// [`drm_crtc_helper_funcs.atomic_check`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_check(
+        crtc: &Crtc<Self>,
+        old_state: &CrtcState<Self::State>,
+        new_state: BorrowedCrtcState<'_, CrtcState<Self::State>>,
+        state: &AtomicStateComposer<Self::Driver>
+    ) -> Result {
+        build_error::build_error("This should not be reachable")
+    }
 }
 
 /// The generated C vtable for a [`DriverCrtc`].
@@ -726,3 +741,30 @@ fn as_raw(&self) -> *mut bindings::drm_crtc_state {
         )
     };
 }
+
+unsafe extern "C" fn atomic_check_callback<T: DriverCrtc>(
+    crtc: *mut bindings::drm_crtc,
+    state: *mut bindings::drm_atomic_state,
+) -> i32 {
+    // SAFETY:
+    // * We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
+    // * We're guaranteed by DRM that `crtc` is pointing to a valid initialized state.
+    let crtc = unsafe { Crtc::from_raw(crtc) };
+
+    // SAFETY: DRM guarantees `state` points to a valid `drm_atomic_state`
+    let state = unsafe {
+        ManuallyDrop::new(AtomicStateComposer::new(NonNull::new_unchecked(state)))
+    };
+
+    // SAFETY: Since we are in the atomic update callback, we're guaranteed by DRM that both the old
+    // and new atomic state are present within `state`
+    let (old_state, new_state) = unsafe {(
+        state.get_old_crtc_state(crtc).unwrap_unchecked(),
+        state.get_new_crtc_state(crtc).unwrap_unchecked(),
+    )};
+
+    from_result(|| {
+        T::atomic_check(crtc, old_state, new_state, &state)?;
+        Ok(0)
+    })
+}
-- 
2.46.1


