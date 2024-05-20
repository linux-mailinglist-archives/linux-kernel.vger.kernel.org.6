Return-Path: <linux-kernel+bounces-184006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C418CA158
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C97282030
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659C813A259;
	Mon, 20 May 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMBSD8ss"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB953E13
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226041; cv=none; b=oMJAJ8tlvcoIDnDhZfbEt1njbL0nzQSePeAH8XB+GMnx4BymCuTLzTyJr0hbgid1QdBy5+Qpqk7ZW3hl9XfmQiuvqYVr0yOStrQzqQ3MDqaL+X1swsM2w57NWk9f1RF72ukHUcG6qkGvjbfx+tOPFhn8Nl6j8eOHy0BAE0N8TSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226041; c=relaxed/simple;
	bh=Xo1H50xmNmCwFq/YzacitBz7yAiTOIYKpZRdmQ6Ez64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6osESgAKVPt9kGI1ekivO1pv1mkNeqnuoVrWytw+ZzJIMmQLmUgyy/Fsd+6PokyMur+Mff6zECjVt+EY8Xcvi/0pmf0AzkaYw5CHU8ncJKrUzJIbSobPIt+bZGye/fqt0YpFmPNb7G3dgZ25x9Bhh504uj7w/N63+qcMoRzYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMBSD8ss; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agQximp23XkAIvccriflMJpmlFVjIztZE/y37x455Bs=;
	b=dMBSD8sspjv5W/6vGT6Ze+AozAX26Mo2Hz5M1w/0US+aJbxhr5FmoYbAP/c/uiHTrADkbB
	WAMy8nwt8UzRVM7NI/zUcCL+/0j++Q8nmzrHnvXWGMcFhERWKaMOXVFfGmUbjYb+F9Qbdj
	hSMda63zTqzl1mF9R83k/hwvkvCsUgk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-uMHFYx9fM4G6oKTQRfWSHA-1; Mon, 20 May 2024 13:27:17 -0400
X-MC-Unique: uMHFYx9fM4G6oKTQRfWSHA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34f7618a1f2so6485229f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226036; x=1716830836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agQximp23XkAIvccriflMJpmlFVjIztZE/y37x455Bs=;
        b=dA2gb6tp+KzcXu5fCUh3pii5W6PKp9MCnfadZ+sNL9yEouEob0RrwBf3aEXuZt52CK
         uipNaZUPpT8qWvx4b1bkBt1yyq4wzR3RY8Bw0cwFKgmFDwQpScLteDTx8AWseSGw+VQQ
         a/3y2NQmH78dhOGOmx/zh3EMprrI1LPLNbKrblSiGZsElnm0TZtlPaTpbkW4qWQ8bXjK
         J/+6gO1QnnPamaHOhzAJpVD0Tg989u7+8rfNXVLfxPpUNND7A7ThNv1HDIoQXqWHvWvm
         31Sx0LnhOD82v5hu/i7aaGfTUyIsLiECvnogxfeqSBVhZk2nYR6+vhH9CSQc0f9hBzb6
         n/mA==
X-Forwarded-Encrypted: i=1; AJvYcCUIspH7p0TZxu0NZ/chLja0QsaQYIPdHU7XIlh0bGhUMugWVz2NV2wbjX4+1h582qYew1D+jJ4k1v/wGA2rn8w+fEKbOgZFWY7daPn1
X-Gm-Message-State: AOJu0Yw1ZHyw7BjunVBkiu7NPPA7N/t94s0CJBsgZWjwPUE9wnvjkskc
	hynmo1GITBUfS483udjgjdWuBbCNr4tvKh4ufLWH9dxdkv+CfOerxH2GR3ERUao0bzVUT321VAk
	tRw3kVJtUfUVTPQq2zbo3dx6WsO9E9zBlcV2wHv5D1d3Lf6qIALKh6fChZIzkHg==
X-Received: by 2002:a5d:6350:0:b0:34d:8206:e76b with SMTP id ffacd0b85a97d-354b8df9230mr5873130f8f.9.1716226036481;
        Mon, 20 May 2024 10:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyj+aQzyFz124Ivaxlo9plfP8f/ni9Dw8Yk9DDidlmWu1q+cPLQmubwDGw7A6qtXoC6DrB8Q==
