Return-Path: <linux-kernel+bounces-547936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C13A53E05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79501892F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF01207E07;
	Wed,  5 Mar 2025 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JY4DQPKS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504F207DF6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215877; cv=none; b=Pn7/vkNevBx9ESxG5gmZR8Xtzf8qxIBKX4AYaau9PNaUTZ6WcK9xINTKGYkoafj6Z20/YUrrKqzL6uw7m2aXa7mTvEhiqRNMDuv/Wrhi7av6XwwnSKDinE7R++3BJF03cj4Pcji7u53Ade+FWNvFdPD7RPm3HHCkxAIBeSwHYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215877; c=relaxed/simple;
	bh=JxVOfLtRbXDIQpGSXtsLb1gfrMiDAnw6ISi3NIo8c1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYLGG4Jf/1oLIDefPZ87Yii3ggdCp5uA8WJQUbW73TozQ7uk/dE8b2dGuPJE7Md6O5hRHtKn+EpgdGJga0KuuVg1o0pGKTnKYOvKd0JEUEsIU0i9zT/n/CBGPbDPbj55sZ+hREhrFaE92YlgM4qYVZH01YqrIbWptvV94vSseJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JY4DQPKS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741215873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIuY6TyfKud/M9WMFn5VR3J80u8Grm+L9fJlJoOSHhY=;
	b=JY4DQPKSXP/BbhrDmlpvkYXh8c+/WVFibfhTcUc3HCuT4Fsit0N3Hx6couZ7UHosGvJpwc
	pCIPMkisBGXFsL3at2qHCEhH9kuROut1lz8q3isN5WjGNH9EfTI3XfcpDj8eksiCBKbdCr
	pmlBrUoamUdyleoVGjM4peVNuJZZK8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-jnJ7gJu3Nuqg6hYvZ-kGQg-1; Wed,
 05 Mar 2025 18:04:29 -0500
X-MC-Unique: jnJ7gJu3Nuqg6hYvZ-kGQg-1
X-Mimecast-MFC-AGG-ID: jnJ7gJu3Nuqg6hYvZ-kGQg_1741215867
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A93A1800349;
	Wed,  5 Mar 2025 23:04:26 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78BB9300019E;
	Wed,  5 Mar 2025 23:04:21 +0000 (UTC)
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
Subject: [RFC v3 01/33] rust: drm: Add a small handful of fourcc bindings
Date: Wed,  5 Mar 2025 17:59:17 -0500
Message-ID: <20250305230406.567126-2-lyude@redhat.com>
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

This adds some very basic rust bindings for fourcc. We only have a single
format code added for the moment, but this is enough to get a driver
registered.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V3:
* Drop FormatList and ModifierList
  These aren't actually needed as pointed out by Louis Chauvet
* Add a constant for FORMAT_MOD_INVALID
  I realized that we actually need this because the format list isn't
  terminated with a 0 like I thought, and we can't pick this up
  automatically through bindgen
* Split out the FormatInfo WIP
  We'll want this someday, but not yet.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/fourcc.rs | 21 +++++++++++++++++++++
 rust/kernel/drm/mod.rs    |  1 +
 2 files changed, 22 insertions(+)
 create mode 100644 rust/kernel/drm/fourcc.rs

diff --git a/rust/kernel/drm/fourcc.rs b/rust/kernel/drm/fourcc.rs
new file mode 100644
index 0000000000000..62203478b5955
--- /dev/null
+++ b/rust/kernel/drm/fourcc.rs
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM fourcc bindings.
+//!
+//! C header: [`include/uapi/drm/drm_fourcc.h`](srctree/include/uapi/drm/drm_fourcc.h)
+
+/// Return a fourcc format code.
+const fn fourcc_code(a: u8, b: u8, c: u8, d: u8) -> u32 {
+    (a as u32) | (b as u32) << 8 | (c as u32) << 16 | (d as u32) << 24
+}
+
+// TODO: We manually import this because we don't have a reasonable way of getting constants from
+// function-like macros in bindgen yet.
+#[allow(dead_code)]
+pub(crate) const FORMAT_MOD_INVALID: u64 = 0xffffffffffffff;
+
+// TODO: We need to automate importing all of these. For the time being, just add the single one
+// that we need
+
+/// 32 bpp RGB
+pub const XRGB888: u32 = fourcc_code(b'X', b'R', b'2', b'4');
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index c44760a1332fa..2c12dbd181997 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -5,5 +5,6 @@
 pub mod device;
 pub mod drv;
 pub mod file;
+pub mod fourcc;
 pub mod gem;
 pub mod ioctl;
-- 
2.48.1


