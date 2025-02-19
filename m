Return-Path: <linux-kernel+bounces-522023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1394DA3C4F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466663BA5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D901FECD3;
	Wed, 19 Feb 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Me53PNRJ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4611FDA9D;
	Wed, 19 Feb 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982370; cv=pass; b=Qwlr0+Hqinp7A3qBiJOcZZuke8Efl/W/PFrX1y/STnDqgEIr+QxFwbXGmLDhQ0/uouvA6ihqGTvBKih2EYL8VeuDuGW2X7emQW5MuY2BVNTj2dgG5bg0TwjLmSnU1yD+zOjR3alJjstHyfZK9ieXG0IKuQfrhONif882kP93UTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982370; c=relaxed/simple;
	bh=fnY+xRhs/mvmhcqrrOJoleU6kesLGIJG/3olYNCyL1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7HdSj14NaOD/ydUDnGt/Ob8uB3ULHt2gv9DxbCxt0YBxyBmRZHyhcWeOXlcQFmm8lWX4dBGbPG2kemntw7AFLjvHc+vHy4ufs7XkZx3AXwc4R/iOCBErCGGy3Swtd02dcBQNea4n1+S0Pn6WnYCbms5fhW+bvmfKLIPJZUG3iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Me53PNRJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739982346; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mHdTfssk3hO/gVSjbUBWQIgt+/aextPwhJBmYx2l1LALAtXke+PJBVC3ehWpndt/8GXW9YqXYnRQfxHUyeH1u+OyagIttWYVrK7zcpoq8GzEialDmTQkxODQ+C1UnRCxiMvYBzBlBRJyTbFxM6vItnfX10hkVATuJM72NF6jexY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739982346; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pJryDSJkCrzxd3hCCxQyAoikD3lNWruHuXg6LmIobnI=; 
	b=kKHxBdK74Z+o2689NatXJRZuL9bfFDwypgrT6rx1ZejbrFml8cEwlEtokk6KvgG65oakSkRWd/DNoA/yMoJ/bcR1tFJ9Osi5mhTxuE3RTOpC31hpBvr7xAPl4vUCS6pl4SL+vauPBuHMuFs52Y7c4J6HyRmu9cqTMGE13V71qII=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739982346;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pJryDSJkCrzxd3hCCxQyAoikD3lNWruHuXg6LmIobnI=;
	b=Me53PNRJII0FexdnI44sYwGiP82B3cKKaUkB+sNZGy9DbbABEBvokG649Sbpl+8l
	M/M0TGPsS5+B3yX6vYBo9sXibiPODW388vOONDB1UWyRC+q6cnRoiYVkMQNPpqz71GW
	fSyi2l9JlJAWozzG+JPzYuVbBjv9NAGlgTv5Zum4=
Received: by mx.zohomail.com with SMTPS id 1739982344632512.1546033548996;
	Wed, 19 Feb 2025 08:25:44 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	sebastian.reichel@collabora.com,
	sjoerd.simons@collabora.co.uk,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: regulator: add a bare minimum regulator abstraction
Date: Wed, 19 Feb 2025 13:25:16 -0300
Message-ID: <20250219162517.278362-1-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a bare minimum regulator abstraction to be used by Rust drivers.
This abstraction adds a small subset of the regulator API, which is
thought to be sufficient for the drivers we have now.

Regulators provide the power needed by many hardware blocks and thus are
likely to be needed by a lot of drivers.

It was tested on rk3588, where it was used to power up the "mali"
regulator in order to power up the GPU.

Note that each instance of [`Regulator`] obtained from
`Regulator::get()` can only be enabled once. This ensures that the calls
to enable and disable are perfectly balanced before `regulator_put()` is
called, as mandated by the C API.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/regulator.rs        | 120 ++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 rust/kernel/regulator.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 55354e4dec14..92504f19655e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -28,6 +28,7 @@
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/refcount.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/slab.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911..0224f4c248c0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -68,6 +68,8 @@
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
+#[cfg(CONFIG_REGULATOR)]
+pub mod regulator;
 pub mod revocable;
 pub mod security;
 pub mod seq_file;
diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
new file mode 100644
index 000000000000..df6eb325d11a
--- /dev/null
+++ b/rust/kernel/regulator.rs
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Regulator abstractions.
+//!
+//! C header: [`include/linux/regulator/consumer.h`](srctree/include/linux/regulator/consumer.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{from_err_ptr, to_result, Result},
+    prelude::*,
+};
+
+use core::ptr::NonNull;
+
+/// A `struct regulator` abstraction.
+///
+/// Note that each instance of [`Regulator`] obtained from `Regulator::get()`
+/// can only be enabled once. This ensures that the calls to enable and disable
+/// are perfectly balanced before `regulator_put()` is called, as mandated by
+/// the C API.
+///
+/// # Invariants
+///
+/// - [`Regulator`] is a non-null wrapper over a pointer to a `struct regulator`
+///   obtained from `regulator_get()`.
+/// - Each instance of [`Regulator`] obtained from `Regulator::get()` can only
+///   be enabled once.
+pub struct Regulator {
+    inner: NonNull<bindings::regulator>,
+    enabled: bool,
+}
+
+impl Regulator {
+    /// Obtains a [`Regulator`] instance from the system.
+    pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
+        // SAFETY: It is safe to call `regulator_get()`, on a device pointer
+        // earlier received from the C code.
+        let inner = from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_ptr()) })?;
+
+        // SAFETY: We can safely trust `inner` to be a pointer to a valid
+        // regulator if `ERR_PTR` was not returned.
+        let inner = unsafe { NonNull::new_unchecked(inner) };
+
+        Ok(Self {
+            inner,
+            enabled: false,
+        })
+    }
+
+    /// Enable the regulator.
+    pub fn enable(&mut self) -> Result {
+        if self.enabled {
+            return Ok(());
+        }
+
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        let res = to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) });
+        if res.is_ok() {
+            self.enabled = true;
+        }
+
+        res
+    }
+
+    /// Disable the regulator.
+    pub fn disable(&mut self) -> Result {
+        if !self.enabled {
+            return Ok(());
+        }
+
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        let res = to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr()) });
+        if res.is_ok() {
+            self.enabled = false;
+        }
+
+        res
+    }
+
+    /// Set the voltage for the regulator.
+    pub fn set_voltage(&self, min_uv: Microvolt, max_uv: Microvolt) -> Result {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        to_result(unsafe {
+            bindings::regulator_set_voltage(self.inner.as_ptr(), min_uv.0, max_uv.0)
+        })
+    }
+
+    /// Get the current voltage of the regulator.
+    pub fn get_voltage(&self) -> Result<Microvolt> {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        let voltage = unsafe { bindings::regulator_get_voltage(self.inner.as_ptr()) };
+        if voltage < 0 {
+            Err(Error::from_errno(voltage))
+        } else {
+            Ok(Microvolt(voltage))
+        }
+    }
+}
+
+impl Drop for Regulator {
+    fn drop(&mut self) {
+        if self.enabled {
+            // It is a requirement from the C API that the calls to enable and
+            // disabled are balanced before calling `regulator_put()`.
+            self.disable();
+        }
+
+        // SAFETY: By the type invariants, we know that `self` owns a reference,
+        // so it is safe to relinquish it now.
+        unsafe { bindings::regulator_put(self.inner.as_ptr()) };
+    }
+}
+
+/// A voltage in microvolts.
+///
+/// The explicit type is used to avoid confusion with other multiples of the
+/// volt, which can be desastrous.
+#[repr(transparent)]
+pub struct Microvolt(pub i32);
-- 
2.48.1


