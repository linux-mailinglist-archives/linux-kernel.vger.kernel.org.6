Return-Path: <linux-kernel+bounces-439787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749B9EB3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E2C2864A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41F1B422E;
	Tue, 10 Dec 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUNhEXNz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA61B2190
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842215; cv=none; b=cD1oyxx5/wo6nb0AH+t1zWTilTTDqVGC/LRaIOeQoEMKYkKc31P68xi6ixEEvkgDBwt8pMv5dveJl4QCnL4PUgVBDhGUuTsVaJSgWSZtxnQ4kjhKRTPpinSIMEtzxfCjNfSqDHqcbk8/VwD9A+CYpM5BndDOJJc0jrhojj1eQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842215; c=relaxed/simple;
	bh=mSDYe3/14oT8+6+Q/fUZOhctfsyXb85zYziAFN+aro0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irGmeh/iMK+YZHrN51kZj3A6TwDemC8/ii9JbV5uX8nbQPGaE9NP2cmwDeaJd5wpmlV65ph1CiP0/hEIOIIqXGIcb/zdDJZdsyVArOvqwsILkTqdC9wWQHWnuzJLgAb2cW+Hq3cTv210bUX3QkRg4/4Vjzolwz36uUilQ+JZjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUNhEXNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EB4C4CEDE;
	Tue, 10 Dec 2024 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842215;
	bh=mSDYe3/14oT8+6+Q/fUZOhctfsyXb85zYziAFN+aro0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUNhEXNzRItzOf7iLFdJoFQ9ZK6ngWKC/R0qyrZEixwhSuN2uLJkBDkQlXpv7UWLz
	 553xgOtzcLJrNmZQ2SY2t7YX3lrqUpg4qh5dVbjBn4BIPuWid2WiEbiuRtwEuVuArN
	 BTrLqJGiVYkpA9kC16t4q0oC3LkE4DLjrMvHT5on9n2i82Xn7baI8NWh26bcR2gQWr
	 zZKZgs8ShX3TUgK7RDePIKDd4FsrKBNkrtnhuIikzHpUJAl0xCz4O87JQWStAL+p8X
	 P20wzoKJQ4/jdAjkGSBLkbu5Tl1VPzrXl4yp9hxggo1JxRqkuSlxljwXQr0xJNvmjJ
	 l4pnhc1xnSt+Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 07/11] x86: drop SWIOTLB and PHYS_ADDR_T_64BIT for PAE
Date: Tue, 10 Dec 2024 15:49:41 +0100
Message-Id: <20241210144945.2325330-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210144945.2325330-1-arnd@kernel.org>
References: <20241210144945.2325330-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Since kernels with and without CONFIG_X86_PAE are now limited
to the low 4GB of physical address space, there is no need to
use either swiotlb or 64-bit phys_addr_t any more, so stop
selecting these and fix up the build warnings from that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig      | 2 --
 arch/x86/mm/pgtable.c | 5 +++--
 include/linux/mm.h    | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b373db8a8176..d0d055f6f56e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1456,8 +1456,6 @@ config HIGHMEM
 config X86_PAE
 	bool "PAE (Physical Address Extension) Support"
 	depends on X86_32 && X86_HAVE_PAE
-	select PHYS_ADDR_T_64BIT
-	select SWIOTLB
 	help
 	  PAE is required for NX support, and furthermore enables
 	  larger swapspace support for non-overcommit purposes. It
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 5745a354a241..b8f9e69b25c1 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -765,11 +765,12 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 {
 	u8 uniform;
+	struct resource res = DEFINE_RES_MEM(addr, PMD_SIZE);
 
 	mtrr_type_lookup(addr, addr + PMD_SIZE, &uniform);
 	if (!uniform) {
-		pr_warn_once("%s: Cannot satisfy [mem %#010llx-%#010llx] with a huge-page mapping due to MTRR override.\n",
-			     __func__, addr, addr + PMD_SIZE);
+		pr_warn_once("%s: Cannot satisfy %pR with a huge-page mapping due to MTRR override.\n",
+			     __func__, &res);
 		return 0;
 	}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c39c4945946c..7725e9e46e90 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -99,7 +99,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
 
 #ifndef DIRECT_MAP_PHYSMEM_END
 # ifdef MAX_PHYSMEM_BITS
-# define DIRECT_MAP_PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
+# define DIRECT_MAP_PHYSMEM_END	(phys_addr_t)((1ULL << MAX_PHYSMEM_BITS) - 1)
 # else
 # define DIRECT_MAP_PHYSMEM_END	(((phys_addr_t)-1)&~(1ULL<<63))
 # endif
-- 
2.39.5


