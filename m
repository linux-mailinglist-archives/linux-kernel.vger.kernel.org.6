Return-Path: <linux-kernel+bounces-517767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A5A38586
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549E8175BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811921CC7E;
	Mon, 17 Feb 2025 14:04:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387922083
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801077; cv=none; b=Ld/yJMBLTcqiOvGA2Hlvv2lMFZ5X6qiw61Fm6AxzF/q0HVvVESoS9GM5szXDiSJoqWa2to9SUNhqzobI3p7QTGDAdBOThs01S3cRnc6oGiHJlF4zTXElHkQwZVZFkEm2MN5MWUOSQ0AsqLnnjc3kp4HmEl1BkjYTns/YNLDJ2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801077; c=relaxed/simple;
	bh=tZmqPQHcoiiJErLx0eEk1aAs3qAh+2S/0YoS5UCOXqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKmvUUgZHOn81wy3sIXjgQr6e/LS+97q8v2ci0gRjlSuZRyztjTK/7+40joBpjciFEQfPsayhpE6k6X1OMuw2ueRFtcPWmkMxMRU0mFKUieeHqdODzk2ZtWtZFgt+5us9zznmQ8XRjBL8rHSh3WnAuGOAyBx3+HrPSNKyagiZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C3B9152B;
	Mon, 17 Feb 2025 06:04:54 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68753F6A8;
	Mon, 17 Feb 2025 06:04:29 -0800 (PST)
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
Subject: [PATCH v2 0/4] Fixes for hugetlb and vmalloc on arm64
Date: Mon, 17 Feb 2025 14:04:13 +0000
Message-ID: <20250217140419.1702389-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series contains some fixes for hugetlb on arm64, and is split out from v1
of a wider series at [1]. While the last patch is technically targetting core-mm
and is not directly related to arm64, I'd like to to go via the arm64 tree so
that the wider performance improvement series (v2 to be posted shortly) that
depends on this series doesn't have to be robust to the fix not being present.

I've included maintainers/reviewers for all the arches that are (trivially)
touched due to the API changes, hoping for some ACKs.

Changes since v1 [1]
====================
- Added Rb from Anshuman - Thanks!
- Added "#ifndef __PAGETABLE_PMD_FOLDED" around PUD_SIZE in flush_hugetlb_tlb_range()

I've marked all of these as candidates for backport to stable.

Applies on top of v6.14-rc3. All mm selftests run and pass.

[1] https://lore.kernel.org/linux-arm-kernel/20250205151003.88959-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (4):
  mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
  arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
  arm64: hugetlb: Fix flush_hugetlb_tlb_range() invalidation level
  mm: Don't skip arch_sync_kernel_mappings() in error paths

 arch/arm64/include/asm/hugetlb.h     | 26 ++++++++++-----
 arch/arm64/mm/hugetlbpage.c          | 48 +++++++++++++---------------
 arch/loongarch/include/asm/hugetlb.h |  6 ++--
 arch/mips/include/asm/hugetlb.h      |  6 ++--
 arch/parisc/include/asm/hugetlb.h    |  2 +-
 arch/parisc/mm/hugetlbpage.c         |  2 +-
 arch/powerpc/include/asm/hugetlb.h   |  6 ++--
 arch/riscv/include/asm/hugetlb.h     |  3 +-
 arch/riscv/mm/hugetlbpage.c          |  2 +-
 arch/s390/include/asm/hugetlb.h      | 12 ++++---
 arch/s390/mm/hugetlbpage.c           | 10 ++++--
 arch/sparc/include/asm/hugetlb.h     |  2 +-
 arch/sparc/mm/hugetlbpage.c          |  2 +-
 include/asm-generic/hugetlb.h        |  2 +-
 include/linux/hugetlb.h              |  4 ++-
 mm/hugetlb.c                         |  4 +--
 mm/memory.c                          |  6 ++--
 mm/vmalloc.c                         |  4 +--
 18 files changed, 87 insertions(+), 60 deletions(-)

--
2.43.0


