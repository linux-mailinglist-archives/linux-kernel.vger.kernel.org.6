Return-Path: <linux-kernel+bounces-568765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354DDA69A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF191B61DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92E221507C;
	Wed, 19 Mar 2025 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piiCKYLA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222871EC013;
	Wed, 19 Mar 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416505; cv=none; b=Wmq9pNbN3XFxAWqHJEmO9Jz+VTTPhkm9FU8a10zDOwb0y4BkYfHTe3/QUI/ol8Z0mHMhiFmY/RJkU1ILraZatcJcSAWfuQSBg88LtoInRlz2nhwZ0zm3U1LlDwg7RrPXtMLera5tAtfaEBLhvzme7yV9FfeqT2zxz/h7D2OJ7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416505; c=relaxed/simple;
	bh=p+JzsKxEduL9/McaTlczwZmdMpIxti9MNodikeaTpCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNHHE8CfTuMMlJfVOLR2bEvHUfl1u5+SImiAElWnwjufcCgZHsTGlC3uZdapE4w00jIZwJxe9aYi5tErzhnCTl/KnazmRGXg/ULWeE73t/79qsMSx4OJvFXeE8fCnKyyqmWSNBGw1YYWu6+Vn0dwFw1vsfbutOtWCKuuItrgIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piiCKYLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC42C4CEEA;
	Wed, 19 Mar 2025 20:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416504;
	bh=p+JzsKxEduL9/McaTlczwZmdMpIxti9MNodikeaTpCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=piiCKYLAoPZay/O2lCRAJ1F1jcxQeKqCBVS4IQ8nl+9HxElBNKeeF1NAoOSmTVF5x
	 kdezQBl/HuWsO0A+fApsnAi4SQ9+BfObMsRup98lFV1zxZAyWB5B/dqQ1guJbACu+v
	 Gldi3g6b0Y8GB3c9YsVXSxfX08npDXqBSpWVftFVxGAKU/3lYKtWHpXp4H6ygxNA8N
	 U7DDh9+Mcc2yLx6SjSwivjdaSIBVXgoaDUzV77ObnxbPnT1Nhdc0TY1GxtAyR3GwEt
	 LuVdlNrapESdKWCzkgTAcuma23EznMHj8YkMmk0yCCluoX35hzyWogxA4me7go4zh/
	 8dwftjvCX8uBg==
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
Subject: [PATCH v3 1/5] rust: types: add `Opaque::zeroed`
Date: Wed, 19 Mar 2025 21:33:53 +0100
Message-ID: <20250319203455.132539-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319203455.132539-1-dakr@kernel.org>
References: <20250319203455.132539-1-dakr@kernel.org>
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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


