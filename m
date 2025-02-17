Return-Path: <linux-kernel+bounces-517783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A62A3859D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160763B4F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B3E2236ED;
	Mon, 17 Feb 2025 14:08:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679B21D586
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801317; cv=none; b=ca1kLmz65jHaDdEAGo1csknvs3gcFEdIJqsRtpAxYtuWQzwICpse+r7IVbQWgiztSFk/b1BlTGqTg3ZFvQq49Ch8G55suoEOkMZ3E1w4AE7OFLErLoF7NJWX0KhJdqTZyBCxpSZzWmXnV/dOdHkEc/3UuEZsGu3vSntD31+pr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801317; c=relaxed/simple;
	bh=SX4OTafAaulA5O7xFZ6alYY8jRcMtmSuUfViWgmLzFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW06YyDdsC6ofIerqErpLzd0HKEd3kjBDfn3xw+DCmwa5KW43DI0a4B2CCiQL1rOmNKMHPqSc0YcQl28ovFvumKiesYP0rnXLWriGKMhIiWUaZeX1/X7GbASFH1z7u56r3rIOojo1+A9tNk2tP/sO68yRl/fw1O9Tih94MgR2w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA4601E5E;
	Mon, 17 Feb 2025 06:08:54 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BF713F6A8;
	Mon, 17 Feb 2025 06:08:33 -0800 (PST)
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
Subject: [PATCH v2 06/14] arm64/mm: Hoist barriers out of set_ptes_anysz() loop
Date: Mon, 17 Feb 2025 14:07:58 +0000
Message-ID: <20250217140809.1702789-7-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217140809.1702789-1-ryan.roberts@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_ptes_anysz() previously called __set_pte() for each PTE in the
range, which would conditionally issue a DSB and ISB to make the new PTE
value immediately visible to the table walker if the new PTE was valid
and for kernel space.

We can do better than this; let's hoist those barriers out of the loop
so that they are only issued once at the end of the loop. We then reduce
the cost by the number of PTEs in the range.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e255a36380dc..e4b1946b261f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -317,10 +317,8 @@ static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
 	WRITE_ONCE(*ptep, pte);
 }
 
-static inline void __set_pte(pte_t *ptep, pte_t pte)
+static inline void __set_pte_complete(pte_t pte)
 {
-	__set_pte_nosync(ptep, pte);
-
 	/*
 	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
 	 * or update_mmu_cache() have the necessary barriers.
@@ -331,6 +329,12 @@ static inline void __set_pte(pte_t *ptep, pte_t pte)
 	}
 }
 
+static inline void __set_pte(pte_t *ptep, pte_t pte)
+{
+	__set_pte_nosync(ptep, pte);
+	__set_pte_complete(pte);
+}
+
 static inline pte_t __ptep_get(pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
@@ -647,12 +651,14 @@ static inline void set_ptes_anysz(struct mm_struct *mm, pte_t *ptep, pte_t pte,
 
 	for (;;) {
 		__check_safe_pte_update(mm, ptep, pte);
-		__set_pte(ptep, pte);
+		__set_pte_nosync(ptep, pte);
 		if (--nr == 0)
 			break;
 		ptep++;
 		pte = pte_advance_pfn(pte, stride);
 	}
+
+	__set_pte_complete(pte);
 }
 
 static inline void __set_ptes(struct mm_struct *mm,
-- 
2.43.0


