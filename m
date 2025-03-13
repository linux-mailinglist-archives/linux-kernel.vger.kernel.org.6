Return-Path: <linux-kernel+bounces-558714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04B6A5E9EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AAE177BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6374213AA3E;
	Thu, 13 Mar 2025 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj6QqrYh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B3747F;
	Thu, 13 Mar 2025 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832710; cv=none; b=WWmFXcmTWivdlulltPh3rOR3XLAcyd3vnrcuEmRdtbfmiBDnfFjMOhnD1DOQudDMOHgZCyvdHDKaopGqvYOoaGvJpdtwiZGTElVNEAQDU+5zGFymFdibZ1rJ0ht6H55I4lcHCnq+OaWUjsbYVIeYuUXL8FDA4/TusQ+fwxFfdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832710; c=relaxed/simple;
	bh=wKnEotyoBRZGC7QY5ZaBo6U4Ja9/wBUlJsJ/h76VflY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wswde7Y8EdfefdIeZpV0BhUzUep7OYaWpgB/kSLv0al3oJNCXhGNg1031rX5RkBs/MgP/mq9I5qAp91oApXn6FfRs1Mrl0uW/Sxz+48NPPqnwojJbL4ntptzSYbedIXi/yqgVWjjzu5DzvF+lOD0B7RfurVRwalQdZ8gCi2p04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj6QqrYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418BEC4CEED;
	Thu, 13 Mar 2025 02:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741832710;
	bh=wKnEotyoBRZGC7QY5ZaBo6U4Ja9/wBUlJsJ/h76VflY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nj6QqrYhS2bHFf32PDYks/O/1YJvw0TCdaj2AkgND0U7TL6O3ellsi+F5LaAh6RD0
	 frfVLmZAsRyDVwSGkxeXFDrs5lyQr5NX8YneilLb0yumq7jk+RaZHmfVo9NkSxQbaE
	 mOBU+yDEFI4Nk0aKlt3jao1cJYpnkS+3aukmeaMwGE1Gh0Gkszlw+76E7DSU/Ydzdo
	 lVvDPUwZETUP/HSe8n4a1k38r7dKXtjjr6WPF+mVAYt2jZZ8sP85eAaoQxLjN3Wt6V
	 rNd60ONNQCLvyAapIM8hDOCnNGyFX5XjYWyAtekNhAY1t/hsRfWW4ioNodHV7Rcdta
	 i6kRywp2tEMpg==
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
Subject: [PATCH v2 1/4] rust: types: add `Opaque::zeroed`
Date: Thu, 13 Mar 2025 03:23:50 +0100
Message-ID: <20250313022454.147118-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313022454.147118-1-dakr@kernel.org>
References: <20250313022454.147118-1-dakr@kernel.org>
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


