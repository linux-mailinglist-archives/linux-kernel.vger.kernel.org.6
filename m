Return-Path: <linux-kernel+bounces-218704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6212690C41C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10E7B20A99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000ED80031;
	Tue, 18 Jun 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X12BZvlz"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895DE74BE1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693678; cv=none; b=ACZWt6P+zHX/AAHGcXfEz04kYPSyJTRh0QaPQpdl1C3mrwhrDq4nv+zF/RAj7Yhi67abwzhx7iHVOgKZGM8PEOuaOqzoMYMEqCWWU4Aih6HoB4k8h74qly5XxgWTR+t9OX2JDp0RHUUwUScbrKjTJv11iU670D/r2Dfa7iw3e+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693678; c=relaxed/simple;
	bh=0j0o/JJqbkPuCd3w9wnczyFRRX9ombob99obZa5CSFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+ehJBFyg7zHUCqjHqZtMm55ZkQdJWTOmbveKeDqtJRJc0LOxcy7Vnlpfl1oepJJal/Lz4wnlz1AqrWHy3bUD+uGBhxUApGdWVYlz+SjsF+Pdq2NKZqjfYu0kvO3MaBzv9wZ1s26m8MhTF5EoSKnNJWjrX9UmUZmZwwycpww3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X12BZvlz; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718693674; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OhkcTOgQo6MdSZjxEddX9KsK/pU+Rag0OqwoL0KeI6s=;
	b=X12BZvlzYEHEGso0VQ/0+4DyjCHOUQDR4VUOMb7d3FLyjaGdz8II8RV33NR1meY0QMi3smKKLbnxU/mVKFM6R3oJjHN7N448TfTieXUwHABLq5tNnqqGuRwoRNeoeV3DLkwpB22rOldX+iVkxJbVOOO32E7JM3d4JhduUmgfw4k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W8jFFLh_1718693672;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8jFFLh_1718693672)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 14:54:32 +0800
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
Subject: [PATCH v2 5/9] mm: filemap: use xa_get_order() to get the swap entry order
Date: Tue, 18 Jun 2024 14:54:17 +0800
Message-Id: <e718e4afb0a387dc04d0e3cb8440d8de20adb011.1718690645.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the following patches, shmem will support the swap out of large folios,
which means the shmem mappings may contain large order swap entries, so
using xa_get_order() to get the folio order of the shmem swap entry to
update the '*start' correctly.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/filemap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 876cc64aadd7..ecc785758aaf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2056,6 +2056,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		folio = fbatch->folios[idx];
 		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
+		else
+			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
 		*start = indices[idx] + nr;
 	}
 	return folio_batch_count(fbatch);
@@ -2120,6 +2122,8 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		folio = fbatch->folios[idx];
 		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
+		else
+			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
 		*start = indices[idx] + nr;
 	}
 	return folio_batch_count(fbatch);
-- 
2.39.3


