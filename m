Return-Path: <linux-kernel+bounces-527920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD15A4114D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6E23B1DD2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367AC1917E4;
	Sun, 23 Feb 2025 19:50:13 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B001419A9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740340212; cv=none; b=Pk3UZe/ESxVUYWJbnKLTdXJbPCWEBxJkULc1Qcdc8L+eTqyzIHJcLhzXCcLvxzWHLDMIICj79NszUOZREHhlsK2lqfBs1DB/Eiymn4s7xAQFrseLVaHEDDSJOtXJX6bwDFfBjaw+QdlTxGnyn9my4PiNWV4sMqamBDZEztQEqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740340212; c=relaxed/simple;
	bh=3TCftahpq0Wkzy5qD4BmaJb8oTplX3tUU1RLE/HlHh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZSlvBylODWAbVObGodNuUH2htfXV+rNquPVJN6ti36DDF4Ybh82PbENT2usRk6cXlbCAZ0Pkio8oXSPlg0Zo7RpMuxW7aPN7ktnRvngoP6bMDQkgCk9pLdacbCCjymnVdeo2KMgJDUINL6zfQZm/QfvxGn6ntHxfAVErJ5Omio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tmHyy-000000001hX-3o7T;
	Sun, 23 Feb 2025 14:49:44 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com,
	mingo@kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v13 04/14] x86/mm: use INVLPGB for kernel TLB flushes
Date: Sun, 23 Feb 2025 14:48:54 -0500
Message-ID: <20250223194943.3518952-5-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250223194943.3518952-1-riel@surriel.com>
References: <20250223194943.3518952-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Use broadcast TLB invalidation for kernel addresses when available.

Remove the need to send IPIs for kernel TLB flushes.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/mm/tlb.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index dbcb5c968ff9..59396a3c6e9c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1077,6 +1077,20 @@ void flush_tlb_all(void)
 	on_each_cpu(do_flush_tlb_all, NULL, 1);
 }
 
+static bool invlpgb_kernel_range_flush(struct flush_tlb_info *info)
+{
+	unsigned long addr;
+	unsigned long nr;
+
+	for (addr = info->start; addr < info->end; addr += nr << PAGE_SHIFT) {
+		nr = (info->end - addr) >> PAGE_SHIFT;
+		nr = clamp_val(nr, 1, invlpgb_count_max);
+		invlpgb_flush_addr_nosync(addr, nr);
+	}
+	__tlbsync();
+	return true;
+}
+
 static void do_kernel_range_flush(void *info)
 {
 	struct flush_tlb_info *f = info;
@@ -1087,6 +1101,22 @@ static void do_kernel_range_flush(void *info)
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
@@ -1097,9 +1127,9 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
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
2.47.1


