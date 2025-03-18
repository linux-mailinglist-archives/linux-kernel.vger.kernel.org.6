Return-Path: <linux-kernel+bounces-565530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0FA66A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAE77AA80E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA0B1EFF86;
	Tue, 18 Mar 2025 06:10:43 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847E1EF377
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278242; cv=none; b=Ov6hjb8VKNUugLoSwnKiloIe2sCszmhvG8Hv2ZL0WWnXPjozNrv8y6GJevsx4qv8nFgflZOuvfjNs0YCsq2+44tk6oJExotZrB3nZzSCHLaUKlJ68vBM2+yypnRwTN77tBTtfHx3fdiX01jNNtStGNjtIZCVN+Dd7aQduT96eVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278242; c=relaxed/simple;
	bh=eSJyje4Q+mqjnEodoWG9k4UIFrGy3hTJ1keLdHng/CU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o9Ss+1lkzhbXbrV9G1h3SnnEC0NfyrVv75H0q5QfGhqydMVaKG7ADin+G2qH4AhApNpQze+7Iy/CxdW92rkXo9JADGY4+xq+pO9IqBmUbPtP28Yf+q0YhQL92ZEC3hgeGETPhk63ULUCuAroQHRXdTcIOwzmFMvHGB61SarxEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH1fF4fG3z4f3jZd
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E34B01A1059
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgD3AGRVDtln65ErGw--.37695S2;
	Tue, 18 Mar 2025 14:10:30 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: tim.c.chen@linux.intel.com,
	ryncsn@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Minor cleanups and improvements to swap freeing code
Date: Tue, 18 Mar 2025 23:06:06 +0800
Message-Id: <20250318150614.6415-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3AGRVDtln65ErGw--.37695S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF43AF1DZw1fWF45Xw48tFb_yoW8ur4kpF
	W3urnxGF18JrnaywsxAw10q34rX3yrKF1UJ3W7ur1fZ3y3uF18Xry0krZ5ZryDA395JrWq
	qF40gryUuF4YvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0E
	n4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0A9N3UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

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
  mm: swap: remove unneeded VM_BUG_ON(*map != SWAP_HAS_CACHE) in
    swap_entry_range_free()
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

 mm/swapfile.c | 157 ++++++++++++++++++++++++--------------------------
 1 file changed, 75 insertions(+), 82 deletions(-)

-- 
2.30.0


