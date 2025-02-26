Return-Path: <linux-kernel+bounces-534571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E9EA468A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EB93AA01F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A222D7A9;
	Wed, 26 Feb 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqJfmxWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DB22A4F0;
	Wed, 26 Feb 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592582; cv=none; b=boM4leJtkcYjXc3M9YHm8guUFAEo3Y6z0H+RlHzFpFUgzTrpdO1m9qWvOzwpcOii0AJ9ZrW6qPmErZaxWTDVD/Z1vwIOAeg26+TuFUjR9Odi/NMYvb10ogJvoVSuzbGt/W5mXkmGHfPM72mNrnsD9BeoN6AoAELwqVx1hRDv6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592582; c=relaxed/simple;
	bh=BQ8xHMKrltZRFNzxJKwFtK1VAIQkorDo50VJfIqedqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDczEgoI0JQrA1C6R5NqBSokmyXRFHBe0nqQ3iffSesWW8aON+DAFivpAEFbX73WXJCGi76/21PVKy2PJKFKE8Uem6lKCRqUCrPrsmmjREgO4cQ50L5tNA2+AmXz3XnPeeAga+RUXX5Dx0maDcFjnfwxOmG3DGjWIRJyBwSNmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqJfmxWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BE1C4CEE9;
	Wed, 26 Feb 2025 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740592581;
	bh=BQ8xHMKrltZRFNzxJKwFtK1VAIQkorDo50VJfIqedqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqJfmxWQBjJ7tvEUfd6uYf1PEpWYAv09MkXWzee9bKtMvDe1brA+59hTUTi7Itawj
	 lICX7awqJbiC+u/jdk9ZwjwPp45oSKWBUeiurrmsrtWyeM5XP2akF5TdAPLomd9N/u
	 FmfocWK7R9CApGtVfmggHmJ+PvpXT1J7nIWr7+Rx9Qfu2A2pr5KM94E5jE1hUyqrwV
	 5WUTyQ0Tqn57A5QoAEAwZRNw8sEhGYcR0BcFXqlPZXJLFBqpcBYkxUKDcHKCN/xpyU
	 tC1vFxRDndUTHptxeO9xXM1rVEKE725QtUB2sJ6cPkfOV66qrxBIy+sQL2jIo4r05l
	 L0D8hs9UQ8+sQ==
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
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4 3/6] rust: firmware: introduce `firmware::ModInfoBuilder`
Date: Wed, 26 Feb 2025 18:55:45 +0100
Message-ID: <20250226175552.29381-4-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226175552.29381-1-dakr@kernel.org>
References: <20250226175552.29381-1-dakr@kernel.org>
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

It is meant to be used in combination with `kernel::module_firmware!`,
which is introduced in a subsequent patch.

Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/firmware.rs | 98 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index c5162fdc95ff..0f27dc212d6e 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -115,3 +115,101 @@ unsafe impl Send for Firmware {}
 // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
 // be used from any thread.
 unsafe impl Sync for Firmware {}
+
+/// Builder for firmware module info.
+///
+/// [`ModInfoBuilder`] is a helper component to flexibly compose firmware paths strings for the
+/// .modinfo section in const context.
+///
+/// It is meant to be used in combination with [`kernel::module_firmware!`].
+///
+/// For more details and an example, see [`kernel::module_firmware!`].
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
+    /// After a new [`ModInfoBuilder`] instance has been created, [`ModInfoBuilder::prepare`] must
+    /// be called before adding path components.
+    pub const fn push(self, bytes: &[u8]) -> Self {
+        if N != 0 && self.n == 0 {
+            crate::build_error!("Must call prepare() before push().");
+        }
+
+        self.push_internal(bytes)
+    }
+
+    const fn prepare_module_name(self) -> Self {
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
+        this.push_internal(b"firmware=")
+    }
+
+    /// Prepare for the next module info entry.
+    ///
+    /// Must be called before [`ModInfoBuilder::push`] can be called.
+    pub const fn prepare(self) -> Self {
+        self.push_internal(b"\0").prepare_module_name()
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


