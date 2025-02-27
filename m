Return-Path: <linux-kernel+bounces-535977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA6A479FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D54189227B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C9224249;
	Thu, 27 Feb 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdqbm/49"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D481E1E01
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651463; cv=none; b=G93rCVy2wb+Cs/yQ5FOzhQMZoYkRVlHWznbKt/3KhzzmjvHRhOCZguoClZ0WGFVj9pr/rneS4otfhvjjzQ7WnELyP3TvbluSSK9HzJMaMCDRNrCOlvLM3eFaV9rKosPhlC7YtiLmEwcwBgxKMmrDxtHXwxCyBGf0/xsMjriMvwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651463; c=relaxed/simple;
	bh=q8O25ZErh+YLAy6NGyQso9ISXKK4chcQifjbXMLfS2k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SouPmeAeEsRlLIJBxCT8/2Ay3Xm+/Oingz61ncicQY/MWAbFHkjvhODlg434REM0/s+ZtT0XxVY7/Ezez92KPd/04Or4d29b+FSkJIS6DN78NSpxgOCLtjQeXXqgngsNu01iwkfoSLV1ImXHRyY9rty223AFNs8eweRy2AxEi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdqbm/49; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ab456333aso7141805e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740651459; x=1741256259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kFj0ZzXY7CxT95rWrmk7m04DzCVcPn5EiM5UeE+gnaU=;
        b=xdqbm/49J0PnffHbl3xtBc2zhia6jNUiozRjhs03RqeFNzE5XeUdYvHWvnhutjgaRi
         NAxh5lQ8DlsxCqoyh16/dnmp+YX8ya3Os/OpKEYfPiog5xYNIzRlIe2rQdH3PKLorAGN
         S9h9FsiGxPxWgwV/2IyqvX8KrC6lV+EzevrBdrBiSjfN49IST9FykzQ2Q3E34gxcBeTL
         +u093hJdPCnm4Fv5lvPT/506fmGbpN75p7sKLz4VM1d3k4PbtYhvKboHGAVhE0UrDGMa
         lND4ZH+XzAhnbEaGQ6ln8qWA79v2uolELvIYMgReXNDVYmXgD4tkO/gUsdWnSNq7pBfl
         fS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651459; x=1741256259;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFj0ZzXY7CxT95rWrmk7m04DzCVcPn5EiM5UeE+gnaU=;
        b=YETHEt0UkcAzlLAnYWCPe/+zypCiZZMuTTU6fwo9tjECRelAgrVG2m0uZ5zw1VlA9/
         P4+cvfBSRfsAoX1x8V0ghjimzbqrlsux/Mo9UTg4+tZtMScoq4GhWZBcJewqcQuOhmDk
         ouCu6LVK1STb6UmY4DOFbMb/L7s9cdKf44lUuX5IRUa8eAonPVdrlRwUjbNvOqNF5fql
         3HdzoLHSxgGnA0uEIDXio5yw4p09xPAoOEldAtrDSAHz3VO76FYMKgHycaJYK0OMVQEK
         +KXY8oanTR3akQC1UNGp7AcjRp3adaGC3cRYWDDxcoccZYH4PkW8/pwqDPht+aTFqfLE
         roTA==
X-Forwarded-Encrypted: i=1; AJvYcCUiIeSyogqAyR+eSUxK+JJT+p0mamLEd30t2BnP7F73hIPTM+sGxDmIWqDjiHp18E8A6XoS8zltQSprpm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHViBabzLe82g9W/8bdYRuYfTvfFR5J5Wl7zEmNupPvBUQBE8
	Fgks7q1cI/7bNS8bsNuSaW1/K5ETEZB4ZTiOnHnNUic1rni/p/M0u5wvF1I7SlvHbw==
