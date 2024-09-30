Return-Path: <linux-kernel+bounces-345000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C587198B116
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718FE1F239D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851418CBEF;
	Mon, 30 Sep 2024 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbVC+cGR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238F18C918
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739605; cv=none; b=Q0G5Xq3zLX0cczUxUadyhyR1dHNHH+/t4rMijbdaL0j+Sjm9ZE83SfQQUh3Q33kcNZdoEOC2I9v8IyIGZ19jxOeMxBlXkHJY8+lUKu9RaB5cFXjuPzYFBdQ+09dxf1ZacVLKt/xuzTv7iRffKNsktnVp7s0/Yt4wytEOe343VjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739605; c=relaxed/simple;
	bh=CWQ/Z7+JMtIRyM+rYwRIt+GcOiYv8t397WrLGcU+DCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyS41fN6xdez3S5tELrB725hCS0VnfkfHDxNlxX1CtacQi6PLqYTUkIxD3tQ7QuGCy7zto1c5GBZODtoAu50wfrsuMRvsy2vBQJGZGht3Bxec8jwTXXNZy4RCLcfOBjWEK1Leb6fFCm3xS844cEvX6A5FeMyAZXddRzKBmtODbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbVC+cGR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9gbDuyNEQzpSC0vAhmZzo+JcWQOY6GTcF09aFJMUz8=;
	b=MbVC+cGR3PWEJe6/K/XnBISw/vxWbQOSonn8w8oadW2zhcF9pxjGVnF6YtCrsL3O2X3IXk
	MBQp9Q2KUK5f1sF8ZOIJ0GkBo7x8KNWY84Rc+V59ONGQy3O8WPhMYv7OSOayA1+fK/wl8C
	iSVybVT0/cMTJL3gPffZn60qJqJ3yCg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-8xusCUW9P3-5hWO4SgwbBw-1; Mon,
 30 Sep 2024 19:39:38 -0400
X-MC-Unique: 8xusCUW9P3-5hWO4SgwbBw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2E5C196A40C;
	Mon, 30 Sep 2024 23:39:35 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9A5F3003DEC;
	Mon, 30 Sep 2024 23:39:32 +0000 (UTC)
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
Subject: [WIP RFC v2 18/35] rust: drm/kms: Add RawPlane and RawPlaneState
Date: Mon, 30 Sep 2024 19:10:01 -0400
Message-ID: <20240930233257.1189730-19-lyude@redhat.com>
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

Same thing as RawCrtc and RawCrtcState, but for DRM planes now

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/plane.rs | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 3ace487316d46..1c151ae3b3dcc 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -312,6 +312,27 @@ unsafe impl<T: DriverPlane> Send for Plane<T> {}
 // SAFETY: Our interface is thread-safe.
 unsafe impl<T: DriverPlane> Sync for Plane<T> {}
 
+/// Common methods available on any type which implements [`AsRawPlane`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// planes.
+pub trait RawPlane: AsRawPlane {
+    /// Return the index of this DRM plane
+    #[inline]
+    fn index(&self) -> u32 {
+        // SAFETY: The index is initialized by the time we expose `Plane` objects to users, and is
+        // invariant throughout the lifetime of the `Plane`
+        unsafe { (*self.as_raw()).index }
+    }
+
+    /// Return the index of this DRM plane in the form of a bitmask
+    #[inline]
+    fn mask(&self) -> u32 {
+        1 << self.index()
+    }
+}
+impl<T: AsRawPlane> RawPlane for T {}
+
 /// A [`struct drm_plane`] without a known [`DriverPlane`] implementation.
 ///
 /// This is mainly for situations where our bindings can't infer the [`DriverPlane`] implementation
@@ -426,6 +447,20 @@ pub trait FromRawPlaneState: AsRawPlaneState {
     unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_plane_state) -> &'a mut Self;
 }
 
+/// Common methods available on any type which implements [`AsRawPlane`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// the atomic state of [`Plane`]s.
+pub trait RawPlaneState: AsRawPlaneState {
+    /// Return the plane that this plane state belongs to.
+    fn plane(&self) -> &Self::Plane {
+        // SAFETY: The index is initialized by the time we expose Plane objects to users, and is
+        // invariant throughout the lifetime of the Plane
+        unsafe { Self::Plane::from_raw(self.as_raw().plane) }
+    }
+}
+impl<T: AsRawPlaneState + ?Sized> RawPlaneState for T {}
+
 /// The main interface for a [`struct drm_plane_state`].
 ///
 /// This type is the main interface for dealing with the atomic state of DRM planes. In addition, it
-- 
2.46.1


