Return-Path: <linux-kernel+bounces-519436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE489A39CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F077174BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA5A269CF5;
	Tue, 18 Feb 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na8orcHN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2DF269CEB;
	Tue, 18 Feb 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883742; cv=none; b=nvlzNlDM2tZtHb4lucBO6zbQDbQq/tHAQOCF96wsb6Lemh+XuLcJo17AG9sX7lLsoqlDEjtD1ulfeS7J86o4zpqUoc3AB8EYJZTRWTWtOIeGToj1hmSwPJkZChTzlbEo03cLZOe61zguC0vya4DHB0n/oQHjqZf9U/70O+dz028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883742; c=relaxed/simple;
	bh=eORqxd0mJn05akI2ESSnkwHFWYB8nod8rI3Ghzxpw9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aeEeq6YfJCM/JCICAmSFmS8UJX5xf7004ipoVMcKqKM6wm/ZgwG5BqeiDzL5S9vlh5C94FTEBgYmdTmJzDxsdoDTCMA9VH51PVPmTn2liqCO9I7Vgxue9SBmU9ncqCp7neOwKygRlcZNp7bw2pTFIMmkWlrQ4nRdeiAx5MImxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na8orcHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DFCC4CEE2;
	Tue, 18 Feb 2025 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883741;
	bh=eORqxd0mJn05akI2ESSnkwHFWYB8nod8rI3Ghzxpw9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=na8orcHNWaxPtN5CoIJLgH4PhCwiW7zHqA62CFqEyEEzqqB2VY9NyEtwYn/p8hz3B
	 ncPT1gHHJCSzt3TvD+c4+tw/MlARr4qkWhLUxKFaxUIWqeF6o8NuHP6wZlN0oI6RfM
	 CkLOCxFi3tq5ZWu9PMSA9LF/rnlrnfN0i7IdQ49tbOjJnEu/V+jfyouSfm38q94KHh
	 gVow/G0L3mW3PfJAi/e1n3EZGuUj1PH5De1+CW+N6cruPW3XTSE0oTKQvB9ha3FT7x
	 KEv9xRsXDeSqwAGL3neYr7LNaoSOo5gYbn4yd/algxuc5m4uJ6KNYt9cDInkbFtcQv
	 IsIXzwQIV1J6A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 13:57:16 +0100
Subject: [PATCH v3 1/4] rust: sync: change `<Arc<T> as
 ForeignOwnable>::PointedTo` to `T`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-configfs-v3-1-0e40c0778187@kernel.org>
References: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
In-Reply-To: <20250218-configfs-v3-0-0e40c0778187@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3517; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=eORqxd0mJn05akI2ESSnkwHFWYB8nod8rI3Ghzxpw9g=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIO+fsEE+kNjovn0VrilnLGRuRMSAXn7BSarl
 s0TdSE1kQmJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SDvgAKCRDhuBo+eShj
 dyOWEAClTZUEf7xX5fDUfakBFemdXABwwkJ3YP6ID8r1waBuVzdJMkTW88nkIjp08fix2X96uaB
 EIftNsf6lsXF6R8QZiH7FBF4Ay16u60LGTEQiVyMN2I27A+2m1mvairYwDqWRkc/7lgIeYMYfQ3
 xEoMY+t8PJ66daMhqWR0NxYno39w+/dXKI4Ogk4wwbRETlzXUf3O/xfxPNjIA1M479/ZbTQX55c
 /02gjDOVoWhgyAm9lYgqXpVxmukjD2ab5kXJ6PFNiKP3c3/i6sRMGV4FkZwV7z8geyiPq1uTMuX
 bytai9FhM2dd0sLWqG4uNHli3B7aNYwI+DfwmVZUdKIz1/ceJKu8fOcSX9X1bZFvStIwKwKL6Up
 2b6uSYs9gK+hPWW5y0AjEl3SQWqKg0JTgzY3p5gz7/rsi9T2PdfN/jZVbGiE5ha+Czcuz8h+p6a
 e0O1VEjMR6xw/H0X/SG71yWHydlXdeQlxayVbpaxvvP2atRRyd4gTz9bPPeBy5D1aHZ45WY5pa5
 SaXTzq7h+cdoVlDygp92mRBq8lzJVnL4IgwCQN54XRssAQ/1IEq7qQcslA8PSd2/KNC/usFMqax
 T27Bi1Q9yInaZj8VtsbJipKHMXDhbS4Q0O0VglQ2+iCwuIkE16bYNFbxtxYPS6Vd2TW6om6HGxh
 OYOBsLpDNU0C9Yg==
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
index dfe4abf82c25c..3d77a31e116f1 100644
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



