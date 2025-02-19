Return-Path: <linux-kernel+bounces-520864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C9A3B035
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0BC3A5E23
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B9199FBA;
	Wed, 19 Feb 2025 03:57:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0F14B07A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937419; cv=none; b=AA3+u4IWCTKwQA/g64O0ZmbnX8a2kXN/37wuag6QuYYlirajsRya+TfQ2wag1OT5Xp65Bvd9Qu39El8JJjkIkfZAs7g652bpJM1dZ4oQsqOP5LAgsACjTsGjJsZxe58e3T49q5aeqfqoyi6YQRzKzzel30Lu9zct1N5MpMibEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937419; c=relaxed/simple;
	bh=isDZq/fsmnp9iyzlWtutpH2zlEjgBDhjMkBrNYkeZqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T+vzLT9C4YyPwmytbL3D4iV3azSId+oe2o37fIEUDYqs039CRRSHkh8TJzgV4qN/tkPmSZkoiWt1usNVqdSuyaP3r7qbMAgHKIQXEultuOU+cRADzyNx/aPJLjoqC8ZiCj2rtnqQpkZ3dtDLQfwgx7fDdFFYPSQe7OWbZuIiUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D42E1682;
	Tue, 18 Feb 2025 19:57:13 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2FDE3F5A1;
	Tue, 18 Feb 2025 19:56:52 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] arm64/mm: Explicit cast conversions to correct data type
Date: Wed, 19 Feb 2025 09:26:46 +0530
Message-Id: <20250219035646.536707-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Roberts <ryan.roberts@arm.com>

When CONFIG_ARM64_PA_BITS_52 is enabled, page table helpers __pte_to_phys()
and __phys_to_pte_val() are functions which return phys_addr_t and pteval_t
respectively as expected. But otherwise without this config being enabled,
they are defined as macros and their return types are implicit.

Until now this has worked out correctly as both pte_t and phys_addr_t data
types have been 64 bits. But with the introduction of 128 bit page tables,
pte_t becomes 128 bits. Hence this ends up with incorrect widths after the
conversions, which leads to compiler warnings.

Fix the warnings by explicitly casting to the correct type after doing the
conversion.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.14-rc3

 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..1da2421c9a15 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -84,8 +84,8 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
 }
 #else
-#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_LOW)
-#define __phys_to_pte_val(phys)	(phys)
+#define __pte_to_phys(pte)	((phys_addr_t)(pte_val(pte) & PTE_ADDR_LOW))
+#define __phys_to_pte_val(phys)	((pteval_t)(phys))
 #endif
 
 #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
-- 
2.25.1


