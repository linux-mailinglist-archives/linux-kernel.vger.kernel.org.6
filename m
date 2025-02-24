Return-Path: <linux-kernel+bounces-529160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B2A4207D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C028164B23
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CA24FC1F;
	Mon, 24 Feb 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5sp4qJf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B124EF94;
	Mon, 24 Feb 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403398; cv=none; b=nriMImy/Mi+gZRyKdgl90Q/0TRNNF/2ByxK1IbyzU/DP4D9m8o/fF6HvAfeDq7cbyFm8nI+2SsUN2P5QzxLuYy40JoEIICJqv2NqPk5DDsDGqRSk0Pgc/VzIdsJrjPcu2Niw04enePI/2HZtX60aC+43UMwVtVBhDB/F/uU9eRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403398; c=relaxed/simple;
	bh=7Ehh98LprBCLuWdknMTk4GDYnRj/3Jr2m6jJjFH1+gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDJXXMrH28R4QCT5u8YGnw4/Lq4X/bsnP4yhJGyV6DEvKZyy3SBS95vEV8ikVDbbUxXaTqw5sNPHw3kpsMUEhJikACjEvNa3RECbup2lDI8x3lRQBuqYVQROZ+eTYtwBZrUJWk4znx9rfiZZilz0B9TT37sI8r1iujpkAMDXwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5sp4qJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60C0C4CED6;
	Mon, 24 Feb 2025 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740403398;
	bh=7Ehh98LprBCLuWdknMTk4GDYnRj/3Jr2m6jJjFH1+gM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R5sp4qJfU2WDDVT3hjef27r5i9XWpMgtpyW22ecnKVV7+mr85VKSiR2vltWvelT2K
	 LG2ph0DWicftgtLBJgz/7anQ5NOiEPNcGNF6+v50hOKfEbZ7gTSV8opn7iH3fViu/b
	 ImIAas6qByqcryD7IWAevsoc5y2gomO+t8gKGkeP+kLbXjevpYUbO7lfA+mBJN+iUT
	 /AvGi+iQkHDyfWS2cZoDTCjRUX+gTtMcFtQ7L3zOLFFH7SWW3C5TFP7IQgVaiKvXmJ
	 bH+ObJ7Unl/jIf2vcWHyrjKbztERxkAK4xDr+w/gpIw9fykU4A4gTR5Vm7uJPXRIR9
	 j4QcJXKrhODyA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 14:21:51 +0100
Subject: [PATCH v4 1/4] rust: sync: change `<Arc<T> as
 ForeignOwnable>::PointedTo` to `T`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-configfs-v4-1-9af9b5e611f6@kernel.org>
References: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
In-Reply-To: <20250224-configfs-v4-0-9af9b5e611f6@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
 Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3515; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=7Ehh98LprBCLuWdknMTk4GDYnRj/3Jr2m6jJjFH1+gM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvHJ2CjhHIGKetvCP9S3T4LQVAEuKyRgZGwIaH
 wVxNOc2Z3yJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xydgAKCRDhuBo+eShj
 d1kFD/9/aIdTOr6iIkx30MBvgEzNSctbzoEE5WfoDZecUsm/V5aGfE4GiaXe8fVlNFr70+5gZZu
 PIJZQItgBOaA6ZXmCi4jB53HMBaOIbnAht/u7aZqJMNfpsynIkQHvMqIHXppoZuKrAcdCjTaIuz
 GR7DgDrBtbSZ3DASVqnkHEh58TkDALxpExEsAl2X69pfDDORlwApC1xzV4O07mTKZIRCKDvcwF8
 cYpsKr0tYeZD47vsc5+X0rEMHvG5GK6ilx46LSxWE+ZlZ3UIVaFZnpOLTOPK+tqufS/qx4rHbAQ
 gbo18OGQwliMSTHEC8MD8iyNtKpLdmDHjlIgKzf4hlH/OvdiUUkUwpTb6ScUKjvy4v4oCxi4rtH
 kdZI6r4BFZeEHpj+ppvTE4RmBMyq0lB3qSestPiE1kYrdyoHBfOdB/l+FZG/l5iJTvD16oi3RQk
 3+m8OG1rv55shjdN09BFg32aSustBtrryHpopKWfPFyAZWpEv6bdxSNoOF42jY66+3u9ti6QHnr
 qGKiSFi1Wzn7lXP16z1B2rlELYiUZAeNx+vGOdTpJ/4tGvV9VCV/fO2NnQ4aO9ZmjU+4Mjpgxhf
 fomE1CLLhPBeWlMp0s4ZNDv309fXHWML6ZaLeCBt99DkvDAMs5iZ4lO4VTGEEKWlUwuZjZwJkVm
 61slYkaTzEPbZjQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Using `ArcInner` as `PoinedTo` in the `ForeignOwnable` implementation for
`Arc` is a bit unfortunate. Using `T` as `PointedTo` does not remove any
functionality, but allows `ArcInner` to be private. Further, it allows
downstream users to write code that is generic over `Box` and `Arc`, when
downstream users need access to `T` after calling `into_foreign`.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---

This patch is a dependency for Rust `configfs` abstractions. It allows both
`Box` and `Arc` to be used as pointer types in the `configfs` hierarchy.
---
 rust/kernel/sync/arc.rs | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index dfe4abf82c25..3d77a31e116f 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -143,7 +143,7 @@ pub struct Arc<T: ?Sized> {
 #[doc(hidden)]
 #[pin_data]
 #[repr(C)]
-pub struct ArcInner<T: ?Sized> {
+struct ArcInner<T: ?Sized> {
     refcount: Opaque<bindings::refcount_t>,
     data: T,
 }
@@ -345,18 +345,25 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 
 // SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
 unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
-    type PointedTo = ArcInner<T>;
+    type PointedTo = T;
     type Borrowed<'a> = ArcBorrow<'a, T>;
     type BorrowedMut<'a> = Self::Borrowed<'a>;
 
     fn into_foreign(self) -> *mut Self::PointedTo {
-        ManuallyDrop::new(self).ptr.as_ptr()
+        let this = ManuallyDrop::new(self).ptr.as_ptr();
+        // SAFETY: `x` is a valid pointer to `Self` so the projection below is
+        // in bounds of the allocation.
+        unsafe { core::ptr::addr_of_mut!((*this).data) }
     }
 
     unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
+        // SAFETY: We did the reverse offset calculation in `into_foreign`, so
+        // the offset calculation below is in bounds of the allocation.
+        let inner_ptr = unsafe { kernel::container_of!(ptr, ArcInner<T>, data).cast_mut() };
+
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr) };
+        let inner = unsafe { NonNull::new_unchecked(inner_ptr) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
@@ -365,9 +372,13 @@ unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
     }
 
     unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
+        // SAFETY: We did the reverse offset calculation in `into_foreign`, so
+        // the offset calculation below is in bounds of the allocation.
+        let inner_ptr = unsafe { kernel::container_of!(ptr, ArcInner<T>, data).cast_mut() };
+
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr) };
+        let inner = unsafe { NonNull::new_unchecked(inner_ptr) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.

-- 
2.47.0



