Return-Path: <linux-kernel+bounces-270021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E256943A28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B481F22271
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4475E13C9D4;
	Thu,  1 Aug 2024 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuq4GKG1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672E2E634;
	Thu,  1 Aug 2024 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470889; cv=none; b=PbrnFc9gwJ2gNSQLhcv0Ak7flaQrk+P612BESfsQCv19tKdA3g3k4DjtOAnX2nqAIqCEZaeNYhOxkCJw1KGlDOUnBCJducRh1rv3RVvgjN/H+2zP3iL4JtmcpK3foTjG4L3EITtviXaZbfg/1OXaobW+qjVcm/7ru9I0/BlZPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470889; c=relaxed/simple;
	bh=IVeFanrsSDZ5EV05jvxVmzxFrqOI4KjMh5AykPQhj/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9u4gytfM17LtIta5T7CwzfpFa2OIilU7yhYAlBn+9JBDErxqPaNZK/Pa5uvxzZ+fkjitf6UNvKCkFjfR55sIGBsj5Jt5glUA//INfharuhXEXiUDfbW9jUgyX2iYaEHkmdxPx136nwbf3jM+HCVTfKUSp1MzbSdtW7v8kRlIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuq4GKG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A302C116B1;
	Thu,  1 Aug 2024 00:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470889;
	bh=IVeFanrsSDZ5EV05jvxVmzxFrqOI4KjMh5AykPQhj/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuq4GKG1noPXG4VromqEQ5zTR/nbJlMJsyPeU7CAhTOpPfxxu0+6HNgp9Z4iJM2no
	 TYLribq5kSOg7QueTYWZ/kivvl8DXQBnDqU1VCfad2nhN6gWLgrhyuIbFU8AkiW0gK
	 UfscVewIgoA7NhLfnntiU21/c+3RrPIk0DTJUk5Q1qEXoOIKFixLbE8P3iCTXBjfOk
	 ZJryrH8v/PpxMJE9BMgPUTA0O/0od0lVUDNowGA0euP+QWNS6fLMJkklMY1DfbUCvS
	 odtDuWRg2OXRcMi+Ox1HrsiRYNn5jVhqQLjG7wpjhDw2oQxunrHiPUkQhZ4d6kTZCt
	 hI8HmjqY65Svg==
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
Subject: [PATCH v3 14/25] rust: alloc: import kernel `Box` type in init.rs
Date: Thu,  1 Aug 2024 02:02:13 +0200
Message-ID: <20240801000641.1882-15-dakr@kernel.org>
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
init.rs, add the new kernel `Box` type instead.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/init.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index ae533305d40e..350582662964 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -211,7 +211,7 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{AllocError, Allocator, Flags, KBox},
+    alloc::{AllocError, Allocator, Box, Flags, KBox},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
@@ -1147,7 +1147,7 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
     }
 }
 
-impl<T, A> InPlaceInit<T> for crate::alloc::Box<T, A>
+impl<T, A> InPlaceInit<T> for Box<T, A>
 where
     A: Allocator + 'static,
 {
@@ -1156,13 +1156,13 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>,
     where
         E: From<AllocError>,
     {
-        let mut this = crate::alloc::Box::<_, A>::new_uninit(flags)?;
+        let mut this = Box::<_, A>::new_uninit(flags)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
         unsafe { init.__pinned_init(slot)? };
         // SAFETY: All fields have been initialized.
-        Ok(unsafe { crate::alloc::Box::assume_init(this) }.into())
+        Ok(unsafe { Box::assume_init(this) }.into())
     }
 
     #[inline]
@@ -1170,13 +1170,13 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this = crate::alloc::Box::<_, A>::new_uninit(flags)?;
+        let mut this = Box::<_, A>::new_uninit(flags)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid.
         unsafe { init.__init(slot)? };
         // SAFETY: All fields have been initialized.
-        Ok(unsafe { crate::alloc::Box::assume_init(this) })
+        Ok(unsafe { Box::assume_init(this) })
     }
 }
 
-- 
2.45.2


