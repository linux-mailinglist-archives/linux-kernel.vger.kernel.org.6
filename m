Return-Path: <linux-kernel+bounces-185797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA468CBB09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053B41F22659
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47C78283;
	Wed, 22 May 2024 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="M2ShXC/k"
Received: from out0-204.mail.aliyun.com (out0-204.mail.aliyun.com [140.205.0.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644D1C6B4
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716358412; cv=none; b=Lpw63+9cGEhDkPuXrYKpmF7Ex8oHZEyDy+JDCkykW0et7qeIcTvD97RXvJBDLWtT1YcWNbT9kxn0k7oR9J/bVT0W2huRbcbKgOMO58Cyj9lgxVV/h3vTdYK+pqDCzvgGzAUFlLLUQYJ7VJscZ1AbGUtuOEB89nLJpdHXDrbOUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716358412; c=relaxed/simple;
	bh=TRiPUs3sOqcR2Uebg5ICahKspfvDNX9Au3ncj/hVLOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nYwhgMcNjurt46oU83oAon12JmRVQUT1dmE1mJUN/lFs6+JbRnHx4Ho4oJbQekPMRZSmQTS0XGWNkfCh5VT4hWQm6YiAtWzlGL+Ef2MsKMfasXRAV1a1JY6igQ04oCIGMsmnWXHdcDcEwMQsYaqfBUanvUwV8Jq7GbTxc1r2Kpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=M2ShXC/k; arc=none smtp.client-ip=140.205.0.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716358401; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=50gKTtI5/VbfrYUWsIwxZn0QXyXPTk7AsRcof412llE=;
	b=M2ShXC/kO+uLmb1DERSb+Y3T2CE4HXLhuViAFdf1bMn31T/nG6D6d5Tc9VCmJCKtGRtP75W2kB8gsyJKzigy63IqXGZV+443bqQ6CUBgYBzd4kqLeGRqxb6GMg1qCcalHkUottxI1VJPaW52ZQr5NiNPpWzef7O46GNIoKy3/Qg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068161075;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.Xjzgxvc_1716358399;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.Xjzgxvc_1716358399)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 14:13:20 +0800
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
Subject: [PATCH v4 0/3] Add update_mmu_tlb_range() to simplify code
Date: Wed, 22 May 2024 14:12:01 +0800
Message-Id: <20240522061204.117421-1-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of commits mainly adds the update_mmu_tlb_range() to
batch update tlb in an address range and implement update_mmu_tlb()
using update_mmu_tlb_range().

After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
multi-size THP"), We may need to batch update tlb of a certain address
range by calling update_mmu_tlb() in a loop. Using the
update_mmu_tlb_range(), we can simplify the code and possibly reduce the
execution of some unnecessary code in some architectures.

Thanks,
Bang

Changes since v3 [3]:
 - Add acked-by from David Hildenbrand (patch #2 and patch #3) - thanks!
 - Add reviewed-by from Lance Yang (patch #3) - thanks!
 - Move the general architecture update_mmu_tlb_range() from patch #2 to
   patch #1 (per David)
 - Update patch #2 commit log (per David)

Changes since v2 [2]:
 - Use generic architecture to implement update_mmu_tlb() (per Ryan)

Changes since v1 [1]:
 - Add __HAVE_ARCH_UPDATE_MMU_TLB_RANGE macro (per Lance Yang)

[1] https://lore.kernel.org/linux-mm/20240429103346.59115-1-libang.li@antgroup.com/
[2] https://lore.kernel.org/linux-mm/20240506155120.83105-1-libang.li@antgroup.com/
[3] https://lore.kernel.org/linux-mm/20240518074914.52170-1-libang.li@antgroup.com/

Bang Li (3):
  mm: Add update_mmu_tlb_range()
  mm: implement update_mmu_tlb() using update_mmu_tlb_range()
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


