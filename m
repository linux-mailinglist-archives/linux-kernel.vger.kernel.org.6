Return-Path: <linux-kernel+bounces-345011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B898B121
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45530282189
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AD1A2848;
	Mon, 30 Sep 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htIPRR7G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0F1AF4F2
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739680; cv=none; b=KA8arVVB8wgN0LdnciwCOkxPnQfDSphXDGz/osixU8WN6IOlbMyidBLiz2L2CNlgs4oua+XLz7paFUALfv3iWb/fNwojM89kKdKVUHBLgivswJmTTntdC1UZqg96hvpJ6pV1VJ3WVDX2WmpSZ2S+Y33L2VSUHYE1j+qLqykCw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739680; c=relaxed/simple;
	bh=8EhYnKqnh/v61mVD1vIYxnLqRDNhv4pH2Nk6IhQ1/u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFYZjsxSZsNn9mn56crf0RJk4dSKwLbyJIQCID3oCnpP7gGfcAfyLvIBpO+IKWRZN8qOZ4obZRYB32qMFb1yVO5NU/Aj61JqY7HUUgG8AOwBJn5ceXqIZU5GTDvCbCXz/U4S/2dekl+TwAjbrX9nz5MSywD5eateBfL8YIfVSG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htIPRR7G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hf2PwgqqoorfI7tgNpCFOlFnV5DzwsS0y6C7e13QCQQ=;
	b=htIPRR7GAy3XrnQ2NSuVSYyUwieq7lQlHqfuNXo7nnie4HXirESiJnG62uBeVFqyctv76v
	k/EqRIhPGjBoxoHi6Mu+XfNlrs/6yjBBG4cCzvOdHSqdaRXbjQuKuSWj72IO9GMmmWCddP
	DoX0Vv242vmzpiC6GgYJ60k3vHDgPlo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-_xPnOvVNMX-5Pb_SaZ2qGQ-1; Mon,
 30 Sep 2024 19:41:16 -0400
X-MC-Unique: _xPnOvVNMX-5Pb_SaZ2qGQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 583F8196D18E;
	Mon, 30 Sep 2024 23:41:14 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EB443003DEC;
	Mon, 30 Sep 2024 23:41:10 +0000 (UTC)
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
Subject: [WIP RFC v2 30/35] rust: drm/kms: Add DriverCrtc::atomic_enable() and atomic_disable()
Date: Mon, 30 Sep 2024 19:10:13 -0400
Message-ID: <20240930233257.1189730-31-lyude@redhat.com>
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

Optional trait methods for implementing the atomic_enable and
atomic_disable callbacks of a CRTC.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/crtc.rs | 76 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index a4e955364bd8c..ef1b331f742d0 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -80,8 +80,8 @@ pub trait DriverCrtc: Send + Sync + Sized {
         },
 
         helper_funcs: bindings::drm_crtc_helper_funcs {
-            atomic_disable: None,
-            atomic_enable: None,
+            atomic_disable: if Self::HAS_ATOMIC_DISABLE { Some(atomic_disable_callback::<Self>) } else { None },
+            atomic_enable: if Self::HAS_ATOMIC_ENABLE { Some(atomic_enable_callback::<Self>) } else { None },
             atomic_check: if Self::HAS_ATOMIC_CHECK { Some(atomic_check_callback::<Self>) } else { None },
             dpms: None,
             commit: None,
@@ -162,6 +162,34 @@ fn atomic_flush(
     ) {
         build_error::build_error("This should never be reachable")
     }
+
+    /// The optional [`drm_crtc_helper_funcs.atomic_enable`] hook.
+    ///
+    /// This hook will be called before enabling a [`Crtc`] in an atomic commit.
+    ///
+    /// [`drm_crtc_helper_funcs.atomic_enable`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_enable(
+        crtc: &Crtc<Self>,
+        old_state: &CrtcState<Self::State>,
+        new_state: BorrowedCrtcState<'_, CrtcState<Self::State>>,
+        state: &AtomicStateMutator<Self::Driver>
+    ) {
+        build_error::build_error("This should never be reachable")
+    }
+
+    /// The optional [`drm_crtc_helper_funcs.atomic_disable`] hook.
+    ///
+    /// This hook will be called before disabling a [`Crtc`] in an atomic commit.
+    ///
+    /// [`drm_crtc_helper_funcs.atomic_disable`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_disable(
+        crtc: &Crtc<Self>,
+        old_state: &CrtcState<Self::State>,
+        new_state: BorrowedCrtcState<'_, CrtcState<Self::State>>,
+        state: &AtomicStateMutator<Self::Driver>
+    ) {
+        build_error::build_error("This should never be reachable")
+    }
 }
 
 /// The generated C vtable for a [`DriverCrtc`].
@@ -850,3 +878,47 @@ fn as_raw(&self) -> *mut bindings::drm_crtc_state {
 
     T::atomic_flush(crtc, old_state, new_state, &state);
 }
+
+unsafe extern "C" fn atomic_enable_callback<T: DriverCrtc>(
+    crtc: *mut bindings::drm_crtc,
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // * We're guaranteed `crtc` is of type `Crtc<T>` via type invariants.
+    // * We're guaranteed by DRM that `crtc` is pointing to a valid initialized state.
+    let crtc = unsafe { Crtc::from_raw(crtc) };
+
+    // SAFETY: DRM never passes an invalid ptr for `state`
+    let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
+
+    // SAFETY: We're in an atomic enable callback, so we know that both the new and old state are
+    // present
+    let (old_state, new_state) = unsafe {(
+        state.get_old_crtc_state(crtc).unwrap_unchecked(),
+        state.get_new_crtc_state(crtc).unwrap_unchecked(),
+    )};
+
+    T::atomic_enable(crtc, old_state, new_state, &state);
+}
+
+unsafe extern "C" fn atomic_disable_callback<T: DriverCrtc>(
+    crtc: *mut bindings::drm_crtc,
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // * We're guaranteed `crtc` points to a valid instance of `drm_crtc`
+    // * We're guaranteed that `crtc` is of type `Plane<T>` by `DriverPlane`s type invariants.
+    let crtc = unsafe { Crtc::from_raw(crtc) };
+
+    // SAFETY: We're guaranteed that `state` points to a valid `drm_crtc_state` by DRM
+    let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
+
+    // SAFETY: We're in an atomic commit callback, so we know that both the new and old state are
+    // present
+    let (old_state, new_state) = unsafe {(
+        state.get_old_crtc_state(crtc).unwrap_unchecked(),
+        state.get_new_crtc_state(crtc).unwrap_unchecked(),
+    )};
+
+    T::atomic_disable(crtc, old_state, new_state, &state);
+}
-- 
2.46.1


