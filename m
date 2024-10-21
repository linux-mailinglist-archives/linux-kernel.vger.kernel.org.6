Return-Path: <linux-kernel+bounces-373705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274D19A5A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565E11C20985
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744D1CF5C1;
	Mon, 21 Oct 2024 06:37:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA33E194A49
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492643; cv=none; b=Ob3Fyi1Rn8RCdDjOOMLbG3UXoHmzb1ycUk9EkBEYDXagRNZwtHH41Xbs/SWFdNh0vr/XEfNAP8fo/vwXKhtfur/YxoSbX4mU+nqTwBX0tk7NwxHN0oCPhdJ14RLpDFTTnGtoNe9al8EZNt+3yYUC6L8pmo+6y0wUfsJ8DeSvV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492643; c=relaxed/simple;
	bh=rCw7/Accwh7BPnKS/ZEAq+5GbKFPBuisKRr1ajfqjvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADDYCDG3CGbD24jYuxH9Gz/zg9iY8i8PZLhL7xdys45LavbzOqBwRcZuZfw8KFr+GmYSEr9JsiUZlb/wKOLvGwrd/luQdufu6pbJTfpIWyrERcZSnjVCpJpkBvq1Xu8T1JaD5sOMCqR82bubUWa68V1aeK3qo6esIJq32yVNJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C193EDA7;
	Sun, 20 Oct 2024 23:37:50 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E07B13F71E;
	Sun, 20 Oct 2024 23:37:18 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop _PROT_SECT_DEFAULT
Date: Mon, 21 Oct 2024 12:07:13 +0530
Message-Id: <20241021063713.750870-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'commit db95ea787bd1 ("arm64: mm: Wire up TCR.DS bit to PTE shareability
fields")' dropped the last reference to symbol _PROT_SECT_DEFAULT, while
transitioning from PMD_SECT_S to PMD_MAYBE_SHARED for PROT_SECT_DEFAULT.
Hence let's just drop that symbol which is now unused.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.12-rc4

 arch/arm64/include/asm/pgtable-prot.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2a11d0c10760..84a099989f82 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -35,7 +35,6 @@
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
 #define PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_MAYBE_NG | PTE_MAYBE_SHARED | PTE_AF)
 #define PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_MAYBE_NG | PMD_MAYBE_SHARED | PMD_SECT_AF)
-- 
2.30.2


