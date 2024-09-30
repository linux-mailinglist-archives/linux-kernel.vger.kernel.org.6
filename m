Return-Path: <linux-kernel+bounces-345012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394D298B122
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDFB1C21B75
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ED61A3BC1;
	Mon, 30 Sep 2024 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Evo3jf4J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129CB1A3BAD
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739690; cv=none; b=dRNQ7gMkSDQtaPYr2KuFxrpqk5o0EMWbKbE0+3N3B7uK98duiz8RNQUjNGAoQS/a/2N9VI2LqPA21mRIY9HSyiiTnXpi2ttx2ge65pnEf0oefpIlobXnnU2hxP8WNiXRELF4croROUdMj3zb2t0Kjw2DVciikdIH0MNwXHtutxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739690; c=relaxed/simple;
	bh=gs5zsr5bhCVvBotuDA0Ru/OSxIx8/bdVamssKd6EjM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIZa0CEEjXHj13c6pbn5brBT0YKNQhzNgr9S9zXQGw/PR4lxFb6kiJQv32447WqWm480/NI3l0hY8MllicQa3Y3RTfz4R65xI0XXAGXLngPISJw1/n0BPORVSCNLGKTL0qQxnOF3nPPLg1N8TazK1mGZZDXcGh34ycq7zl1HHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Evo3jf4J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhLeLvV27GzVDMIsND1hL5s5tE+smtYvQODvZdGLp1k=;
	b=Evo3jf4JzWzaCBfPLhV7XgjTQhpb71vHcLKxMeBS78Ynzlm2w0B/F6LN8h+Jn9T8t7YFWy
	IQ0NY/qr5PSJk8S0pldH/OdhzKsJDhoa1FTyc+05nMcIAWCcN7og9LZV/fiWX6cfN8ipdh
	owbtjQz7dFP2G572Rb64p9y159wLS6o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-JvvOGLywPfqNFpiwe3YSlg-1; Mon,
 30 Sep 2024 19:41:22 -0400
X-MC-Unique: JvvOGLywPfqNFpiwe3YSlg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 800D1194511A;
	Mon, 30 Sep 2024 23:41:20 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA03A3003DEC;
	Mon, 30 Sep 2024 23:41:16 +0000 (UTC)
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
	Danilo Krummrich <dakr@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [WIP RFC v2 31/35] rust: drm: Add Device::event_lock()
Date: Mon, 30 Sep 2024 19:10:14 -0400
Message-ID: <20240930233257.1189730-32-lyude@redhat.com>
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

This is just a crate-private helper to use Lock::from_raw() to provide an
immutable reference to the DRM event_lock, so that it can be used like a
normal rust spinlock. We'll need this for adding vblank related bindings.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/device.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index d4d6b1185f6a6..207e7ea87cf8f 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -15,6 +15,7 @@
     error::from_err_ptr,
     error::Result,
     types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
+    sync::*,
 };
 use core::{
     ffi::c_void,
@@ -159,6 +160,12 @@ pub fn data(&self) -> <T::Data as ForeignOwnable>::Borrowed<'_> {
         unsafe { <T::Data as ForeignOwnable>::from_foreign(drm.raw_data()) };
     }
 
+    /// Returns a reference to the `event` spinlock
+    pub(crate) fn event_lock(&self) -> &SpinLockIrq<()> {
+        // SAFETY: `event_lock` is initialized for as long as `self` is exposed to users
+        unsafe { SpinLockIrq::from_raw(&mut (*self.as_raw()).event_lock) }
+    }
+
     pub(crate) const fn has_kms() -> bool {
         <T::Kms as KmsImplPrivate>::MODE_CONFIG_OPS.is_some()
     }
-- 
2.46.1


