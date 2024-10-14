Return-Path: <linux-kernel+bounces-363883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992D99C822
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CD8B2913B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7E1CC891;
	Mon, 14 Oct 2024 11:01:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1A11CC892
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903685; cv=none; b=aAnQdZCHOKgpLMdnLtWm5i1dRUdQwRbZb59L9QfMoQ6D0CwVK6sJI+xWvKJQEbWEW2dLauishd05f/OdXQSWAX2Z4nQg/4bOUkOF0chr+QOhDE1cah9uWUtLoZhlqy7tKL+iF4j4LhvrJSHC2yk+gv//nOcwUk0NXSRvB1gJeW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903685; c=relaxed/simple;
	bh=GhwJFY5PT/dbmm4PJVMYDIxvOlsI9WdHtdSuD38uguk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ux2wN5zo7mUsc8RFmNsxyStoGEMY3g+MGwG3jX4Sl/4z9WyYqjPN4MyuEIUQTet+6A9ZLVh4GN91lJ3Yv7Od8pH8KTeFqKIu2U6G4hnbqxikQwahIKM2pPSgFAOA78mJQeybI4YDX/ZlUnEDaxv1eIhVS4AbnSlePKWya4QwjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1861F1756;
	Mon, 14 Oct 2024 04:01:53 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18CCC3F51B;
	Mon, 14 Oct 2024 04:01:20 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 37/57] arm64: Fix macros to work in C code in addition to the linker script
Date: Mon, 14 Oct 2024 11:58:44 +0100
Message-ID: <20241014105912.3207374-37-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously INIT_DIR_SIZE and INIT_IDMAP_DIR_SIZE used _end for the end
address of the kernel image. In the linker script context, this resolves
to an integer that refers to the link va of the end of the kernel image.
But in C code it resolves to a pointer to the end of the image as placed
in memory. So there are 2 problems; because its a pointer, we can't do
arithmetic on it. And because the image may be in a different location
in memory than the one it was linked at, it is not correct to find the
image size by subtracting KIMAGE_VADDR.

So introduce KIMAGE_VADDR_END, which always represents the link va of
the end of the kernel image as an integer.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/kernel-pgtable.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index bf05a77873a49..1722b9217d47d 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -35,6 +35,8 @@
 #define IDMAP_LEVELS		ARM64_HW_PGTABLE_LEVELS(IDMAP_VA_BITS)
 #define IDMAP_ROOT_LEVEL	(4 - IDMAP_LEVELS)
 
+#define KIMAGE_VADDR_END	(_AT(u64, _end) - _AT(u64, _text) + KIMAGE_VADDR)
+
 /*
  * A relocatable kernel may execute from an address that differs from the one at
  * which it was linked. In the worst case, its runtime placement may intersect
@@ -56,10 +58,10 @@
 	+ EARLY_LEVEL(3, (lvls), (vstart), (vend), add) /* each entry needs a next level page table */	\
 	+ EARLY_LEVEL(2, (lvls), (vstart), (vend), add)	/* each entry needs a next level page table */	\
 	+ EARLY_LEVEL(1, (lvls), (vstart), (vend), add))/* each entry needs a next level page table */
-#define INIT_DIR_SIZE (PAGE_SIZE * (EARLY_PAGES(SWAPPER_PGTABLE_LEVELS, KIMAGE_VADDR, _end, EXTRA_PAGE) \
+#define INIT_DIR_SIZE (PAGE_SIZE * (EARLY_PAGES(SWAPPER_PGTABLE_LEVELS, KIMAGE_VADDR, KIMAGE_VADDR_END, EXTRA_PAGE) \
 				    + EARLY_SEGMENT_EXTRA_PAGES))
 
-#define INIT_IDMAP_DIR_PAGES	(EARLY_PAGES(INIT_IDMAP_PGTABLE_LEVELS, KIMAGE_VADDR, _end, 1))
+#define INIT_IDMAP_DIR_PAGES	(EARLY_PAGES(INIT_IDMAP_PGTABLE_LEVELS, KIMAGE_VADDR, KIMAGE_VADDR_END, 1))
 #define INIT_IDMAP_DIR_SIZE	((INIT_IDMAP_DIR_PAGES + EARLY_IDMAP_EXTRA_PAGES) * PAGE_SIZE)
 
 #define INIT_IDMAP_FDT_PAGES	(EARLY_PAGES(INIT_IDMAP_PGTABLE_LEVELS, 0UL, UL(MAX_FDT_SIZE), 1) - 1)
-- 
2.43.0


