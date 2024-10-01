Return-Path: <linux-kernel+bounces-346200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08298C114
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF31B26018
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334C21CEABA;
	Tue,  1 Oct 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+vqwI38"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DEA1C5782;
	Tue,  1 Oct 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794941; cv=none; b=MDBvepvQldO0BNxrsMGYyTWDpHp3Sx1F4sV05lV1lJeZ8sL8AEKmIU5l3a3N8f5QFOj1Na7YwFVGz5yPQn6nAU43QZi1gvPtHNHQlasjYDQtbQdZs94jkyHVVBd1PVGfJjYKODX1QoP2tGitYeD7w+OTJM10UQ5l+LebPIXryQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794941; c=relaxed/simple;
	bh=dcNxqKnnFz5ev8owV03l67WWJcIeV+zuTzyuxUVGedE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueSedhmWRVwFz24tFlWOFRV7fiP1oT5lA/KuPsGYcjNAFLviMjx/q/e2hf/LzyrswQYCxufoAQbGao6iEYKHUZGdnVe2lA0rtxpp8WtgD6VEEwK4H1Vz69l+5MsK7LrmB5fqwkxrGest9Zz/0HWveThEx7ZGOFywjsglee6pR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+vqwI38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144C8C4CECF;
	Tue,  1 Oct 2024 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794941;
	bh=dcNxqKnnFz5ev8owV03l67WWJcIeV+zuTzyuxUVGedE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+vqwI38aUi+XTqVQgdXynPd4BENIOD2o+SC8pUH/21gcJ38Nb+gJ9Plsd8r5vgwV
	 Kn9kpo72MOUkdbIXgIZpJ3qQBORhhLeLArsAJuKam4covn0BAwwsqH05GicpaVFNw1
	 2GFtDg/GWK84pE3pbS0ECn8byzZ7dGOcM5cO807Ydx84gCrZxp9MCv+mD9H1gFflk4
	 v4HuwvDxJvtwbjAHu05uNovXhcR0jTBp89Gt6/gzW8KaCOS3nxpF/SVzoCrOoUSd5h
	 IasB3eCjPkSosJoVIiaxIMMoV4bg2+ML4Pefbxkv75mwlHgMDpaPO0cLzGsHJplbe6
	 Jvzs4ivfCAKtQ==
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
Subject: [PATCH v8 23/29] rust: error: check for config `test` in `Error::name`
Date: Tue,  1 Oct 2024 16:59:58 +0200
Message-ID: <20241001150008.183102-24-dakr@kernel.org>
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

Additional to `testlib` also check for `test` in `Error::name`. This is
required by a subsequent patch that (indirectly) uses `Error` in test
cases.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
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
2.46.1


