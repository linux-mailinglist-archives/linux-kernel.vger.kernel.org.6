Return-Path: <linux-kernel+bounces-544582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B5A4E381
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2118A01A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F96B279336;
	Tue,  4 Mar 2025 15:05:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB48C283CB7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100712; cv=none; b=JM5yUALtKZhex3VKJTAqlIHS6LW8CH0HVeaoFRVIjTlwsEvyXDkA9zHYZ3zKDl6Qq37cfXGrYNwI+yQTXSJ9LIvas65NAiZ4gkpC+lYg1sRuvFGIs7mxZiFjwt231llvrjbjapohZ8lRLThX4bS9d8dGpIB+/3rHK5JSbT8cheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100712; c=relaxed/simple;
	bh=9tjQNeVEY23qc2oAD5I6b8y2928mds9+8XfKGIYSDm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTcrmk6ZyCUtZhFiT+54L7qXjxrm4mvtZdayjBOjcDZ8hpJZe8BCsj0E0zuB699oUX7Nih43B8nX81dbytzztJCGqztsKh5dSzGow9QDmigPfOr8qzp/9LsvEoW3UZG5KYh6f/hnxbu+4MYTzvapjQPL6yG4djlN1mRGBHCTxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B52451007;
	Tue,  4 Mar 2025 07:05:23 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EEE23F66E;
	Tue,  4 Mar 2025 07:05:08 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] mm/vmalloc: Warn on improper use of vunmap_range()
Date: Tue,  4 Mar 2025 15:04:37 +0000
Message-ID: <20250304150444.3788920-8-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304150444.3788920-1-ryan.roberts@arm.com>
References: <20250304150444.3788920-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A call to vmalloc_huge() may cause memory blocks to be mapped at pmd or
pud level. But it is possible to subsequently call vunmap_range() on a
sub-range of the mapped memory, which partially overlaps a pmd or pud.
In this case, vmalloc unmaps the entire pmd or pud so that the
no-overlapping portion is also unmapped. Clearly that would have a bad
outcome, but it's not something that any callers do today as far as I
can tell. So I guess it's just expected that callers will not do this.

However, it would be useful to know if this happened in future; let's
add a warning to cover the eventuality.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/vmalloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a6e7acebe9ad..fcdf67d5177a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -374,8 +374,10 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		if (cleared || pmd_bad(*pmd))
 			*mask |= PGTBL_PMD_MODIFIED;
 
-		if (cleared)
+		if (cleared) {
+			WARN_ON(next - addr < PMD_SIZE);
 			continue;
+		}
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		vunmap_pte_range(pmd, addr, next, mask);
@@ -399,8 +401,10 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (cleared || pud_bad(*pud))
 			*mask |= PGTBL_PUD_MODIFIED;
 
-		if (cleared)
+		if (cleared) {
+			WARN_ON(next - addr < PUD_SIZE);
 			continue;
+		}
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		vunmap_pmd_range(pud, addr, next, mask);
-- 
2.43.0


