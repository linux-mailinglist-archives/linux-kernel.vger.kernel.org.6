Return-Path: <linux-kernel+bounces-394432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC89BAF16
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DE92814BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190AF1AE00B;
	Mon,  4 Nov 2024 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEg0s3d7"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F91ACDF0;
	Mon,  4 Nov 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711253; cv=none; b=Y2MLLWgXhAIh1Fj5Lt8iSF5DJVA651hYga0lYGGjCo7FG+k26c8oGqAkAg3+W4bDq4Ewm8L5ExkAjmsq4vNJSWUIzoxkKZop+sOyyJRuicPgkbllCP+fYfXB9arPugZptv2kq4cC/DraaDa3xt/FNT7myVm34/JEerIwSRqX+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711253; c=relaxed/simple;
	bh=b4HpGAD8/H+EFsnaQ23A1FKmj3D4cx0gWZbjsIi06kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxeeTPEtfxhZQcb3O9WJHuNCeb6iLZe5eHWjFTFbyCh2UtaixKdNUp4QT2NJzQV6JC+qrzho/lDTQfVlf3qkqRzKt+4hbqvHQz9wCMIbGFb7peUctUUI7KVWeDx57AroqbEvNZ+UooPrtbnePbuYWsPBiMl7PqT3TKNpzCIO4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEg0s3d7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so32147731fa.1;
        Mon, 04 Nov 2024 01:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730711249; x=1731316049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyVy7gdr0CZOajhFw0hRqDhU/vkb7fugb2BQinDJKQ0=;
        b=fEg0s3d7l/2mDTA/c3P86k26S9x2b11f8/AzV27EA9jPklt0uUtxDFCM+AChV0dGD/
         sh4/R3TStVgv6W/0OUvOnLBZAdSTHgdSyGe+Eq4LAQQhuHrQxK/0PuG3y6OYCSfKbRy7
         Ymwf5i+Wk1u+Bz1uEkDwja8P9DpqIFempBHEIK7QoQOcEMpGzdB6H7k3EBZ8w6Uxg5OP
         Kde3zdmACYhkwsqqystdCZMYyKhcJCc//85gznzYUF9RCXCFTsLtCt/PR+vz+wRsfI0G
         xx2d9RALEjggXQNruxbeLg+oFU69TysAHXHAdq+fNSChtFMXa2Y25BMjSCGafOc5NVdi
         v4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711249; x=1731316049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyVy7gdr0CZOajhFw0hRqDhU/vkb7fugb2BQinDJKQ0=;
        b=CB+LoA7Wh6zFwAt08wIzxhVjk7dl4sBBm+ofKeDN+0draaXWwhIz8M8lRo4lycoYi/
         g+md40IqRK2n1GEx15CUTLTc7tF63Sy+/QlcHwIMk3SakQF2MQScT2QFmVi9/TD7uEyt
         SsXTx6YGngdrsGHcRnf67+xI0wYGJvDgqxUr9UwY9gX0HSH0/5Z3Ru/Px8p7HRN/lG0D
         u/q4CNiqq9xiiV1e8AmcBwa0EGJXVbkqZbtksmgFy4PgaOOwHk+XmIY8hnGlE11Fxt7+
         vZG1rYBHXGT93u2rZ5vd6O9NpI/ojNwCqLOE/xobnda9z2tpuLCMzYzVcqo2SxS2x/u3
         vnmg==
X-Forwarded-Encrypted: i=1; AJvYcCUyZkK6xkdf/jDLObxNlMgJTirUmwopk4Y3osW/73tlaRZ7KNEs5XdbiLfDdLFhWpU+dqxfb9PL5u9THEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cAu1oCjFI5rYfeTaDjOZklJyzdTSSSIOHPnIXlTHo946Q5ck
	MUBwe95jZxZUDibNc1fKpN8qKs5V7OSPbzOFcYvnBDzQWtALTcajNQj7Cg==
X-Google-Smtp-Source: AGHT+IH/3d4VHUKEdA3D23Z/rS1PfIASMm1BkVuuCsSeHaTvMGlya7IrOnJtKqCwswyZtiDB7W7hNQ==
X-Received: by 2002:a05:651c:2204:b0:2fb:50e9:34b4 with SMTP id 38308e7fff4ca-2fdec47a3f4mr71696251fa.8.1730711249306;
        Mon, 04 Nov 2024 01:07:29 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a6070sm15829991fa.89.2024.11.04.01.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:07:27 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: daniel.almeida@collabora.com,
	a.hindborg@kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v3 2/2] rust: add dma coherent allocator abstraction.
