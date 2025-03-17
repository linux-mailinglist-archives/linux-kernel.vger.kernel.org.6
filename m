Return-Path: <linux-kernel+bounces-564936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B5A65D52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B257189344E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F661F5608;
	Mon, 17 Mar 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDpX0bI1"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A741EDA10;
	Mon, 17 Mar 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237655; cv=none; b=Wz3xfW7Ha4olYYgPVwivqI/ceDrrgtn1WAHRhZU/ntQ1UsNvVbl0gwIwEvgpHeJVIHSAHeyX5GEDehD0GzZPznJnOpCkjGPW7wKBB7hd7XhHnlFOBWWzirY/JB2h+eYpzaw4snpxpXX7TLw+cTtCDjVGU8+sHsk/6PoeUieuX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237655; c=relaxed/simple;
	bh=NPurUptvYolnP+zwLTc8xyODM40c1STXAevHbBUYyUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKFvyl78du2rZLsHo3KD0YavBd4ACXhDcTc4I4aEO+jKb1mTLXO8zay6wa1hOWyMGEEk1e29vKjW47l4M9mo1wtwyI48TTb9Emo3JlLnxCtAHv65sFCLj2syHOPIDIjCX5mq6MOZP5CDQOq1ofOMJPKddGXHt6qvJPCRiJGkDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDpX0bI1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54996d30bfbso4340860e87.2;
        Mon, 17 Mar 2025 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237651; x=1742842451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY0a+7Bd76kNssAI216pzAYL/YAAvUS9w1O5DEvCouw=;
        b=BDpX0bI1rBX+NOnvM9N+P8mrF4K5wXtW/Hr1USsCrrCjDl2XU5QmDHhE+gM/FDhsdj
         Wg5Zw4kG4UNO8wgC01Xz5ozqAd7/ayLtN2AsCSw5qNNqJQfPsCQnMDscTH0u1bOj98x6
         SD5SEGmPIC5RSN1EecSS/PC5HtEmPZ/yTfHdzl+ySY8UUXYvGuu7me5ykQy8O8sclAEt
         cv4v3x2IL7/jsMo98FyUv4NaKDT8nygVAj+a29Sd+KngyGvWSAFt7vUe/VYeVKQuIu9m
         ophBjqMZ7kPTeRHE12SM9XVL/VEcHGSvwN7lGTrDXhs0X0UhRQwdKORc0NLT4wsZqOwr
         1ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237651; x=1742842451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY0a+7Bd76kNssAI216pzAYL/YAAvUS9w1O5DEvCouw=;
        b=rwa++baIOibR4k4W3qTbTQWC4TuVprWAXuFdWolShT69u30S328ezYsY2IvnYFtqsJ
         18ysaOrUTAKNN76DfLzpzCCwEzdXoLZEmYre4UYWtMqAnWsEvsCzrNxlnwDxENW2A7Cc
         /xd6sto9WAhCObzGfZHP+/kVGQQIKAYEwidL+4GFO21f7GkVXzrTeJ9L/tgWx9oTF/Cu
         wFSDk0s9pVNpmavQGq4kQ9oq4yxw6C2fUOx80wjk5HUz0vQLu7h1sYhpnDHJlGF5xAbS
         nGg9Z5fxB0wiaqXDmeZ8mCztMjlijvb7NA7QthMD975v+b/lMeZ1yw3+gWQCbBBkFfik
         mlxA==
X-Forwarded-Encrypted: i=1; AJvYcCXOa+wZLS1HbGoim7LnMizP+nsZcEOwEpyxztMP6HhpqOeMtL6Zn4HBuRtWct2acPwKe5VX26Eg3iUhI7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7RPd+HG6HiLkiwU4gSeH+jDCl5zXEp5N3+q3lcueGBOgR72Mx
	Y6beW1CurKDBdcVEgTv/82XJ3tTlOYCWaKbBsYJWqTyB2iH5cb2LPR/J1w==
X-Gm-Gg: ASbGncsD+WQgy+PGA8z8ieIcW9/Qs45JH8l+cINsK0exUnxEt8A+r2X/+XXgxhW27g2
	hemb1ejEPUx4+F4Z4fw7Pe1xNs0K8q55O/XfBFAcclKn/iTBaoa1c0ZJgT7AKGWQr2Kn4eA5Y9R
	WqCSvVXfKQnM9wh1l5f7okhuG2WCr6dh2EcdUQjLgGvPTOAqeGnEAeGNp7+yLrl+fXBuoVpqPNt
	Hfv2LX/RsL9zrreD2Jy80Fce6vNMlpM6zFwzhv2mN9AvzaM42iS66aiGB6XSrhFZiM0tQZXh/7T
	1mCKMp/0p+pQr/oyTpu/EQKB8w5BkDNZ64FC/uS3FDyroAUCY0g6gX2iBResqWWdN1n2Yq3lfJb
	o4Ml1eskGTk1uhDP5b0YUU1zqzDQCrDZt
X-Google-Smtp-Source: AGHT+IEoHmWqOEUAbFn1XAQ9ghX1d5uNsCm0ipDw6XJoieye2FBFqVI/P9sH7ueMp48dHZ+dyTCaAA==
X-Received: by 2002:a05:6512:6c7:b0:549:b0f3:439c with SMTP id 2adb3069b0e04-549c39122d7mr7333101e87.21.1742237651131;
        Mon, 17 Mar 2025 11:54:11 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:10 -0700 (PDT)
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
Subject: [PATCH v15 03/11] samples: rust: add Rust dma test sample driver
Date: Mon, 17 Mar 2025 20:52:10 +0200
Message-ID: <20250317185345.2608976-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
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


