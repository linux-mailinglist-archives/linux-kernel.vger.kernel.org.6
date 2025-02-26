Return-Path: <linux-kernel+bounces-532901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1965CA4538F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FDE189E7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08A022068F;
	Wed, 26 Feb 2025 03:01:50 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38C215764
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538909; cv=none; b=IGMIjOxS8FyBEF5ZK86INB64gBPXrmWqAptxNBPwlFGrvlGfH8W41qHPiENW4LVpQMGGgB1mg1W4lIqCMeDal7ezcC13aWQ2bedL6e4E8mXYfHO2eu1kQgNSz4eRhf9MuIBKfn7419mV80sK3T/Uo03BWIp/oiw3MDrFlj26k8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538909; c=relaxed/simple;
	bh=JUwyQmPKvTyN71rE3To1nzsYszhH81j9dtrjka017cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrWqAM/0Onw3EuHo1M0RZvbUoBPIqPHyWhLsI2/Eg3mKh9VS2lm09P0u5gx2yJOlqI2q1nfdQaxR24xQ3sBAprcYdalxV1KBPnFJHmnhjJeQ8mR11Qos+LbOEy5g99X/yz6me0EHuv9WOeqsA07Y6KtZ5TqscT54oAvlqbCV0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tn7fw-000000001Y5-0hvS;
	Tue, 25 Feb 2025 22:01:32 -0500
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
Subject: [PATCH v14 04/13] x86/mm: use INVLPGB for kernel TLB flushes
Date: Tue, 25 Feb 2025 22:00:39 -0500
Message-ID: <20250226030129.530345-5-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226030129.530345-1-riel@surriel.com>
References: <20250226030129.530345-1-riel@surriel.com>
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
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/mm/tlb.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index dbcb5c968ff9..f44a03bca41c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1077,6 +1077,18 @@ void flush_tlb_all(void)
 	on_each_cpu(do_flush_tlb_all, NULL, 1);
 }
 
+static void invlpgb_kernel_range_flush(struct flush_tlb_info *info)
+{
+	unsigned long addr, nr;
+
+	for (addr = info->start; addr < info->end; addr += nr << PAGE_SHIFT) {
+		nr = (info->end - addr) >> PAGE_SHIFT;
+		nr = clamp_val(nr, 1, invlpgb_count_max);
+		invlpgb_flush_addr_nosync(addr, nr);
+	}
+	__tlbsync();
+}
+
 static void do_kernel_range_flush(void *info)
 {
 	struct flush_tlb_info *f = info;
@@ -1087,6 +1099,22 @@ static void do_kernel_range_flush(void *info)
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
@@ -1097,9 +1125,9 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
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


