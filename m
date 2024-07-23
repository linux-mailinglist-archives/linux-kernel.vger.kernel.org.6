Return-Path: <linux-kernel+bounces-260286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2673093A560
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B791F21CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C815B54C;
	Tue, 23 Jul 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLoQu3Om"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE013158A01;
	Tue, 23 Jul 2024 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758326; cv=none; b=KQbIipLiEeyRwcDFd+LzD3tkln9URCnLj+TOsypOumjOA32RLyqUYZMdcZE+oDqX0eEwe3NvHf6fynuV8wShIbDKH4Q6eD8UcOg70Iz9/DmTA13TCodzrrMLV0kgABGWcehXRD0lGzpY0lE9gxnke9U859Y+/m8NAxIIaBeNKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758326; c=relaxed/simple;
	bh=/9+EutwFn2+cS9gNKuR0E554iCROCZoKL1CdsGgwb8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l715DHye1H4LWaGZ9Kakt13R5d9fZ5MF3ctYexYj+aOm3XbqQ6hJOC93P5kZBZNOtyTxfwZCfiFcjGT7knhY5FKdllrgN2AL+nAIkj8imhF0L5UJMgTbk9gOB9mzVKm+MiCRG9OyBUbMJMyEFoO2SEEa0j7Qewe9it094KTFLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLoQu3Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AACC4AF0B;
	Tue, 23 Jul 2024 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758326;
	bh=/9+EutwFn2+cS9gNKuR0E554iCROCZoKL1CdsGgwb8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLoQu3OmR4kR03BZ8aJlI9lV2J2cK5q15+YM0g9Mk3OdIv99lwhllIfwFbxAjDPC7
	 HEnHKhrUzctHyMCZubcBLDIYnasV0oih0b4l8i8KKkDl1cTVVSZeu5e8LCNtXC9umw
	 ePCdXJCWkjhzKSab4zyxHHvCfTN1E96TI1Y98S+fDFoQZzdkh2+NlSOv7IoxINuKCO
	 Zk2LoBFwQLTP4+xHE4wyhAHcPm8YeMUUFW0+qqSp6flIxknGQD42hXLewq85y1cAth
	 FLFbS9W39HLuUQ5Wph9CZsa9pgiQFbH6DqanRCeBaRElTVvTKwdx9dPpacwWGPZdEF
	 c8Bc9x1nNVNmw==
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
Subject: [PATCH v2 13/23] rust: alloc: import kernel `Box` type in types.rs
Date: Tue, 23 Jul 2024 20:10:02 +0200
Message-ID: <20240723181024.21168-14-dakr@kernel.org>
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

Now that we removed `BoxExt` and the corresponding includes in
types.rs, add the new kernel `Box` type instead.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/types.rs | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index d67b37a5edb8..ee0063a20d89 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,7 +2,7 @@
 
 //! Kernel types.
 
-use crate::alloc::Allocator;
+use crate::alloc::{Allocator, Box};
 use crate::init::{self, PinInit};
 use core::{
     cell::UnsafeCell,
@@ -67,15 +67,14 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
     }
 }
 
-
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
@@ -89,7 +88,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { crate::alloc::Box::from_raw(ptr as _) }
+        unsafe { Box::from_raw(ptr as _) }
     }
 }
 
-- 
2.45.2


