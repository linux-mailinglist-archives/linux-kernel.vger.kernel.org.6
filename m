Return-Path: <linux-kernel+bounces-432968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3659E5282
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D905316722F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3A1D63EE;
	Thu,  5 Dec 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TwZW65zS"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2191D3566
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395061; cv=none; b=K+SXfnPR2+5k914K3x6LcjmP1zxlXLZhlW7UfYSHuZSS/zk5YPlnyr2DTMehrA496q0R+SKT1JidyciEww3Q9QaurBHUnZzFkj/Fq1MlQFNbPCO3WR6Vni0pD7NPIuQy7pwh5MOQt2YNkS51IDWYa7eltbgfJ8cwzw+36pH2zRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395061; c=relaxed/simple;
	bh=KdZD41tgx6Qr1c/gRskjjZMoJZN3uukBytOi/4j5RuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AFSu2JAHtTLOFHekpamfXY1Bibq4jdEQDDElRBrQGHCPT4qy4FrlJHUncdpYNS3F/w5hlq/M7cgWpr3EazrTzCJotf85JXu/Sdnb3+dFU0QG+Hk0+L7QnEypxREgDrYBvY9XlBE4nraNin/ogdTHRceISNbjO0++az0LT6LnKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TwZW65zS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so784069b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395059; x=1733999859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx3bO1dHXrQFEcxzN7b+pxSxnpvefYStWIHaUWrn/y4=;
        b=TwZW65zS8DQ8KyF886jAXurpc9T5e9ibSiyHGmqP04/+a38fVgmf7A4jM2tFjo3lHv
         23D7+pMw/1Gvy4nYcVgqu6Ad7ntkO2BGDI/YTtjYkReVHxNv8WDELXrZATb4mr+Y6iPL
         p/I2gKgAxxHIVdY9uUNMkcv2oOl660okaDhJbwU35QxudVQeU1EQrU5IqiFOrETRG/iC
         O4bbyYXPf/C+7IIrHvMaQtqFthC1d7fUSJYN75VN8e1BtAUFoQ+nLKUyBcfaOzZeGxv3
         9naSTJO/2myND4GAUBf6T0UZykVFyO8uw0a/3OoTUv4vHfQWdziDiR/0rLFMVNdJcLfN
         TckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395059; x=1733999859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx3bO1dHXrQFEcxzN7b+pxSxnpvefYStWIHaUWrn/y4=;
        b=DogNzfFBq5NSd7SrUqezdVM9sTiZ2TMMeKfpZnzIvfHUrLC5F6CmQE18295U3iXZwU
         cc4APYdBRzcaFqGlqLyTpLGwMg+QRZnl3lflKIDiByExfbvB9GiN+V0DjdYs1OlER2bU
         VIHvSXS5PdZvh+0ZW+A0inomjQDdvoOWiMGs08LqnJ2oap03To9JqwiqQNIioVOPojxS
         M4ocFd2Mmlqb1VEw96/ZVU88hknckhWasg3PLJuB/dRVpP0JWEpE+zbcQK7O5zw5Ofoc
         eK1jXTdKoO5/aJbwcN/WL2+GbYKTuTRRMNasitqynxJDDc0gLEfIjk5166akTtZjI36Q
         oeZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsxJeD5//bwwJ2dPVH3tRqBhVXcxsjWzwaXcajGWc9N6cx199oLEkmbkaDVmBqaCAxOSfMnhgjzFPC4YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUn86858r0eo4l4m7z8SeJ61KBCi7vSJ5JIpDiK4zuf6ADHNVz
	+yzyp/Yf3kTy8XgAaiydcRot9zh2eB8otIsGfnIkPeB+96CmTvZW4QdBtT/NGeo=
X-Gm-Gg: ASbGncv0ZdJyVxV3IFgO4S4kGVd5/mxMm1qq8BtCpKSoWkEDGSz3D02HjqJi0W2HDaj
	/YXRCYkMlypd6WFv1jwPTHh8Zbbrbf1DXsGvaVlM3x9NHnAg8tlau+GvVoQQnFiIOfi2XoXXXJB
	6RS8T4Xn497csSqKFMgQ4I0RhKbbKystFbxKEe9AtITpWsORJuUhqndGyJS4FTHl2hYMCmNyZcv
	Ip4gW7B5LCJDoula/mzlZJVICrhGZM3j410UEW/NAXi9Frx8BA82Tvj5ZeIDJrBtFt/qcOiDS7D
	6nYJ651v7mfh72q0wxe6pww7gGfIkIST
X-Google-Smtp-Source: AGHT+IHiqAXBvE3gLjiFeE5je7PXQUYt1a4jU3QlzDyqkveJzS+AyvksHc49kSByBz2ufFXcaypagw==
X-Received: by 2002:a05:6a00:92a3:b0:71e:79a9:ec47 with SMTP id d2e1a72fcca58-7257fa5708fmr12300993b3a.6.1733395058729;
        Thu, 05 Dec 2024 02:37:38 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.37.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:37:38 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 00/21] riscv: Introduce 64K base page
