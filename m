Return-Path: <linux-kernel+bounces-547952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6957DA53E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5ECB3A8143
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C89207A10;
	Wed,  5 Mar 2025 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIFwK2Ct"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521620A5D7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216049; cv=none; b=Wj04fLR38zscRI7xswjNGj6SoE7gobDpUZe1iJSKNMCjqp7h6NQf33e0chiBYw7YZMlx5LrlQZ9gvfK9QA5g423VlymIftZKjnW35Lv9aca2qRXKQVx/wK4Wgv/9+vtg6GpgXWJe7ljGeboIjTTeOyISyFhxrs7jSOmokonpZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216049; c=relaxed/simple;
	bh=NbZ0bdhl/7igkfFfMYHwQymMyd27aYPm/3bnZLXn7+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeO4HshUfAnoaBdFbRALAx9Q8Boet4dqc3igQB/RwqMjav2ws9Ni6U1C607NKaE9x9+KfT6mqCYxm8RYJxEYMkkf5OezKQTC4jazhZr/V7dUicOO6pX9HF4WtdAxAUa8mOoMoE784yRs8dzTQNI6yCNU1B59iQ4zeoRj44ao12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIFwK2Ct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebrZLCn49Ar/u+hhgDqOxZKPNPiNI29a3OC6pvuCf4w=;
	b=HIFwK2Ct8puG2QLig8zcM74GlYxNeIPyMnuga8UXEkFUq+Q2pJ2Yn1pbZt8BrgZDPC7jfn
	zDbAaAz0p7HTwkyEC8RDHRZlCI/DIEGN9o+RntPNXy3m0+vmxiKo3zu4mnQnsf6W6xiRzY
	ke0YPOAnqlfDohdaarDZtCG/LxjowrI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-XgmrCJ5TNj6LdSlFvAzo0Q-1; Wed,
 05 Mar 2025 18:05:46 -0500
X-MC-Unique: XgmrCJ5TNj6LdSlFvAzo0Q-1
X-Mimecast-MFC-AGG-ID: XgmrCJ5TNj6LdSlFvAzo0Q_1741215944
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F9A51956087;
	Wed,  5 Mar 2025 23:05:44 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A2A130001A1;
	Wed,  5 Mar 2025 23:05:40 +0000 (UTC)
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
Subject: [RFC v3 08/33] rust: drm/kms: Add UnregisteredConnector::attach_encoder()
Date: Wed,  5 Mar 2025 17:59:24 -0500
Message-ID: <20250305230406.567126-9-lyude@redhat.com>
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

This adds a simple binding for completing the last step of creating a DRM
connector - attaching its encoder. This function should only be called
before the connector is registered, and DRM should enforce this itself by
returning an error if a driver tries to add an encoder to an
already-registered DRM connector.

Note that unlike most of the methods we'll be adding to DRM mode objects,
this is directly implemented on the Connector<T> type since I don't really
think it would make sense for us to allow this operation on an
OpaqueConnector (a DRM connector without a known DriverConnector
implementation, something we'll be adding in the next few commits).

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V3:
* Move to UnregisteredConnector interface
* Improve safety comments

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/connector.rs | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index ed65c06ece627..6fe0a7517bd55 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/drm/drm_connector.h`](srctree/include/drm/drm_connector.h)
 
-use super::{KmsDriver, ModeObject, RcModeObject};
+use super::{encoder::*, KmsDriver, ModeObject, RcModeObject};
 use crate::{
     alloc::KBox,
     bindings,
@@ -362,6 +362,18 @@ pub fn new<'a>(
         // SAFETY: We just allocated the connector above, so this pointer must be valid
         Ok(unsafe { &*this })
     }
+
+    /// Attach an encoder to this [`Connector`].
+    #[must_use]
+    pub fn attach_encoder(&self, encoder: &impl AsRawEncoder) -> Result {
+        // SAFETY:
+        // - Both as_raw() calls are guaranteed to return a valid pointer
+        // - We're guaranteed this connector is not registered via our type invariants, thus this
+        //   function is safe to call
+        to_result(unsafe {
+            bindings::drm_connector_attach_encoder(self.as_raw(), encoder.as_raw())
+        })
+    }
 }
 
 unsafe extern "C" fn connector_destroy_callback<T: DriverConnector>(
-- 
2.48.1


