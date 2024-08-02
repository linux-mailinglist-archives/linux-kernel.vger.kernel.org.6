Return-Path: <linux-kernel+bounces-272694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81657946006
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E181C21A64
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B22139CE;
	Fri,  2 Aug 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rOzg7n9O"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243102101A0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611677; cv=none; b=IZeTcUcoeWXUH5NSWcWhUBS2LpO4G5sdUlx9FzZw+b8D0zpTWZO5WJnJQbU5yYokQqDgzsMM05MeBwpMr2rGg7dZkxBcO4c++TpPQ5ADmpDIuY2AmDUHe8AOQ0e7PEn0oVMZGnVeTEgJ/Zb1hdGrPWQj6ZyODyT0T/3MXmr+Za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611677; c=relaxed/simple;
	bh=gyZBrNQCxG+p7kBOZpKGcffI6R62jJJS1MBXN6iwzmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OGA6Wa+Z1BY7HbXRiblQWBcuVuZs8fnxV6V1IaLY0gu+UxMD/YES76FiW+/MCfKnNGG41KMuJEqUHZ8+f++L5+RBYi/Uz7rGldtzJzymZie470MZLg3LTO88IsKkxw/p5yDoBScc+Ev1XPsvYNZh2VZfXHCpCew2wJKj5pIhcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rOzg7n9O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso61245905e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722611673; x=1723216473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hBY2jE6SQVLEJ2rTtvFkGo52n+rOy9A54yoDBcuOdIo=;
        b=rOzg7n9OLSQxu9LaMiAFNhxZX/OTkT2WiLn5zvXI4Jk5i6lFOUBkSBPNIF+VJo2bL6
         djy3UTwRRRz1dVhrUVveV7NQwcw/42TIimfpJi0VZ546UzLTqdX80uZhkDMch4HCVyf+
         2RCWbgU9rvqIuu/OiZltOo+Q5WU8Us/SwzXauoeXFlIDdKDMxd+baJypqsSoeAebr732
         b0gg+cuBCPYwnvTRls9RYsRTP7WjzCWxYfVSiZhdW26lnKqLHG4/X6oQaChBG91b8NDY
         CgEw6EtW7SlU8/fFjn+QGi2flenz7VuqsZvaEuutYCpHBf31HNGX27QGK+qITvjX2DPk
         ZAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611673; x=1723216473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBY2jE6SQVLEJ2rTtvFkGo52n+rOy9A54yoDBcuOdIo=;
        b=wl8wb+jQF5n0E7Yo1cfsKTSnyXslKrYdiGDghR5GTwZAYcbQBtTlU2LvAyR/T7vm7x
         J05KtG7rF9JeyCGz4HzJYHb2K5GqdHeX2IKUNEOaiF/9+awR5anAIKjWFTEy/8DDRQ7A
         xyavYNis+QnqCrQ5BlD+W6TbScIBKpC80SZ6t/xWtLjOnuY9ADYvp86mxQ1oAE0PH4H+
         wPJskeLcbs4OzooYfT4umr7x59v7DhUtilLBWb3LAC+Y6CpqpmshSS+MyZldrLmyZR2U
         q5f2KreY3JYQ0DC7AaTbHy6UBmMqOgo766SLoMb7N0XpdBZwQDo1qz5Qj3iMOMSOHrrM
         srhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWy4F8wIluXAdlPzFdbW9pXPZvw+e8RHFTo1fuqyziHgA3GeORJGML59lx4ktEwCigg+hLckNDqfrN9USCUpKOX3Qe7AYtKLnJ+ogT
X-Gm-Message-State: AOJu0YxTHSzlI7xUq+avSn6fwEdUeJt7+QDB49bZVF6d1FnaOHtL0Gua
	NXx+ohxgK+L6cq/HK55i7DJpdlYDgiycDpr9qxIUN/ccAIdtZ7HMO1zhfKfyRpo=
X-Google-Smtp-Source: AGHT+IH4oAftIk88ByazbNx7M8aEqytLa2lIWzUyzNWyKW+yeSfszojodoNPHEIHeKtlRo8S+0ksYw==
X-Received: by 2002:a05:600c:3c84:b0:426:6ee7:d594 with SMTP id 5b1f17b1804b1-428e6af2443mr32146155e9.7.1722611673233;
        Fri, 02 Aug 2024 08:14:33 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8ad7f4sm98898355e9.11.2024.08.02.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:14:32 -0700 (PDT)
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
Subject: [PATCH v3 0/9] Merge arm64/riscv hugetlbfs contpte support
Date: Fri,  2 Aug 2024 17:14:21 +0200
Message-Id: <20240802151430.99114-1-alexghiti@rivosinc.com>
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

v2: https://lore.kernel.org/linux-riscv/20240508113419.18620-1-alexghiti@rivosinc.com/
v1: https://lore.kernel.org/linux-riscv/20240301091455.246686-1-alexghiti@rivosinc.com/

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
 arch/arm64/include/asm/pgtable.h    |  59 +++++-
 arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
 arch/riscv/Kconfig                  |   1 +
 arch/riscv/include/asm/hugetlb.h    |  35 +---
 arch/riscv/include/asm/pgtable-64.h |  11 ++
 arch/riscv/include/asm/pgtable.h    | 156 +++++++++++++--
 arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
 arch/riscv/mm/pgtable.c             |   6 +-
 include/linux/hugetlb_contpte.h     |  38 ++++
 mm/Kconfig                          |   3 +
 mm/Makefile                         |   1 +
 mm/hugetlb_contpte.c                | 271 ++++++++++++++++++++++++++
 14 files changed, 527 insertions(+), 595 deletions(-)
 create mode 100644 include/linux/hugetlb_contpte.h
 create mode 100644 mm/hugetlb_contpte.c

-- 
2.39.2


