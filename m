Return-Path: <linux-kernel+bounces-345003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F3198B119
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2457280F51
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D71AC898;
	Mon, 30 Sep 2024 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUOh7f6k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BF1AC8BB
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739621; cv=none; b=jCzqS30bsanWBicIN+aVBCRjVdfj8ueBbkiREhUtC4lP+MsXSv49EJpKhu0ILooBWBqtfwav4dnJPvyvh8lspAMDv5OlVbqxNyiuVe2YGgzZdTjJSkfMzD1HDCtVhynmoZFX9ZMjxF3mab3VyRGAJxIp6PXULoFXexphLA1BE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739621; c=relaxed/simple;
	bh=zfEHbnw95EVHEw4LX1HX9dfMN4BVaAxa3ZTx98afW2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGPtZIac6Lu5V7otobqBDm7MaHF0jzixwWGu5pMQYDMG+odF8wtqC5wq3nJyaLIi1jrtDLpoa1WKsqe6H3RUhZLhyRTrCNYAeJusoOQPN8Vq5Jq4yOQ2HSiFlGylXlSrHDjaR6WDU8ldFyOsJPwgkxGA42ELmgiXBup3Ab3IYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUOh7f6k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfyGQAtdmrvZOPwaMinkiOwAP5GbXOwQ1SJfQzgrIws=;
	b=KUOh7f6k8VnT+SPLmdngOee9Obg9pNI8LThDnKS0hSsw2f7QmxEczfZaYLVFWjhhEn9hbR
	aj1pkhzpHoks6Ys+cQSPgdbp6heOTwqF2U4KPo/C0g4FnvIerJ2VUYGihvDJ9I5iSV3md1
	bjADv6fg83BneDPCxey+3Y/07t4I4n4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-xZpGV_G_OmSZbwHMYykISQ-1; Mon,
 30 Sep 2024 19:40:15 -0400
X-MC-Unique: xZpGV_G_OmSZbwHMYykISQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 071AE19560B7;
	Mon, 30 Sep 2024 23:40:13 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD4DA3003DEC;
	Mon, 30 Sep 2024 23:40:08 +0000 (UTC)
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
Subject: [WIP RFC v2 22/35] rust: drm/kms: Add DriverPlane::atomic_update()
Date: Mon, 30 Sep 2024 19:10:05 -0400
Message-ID: <20240930233257.1189730-23-lyude@redhat.com>
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

A mandatory trait method used for implementing DRM's atomic plane update
callback.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/plane.rs | 39 +++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index d6e11a65cc101..506ed5ced1270 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -75,7 +75,7 @@ pub trait DriverPlane: Send + Sync + Sized {
             begin_fb_access: None, // TODO: someday?
             end_fb_access: None, // TODO: someday?
             atomic_check: None,
-            atomic_update: None,
+            atomic_update: if Self::HAS_ATOMIC_UPDATE { Some(atomic_update_callback::<Self>) } else { None },
             atomic_enable: None, // TODO
             atomic_disable: None, // TODO
             atomic_async_check: None, // TODO
@@ -103,6 +103,21 @@ pub trait DriverPlane: Send + Sync + Sized {
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
+        plane: &Plane<Self>,
+        new_state: BorrowedPlaneState<'_, PlaneState<Self::State>>,
+        old_state: &PlaneState<Self::State>,
+        state: &AtomicStateMutator<Self::Driver>
+    ) {
+        build_error::build_error("This should not be reachable")
+    }
 }
 
 /// The generated C vtable for a [`DriverPlane`].
@@ -757,3 +772,25 @@ fn deref_mut(&mut self) -> &mut Self::Target {
     // - The cast to `drm_plane_state` is safe via `PlaneState`s type invariants.
     unsafe { bindings::__drm_atomic_helper_plane_reset(plane, Box::into_raw(new).cast()) };
 }
+
+unsafe extern "C" fn atomic_update_callback<T: DriverPlane>(
+    plane: *mut bindings::drm_plane,
+    state: *mut bindings::drm_atomic_state,
+) {
+    // SAFETY:
+    // * We're guaranteed `plane` is of type `Plane<T>` via type invariants.
+    // * We're guaranteed by DRM that `plane` is pointing to a valid initialized state.
+    let plane = unsafe { Plane::from_raw(plane) };
+
+    // SAFETY: DRM guarantees `state` points to a valid `drm_atomic_state`
+    let state = unsafe { AtomicStateMutator::new(NonNull::new_unchecked(state)) };
+
+    // SAFETY: Since we are in the atomic update callback, we're guaranteed by DRM that both the old
+    // and new atomic state are present within `state`
+    let (old_state, new_state) = unsafe {(
+        state.get_old_plane_state(plane).unwrap_unchecked(),
+        state.get_new_plane_state(plane).unwrap_unchecked(),
+    )};
+
+    T::atomic_update(plane, new_state, old_state, &state);
+}
-- 
2.46.1


