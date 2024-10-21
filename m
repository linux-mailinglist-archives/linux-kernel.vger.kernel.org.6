Return-Path: <linux-kernel+bounces-373623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D119A597B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F184428271E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BE1D12E0;
	Mon, 21 Oct 2024 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAk5zSQk"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37841D0E35
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484557; cv=none; b=nVjKlsklHe8lpqUC1g+3bjPceZrCR0jxnW5yik+efknJWfIvcoNiGkahmu4Je725qTE7cmg6+wVp3VaHCzn3z/0bb5Z+6BhkkBwU99e1ciL48z5TokWbM1TD8Q6sa+t/bUg9nAGctxYCFQkXXGZWv9HHX+wB6ng7Nh9/sLSK7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484557; c=relaxed/simple;
	bh=KS3IBh6pNTFwZWi8Y6TKh/aDmrKSQhwTGt8tYaFvGTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ht/g0AHNXPzMaoR4a1oOz9NQG2CsCQgXV+tU4A++SNZC5ZNhqRFLaylYReB29N21EtNlV7lJZD0ojxegNEwkX40owgpMg39rTD2JwVmtuFxRbeTh5oOf/tD0eyR67C18fgHwaxid9zw3aQL6JZZtu9mDqG74sXstitFOthNvEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAk5zSQk; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293150c2c6so8378661276.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729484555; x=1730089355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=toVG9Bv1ZFXM9w/cWVF/q6arTJn/fxOOJss0eISMw6g=;
        b=CAk5zSQkh6HH7+mSljMyoxOK1v80+vZzykJQSHEjWQblGpeaSVZQeiNJ8YarezCJ/Y
         c7pSvGv9YQbQifnoy9aJp1aBtz777Fq3YqgpXaWcWqiZJl8y1D7blxVb2K/IGnPGSCG6
         OcHWTjIiMJfOmC/CVFgy1HDhaPLhDOeEuoJ00Rl6+35abcMdB4qpM6UYRXlLGmOcmiKT
         ixISqkc3aOb5616KQp/k+yBniycthn/oMiGO02jfDT8LzCgO6gMtx3QfVem4ajP/uA8G
         mgOceWScvZGAwrpwfMKHYrgtLesI9OPKnpERgY1s+9fcR6om3qKpQyeil0QOlt2wg7rV
         uhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729484555; x=1730089355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toVG9Bv1ZFXM9w/cWVF/q6arTJn/fxOOJss0eISMw6g=;
        b=wTySrMKdvPdy2EVMFwhBsou2qrllnl2QEwFCsHCL5aVXY3OZBXx6ThC7z60Vy0wNnb
         UdEHDMEM5q0fBBB6L2yRoHIaxP495U3bx/AvM/650ip01OA5W+QjMD//4snrz3dzrWzK
         VIHHguE4gk9XMkYTtLD7Cz7BqmvwznZUjfGHOFqR7EDmuzkN5ZrSXiX5tHcFlY2P2EjX
         YbF+r0YOgaiU+7SH3xy9b4I+tMI1ZEwCSoa2Mhv0CH6/aI0lm0jW1dNQwx9LzsLTBLD8
         C41jvEqWlWdf64fTg/v2x8tgbwnkAl/4uv2MG8Bj8MHnguOytk0ILuzzK99mw3hhGc9V
         N5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXmJO+zV7VndJoHmzPZlBSGUWKn/7hxtXqmNDHCVEfeBz24ozxwmm62zsLMTwsZoKR5Cbmyi0Y6okciWfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfp4tMZrLxnT0jzLoaZBOU6rl0itkyrVa73qTNJkbMPs+HB+rz
	p7AhS074GUlpnD//0Dkq274vn4P0srdW4ERKeIQADfswKQVJDUKq7ICL5v6sz5+snlWN3VQUE4D
	u4w==
X-Google-Smtp-Source: AGHT+IFk9uamhIyVPiPVkC9AAkl4R2cZvpHrX9RuV4B2/rBtrreDBZ8gNEYfOVDCArI/WEZD+WVYAn+KZ5o=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:1569:9ef4:20ab:abf9])
 (user=yuzhao job=sendgmr) by 2002:a25:7453:0:b0:e28:eee0:aaa1 with SMTP id
 3f1490d57ef6-e2bb12db7e5mr5668276.4.1729484554722; Sun, 20 Oct 2024 21:22:34
 -0700 (PDT)
Date: Sun, 20 Oct 2024 22:22:17 -0600
In-Reply-To: <20241021042218.746659-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241021042218.746659-6-yuzhao@google.com>
Subject: [PATCH v1 5/6] arm64: pause remote CPUs to update vmemmap
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
updated, and therefore they should not trigger (non-spurious) kernel
PFs.

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
2.47.0.rc1.288.g06298d1525-goog


