Return-Path: <linux-kernel+bounces-545206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3FAA4EA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E2319C315E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E35294F38;
	Tue,  4 Mar 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGt6lRn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A224EA93;
	Tue,  4 Mar 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109784; cv=none; b=fM5boU9ck4z9ocoWu7ww5EoHRp/vmBkXSIqg8Pr31oxwYgTqu5/q7vvLoyL3bfGp93nWuzyvMgvDOjSnHEf3V7rrYZegmwlQtxqv1kGSlu5lE+oR6axM5omoN507B2GdIJfGcjz2JBiWiVUV+Z7o5TbJl3rr0A7etQvsaBt83ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109784; c=relaxed/simple;
	bh=3aln9+M9ieNTPHO38xJ0g/bUpzp7dMA8QDZstujuk7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCNHvc+PqTuIf8PEdNi8WATYxsfAuyudYfe/x0KOv0h8JVb0rNbFH31QTsbyAgMayc4iLbKuKBn23YVEwhcoHSqjN5fLf92cAERBgzWS0NDMl5emthl7tLhws3VfnTF/OtdxwQw5GND3/Rk2JOpN52+LKU5RZDCdPdplytgiWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGt6lRn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90920C4CEE8;
	Tue,  4 Mar 2025 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741109783;
	bh=3aln9+M9ieNTPHO38xJ0g/bUpzp7dMA8QDZstujuk7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGt6lRn33MH6Nh8ExH089CWVB8DiWcQfh+LuWzHhwAf9VY9Idc9c5u6ngzFLAMg10
	 Bv56y+UnaF8U9b6/hT85+s248TD3+xIxGpqQ3RWEMLLbdgpe5G7KVzFxb+Q01OQQDb
	 PfSFboisVz1jh20GSr44nh3tZiH+6KKFhTs9PaSmOmLodlBRspV3GUGhMYkHdNMjtv
	 09rye8H4R4KToGlePywDqnaeTHREaAfsSW4nkFC7y6QPAf6pXcZAHi6q+YqicVt3aD
	 q1H1DEneUtk1deMG6vBhK3LgnKOmsYM7plu3EhIAsPe9NlRedt+nEFVe4CWR3ecH3r
	 xwl1XHHbf/C3g==
From: Danilo Krummrich <dakr@kernel.org>
To: airlied@gmail.com,
	simona@ffwll.ch,
	corbet@lwn.net,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	pstanner@redhat.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	bskeggs@nvidia.com,
	acurrid@nvidia.com
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 3/5] rust: firmware: add `module_firmware!` macro
Date: Tue,  4 Mar 2025 18:34:50 +0100
Message-ID: <20250304173555.2496-4-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304173555.2496-1-dakr@kernel.org>
References: <20250304173555.2496-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Analogous to the `module!` macro `module_firmware!` adds additional
firmware path strings to the .modinfo section.

In contrast to `module!`, where path strings need to be string literals,
path strings can be composed with the `firmware::ModInfoBuilder`.

Some drivers require a lot of firmware files (such as nova-core) and
hence benefit from more flexibility composing firmware path strings.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/firmware.rs | 79 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 6e6972d94597..5d1ac8287171 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -116,6 +116,85 @@ unsafe impl Send for Firmware {}
 // be used from any thread.
 unsafe impl Sync for Firmware {}
 
+/// Create firmware .modinfo entries.
+///
+/// This macro is the counterpart of the C macro `MODULE_FIRMWARE()`, but instead of taking a
+/// simple string literals, which is already covered by the `firmware` field of
+/// [`crate::prelude::module!`], it allows the caller to pass a builder type (e.g.
+/// [`ModInfoBuilder`]) which can create the firmware modinfo strings in a more flexible way.
+///
+/// Drivers should extend the [`ModInfoBuilder`] with their own driver specific builder type.
+///
+/// The `builder` argument must be a type which implements the following function.
+///
+/// `const fn create(module_name: &'static CStr) -> ModInfoBuilder`
+///
+/// `create` should pass the `module_name` to the [`ModInfoBuilder`] and, with the help of
+/// it construct the corresponding firmware modinfo.
+///
+/// Typically, such contracts would be enforced by a trait, however traits do not (yet) support
+/// const functions.
+///
+/// # Example
+///
+/// ```
+/// # mod module_firmware_test {
+/// # use kernel::firmware;
+/// # use kernel::prelude::*;
+/// #
+/// # struct MyModule;
+/// #
+/// # impl kernel::Module for MyModule {
+/// #     fn init(_module: &'static ThisModule) -> Result<Self> {
+/// #         Ok(Self)
+/// #     }
+/// # }
+/// #
+/// #
+/// struct Builder<const N: usize>;
+///
+/// impl<const N: usize> Builder<N> {
+///     const fn create(module_name: &'static kernel::str::CStr) -> firmware::ModInfoBuilder<N> {
+///         firmware::ModInfoBuilder::new(module_name)
+///             .prepare()
+///             .push("vendor/foo.bin")
+///             .prepare()
+///             .push("vendor/bar.bin")
+///     }
+/// }
+///
+/// module! {
+///    type: MyModule,
+///    name: "module_firmware_test",
+///    author: "Rust for Linux",
+///    description: "module_firmware! test module",
+///    license: "GPL",
+/// }
+///
+/// kernel::module_firmware!(Builder);
+/// # }
+/// ```
+#[macro_export]
+macro_rules! module_firmware {
+    ($($builder:tt)*) => {
+
+        #[cfg(not(MODULE))]
+        const fn __module_name() -> &'static kernel::str::CStr {
+            <LocalModule as kernel::ModuleMetadata>::NAME
+        }
+
+        #[cfg(MODULE)]
+        const fn __module_name() -> &'static kernel::str::CStr {
+            kernel::c_str!("")
+        }
+
+        #[link_section = ".modinfo"]
+        #[used]
+        static __MODULE_FIRMWARE: [u8; $($builder)*::create(__module_name()).build_length()] =
+            $($builder)*::create(__module_name()).build();
+    };
+}
+
 /// Builder for firmware module info.
 ///
 /// [`ModInfoBuilder`] is a helper component to flexibly compose firmware paths strings for the
-- 
2.48.1


