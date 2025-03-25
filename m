Return-Path: <linux-kernel+bounces-574827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F652A6EA83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D7216FEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC86A255238;
	Tue, 25 Mar 2025 07:30:07 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B18253F30
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887807; cv=none; b=IWN+b1fECfE+04uUEcenHQIqqpIkPyWHKEkfZ+MAgU511fKs7CGJB6QdhNsu35X4DHexY0KVMoVg9ixVRoxcsvp0OtLdOQEevPbIgBfXBtD/QbAJFl7SCpVgCe4t9taB84edVE7rd578YIc2/krwPAtM1Uw/peAPWS4SoW/bzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887807; c=relaxed/simple;
	bh=YECRja9/GvlP+EqnGR4CFjAf6P7kp3deMkCtqDhT/zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QRo4Zyymr7p1OPnepHWJNjsPFTOPVKDUsFIhJkFFbvRCRbsQPLZzZu4Sn172Gu6npzx8zJ7h6b8Nx537J4OVMOId26dxcm3MSNNexNYqBTjoLXpDfJcBTtHjDT7AGtb7B5gffFgSou6i8dppDEVqAhhLUVsYjQ6t4FFKBn/TIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZMM4f0nvlz4f3jqq
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 99AB51A08FF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgB3M2ZxW+JnZofaHQ--.14216S2;
	Tue, 25 Mar 2025 15:29:55 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	tim.c.chen@linux.intel.com,
	bhe@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] Minor cleanups and improvements to swap freeing code
Date: Wed, 26 Mar 2025 00:25:20 +0800
Message-Id: <20250325162528.68385-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3M2ZxW+JnZofaHQ--.14216S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWxWw4rWF4fWFWxArW8Zwb_yoW8tFWrpF
	WfurnxGF18Jr1fAwsxAw10q34rX3yrK3W3G3W7ur1rZa43uF1Fqry0krZ5uFyDZrZ5CrWq
	qF40gryUuF4YvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAa
	w2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUVcTmDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v3->v4:
-Collect RVB from Baoquan
-Grammatical correctness and typo fix in changelog.

v2->v3:
-Extent VM_BUG_ON instead of remove it
-Keep bracket for more readability
-Collect RVB from Tim for rest part

v1->v2:
-Collect RVB from Tim
-Drop patch to factor out __swap_entry_free()
-Improve changelog and add more comment.
-Avoid unneeded lock re-aquire

Hi All,
This series contains some cleanups and improvements which are made
during learning swapfile. Here is a summary of the changes:
1. Function nameing improvments.
-Use "put" instead of "free" to name functions which only do actual free
when count drops to zero.
-Use "entry" to name function only frees one swap slot. Use "entries" to
name function could may free multi swap slots within one cluster. Use
"_nr" suffix to name function which could free multi swap slots spanning
cross multi clusters.
2. Eliminate the need to set swap slot to intermediate SWAP_HAS_CACHE
value before do actual free by using swap_entry_range_free()
3. Add helpers swap_entries_put_map() and swap_entries_put_cache() as a
general-purpose routine to free swap entries within a single cluster
which will try batch-remove first and fallback to put eatch entry
indvidually with cluster lock acquired/released only once. By using 
these helpers, we could remove repeated code, levarage batch-remove in
more cases and aoivd to acquire/release cluster lock for each single
swap entry.

Kemeng Shi (8):
  mm: swap: rename __swap_[entry/entries]_free[_locked] to
    swap_[entry/entries]_put[_locked]
  mm: swap: enable swap_entry_range_free() to drop any kind of last ref
  mm: swap: use swap_entries_free() to free swap entry in
    swap_entry_put_locked()
  mm: swap: use swap_entries_free() drop last ref count in
    swap_entries_put_nr()
  mm: swap: drop last SWAP_MAP_SHMEM flag in batch in
    swap_entries_put_nr()
  mm: swap: free each cluster individually in swap_entries_put_map_nr()
  mm: swap: factor out helper to drop cache of entries within a single
    cluster
  mm: swap: replace cluster_swap_free_nr() with
    swap_entries_put_[map/cache]()

 mm/swapfile.c | 165 +++++++++++++++++++++++++-------------------------
 1 file changed, 83 insertions(+), 82 deletions(-)

-- 
2.30.0


