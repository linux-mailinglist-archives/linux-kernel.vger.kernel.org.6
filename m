Return-Path: <linux-kernel+bounces-270006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6EF9439E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2101C21223
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B221E4A9;
	Thu,  1 Aug 2024 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZyPia1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D321757D;
	Thu,  1 Aug 2024 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470818; cv=none; b=lgMJDyYS0myXdZWcmjkOkFTrRb40ydKGFzfPVoBcFqqCyx3kQJsvE8PHHChVc7Lr/8EY19h+16eViwCSGwx7ghpJbniOxFbrNF2Ajk+p5376hjsa4MRuoO9C1Ylbnb23FsqYZcX6PYB4RCBdIKzkUeNi8PYMv02AHPP1BfmVdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470818; c=relaxed/simple;
	bh=kRuEhdnhz6Oh4MuGdrkk5vMdvHwyKzjCm+Q5vf6XVyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ9yp5WHMLp+3yV/KCUsx3NRuV1U1uetoiDQNBGDjBEASanGPG+pYb+jI3KFbegrrnQik+BkQpjEqXA03FNsHV2lVfuM5nZpCdwGzj/dYRcYuFIzyBwikg07XnBdkdcytPN/QXp7pKrdD7Eu/QfQl0zbVcJJ8ZitmbJ2IxbbJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZyPia1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C43C4AF0E;
	Thu,  1 Aug 2024 00:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470817;
	bh=kRuEhdnhz6Oh4MuGdrkk5vMdvHwyKzjCm+Q5vf6XVyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZyPia1n+C0W5qz4kOxNx9KtE86e+aYpLFiHeEsfmLE8REX244dH5Fld8vnG8OWiZ
	 I94s406MrWq+XMAJ5CvqLyEZ6/oG7aG3/Yn5PO0+VRj+dr1OS12yfrs/2t+4d7ZLss
	 z3HvFFA1Luj4pnTMr/Zt3ZNMxItVXCH0i8tO24PlKAabfOrX3RqrGhxClSvFmhr6bI
	 W7i63bjwg+UbUJyliCuE1n6qme78rFHJCXcUdP/nQTwb90pZc307evxXka/xaZAL2S
	 sHNQvp2tGtawND8QO0AXNQvYv7RzXPrtlQLkRF0+ESzwD0h3Saa+NkJnaazUfsg2My
	 gjjaI1s6MpLuw==
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
Subject: [PATCH v3 01/25] rust: alloc: add `Allocator` trait
Date: Thu,  1 Aug 2024 02:02:00 +0200
Message-ID: <20240801000641.1882-2-dakr@kernel.org>
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

Add a kernel specific `Allocator` trait, that in contrast to the one in
Rust's core library doesn't require unstable features and supports GFP
flags.

Subsequent patches add the following trait implementors: `Kmalloc`,
`Vmalloc` and `KVmalloc`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 1966bd407017..b79dd2c49277 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -11,6 +11,7 @@
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+use core::{alloc::Layout, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
 ///
@@ -86,3 +87,75 @@ pub mod flags {
     /// small allocations.
     pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
 }
+
+/// The kernel's [`Allocator`] trait.
+///
+/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffer described
+/// via [`Layout`].
+///
+/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
+/// an object instance.
+///
+/// # Safety
+///
+/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
+/// it is explicitly freed.
+///
+/// Any pointer to a memory buffer which is currently allocated must be valid to be passed to any
+/// other [`Allocator`] function. The same applies for a NULL pointer.
+///
+/// If `realloc` is called with:
+///   - a size of zero, the given memory allocation, if any, must be freed
+///   - a NULL pointer, a new memory allocation must be created
+pub unsafe trait Allocator {
+    /// Allocate memory based on `layout` and `flags`.
+    ///
+    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
+    /// constraints (i.e. minimum size and alignment as specified by `layout`).
+    ///
+    /// This function is equivalent to `realloc` when called with a NULL pointer.
+    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's safety requirements and asks
+        // for a new memory allocation.
+        unsafe { Self::realloc(None, layout, flags) }
+    }
+
+    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
+    /// requested size is zero, `realloc` behaves equivalent to `free`.
+    ///
+    /// If the requested size is larger than the size of the existing allocation, a successful call
+    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
+    /// may also be larger.
+    ///
+    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
+    /// may not shrink the buffer; this is implementation specific to the allocator.
+    ///
+    /// On allocation failure, the existing buffer, if any, remains valid.
+    ///
+    /// The buffer is represented as `NonNull<[u8]>`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an existing and valid memory allocation created by this allocator
+    /// instance.
+    ///
+    /// Additionally, `ptr` is allowed to be a NULL pointer; in this case a new memory allocation is
+    /// created.
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError>;
+
+    /// Free an existing memory allocation.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
+    /// instance.
+    unsafe fn free(ptr: NonNull<u8>) {
+        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
+        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
+        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
+    }
+}
-- 
2.45.2


