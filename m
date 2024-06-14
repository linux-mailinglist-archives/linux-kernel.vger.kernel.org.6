Return-Path: <linux-kernel+bounces-215607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCCD9094D9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C75287667
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D655187561;
	Fri, 14 Jun 2024 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r55ZX3Wn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96EC12E61
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718408893; cv=none; b=MNe0OIbDLTveYKYgzg9cgZTHooK7hv1VBTpXKUCmgTSofwSw7J8r63/7GeytVcOkFt9f1K65k6oJqjPC3ToObgUA0eENPCtd2T8HMKShlPv7W3SfJKggtEkCSr5G7K6jc/IJFdI/mcZwaImzOAt/FJ00RaJpTWNeqolFnPCEP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718408893; c=relaxed/simple;
	bh=7rZ0unu2/SVRtrNWYASpCkCRRJyZVysK1s+WYY0kNN4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gkz1U1sufQdbEjv1eknAizTA9nhlBLYLWehB91LWzEDiWJcHzS3kmucBUFL/gt1F4LtlIZ+HdV945wCT1SWqV+i5YG28W8d/iC+p6kVG70KWq5CfUS8Awrip4UgboZajp8DZN9G4KG3RIxdSkwSGyy8Mj+O/Zomds6t+Si46w7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r55ZX3Wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17185C2BD10;
	Fri, 14 Jun 2024 23:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718408893;
	bh=7rZ0unu2/SVRtrNWYASpCkCRRJyZVysK1s+WYY0kNN4=;
	h=From:Subject:Date:To:Cc:From;
	b=r55ZX3WnPgw2PioxOEVDpxu2C4ufHfovPXKCkdh5qkWsOcbcLhfaPy/AmT3ZYC8wQ
	 yNdArvsz71CUMzj/iLraHfGW+rDJtCYN4UxzgN6ejlJsKgjC/opaar//dpgBeWqboI
	 hl9iPNBCR4XV3/SccizoJ5jkHftRub5y+D7kQXFi00ob139M7DV7uB+7DCWTeGW3gE
	 3/T7kOY9UQ0IIjKr1pR7WD7BPt+PZT7qgEeA4PR6P5HfJfHpnorWgZZOOMHYGYSZuT
	 69xjzQoboPiPj/+D9AuN4zGgOzXqeJFLNyfOiJxU3OAfPWKcwt6gHvz2efk36XBZh7
	 slo3mnfMM77JQ==
From: Chris Li <chrisl@kernel.org>
Subject: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
Date: Fri, 14 Jun 2024 16:48:06 -0700
Message-Id: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALbWbGYC/13MTQrCMBCG4auUWRvJz7QWV72HdJHGsQ2GpCQSl
 ZK7GwtuXL7DfM8GiaKlBOdmg0jZJht8DXlowCzaz8TstTZILpG3UrH01CvTzgWjHyEy0So02HM
 yhFBHa6Sbfe3gZay92FTf3rufxff6o/CfyoJxhqe+ExNKNcluuFP05I4hzjCWUj5nyDiUrQAAA
 A==
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

The mTHP allocation failure rate raises to almost 100% after a few
hours in Barry's test run.

The reason is that all the empty cluster has been exhausted while
there are planty of free swap entries to in the cluster that is
not 100% free.

Remember the swap allocation order in the cluster.
Keep track of the per order non full cluster list for later allocation.

This greatly improve the sucess rate of the mTHP swap allocation.

There is some test number in the V1 thread of this series:
https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@kernel.org

Reported-by: Barry Song <21cnbao@gmail.com>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
Changes in v2:
- Add the cluster state field to track the different phases of
  cluster allocations.
- Rename "next" to "list" for the list field, suggested by Ying.
- Update comment for the locking rules for cluster fields and listi,
  suggested by Ying.
- Nonfull list avoid cluster on the per cpu active cluster.
- Allocate from the nonfull list before attempting free list, suggested
  by Kairui.
- Link to v1: https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@kernel.org

---
Chris Li (2):
      mm: swap: swap cluster switch to double link list
      mm: swap: mTHP allocate swap entries from nonfull list

 include/linux/swap.h |  31 +++---
 mm/swapfile.c        | 270 ++++++++++++++++++---------------------------------
 2 files changed, 107 insertions(+), 194 deletions(-)
---
base-commit: 19b8422c5bd56fb5e7085995801c6543a98bda1f
change-id: 20240523-swap-allocator-1534c480ece4

Best regards,
-- 
Chris Li <chrisl@kernel.org>


