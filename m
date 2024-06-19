Return-Path: <linux-kernel+bounces-220351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC49D90E017
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D9C1F21523
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E51974FE;
	Tue, 18 Jun 2024 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJbm6px9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A79190693
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754080; cv=none; b=LpBrx7Xv4uhcDWYJjauJOleLNsRvvJtHoX6956k6PA+h98Pi0DPRZCNbajxqellxhR0DaCWfj6ctbPRenqqyb36I9oXIABB0irAKcn6UVF933f52bMsVxwpH/SBCIOGU94mNaTgckYnVtII61teJCj4/ADYwNNlhLJ/cBFvNLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754080; c=relaxed/simple;
	bh=EBw38hbSMJ4L48oAzDUxRJIjvYWmo5x/U079N5zEgOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9IiXyTGfUf3Z1zqT2SQeX0jhpJmFkvduUmJAo3rAx1WsV2bsnTnBOFjGGVVgA0ez0EIVRkL32uoCZnR9fbBVVWsS32WUR/VosgVSti4ugO/UH7mkUYTiejcoHGLP3gpmK1+I08U5PMnA87QMP/FEqTKK+5dtA30TSP3kL/y4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJbm6px9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqI5ygNChRTcl6pYO7gGep9CWBe4/cTEl5OVzb7sLnk=;
	b=hJbm6px95NzWjAZ/aP7WzskQI3MwiTEbXft/kP/9Cqetcz3IU5rfK+RwUhZNGjsFPk2r5a
	bAM4sPEVgyGb71QFiKA/OHg2PVVAggh4vkPLRKf78HbDfkKrtxxGsKFbDb5YjXE0vYZE1R
	Za4hgLtrubutU6eLnSIwWu0quKngOas=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-A2ivHhhLOJe03z1029KaBg-1; Tue, 18 Jun 2024 19:41:16 -0400
X-MC-Unique: A2ivHhhLOJe03z1029KaBg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-362a0c1041dso423361f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754075; x=1719358875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqI5ygNChRTcl6pYO7gGep9CWBe4/cTEl5OVzb7sLnk=;
        b=EvValVjQugFDBTVosd5sdFZboFgQki0x3ZVq79SKT5B8gy04GBLxik+gz1zIbgrvAo
         fEyp3MLsDk8XNH0Rmhh+tIu7a7+7UWJU94ECulHRZnHa2oYehzGND0WSK1IAILrZXW4r
         A7m6mi/thw/Y4Fq1yQSaKNcgiSFdmiRD354xmTf3hVl1i1xXSmsRIcSF4kfW4MtPVzLW
         nbyeBW02MDD7Z4/HkYnOwCJlRdyEWAaXRgkuW3ICJdBo/xTQ1st49xyc1wxXXp3jV0XN
         DrtAt6saNExs89fSrq18zcQLLIe3LB4iglyMyieSUaTqOwefDXwekrf0LKkq7K18YER3
         z2/A==
X-Forwarded-Encrypted: i=1; AJvYcCVnLpOaIhyeKwD9vs81tFX342u0cOXS8BJ+gdk6mWpn2DGJN3en+pui2YNz5qFIMoPl59Z2yINMqZlfBE3NSOsPx8HSBMpmVZPZvcbw
X-Gm-Message-State: AOJu0Yz58zzFfSiN3fnU2NdWrXGcUxBMbyicOQUVtySps29/bw9e6mfv
	HS17IHky6UtZfoCB9Z0WeBy6IrqTxOvpbJ/vzzKcRmNW2PuA4Hdza6UMcC2yMEJvqhAbJPCmD4r
	gvF3YokTCemBPK8X7gm9PKxn6wRWTFrI/InbzAQRgXozv9Vbkah9ghVuFsK+peQ==
X-Received: by 2002:adf:fa44:0:b0:35d:ca63:4e74 with SMTP id ffacd0b85a97d-363199907a4mr576669f8f.70.1718754075086;
        Tue, 18 Jun 2024 16:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhmtLVbtHLOjx+KKo+aXa8pMAKtnnN15KAyO8GWHBuRqRj3fAwBZG4C2+l0meUQKo6/yav/Q==
X-Received: by 2002:adf:fa44:0:b0:35d:ca63:4e74 with SMTP id ffacd0b85a97d-363199907a4mr576644f8f.70.1718754074734;
        Tue, 18 Jun 2024 16:41:14 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114dcfsm15387775f8f.114.2024.06.18.16.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:41:14 -0700 (PDT)
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
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 08/10] rust: add devres abstraction
Date: Wed, 19 Jun 2024 01:39:54 +0200
Message-ID: <20240618234025.15036-9-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618234025.15036-1-dakr@redhat.com>
References: <20240618234025.15036-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust abstraction for the kernel's devres (device resource
management) implementation.

The Devres type acts as a container to manage the lifetime and
accessibility of device bound resources. Therefore it registers a
devres callback and revokes access to the resource on invocation.

Users of the Devres abstraction can simply free the corresponding
resources in their Drop implementation, which is invoked when either the
Devres instance goes out of scope or the devres callback leads to the
resource being revoked, which implies a call to drop_in_place().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/helpers.c        |   6 ++
 rust/kernel/devres.rs | 168 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs    |   1 +
 3 files changed, 175 insertions(+)
 create mode 100644 rust/kernel/devres.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 824b7c0b98dc..269f97698588 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -287,6 +287,12 @@ void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
 EXPORT_SYMBOL_GPL(rust_helper_writeq_relaxed);
 #endif
 
