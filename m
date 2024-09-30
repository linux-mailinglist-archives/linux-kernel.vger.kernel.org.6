Return-Path: <linux-kernel+bounces-345007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDCE98B11D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08B7281E99
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F411A3045;
	Mon, 30 Sep 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huyVhplM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523C188A3E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739653; cv=none; b=sBce6cr3P1Wq4bV2BMNV4wb68oprCS58kIc76DwGyTuijOav8Vd4ul38iCQ/8UDNYUaTjeJ9NvUWVoYDMwif4L2+oCsZJHBR2XB14iJM6x9/PjvNPmwD2y8woMmo2GYbIq5PMoqW6VjX+5U3LzHf5VWI97muLPgPILDvR1jnLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739653; c=relaxed/simple;
	bh=8Gy2EvSvWd770balBZF1QEDDsL9x1cn4XZHt/qO0WII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr3mANUBrcaL4Vqdl3qULlFbg5/XfNISEznn/THFNXh8Dx45uDsUlxn9aJqGpCBQ4ziX9FKgfixqOJJfgnM5PG1T8l2btuVdjO4jiDAIpQicQnELDszO7vrabs5PyHfASB3z2E+pYh91cw/1raOHo8+NRJ4LN7zplhOC2x2r3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=huyVhplM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r65mS9fGP6QHa8ZJthkFLot5TCFWUe3W7tgNCeGtS+Y=;
	b=huyVhplMcMgR58rdtGQrI30Xpz/s4K1EK/aF59V/iB77ERanL/KxQLtPDRYYNYd1/8blur
	LO+PNy5AiYXMvpZDQvu0eX46Pruu3K2HOdfWESjCwbqliouGJogOJkGQmym94dE2HQeAHF
	sT6cY0lBHwLltGtVSji+F9HMZkm7q/A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-YGuzUkxzNLKTlLsoR2qN7w-1; Mon,
 30 Sep 2024 19:40:47 -0400
X-MC-Unique: YGuzUkxzNLKTlLsoR2qN7w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC143196A433;
	Mon, 30 Sep 2024 23:40:44 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C03833003DEC;
	Mon, 30 Sep 2024 23:40:40 +0000 (UTC)
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
Subject: [WIP RFC v2 26/35] WIP: rust: drm/kms: Add RawPlaneState::atomic_helper_check()
Date: Mon, 30 Sep 2024 19:10:09 -0400
Message-ID: <20240930233257.1189730-27-lyude@redhat.com>
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

Add a binding for drm_atomic_helper_check_plane_state(). Since we want to
make sure that the user is passing in the new state for a Crtc instead of
an old state, we explicitly ask for a reference to a BorrowedCrtcState.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

TODO:
* Add support for scaling options

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/plane.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 4d16d53179fca..cd5167e6441f1 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -496,6 +496,31 @@ fn crtc<'a, 'b: 'a>(&'a self) -> Option<&'b OpaqueCrtc<<Self::Plane as ModeObjec
         // SAFETY: This cast is guaranteed safe by `OpaqueCrtc`s invariants.
         NonNull::new(self.as_raw().crtc).map(|c| unsafe { OpaqueCrtc::from_raw(c.as_ptr()) })
     }
+
+    /// Run the atomic check helper for this plane and the given CRTC state
+    fn atomic_helper_check<S>(
+        &mut self,
+        crtc_state: &BorrowedCrtcState<'_, S>,
+        can_position: bool,
+        can_update_disabled: bool
+    ) -> Result
+    where
+        S: FromRawCrtcState,
+        S::Crtc: AsRawCrtc<Driver = <Self::Plane as ModeObject>::Driver>
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
+                can_update_disabled
+            )
+        })
+    }
 }
 impl<T: AsRawPlaneState + ?Sized> RawPlaneState for T {}
 
-- 
2.46.1


