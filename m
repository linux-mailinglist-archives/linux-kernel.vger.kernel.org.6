Return-Path: <linux-kernel+bounces-445934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81AD9F1DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16B87A02F5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7073D185B48;
	Sat, 14 Dec 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IauP9tSM"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58677E0FF
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167020; cv=none; b=ZMt+Fy67C2LyqWBx64mHZO4InKGrQgxUT36MqLL9KPU4t8aVHm7p3+2BN/4iya/Skrjw+O78C0SIJqpRULPWJ5bIHVp8szoSojSbDKgwBZoQOFzECS1gY+/bsY7hCnalog81he3KYVNpQ+wiG9AcFrvt+utE0/LzTO+vucj+Rjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167020; c=relaxed/simple;
	bh=nM+RxzFrTtuZKofGknIbQwOZXGk6vaJ+GQKZwKrEmP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OTltbNCRB3WJdiYeVgUPkW1Awe73s6qDtJMQJTduHbySJbjjp0V7luIUpez+yLDu7Elzj+WBkT/2q9MxvKpfCnNeqbECWohqbJCpILbEIZ8oEX1V5zdeYwNE1hWj3Ar72dSi17KFa3lHDei3UW8EwYt0GOK4xYkubs6f0aDRWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IauP9tSM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728f1e66418so2184908b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167018; x=1734771818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQxGVZsKOv6M0IrGGX96lWptBM6M1MsM2naDTLaIS68=;
        b=IauP9tSMKcnC5Dtv8O/mWtGTB7dF5gF/NIfB5qw7yiF3mj0xVlAEa7+gr3lnvhadZh
         bLqNnnBVJRXAer9zNNqlKlom6vBGQ5MYmuPrey46xEV/y6CPWHlR+doxQ6/+rjUoq0+6
         IZkoaa4558+ZMqvr48/e1P6hddcWNq9gUNr2BUQPUhqrimVSIdeg5TciNYRxjfO9okAA
         LTP1v2CO65Kk8BP1vSCAKtm47MQZD6WpRsNN1N7zy7IEqsDbsB3UyNDe15bkg2VwSYyK
         0h+F+jEg5S7xDo/CnG0xx576kex+JFOCs6GyHCoAfWZ2GoplbVuXUxvyN5uE8r1r0El4
         LQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167018; x=1734771818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQxGVZsKOv6M0IrGGX96lWptBM6M1MsM2naDTLaIS68=;
        b=ue762Z5nM9VCDPVJ3AhcJcvH+MhxLPX74amEcB1UwaH/QbQmNqG2f1nTQvKWgCHbT6
         05cQTIwlZLTpBvz9tZ3n3xJ7O5MA4jilK0Zs3d7kIgif1ZneeRBi6jCNCB9ayMjh9m0T
         mEc0OictbxuNtLtKC/5JWfYUtUavkIxk0L8fINwQbrn6ayb5VglU226Sdxs9jAbUQyCy
         WxavOn5kGp8j2seLRAsZ0b3GJHlYJLgGqVpi+VD4O6urtyFzPkn/fnAmPs4q/1LsQu0h
         vQ5fQc1q01Ke6ezQ+M1PW+SS6B2C70l5T4grpIj18DRrgmO4w8ZBeHF95SfbOR1Xg9D1
         Qygw==
X-Forwarded-Encrypted: i=1; AJvYcCU8+J0KumV912FK1yJReyxoOFG/OsaE4RjPiUgAfMZDf7oYm5Gbp+HzfVqpyuTV8YKz9wsy4zhMgQ3m2TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6hTJrKoiOEunM+aXXmIfqGUyq2Tx+oUlMdmxiv/zydpono1M
	wYLSIPaXuZxVBzsqu1wpj8NkpmxUMrFjDwjH2xApGxFXvYXROCnv0+6VkZwnCDc=
X-Gm-Gg: ASbGncs0n5jiF1z8WV6Eejx0jbwMsUPWyFLRvlk/a0m/SQxNovknDGvT3rZLCocgqV6
	LjS2p4FqBeAXake3FuNxZvn3eh8N2CQWPCjwJiHqqiFKDn8WbSyGkAMBW8BGmNnzz938FHmTN/b
	Rg4Z8LzpMhOj/5H1PiT7hFokIvS2XUM4AjAb0KkVJy4Rx1o5vpqBfm0j7myVR3X9WJZH+ZUT3lL
	UUlpl2YloGX6wUvdpaVwlXGstaIIvXvD/DJOXRR1MD+S9ObWTi1yUmXDMEaw8Q37HUIzh+z0X/w
	c556EPbVw7+eW3kjsVhEaRTWoAWTag==
X-Google-Smtp-Source: AGHT+IFlSDv3uZE5Q5rEc2oV0IgrgqQ7AXlRsBX7UGansTakEMu3lzKwDtU1nsVJ8ZGM9DdkCxj/KA==
X-Received: by 2002:a17:902:d2ca:b0:216:2f7f:ff69 with SMTP id d9443c01a7336-2189298bbecmr80981855ad.5.1734167017987;
        Sat, 14 Dec 2024 01:03:37 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:03:37 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 00/12] move pagetable_*_dtor() to __tlb_remove_table()
