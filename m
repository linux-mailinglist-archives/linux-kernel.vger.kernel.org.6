Return-Path: <linux-kernel+bounces-270033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE72943A6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA311C21B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F13914885B;
	Thu,  1 Aug 2024 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUivBdiq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95A1487F6;
	Thu,  1 Aug 2024 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470933; cv=none; b=iV9oG/rhf6IDo/E4gTRbnHemzOLPNeyvIpHLptDdM/9FoU/ws3QUNwMBJC/dICmImnann4Fo2oBAsgbGMWmjGE1FPS1aZFXDDqn0oGAvIben4qIgFlkzGIUhLnIgRyT27xKGRopqVSIqEig9Xxc1Q321DK5nQtVewg4tv0IAU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470933; c=relaxed/simple;
	bh=ifLa6ui520OxD4tx6GpOL1mZtUOCjuqJJxFCxi3qo5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIEePWDb+kazXtHc8dn7Z7dFXccCVMqn8v1VhhYgP4UpMn/6JTkhafFLl8tlcFYLumSTt4t+pMzo03G+V6nGBuUsWGN/U39vg+jvJjUaNPKX9bThc42JGJrayDXL03rE9JMgQt7taTpu8rYob5dR5WrcVxFzQYNK0zQvozbhtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUivBdiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C057C116B1;
	Thu,  1 Aug 2024 00:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470933;
	bh=ifLa6ui520OxD4tx6GpOL1mZtUOCjuqJJxFCxi3qo5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUivBdiq+ljrI8Gj0tdo4pLab5vvfpKTImgKvmcvTlTlbF5y7wRSOxm4qYZPTwRrY
	 9St9UbAqB/1kv8ZPBXZIS8y3eRCZKDQ57QumGUiQIsO00sUO9UfMQOijL9qMuudvnz
	 aKOC5wQz2A54+FBlR9nidtxr4w67RBmayYNlzhNolOJwOFsIjD0Ym1brzxi1h7QCf3
	 qiHZur/RDhDo9nOBevWr39KwXMfkYs3kTPoVkSR2/Y3qC6Xog5zZp9GYEV0X4aWYz/
	 DDXt3B7GcuuZE7t1VZNtZkX60Rjn3wfax61v1tlZhI3RDyOotEPkpxGFK1zrpAPllz
	 X9DqJJD90FF7A==
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
Subject: [PATCH v3 22/25] rust: error: use `core::alloc::LayoutError`
Date: Thu,  1 Aug 2024 02:02:21 +0200
Message-ID: <20240801000641.1882-23-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801000641.1882-1-dakr@kernel.org>
References: <20240801000641.1882-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `core::alloc::LayoutError` instead of `alloc::alloc::LayoutError` in
preparation to get rid of Rust's alloc crate.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 145f5c397009..2d012cc3881a 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,7 +6,7 @@
 
 use crate::{alloc::AllocError, str::CStr};
 
-use alloc::alloc::LayoutError;
+use core::alloc::LayoutError;
 
 use core::fmt;
 use core::num::TryFromIntError;
-- 
2.45.2


