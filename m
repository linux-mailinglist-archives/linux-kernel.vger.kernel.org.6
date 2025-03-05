Return-Path: <linux-kernel+bounces-547964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5BA53E3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3013AAD29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED712080CD;
	Wed,  5 Mar 2025 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjG/y25E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0EA20766F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216136; cv=none; b=ujz9zJ3IR4CQbCNZQj/DXIWlM+gLicspL769ABa8BxbCvxIDX5fCjoZnZLUPBjFKitzZLiHN/I0IIq9t6WnVuK58aj9Fm52B3RHVmkNm4nve6r3sfxd9ioTeWYHomETbaX6wA2f8eLTgEDM0M/TxGITDfbf1UVG374MzyoFg1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216136; c=relaxed/simple;
	bh=iDSCLBL5B3BWxOXgvdiVkZne8iKvTHftbvdtBS+FAMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWMacbdUHeOPaZ/cT943np0cpV1Ru/2E0zsQTow/OuBhvagrbzulODZYGSH5q4yGas1yGXAMQKNVBPg5GRJZf0h+WUT19EpL/aX3UC9ZWkzKSKhKui/+ljHikod0dJeCOz/lDKeCn3ImUovPj/TO9b3YfswjzAZ7yh6oHN2v3JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjG/y25E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741216131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRRGIfbn1O4NQuVIAQdXUxnmr9FtR81ZdEGKL5sWc/Q=;
	b=cjG/y25Es1NReX83lC7qSQvBc4tIGw5v7U/Rdb4EXph6sSrpdgmvNmKNI8VNRIYh+iyFNl
	HgsNd0qhZzPmfXntAd0oPRocizA64HcIKRJm4NSJtvlLuBq17EAgS/DPJnXwnzaflcR3Na
	DtOT60YPnRVdDIVDJJBpeIPM54x0S+4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-EymIt6hbNLKfbKEoENAk_A-1; Wed,
 05 Mar 2025 18:08:48 -0500
X-MC-Unique: EymIt6hbNLKfbKEoENAk_A-1
X-Mimecast-MFC-AGG-ID: EymIt6hbNLKfbKEoENAk_A_1741216126
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FE9E1809CA3;
	Wed,  5 Mar 2025 23:08:46 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32191300019E;
	Wed,  5 Mar 2025 23:08:42 +0000 (UTC)
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
	Asahi Lina <lina@asahilina.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC v3 29/33] rust: drm: Add Device::event_lock()
Date: Wed,  5 Mar 2025 17:59:45 -0500
Message-ID: <20250305230406.567126-30-lyude@redhat.com>
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

This is just a crate-private helper to use Lock::from_raw() to provide an
immutable reference to the DRM event_lock, so that it can be used like a
normal rust spinlock. We'll need this for adding vblank related bindings.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/device.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index cf063de387329..3938ceb044645 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -11,6 +11,7 @@
     error::from_err_ptr,
     error::Result,
     ffi,
+    sync::*,
     types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
 };
 use core::{marker::PhantomData, ptr::NonNull};
@@ -154,6 +155,13 @@ pub fn data(&self) -> <T::Data as ForeignOwnable>::Borrowed<'_> {
         unsafe { <T::Data as ForeignOwnable>::from_foreign(drm.raw_data()) };
     }
 
+    /// Returns a reference to the `event` spinlock
+    #[allow(dead_code)]
+    pub(crate) fn event_lock(&self) -> &SpinLockIrq<()> {
+        // SAFETY: `event_lock` is initialized for as long as `self` is exposed to users
+        unsafe { SpinLockIrq::from_raw(&mut (*self.as_raw()).event_lock) }
+    }
+
     pub(crate) const fn has_kms() -> bool {
         <T::Kms as KmsImplPrivate>::MODE_CONFIG_OPS.is_some()
     }
-- 
2.48.1


