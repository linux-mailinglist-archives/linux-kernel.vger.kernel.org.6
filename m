Return-Path: <linux-kernel+bounces-559441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A1A5F3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60823A98E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22873266EFE;
	Thu, 13 Mar 2025 12:09:30 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46F146585
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867769; cv=none; b=qr1aGr6XHydFRuOuX5Xzi/Nmt8nOka31+uA0SUxjkhIHg9t5S9ZPBTQ0dJddayi0lXO5C9VtjYxMX2f9umDmjT4ZM20KK6+IjqYjHnN0LpESLK0dX/YVKpi8rl7CvhrApYMeWxsam3sfFXoVDnmjt0vD2gNJ7g3zbOdkmi7hFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867769; c=relaxed/simple;
	bh=Toe05CGuFIzZSAtZ+R/jLB87y//iL+v6NXBc4JHjgL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=alCGIipOqq+m2a3ae/oSqDx65VKNISboZLAnHmQ9sApX5fWp11ASeuavubzgC2858NkGstkmeGYuynKQN6+tLirS3zBGGf/I7EXE/7dSpCi/gMz1t9KBY7dNazxXToh9kbMObJr1boF3uLfySItB14T8jdr2/vF0SJf/5DXkF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZD5rX2XGrz4f3mHV
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 407631A1195
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCnsGPyytJnTaZeGQ--.9643S2;
	Thu, 13 Mar 2025 20:09:24 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] Minor cleanups and improvements to swap freeing code
Date: Fri, 14 Mar 2025 05:05:06 +0800
Message-Id: <20250313210515.9920-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnsGPyytJnTaZeGQ--.9643S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF43AF1DZw1fWF45Xw48tFb_yoW8ZF1fpF
	W3uwnxGF18JrnaywsxAw10qryrX3yrKF47G3W7ur18Zw43uF18XryjyrZ5ZFyDA395JrWq
	qF48K34UuF4YvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUsBMNUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

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

Kemeng Shi (9):
  mm: swap: rename __swap_[entry/entries]_free[_locked] to
    swap_[entry/entries]_put[_locked]
  mm: swap: factor out the actual swap entry freeing logic to new helper
  mm: swap: use __swap_entry_free() to free swap entry in
    swap_entry_put_locked()
  mm: swap: remove unneeded VM_BUG_ON(*map != SWAP_HAS_CACHE) in
    swap_entry_range_free()
  mm: swap: use swap_entries_free() drop last 1 flag in
    swap_entries_put_nr()
  mm: swap: drop last SWAP_MAP_SHMEM flag in batch in
    swap_entries_put_nr()
  mm: swap: free each cluster individually in swap_entries_put_map_nr()
  mm: swap: factor out helper to drop cache of entries within a single
    cluster
  mm: swap: replace cluster_swap_free_nr() with
    swap_entries_put_[map/cache]()

 mm/swapfile.c | 173 +++++++++++++++++++++++++-------------------------
 1 file changed, 86 insertions(+), 87 deletions(-)

-- 
2.30.0


