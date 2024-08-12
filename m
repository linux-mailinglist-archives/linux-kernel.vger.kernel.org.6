Return-Path: <linux-kernel+bounces-283605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8DF94F6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA991C21D92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825B7194A53;
	Mon, 12 Aug 2024 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6j+mJpZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F519414A;
	Mon, 12 Aug 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487156; cv=none; b=aA83sOuroVU2wab47mbF64Yp+RxovU4aIV4VzuXFiDfi48tARw3NxgN/XSTv7gTtPvQd29nuhYBsN1oNK6sKV8Zz7pzcIHCzrdKBuPheXcD7U+6EfTspLBw9G9D0luC31d4ZgUVGYB+oliPtiAtVMKUy8DrWp2eV02EaTv/zA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487156; c=relaxed/simple;
	bh=2F6Eq8ZEErgwGsu4sxTQuCutTP6qKEaQ1vvV8Sy7t1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfKS5vrz+nLJ/WcqmGhxT1y/jtE+I8ww+p12aKPbsd/dF/f02Oz1qJ2KXpF6cyUro4rb/ChTnoICq4PPWyz0c6zuJcBHcTdvn6ETxtbRFvVQyOYdMgzgb4sAFWad7dC9Fp9Svugwa5jAN5xBT7HF4xGKPhBbH6PRAna0roQjti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6j+mJpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5DDC4AF09;
	Mon, 12 Aug 2024 18:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487156;
	bh=2F6Eq8ZEErgwGsu4sxTQuCutTP6qKEaQ1vvV8Sy7t1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6j+mJpZtX+GQyemhh1YN3z+WuLKkO07HkID9hB60cEgOmMMs5DJr4cHKl1pgGPeR
	 2zIpFnJHzziufgeTVg+xA5uce22bQeLWbfLDPV5oiSEq+SNKklaaVdlEROb6c81rIQ
	 Q8CDN418goWJaq0ttWBuLX4VyQ7c24iY7eQ9d+3oJ7Gp9lREGXADM9jAIKJ3qTMJq4
	 eV4yUFZsIj6KTKDzj/3ZaX3CItDMBhnlUIwrWi7BQ819hVr6+KgPLw13G5v6DLQ6K8
	 tTVj59KMhsXhTZd8JhgIDl+XQxhKQiN4I+WuM2Eg0yLzJBA4rY+drE+cbFM0avdu4N
	 sSJ85j4Uw23OQ==
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
Subject: [PATCH v5 20/26] rust: error: check for config `test` in `Error::name`
Date: Mon, 12 Aug 2024 20:23:06 +0200
Message-ID: <20240812182355.11641-21-dakr@kernel.org>
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

Additional to `testlib` also check for `test` in `Error::name`. This is
required by a subsequent patch that (indirectly) uses `Error` in test
cases.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/error.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 2d012cc3881a..7adf889b9526 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -140,7 +140,7 @@ pub(crate) fn to_ptr<T>(self) -> *mut T {
     }
 
     /// Returns a string representing the error, if one exists.
-    #[cfg(not(testlib))]
+    #[cfg(not(any(test, testlib)))]
     pub fn name(&self) -> Option<&'static CStr> {
         // SAFETY: Just an FFI call, there are no extra safety requirements.
         let ptr = unsafe { bindings::errname(-self.0) };
@@ -157,7 +157,7 @@ pub fn name(&self) -> Option<&'static CStr> {
     /// When `testlib` is configured, this always returns `None` to avoid the dependency on a
     /// kernel function so that tests that use this (e.g., by calling [`Result::unwrap`]) can still
     /// run in userspace.
-    #[cfg(testlib)]
+    #[cfg(any(test, testlib))]
     pub fn name(&self) -> Option<&'static CStr> {
         None
     }
-- 
2.45.2


