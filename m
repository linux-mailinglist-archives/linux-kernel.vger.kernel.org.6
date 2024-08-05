Return-Path: <linux-kernel+bounces-274688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62F2947B75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85741C21296
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013D515F3E1;
	Mon,  5 Aug 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I38LAKVI"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE515F323
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862577; cv=none; b=BBDOIWFVbcDFgYVbxahAjpwRf079pnJkvwYaEOp+47PwIiuvSpclk7wI3Np12a4eLkn7AfzvF725A9Q6Qp8UhEN17guL62UDZw8tlvCT8XDF3cc/VaS8CmonmPxljqw3Vki74fshp6NGNJ3clO+O6DWjQcMVHYRxs4L+m+1oex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862577; c=relaxed/simple;
	bh=avB8w0YfcXkyDQgGb/pTXo2SZkD2aFY9wudx96Zg4TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3ZUbLxBI+srJgW9Sh9safOwFyHYEZ6yoQJN7TIT6u1PED8+R/MGNGB8SaukUoTYmDCroWRFAVojXjZdwhXpCtufW6JeJ8Qm9sAY/tvEDFrOWOl5H8fS/OPuHGIQxDHQcaYTZN/CXl/3oKGl3PQnrA+zLtDF5CQNJd4+GTDYug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I38LAKVI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d2357df99so269748b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722862575; x=1723467375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XC0Rcbjdh8ylucXC7ADaLu0MmCwUQ8ESfO/B+g+YjaQ=;
        b=I38LAKVIsvYu3UJQHECma+wBvHT3NDksVnruyBmeL9bVleLEN2l14I4qSqzwioa+QJ
         64gLHjrRYBBR9MFzL5FYwDH8skxshQ7AA7/o7cVSd0tb1hbhXL7lIWjwh+brClR4DTwT
         FENgTl96ZAH1N2NugY2j9F9k6vUOhJ7ccH2vkanaNndxOp9jalQja+HJk/DNqH1ZKuja
         qKW5y5AkFgSKBLqHWFGQXMWuo9+8fsLI3Oj5DAvrviyJ2z57vEsmJ+AnVScv6pPxysx4
         IB+0lGM0wb6vNjgvsH8o/kpswzPrzxxG5m5J1ve7Z2ck5+h+mlcwixGa7apjYSph0+F2
         Q63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862575; x=1723467375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XC0Rcbjdh8ylucXC7ADaLu0MmCwUQ8ESfO/B+g+YjaQ=;
        b=qIMUz5MvKFXIlJQ8KPtSwH7ambi8cHeCXfqs8KIwd78zFfofkoYgH1WV3P6tssnENJ
         acJP4rEFH8u3mrP2h4pR8d9DGeDg5njplKLbFkwecXkFygL+Xzwn/koiSRtqhvSzJSt2
         vygnwhJ8pDRoFFXPW6outES1DE901PJ4pxdUoNP6YJavySChiBHUfqmU/45fkjUra68V
         iOTzZ/l1mUcld5/f02sW/MBCMNv/Vaf2+XUHPF9ylIRp3NNWAXfVasdH4W6uEpyM0CFX
         l/Fbz4xdrO0hRtveGISnR9/FLMyEJKiFq2FCiX6a+zS3m5OMIlnGmM2dU+dDnsG1URoi
         f3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXk/3oTNhp2Kw8Q0ZUgwHRkj9X/oOeSw44NMKQI/PORs+w1eDbIMzPSbGFYXl6hzBfVgx1hoarBhHyACO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAMyNaOaYXx1agxndgZe4ERQF4eDgpyOEaI61RmDGBVndkvuW
	5cgfKZuN01pBnEd8D+d8qsC4wrLL8NHiOQzZup3kwC5uoCZBhboUDUQTW3Ib0HQ=
X-Google-Smtp-Source: AGHT+IF/l8kL7sdJ/NhN/cq8F6a1ZTnpgYnj4ROM1RQNcS/ED4bxJRGoEHg/fBeOyRXw7ShGlIlTUA==
X-Received: by 2002:a05:6a00:3a20:b0:706:aadc:b0a7 with SMTP id d2e1a72fcca58-7106cf94aa4mr8039553b3a.1.1722862575131;
        Mon, 05 Aug 2024 05:56:15 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf1asm5503030b3a.142.2024.08.05.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:56:14 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH v2 6/7] x86: mm: define arch_flush_tlb_before_set_huge_page
Date: Mon,  5 Aug 2024 20:55:10 +0800
Message-Id: <1c8bee0c868c1e67ea02a6fa49225b00503b5436.1722861064.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1722861064.git.zhengqi.arch@bytedance.com>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we use mmu_gather to batch flush tlb and free PTE pages, the TLB is
not flushed before pmd lock is unlocked. This may result in the following
two situations:

1) Userland can trigger page fault and fill a huge page, which will cause
   the existence of small size TLB and huge TLB for the same address.

2) Userland can also trigger page fault and fill a PTE page, which will
   cause the existence of two small size TLBs, but the PTE page they map
   are different.

According to Intel's TLB Application note (317080), some CPUs of x86 do
not allow the 1) case, so define arch_flush_tlb_before_set_huge_page to
detect and fix this issue.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/include/asm/pgtable.h |  6 ++++++
 arch/x86/mm/pgtable.c          | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e39311a89bf47..f93d964ab6a3e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1668,6 +1668,12 @@ void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte);
 #define arch_check_zapped_pmd arch_check_zapped_pmd
 void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd);
 
+#ifdef CONFIG_PT_RECLAIM
+#define arch_flush_tlb_before_set_huge_page arch_flush_tlb_before_set_huge_page
+void arch_flush_tlb_before_set_huge_page(struct mm_struct *mm,
+					 unsigned long addr);
+#endif
+
 #ifdef CONFIG_XEN_PV
 #define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
 static inline bool arch_has_hw_nonleaf_pmd_young(void)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ea8522289c93d..7e14cae819edd 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -934,3 +934,16 @@ void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd)
 	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
 			pmd_shstk(pmd));
 }
+
+#ifdef CONFIG_PT_RECLAIM
+void arch_flush_tlb_before_set_huge_page(struct mm_struct *mm,
+					 unsigned long addr)
+{
+	if (atomic_read(&mm->tlb_flush_pending)) {
+		unsigned long start = ALIGN_DOWN(addr, PMD_SIZE);
+		unsigned long end = start + PMD_SIZE;
+
+		flush_tlb_mm_range(mm, start, end, PAGE_SHIFT, false);
+	}
+}
+#endif /* CONFIG_PT_RECLAIM */
-- 
2.20.1


