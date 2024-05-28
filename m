Return-Path: <linux-kernel+bounces-192578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2ED8D1F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F11928571C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BA17083D;
	Tue, 28 May 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OH6vs6Db"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301A16FF5F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908300; cv=none; b=Q8B6B1oQEfGh+Mn8LDoFfNu9yuEF29naC+o8BHtVENo/zf9Fmm9+1HV5qubp5sk/NqpoSoFOT+4lmCktJVtc5Z2F3YZd7RYI3OOxmboLdAobBdJmaHmzqVGqAMotdObuty5PCDjNn9t6LJKX+NPyxI3mJvOhhrj/RVx+BMPI/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908300; c=relaxed/simple;
	bh=bAnCEa/erhDmZsiB7H9fwSPtBIVcIRW/I8ZTIy0mAKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IOKpf1rNVjyyGQY6t6FvGD73CQb/9B9Lk7isoWKKhg4PFmC4OGUrSnH+EyeJ1OfynN1n2AOSVr8dUK/XBFxTfpmooy0YDEUv3Ge+M6n1fNGgA30rRgeQzj/1cPnecmSAy+yRB2Iqs6MfF4A3jTS8tc+qotxVV6UsC5c7fya34LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OH6vs6Db; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-5296043d77bso809042e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716908297; x=1717513097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MbNhTCNPPg7usQjQRVAmhprE0uGhsuRXbAWwmmZLIiQ=;
        b=OH6vs6DbiQ+GOT/0A4xJJwWnwe8l1Sr24r7l9VfqCxEo+ks8a1+a/tuFiaXW11+o5S
         OoNCi0SQp8DkzG6Eyw1vbSQV7w46gkw9XLZh+iUtGdE2WyukimxZSKyG08wYkXV1Zb+8
         JQiItXCFoQK+F19zb3PtbAe4TYmB6RWkhFC2Rg0vVI3t/bk9jHqesfgymzQjANgkJik4
         vHzRDwJB7ZddPI9qgvIhRnmYp5N3VFDEWzU1EMMv1N3nNwJhpI6zaSVrqZJwNgwTnhOf
         sN/MPFetEgflwRennRELSoTfMG68TiffYGXC8JrejIxu5Kf0yWBu5JV2Sc2auFg9KCK/
         dyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716908297; x=1717513097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbNhTCNPPg7usQjQRVAmhprE0uGhsuRXbAWwmmZLIiQ=;
        b=AZzfvhn8zhN8ZpuAO2fDIlnRu8wYo6UoyAwuCcgjIUowMhyDx8NVa7DIHcMfZY8Rpn
         mn3savc8gvk6B9LNF4OZITyBzMvSBfKhNB9T7DMCydACS6y8S8uACV9V45wxVMJWJwQn
         fhrnI3GPujYwkzi/wKwOSQxeV41Tyymcp4WPFXJ6su8CDNYJbv9MQVrLy1F9IoST3AiQ
         ghDV1srnbyj8TFmwjTpUGYde6DkCDzZ/B+L1KCV4v44KZKzteDRtqlhPzDoXLSsvhQX8
         euh70JhWOY50sQtPVjn9FTe904cKgVR2Lsr8BieRhq7SkI42t2J2oyh3z3lD+FMx3eW2
         d1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWfgmXsjL3sVrcHv8qmDH5J7zhQC7XgoME9IdNjoy4zy2S46J9mxNpCHoRu4yNxP9nDLFu0t0Y7FpKUdMlHsppmbSkuO0PdTbd9G8SG
X-Gm-Message-State: AOJu0YyBxlRncLGJWyUxk8oIMDZPc80AKKIvEHfaREAHsw0H0PicLbOr
	9RffC/MypvwyHspnHTyuCTfs6wv2FtE0ry/y3HFpz9qQNLsoctuQwjQWW+sJtS7XTjB9x6TF58F
	S1mPDXlPQIDz/hg==
