Return-Path: <linux-kernel+bounces-547962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F46A53E39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCDA173BE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72452135CF;
	Wed,  5 Mar 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gp8HOiyX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98920766A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216111; cv=none; b=ByzdTOArBKngy7+Fzz1UxlSYv9m7XknQKHFtsXohWzqXMMwDv9xLAVlqEJlIvDy2b4OhKf4nub3HLUgnsKPUYoOVvUSJ6rNtFoeGfLt0PmSfVixkOtEx0YXmxc8F9paqocoCw/YaXUoxW6tsVqGnalHbDKCGUJCPPOlMtBbv49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216111; c=relaxed/simple;
	bh=uO/FvDhy3vUg1lr4d+ThWPV2s11M41Ft7r7+gQi1714=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NojEqCaUL3WCdLuTnFJS88hi7BwhmbcZdZHh9KiAZs9KSU5Z2NCgfm2y8GsuoMWkMseiUqU4BOmaxkgT10nGAjLHzM9o+e+Ye+np90R0iDgp2Mi2G63Qystc8oVtuvDMcGzWkjLHV1U5fNWFKbAaOq49CXFxz+0zwELSnv66YMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gp8HOiyX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGaidaXItPxvHOgKUEqHTZ0I38IyrDd5JklCvf8qG1Y=;
	b=Gp8HOiyXpqGjGLLcMmjluXKufEYPkxpQp+Jp0NuL0/9ZXht/w/bP9SjAlAqFzNpUMN0Se+
	g6hCvGKZKS0TOWocGs/4Ky++XZq+0rAsUB7BG/5MqyPZz713KsV0CjWZIjs0ubwSHH7OMK
	FQbXapj6R8fD1xwpZEVXYjr7ZtLhjeo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-7W8r-8dGNmCViAT1HOLdig-1; Wed,
 05 Mar 2025 18:08:27 -0500
X-MC-Unique: 7W8r-8dGNmCViAT1HOLdig-1
X-Mimecast-MFC-AGG-ID: 7W8r-8dGNmCViAT1HOLdig_1741216105
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB601195605E;
	Wed,  5 Mar 2025 23:08:24 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4CA9300019E;
	Wed,  5 Mar 2025 23:08:20 +0000 (UTC)
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
Subject: [RFC v3 26/33] rust: drm/kms: Add RawPlane::framebuffer()
Date: Wed,  5 Mar 2025 17:59:42 -0500
Message-ID: <20250305230406.567126-27-lyude@redhat.com>
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

Returns the Framebuffer currently assigned in an atomic plane state.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/framebuffer.rs |  1 -
 rust/kernel/drm/kms/plane.rs       | 18 +++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/kms/framebuffer.rs b/rust/kernel/drm/kms/framebuffer.rs
index 5a60b580fe0bf..99f366e8813e2 100644
--- a/rust/kernel/drm/kms/framebuffer.rs
+++ b/rust/kernel/drm/kms/framebuffer.rs
@@ -66,7 +66,6 @@ impl<T: KmsDriver> Framebuffer<T> {
     /// The caller guarantews that `ptr` points to a initialized `struct drm_framebuffer` for at
     /// least the entire lifetime of `'a`.
     #[inline]
-    #[allow(dead_code)]
     pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_framebuffer) -> &'a Self {
         // SAFETY: Our data layout is identical to drm_framebuffer
         unsafe { &*ptr.cast() }
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 63b453b7307fd..1d50632ae473f 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/drm/drm_plane.h`](srctree/include/drm/drm_plane.h)
 
 use super::{
-    atomic::*, crtc::*, KmsDriver, ModeObject, ModeObjectVtable, StaticModeObject,
+    atomic::*, crtc::*, framebuffer::*, KmsDriver, ModeObject, ModeObjectVtable, StaticModeObject,
     UnregisteredKmsDevice,
 };
 use crate::{
@@ -646,6 +646,22 @@ fn atomic_helper_check<S, D>(
             )
         })
     }
+
+    /// Return the framebuffer currently set for this plane state
+    #[inline]
+    fn framebuffer<D>(&self) -> Option<&Framebuffer<D>>
+    where
+        Self::Plane: ModeObject<Driver = D>,
+        D: KmsDriver,
+    {
+        // SAFETY: The layout of Framebuffer<T> is identical to `fb`
+        unsafe {
+            self.as_raw()
+                .fb
+                .as_ref()
+                .map(|fb| Framebuffer::from_raw(fb))
+        }
+    }
 }
 impl<T: AsRawPlaneState + ?Sized> RawPlaneState for T {}
 
-- 
2.48.1


