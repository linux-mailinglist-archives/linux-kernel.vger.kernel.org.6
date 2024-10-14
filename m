Return-Path: <linux-kernel+bounces-363898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD599C836
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C4628E6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167521D95AB;
	Mon, 14 Oct 2024 11:02:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5951D89F4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903723; cv=none; b=AdEkxNaks5eXTzuAl2bRWEVcTr7bqOQxmElUA0TvszxCASygQtE2HVxOihjMVeKcHPBfY1KskopkaYrQ9Zkn2GF9IfvKKOlYreXwJXtro9iQxRcEplLkPMXLxTn88erZ78SgeQVgaMVwuBKuawrwz5mYDBH6DKZ9PEwcKKMdRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903723; c=relaxed/simple;
	bh=NgjUB+me2wHotMT/rnk6ejI3c7wIZgQ/0hi0Oxaz9Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEdnLmcPLWmCHu3nUMR5j4PkZoze/PRGWbJw50Y+e1gQXN7WCTi+cQLmCY6LLkqDdJ9jaR4SRDO+Gu5o7AGt1YPeOAmsFHXkwr9T2YmEkmO+1D5kfCAGtjNNm0QjJXO2jd2/MDmkDb+3Gbg9/TsqKH4SkK2Hgh5f7VXWFvDwHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A49A51A25;
	Mon, 14 Oct 2024 04:02:31 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5B033F51B;
	Mon, 14 Oct 2024 04:01:59 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 51/57] arm64: Introduce cpu features for page sizes
Date: Mon, 14 Oct 2024 11:58:58 +0100
Message-ID: <20241014105912.3207374-51-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce one boot cpu feature per page size, ARM64_USE_PAGE_SIZE_*K.
These will enable use of the alternatives framework to patch code based
on the page size selected at boot.

Additionally, this provides a neat way to figure out what page size is
in use during boot from the kernel log.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/kernel/cpufeature.c | 25 +++++++++++++++++++++++++
 arch/arm64/tools/cpucaps       |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7705c9c0e7142..e5618423bb99d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1831,6 +1831,13 @@ static bool has_nv1(const struct arm64_cpu_capabilities *entry, int scope)
 		  is_midr_in_range_list(read_cpuid_id(), nv1_ni_list)));
 }
 
+static bool use_page_size(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	return (entry->capability == ARM64_USE_PAGE_SIZE_4K && PAGE_SIZE == SZ_4K) ||
+	       (entry->capability == ARM64_USE_PAGE_SIZE_16K && PAGE_SIZE == SZ_16K) ||
+	       (entry->capability == ARM64_USE_PAGE_SIZE_64K && PAGE_SIZE == SZ_64K);
+}
+
 static bool has_lpa2_at_stage1(u64 mmfr0)
 {
 	unsigned int tgran;
@@ -2881,6 +2888,24 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_nv1,
 		ARM64_CPUID_FIELDS_NEG(ID_AA64MMFR4_EL1, E2H0, NI_NV1)
 	},
+	{
+		.desc = "4K page size",
+		.capability = ARM64_USE_PAGE_SIZE_4K,
+		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
+		.matches = use_page_size,
+	},
+	{
+		.desc = "16K page size",
+		.capability = ARM64_USE_PAGE_SIZE_16K,
+		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
+		.matches = use_page_size,
+	},
+	{
+		.desc = "64K page size",
+		.capability = ARM64_USE_PAGE_SIZE_64K,
+		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
+		.matches = use_page_size,
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index ac3429d892b9a..5cb75675303c6 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -71,6 +71,9 @@ SPECTRE_BHB
 SSBS
 SVE
 UNMAP_KERNEL_AT_EL0
+USE_PAGE_SIZE_4K
+USE_PAGE_SIZE_16K
+USE_PAGE_SIZE_64K
 WORKAROUND_834220
 WORKAROUND_843419
 WORKAROUND_845719
-- 
2.43.0


