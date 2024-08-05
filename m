Return-Path: <linux-kernel+bounces-274883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB00B947DED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAC01F25889
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7CF161310;
	Mon,  5 Aug 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1oXHRoz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7A159217;
	Mon,  5 Aug 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871291; cv=none; b=fyZ3vw3rm1GetPg/DlEEm28ldN0xh+3CVmnLwPwWfVgJNh7Q9cta1Si88/t6Lo4PYblfwTYwCP3b7j5sN6kZu7ekkks1sI7RhvVSD/7UeLRNvCNqyOB7Az36t9u1neAqpUjUpwUekvZz+vfiDK62h8Mrik3xjk4kVW1d2CKUOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871291; c=relaxed/simple;
	bh=Lu3sR+WGYMF1UUYzfkZ9j2xNETNWcnAc7sJFrR4A4JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWg4z7/AhpoL7QmdTke93uaijlOofqG7ZQifEbfsI1VFt2AbZn0Q3AiH/0IOnZW0UGyohkf/jBgrBOsZBdVzeXOpc1ox5RBelOhpIFLC8CDWChtZEX5ZKnnpD0RrjngOMwo2DXi63BHkrRYy3BESNMKeL+1jFQTtwbNcgy/erkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1oXHRoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E80C4AF0C;
	Mon,  5 Aug 2024 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871291;
	bh=Lu3sR+WGYMF1UUYzfkZ9j2xNETNWcnAc7sJFrR4A4JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1oXHRozCxElqWOZx7zUrpBUJXCIC5CrgbAKeFrqcKlcOBNs9+XpKdfy265PO/e2n
	 0GUo+PujPXsi41M3hy94E7O07PgxZUBhl0OgrkJ0S6nULlWzvpKrgUIEBg0GWG7nJL
	 E3mn/JFadLIHEbOEsL3MQWJ3IdCYLT0JfGQ6cj5mhTUxBnpdtJ14VGxCnUZRyUb4If
	 1HQONpQID/uAQoBZH93bhl3KmSVoVKgO5rLNsLNr5bwE8QvS1oMqiE/Xmuofhnq0fD
	 vmMbWClGaZPm9KtavkN4Jyq2LQxp6+IOqM/891vzyrtx2CP/fH8mwZGZny4FXDatGR
	 UEkMf7445vvKw==
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
Subject: [PATCH v4 14/28] rust: alloc: import kernel `Box` type in init.rs
Date: Mon,  5 Aug 2024 17:19:33 +0200
Message-ID: <20240805152004.5039-15-dakr@kernel.org>
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
init.rs, add the new kernel `Box` type instead.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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


