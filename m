Return-Path: <linux-kernel+bounces-274900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E26C947E02
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED638281002
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D724E16F288;
	Mon,  5 Aug 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYI9PdiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19815B10A;
	Mon,  5 Aug 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871364; cv=none; b=XHavl0YzJJPrz1W7VfyJdHSGg2wwExEIK98rUYIEf5ZaVjzNtwOTUlNrIxXx7SnwRWQISEE9shLKuzE5JpaV0OoqjhaIQnq8z5rwpzTICY4BV50J7P4AVHU3Pd9KW7FZOr5tzEW4BbZdvYiQypPKmGuOYA2Grt+VCQLUCzZgMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871364; c=relaxed/simple;
	bh=yqZfDZklljbN0uO3lQJvfzXfJFBboT5n5ZoqxzlseQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCrXBVoECrQ4WGf9Kjt2+qQXCPObTr93g1hJcdKTtsHV6n6Vne1dyHAbsMbxJCX7Vmd38j/MiS4U9aLlldktJ4cLtDJXNRMwY+O6CJuj48uAr/L7tK0cn3IXt1pA9LvXtFyTZSOLaa76V3Kft2tNEOKPWoKUBXH+ZbbT1+AcqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYI9PdiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B800C32782;
	Mon,  5 Aug 2024 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871363;
	bh=yqZfDZklljbN0uO3lQJvfzXfJFBboT5n5ZoqxzlseQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYI9PdiHMEa6z+y4a49v74LXqpDE47khUkbXxwkn7JYJYv/DZQXc3MSTZ/urywyFv
	 atR7cWe7kP9ojhrrPjeXzdwpLW5B2kqLlZV4q3SWIiqkRhYsDlXQk8VOhHar7GSrul
	 OEJ5fsIxT7PzlDXt9Qhf6ElEZjeBGlY9ucX75YFzAN/lCYSU71WbrPUOHriRCkvNJh
	 jHsqsqgSPK7T1H7fJqIabk5l4385QPeLFQXDP/EFQSg20ALuU3yAOU6hy1H70UMRj0
	 5AeKx4fuuC9Ximy7trO2gaPMkBbXWTijm+t/VfnZpLpfZlUuDmitxWYYoCS4Nq4CI2
	 vpc0lH5iTtJsg==
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
Subject: [PATCH v4 27/28] rust: alloc: update module comment of alloc.rs
Date: Mon,  5 Aug 2024 17:19:46 +0200
Message-ID: <20240805152004.5039-28-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before we remove Rust's alloc crate, rewrite the module comment in
alloc.rs to avoid a rustdoc warning.

Besides that, the module comment in alloc.rs isn't correct anymore,
we're no longer extending Rust's alloc crate.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 615afe69d097..ccb9f5ddc4bb 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! Extensions to the [`alloc`] crate.
+//! Implementation of the kernel's memory allocation infrastructure.
 
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
-- 
2.45.2


