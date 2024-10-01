Return-Path: <linux-kernel+bounces-345211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA098B32D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215181F243C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F21BB6BE;
	Tue,  1 Oct 2024 04:58:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4B274BF8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727758695; cv=none; b=f4NX43M3E0i++Aqmk8wwhK47H3u6yuoxxe3oYd8+D4su+EVIZu/hQPG/BaYbESgHfttVnr2hBzvzla0sXNBmnJIx9jc7t8YEmu8VqeHe97YqFE3ZFOILRY6Aq7/Q/pfVxa26e0jBsp/YQSaLnUxgMmBQXloGu1nqDovy6SgakgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727758695; c=relaxed/simple;
	bh=0rcxiTQasVqAolAQjld7mMrkXR+8X5tq+GorzTEAINo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CPTQZ/Ev36gCq83f1QBaP243PGXiR7kZeHtOCOth9RcY1HvfqCDqiCtDRvm/2V70zXYKR0qyb0xpd2xygFZX1HuGss2NI7LqPhjG4FaINU4iAVSdY/Thabg3TdmPiBAKT96FAk0CkzxaoYmj9oYcW3M0XLwFvGUOCnM9+Ar66nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E81C2339;
	Mon, 30 Sep 2024 21:58:42 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3A593F587;
	Mon, 30 Sep 2024 21:58:10 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH] arm64/mm: Change pgattr_change_is_safe() arguments as pteval_t
Date: Tue,  1 Oct 2024 10:28:04 +0530
Message-Id: <20241001045804.1119881-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pgattr_change_is_safe() processes two distinct page table entries that just
happen to be 64 bits for all levels. This changes both arguments to reflect
the actual data type being processed in the function.

This change is important when moving to FEAT_D128 based 128 bit page tables
because it makes it simple to change the entry size in one place.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.12-rc1

 arch/arm64/include/asm/pgtable.h | 2 +-
 arch/arm64/mm/mmu.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c329ea061dc9..d56dbe5742d6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -338,7 +338,7 @@ static inline pte_t __ptep_get(pte_t *ptep)
 }
 
 extern void __sync_icache_dcache(pte_t pteval);
-bool pgattr_change_is_safe(u64 old, u64 new);
+bool pgattr_change_is_safe(pteval_t old, pteval_t new);
 
 /*
  * PTE bits configuration in the presence of hardware Dirty Bit Management
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e55b02fbddc8..c1b2d0dc3078 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -119,7 +119,7 @@ static phys_addr_t __init early_pgtable_alloc(int shift)
 	return phys;
 }
 
-bool pgattr_change_is_safe(u64 old, u64 new)
+bool pgattr_change_is_safe(pteval_t old, pteval_t new)
 {
 	/*
 	 * The following mapping attributes may be updated in live
-- 
2.25.1


