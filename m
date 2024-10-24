Return-Path: <linux-kernel+bounces-380072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4409AE88C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12D71C22DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F51FF608;
	Thu, 24 Oct 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="USAqDUqP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4A1F5852;
	Thu, 24 Oct 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779640; cv=pass; b=cpvrxozZdLE9tuJzTMo/FDFB13fQEZ1Lthp8DLdApkw6uiAHWlSbUnMd8lLQdak6braAvhZzgGK+67ITz+SIwE4vB40xap45wjpUGz1dm1MLtaIg9maapaMUumlmnlLVXdmRC2rOT74jPhABuzIBZyugxVt1J8dPNkDEdX8f71U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779640; c=relaxed/simple;
	bh=HH6smeMlfL9puxyiwoi08+MKIHl/++NiDD+5rHeJER0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Gyv2jvByHTYM1K9EEMSnxtPAlMd4uI1EScJZP+27JlfYz4dCk6Nsu8Ee30Qxr5LQYH1PFJE7CVRhimv6lVu6VY9M1K3K88oO3D/7bLs8I7SKS1Zj+KA88TIgHGEcMT530SYAd0pQ+m30vvL5jgGbyCPB+Nt+2EBbRfQx5cUcKWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=USAqDUqP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729779614; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M91YgG8m8AzXjL8OdAN0LUN+kIri8v1yiKgpUXI91w0T7vxHPbOsM03ZsLNFL7iz9tvP/uwf9g97BIQxf1+ucoN6pEf5lh80Ydcx0jf23a8t4psKMVrxasmyMCXSgpWTWKg8BcLewsFGVai32NjLbc0Wd49iJJJ+EeNHKVL2tFs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729779614; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ao3iZyC1xhz8yu/jMW2K2zltqLGqcgU2tIvX5T3C8as=; 
	b=BZMwmrnZZeZKPIjEm0iTCWNGIYhN9tp6l1yI+1gr+xmAqZHyGfqxkbgj+Dk6RTZmB4U+4tXTDdfPc1UtPh3nz7E+KmLj0Wm3nWtcl2XFfXI5iF+FyJhVvDgG0kYiVx+xvvu1wRKnF4TlmOvNKMtHHujPCzs0HO794d1IpZQR2EY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729779614;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=Ao3iZyC1xhz8yu/jMW2K2zltqLGqcgU2tIvX5T3C8as=;
	b=USAqDUqPGIMdadGgLF3d4jPK9eZE4KglTC14Z5qKIAFgDMxhSJywLwlZ/TYVxt3T
	H/S/8djC9zOKp0iJs8EFXzMHCsJbzcuJfAfNl6P5NPDgHw9qrnT/pwL11UqMyhIBDPs
	0JbyUinDsPYBMm8/1rpZPmV4pIVV2DTETyCp278w=
Received: by mx.zohomail.com with SMTPS id 1729779613906705.2468068702939;
	Thu, 24 Oct 2024 07:20:13 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 24 Oct 2024 11:20:02 -0300
Subject: [PATCH] rust: irq: add support for request_irq()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
X-B4-Tracking: v=1; b=H4sIAJFXGmcC/x3MwQqDMAwA0F+RnBeocQzxV8YYmmWaS1uTOgbiv
 1s8vsvbwcVUHIZmB5OfuqZY0d4a4GWMs6B+qoEC3dtAHZaUlTGPsSzJ0BxN1k28vNVWfFAIPTP
 3JBPUIpt89X/1z9dxnIPjLHxuAAAA
X-Change-ID: 20241023-topic-panthor-rs-request_irq-62008ccc82eb
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Both regular and threaded versions are supported.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/irq.c              |   9 +
 rust/kernel/irq.rs              |   6 +
 rust/kernel/irq/request.rs      | 450 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 6 files changed, 468 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941afa17c48737d2b2e49ac6d26f670b1..f1c35b334f5f7d2adcacb1def72182a09db2ac6c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
