Return-Path: <linux-kernel+bounces-325727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9798975D85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B070A2826FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E461BFE1F;
	Wed, 11 Sep 2024 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlamu4iR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA01BBBD7;
	Wed, 11 Sep 2024 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095407; cv=none; b=hJ1EKKI8Axi6U5wDwDGjlAiH+83Dfs9d/dg0OL/RWROqhAAipKP2r/8FSPfOHgGqq8Nktm5dq98lYzNJ9XlrRzrqa4dQT4q/qgh4HAuP99CwgFdF3CXxDc47vD0KEX0lM2fpvGgtxYSCuTTjuTY5OXMBGeeKQtcz4xGM+8cv1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095407; c=relaxed/simple;
	bh=F2SiwlBtvDarApJOsx0M5Yh8m55DamKxmrKOHUpHf/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQSuMynM4uk+AHPW7uxkdk1hr/kluS9LvsIARyPOzQ8eIO+hTrW/mng6MCwJjCg9GWnYgeNwpbTpeFVDNu6UqZKOTzw34/7Hg2BVxiLG3R/PMMcIee43M0h/cljfSx0QK1J+kM3xGirP0v73QREm7fd//eNm9oS9yOaGr4iLftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlamu4iR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EDDC4CECD;
	Wed, 11 Sep 2024 22:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095407;
	bh=F2SiwlBtvDarApJOsx0M5Yh8m55DamKxmrKOHUpHf/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hlamu4iRv8xXSCkHAmar3KUNSPO3lkPYrPcPHu4IrAsbykCYVQpH0HcvRJJRZ0DHz
	 XKpcM0mxEYFkl5S5WNATEcoL7Xs/iePmQhT1297x1nCybn3BwHGf9F8MwGHo1tF/re
	 jyta5/E9VxSboNN95jYSIk5Krd7cpYjbyH+ePtE8st+cbUKNNS0G7EBY91R3VXZDou
	 lt4MjcfAfxT2vFOVb5ZZaCHOvI5mp/oVMw5lME9XhehHaThcjPHWBshnWqF+FvwLUL
	 zGZpYuNdVNupA6fpDQh6MD3xpcFe03UbJdkstToGDU7BpmtfXiTsnv2BjmKcVnv7f8
	 zi2EzgqaloJFA==
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
Subject: [PATCH v7 20/26] rust: error: check for config `test` in `Error::name`
Date: Thu, 12 Sep 2024 00:52:56 +0200
Message-ID: <20240911225449.152928-21-dakr@kernel.org>
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

Additional to `testlib` also check for `test` in `Error::name`. This is
required by a subsequent patch that (indirectly) uses `Error` in test
cases.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/error.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 81b4fc5cf21e..b71fdd0f54c2 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -143,7 +143,7 @@ pub(crate) fn to_ptr<T>(self) -> *mut T {
     }
 
     /// Returns a string representing the error, if one exists.
-    #[cfg(not(testlib))]
+    #[cfg(not(any(test, testlib)))]
     pub fn name(&self) -> Option<&'static CStr> {
         // SAFETY: Just an FFI call, there are no extra safety requirements.
         let ptr = unsafe { bindings::errname(-self.0) };
@@ -160,7 +160,7 @@ pub fn name(&self) -> Option<&'static CStr> {
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


