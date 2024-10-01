Return-Path: <linux-kernel+bounces-346196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB53F98C110
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D9EB25C0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729BD1CDA3F;
	Tue,  1 Oct 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5ac0Azm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45111CDA27;
	Tue,  1 Oct 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794919; cv=none; b=K9N6imEz5OzwpBIgZViyzWCq6r7ao5KLaEqUXoB/GGmgiqqWJ/iXaA89LHdZIrVh+ys1WetYoxfE6IMY6OHSOZWFvJ845ZXQPnX4FNJqtphPfks2ZNkteExg1g279tOQ+JU3VYG9VfAt2m3yVOvxLTmk/id/qCjXQp577vZWy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794919; c=relaxed/simple;
	bh=L+/LMFOMtE864WvCn41tWWSUMQocDvmfmSNi2WDyR5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnVxEjx8ZdQUVgYIpP23IEE78W+pEHf2y23x8thC9oHZ+H2uyVG3E2b5N4NxwrZXbL5j9v/2aG9hrWPzG77lCysKB+TCM8iclvv2+5ECbICjJIYBmZ42dX3zP/nlA/GkdB6dUa/spxpKF+J0LAeRf28diRJ/vESv0krH3fAlQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5ac0Azm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C29C4CECF;
	Tue,  1 Oct 2024 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794919;
	bh=L+/LMFOMtE864WvCn41tWWSUMQocDvmfmSNi2WDyR5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5ac0AzmGV2ElLdhlD4+yTKtDEpfPVAhJdXEM9yuVluSA7ZN4jRVDGY1YCM/imngE
	 laj9dhlSw8k73BtPsXFQEf8MINHpP7+qSMO67XNPHZEv+ugT7IDpeZ0kRb0/DZa1NM
	 j9evXryTLEGDekebVTAcTHDEdfpduYwURpHjQKQCrHT47q/QX0C8B0OfCgi8JtDWbl
	 KrIzUEkBHU7KAg32b1JWyrf6EY6Yw17urRFjHRXgvIWDEWRzdGQ4kqxR9k9TMDDLyt
	 i9kUccDMuGH8Crmzs+G7AVlSu6MlWJ8FZJgFixA6w0wVCD+fFtMk7y0IQxgnqnFQBB
	 mh1RonLnRjoRQ==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v8 19/29] rust: treewide: switch to the kernel `Vec` type
Date: Tue,  1 Oct 2024 16:59:54 +0200
Message-ID: <20241001150008.183102-20-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we got the kernel `Vec` in place, convert all existing `Vec`
users to make use of it.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/str.rs            | 12 +++++-------
 rust/kernel/sync/locked_by.rs |  2 +-
 rust/kernel/types.rs          |  2 +-
 rust/kernel/uaccess.rs        | 17 +++++++----------
 rust/macros/lib.rs            |  6 +++---
 samples/rust/rust_minimal.rs  |  4 ++--
 6 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index bb8d4f41475b..209ad1bb1a49 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,8 +2,7 @@
 
 //! String representations.
 
-use crate::alloc::{flags::*, vec_ext::VecExt, AllocError};
-use alloc::vec::Vec;
+use crate::alloc::{flags::*, AllocError, KVec};
 use core::fmt::{self, Write};
 use core::ops::{self, Deref, DerefMut, Index};
 
