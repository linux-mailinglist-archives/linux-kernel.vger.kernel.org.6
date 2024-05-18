Return-Path: <linux-kernel+bounces-182793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5E68C8FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911881C21A21
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 07:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CD2D52A;
	Sat, 18 May 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="0dcyiLFC"
Received: from out187-24.us.a.mail.aliyun.com (out187-24.us.a.mail.aliyun.com [47.90.187.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE5A101CE
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716018715; cv=none; b=kB2uFs2tX8pjXonFwR8WPjgA73SUIrnMwCoJj8EAKvh2sINCSbTtKhsfySVQVwXKy3+rhHClXayANJuOeSa+wOGIiiyo5/lP3P9Ma4NGBF+ii/ZN1ylL0CO5xuWuLYYad0Ilz9MOe+ONIuw8b6h/YHhfij0pu9FPNXw18+2r0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716018715; c=relaxed/simple;
	bh=nifAML72DAg47mSHoyFc+yQB6k76eOuWitHSpVdE7/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rmwFhCjuVevAROMM1RXcjOs/e2UBlEukRBxxS76bMZvfUzx/XemNgP9w8py5yY5ytyV5fMS+LGJCTKWEMvKs5a8CPrs1j0rGa6sG1R773l12xtMmummf9H5NYsDRa3ddLdnAPT0s6ixqneqOWc5tRSQQuHqii8FmTmT5sS6tHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=0dcyiLFC; arc=none smtp.client-ip=47.90.187.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716018695; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GQ8XlBmX7iG6Cx7KU2H5vSERCOEK8rIAF03pf3vdLkg=;
	b=0dcyiLFC2zql6jJtan25xhQ+Z/jI7/b/bYg5dlrsMst1A9CP+QcuCju/vmSQU29Y2k3iAszzCFfsB3KUocgJMNOHM3GrJ69Rl0ti5xZOC27rLl4/cg3qb7YLpOT0qJW4kou9YRplkXunPkg/aVKxE3vpYDfLur2yu7zz2TZjfzM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067116;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.Xg9HuaJ_1716018692;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.Xg9HuaJ_1716018692)
          by smtp.aliyun-inc.com;
          Sat, 18 May 2024 15:51:33 +0800
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
Subject: [PATCH v3 0/3] Add update_mmu_tlb_range() to simplify code
Date: Sat, 18 May 2024 15:49:11 +0800
Message-Id: <20240518074914.52170-1-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of commits mainly adds the update_mmu_tlb_range() to
batch update tlb in an address range and refactor the update_mmu_tlb().

After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
multi-size THP"), We may need to batch update tlb of a certain address
range by calling update_mmu_tlb() in a loop. Using the
update_mmu_tlb_range(), we can simplify the code and possibly reduce the
execution of some unnecessary code in some architectures.

Thanks,
Bang

Changes since v2 [2]:
 - Use generic architecture to implement update_mmu_tlb() (per Ryan)

Changes since v1 [1]:
 - Add __HAVE_ARCH_UPDATE_MMU_TLB_RANGE macro (per Lance Yang)

[1] https://lore.kernel.org/linux-mm/20240429103346.59115-1-libang.li@antgroup.com/
[2] https://lore.kernel.org/linux-mm/20240506155120.83105-1-libang.li@antgroup.com/

Bang Li (3):
  mm: Add update_mmu_tlb_range()
  mm: Refactor update_mmu_tlb()
  mm: Use update_mmu_tlb_range() to simplify code

 arch/loongarch/include/asm/pgtable.h |  4 ++--
 arch/mips/include/asm/pgtable.h      |  4 ++--
 arch/riscv/include/asm/pgtable.h     |  4 ++--
 arch/xtensa/include/asm/pgtable.h    |  6 +++---
 arch/xtensa/mm/tlb.c                 |  6 +++---
 include/linux/pgtable.h              | 11 ++++++++---
 mm/memory.c                          |  4 +---
 7 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.19.1.6.gb485710b


