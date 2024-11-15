Return-Path: <linux-kernel+bounces-410967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729CF9CF0ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7321F2ACA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085E1E131B;
	Fri, 15 Nov 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOOgq20Z"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF31D90A7;
	Fri, 15 Nov 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686458; cv=none; b=L5VN4WMsCedrs4fcAc+anGnAJy5wXAbNUZBpnEbnd96vKM5lRpVwYUKxToc8mUP7FL92FM8MiyVG+lESOm+szv43kEliHlPt+wKLpr6ZNznTQW7HnOh7Db5IH0kRtV5snBOGRo6I9yy/HCNYOYPV6rkksP/28BRPyvv/bE/IlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686458; c=relaxed/simple;
	bh=fH92snzceKk4eLxhpIkJVtTGzy859oiwahfncz/Oy0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JD9Xc8fkoL/QgGz0KgYwE9hrhweOqFUpm3HOh8Gkb8EOYGTubypqGMPpFAVTtKHGRBAkN0yJFyqmF33g8ZjqNz4c/pMgZH9SjooKnS1VOt0vsp5xAr/U2wc4TBgdFL3J6r25Ayuif5sEvBbZHeJgBWRqdFbGybip/+vyv4M6n6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOOgq20Z; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b14554468fso114142485a.1;
        Fri, 15 Nov 2024 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686456; x=1732291256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DEX5pxhpjG/jUyf+2MYvISOzDGV5P67ztR+W135scA=;
        b=LOOgq20Ztw+9FKKCLYKgD0PBiv70J+hPyE0nTKjF358r95WVFHoJuu9xRouMsPeU85
         +2TSFZa8Q3TDMdJiYQj7UmGcOZaHc2JF4k/wdahHo1ceEAQaYVvnCWn89Uz6FMviE3f/
         /xU+h/ls1S2rn6AjQOB4/EamqK9XAYlg4tgjRe8NymZVgqcXlYLGF0c7prk2q8rXXJtX
         77qINH3GzaMODHgwIyPZR90n/kfl8ZbMLEL82wt6tnJB2NDF/nPzkTBFwTKgA/WvSxrH
         WH902LI68mLlGeWzfZjIAwE8P1kD5t0Gu8WlL4thnfmUYLS6nsxYt4iBqExSViIjRpWM
         DOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686456; x=1732291256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DEX5pxhpjG/jUyf+2MYvISOzDGV5P67ztR+W135scA=;
        b=eT2MGHr9CbFetwNiEVRQfmC1+pHAlyyG5Is/Mc32n2PgW1yFe3pqXQkBSWk5nVpAa/
         fKzcGRYjsjGAJnpaHPHxeRNZwYdEwkXOO48xYxsJ96vepNOo9O01YMSUx6riwUrQdpWE
         lx5GEWOmXffpvY1zMvfObnm8uM9hiXqbrrwY6aDlBIFkzWMLM1QnTnWfLapdhB729KHC
         dg7vVKWck/hmCIZbwzK5Xe9s5rh70Xzhctv7/oEILDr2SJPczdS83ZmvcB0pZMRW4cCW
         QKjSmb2SnVsfflmHKmJ16uTEvLf/kNx1HikPv3a4xa1Ywlk3WQ3+R67RML/tizYYO6sc
         sBYg==
X-Forwarded-Encrypted: i=1; AJvYcCWuXaaLeJIq3F2dZa9B0kklVkVMIEzVnT0144zGiWDWtAK9Y2lWbAMPkxlBR9Knlv2w1aCe1KM1JYTBzeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFA24NGFsy5ZAOKySy1WCKTaAtouM/GtEuKNtJG8P2VxMKxYo
	osx+FMNWpOKSyN1XnN+rgr9xvkD3dQfHSHSZpi694nwoX+n5Utq3
X-Google-Smtp-Source: AGHT+IFe+QU+wg5N9XavpDWq+PX3XEbWW6HEvIvwg6+ZUCMH18ICQ/FYJdk5fHlULHNJlunV4weqvw==
X-Received: by 2002:a05:620a:4594:b0:7b1:5f49:6bf7 with SMTP id af79cd13be357-7b3623718e1mr385035785a.56.1731686455712;
        Fri, 15 Nov 2024 08:00:55 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:edce:cf6f:2815:775e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984576sm171108785a.25.2024.11.15.08.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:00:55 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 15 Nov 2024 11:00:48 -0500
Subject: [PATCH v5 5/6] rust: reorder `ForeignOwnable` items
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-borrow-mut-v5-5-86204b249667@gmail.com>
References: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
In-Reply-To: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
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

This removes an inconsistency with `kbox.rs` which already uses this
ordering.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 18 +++++++++---------
 rust/kernel/types.rs    | 20 ++++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 01d85da799d77127fc99a9b270b8a7b1ef435b6f..1d26c309d21db53f1fc769562c2afb4e881c3b5b 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -337,25 +337,25 @@ fn into_foreign(self) -> *mut crate::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
-        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
-        // for the lifetime of the returned value.
-        unsafe { ArcBorrow::new(inner) }
+        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+        // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
+        // holds a reference count increment that is transferrable to us.
+        unsafe { Self::from_inner(inner) }
     }
 
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
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
index fd7685921c7c9866f963adef122dfe45a7afd87b..c2ac1626f8ddff7397ec00f502abcfe78829b532 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -31,14 +31,6 @@ pub trait ForeignOwnable: Sized {
     /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
     fn into_foreign(self) -> *mut crate::ffi::c_void;
 
-    /// Borrows a foreign-owned object.
-    ///
-    /// # Safety
-    ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Self::Borrowed<'a>;
-
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
     /// # Safety
@@ -67,6 +59,14 @@ unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
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
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Self::Borrowed<'a>;
 }
 
 impl ForeignOwnable for () {
@@ -76,9 +76,9 @@ fn into_foreign(self) -> *mut crate::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *mut crate::ffi::c_void) -> Self::Borrowed<'a> {}
-
     unsafe fn from_foreign(_: *mut crate::ffi::c_void) -> Self {}
+
+    unsafe fn borrow<'a>(_: *mut crate::ffi::c_void) -> Self::Borrowed<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.0


