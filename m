Return-Path: <linux-kernel+bounces-529294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8192A422B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE23D19C1BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C51386B4;
	Mon, 24 Feb 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1QOofvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC9D13BC26;
	Mon, 24 Feb 2025 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406289; cv=none; b=Fw4+fp/B7F/2bEh4Vtkq6e7eh2rpcnl1bQvR08MnEjIN5xESKDwqHSTLq4qnCubCEHLrXLJO4anQVYu8ch8rFfrnkfbnw0deu6bhOl2bcDfWvMIJbWNHuOaHT2wyZGkYz91yW5iVJ4YvKI2yqdXWdAdDY1SmV5qeb9BB7xGllnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406289; c=relaxed/simple;
	bh=RQdVPYUPxuE56GoXKqcHw8DD6iWVMqD2pu1GTpiafhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j8wYsNz9tkEpqeTr0r/l/y/ELaRbmKf+m28jwMsBAV5EfOqvOg8yLoi2K/Ey7q/HgbNHtcY+7AhU8TiFMYa/RfEOXG7++PrexsxnecivGvbUKMoq/v7utxvVsvlaxPptk+9l0KHLp4Nq88QtFqR+oADh/+J6gve10hXnAF0yW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1QOofvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA91BC4CED6;
	Mon, 24 Feb 2025 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740406289;
	bh=RQdVPYUPxuE56GoXKqcHw8DD6iWVMqD2pu1GTpiafhg=;
	h=From:To:Cc:Subject:Date:From;
	b=k1QOofvF8qjd2BhDzXY2lzFSfZlTU9nlFLKbhztRIolki5vp1ZsqoSpykZpnUqg4h
	 Xm3rODsno22eUymgUI3L+5AHfYvAbGb4xZR0l5YTQ+lHi8BGw0OBZK/6fXnRq0Tzgc
	 ZTmdprto+vVRrEbVylp27siCaZBgWkZfo/V8o+ulgS1jRC3y3rLyO8bnRklcB86KTi
	 SmUq6V3UUhQqMx8wLv/LDC3jMR98zO+Lj8Teyi/o7kK4lIo0izD/fCQtoQqsRqyO4J
	 qZv5pmWzlDsk6294meAG4ELObwdo4eA0Unk1VSiYHGmEHUKCIK0vDMFhuoNr4jpyFi
	 CT7KwdiCTaBJg==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Frank van der Linden <fvdl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/2] mm, cma: fix 32-bit warning
Date: Mon, 24 Feb 2025 15:07:35 +0100
Message-Id: <20250224141120.1240534-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang warns about certain always-true conditions, like this one on 32-bit
builds:

mm/cma.c:420:13: error: result of comparison of constant 4294967296 with expression of type 'phys_addr_t' (aka 'unsigned int') is always true [-Werror,-Wtautological-constant-out-of-range-compare]
  420 |                 if (start < SZ_4G)
      |                     ~~~~~ ^ ~~~~~

Replace this one with an equivalent expression that does not cause a warning.

Fixes: 4765deffa0f7 ("mm, cma: support multiple contiguous ranges, if requested")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 34a4df29af72..ef0206c0f16d 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -417,7 +417,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 	 * Create a list of ranges above 4G, largest range first.
 	 */
 	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &start, &end, NULL) {
-		if (start < SZ_4G)
+		if (upper_32_bits(start) == 0)
 			continue;
 
 		start = ALIGN(start, align);
-- 
2.39.5


