Return-Path: <linux-kernel+bounces-170107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794BA8BD1F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118F01F24AA5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22CE155A5F;
	Mon,  6 May 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="LWFtCWkL"
Received: from out0-221.mail.aliyun.com (out0-221.mail.aliyun.com [140.205.0.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40B4D58E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011049; cv=none; b=I5ZSUwIOT2x9inCpvx6F+BD2m3JpwAblbI0QUL2HqkXrlj9hjj0YWvB2paqgbL4vIxRZZSXHE80zJgMJe5MiGm5EYsc/Ok2JTsvb6a3qr40qbXJb7CPxVLD+9amMZoyjn2LsB1ecdfiD538tHNcqTul37SjJZrvZWdB8aA3GcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011049; c=relaxed/simple;
	bh=9Yh85VzIOU/V0hUFMa4Ncpa3uq6U/PD5BfSD0II4KQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U4+3Ixf7HgnQwEwQSrBlIGN+K7VGxMT4KMs0OrmRPQjWPd+qC6HNUo9q02TouEj9swGzcihT7VSLW1pqe+iWpvB2iMoUh5pnU39CBiFXM037tgEkgSax/Y2DP/H8Hjf9m4H3oSuYYrmDBzJblmU+Z2dnvQ5qA+nOvSkwrZOpP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=LWFtCWkL; arc=none smtp.client-ip=140.205.0.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1715011044; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=V5hA+ZyI44gZD58G2AfJieyG2gwT3Fy83Cv7WPpLrX0=;
	b=LWFtCWkLpTI27jN7lJilPUvZCYzaowFXsvy8WvKBNpDiyV9gzVPq4kgHP0bliu58ABopWDCG+9SizSXb81+GgvgxXHjcALqpYDpKh2v+p/zBMIAYb7wHV3L4BdsJfrktf7I636OIS2euGrOfdKrRf1Btm4AWoud5OKOx3pJtV8Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047202;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XTd3Clf_1715010725;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XTd3Clf_1715010725)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 23:52:06 +0800
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
Subject: [PATCH v2 3/5] riscv: Add update_mmu_tlb_range()
Date: Mon, 06 May 2024 23:51:18 +0800
Message-Id: <20240506155120.83105-4-libang.li@antgroup.com>
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
 arch/riscv/include/asm/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 661b2b4fe758..f784c6dd2c66 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -489,6 +489,10 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb update_mmu_cache
 
+#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
+#define update_mmu_tlb_range(vma, addr, ptep, nr) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, nr)
+
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp)
 {
-- 
2.19.1.6.gb485710b


