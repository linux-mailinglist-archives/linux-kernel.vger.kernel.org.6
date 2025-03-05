Return-Path: <linux-kernel+bounces-547959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42929A53E36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B038173A10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF77211299;
	Wed,  5 Mar 2025 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFrJ+IzX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62DF20E6F9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216085; cv=none; b=Wxp4qcqOt6dosCnyhREWBTTQD5/hiwW1hfcdI/1IxyjR+CqqCxH6wtfPDUV7TaVtTvrvYCgtvsNdAgsz6HuplWIjtCcbelqfmnrCRlz/H95ZpUml//ut51Ykt+HRPoRt6SN5L/uINTdMTJp9mia2XjIn7G2s/x2toB0AzPsEPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216085; c=relaxed/simple;
	bh=HFDmzN6ClWLyWKx53ze9pGYH5MbB28U3H4Vw8SEShxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2+LkO9I0NOaeLVjRp0KNdi6rU66RCEzGsNkbdkgUH3yDZrJ4/ub+B6+uN0pcsNK1dPELe9qrCLYeYghPoztdHkhjtgxmNz7Vy9XQ3oMxLCGKMeb11fxsfp1Uu5YOpaFZEobo47KkHV+dxSdLaYANwdOhnZ0ebpL05WuzLiRTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFrJ+IzX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2VpDj6SMIZeSrAkqn3RnehhHLuj14WMhqBC+m4f1mU=;
	b=HFrJ+IzXY9IU41cyYRWKeDat12lf/kHmsd9lF84XJsKAFnZXIzW9Hn/En9LXVQoHssMbGp
	3mn3soK5aNm32FD3Vu5oWMlNDIsZm4XrKDEZrNQ/AztUgyWSb8taZz4LRIHtUluztDJcyd
	Ds+wH31ymQgF7r3oauUxeO3YglMNIOs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-2v86yqRoN-WEcr2o8c_Y7A-1; Wed,
 05 Mar 2025 18:07:57 -0500
X-MC-Unique: 2v86yqRoN-WEcr2o8c_Y7A-1
X-Mimecast-MFC-AGG-ID: 2v86yqRoN-WEcr2o8c_Y7A_1741216075
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3B1A1800349;
	Wed,  5 Mar 2025 23:07:55 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A62C300019E;
	Wed,  5 Mar 2025 23:07:51 +0000 (UTC)
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
Subject: [RFC v3 23/33] rust: drm/kms: Add RawPlaneState::crtc()
Date: Wed,  5 Mar 2025 17:59:39 -0500
Message-ID: <20250305230406.567126-24-lyude@redhat.com>
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

Add a binding for checking drm_plane_state.crtc. Note that we don't have a
way of knowing what DriverCrtc implementation would be used here (and want
to make this function also available on OpaquePlaneState types), so we
return an OpaqueCrtc.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/plane.rs | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index f3adc30c17489..a30f7f8caaafb 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -5,7 +5,8 @@
 //! C header: [`include/drm/drm_plane.h`](srctree/include/drm/drm_plane.h)
 
 use super::{
-    atomic::*, KmsDriver, ModeObject, ModeObjectVtable, StaticModeObject, UnregisteredKmsDevice,
+    atomic::*, crtc::*, KmsDriver, ModeObject, ModeObjectVtable, StaticModeObject,
+    UnregisteredKmsDevice,
 };
 use crate::{
     alloc::KBox,
@@ -608,6 +609,16 @@ fn plane(&self) -> &Self::Plane {
         // invariant throughout the lifetime of the Plane
         unsafe { Self::Plane::from_raw(self.as_raw().plane) }
     }
+
+    /// Return the current [`OpaqueCrtc`] assigned to this plane, if there is one.
+    fn crtc<'a, 'b: 'a, D>(&'a self) -> Option<&'b OpaqueCrtc<D>>
+    where
+        Self::Plane: ModeObject<Driver = D>,
+        D: KmsDriver,
+    {
+        // SAFETY: This cast is guaranteed safe by `OpaqueCrtc`s invariants.
+        NonNull::new(self.as_raw().crtc).map(|c| unsafe { OpaqueCrtc::from_raw(c.as_ptr()) })
+    }
 }
 impl<T: AsRawPlaneState + ?Sized> RawPlaneState for T {}
 
-- 
2.48.1


