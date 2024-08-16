Return-Path: <linux-kernel+bounces-288755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFCC953E32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA5A288CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF3284A5E;
	Fri, 16 Aug 2024 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDFzCKig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FD84A2B;
	Fri, 16 Aug 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767251; cv=none; b=OGkpehezur/7va6HGjy+2pnWLHbzGDPa/aeOKb6uCzIg71b81LOQQfdeO8VhDBwFCT537RgGmuSi0eC+eQIq29Zs8mjlx7OAcvkBa0ezWn7CWCZyvHZ6ivD1JgztQMlYo0CMSfFzR649BWgClXvyZhaIpIOpIYG10+lvqvk/fvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767251; c=relaxed/simple;
	bh=2JZ/HPYqMBMv9V3VcU7sSwUGHcVU2KFw93XwDqoGeDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5hmT4FX2Rk7v/J1V7HGQk3M0o+8KC9xOdqwZcwVVd1QO+LfCF2PMR0xC4Kq7uYK9nK3v8Ck2l5inwa0aP74Iv49sG3GfCG7mY7BNknZCqSMGhI0eZ42iQuwP9MaCoK5/0R2DlAqhbAm0VrZA7kpEqbHj1abjE9CXeqHQMiuCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDFzCKig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7733DC4AF0F;
	Fri, 16 Aug 2024 00:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767251;
	bh=2JZ/HPYqMBMv9V3VcU7sSwUGHcVU2KFw93XwDqoGeDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDFzCKigmPq8S5g5JjHxUVJaiXQcpcx6LPz0k+Mik2iTPq7nOt3vh/1QYBTXXd3Xn
	 TFg6vqur3nJzb+OvP8mOVgmWqylFXdn9K/0kEiyGSLFfkMq1AsBcYjhXtpYY9cz0cJ
	 5s4xn9tMnpGQinwPfZKPb3Sru19j59yWh2dUn31cNU9NU2xUQYRZZMhsYjEPtVBIJq
	 J2l3066gtvSBLWXDcMx8w2WRtnRHqDEGXfU+xS1462CaNEfWeH6XmBN6O5BslF6Dfh
	 bR8G2mU7+WRzSYLV3JjCX6qIG1aJ87CMXghyr/+ahsBm10J0y67ifwe4LB2sgcr1eb
	 fDA8jt6ZJSr/g==
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
Subject: [PATCH v6 20/26] rust: error: check for config `test` in `Error::name`
Date: Fri, 16 Aug 2024 02:11:02 +0200
Message-ID: <20240816001216.26575-21-dakr@kernel.org>
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
2.46.0


