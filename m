Return-Path: <linux-kernel+bounces-344992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5100198B0FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C291C218E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1D1A303A;
	Mon, 30 Sep 2024 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfNllZP2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621A1A3030
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739544; cv=none; b=NhMvKgD6MfIBBXd5zhh7OvHZRVrWqo+3ovVs3OdBVJnExD9vksyUZfT17IiAKoTzbvc/c7/e2wVF/vdXrdKYMUYN2wAEw6C2crHYT83BnmszOgsg2yiGCxeoU6EWuN47ksbM5ML9s0uyqNxM2/z3QycU84IibUF7V22WzLTZo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739544; c=relaxed/simple;
	bh=BRSMnz4bgfWkJpxSGaK15GJ9NHwSBth89e3f+w1/k6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ/rJP0Kf1pFVCgWw81xkJdPxqCh9NwZed/yzCjrGeGaUy5ItxmaZOakD/YD5VISfJpbSH9RlvM1bW6w/OfPIe9q8qQXNgNMC+NJTxySDz9X5UtNimIDZ63uj+a1NpBJiBVwaQF28a1CH9/6sjdVlJiVG9rxCI7wNIBq7db5Q/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfNllZP2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xibrkd8yzwA0Iqd6dDSkdoojf7lApu96rDOOBdAdKcQ=;
	b=PfNllZP28CzR4WcgzoRCFUEPn/LsrljnVDQzuW0/6gbjg66fcjMjeydJmdp6BK+RVv0bKA
	r1mnxJ9JU56fjjYyRaOHdnNpC8znOnvtWAjCOqTm6NbT5to4dVtRqHnXNM82L4/xjNMO1m
	nzpXoE7A/M+yKosRVpMtit6Xj+cOOjc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-bjN3m5KvN1iMrZyVKWqy7w-1; Mon,
 30 Sep 2024 19:38:58 -0400
X-MC-Unique: bjN3m5KvN1iMrZyVKWqy7w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37682193EF57;
	Mon, 30 Sep 2024 23:38:56 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 140803003DEC;
	Mon, 30 Sep 2024 23:38:50 +0000 (UTC)
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
Subject: [WIP RFC v2 12/35] rust: drm/kms: Add ConnectorGuard::set_preferred_mode
Date: Mon, 30 Sep 2024 19:09:55 -0400
Message-ID: <20240930233257.1189730-13-lyude@redhat.com>
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

Add a wrapper for `drm_set_preferred_mode()` for our new
`ConnectorGuard` type so we can set the preferred mode for RVKMS
connectors.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/connector.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 7d0f67c3bdaf8..ec842ebc111ae 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -387,6 +387,12 @@ pub fn add_modes_noedid(&self, (max_h, max_v): (i32, i32)) -> i32 {
         // SAFETY: We hold the locks required to call this via our type invariants.
         unsafe { bindings::drm_add_modes_noedid(self.as_raw(), max_h, max_v) }
     }
+
+    /// Set the preferred display mode for the underlying [`Connector`].
+    pub fn set_preferred_mode(&self, (h_pref, w_pref): (i32, i32)) {
+        // SAFETY: We hold the locks required to call this via our type invariants.
+        unsafe { bindings::drm_set_preferred_mode(self.as_raw(), h_pref, w_pref) }
+    }
 }
 
 // SAFETY: DRM expects this struct to be zero-initialized
-- 
2.46.1