Date: Sat, 14 Dec 2024 17:02:46 +0800
Message-Id: <cover.1734164094.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

As proposed [1] by Peter Zijlstra below, this patch series aims to move
pagetable_*_dtor() into __tlb_remove_table(). This will cleanup pagetable_*_dtor()
a bit and more gracefully fix the UAF issue [2] reported by syzbot.

```
Notably:

 - s390 pud isn't calling the existing pagetable_pud_[cd]tor()
 - none of the p4d things have pagetable_p4d_[cd]tor() (x86,arm64,s390,riscv)
   and they have inconsistent accounting
 - while much of the _ctor calls are in generic code, many of the _dtor
   calls are in arch code for hysterial raisins, this could easily be
   fixed
 - if we fix ptlock_free() to handle NULL, then all the _dtor()
   functions can use it, and we can observe they're all identical
   and can be folded

after all that cleanup, you can move the _dtor from *_free_tlb() into
tlb_remove_table() -- which for the above case, would then have it
called from __tlb_remove_table_free().
```

And hi Andrew, I developed the code based on the latest linux-next, so I reverted
the "mm: pgtable: make ptlock be freed by RCU" first. Once the review of this
patch series is completed, the "mm: pgtable: make ptlock be freed by RCU" can be
dropped directly from mm tree, and this revert patch will not be needed.

This series is based on next-20241213. And I tested this patch series on x86 and
only cross-compiled it on arm[64], powerpc, riscv, s390 and sparc.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/all/20241211133433.GC12500@noisy.programming.kicks-ass.net/
[2]. https://lore.kernel.org/all/67548279.050a0220.a30f1.015b.GAE@google.com/

Qi Zheng (12):
  Revert "mm: pgtable: make ptlock be freed by RCU"
  mm: pgtable: introduce generic p4d_alloc_one() and p4d_free()
  arm64: pgtable: use mmu gather to free p4d level page table
  s390: pgtable: add statistics for PUD and P4D level page table
  mm: pgtable: introduce pagetable_dtor()
  arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
  arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
  riscv: pgtable: move pagetable_dtor() to __tlb_remove_table()
  x86: pgtable: move pagetable_dtor() to __tlb_remove_table()
  s390: pgtable: also move pagetable_dtor() of PxD to
    __tlb_remove_table()
  mm: pgtable: introduce generic __tlb_remove_table()
  mm: pgtable: move __tlb_remove_table_one() in x86 to generic file

 Documentation/mm/split_page_table_lock.rst |  4 +-
 arch/arm/include/asm/tlb.h                 | 10 ----
 arch/arm64/include/asm/pgalloc.h           | 17 +++---
 arch/arm64/include/asm/tlb.h               | 21 +++++---
 arch/csky/include/asm/pgalloc.h            |  2 +-
 arch/hexagon/include/asm/pgalloc.h         |  2 +-
 arch/loongarch/include/asm/pgalloc.h       |  2 +-
 arch/m68k/include/asm/mcf_pgalloc.h        |  4 +-
 arch/m68k/include/asm/sun3_pgalloc.h       |  2 +-
 arch/m68k/mm/motorola.c                    |  2 +-
 arch/mips/include/asm/pgalloc.h            |  2 +-
 arch/nios2/include/asm/pgalloc.h           |  2 +-
 arch/openrisc/include/asm/pgalloc.h        |  2 +-
 arch/powerpc/include/asm/tlb.h             |  1 +
 arch/powerpc/mm/book3s64/mmu_context.c     |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c         |  2 +-
 arch/powerpc/mm/pgtable-frag.c             |  4 +-
 arch/riscv/include/asm/pgalloc.h           | 51 ++++++++----------
 arch/riscv/include/asm/tlb.h               | 18 -------
 arch/riscv/mm/init.c                       |  4 +-
 arch/s390/include/asm/pgalloc.h            | 31 +++++++----
 arch/s390/include/asm/tlb.h                | 37 ++++++-------
 arch/s390/mm/pgalloc.c                     | 21 ++------
 arch/sh/include/asm/pgalloc.h              |  2 +-
 arch/sparc/include/asm/tlb_32.h            |  1 +
 arch/sparc/include/asm/tlb_64.h            |  1 +
 arch/sparc/mm/init_64.c                    |  2 +-
 arch/sparc/mm/srmmu.c                      |  2 +-
 arch/um/include/asm/pgalloc.h              |  6 +--
 arch/x86/include/asm/pgalloc.h             | 16 +++---
 arch/x86/include/asm/tlb.h                 | 33 ------------
 arch/x86/kernel/paravirt.c                 |  1 +
 arch/x86/mm/pgtable.c                      | 13 ++---
 include/asm-generic/pgalloc.h              | 61 ++++++++++++++++++++--
 include/asm-generic/tlb.h                  | 15 +++++-
 include/linux/mm.h                         | 44 +++++-----------
 include/linux/mm_types.h                   |  9 +---
 mm/memory.c                                | 23 +++-----
 mm/mmu_gather.c                            | 20 ++++++-
 39 files changed, 233 insertions(+), 259 deletions(-)

-- 
2.20.1