X-Google-Smtp-Source: AGHT+IGKTzvYBVxuxp0VYfqRsp+nXS80+pOFrmh9vT+H19zk2AtK9i56hrMm1YftZM2YjXGr+riL5kwpUaFyUE8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:4402:b0:529:ab01:8069 with SMTP
 id 2adb3069b0e04-529ab0182dbmr5757e87.13.1716908296723; Tue, 28 May 2024
 07:58:16 -0700 (PDT)
Date: Tue, 28 May 2024 14:58:02 +0000
In-Reply-To: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15868; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xSbvVhrtFodD9MRESuXkcvT+XV4rvLfOM/6wExJZQsQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmVfEARqNIHiaKy6z316zm3PP79ctgWVQBabdCc
 l/fttkHreWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZlXxAAAKCRAEWL7uWMY5
 RkTNEACIqh4LUos+sWpcJRx24EvZkwksLjc1ka4p+vlWBcvxp7SVkMsWwF2VtnKK8/bBDVOpbZV
 2dsWXyio/j2tYPt6eDdqhMzhQnFfN3IKv+2r3OF1pbAWrgT80prHGMvDFpi+w4sNK6rHutxBKMq
 LM3W3yRYjI+4d7BkrgzmLszN3V44jFI9xj6VCviXzVHYoU/aO7tZGMqBizL+YiOetPxok1tKpGs
 6JYq1WesiFFSJFNFNoEupEolZBNDNSYJVnEZ06uL8uyonk6yMU1NGmK4pI5mLO0mXk4kGIpwumr
 ZY7TPrbJM62OPgOHU0d5iTBCXG9M999lWdE5nreINZERUZv2FyQJo/zVnGkEe7nxmcf8WA7HzSW
 zMnyDACW1QooRkj3ZYxqloCMRiSMPWJsIrKFtFRxNP7kOUHj2DAU7wNCzsQiPBgUJBBhDB71Mbf
 k+YA+tiZwxLxamSC5UDoHhrIiobMqran1KtIKfihbIvfd7TlUFDn1Q/RC1Y4f5Mzkf7qMQRSWLj
 JXkb5/xtjvtzTeeSMP33sjCziO+zKGmnuBXvheSBs4OIzL+JqexdWTTIiAFJ+FVLr2Fvc8wpJJT
 DGfmORaBLX4NReBCJ/Ox9J/uR9/SV0Fu0DBVMWso2YJejWLADed2IEHxpx1uQtNn6EofSOLuYIB CrkyYbre7wKtgmg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240528-alice-mm-v7-1-78222c31b8f4@google.com>
Subject: [PATCH v7 1/4] rust: uaccess: add userspace pointers
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Wedson Almeida Filho <wedsonaf@gmail.com>

A pointer to an area in userspace memory, which can be either read-only
or read-write.

All methods on this struct are safe: attempting to read or write on bad
addresses (either out of the bound of the slice or unmapped addresses)
will return `EFAULT`. Concurrent access, *including data races to/from
userspace memory*, is permitted, because fundamentally another userspace
thread/process could always be modifying memory at the same time (in the
same way that userspace Rust's `std::io` permits data races with the
contents of files on disk). In the presence of a race, the exact byte
values read/written are unspecified but the operation is well-defined.
Kernelspace code should validate its copy of data after completing a
read, and not expect that multiple reads of the same address will return
the same value.

These APIs are designed to make it difficult to accidentally write
TOCTOU bugs. Every time you read from a memory location, the pointer is
advanced by the length so that you cannot use that reader to read the
same memory location twice. Preventing double-fetches avoids TOCTOU
bugs. This is accomplished by taking `self` by value to prevent
obtaining multiple readers on a given `UserSlice`, and the readers only
permitting forward reads. If double-fetching a memory location is
necessary for some reason, then that is done by creating multiple
readers to the same memory location.

