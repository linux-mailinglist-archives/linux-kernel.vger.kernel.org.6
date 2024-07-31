Return-Path: <linux-kernel+bounces-268491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B395594253C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B053B219BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5592940D;
	Wed, 31 Jul 2024 04:06:21 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855D182BD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722398781; cv=none; b=QPCpWWpSrXJ9XJL+YA/SVB2PZ61ZdBLHoD6imhibgTP7+san4iFT+9VQz5QOOQKnkkFWLEKi/fMyc5OWxUtSwtBJTH+otL38qvgdHM4FkjSxen1xd6udJmKXARB3GGyoKVLlGDfUNZgm7XQ81k652qICkeEVHTVLrRjb3Vf9rRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722398781; c=relaxed/simple;
	bh=4Bq4B/70G5HYBtwM9qoWsnUwKgAmo419xbWBOZoKSrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dokVUMbLqhVykM9y1BYXjN5RAs0AVQqucPVWhx2ixJvO7CpnD+FXKuf0ZQRtRhOf+xQBUSfg7yqtaGp0oJzEREEqbKoKQFDzHQmMjfUTGvM7hlizMpEGdUU8JfGP0zV1JKVhJU4wU5v8zUcko5B2DgmnSKZQkfouVAPuvyrj9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowAAnL0spuKlmWXZdAg--.7845S5;
	Wed, 31 Jul 2024 12:06:11 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 3/3] riscv: mm: Add uffd write-protect support
Date: Wed, 31 Jul 2024 12:04:44 +0800
Message-Id: <20240731040444.3384790-4-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731040444.3384790-1-zhangchunyan@iscas.ac.cn>
References: <20240731040444.3384790-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnL0spuKlmWXZdAg--.7845S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1UurWUCr4DXry8Aw1DZFb_yoWrWrW3pF
	s5Ga1rurWDJFn7KayfGrW8Kr4rZw45W34DXr9xua1kJFWUKrWDXF95Kw1aqryrXFWvv34x
	JrWrKr4rCr47AF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
	jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02
	Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	xeT5DUUUU
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBwoPB2apggyjiAABsu

Reuse PTE bit(9) for uffd-wp tracking and make it mutually exclusive
with soft-dirty and DEVMAP which all use this PTE bit.

Additionally for tracking the uffd-wp state as a pte swp bit,
we use swap entry pte bit(4) which is also used by swp
soft-dirty tracking.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 arch/riscv/Kconfig                    |  7 +++
 arch/riscv/include/asm/pgtable-bits.h | 13 ++++++
 arch/riscv/include/asm/pgtable.h      | 64 +++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d6ac55794c5f..e8aed24197c5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -971,6 +971,13 @@ config RISCV_HAS_SOFT_DIRTY
 	help
 	  The PTE bit(9) is used for soft-dirty tracking.
 
+config RISCV_HAS_USERFAULTFD_WP
+	bool "userfaultfd write protection"
+	select HAVE_ARCH_USERFAULTFD_WP
+	depends on USERFAULTFD
+	help
+	  The PTE bit(9) is used for userfaultfd write-protected
+	  tracking.
 endchoice
 
 endmenu # "Kernel features"
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index c6d51fe9fc6f..53b3fd12e8fa 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -38,6 +38,19 @@
 #define _PAGE_SWP_SOFT_DIRTY	0
 #endif /* CONFIG_MEM_SOFT_DIRTY */
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+/*
+ * CONFIG_HAVE_ARCH_USERFAULTFD_WP is mutually exclusive with
+ * HAVE_ARCH_SOFT_DIRTY so we can use the same bit for uffd-wp
+ * and soft-dirty tracking.
+ */
+#define _PAGE_UFFD_WP		(1 << 9) /* RSW: 0x2 for uffd-wp tracking */
+#define _PAGE_SWP_UFFD_WP	_PAGE_USER
+#else
+#define _PAGE_UFFD_WP           0
+#define _PAGE_SWP_UFFD_WP	0
+#endif
+
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ddf6e4f44252..c6e790e75309 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -417,6 +417,38 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
 }
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+static inline int pte_uffd_wp(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_UFFD_WP;
+}
+
+static inline pte_t pte_mkuffd_wp(pte_t pte)
+{
+	return pte_wrprotect(__pte(pte_val(pte) | _PAGE_UFFD_WP));
+}
+
+static inline pte_t pte_clear_uffd_wp(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_UFFD_WP));
+}
+
+static inline int pte_swp_uffd_wp(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_UFFD_WP;
+}
+
+static inline pte_t pte_swp_mkuffd_wp(pte_t pte)
+{
+	return pte_wrprotect(__pte(pte_val(pte) | _PAGE_SWP_UFFD_WP));
+}
+
+static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_SWP_UFFD_WP));
+}
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 /* static inline pte_t pte_mkread(pte_t pte) */
 
 static inline pte_t pte_mkwrite_novma(pte_t pte)
@@ -783,6 +815,38 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
 }
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+static inline int pmd_uffd_wp(pmd_t pmd)
+{
+	return pte_uffd_wp(pmd_pte(pmd));
+}
+
+static inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
+{
+	return pte_pmd(pte_mkuffd_wp(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
+{
+	return pte_pmd(pte_clear_uffd_wp(pmd_pte(pmd)));
+}
+
+static inline int pmd_swp_uffd_wp(pmd_t pmd)
+{
+	return pte_swp_uffd_wp(pmd_pte(pmd));
+}
+
+static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
+{
+	return pte_pmd(pte_swp_mkuffd_wp(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
+{
+	return pte_pmd(pte_swp_clear_uffd_wp(pmd_pte(pmd)));
+}
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline int pmd_soft_dirty(pmd_t pmd)
 {
-- 
2.34.1


