Return-Path: <linux-kernel+bounces-248695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE2D92E0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798921C21B15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F714B94B;
	Thu, 11 Jul 2024 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3RmEBU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A21474D3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682960; cv=none; b=d0TWm4v1FSimZah3c+sQwKjmA01yHb6NLhKD3dOD+B9jNKms6y65HFRX5suCcXd8KT7a/9K9U+Np2/N6D15cTHlxHawPXrXGeJU3v0e6VxukT/hhkT1nlQUSFy6uCCVmiZqVit7hGfZJUsh/JFcDeQRihjdp6ezloK6F8d4HVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682960; c=relaxed/simple;
	bh=ah7G4I/jvGKyUS1UQGL+VahXuGeap2epsi0AOoiBQFo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lv/dXL+KuSFmgrktsS/6COr2ZKndsrSYtkA+JxNBZvtQQke4cxl/LyUlYFkMBZM2ikX309cBrKtStuC+Tcml5byZ+h3R12XQCdqX3P5lyGeAQpKx26W4XupXTRoTNhq9om7mKC3PVmIAXGqKPp3vB5k9CEz030+rWPHKNI7QP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3RmEBU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB61C116B1;
	Thu, 11 Jul 2024 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720682960;
	bh=ah7G4I/jvGKyUS1UQGL+VahXuGeap2epsi0AOoiBQFo=;
	h=From:Subject:Date:To:Cc:From;
	b=k3RmEBU3JVJPkuQq8+QVS/cOexl5WCn1JLgduVW4ie536oanQHwzZhy1ZVUSgiAOy
	 vMlCW5Fm0L5FpbbZieP5qrXwH43pjyYlXn0JO5m4szLiKH0eB72IHqJpgmxuJTdwTk
	 2w6k85wkaVVBBRj7p0FuVRvnjVezGSjY1e9Oy7Amk+MH9plc+t9Pge08wFqfX+1O9S
	 nRDsLLHxTKg0hoVMP4gyL0spvWtgSRTsGTbyZFpGeLOPdZ+2KxYn4Bx8JMpmy67MSX
	 tKpLhrMu9tDbaRabZZUWAEd+uZx7d+LhU5XOlexqKkuJzNmbozJjSkLXYne0+6mh6n
	 +3GLIjqVsgPAw==
From: Chris Li <chrisl@kernel.org>
Subject: [PATCH v4 0/3] mm: swap: mTHP swap allocator base on swap cluster
 order
Date: Thu, 11 Jul 2024 00:29:04 -0700
Message-Id: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMCJj2YC/2XMyw6CMBCF4VchXVtDp8PNle9hXJQ6QCOhpDVVQ
 3h3C4nxwvJM5vsn5skZ8uyQTMxRMN7YIQ7cJUx3amiJm0vcDFLANAPJ/V2NXPW91epmHReZRI1
 lSpqQRTQ6asxjDZ7OcXfGx7fn2g9iub5T+J8KgqccizIXNYKsIT9eyQ3U761r2dIK8PG52HqIH
 lQmZI2qaKDZePntq42X0VNVSCVFfEH88fM8vwBhE+bQLQEAAA==
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

This is the short term solutions "swap cluster order" listed
in my "Swap Abstraction" discussion slice 8 in the recent
LSF/MM conference.

When commit 845982eb264bc "mm: swap: allow storage of all mTHP
orders" is introduced, it only allocates the mTHP swap entries
from the new empty cluster list.  It has a fragmentation issue
reported by Barry.

https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/

The reason is that all the empty clusters have been exhausted while
there are plenty of free swap entries in the cluster that are
not 100% free.

Remember the swap allocation order in the cluster.
Keep track of the per order non full cluster list for later allocation.

The patch 3 of this series gives the swap SSD allocation
a new separate code path from the HDD allocation. The new allocator
use cluster list only and do not global scan swap_map[] without lock
any more.

This streamline the swap allocation for SSD. The code matches the execution
flow much better.

User impact: For users that allocate and free mix order mTHP swapping,
It greatly improves the success rate of the mTHP swap allocation after the
initial phase.

It also performs faster when the swapfile is close to full, because the
allocator can get the non full cluster from a list rather than scanning
a lot of swap_map entries. 

This series still lacks the swap cache reclaim feature. The reclaim series
of patches are under development and testing right now. Will post the
mail list soon. For this reason, the patch 3 is consider RFC and not
ready to merge.

With Barry's mthp test program V2:

Without:
$ ./thp_swap_allocator_test -a
Iteration 1: swpout inc: 32, swpout fallback inc: 192, Fallback percentage: 85.71%
Iteration 2: swpout inc: 0, swpout fallback inc: 231, Fallback percentage: 100.00%
Iteration 3: swpout inc: 0, swpout fallback inc: 227, Fallback percentage: 100.00%
...
Iteration 98: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 99: swpout inc: 0, swpout fallback inc: 215, Fallback percentage: 100.00%
Iteration 100: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%

