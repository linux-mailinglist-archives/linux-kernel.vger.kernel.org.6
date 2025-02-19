Return-Path: <linux-kernel+bounces-521801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 682AEA3C270
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4681889F48
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37E18A959;
	Wed, 19 Feb 2025 14:46:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2F1E0B62
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976382; cv=none; b=oP8Eu5gCbIPaoTBv9+L35hD9mNFJvspKdB3Q0CzjCxfRDIQ+QWaYlM/honSPO9ogM5soMuYs/v5NZhLxEQGVjl9mVmWPTz/nHc1Glk9WHIX6pTqw1V6rptErW1xc/SQTufXh/A6qtduTBfJD1CAYGkeWD4CSGGqbqtf6TEYZQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976382; c=relaxed/simple;
	bh=Na8CwMKfZHUBjRSTymCHd4NTW74NZ0Z9OFJIxFyScTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGs7jYSPEmssSKyW9z4enYq9X6VVMeEQu/bzpfhp02GWBmr4cjLAoHfT2zPcV/df/HCmkkjsxiRm+GHz48CAYmqnTE0plhNpN7pqpyLYyRDozz5OfFYjQKdFqwOJBYUIoQeb0G8xl9Nt+GHvHVqB4nKn1sfRKw0823We0FuCkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B071688;
	Wed, 19 Feb 2025 06:46:38 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B64FD3F59E;
	Wed, 19 Feb 2025 06:46:16 -0800 (PST)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	joey.gouly@arm.com,
	broonie@kernel.org,
	mark.rutland@arm.com,
	james.morse@arm.com,
	yangyicong@hisilicon.com,
	robin.murphy@arm.com,
	anshuman.khandual@arm.com,
	maz@kernel.org,
	liaochang1@huawei.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	oliver.upton@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v1 2/3] arm64/mm: Delay tlbi in contpte_convert() under BBML2
Date: Wed, 19 Feb 2025 14:38:39 +0000
Message-ID: <20250219143837.44277-6-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250219143837.44277-3-miko.lenczewski@arm.com>
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When converting a region via contpte_convert() to use mTHP, we have two
different goals. We have to mark each entry as contiguous, and we would
like to smear the dirty and young (access) bits across all entries in
the contiguous block. Currently, we do this by first accumulating the
dirty and young bits in the block, using an atomic
__ptep_get_and_clear() and the relevant pte_{dirty,young}() calls,
performing a tlbi, and finally smearing the correct bits across the
block using __set_ptes().

This approach works fine for BBM level 0, but with support for BBM level
2 we are allowed to reorder the tlbi to after setting the pagetable
entries. This reordering means that other threads will not see an
invalid pagetable entry, instead operating on stale data, until we have
performed our smearing and issued the invalidation. Avoiding this
invalid entry reduces faults in other threads, and thus improves
performance marginally (more so when there are more threads).

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/contpte.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 55107d27d3f8..e26e8f8cfb9b 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -68,9 +68,13 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 			pte = pte_mkyoung(pte);
 	}
 
-	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
+	if (!system_supports_bbml2_noconflict())
+		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 
 	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
+
+	if (system_supports_bbml2_noconflict())
+		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 }
 
 void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
-- 
2.45.3


