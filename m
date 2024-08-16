Return-Path: <linux-kernel+bounces-288754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F136F953E31
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998832885B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B187839E4;
	Fri, 16 Aug 2024 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKJgKObJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788578287E;
	Fri, 16 Aug 2024 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767246; cv=none; b=AOt+coddpE7mtN8gj5YROAnQQ/he4KbrBHVCcvVeqW5aybbAe/JAvum1GT0Jx0Whue/+Ux0ssvlGP6gvLmbCizPQPKo+fV5fkj1LwPxOeX3BI5o8W3uThmlUjOlrxhVEKYVmWOni6BKjSCf6HoR/pEBi/lFz/UdLVXFkgRuyvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767246; c=relaxed/simple;
	bh=unZr/wctKeO2llH/7rXaGgjBoxn3EEVi4EeNhTJ2sVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL49KLvmY82lN7mZnEM13Q5posfRBpQxNVfdWg7DO8ZM7NfW7JGIX4/b+BZXh8W3Lvm//7FguCBB2Eo7sxrUcucG0K5x06qBIDlKMMAdYJPU7fRTsLgj9tDtBt42sPm8NojK+fvLN3T9ro+MwafFHfj5YXG0hXYbGo2A/TBUTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKJgKObJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274AFC4AF0C;
	Fri, 16 Aug 2024 00:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767246;
	bh=unZr/wctKeO2llH/7rXaGgjBoxn3EEVi4EeNhTJ2sVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKJgKObJI+X2UmQVowJ7q51gwpaf2MwFkO5t4y1aBGn0icOlMhlqwKReb6RPYh4Qk
	 j7MMCR3KgSXIZ5dKB/BlbC4UkjsWvD+GY4qr9tp0cBdcMouT8+MFpoBSwFXDQLYQcW
	 xkb3Jp5QOnRpnKNoYBiz2kLl3LfwyoIxd4bkP18/3wBgSOoxFXKkxdV9rD6yGlxtYi
	 0NO17v5AJDvxUBL8EzYxA1wkP//qS8XDAcFundYdEW2S+VWF7N3yLhKwld88YtjRdc
	 LTn2ggh8HgiHkQdYneYku/q+d3FequHq2IikvRSis2NcmFhMVmr7j7HYwrcs8i9jxa
	 YNou96ZIY75Mw==
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
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v6 19/26] rust: error: use `core::alloc::LayoutError`
Date: Fri, 16 Aug 2024 02:11:01 +0200
Message-ID: <20240816001216.26575-20-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `core::alloc::LayoutError` instead of `alloc::alloc::LayoutError` in
preparation to get rid of Rust's alloc crate.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 145f5c397009..2d012cc3881a 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,7 +6,7 @@
 
 use crate::{alloc::AllocError, str::CStr};
 
-use alloc::alloc::LayoutError;
+use core::alloc::LayoutError;
 
 use core::fmt;
 use core::num::TryFromIntError;
-- 
2.46.0


