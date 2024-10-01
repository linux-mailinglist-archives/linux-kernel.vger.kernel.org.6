Return-Path: <linux-kernel+bounces-346203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5E98C119
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527D21F21C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D571CF28C;
	Tue,  1 Oct 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1xNcO7w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E701CF283;
	Tue,  1 Oct 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794957; cv=none; b=G31OC1qzl2Tajj4qDFUWjLcYtSK4DGyofC0hJSMF29k3+n9X1EpYrRYx2IT8dyqkwKB9TbIu5kI+l3UsqrHBQA98NittnzRJbOjk/YRSAmlK9sUtXUvSzSkxmlQMiv5CnXb7NsoK+1fQL71qjDF3D6vW6xoRCYXTOuGTYHmFTdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794957; c=relaxed/simple;
	bh=rMRoTLbwJY/KNbnwZeqVlUvQeXlcU9VSnqsWXV9nz8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMfwXAt1+NN2ljEeNa6cWjFPNzogY80HhXAT7E2XWwZa1N3b5S7YldPvnXIuAabd3ZUFypmRfV5qAf4BSxUzjxaL2LZPTicXENMn8XUihdXxkezODJZ4JTgp+dGfkDFMFWFhsf4tPtPO5/Q0uayaaHj6/jo8luWYhR52YvYevnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1xNcO7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226F6C4CECD;
	Tue,  1 Oct 2024 15:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794957;
	bh=rMRoTLbwJY/KNbnwZeqVlUvQeXlcU9VSnqsWXV9nz8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1xNcO7wmDj+pX9zXKSF5zGwWUM4O85kJZ5cWPAxgO9+xb910r5UXJlLXxC1BXTUT
	 zzBp0tTw/b1CeJHxrZy8zQ/bdjKcIOnTq8eOvJIpeXw1cMsIqUvNt3L7SIRSn61PTl
	 ULpwj3RBaA4YjI5NczO3MZgxSOju7nslA/iHjIWPgpSrQwMOvY7je1ZvCyoage2RRw
	 DsL33UucQCuqwoMwJtQaQmGtNWSnzyiAGCJPNjlAEeuoZGEE8Di3jHuGZ+YB5HwTSW
	 2uu10sTfzzqUOW5Can8mKlVOL3Q76hTPPjmlVHG5LSSsr9tPb5YkMuuza15LjJbHWB
	 hsHNBft18qx1A==
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
Subject: [PATCH v8 26/29] rust: str: test: replace `alloc::format`
Date: Tue,  1 Oct 2024 17:00:01 +0200
Message-ID: <20241001150008.183102-27-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
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
2.46.1


