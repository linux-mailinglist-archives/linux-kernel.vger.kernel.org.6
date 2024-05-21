Return-Path: <linux-kernel+bounces-184851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269858CAD06
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3AB1F22E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBF7763FC;
	Tue, 21 May 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nzMjLmy3"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D9745E7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289423; cv=none; b=e1u/AlW6ZpnOE2n3AaDH5WMVZOJjBrKgQehiORt+b/bvCFVC3T6NzqQfU2TqW6cARZFGjaBrVSeWd1SNN2Po4msZOwD9W5UagQXxc4A+p6fkv7RRFa2U45vjOX3nmCihsHuITFuluuVQCpDwb/WJjmXye5yfybFUDdWy6JHDeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289423; c=relaxed/simple;
	bh=rc2tOhLkwkX3ybDr66V8237pfMfld4Tlo9Wq9wRfzIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tF7aMfd8EYYhmz4jF8xUzyRXGaJJ8Kx9CfAW0Ort78qQGPfZlM41zz7ve6EuAwMZmjcYzYryTas9khawoZa9ZwZZDr0nl0Qr2PxdOBVlZPI7U48gjyH2Pw8MybX8kLrVEjMpeKhBwAbfEopmB73jHdt6XcDtsHTsaWBR77MjHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nzMjLmy3; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716289414; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jRAtHbKubpnpADzITDXZT1b01GiilShGna80PhKpWSg=;
	b=nzMjLmy3ZA00agnVzDjG7nRemJ2J8K1qo4r4yJKo11Qfu19C9apclBzd40rzTaPT2yAezGz2vfwbDH0BOb+qpjpeDP6f0oN0pcSJW615OhhuvP1NauobnslPGlGjbJt57/NMlghbBRlRWT6kPh5tCBlcQMFwqeEZzx8/U4WrYDk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W6xeTAt_1716289410;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6xeTAt_1716289410)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 19:03:31 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	hrisl@kernel.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/8] mm: fix shmem swapout statistic
Date: Tue, 21 May 2024 19:03:11 +0800
Message-Id: <f467d0e9a021f4bd95588b9d888f1740fab3e3bc.1716285099.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
References: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we know, shmem not only supports the sharing of anonymous pages, but also
the RAM-based temporary filesystem. Therefore, shmem swapouts should not be
marked as anonymous swapout statistics. Fix it by adding folio_test_anon().

Fixes: d0f048ac39f6 ("mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/page_io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 46c603dddf04..b181b81f39e3 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -217,7 +217,9 @@ static inline void count_swpout_vm_event(struct folio *folio)
 		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
 	}
-	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
+
+	if (folio_test_anon(folio))
+		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
 #endif
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
-- 
2.39.3


