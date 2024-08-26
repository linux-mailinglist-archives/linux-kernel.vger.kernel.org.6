Return-Path: <linux-kernel+bounces-302183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F73E95FAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEE9288C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE11A08DF;
	Mon, 26 Aug 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xnryqcbg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52A1A08A8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705075; cv=none; b=W0hyyX/Lrvo78J1tafM5hk56GPeU1bWMbWK0m1Y/5SJmZ/LO0AiXKg/6Azy/MuB/fDVOl3P3xo29wljf/QCHTsMPTid2R2/sN5ICRIhF64C177fJ8pD5jP7Apon/Hxj0iI5kAzLs6rJZLTpYJVJVj9SjGHXJM0iJuvXjBwj6Wfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705075; c=relaxed/simple;
	bh=wO6hxJPqfj9KTLTi6qw+v+hbYJLMemjraAGsqutmV4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSGXv9IRhuLOlpZgErFkLTAS1h52geht77BIuCPITRsuteEvdHGNYqVYj+vKjOtnmLjs9EI+/GVdGMG0MWZgPQe3Kg7vLVZ8FEa8rkChVmvo4Pv1VMWQfJachNNKct+FDDCPzlCetB/PC/m69OUD710I9bhTmIyJSfUPDVncTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xnryqcbg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IC5gYR+7Z4BwAPnZp8TN8XZEGypCYGRNkok3NV40z5s=;
	b=XnryqcbgleFQu7wsb3ArLf6EE3uUSWK//GXhMsmI9jW89K3rTSNw8kygWmA0SGqz0athRd
	P0i+HBcJyIOLsfUVtZBF9Mdevx+gcNdBbkaevSQ3/zDJYfmURFjtntrnfHi53v0EQHdB73
	oIVlDZAi35dyCKAnpTAe3PGb1GScXck=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-xck-W9kjNUC6aprW_elcBQ-1; Mon, 26 Aug 2024 16:44:31 -0400
X-MC-Unique: xck-W9kjNUC6aprW_elcBQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5d5c7bfd8aaso6416856eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705070; x=1725309870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IC5gYR+7Z4BwAPnZp8TN8XZEGypCYGRNkok3NV40z5s=;
        b=hTVtUKBC8VHgiJNEYCH5MPuvYyRvKMdPGhCJy0MepyWpBNXYTsqWV56rU7vGqmGPg5
         Xm2pEP5blUW9fjDvAe0sbL922Wi/do3pniY8YgwxJbaBMi2t1ecHpaTZgVIX398BdBmp
         eL9NLFz30TA4EX4NuoAzJ+2468QBs0Vo7CO3WGF2ZVx5+Uc5Crs1svcWHqBmVHyNDO++
         gA/0QlLsqKaylujD7R0x3DaP5dPwulkUPbPVTHY9MlKt8BhKEXbZBhgHwew/y0NYOM+n
         OWLfzYY2G3vsMXD9VyR+LkBKryRfMqYJef4YD48I8itbkirqUc+kMDR8CjmB8RfL1ntq
         or8A==
X-Gm-Message-State: AOJu0YxwzqzsyGbJQ8yzOlKVv5SyZzSJN8UbOhKlOD/hvfxPmR5U/d+L
	Oc54shwdZ+jsoJc8j9Wc8ydDmSq0san2av2B5ij6qKd6IFrjx3C59OJB9cKLLaGR0mcqz/hlRuO
	swLAHLg4M2YLeDUIMXJ435WoWr90Qrn3T8eHMPfq9V3O0OBxZEBl37pplmwdT9i4EAip2Xw6lYY
	qVdXsKSoDLgRP3DqnxpR8cUhnMcsZMolO6H1F0/Gf1igk=
X-Received: by 2002:a05:6358:70c3:b0:1ac:f00d:c8c6 with SMTP id e5c5f4694b2df-1b5c22ebd07mr1493543455d.27.1724705070710;
        Mon, 26 Aug 2024 13:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWRaHJzCfl4jAxAoYVG6HBrfG1+v3SSmaZHfZSlba6wG4sR68STMcFscyvu7mDZcazVEGWKw==
X-Received: by 2002:a05:6358:70c3:b0:1ac:f00d:c8c6 with SMTP id e5c5f4694b2df-1b5c22ebd07mr1493538355d.27.1724705070146;
        Mon, 26 Aug 2024 13:44:30 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 17/19] mm/x86: Support large pfn mappings
Date: Mon, 26 Aug 2024 16:43:51 -0400
Message-ID: <20240826204353.2228736-18-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240826204353.2228736-1-peterx@redhat.com>
References: <20240826204353.2228736-1-peterx@redhat.com>
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
index b74b9ee484da..d4dbe9717e96 100644
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
index 8d12bfad6a1d..4c2d080d26b4 100644
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