Date: Thu,  5 Dec 2024 18:37:08 +0800
Message-Id: <20241205103729.14798-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series attempts to break through the limitation of MMU and
supports larger base page on RISC-V, which only supports 4K page size
now. The key idea is to always manage and allocate memory at a
granularity of 64K and use SVNAPOT to accelerate address translation.
This is the second version and the detailed introduction can be found
in [1].

Changes from v1:
- Rebase on v6.12.

- Adjust the page table entry shift to reduce page table memory usage.
    For example, in SV39, the traditional va behaves as:

    ----------------------------------------------
    | pgd index | pmd index | pte index | offset |
    ----------------------------------------------
    | 38     30 | 29     21 | 20     12 | 11   0 |
    ----------------------------------------------

    When we choose 64K as basic software page, va now behaves as:

    ----------------------------------------------
    | pgd index | pmd index | pte index | offset |
    ----------------------------------------------
    | 38     34 | 33     25 | 24     16 | 15   0 |
    ----------------------------------------------

- Fix some bugs in v1.

Thanks in advance for comments.

[1] https://lwn.net/Articles/952722/

Xu Lu (21):
  riscv: mm: Distinguish hardware base page and software base page
  riscv: mm: Configure satp with hw page pfn
  riscv: mm: Reimplement page table entry structures
  riscv: mm: Reimplement page table entry constructor function
  riscv: mm: Reimplement conversion functions between page table entry
  riscv: mm: Avoid pte constructor during pte conversion
  riscv: mm: Reimplement page table entry get function
  riscv: mm: Reimplement page table entry atomic get function
  riscv: mm: Replace READ_ONCE with atomic pte get function
  riscv: mm: Reimplement PTE A/D bit check function
  riscv: mm: Reimplement mk_huge_pte function
  riscv: mm: Reimplement tlb flush function
  riscv: mm: Adjust PGDIR/P4D/PUD/PMD_SHIFT
  riscv: mm: Only apply svnapot region bigger than software page
  riscv: mm: Adjust FIX_BTMAPS_SLOTS for variable PAGE_SIZE
  riscv: mm: Adjust FIX_FDT_SIZE for variable PMD_SIZE
  riscv: mm: Apply Svnapot for base page mapping if possible
  riscv: Kconfig: Introduce 64K page size
  riscv: Kconfig: Adjust mmap rnd bits for 64K Page
  riscv: mm: Adjust address space layout and init page table for 64K
    Page
  riscv: mm: Update EXEC_PAGESIZE for 64K Page

 arch/riscv/Kconfig                    |  34 +-
 arch/riscv/include/asm/fixmap.h       |   3 +-
 arch/riscv/include/asm/hugetlb.h      |   5 +
 arch/riscv/include/asm/page.h         |  56 ++-
 arch/riscv/include/asm/pgtable-32.h   |  12 +-
 arch/riscv/include/asm/pgtable-64.h   | 128 ++++--
 arch/riscv/include/asm/pgtable-bits.h |   3 +-
 arch/riscv/include/asm/pgtable.h      | 564 +++++++++++++++++++++++---
 arch/riscv/include/asm/tlbflush.h     |  26 +-
 arch/riscv/include/uapi/asm/param.h   |  24 ++
 arch/riscv/kernel/head.S              |   4 +-
 arch/riscv/kernel/hibernate.c         |  21 +-
 arch/riscv/mm/context.c               |   7 +-
 arch/riscv/mm/fault.c                 |  15 +-
 arch/riscv/mm/hugetlbpage.c           |  30 +-
 arch/riscv/mm/init.c                  |  45 +-
 arch/riscv/mm/kasan_init.c            |   7 +-
 arch/riscv/mm/pgtable.c               | 111 ++++-
 arch/riscv/mm/tlbflush.c              |  31 +-
 arch/s390/include/asm/hugetlb.h       |   2 +-
 include/asm-generic/hugetlb.h         |   5 +-
 include/linux/pgtable.h               |  21 +
 kernel/events/core.c                  |   6 +-
 mm/debug_vm_pgtable.c                 |   6 +-
 mm/gup.c                              |  10 +-
 mm/hmm.c                              |   2 +-
 mm/hugetlb.c                          |   4 +-
 mm/mapping_dirty_helpers.c            |   2 +-
 mm/memory.c                           |   4 +-
 mm/mprotect.c                         |   2 +-
 mm/ptdump.c                           |   8 +-
 mm/sparse-vmemmap.c                   |   2 +-
 mm/vmscan.c                           |   2 +-
 33 files changed, 1029 insertions(+), 173 deletions(-)
 create mode 100644 arch/riscv/include/uapi/asm/param.h

-- 
2.20.1


