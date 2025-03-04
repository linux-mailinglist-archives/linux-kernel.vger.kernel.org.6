Return-Path: <linux-kernel+bounces-544581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118DA4E2C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17EF19C2C65
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7816F283CB0;
	Tue,  4 Mar 2025 15:05:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA6283C90
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100710; cv=none; b=UFYRj50Kh2rHZng619GAOaKnNBEGqvu97YzDyanAxe6ZZA3lSKEJAZ1yQxRzCdxJrEfh/cJz9E7EZQzc56DvyktyTsG2DE0ChxCZybQtAZ4KfPlOZnl4Ws9l4WEBGK2qnj05d/3RKC9Zk8U4uxvY2WwjIwkjDDd6mNDvHP3XO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100710; c=relaxed/simple;
	bh=aYAYZ8yX3+DzCiiENiVNFGzYXz3TId8FNdWwH4AVEdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4njRR8KMNyZNngQpxoTNu2WQlOPi4q6p0eA3WnOq8/nQTgD7M6NjcW+ckYuq+J6Gwz+EzfAUlfrMtptyuIKTfM6nhYeEOQqhHCYZMaW9buHwc5wRL561xG2C7MWCPWvFBjPCNlYJKr2fpTec/X1GY6kPKk5UZVhw8pibGGTmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9595EFEC;
	Tue,  4 Mar 2025 07:05:21 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7FE3F66E;
	Tue,  4 Mar 2025 07:05:05 -0800 (PST)
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
Subject: [PATCH v3 06/11] arm64/mm: Hoist barriers out of set_ptes_anysz() loop
Date: Tue,  4 Mar 2025 15:04:36 +0000
Message-ID: <20250304150444.3788920-7-ryan.roberts@arm.com>
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

set_ptes_anysz() previously called __set_pte() for each PTE in the
range, which would conditionally issue a DSB and ISB to make the new PTE
value immediately visible to the table walker if the new PTE was valid
and for kernel space.

We can do better than this; let's hoist those barriers out of the loop
so that they are only issued once at the end of the loop. We then reduce
the cost by the number of PTEs in the range.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e255a36380dc..1898c3069c43 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -317,13 +317,11 @@ static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
 	WRITE_ONCE(*ptep, pte);
 }
 
-static inline void __set_pte(pte_t *ptep, pte_t pte)
+static inline void __set_pte_complete(pte_t pte)
 {
-	__set_pte_nosync(ptep, pte);
-
 	/*
 	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
-	 * or update_mmu_cache() have the necessary barriers.
+	 * has the necessary barriers.
 	 */
 	if (pte_valid_not_user(pte)) {
 		dsb(ishst);
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