X-Received: by 2002:a5d:6350:0:b0:34d:8206:e76b with SMTP id ffacd0b85a97d-354b8df9230mr5873110f8f.9.1716226036132;
        Mon, 20 May 2024 10:27:16 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3518d817ee2sm25948722f8f.2.2024.05.20.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:27:15 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH 06/11] rust: add device::Data
Date: Mon, 20 May 2024 19:25:43 +0200
Message-ID: <20240520172554.182094-7-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520172554.182094-1-dakr@redhat.com>
References: <20240520172554.182094-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a generic type `device::Data` to represent driver specific data bound
to a device.

`device::Data` also stores and allows access to registrations, which are
revoked automatically when the corresponding device is unbound, even if
the `device::Data`'s reference count is non-zero.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/device.rs | 103 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index fafec70effb6..b1c3f7a0d623 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -4,11 +4,24 @@
 //!
 //! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
 
+use macros::pin_data;
+
 use crate::{
+    alloc::flags::*,
     bindings,
+    error::Result,
+    init::InPlaceInit,
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    sync::{LockClassKey, RevocableMutex, RevocableMutexGuard, UniqueArc},
     types::{ARef, Opaque},
 };
-use core::ptr;
+use core::{
+    ops::{Deref, DerefMut},
+    pin::Pin,
+    ptr,
+};
 
 /// A ref-counted device.
 ///
@@ -74,3 +87,91 @@ unsafe impl Send for Device {}
 // SAFETY: `Device` only holds a pointer to a C device, references to which are safe to be used
 // from any thread.
 unsafe impl Sync for Device {}
+
+/// Device data.
+///
+/// When a device is unbound (for whatever reason, for example, because the device was unplugged or
+/// because the user decided to unbind the driver), the driver is given a chance to clean up its
+/// state.
+///
+/// The device data is reference-counted because other subsystems may hold pointers to it; some
+/// device state must be freed and not used anymore, while others must remain accessible.
+///
+/// This struct separates the device data into two categories:
+///   1. Registrations: are destroyed when the device is removed.
+///   2. General data: remain available as long as the reference count is nonzero.
+///
+/// This struct implements the `DeviceRemoval` trait such that `registrations` can be revoked when
+/// the device is unbound.
+#[pin_data]
+pub struct Data<T, U> {
+    #[pin]
+    registrations: RevocableMutex<T>,
+    #[pin]
+    general: U,
+}
+
+/// Safely creates an new reference-counted instance of [`Data`].
+#[doc(hidden)]
+#[macro_export]
+macro_rules! new_device_data {
+    ($reg:expr, $gen:expr, $name:literal) => {{
+        static CLASS1: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
+        let regs = $reg;
+        let gen = $gen;
+        let name = $crate::c_str!($name);
+        $crate::device::Data::try_new(regs, gen, name, &CLASS1)
+    }};
+}
+
+impl<T, U> Data<T, U> {
+    /// Creates a new instance of `Data`.
+    ///
+    /// It is recommended that the [`new_device_data`] macro be used as it automatically creates
+    /// the lock classes.
+    pub fn try_new(
+        registrations: T,
+        general: impl PinInit<U>,
+        name: &'static CStr,
+        key1: &'static LockClassKey,
+    ) -> Result<Pin<UniqueArc<Self>>> {
+        let ret = UniqueArc::pin_init(
+            pin_init!(Self {
+                registrations <- RevocableMutex::new(
+                    registrations,
+                    name,
+                    key1,
+                ),
+                general <- general,
+            }),
+            GFP_KERNEL,
+        )?;
+
+        Ok(ret)
+    }
+
+    /// Returns the locked registrations if they're still available.
+    pub fn registrations(&self) -> Option<RevocableMutexGuard<'_, T>> {
+        self.registrations.try_write()
+    }
+}
+
+impl<T, U> crate::driver::DeviceRemoval for Data<T, U> {
+    fn device_remove(&self) {
+        self.registrations.revoke();
+    }
+}
+
+impl<T, U> Deref for Data<T, U> {
+    type Target = U;
+
+    fn deref(&self) -> &U {
+        &self.general
+    }
+}
+
+impl<T, U> DerefMut for Data<T, U> {
+    fn deref_mut(&mut self) -> &mut U {
+        &mut self.general
+    }
+}
-- 
2.45.1


