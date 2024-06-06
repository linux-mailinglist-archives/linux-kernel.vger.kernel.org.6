Return-Path: <linux-kernel+bounces-204217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E1D8FE5F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A890F288C32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3734DA14;
	Thu,  6 Jun 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aGYlBpUs"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAC19596C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675159; cv=none; b=eDxciIEGJyRntcKihPif88FShtdZtDt7tAQmgHjQQR4QEXjwJZmyc4aEKkxITEt2oscBI5K/Rm7mczZAEvDkCvBbclPCXS3X8KcjVsyC8wM487Vb8v64KdsHszydydoPBUdDAGnB82g6nthCoyMlmtwjEQZgIy3YJWi5yKOYDHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675159; c=relaxed/simple;
	bh=b3ofusNovId4cRoSubuTegS38gGdSYyOQ2tUiNCWnmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXNLN7jDBBMAGrGtBDd8II/9aDvx96NATJSpk7INi6jBfVpx06Y+jqzNO9mHij05D7+DeusqyPuywS77ApqufB8zGmSIUL3MFl9fQMBmtwKMuAB/eujgkOmXcMOm9FytTbT66LoBAjuR+LBjxGoWgeGGfDcnEAHUTppmWkiNSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aGYlBpUs; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717675155; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6L2s5n2sjWQ9jCz7vuGuOZ+fZmIEW+s447Fnt0+HHXo=;
	b=aGYlBpUs+IHwplrsJKybxO6Wt0Y/iWc5bmRfbUtPiJ9sM038kBfcjNXiAMQ8X87zEKyumGPOMeONihniOiZh7JPUZZQRpJktNabKzCfzWFuf8QHJgtSxLBEN6VhvC6pSPs5GEMzspYFa86zmwhu++1KUtPVL5ApAF7eUDvR2M9o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W7y5mvE_1717675153;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7y5mvE_1717675153)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 19:59:14 +0800
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
Subject: [PATCH 3/7] mm: shmem: support large folio allocation for shmem_replace_folio()
Date: Thu,  6 Jun 2024 19:58:53 +0800
Message-Id: <230e35b2fdc13c6199d8437e4cb6f68fded4072d.1717673614.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support large folio swapin for shmem in the following patches, add
large folio allocation for the new replacement folio in shmem_replace_folio(),
as well as updating statistics using the number of pages in the folio.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 174d8ae25b9b..eefdf5c61c04 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1889,7 +1889,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	 */
 	gfp &= ~GFP_CONSTRAINT_MASK;
 	VM_BUG_ON_FOLIO(folio_test_large(old), old);
-	new = shmem_alloc_folio(gfp, 0, info, index);
+	new = shmem_alloc_folio(gfp, folio_order(old), info, index);
 	if (!new)
 		return -ENOMEM;
 
@@ -1910,11 +1910,13 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	xa_lock_irq(&swap_mapping->i_pages);
 	error = shmem_replace_entry(swap_mapping, swap_index, old, new);
 	if (!error) {
+		int nr_pages = folio_nr_pages(old);
+
 		mem_cgroup_migrate(old, new);
-		__lruvec_stat_mod_folio(new, NR_FILE_PAGES, 1);
-		__lruvec_stat_mod_folio(new, NR_SHMEM, 1);
-		__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -1);
-		__lruvec_stat_mod_folio(old, NR_SHMEM, -1);
+		__lruvec_stat_mod_folio(new, NR_FILE_PAGES, nr_pages);
+		__lruvec_stat_mod_folio(new, NR_SHMEM, nr_pages);
+		__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -nr_pages);
+		__lruvec_stat_mod_folio(old, NR_SHMEM, -nr_pages);
 	}
 	xa_unlock_irq(&swap_mapping->i_pages);
 
-- 
2.39.3


