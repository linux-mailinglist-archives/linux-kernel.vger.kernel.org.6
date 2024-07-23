Return-Path: <linux-kernel+bounces-260293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B293A567
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9B6B22540
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACED15958A;
	Tue, 23 Jul 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrqjLlOl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED41586F6;
	Tue, 23 Jul 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758367; cv=none; b=KTro6QS7SJzuxaO9lbRl0Y3TzUlKQAcSgKy9NiZNR4tC6GZ5sdnonNiQMEvF2Ldb6L0WxQPZEMTp4hJrZxpHgE+4NMxoxRUcT7ivbO2sC6MP8XZUruJxx6BxpHUUbCA4bximdAzMeieRMR5+P/9PsYZ9tpLmcIW9vnPYmJYfcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758367; c=relaxed/simple;
	bh=hs6yx2vsssnsC1cMGPjQ8GCbMEe+TcUfgVzllRdmHcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jptD7DaayNgMmjbWnRqQ9vJaTkn1nQkw7HR2PbXH7fJThDHseaiL8F61rRRKN2Gp0Won+OTnYNs3wbXPPIXFQXt1qE3edBk1+PIn0L0CT5TWx+2PzCu+7vAmYQpG64XoehAmy7NxLlt3x+Yqe6tlvLT67s+2Zqy2cWi8a+7iRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrqjLlOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C23C4AF0F;
	Tue, 23 Jul 2024 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758366;
	bh=hs6yx2vsssnsC1cMGPjQ8GCbMEe+TcUfgVzllRdmHcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrqjLlOlUH7v2hvkeiyaOJgc8Oh7GHD2if+LolauVZpdSjXJUzYAuQSO2G/BzwM5a
	 AiiIxDaMskwTxGJy7m1wRE3mRn+MgcsrMoFfCM2jX0p1VeXsMAdcuVKwrBcxbtAVap
	 N8yVJHcsAAoTB1CKwwVVjKF9duYwYdIOfsGllMFjDQI0TlX/+Nvm54Os3pUOrmTdvp
	 8QwWTfKrIcqQDSHMODvSnN7m7+O4chstkokwWJnPrzXHLHbSa4PcpOpxKw9Spm5ecv
	 SK/gnFUPteAQ6WvAFwlrrE4SkuWjarVlw4ifOSDMcOzGALc0arYSU0kyzasYjAL0MR
	 aSvxiwry37BOQ==
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
Subject: [PATCH v2 20/23] rust: alloc: remove `GlobalAlloc` and `krealloc_aligned`
Date: Tue, 23 Jul 2024 20:10:09 +0200
Message-ID: <20240723181024.21168-21-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723181024.21168-1-dakr@kernel.org>
References: <20240723181024.21168-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have all the `Allocator`s and the kernel `Box` and `Vec`
implementations in place, remove `GlobalAlloc` and `krealloc_aligned`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 63 ++--------------------------------
 1 file changed, 2 insertions(+), 61 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 1e53f149db96..fbee89ac3be4 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -2,8 +2,8 @@
 
 //! Allocator support.
 
-use super::{flags::*, Flags};
-use core::alloc::{GlobalAlloc, Layout};
+use super::Flags;
+use core::alloc::Layout;
 use core::ptr;
 use core::ptr::NonNull;
 
@@ -39,27 +39,6 @@ fn aligned_size(new_layout: Layout) -> usize {
     layout.size()
 }
 
-/// Calls `krealloc` with a proper size to alloc a new object.
-///
-/// # Safety
-///
-/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
-/// - `new_layout` must have a non-zero size.
-pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
-    // SAFETY:
-    // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
-    //   function safety requirement.
-    // - `size` is greater than 0 since it's from `layout.size()` (which cannot be zero according
-    //   to the function safety requirement)
-    unsafe {
-        bindings::krealloc(
-            ptr as *const core::ffi::c_void,
-            aligned_size(new_layout),
-            flags.0,
-        ) as *mut u8
-    }
-}
-
 struct ReallocFunc(
     // INVARIANT: One of the following `krealloc`, `vrealloc`, `kvrealloc`.
     unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
@@ -121,41 +100,6 @@ unsafe fn realloc(
     }
 }
 
-unsafe impl GlobalAlloc for Kmalloc {
-    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
-        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-        // requirement.
-        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL) }
-    }
-
-    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
-        unsafe {
-            bindings::kfree(ptr as *const core::ffi::c_void);
-        }
-    }
-
-    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
-        // SAFETY:
-        // - `new_size`, when rounded up to the nearest multiple of `layout.align()`, will not
-        //   overflow `isize` by the function safety requirement.
-        // - `layout.align()` is a proper alignment (i.e. not zero and must be a power of two).
-        let layout = unsafe { Layout::from_size_align_unchecked(new_size, layout.align()) };
-
-        // SAFETY:
-        // - `ptr` is either null or a pointer allocated by this allocator by the function safety
-        //   requirement.
-        // - the size of `layout` is not zero because `new_size` is not zero by the function safety
-        //   requirement.
-        unsafe { krealloc_aligned(ptr, layout, GFP_KERNEL) }
-    }
-
-    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
-        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-        // requirement.
-        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL | __GFP_ZERO) }
-    }
-}
-
 unsafe impl Allocator for Vmalloc {
     unsafe fn realloc(
         ptr: Option<NonNull<u8>>,
@@ -184,9 +128,6 @@ unsafe fn realloc(
     }
 }
 
-#[global_allocator]
-static ALLOCATOR: Kmalloc = Kmalloc;
-
 // See <https://github.com/rust-lang/rust/pull/86844>.
 #[no_mangle]
 static __rust_no_alloc_shim_is_unstable: u8 = 0;
-- 
2.45.2


