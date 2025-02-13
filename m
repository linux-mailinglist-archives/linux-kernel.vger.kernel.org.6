Return-Path: <linux-kernel+bounces-513432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F67CA34A35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F0B18951B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7523A995;
	Thu, 13 Feb 2025 16:22:24 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05EB1C863C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463744; cv=none; b=C9/Sxh8y3ZI4j+2VXxyJsIfKOmx1BKCKqj69DUTqSAjfZRoFgMzhwNq7QVlM1+Wx/YefSbjuBP2DpfyfrxElD0AJrdNn+JozsKgFc3SiNHj+qRE32xpv1EUwwUc8xSZQYd+daQYO0DglLWH1s7wrnkQ5oFaWkJpUs8q5cjDapVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463744; c=relaxed/simple;
	bh=OultV2gf7z66EDxvE90LeulSf2nCT8KBuXJ7wGnhneQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3ioXaEmDoXDdqb3kuFs2SRc8RUNjhJ0mD+V7jkOm1mmsn5ijJ5NHih5PaBchvKP4guII9btn6dxJaKvJSCSM4IxRmXDrThviMkkyajL6Ououeb4PXdLbithc0XakytRu1Qoypob+AJ8NAWynWioQbLJM9aDhxdLoo0g5ajVqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tibr7-000000003xx-0qLG;
	Thu, 13 Feb 2025 11:14:25 -0500
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
	Rik van Riel <riel@surriel.com>,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: [PATCH v11 06/12] x86/mm: use INVLPGB for kernel TLB flushes
Date: Thu, 13 Feb 2025 11:13:57 -0500
Message-ID: <20250213161423.449435-7-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250213161423.449435-1-riel@surriel.com>
References: <20250213161423.449435-1-riel@surriel.com>
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
 arch/x86/mm/tlb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 924ac2263725..ce9df82754ce 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1077,6 +1077,28 @@ void flush_tlb_all(void)
 	on_each_cpu(do_flush_tlb_all, NULL, 1);
 }
 
+static bool broadcast_kernel_range_flush(struct flush_tlb_info *info)
+{
+	unsigned long addr;
+	unsigned long nr;
+
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return false;
+
+	if (info->end == TLB_FLUSH_ALL) {
+		invlpgb_flush_all();
+		return true;
+	}
+
+	for (addr = info->start; addr < info->end; addr += nr << PAGE_SHIFT) {
+		nr = (info->end - addr) >> PAGE_SHIFT;
+		nr = clamp_val(nr, 1, invlpgb_count_max);
+		invlpgb_flush_addr_nosync(addr, nr);
+	}
+	tlbsync();
+	return true;
+}
+
 static void do_kernel_range_flush(void *info)
 {
 	struct flush_tlb_info *f = info;
@@ -1096,7 +1118,9 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	info = get_flush_tlb_info(NULL, start, end, PAGE_SHIFT, false,
 				  TLB_GENERATION_INVALID);
 
-	if (info->end == TLB_FLUSH_ALL)
+	if (broadcast_kernel_range_flush(info))
+		; /* Fall through. */
+	else if (info->end == TLB_FLUSH_ALL)
 		on_each_cpu(do_flush_tlb_all, NULL, 1);
 	else
 		on_each_cpu(do_kernel_range_flush, info, 1);
-- 
2.47.1


