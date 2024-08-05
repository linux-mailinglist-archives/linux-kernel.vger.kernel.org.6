Return-Path: <linux-kernel+bounces-274895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152DC947DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465E41C20D43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C30416D9A6;
	Mon,  5 Aug 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEmVFRkO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32B16D32C;
	Mon,  5 Aug 2024 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871341; cv=none; b=IAlrrlGsNKDVsKDaeLL2v08jaTUnod4+69Enir0bdl7XF8oH4DhXJv1vj1wv9l4v/8dmeVaADDhWmRdGs6fkV2VyFfUBFadwNb7DS4uiQHRX3qkttRpiufOBufWh/P64GVN317zSgCr9mcCoUSIn1KCZ73pPGrM9C9PGhTVD3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871341; c=relaxed/simple;
	bh=EhvuU5VnVA5zmjTNVXg5lAn5aUpDsOgozY6sKUH/Zyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0YIYK9/rn0HuKv8GLgjhIvF0ReBPMAPI7Q0ahQ8WyIcb9DgraqlrRRqe5AD7qjWi2aBjG3awuKDezB1svNuoBZYG9sCN0QccWjo3tp9Dzf390DDXpvaP2vKdQ4TbbGvV2smLbHTuEgIRY0tvFfeMu70+eZCc/zOqCrH9rbGK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEmVFRkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B82C32782;
	Mon,  5 Aug 2024 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871341;
	bh=EhvuU5VnVA5zmjTNVXg5lAn5aUpDsOgozY6sKUH/Zyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEmVFRkOg+K1zHXflqDDLqMsFN5JV8HF2isrn3XG9SHLQENzOcT1gsu+4+g9o/IzO
	 i1NcdMbFG58zjVRkRc8yw/6WVmKfBbia9zg9ZCiJXfUuQ3LyVj5VN/oa0PoAO1m01I
	 MvEgr/p5ZsWrWwkny74Vk6sUqDTVENSSe4P7kEvbpyZHeukri9Abj45hY5u8CkXoCh
	 aN2L+tN6VhYoOARZWnKwC/hxOobR4fqHcZaFq4TnhdsVuma4wHYELV1bVW+P3pV54S
	 mAJX732Y/F1kZcbxCvivOKl4QFC3ef7HJjrVY4T7QgWrZtHUOWkFlOz0riRnp+tfdU
	 3D1Tn2ABbHY+A==
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
Subject: [PATCH v4 23/28] rust: error: check for config `test` in `Error::name`
Date: Mon,  5 Aug 2024 17:19:42 +0200
Message-ID: <20240805152004.5039-24-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Additional to `testlib` also check for `test` in `Error::name`. This is
required by a subsequent patch that (indirectly) uses `Èrror` in test
cases.

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


