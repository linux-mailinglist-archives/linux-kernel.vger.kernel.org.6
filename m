Return-Path: <linux-kernel+bounces-389522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DAE9B6E06
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6966B1C2330F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEA021764E;
	Wed, 30 Oct 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtGSH3HX"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07662216423;
	Wed, 30 Oct 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321211; cv=none; b=NtqGt9Nx0Cg81l0KRYGSoqEHIwAd7/eMwsPArr+6EBE1nNkYjPIRsi1odQY2u6S5ViRa8RYcC+UftXqa0QKvSFYoX//5jq1NyVj6l0+JufEE73zPVczXKqldkyEbWsd7m4jLZ8U/rqEn0C1xXdcPifSSOLz7XbljTt7fH6akzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321211; c=relaxed/simple;
	bh=0Th+x2IDMOoiPCod6xdhQvrFDyU4PFyE5MtERCpSFyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S44YLygd/tjdzeTcSDkptFGG4hNO2cD0jBlis6l/9WP9PdlQrZ6lXVqXfP8lmrcgYX8PHQJZqRlMlPstvi0TeR3P+UdbvV5zaDjxgwK/cs8TPHQBHH3yL8hgNosdNCLyOzUH7XI05f4/MRW7hXyM3wRWiYEcClHc0yLuN7/4ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtGSH3HX; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4609c9b39d0so2029071cf.1;
        Wed, 30 Oct 2024 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321208; x=1730926008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryl4oucJD5PPaNzWfafNblD5KtXW1k3WEIZKABqwt9Y=;
        b=PtGSH3HXMn+T2SeDwj/hlZxfTM/MI2YlLo4gekLQ51PRJfjc9pzvdB1tMKCS8Yw0V2
         vG1Ak0qpqmKllnddmzB2BVqeMe+2RICbRih685eeBBRgkC1MBNMBgrh6Xz4tGTAXZXft
         A4FvtGftW6R8LQ3gA58LX40k46kKJZ+TjDQRHcUwhc7sg3I23l+as4Ymd/4KXY4ZUYhE
         PV0vb5/MPdTBt/enb1ou8Cd/SIZHAwlesXYHZ38ylnp7Ba6zrDV3EsQ/rswqAaIFKhAi
         M2yk62f5tqx+ibVknGe8YO3UCmBm15Aamh6ME6d246tdihaU7+DdLK+XSuLIJiTukKbT
         UH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321208; x=1730926008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryl4oucJD5PPaNzWfafNblD5KtXW1k3WEIZKABqwt9Y=;
        b=IdaLufrNvxtQNkfbjDGlDVOr+zYqFezQgbxBaL10Pqe56ZZisA6gYg2aXYYEh/JUAG
         kC4NXiTrbz5PomdPShxuEvcavecHJWB1X5/67fNZKiYEhTHCxVQbHZHdhNYsqpklnrrS
         hAYX+I4k2G3ICJ9vWplQvOKIVcFxPLA/j56o0uUrfKKSpXgE6qEM7SNZ55HBvTlfNDvE
         BktZjhW01iTInEICaNSoiXEj7XcHlX/U4yA868yz306KylYT33/y2nA4N68PTko4MEky
         pPIW0w1vhIi5VBk3P89sHlc+ys+PBTw0OTHAk6Fv4azSIcHY10uGN7BJiSb1dvo1yB3N
         KmxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKjt1fdVIx0+hJv4rFrA+RGnd4G2Kya7AnDXm2wqYVR15h+bfVuVIorgf0kdX3Mly2KTePYMCOkQWe944=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0VyiKfnXbc0QSqjQr5rXEFiMLBUxF9KKQRPEWZ5B4I81ur5D
	tNwUuwEeik3JmKzWjm/BHZ8FnU2CSEGmW0VZqKY6n38SFtDKhRgX
X-Google-Smtp-Source: AGHT+IHUvH2uFaNbT0sxzXsGMiq/mHK3axbbueOqnq52zss6gcSnP4GhuLOuojLLomDXgwLNU4P8Ng==
X-Received: by 2002:ac8:5a11:0:b0:461:50a1:4e2 with SMTP id d75a77b69052e-462ab308c72mr12615821cf.55.1730321207830;
        Wed, 30 Oct 2024 13:46:47 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:89dc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0c72efsm271271cf.50.2024.10.30.13.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:46:47 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Oct 2024 16:46:41 -0400
Subject: [PATCH 4/5] rust: reorder `ForeignOwnable` items
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-borrow-mut-v1-4-8f0ceaf78eaf@gmail.com>
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
In-Reply-To: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

`{into,from}_foreign` before `borrow` is slightly more logical.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 18 +++++++++---------
 rust/kernel/types.rs    | 20 ++++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 26b7272424aafdd4847d9642456cab837797ac33..4552913c75f747d646bf408c1e8a1a883afb4b6a 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -339,29 +339,29 @@ fn into_foreign(self) -> *mut core::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
-    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
         let ptr = ptr.cast();
 
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         let inner = unsafe { NonNull::new_unchecked(ptr) };
 
-        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
-        // for the lifetime of the returned value.
-        unsafe { ArcBorrow::new(inner) }
+        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+        // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
+        // holds a reference count increment that is transferrable to us.
+        unsafe { Self::from_inner(inner) }
     }
 
-    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
         let ptr = ptr.cast();
 
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         let inner = unsafe { NonNull::new_unchecked(ptr) };
 
-        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
-        // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
-        // holds a reference count increment that is transferrable to us.
-        unsafe { Self::from_inner(inner) }
+        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
+        // for the lifetime of the returned value.
+        unsafe { ArcBorrow::new(inner) }
     }
 }
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 04358375794dc5ba7bfebbe3cfc5885cff531f15..b8a7b2ee96a17081ad31e1bb73cb0513bcd05ef4 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -31,14 +31,6 @@ pub trait ForeignOwnable: Sized {
     /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
     fn into_foreign(self) -> *mut core::ffi::c_void;
 
-    /// Borrows a foreign-owned object.
-    ///
-    /// # Safety
-    ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Self::Borrowed<'a>;
-
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
     /// # Safety
@@ -67,6 +59,14 @@ unsafe fn try_from_foreign(ptr: *mut core::ffi::c_void) -> Option<Self> {
             unsafe { Some(Self::from_foreign(ptr)) }
         }
     }
+
+    /// Borrows a foreign-owned object.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
+    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Self::Borrowed<'a>;
 }
 
 impl ForeignOwnable for () {
@@ -76,9 +76,9 @@ fn into_foreign(self) -> *mut core::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *mut core::ffi::c_void) -> Self::Borrowed<'a> {}
-
     unsafe fn from_foreign(_: *mut core::ffi::c_void) -> Self {}
+
+    unsafe fn borrow<'a>(_: *mut core::ffi::c_void) -> Self::Borrowed<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.0