$ ./thp_swap_allocator_test -a -s
Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percentage: 100.00%
Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%
..
Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percentage: 100.00%
Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percentage: 100.00%
Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00%

$ ./thp_swap_allocator_test -s
Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percentage: 100.00%
Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%
..
Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percentage: 100.00%
Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percentage: 100.00%
Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00%

$ ./thp_swap_allocator_test
Iteration 1: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%
Iteration 2: swpout inc: 0, swpout fallback inc: 218, Fallback percentage: 100.00%
Iteration 3: swpout inc: 0, swpout fallback inc: 222, Fallback percentage: 100.00%
..
Iteration 98: swpout inc: 0, swpout fallback inc: 228, Fallback percentage: 100.00%
Iteration 99: swpout inc: 0, swpout fallback inc: 230, Fallback percentage: 100.00%
Iteration 100: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00%

With:
$ ./thp_swap_allocator_test -a
Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
...
Iteration 98: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 99: swpout inc: 215, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 100: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%

$ ./thp_swap_allocator_test -a -s
Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 4: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 5: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 6: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 7: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 8: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 9: swpout inc: 217, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 10: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 11: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 12: swpout inc: 232, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 13: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 14: swpout inc: 223, swpout fallback inc: 3, Fallback percentage: 1.33%
Iteration 15: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 16: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 17: swpout inc: 212, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 18: swpout inc: 234, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 19: swpout inc: 220, swpout fallback inc: 6, Fallback percentage: 2.65%
Iteration 20: swpout inc: 231, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 21: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 22: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 23: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 24: swpout inc: 232, swpout fallback inc: 1, Fallback percentage: 0.43%
Iteration 25: swpout inc: 215, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 26: swpout inc: 230, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 27: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 28: swpout inc: 225, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 29: swpout inc: 226, swpout fallback inc: 2, Fallback percentage: 0.88%
Iteration 30: swpout inc: 224, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 31: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 32: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 33: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 34: swpout inc: 226, swpout fallback inc: 2, Fallback percentage: 0.88%
Iteration 35: swpout inc: 230, swpout fallback inc: 3, Fallback percentage: 1.29%
Iteration 36: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 37: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 38: swpout inc: 221, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 39: swpout inc: 229, swpout fallback inc: 1, Fallback percentage: 0.43%
Iteration 40: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 41: swpout inc: 231, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 42: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 43: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 44: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 45: swpout inc: 221, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 46: swpout inc: 221, swpout fallback inc: 2, Fallback percentage: 0.90%
Iteration 47: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 48: swpout inc: 220, swpout fallback inc: 1, Fallback percentage: 0.45%
Iteration 49: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 50: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 51: swpout inc: 224, swpout fallback inc: 2, Fallback percentage: 0.88%
Iteration 52: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 53: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 54: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 55: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 56: swpout inc: 226, swpout fallback inc: 2, Fallback percentage: 0.88%
Iteration 57: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 58: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 59: swpout inc: 224, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 60: swpout inc: 229, swpout fallback inc: 1, Fallback percentage: 0.43%
Iteration 61: swpout inc: 217, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 62: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 63: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 64: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 65: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 66: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 67: swpout inc: 220, swpout fallback inc: 2, Fallback percentage: 0.90%
Iteration 68: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 69: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 70: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 71: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 72: swpout inc: 231, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 73: swpout inc: 218, swpout fallback inc: 5, Fallback percentage: 2.24%
Iteration 74: swpout inc: 223, swpout fallback inc: 5, Fallback percentage: 2.19%
Iteration 75: swpout inc: 222, swpout fallback inc: 7, Fallback percentage: 3.06%
Iteration 76: swpout inc: 226, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 77: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 78: swpout inc: 215, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 79: swpout inc: 223, swpout fallback inc: 2, Fallback percentage: 0.89%
Iteration 80: swpout inc: 222, swpout fallback inc: 1, Fallback percentage: 0.45%
Iteration 81: swpout inc: 218, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 82: swpout inc: 228, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 83: swpout inc: 229, swpout fallback inc: 1, Fallback percentage: 0.43%
Iteration 84: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 85: swpout inc: 213, swpout fallback inc: 1, Fallback percentage: 0.47%
Iteration 86: swpout inc: 215, swpout fallback inc: 8, Fallback percentage: 3.59%
Iteration 87: swpout inc: 222, swpout fallback inc: 1, Fallback percentage: 0.45%
Iteration 88: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 89: swpout inc: 222, swpout fallback inc: 6, Fallback percentage: 2.63%
Iteration 90: swpout inc: 224, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 91: swpout inc: 214, swpout fallback inc: 1, Fallback percentage: 0.47%
Iteration 92: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 93: swpout inc: 221, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 94: swpout inc: 223, swpout fallback inc: 2, Fallback percentage: 0.89%
Iteration 95: swpout inc: 222, swpout fallback inc: 1, Fallback percentage: 0.45%
Iteration 96: swpout inc: 223, swpout fallback inc: 4, Fallback percentage: 1.76%
Iteration 97: swpout inc: 223, swpout fallback inc: 7, Fallback percentage: 3.04%
Iteration 98: swpout inc: 227, swpout fallback inc: 1, Fallback percentage: 0.44%
Iteration 99: swpout inc: 229, swpout fallback inc: 1, Fallback percentage: 0.43%
Iteration 100: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%

