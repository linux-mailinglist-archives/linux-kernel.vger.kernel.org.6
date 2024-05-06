Return-Path: <linux-kernel+bounces-170099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F968BD1D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29CE1F24BE4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD274155380;
	Mon,  6 May 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="w+V0SPVu"
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC9142E8A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010735; cv=none; b=s6Bh6J8VpFQmXXspnMafUXtI2P9N/RSyL7CJG+Cs7SGdvFvKwfp+cb3qrxwKpDzEJEhwWICW0RxmzsZHzYxVAoUvp/+vg0hNm6lnEgbrYfb3+hQt/AMUqvBWowuZkaU0x+CNqjwt/0DnHQ0vY2BvyFsUbqeHORmrvSrDaKPhMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010735; c=relaxed/simple;
	bh=IDDpkgBKjbOqR7QDCBIzGc24eoXl3y9UB7IfT/1YoPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6oPC+g+tYEeygR2Ug4lWYbg/uaxbDtvebHa8BHO7t2gtaRG4D/ns/gRdxVHNJPoIftzjXbYb7f34s6I6Q+of+ZIsYFO+7YW1pFOUBwRTSQIkVSWUkgS1WqkgV30ye5QFH7HQRFKpy6a+sJmzhrwP4vg55uLIldXxy6bo5EF6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=w+V0SPVu; arc=none smtp.client-ip=140.205.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1715010724; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TKTzSti+PtAcGWZfYR7jaBIBKKIAPqWETl5mtmtjZos=;
	b=w+V0SPVuonnfJf9NVwOnfJbb/mdo+nhnNuGiA/ZfDGzieFgOjoPCCrU7rFCbEvnUd0/G+Cm1gpIQ3eiZaAt/ywabQuNnULKp/sDCJQ/LiRxRaiTNclvzxsx768bHYzpmWYxS82kSDYVaFkWcTjfxi0z2UlgvD1CJbZOdsvR+fek=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XTd3ClE_1715010722;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XTd3ClE_1715010722)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 23:52:02 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	tsbogend@alpha.franken.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com
Cc:  <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
   <loongarch@lists.linux.dev>,
   <linux-riscv@lists.infradead.org>,
   <david@redhat.com>,
   <ryan.roberts@arm.com>,
   <ioworker0@gmail.com>,
   <libang.linux@gmail.com>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH v2 1/5] LoongArch: Add update_mmu_tlb_range()
Date: Mon, 06 May 2024 23:51:16 +0800
Message-Id: <20240506155120.83105-2-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240506155120.83105-1-libang.li@antgroup.com>
References: <20240506155120.83105-1-libang.li@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added update_mmu_tlb_range function, we can batch update tlb of an
address range.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 arch/loongarch/include/asm/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index af3acdf3481a..924b6b031f06 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -470,6 +470,10 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
 
+#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
+#define update_mmu_tlb_range(vma, addr, ptep, nr) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, nr)
+
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 			unsigned long address, pmd_t *pmdp)
 {
-- 
2.19.1.6.gb485710b


