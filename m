Return-Path: <linux-kernel+bounces-322877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527A9731C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023BC28BFA6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28165190685;
	Tue, 10 Sep 2024 10:10:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB3188A0C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963046; cv=none; b=fFRgRZtIPUXuShmtwq5fhZj/aTjKevKz8b2vBwYY/nk/EMYq2nB57hg+v5Dmq50rZGNrepL+M0e3RWhb0wEDfirrhxhPjpTwL5UG8PGekgmwVSdf4LFlYRXUeuI6BW8RkFOalCj+zF46ygI5+s3R5qBpab1yt42YH3oTQKCq6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963046; c=relaxed/simple;
	bh=Okq17kxg/fgmaxV72FofOayjS2nLOUl4h5cqzTFEGC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hi1tHZ4wQqukKYS16pP+gupC4GadNPEJdjwjLM5IvWvfs6xVwu9JyWi5RThUPrffTeqQ/ePHTEx8Xctt5OJdLOYTy8yRyq1//xKj2FSCbBShUA7QWjUWh10os68Udcuir/DRgVleiy275J6pRaT8PpTWKAZbMDkbiuGrkX0Av8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AF9D106F;
	Tue, 10 Sep 2024 03:11:12 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.63.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50E4A3F66E;
	Tue, 10 Sep 2024 03:10:40 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm: Drop unused set_pte_safe()
Date: Tue, 10 Sep 2024 15:40:26 +0530
Message-Id: <20240910101026.428808-1-anshuman.khandual@arm.com>
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

Besides this macro was buggy due to doing direct dereferencing of the pte,
and if it were to be kept, it should have been updated to use a single call
to ptep_get().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Updated the commit message per Ryan

Changes in V1:

https://lore.kernel.org/all/20240910090409.374424-1-anshuman.khandual@arm.com/

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


