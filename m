Return-Path: <linux-kernel+bounces-288758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F451953E36
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DAF1F24706
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150AB4A0A;
	Fri, 16 Aug 2024 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExCVsShO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2CA2F3E;
	Fri, 16 Aug 2024 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767267; cv=none; b=YJ6pFhSjcashG9Lc5/b83CLwf3nI6RtcxRDIuBHl2wRGsb+c7VLIUfuf2h64MNxVo8uht/Hib/SyXQK40HpwpCDPrn6N28VOZdOsAUIeOQLfdH8ivZCEQHo/cMyUGJVyW8mSQ4xpiAxHhfWDV2t8djRzjTfztNMpiw++duf0w24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767267; c=relaxed/simple;
	bh=byWvg3/QTModmmEnrau3RUl54V9uowntF04isjcbzmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC0NG5M9XfI/9N4IGQCiUvwevI826gBtJKGKasjhlg/n9DeLE74uKcTwFPSbrUBI8cyFH3suUQkD3md0lTC5HkIhhkE7CgyYxj9q2roMH+Xw21U8yeRxmrY4nLSX9faVmqatvF9DVvM3iQtr+ow1ghbe+TyradOrK0ppwlXjeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExCVsShO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631C6C32786;
	Fri, 16 Aug 2024 00:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767267;
	bh=byWvg3/QTModmmEnrau3RUl54V9uowntF04isjcbzmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExCVsShOu+MJYyYdh3Bouvz6RbIOq9x/nfwsjA+xfaTBafsQ/7F1iqdP1l+TX/Yjg
	 65XXWKpcYDzhdg1TpyB2x8z+mDg9uGx0raYVemR9FrzpnNnUYDQx23BL9hGzvaUkTA
	 xfdhGCS//QauVuv56XjPoHXcjgfzT6pkP2WvovLYzPo8yr1x0Xx+E9LcXJa8edt91d
	 UtWk4DypRH1l6gRpe22mvohkuJ6xdwEEsCVLsTGE04coDgZgWtyHHLzAIZFxu60pGL
	 EA7QkBvas09Pq57lxKs53sOQYzML5eG0QRVC2pE5u6wuRvw4Iknw3DUEvAtsfHcERA
	 7mqZ2lz96lK9g==
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
Subject: [PATCH v6 23/26] rust: str: test: replace `alloc::format`
Date: Fri, 16 Aug 2024 02:11:05 +0200
Message-ID: <20240816001216.26575-24-dakr@kernel.org>
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

The current implementation of tests in str.rs use `format!` to format
strings for comparison, which, internally, creates a new `String`.

In order to prepare for getting rid of Rust's alloc crate, we have to
cut this dependency. Instead, implement `format!` for `CString`.

Note that for userspace tests, `Kmalloc`, which is backing `CString`'s
memory, is just a type alias to `Cmalloc`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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


