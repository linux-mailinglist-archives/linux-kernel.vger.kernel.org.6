Return-Path: <linux-kernel+bounces-345009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C598B11F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAE41C21AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68671A264B;
	Mon, 30 Sep 2024 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THdhzqhA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628C1A38D5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739669; cv=none; b=j0wlU+XZlcyXn/hJf+cqccD7XM2DfPvv8pnmFET+fVcwEiUi5n/JVmgPYIeKWOJNOerkJ3yBhwFtSkVF+rQk504VCoIPQub2fQtI+HchHpuoSgfaHSB00Td2Cdpo7uCgcoEPiCWwEmuncPNJ7Q+NYY9djzMo2H2Y+P7cXSjh5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739669; c=relaxed/simple;
	bh=jU6RZ0YUCmZIbC7xhdPk67c/tjszUhAsumc04l8wVCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYrFQCc+U8OsJPwe1SwaHC0ugvISalFQxZsLf5hkohIoL/selKwQKTbWkw+6hGTY2JuvyTmivTunvcUgYJKHye2ADlIsvxziEUTNYHmRb9EC+bChMLSjLgN1t9TJlGqOvWFpbldi+xWH+M1CoRDXzO99FcOl6WNC9ZdYwbcIQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THdhzqhA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAGxt+7QcVJP+8MJM9swQ0ElPs58C/YHAc6dcv4hB6c=;
	b=THdhzqhAUckIViLBCBLG1mIZaKwxllWAlavqC6MNTYjZuJxfMKGAZjDHOkbOJnEx5TtPIj
	y/AAK3XT77vm2aY3St7IwL2MdEJTQT9EGY3ehgFqbuztozBQkwLnxqjYlRAMpJeKQXE3Gp
	puyzar8LzArR6YGTTI8JASYoeUvdtCQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-T8aDwVKTNQu0bBm4d0eZrg-1; Mon,
 30 Sep 2024 19:41:02 -0400
X-MC-Unique: T8aDwVKTNQu0bBm4d0eZrg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FCB719192B1;
	Mon, 30 Sep 2024 23:41:00 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F3933003E4D;
	Mon, 30 Sep 2024 23:40:56 +0000 (UTC)
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
Subject: [WIP RFC v2 28/35] rust: drm/kms: Add RawPlane::framebuffer()
Date: Mon, 30 Sep 2024 19:10:11 -0400
Message-ID: <20240930233257.1189730-29-lyude@redhat.com>
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

Returns the Framebuffer currently assigned in an atomic plane state.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/plane.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index cd5167e6441f1..15efa53fda8d3 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -31,6 +31,7 @@
     StaticModeObject,
     atomic::*,
     crtc::*,
+    framebuffer::*,
 };
 
 /// The main trait for implementing the [`struct drm_plane`] API for [`Plane`]
@@ -521,6 +522,13 @@ fn atomic_helper_check<S>(
             )
         })
     }
+
+    /// Return the framebuffer currently set for this plane state
+    #[inline]
+    fn framebuffer(&self) -> Option<&Framebuffer<<Self::Plane as ModeObject>::Driver>> {
+        // SAFETY: The layout of Framebuffer<T> is identical to `fb`
+        unsafe { self.as_raw().fb.as_ref().map(|fb| Framebuffer::from_raw(fb)) }
+    }
 }
 impl<T: AsRawPlaneState + ?Sized> RawPlaneState for T {}
 
-- 
2.46.1


