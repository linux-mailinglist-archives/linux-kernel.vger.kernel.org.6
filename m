Return-Path: <linux-kernel+bounces-541648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0AAA4BF83
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93228167E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1FC2036F9;
	Mon,  3 Mar 2025 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEUKodft"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF820C48A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002936; cv=none; b=owFVQ/qU6KUryMMMgFs43nICTqDLCdf60mdozDkYEPNRZnc5rfb3dSxKyV0XlWYg0y0nl3S1btg84HfC1s8fyzYUFOk0ynWnlcdEvHeinbdcgja47zRVNNJprFEUFMNV80qkYfmRFMP27LakSTrVfEsh/xSgHps7pwmgMTW2OsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002936; c=relaxed/simple;
	bh=ARBixnKaa2YiWZQGbYg6l+fDIhalnJw19qwnxyAKuJM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e3qmVPFySOsl5C4P1lY+oOsCqenyuZs0PXX2QV73utuvDk0akOZHhEJ0K/2igLgYRFM5sPq1bZMTaaElhHpDtc068FPqLPR8XT9arPCpNrAzZAK44eaDQMTfH6RpSxDWElmS5EgIJpgH1eCxfFeVrzp4gZVQL0E5qjTQ/ifxHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEUKodft; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4388eee7073so22797815e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741002932; x=1741607732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1xhEqKF15L5Rz/R/NPRqubc93fGir2lOgJV+LLpixRk=;
        b=ZEUKodft1kdRZEHeTk5YI3RdkrVxhV7xHqLVDJK6s/qM4/OosiOxwqp7T8uhVKI4DJ
         jGSHCrL0AejKnA8OELe9WAgi+wQhQlIcWqz+SWweRcOG8bt6QKtSjwcYkuJFijLw00MN
         G5f7zWu+TPwxytebYFbXpPMX3WTFw6KMyp8EtAAm/7AREOH6s1f7OoUgnQ1cMmveK/tF
         NO/ix+S9WK5RMqMjzfD2jpt5jeCk9dXyxff3DsTtWxicrO9W7gO1yTiiWpu1SklG7tWN
         qqU1RbSUTZZyH+EOZwzPjfIQjB554NnUhh3fBLM5FAnyIVg2sLJxbFbXRqPO1iSp64PL
         AGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002932; x=1741607732;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xhEqKF15L5Rz/R/NPRqubc93fGir2lOgJV+LLpixRk=;
        b=CC5nwJDcrE8mAWY0IZAe5CKs1e00JAXps3Mb/+GCQauB++QjJInVHxttTxsxo0qtnt
         2iJF/zqyzO9Gt/i4XUr8s6YCpq6tlEVZuew2Jm719L0VwGBEKzzRpzEJSNSMljwZy2fR
         KmSCIqGVbj8n9/Wbk1crDYKg3pf3JfIg4OSU/DXVYGtKs+XOH+ImKDVgE8z+CfPCNj+N
         iaWmWHcMYTfSC6yTJTmCpP6PeGzgQTzvPKwlOt7ePo57iuDFpeIcHpwsQtl+yBAlG8d7
         isu0mXnOmOGZ9im+P9DH6AeLI9O1GOEDu6Ed6GsDAnrrjzWIJGt+qdOCLs4Dy481z1N6
         +52Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC0x9t8mJ37qrQNzBQdjkgV2CUlTp5i9prLk+ua7G2zd4ZBAwsXy1KSvgimmejdwaveadGE57LiBn47tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLbtFfHgNQOzFud3qYvpwMx+OdvfHwMOlkQDNXU0d6NOG5E+M
	vs0Ri1X8ganwe+QgoycR8Il8ww4ldcJMRwaOV+jXu3kDrkuykcV7JDGnZQD5/19DGA==
X-Google-Smtp-Source: AGHT+IFZJk1XP58PmFKamy9K5ci7nNaM2rAgdZuqMpfwvU2d9ouxj3yspjhI6DCOxlDGzn8rncjyb9M=
X-Received: from wmgg5.prod.google.com ([2002:a05:600d:5:b0:43b:c99a:4af8])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e12:b0:439:9536:fa6b
 with SMTP id 5b1f17b1804b1-43b04dc34d4mr151150155e9.13.1741002932424; Mon, 03
 Mar 2025 03:55:32 -0800 (PST)
