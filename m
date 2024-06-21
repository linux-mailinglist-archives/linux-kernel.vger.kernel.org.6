Return-Path: <linux-kernel+bounces-224049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31E911C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A66B23F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820CC158206;
	Fri, 21 Jun 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zefbg62V"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B043C2F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954144; cv=none; b=b7dlBaW4IHsPVyxX6NJBPyqgbin8V1OPgMHMwWu73WvMIShQwCrKPyLbeYUPFIQYMWF5JZoDIBddpIUTwBVe2TTcaklitr6bC6GdEAD+Hu4HRPEfPI3Hu0wtWPOuc/a9KiJew/yHbw83oP0JivUsQfHBK+fzygwP7VbJEYSUsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954144; c=relaxed/simple;
	bh=XaO4Z0+DtOg24zA1OThoXiLI5A9lBnk/os2EEmz7b7Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cJaCSZii49MvZBwiP5oS5k7PHNrQI5uS+U5VytcTmo4QDVXCSPKK1W5Uj/SYvEL+GnEATrFguV9I3g7h+WLZajg1SeSnHGEGsDBga6nj7c6Lmn0qYdEV7qvzqzObDDyoDeWKc9wSXuVjA/vmBxf1mwWzFUB0dzj9rrK5z/ahoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zefbg62V; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: nphamcs@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718954139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tOqrzNN/hVJKUhpB295MtNPXD1lC1GUlx7tqQgCRnPA=;
	b=Zefbg62V36nuWtcHlL8rHv8yJSAts/gdbTUpSU26lKcKadShZFr7b3INq0P3kGHIlNHc+w
	3KfFaGbjq+7Lb9dA8c4Di4KDwbSL5ooEL523a9ZpYEJ1Ix+fqeaAyBsIrV4MpfbRMXZVf/
	b3S647Wzzs4fwypFVjLTrw18mbztNCU=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: yuzhao@google.com
X-Envelope-To: senozhatsky@chromium.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: minchan@kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH v2 0/2] mm/zsmalloc: change back to per-size_class lock
Date: Fri, 21 Jun 2024 15:15:08 +0800
Message-Id: <20240621-zsmalloc-lock-mm-everything-v2-0-d30e9cd2b793@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHwodWYC/42NTQ6CMBBGr0Jm7ZgW5EdX3sOwqO0IE6E1LTYg4
 e5WTuDiW7xv8d4KgTxTgEu2gqfIgZ1NkB8y0L2yHSGbxJCL/CQqWeMnjGoYnMa0J44jUiS/TD3
 bDoumVkZVVCh9hmR4eXrwvNtvbeKew+T8ssei/L3/eaNEgSWVopGkpLwX14Htez4aitBu2/YFj
 Vu2+MYAAAA=
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
 Nhat Pham <nphamcs@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>, Takero Funaki <flintglass@gmail.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718954135; l=2161;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=XaO4Z0+DtOg24zA1OThoXiLI5A9lBnk/os2EEmz7b7Q=;
 b=MaNU41YtH+wB6JIswCj4bvQET2ZJktB31PF0WTzqMTS+g61cKj0d0rRlcreBVK5g34wBX9Yh8
 sxYuNFjS9YsC51599x1WG8we4RP6XjdSxbLspNKRjPf2DhYfZuqBWWj
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=/XPhIutBo+zyUeQyf4Ni5JYk/PEIWxIeUQqy2DYjmhI=
X-Migadu-Flow: FLOW_OUT

Changes in v2:
- Fix error handling in zswap_pool_create(), thanks Dan Carpenter.
- Add Reviewed-by tag from Nhat, thanks.
- Improve changelog to explain about other backends, per Yu Zhao.
- Link to v1: https://lore.kernel.org/r/20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev

Commit c0547d0b6a4b ("zsmalloc: consolidate zs_pool's migrate_lock and
size_class's locks") changed per-size_class lock to pool spinlock to
prepare reclaim support in zsmalloc. Then reclaim support in zsmalloc
had been dropped in favor of LRU reclaim in zswap, but this locking
change had been left there.

Obviously, the scalability of pool spinlock is worse than per-size_class.
And we have a workaround that using 32 pools in zswap to avoid this
scalability problem, which brings its own problems like memory waste
and more memory fragmentation.

So this series changes back to use per-size_class lock and using testing
data in much stressed situation to verify that we can use only one pool
in zswap. Note we only test and care about the zsmalloc backend, which
makes sense now since zsmalloc became a lot more popular than other
backends.

Testing kernel build (make bzImage -j32) on tmpfs with memory.max=1GB,
and zswap shrinker enabled with 10GB swapfile on ext4.

				real	user    sys
6.10.0-rc3			138.18	1241.38 1452.73
6.10.0-rc3-onepool		149.45	1240.45 1844.69
6.10.0-rc3-onepool-perclass	138.23	1242.37 1469.71

We can see from "sys" column that per-size_class locking with only one
pool in zswap can have near performance with the current 32 pools.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (2):
      mm/zsmalloc: change back to per-size_class lock
      mm/zswap: use only one pool in zswap

 mm/zsmalloc.c | 85 +++++++++++++++++++++++++++++++++++------------------------
 mm/zswap.c    | 60 +++++++++++++----------------------------
 2 files changed, 69 insertions(+), 76 deletions(-)
---
base-commit: 7c4c5a2ebbcea9031dbb130bb529c8eba025b16a
change-id: 20240617-zsmalloc-lock-mm-everything-387ada6e3ac9

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


