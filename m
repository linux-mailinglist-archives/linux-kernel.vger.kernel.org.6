Return-Path: <linux-kernel+bounces-547958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16016A53E34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B0E3A1640
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3CD20E328;
	Wed,  5 Mar 2025 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIiG+4VY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8220E010
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216081; cv=none; b=XfKiHjeGlbCA47+TY/Sk0w325Yw5hlM3I3mi5wxQw77pv4EpE8n0P+7nKnPbGtg2D/hbsfPfTcnfA35k4GCrma4kgSh90rX3Yx4TTkWT6cRAZi2XnhZWi2hZoQe10bIB1fpsiiXJ1qVOJK+BGdol1NypEvwuvLJgZ3ZthN6IzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216081; c=relaxed/simple;
	bh=aaLSN9RN3gmYzBHJpU5ewiDXbcZaSZXt4IfHYWgoc/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9koSV6+msMKDm3YZ1+jxJYmS655FqE41e2ZJ2lql32+btFc0RTIGbwRgtEBRgyE+Amyr13yJvdoR04OaBdllKZzuirvnXH2hk7jTLrn7zjNaDhfNzhwBjJRfr+tAPrnjVQ34Mr1wm4b6E0TjyZnggUJtA5VyDdD+I/o3tOqLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIiG+4VY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9knJ5NY3utv62oPTmxDgFn+ShbZu7msy2bjZd2Ss7KQ=;
	b=SIiG+4VYbKWVLYRWv78cjsCeIBWVBIw1pNTNEesg3jxjjNtQauGZbEoC1oVmlg583g7J2t
	8tEekDcdLwa/MZy8DRXr39O5ncM7hbs4XFFHzWyXMupUd42F63QLpoqmDsWMICMXBViUVW
	deV5t4B6uZURLn4tslpyYIe96FfLKmk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-49tX_X7rPSCi0De8hFzj0Q-1; Wed,
 05 Mar 2025 18:07:50 -0500
X-MC-Unique: 49tX_X7rPSCi0De8hFzj0Q-1
X-Mimecast-MFC-AGG-ID: 49tX_X7rPSCi0De8hFzj0Q_1741216068
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9481E19560BA;
	Wed,  5 Mar 2025 23:07:48 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA261300019E;
	Wed,  5 Mar 2025 23:07:44 +0000 (UTC)
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
Subject: [RFC v3 22/33] rust: drm/kms: Add RawCrtcState::active()
Date: Wed,  5 Mar 2025 17:59:38 -0500
Message-ID: <20250305230406.567126-23-lyude@redhat.com>
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

A binding for checking drm_crtc_state.active.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/crtc.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 50f5b68f4a3fe..99719c4e288e6 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -607,6 +607,14 @@ fn crtc(&self) -> &Self::Crtc {
         //   state
         unsafe { <Self::Crtc as AsRawCrtc>::from_raw((*self.as_raw()).crtc) }
     }
+
+    /// Returns whether or not the CRTC is active in this atomic state.
+    fn active(&self) -> bool {
+        // SAFETY: `active` and the rest of its containing bitfield can only be modified from the
+        // atomic check context, and are invariant beyond that point - so our interface can ensure
+        // this access is serialized
+        unsafe { (*self.as_raw()).active }
+    }
 }
 impl<T: AsRawCrtcState> RawCrtcState for T {}
 
-- 
2.48.1


