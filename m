Return-Path: <linux-kernel+bounces-510015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E39A31750
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441F73A3210
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF108265CD8;
	Tue, 11 Feb 2025 21:08:36 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C22264FA9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308116; cv=none; b=kABTQ0/Xs8h7L2ypB0pKMMgUR0MifHd9KHEVoBHQq7B6sYN2XTPwOPrIqt8K2cviAmQD91feVLRHxdbhW6bpmHW3IhwDZmve7HFjkod+uzYrEqbhyqpcqE94WOOJ8JyYqdsxK5c8INvereIdcgQ4MaQM+znK2573ToFZTp8lMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308116; c=relaxed/simple;
	bh=Ap5A/HY7+O6tDMb8RNFA25mXWNIz2vcTTyQGIqN7HhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3RiFMiWOLIuD67vEIASJHmDWIbEH4QzJr7Y/LTknsN+Z8k0188lLZ0/PqE+05sUTsQD5/rz8i2hB57QfGHFfGfiE3bKnaJlFez7bbe9hTVTpc7cgGr8T5ENHW+7RJq8ukj7sUHplTdFHeIbR+YmWsvZUwoMtb4q6UqrAQnfuk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1thxUX-000000008HU-32ms;
	Tue, 11 Feb 2025 16:08:25 -0500
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
Subject: [PATCH v10 06/12] x86/mm: use INVLPGB for kernel TLB flushes
Date: Tue, 11 Feb 2025 16:08:01 -0500
Message-ID: <20250211210823.242681-7-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211210823.242681-1-riel@surriel.com>
References: <20250211210823.242681-1-riel@surriel.com>
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
---
 arch/x86/mm/tlb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 58c8a6a94e65..54a118b22e59 100644
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
+		nr = min((info->end - addr) >> PAGE_SHIFT, invlpgb_count_max);
+		nr = max(nr, 1); /* Round up if the last page is partial. */
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


