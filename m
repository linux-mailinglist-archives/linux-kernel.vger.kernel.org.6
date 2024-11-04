Return-Path: <linux-kernel+bounces-394204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D539BABCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498131C208D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587AA175D32;
	Mon,  4 Nov 2024 04:16:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20214EC59
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 04:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730693794; cv=none; b=SYfnXsVyOJ7NDzw9O995H7fduLMAvqvRUEXga6dGvbF5Jq7Qc/JFq6WEebQaMAM1+aPrE8v0eKsnlkUSVhB5h9TZeOTyjiLNLFni3l50+WBCYwahgnbE/a/1n6nrEVv+ZMmcgjMiEeLNjSl4giREo7YlCyTi7eoY3jnKT3/tj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730693794; c=relaxed/simple;
	bh=Yll2ECDRo9iwqyZAf1VY3howOk542bDr7QoBbGWjqHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhgxmNh0C/qWtf27hRbPmrR67joAxpJUe1gvPmxJ9waI2HfdbdN0CNf1J2DEDSRljVLFdnI9eoaUNlZpcVKrYq4xBr9ChJlgiU5EEraQmOxdO0i1cHMJqmNPB53itZ9K1ZlwYH3LMQnryjhIlMEe6GK2i4pMDJ9s9WOUD8sBnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FD4CFEC;
	Sun,  3 Nov 2024 20:16:55 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F78F3F6A8;
	Sun,  3 Nov 2024 20:16:22 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop setting PTE_TYPE_PAGE in pte_mkcont()
Date: Mon,  4 Nov 2024 09:46:17 +0530
Message-Id: <20241104041617.3804617-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTE_TYPE_PAGE bits were being set in pte_mkcont() because PTE_TABLE_BIT was
being cleared in pte_mkhuge(). But after arch_make_huge_pte() modification,
which dropped pte_mkhuge() completely, setting back PTE_TYPE_PAGE bits are
no longer necessary. Hence this changes pte_mkcont() to just set PTE_CONT.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.12-rc6 after applying the earlier arch_make_huge_pte()
re-organization patch.

https://lore.kernel.org/all/20241029044529.2624785-1-anshuman.khandual@arm.com/
 
 arch/arm64/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index fa4c32a9f572..17f7fb05e79e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -265,8 +265,7 @@ static inline pte_t pte_mkspecial(pte_t pte)
 
 static inline pte_t pte_mkcont(pte_t pte)
 {
-	pte = set_pte_bit(pte, __pgprot(PTE_CONT));
-	return set_pte_bit(pte, __pgprot(PTE_TYPE_PAGE));
+	return set_pte_bit(pte, __pgprot(PTE_CONT));
 }
 
 static inline pte_t pte_mknoncont(pte_t pte)
-- 
2.30.2


