Return-Path: <linux-kernel+bounces-350677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33797990805
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574B01C21368
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CEC1C7263;
	Fri,  4 Oct 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0SZdVWM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00361C7264;
	Fri,  4 Oct 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056579; cv=none; b=RRchHDUvymavWsAtVV+PK0agTpd8peks1GsAEwmEY2lAiD7GmScPuEuW62HBGODDkEzqhju+6/xxq3EN6DYBhblw/ggZdAvfzVHKQdEl1xgwEips4ZrJUraSzMbOt5FbZKFspQZUftr7xkndwhkqp2twlpNUI//tDM1pVnwuSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056579; c=relaxed/simple;
	bh=k3fbnNVumq3p6Zkau+316hxp1LWKMWboxrOE8MJqOiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoRLd9pGbzjPDGBil9L3KKSpKJ0HDrzw8JLVy/fDD9KJrNyp2JXJhNCgtnQgYGf40ud6zYSU0B9t2ZR5FwFnFIhLlUiT4U0a/jkoFwBT/aCK0wPp0HL0lAuX9AjfRB9gCIhtUmZLGtkGmG8ud83f9guisNM8otDgjtv48uSucQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0SZdVWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA1DC4CEC7;
	Fri,  4 Oct 2024 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056579;
	bh=k3fbnNVumq3p6Zkau+316hxp1LWKMWboxrOE8MJqOiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0SZdVWM49uPjrTKdSFLLtEup1HwgkGeO9v9ZDDnn5aHOC/i/t7QB+rI7DTTt8Uhq
	 QGpzMmjDSv5/Qv/j/7F92bzQpromwD9bU8z7/bweJ/CYCoVL41kbiK/SbygAqIxBqN
	 ibze+ncGEHEUljEJDwBQobzEi4pp4I/Pns6sFjuwbCew0cB3cspYtq0kXvPTFLk78v
	 Aeb6O8+lSbL51Amuo3xpUiptRKKfFv4hWnWZuI711Rj8/Jweg3w+7pIusrhns+Cf39
	 Y6cq0XQxjySmgv72xnyort+/t+OcltdJQA1mHzJ2oDHuSaE7N3SLbHuRI5O+FZnjPk
	 4TnpYuFKDci8A==
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
Subject: [PATCH v9 10/29] rust: alloc: add __GFP_NOWARN to `Flags`
Date: Fri,  4 Oct 2024 17:41:14 +0200
Message-ID: <20241004154149.93856-11-dakr@kernel.org>
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

Some test cases in subsequent patches provoke allocation failures. Add
`__GFP_NOWARN` to enable test cases to silence unpleasant warnings.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/kernel/alloc.rs            | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..a80783fcbe04 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -31,4 +31,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
 const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
+const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index f8ddc8d96da9..97defee1d6a1 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -91,6 +91,11 @@ pub mod flags {
     /// use any filesystem callback.  It is very likely to fail to allocate memory, even for very
     /// small allocations.
     pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
+
+    /// Suppresses allocation failure reports.
+    ///
+    /// This is normally or'd with other flags.
+    pub const __GFP_NOWARN: Flags = Flags(bindings::__GFP_NOWARN);
 }
 
 /// The kernel's [`Allocator`] trait.
-- 
2.46.1


