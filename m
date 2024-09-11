Return-Path: <linux-kernel+bounces-325725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58790975D83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CA8281769
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601951BFDEB;
	Wed, 11 Sep 2024 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXYbBBOq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017C1BB6BE;
	Wed, 11 Sep 2024 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095396; cv=none; b=K1WWKVaUgLdu/dFXCTlf6EhNTKLCI5NquXUBEaz6e0U54ll8BsVeBPk7/eqw13v+bKEf7EMIgX1cjDhF6vhiUeP2mIoC5aJ2jX6TrIj5DFuXOttZE6/nPtYxCKom0R+ikTY3WMX8CZpbtnCKnvSn1xqraGF4Aies9FfjYbiHqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095396; c=relaxed/simple;
	bh=LpXBgctNj+tjXHis1qyn9ZWQx0pllgQA+Wvf8FmkV/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcDNtFUUE87+rzgMoO3vXt2yGiBArt5WVUs6EBONFS+zHExbabH/fkorHRWblI2vZKhdmy2OuO+ZWawyGW09YwmpNrYaBu1OISgJXbVKCOl2MIpIOtYE9yqnyccqNDPo5wUkjmS/OOz6FTp6jQjYEJhH/C26eugE/I7bvGkDyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXYbBBOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FF2C4CEC5;
	Wed, 11 Sep 2024 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095396;
	bh=LpXBgctNj+tjXHis1qyn9ZWQx0pllgQA+Wvf8FmkV/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXYbBBOqTcZi/ck3nmSLuIo/cm3vH9ZCqqGY7cMR6byy9TvrFUZF9Ko0BLAU0XK5n
	 IQcydTIGaCpDd1VdWShtJHNIhuSKbBiu8fZmbLNPk5V1FstGPSiHU4mlPiZoudj+Ar
	 PQl5lIHYYx6DN9XopMPbbPArq5yaSmpw8e5IZ2fxZOyDV03qYVJXOkOnSQ34Apk2Yr
	 hjSWUuaP4yKr8zeAshhWErn5eS5YnndvNZIaAYFOQQvXLhap2aMHNHVfcDtaJG21zB
	 rXWNnxDqHjf/D33ZosFzBveNXrQC+Lla5IZg1w4nNUswcNQSYDii1X8IXBQYZjmjqo
	 bqTnlXOfLpGWQ==
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
Subject: [PATCH v7 18/26] rust: alloc: add `Vec` to prelude
Date: Thu, 12 Sep 2024 00:52:54 +0200
Message-ID: <20240911225449.152928-19-dakr@kernel.org>
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

Now that we removed `VecExt` and the corresponding includes in
prelude.rs, add the new kernel `Vec` type instead.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/prelude.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 07daccf6ca8e..8bdab9aa0d16 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
+pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
 pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
-- 
2.46.0


