Return-Path: <linux-kernel+bounces-188492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C68CE2AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3666B1C21911
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E701292E1;
	Fri, 24 May 2024 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gmsP42Ph"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9A9475
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541060; cv=none; b=cLK6l987zzHQ/sJvixybKMaO66GWYbpliWNkEyakkoQU9O7/4JqkQGmjtx7eglvwyr3ABK8L65gpIDA9Cy+D27f9Z5UmByPAFSJ1LChciolC5B7hAcKuifAUZyniv2bLW54xj9Q53j/hwhvYLJnfBjsfTkB8LY9iEHPha5xtvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541060; c=relaxed/simple;
	bh=Qwch/DUifmAp31RvHL48cbakz6SI6sa/rOXdG37/3XU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dKbd5h4nw8m/GNTFTUGnxZix1TDygEjK+gKA8owdZJRtlxEBh4/I6SJkdoG7CEsKXKyM1HvIl1Q7y8MR4X45hy73oUJUH88UelCTJluFO1v0R5E1CfEfn3c1XiRHY9oNq/vu4q8eQghjVR9No0eIoaB6y21gmhb0M175XJcPgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gmsP42Ph; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mm@kvack.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716541054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ds3tXwBbM94eOORMZkrEUwB+zppk0KBTTGow/Bf7ObE=;
	b=gmsP42PhKt2uOV+RAkNceZG54YnzQJokMJoltMBQIAhoYJpf3d1WZb87ZIExln82ufv6Cx
	66wGydR9WWv+rj5YYvkTvs7grhOAaUHQgz8g2MbzKj3bBC6OwJwfzCYUxa0d04Calj9ZTZ
	Y3EW5n4sNTBBeR56/6R1R5mRfrLGokA=
X-Envelope-To: hughd@google.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: shr@devkernel.io
X-Envelope-To: david@redhat.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH 0/4] mm/ksm: cmp_and_merge_page() optimizations and cleanup
Date: Fri, 24 May 2024 16:56:49 +0800
Message-Id: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFFWUGYC/x3MQQ5AMBBA0avIrE1SVRGuIhbVDiaipCMixN01l
 m/x/wNCkUmgzR6IdLLwFhKKPAM32zARsk8GrbRRlTY4GFxkRXE24LYfvPJN6PXoG6MKV1Y1pHS
 PNPL1b7v+fT8bM4zFZgAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, 
 aarcange@redhat.com, hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541051; l=4789;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=Qwch/DUifmAp31RvHL48cbakz6SI6sa/rOXdG37/3XU=;
 b=tc4ETyQ1obSkVNvp3j9PenRnW77MaL27u6kiBfgJ2EWDTRmFBjAxEsvIY9mP+ovHUK/uTGFhu
 QvlGJNeavitASKO7v+zSljH/WcCfK5JmN7Mtp02Mj6IfTzFo6MGYOYx
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

Hello,

This series mainly optimizes cmp_and_merge_page() to have more efficient
separate code flow for ksm page and non-ksm anon page.

- ksm page: don't need to calculate the checksum obviously.
- anon page: don't need to search stable tree if changing fast and try
  to merge with zero page before searching ksm page on stable tree.

Please see the patch-2 for details.

Patch-3 is cleanup also a little optimization for the chain()/chain_prune
interfaces, which made the stable_tree_search()/stable_tree_insert() over
complex.

In patch-4, fix behaviors in stable_tree_search() when handle migrating
stable_node: return the migrated ksm page if no shareable ksm page found
on the stable tree, so our rmap_item can be added directly.

I have done simple testing using "hackbench -g 1 -l 300000" (maybe I need
to use a better workload) on my machine, have seen a little CPU usage
decrease of ksmd and some improvements of cmp_and_merge_page() latency:

Before:

- ksm page
[128, 256)            21 |                                                    |
[256, 512)         12509 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)            769 |@@@                                                 |
[1K, 2K)              99 |                                                    |
[2K, 4K)               4 |                                                    |
[4K, 8K)               2 |                                                    |
[8K, 16K)              8 |                                                    |

- anon page
[512, 1K)             19 |                                                    |
[1K, 2K)            7160 |@@@@@@@@@@@                                         |
[2K, 4K)           33516 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4K, 8K)           33172 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
[8K, 16K)          11305 |@@@@@@@@@@@@@@@@@                                   |
[16K, 32K)          1303 |@@                                                  |
[32K, 64K)            16 |                                                    |
[64K, 128K)            6 |                                                    |
[128K, 256K)           6 |                                                    |
[256K, 512K)           9 |                                                    |
[512K, 1M)             3 |                                                    |
[1M, 2M)               2 |                                                    |
[2M, 4M)               1 |                                                    |

After:

- ksm page
[128, 256)             9 |                                                    |
[256, 512)           915 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)             41 |@@                                                  |
[1K, 2K)               1 |                                                    |
[2K, 4K)               1 |                                                    |

- anon page
[512, 1K)            374 |                                                    |
[1K, 2K)            5367 |@@@@                                                |
[2K, 4K)           64362 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[4K, 8K)           27721 |@@@@@@@@@@@@@@@@@@@@@@                              |
[8K, 16K)           1047 |                                                    |
[16K, 32K)            63 |                                                    |
[32K, 64K)             7 |                                                    |
[64K, 128K)            6 |                                                    |
[128K, 256K)           5 |                                                    |
[256K, 512K)           3 |                                                    |
[512K, 1M)             1 |                                                    |

We can see the latency of cmp_and_merge_page() when handling non-ksm
anon pages has been improved.

Thanks for review and comments!

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (4):
      mm/ksm: refactor out try_to_merge_with_zero_page()
      mm/ksm: don't waste time searching stable tree for fast changing page
      mm/ksm: optimize the chain()/chain_prune() interfaces
      mm/ksm: use ksm page itself if no another ksm page is found on stable tree

 mm/ksm.c | 266 ++++++++++++++++++++-------------------------------------------
 1 file changed, 84 insertions(+), 182 deletions(-)
---
base-commit: 2218eca02bc4203f68b8fb7e1116e5a2601506d1
change-id: 20240524-b4-ksm-scan-optimize-d2fd9401c357

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


