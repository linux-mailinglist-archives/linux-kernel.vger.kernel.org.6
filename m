Return-Path: <linux-kernel+bounces-536296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7CBA47DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5F63A63EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9097022F38E;
	Thu, 27 Feb 2025 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4bPdPBq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16622D4EB;
	Thu, 27 Feb 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659799; cv=none; b=DRQdf9Te0DPcJ59TChSFY+VtUzDpnSzuzeN5Ohob1dCfEWZBd34lHhb1r0gUwpECHoSKvFSuAuc993gEUaLllIo6dNzQkJdjPVudbofcSu94Wai5gjSbGoEI5OpnJWjuM6dQwPpxkCPaM4dMCSBtVloZ8x8Ud6BeY5VEjN2AvsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659799; c=relaxed/simple;
	bh=iH024xRD6cyG1uXtxu6ZtfNK2dVVhqaMlYLdesMgGzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKHr/71dfZEm1/00afiZpaauglWFCM3brDGi7lcQcf+4xm5vsIR4Z+WRs+NnC4CXykRuTgI4TAkNev4y64i+8DGsTDXGvEJxGHA6V8tvBT7+wH3+5S1ynYL+4s49p44EgdsBfvF333zIamL5ofaViZB8dBwfvAyxEBjPKYbotiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4bPdPBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7EAC4CEE7;
	Thu, 27 Feb 2025 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740659798;
	bh=iH024xRD6cyG1uXtxu6ZtfNK2dVVhqaMlYLdesMgGzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D4bPdPBqUn5LzwalPZyesL3WxozFSx+lVm60/h5twQ9xSKynYeJm2FdJtGtxpAE31
	 LQvmq2Sryqt5NNtK6pQx6Li0UTxSl5PB1JdOzCMb+ntGrQrntpi3Mo78dLz2brYA6O
	 ZnnDvG6RsPJWzLI2a7SAlG382hA357b2dq0i5X1VRBlTo5Yg7civaLgJwk4FG86Nn1
	 qm1ERKfA1k4jJ7C00uDIp2ZaBcLP07H63ls0cOyJ+iua/q0wLgvd9cBxq/4GHlaPkP
	 FJ9Bs99jJlUtBGBBpZSg7NRoNxA2f0CST2FjJGbP75f2m3YMyqx+KCQ5vqQyOyFb+A
	 MFvLXHD8gbe0g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 27 Feb 2025 13:35:10 +0100
Subject: [PATCH v5 1/4] rust: sync: change `<Arc<T> as
 ForeignOwnable>::PointedTo` to `T`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-configfs-v5-1-c40e8dc3b9cd@kernel.org>
References: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
In-Reply-To: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3633; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=iH024xRD6cyG1uXtxu6ZtfNK2dVVhqaMlYLdesMgGzs=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnwFwCLx7ibrR86EZs9lxtw3xWU7qjzlrraFiUg
 aqWtCvx2j+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8BcAgAKCRDhuBo+eShj
 d7zCD/4kXPykk11x9sM9lc2DgfeaLln/UR8q1SJcAmmtkL/DKMGOmk/3Xu655gnCckR7WujxadZ
 gkJ18bqmT4iM1OLMxu6YgiANSD1mwE8IeK7m/VHvEJIDTfckWZNT2h6iGOxUnwWSzWPZ+SrbyKH
 W2VUPvuJL2SGBfO13ZoBAcwNgLTlINOBWmIdgv5NuYtqhraWKol4ieNUdR4G3nxHV+MUsE1ALnn
 aMc+LTKOCp/AyNhMGUim1WCCn9FlYDGo4t0DAy34bcwMre4A+e41ViEXLPqgD8uTm03Mp2D9O7Y
 TVDhQSv44L53L93xhiu7eaUL04DQGgKeERR/80bHME3zuWpb1KBPCy3salC/wRAnd9LQvHzEzHQ
 LnF5o7K2jYwHiB+zfm7YX0JpGxHZ/bb7GIVUJWJqHm/mQ38vcLAnODSLr08jg83EL37WNBVfBy2
 VfPti6ubyex7wsi+236SpG1fsmubcy6VZ3gWRQnb9REYLD6S/rSjpe8ydnVznUfuYmbFbdDTX9q
 pAMbMQfteYk4IQeQPOGdbvPHlBVc/+ykqewg0GQqet0/qoLFUvy/CFjFKHuQjrc1WXnK/SCZQ8G
 vsiNGoKQns5Vz1BV4Inyk6TF/1kT49pc5Q9eawot4dWRLSIMZuyj78/SGcsUng1qbVEk7e5VU4j
 qDB72JaC/YFS1uA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Using `ArcInner` as `PoinedTo` in the `ForeignOwnable` implementation for
`Arc` is a bit unfortunate. Using `T` as `PointedTo` does not remove any
functionality, but allows `ArcInner` to be private. Further, it allows
downstream users to write code that is generic over `Box` and `Arc`, when
downstream users need access to `T` after calling `into_foreign`.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
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



