Return-Path: <linux-kernel+bounces-430544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E239E3297
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC1D168B2E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281D17557C;
	Wed,  4 Dec 2024 04:11:41 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC28166307
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285501; cv=none; b=SkOslcVFJlC8NUXEVxUJcM1AKm/wPjKu2AIiv5IYBMV+dJOtFVtHJV/RA0hXRXoif8Uhb49g1d/3wy3ABD4gyLNITutNkDP36Dx7ZPleKrz1akSgGkbykvZOYVUKzExcTSY40ZCnaa19cW2F0PbyoxX/neJ6LTx2rD/IzJeykIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285501; c=relaxed/simple;
	bh=0FLPxstDmIviQ1UHzQ3H/WGXnLp/v483fyKV7P/sc4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BuaT1xDmzwixBVrVlip9P+ueQQpvaYlHSMmr40XXT0bn7zAZasXH6QjUpBKgCB5fEua0NbPvb9hyc/OmELLdcSnH8dx8T9nsl2WfuAIe69df1H3kc1S1AuL7QgPqU+E+IWhhZAflUzRaOEpRKsBy+PgQFIPAxWaRhlUAUuroXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y33x01TSjz4f3jJL
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:11:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2F7E21A0359
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:11:35 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBnQ8Bt1k9nusICDg--.38617S2;
	Wed, 04 Dec 2024 12:11:33 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	david@redhat.com,
	willy@infradead.org,
	ryan.roberts@arm.com,
	baohua@kernel.org,
	21cnbao@gmail.com,
	wangkefeng.wang@huawei.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com,
	xieym_ict@hotmail.com
Subject: [RFC PATCH v3 0/2] mm: vmscan: retry folios written back while isolated
Date: Wed,  4 Dec 2024 04:01:56 +0000
Message-Id: <20241204040158.2768519-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnQ8Bt1k9nusICDg--.38617S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1xZw4UJr13GryfKrWDCFg_yoW8CFWxpF
	n3WF13Kw1kGr43JwnxZ3Wagr1rC3y8Cr13Jr1fGa4Sya45uryj9Fy0934vvFWrGryDAFWr
	tr4Yqr9YgF1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrsqXDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The page reclaim isolates a batch of folios from the tail of one of the
LRU lists and works on those folios one by one.  For a suitable
swap-backed folio, if the swap device is async, it queues that folio for
writeback.  After the page reclaim finishes an entire batch, it puts back
the folios it queued for writeback to the head of the original LRU list.

In the meantime, the page writeback flushes the queued folios also by
batches.  Its batching logic is independent from that of the page reclaim.
For each of the folios it writes back, the page writeback calls
folio_rotate_reclaimable() which tries to rotate a folio to the tail.

folio_rotate_reclaimable() only works for a folio after the page reclaim
has put it back.  If an async swap device is fast enough, the page
writeback can finish with that folio while the page reclaim is still
working on the rest of the batch containing it.  In this case, that folio
will remain at the head and the page reclaim will not retry it before
reaching there.

This issue has been fixed for multi-gen LRU with commit 359a5e1416ca ("mm:
multi-gen LRU: retry folios written back while isolated"). Fix this issue
in the same way for active/inactive lru.

---
v3:
 - fix this issue in the same with way as multi-gen LRU.

v2:
 - detect folios whose writeback has done and move them to the tail
    of lru. suggested by Barry Song
[2] https://lore.kernel.org/linux-kernel/CAGsJ_4zqL8ZHNRZ44o_CC69kE7DBVXvbZfvmQxMGiFqRxqHQdA@mail.gmail.com/

v1:
[1] https://lore.kernel.org/linux-kernel/20241010081802.290893-1-chenridong@huaweicloud.com/

Chen Ridong (2):
  mm: vmascan: add find_folios_written_back() helper
  mm: vmscan: retry folios written back while isolated

 mm/vmscan.c | 108 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 32 deletions(-)

-- 
2.34.1


