Return-Path: <linux-kernel+bounces-547945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F61A53E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C503F3AEF84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBDE207E15;
	Wed,  5 Mar 2025 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVN+A+fy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7F207E00
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215983; cv=none; b=bNjzsih478DJdYs2Qf4SNtfSzL5JasXaFZUgmEWy1FE/2tPKv8CfLGsUP6OkDeblrR+/w3ExzGM1ogNS6PWO0AoGOJplDTPUtxLFEEtjKwU/vd+vmGxkAMPY2iHxFn3+qfjr1uXezSbts+dMDVAFV44WRUll5eU2vnNUBJeMQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215983; c=relaxed/simple;
	bh=cuYtKvrflMZ1n9ats9+ViBisYTGhzwQIGCOs7gaVgao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mh7CItM+h4yRokhnIindDyWscOYOv/+soOtOGtB9i3cglVdGfojVhZ5vbrLVvHFLCUAooSGkQGieVFohe+he9SqE0ZR86iz82ldx8a333izeKPu9hfJZqia5xJXvJwdk1t2BDeHo4A6oLPBjzMKij7Y9GjFcnog6YjBRTkmQc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVN+A+fy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741215981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qk/jp+gPRUmslXZDnoYRXtjViDFAYaKs0fIHC124xLM=;
	b=QVN+A+fytFKzIu3k3/3aXN47Do9b9B+Q3QkyAiuirRTskx9eDNnckooafrVrD8SXbguPTc
	DjmZKWF4FHdv3O+JyIFS5ntrnNFJoEnOlVpy64CflImBY8TcmZ7meiM739S118vANrCrAt
	46dsVbjom7rtvXH1tg3haX0CqeEhPPM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-EFdwfM_IOfOKpD2hnobrBw-1; Wed,
 05 Mar 2025 18:06:15 -0500
X-MC-Unique: EFdwfM_IOfOKpD2hnobrBw-1
X-Mimecast-MFC-AGG-ID: EFdwfM_IOfOKpD2hnobrBw_1741215970
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B2B5180AF58;
	Wed,  5 Mar 2025 23:06:10 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAD24300019E;
	Wed,  5 Mar 2025 23:06:05 +0000 (UTC)
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
Subject: [RFC v3 11/33] rust: drm/kms: Add ConnectorGuard::set_preferred_mode
Date: Wed,  5 Mar 2025 17:59:27 -0500
Message-ID: <20250305230406.567126-12-lyude@redhat.com>
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

Add a wrapper for `drm_set_preferred_mode()` for our new
`ConnectorGuard` type so we can set the preferred mode for RVKMS
connectors.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/connector.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 855a47b189a91..244db1cfdc552 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -455,6 +455,12 @@ pub fn add_modes_noedid(&self, (max_h, max_v): (i32, i32)) -> i32 {
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
2.48.1


