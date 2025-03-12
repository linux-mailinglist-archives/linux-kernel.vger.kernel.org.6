Return-Path: <linux-kernel+bounces-557103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824FA5D3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAD118996B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB15986323;
	Wed, 12 Mar 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP2xP6FE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C33182D7;
	Wed, 12 Mar 2025 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741739282; cv=none; b=IOlsXGl12leptbwedeIEbRAuWVnv8InzL87uz/lSrdP8ageXbs9euQBvQP9wtY7ictEI1Xz+Kgsod9YezJAi2nzlJqRZcWpMPIbEb0IcgrF/qOPymu1jaueVa+dvq1K49f+RTECVPJuQamDjpse9bTvk0LIyS61bQLvJ2Gw6ZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741739282; c=relaxed/simple;
	bh=wKnEotyoBRZGC7QY5ZaBo6U4Ja9/wBUlJsJ/h76VflY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJLqExFKjZFBbvaCWUyxg4xcD2KJuO9cWu78FB5lJFi5TpYpkOGEwOLYdaHROrKvoygvE96T+5RpyGtTZ4ckO/66LEpG8PHYYUxsF2o4UAfKhab6Ree7hNhtSrBFULryEZnZNZYqki7zCCSKlqsEQQckuBnuYO6bKt5PQpR66zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP2xP6FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E4C4CEF0;
	Wed, 12 Mar 2025 00:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741739281;
	bh=wKnEotyoBRZGC7QY5ZaBo6U4Ja9/wBUlJsJ/h76VflY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CP2xP6FEjqAt+FyA8yYLAi8jRtlJirdojff/juCnxpYb/gs1Y8lGLpuGHsoLig8nr
	 pLszn+JR+fJGePgi4EHdSd6DLkNNRFwBbfv+pSK/Z9BjWCxORvSjREKKmvaX10qvj3
	 VYGyHSyONbXlwySsOzyJDg1AcgignLD6/Tz+OuLKeyCvq2GAgrLxlKeS/BZx0HBNGw
	 7tm+6nZppyuP7eXZOEm9IiWh7726KOAORBLCYUSc4R65wbX0pA8L2up6eK0zHJzkAI
	 9EQ32qozo0fSD06JcsvOqZR/PQnAzeATwFMhy2VMhbKB6g+GTlZUVkOToxCnQMTfto
	 u/xvEqFu1Mhvw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	airlied@gmail.com,
	acourbot@nvidia.com,
	jhubbard@nvidia.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/4] rust: types: add `Opaque::zeroed`
Date: Wed, 12 Mar 2025 01:19:07 +0100
Message-ID: <20250312002741.453350-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312002741.453350-1-dakr@kernel.org>
References: <20250312002741.453350-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Analogous to `Opaque::uninit` add `Opaque::zeroed`, which sets the
corresponding memory to zero. In contrast to `Opaque::uninit`, the
corresponding value, depending on its type, may be initialized.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/types.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2bbaab83b9d6..f5e7fed903a7 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -326,6 +326,14 @@ pub const fn uninit() -> Self {
         }
     }
 
+    /// Creates a new zeroed opaque value.
+    pub const fn zeroed() -> Self {
+        Self {
+            value: UnsafeCell::new(MaybeUninit::zeroed()),
+            _pin: PhantomPinned,
+        }
+    }
+
     /// Create an opaque pin-initializer from the given pin-initializer.
     pub fn pin_init(slot: impl PinInit<T>) -> impl PinInit<Self> {
         Self::ffi_init(|ptr: *mut T| {
-- 
2.48.1