+#include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a969f9e8eb747aabdc17a8cb06936b..0bb48df454bd87def8271444ea58c781b792e34c 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "err.c"
+#include "irq.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
diff --git a/rust/helpers/irq.c b/rust/helpers/irq.c
new file mode 100644
index 0000000000000000000000000000000000000000..1faca428e2c047a656dec3171855c1508d67e60b
--- /dev/null
+++ b/rust/helpers/irq.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/interrupt.h>
+
+int rust_helper_request_irq(unsigned int irq, irq_handler_t handler,
+			    unsigned long flags, const char *name, void *dev)
+{
+	return request_irq(irq, handler, flags, name, dev);
+}
diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
new file mode 100644
index 0000000000000000000000000000000000000000..3ab83c5bdb831e84f5e035d9ef56f8e373fa572d
--- /dev/null
+++ b/rust/kernel/irq.rs
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IRQ abstractions
+
+/// IRQ allocation and handling
+pub mod request;
diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
new file mode 100644
index 0000000000000000000000000000000000000000..4b5c5b80c3f43d482132423c2c52cfa5696b7661
--- /dev/null
+++ b/rust/kernel/irq/request.rs
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright 2019 Collabora ltd.
+
+//! IRQ allocation and handling
+
+use crate::error::to_result;
+use crate::prelude::*;
+use crate::str::CStr;
+use crate::types::Opaque;
+
+/// Flags to be used when registering IRQ handlers.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`flags`] module.
+#[derive(Clone, Copy)]
+pub struct Flags(u64);
+
+impl core::ops::BitOr for Flags {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Flags {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Flags {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}
+
+/// The flags that can be used when registering an IRQ handler.
+pub mod flags {
+    use super::Flags;
+
+    use crate::bindings;
+
+    /// Use the interrupt line as already configured.
+    pub const TRIGGER_NONE: Flags = Flags(bindings::IRQF_TRIGGER_NONE as _);
+
+    /// The interrupt is triggered when the signal goes from low to high.
+    pub const TRIGGER_RISING: Flags = Flags(bindings::IRQF_TRIGGER_RISING as _);
+
+    /// The interrupt is triggered when the signal goes from high to low.
+    pub const TRIGGER_FALLING: Flags = Flags(bindings::IRQF_TRIGGER_FALLING as _);
+
+    /// The interrupt is triggered while the signal is held high.
+    pub const TRIGGER_HIGH: Flags = Flags(bindings::IRQF_TRIGGER_HIGH as _);
+
+    /// The interrupt is triggered while the signal is held low.
+    pub const TRIGGER_LOW: Flags = Flags(bindings::IRQF_TRIGGER_LOW as _);
+
+    /// Allow sharing the irq among several devices.
+    pub const SHARED: Flags = Flags(bindings::IRQF_SHARED as _);
+
+    /// Set by callers when they expect sharing mismatches to occur.
+    pub const PROBE_SHARED: Flags = Flags(bindings::IRQF_PROBE_SHARED as _);
+
+    /// Flag to mark this interrupt as timer interrupt.
+    pub const TIMER: Flags = Flags(bindings::IRQF_TIMER as _);
+
+    /// Interrupt is per cpu.
+    pub const PERCPU: Flags = Flags(bindings::IRQF_PERCPU as _);
+
+    /// Flag to exclude this interrupt from irq balancing.
+    pub const NOBALANCING: Flags = Flags(bindings::IRQF_NOBALANCING as _);
+
+    /// Interrupt is used for polling (only the interrupt that is registered
+    /// first in a shared interrupt is considered for performance reasons).
+    pub const IRQPOLL: Flags = Flags(bindings::IRQF_IRQPOLL as _);
+
+    /// Interrupt is not reenabled after the hardirq handler finished. Used by
+    /// threaded interrupts which need to keep the irq line disabled until the
+    /// threaded handler has been run.
+    pub const ONESHOT: Flags = Flags(bindings::IRQF_ONESHOT as _);
+
+    /// Do not disable this IRQ during suspend. Does not guarantee that this
+    /// interrupt will wake the system from a suspended state.
+    pub const NO_SUSPEND: Flags = Flags(bindings::IRQF_NO_SUSPEND as _);
+
+    /// Force enable it on resume even if [`NO_SUSPEND`] is set.
+    pub const FORCE_RESUME: Flags = Flags(bindings::IRQF_FORCE_RESUME as _);
+
+    /// Interrupt cannot be threaded.
+    pub const NO_THREAD: Flags = Flags(bindings::IRQF_NO_THREAD as _);
+
+    /// Resume IRQ early during syscore instead of at device resume time.
+    pub const EARLY_RESUME: Flags = Flags(bindings::IRQF_EARLY_RESUME as _);
+
+    /// If the IRQ is shared with a NO_SUSPEND user, execute this interrupt
+    /// handler after suspending interrupts. For system wakeup devices users
+    /// need to implement wakeup detection in their interrupt handlers.
+    pub const COND_SUSPEND: Flags = Flags(bindings::IRQF_COND_SUSPEND as _);
+
+    /// Don't enable IRQ or NMI automatically when users request it. Users will
+    /// enable it explicitly by `enable_irq` or `enable_nmi` later.
+    pub const NO_AUTOEN: Flags = Flags(bindings::IRQF_NO_AUTOEN as _);
+
+    /// Exclude from runnaway detection for IPI and similar handlers, depends on
+    /// `PERCPU`.
+    pub const NO_DEBUG: Flags = Flags(bindings::IRQF_NO_DEBUG as _);
+}
+
+/// The value that can be returned from an IrqHandler;
+pub enum IrqReturn {
+    /// The interrupt was not from this device or was not handled.
+    None = bindings::irqreturn_IRQ_NONE as _,
+
+    /// The interrupt was handled by this device.
+    Handled = bindings::irqreturn_IRQ_HANDLED as _,
+}
+
+/// Callbacks for an IRQ handler.
+pub trait Handler: Sync {
+    /// The actual handler function. As usual, sleeps are not allowed in IRQ
+    /// context.
+    fn handle_irq(&self) -> IrqReturn;
+}
+
+/// A registration of an IRQ handler for a given IRQ line.
+///
+/// # Invariants
+///
+/// * We own an irq handler using `&self` as its private data.
+///
+/// # Examples
+///
+/// The following is an example of using `Registration`:
+///
+/// ```
+/// use kernel::prelude::*;
+/// use kernel::irq;
+/// use kernel::irq::Registration;
+/// use kernel::sync::Arc;
+/// use kernel::sync::lock::SpinLock;
+///
+/// // Declare a struct that will be passed in when the interrupt fires. The u32
+/// // merely serves as an example of some internal data.
+/// struct Data(u32);
+///
+/// // [`handle_irq`] returns &self. This example illustrates interior
+/// // mutability can be used when share the data between process context and IRQ
+/// // context.
+/// //
+/// // Ideally, this example would be using a version of SpinLock that is aware
+/// // of `spin_lock_irqsave` and `spin_lock_irqrestore`, but that is not yet
+/// // implemented.
+///
+/// type Handler = SpinLock<Data>;
+///
+/// impl kernel::irq::Handler for Handler {
+///     // This is executing in IRQ context in some CPU. Other CPUs can still
+///     // try to access to data.
+///     fn handle_irq(&self) -> irq::IrqReturn {
+///         // We now have exclusive access to the data by locking the SpinLock.
+///         let mut handler = self.lock();
+///         handler.0 += 1;
+///
+///         IrqReturn::Handled
+///     }
+/// }
+///
+/// // This is running in process context.
+/// fn register_irq(irq: u32, handler: Handler) -> Result<irq::Registration<Handler>> {
+///     let registration = Registration::register(irq, irq::flags::SHARED, "my-device", handler)?;
+///
+///     // You can have as many references to the registration as you want, so
+///     // multiple parts of the driver can access it.
+///     let registration = Arc::pin_init(registration)?;
+///
+///     // The handler may be called immediately after the function above
+///     // returns, possibly in a different CPU.
+///
+///     // The data can be accessed from the process context too.
+///     registration.handler().lock().0 = 42;
+///
+///     Ok(registration)
+/// }
+///
+/// # Ok::<(), Error>(())
+///```
+#[pin_data(PinnedDrop)]
+pub struct Registration<T: Handler> {
+    irq: u32,
+    #[pin]
+    handler: Opaque<T>,
+}
+
+impl<T: Handler> Registration<T> {
+    /// Registers the IRQ handler with the system for the given IRQ number. The
+    /// handler must be able to be called as soon as this function returns.
+    pub fn register(
+        irq: u32,
+        flags: Flags,
+        name: &'static CStr,
+        handler: T,
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            irq,
+            handler: Opaque::new(handler)
+        })
+        .pin_chain(move |slot| {
+            // SAFETY:
+            // - `handler` points to a valid function defined below.
+            // - only valid flags can be constructed using the `flags` module.
+            // - `devname` is a nul-terminated string with a 'static lifetime.
+            // - `ptr` is a cookie used to identify the handler. The same cookie is
+            // passed back when the system calls the handler.
+            to_result(unsafe {
+                bindings::request_irq(
+                    irq,
+                    Some(handle_irq_callback::<T>),
+                    flags.0,
+                    name.as_char_ptr(),
+                    &*slot as *const _ as *mut core::ffi::c_void,
+                )
+            })?;
+
+            Ok(())
+        })
+    }
+
+    /// Returns a reference to the handler that was registered with the system.
+    pub fn handler(&self) -> &T {
+        // SAFETY: `handler` is initialized in `register`.
+        unsafe { &*self.handler.get() }
+    }
+}
+
+#[pinned_drop]
+impl<T: Handler> PinnedDrop for Registration<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY:
+        // - `self.irq` is the same as the one passed to `reques_irq`.
+        // -  `&self` was passed to `request_irq` as the cookie. It is
+        // guaranteed to be unique by the type system, since each call to
+        // `register` will return a different instance of `Registration`.
+        //
+        // Notice that this will block until all handlers finish executing, so,
+        // at no point will &self be invalid while the handler is running.
+        unsafe { bindings::free_irq(self.irq, &*self as *const _ as *mut core::ffi::c_void) };
+    }
+}
+
+/// The value that can be returned from `ThreadedHandler::handle_irq`.
+pub enum ThreadedIrqReturn {
+    /// The interrupt was not from this device or was not handled.
+    None = bindings::irqreturn_IRQ_NONE as _,
+
+    /// The interrupt was handled by this device.
+    Handled = bindings::irqreturn_IRQ_HANDLED as _,
+
+    /// The handler wants the handler thread to wake up.
+    WakeThread = bindings::irqreturn_IRQ_WAKE_THREAD as _,
+}
+
+/// The value that can be returned from `ThreadedFnHandler::thread_fn`.
+pub enum ThreadedFnReturn {
+    /// The thread function did not make any progress.
+    None = bindings::irqreturn_IRQ_NONE as _,
+
+    /// The thread function ran successfully.
+    Handled = bindings::irqreturn_IRQ_HANDLED as _,
+}
+
+/// Callbacks for a threaded IRQ handler.
+pub trait ThreadedHandler: Sync {
+    /// The actual handler function. As usual, sleeps are not allowed in IRQ
+    /// context.
+    fn handle_irq(&self) -> ThreadedIrqReturn;
+
+    /// The threaded handler function. This function is called from the irq
+    /// handler thread, which is automatically created by the system.
+    fn thread_fn(&self) -> ThreadedFnReturn;
+}
+
+/// A registration of a threaded IRQ handler for a given IRQ line.
+///
+/// Two callbacks are required: one to handle the IRQ, and one to handle any
+/// other work in a separate thread.
+///
+/// The thread handler is only called if the IRQ handler returns `WakeThread`.
+///
+/// # Invariants
+///
+/// * We own an irq handler using `&self` as its private data.
+///
+/// # Examples
+///
+/// The following is an example of using `ThreadedRegistration`:
+///
+/// ```
+/// use kernel::prelude::*;
+/// use kernel::irq;
+/// use kernel::irq::Registration;
+/// use kernel::sync::Arc;
+/// use kernel::sync::lock::SpinLock;
+///
+/// // Declare a struct that will be passed in when the interrupt fires. The u32
+/// // merely serves as an example of some internal data.
+/// struct Data(u32);
+///
+/// // [`handle_irq`] returns &self. This example illustrates interior
+/// // mutability can be used when share the data between process context and IRQ
+/// // context.
+/// //
+/// // Ideally, this example would be using a version of SpinLock that is aware
+/// // of `spin_lock_irqsave` and `spin_lock_irqrestore`, but that is not yet
+/// // implemented.
+///
+/// type Handler = SpinLock<Data>;
+///
+/// impl kernel::irq::Handler for Handler {
+///     // This is executing in IRQ context in some CPU. Other CPUs can still
+///     // try to access to data.
+///     fn handle_irq(&self) -> irq::ThreadedIrqReturn {
+///         // We now have exclusive access to the data by locking the SpinLock.
+///         let mut handler = self.lock();
+///         handler.0 += 1;
+///
+///         // By returning `WakeThread`, we indicate to the system that the
+///         // thread function should be called. Otherwise, return
+///         // ThreadedIrqReturn::Handled.
+///         ThreadedIrqReturn::WakeThread
+///     }
+///
+///     // This will run (in a separate kthread) iff `handle_irq` returns
+///     // `WakeThread`.
+///     fn thread_fn(&self) -> irq::ThreadedFnReturn {
+///         // We now have exclusive access to the data by locking the SpinLock.
+///         let mut handler = self.lock();
+///         handler.0 += 1;
+///     }
+///
+///     // This is running in process context.
+///     fn register_irq(irq: u32, handler: Handler) -> Result<irq::Registration<Handler>> {
+///         let registration = ThreadedRegistration::register(irq, irq::flags::SHARED, "my-device", handler)?;
+///
+///         // You can have as many references to the registration as you want, so
+///         // multiple parts of the driver can access it.
+///         let registration = Arc::pin_init(registration)?;
+///
+///         // The handler may be called immediately after the function above
+///         // returns, possibly in a different CPU.
+///
+///         // The data can be accessed from the process context too.
+///         registration.handler().lock().0 = 42;
+///
+///         Ok(registration)
+///     }
+/// }
+///
+/// # Ok::<(), Error>(())
+///```
+#[pin_data(PinnedDrop)]
+pub struct ThreadedRegistration<T: ThreadedHandler> {
+    irq: u32,
+    #[pin]
+    handler: Opaque<T>,
+}
+
+impl<T: ThreadedHandler> ThreadedRegistration<T> {
+    /// Registers the IRQ handler with the system for the given IRQ number. The
+    /// handler must be able to be called as soon as this function returns.
+    pub fn register(
+        irq: u32,
+        flags: Flags,
+        name: &'static CStr,
+        handler: T,
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            irq,
+            handler: Opaque::new(handler)
+        })
+        .pin_chain(move |slot| {
+            // SAFETY:
+            // - `handler` points to a valid function defined below.
+            // - only valid flags can be constructed using the `flags` module.
+            // - `devname` is a nul-terminated string with a 'static lifetime.
+            // - `ptr` is a cookie used to identify the handler. The same cookie is
+            // passed back when the system calls the handler.
+            to_result(unsafe {
+                bindings::request_threaded_irq(
+                    irq,
+                    Some(handle_threaded_irq_callback::<T>),
+                    Some(thread_fn_callback::<T>),
+                    flags.0,
+                    name.as_char_ptr(),
+                    &*slot as *const _ as *mut core::ffi::c_void,
+                )
+            })?;
+
+            Ok(())
+        })
+    }
+
+    /// Returns a reference to the handler that was registered with the system.
+    pub fn handler(&self) -> &T {
+        // SAFETY: `handler` is initialized in `register`.
+        unsafe { &*self.handler.get() }
+    }
+}
+
+#[pinned_drop]
+impl<T: ThreadedHandler> PinnedDrop for ThreadedRegistration<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY:
+        // - `self.irq` is the same as the one passed to `request_threaded_irq`.
+        // -  `&self` was passed to `request_threaded_irq` as the cookie. It is
+        // guaranteed to be unique by the type system, since each call to
+        // `register` will return a different instance of
+        // `ThreadedRegistration`.
+        //
+        // Notice that this will block until all handlers finish executing, so,
+        // at no point will &self be invalid while the handler is running.
+        unsafe { bindings::free_irq(self.irq, &*self as *const _ as *mut core::ffi::c_void) };
+    }
+}
+
+unsafe extern "C" fn handle_irq_callback<T: Handler>(
+    _irq: i32,
+    ptr: *mut core::ffi::c_void,
+) -> core::ffi::c_uint {
+    let data = unsafe { &*(ptr as *const T) };
+    T::handle_irq(data) as _
+}
+
+unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler>(
+    _irq: i32,
+    ptr: *mut core::ffi::c_void,
+) -> core::ffi::c_uint {
+    let data = unsafe { &*(ptr as *const T) };
+    T::handle_irq(data) as _
+}
+
+unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(
+    _irq: i32,
+    ptr: *mut core::ffi::c_void,
+) -> core::ffi::c_uint {
+    let data = unsafe { &*(ptr as *const T) };
+    T::thread_fn(data) as _
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e96a1dd9cf76bd34a8d992458870b4..0390bc0b114f60876414c82b5b8862401338d241 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub mod firmware;
 pub mod init;
 pub mod ioctl;
+pub mod irq;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;

---
base-commit: 33c255312660653cf54f8019896b5dca28e3c580
change-id: 20241023-topic-panthor-rs-request_irq-62008ccc82eb

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


