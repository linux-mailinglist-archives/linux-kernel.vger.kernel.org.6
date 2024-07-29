Return-Path: <linux-kernel+bounces-265874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CFF93F721
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1131F2824CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D832614EC71;
	Mon, 29 Jul 2024 13:59:27 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA761E515
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261567; cv=none; b=l++TBxpE8+TKluaa587WJqfY/sFXTbCtN1buCCx+ToNvsBLxUsCNEPn5gUI20cuvwczEQ6UtGmShDNoMSqERBR4i7TXU6Xb5BfEtWfoz9GTO6j5f4IhtDuAn18awRvYOlbPf/mJ8q2DL+AlzpC/Gp6WyXQs4BGIlSFyoovEWmKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261567; c=relaxed/simple;
	bh=LVDUmFv7UA9ijcy4nvqrOeIdryfWQmOVHnYWex4La00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TYn5KV/e0Eam45G8hdc6IXIV78I8gA//ffaNbjjFdD8iuJeEvFWZEPiIj+FyWtXdhhy+FWxZkVo8I0xfFlq9bvQ0y26zOIYuykOMtrtfDxYyPo3aYFty1vfC5UdffJ1/uByEa1/4vZI90lzg/BZ5jBJKVcCLowOvscsYFhaua8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 46TCCCSI027469
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:12:12 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 46TCBa6O026906;
	Mon, 29 Jul 2024 20:11:36 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id D99332004721;
	Mon, 29 Jul 2024 20:16:19 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Mon, 29 Jul 2024 20:11:39 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <jiaoxupo@h3c.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shaohaojize@126.com>, <zhang.chuna@h3c.com>,
        <zhang.zhansheng@h3c.com>, <zhang.zhengming@h3c.com>
Subject: [PATCH v3] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Mon, 29 Jul 2024 20:13:08 +0800
Message-ID: <1722255188-4478-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 46TCCCSI027469

 CPU 0:                                                 CPU 1:
 kmap_high(){                                           kmap_xxx() {
               ...                                        irq_disable();
        spin_lock(&kmap_lock)
               ...
        map_new_virtual                                     ...
           flush_all_zero_pkmaps
              flush_tlb_kernel_range         /* CPU0 holds the kmap_lock */
                      smp_call_function_many         spin_lock(&kmap_lock)
                      ...                                   ....
        spin_unlock(&kmap_lock)
               ...

CPU 0 holds the kmap_lock, waiting for CPU 1 respond to IPI. But CPU 1 has
disabled irqs, waiting for kmap_lock, cannot answer the IPI. Fix this by 
releasing kmap_lock before call flush_tlb_kernel_range, avoid kmap_lock
deadlock.

        if (need_flush) {
            unlock_kmap();
            flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
            lock_kmap();
        }

Dropping the lock like this is safe. kmap_lock is used to protect
pkmap_count, pkmap_page_table and last_pkmap_nr(static variable). 
When call flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP)), 
flush_tlb_kernel_range will neither modify nor read these variables. 
Leave that data unprotected here is safe.

map_new_virtual aims to find an usable entry pkmap_count[last_pkmap_nr].
When read and modify the pkmap_count[last_pkmap_nr], the kmap_lock is 
not dropped. "if (!pkmap_count[last_pkmap_nr])" determine 
pkmap_count[last_pkmap_nr] is usable or not. If unusable, try agin.

Furthermore, the value of static variable last_pkmap_nr is stored in
a local variable last_pkmap_nr, when kmap_lock is acquired, this is 
thread-safe.

In an extreme case, if Thread A and Thread B access the same last_pkmap_nr,
Thread A calls function flush_tlb_kernel_range and release the kmap_lock,
and Thread B then acquires the kmap_lock and modifies the variable
pkmap_count[last_pkmap_nr]. After Thread A completes the execution 
of function the variable pkmap_count[last_pkmap_nr]. After Thread A 
completes the execution of function flush_tlb_kernel_range, it will
check the variable pkmap_count[last_pkmap_nr].

static inline unsigned long map_new_virtual(struct page *page)
{
        unsigned long vaddr;
        int count;
        unsigned int last_pkmap_nr; // local variable to store static variable last_pkmap_nr
        unsigned int color = get_pkmap_color(page);

start:
      ...
                        flush_all_zero_pkmaps();// release kmap_lock, then acquire it
                        count = get_pkmap_entries_count(color);
                }
                ...
                if (!pkmap_count[last_pkmap_nr]) // pkmap_count[last_pkmap_nr] is used or not
                        break;  /* Found a usable entry */
                if (--count)
                        continue;

               ...
        vaddr = PKMAP_ADDR(last_pkmap_nr);
        set_pte_at(&init_mm, vaddr,
                   &(pkmap_page_table[last_pkmap_nr]), mk_pte(page, kmap_prot));

        pkmap_count[last_pkmap_nr] = 1;
        ...
        return vaddr;
}

Fixes: 3297e760776a ("highmem: atomic highmem kmap page pinning")
Signed-off-by: zhangchun <zhang.chuna@h3c.com>
Co-developed-by: zhangzhansheng <zhang.zhansheng@h3c.com>
Signed-off-by: zhangzhansheng <zhang.zhansheng@h3c.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: zhangzhengming <zhang.zhengming@h3c.com>
---
 mm/highmem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index ef3189b..07f2c67 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -231,8 +231,18 @@ static void flush_all_zero_pkmaps(void)
 		set_page_address(page, NULL);
 		need_flush = 1;
 	}
-	if (need_flush)
+	if (need_flush) {
+		/*
+		 * In multi-core system one CPU holds the kmap_lock, waiting
+		 * for other CPUs respond to IPI. But other CPUS has disabled
+		 * irqs, waiting for kmap_lock, cannot answer the IPI. Release
+		 * kmap_lock before call flush_tlb_kernel_range, avoid kmap_lock
+		 * deadlock.
+		 */
+		unlock_kmap();
 		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
+		lock_kmap();
+	}
 }
 
 void __kmap_flush_unused(void)
-- 
1.8.3.1


