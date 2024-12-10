Return-Path: <linux-kernel+bounces-440160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1859EB992
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DF62847A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A58214203;
	Tue, 10 Dec 2024 18:46:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1682046BB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856385; cv=none; b=V8DqHIlTx7jVPEtgkuew0HIdbRRfGBtn71jHE+/kKo6tcIoWmEJ5R4XPrfCLOZiIIeRm6GNn1aX/HF876qzSce1HJ6AheXK1vFoXOz6E1fRLZyDd5OO+uGMVr9v66DoCzL5MGaZH3dieXqpwYkcG7aeeSRBXcNlCUb+c/OsIwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856385; c=relaxed/simple;
	bh=MUj0XiiDJvlffQOyhM77P0HfGWcEWfMtHYWPgxMsvc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UF0nX5Udc9TODqYBX1jL/wJMAcR3KamYZvGU9MWGl1cuE+u3b5saEl1DzreRBoIRTsKkv9bzW6/LC6mJ77lzlhRY4eOFv+xU4EEu+kz2hSaI+gUEbnhOhNZxIGxCEuejdAUyk1+vPvJb2ZX5mK4BZggDX5Bk32VsYXRhHwuLmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AF0C106F;
	Tue, 10 Dec 2024 10:46:51 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EA8F3F58B;
	Tue, 10 Dec 2024 10:46:21 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	jane.chu@oracle.com,
	osalvador@suse.de,
	tglx@linutronix.de
Subject: [PATCH 0/4] Remove problematic include in <asm/set_memory.h>
Date: Tue, 10 Dec 2024 18:46:06 +0000
Message-ID: <20241210184610.2080727-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The need for this series arose from a completely unrelated series [1].
Long story short, that series causes <linux/mm.h> to include
<linux/set_memory.h>, which doesn't feel too unreasonable.

That works fine on arm64 and probably most other architectures, but not
on x86 [2]: <asm/set_memory.h> itself includes <linux/mm.h>, creating a
circular dependency.

set_memory.h doesn't really need <linux/mm.h>, so removing that include
seems like the right thing to do. That turned out to be a little more
involved than expected, hence this series:

* Patch 1-2 ensure that code doesn't rely on <asm/set_memory.h>
  including <linux/mm.h>. The errors that these patches fix are included
  at the end of this email.

* Patch 3 removes an unused function whose declaration relied on
  <linux/mm.h> being included.
 
* Patch 4 actually remove the include.

I've build-tested this series with x86_64_defconfig and allyesconfig. 

- Kevin

[1] https://lore.kernel.org/linux-hardening/20241206101110.1646108-1-kevin.brodsky@arm.com/
[2] https://lore.kernel.org/oe-kbuild-all/202412062006.C23V9ESs-lkp@intel.com/

Cc: bp@alien8.de
Cc: dan.j.williams@intel.com
Cc: dave.hansen@linux.intel.com
Cc: david@redhat.com
Cc: jane.chu@oracle.com
Cc: osalvador@suse.de
Cc: tglx@linutronix.de
---
Build errors caused by patch 4 and fixed by patch 1-2:

  CC      drivers/gpu/drm/i915/gt/intel_ggtt.o
In file included from arch/x86/include/asm/smp.h:9,
                 from drivers/gpu/drm/i915/gt/intel_ggtt.c:7:
arch/x86/include/asm/thread_info.h: In function 'arch_within_stack_frames':
arch/x86/include/asm/thread_info.h:212:16: error: 'NOT_STACK' undeclared (first use in this function)
  212 |         return NOT_STACK;
      |                ^~~~~~~~~
arch/x86/include/asm/thread_info.h:212:16: note: each undeclared identifier is reported only once for each function it appears in

  CC      drivers/virt/coco/sev-guest/sev-guest.o
drivers/virt/coco/sev-guest/sev-guest.c: In function 'free_shared_pages':
drivers/virt/coco/sev-guest/sev-guest.c:621:31: error: implicit declaration of function 'PAGE_ALIGN'; did you mean 'PFN_ALIGN'? [-Wimplicit-function-declaration]
  621 |         unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
      |                               ^~~~~~~~~~
      |                               PFN_ALIGN
  CC      drivers/infiniband/hw/mlx5/ib_rep.o
drivers/virt/coco/sev-guest/sev-guest.c: In function 'alloc_shared_pages':
drivers/virt/coco/sev-guest/sev-guest.c:646:51: error: implicit declaration of function 'page_address'; did you mean 'pbe_address'? [-Wimplicit-function-declaration]
  646 |         ret = set_memory_decrypted((unsigned long)page_address(page), npages);
      |                                                   ^~~~~~~~~~~~
      |                                                   pbe_address
drivers/virt/coco/sev-guest/sev-guest.c:653:16: error: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
  653 |         return page_address(page);
      |                ^~~~~~~~~~~~~~~~~~

---
Kevin Brodsky (4):
  x86/smp: Explicitly include <linux/thread_info.h>
  x86/sev: Explicitly include <linux/mm.h>
  x86/mm: Remove unused __set_memory_prot()
  x86/mm: Remove unnecessary include in set_memory.h

 arch/x86/include/asm/set_memory.h       |  2 --
 arch/x86/include/asm/smp.h              |  2 +-
 arch/x86/mm/pat/set_memory.c            | 13 -------------
 drivers/virt/coco/sev-guest/sev-guest.c |  1 +
 4 files changed, 2 insertions(+), 16 deletions(-)


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.47.0


