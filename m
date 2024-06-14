Return-Path: <linux-kernel+bounces-215001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC2908D26
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD72C1F2512F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A79463;
	Fri, 14 Jun 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u3XAwKX/"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF5945A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374613; cv=none; b=od5vNURnbkvEgn5z0gFs0FFamQSn8cBU7eZ9UMfoTFXiPYctGcuYSsYvHbRKHgi8B5O8qHDTWztjBWyvY5pv8mQIfXP/OHpar+ggHhYNaKdPTRd1cs0MjCkf4HqU2od98FmHroPin8i5hoP2w+QHsCfWPzGz2LLb/QR6XRcF1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374613; c=relaxed/simple;
	bh=jpTO11Zs6ARpgn9DdGfpY+ts6ppb84MF/J8UwwtQ6M0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Agc90Lx/J4OudrksdiGz013kkPsOPjSoDxRUMcb99YCyrcLS6ESbZD6cI60Rzh519dEZDGsXFg9N0qFgiF5YI16sUVoQe2SKfD3LDaeesD3odN52FvL0dcgaMVe/NSQr+0fP/WmY4JeXYrm3JS8sqYz4xLnjqJjFNpG0hP+5kHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u3XAwKX/; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718374607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w8jKgK+1dz6W9hZOwl0Mk0auD1tYCqkT+HhvW1YvPYs=;
	b=u3XAwKX/k1yalv9l/B8981lwLsSxoU4TtJpZgfX2Otb4VYYyX1hxOsRJh/L3oDSXPcZ4TR
	DZcGeXteZmuoatFYJvHwCHBAZlRUb5lP2bfeGQIQ+HBKDtoPhS1ZCGuRWg+1RMKPRzoPJN
	tvFUngscgmmwJM1LKcwM8NNXzKcP0/Q=
X-Envelope-To: andreyknvl@gmail.com
X-Envelope-To: elver@google.com
X-Envelope-To: glider@google.com
X-Envelope-To: dvyukov@google.com
X-Envelope-To: ryabinin.a.a@gmail.com
X-Envelope-To: kasan-dev@googlegroups.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: spender@grsecurity.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Brad Spengler <spender@grsecurity.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: fix bad call to unpoison_slab_object
Date: Fri, 14 Jun 2024 16:16:40 +0200
Message-Id: <20240614141640.59324-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

Commit 29d7355a9d05 ("kasan: save alloc stack traces for mempool") messed
up one of the calls to unpoison_slab_object: the last two arguments are
supposed to be GFP flags and whether to init the object memory.

Fix the call.

Without this fix, unpoison_slab_object provides the object's size as
GFP flags to unpoison_slab_object, which can cause LOCKDEP reports
(and probably other issues).

Fixes: 29d7355a9d05 ("kasan: save alloc stack traces for mempool")
Reported-by: Brad Spengler <spender@grsecurity.net>
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index e7c9a4dc89f8..85e7c6b4575c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -532,7 +532,7 @@ void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
 		return;
 
 	/* Unpoison the object and save alloc info for non-kmalloc() allocations. */
-	unpoison_slab_object(slab->slab_cache, ptr, size, flags);
+	unpoison_slab_object(slab->slab_cache, ptr, flags, false);
 
 	/* Poison the redzone and save alloc info for kmalloc() allocations. */
 	if (is_kmalloc_cache(slab->slab_cache))
-- 
2.25.1


