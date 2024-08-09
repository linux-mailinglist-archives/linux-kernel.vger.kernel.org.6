Return-Path: <linux-kernel+bounces-281209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965694D459
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB551C20C32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F819EEA2;
	Fri,  9 Aug 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hprFUyNs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49419E7F5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219797; cv=none; b=ho4IWOIU+XG4EFbRgAPPUYNGu/v8B8FXV5iO/EpRxGHUsvqu8NDbtKNJE3loaVnIzodqSLIMZ8nLw7Ow7fdPk4YZvMMaqWmibFlhZP+PX+1Wz5jdnnZROpdz5p+9gBBwvt45xwixjJyKD0WDLiJkmC7wl6pfKHdrpIPPqksWm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219797; c=relaxed/simple;
	bh=6vd9dKzSoYHnE87pbZ79rfnDAvgUPCtQqMHJIVAxycI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEHSFeL/OW3vTcZgYhA0p2Y/eEgdtbWmWw6pjOMahrHRvBgGXX5Pw/P4trlHQ77MK18yIUxWwnju35oYV+Fy2lDenXleXjUo7uMVCNfmz5Ig4ob3mmwLD4bk0DPfOSTjRHI0+yrQzEjPlewAnkwOeMro7Qb39Mg4tmoT03fSGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hprFUyNs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoGoBxg1RIhRUWN8551lXVuosUhfDUfYXVK/Rz8tB4Q=;
	b=hprFUyNsXu62UOaW2ILvBg7uWsxhM3gv11ZLAxlf4KKM9ghkPhiXGh9IucHRr/f0/doycp
	htU9oEmYo291aq5zOGkqyMsy22a8ACoBjkEGHDIOaxpZKTkqERnJvvR6cbAdMGkM+lyi/E
	vpEium1+71XvyZkIMr9s2V93k1wyaNw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-dDToYNiWM_ye7Ts1Bz5-AQ-1; Fri, 09 Aug 2024 12:09:53 -0400
X-MC-Unique: dDToYNiWM_ye7Ts1Bz5-AQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44fea369811so4530921cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219793; x=1723824593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoGoBxg1RIhRUWN8551lXVuosUhfDUfYXVK/Rz8tB4Q=;
        b=PGUSk8+bT2yhXqWOqir01HgCRwGfE/+ENMUpreQuJ2lb0WaqLVa6r16tK1WsJ3vsA3
         s1gI6CTmqtvVRbC2ty9VjA3llGYo2GhNtwSB/Or2nYCwzNAKJcg9BHt8Xd8f6cR/h1lW
         BfAwQkY+4wH1+c0UhPQut3k4FNiLcJxXcY8fWhYEN5HZx+peoSpsbnUqDJgY7+lCu44o
         KonQLag1hqApTnZjTVOzkgX614ACpPnMm4vIJy+847VIPMoYN7n1gk4tEddDyG5mzDXo
         yi7z822dQta2gK+cmIqe8gGBSJA+BK3PPGn9+1rvgFNG/eSBlD1WZM3UtZ3nddF4W6cf
         ZiRA==
X-Forwarded-Encrypted: i=1; AJvYcCWw6i6ApceZ17dvflXwxGQ6sWmFnm/O2ad6vNyPporBDau4HGKUCmqmbLWhzwwj2Njf0UmXVKElSIw+yCawApbPy0r9JX8MLsyXtF7C
X-Gm-Message-State: AOJu0YwZKxOCC1GOFHXXbVLXa4YsOHDb/rlMmkb7VY3aBI7mrxA8EaXn
	l0N6DdzUSeqddwFQ3p59dYrk9F2EERzqL/KZq74FhhdP0fFGk3GCn45pqonT592vIC8/eCDFmVV
	G8HOaEZVrFAiiG6zT/z7jRvRawxenFTEbl6Pb/CLBxhIzxCoWig54f2HdLzEeGA==
X-Received: by 2002:ac8:5e07:0:b0:44e:cff7:3741 with SMTP id d75a77b69052e-45312646da2mr14005701cf.7.1723219793235;
        Fri, 09 Aug 2024 09:09:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyC9JbjVCeQC7LVvckqh3sKVh2QUlZ0IzLJIVdarr6jR5vj53aOO53iHwQIsrAsjgq+0MAjA==
