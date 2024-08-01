Return-Path: <linux-kernel+bounces-270025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E12CC943A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B3DB2402E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837813D8BA;
	Thu,  1 Aug 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js2NMZY6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDB13D897;
	Thu,  1 Aug 2024 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470911; cv=none; b=lukpvBdFMvN4THXB3H4GfpEEusLrhAxmhm2+84VKSrGOx82n4tNn2DEzzVAuZMgi4TI9QK0B/AhERo1G5WwMcpaov1Xc1CBPApN2R0Lcn7XUyKEYXaNd3pvbajlDJznJm2A3dwPtBsE93x3OSazghZX4qc5ZsZlt22PkiBrOsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470911; c=relaxed/simple;
	bh=OUyFX4Ajg0yzg7q3aN3a+WdxriUzErZ+JXbxE/+fux8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxatyrguLtvEFv2w2NYMFqWmHzgqdiJMIp/LDtOxY6wZIKINAL2OGR2qF0pt+vnKVZQ0mJnSMnw+Nr29JQSlNg20vC5ou5afQReKkURXT2vB9Rk73F3kjTWOtdAD2WvAefsatGn6gLLWX4leRYDkMCS90Qq5XQsXIxr9R8QccUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js2NMZY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463FAC4AF0F;
	Thu,  1 Aug 2024 00:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470911;
	bh=OUyFX4Ajg0yzg7q3aN3a+WdxriUzErZ+JXbxE/+fux8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Js2NMZY6KzQF8+HOV/w9yQBdGTLitDFYjSDJAYJkoz0gvQOXybeowYVyKR1HmX4rC
	 BKfFSWgc0PTmCt/CV4FK3bEntTZ43LLG0ANOF7SchZlYZZKOptkJfSAiDe72B0YXsV
	 8mMM+N3dPxgTdBtUo/UQjSD2CNgJMzvry0fU5GkfQQMFQxw7dSJiGVSd89Loae0/dP
	 LMhti3ixkeUFln9mVriL9OQCtzb+g/0UtXUrob8xfQnApB7ISDqlh147HA//cYwreG
	 BCirXNxiRHFFRXbIZoehuAKavolfU1YGsdHljBv7yH8PJfdxkjSGXJm7yXaBEAmwtS
	 1t7Q5rYR2JsCg==
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
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 18/25] rust: treewide: switch to the kernel `Vec` type
Date: Thu,  1 Aug 2024 02:02:17 +0200
Message-ID: <20240801000641.1882-19-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801000641.1882-1-dakr@kernel.org>
References: <20240801000641.1882-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we got the kernel `Vec` in place, convert all existing `Vec`
users to make use of it.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/str.rs            | 12 +++++-------
 rust/kernel/sync/locked_by.rs |  2 +-
 rust/kernel/types.rs          |  2 +-
 rust/kernel/uaccess.rs        | 15 ++++++---------
 samples/rust/rust_minimal.rs  |  4 ++--
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index bb8d4f41475b..0b6ffbade521 100644
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
+        KVec::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)?;
 
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
index 809653b9d945..1d90d2c68f74 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -158,7 +158,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 /// # use kernel::types::ScopeGuard;
 /// fn example3(arg: bool) -> Result {
 ///     let mut vec =
-///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
+///         ScopeGuard::new_with_data(KVec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
 ///
 ///     vec.push(10u8, GFP_KERNEL)?;
 ///     if arg {
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index e9347cff99ab..d19002308636 100644
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
@@ -78,14 +75,14 @@
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
+        KVec::<u8>::reserve(buf, len, flags)?;
 
         // The call to `try_reserve` was successful, so the spare capacity is at least `len` bytes
         // long.
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
2.45.2


