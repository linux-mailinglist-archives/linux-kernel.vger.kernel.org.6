Return-Path: <linux-kernel+bounces-240965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0AB92751C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94B31F249DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C731B0123;
	Thu,  4 Jul 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wGowpd2A"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111E1AC449
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092326; cv=none; b=Ack3k7mJSqxv2ln7xKgTfVcANS2Ce68BblILaEf+NmnETE4pzOQHGMCCAWJipcsMAV8nVuZPFx/3f3JK8Kya3sxMVMWxD3GE8LqZDX3lyWyajR/A4Xbk2q3G7pub3UyaKTube5Gg6UGkUuW4RQvKbtxzRHX1LQO+STn8th5u5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092326; c=relaxed/simple;
	bh=W4k8pQxtESx74QX5w98fYmUE49+hI7/Jd5f3a/KoVSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYbAri/7Vt7WSyyFBXHHMmxUlrBw1jja2eh+2Ffcqp2jsufBJYDg3ktl/yAVB952i3Re54+278ZD4EWkVeVbwQ1lIr6WhTyQFgE8wS8HNvMz/TjR5svjgHmWq+/0FcIDmeM4JETwbcowBIYdUtfuR2+9NshiOvd7c8VbmVpe70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wGowpd2A; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720092317; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lRtF0SmyYSxOdTg4TDG7az1S/WCMj7v41FB3x6ABx2s=;
	b=wGowpd2AnJSi+U10Xowe1qk1KCXBXaBMrx3kmgBsU6aHGBgfjW4o0nLlWb1vWZa67K3QVV4U7TrcdnduYixuFxrBR/M+reaOXXrgPWREoUht79mpK+LTbJizsFnT89NMqG65xIZDChpUunKTY+RJH8dYz5qgiUN6a3taE94zuBM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9qWV5d_1720092315;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qWV5d_1720092315)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:25:16 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] mm: shmem: drop folio reference count using 'nr_pages' in shmem_delete_from_page_cache()
Date: Thu,  4 Jul 2024 19:24:57 +0800
Message-Id: <871ca0ed707c6245c04751523f384d4832bed13a.1720079976.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
References: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support large folio swapin/swapout for shmem in the following patches,
drop the folio's reference count by the number of pages contained in the
folio when a shmem folio is deleted from shmem pagecache after adding
into swap cache.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1718da7eefab..eb030827f7fb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -842,7 +842,7 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
 	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
 	__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
 	xa_unlock_irq(&mapping->i_pages);
-	folio_put(folio);
+	folio_put_refs(folio, nr);
 	BUG_ON(error);
 }
 
-- 
2.39.3


