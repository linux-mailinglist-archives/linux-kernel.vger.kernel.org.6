Return-Path: <linux-kernel+bounces-224156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E1A911DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78FA1C2212E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08A16EB78;
	Fri, 21 Jun 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c44birts"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3A16D4EF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956512; cv=none; b=MiiRlSduF+MhmWk5ZGAJym9gH2XXsAJvSyIXi2d5rffTrFac09ux97kDmFrzByhkayTCmpMekdePmo5i8IouLjmXQU0wumYIkKRmLw4zLzfYA2Bnhe+0OYcv/2SOxfcuE4caY2AlnLgkf4ZPXeZBCkIgndlRBddh+MH4Y28XMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956512; c=relaxed/simple;
	bh=jLA1H+y/05ddFVormNithidAIAVMdbemin5WLnmAX3M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uSM61aiL2+ZdAtN38ydAgll1ZhKsd1ALsqjz5OXDf77NWkwJDd17aVJ4DBYcOxXjwChxx78NOW8/hMo0bA+C6uYvCnfzfskZez1XAMkBTB8du4/FIMARpa61aZ1pMLypXD46JPXvOKRu6g1+ZrfWV3lxIRZJJ6pQ05jcOA3zPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c44birts; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718956506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/DzM3S1lYqPHGfQNE3s2md1ssVnUB4aDWLiC0OMtstI=;
	b=c44birtsPLQ/KRxTVLOrU2WaCy1Np6KOJZvdccrU8NL3X5ygcZfpbPgOGTOiuiH5DxThip
	p65dlLsSzqF6mibdo8opCdIIiniwMwr3mVytvEBO09zjSIKFpEUtIsyHWjmsE1YPl0QCON
	jGakdbqg7WcEbyMcPmyqF4mhw13YlkU=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hughd@google.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: shr@devkernel.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH v2 0/3] mm/ksm: cmp_and_merge_page() optimizations and
 cleanup
Date: Fri, 21 Jun 2024 15:54:28 +0800
Message-Id: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALQxdWYC/22NQQ6CMBBFr0K6dkw7FEhceQ/DooVRJkohLTYo6
 d2tuHX5XvLf30QgzxTEqdiEp8iBJ5cBD4XoBuNuBNxnFihRyxoVWA33MELojINpXnjkNwHVSpv
 SVIiqEXk6e7ryumcvbeaBwzL51/4S1df+ghXq/8GoQIKsSlsq2zfG6vOD3XM99hRFm1L6AOT20
 9+4AAAA
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, 
 aarcange@redhat.com, hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718956503; l=4828;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=jLA1H+y/05ddFVormNithidAIAVMdbemin5WLnmAX3M=;
 b=g2ZgHFx1HAZs4ZB+QDo8QKaBIN++N9TrIez8n5Qzm40axxA1trrwzZOYrA2ZkpsssQpjz+Agz
 kXxi8F6BtCbDhSUYsKlhPP0Gi/QNcMJQNBQ237b1Pi8R+sUIyBiRi2j
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=/XPhIutBo+zyUeQyf4Ni5JYk/PEIWxIeUQqy2DYjmhI=
X-Migadu-Flow: FLOW_OUT

Changes in v2:
- Fix the comments of try_to_merge_with_zero_page(), per David.
- Drop the last one patch in this version since it's a very rare case
  and hard to testing to prove.
- Rebase on the latest mm/mm-stable branch.
- Link to v1: https://lore.kernel.org/r/20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev

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

I have done simple testing using "hackbench -g 1 -l 300000" (maybe I need
to use a better workload) on my machine, have seen a little CPU usage
decrease of ksmd and some improvements of cmp_and_merge_page() latency:

We can see the latency of cmp_and_merge_page() when handling non-ksm
anon pages has been improved.

Thanks for review and comments!

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

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (3):
      mm/ksm: refactor out try_to_merge_with_zero_page()
      mm/ksm: don't waste time searching stable tree for fast changing page
      mm/ksm: optimize the chain()/chain_prune() interfaces

 mm/ksm.c | 250 +++++++++++++++++++++------------------------------------------
 1 file changed, 82 insertions(+), 168 deletions(-)
---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240621-b4-ksm-scan-optimize-e614a3a52217

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


