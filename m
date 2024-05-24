Return-Path: <linux-kernel+bounces-188968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499308CE924
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9771F217EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF612FF95;
	Fri, 24 May 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGEtu5xh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3E12F379
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571050; cv=none; b=TpHkfziDcoC3QgcWdN5kUHD/SF1hBxybr5iaUSK/VKmayY67cXdmWzHeaHj7nlbCr3nabl6/rebGpeDRhAI0GcNm/pkVzz0LTsBbkR2R9Yzc+D5JEcuo/O1w9adjGSv6yyJdi5WE1Hu+67ACKReFFWPfx2LDGp6+X9JA8suZV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571050; c=relaxed/simple;
	bh=LWI53cB4MZ9NTt9TO+i5sJJm697nQeTm1z7xgs/U1n0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=clo2/d5MHuriorInMzs15A4RKXnwwgbEGJGsf/w1wxpCS8PfZH5L8Ze0vAJsEHpzMkHcPgU+/4eGXLeqUawYUucOZWOI8jmTbsQSvFwIUxgX33DfpKQxL8TE9T1Rv1zenp26e9MELm4uUWLxP9AZl9/nRc/hvAoM2/j21Vnts/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGEtu5xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AEFC2BBFC;
	Fri, 24 May 2024 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716571050;
	bh=LWI53cB4MZ9NTt9TO+i5sJJm697nQeTm1z7xgs/U1n0=;
	h=From:Subject:Date:To:Cc:From;
	b=eGEtu5xh4B1wWNrFGgqZYe1RbfRL7r91Vpqr98iX7fH9QLmd3C32CB9+2gikzV6gQ
	 iZ5wvyMYCbsVfTLA7o7AFgKsYPQ+H6UHbdX+D2fN479qyzF1E9NSqzh/FsL56w+MZu
	 ASV2Mok1qIUmggQWKYeLdAG7ojUGXtGUohSrLrWuxfut4Q7tzKpFIyNbHw9pAonWPB
	 h837qro56VY2AbfHQvZs5iP6QxJx74GVIuV6pSf1Za7oDJmz62djWeGYtrRBleWKLJ
	 zv/fLoU1kzIHIaV1aORFe9lNwuRWAhTPbshkNZ1Mq0maTgAqWJI4cAkcq7rRJbyeaC
	 O8EEFFnrkBmnA==
From: Chris Li <chrisl@kernel.org>
Subject: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
Date: Fri, 24 May 2024 10:17:17 -0700
Message-Id: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ3LUGYC/x3MTQqAIBBA4avErBP8hegq0UJsqgFR0ahAvHvS8
 lu8V6FgJiwwDxUy3lQohg4xDuBOGw5ktHWD5FJzIxUrj03Meh+dvWJmwijt9MTRoYYepYw7vf9
 wWVv7AGQJcvRgAAAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
 "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.12.4

This is the short term solutiolns "swap cluster order" listed
in my "Swap Abstraction" discussion slice 8 in the recent
LSF/MM conference.

When commit 845982eb264bc "mm: swap: allow storage of all mTHP
orders" is introduced, it only allocates the mTHP swap entries
from new empty cluster list. That works well for PMD size THP,
but it has a serius fragmentation issue reported by Barry.

https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/

The mTHP allocation failure rate raises to almost 100% after a few
hours in Barry's test run.

The reason is that all the empty cluster has been exhausted while
there are planty of free swap entries to in the cluster that is
not 100% free.

Address this by remember the swap allocation order in the cluster.
Keep track of the per order non full cluster list for later allocation.

This greatly improve the sucess rate of the mTHP swap allocation.
While I am still waiting for Barry's test result. I paste Kairui's test
result here:

I'm able to reproduce such an issue with a simple script (enabling all order of mthp):

modprobe brd rd_nr=1 rd_size=$(( 10 * 1024 * 1024))
swapoff -a
mkswap /dev/ram0
swapon /dev/ram0

rmdir /sys/fs/cgroup/benchmark
mkdir -p /sys/fs/cgroup/benchmark
cd /sys/fs/cgroup/benchmark
echo 8G > memory.max
echo $$ > cgroup.procs

memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 32 -B binary &

/usr/local/bin/memtier_benchmark -S /tmp/memcached.socket \
        -P memcache_binary -n allkeys --key-minimum=1 \
        --key-maximum=18000000 --key-pattern=P:P -c 1 -t 32 \
        --ratio 1:0 --pipeline 8 -d 1024

Before:
Totals      48805.63         0.00         0.00         5.26045         1.19100        38.91100        59.64700     51063.98
After:
Totals      71098.84         0.00         0.00         3.60585         0.71100        26.36700        39.16700     74388.74

And the fallback ratio dropped by a lot:
Before:
hugepages-32kB/stats/anon_swpout_fallback:15997
hugepages-32kB/stats/anon_swpout:18712
hugepages-512kB/stats/anon_swpout_fallback:192
hugepages-512kB/stats/anon_swpout:0
hugepages-2048kB/stats/anon_swpout_fallback:2
hugepages-2048kB/stats/anon_swpout:0
hugepages-1024kB/stats/anon_swpout_fallback:0
hugepages-1024kB/stats/anon_swpout:0
hugepages-64kB/stats/anon_swpout_fallback:18246
hugepages-64kB/stats/anon_swpout:17644
hugepages-16kB/stats/anon_swpout_fallback:13701
hugepages-16kB/stats/anon_swpout:18234
hugepages-256kB/stats/anon_swpout_fallback:8642
hugepages-256kB/stats/anon_swpout:93
hugepages-128kB/stats/anon_swpout_fallback:21497
hugepages-128kB/stats/anon_swpout:7596

(Still collecting more data, the success swpout was mostly done early, then the fallback began to increase, nearly 100% failure rate)

After:
hugepages-32kB/stats/swpout:34445
hugepages-32kB/stats/swpout_fallback:0
hugepages-512kB/stats/swpout:1
hugepages-512kB/stats/swpout_fallback:134
hugepages-2048kB/stats/swpout:1
hugepages-2048kB/stats/swpout_fallback:1
hugepages-1024kB/stats/swpout:6
hugepages-1024kB/stats/swpout_fallback:0
hugepages-64kB/stats/swpout:35495
hugepages-64kB/stats/swpout_fallback:0
hugepages-16kB/stats/swpout:32441
hugepages-16kB/stats/swpout_fallback:0
hugepages-256kB/stats/swpout:2223
hugepages-256kB/stats/swpout_fallback:6278
hugepages-128kB/stats/swpout:29136
hugepages-128kB/stats/swpout_fallback:52

Reported-by: Barry Song <21cnbao@gmail.com>
Tested-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
Chris Li (2):
      mm: swap: swap cluster switch to double link list
      mm: swap: mTHP allocate swap entries from nonfull list

 include/linux/swap.h |  18 ++--
 mm/swapfile.c        | 252 +++++++++++++++++----------------------------------
 2 files changed, 93 insertions(+), 177 deletions(-)
---
base-commit: c65920c76a977c2b73c3a8b03b4c0c00cc1285ed
change-id: 20240523-swap-allocator-1534c480ece4

Best regards,
-- 
Chris Li <chrisl@kernel.org>


