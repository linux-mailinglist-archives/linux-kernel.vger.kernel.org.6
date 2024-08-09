Return-Path: <linux-kernel+bounces-281210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AA994D45B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6981C21022
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E79119F467;
	Fri,  9 Aug 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ8p2/gE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1119EEAF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219800; cv=none; b=Hg2U6WC9GZ9nQvwQ0ie0g02bOSJCv/jxufFYJxUUvlWb8n6edv4wgdsAKmQlArQw2RRRbpPhK6HOp/Owg5KVnaU6UcQebTpbKCA+nVmNcxlUB4V7+XheXrAgaIqM0PwtG0YByAoIk7u8Naq1PIKVyoiZcRs7cWP74a+RmfrmaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219800; c=relaxed/simple;
	bh=Pk1TeOIKWSjAqBlIFkGydJm2rF11Zc/q9MVN9zTRZbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TugzOcaRiTCPFkoR+bEF49i4mDMvEIUW4JFw9+mFJIgXdPDRgfPtocjKfu7KVAp/CK5mpRRdU0iE4l2n5fDMpVO6VzyBt2/QNGMiey1YXW6pdheBReoIOjn+9fmCprSmX8T5ICejcDxuqv0EvwjQiTFTF2z3Ury9fAIBtxTu0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJ8p2/gE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UM853E440qfXKYz7avWh673RydKsfl7XbVKvi0Id2+c=;
	b=WJ8p2/gEQN/T/ur0VD/i/un34LD3UOdChxL95tbYabSaIfMA4ZLVb5zDdDho++90puyHxP
	y24KRtrqVpX4a2jr/WFChpfB/t2TG2N7sjbkk2eUK6YD0sApY7wII1VUWejPh4IiuSxYUd
	gjzUNyfAdONXKj+MNEyzO23pIy2IW4g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-wPcuUvHYNkOt9wBDH5rJgQ-1; Fri, 09 Aug 2024 12:09:55 -0400
X-MC-Unique: wPcuUvHYNkOt9wBDH5rJgQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4503ee1b5d6so5447711cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219795; x=1723824595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM853E440qfXKYz7avWh673RydKsfl7XbVKvi0Id2+c=;
        b=KP+U9Qygar2ncjPGbCXQjy0VS0JBk2R/3c/E1D0G/WRZofPQ8e/sTwmPwTutLj6gGL
         EugAt7DWfL3ZIGKh2xdrKpIVKjcuT9Y2RxSRFVqU+xNuC6gT/mipVQfl/qlzNBvq8Et5
         GO0d2xEy9vnw0OxObNLn+yr5GhRaz+fujXWMlfGItkE/ej8NoX4rGdjh//EweNCJ4BoO
         HPO9j88Vs3SCnFdBjCurlLvFk72tBwOkMYdvT1HCmdkAEmFxtkggEBqcaCCVW6LCO7If
         thGbyIMjjmUxhErwkYPxJiJ0shGoJ9B5ek0X7n9gsd9xI+C5h8LXMDP4kl7j/AhhgJML
         OAZw==
X-Forwarded-Encrypted: i=1; AJvYcCVzUudx7KKVb5DkZQPVQAg7n00MCx/8VtveOLqwcNIfKAbsSpV11/LY9qpgFt1VGLfPEtB9sCY7132EfqN16MKZSZ0ZpzO6hxgl45Ci
X-Gm-Message-State: AOJu0Yz+ghktAzV+NHkU6VJ/dk7c4zZ/lhpzqDHj8GlyRBqbusHu/bRy
	dSW2MCjlZ/nv+MK6mJUL+1EG+fm3Kdt1sBfwU79bDM0He6S55e5IPqMYAXL1zX08tfuhLDosg3t
	c3D+VLoTFj1w6KzNcjpLJROOP+Cpf4pwhngCurCw9bynTMCik8Wynuk0HKGYr+w==
X-Received: by 2002:ac8:5e07:0:b0:44e:cff7:3741 with SMTP id d75a77b69052e-45312646da2mr14006671cf.7.1723219795211;
        Fri, 09 Aug 2024 09:09:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzDYjFq+v9SYAdrw2G1PaR/i1nnMK5UGwVdyzJwk9mK3TcvaabWRsZT43a6L+rPfA/Jc6OAg==
X-Received: by 2002:ac8:5e07:0:b0:44e:cff7:3741 with SMTP id d75a77b69052e-45312646da2mr14006381cf.7.1723219794745;
        Fri, 09 Aug 2024 09:09:54 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:54 -0700 (PDT)
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
Subject: [PATCH 18/19] mm/arm64: Support large pfn mappings
Date: Fri,  9 Aug 2024 12:09:08 -0400
Message-ID: <20240809160909.1023470-19-peterx@redhat.com>
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

Support huge pfnmaps by using bit 56 (PTE_SPECIAL) for "special" on
pmds/puds.  Provide the pmd/pud helpers to set/get special bit.

There's one more thing missing for arm64 which is the pxx_pgprot() for
pmd/pud.  Add them too, which is mostly the same as the pte version by
dropping the pfn field.  These helpers are essential to be used in the new
follow_pfnmap*() API to report valid pgprot_t results.

Note that arm64 doesn't yet support huge PUD yet, but it's still
straightforward to provide the pud helpers that we need altogether.  Only
PMD helpers will make an immediate benefit until arm64 will support huge
PUDs first in general (e.g. in THPs).

Cc: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3fc891f1544..5f026b95f309 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -99,6 +99,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b78cc4a6758b..2faecc033a19 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -578,6 +578,14 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
 }
 
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+#define pmd_special(pte)	(!!((pmd_val(pte) & PTE_SPECIAL)))
+static inline pmd_t pmd_mkspecial(pmd_t pmd)
+{
+	return set_pmd_bit(pmd, __pgprot(PTE_SPECIAL));
+}
+#endif
+
 #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
 #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
 #define pmd_pfn(pmd)		((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT)
@@ -595,6 +603,27 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
 #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
+#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
+#define pud_special(pte)	pte_special(pud_pte(pud))
+#define pud_mkspecial(pte)	pte_pud(pte_mkspecial(pud_pte(pud)))
+#endif
+
+#define pmd_pgprot pmd_pgprot
+static inline pgprot_t pmd_pgprot(pmd_t pmd)
+{
+	unsigned long pfn = pmd_pfn(pmd);
+
+	return __pgprot(pmd_val(pfn_pmd(pfn, __pgprot(0))) ^ pmd_val(pmd));
+}
+
+#define pud_pgprot pud_pgprot
+static inline pgprot_t pud_pgprot(pud_t pud)
+{
+	unsigned long pfn = pud_pfn(pud);
+
+	return __pgprot(pud_val(pfn_pud(pfn, __pgprot(0))) ^ pud_val(pud));
+}
+
 static inline void __set_pte_at(struct mm_struct *mm,
 				unsigned long __always_unused addr,
 				pte_t *ptep, pte_t pte, unsigned int nr)
-- 
2.45.0


