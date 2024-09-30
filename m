Return-Path: <linux-kernel+bounces-345005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26898B11B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4DE1C21A28
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8CB1AD40F;
	Mon, 30 Sep 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FA9mF/D2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FC1A262F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739635; cv=none; b=iNBWVddhBKh7yRegja9zeBZ5wTJIkXikXskpLXZkRs54unm/5dTR9dGN7pW0+fVYxVociGJTCBsGnQXSv+Ojmvjb4Mko+9/KehLhCwjI8fMqelcym8NgceP+HBHDrT2agDndIz/Iakr14RmFYgP/ZN6Q7TRFVtGLXMIwev4jp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739635; c=relaxed/simple;
	bh=/kwts4hSPl1B28vmVUNcbKh3gOb5ZFKw04vEOVyavqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/AUfvY1DiohtCRP0GmSnoc0W71GZUfH+ZtBVEmLgJ2/hurslwFOXRtDLVk+jyJNRVs2/QhD/YrbS3k8FfUdhaogkNwNVitQLxrPquBOnon08xF461GAclAGCWKCtfstqq/1HqlqZ6b4VlTfELBzw9SkKmvbYgn25rkVQIFtzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FA9mF/D2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60V41hOGujHu5sr/jwQK4i2saVJBJYoo6sOpK9L71eA=;
	b=FA9mF/D20FIxcEGGKV6ciNwFrk3dppNFvhfEs5S/i/VcjOAbGID4k2E2IT+lSBHC+5SGDZ
	kRB+4s0PaUEIOGavIeiSgVwxaXGZ0GjQPdN1Fzsq/C4adiupp9ORsX4M9wfK/i0jruRwQz
	FcY+EdB++zJlMmJWvntxkXtui11bjSw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-QVcBuQXJPZC4PTHFCIUINA-1; Mon,
 30 Sep 2024 19:40:29 -0400
X-MC-Unique: QVcBuQXJPZC4PTHFCIUINA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE0DC19626D7;
	Mon, 30 Sep 2024 23:40:26 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22E813003E4D;
	Mon, 30 Sep 2024 23:40:22 +0000 (UTC)
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
Subject: [WIP RFC v2 24/35] rust: drm/kms: Add RawCrtcState::active()
Date: Mon, 30 Sep 2024 19:10:07 -0400
Message-ID: <20240930233257.1189730-25-lyude@redhat.com>
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

A binding for checking drm_crtc_state.active.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/crtc.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 43c7264402b07..ec9b58763dcca 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -496,6 +496,14 @@ fn crtc(&self) -> &Self::Crtc {
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
2.46.1


