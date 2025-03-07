Return-Path: <linux-kernel+bounces-550947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D78A56650
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F7189950A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF89216E1C;
	Fri,  7 Mar 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G35Pw9hK"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DA2163BA;
	Fri,  7 Mar 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345728; cv=none; b=ozDQtS6Z5vKvdIr4nowuscTUG8lNSw8kwmZHOEAXWK/WZ2th5y814f2gapJCYu2GSWyt+dXhys77GOzgriH5kJiKhdYQn5yvBTd9/YyXwPnH5X7gorGs53BeonIiiS8C0UvYMMiiGjRrfOexiVXPRo5Z4weC1F++SgPNgMdy8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345728; c=relaxed/simple;
	bh=fWkCL8BMSYNMfEbrDrnuytIEF1WS+GC8K9E0V39YodU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/XKO8oEDUdwa9BGHjaPVJ0CtD/47oMaoGLSbci5Yn3apiZxQlmqFfZvxQmTowbiUlBNJsltkXXIuE76BPBNyNu4CocFcDQ75obk1/lfEzq+aHNVzKmMyT8IRKRhIqPZ91Alzva2/X6+IJorePuVyBdNd7c/ZWpIaxVyn9eL2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G35Pw9hK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5497590ffbbso1956470e87.1;
        Fri, 07 Mar 2025 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345725; x=1741950525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjRzcycbu56jCOb7vRNRwX3YWPCEzPaeoXXPekHZQFg=;
        b=G35Pw9hKozp1SLGGeYYiSrQ0sdrEUGOPW/VU7sSnikUUWzksOgdAkW/KLa7J/vaTHU
         LITvXQlX7F1sZEoRQl2R96LSKI7yXtL1N9HeUZ1Wb1JPjKg31e1V+z3qe3Hl67bBrN9p
         Ghq0hu7SMOS8V/U8Qs61wExHmwKOEsLYA2me09I6P214HzrPv2d8lR2PXaYYC4ICKFbj
         i4lNhrpzJ/b+wfUvVaO1jW2vjXBIrbru0TWcSls6Q4Rv/tiGevDrSpVzFdgnPKRr4lkY
         1+ArijcFifZfdLR9tvZcqma5lw1VqsNHRUqGgAWwe22GnNo5o7YM5QCbKRyK8COAcD0f
         tI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345725; x=1741950525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjRzcycbu56jCOb7vRNRwX3YWPCEzPaeoXXPekHZQFg=;
        b=XAHf5Nl0EFZPMd+ZJrOmEXB329in5GNVZcOMPNVoJxcly8Sxh+qn4zKf+L18qMYFZK
         7y6A4ohwSzVCFDJu0+r22vRQzaLTfrBfvIsLvbcO6Kth9kfniyowJKAdCV8Q6T/f+p30
         Ft2TB0j6By85rAB9WQHEcfJ21xfwjBX7EAjoaHXAvxFyY83oV7WaEqMjLglRVqe3VuEV
         BuUiBiYDk46DW7IRGN1HZ9uAKCsAofENBAjU/m2cPtyUhZ8+bzBQNcVw+v9R6U8BeQn6
         DedT14kvypmJnnzzKYSFTdG29ylz5NRLInkMNABtfNvGDCAala4aOPhahCFFNS3ag8sg
         bh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIyy3ZeTjmkJChO8OPTrmr+KWeIy+Zk0uZQFkj9Iy7AmkocTGcev3/zmicffhZw1Je7ZLXIvU/AB/Wo1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOgjZjbKI+35Oc2802lWSBXmikOvmnFSR4MoFhs912H7SKCT1
	X030u/ZqiEKDgUrtDvCSfWBG5VvDLECyVKXvASK7O8HthVoDyowVuihgcA==
X-Gm-Gg: ASbGncvB51dpdV7R/xivyEiPkF5gEnwTKXI/FpmNf52/qWzlSKGwHe6Ackk2V+eoxNT
	Y6jX+TkavNKrntqOY3YJvusYnOuB3vaO+zzlHGYHJXrsx4eyu9rYz4nQ/rwh9F+Q4kcwkE+i1aq
	/9zE3dmGnKD540twnqnnA7BLuD3PG+fsauG4zWYQd6P6XbSjm5/J92OnteSfFISpBqAKeMErLZt
	hTb2uJKhREwKzhiuolEyLeync8b5JbTdmlIZC6usqvEhRygp1C/fIf9GkQI7jelfbsCYuVWiR6U
	E4v4ZxeLOUPtpo9khbm8MvSdkVT7Hk+q7I8UEsg4dUqHTM1GwMKB8haGfBLSjG0zYTthMzUMPnh
	3rJua+0GlgEoQS5X8yucryw==
X-Google-Smtp-Source: AGHT+IFjoxl6eClgg1VA0EEBG5W1vMJn01ur8ijpiShnc8E2q98l9Vo8EwdrO+pPkvWO3BDH5B5Afw==
X-Received: by 2002:a05:6512:b99:b0:545:2d4d:36d1 with SMTP id 2adb3069b0e04-54990e5d4e3mr996613e87.20.1741345724809;
        Fri, 07 Mar 2025 03:08:44 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:44 -0800 (PST)
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
Subject: [PATCH v13 5/7] samples: rust: add Rust dma test sample driver
Date: Fri,  7 Mar 2025 13:06:22 +0200
Message-ID: <20250307110821.1703422-6-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
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
 samples/rust/Kconfig     |  11 +++++
 samples/rust/Makefile    |   1 +
 samples/rust/rust_dma.rs | 104 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 samples/rust/rust_dma.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 3b6eae84b297..04bbba870bd1 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -78,4 +78,15 @@ config SAMPLE_RUST_HOSTPROGS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_DMA
+	tristate "DMA test driver"
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
index 000000000000..aed55ae4dcfe
--- /dev/null
+++ b/samples/rust/rust_dma.rs
@@ -0,0 +1,104 @@
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
+    ca: kernel::devres::Devres<CoherentAllocation<MyStruct>>,
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
+        let dev = pdev.as_mut();
+
+        dev.dma_set_mask_and_coherent(kernel::dma::dma_bit_mask(64))?;
+
+        dev_info!(dev, "Probe DMA test driver.\n");
+
+        let ca: kernel::devres::Devres<CoherentAllocation<MyStruct>> =
+            CoherentAllocation::alloc_coherent(dev, TEST_VALUES.len(), GFP_KERNEL)?;
+
+        || -> Result {
+            let reg = ca.try_access().ok_or(ENXIO)?;
+
+            for (i, value) in TEST_VALUES.into_iter().enumerate() {
+                kernel::dma_write!(reg[i] = MyStruct::new(value.0, value.1));
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
+            let reg = self.ca.try_access().ok_or(ENXIO)?;
+            for (i, value) in TEST_VALUES.into_iter().enumerate() {
+                assert_eq!(kernel::dma_read!(reg[i].h), value.0);
+                assert_eq!(kernel::dma_read!(reg[i].b), value.1);
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


