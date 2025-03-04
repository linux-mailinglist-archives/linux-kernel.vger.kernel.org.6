Return-Path: <linux-kernel+bounces-544311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A287A4DFFE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9457A732C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688EA204C13;
	Tue,  4 Mar 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7wXgql1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066A2054FB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096716; cv=none; b=WKoe/jmEK53bLoHYGUT30UsEyN/c1XvbtfqXaZfI9JDHFUukz/BVTY108S+Y+aN10Y+o+N9MyTvj0pas72Ok7tVZZXhS9Ds2kcj3m9gEKxQAxOo7tJZECsoU8t9/H+b5xFvjBaIKmd1y3lRk4oQ5zSSKyOiSamGaOTylzhenkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096716; c=relaxed/simple;
	bh=SCBkxqxjfa8HkA0BTRuWWUnRPjL2osKJM/O5wsn1zgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKl0ULndkvn1T3Mb7VvWpwxO5ioOHzVT6box4gQXSl/NGWRQEn54pBX51RmLIu27lMZP6EIIf4C6rWYBRqu4igOcak7P4d+My98QEKV2EBDHxiDtxw50qX2My/Gpk2DDv3GGsWl7xOpZZbCakfPtZqlG8iZ1iehxkeACGqFL938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7wXgql1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76C2C4CEE9;
	Tue,  4 Mar 2025 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096716;
	bh=SCBkxqxjfa8HkA0BTRuWWUnRPjL2osKJM/O5wsn1zgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7wXgql127OzEvUasxqBMsRN6H4aOQJkUBD9QFFp0MlWYDxeAMoemW1MSkD4DdFqs
	 Y+dzSoFejSn2qTJdDM/MMYQzqDcJHWXSkBLHFhvyJlXZnqTc+q9qU4EfWlJiPxNMri
	 4Ub42ppW+HYV/33X/CNhXK9xRzE0lEcRMQ2a+lFHZggSFPa8OWGKesGc7na8LhUotY
	 13TM2ptAtVMkYvywbkYqXhdYkHXtIFNDSsoD1E3T7O4ctYWFvG24yllC8qH3EJqjd5
	 ScPHoLs5KpaTir7CU2nrRL173YHIC5U/nkdibqRywUCjXPphsc/MxLuXvYg+Gj3Uqi
	 61rZwEDraemlg==
From: Borislav Petkov <bp@kernel.org>
To: riel@surriel.com
Cc: Manali.Shukla@amd.com,
	akpm@linux-foundation.org,
	andrew.cooper3@citrix.com,
	jackmanb@google.com,
	jannh@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhklinux@outlook.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	zhengqi.arch@bytedance.com,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v15 04/11] x86/mm: Use INVLPGB for kernel TLB flushes
Date: Tue,  4 Mar 2025 14:58:09 +0100
Message-ID: <20250304135816.12356-5-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304135816.12356-1-bp@kernel.org>
References: <20250304135816.12356-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

Use broadcast TLB invalidation for kernel addresses when available.
Remove the need to send IPIs for kernel TLB flushes.

   [ bp: Integrate dhansen's comments additions, merge the
     flush_tlb_all() change into this one too. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-5-riel@surriel.com
---
 arch/x86/mm/tlb.c | 48 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index dbcb5c968ff9..8cd084bc3d98 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1064,7 +1064,6 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
 }
 
-
 static void do_flush_tlb_all(void *info)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
@@ -1074,7 +1073,32 @@ static void do_flush_tlb_all(void *info)
 void flush_tlb_all(void)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
-	on_each_cpu(do_flush_tlb_all, NULL, 1);
+
+	/* First try (faster) hardware-assisted TLB invalidation. */
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		invlpgb_flush_all();
+	else
+		/* Fall back to the IPI-based invalidation. */
+		on_each_cpu(do_flush_tlb_all, NULL, 1);
+}
+
+/* Flush an arbitrarily large range of memory with INVLPGB. */
+static void invlpgb_kernel_range_flush(struct flush_tlb_info *info)
+{
+	unsigned long addr, nr;
+
+	for (addr = info->start; addr < info->end; addr += nr << PAGE_SHIFT) {
+		nr = (info->end - addr) >> PAGE_SHIFT;
+
+		/*
+		 * INVLPGB has a limit on the size of ranges it can
+		 * flush. Break up large flushes.
+		 */
+		nr = clamp_val(nr, 1, invlpgb_count_max);
+
+		invlpgb_flush_addr_nosync(addr, nr);
+	}
+	__tlbsync();
 }
 
 static void do_kernel_range_flush(void *info)
@@ -1087,6 +1111,22 @@ static void do_kernel_range_flush(void *info)
 		flush_tlb_one_kernel(addr);
 }
 
+static void kernel_tlb_flush_all(struct flush_tlb_info *info)
+{
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		invlpgb_flush_all();
+	else
+		on_each_cpu(do_flush_tlb_all, NULL, 1);
+}
+
+static void kernel_tlb_flush_range(struct flush_tlb_info *info)
+{
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		invlpgb_kernel_range_flush(info);
+	else
+		on_each_cpu(do_kernel_range_flush, info, 1);
+}
+
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	struct flush_tlb_info *info;
@@ -1097,9 +1137,9 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 				  TLB_GENERATION_INVALID);
 
 	if (info->end == TLB_FLUSH_ALL)
-		on_each_cpu(do_flush_tlb_all, NULL, 1);
+		kernel_tlb_flush_all(info);
 	else
-		on_each_cpu(do_kernel_range_flush, info, 1);
+		kernel_tlb_flush_range(info);
 
 	put_flush_tlb_info();
 }
-- 
2.43.0


