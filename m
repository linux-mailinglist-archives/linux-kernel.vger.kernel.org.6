Return-Path: <linux-kernel+bounces-234076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D291C1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E8A1C20833
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E0D1C2327;
	Fri, 28 Jun 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdSgsu42"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072561C8FBC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586683; cv=none; b=gX2DxENgVwuqMjAbL/G52ZtDmUGYZyvmAivKRljqivVVuvgNiaPt0uAmRvt5PES3qrv8hIrCp2F1qYUobCXOh7SY97aRJeWhWdALLA5H3FPy7LCE9PH3JK3voNX1eRMqEGvhXC2qlSmYB0WC2oMdjxUsNLzQ1xmp6+PFs0PnD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586683; c=relaxed/simple;
	bh=ga/i0Ls35fCY8YV78KUSoH70UwUyGmCIIMOEY6Y8GEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIrGHNBqEWCMFyVEIdZK0iPQFwDWwNj2390vZbIwhfxz/Lm7FcE9KN19khWXGJH948ZAfEIoGOxO5kCE9difdUjOaF+kTaejZHNZdyIobSXCqP6QKFz8FkNp6jFVcC2+RYpfe4HmfexjpB2EInzu4eVbRDOBZCINRNv2AHMYG5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdSgsu42; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-52ce0424506so844918e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586678; x=1720191478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKNhAShYl2ft6CJ5KlQf/Btl3Xr+pMe1lD7fxUEeZXA=;
        b=RdSgsu42slNB051+uT2W1sssKaT0dBua3wdhjo12dqRv2I8prYtVNS9yzRJLhpu5BM
         QPb08x0lSlBdoZCVj612UnXjWinHw0pLvsZj2TsXLLNR2+IMbH47c4GGvPX8iL2AWlr4
         1r2BxJ49ODedaXOVKlL8ZXxYZpAcugxg3ZafhSo7COsMQKAwj6TtwgUey3JMvyiXjeCT
         0ijHwL76dAWC1M108rSEgdkNTz4WCopzpOUlveTgkWirfyDMbRdsuoa0CUHQb08T3PiV
         NrXDRTAmBDkFk4GGRNlI8EwD5y4Kxj/yHuyGdrusR1pJuRnUNtdwXRrsqYVnaiFTou0k
         vZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586678; x=1720191478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKNhAShYl2ft6CJ5KlQf/Btl3Xr+pMe1lD7fxUEeZXA=;
        b=Wo7Jsa05oFcPG+fiKj96h7uxaI7tRHFZXqc8auxxHvBUzgfc557RBj8azMLLLw//64
         fTx3CH1w6DwBd4up9xrNBSwlOBgniTp6Znq8tfa8L74q9IpQ76+CtkBLChKiBMXz9d+3
         Rix9BkP1xAo83DoZzQRMp85bFaC2kI4OgwQLMjzSw0JVk6oP8LF2kbSXVzhQnkfiWleZ
         YA3DZYScOcRhTGgz0kINMUVAbdt7w7b0VlwJqzpleZnlKaLtdvRoJSoxx139oJuOh0hJ
         61pZylPAPahF9/85myWYpIdp4LxvAjvEoQtRDCNLbck0/0I3AsRXH4eWlOvIuvyTTGuQ
         or5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwB2H7mJ/jmrM9ZSZch/ZrvutA3HtfPohNTj4HeLj9vxmwaa6ar6mY6qKiioVLZBTipG0fcR9CzQcl6X5IhtKZhhL9juRclwtsM95U
X-Gm-Message-State: AOJu0YwQ4Z6BBaaaZr4PsKP8AHixJL6Zdi0zTIeZ40tL+VfMxYB0kEfX
	mJSqRPOGt2Z9xZPxrhwevqXTwUXqXJUnlWJAE0ax4Dotw3Ge/YSzSIhOng7C8iEW9kXoj7WmJP3
	hKFLXtMiPUNcdiQ==
X-Google-Smtp-Source: AGHT+IHJC6o+lUlIFO7TinLD84hZqcPdCGTwHSu/cNBNaG382CRlS8Qcn3syKx6kEDE1pwh70GYf8EQFI780xsc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:58cb:0:b0:52c:97a8:63db with SMTP id
 2adb3069b0e04-52ce183adecmr19220e87.7.1719586678195; Fri, 28 Jun 2024
 07:57:58 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:57:17 +0000
