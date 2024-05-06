Return-Path: <linux-kernel+bounces-170106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E319A8BD1F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E751284BC4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD2315573D;
	Mon,  6 May 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="oV1gmpqq"
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569C4D58E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011043; cv=none; b=MskOrd5VFtVnCUTFBIupnCh9YBPIrqfovHUgDWBo+YUTdSWIhQ1op5RQ2A89eVzzz12h0VabaV+S23GtCzkp9iK7oJC/5Hn46Q/N4wE/4vB7tQi7NlQAUg/jPoFCvWl/XcxtIlC1a9e1tyeqJW4SzQn15BJVOQk4xx2dOckXgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011043; c=relaxed/simple;
	bh=QxU4xP/UtRSyvVOvavTzU56iJmtUuco9rYcv/ovt128=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cmm3mgeWd5a/hdXrsEl3frPndBEEB+C/FlDZCUqflr3fAes4B54xGeMgklMFk+c5P3+m3lMXspUy2taa0SiYCpCIQM/eSXg+ehYVgEfrkbzsw0sVFyJFFnC7zxJxDq2OhK5U27qUUjicTwoLcQa1N+F1arO6CMqZKTC7qye0HoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=oV1gmpqq; arc=none smtp.client-ip=140.205.0.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1715011038; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=j6/KtEs6TFeoK8UWIq9uFemS/8A9ve6yI0uusmjA3lY=;
	b=oV1gmpqqAuX/9T8PND1UwE3ZtDrlbZJfoieJ+hdijrzn4M2h5IgPz8V4TeWSr6U0SCYY9r3zDAx5kOB9wRfCw58XVgQYys8vrvU0NVKwtSb6esMYilwkA7pBEgwrLIrkXoFIR1jXNgVgHc0o4z37kqDhYQtEWyG3eK2smsrb23I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XThas7i_1715010719;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XThas7i_1715010719)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 23:52:00 +0800
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
Subject: [PATCH v2 0/5] Add update_mmu_tlb_range() to simplify code
Date: Mon, 06 May 2024 23:51:15 +0800
Message-Id: <20240506155120.83105-1-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of commits mainly adds the update_mmu_tlb_range() to
batch update tlb in an address range.

After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
multi-size THP"), We may need to batch update tlb of a certain address
range by calling update_mmu_tlb() in a loop. Using the
update_mmu_tlb_range(), we can simplify the code and possibly reduce the
execution of some unnecessary code in some architectures.

Thanks,
Bang

Changes since v1 [1]:
 - Add __HAVE_ARCH_UPDATE_MMU_TLB_RANGE macro (per Lance Yang)

[1] https://lore.kernel.org/linux-mm/20240429103346.59115-1-libang.li@antgroup.com/

Bang Li (5):
  LoongArch: Add update_mmu_tlb_range()
  mips: Add update_mmu_tlb_range()
  riscv: Add update_mmu_tlb_range()
  xtensa: Add update_mmu_tlb_range()
  mm: Add update_mmu_tlb_range()

 arch/loongarch/include/asm/pgtable.h | 4 ++++
 arch/mips/include/asm/pgtable.h      | 4 ++++
 arch/riscv/include/asm/pgtable.h     | 4 ++++
 arch/xtensa/include/asm/pgtable.h    | 4 ++++
 arch/xtensa/mm/tlb.c                 | 6 ++++++
 include/linux/pgtable.h              | 8 ++++++++
 mm/memory.c                          | 4 +---
 7 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.19.1.6.gb485710b


