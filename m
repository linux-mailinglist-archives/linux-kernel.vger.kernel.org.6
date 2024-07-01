Return-Path: <linux-kernel+bounces-235858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3E91DA7B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3701C21984
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E57F14B942;
	Mon,  1 Jul 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hb5Y3QwG"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA814B077
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823713; cv=none; b=CMOlSMNTdvFy177d8/WtmtDEmSH0k+i6GjOM0ixufEWe8SbGwY/KQdV13SML83YcOMJvXW3rJVBv82popGyv8mBbg2CMithmm5WOZMakdXKARCMB2KhIe/T5/BYXiMeP2aD5/55ePbFbNLLWc0AyxZ4Y8FY8IaMW9NTK2DCRgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823713; c=relaxed/simple;
	bh=I9ZLJI6Hui3oX+ajVbw9U0h4kGM7XOSsdMnotECzQ1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1VakSR8meXeqBsyg+NTP6vrmp8x1US+ObSdzeG7EpeyD7GuN0bgQGd4BytAuKXnchLWwzIHLEZln9/YtazHi9gm6Lji53GzxvTip22TR0CikzUsX9BGbqMStlhsy0ZkQVMdOqIItxLpO3bQG0Gj60NFUhVJsw7kR3xmO3IISSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hb5Y3QwG; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25cce249004so441845fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719823710; x=1720428510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSdXPp6cua9HpA6rLebdl04hcrKD7F+dglilKwP4NdI=;
        b=hb5Y3QwGjZ9AmmfZA/oi0sGtobsrTBo46HyxZqJDFnmW1qTi8ZgOfuJ5T+2iyDygkk
         LIPf5HYdJY48fGrlmpTV5aycpnBC6TGeTqwx+uMESEhvCNi/r82Um/6DuNKteGbX74co
         fwmMfZjLR2Q9YEZz266Qp4RwHzlJrzU38/QomOKMoNj+CWy7FfVizBN/Z7EICQmmBgLw
         lxVIhmXBVSpIzYwT3VJHELARKlbReMsgeD+0zjwHQq8NZxhPQTFhFDvb8J7DcDAsXYlm
         /aZan/dSx9EK1j+1RjGe50b0Eol7FOa+mAlvMg0aH3mmK2KCpbGaXBWeVxD/Hl3J+U3q
         CJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823710; x=1720428510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSdXPp6cua9HpA6rLebdl04hcrKD7F+dglilKwP4NdI=;
        b=C7KHWhYQDfcNtWVqooq2DC6CFjVUWuJ3TNuYjRr2O7bNxoCcS4jSGp0aI0GokTOSpN
         p45wdbPnWJKRev5XLeeBzkmmEA6tw9HL6Ah0HVAvuRuWk7MemrFrf4IlqRwsVtjdC2Me
         1GkhhtybQmo+s6n73eCWy3xY8IsDiBVH/1yOmdJtUqqQX4O3p0RNqf+yv0GcNN0chz2X
         MaInBhwlOvm+3ixyLBLq+zCrd6bY5X36pRySI4M4o9K0jtucCa6qJdEAt3hhRuW6JMjk
         AN6K6m9lyizMr4ADz9TSa8F7Vqj2RNzodV4ZW5mYnAH6QZ0LowgWek6O3G531KfZoYwj
         AxOA==
X-Forwarded-Encrypted: i=1; AJvYcCXczFKvHaLPbBqVMOJrzqJW7QIRdh/8IzzPucZUJzZNp0yNkmV1WwLHjirzuizWjZmnILHdaLi0IQck+V41dB3AXFRSxa1orI+aKtzu
X-Gm-Message-State: AOJu0YxW5PyJ+KfKGWVbGkEWL5NeLDl/mGTqfjuS2r4iwCh4+qfhDani
	e6TdqLSJDunhxn3DBY7YLIfORTDrWf3dXOXP4N7c23osyjwmtd/KMTPTm+a5CzY=
X-Google-Smtp-Source: AGHT+IFfafy76qxnP3FNZsq5qulnNjrKrfxWqb4/wPoL/DGlK5/mwzGRfDiOgExztR4uBC55G6FnbA==
X-Received: by 2002:a05:6871:7806:b0:254:ecbd:1815 with SMTP id 586e51a60fabf-25db3709c91mr5161423fac.5.1719823710530;
        Mon, 01 Jul 2024 01:48:30 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a7e7e0sm5932374b3a.204.2024.07.01.01.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:48:30 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 6/7] x86: mm: define arch_flush_tlb_before_set_huge_page
Date: Mon,  1 Jul 2024 16:46:47 +0800
Message-Id: <a6cea157a2d9ba4d35f53d4d44b4d6e9ccd26aa5.1719570849.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1719570849.git.zhengqi.arch@bytedance.com>
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
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
index e39311a89bf4..f93d964ab6a3 100644
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
index cd5bf2157611..d037f7425f82 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -926,3 +926,16 @@ void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd)
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


