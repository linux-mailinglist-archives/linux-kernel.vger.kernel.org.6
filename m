Return-Path: <linux-kernel+bounces-358212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F21997B80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A481F23E00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D5198842;
	Thu, 10 Oct 2024 03:50:56 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C70218C03D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532255; cv=none; b=Tif8l2KmSlb2bNpJ57jriKgySciRAA+E0uIeVedHYcLSG/46sZJGM3R9mqArEfcxyMB8FkS1NVUW2NgU0NxEaCDwMcNwkkEYnrYyVQjG1kiKuXbLtVCzjm/plVNZyCoKGJsVavThsB0siuCcHiYheB1+RftTQOdKTozXu10MnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532255; c=relaxed/simple;
	bh=t2KrUGZIDFgaKdCUSV0kybkLwE+kNnGsx3HNHyOYu5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZdgYqgklA3L+4x07aOSQ6uE2T7K0MROPwOqsztR77BiNLOZ0tXW3VrgC2kAXWARxT358XsjuRnppqJtWzOjS30gQNRxbeLzs+ZzhFWeaFeg5JeeLPdfIQ/9PcxWB7oWrmQrgIe74sO9L6DW9+xQRuVQ/Ejr15nETmejZPURwghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxLOsbTwdn27sRAA--.25416S3;
	Thu, 10 Oct 2024 11:50:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDx7tUZTwdnFP8hAA--.52915S5;
	Thu, 10 Oct 2024 11:50:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH 3/4] LoongArch: Add barrier between set_pte and memory access
Date: Thu, 10 Oct 2024 11:50:47 +0800
Message-Id: <20241010035048.3422527-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241010035048.3422527-1-maobibo@loongson.cn>
References: <20241010035048.3422527-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx7tUZTwdnFP8hAA--.52915S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

It is possible to return a spurious fault if memory is accessed
right after the pte is set. For user address space, pte is set
in kernel space and memory is accessed in user space, there is
long time for synchronization, no barrier needed. However for
kernel address space, it is possible that memory is accessed
right after the pte is set.

Here flush_cache_vmap/flush_cache_vmap_early is used for
synchronization.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/cacheflush.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
index f8754d08a31a..53be231319ef 100644
--- a/arch/loongarch/include/asm/cacheflush.h
+++ b/arch/loongarch/include/asm/cacheflush.h
@@ -42,12 +42,24 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
 #define flush_cache_dup_mm(mm)				do { } while (0)
 #define flush_cache_range(vma, start, end)		do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)		do { } while (0)
-#define flush_cache_vmap(start, end)			do { } while (0)
 #define flush_cache_vunmap(start, end)			do { } while (0)
 #define flush_icache_user_page(vma, page, addr, len)	do { } while (0)
 #define flush_dcache_mmap_lock(mapping)			do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)		do { } while (0)
 
+/*
+ * It is possible for a kernel virtual mapping access to return a spurious
+ * fault if it's accessed right after the pte is set. The page fault handler
+ * does not expect this type of fault. flush_cache_vmap is not exactly the
+ * right place to put this, but it seems to work well enough.
+ */
+static inline void flush_cache_vmap(unsigned long start, unsigned long end)
+{
+	smp_mb();
+}
+#define flush_cache_vmap flush_cache_vmap
+#define flush_cache_vmap_early	flush_cache_vmap
+
 #define cache_op(op, addr)						\
 	__asm__ __volatile__(						\
 	"	cacop	%0, %1					\n"	\
-- 
2.39.3


