Return-Path: <linux-kernel+bounces-270020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5772943A27
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA71B248A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD6B13C838;
	Thu,  1 Aug 2024 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYxUKb4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A92E634;
	Thu,  1 Aug 2024 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470884; cv=none; b=la9oLG4nj/hC2beoIsa4MTiig+buF5GOio2vFXLfm4TvYfVEWX46xs3LvctqRUCSH1lT7Vfthvd0C86kpgf7mCR9IVHlXyVvzGePBlyEbQGPNTMMSSH4n75uVXmzbOtzD3XfMbboiGpQIzj0Bj9EQdT3GxpUV6iN6i2yLmXwgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470884; c=relaxed/simple;
	bh=w6PgALWiEZslFA5r/x2p08ONTo0/JO09gDNDQem/zbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zh7tKQzz9Z+gS+3bLKMxzCVRF8SeB7PzgDqzchdqIOamPEeXxNdo9IQLSoRkT9muRrqufS+vY3uzWktnNKq66ic6dn+STUoUMDQHnM+5ZoyEH/K6r8+Da/Liu8fjyxol/br/3bNfNjJLqPED2mUk6BQQxzClGb50ZV2vpo0zajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYxUKb4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A4EC4AF0E;
	Thu,  1 Aug 2024 00:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470883;
	bh=w6PgALWiEZslFA5r/x2p08ONTo0/JO09gDNDQem/zbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AYxUKb4V1+mWLyMLbmg/lrmQ/MpwgoFzMkBm5upnFiq0uNUepCersNXThbHOs+Ej4
	 vlt/uoEQ7BsgNjHg2m7bp+LWIoqeYyHeSFLzgioWidQeDHftOPwdv7rilxyAOS+WoO
	 BGLdSDI7hLHpTiUtKzhWc+LxhbdrB1WEze5I2Vx7e0u518+fkzkgUwvnIa9MiTORkq
	 o4iTRGGS69IqkRbQf+f7qsmMiSu3EDq3jLAcbTodaoS1v/AH00kGKq0CCJxtwr6+8X
	 hJJXfsPN9BEBUDkmHG7lLcfbpSCl30d5gtzLttCAw1a8OZMyIXgUJEYM78Hcuy3oI1
	 2xs7GpyVzkJqw==
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
Subject: [PATCH v3 13/25] rust: alloc: import kernel `Box` type in types.rs
Date: Thu,  1 Aug 2024 02:02:12 +0200
Message-ID: <20240801000641.1882-14-dakr@kernel.org>
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

Now that we removed `BoxExt` and the corresponding includes in
types.rs, add the new kernel `Box` type instead.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/types.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2aadf715b336..809653b9d945 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,7 +2,7 @@
 
 //! Kernel types.
 
-use crate::alloc::Allocator;
+use crate::alloc::{Allocator, Box};
 use crate::init::{self, PinInit};
 use core::{
     cell::UnsafeCell,
@@ -67,14 +67,14 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
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
@@ -88,7 +88,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { crate::alloc::Box::from_raw(ptr as _) }
+        unsafe { Box::from_raw(ptr as _) }
     }
 }
 
-- 
2.45.2


