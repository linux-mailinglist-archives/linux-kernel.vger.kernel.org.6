Return-Path: <linux-kernel+bounces-533778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6679A45E77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F463B7D23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141F21B9DE;
	Wed, 26 Feb 2025 12:07:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C3D21B196
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571633; cv=none; b=nUVF+88/tNRgW5KjEhcwJFFeQ2+CeYVjhPrCuGSN2jgUv4mrUwEbigPdIUmVceOZWfzJZLMAyZJUJ3kOIgDii7qzTlzrfPCcCMmXzHD63UUI3ajWx2n6c9xCmHWxPvgjcVkAeiH/pgjhrqFoPnWGSH4Mb8YXuVINJqSQFYaV2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571633; c=relaxed/simple;
	bh=WPoZx1BxYDQFf2WzJ+3g8CffgG9uDPrxhEkxCQdY6II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWXmTqcK10Xe3PArenhaInMYjqT2XRey+Y/shaN0WUX2WjKnppS5zZ9+JWrXo9EFUN0zcPKfVPPGpt5MtHAqS8YipEI3U1wI7Os4B73ukHWLl3D52Blpx1lxVAtum018NNi/Fo2yv3NJFNNS3XE5rR9ULq5qePTxRUWwfJbc1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F17C413D5;
	Wed, 26 Feb 2025 04:07:26 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8056A3F5A1;
	Wed, 26 Feb 2025 04:07:05 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Fixes for hugetlb on arm64
Date: Wed, 26 Feb 2025 12:06:50 +0000
Message-ID: <20250226120656.2400136-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series contains some fixes for hugetlb on arm64. It turns out that I will
need to rework the companion performance improvement series a bit and as a
result won't be relying on the purely mm fix that was patch 4 in v2. So I've
dropped that patch and will send it to mm separately.

I think this should be ready for merge now.

Changes since v2 [2]
====================
- Added Rb/Ab from various people - Thanks!
- Reworked num_contig_ptes() to return 1 by default and warn for bad sizes
- Fixed some formatting issues in s390 header
- Moved s390's huge_ptep_get_and_clear() to header and made it inline
- Removed patch 4; I'll send this to mm list separately
- Fixed various typos in commit logs

Changes since v1 [1]
====================
- Added Rb from Anshuman - Thanks!
- Added "#ifndef __PAGETABLE_PMD_FOLDED" around PUD_SIZE in flush_hugetlb_tlb_range()

I've marked all of these as candidates for backport to stable.

Applies on top of v6.14-rc3. All mm selftests run and pass.

[1] https://lore.kernel.org/all/20250205151003.88959-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/all/20250217140419.1702389-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (3):
  mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
  arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
  arm64: hugetlb: Fix flush_hugetlb_tlb_range() invalidation level

 arch/arm64/include/asm/hugetlb.h     | 26 ++++++++----
 arch/arm64/mm/hugetlbpage.c          | 61 ++++++++++++----------------
 arch/loongarch/include/asm/hugetlb.h |  6 ++-
 arch/mips/include/asm/hugetlb.h      |  6 ++-
 arch/parisc/include/asm/hugetlb.h    |  2 +-
 arch/parisc/mm/hugetlbpage.c         |  2 +-
 arch/powerpc/include/asm/hugetlb.h   |  6 ++-
 arch/riscv/include/asm/hugetlb.h     |  3 +-
 arch/riscv/mm/hugetlbpage.c          |  2 +-
 arch/s390/include/asm/hugetlb.h      | 16 ++++++--
 arch/s390/mm/hugetlbpage.c           |  4 +-
 arch/sparc/include/asm/hugetlb.h     |  2 +-
 arch/sparc/mm/hugetlbpage.c          |  2 +-
 include/asm-generic/hugetlb.h        |  2 +-
 include/linux/hugetlb.h              |  4 +-
 mm/hugetlb.c                         |  4 +-
 16 files changed, 82 insertions(+), 66 deletions(-)

--
2.43.0


