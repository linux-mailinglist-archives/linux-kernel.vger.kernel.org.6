Return-Path: <linux-kernel+bounces-346191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E521A98C108
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A2EB20CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4830E1CCB56;
	Tue,  1 Oct 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzjWXBk4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590A1CCB4A;
	Tue,  1 Oct 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794892; cv=none; b=MVmgC8tlKnsMdqQFtHoLH4cgUSKK1SpW9yraVPPclWPM0qVop77wSkqA/xmbcqczJ0m1Hrze7nicMksgkmSKVvgqCiXBQ80RzOBv3nTuaqnh24q5j0mGHOAyxwu49VAt5L4KmA/qbDWVeOdma+3jAsyJfpf1Nd/gwOyQlX4R9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794892; c=relaxed/simple;
	bh=83eAnIr1D5O9vSM1uHBUzB+eFQ2uxXd/+rUZl+c6k2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzhj9kacQM8LPFP62FHkC6duWL4R8mAupFB7KcG2yQYUEZI3c7ACW0sAErxfPtNg0I6RN5A2Phj3AGy6fYKd4fq1N70lS/FTVNulZDBPgWabRUCHWn/3z7RFCkieG0nSqrJkWmyKctJysfwHEL9BLd/IFthMmbWv0NpiQGc1qMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzjWXBk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25B2C4CEC6;
	Tue,  1 Oct 2024 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794892;
	bh=83eAnIr1D5O9vSM1uHBUzB+eFQ2uxXd/+rUZl+c6k2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzjWXBk4vQneZyy/BjBLIim5d7KxHk36k2ryWrmaJJ/F6O9n8xp7Aieu8M3ZuEDe8
	 klTebPqsb+t4fEBdrdr1WqOR2SZtTB0qYJBwJZHT49UoShqrYC74vS5RTr1iJ6mnCo
	 Cy2xNgeFsNPnn5EKfR2Cjxq4/3EFuDFXAL8N//ZAY83r7hd1HtZMOuXuwGA9wX1V2N
	 OkwUkpeIluaq7tnDsSpSh2X24hAxzhJ/2/QfxqUzsnyBVIVKkveltPvdGIlMaACgrp
	 vQCiKfN0PL0URFWoD5gF8w8aIFG8+7Xji1HUcRSr9JajIGPiSuVAQTCA7MxFqZin3s
	 UXqoqOE8rcM/g==
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
Subject: [PATCH v8 14/29] rust: alloc: add `Box` to prelude
Date: Tue,  1 Oct 2024 16:59:49 +0200
Message-ID: <20241001150008.183102-15-dakr@kernel.org>
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

Now that we removed `BoxExt` and the corresponding includes in
prelude.rs, add the new kernel `Box` type instead.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/prelude.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index c1f8e5c832e2..d5f2fe42d093 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
+pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, VBox};
 
 #[doc(no_inline)]
 pub use alloc::vec::Vec;
-- 
2.46.1