Constructing a `UserSlice` performs no checks on the provided address
and length, it can safely be constructed inside a kernel thread with no
current userspace process. Reads and writes wrap the kernel APIs
`copy_from_user` and `copy_to_user`, which check the memory map of the
current process and enforce that the address range is within the user
range (no additional calls to `access_ok` are needed).

This code is based on something that was originally written by Wedson on
the old rust branch. It was modified by Alice by removing the
`IoBufferReader` and `IoBufferWriter` traits, and various other changes.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers.c         |  14 +++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/uaccess.rs | 313 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 2c37a0f5d7a8..d6abe4bd45d9 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -39,6 +39,20 @@ __noreturn void rust_helper_BUG(void)
 }
 EXPORT_SYMBOL_GPL(rust_helper_BUG);
 
+unsigned long rust_helper_copy_from_user(void *to, const void __user *from,
+					 unsigned long n)
+{
+	return copy_from_user(to, from, n);
+}
+EXPORT_SYMBOL_GPL(rust_helper_copy_from_user);
+
+unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
+				       unsigned long n)
+{
+	return copy_to_user(to, from, n);
+}
+EXPORT_SYMBOL_GPL(rust_helper_copy_to_user);
+
 void rust_helper_mutex_lock(struct mutex *lock)
 {
 	mutex_lock(lock);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fbd91a48ff8b..767026db068e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,7 @@
 pub mod task;
 pub mod time;
 pub mod types;
+pub mod uaccess;
 pub mod workqueue;
 
 #[doc(hidden)]
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
new file mode 100644
index 000000000000..77957d7ec011
--- /dev/null
+++ b/rust/kernel/uaccess.rs
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Slices to user space memory regions.
+//!
+//! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.h)
+
+use crate::{alloc::Flags, bindings, error::Result, prelude::*};
+use alloc::vec::Vec;
+use core::ffi::{c_ulong, c_void};
+use core::mem::MaybeUninit;
+
+/// The type used for userspace addresses.
+pub type UserPtr = usize;
+
+/// A pointer to an area in userspace memory, which can be either read-only or read-write.
+///
+/// All methods on this struct are safe: attempting to read or write on bad addresses (either out of
+/// the bound of the slice or unmapped addresses) will return `EFAULT`. Concurrent access,
+/// *including data races to/from userspace memory*, is permitted, because fundamentally another
+/// userspace thread/process could always be modifying memory at the same time (in the same way that
+/// userspace Rust's [`std::io`] permits data races with the contents of files on disk). In the
+/// presence of a race, the exact byte values read/written are unspecified but the operation is
+/// well-defined. Kernelspace code should validate its copy of data after completing a read, and not
+/// expect that multiple reads of the same address will return the same value.
+///
+/// These APIs are designed to make it difficult to accidentally write TOCTOU (time-of-check to
+/// time-of-use) bugs. Every time a memory location is read, the reader's position is advanced by
+/// the read length and the next read will start from there. This helps prevent accidentally reading
+/// the same location twice and causing a TOCTOU bug.
+///
+/// Creating a [`UserSliceReader`] and/or [`UserSliceWriter`] consumes the `UserSlice`, helping
+/// ensure that there aren't multiple readers or writers to the same location.
+///
+/// If double-fetching a memory location is necessary for some reason, then that is done by creating
+/// multiple readers to the same memory location, e.g. using [`clone_reader`].
+///
+/// # Examples
+///
+/// Takes a region of userspace memory from the current process, and modify it by adding one to
+/// every byte in the region.
+///
+/// ```no_run
+/// use alloc::vec::Vec;
+/// use core::ffi::c_void;
+/// use kernel::error::Result;
+/// use kernel::uaccess::{UserPtr, UserSlice};
+///
+/// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result<()> {
+///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
+///
+///     let mut buf = Vec::new();
+///     read.read_all(&mut buf, GFP_KERNEL)?;
+///
+///     for b in &mut buf {
+///         *b = b.wrapping_add(1);
+///     }
+///
+///     write.write_slice(&buf)?;
+///     Ok(())
+/// }
+/// ```
+///
+/// Example illustrating a TOCTOU (time-of-check to time-of-use) bug.
+///
+/// ```no_run
+/// use alloc::vec::Vec;
+/// use core::ffi::c_void;
+/// use kernel::error::{code::EINVAL, Result};
+/// use kernel::uaccess::{UserPtr, UserSlice};
+///
+/// /// Returns whether the data in this region is valid.
+/// fn is_valid(uptr: UserPtr, len: usize) -> Result<bool> {
+///     let read = UserSlice::new(uptr, len).reader();
+///
+///     let mut buf = Vec::new();
+///     read.read_all(&mut buf, GFP_KERNEL)?;
+///
+///     todo!()
+/// }
+///
+/// /// Returns the bytes behind this user pointer if they are valid.
+/// fn get_bytes_if_valid(uptr: UserPtr, len: usize) -> Result<Vec<u8>> {
+///     if !is_valid(uptr, len)? {
+///         return Err(EINVAL);
+///     }
+///
+///     let read = UserSlice::new(uptr, len).reader();
+///
+///     let mut buf = Vec::new();
+///     read.read_all(&mut buf, GFP_KERNEL)?;
+///
+///     // THIS IS A BUG! The bytes could have changed since we checked them.
+///     //
+///     // To avoid this kind of bug, don't call `UserSlice::new` multiple
+///     // times with the same address.
+///     Ok(buf)
+/// }
+/// ```
+///
+/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
+/// [`clone_reader`]: UserSliceReader::clone_reader
+pub struct UserSlice {
+    ptr: UserPtr,
+    length: usize,
+}
+
+impl UserSlice {
+    /// Constructs a user slice from a raw pointer and a length in bytes.
+    ///
+    /// Constructing a [`UserSlice`] performs no checks on the provided address and length, it can
+    /// safely be constructed inside a kernel thread with no current userspace process. Reads and
+    /// writes wrap the kernel APIs `copy_from_user` and `copy_to_user`, which check the memory map
+    /// of the current process and enforce that the address range is within the user range (no
+    /// additional calls to `access_ok` are needed). Validity of the pointer is checked when you
+    /// attempt to read or write, not in the call to `UserSlice::new`.
+    ///
+    /// Callers must be careful to avoid time-of-check-time-of-use (TOCTOU) issues. The simplest way
+    /// is to create a single instance of [`UserSlice`] per user memory block as it reads each byte
+    /// at most once.
+    pub fn new(ptr: UserPtr, length: usize) -> Self {
+        UserSlice { ptr, length }
+    }
+
+    /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address.
+    pub fn read_all(self, buf: &mut Vec<u8>, flags: Flags) -> Result {
+        self.reader().read_all(buf, flags)
+    }
+
+    /// Constructs a [`UserSliceReader`].
+    pub fn reader(self) -> UserSliceReader {
+        UserSliceReader {
+            ptr: self.ptr,
+            length: self.length,
+        }
+    }
+
+    /// Constructs a [`UserSliceWriter`].
+    pub fn writer(self) -> UserSliceWriter {
+        UserSliceWriter {
+            ptr: self.ptr,
+            length: self.length,
+        }
+    }
+
+    /// Constructs both a [`UserSliceReader`] and a [`UserSliceWriter`].
+    ///
+    /// Usually when this is used, you will first read the data, and then overwrite it afterwards.
+    pub fn reader_writer(self) -> (UserSliceReader, UserSliceWriter) {
+        (
+            UserSliceReader {
+                ptr: self.ptr,
+                length: self.length,
+            },
+            UserSliceWriter {
+                ptr: self.ptr,
+                length: self.length,
+            },
+        )
+    }
+}
+
+/// A reader for [`UserSlice`].
+///
+/// Used to incrementally read from the user slice.
+pub struct UserSliceReader {
+    ptr: UserPtr,
+    length: usize,
+}
+
+impl UserSliceReader {
+    /// Skip the provided number of bytes.
+    ///
+    /// Returns an error if skipping more than the length of the buffer.
+    pub fn skip(&mut self, num_skip: usize) -> Result {
+        // Update `self.length` first since that's the fallible part of this operation.
+        self.length = self.length.checked_sub(num_skip).ok_or(EFAULT)?;
+        self.ptr = self.ptr.wrapping_add(num_skip);
+        Ok(())
+    }
+
+    /// Create a reader that can access the same range of data.
+    ///
+    /// Reading from the clone does not advance the current reader.
+    ///
+    /// The caller should take care to not introduce TOCTOU issues, as described in the
+    /// documentation for [`UserSlice`].
+    pub fn clone_reader(&self) -> UserSliceReader {
+        UserSliceReader {
+            ptr: self.ptr,
+            length: self.length,
+        }
+    }
+
+    /// Returns the number of bytes left to be read from this reader.
+    ///
+    /// Note that even reading less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.length
+    }
+
+    /// Returns `true` if no data is available in the io buffer.
+    pub fn is_empty(&self) -> bool {
+        self.length == 0
+    }
+
+    /// Reads raw data from the user slice into a kernel buffer.
+    ///
+    /// For a version that uses `&mut [u8]`, please see [`UserSliceReader::read_slice`].
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address, or if the read goes out of bounds
+    /// of this [`UserSliceReader`]. This call may modify `out` even if it returns an error.
+    ///
+    /// # Guarantees
+    ///
+    /// After a successful call to this method, all bytes in `out` are initialized.
+    pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
+        let len = out.len();
+        let out_ptr = out.as_mut_ptr().cast::<c_void>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: `out_ptr` points into a mutable slice of length `len_ulong`, so we may write
+        // that many bytes to it.
+        let res =
+            unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const c_void, len_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        self.ptr = self.ptr.wrapping_add(len);
+        self.length -= len;
+        Ok(())
+    }
+
+    /// Reads raw data from the user slice into a kernel buffer.
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address, or if the read goes out of bounds
+    /// of this [`UserSliceReader`]. This call may modify `out` even if it returns an error.
+    pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
+        // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
+        // `out`.
+        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
+        self.read_raw(out)
+    }
+
+    /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address.
+    pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Result {
+        let len = self.length;
+        VecExt::<u8>::reserve(buf, len, flags)?;
+
+        // The call to `try_reserve` was successful, so the spare capacity is at least `len` bytes
+        // long.
+        self.read_raw(&mut buf.spare_capacity_mut()[..len])?;
+
+        // SAFETY: Since the call to `read_raw` was successful, so the next `len` bytes of the
+        // vector have been initialized.
+        unsafe { buf.set_len(buf.len() + len) };
+        Ok(())
+    }
+}
+
+/// A writer for [`UserSlice`].
+///
+/// Used to incrementally write into the user slice.
+pub struct UserSliceWriter {
+    ptr: UserPtr,
+    length: usize,
+}
+
+impl UserSliceWriter {
+    /// Returns the amount of space remaining in this buffer.
+    ///
+    /// Note that even writing less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.length
+    }
+
+    /// Returns `true` if no more data can be written to this buffer.
+    pub fn is_empty(&self) -> bool {
+        self.length == 0
+    }
+
+    /// Writes raw data to this user pointer from a kernel buffer.
+    ///
+    /// Fails with `EFAULT` if the write happens on a bad address, or if the write goes out of bounds
+    /// of this [`UserSliceWriter`]. This call may modify the associated userspace slice even if it
+    /// returns an error.
+    pub fn write_slice(&mut self, data: &[u8]) -> Result {
+        let len = data.len();
+        let data_ptr = data.as_ptr().cast::<c_void>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: `data_ptr` points into an immutable slice of length `len_ulong`, so we may read
+        // that many bytes from it.
+        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        self.ptr = self.ptr.wrapping_add(len);
+        self.length -= len;
+        Ok(())
+    }
+}

-- 
2.45.1.288.g0e0cd299f1-goog