Date: Mon,  3 Mar 2025 11:40:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250303114037.3259804-2-bqe@google.com>
Subject: [PATCH v2] rust: add bindings and API for bitmap.h and bitops.h.
From: Burak Emir <bqe@google.com>
To: bqe@google.com, Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds a Rust bitmap API and necessary bitmap and bitops bindings.
These are for porting the approach from commit 15d9da3f818c ("binder:
use bitmap for faster descriptor lookup") to Rust. The functionality
in dbitmap.h makes use of bitmap and bitops.

The Rust bitmap API provides an abstraction to underlying bitmap
and bitops operations. For now, we only include methods that are
necessary for reimplementing dbitmap.h. It is straightforward to add
more methods later, as needed. We offer a safe API through
bounds checks which panic if violated.

We introduce bindings for the non-atomic variants __set_bit and
__clear_bit, and use the _find_* variants instead of the find_*
wrappers. The C optimizations enabled by the wrappers does not carry
over to Rust.

This series uses the usize type for sizes and indices into the bitmap,
because Rust generally always uses that type for indices and lengths
and it will be more convenient if the API accepts that type. This means
that we need to perform some casts to/from u32 and usize, since the C
headers use unsigned int instead of size_t/unsigned long for these
numbers in some places.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
This is v2 of a patch introducing Rust bitmap API [v1]. Thanks
for all the helpful comments!

Changes v1 --> v2:
- Rebased on Yury's v2 patch [1] and Viresh's v2 patch [2]
- Removed import of `bindings::*`, keeping only prefix (Miguel)
- Renamed panic methods to make more explicit (Miguel)
- use markdown in doc comments and added example/kunit test (Miguel)
- Added maintainer section for BITOPS API BINDINGS [RUST] (Yury)
- Added M: entry for bitmap.rs which goes to Alice (Viresh, Alice)
- Changed calls from find_* to _find_*, removed helpers (Yury)
- Use non-atomic __set_bit and __clear_bit from Bitmap Rust API (Yury)

Question to Yury: we could remove `bitmap_copy` helper and instead do
the memcpy in Rust. Should we? If so, should we expose a helper for
`bitmap_size` or duplicate the nbits-to-aligned-nlongs logic?

[1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/
[2] https://lore.kernel.org/all/cover.1740726226.git.viresh.kumar@linaro.org/
[v1]: https://lore.kernel.org/all/20250227101720.1811578-1-bqe@google.com/

Thanks,
Burak

---
 MAINTAINERS                     |   8 ++
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/bitmap.c           |   8 ++
 rust/helpers/bitops.c           |  13 +++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 191 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 7 files changed, 224 insertions(+)
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d6e55d8593b..8f42fb1f24c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4032,12 +4032,15 @@ F:	tools/lib/find_bit.c
 BITMAP API BINDINGS [RUST]
 M:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
 BITMAP API [RUST]
 M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
+M:	Alice Ryhl <aliceryhl@google.com> (bitmap)
 R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	rust/kernel/bitmap.rs
 F:	rust/kernel/cpumask.rs
 
 BITOPS API
@@ -4054,6 +4057,11 @@ F:	include/linux/bitops.h
 F:	lib/test_bitops.c
 F:	tools/*/bitops*
 
+BITOPS API BINDINGS [RUST]
+M:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/helpers/bitops.c
+
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 673b1daa9a58..50416c1a3de9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/bitmap.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
new file mode 100644
index 000000000000..4fa4e4f76110
--- /dev/null
+++ b/rust/helpers/bitmap.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitmap.h>
+
+void rust_helper_bitmap_copy(unsigned long *dst, const unsigned long *src, unsigned int nbits)
+{
+	bitmap_copy(dst, src, nbits);
+}
diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
new file mode 100644
index 000000000000..986dafb45184
--- /dev/null
+++ b/rust/helpers/bitops.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+
+void rust_helper___set_bit(unsigned int nr, volatile unsigned long *addr)
+{
+	__set_bit(nr, addr);
+}
+
+void rust_helper___clear_bit(unsigned int nr, volatile unsigned long *addr)
+{
+	__clear_bit(nr, addr);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index de2341cfd917..541d8cb30195 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,6 +7,8 @@
  * Sorted alphabetically.
  */
 
+#include "bitmap.c"
+#include "bitops.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
new file mode 100644
index 000000000000..783b11b70475
--- /dev/null
+++ b/rust/kernel/bitmap.rs
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust API for bitmap.
+//!
+//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h).
+
+use crate::alloc::{AllocError, Flags};
+use crate::bindings;
+use core::ptr::NonNull;
+
+/// Wraps underlying C bitmap structure.
+///
+/// # Invariants
+///
+/// * `ptr` is obtained from a successful call to `bitmap_zalloc` and
+///   holds the address of an initialized array of unsigned long
+///   that is large enough to hold `nbits` bits.
+pub struct Bitmap {
+    /// Pointer to an array of unsigned long.
+    ptr: NonNull<usize>,
+    /// How many bits this bitmap stores. Must be < 2^32.
+    nbits: usize,
+}
+
+impl Drop for Bitmap {
+    fn drop(&mut self) {
+        // SAFETY: `self.ptr` was returned by bitmap_zalloc.
+        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
+    }
+}
+
+#[cold]
+fn panic_not_in_bounds_lt(arg: &'static str, len: usize, val: usize) -> ! {
+    panic!("{arg} must be less than length {len}, was {val}");
+}
+
+#[cold]
+fn panic_not_in_bounds_le(arg: &'static str, len: usize, val: usize) -> ! {
+    panic!("{arg} must be less than or equal to length {len}, was {val}");
+}
+
+impl Bitmap {
+    /// Constructs a new [`Bitmap`].
+    ///
+    /// Fails with AllocError if `nbits` is greater than or equal to 2^32,
+    /// or when the bitmap could not be allocated.
+    ///
+    /// # Example
+    ///
+    /// ```
+    /// # use kernel::bitmap::Bitmap;
+    ///
+    /// fn new_bitmap() -> Bitmap {
+    ///   Bitmap::new(128, GFP_KERNEL).unwrap()
+    /// }
+    /// ```
+    #[inline]
+    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
+        if let Ok(nbits_u32) = u32::try_from(nbits) {
+            // SAFETY: nbits == 0 is permitted and nbits fits in u32.
+            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
+            // Zero-size allocation is ok and yields a dangling pointer.
+            let ptr = NonNull::new(ptr).ok_or(AllocError)?;
+            Ok(Bitmap { ptr, nbits })
+        } else {
+            Err(AllocError)
+        }
+    }
+
+    /// Returns how many bits this bitmap holds.
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.nbits
+    }
+
+    /// Returns true if this bitmap has length 0.
+    #[inline]
+    pub fn is_empty(&self) -> bool {
+        self.nbits == 0
+    }
+
+    /// Returns a mutable raw pointer to the backing bitmap.
+    #[inline]
+    pub fn as_mut_ptr(&mut self) -> *mut usize {
+        self.ptr.as_ptr()
+    }
+
+    /// Returns a raw pointer to the backing bitmap.
+    #[inline]
+    pub fn as_ptr(&self) -> *const usize {
+        self.ptr.as_ptr()
+    }
+
+    /// Sets bit with number `nr`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `nr` is greater than or equal to `self.nbits`.
+    #[inline]
+    pub fn set_bit(&mut self, nr: usize) {
+        if self.nbits <= nr {
+            panic_not_in_bounds_lt("nr", self.nbits, nr)
+        }
+        // SAFETY: Bit nr is within bounds.
+        unsafe { bindings::__set_bit(nr as u32, self.as_mut_ptr()) };
+    }
+
+    /// Clears bit with number `nr`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `nr` is greater than or equal to `self.nbits`.
+    #[inline]
+    pub fn clear_bit(&mut self, nr: usize) {
+        if self.nbits <= nr {
+            panic_not_in_bounds_lt("nr", self.nbits, nr);
+        }
+        // SAFETY: Bit nr is within bounds.
+        unsafe { bindings::__clear_bit(nr as u32, self.as_mut_ptr()) };
+    }
+
+    /// Copy up to `nbits` bits from this bitmap into another.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `nbits` is too large for this bitmap or destination.
+    #[inline]
+    pub fn bitmap_copy(&self, dst: &mut Bitmap, nbits: usize) {
+        if self.nbits < nbits {
+            panic_not_in_bounds_le("nbits", self.nbits, nbits);
+        }
+        if dst.nbits < nbits {
+            panic_not_in_bounds_le("nbits", dst.nbits, nbits);
+        }
+        // SAFETY: nbits == 0 is supported and access to `self` and `dst` is within bounds.
+        unsafe { bindings::bitmap_copy(dst.as_mut_ptr(), self.ptr.as_ptr(), nbits as u32) };
+    }
+
+    /// Finds the last bit.
+    #[inline]
+    pub fn find_last_bit(&self) -> usize {
+        // SAFETY: nbits == 0 is supported and access is within bounds.
+        unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) }
+    }
+
+    /// Finds the last bit, searching up to `nbits` bits.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `nbits` is too large for this bitmap.
+    #[inline]
+    pub fn find_last_bit_upto(&self, nbits: usize) -> usize {
+        if self.nbits < nbits {
+            panic_not_in_bounds_le("nbits", self.nbits, nbits);
+        }
+        // SAFETY: nbits == 0 is supported and access is within bounds.
+        unsafe { bindings::_find_last_bit(self.as_ptr(), nbits) }
+    }
+
+    /// Finds the next zero bit, searching up to `nbits`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `nbits` is too large for this bitmap.
+    #[inline]
+    pub fn find_next_zero_bit_upto(&self, nbits: usize) -> usize {
+        if self.nbits < nbits {
+            panic_not_in_bounds_le("nbits", self.nbits, nbits);
+        }
+        // SAFETY: nbits == 0 is supported and access is within bounds.
+        unsafe {
+            bindings::_find_next_zero_bit(self.as_ptr(), nbits, 0 /* offset */)
+        }
+    }
+
+    /// Finds the next zero bit, searching up to `nbits` bits, with offset `offset`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `nbits` is too large for this bitmap.
+    #[inline]
+    pub fn find_next_zero_bit_upto_offset(&self, nbits: usize, offset: usize) -> usize {
+        if self.nbits < nbits {
+            panic_not_in_bounds_le("nbits", self.nbits, nbits);
+        }
+        // SAFETY: nbits == 0 and out-of-bounds offset is supported, and access is within bounds.
+        unsafe { bindings::_find_next_zero_bit(self.as_ptr(), nbits, offset) }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index efbd7be98dab..be06ffc47473 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub use ffi;
 
 pub mod alloc;
+pub mod bitmap;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 #[doc(hidden)]
-- 
2.48.1.711.g2feabab25a-goog