@@ -790,7 +789,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// assert_eq!(s.is_ok(), false);
 /// ```
 pub struct CString {
-    buf: Vec<u8>,
+    buf: KVec<u8>,
 }
 
 impl CString {
@@ -803,7 +802,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         let size = f.bytes_written();
 
         // Allocate a vector with the required number of bytes, and write to it.
-        let mut buf = <Vec<_> as VecExt<_>>::with_capacity(size, GFP_KERNEL)?;
+        let mut buf = KVec::with_capacity(size, GFP_KERNEL)?;
         // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
         let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
         f.write_fmt(args)?;
@@ -850,10 +849,9 @@ impl<'a> TryFrom<&'a CStr> for CString {
     type Error = AllocError;
 
     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
-        let mut buf = Vec::new();
+        let mut buf = KVec::new();
 
-        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
-            .map_err(|_| AllocError)?;
+        buf.extend_from_slice(cstr.as_bytes_with_nul(), GFP_KERNEL)?;
 
         // INVARIANT: The `CStr` and `CString` types have the same invariants for
         // the string data, and we copied it over without changes.
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index babc731bd5f6..b94517231fcc 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -43,7 +43,7 @@
 /// struct InnerDirectory {
 ///     /// The sum of the bytes used by all files.
 ///     bytes_used: u64,
-///     _files: Vec<File>,
+///     _files: KVec<File>,
 /// }
 ///
 /// struct Directory {
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 53d3ddc0b98c..bf1a96d5e1f8 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -135,7 +135,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 /// # use kernel::types::ScopeGuard;
 /// fn example3(arg: bool) -> Result {
 ///     let mut vec =
-///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
+///         ScopeGuard::new_with_data(KVec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
 ///
 ///     vec.push(10u8, GFP_KERNEL)?;
 ///     if arg {
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index e9347cff99ab..bc011061de45 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -11,7 +11,6 @@
     prelude::*,
     types::{AsBytes, FromBytes},
 };
-use alloc::vec::Vec;
 use core::ffi::{c_ulong, c_void};
 use core::mem::{size_of, MaybeUninit};
 
@@ -46,7 +45,6 @@
 /// every byte in the region.
 ///
 /// ```no_run
-/// use alloc::vec::Vec;
 /// use core::ffi::c_void;
 /// use kernel::error::Result;
 /// use kernel::uaccess::{UserPtr, UserSlice};
@@ -54,7 +52,7 @@
 /// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result<()> {
 ///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
 ///
-///     let mut buf = Vec::new();
+///     let mut buf = KVec::new();
 ///     read.read_all(&mut buf, GFP_KERNEL)?;
 ///
 ///     for b in &mut buf {
@@ -69,7 +67,6 @@
 /// Example illustrating a TOCTOU (time-of-check to time-of-use) bug.
 ///
 /// ```no_run
-/// use alloc::vec::Vec;
 /// use core::ffi::c_void;
 /// use kernel::error::{code::EINVAL, Result};
 /// use kernel::uaccess::{UserPtr, UserSlice};
@@ -78,21 +75,21 @@
 /// fn is_valid(uptr: UserPtr, len: usize) -> Result<bool> {
 ///     let read = UserSlice::new(uptr, len).reader();
 ///
-///     let mut buf = Vec::new();
+///     let mut buf = KVec::new();
 ///     read.read_all(&mut buf, GFP_KERNEL)?;
 ///
 ///     todo!()
 /// }
 ///
 /// /// Returns the bytes behind this user pointer if they are valid.
-/// fn get_bytes_if_valid(uptr: UserPtr, len: usize) -> Result<Vec<u8>> {
+/// fn get_bytes_if_valid(uptr: UserPtr, len: usize) -> Result<KVec<u8>> {
 ///     if !is_valid(uptr, len)? {
 ///         return Err(EINVAL);
 ///     }
 ///
 ///     let read = UserSlice::new(uptr, len).reader();
 ///
-///     let mut buf = Vec::new();
+///     let mut buf = KVec::new();
 ///     read.read_all(&mut buf, GFP_KERNEL)?;
 ///
 ///     // THIS IS A BUG! The bytes could have changed since we checked them.
@@ -130,7 +127,7 @@ pub fn new(ptr: UserPtr, length: usize) -> Self {
     /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address.
-    pub fn read_all(self, buf: &mut Vec<u8>, flags: Flags) -> Result {
+    pub fn read_all(self, buf: &mut KVec<u8>, flags: Flags) -> Result {
         self.reader().read_all(buf, flags)
     }
 
@@ -291,9 +288,9 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
     /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
     ///
     /// Fails with [`EFAULT`] if the read happens on a bad address.
-    pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Result {
+    pub fn read_all(mut self, buf: &mut KVec<u8>, flags: Flags) -> Result {
         let len = self.length;
-        VecExt::<u8>::reserve(buf, len, flags)?;
+        buf.reserve(len, flags)?;
 
         // The call to `try_reserve` was successful, so the spare capacity is at least `len` bytes
         // long.
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index ab93111a048c..8d4ac914b48b 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -242,7 +242,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// #[pin_data]
 /// struct DriverData {
 ///     #[pin]
-///     queue: Mutex<Vec<Command>>,
+///     queue: Mutex<KVec<Command>>,
 ///     buf: KBox<[u8; 1024 * 1024]>,
 /// }
 /// ```
@@ -251,7 +251,7 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// #[pin_data(PinnedDrop)]
 /// struct DriverData {
 ///     #[pin]
-///     queue: Mutex<Vec<Command>>,
+///     queue: Mutex<KVec<Command>>,
 ///     buf: KBox<[u8; 1024 * 1024]>,
 ///     raw_info: *mut Info,
 /// }
@@ -281,7 +281,7 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
 /// #[pin_data(PinnedDrop)]
 /// struct DriverData {
 ///     #[pin]
-///     queue: Mutex<Vec<Command>>,
+///     queue: Mutex<KVec<Command>>,
 ///     buf: KBox<[u8; 1024 * 1024]>,
 ///     raw_info: *mut Info,
 /// }
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 2a9eaab62d1c..4aaf117bf8e3 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -13,7 +13,7 @@
 }
 
 struct RustMinimal {
-    numbers: Vec<i32>,
+    numbers: KVec<i32>,
 }
 
 impl kernel::Module for RustMinimal {
@@ -21,7 +21,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Rust minimal sample (init)\n");
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
 
-        let mut numbers = Vec::new();
+        let mut numbers = KVec::new();
         numbers.push(72, GFP_KERNEL)?;
         numbers.push(108, GFP_KERNEL)?;
         numbers.push(200, GFP_KERNEL)?;
-- 
2.46.1


