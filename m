Return-Path: <linux-kernel+bounces-316127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B487996CB92
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355EBB22CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA331361;
	Thu,  5 Sep 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfpMKzG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C692F621;
	Thu,  5 Sep 2024 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495131; cv=none; b=CMUFlXPWKbabi72C8DyXAafebknXto4j+sEKq9SJcPZIfxPVs7I9mHB5+XN5kgi91BqqNGHD3s1l5Ar1fLSLTniej3sIn3N5PVhDx//31W63NMhv86nPLip1cf3MDHvkOevBbWLcAceKh96vGoIG/kAtKi8yAzinjetkR5FRXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495131; c=relaxed/simple;
	bh=ot9I2Ee5hZbVpoV8bGx/1aoSYYU+azevoKMQDnXh7Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9mTD/AGw6pZ8IWVKC9pH8advokJJNUwpT8aOtAf0YHY0ebHE3/luoMGRqVlKSc4BD4GVTTe/Cz8dmLWCpy5y6tGdEe22i7T9OR6hoCqqwPVQqx1mvqCfpTQLzfI+WXa1IXATyfUzKOa+HXrpaSfFzY0YlDLsPpTAMcUS+5+Zuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfpMKzG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7ECC4CEC2;
	Thu,  5 Sep 2024 00:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725495131;
	bh=ot9I2Ee5hZbVpoV8bGx/1aoSYYU+azevoKMQDnXh7Ak=;
	h=From:To:Cc:Subject:Date:From;
	b=nfpMKzG4pw/I6Fb28XLxgiaUe4liVbXrW/g+urZOZRvdfo7TWn24bfTKch833D9hu
	 3gYfSETVlMFI6LfHABbm7iKEP+R3+pZVxlYXaCPRIWTe1o7Vz1YmzUz/IQGuC2emOL
	 uuF03bP0xbVEGHP8H6H84W/n1AjZqEJBOg19rPln4css8x4ZGyIyHr10ii56HH/3aJ
	 iaaBG+jlIHVn2WUCc76jIozvAahtA69V93Uslurz1wGX1e/jpKmItcQCtAr0M99X5R
	 e6dYAcqqqCeLAPYV6xxtT5TPjs/EF0nVqWVK6WviiZe4m30jJzqq60R//Fl+Lrmn9E
	 g/qkw6gUKUOdg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	David Hildenbrand <david@redhat.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon/vaddr: protect vma traversal in __damon_va_thre_regions() with rcu read lock
Date: Wed,  4 Sep 2024 17:12:04 -0700
Message-Id: <20240905001204.1481-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Traversing VMAs of a given maple tree should be protected by rcu read
lock.  However, __damon_va_three_regions() is not doing the protection.
Hold the lock.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/b83651a0-5b24-4206-b860-cb54ffdf209b@roeck-us.net
Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b0e8b361891d..08cfd22b5249 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -126,6 +126,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 	 * If this is too slow, it can be optimised to examine the maple
 	 * tree gaps.
 	 */
+	rcu_read_lock();
 	for_each_vma(vmi, vma) {
 		unsigned long gap;
 
@@ -146,6 +147,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 next:
 		prev = vma;
 	}
+	rcu_read_unlock();
 
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
 		return -EINVAL;
-- 
2.39.2