X-Google-Smtp-Source: AGHT+IHLhrWF3dhK4n0mqgAn6rGmJPaaim2Cp9PRSW6vUchlM9/HHhIdNZgygcJCh7ZGnfwxeeEsTw4=
X-Received: from wmbbi15.prod.google.com ([2002:a05:600c:3d8f:b0:439:8333:1efb])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a01:b0:439:9424:1b70
 with SMTP id 5b1f17b1804b1-43ab0f6fd2amr131962545e9.30.1740651459744; Thu, 27
 Feb 2025 02:17:39 -0800 (PST)
Date: Thu, 27 Feb 2025 10:08:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227101720.1811578-1-bqe@google.com>
Subject: [PATCH] rust: add bindings and API for bitmap.h and bitops.h.
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds a bitmap and bitops bindings and bitmap Rust API.
These are for porting the approach from commit 15d9da3f818c ("binder:
use bitmap for faster descriptor lookup") to Rust. The functionality
in dbitmap.h makes use of bitmap and bitops.

The Rust bitmap API provides an abstraction to underlying bitmaps
and bitops operations. For now, we only include methods that are
necessary for reimplementing dbitmap.h. It is straightforward to add
more methods later, as needed. We offer a safe API through
bounds checks which panic if violated.

This series uses the usize type for sizes and indices into the bitmap,
because Rust generally always uses that type for indices and lengths
and it will be more convenient if the API accepts that type. This means
that we need to perform some casts to/from u32 and usize, since the C
headers use unsigned int instead of size_t/unsigned long for these
numbers in some places.

Adds F: entries to MAINTAINERS.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
This series adds a Rust abstraction for bitmap, and binding helpers
for inline methods of bitmap.h bitops.h.

It depends on [1] and [2] which add bitmap helpers, MAINTAINERS entries
and an abstraction that is part of the bitmaps Rust API.

Question for Yury: What would you like us to do for the MAINTAINERS
file? For now I just added the new files as F: entries.

[1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/
[2] https://lore.kernel.org/all/cover.1740475625.git.viresh.kumar@linaro.org/

 MAINTAINERS                     |   4 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/bitmap.c           |   8 ++
 rust/helpers/bitops.c           |  13 +++
 rust/helpers/find.c             |  15 +++
 rust/helpers/helpers.c          |   3 +
 rust/kernel/bitmap.rs           | 182 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 8 files changed, 227 insertions(+)
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/helpers/find.c
 create mode 100644 rust/kernel/bitmap.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d6e55d8593b..359f09e8e2c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4033,12 +4033,16 @@ BITMAP API BINDINGS [RUST]
 M:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
 F:	rust/helpers/cpumask.c
+F:	rust/helpers/find.c
+F:	rust/helpers/bitmap.c
+F:	rust/helpers/bitops.c
 
 BITMAP API [RUST]
 M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
 R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
 F:	rust/kernel/cpumask.rs
+F:	rust/kernel/bitmap.rs
 
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
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
index 000000000000..191ef0341fd5
--- /dev/null
+++ b/rust/helpers/bitops.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+
+void rust_helper_set_bit(unsigned int nr, volatile unsigned long *addr)
+{
+	set_bit(nr, addr);
+}
+
+void rust_helper_clear_bit(unsigned int nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
diff --git a/rust/helpers/find.c b/rust/helpers/find.c
new file mode 100644
index 000000000000..3841d3f0330f
--- /dev/null
+++ b/rust/helpers/find.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/find.h>
+
+unsigned long rust_helper_find_last_bit(const unsigned long *addr, unsigned long size)
+{
+	return find_last_bit(addr, size);
+}
+
+
+unsigned long rust_helper_find_next_zero_bit(const unsigned long *addr, unsigned long size,
+				 unsigned long offset)
+{
+	return find_next_zero_bit(addr, size, offset);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index de2341cfd917..86ebbc97a57d 100644
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
@@ -15,6 +17,7 @@
 #include "cred.c"
 #include "device.c"
 #include "err.c"
+#include "find.c"
 #include "fs.c"
 #include "io.c"
 #include "jump_label.c"
diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
new file mode 100644
index 000000000000..25fe07a7073a
--- /dev/null
+++ b/rust/kernel/bitmap.rs
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust API for bitmap.
+//!
+//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h).
+
+use crate::alloc::{AllocError, Flags};
+use crate::bindings::{
+    bitmap_copy, bitmap_free, bitmap_zalloc, clear_bit, find_last_bit, find_next_zero_bit, set_bit,
+};
+use core::ptr::NonNull;
+
+/// Wraps underlying C bitmap structure.
+///
+/// # Invariants
+///
+/// * `ptr` is obtained from a successful call to bitmap_zalloc and
+///   holds the address of a zero-initialized array of unsigned long
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
+        unsafe { bitmap_free(self.as_mut_ptr()) };
+    }
+}
+
+#[cold]
+fn not_in_bounds_lt(arg: &'static str, len: usize, val: usize) -> ! {
+    panic!("{arg} must be less than length {len}, was {val}");
+}
+
+#[cold]
+fn not_in_bounds_le(arg: &'static str, len: usize, val: usize) -> ! {
+    panic!("{arg} must be less than or equal to length {len}, was {val}");
+}
+
+impl Bitmap {
+    /// Constructs a new Bitmap.
+    ///
+    /// Fails with AllocError if `nbits` is greater than or equal to 2^32,
+    /// or when the bitmap could not be allocated.
+    #[inline]
+    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
+        if let Ok(nbits_u32) = u32::try_from(nbits) {
+            // SAFETY: nbits == 0 is permitted and nbits fits in u32.
+            let ptr = unsafe { bitmap_zalloc(nbits_u32, flags.as_raw()) };
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
+            not_in_bounds_lt("nr", self.nbits, nr)
+        }
+        // SAFETY: Bit nr is within bounds.
+        unsafe { set_bit(nr as u32, self.as_mut_ptr()) };
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
+            not_in_bounds_lt("nr", self.nbits, nr);
+        }
+        // SAFETY: Bit nr is within bounds.
+        unsafe { clear_bit(nr as u32, self.as_mut_ptr()) };
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
+            not_in_bounds_le("nbits", self.nbits, nbits);
+        }
+        if dst.nbits < nbits {
+            not_in_bounds_le("nbits", dst.nbits, nbits);
+        }
+        // SAFETY: nbits == 0 is supported and access to `self` and `dst` is within bounds.
+        unsafe { bitmap_copy(dst.as_mut_ptr(), self.ptr.as_ptr(), nbits as u32) };
+    }
+
+    /// Finds the last bit.
+    #[inline]
+    pub fn find_last_bit(&self) -> usize {
+        // SAFETY: nbits == 0 is supported and access is within bounds.
+        unsafe { find_last_bit(self.as_ptr(), self.nbits) }
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
+            not_in_bounds_le("nbits", self.nbits, nbits);
+        }
+        // SAFETY: nbits == 0 is supported and access is within bounds.
+        unsafe { find_last_bit(self.as_ptr(), nbits) }
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
+            not_in_bounds_le("nbits", self.nbits, nbits);
+        }
+        // SAFETY: nbits == 0 is supported and access is within bounds.
+        unsafe {
+            find_next_zero_bit(self.as_ptr(), nbits, 0 /* offset */)
+        }
+    }
+
+    /// Finds the next zero bit, searching up to `nbits` bits, with offset `offset`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `nbits` is too large for this bitmap.
+    pub fn find_next_zero_bit_upto_offset(&self, nbits: usize, offset: usize) -> usize {
+        if self.nbits < nbits {
+            not_in_bounds_le("nbits", self.nbits, nbits);
+        }
+        // SAFETY: nbits == 0 and out-of-bounds offset is supported, and access is within bounds.
+        unsafe { find_next_zero_bit(self.as_ptr(), nbits, offset) }
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
2.48.1.658.g4767266eb4-goog


