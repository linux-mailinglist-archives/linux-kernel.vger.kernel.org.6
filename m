Return-Path: <linux-kernel+bounces-350694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE999081B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA751F22C85
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1FA1E32AD;
	Fri,  4 Oct 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnNeEXxR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C52225D1;
	Fri,  4 Oct 2024 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056668; cv=none; b=H8picMCv5P3pxVrCafWh/AzsQMUnfPeAmb0O3oLxqqXVxG8ZqCitbkiKtVYC3w8ZVHrf0vUM6geczK+eUKvJia30kXQQ+UVmddgh+8dEXbB63wgldkasxXuGXhFNSKdhg+EbjjAU/gbzNufNeJaiPcGZfxn7vJaV+nbx2xhcGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056668; c=relaxed/simple;
	bh=+flMXZQfIhSSa3rmdG7sm/b2ESf50jZzxj0uBuhzVdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG8uaM2eMtI/ei2DaeEVmh7iAulPePLPirUMTS1QiVvMvazLNiYirqRbtH79/jRUdEuz0p3OOyy0neJGj7K7yTvjoTOZOaKkr4IvjTTH1wBMfdaHq7ZS1C3hAcCFUn2EsVJJugaQY2t8pP++Fgn7M1Oyd0m/B/z1ZQGGtqnhisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnNeEXxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C23C4CEC7;
	Fri,  4 Oct 2024 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056668;
	bh=+flMXZQfIhSSa3rmdG7sm/b2ESf50jZzxj0uBuhzVdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fnNeEXxR7mvP92yIfBbZLKQgeMPUx20LLtjjEtRpZbG5b21h9I1Q266YhULU7we5G
	 nIKnt7Ig2nVe5gPYYo/WacZZO+8P/BkpLtAFIfmf5m6S5lMNkXsZJ4yTPSmqgK7scw
	 /kUUR7mXbJJ8XXO3LP2dNem62eLLl2KpL1XH3Xle8t6v18Drlsi691bL1jeRJWyQR7
	 4cxmM1JClD1M0QJ2FXgsJ/ZrZEQRzaQYn9D+5MrpBEY9ABXsinpdgYKX9rn2EjyRUz
	 pNO82/M6amgupFvVov/hqqXNHS/+rEi1aMJOiy/7d+sQYdu0oHywrQ7+1ynfWF9luu
	 TmZWjk4vJOhrA==
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
Subject: [PATCH v9 26/29] rust: str: test: replace `alloc::format`
Date: Fri,  4 Oct 2024 17:41:30 +0200
Message-ID: <20241004154149.93856-27-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
References: <20241004154149.93856-1-dakr@kernel.org>
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
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/str.rs | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6053bc7a98d1..aff6baa521d4 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -524,7 +524,28 @@ macro_rules! c_str {
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
2.46.1


