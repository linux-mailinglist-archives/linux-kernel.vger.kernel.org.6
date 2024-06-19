Return-Path: <linux-kernel+bounces-220768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297A790E6CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0521C2148A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C177FBD1;
	Wed, 19 Jun 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkJEyVUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6879DC7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788836; cv=none; b=f+I+h3UhNtCsuSMB6YQWza6yzmTpyqO5muMxRLz77nvhlE3E4rkSt4n0O4Gz5hqhbLzNcnLLTjafueNQGzNGEeSqOFa/LgWse0s5haDgecGOK/IuLqUuXZIyAG4N6vHeX2ZohR4cPsBtjrGm86WxlwCxOdSkVdhAPtjXA6cKmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788836; c=relaxed/simple;
	bh=COkjaeKz8fplJ2Dg3wgX4Wj7712CRaMzdyemxxKURNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OWlSsqkDPoYKMt6bD5pzwm3E+4LMdU2Tmiw2tne80SYsGzhSufRNDbSUm49PYY6rGngQT1XhfefwX7bg/u5bnRGfNS9kEKaF4l0sIyRLD3Gtzdpb65uB+bcdl8AGBeaSHU0E8vzi1CVgn3Wxtp6QjXfkWRF8nfMKwsxk1KlRES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkJEyVUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74094C2BBFC;
	Wed, 19 Jun 2024 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718788835;
	bh=COkjaeKz8fplJ2Dg3wgX4Wj7712CRaMzdyemxxKURNA=;
	h=From:Subject:Date:To:Cc:From;
	b=BkJEyVUbJYJggEbKPHubYTt8uEq+AnhSxxHyyE9szcog0Mhldx0glFjUUTioi0a3/
	 VF3YC7aAEOrhQZMfnftIR7hY6RO42Gl9txADrlIDHAtGeIRdjzcMbiUBKhqqO9PWpE
	 tnqmpl3l+rT4CRUCh3AKGAiy4mMiJEngj3iQEzJQtnx6ZqkCO3tuUW5b5DMRDVk1u/
	 VssPNiWuuCEmSCV0uGORAVu5WbA+vN8aGrT8aB+NKXT7Lx4HTMajtu3R/yqE4YfuuP
	 eLxyOVI8UbllFLuzSFUsgVpzgiKLbn8zR27YTyHH+BQG4bVYHLrHyxukQbbXPXzWeB
	 vQ98F8NlsMIeg==
From: Chris Li <chrisl@kernel.org>
Subject: [PATCH v3 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
Date: Wed, 19 Jun 2024 02:20:28 -0700
Message-Id: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANyicmYC/2WMwQ6CMBAFf4X0bE273QLx5H8YD6Uu0EgoaU3VE
 P7dQmKMepyXNzOzSMFRZIdiZoGSi86PGdSuYLY3Y0fcXTIzEIBCg+LxbiZuhsFbc/OBS63QYi3
 IErIsTYFa99iCp3Pm3sV8e279JNf1ncLfVJJccKzqUjYIqoHyeKUw0rD3oWNrK8HHL+W/D9kHo
 6Vq0FQttF/+siwvADQUQ+0AAAA=
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

This is the short term solutiolns "swap cluster order" listed
in my "Swap Abstraction" discussion slice 8 in the recent
LSF/MM conference.

When commit 845982eb264bc "mm: swap: allow storage of all mTHP
orders" is introduced, it only allocates the mTHP swap entries
from new empty cluster list.  It has a fragmentation issue
reported by Barry.

https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/

The reason is that all the empty cluster has been exhausted while
there are planty of free swap entries to in the cluster that is
not 100% free.

Remember the swap allocation order in the cluster.
Keep track of the per order non full cluster list for later allocation.

User impact: For users that allocate and free mix order mTHP swapping,
It greatly improves the success rate of the mTHP swap allocation after the
initial phase.

Barry provides a test program to show the effect:
https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@gmail.com/

Without:
$ mthp-swapout                                                          
Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%   
Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%                                                    
Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%   
Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%            
Iteration 5: swpout inc: 110, swpout fallback inc: 117, Fallback percentage: 51.54%                                                 
Iteration 6: swpout inc: 0, swpout fallback inc: 230, Fallback percentage: 100.00%          
Iteration 7: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00% 
Iteration 8: swpout inc: 0, swpout fallback inc: 223, Fallback percentage: 100.00%                                                  
Iteration 9: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%                                                  
Iteration 10: swpout inc: 0, swpout fallback inc: 216, Fallback percentage: 100.00%                                                 
Iteration 11: swpout inc: 0, swpout fallback inc: 212, Fallback percentage: 100.00%                                                 
Iteration 12: swpout inc: 0, swpout fallback inc: 224, Fallback percentage: 100.00%                                                 
Iteration 13: swpout inc: 0, swpout fallback inc: 214, Fallback percentage: 100.00%        

$ mthp-swapout -s
Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 5: swpout inc: 33, swpout fallback inc: 197, Fallback percentage: 85.65%
Iteration 6: swpout inc: 0, swpout fallback inc: 229, Fallback percentage: 100.00%
Iteration 7: swpout inc: 0, swpout fallback inc: 223, Fallback percentage: 100.00%
Iteration 8: swpout inc: 0, swpout fallback inc: 219, Fallback percentage: 100.00%
Iteration 9: swpout inc: 0, swpout fallback inc: 212, Fallback percentage: 100.00%

With:
$ mthp-swapout       
Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%                                                    
Iteration 2: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%                                                    
Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%                                                    
Iteration 4: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%       
Iteration 5: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00% 
Iteration 6: swpout inc: 230, swpout fallback inc: 0, Fallback percentage: 0.00%            
...
Iteration 94: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 95: swpout inc: 221, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 96: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 97: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 98: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 100: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%

$ mthp-swapout -s
Iteration 1: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 2: swpout inc: 227, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 4: swpout inc: 224, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 5: swpout inc: 230, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 6: swpout inc: 229, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 7: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 8: swpout inc: 219, swpout fallback inc: 0, Fallback percentage: 0.00%
...
Iteration 94: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 95: swpout inc: 212, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 96: swpout inc: 220, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 97: swpout inc: 220, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 98: swpout inc: 216, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 99: swpout inc: 223, swpout fallback inc: 0, Fallback percentage: 0.00%
Iteration 100: swpout inc: 225, swpout fallback inc: 0, Fallback percentage: 0.00%

Reported-by: Barry Song <21cnbao@gmail.com>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
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
Chris Li (2):
      mm: swap: swap cluster switch to double link list
      mm: swap: mTHP allocate swap entries from nonfull list

 include/linux/swap.h |  30 +++----
 mm/swapfile.c        | 248 +++++++++++++++++----------------------------------
 2 files changed, 95 insertions(+), 183 deletions(-)
---
base-commit: 19b8422c5bd56fb5e7085995801c6543a98bda1f
change-id: 20240523-swap-allocator-1534c480ece4

Best regards,
-- 
Chris Li <chrisl@kernel.org>


