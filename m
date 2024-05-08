Return-Path: <linux-kernel+bounces-173117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A508BFBC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34431C215A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFDB81ADB;
	Wed,  8 May 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BbXhZm8r"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94681ABF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167120; cv=none; b=XQ6a9Fegb1rRuY5mq2uKGtzmk7pLJ9hPXBDj1xei0eOvLiL1YW65Y2thSdPQrsYNlZPTpEqtFl3rQJf++cm+8oIOhTXUaw464Tg5W2Nf+kW/YXkjihPZOVgGm37yA5Hrosq8AfDnAmpO3xm4+m2IYAnirvLqYo9oW2U8rC2x3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167120; c=relaxed/simple;
	bh=9Tw14u/QjNGtWMQB3QHmKHHHhMzkhGdimGLqtqYRluM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oPaakDsM3mLd8FWlX6mn0B8CmMD4HgANcI3/h4h0u4FvNBjdzXI/EvAVBa+lgjBy0b+80byTr6cq1IYVUP+7Zr/h4KG4h3ha30gEJRurNkPHs6foDT3IYLwOHOt1GwynGKZoTNSA9yDKekzFg6bbXxf8ruue3RpThPuo+dCFIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BbXhZm8r; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso53218081fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715167117; x=1715771917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7s2Jc0w0RwoJia0FRkNkBXydPtaseE14QqCOpfNooII=;
        b=BbXhZm8rWzVQUJow6yk/wXL8edYHa9SfWqLVbqhN7uKdxr7JDTvOuG6EHe59DuF5d8
         BwAnKVchjp7Hd0IP3ex8LyhvwcwA0CaOTmphXobmkd5Ccd/HqW3jZrO6H1QP+VGayRD5
         fhyCMHoZRcAxOgsjHNNRtq8C/LUD/IXdJ5TWnfOyADwqD58oWXmQ6dwd/t6OYjKs6q4N
         S7N/+cIOPHHoXg5idMupeYE37z+M75SrSeb4IlgpI5zNS7wkzeW+gOxA9UjIl9nzHKCv
         YRcG+Ar7UFBmYR87FY1ZEni9F5oN8K6u+TtbCf7inO+8ocObpfTMNzK/o6LKUvmMld3/
         llKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167117; x=1715771917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7s2Jc0w0RwoJia0FRkNkBXydPtaseE14QqCOpfNooII=;
        b=IBGoxDRTBksrixyBbmj0mvkR9QiawF8Tde3OxPuadlyXId43CIvU8/D4K5YpyxSOmX
         RiJeV449gfXKsDif6zD/SiQwFC6xuTZ5Fb9rqYdUrB6Vm2L1KVvb1EDq6xM2cMq2Xvnv
         sTcE09QbspKwHUMzuKqtuNtizGf26EJoULldWUfnDX5cCm3lLYJj+0dzttDC+G0NEOzE
         rfSTJ2ZhDBS+i3YycCWAG76JuL8pu5P6/EIBJe1B8ucytboTO8z4gHvGHirL+KfT224i
         QQSRn3AL22UMtfqhfW5UJaPtfK6kLV96cYZMLL1zJqc9YEPwnqqPCnHjJS8kCpDeXmvc
         JwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1L2MFomSZ/3ZOuNiVMhcehDUEy85b474iyCIpiQAVvhJscDYVj/fqxZYMsCFFD96d3//4EE0m4WjiL/z/DPluKbI8RlUJe5u25G+R
X-Gm-Message-State: AOJu0YxeuTKzj44IEQQnkdClxDaQGME/NlM2bxT6Ka1P7vm++HKmNocn
	Es73fQ6r60uduc0gthlOPTyIuPa7PrxPGRqlFjFfI2viM/C3aCNhw8z+rpd9Oco=
X-Google-Smtp-Source: AGHT+IE4qIFoqxTdkb49q/bY17UwLRoTIUg63kSAW3jbHy8RJOOcZA258spjIObf7gc4cKs2O6G04w==
X-Received: by 2002:a2e:4602:0:b0:2e0:3132:94d4 with SMTP id 38308e7fff4ca-2e446f7c72amr11638751fa.16.1715167116751;
        Wed, 08 May 2024 04:18:36 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f21-20020a2ea0d5000000b002e123933dcbsm2422820ljm.120.2024.05.08.04.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:18:36 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 0/9] Merge arm64/riscv hugetlbfs contpte support
Date: Wed,  8 May 2024 13:18:20 +0200
Message-Id: <20240508111829.16891-1-alexghiti@rivosinc.com>
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

Changes in v2:
  - Rebase on top of 6.9-rc3

Alexandre Ghiti (9):
  riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
  riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
  mm: Use common huge_ptep_get() function for riscv/arm64
  mm: Use common set_huge_pte_at() function for riscv/arm64
  mm: Use common huge_pte_clear() function for riscv/arm64
  mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
  mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
  mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
  mm: Use common huge_ptep_clear_flush() function for riscv/arm64

 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/pgtable.h    |  56 +++++-
 arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
 arch/riscv/Kconfig                  |   1 +
 arch/riscv/include/asm/hugetlb.h    |   2 +-
 arch/riscv/include/asm/pgtable-64.h |  11 ++
 arch/riscv/include/asm/pgtable.h    | 153 +++++++++++++--
 arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
 arch/riscv/mm/pgtable.c             |   6 +-
 mm/Kconfig                          |   3 +
 mm/Makefile                         |   1 +
 mm/contpte.c                        | 272 ++++++++++++++++++++++++++
 12 files changed, 480 insertions(+), 544 deletions(-)
 create mode 100644 mm/contpte.c

-- 
2.39.2


