Return-Path: <linux-kernel+bounces-443317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E7A9EECE2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42043284E22
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16186F2FE;
	Thu, 12 Dec 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KthpSs3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAB2135C1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017962; cv=none; b=PHsN3OfdzAUU+6k0CGKqZedcdIb9jjBb8BULdl6HBgzRA1ZAHbB4X+kAbunPPQwXIicG4jHIclnwxhXg4zhMJ0lfc0K6IBxJAsWNS4K/FmwVqiGJ6yBkGiFLgLBiPFyBcdWgTUMHKvmxUgV5NsrMJf3idpWSzR6F2vqrBtyuDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017962; c=relaxed/simple;
	bh=d39Ur9JdCLchD2dgxGueQbpDyONUWTQL7p1gLGqxRkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tDJbm1/mZg6jU4ANwFshrT0MWt0rEvXAAy74rRoyyvuDJ8GrLkVrKiITrU5CEqaSB9XLgZTjrB4P8QfmHNUQjl5UaQmp7RmAMgaVs1wGcyf2KbnBskKbeVL1+pz/0BH+Ks4cVCofs7SHXG4+QWC7rDaB9ZGtUVDRv6dnH8K+Ihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KthpSs3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98597C4CECE;
	Thu, 12 Dec 2024 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734017961;
	bh=d39Ur9JdCLchD2dgxGueQbpDyONUWTQL7p1gLGqxRkA=;
	h=From:To:Cc:Subject:Date:From;
	b=KthpSs3bpc3Mkll6mrZ4naR9FEMuW+IygdyG54PvLgi6SbExUBTsge4AY9fd3Ueq5
	 IK0ayK+7m5gsSeLZ8+IDB/6qT7/DUF4XU56CVIs9gCpdj/xkYQXyRjPzU4idQlLAsc
	 yrIlNfLkVjwKycFojToV9ZMTTOVBCfK2ambwnHzX0R0bH32T1m2nk5p1JHY8ngcYFh
	 l4S7IZJFPZLStaMmUDJ5OyZA+Mkn8XkZa3IaK4/6hsRJ2NTzQHJrEFSdCOWiCpW4rK
	 K8lvK9XlzZwdmtmlkAfP3Fhcx0wooLnRx2maA8bOfKk9cmhFK0fnK6NXabY7rMn7mF
	 kPjF39SSUp3gQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Junjie Fu <fujunjie1@qq.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: include linux/pagemap.h where needed
Date: Thu, 12 Dec 2024 16:39:10 +0100
Message-Id: <20241212153916.1292365-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The pagemap header used to be included by accident here but is now
missing:

mm/z3fold.c: In function 'free_z3fold_page':
mm/z3fold.c:353:17: error: implicit declaration of function 'lock_page'; did you mean 'copy_page'? [-Wimplicit-function-declaration]
  353 |                 lock_page(page);
      |                 ^~~~~~~~~
      |                 copy_page

Add the correct #include statement.

Fixes: a6c37165ca40 ("mempolicy.h: remove unnecessary header file inclusions with no test failure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/z3fold.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 379d24b4fef9..4ae93bb2e3ab 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/page-flags.h>
+#include <linux/pagemap.h>
 #include <linux/migrate.h>
 #include <linux/node.h>
 #include <linux/compaction.h>
-- 
2.39.5


