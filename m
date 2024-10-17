Return-Path: <linux-kernel+bounces-369821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10939A232B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684D31F22877
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37121DED6C;
	Thu, 17 Oct 2024 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k03efsGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED51DE882;
	Thu, 17 Oct 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170569; cv=none; b=WMjAF4/GfyHgugzVVYhQcp7muXHc5uKFCd79L9gbps+WANQ00UKLmrLcPKnaTUD26qRytq6DyL/rWhmKRAcUSbOgNHnM0GWZiQIktOMBpLxifI1WaQVcxk1KPhnHvgM9w2wdBW/K0Rjr6KP71hwSeLos+UnImotyx+s44kSA2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170569; c=relaxed/simple;
	bh=5C2sQwreJAUq2xkupKtASZ31n79IvjHwew9MiqdV2gQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJo9qZnNVOWAHVES07ivKDfdyUmB9V34J/ggaz2ndum8RCPpb+Qow6gKJKcs0EzW+vjr+JoPGjvFoDZ+vtlpA38FMDt6HvJVDZSXdcyEVzTIbj4KEEM4MOX/8HuePoGnUgqUN8l8dzyMBpUuaJBV7V53KlD+evD1T0VZh3H/HFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k03efsGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613FEC4CEC3;
	Thu, 17 Oct 2024 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170568;
	bh=5C2sQwreJAUq2xkupKtASZ31n79IvjHwew9MiqdV2gQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k03efsGwkAOdspzTf41oAKUSZenaZH4FETcsJiTM8AuGa/GF+y5Qg93qg8F+L4BjT
	 YA1ADPcPDbkV5RG6KAeHC8u/u7fSRpjwHq1SmmXMGxiOMb++81jqiPNlWxxlHiwcvF
	 t5jjdUnGiCgBBfGJmHJEVAPdAkD2QUgFMX1NN66KTAaz5cEDyVtteylkWXMVQe4Mez
	 OGXSfj5EBqEfY4+ZPQqlo5h7FlKfpk0Bwdfeu8yqMsg7JhHmRp3GPlvZPQSesxBQ+o
	 3FCSCFoUhBaIiGtuieOatsNv+a/6HoIlRNVTXaG1kIIIN1Q6RBm65khw3LZf7Vjsxv
	 RUmB6R0GiOhCA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:30 +0200
Subject: [PATCH v3 03/13] rust: sync: add `Arc::as_ptr`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-3-59a75cbb44da@kernel.org>
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
In-Reply-To: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2

Add a method to get a pointer to the data contained in an `Arc`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/arc.rs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3021f30fd822f6a59c33f32e08008c7fea483b02..5e73af1253df37c2c810a0ee6f1b1236bbddef5e 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -237,6 +237,15 @@ pub fn into_raw(self) -> *const T {
         unsafe { core::ptr::addr_of!((*ptr).data) }
     }
 
+    /// Return a raw pointer to the data in this arc.
+    pub fn as_ptr(this: &Self) -> *const T {
+        let ptr = this.ptr.as_ptr();
+
+        // SAFETY: As `ptr` points to a valid allocation of type `ArcInner`,
+        // field projection to `data`is within bounds of the allocation.
+        unsafe { core::ptr::addr_of!((*ptr).data) }
+    }
+
     /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
     ///
     /// # Safety
@@ -515,11 +524,11 @@ unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
     }
 
     /// Creates an [`ArcBorrow`] to an [`Arc`] that has previously been deconstructed with
-    /// [`Arc::into_raw`].
+    /// [`Arc::into_raw`] or [`Arc::as_ptr`].
     ///
     /// # Safety
     ///
-    /// * The provided pointer must originate from a call to [`Arc::into_raw`].
+    /// * The provided pointer must originate from a call to [`Arc::into_raw`] or [`Arc::as_ptr`].
     /// * For the duration of the lifetime annotated on this `ArcBorrow`, the reference count must
     ///   not hit zero.
     /// * For the duration of the lifetime annotated on this `ArcBorrow`, there must not be a

-- 
2.46.0



