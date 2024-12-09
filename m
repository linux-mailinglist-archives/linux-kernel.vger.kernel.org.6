Return-Path: <linux-kernel+bounces-436992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588CC9E8DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0F62813CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4D2156F2;
	Mon,  9 Dec 2024 08:46:22 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E78142903
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733982; cv=none; b=ZeKXwtDVhM72xBYE2njqTXUXmQ1cWSRhDru6r3dnYAwOKRbB6q5MSHUf3wK2j3WdmJFjba+fXlcbMjUlwT4E7gMwDbtArF6pif25ftZJ3v5nznmB1tbqIeyHj4QW4ImM/phX9FMtNpqCDHSkg1dHMRU5wWcx/f6/4CCO7RNOPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733982; c=relaxed/simple;
	bh=90HUZJKxP0lJ5JvseYPHcVAIJlH0Zmt1umhhTRXq0T4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bFd3j9O7wD06ftveDEg+73+JIB28DSDGZjg1PuYt+SIaHLXtG1RAGENZdDoBVtJjGwO1E5lSzFrFfIyYm5i6eEq6OnBEDOOgn0fFjQ6TBgNjtRSt0EcBCDwUG5Dt93vtdLIlPvfk3OOxMuK5dDUW39Bx8ANzcg8dRBIGofy8CSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y6FnW5YtLz4f3jsM
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:45:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EB8001A0196
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:46:10 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgAX8oVArlZn1gthEA--.6675S2;
	Mon, 09 Dec 2024 16:46:08 +0800 (CST)
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
Subject: [PATCH v4 0/1] mm: vmascan: retry folios written back while isolated for traditional LRU
Date: Mon,  9 Dec 2024 08:36:17 +0000
Message-Id: <20241209083618.2889145-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAX8oVArlZn1gthEA--.6675S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfZw13Aw4rCF48Zw45trb_yoW8uF1UpF
	n3W3W3tr1kGr13KwsxuF1avr15C395Cw13JFn3Ga4Sva4Uu34j9Fy0934vvFW8Grn8CFyr
	tr4Ygr9YgFWUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written back
while isolated") only fixed the issue for mglru. However, this issue
also exists in the traditional active/inactive LRU. Fix this issue
in the same way for active/inactive lru.

What is fixed:
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

---
v4:
 - conbine patch 1 and patch 2 together in v3.
 - refine commit msg.
 - fix builds errors reported-by: kernel test robot <lkp@intel.com>.
v3:
 - fix this issue in the same with way as multi-gen LRU.

v2:
 - detect folios whose writeback has done and move them to the tail
    of lru. suggested by Barry Song
[2] https://lore.kernel.org/linux-kernel/CAGsJ_4zqL8ZHNRZ44o_CC69kE7DBVXvbZfvmQxMGiFqRxqHQdA@mail.gmail.com/

v1:
[1] https://lore.kernel.org/linux-kernel/20241010081802.290893-1-chenridong@huaweicloud.com/

Chen Ridong (1):
  mm: vmascan: retry folios written back while isolated for traditional
    LRU

 include/linux/mmzone.h |   3 +-
 mm/vmscan.c            | 108 +++++++++++++++++++++++++++++------------
 2 files changed, 77 insertions(+), 34 deletions(-)

-- 
2.34.1