In-Reply-To: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7101; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=RLxJnIFmmThp3fETtbijGb8ieDu222aEk+QMIYVNKMM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfs9kLchzWCZxKvmZirniEjMYg6x6IpyWbkVDt
 Gc2J6HlVjGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn7PZAAKCRAEWL7uWMY5
 RrdbEACmlKuKhZnKfdtJeHmMsHCFUz/SVUYD6sxWsLjXbGQpriNwGnqQkUUT/IJxr0Csp4XBCLr
 VKcZ09jPKO73ykP5uPfbsOn7E2qu2anYkFBpcCDpsqMJXMOIE+b2ZKV3tGw4Upkw2lnur2qn08N
 iV2MAA8nGD7rna2bsf8DyM0re2MCU1Ux4jhT8Vz7blpwi60ezAUBJ4t7XIUXSesWjbrgbLzjdBq
 eNOV5op4NjcpKqenS5oEsbOUhq53e3y0l25ic1cWBHEOwDggXrlA4ZmPwwSTfitrsv1uGm6abO2
 NqYzjx/lzcBTUFSMCdNaba7iddy0dqwWFbpTuPgPPKcTkHuvovpiwimGJWjPLM9Mu/PwABhmtwT
 R6qEsjgPK0Cui3794fLBnPNfltSrNY9AnM19rtYqvgd5/PSArwKR0zLB2D+mDoX1e0sTC9QW52/
 wkS6IUiGXF44qkJ9n5kzY4hUjz0HQmLw7ldgVSKjhFnPniJTfOJs8Pq70RGB66kTbLCRgaOIxW2
 x/RSaJqhOneYL3vWG/yJT0SF+ZZYw4bbaN8mmg6+e8A43/6CiR2Xgh31UCTcjrxS26s8CxEms0r
 zBpJqZcPItoUM15UGH+1/onjUR+W2Qj/dts/+8yS7rkFbpDz7mtfYlcBz0u5v0TAlTHQkcbyAOm DUHj8DuGOhYQGQg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-alice-file-v7-4-4d701f6335f3@google.com>
Subject: [PATCH v7 4/8] rust: cred: add Rust abstraction for `struct cred`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="utf-8"

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a wrapper around `struct cred` called `Credential`, and provide
functionality to get the `Credential` associated with a `File`.

Rust Binder must check the credentials of processes when they attempt to
perform various operations, and these checks usually take a
`&Credential` as parameter. The security_binder_set_context_mgr function
would be one example. This patch is necessary to access these security_*
methods from Rust.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 13 ++++++++
 rust/kernel/cred.rs             | 74 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/file.rs             | 13 ++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 102 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 541afef7ddc4..94091cb337e9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index e68025b53342..9cf25e5324a4 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,6 +23,7 @@
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
@@ -172,6 +173,18 @@ struct file *rust_helper_get_file(struct file *f)
 }
 EXPORT_SYMBOL_GPL(rust_helper_get_file);
 
+const struct cred *rust_helper_get_cred(const struct cred *cred)
+{
+	return get_cred(cred);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_cred);
+
+void rust_helper_put_cred(const struct cred *cred)
+{
+	put_cred(cred);
+}
+EXPORT_SYMBOL_GPL(rust_helper_put_cred);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
new file mode 100644
index 000000000000..360d6fdbe5e7
--- /dev/null
+++ b/rust/kernel/cred.rs
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Credentials management.
+//!
+//! C header: [`include/linux/cred.h`](srctree/include/linux/cred.h).
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
+
+use crate::{
+    bindings,
+    types::{AlwaysRefCounted, Opaque},
+};
+
+/// Wraps the kernel's `struct cred`.
+///
+/// Credentials are used for various security checks in the kernel.
+///
+/// Most fields of credentials are immutable. When things have their credentials changed, that
+/// happens by replacing the credential instead of changing an existing credential. See the [kernel
+/// documentation][ref] for more info on this.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_cred` ensures that the
+/// allocation remains valid at least until the matching call to `put_cred`.
+///
+/// [ref]: https://www.kernel.org/doc/html/latest/security/credentials.html
+#[repr(transparent)]
+pub struct Credential(Opaque<bindings::cred>);
+
+// SAFETY:
+// - `Credential::dec_ref` can be called from any thread.
+// - It is okay to send ownership of `Credential` across thread boundaries.
+unsafe impl Send for Credential {}
+
+// SAFETY: It's OK to access `Credential` through shared references from other threads because
+// we're either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for Credential {}
+
+impl Credential {
+    /// Creates a reference to a [`Credential`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`Credential`] reference.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `Credential` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the effective UID of the given credential.
+    pub fn euid(&self) -> bindings::kuid_t {
+        // SAFETY: By the type invariant, we know that `self.0` is valid. Furthermore, the `euid`
+        // field of a credential is never changed after initialization, so there is no potential
+        // for data races.
+        unsafe { (*self.0.get()).euid }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
+unsafe impl AlwaysRefCounted for Credential {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_cred(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero. The cast is okay
+        // because `Credential` has the same representation as `struct cred`.
+        unsafe { bindings::put_cred(obj.cast().as_ptr()) };
+    }
+}
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 08551bf5c625..91113f844981 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -7,6 +7,7 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -272,6 +273,18 @@ pub fn as_ptr(&self) -> *mut bindings::file {
         self.inner.get()
     }
 
+    /// Returns the credentials of the task that originally opened the file.
+    pub fn cred(&self) -> &Credential {
+        // SAFETY: It's okay to read the `f_cred` field without synchronization because `f_cred` is
+        // never changed after initialization of the file.
+        let ptr = unsafe { (*self.as_ptr()).f_cred };
+
+        // SAFETY: The signature of this function ensures that the caller will only access the
+        // returned credential while the file is still valid, and the C side ensures that the
+        // credential stays valid at least as long as the file.
+        unsafe { Credential::from_ptr(ptr) }
+    }
+
     /// Returns the flags associated with the file.
     ///
     /// The flags are a combination of the constants in [`flags`].
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index dba3415c1cee..ea7d07f0e83d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -28,6 +28,7 @@
 
 pub mod alloc;
 mod build_assert;
+pub mod cred;
 pub mod error;
 pub mod file;
 pub mod init;

-- 
2.45.2.803.g4e1b14247a-goog