Date: Mon,  4 Nov 2024 11:06:34 +0200
Message-ID: <20241104090711.3000818-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104090711.3000818-1-abdiel.janulgue@gmail.com>
References: <20241104090711.3000818-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple dma coherent allocator rust abstraction. Based on
Andreas Hindborg's dma abstractions from the rnvme driver.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 165 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 167 insertions(+)
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a80783fcbe04..3ff2abbfaef6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/dma-mapping.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
new file mode 100644
index 000000000000..75a304d612f0
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Direct memory access (DMA).
+//!
+//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::code::*,
+    error::Result,
+    types::ARef,
+};
+use core::ops::Add;
+
+/// Abstraction of dma_alloc_coherent
+///
+/// # Invariants
+///
+/// For the lifetime of an instance of CoherentAllocation, the cpu address is a valid pointer
+/// to an allocated region of consistent memory and we hold a reference to the device.
+pub struct CoherentAllocation<T: Add> {
+    dev: ARef<Device>,
+    dma_handle: bindings::dma_addr_t,
+    count: usize,
+    cpu_addr: *mut T,
+}
+
+impl<T: Add> CoherentAllocation<T> {
+    /// Allocates a region of `size_of::<T> * count` of consistent memory.
+    ///
+    /// Returns a CoherentAllocation object which contains a pointer to the allocated region
+    /// (in the processor's virtual address space) and the device address which can be
+    /// given to the device as the DMA address base of the region. The region is released once
+    /// [`CoherentAllocation`] is dropped.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::device::Device;
+    /// use kernel::dma::CoherentAllocation;
+    ///
+    /// # fn dox(dev: &Device) -> Result<()> {
+    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL)?;
+    /// # Ok(()) }
+    /// ```
+    pub fn alloc_coherent(
+        dev: &Device,
+        count: usize,
+        flags: kernel::alloc::Flags,
+    ) -> Result<CoherentAllocation<T>> {
+        let t_size = core::mem::size_of::<T>();
+        let size = count.checked_mul(t_size).ok_or(EOVERFLOW)?;
+        let mut dma_handle = 0;
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        // We ensure that we catch the failure on this function and throw an ENOMEM
+        let ret = unsafe {
+            bindings::dma_alloc_attrs(
+                dev.as_raw(),
+                size,
+                &mut dma_handle, flags.as_raw(),
+                0,
+            )
+        };
+        if ret.is_null() {
+            return Err(ENOMEM)
+        }
+
+        Ok(Self {
+            dev: dev.into(),
+            dma_handle,
+            count,
+            cpu_addr: ret as _,
+        })
+    }
+
+    /// Reads a value on a location specified by index.
+    pub fn read(&self, index: usize) -> Result<T>
+    where
+        T: Copy
+    {
+        if let Some(val) = self.cpu_buf().get(index) {
+            Ok(*val)
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Write a value on the memory location specified by index.
+    pub fn write(&mut self, index: usize, value: &T) -> Result
+    where
+        T: Copy,
+    {
+        if let Some(elem) = self.cpu_buf_mut().get_mut(index) {
+            *elem = *value;
+            Ok(())
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Performs a read and then a write of a value on a location specified by index.
+    pub fn read_write(&mut self, index: usize, value: &T) -> Result<T>
+    where
+        T: Copy,
+    {
+        if let Some(elem) = self.cpu_buf_mut().get_mut(index) {
+            let val = *elem;
+            *elem = *value;
+            Ok(val)
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Returns the base address to the allocated region and the dma handle.
+    /// Caller takes ownership of returned resources.
+    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
+        let ret = (self.cpu_addr as _, self.dma_handle);
+        core::mem::forget(self);
+        ret
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space.
+    pub fn start_ptr(&self) -> *const T {
+        self.cpu_addr as _
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space as
+    /// a mutable pointer.
+    pub fn start_ptr_mut(&mut self) -> *mut T {
+        self.cpu_addr
+    }
+
+    /// Returns a DMA handle which may given to the device as the DMA address base of
+    /// the region.
+    pub fn dma_handle(&self) -> bindings::dma_addr_t {
+        self.dma_handle
+    }
+
+    fn cpu_buf(&self) -> &[T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
+    }
+
+    fn cpu_buf_mut(&mut self) -> &mut [T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
+    }
+}
+
+impl<T: Add> Drop for CoherentAllocation<T> {
+    fn drop(&mut self) {
+        let size = self.count * core::mem::size_of::<T>();
+        // SAFETY: the device, cpu address, and the dma handle is valid due to the
+        // type invariants on `CoherentAllocation`.
+        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
+                                          self.cpu_addr as _,
+                                          self.dma_handle, 0) }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b62451f64f6e..b713c92eb1ef 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -32,6 +32,7 @@
 pub mod block;
 mod build_assert;
 pub mod device;
+pub mod dma;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.43.0


