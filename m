Return-Path: <linux-kernel+bounces-400590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7793C9C0FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031741F23765
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074B218950;
	Thu,  7 Nov 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdkPGkY0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757A21893A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010852; cv=none; b=rbUWWH4iZ3KkrUvfZYt40vyYpVhscNhADQnz3dO+FmheFzQTwz51VPc9Qk8iSUEJTzHUHGynholh9NHrA/vj53fLe8N+yl+GvjeKAXtI52cXvTL6SeWJlltNyDRikL0+impieRhzfrnfuXN5glW8ee5uCElgpFK2Q706PKyKe9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010852; c=relaxed/simple;
	bh=YI+CbUBxtZDwtEvf4/YhGH6h78EVLsQ4qA//gteVUIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cv6L9uRQYw1UbItzAtc3G1V+OQ580JFHnT/43+R0+T4ylEbkIsT6Hghr/njv80HmswH6pF9DatyWQLQ2r01mU17y8Dj6swxbC+yusLdChTyzogEQwq6Uw8SeoaN+ywwJ+VQbRv1ckgjB9/JpDirsLNg9bsjCBT+4vzy0tvC3NW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PdkPGkY0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8901dff1so28844577b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 12:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731010849; x=1731615649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kshc+5TecBnElfjUZu5d6HS1cvMCCmL1E/fnjesi6Ow=;
        b=PdkPGkY0ftoi+Eg0TS1AGa4hSlyvDyAWmAds3Hd5wi8sYPiEqjkUZjf2r8Ay+gehU4
         i73wJhtn/Z5m/voRnR9+qEgALcns3WrgNA5nnUbNLFam654N1Hh4jI7x4jW8Z252MTWi
         rrNX6sd/QvOo4DTjP8GWCX2HJIeFes2ofUah6L4rhT4wsjKOW715u2WWX+XbJZIio/Na
         XklJkOQFFzFM9s0EuH9dT921Ju+uPuYusnlXZAHnKCMSNl43vtlVNAw4QMtEKLoBz30n
         lOOwFIvGrPaU4vgJXN3mBYjap/iALIeErFAuCmkh1Vp1CqRe8YesjxxDVDzIH7vSSEIb
         AUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731010849; x=1731615649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kshc+5TecBnElfjUZu5d6HS1cvMCCmL1E/fnjesi6Ow=;
        b=ht+6y44RKUPooIDN7EO4l+XNffPyWwoG3k1cQ2HPWBFZOYZHZGonzAElI/ypNiRB0+
         hBP0XFadpI7fGckYoxLpsBAIiRDo4mE7X4rIOHMtZpX14rWEQdLkHkbQT8s3GIZdG9Bt
         mfuM87wZMe4wn+YqhUBq7y5Ik8BnnPbcEcIf5qYwyltfXtAy2kOivFbBv7Duy0Dm4E8C
         Z52nxtvDzXx7JeHVt/M/LUY3/nY74jxYK+TbPTJnecvSwb4QyGzdxEjWCbcET5CWO8Wu
         dU4ZhRP57816+86IaLQ3iOhK6VhjJATT9QUGyY5ClJrucbOTlNz9KdI/AI/c81rsOTqR
         NlmA==
X-Forwarded-Encrypted: i=1; AJvYcCXp5TaSLG4rnjDVrzxbmNZRaWFita0C3C+WREmeum9fleJHtTmrFqPrZ6Y7rmktj1aoYU0vVsu6/oeAVXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysd5M/N9Yc2k+kbBgwXJ0xIjPOYORezW+BlkHqNkzLIZ+RZ+fS
	SQK2eudlZKhCFeza0LRblinw9iFBGOzqIaUNnYS+4S9RKct02LNbbm/lLrkB7iIRq42zlqCKRKH
	4GQ==
X-Google-Smtp-Source: AGHT+IEjIv/a3qKWak4A1Vn18DXvCmBDzVmrxwgOEzTP/K9OGHGZiWxXZlnHtaXBKDC55f0LUGtreAyzNRE=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:a4c0:c64f:6cdd:91f8])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:c08:b0:6c1:298e:5a7 with SMTP id
 00721157ae682-6eaddfb88bcmr33137b3.5.1731010849660; Thu, 07 Nov 2024 12:20:49
 -0800 (PST)
Date: Thu,  7 Nov 2024 13:20:32 -0700
In-Reply-To: <20241107202033.2721681-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107202033.2721681-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107202033.2721681-6-yuzhao@google.com>
Subject: [PATCH v2 5/6] arm64: pause remote CPUs to update vmemmap
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nanyong Sun <sunnanyong@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Pause remote CPUs so that the local CPU can follow the proper BBM
sequence to safely update the vmemmap mapping `struct page` areas.

While updating the vmemmap, it is guaranteed that neither the local
CPU nor the remote ones will access the `struct page` area being
updated, and therefore they should not trigger kernel PFs.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/include/asm/pgalloc.h | 69 ++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 8ff5f2a2579e..f50f79f57c1e 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/cpu.h>
 
 #define __HAVE_ARCH_PGD_FREE
 #define __HAVE_ARCH_PUD_FREE
@@ -137,4 +138,72 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 	__pmd_populate(pmdp, page_to_phys(ptep), PMD_TYPE_TABLE | PMD_TABLE_PXN);
 }
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+
+#define VMEMMAP_ARCH_TLB_FLUSH_FLAGS (VMEMMAP_SPLIT_NO_TLB_FLUSH | VMEMMAP_REMAP_NO_TLB_FLUSH)
+
+#define vmemmap_update_supported vmemmap_update_supported
+static inline bool vmemmap_update_supported(void)
+{
+	return system_uses_irq_prio_masking();
+}
+
+#define vmemmap_update_lock vmemmap_update_lock
+static inline void vmemmap_update_lock(void)
+{
+	cpus_read_lock();
+}
+
+#define vmemmap_update_unlock vmemmap_update_unlock
+static inline void vmemmap_update_unlock(void)
+{
+	cpus_read_unlock();
+}
+
+#define vmemmap_update_pte_range_start vmemmap_update_pte_range_start
+static inline void vmemmap_update_pte_range_start(pte_t *pte,
+						  unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+
+	local_irq_disable();
+	pause_remote_cpus();
+
+	for (addr = start; addr != end; addr += PAGE_SIZE, pte++)
+		pte_clear(&init_mm, addr, pte);
+
+	flush_tlb_kernel_range(start, end);
+}
+
+#define vmemmap_update_pte_range_end vmemmap_update_pte_range_end
+static inline void vmemmap_update_pte_range_end(void)
+{
+	resume_remote_cpus();
+	local_irq_enable();
+}
+
+#define vmemmap_update_pmd_range_start vmemmap_update_pmd_range_start
+static inline void vmemmap_update_pmd_range_start(pmd_t *pmd,
+						  unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+
+	local_irq_disable();
+	pause_remote_cpus();
+
+	for (addr = start; addr != end; addr += PMD_SIZE, pmd++)
+		pmd_clear(pmd);
+
+	flush_tlb_kernel_range(start, end);
+}
+
+#define vmemmap_update_pmd_range_end vmemmap_update_pmd_range_end
+static inline void vmemmap_update_pmd_range_end(void)
+{
+	resume_remote_cpus();
+	local_irq_enable();
+}
+
+#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
+
 #endif
-- 
2.47.0.277.g8800431eea-goog