X-Received: by 2002:ac8:5e07:0:b0:44e:cff7:3741 with SMTP id d75a77b69052e-45312646da2mr14005321cf.7.1723219792685;
        Fri, 09 Aug 2024 09:09:52 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	peterx@redhat.com,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 17/19] mm/x86: Support large pfn mappings
Date: Fri,  9 Aug 2024 12:09:07 -0400
Message-ID: <20240809160909.1023470-18-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240809160909.1023470-1-peterx@redhat.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helpers to install and detect special pmd/pud entries.  In short, bit 9 on
x86 is not used for pmd/pud, so we can directly define them the same as the
pte level.  One note is that it's also used in _PAGE_BIT_CPA_TEST but that
is only used in the debug test, and shouldn't conflict in this case.

One note is that pxx_set|clear_flags() for pmd/pud will need to be moved
upper so that they can be referenced by the new special bit helpers.
There's no change in the code that was moved.

Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/pgtable.h | 80 ++++++++++++++++++++++------------
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index acd9745bf2ae..7a3fb2ff3e72 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -28,6 +28,7 @@ config X86_64
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a7c1e9cfea41..1e463c9a650f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -120,6 +120,34 @@ extern pmdval_t early_pmd_flags;
 #define arch_end_context_switch(prev)	do {} while(0)
 #endif	/* CONFIG_PARAVIRT_XXL */
 
+static inline pmd_t pmd_set_flags(pmd_t pmd, pmdval_t set)
+{
+	pmdval_t v = native_pmd_val(pmd);
+
+	return native_make_pmd(v | set);
+}
+
+static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
+{
+	pmdval_t v = native_pmd_val(pmd);
+
+	return native_make_pmd(v & ~clear);
+}
+
+static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
+{
+	pudval_t v = native_pud_val(pud);
+
+	return native_make_pud(v | set);
+}
+
+static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
+{
+	pudval_t v = native_pud_val(pud);
+
+	return native_make_pud(v & ~clear);
+}
+
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
@@ -317,6 +345,30 @@ static inline int pud_devmap(pud_t pud)
 }
 #endif
 
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+static inline bool pmd_special(pmd_t pmd)
+{
+	return pmd_flags(pmd) & _PAGE_SPECIAL;
+}
+
+static inline pmd_t pmd_mkspecial(pmd_t pmd)
+{
+	return pmd_set_flags(pmd, _PAGE_SPECIAL);
+}
+#endif	/* CONFIG_ARCH_SUPPORTS_PMD_PFNMAP */
+
+#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
+static inline bool pud_special(pud_t pud)
+{
+	return pud_flags(pud) & _PAGE_SPECIAL;
+}
+
+static inline pud_t pud_mkspecial(pud_t pud)
+{
+	return pud_set_flags(pud, _PAGE_SPECIAL);
+}
+#endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
+
 static inline int pgd_devmap(pgd_t pgd)
 {
 	return 0;
@@ -487,20 +539,6 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return pte_set_flags(pte, _PAGE_SPECIAL|_PAGE_DEVMAP);
 }
 
-static inline pmd_t pmd_set_flags(pmd_t pmd, pmdval_t set)
-{
-	pmdval_t v = native_pmd_val(pmd);
-
-	return native_make_pmd(v | set);
-}
-
-static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
-{
-	pmdval_t v = native_pmd_val(pmd);
-
-	return native_make_pmd(v & ~clear);
-}
-
 /* See comments above mksaveddirty_shift() */
 static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
 {
@@ -595,20 +633,6 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 #define pmd_mkwrite pmd_mkwrite
 
-static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
-{
-	pudval_t v = native_pud_val(pud);
-
-	return native_make_pud(v | set);
-}
-
-static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
-{
-	pudval_t v = native_pud_val(pud);
-
-	return native_make_pud(v & ~clear);
-}
-
 /* See comments above mksaveddirty_shift() */
 static inline pud_t pud_mksaveddirty(pud_t pud)
 {
-- 
2.45.0


