Return-Path: <linux-kernel+bounces-568769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBE1A69A41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE598156F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F221ABD1;
	Wed, 19 Mar 2025 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABegs/Al"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996621ABA8;
	Wed, 19 Mar 2025 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416519; cv=none; b=Sva61KQZIY2y0IrAX13z5x1G2hkiTlUgrcZb3FStxhz4JO1L1K91AwQp8lhhwnhImE29tDKihGjvthNtxapFo5NC/WIAcIU512i7mUWBTUiSJ4eIK+q3kEa3MrW2at1C3Y2FNUwqtkXWpiQVWw1ohDRq/JkH0fbCx26G6U+Jx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416519; c=relaxed/simple;
	bh=sxOTX+2LPaZPARYN028bSE2ifTHGymdjHAmVElZ1zEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvJtBET+A9nsIQraj2mUIPsAioyjbM45ZIalEdK5fMGqRTL4X5mDAgAqAHRmyzspCCKW/06jvMI9CilRjYZVhlPrdpbM9ATsxM1w4hZ9DkTYxv497lRm4yKHi7c2Cl6RtT2GpZIYpdFIdORYBhFHTEaqjOSJMH+GK6fnyy50oV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABegs/Al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F19C4CEE7;
	Wed, 19 Mar 2025 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416519;
	bh=sxOTX+2LPaZPARYN028bSE2ifTHGymdjHAmVElZ1zEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABegs/AlFYCG9R5Yo9jXFsVgXDDfvLKxJFt/Mfemd4yYGw0mcBJEMKz0nE+D8dUJC
	 LnILQ4WBdgge+pFhoat0aHmwTnEe16q4GiSC464WfZgd4u4WTdrSRyEzNOrMk0r9yK
	 ye9AFX49ZDjBm1AvNOchFjufsYyAvwBicaktgU+tG4YlVz1WnCDhQ/jzeKYw6vj2G1
	 BFrrOizRYdpquEJPt50McY6vZohoe559ojN8+DvpMVszy0I7KRKLiDYNTd0+jM6kd5
	 DTTKBat7nhpks+3+Jgm47CAYjTRoHBCPAOP/k2iEDabqcIUHA4UlZMHl3AmE5e+m9A
	 5bt9U1AXrVBhA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	airlied@gmail.com,
	acourbot@nvidia.com,
	jhubbard@nvidia.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 5/5] samples: rust: add Rust auxiliary driver sample
Date: Wed, 19 Mar 2025 21:33:57 +0100
Message-ID: <20250319203455.132539-6-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319203455.132539-1-dakr@kernel.org>
References: <20250319203455.132539-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sample Rust auxiliary driver based on a PCI driver for QEMU's
"pci-testdev" device.

The PCI driver only registers an auxiliary device, in order to make the
corresponding auxiliary driver probe.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS                           |   1 +
 samples/rust/Kconfig                  |  12 +++
 samples/rust/Makefile                 |   1 +
 samples/rust/rust_driver_auxiliary.rs | 110 ++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 samples/rust/rust_driver_auxiliary.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a737b28cdfa..6ec20e4f715d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7121,6 +7121,7 @@ F:	rust/kernel/devres.rs
 F:	rust/kernel/driver.rs
 F:	rust/kernel/faux.rs
 F:	rust/kernel/platform.rs
+F:	samples/rust/rust_driver_auxiliary.rs
 F:	samples/rust/rust_driver_platform.rs
 F:	samples/rust/rust_driver_faux.rs
 
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 3b6eae84b297..413216da1b70 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -71,6 +71,18 @@ config SAMPLE_RUST_DRIVER_FAUX
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_AUXILIARY
+	tristate "Auxiliary Driver"
+	depends on AUXILIARY_BUS
+	depends on PCI
+	help
+	  This option builds the Rust auxiliary driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_auxiliary.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 0dbc6d90f1ef..30a8809d0a15 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
new file mode 100644
index 000000000000..0f03d1d2181e
--- /dev/null
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust auxiliary driver sample (based on a PCI driver for QEMU's `pci-testdev`).
+//!
+//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
+
+use kernel::{
+    auxiliary, bindings, c_str, device::Core, driver, error::Error, init, pci, prelude::*,
+    str::CStr, InPlaceModule,
+};
+
+const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
+const AUXILIARY_NAME: &CStr = c_str!("auxiliary");
+
+struct AuxiliaryDriver;
+
+kernel::auxiliary_device_table!(
+    AUX_TABLE,
+    MODULE_AUX_TABLE,
+    <AuxiliaryDriver as auxiliary::Driver>::IdInfo,
+    [(auxiliary::DeviceId::new(MODULE_NAME, AUXILIARY_NAME), ())]
+);
+
+impl auxiliary::Driver for AuxiliaryDriver {
+    type IdInfo = ();
+
+    const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
+
+    fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        dev_info!(
+            adev.as_ref(),
+            "Probing auxiliary driver for auxiliary device with id={}\n",
+            adev.id()
+        );
+
+        if let Some(parent) = adev.as_ref().parent() {
+            let pdev: &pci::Device = parent.try_into()?;
+
+            dev_info!(
+                adev.as_ref(),
+                "Parent: VendorID={:#x}, DeviceID={:#x}\n",
+                pdev.vendor_id(),
+                pdev.device_id()
+            );
+        }
+
+        let this = KBox::new(Self, GFP_KERNEL)?;
+
+        Ok(this.into())
+    }
+}
+
+struct PciDriver {
+    _reg: [auxiliary::Registration; 2],
+}
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    MODULE_PCI_TABLE,
+    <PciDriver as pci::Driver>::IdInfo,
+    [(
+        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        ()
+    )]
+);
+
+impl pci::Driver for PciDriver {
+    type IdInfo = ();
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        let this = KBox::new(
+            Self {
+                _reg: [
+                    auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 0, MODULE_NAME)?,
+                    auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 1, MODULE_NAME)?,
+                ],
+            },
+            GFP_KERNEL,
+        )?;
+
+        Ok(this.into())
+    }
+}
+
+#[pin_data]
+struct SampleModule {
+    #[pin]
+    _pci_driver: driver::Registration<pci::Adapter<PciDriver>>,
+    #[pin]
+    _aux_driver: driver::Registration<auxiliary::Adapter<AuxiliaryDriver>>,
+}
+
+impl InPlaceModule for SampleModule {
+    fn init(module: &'static kernel::ThisModule) -> impl init::PinInit<Self, Error> {
+        try_pin_init!(Self {
+            _pci_driver <- driver::Registration::new(MODULE_NAME, module),
+            _aux_driver <- driver::Registration::new(MODULE_NAME, module),
+        })
+    }
+}
+
+module! {
+    type: SampleModule,
+    name: "rust_driver_auxiliary",
+    author: "Danilo Krummrich",
+    description: "Rust auxiliary driver",
+    license: "GPL v2",
+}
-- 
2.48.1


