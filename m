Return-Path: <linux-kernel+bounces-178782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A38C579A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7231C222A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2361459F4;
	Tue, 14 May 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tutFg42F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747101459E2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695518; cv=none; b=DmfEtWG82pbUp8Srk0xsgyLQEWIKII60uIatiVasSUA7MgmEmqCHXJdGExTaTPrrxypkPTyq+76amVelN8X9AiwiF2Gvtcbvf4/yzivXQs/xm7bHGFMP+d0nBXd9o4BRbq0raDuMxx7eOwTIyxx/ZmIKOwWOMuYOUIgRiVe2hnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695518; c=relaxed/simple;
	bh=pGRP84KXNHRvDwj4d3tBEvZ5yXWiOvKEJ5ie6tEwIpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTQrcCyYMvJz3tMZf7lW9xTeMIm6DACioCdsAZwMae+BRKRGxt8MXPAeN0IYJu8dgin7e82MRgiGgqVxEaKghx/W07nx2b2dBuGt8tBxo3XC4WSNaV+dbq2Plonsgm8uEwGV3BJe/m8Iem+Spy1vvo/2b4cg4e7uzc8Fe422riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tutFg42F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B219C32781;
	Tue, 14 May 2024 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695518;
	bh=pGRP84KXNHRvDwj4d3tBEvZ5yXWiOvKEJ5ie6tEwIpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tutFg42F+WZxo8OqjmYracQbf76JUHyChIpewLcaBxxXzAHL9f9NzUzxKpCwPQPMp
	 JAOf7a5DMjRYICN6Zd3nayVU2QucQqYBCAI8sN3NmvDZjznrg3QP+0FsKPkhBf5X1d
	 DjQUz7i2J5ltDjh2koA8AsRmQ0kDN4rVWu0JQFdPf4Vmy6PaVJo12jabRGD99LsIn6
	 QsnhffWfY2J+BIqE97O1tmA6XlKvqzaJOazwfm63YK7bQUZNkTJ0dnTNMdXBkL3W1n
	 IXNollIatVKhq1PFO/MKuIo9s9ffetE+5TaxWGUT6CgxwvGg7EYhSFKTurXIn/mT0T
	 2VnjGlsE++ceA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/8] riscv: mm: Refactor create_linear_mapping_range() for memory hot add
Date: Tue, 14 May 2024 16:04:41 +0200
Message-Id: <20240514140446.538622-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Add a parameter to the direct map setup function, so it can be used in
arch_add_memory() later.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/init.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c969427eab88..6f72b0b2b854 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1227,7 +1227,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 }
 
 static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
-						  uintptr_t fixed_map_size)
+						  uintptr_t fixed_map_size, const pgprot_t *pgprot)
 {
 	phys_addr_t pa;
 	uintptr_t va, map_size;
@@ -1238,7 +1238,7 @@ static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t
 					    best_map_size(pa, va, end - pa);
 
 		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
-				   pgprot_from_va(va));
+				   pgprot ? *pgprot : pgprot_from_va(va));
 	}
 }
 
@@ -1282,22 +1282,19 @@ static void __init create_linear_mapping_page_table(void)
 		if (end >= __pa(PAGE_OFFSET) + memory_limit)
 			end = __pa(PAGE_OFFSET) + memory_limit;
 
-		create_linear_mapping_range(start, end, 0);
+		create_linear_mapping_range(start, end, 0, NULL);
 	}
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, 0);
-	create_linear_mapping_range(krodata_start,
-				    krodata_start + krodata_size, 0);
+	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, 0, NULL);
+	create_linear_mapping_range(krodata_start, krodata_start + krodata_size, 0, NULL);
 
 	memblock_clear_nomap(ktext_start,  ktext_size);
 	memblock_clear_nomap(krodata_start, krodata_size);
 #endif
 
 #ifdef CONFIG_KFENCE
-	create_linear_mapping_range(kfence_pool,
-				    kfence_pool + KFENCE_POOL_SIZE,
-				    PAGE_SIZE);
+	create_linear_mapping_range(kfence_pool, kfence_pool + KFENCE_POOL_SIZE, PAGE_SIZE, NULL);
 
 	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
 #endif
-- 
2.40.1


