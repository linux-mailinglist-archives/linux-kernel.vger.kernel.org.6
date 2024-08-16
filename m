Return-Path: <linux-kernel+bounces-288761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4896A953E39
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A77D1C21D60
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEFF13A27D;
	Fri, 16 Aug 2024 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fpi8d3xS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF42139566;
	Fri, 16 Aug 2024 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767283; cv=none; b=U9FDCpXS8PvZE+yxu/tTU+cbr3eZBh6WNrADyaYwUbISgojn6xe8c+kRYgVcT2QDNWDkBPZT3TcSc4/Pdl/VK0oxHuWdfbBJDVxuGnT0E4NpY/N46m/J3Hw3orBMcCAAmXF8CW1jayagexZT/PgJLOzgskHDbSL6fIMUNQFRuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767283; c=relaxed/simple;
	bh=0vRT7A88Z+C0vOfDex96MupvcF/nPHLRzZQHI1NMWu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0p+UtI/cHiVD5aJh80QPgXq+NKPivmShGBkrXiyNevU4F1XZN/Xh81LI436BTOMv6zFWvGa9cEUMqz/bVS6e0JHlY+uGaHeK4ixyJAc+UbK5qPMigWpqRaRk+0cgJikWsy0ZsH+1gCSZrw3Jizws2Y6nPDOE0ftGnSudnKbKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fpi8d3xS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E006C4AF0F;
	Fri, 16 Aug 2024 00:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767283;
	bh=0vRT7A88Z+C0vOfDex96MupvcF/nPHLRzZQHI1NMWu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fpi8d3xSzM8wjRKtjJNsznVuhGC72mP4ZaQ0gtuCnnzxdVK+yORnEznzd1krP2U3k
	 xM8uNfnqulxOgvRW6s/PZaGN5GuJMt3yyJGmcDHdq1S5PuJCnF5P3jjxiLlTs0pVhE
	 55B8GnhvR06FNNErgi3d/UmizyH4qltjrkiri6WRPoTnJi0F37/OLZmuAuqPmg8zmm
	 9IWkiFiAuCK7XBxGQOIhKIpmFCWNKfpU6oFBWFCDVB7zhKb6EV/YTTFNPFa2qyIXzf
	 UlGYTCOqOtcbcYddp+vz+HV7fZKaaNeia27DBJtPaXhI/xxZM3uFnMEMA3aDNAMbwn
	 rhwy7Q5KJQyeA==
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
Subject: [PATCH v6 26/26] MAINTAINERS: add entry for the Rust `alloc` module
Date: Fri, 16 Aug 2024 02:11:08 +0200
Message-ID: <20240816001216.26575-27-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
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
2.46.0


