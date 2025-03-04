Return-Path: <linux-kernel+bounces-544308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F8A4DFFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BF8173EEE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864A5204F61;
	Tue,  4 Mar 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8kbxrx7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFC204C13
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096707; cv=none; b=jvxayWCwemmcgJGkoSlAkyxZuPFguWfawfcO+dru0AEFSXb8ZtQBNk1Z7w+jYlW0vkSH8XW88X0/ssMUWgnnYgXCgyK6jhIVvYNkwVPIY/AYo8n8g4pNWR9YNSePsxnvjjwKDEYE9mR8ixVnYorw1zmeCR7EyDDqqpVQ72zG//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096707; c=relaxed/simple;
	bh=vdVKhRglpt9Vosn6QZofV8P5uPpS3iho3gB/iAAuoYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0UeC/MM7w8KmNbVqM8H8F0FRvT+pP4C+G3uH/OYFmN+OFgOp7NeZKiStiJLiRXj7d3ZhGqlO8LG/+HOA3kmNpy3J7NbNw0RrJggscrwac+zc/Ms0M0EK+8oZrYhMPKXnUvjJYkmz5W5RoyVswMKgXfsHt+3/CEaKsiY0EQzKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8kbxrx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4144AC4CEE9;
	Tue,  4 Mar 2025 13:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096706;
	bh=vdVKhRglpt9Vosn6QZofV8P5uPpS3iho3gB/iAAuoYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h8kbxrx7XK4Q+NvxBwsqKAlUsRBlNusvYOQqa0kf5IrWbDf80uhG5BGtg+q9zejMf
	 oAqZYkG9/qjpExATxHbmuTpbZK2dfkB7e6NzRlJsNoDhm2Mlg8TE+bEZz5S/zi/QOR
	 /Zw0xLHN3jXCTS2tzLM1RblDh0T7FFfcDnBF7wlZt7FWicx8bsydT8MZoHrPcWDSYV
	 t/u5zBdrjbIS1pMarOZxjDvEt/zd9iNJo/N/qn4PRfEBtEHfm1mrO9nnV1a+HuIXfv
	 WtAWNU17nNtTk9VdJaXMcKNm9IwQcRzKR5IQ3yE6ntI9ZLYVjMCJhWyICrHRxL689W
	 4CHBTPC+GBXiw==
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
	Dave Hansen <dave.hansen@intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v15 01/11] x86/mm: Consolidate full flush threshold decision
Date: Tue,  4 Mar 2025 14:58:06 +0100
Message-ID: <20250304135816.12356-2-bp@kernel.org>
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

Reduce code duplication by consolidating the decision point for whether to do
individual invalidations or a full flush inside get_flush_tlb_info().

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/r/20250226030129.530345-2-riel@surriel.com
---
 arch/x86/mm/tlb.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ffc25b348041..dbcb5c968ff9 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1000,6 +1000,15 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	BUG_ON(this_cpu_inc_return(flush_tlb_info_idx) != 1);
 #endif
 
+	/*
+	 * If the number of flushes is so large that a full flush
+	 * would be faster, do a full flush.
+	 */
+	if ((end - start) >> stride_shift > tlb_single_page_flush_ceiling) {
+		start = 0;
+		end = TLB_FLUSH_ALL;
+	}
+
 	info->start		= start;
 	info->end		= end;
 	info->mm		= mm;
@@ -1026,17 +1035,8 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				bool freed_tables)
 {
 	struct flush_tlb_info *info;
+	int cpu = get_cpu();
 	u64 new_tlb_gen;
-	int cpu;
-
-	cpu = get_cpu();
-
-	/* Should we flush just the requested range? */
-	if ((end == TLB_FLUSH_ALL) ||
-	    ((end - start) >> stride_shift) > tlb_single_page_flush_ceiling) {
-		start = 0;
-		end = TLB_FLUSH_ALL;
-	}
 
 	/* This is also a barrier that synchronizes with switch_mm(). */
 	new_tlb_gen = inc_mm_tlb_gen(mm);
@@ -1089,22 +1089,19 @@ static void do_kernel_range_flush(void *info)
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	/* Balance as user space task's flush, a bit conservative */
-	if (end == TLB_FLUSH_ALL ||
-	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
-		on_each_cpu(do_flush_tlb_all, NULL, 1);
-	} else {
-		struct flush_tlb_info *info;
+	struct flush_tlb_info *info;
+
+	guard(preempt)();
 
-		preempt_disable();
-		info = get_flush_tlb_info(NULL, start, end, 0, false,
-					  TLB_GENERATION_INVALID);
+	info = get_flush_tlb_info(NULL, start, end, PAGE_SHIFT, false,
+				  TLB_GENERATION_INVALID);
 
+	if (info->end == TLB_FLUSH_ALL)
+		on_each_cpu(do_flush_tlb_all, NULL, 1);
+	else
 		on_each_cpu(do_kernel_range_flush, info, 1);
 
-		put_flush_tlb_info();
-		preempt_enable();
-	}
+	put_flush_tlb_info();
 }
 
 /*
-- 
2.43.0


