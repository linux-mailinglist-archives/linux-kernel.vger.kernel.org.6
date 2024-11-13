Return-Path: <linux-kernel+bounces-407163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 155EA9C6989
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6958B25D66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891817C225;
	Wed, 13 Nov 2024 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gx+FAw0j"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9103178CEC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480821; cv=none; b=CIi1BThSNZITMm83FHsu7nSB5iyWRLxO1rBKlD6oRB7/hYgUCX29H90c1LF4PHp6sm4ZpQJodwXCUaScCjZAUY1ElsoplVamaZDEg75SuCjLv0Gbd4UkJOeHv+1rAQLsOHULWkCkAJB20lDwuyMZLRPhGEeSEE9sH/GXte+IDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480821; c=relaxed/simple;
	bh=gM1AmQUTdghXXMXy3xwH1FYMw0dVrg0YWgWl9YPT0Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVGhGnAcPZoaQoADsVW/vc+bVboaMRFlDtwRH4F6KC4kfqk0hDSFwhP5uFp+6Nu9cTsZdfN85iuYEgyz+XS4s+rsAhwJ0KaJIC+1TmuEu5UzoUygeWCjzBwN6JJY7OLuErCpAXlfOj9Ro3W+oG7yewLfKRaGwVyv4cs8sf3Aekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gx+FAw0j; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731480816; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rke6BBoCSHEi6qXFioYD5L856RErh718Aq4eT0sMXjI=;
	b=Gx+FAw0jpkK04Uco3xyp3SMh4b+LHUrRmlm9/PF/c9I6PaDkdafMuTPsqoLbzhFjvVTFd3glq7xuGVxp164+R+kfMmaTNrZE5WSv5QG3yFaBhUmDGNhm2m2wieKxmqrSJmCCxriClyma31R7DhPK7Vkxskhywy8o4g4VRYATRCM=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJK6noe_1731480814 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 14:53:35 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: baolin.wang@linux.alibaba.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	da.gomez@samsung.com,
	david@redhat.com,
	hughd@google.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org
Subject: [PATCH] mm: shmem: add large folio support for tmpfs fix
Date: Wed, 13 Nov 2024 14:53:28 +0800
Message-Id: <dfa8356b04fb2c9dfd908a7bbb353b942b0b113c.1731477422.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <eabd8c89fc1b4807eaf28750e04c44b718ae6487.1731397290.git.baolin.wang@linux.alibaba.com>
References: <eabd8c89fc1b4807eaf28750e04c44b718ae6487.1731397290.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As David suggested: "We can allow all orders up to MAX_PAGECACHE_ORDER,
since shmem_mapping_size_orders() handles it properly", therefore we can
drop the 'MAX_PAGECACHE_ORDER' condition.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a3203cf8860f..d54b24d65193 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -590,19 +590,19 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
 					      struct vm_area_struct *vma,
 					      unsigned long vm_flags)
 {
+	unsigned int maybe_pmd_order = HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER ?
+		0 : BIT(HPAGE_PMD_ORDER);
 	unsigned long within_size_orders;
 	unsigned int order;
 	pgoff_t aligned_index;
 	loff_t i_size;
 
-	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
-		return 0;
 	if (!S_ISREG(inode->i_mode))
 		return 0;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return 0;
 	if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
-		return BIT(HPAGE_PMD_ORDER);
+		return maybe_pmd_order;
 
 	/*
 	 * The huge order allocation for anon shmem is controlled through
@@ -619,12 +619,12 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
 	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
 		if (vma)
-			return BIT(HPAGE_PMD_ORDER);
+			return maybe_pmd_order;
 
 		return shmem_mapping_size_orders(inode->i_mapping, index, write_end);
 	case SHMEM_HUGE_WITHIN_SIZE:
 		if (vma)
-			within_size_orders = BIT(HPAGE_PMD_ORDER);
+			within_size_orders = maybe_pmd_order;
 		else
 			within_size_orders = shmem_mapping_size_orders(inode->i_mapping,
 								       index, write_end);
@@ -642,7 +642,7 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
 		fallthrough;
 	case SHMEM_HUGE_ADVISE:
 		if (vm_flags & VM_HUGEPAGE)
-			return BIT(HPAGE_PMD_ORDER);
+			return maybe_pmd_order;
 		fallthrough;
 	default:
 		return 0;
-- 
2.39.3


