Return-Path: <linux-kernel+bounces-350690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84AE990813
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717B328C835
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C295221E46;
	Fri,  4 Oct 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPfYaikd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1E1E285B;
	Fri,  4 Oct 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056652; cv=none; b=FSVtwPVDZRgjAJcWrLUKHTnF89npzEa1w8zTQJrkPPawp4PTTcP8FfYLvjCGD8kMcH4A2ZFcQazioF+dHW4Ecn/Tk1bt8IqN8chvqtb95GUQeX4u8rKa5pp2BR/pBt1eT8FHDMb1R1RgpqN2Duo/sYLaG2R+n2K5MOCTghGB5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056652; c=relaxed/simple;
	bh=VajjPpTKjd92I7r04pL25dRwn4WQWZ1yOCCgBSYIXyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp2xEGn6nntzaWgNlzT7UIFT7QvA7GcbkfnAVPk4QDu9K4l22HjBV4J2DRWHefB/qW5JsM771uM93U1tTthiTESNJlRTltWxs8cGd9avR7LgHmd2QXBCJetD9WbupRuBCfvW3QfLz3P3Z2aM9YZGSwqwgW0sciUsbPfHcZycWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPfYaikd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC5DC4CECF;
	Fri,  4 Oct 2024 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056652;
	bh=VajjPpTKjd92I7r04pL25dRwn4WQWZ1yOCCgBSYIXyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPfYaikd0L/Vx+JqKeDTWx4hMoyf5HUOadWTknz+gONqrexWgDlw1ZuDMy1brwY88
	 GtyfW1b2JKLCI1bQN6crBsF7amgUYsB1MNPSbPzIToO8N7xZ1iB+tvWogaPb/pis6E
	 7scY361XwbntTfDE+WcJS9wSd62G0hKmXzmkaiwFcfelOZfj16trTfEETlcaW6nxSt
	 pi2ABhYIO9QggEAtYzZheUDGuPHsVMqacsseRUGKmHuUhUtOIwS4Vh+jS+0AujyAo+
	 JR8dVh76tKj5pcblkzaTkc2uvj6D97PC3eLEf5hAmjPyZjlN9YJTXlwMcQQvmjWyMf
	 P/hOEN+8Mty6Q==
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
Subject: [PATCH v9 23/29] rust: error: check for config `test` in `Error::name`
Date: Fri,  4 Oct 2024 17:41:27 +0200
Message-ID: <20241004154149.93856-24-dakr@kernel.org>
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
index ca957bd262df..99d505cd5ae1 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -142,7 +142,7 @@ pub fn to_ptr<T>(self) -> *mut T {
     }
 
     /// Returns a string representing the error, if one exists.
-    #[cfg(not(testlib))]
+    #[cfg(not(any(test, testlib)))]
     pub fn name(&self) -> Option<&'static CStr> {
         // SAFETY: Just an FFI call, there are no extra safety requirements.
         let ptr = unsafe { bindings::errname(-self.0) };
@@ -159,7 +159,7 @@ pub fn name(&self) -> Option<&'static CStr> {
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


