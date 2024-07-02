Return-Path: <linux-kernel+bounces-237351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A62691EF8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282332836A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0DD14BF90;
	Tue,  2 Jul 2024 06:56:12 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCB1474CC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903372; cv=none; b=nV7K7abhH2h9QhrvYMlcHqPIVv9mkpTZQYMMg/8h9S9g8zTHKwaxVGM+1Kyy9O2PeVkAelsYKs9orpb5jFBfdEfoqcngFrZjHBgVEgRFKCXdYxiaw5khfs4o774gQpFHbz//9SUWHdF6Y0KEJGmBts3380uROejroPdFP3a/jA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903372; c=relaxed/simple;
	bh=QYWkB+WnDssmd9DGN5jYXiqns9mbm6vXxZHdt10Hd4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pk2VAumTJvqTEdJL7V0HfbjEpMLTV1o2peHcJtA60SBmL2PzduZxx4rGxsHMUxtr/VdSXnKb0oaLf36zWJUCotQv6niaQQ75/fD+ijcyTdA8U5+qpqOL9Dwu7uPOLHlXygaKh81MBCONXJpmJ+ju533leyX0q9xyikTfSoNBTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4626smGA034206;
	Tue, 2 Jul 2024 14:54:48 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 75DE92004BB3;
	Tue,  2 Jul 2024 14:58:53 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 2 Jul 2024 14:54:50 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <jiaoxupo@h3c.com>,
        <zhang.zhengming@h3c.com>, <zhang.zhansheng@h3c.com>,
        <shaohaojize@126.com>, zhangchun <zhang.chuna@h3c.com>
Subject: [PATCH] mm: fix kmap_high deadlock V2
Date: Tue, 2 Jul 2024 14:56:09 +0800
Message-ID: <1719903369-35385-1-git-send-email-zhang.chuna@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 4626smGA034206

I work with zhangzhansheng(from h3c) find that some situation
may casue deadlock when we use kmap_high and kmap_XXX or kumap_xxx
between  differt cores at the same time,  kmap_high->map_new_virtual->
flush_all_zero_pkmaps->flush_tlb_kernel_range->on_each_cpu. On this
condition, kmap_high hold the kmap_lock，wait the other cores respond
to ipi. But the others may disable irq and wait kmap_lock,
this is some deadlock condition. I think it's necessary to give
kmap_lock before call flush_tlb_kernel_range.
Like this:
spin_unlock(&kmap_lock);
flush_tlb_kernel_range(xxx);
spin_lock(&kmap_lock);

CPU 0:                cpu 1:
			kmap_xxx() {
xxx			irq_disable();
kmap_high();		spin_lock(&kmap_lock)
xxx			yyyyyyy
			spin_unlock(&kmap_lock)
			irq_enable();
			}
kmap_high detail:
kmap_high() {
	zzz
	spin_lock(&kmap_lock)
	map_new_virtual->
		flush_all_zero_pkmaps->
			flush_tlb_kernel_range->
				on_each_cpu
	/*
	if cpu 1 irq_disabled, the cpu 1
	cannot ack, then cpu 0 and cpu 1 may hangup.
	*/
	spin_unlock(&kmap_lock)
	zzz
}
Signed-off-by: zhangchun <zhang.chuna@h3c.com>

Reviewed-by: zhangzhengming <zhang.zhengming@h3c.com>
---
 mm/highmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index bd48ba4..841b370 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -220,8 +220,11 @@ static void flush_all_zero_pkmaps(void)
 		set_page_address(page, NULL);
 		need_flush = 1;
 	}
-	if (need_flush)
+	if (need_flush) {
+		spin_unlock(&kmap_lock);
 		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
+		spin_lock(&kmap_lock);
+	}
 }
 
 void __kmap_flush_unused(void)
-- 
1.8.3.1


