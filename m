Return-Path: <linux-kernel+bounces-274882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61398947DEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2FE1F256B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35115B968;
	Mon,  5 Aug 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQYjAm2s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA68159217;
	Mon,  5 Aug 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871286; cv=none; b=j2ywWnKoHlvXBM1f+hgqewNiPessN5o+3YgFrXTjjLJie9l57m6dRsrYVAdOaKOuQkva6BSCOO3y5+BYjorAyipHRwxqUsSl92kNpZMlaCvtvkV8pel6SBwZ4QosiEGrfyu794E9W7HgLiCDNf7iky+B9TApMsQP67bN0bcwTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871286; c=relaxed/simple;
	bh=pVB6WWQkYTknQoh+SglRWl5bEx9KaiouK24Dn9ENpJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDZ77P5spUjA3Q4mw0JBJEKf1w8I3MZOx2K+OuNMe+OsN3W8j/yU1W/+VuQISZGMZT5wRlsxuRelQsDy1TIqZvP2wvDkc9c2/74g12ncBJLOB6AFzaUmFjB88cR4A2PyuoxL9bWAl6yMvusluLrreHNDFFuJHq6+8rXDme4vNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQYjAm2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8145C32782;
	Mon,  5 Aug 2024 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871285;
	bh=pVB6WWQkYTknQoh+SglRWl5bEx9KaiouK24Dn9ENpJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQYjAm2sn0N6rVEH3rEmI88pOgI8cRwdDI2RVbhONdO8s774rHc+/ZyM38gA+TMDz
	 O/mocm5GbuEzpZg9UYh4Uwo3tfa9QKVP5kxgGdwkxx/2Hvom/KgwaRf5pVIRcDUZ/N
	 YtdkmL3LWu/gXveCzX1gQHv6V1pHg1AJwxZ+Njgnuq8lvmWDSetGbAcqgsArJAmgrN
	 Q8O7wXU6pwrOYxUmXiKZFxHufxGJ7Vl3EHSde2TIC27WBazAjWKa7npwrVpWmxmqtq
	 Sti3WOICk5Z7VUtMscEnq3sH83gFrz8TCDCqC8vn5tEk/WU2R4Ti+ANG/IvBqcYkAL
	 sVr3GPTAsR56Q==
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
Subject: [PATCH v4 13/28] rust: alloc: import kernel `Box` type in types.rs
Date: Mon,  5 Aug 2024 17:19:32 +0200
Message-ID: <20240805152004.5039-14-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we removed `BoxExt` and the corresponding includes in
types.rs, add the new kernel `Box` type instead.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/types.rs | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index b80a3b2b62ac..25761da5a816 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,7 +2,7 @@
 
 //! Kernel types.
 
-use crate::alloc::Allocator;
+use crate::alloc::{Allocator, Box};
 use crate::init::{self, PinInit};
 use core::{
     cell::UnsafeCell,
@@ -68,14 +68,14 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
     }
 }
 
-impl<T: 'static, A> ForeignOwnable for crate::alloc::Box<T, A>
+impl<T: 'static, A> ForeignOwnable for Box<T, A>
 where
     A: Allocator,
 {
     type Borrowed<'a> = &'a T;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
-        crate::alloc::Box::into_raw(self) as _
+        Box::into_raw(self) as _
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
@@ -89,11 +89,11 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { crate::alloc::Box::from_raw(ptr as _) }
+        unsafe { Box::from_raw(ptr as _) }
     }
 }
 
-impl<T: 'static, A> ForeignOwnable for Pin<crate::alloc::Box<T, A>>
+impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 where
     A: Allocator,
 {
@@ -101,7 +101,7 @@ impl<T: 'static, A> ForeignOwnable for Pin<crate::alloc::Box<T, A>>
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
-        crate::alloc::Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
@@ -118,7 +118,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(crate::alloc::Box::from_raw(ptr as _)) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
     }
 }
 
-- 
2.45.2


