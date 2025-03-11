Return-Path: <linux-kernel+bounces-556636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780E0A5CCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C683B9996
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A796D2638BE;
	Tue, 11 Mar 2025 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC7HJpin"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBD2638A5;
	Tue, 11 Mar 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715394; cv=none; b=W8u8sL0IGXiophtHrrkdZnIqDDub5T5LAZJv0ea1Hw/xi1dHeai8nu9+ZwpOnBHHKjXIW+K7nU76ugkoA0zZiyfKMIIfXvFn6ycqREgxBe8QuEDWhPgDkXi9y7qoVntkPpk0psyGJhL3+lU4mSeVZkiYvofEQd0ryd6b+tduAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715394; c=relaxed/simple;
	bh=NPurUptvYolnP+zwLTc8xyODM40c1STXAevHbBUYyUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7cxaq+gn0VKfOeaQE4aey0k0osW2Jd7gnHaesXP5+xLMvDblLoNQeDi3JiyczH43uuNGWCsywUrB5rTOaDKv3uHpNHJJOo5SETa0w1gev3w1nriVYOe+qyUBY5BKoJfwTrocKZ1fQ590hnB0LDBavO4tmlzqSSy5tV6Lu3/NOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC7HJpin; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54998f865b8so3710791e87.3;
        Tue, 11 Mar 2025 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715390; x=1742320190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY0a+7Bd76kNssAI216pzAYL/YAAvUS9w1O5DEvCouw=;
        b=kC7HJpintuPxuFVQ376ZhKQeSlDm3afRVsBf+Aeln327+EPWPakKayCSqtlPnHPXzu
         o2/l8qxg1v2AYRWeOIAua3gU8CuXwi5nWFodgao66CEYpiAtyjAkCFAk/djm0eGuJwwn
         Tq1k15I7YFI3CEOqg4M6gjvDXCnSeOwK5Jhut0NjkTy+2KT9WluwbuG8XtFMkwYXwWhx
         Um0BMf6BlDf5UPSgRpS4c7SiESO1Vnv7zoNye0nRPjzFAa9NPQyFJieyc3bofW2TY5ix
         lgA44oDgYhX9KlE2Mw7dSe2/1dfnYyMP+oanI7A0rUa5b5X/iEuGavx62Iiu1QvjH+ai
         CP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715390; x=1742320190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY0a+7Bd76kNssAI216pzAYL/YAAvUS9w1O5DEvCouw=;
        b=lapScmNC564BFyE83vEp6L/2IW6n98op0M7BrDigliaDy2/WrcWko7jK7Zl4RxtYoE
         GCfwhCxmtu2czDMPcsSgoYR5o0CThuA4diSskmgh/qCf3dZX85wn3Kn3gFLhG6+95XPb
         mVRtWqp4fByqkIo+H9juUw6OjOhHRTS2FbYPuKO34n1bLwR93EnIeWQlgJppq9spKDRq
         cSNePulJ8WA/DaEb1/kELV+KgZxx8iynPLAHsJFU2DDSraHddwS/+qRv6Kl66vkpfQdt
         pHURKD9g/QaFjMQw7zgj7mbEye2/tP811PN5fGfS3xWXs8BFNETWkI2tcuRnBkUzNHsW
         biug==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7y9zVamA88Wv+PGi3o4kfLanVCMrSo+l+9V/GNgC2ZQpGj3ru/tAlF5hJidGMpASUTsC1Z95AZyPPdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSsf3xXYtZyoAFzLrOtzmWcCHCjhoUDj4lAz5g3rukvtdiYn7
	krBA2IBbVlONchsCFR8wVTjjxmFkVMv7tvaNGiAMOXrYj6VqQe9ovcwpsA==
X-Gm-Gg: ASbGncv0jDdmBSkvmlAK9LgmxbLJr680ZEBoelxmpDYo2fJ+Fce8c/wnngbANfvIVoR
	V5uUZ3MxyUoAWChxletNO0+EZayflMIdeFaaLso2dVe7wVSIOOW2lO9dH4uc0BcVYHCfA9mlAMh
	FC3FV+GngCHoATf8Mt+uUXwjiipifTIgkT4ja5+9AZhe9l0oC0ucydmfyvc0L1diRuHJoHyWLT4
	lGdo5ogUwpL3n/tgFubkvCDMDiDo25sCXahYJDSUWWkIoRMypz5J4kXNKki471NkdonLpXVpl2S
	y7PiJ0INGPrpEfTPTuYXfzryPzVyjMkl8p8Y5z7QEdOb0hcKTSKtFdYdcUxi7/pY+XY0jSUujaO
	3aJ5FMkeZ13FUOSiBQn53Aw==
