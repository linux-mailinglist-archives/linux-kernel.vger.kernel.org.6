Return-Path: <linux-kernel+bounces-282735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D87694E802
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCAF1C21ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3099416D4E6;
	Mon, 12 Aug 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E6Omb59K"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0065167DA4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448556; cv=none; b=D3oOjxCq8yUv1o2+QtwUkHdNiOLNoM/nN/lEWxIQmrcwKyM0VxGQzsowzurn9rXeDgGTsWbi06MTzISGKXWCVtT/gmn1Te7x4wG0T66b685qCzJGSqhE8WbgUnVhwBWbCPYQ56SPWss1//TonUDZsigjenor6SfwAhMPlsSd+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448556; c=relaxed/simple;
	bh=u9rNPtYk720ssVEKO/QfyAhPgGcp45dwY7nlKRUHczU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=biI63dQIvxpk8P/nPWpkl+TwTwA0O3udEBdyiheBHjrd5E77UmgAzHAz4jF5dDCtHcyzR1M39y1w2AKqBjMzN90xhdSptKOmSPm7Iyyu2UzxYWjy48Al0htwdn1bESinRGqewWhabeeHvemvk6FaTtE7jd3kRIbr/fBZu5AQRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E6Omb59K; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723448547; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HTq6ByUKYopHbBOucaa7TnUS458Ur1YounHQqWHqN9Y=;
	b=E6Omb59KxBW10MwmDv8gZmA3aiVsEivAfHXW16N/XooKXU8jJ4v2ro9V6YeWxerPcMfFdViXoWrXbHDuJPyr4gy51+W3YeoyR1UNcBvUimdrC289Azqm3bx5OdFgZu/lApkS4p9HDaykToZ8pWJPjywV6HLYP/eQktRkTSopcbc=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCazOjj_1723448544)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 15:42:25 +0800
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
Subject: [PATCH v5 7/9] mm: shmem: drop folio reference count using 'nr_pages' in shmem_delete_from_page_cache()
Date: Mon, 12 Aug 2024 15:42:08 +0800
Message-Id: <b371eadb27f42fc51261c51008fbb9a334985b4c.1723434324.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
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
index d94f02ad7bd1..345e25425e37 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -851,7 +851,7 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
 	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
 	__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
 	xa_unlock_irq(&mapping->i_pages);
-	folio_put(folio);
+	folio_put_refs(folio, nr);
 	BUG_ON(error);
 }
 
-- 
2.39.3


