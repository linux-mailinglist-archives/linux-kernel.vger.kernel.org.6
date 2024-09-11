Return-Path: <linux-kernel+bounces-325730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA06D975D88
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253811C22786
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5911BD017;
	Wed, 11 Sep 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2tMltIA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A171C1739;
	Wed, 11 Sep 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095423; cv=none; b=dkiWACMIEGO4lW5bIWt/PLypuqjPcF4JPbfi/MezGRnjlmpzuO7gOrxDUNCpCbCqRQLf0MixY6RZjaF8TzDx/y8gAG3Xi6na0HlXw28UpIUZtQut4+FO2x2ki0xyKzIw1dx4+MoggU3ZjifHGl6mvoxuA2U55KUKavV4h7nDc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095423; c=relaxed/simple;
	bh=fJujYBGRQtYZqIjs4LKUGmLmSm16nkPMSrJSclIruqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFpy2V43cq2nIJ8h2TPKJ6bLHIiTRn7TkAn4tZtby/xSr9Pk99DWBSjPhWo5iiS/ryRfRjPQX7Wm4X1akLFsUQ07CtwF3ufmOGj9IZbyT6W7wecf62T2kHzefr8rKbVFrFp8LKUri9aWPsR+Op5jcShfPY+i+C6GybiLu4YHu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2tMltIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA91C4CEC5;
	Wed, 11 Sep 2024 22:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095423;
	bh=fJujYBGRQtYZqIjs4LKUGmLmSm16nkPMSrJSclIruqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2tMltIAnv/i/tJGJe7bNbkIVpUV0WYSuNcZNfxRBs0WykhZrbPUzjYzdq1yY34uH
	 1Tx1f0x7bXrf25FFCClhtCtxPjxtJodKtTeMP74jggPIzmW/Z/1VJE6bDVMXBtUCvg
	 XkIo9Xxs8cYlTzpQVFzlR6GruyGgXDdHHxUw8xMdtQ8zupFvp5V7el7Qx/kcfhcV6F
	 S8uHLX7f2feRP+Gm60bPlSTQHq8hx+Uef+zFzcViVZkn5GWlUJqbW3040EiuFZo9sg
	 rXwez/Mly+0HlkBG7ZYvORIQfbENvQGSBM11EbHHo2c4mMzroKLodWB7u1U76CPay2
	 nU3m0kqSg8I5w==
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
Subject: [PATCH v7 23/26] rust: str: test: replace `alloc::format`
Date: Thu, 12 Sep 2024 00:52:59 +0200
Message-ID: <20240911225449.152928-24-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911225449.152928-1-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of tests in str.rs use `format!` to format
strings for comparison, which, internally, creates a new `String`.

In order to prepare for getting rid of Rust's alloc crate, we have to
cut this dependency. Instead, implement `format!` for `CString`.

Note that for userspace tests, `Kmalloc`, which is backing `CString`'s
memory, is just a type alias to `Cmalloc`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/str.rs | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 209ad1bb1a49..726329530338 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -523,7 +523,28 @@ macro_rules! c_str {
 #[cfg(test)]
 mod tests {
     use super::*;
-    use alloc::format;
+
+    struct String(CString);
+
+    impl String {
+        fn from_fmt(args: fmt::Arguments<'_>) -> Self {
+            String(CString::try_from_fmt(args).unwrap())
+        }
+    }
+
+    impl Deref for String {
+        type Target = str;
+
+        fn deref(&self) -> &str {
+            self.0.to_str().unwrap()
+        }
+    }
+
+    macro_rules! format {
+        ($($f:tt)*) => ({
+            &*String::from_fmt(kernel::fmt!($($f)*))
+        })
+    }
 
     const ALL_ASCII_CHARS: &'static str =
         "\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\x08\\x09\\x0a\\x0b\\x0c\\x0d\\x0e\\x0f\
-- 
2.46.0


