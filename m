Return-Path: <linux-kernel+bounces-539140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9EA4A168
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DBD3B0C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B2C2777E0;
	Fri, 28 Feb 2025 18:25:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D327426B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767117; cv=none; b=VS/Jw0k5bnwNkiOlGF6/eq8XhE8DwcV1BZLioWIW7kQMcUKN9KOs0l0FFmKrk/1hdlI7Ma7o2i0W1zYLNjzoLsuHlwneKxc78t2x+fMMNdnk6Ll4xjGd3vSHbZ8o12w145ysFrsz7AZgLtVEnBJi/9MntZ0PhfGutFyXXTQlh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767117; c=relaxed/simple;
	bh=M8PklyqTdrEX2UOqTvAkAODbiY//AcFQSHqMJTyBN5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0UZBK/NgUh6XeoUMMjDNvK4T1LmzTOS/VWfHtNzamlVcr2rPQxhvNu8CVYGQNzNLGcHvrnZltboKR3aNofbA0OEI66LwggE2Sx4yINDAeiW6RhodhU3kNZuc2hRV9FAJg7+w8lasN96t4HGAWx78qEVWxgT0L++etzFmMxFKZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 330C6176A;
	Fri, 28 Feb 2025 10:25:30 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C73F03F6A8;
	Fri, 28 Feb 2025 10:25:11 -0800 (PST)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	joro@8bytes.org,
	jean-philippe@linaro.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	oliver.upton@linux.dev,
	james.morse@arm.com,
	broonie@kernel.org,
	maz@kernel.org,
	david@redhat.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v2 2/4] arm64/mm: Delay tlbi in contpte_convert() under BBML2
Date: Fri, 28 Feb 2025 18:24:02 +0000
Message-ID: <20250228182403.6269-4-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250228182403.6269-2-miko.lenczewski@arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
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
index 55107d27d3f8..145530f706a9 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -68,9 +68,13 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 			pte = pte_mkyoung(pte);
 	}
 
-	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
+	if (!system_supports_bbml2_noabort())
+		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 
 	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
+
+	if (system_supports_bbml2_noabort())
+		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 }
 
 void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
-- 
2.45.3


