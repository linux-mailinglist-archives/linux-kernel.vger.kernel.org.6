Return-Path: <linux-kernel+bounces-569092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD926A69E70
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D99188EC12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF91C1AD4;
	Thu, 20 Mar 2025 02:52:55 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907228EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742439175; cv=none; b=VdlfI30Lnv9rK/SxOC4D13GwQaZlCHAkattBBCDA4lne82C/ZUkAaKPW2FRJKWTJ/WSkRGwKeHkeU08gcYJrrPlSE/lOcr6/3kSTALIBNdD04BaFad/XpXVKqUvd27OnbsL7nEzlOxfY3uDcsVGPhgg5b1pIE3wY6oyYG7byHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742439175; c=relaxed/simple;
	bh=Om7rubbuR8fJ9FLnreh+anuCSEnghxm8vYWcuW9FmAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ebBG26b6IGFrYQQEOs7jWcaDRzSbA+cNaakZhcd/VZ7I2JFFFDBaNPcnWmAyXkb2U6eQkPvsbLe+Ji+yR4AmZCmiam54UGdRUEh7DLexDhuN5k08d/UFsKPZKFfrUoDTiC//cfNEuQI2Sh2QrJbLDu3es6y1Xk/rf4zEuDh/5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZJ9963G85z4f3jcl
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:52:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2414E1A13D1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:52:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgAHW8X_gttnYGGmGw--.42197S2;
	Thu, 20 Mar 2025 10:52:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	tim.c.chen@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Minor cleanups and improvements to swap freeing code
Date: Thu, 20 Mar 2025 19:48:21 +0800
Message-Id: <20250320114829.25751-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHW8X_gttnYGGmGw--.42197S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW3ury8Kw4DZFykuF15Jwb_yoW8uw4kpF
	W3urnxGF18Jr1SywsxAw10q34rX3yrKF15J3W7ur1rZa43uF10qry0krZ5uFyDZ395ArWq
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

v2->v3:
-Extent VM_BUG_ON instead of remove it
-Keep bracket for more readability
-Collect RVG from Tim for rest part

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


