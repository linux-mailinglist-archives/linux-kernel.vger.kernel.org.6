Return-Path: <linux-kernel+bounces-547957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBF2A53E35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D139188484E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B5206F2E;
	Wed,  5 Mar 2025 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfW0uduS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717F20E00A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216081; cv=none; b=Yig5jKVrcaOBIR3lDHSYal/CMCi1q5tnWDCAR/La7UcCjyFzd8cwNszvkmusqWge2riyKsspmNm9ynlJJzZdvGsud9l5Y0O+fgRlf8+5hLWQG5ctq/McxYouUhNON9bCo01JjfPI/tC8P1OaADYXHH5ekK8MBAIF/VHU0K3IAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216081; c=relaxed/simple;
	bh=ykwsaVKw1mpzv+yYZMIqJXcCjgnimTVnBDdZ4X7g/y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Le+dMp/v0HhyLrR5PfHdyzaM54fX7y84iOlLSAy9IxNwPwVKwbr35602nPunbD8ZUcxCv/Tl1A/3AP+TH2Z9WJqED1YulXVnkStD7lWn0J+D2PegIOJGXima7afcG+qQdqAizkCynHhMtUL8HJJBx55nFsP7iASWZsiXHLLIZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfW0uduS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8Wya8waZxf4PRUJ4SmPnCKJ5/8nzDdWThNqRlGolhE=;
	b=hfW0uduSvcnBON9t4ktmTfj4jMsIxnnq5qW2+If/L+EmPdVbYtphjqZOJJwoPtNcDHBn7m
	IOVEOt/vjrayGkA0AxLrXKeL2euYpiIUlYOJI2RzARMfgv++YjhWb7ZgvbnSnVlsO9JYYd
	6bRbSrJ/bO/48Q9tiKWCZppJLAKNPws=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-fTF3WE_ONlOJowyS2fczRQ-1; Wed,
 05 Mar 2025 18:07:43 -0500
X-MC-Unique: fTF3WE_ONlOJowyS2fczRQ-1
X-Mimecast-MFC-AGG-ID: fTF3WE_ONlOJowyS2fczRQ_1741216061
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C3631800262;
	Wed,  5 Mar 2025 23:07:41 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAB83300019E;
	Wed,  5 Mar 2025 23:07:37 +0000 (UTC)
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
Subject: [RFC v3 21/33] rust: drm/kms: Add DriverPlane::atomic_check()
Date: Wed,  5 Mar 2025 17:59:37 -0500
Message-ID: <20250305230406.567126-22-lyude@redhat.com>
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

Optional trait method for implementing a plane's atomic_check().

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V3:
* Document ManuallyDrop uses better

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/plane.rs | 53 ++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index b090aebc35649..f3adc30c17489 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -11,7 +11,7 @@
     alloc::KBox,
     bindings,
     drm::{device::Device, fourcc::*},
-    error::{to_result, Error},
+    error::{from_result, to_result, Error},
     init::Zeroable,
     prelude::*,
     private::Sealed,
@@ -20,7 +20,7 @@
 use core::{
     cell::Cell,
     marker::*,
-    mem,
+    mem::{self, ManuallyDrop},
     ops::*,
     pin::Pin,
     ptr::{addr_of_mut, null, null_mut, NonNull},
@@ -69,7 +69,11 @@ pub trait DriverPlane: Send + Sync + Sized {
             cleanup_fb: None,
             begin_fb_access: None,
             end_fb_access: None,
-            atomic_check: None,
+            atomic_check: if Self::HAS_ATOMIC_CHECK {
+                Some(atomic_check_callback::<Self>)
+            } else {
+                None
+            },
             atomic_update: if Self::HAS_ATOMIC_UPDATE {
                 Some(atomic_update_callback::<Self>)
             } else {
@@ -117,6 +121,21 @@ fn atomic_update(
     ) {
         build_error::build_error("This should not be reachable")
     }
+
+    /// The optional [`drm_plane_helper_funcs.atomic_check`] hook for this plane.
+    ///
+    /// Drivers may use this to customize the atomic check phase of their [`Plane`] objects. The
+    /// result of this function determines whether the atomic check passed or failed.
+    ///
+    /// [`drm_plane_helper_funcs.atomic_check`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn atomic_check(
+        _plane: &Plane<Self>,
+        _new_state: PlaneStateMutator<'_, PlaneState<Self::State>>,
+        _old_state: &PlaneState<Self::State>,
+        _state: &AtomicStateComposer<Self::Driver>,
+    ) -> Result {
+        build_error::build_error("This should not be reachable")
+    }
 }
 
 /// The generated C vtable for a [`DriverPlane`].
@@ -974,3 +993,31 @@ fn <D, P>(PlaneStateMutator<'a, OpaquePlaneState<D>>) -> Self
 
     T::atomic_update(plane, new_state, old_state, &state);
 }
+
+unsafe extern "C" fn atomic_check_callback<T: DriverPlane>(
+    plane: *mut bindings::drm_plane,
+    state: *mut bindings::drm_atomic_state,
+) -> i32 {
+    // SAFETY:
+    // - We're guaranteed `plane` is of type `Plane<T>` via type invariants.
+    // - We're guaranteed by DRM that `plane` is pointing to a valid initialized state.
+    let plane = unsafe { Plane::from_raw(plane) };
+
+    // SAFETY: We're guaranteed by DRM that `state` points to a valid instance of `drm_atomic_state`
+    // We use ManuallyDrop here since AtomicStateComposer would otherwise drop a owned reference to
+    // the atomic state upon finishing this callback.
+    let state = ManuallyDrop::new(unsafe {
+        AtomicStateComposer::<T::Driver>::new(NonNull::new_unchecked(state))
+    });
+
+    // SAFETY: We're guaranteed by DRM that both the old and new atomic state are present within
+    // this `drm_atomic_state`
+    let (old_state, new_state) = unsafe {
+        (
+            state.get_old_plane_state(plane).unwrap_unchecked(),
+            state.get_new_plane_state(plane).unwrap_unchecked(),
+        )
+    };
+
+    from_result(|| T::atomic_check(plane, new_state, old_state, &state).map(|_| 0))
+}
-- 
2.48.1


