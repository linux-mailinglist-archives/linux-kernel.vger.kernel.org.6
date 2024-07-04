Return-Path: <linux-kernel+bounces-240954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEEC927509
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6166B1F23569
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C081AC25F;
	Thu,  4 Jul 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oStAhCsL"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10671ABC56
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092317; cv=none; b=LVodt/lZ0C28yGL8IPr/5+YxeblpYUerrRuNmY74StsOvk2uXPRmjIQpOe6fHtwQP2HrJ5OZZI+AamdwPh/t9MQ+wJ8GjNWosLaGczpmhq7FTsb3UAMcq7yLhb8MDDRO0ZBhO8Ec0ucxyiBewxfSUpTxBaPujoChz61Pv+GCsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092317; c=relaxed/simple;
	bh=nrB6IvDB2ONuQK/c1z1KKsx3TDOQ2TduIDwQM2Luk+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Go57PmwXV43N0acdWL/FVZs1t2qmx4c5A0VslWgtAbYCUkRmckwCEBgGnI8Ys2XweZyNXqKfKBFPZ6HR7vDMoNhsjbUgm7aFFhimy5ogK20EoHznvbZOO2U6+jthRHfaQpTAxal2tzE1M11RbPItTljgGcltSb6Svq4JtNQbmHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oStAhCsL; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720092312; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bjDtTTMdlmmldWh/OT1ZyYCpZPGPkV2gHwKUwOxuuNY=;
	b=oStAhCsLODir6y4rgQfL1ZGlfa+nnwKiji1bWz7yNL7o88MVhKywOXR4cG1IbDn9UpJnxVEJW5tb4sLhJM1e2/kcYDp9tEVN77rOOsJFC6km6wOQicdnYkD4gg8gUbnvuNZ9cR4E0wDOji6f8ZO0gFHeaDpMO1p5z2bGExBIjcI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9qjOx8_1720092310;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qjOx8_1720092310)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:25:10 +0800
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
Subject: [PATCH v3 03/10] mm: shmem: extend shmem_partial_swap_usage() to support large folio swap
Date: Thu,  4 Jul 2024 19:24:52 +0800
Message-Id: <16b2d5360b0a5588c21508714b1afa50c874f307.1720079976.git.baolin.wang@linux.alibaba.com>
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

To support shmem large folio swapout in the following patches, using
xa_get_order() to get the order of the swap entry to calculate the swap
usage of shmem.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6244b909b069..42bf3176fa6c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -881,7 +881,7 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 		if (xas_retry(&xas, page))
 			continue;
 		if (xa_is_value(page))
-			swapped++;
+			swapped += 1 << xa_get_order(xas.xa, xas.xa_index);
 		if (xas.xa_index == max)
 			break;
 		if (need_resched()) {
-- 
2.39.3


