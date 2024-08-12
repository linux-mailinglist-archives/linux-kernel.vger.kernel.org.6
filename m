Return-Path: <linux-kernel+bounces-283608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ADF94F6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8916F1C21CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781C619B3C4;
	Mon, 12 Aug 2024 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7jG6z+3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7401922DA;
	Mon, 12 Aug 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487172; cv=none; b=T2W1QiQ7ZvvklgpFyu1sJBfBJFwA1ljLLznmXlzu8VzrPoGUnrJtAC7E1VR3cfnpnuAAL0Je3YsH8xnFxqLD8dTOLovoahl7R46NEjyv1YeH5/abvPsUkzOOcqU5iIuJhxMFzFRf1v/2ZrCV2ov/Y4/rgYMWDr4YBli+dlzUUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487172; c=relaxed/simple;
	bh=SxIIf+SSSfq/ByqB+qb2+RtiJyH5BPK+PFBZGcm3qDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZLMtUTa6KsM4VtqL6skSmMmi8Q/tnTD0SqMEWXA6E2iuTVZO2Chk1kfO23PIwFsX+lwmj1Evv544n8g3Z+8R5pYRXSmJhEwzTlgAlb13Xlu47tFOdIxRL/RFMRZxOM3SUe+WD85kC/lz4lcgP+AhEo2r5UwqH8vZsHXA+KGxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7jG6z+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD867C4AF09;
	Mon, 12 Aug 2024 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487172;
	bh=SxIIf+SSSfq/ByqB+qb2+RtiJyH5BPK+PFBZGcm3qDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7jG6z+3m6ZxFsGXWBawNolBPj9HDFiJ+jJbgWgSYU/Bo/BLz6Pp3ReAsC31yciEI
	 RmHM57eHf3FgMPfF4E0cuk0P3mTZJe1gWJuKYbnyDPUaA04ll0yzwsvXSaCJ3BlBck
	 WyO81o6zRTQMz831jpTuwtl4Jh9LVcLBhNeAGQfpu9rcJHNTSEEJNYF71Go5BM5bX6
	 S2y4NTJ1ealfzYlRIIGKlxwSAwRHoeKbSk1QtVAoFmRDWgr7GXsHjl643pPGylZTW3
	 RFedq47VIXKszDfEcxP1PJkcuDHYtpF7oC2Z4s6hqB/DvMsvDUMO8neVPx1WuCqKbp
	 g1ggCMovo94Pw==
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
Subject: [PATCH v5 23/26] rust: str: test: replace `alloc::format`
Date: Mon, 12 Aug 2024 20:23:09 +0200
Message-ID: <20240812182355.11641-24-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812182355.11641-1-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org>
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
2.45.2


