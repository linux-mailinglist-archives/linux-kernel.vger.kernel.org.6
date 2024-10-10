Return-Path: <linux-kernel+bounces-358210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F96997B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B467D1C21ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368DD192D97;
	Thu, 10 Oct 2024 03:50:55 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D2A5028C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532254; cv=none; b=nS8isO3Z0RTc6qxmOkAmZCEgk0qp+jv+G+AAvnQShvjZVLsVCMngO2pt5Pz01mbxN3OnkojoBL0fQV0tk4pXVRt/S9ISe80Uq82Y64vl4MIkOtuLbQCW7jOZCXmVPTANH7VmOBTVCu16OAj/g8rWFZy5KSogervavIMb4rU+Sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532254; c=relaxed/simple;
	bh=DEH5sLqV98/CSF+ZFh0bp8j4baZyz1B5ZwDF/lhjHHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EjHw5g5esB3rCPYBF6VEbvKbFzC86c2bi6UZA1mnjxKjzRBrDvuV4lX1mWPHR4vhPAGjV2/nyiHEOBmx0axq8ho4kVP5Tj54vFXuDKxI3cWQ+7iMGWVVzd0r8mZrc5jNsr7d7Pd2/SOvaee7aRAzvzhW94xZwt51S3wAX5PHapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx34saTwdnwrsRAA--.25122S3;
	Thu, 10 Oct 2024 11:50:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDx7tUZTwdnFP8hAA--.52915S2;
	Thu, 10 Oct 2024 11:50:49 +0800 (CST)
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
Subject: [PATCH 0/4] LoongArch: Fix vmalloc test issue
Date: Thu, 10 Oct 2024 11:50:44 +0800
Message-Id: <20241010035048.3422527-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx7tUZTwdnFP8hAA--.52915S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On LoongArch 3C5000 Dual-Way machine, there are 32 CPUs and 128G RAM,
there are some errors with run vmalloc test with command like this
  insmod test_vmalloc.ko   nr_threads=32  run_test_mask=0x3af

Here is part of error message,
 WARNING: CPU: 13 PID: 1457 at mm/vmalloc.c:503 vmap_small_pages_range_noflush+0x388/0x510
 CPU: 13 UID: 0 PID: 1457 Comm: vmalloc_test/15 Not tainted 6.12.0-rc2+ #93

 Trying to vfree() nonexistent vm area (000000004dec9ced)
 WARNING: CPU: 3 PID: 1444 at mm/vmalloc.c:3345 vfree+0x1e8/0x4c8
 CPU: 3 UID: 0 PID: 1444 Comm: vmalloc_test/2

 Trying to vfree() bad address (00000000fc7c9da5)
 WARNING: CPU: 10 PID: 1552 at mm/vmalloc.c:3210 remove_vm_area+0x88/0x98
 CPU: 10 UID: 0 PID: 1552 Comm: kworker/u144:3

The mainly problem is that function set_pte() and pte_free() is atomic,
there is contension between them. Since these functions need modify
two consecutive pte entries for kernel space area, to assure that both
pte entries with PAGE_GLOBAL bit set.

With this patchset, vmalloc test case passes to run with command
  insmod test_vmalloc.ko   nr_threads=32  run_test_mask=0x3af

Bibo Mao (4):
  LoongArch: Set pte entry with PAGE_GLOBAL for kernel space
  mm/sparse-vmemmap: set pte_init when vmemmap is created
  LoongArch: Add barrier between set_pte and memory access
  LoongArch: Use atomic operation with set_pte and pte_clear function

 arch/loongarch/include/asm/cacheflush.h | 14 +++++++-
 arch/loongarch/include/asm/pgalloc.h    | 13 +++++++
 arch/loongarch/include/asm/pgtable.h    | 45 +++++++++----------------
 arch/loongarch/mm/init.c                |  4 ++-
 arch/loongarch/mm/kasan_init.c          |  4 ++-
 arch/loongarch/mm/pgtable.c             | 22 ++++++++++++
 mm/sparse-vmemmap.c                     |  5 +++
 7 files changed, 75 insertions(+), 32 deletions(-)


base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
-- 
2.39.3


