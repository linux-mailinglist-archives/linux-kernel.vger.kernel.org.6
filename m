Return-Path: <linux-kernel+bounces-173145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ADF8BFC22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F3F1F217AF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A481AD7;
	Wed,  8 May 2024 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="znBmokDd"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBD80C16
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168068; cv=none; b=sp0qCjLwb5NYtDZjJoLBiVSKof1iyoZY+7yMep5z60CvSjMgy2W0oXr8vr/99rIFDa/GBHzxepV2MAG/n34FVQkfhVpxXn/yZoQwKgTvJfbSl+qpDnAhA/kDzcjTil7mX3n+jUtMueOpFqAs11PWAa6M4mrxl1nanxzYyJEJerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168068; c=relaxed/simple;
	bh=9Tw14u/QjNGtWMQB3QHmKHHHhMzkhGdimGLqtqYRluM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZwNv21EN6hHVKmRe0PtSGJrgE8YzKSjlOhlUhStJaZi6+R0G3r+SDXP1W3WEYUxwWwye7HGJ0zyDVcwLSyS5q5j7BcOYkmMKAhvrS5Ba6cguAD0FdfuNiciMlJ+k2YiePxmVTX/KmBNUjWB0f6wtoxXI7oSb73aMDFVV4kdvNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=znBmokDd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f57713684so5324653e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715168064; x=1715772864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7s2Jc0w0RwoJia0FRkNkBXydPtaseE14QqCOpfNooII=;
        b=znBmokDd2QiiR2G9/fWbwr12/6wd5lpcw95EIiXTk7MvfAmooUgZ5smYB0nzOL62hw
         wGV8zx05KbFDKYfIraNvg80v3BvnhQpQtHTji/ty/wg8AhCfmXJtPEXCebyUUuvobSse
         zrxz4z+N10oCZ9Wd8BLCGY2HnJKHwC/5DCK9Dr3N6piFkTM/XHUCln3fmybm7JcgFUQi
         m4yJn5l747AWh84xMEnQxCyUKTSU9K3PgXJUyC9i1hhQpNxpebVBHfd74HHSVCrK3Q1X
         IJvWj+ahl70Pcr9J3tiNJrfEONEw64/EoPbtGQNKWljZSxU0qqs5bemUO3+5l6y9/E+V
         90WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168064; x=1715772864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7s2Jc0w0RwoJia0FRkNkBXydPtaseE14QqCOpfNooII=;
        b=sBEkzZST5r/7DVa1k7yNs8/s/fFfFKCAjPN+xS87iI+2HP26uNMsXoF9DVGugtW+WX
         IPK+zphjvt4gdCBofsyfaT3vBd61Mr5PB+oVWPAh4+j+LKm/ca+nbIy5owjg9bjXLAXq
         MMXIQy6DEKq7Vkrap+gj6ObT996VmN3YrK6we1vc6UzH5q20mgIRh2r7aj9v2jWqcF5a
         UDfQWsSKhFYtTLYu1aIW1zIiZby2c7V5ELN8yfi0L/PlnQunEciqQe8C/hXa9TOE+j1U
         A8+4rjmJ/yx6emntd1Eqm4Zbuz/IaF2igBxFFqqJY4Zf/QZOKS1YQuQHCswXX/DrLnC7
         y3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUOIHsgxBtVzxepRClqxm8A2/tFtNz8nZi1DNZ4VQWvYRFEx82nxPprn1XQA0H5M/hUVNqXgpBB8jvJ+RXd/OkJtX3E83oGNJJpsshF
X-Gm-Message-State: AOJu0YxD4elMJ3/4MzYd7qtC9d84Y/Nl3qoDkylAvzTHXtkUiJ/qQ+SD
	uQWoLucCLNxR/gvlzp7W4xp/pDTCZ7dMIMhsdCrViNF6Dr1Oza79EjXARa7cZSQ=
X-Google-Smtp-Source: AGHT+IHQ0+1QRr9yi6sWcDZ0EGp5PxgqjX1SIZMCwr+oGXVeU6XovCaKI7Yf+LAxYXYIcWcDnNZqDg==
X-Received: by 2002:a05:6512:3493:b0:51d:7d4a:5e6e with SMTP id 2adb3069b0e04-5217c276f94mr1361793e87.3.1715168064446;
        Wed, 08 May 2024 04:34:24 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z8-20020a05600c0a0800b00418db9e4228sm2001659wmp.29.2024.05.08.04.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:34:24 -0700 (PDT)
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
Subject: [PATCH RESEND v2 0/9] Merge arm64/riscv hugetlbfs contpte support
Date: Wed,  8 May 2024 13:34:10 +0200
Message-Id: <20240508113419.18620-1-alexghiti@rivosinc.com>
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


