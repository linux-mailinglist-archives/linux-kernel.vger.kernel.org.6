Return-Path: <linux-kernel+bounces-217337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAACE90AE76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8EE1C23DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA474197A6E;
	Mon, 17 Jun 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NkXMzD2B"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD7D197A61
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629111; cv=none; b=sjBhPmE15iK56rj9yK2OBW/6d/J8rbbzWtQpf8Dr0oCTV6y26WhQ6qjXPXGjxCgFuPm+LbRWFKq//ZkhcVvZEPFWZNb4530MJxTxXfeZM5v8ZhecUk+hjO/+ckaTkBvY3GITOfeNmTnC5SODSHhBKOEa+1j7O+/vWUWYIvufKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629111; c=relaxed/simple;
	bh=Uax/c7+sLz4sjtkyfwBC5I+goM5LE5/SzcO4Oqcruq8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nmMhSJW7E+vHFrb7g70R7L3wjFMFFa/U9kRby6c0Lpw8F7mvF2JLE3GsWpg2FBkHMOF246iz5CW4pBZCXA74cqY8QTXQLIIjxUUIk90hH89D4R6qmh9NOoQ+K78sju3nVE8d4n/Z3i39Rnz+WAgem4UhIVYRK8Qnsf23k2vgN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NkXMzD2B; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: zhouchengming@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718629107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LhE5GerIuky+iWF4C4KHZxHl5t3Dhdt0MaEcD7DaEsk=;
	b=NkXMzD2B9dj2qK2dt1EReRRc55Klfna1SYWcfLP48rL/PlxVfGVWWC9peMzBfPjJw7iOT+
	wjdrA4nMYuuhXlsjmdK7kwyS+T+GanthCtdwg4OT4JxvWBozqV/id4tyc0o/56t+VdlRRk
	siRsgl3zewrDhPTqblGaV8G8wYrY4bM=
X-Envelope-To: minchan@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: senozhatsky@chromium.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: chengming.zhou@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH 0/2] mm/zsmalloc: change back to per-size_class lock
Date: Mon, 17 Jun 2024 20:57:39 +0800
Message-Id: <20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMMycGYC/x3MSQqAMAxA0atI1gaccLqKuAg1atBWaaU44N0tL
 v7ibf4Djq2wgzZ6wLIXJ5sJSOMI1ExmYpQhGLIkK5IyrfB2mtZ1UxhaUGtkz/Y6ZjET5nVFA5W
 ck2ogHHbLo5z/vevf9wOOhJzbbQAAAA==
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
 Nhat Pham <nphamcs@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718629103; l=1719;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=Uax/c7+sLz4sjtkyfwBC5I+goM5LE5/SzcO4Oqcruq8=;
 b=A0tE65qrzF8XFHhYayouNtAAv60P5BRip7QjzITZqmguqKp1XxX6F5N5PMVtNa6MjEAgJe6iM
 /qfBmi/s/MPAtnKKpz7zjf165JAB808L3jKcV7ve8Fv4hu0ad6h/WI1
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=/XPhIutBo+zyUeQyf4Ni5JYk/PEIWxIeUQqy2DYjmhI=
X-Migadu-Flow: FLOW_OUT

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
in zswap.

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


