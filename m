Return-Path: <linux-kernel+bounces-530737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C9A437A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6DD1899E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546B0261365;
	Tue, 25 Feb 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAs03blF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C6260A58
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472232; cv=none; b=sreGMigR5S/UORyHnqQkIvUOBEqF9E3JjFhZ0MYVj/c1KJpqhZziXheDDrstvmAHUHgb90PUy1mqoQNKj7m4yyOud9+nxNIzZ9ot3Jxqgj85HSABiNS1leCHKGj8IaOhdsMNji+m1sHUffIhODvhhHhCEarl+NK46i4klw1XOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472232; c=relaxed/simple;
	bh=AAsNuK5nv3eH0sJUjtIB0mTHxICDEJB7+Uae9QMRJNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dodLfQvfQIH22C+km215KJFHftskffwLhpbph+kGzyx4cn4Pp/r+kiNK/E7YLUfafIsaMg4QwlZifKLR55D6JAv4lbGYWfGK3jiznMKXj/h/B/HyNZqUt0emVwRXDij8GRxr4eGBxJRZQn319bz20HhCL6pmCm2JlIuukbojOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAs03blF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D414C4CEE2;
	Tue, 25 Feb 2025 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740472232;
	bh=AAsNuK5nv3eH0sJUjtIB0mTHxICDEJB7+Uae9QMRJNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAs03blF3cHVISSpwL8rWqGn0w/ZuV+xGqkRkyr6MTxtmGIZXn2rW6uzfAaE95Maf
	 AIZLeIqEHUkZ7jDls5g7lyfUu1Kn6BGcE/xi4qq/TSra8JPKzZDgfkHf0nIbrBeoih
	 kfmV6hidZ+dafXIl+4ByiJ5lUZNfSSwzoV2MISsljPHM2XdNnV5jWoYGP7c+9EMIZ4
	 T/+ajmNmTBsVbCNX8jkPJdCrpleqy3V0ig8x/n0b8V937GccvdW6XSANUjeocIINd6
	 Hvu2AtBWJ0Crc7TdDsQnOlpQsJTrqEqgKA+UpCRWSV0fqyz2wm/5SOhPKwBmomDxR9
	 JtFXpS0ZVCk2g==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Frank van der Linden <fvdl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable 2/2] mm/mm_init: rename init_reserved_page to init_deferred_page
Date: Tue, 25 Feb 2025 10:30:17 +0200
Message-ID: <20250225083017.567649-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225083017.567649-1-rppt@kernel.org>
References: <20250225083017.567649-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
function performs initialization of a struct page that would have been
deferred normally.

Rename it to init_deferred_page() to better reflect what the function does.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9a02b1e2fce..abb24aedfc96 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -728,7 +728,7 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static void __meminit init_reserved_page(unsigned long pfn, int nid)
+static void __meminit init_deferred_page(unsigned long pfn, int nid)
 {
 	if (early_page_initialised(pfn, nid))
 		return;
@@ -748,7 +748,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static inline void init_reserved_page(unsigned long pfn, int nid)
+static inline void init_deferred_page(unsigned long pfn, int nid)
 {
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
@@ -769,7 +769,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_reserved_page(start_pfn, nid);
+			init_deferred_page(start_pfn, nid);
 
 			/*
 			 * no need for atomic set_bit because the struct
-- 
2.47.2


