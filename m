Return-Path: <linux-kernel+bounces-281193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971A94D434
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBF61C2155B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6AF1991D7;
	Fri,  9 Aug 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHSZAnXD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350E1870
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219761; cv=none; b=mnpWwLOdF4ztAoaKUrk+3amMdBCAz8KCeLBhIUS6vjReDIl28dBqU34W5P+w/ALML9Gf2rnWCgIXmyyAhod3aMCiVzQ3yUIuKmlBJ2tM4bC13faVjhSTaClnvIoNaRCzckQ8ey3cxZFP4owF3alMMSreesma/Ve0cte2NPAUO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219761; c=relaxed/simple;
	bh=6BzQDInfC57JnWWffubPvoRSjDM7Wzn3qARHvi6r3og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhqA/z7ssv5OiNMGGSzCVC6i5WzXE2nU5Ii47o4eXf6APX3it/CA5+hLYxqOoR2KIeLLtFels3eE3wJ9TEmjkPPFvrPHeDKOvXhX26vcliFWDdq+nsw/v4tVirHmqxbT8sZonUc2QZKT5qwtwo5Z8AVrlIRjLNQQnQ7940ceRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHSZAnXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKim6v00HbGyszP90Y55Ixe8BGOuNlK0Kt5OSqhmIXk=;
	b=IHSZAnXDEI1RUl3SEJ44WYgpa3FsRsc8rxYXz+UIFlk/+4CB/LjZl2vejxzr3e9Vx9dyxH
	z866pgNJjZTXdXiSE/0fVeQolByIN3/mKfkH1Xpd7B+h3KCVFvmJuw5qtupNiXwXeS55BF
	1XgYUhBic42a7qZWKpuUrxRl7dh7PGk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-YEq5pXW9Mt2imCZCbTfw3g-1; Fri, 09 Aug 2024 12:09:17 -0400
X-MC-Unique: YEq5pXW9Mt2imCZCbTfw3g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44ff65342daso843681cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219757; x=1723824557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKim6v00HbGyszP90Y55Ixe8BGOuNlK0Kt5OSqhmIXk=;
        b=N5WVUEkL3LTPBMynMoHUiFJ4OYZF5wyQU8wSW8OoutSwHO2aLd27/5D+kh9v7ZePUa
         6ocgWHhj9kqT2cb48Ws9RDWbqcKTQxfVKXsawAulWBk6CIlaYu6FAjh6g0jyAT0TbKUq
         ssBBvbTaMf98KsZSuIRZX4exWG9x0pmcFQKOJK/vi1cgrARPGfDddvI5FECaJ+GEeX5T
         ImS7EQbQJZtDiVBK/Sx8qGujs5IdcbRJWpsO4Ut2BNAxQ4lRWFDtaqMdmE42lhfFJmmp
         Oew6GDYSRi160lYm7aV/G1NkzVh/f27B/DLyKdx0ExEEtP+i0fbeeO4Wb6Fw0IVmxvPo
         yX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZW0J2G1N03ZqUctOyjnlXrioMm27jawl1bY2doJJISutcYHZ00H5K29OYDgZjodjqYIu+FW8550d3JL1el6sRSCaao/aejzI+h2WM
X-Gm-Message-State: AOJu0YzqEBghSnlPRmT7cJDJNq3gt3I+VUEkL3QTyE6N8jB9rORcmEhi
	kau/222PKoLyAxu3lOoUHGwoLS0rfKb6vw08jWl5e7JvRmZ/0EjDIwR9dXGMe62NeKTQ9cojeuI
	Bq/Pe4B1/6R12dSZ2WwMjW6X8WZbp4TOL08Pz51fm3G8KavDoSqRUt7pUarehlg==
X-Received: by 2002:ac8:58c4:0:b0:450:1e5e:3f3f with SMTP id d75a77b69052e-4531255bb38mr13611121cf.5.1723219756653;
        Fri, 09 Aug 2024 09:09:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAN0G3ozf6o5j8NgDrSR8g+6fB/Zkz8yhBLk8I4VWUl++aRhUduuiwR699bOA3QLxmHpo6kg==
X-Received: by 2002:ac8:58c4:0:b0:450:1e5e:3f3f with SMTP id d75a77b69052e-4531255bb38mr13610781cf.5.1723219756198;
        Fri, 09 Aug 2024 09:09:16 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:15 -0700 (PDT)
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
Subject: [PATCH 01/19] mm: Introduce ARCH_SUPPORTS_HUGE_PFNMAP and special bits to pmd/pud
Date: Fri,  9 Aug 2024 12:08:51 -0400
Message-ID: <20240809160909.1023470-2-peterx@redhat.com>
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

This patch introduces the option to introduce special pte bit into
pmd/puds.  Archs can start to define pmd_special / pud_special when
supported by selecting the new option.  Per-arch support will be added
later.

Before that, create fallbacks for these helpers so that they are always
available.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 24 ++++++++++++++++++++++++
 mm/Kconfig         | 13 +++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 43b40334e9b2..90ca84200800 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2644,6 +2644,30 @@ static inline pte_t pte_mkspecial(pte_t pte)
 }
 #endif
 
+#ifndef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+static inline bool pmd_special(pmd_t pmd)
+{
+	return false;
+}
+
+static inline pmd_t pmd_mkspecial(pmd_t pmd)
+{
+	return pmd;
+}
+#endif	/* CONFIG_ARCH_SUPPORTS_PMD_PFNMAP */
+
+#ifndef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
+static inline bool pud_special(pud_t pud)
+{
+	return false;
+}
+
+static inline pud_t pud_mkspecial(pud_t pud)
+{
+	return pud;
+}
+#endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
+
 #ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
 static inline int pte_devmap(pte_t pte)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index 3936fe4d26d9..3db0eebb53e2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -881,6 +881,19 @@ endif # TRANSPARENT_HUGEPAGE
 config PGTABLE_HAS_HUGE_LEAVES
 	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
 
+# TODO: Allow to be enabled without THP
+config ARCH_SUPPORTS_HUGE_PFNMAP
+	def_bool n
+	depends on TRANSPARENT_HUGEPAGE
+
+config ARCH_SUPPORTS_PMD_PFNMAP
+	def_bool y
+	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE
+
+config ARCH_SUPPORTS_PUD_PFNMAP
+	def_bool y
+	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+
 #
 # UP and nommu archs use km based percpu allocator
 #
-- 
2.45.0


