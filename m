Return-Path: <linux-kernel+bounces-549994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AECC3A559AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9752D3B172A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1527CB34;
	Thu,  6 Mar 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbcKDMn+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2927C867;
	Thu,  6 Mar 2025 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299839; cv=none; b=QCjSndDFmxn66bQIA4AwPX6Gy56CCtwBpW2WwzxI1s6kextZJTsqRAMPqLHAWK+QHXUBMjZoIA3YojbL4NAOLs1AoTEF3Zp1ZiVYCg+jlX8/kdT9KWAKWsSvGLdhhDiMNeOozBmnvrkvS3bd337Q4kBbW+LXgwaq0ukW+UkdbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299839; c=relaxed/simple;
	bh=ILGJjKKo5nQZHxzXgwewCMckflvSqIeS3xmxKI0k4uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI3POJgmeIfj3YF6fTAnP3CU6S3/VrISBOHuxK8QGFEXpENPLCL8UFGgY8hD9uelu9GaFk9YBcLc/OSP2M6KCW5Se6rII5agz5rcSIT5lgjH48fGS/Sh6hYRLM7Hzu8mCV+zInJxtH+QQu1d0ZlUdyrBKiSpcqXGv7cfj0dwofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbcKDMn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D4AC4CEEB;
	Thu,  6 Mar 2025 22:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741299839;
	bh=ILGJjKKo5nQZHxzXgwewCMckflvSqIeS3xmxKI0k4uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbcKDMn+v17Jlhx7k1of1maIC3wGlRZRcgexU9K896QzxSROQEhd5YkuHiPaEKPfp
	 YNd15lAFxZ5nEXsQtXTWFtQX4EbhZRYBZhw4UxQwHF4sDXrUGs18SHeJP5xTLZGQNn
	 hAEOFNMyQWxy7wX7mBDL5FfHqozrd1QbipglcV6Xi0TafZxC01zX/71bJxfdXTe0E9
	 VUbQpWfSuyDow21BWdgx9ZScYZEgK9d7+ePkGYbHau+R6kL1vlhVoLkfEvIjJ1/Yka
	 EhZNKq8Q6eaXv42yK9oZILxlBrXGKMonB+Gsk8TC1yKwd51UvPs6zN3kGcJGdysJan
	 59FwoY6ItGEkg==
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
Subject: [PATCH v6 2/5] rust: firmware: introduce `firmware::ModInfoBuilder`
Date: Thu,  6 Mar 2025 23:23:28 +0100
Message-ID: <20250306222336.23482-3-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306222336.23482-1-dakr@kernel.org>
References: <20250306222336.23482-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `firmware` field of the `module!` only accepts literal strings,
which is due to the fact that it is implemented as a proc macro.

Some drivers require a lot of firmware files (such as nova-core) and
hence benefit from more flexibility composing firmware path strings.

The `firmware::ModInfoBuilder` is a helper component to flexibly compose
firmware path strings for the .modinfo section in const context.

It is meant to be used in combination with `kernel::module_firmware!`.

Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/firmware.rs | 127 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index c5162fdc95ff..6008b62f2de8 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -115,3 +115,130 @@ unsafe impl Send for Firmware {}
 // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
 // be used from any thread.
 unsafe impl Sync for Firmware {}
+
+/// Builder for firmware module info.
+///
+/// [`ModInfoBuilder`] is a helper component to flexibly compose firmware paths strings for the
+/// .modinfo section in const context.
+///
+/// Therefore the [`ModInfoBuilder`] provides the methods [`ModInfoBuilder::new_entry`] and
+/// [`ModInfoBuilder::push`], where the latter is used to push path components and the former to
+/// mark the beginning of a new path string.
+///
+/// [`ModInfoBuilder`] is meant to be used in combination with `kernel::module_firmware!`.
+///
+/// The const generic `N` as well as the `module_name` parameter of [`ModInfoBuilder::new`] is an
+/// internal implementation detail and supplied through the above macro.
+pub struct ModInfoBuilder<const N: usize> {
+    buf: [u8; N],
+    n: usize,
+    module_name: &'static CStr,
+}
+
+impl<const N: usize> ModInfoBuilder<N> {
+    /// Create an empty builder instance.
+    pub const fn new(module_name: &'static CStr) -> Self {
+        Self {
+            buf: [0; N],
+            n: 0,
+            module_name,
+        }
+    }
+
+    const fn push_internal(mut self, bytes: &[u8]) -> Self {
+        let mut j = 0;
+
+        if N == 0 {
+            self.n += bytes.len();
+            return self;
+        }
+
+        while j < bytes.len() {
+            if self.n < N {
+                self.buf[self.n] = bytes[j];
+            }
+            self.n += 1;
+            j += 1;
+        }
+        self
+    }
+
+    /// Push an additional path component.
+    ///
+    /// Append path components to the [`ModInfoBuilder`] instance. Paths need to be separated
+    /// with [`ModInfoBuilder::new_entry`].
+    ///
+    /// # Example
+    ///
+    /// ```
+    /// use kernel::firmware::ModInfoBuilder;
+    ///
+    /// # const DIR: &str = "vendor/chip/";
+    /// # const fn no_run<const N: usize>(builder: ModInfoBuilder<N>) {
+    /// let builder = builder.new_entry()
+    ///     .push(DIR)
+    ///     .push("foo.bin")
+    ///     .new_entry()
+    ///     .push(DIR)
+    ///     .push("bar.bin");
+    /// # }
+    /// ```
+    pub const fn push(self, s: &str) -> Self {
+        // Check whether there has been an initial call to `next_entry()`.
+        if N != 0 && self.n == 0 {
+            crate::build_error!("Must call next_entry() before push().");
+        }
+
+        self.push_internal(s.as_bytes())
+    }
+
+    const fn push_module_name(self) -> Self {
+        let mut this = self;
+        let module_name = this.module_name;
+
+        if !this.module_name.is_empty() {
+            this = this.push_internal(module_name.as_bytes_with_nul());
+
+            if N != 0 {
+                // Re-use the space taken by the NULL terminator and swap it with the '.' separator.
+                this.buf[this.n - 1] = b'.';
+            }
+        }
+
+        this
+    }
+
+    /// Prepare the [`ModInfoBuilder`] for the next entry.
+    ///
+    /// This method acts as a separator between module firmware path entries.
+    ///
+    /// Must be called before constructing a new entry with subsequent calls to
+    /// [`ModInfoBuilder::push`].
+    ///
+    /// See [`ModInfoBuilder::push`] for an example.
+    pub const fn new_entry(self) -> Self {
+        self.push_internal(b"\0")
+            .push_module_name()
+            .push_internal(b"firmware=")
+    }
+
+    /// Build the byte array.
+    pub const fn build(self) -> [u8; N] {
+        // Add the final NULL terminator.
+        let this = self.push_internal(b"\0");
+
+        if this.n == N {
+            this.buf
+        } else {
+            crate::build_error!("Length mismatch.");
+        }
+    }
+}
+
+impl ModInfoBuilder<0> {
+    /// Return the length of the byte array to build.
+    pub const fn build_length(self) -> usize {
+        // Compensate for the NULL terminator added by `build`.
+        self.n + 1
+    }
+}
-- 
2.48.1


