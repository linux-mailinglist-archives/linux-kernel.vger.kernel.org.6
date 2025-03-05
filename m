Return-Path: <linux-kernel+bounces-547960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2A3A53E37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DCF3A6589
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D79220E6F9;
	Wed,  5 Mar 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ppm9fh8l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2F20764E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216093; cv=none; b=lUUcYpmqO/lQ2Z8Yy58XvgBRoiESxOTeegGl1def7Qd55u9tlyB86bIHG+GJ/tPiILq1sVlKbpk0ryEAqWIN3a1xraSf8leuyT6gxcBC7EI/HPRe+VJMzCitgZHJIqK9f+iRgeYLhWvdYvG+yW2PctH20VIg72RwYNuMH8LwxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216093; c=relaxed/simple;
	bh=CLFoibv3F/2cu4dY6+8tFXH1EgnWuBIEXhvC4dAPsWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLKjHwOrQ1tczutGZFjjxjNgyFsAL9I2csSkSzr3Zx7QyTRuzumeq94wXYlVdB7gwuLj9DEji6rYMkKofyvjNxyeBHsOa1hI728v6FEiXjRLNn5syBpt/es7nSceYnP5nl2Ss2MZ54iT0j0dTUYWQ45gvOcu7fQeOFsepz/GPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ppm9fh8l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGbLhta6NjlzPjR8SQEXQQ3XRNfxpmzeftS1Pw9ReGk=;
	b=Ppm9fh8lDOLKS0/iOibkbGrQ9VEg+dm6Vzv81w7NR0ggvrJ1fthiee46oD1WnOHwXmh/GI
	H8TpLMPMA8ZUv8f/Qt+NipCii5jL1XqZjaUiqo2Uidjf0g+on9qpBvh7AzBw9dFazLNH/w
	byTSa3qV/5lRb3ltpRE1ve/RMd+VKko=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-NEQZTfTCPGGuhlnexhj2qg-1; Wed,
 05 Mar 2025 18:08:08 -0500
X-MC-Unique: NEQZTfTCPGGuhlnexhj2qg-1
X-Mimecast-MFC-AGG-ID: NEQZTfTCPGGuhlnexhj2qg_1741216086
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA39218001D7;
	Wed,  5 Mar 2025 23:08:05 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4906B300019E;
	Wed,  5 Mar 2025 23:08:02 +0000 (UTC)
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
Subject: [RFC v3 24/33] rust: drm/kms: Add RawPlaneState::atomic_helper_check()
Date: Wed,  5 Mar 2025 17:59:40 -0500
Message-ID: <20250305230406.567126-25-lyude@redhat.com>
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

Add a binding for drm_atomic_helper_check_plane_state(). Since we want to
make sure that the user is passing in the new state for a Crtc instead of
an old state, we explicitly ask for a reference to a CrtcStateMutator.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/crtc.rs  |  2 ++
 rust/kernel/drm/kms/plane.rs | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 99719c4e288e6..aaa208b35c3c1 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -593,6 +593,8 @@ pub trait AsRawCrtcState {
     }
 }
 
+pub(super) use private::AsRawCrtcState as AsRawCrtcStatePrivate;
+
 /// Common methods available on any type which implements [`AsRawCrtcState`].
 ///
 /// This is implemented internally by DRM, and provides many of the basic methods for working with
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index a30f7f8caaafb..63b453b7307fd 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -619,6 +619,33 @@ fn crtc<'a, 'b: 'a, D>(&'a self) -> Option<&'b OpaqueCrtc<D>>
         // SAFETY: This cast is guaranteed safe by `OpaqueCrtc`s invariants.
         NonNull::new(self.as_raw().crtc).map(|c| unsafe { OpaqueCrtc::from_raw(c.as_ptr()) })
     }
+
+    /// Run the atomic check helper for this plane and the given CRTC state.
+    fn atomic_helper_check<S, D>(
+        &mut self,
+        crtc_state: &CrtcStateMutator<'_, S>,
+        can_position: bool,
+        can_update_disabled: bool,
+    ) -> Result
+    where
+        D: KmsDriver,
+        S: FromRawCrtcState,
+        S::Crtc: ModesettableCrtc + ModeObject<Driver = D>,
+        Self::Plane: ModeObject<Driver = D>,
+    {
+        // SAFETY: We're passing the mutable reference from `self.as_raw_mut()` directly to DRM,
+        // which is safe.
+        to_result(unsafe {
+            bindings::drm_atomic_helper_check_plane_state(
+                self.as_raw_mut(),
+                crtc_state.as_raw(),
+                bindings::DRM_PLANE_NO_SCALING as _, // TODO: add parameters for scaling
+                bindings::DRM_PLANE_NO_SCALING as _,
+                can_position,
+                can_update_disabled,
+            )
+        })
+    }
 }
 impl<T: AsRawPlaneState + ?Sized> RawPlaneState for T {}
 
-- 
2.48.1


