Return-Path: <linux-kernel+bounces-268489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FDC94253A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E45B23551
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7B1BDDF;
	Wed, 31 Jul 2024 04:06:20 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACEE17C77
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722398779; cv=none; b=gDItVT+zwlW4N3idpli30MOWjS5SvOZYZFy8ZwL4VT1J1MsEKNsdhpHG48dAJE7MdLtchc8g1B5slvNbSwlL46fhCfLbUpb9FS7QXhbKzS39MzhhXGWJEczG5eUEn6eCW4uQQ3i9WwST4W+vBxRY05xosPY39JTTekXWHBqdMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722398779; c=relaxed/simple;
	bh=fHF7Pg+H3XG0ZS5Yws0rBHuzSmnMTlJ6pNDblDw+Y74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZLPI1TFzSIMCe4ohXTcFSH0QQ9Tl7RMA62qK88ckWMOiSzG57sG4qbS5yfU8McV8Uvly6w81c16kRdGaS546NoPgLwF0r8OsIvu0xAvQoWaJQGM5kyaopExFprLbxmeU+rDcQlVxkJTCXf5i/ZcVZCTCXFXKQyBEBInCXdr6AOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowAAnL0spuKlmWXZdAg--.7845S3;
	Wed, 31 Jul 2024 12:06:07 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 1/3] riscv: mm: Prepare for reuse PTE RSW bit(9)
Date: Wed, 31 Jul 2024 12:04:42 +0800
Message-Id: <20240731040444.3384790-2-zhangchunyan@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAAnL0spuKlmWXZdAg--.7845S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4UKF47uw1UGr13AFy5urg_yoW8AryDpF
	s0kr9YkFWrCrySkay2yFnFgr4UAa98K3sIgry8ur4UJas8t3yUZ39xKw17Xay8Xa1vvF93
	GFWvg345ury3Jw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
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
	IasUDUUUU
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiDAYPB2apgQWjrQAAsH

The PTE bit(9) on RISC-V is reserved for software, it is used by DEVMAP
now which has to be disabled if we want to use bit(9) for other features,
since there's no more free PTE bit on RISC-V now.

So to make ARCH_HAS_PTE_DEVMAP selectable, this patch uses it as
the build condition of devmap definitions.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 arch/riscv/include/asm/pgtable-64.h   | 2 +-
 arch/riscv/include/asm/pgtable-bits.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 0897dd99ab8d..babb8d2b0f0b 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -398,7 +398,7 @@ static inline struct page *pgd_page(pgd_t pgd)
 #define p4d_offset p4d_offset
 p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_ARCH_HAS_PTE_DEVMAP)
 static inline int pte_devmap(pte_t pte);
 static inline pte_t pmd_pte(pmd_t pmd);
 
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index a8f5205cea54..5bcc73430829 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -19,7 +19,13 @@
 #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
 
 #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
+
+#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
 #define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
+#else
+#define _PAGE_DEVMAP	0
+#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
+
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
-- 
2.34.1


