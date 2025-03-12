Return-Path: <linux-kernel+bounces-557106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECBCA5D3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A00C1899607
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817AD78C9C;
	Wed, 12 Mar 2025 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyt/l2Bl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FA6A009;
	Wed, 12 Mar 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741739293; cv=none; b=tztGlhjpfbXmkxQScA3AD932p6hvjsf/bk9UZSR+EWCa3J2ebRpZ22C8eLKu5W43AdQJ7x2hgM8Kwzqu/370Idhe3tSTTBcbG6Wq/RcJDTLXBZ5wDweWEs5oCrw74Rmx/eVfMhf/XsnThD8hbsxZMqV1DzY9Q3Yez61BukEYkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741739293; c=relaxed/simple;
	bh=7HTnlknCHy9BYSUW62VmRoYLTpc62pptmvjdRlu1dmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgHbRCs/9udA8CFXXYoXfuPqyxAbfICy26ZfEF0KIlT0Y1VKwhsTvIWdV6ObIqgPr4Xp9Rsn5+BBGBg7vIjH5aPCDZof6qcR//f9OHlDgkTcZexNndkdTbkS5GcCweuhL+hY3rUS+4grDQ/PQp2HL/JuPRHYykGOhGosCf9AZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyt/l2Bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD55DC4CEF0;
	Wed, 12 Mar 2025 00:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741739293;
	bh=7HTnlknCHy9BYSUW62VmRoYLTpc62pptmvjdRlu1dmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lyt/l2BlQY2M6AnuD2WsOxrp0uIO/vA/X9tmDRm+XzpCi8sdN6WF9ZG8ItxIC6pvv
	 RjsX7lfAE01YZakJMINkjB/hOL8BTLMOjIuoSTqvLfHs/u66NvIUtDAmUagsJWYhyN
	 AED/Nc0eB3keU/jcyL991FVIhfbwqtmt3UeM5nzQ/QO39QI5AnyrypxpQ1vrxWHGM9
	 v4pPlSyrcM7WcBsUtpeoKy5/vuQ8QQ7aR9E/scet0CWfgZI8fWL1p0T9s6QbBYSz8H
	 33tXy5crNp+txKFzBl9I0BwDDviZ43ab1dB+O0vRmb7pNwe1WhUOZ2UMooYhETjPUG
	 /LsKpwGLcAjXw==
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
Subject: [PATCH 4/4] samples: rust: add Rust auxiliary driver sample
Date: Wed, 12 Mar 2025 01:19:10 +0100
Message-ID: <20250312002741.453350-5-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312002741.453350-1-dakr@kernel.org>
References: <20250312002741.453350-1-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS                           |  1 +
 samples/rust/Kconfig                  | 10 +++
 samples/rust/Makefile                 |  1 +
 samples/rust/rust_driver_auxiliary.rs | 99 +++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)
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
index 3b6eae84b297..6679d1f1fd48 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -71,6 +71,16 @@ config SAMPLE_RUST_DRIVER_FAUX
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_AUXILIARY
+	tristate "Auxiliary Driver"
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
index 000000000000..f9af7c07a2b7
--- /dev/null
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust auxiliary driver sample (based on a PCI driver for QEMU's `pci-testdev`).
+//!
+//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
+
+use kernel::{
+    auxiliary, bindings, c_str, driver, error::Error, init, pci, prelude::*, str::CStr,
+    InPlaceModule,
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
+    fn probe(adev: &mut auxiliary::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        dev_info!(
+            adev.as_ref(),
+            "Probing auxiliary driver for auxiliary device with id={}\n",
+            adev.id()
+        );
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
+    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
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


