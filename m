Return-Path: <linux-kernel+bounces-571291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57870A6BB6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5016189F5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE371227EB6;
	Fri, 21 Mar 2025 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="H/I1uMAb"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7021F8F09
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562403; cv=none; b=tAfpDH27rmgoeJwLJ3hBS49wqKmGyGpcO80A7EPRvy53hxXSk/36IoGV6PZjfmznz8VOYRW+N0GK1Y+ORng0btp8LPYrJ3q9DchkaHHb0UOYEQ66gflz5s5AHdv+Aco8CAZfLHVtYr6I3z6YcJA1/E0TU1OHb2qtQWO1nhP8vlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562403; c=relaxed/simple;
	bh=Gwt5hhvHSalznLhRxj3uGdqKGzpQED/I63uZnqm/etw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tNZuj3vORlJawFgP9TeKFSsyn+Rqh1vg4X0XJZN2nXLhWf79lzDgptLOim8/YIRIai/lK1bcxcDuImDcGEoN2G5ZRluz21wkmwNcShxtWMZTqp/z/uz+pLe/yhImahpM5VyeBMa5OxfzDMJfQLdCyGPyGEtmJyKzcL9x4pPP37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=H/I1uMAb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1984974f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742562399; x=1743167199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoPNTj3V5YtvLo2U0JoAwgjQlQPlLdtIAiFjHR9ruWQ=;
        b=H/I1uMAbaWWnQMeXzcJHi94avUkciQTFTZewYREd+RVtYjE+fHD9Zhw1d9QLGgfAXW
         EfvRzxZCm9zlO9Eyub++e63npP1F/6YeZ+ilp6uiAlhnV+lmFqu1n1bUk6hqRaPzE5TY
         6Qt2O8GDnxF3ALhOCYYU8kQcWMs4548uSUlI1hQyZzOSCKvVlg/YP/lSodt6VRvvfley
         xmboTqSkCOOmN/hOQrl0IcAAPQzTtBA2Doptf4C5Uwu/lmBKYY3Wug9W5h3lTLqRjS2a
         dtuF3MeC3jWXDWVc529rOYVBN26RqT4aHPbd5xflij1ofKjd1SMsHItTXOvno/rD2ZZm
         3PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562399; x=1743167199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoPNTj3V5YtvLo2U0JoAwgjQlQPlLdtIAiFjHR9ruWQ=;
        b=VZ148Zr53HFPKTgBCThuXCZoY/Hv3SDWQqlE3K+y6jQzYvu/xISAr81XUbQh0WopuB
         Ho5EeCDcw2yMZ+WrEdNJ/RwC1EEA0aKVBRinxzs5X8uQbR4Ka+R10SFu28eCsFwX3Kmz
         UwGZlKcZHnCbnPOanFikhZQig4asn0wqXHccyM/euFu6xwGDNFLnk8paFJ8tQhj2CoVL
         bRAauky8yCLhS3HTJo8jBCAAMClahonhAOCb48CRSuNlDhrWJGp3QxM8FyaabWXfJ9oX
         A1D8ic+opoVgLAMy7ezhKs/2w400l2KiHxpJLnGvnEK4sNwAT0acf6s9bSpZ6rfOSuYM
         AnUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrRV9so1nn+pmB6+eYGYBuGkr1K9KdLE6amlfAS5cUKBS4PU8Bkt0GdhkfgE6tpB1cLb+MeX1tk/e0zhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCYLi+UtJ9ZqT6EtHAOoH/4D+VKrolFbQNyDyCF6/yGCxCNfHW
	ZOO1kIBdMocjjvXZ1zXYvSpL591Z9bLqwl4lleP95NiOmW3ymczesaZPgJU3daU=
X-Gm-Gg: ASbGncs4NvJ28tl5Gq5yW/wzRyww3ViME7v5gwk2UosZhZflWogew94FShCrqgv6p47
	ZHVpwnO9Olc7WwPEcThtSwVtQeNMR/XcEkISAryxNgJlgb+zgDTX32sTNR6tmDBI2QUclCg2Bli
	ovXX2/EF0DrJfnAcNE0S90HRvVLipGU/GJcAMehzQb6rZ6TEuJFKdeV7B7k24SfCU1nd9s/M9Ek
	6lD1sUcxoxyWREgYNsqIS8jraOMrhuR4iQ8bw470dOvvKLpsHM+t5v715Ha9okvAwK8zbAGMkyq
	3Gif05dCDmLr59oYo3iQ4U96vrA4i2QntqvgL5Qb0zRV/qvcDzMroGzxnC1gGcS0FCH1gQ==