$ ./thp_swap_allocator_test      
Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 134, swpout fallback inc: 98, Fallback percentage: 42.24%
Iteration 3: swpout inc: 72, swpout fallback inc: 154, Fallback percentage: 68.14%
Iteration 4: swpout inc: 40, swpout fallback inc: 183, Fallback percentage: 82.06%
Iteration 5: swpout inc: 27, swpout fallback inc: 199, Fallback percentage: 88.05%
Iteration 6: swpout inc: 22, swpout fallback inc: 202, Fallback percentage: 90.18%
Iteration 7: swpout inc: 12, swpout fallback inc: 216, Fallback percentage: 94.74%
Iteration 8: swpout inc: 14, swpout fallback inc: 214, Fallback percentage: 93.86%
Iteration 9: swpout inc: 5, swpout fallback inc: 221, Fallback percentage: 97.79%
Iteration 10: swpout inc: 10, swpout fallback inc: 218, Fallback percentage: 95.61%
...
Iteration 97: swpout inc: 12, swpout fallback inc: 207, Fallback percentage: 94.52%
Iteration 98: swpout inc: 8, swpout fallback inc: 219, Fallback percentage: 96.48%
Iteration 99: swpout inc: 16, swpout fallback inc: 218, Fallback percentage: 93.16%
Iteration 100: swpout inc: 10, swpout fallback inc: 218, Fallback percentage: 95.61%

$ ./thp_swap_allocator_test -s
Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 84, swpout fallback inc: 148, Fallback percentage: 63.79%
Iteration 3: swpout inc: 39, swpout fallback inc: 195, Fallback percentage: 83.33%
Iteration 4: swpout inc: 16, swpout fallback inc: 217, Fallback percentage: 93.13%
Iteration 5: swpout inc: 11, swpout fallback inc: 214, Fallback percentage: 95.11%
Iteration 6: swpout inc: 10, swpout fallback inc: 218, Fallback percentage: 95.61%
...
Iteration 96: swpout inc: 5, swpout fallback inc: 225, Fallback percentage: 97.83%
Iteration 97: swpout inc: 2, swpout fallback inc: 215, Fallback percentage: 99.08%
Iteration 98: swpout inc: 2, swpout fallback inc: 220, Fallback percentage: 99.10%
Iteration 99: swpout inc: 4, swpout fallback inc: 222, Fallback percentage: 98.23%
Iteration 100: swpout inc: 3, swpout fallback inc: 221, Fallback percentage: 98.66%

Kernel compile under tmpfs with cgroup memory.max = 2G.
12 core 24 hyperthreading, 32 jobs.

HDD swap 3 runs average, 20G swap file:

Without:
user	4186.290
system	421.743
real	597.317

With:
user	4113.897
system	413.123
real	659.543

SSD swap 10 runs average, 20G swap partition:

Without:
user	4736.810
system	500.921
real	250.243
 
With:
user	4729.478
system	500.265
real	249.633

Two zram swap:
zram0 1.4G zram1 20G.
The idea is forcing the zram0 almost
full then overflow to zram1:

Two zram 10 runs average:

Without:
user	4600.693
system	384.105
real	238.735

With:
user	4604.502
system	382.087
real	239.063

Reported-by: Barry Song <21cnbao@gmail.com>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
Changes in v4:
- Remove a warning in patch 2.
- Allocating from the free cluster list before the nonfull list. Revert the v3 behavior.
- Add cluster_index and cluster_offset function.
- Patch 3 has a new allocating path for SSD.
- HDD swap allocation does not need to consider clusters any more.

Changes in v3:
- Using V1 as base.
- Rename "next" to "list" for the list field, suggested by Ying.
- Update comment for the locking rules for cluster fields and list,
  suggested by Ying.
- Allocate from the nonfull list before attempting free list, suggested
  by Kairui.
- Link to v2: https://lore.kernel.org/r/20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org

Changes in v2:
- Abandoned.
- Link to v1: https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@kernel.org

---
Chris Li (3):
      mm: swap: swap cluster switch to double link list
      mm: swap: mTHP allocate swap entries from nonfull list
      RFC: mm: swap: seperate SSD allocation from scan_swap_map_slots()

 include/linux/swap.h |  30 ++--
 mm/swapfile.c        | 490 +++++++++++++++++++++++----------------------------
 2 files changed, 238 insertions(+), 282 deletions(-)
---
base-commit: ff3a648ecb9409aff1448cf4f6aa41d78c69a3bc
change-id: 20240523-swap-allocator-1534c480ece4

Best regards,
-- 
Chris Li <chrisl@kernel.org>


