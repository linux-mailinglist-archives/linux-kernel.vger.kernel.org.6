Return-Path: <linux-kernel+bounces-322727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF9972CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE35B261E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79787187FF6;
	Tue, 10 Sep 2024 09:04:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CFC175568
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959063; cv=none; b=Rr4kobFfqI+w6LZvVqq41mA0orVcnjzVPFzy63k47kgCY4VvVNxYVDrwJQ4heFGzuLi3zsb2Jzb4nQVKdgaZEINnCZHV53DGwrTgUgQzOTiYFA5T/pOBkRPM8bHbtQDm3OEjecpu8eRcusZcId6opJmHM+2w0UZpkUNF1xNbXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959063; c=relaxed/simple;
	bh=+l8xZJ5Z2gudgi6cWpsuTSOuc0ht2cU5I4VjyI75N1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HxbGmfcA+BEVU6g2nfYEmDcMfQvoSXLXyG+U0lv1BHe/W8guZ8A/p7gffLj14EIp/m6JFycD2rnkPU7wSSNOXdCY3iKmU/tYk6wBOOc/4zf3/ZxdllNSSbW1lqZrmC+gv50vn/L6tHmFmbKuAIoekLAmgYsKDpXdOJQBn6W+AnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46256113E;
	Tue, 10 Sep 2024 02:04:48 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.63.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EB473F66E;
	Tue, 10 Sep 2024 02:04:15 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Drop unused set_pte_safe()
Date: Tue, 10 Sep 2024 14:34:09 +0530
Message-Id: <20240910090409.374424-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All set_pte_safe() usage have been dropped after the commit eccd906484d1
("x86/mm: Do not use set_{pud, pmd}_safe() when splitting a large page")
This just drops now unused helper set_pte_safe().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/pgtable.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc36..aeabbf0db7c8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1058,12 +1058,6 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
  * same value. Otherwise, use the typical "set" helpers and flush the
  * TLB.
  */
-#define set_pte_safe(ptep, pte) \
-({ \
-	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
-	set_pte(ptep, pte); \
-})
-
 #define set_pmd_safe(pmdp, pmd) \
 ({ \
 	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
-- 
2.30.2