X-Google-Smtp-Source: AGHT+IEOpmQu3vdRTdoPK4Nh9YP5qAW7X5GoPVuQLhck+hEVtrUjAV5TX9kBkzKS3ZyCGSIbxUt4SQ==
X-Received: by 2002:a5d:6c6a:0:b0:390:f5c8:1079 with SMTP id ffacd0b85a97d-3997959cde3mr6694234f8f.24.1742562398418;
        Fri, 21 Mar 2025 06:06:38 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2001:861:3382:ef90:3d12:52fe:c1cc:c94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5b8dsm2363992f8f.59.2025.03.21.06.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:06:37 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 0/9] Merge arm64/riscv hugetlbfs contpte support
Date: Fri, 21 Mar 2025 14:06:26 +0100
Message-Id: <20250321130635.227011-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset intends to merge the contiguous ptes hugetlbfs implementation
of arm64 and riscv.

Both arm64 and riscv support the use of contiguous ptes to map pages that
are larger than the default page table size, respectively called contpte
and svnapot.

The riscv implementation differs from the arm64's in that the LSBs of the
pfn of a svnapot pte are used to store the size of the mapping, allowing
for future sizes to be added (for now only 64KB is supported). That's an
issue for the core mm code which expects to find the *real* pfn a pte points
to. Patch 1 fixes that by always returning svnapot ptes with the real pfn
and restores the size of the mapping when it is written to a page table.

The following patches are just merges of the 2 different implementations
that currently exist in arm64 and riscv which are very similar. It paves
the way to the reuse of the recent contpte THP work by Ryan [1] to avoid
reimplementing the same in riscv.

This patchset was tested by running the libhugetlbfs testsuite with 64KB
and 2MB pages on both architectures (on a 4KB base page size arm64 kernel).

[1] https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-ryan.roberts@arm.com/

v4: https://lore.kernel.org/linux-riscv/20250127093530.19548-1-alexghiti@rivosinc.com/
v3: https://lore.kernel.org/all/20240802151430.99114-1-alexghiti@rivosinc.com/
v2: https://lore.kernel.org/linux-riscv/20240508113419.18620-1-alexghiti@rivosinc.com/
v1: https://lore.kernel.org/linux-riscv/20240301091455.246686-1-alexghiti@rivosinc.com/

Changes in v5:
  - Fix "int i" unused variable in patch 2 (as reported by PW)
  - Fix !svnapot build
  - Fix arch_make_huge_pte() which returned a real napot pte
  - Make __ptep_get(), ptep_get_and_clear() and __set_ptes() napot aware to
    avoid leaking real napot pfns to core mm
  - Fix arch_contpte_get_num_contig() that used to always try to get the
    mapping size from the ptep, which does not work if the ptep comes the core mm
  - Rebase on top of 6.14-rc7 + fix for
    huge_ptep_get_and_clear()/huge_pte_clear()
    https://lore.kernel.org/linux-riscv/20250317072551.572169-1-alexghiti@rivosinc.com/

Changes in v4:
  - Rebase on top of 6.13

Changes in v3:
  - Split set_ptes and ptep_get into internal and external API (Ryan)
  - Rename ARCH_HAS_CONTPTE into ARCH_WANT_GENERAL_HUGETLB_CONTPTE so that
    we split hugetlb functions from contpte functions (actually riscv contpte
    functions to support THP will come into another series) (Ryan)
  - Rebase on top of 6.11-rc1

Changes in v2:
  - Rebase on top of 6.9-rc3

Alexandre Ghiti (9):
  riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
  riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
  mm: Use common huge_ptep_get() function for riscv/arm64
  mm: Use common set_huge_pte_at() function for riscv/arm64
  mm: Use common huge_pte_clear() function for riscv/arm64
  mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
  mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
  mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
  mm: Use common huge_ptep_clear_flush() function for riscv/arm64

 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/hugetlb.h    |  22 +--
 arch/arm64/include/asm/pgtable.h    |  68 ++++++-
 arch/arm64/mm/hugetlbpage.c         | 294 +---------------------------
 arch/riscv/Kconfig                  |   1 +
 arch/riscv/include/asm/hugetlb.h    |  36 +---
 arch/riscv/include/asm/pgtable-64.h |  11 ++
 arch/riscv/include/asm/pgtable.h    | 222 ++++++++++++++++++---
 arch/riscv/mm/hugetlbpage.c         | 243 +----------------------
 arch/riscv/mm/pgtable.c             |   6 +-
 include/linux/hugetlb_contpte.h     |  39 ++++
 mm/Kconfig                          |   3 +
 mm/Makefile                         |   1 +
 mm/hugetlb_contpte.c                | 258 ++++++++++++++++++++++++
 14 files changed, 583 insertions(+), 622 deletions(-)
 create mode 100644 include/linux/hugetlb_contpte.h
 create mode 100644 mm/hugetlb_contpte.c

-- 
2.39.2