+int rust_helper_devm_add_action(struct device *dev, void (*action)(void *), void *data)
+{
+	return devm_add_action(dev, action, data);
+}
+EXPORT_SYMBOL_GPL(rust_helper_devm_add_action);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
new file mode 100644
index 000000000000..ab0a3eb1ea4f
--- /dev/null
+++ b/rust/kernel/devres.rs
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Devres abstraction
+//!
+//! [`Devres`] represents an abstraction for the kernel devres (device resource management)
+//! implementation.
+
+use crate::{
+    alloc::Flags,
+    bindings,
+    device::Device,
+    error::{Error, Result},
+    prelude::*,
+    revocable::Revocable,
+    sync::Arc,
+};
+
+use core::ffi::c_void;
+use core::ops::Deref;
+
+#[pin_data]
+struct DevresInner<T> {
+    #[pin]
+    data: Revocable<T>,
+}
+
+/// This abstraction is meant to be used by subsystems to containerize [`Device`] bound resources to
+/// manage their lifetime.
+///
+/// [`Device`] bound resources should be freed when either the resource goes out of scope or the
+/// [`Device`] is unbound respectively, depending on what happens first.
+///
+/// To achieve that [`Devres`] registers a devres callback on creation, which is called once the
+/// [`Device`] is unbound, revoking access to the encapsulated resource (see also [`Revocable`]).
+///
+/// After the [`Devres`] has been unbound it is not possible to access the encapsulated resource
+/// anymore.
+///
+/// [`Devres`] users should make sure to simply free the corresponding backing resource in `T`'s
+/// [`Drop`] implementation.
+///
+/// # Example
+///
+/// ```
+/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::Io};
+/// # use core::ops::Deref;
+///
+/// // See also [`pci::Bar`] for a real example.
+/// struct IoMem<const SIZE: usize>(Io<SIZE>);
+///
+/// impl<const SIZE: usize> IoMem<SIZE> {
+///     fn new(paddr: usize) -> Result<Self>{
+///
+///         // SAFETY: assert safety for this example
+///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };
+///         if addr.is_null() {
+///             return Err(ENOMEM);
+///         }
+///
+///         // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
+///         // size `SIZE`.
+///         let io = unsafe { Io::new(addr as _, SIZE)? };
+///
+///         Ok(IoMem(io))
+///     }
+/// }
+///
+/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
+///     fn drop(&mut self) {
+///         // SAFETY: Safe as by the invariant of `Io`.
+///         unsafe { bindings::iounmap(self.0.base_addr() as _); };
+///     }
+/// }
+///
+/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
+///    type Target = Io<SIZE>;
+///
+///    fn deref(&self) -> &Self::Target {
+///        &self.0
+///    }
+/// }
+///
+/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
+/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
+///
+/// let iomem = IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD).unwrap();
+/// let devres = Devres::new(&dev, iomem, GFP_KERNEL).unwrap();
+///
+/// let res = devres.try_access().ok_or(ENXIO).unwrap();
+/// res.writel(0x42, 0x0);
+/// ```
+///
+pub struct Devres<T>(Arc<DevresInner<T>>);
+
+impl<T> DevresInner<T> {
+    fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
+        let inner = Arc::pin_init(
+            pin_init!( DevresInner {
+                data <- Revocable::new(data),
+            }),
+            flags,
+        )?;
+
+        // Convert `Arc<DevresInner>` into a raw pointer and make devres own this reference until
+        // `Self::devres_callback` is called.
+        let data = inner.clone().into_raw();
+        let ret = unsafe {
+            bindings::devm_add_action(dev.as_raw(), Some(Self::devres_callback), data as _)
+        };
+
+        if ret != 0 {
+            // SAFETY: We just created another reference to `inner` in order to pass it to
+            // `bindings::devm_add_action`. If `bindings::devm_add_action` fails, we have to drop
+            // this reference accordingly.
+            let _ = unsafe { Arc::from_raw(data) };
+            return Err(Error::from_errno(ret));
+        }
+
+        Ok(inner)
+    }
+
+    unsafe extern "C" fn devres_callback(ptr: *mut c_void) {
+        let ptr = ptr as *mut DevresInner<T>;
+        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
+        // reference.
+        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
+        //         `DevresInner::new`.
+        let inner = unsafe { Arc::from_raw(ptr) };
+
+        inner.data.revoke();
+    }
+}
+
+impl<T> Devres<T> {
+    /// Creates a new [`Devres`] instance of the given `data`. The `data` encapsulated within the
+    /// returned `Devres` instance' `data` will be revoked once the device is detached.
+    pub fn new(dev: &Device, data: T, flags: Flags) -> Result<Self> {
+        let inner = DevresInner::new(dev, data, flags)?;
+
+        Ok(Devres(inner))
+    }
+
+    /// Same as [Devres::new`], but does not return a `Devres` instance. Instead the given `data`
+    /// is owned by devres and will be revoked / dropped, once the device is detached.
+    pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
+        let _ = DevresInner::new(dev, data, flags)?;
+
+        Ok(())
+    }
+}
+
+impl<T> Deref for Devres<T> {
+    type Target = Revocable<T>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0.data
+    }
+}
+
+impl<T> Drop for Devres<T> {
+    fn drop(&mut self) {
+        // Revoke the data, such that it gets dropped already and the actual resource is freed.
+        // `DevresInner` has to stay alive until the devres callback has been called. This is
+        // necessary since we don't know when `Devres` is dropped and calling
+        // `devm_remove_action()` instead could race with `devres_release_all()`.
+        self.revoke();
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f4dd11014a65..ef9426e32c18 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -31,6 +31,7 @@
 mod build_assert;
 pub mod device;
 pub mod device_id;
+pub mod devres;
 pub mod driver;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
-- 
2.45.1


