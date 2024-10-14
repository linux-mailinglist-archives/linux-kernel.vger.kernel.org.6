Return-Path: <linux-kernel+bounces-363190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB199BED2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F74628629A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B7D1A7AEC;
	Mon, 14 Oct 2024 03:59:02 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11A41A707F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878342; cv=none; b=aKEXsYdivyDUW3Jw6qe2xi8LfnCIrN01rXQJVrJtuTEZoPTJCI1raEe/evbRnYmBWSysVoe2CQHp6CKxhz6QKaeUr6e2LdJEt1tK2+5BjdT3OQLZFgPxUQRf5posiTYXo+zVrWcpfev66nSIHw3ney/H05JdR4HezGoeHVrhLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878342; c=relaxed/simple;
	bh=WYGTl5mmeDx0+8Wta7iE4Bc8JxUtrPtFOoyKZLU8/98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RHGVUwoyF8x5XgdC3boTw8299vL+oCyUax4g4Wwl3FOjpKZGnlbs3gF8aLWDLJeH5FxknEUij/dJW3TWli+/IzOUjjkBxyJ+hdK5ptSTIqj5xl+CDfIgZVc2EP5v3BMx28QmuRC/v/LLVQW/kgQazljsP7TByQ0xyBqQXcXgAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxbWsAlwxneAIaAA--.38056S3;
	Mon, 14 Oct 2024 11:58:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMBxXuT_lgxnc6EoAA--.1717S2;
	Mon, 14 Oct 2024 11:58:56 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH v2 0/3] LoongArch: Fix vmalloc test issue
Date: Mon, 14 Oct 2024 11:58:52 +0800
Message-Id: <20241014035855.1119220-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxXuT_lgxnc6EoAA--.1717S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On LoongArch 3C5000 Dual-Way machine, there are 32 CPUs and 128G RAM,
there are some errors with run vmalloc test with command like this
  insmod test_vmalloc.ko   nr_threads=32  run_test_mask=0x3af

Here is part of error message and summary test report for failed cases:
 WARNING: CPU: 13 PID: 1457 at mm/vmalloc.c:503 vmap_small_pages_range_noflush+0x388/0x510
 CPU: 13 UID: 0 PID: 1457 Comm: vmalloc_test/15 Not tainted 6.12.0-rc2+ #93

 Trying to vfree() nonexistent vm area (000000004dec9ced)
 WARNING: CPU: 3 PID: 1444 at mm/vmalloc.c:3345 vfree+0x1e8/0x4c8
 CPU: 3 UID: 0 PID: 1444 Comm: vmalloc_test/2

 Trying to vfree() bad address (00000000fc7c9da5)
 WARNING: CPU: 10 PID: 1552 at mm/vmalloc.c:3210 remove_vm_area+0x88/0x98
 CPU: 10 UID: 0 PID: 1552 Comm: kworker/u144:3

Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: random_size_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: random_size_align_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: kvfree_rcu_2_arg_vmalloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: random_size_align_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: fix_size_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: random_size_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: random_size_align_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: random_size_align_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: kvfree_rcu_2_arg_vmalloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: random_size_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: kvfree_rcu_1_arg_vmalloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: fix_size_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000
Summary: long_busy_list_alloc_test passed: 0 failed: 1 repeat: 1 loops: 1000000

The mainly problem is that function set_pte() and pte_free() is not atomic,
since these functions need modify two consecutive pte entries for kernel
space area to assure that both pte entries with PAGE_GLOBAL bit set. And
there is contension problem between them.

With this patchset, vmalloc test case passes to run with command
  insmod test_vmalloc.ko   nr_threads=32  run_test_mask=0x3af

---
  v1 ... v2:
    1. Solve compile warning issue by declaring function
       kernel_pte_init() in header file include/linux/mm.h
    2. Add kernel_pte_init() in function zero_pmd_populate() called by
       file mm/kasan/init.c
    3. Merge the first two patches into one since both these two patches
       set pte entry with PAGE_GLOBAL in different modules
    4. Remove amotic operation with pte_clear(), using generic read and
       clear operation, vmalloc test pass to run also
    5. refresh some comments description
---
Bibo Mao (3):
  LoongArch: Set initial pte entry with PAGE_GLOBAL for kernel space
  LoongArch: Add barrier between set_pte and memory access
  LoongArch: Remove pte buddy set with set_pte and pte_clear function

 arch/loongarch/include/asm/cacheflush.h | 14 +++++++++-
 arch/loongarch/include/asm/pgalloc.h    | 13 +++++++++
 arch/loongarch/include/asm/pgtable.h    | 36 +++++--------------------
 arch/loongarch/mm/init.c                |  4 ++-
 arch/loongarch/mm/kasan_init.c          |  4 ++-
 arch/loongarch/mm/pgtable.c             | 22 +++++++++++++++
 include/linux/mm.h                      |  1 +
 mm/kasan/init.c                         |  8 +++++-
 mm/sparse-vmemmap.c                     |  5 ++++
 9 files changed, 73 insertions(+), 34 deletions(-)


base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
-- 
2.39.3


