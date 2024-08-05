Return-Path: <linux-kernel+bounces-274899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5742947E01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB7C284E44
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F3A16F851;
	Mon,  5 Aug 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc9cVv7E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45516F824;
	Mon,  5 Aug 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871358; cv=none; b=ipH8E5tJXatWNv8/zpWR/kszwc9SzTH2nXrQS7ZrFg+Lb3pIAyes9a2mxvlvR2MrCgyR/KdCFE9iLJDqRRA+a7lzmdB96va1eCr9mS16FqpcrAuYzhG2NWFcC6VJGWCQOBtnuJ2r0uau6Ylqc7yf+Kr7VSXghoutawIt8GB3a3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871358; c=relaxed/simple;
	bh=6dLN6QohX0ktcU4cWe7TRCkIGusnQOXkZAPpBQ1FLWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wdh4ouv4kY4sMU1GTXe5IRBkoiyHR35mSqGriHGRe3rC+OX3ZnnvosXWGqZS7OwL9Kh2EIuqFNPgeqonhLM+DPkHJzgkhwJPB18O6C0XviIVCHi2NNFueySa07Wo4cNgKqyED+BNYsVI7/LV339vMpAOS09MGy+ZrxupZHXL9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc9cVv7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE08AC32782;
	Mon,  5 Aug 2024 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871358;
	bh=6dLN6QohX0ktcU4cWe7TRCkIGusnQOXkZAPpBQ1FLWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uc9cVv7EEGEFQxjC4dwhg3zVwyiZ6SxOToMFUCRbQVqM16pUaXc+fZlyaIuu7Frtu
	 NDJPcUyyZsri9m6uxCaouTJDUyTn+TWuVOk9yGLqOPI8Hv8+Fz9y0bT5pvkaO4Q92u
	 N6maC4dN3Y+PW6mixAbH4phOt+o6zomDCYBcUaUyQc0VZI+BuzVDShLPiaoTLNIxPA
	 ADzFXCXhJEV/3uBxq0mK01Cm43A4x58uvAMs0f0RqRGngixezRZG+Ib22n4Q1Wfstm
	 4L0sh3jjULPRSEozDeAdICVRsE9LtDVeLSGocoEd0pjyL+E/2FdsA88HTkU86M33oG
	 oXaa/CY92g80g==
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
Subject: [PATCH v4 26/28] rust: str: test: replace `alloc::format`
Date: Mon,  5 Aug 2024 17:19:45 +0200
Message-ID: <20240805152004.5039-27-dakr@kernel.org>
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

The current implementation of tests in str.rs use `format!` to format
strings for comparison, which, internally, creates a new `String`.

In order to prepare for getting rid of Rust's alloc crate, we have to
cut this dependency. Instead, implement `format!` for `CString`.

Note that for userspace tests, `Kmalloc`, which is backing `CString`'s
memory, is just a type alias to `Cmalloc`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/str.rs | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 0b6ffbade521..8f234224cbf5 100644
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
2.45.2


