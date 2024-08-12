Return-Path: <linux-kernel+bounces-283611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD3894F6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17A0B2381D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029C319D069;
	Mon, 12 Aug 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrewnQXR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1419CCEB;
	Mon, 12 Aug 2024 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487189; cv=none; b=BcEEV1jVVA1PIzMqaMc1YD/daQbRfAxNqNRCQop4az7DFJwtw6tdSG8Zz1JtO6OpzJTVrr6PdNGP1YTPNPvt9aEUjXgR1V8oB6/ZgVWmN7LI66AixKylKhsBUhoHSfdRNtxmITWeQIWqTdIq9mFLYdyBj3pUHn4idwvaBf+XpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487189; c=relaxed/simple;
	bh=pq9p+3MKfusrm9d+dkS4M59Yq++w7zxN0VRikqPFNQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZR4+YSX6jdjbbLRgQCRSasIes2TVrXpQJlvjnwwpywXjQv6U0/NMqQ6Jqo7KZctYDa8XhSIwEsZZOpENU7RzwqsphAizXFdLgiFO7ME3dhS8FqImu8h8wnfxDRik0w36AaoEohpnrue9wKeex5jwwxwG2Zh5KAyeOYrIFgg7OYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrewnQXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9884C4AF15;
	Mon, 12 Aug 2024 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487188;
	bh=pq9p+3MKfusrm9d+dkS4M59Yq++w7zxN0VRikqPFNQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IrewnQXRBh0PBYuwXSIQzmoElmSkGlvcMIqqYkJoje+DqQVUvmpLyAjNKgHZj2XyC
	 bLeNJWuUkdDY83SrJNoBjfbUX/5YEjdHOr2qvbI08G7Y8m/JJ9C9PWI7gEj7NEdg56
	 QMfJavksWPUfcD+0yrlxQqeXCHHsLY//EgheijRgeFWVjkW8fiAINf04QtccJXnICd
	 zX4WVPUZ6XkHAB9nTETApAZM7kDsvWEMYZW0Ds5g9QfWDJtXvff/bLThXq6pF6eTdN
	 eHpJ9utvJFX4N4z0b7ivpkyafVprJqj/0uvR1l/Hd/U+aH/x++mqll/JMs5mbzrMTI
	 ImMXMjHnkjaeQ==
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
Subject: [PATCH v5 26/26] MAINTAINERS: add entry for the Rust `alloc` module
Date: Mon, 12 Aug 2024 20:23:12 +0200
Message-ID: <20240812182355.11641-27-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812182355.11641-1-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add maintainers entry for the Rust `alloc` module.

Currently, this includes the `Allocator` API itself, `Allocator`
implementations, such as `Kmalloc` or `Vmalloc`, as well as the kernel's
implementation of the primary memory allocation data structures, `Box`
and `Vec`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..560516b3aaf4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19925,6 +19925,13 @@ F:	scripts/*rust*
 F:	tools/testing/selftests/rust/
 K:	\b(?i:rust)\b
 
+RUST [ALLOC]
+M:	Danilo Krummrich <dakr@kernel.org>
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/alloc.rs
+F:	rust/kernel/alloc/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
-- 
2.45.2


