Return-Path: <linux-kernel+bounces-302184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F6A95FAE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC11C22776
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4781A0B15;
	Mon, 26 Aug 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzpqRune"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399E1A08CC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705077; cv=none; b=NK9mAUZvfSK2ss+igNdUs/tKtVDv1KjdSt6dSzS6AVm/sgalDPHwmTqWacfviz7aC9K0cMT6ejK3jBw8GmqBCSUw6H65dOVYX2B+K8++TkYWc0ptvV+5Ljkb/nfTpVJ3QdmZETOCVyvT4aRhUSjbpTp5DJIFaK5oB5DnUR4me58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705077; c=relaxed/simple;
	bh=5/RkLDpH7n+0lRZdC6d7Fr9a2r7GbmT3sDiSd48lk+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ospTrmDuypd99uHxSfa85KHHIcQq5xVV3MuaYImP95lhv12txVt3ulJ5cDTvXF8KHn3dP5IwEWTOzkDt0gDY9tIckVgfivYOqCXy5C6ItI15XUUFCfZTMCX+XE2V8wN6h6cNaOh+d8hoWfNMm20WnuQ0Whi0VZNX3LFTW1JDp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzpqRune; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEAM9DK74WZYySVYhL7YnC2YOY0xQ42haB8uzH2x2BY=;
	b=GzpqRune84QmLOWjJZXXnUAv2Lg2O4s+kwWDFqH1+eql3Zz4ndDdB9E4xDOTPDPX01kCsl
	nv8Nz7XUZj5jRIIiTqE4wUFQy8Wkxt5os9pdhW+C6xxXIhZiEGsPgRgKa/p8s9QP4vyyJg
	fdvsFZtNjO8sWqxga7h8Zk8go92l8Ts=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-8wwUoSz6PIiD_cv2n3NBXw-1; Mon, 26 Aug 2024 16:44:33 -0400
X-MC-Unique: 8wwUoSz6PIiD_cv2n3NBXw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4518f9f8a9cso62257721cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705072; x=1725309872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEAM9DK74WZYySVYhL7YnC2YOY0xQ42haB8uzH2x2BY=;
        b=f8q0ZuMVhqSqYSF9ayTNG+wVwt1AKUXtpZuOBpfER/7nb8GQ3gzbWtIqz30f78r1pW
         gYjDNqfqe9zkdOKpNXnZWL2k++p98oSe8ErpJqhNwxFyDZaPl/8xcIJgZ/Yo78XDLknj
         qGhiDOi/FxgIojOLzJGs3gIgqqyvz6ylmJj5ZpIyXUzDaILK8Mtpe796+cFQpVHmYxWx
         k3Op2NSh7KhR1PmyMrnLal5rWXyfuqhca3qj7IGhh+RDvauKpP0H98MFT3vu1xyircF/
         ezZSd/QWcD6YFc8a2s4b/t/iJrSg5AGCalgKADcdQgve8uNOm9yN+GyPkZHo+HICczhq
         AmwA==
X-Gm-Message-State: AOJu0YyoozWohujrCG3egIyxp48oPnx821Oy634JiEhJLmL14oXR6F+B
	nwrRxihqXF/I90emxs2+z6WkbA2CuUnwudbB0/+/Ee7u3p3i9hzXpMtBiVbDg9eFM0UhmsW4O+3
	4vkmyr1rvvlqnS77i11s3LO3k5Mu9H/Qkbg7TEGk7bhHE4B7pe1AtXzc5Isn7MN+jdOQoSMFbm7
	uBP63SVppW1tggrDRbOsMtipKsjMJgbme4zCATwV9KEb0=
X-Received: by 2002:a05:620a:430a:b0:7a4:faab:fc79 with SMTP id af79cd13be357-7a6896d1835mr1392502085a.8.1724705072645;
        Mon, 26 Aug 2024 13:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDiJ56urcvTKu8a4/ieO25ZyreTkMfmYYALFQqTS8OY3wwzzWFQolk9khXQC+xv0hRJc4KwA==
X-Received: by 2002:a05:620a:430a:b0:7a4:faab:fc79 with SMTP id af79cd13be357-7a6896d1835mr1392497485a.8.1724705072141;
        Mon, 26 Aug 2024 13:44:32 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:31 -0700 (PDT)
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
Subject: [PATCH v2 18/19] mm/arm64: Support large pfn mappings
Date: Mon, 26 Aug 2024 16:43:52 -0400
Message-ID: <20240826204353.2228736-19-peterx@redhat.com>
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
index 6494848019a0..6607ed8fdbb4 100644
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