X-Google-Smtp-Source: AGHT+IHwItuL4p8GEONkja8pXnOCoaN6KKG1lPFxAT9W4J2iw1+SfhfJZwRqf3e2PLRMhwdeW6DL/Q==
X-Received: by 2002:a05:6512:3d8f:b0:549:9044:94b3 with SMTP id 2adb3069b0e04-54990e67285mr5883924e87.29.1741715390119;
        Tue, 11 Mar 2025 10:49:50 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:48 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v14 03/11] samples: rust: add Rust dma test sample driver
Date: Tue, 11 Mar 2025 19:47:59 +0200
Message-ID: <20250311174930.2348813-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple driver to excercise the basics of the Rust DMA
coherent allocator bindings.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 samples/rust/Kconfig     | 11 +++++
 samples/rust/Makefile    |  1 +
 samples/rust/rust_dma.rs | 97 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 samples/rust/rust_dma.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 3b6eae84b297..e2d14aa6beec 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -78,4 +78,15 @@ config SAMPLE_RUST_HOSTPROGS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_DMA
+	tristate "DMA Test Driver"
+	depends on PCI
+	help
+	  This option builds the Rust dma test driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called dma.
+
+	  If unsure, say N.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 0dbc6d90f1ef..1a9aff6e8d6a 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_DMA)		+= rust_dma.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
new file mode 100644
index 000000000000..1740140faba6
--- /dev/null
+++ b/samples/rust/rust_dma.rs
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust DMA api test (based on QEMU's `pci-testdev`).
+//!
+//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
+
+use kernel::{bindings, dma::CoherentAllocation, pci, prelude::*};
+
+struct DmaSampleDriver {
+    pdev: pci::Device,
+    ca: CoherentAllocation<MyStruct>,
+}
+
+const TEST_VALUES: [(u32, u32); 5] = [
+    (0xa, 0xb),
+    (0xc, 0xd),
+    (0xe, 0xf),
+    (0xab, 0xba),
+    (0xcd, 0xef),
+];
+
+struct MyStruct {
+    h: u32,
+    b: u32,
+}
+
+impl MyStruct {
+    fn new(h: u32, b: u32) -> Self {
+        Self { h, b }
+    }
+}
+// SAFETY: All bit patterns are acceptable values for `MyStruct`.
+unsafe impl kernel::transmute::AsBytes for MyStruct {}
+// SAFETY: Instances of `MyStruct` have no uninitialized portions.
+unsafe impl kernel::transmute::FromBytes for MyStruct {}
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    MODULE_PCI_TABLE,
+    <DmaSampleDriver as pci::Driver>::IdInfo,
+    [(
+        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        ()
+    )]
+);
+
+impl pci::Driver for DmaSampleDriver {
+    type IdInfo = ();
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
+
+        let ca: CoherentAllocation<MyStruct> =
+            CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+
+        || -> Result {
+            for (i, value) in TEST_VALUES.into_iter().enumerate() {
+                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
+            }
+
+            Ok(())
+        }()?;
+
+        let drvdata = KBox::new(
+            Self {
+                pdev: pdev.clone(),
+                ca,
+            },
+            GFP_KERNEL,
+        )?;
+
+        Ok(drvdata.into())
+    }
+}
+
+impl Drop for DmaSampleDriver {
+    fn drop(&mut self) {
+        dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
+
+        let _ = || -> Result {
+            for (i, value) in TEST_VALUES.into_iter().enumerate() {
+                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
+                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
+            }
+            Ok(())
+        }();
+    }
+}
+
+kernel::module_pci_driver! {
+    type: DmaSampleDriver,
+    name: "rust_dma",
+    author: "Abdiel Janulgue",
+    description: "Rust DMA test",
+    license: "GPL v2",
+}
-- 
2.43.0


