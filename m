Return-Path: <linux-kernel+bounces-547956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B057A53E33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE4B3A1FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C531F76B5;
	Wed,  5 Mar 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGM6kt2a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962472066FF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216079; cv=none; b=E+OrRnQ2qY20UkvnYYkaeaVPp+PIJhTQQQXQlEpVq/mfWnE8g5Vh3cDowoajoDKgMZRWOF58HuurkmgsOlJFaOQ1n3VjZDfP36UrZGpQ5jbidk0hoOS9h15HLicWo/oRSFQtgqUg/x3eCSVWytZlTQ+Gpn1vMo993/V/RWwhdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216079; c=relaxed/simple;
	bh=0ZuwPDudrCakJsAqrir16bTSWYDMXS0Di7v5Px72Guk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPLy7bvN70/7oCNE5ALrB10xfjpmAOJHR8Ej4zRbGkWbZfKQeN4pGaxFwwu6pemXTDemhNy+vSSclLx76AKwVRcCgCayPr66Qe1iEGuxUpKDLrpOUp2yun4zC7ZytBTUMjx684Dwzr+7OIS4KozZL1QTtrkNpWhyLzdY1DpCAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGM6kt2a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Sa15p0zk9/0E89lqNYU9Y3htAIogxJ6GNdp/TIXh9E=;
	b=eGM6kt2aOXAEpis+tdf3QF9BsC2L4zkOMbFtv3j6IQuHRdQG87lL1LiSH570yxacCN2zlB
	qjxHrm3DZZ35RFphrtye2DoYnCSE/vUrxpzY6IsgZ+s3yxVGvoowBFHLnH8oX1fQ33NJcS
	qUUZ7hB/xlDLvTxaB7LmBZr3yyBTwsA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-gMt0t3KrPU-Esgh-380sOA-1; Wed,
 05 Mar 2025 18:07:36 -0500
X-MC-Unique: gMt0t3KrPU-Esgh-380sOA-1
X-Mimecast-MFC-AGG-ID: gMt0t3KrPU-Esgh-380sOA_1741216054
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E452E18001D0;
	Wed,  5 Mar 2025 23:07:33 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 802F5300019E;
	Wed,  5 Mar 2025 23:07:30 +0000 (UTC)
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
Subject: [RFC v3 20/33] rust: drm/kms: Add DriverPlane::atomic_update()
Date: Wed,  5 Mar 2025 17:59:36 -0500
Message-ID: <20250305230406.567126-21-lyude@redhat.com>
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

A mandatory trait method used for implementing DRM's atomic plane update
callback.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/plane.rs | 45 +++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 4e73c2966ca22..b090aebc35649 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -70,7 +70,11 @@ pub trait DriverPlane: Send + Sync + Sized {
             begin_fb_access: None,
             end_fb_access: None,
             atomic_check: None,
-            atomic_update: None,
+            atomic_update: if Self::HAS_ATOMIC_UPDATE {
+                Some(atomic_update_callback::<Self>)
+            } else {
+                None
+            },
             atomic_enable: None,
             atomic_disable: None,
             atomic_async_check: None,
@@ -98,6 +102,21 @@ pub trait DriverPlane: Send + Sync + Sized {
     ///
     /// Drivers may use this to instantiate their [`DriverPlane`] object.
     fn new(device: &Device<Self::Driver>, args: Self::Args) -> impl PinInit<Self, Error>;
+
+    /// The optional [`drm_plane_helper_funcs.atomic_update`] hook for this plane.
+    ///
+    /// Drivers may use this to customize the atomic update phase of their [`Plane`] objects. If not
+    /// specified, this function is a no-op.
+    ///
+    /// [`drm_plane_helper_funcs.atomic_update`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_update(
+        _plane: &Plane<Self>,
+        _new_state: PlaneStateMutator<'_, PlaneState<Self::State>>,
+        _old_state: &PlaneState<Self::State>,
+        _state: &AtomicStateMutator<Self::Driver>,
+    ) {
+        build_error::build_error("This should not be reachable")
+    }
 }
 
 /// The generated C vtable for a [`DriverPlane`].
@@ -931,3 +950,27 @@ fn <D, P>(PlaneStateMutator<'a, OpaquePlaneState<D>>) -> Self
     // - The cast to `drm_plane_state` is safe via `PlaneState`s type invariants.
     unsafe { bindings::__drm_atomic_helper_plane_reset(plane, KBox::into_raw(new).cast()) };
 }
+
+unsafe extern "C" fn atomic_update_callback<T: DriverPlane>(
+    plane: *mut bindings::drm_plane,
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // - We're guaranteed `plane` is of type `Plane<T>` via type invariants.
+    // - We're guaranteed by DRM that `plane` is pointing to a valid initialized state.
+    let plane = unsafe { Plane::from_raw(plane) };
+
+    // SAFETY: DRM guarantees `state` points to a valid `drm_atomic_state`
+    let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
+
+    // SAFETY: Since we are in the atomic update callback, we're guaranteed by DRM that both the old
+    // and new atomic state are present within `state`
+    let (old_state, new_state) = unsafe {
+        (
+            state.get_old_plane_state(plane).unwrap_unchecked(),
+            state.get_new_plane_state(plane).unwrap_unchecked(),
+        )
+    };
+
+    T::atomic_update(plane, new_state, old_state, &state);
+}
-- 
2.48.1


