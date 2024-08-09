Return-Path: <linux-kernel+bounces-281199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE6794D440
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC667B217E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3819AD9E;
	Fri,  9 Aug 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIujg+TR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7D19A2B7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219777; cv=none; b=o62ZBQe0jTeXYDf8MIhrrwryFUpfbxSEKrlwPLz3UPpTqjMj+QFO7OHdvdN17IOKBx/OYAws5ZYog+o1brmHqPLbWMyEzdN02ijGJZJ6MlBaLulhXpjDwsL/qX/Nbu3fGujxM1GXoNYJWdbKxMQ8kvNLDGLQXAUQLvWslAFpBSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219777; c=relaxed/simple;
	bh=KGvOFcjjnMZbGILhL/il8UWmtwN07FBEuaEKlUcuKek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKJSIG6haHhLtah1wV/8qrh2FmhlcrEZ4UcYRDdp9xiWMuf5Kj2ZNYrFPeFxDXHEJkJ4t/gUTMP5yyd8QSgmwr+CTtOI2gG2MGjMkiN4v+6d1UTjpIHrJLpYODDRkTpem6qIk/7VgT2Fi2QkpCVWhW8oHhGnSELUN5xLqFU0v0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIujg+TR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aM3oVPeXmFPFf4Q68bjufzjsUq2ESmscQPnLEkaBB8=;
	b=CIujg+TRmFsPmbbcr2GhZLIcY4kvdjfY20IxHv10a5q6JHl5yM1hZNQvhj9euw5d8ul0mC
	LRJmlMQt+DtLff+nFF93gywWk46J8QiSAeRQU+i418+CQCTgjFCrXsMZkm6CRnmlOisdsn
	MeFrqrJ08J85fRExEbtyVCsm5udjvbk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-yjic9GHFNvKowuXk9w2ITw-1; Fri, 09 Aug 2024 12:09:33 -0400
X-MC-Unique: yjic9GHFNvKowuXk9w2ITw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44fea369811so4529931cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219773; x=1723824573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aM3oVPeXmFPFf4Q68bjufzjsUq2ESmscQPnLEkaBB8=;
        b=R8bng0RyE9Xwuy6wuqMNxjM3A8WjKE0EYs4utp8Kwruf3Pufa3PZ+0wnS4D1JHq+u1
         GYHhH7AEF69kqahfshunHZbE8ahaSJH+K4fxFSGCI6zbOME40HUD+/76Ey2ygpvmb4QS
         x3l84u7ZvmNWCpeuaxS3t315XXH4466omTH0WRfX46xXRpwgRGJ9fELWrITTIAsxMI5K
         mnTKyHDSMDiAOKM3I0sXrjDe4w1RyQN35E2Uq+yZZ0GVS6Ot6+lpSkQER6KW+S0tAE9S
         0z+Q2PIoHhSNm9S02QHDX3gPrKCBLsikjHbJx7QwWBT+zEPI49RBSvYZ0z3Wjb9Bw2eb
         1Jyw==
X-Forwarded-Encrypted: i=1; AJvYcCVysaKRpdMxYln8cr0iuVetuWVINkRQ95J1j/f6SVuQCn5Gof8tyDdt6viemnya/FePYTPCG6DrH+DK+Ly6z0RZoj2rWdLcGNdqCxeK
X-Gm-Message-State: AOJu0YxsniU/YFU6/73ijDae5cJyYe0cY7O88HkWp6KtVGZ3DiYfgj+L
	ydK2tSogoi8+jF1dNFQsSq38rTGXTy5zCW5s8UY0hDindah+zdIAsdaAW2Uesn2YtdlTiSl2kgY
	ndHM6zvDQ4jz9zw6NfTh0E4jTei/zfZjtLrYihJ2kyzhsPsIWigRCXSLmRo458g==
X-Received: by 2002:ac8:5f10:0:b0:450:349:1170 with SMTP id d75a77b69052e-4531255c62dmr14739711cf.6.1723219773077;
        Fri, 09 Aug 2024 09:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6GyuXgyukqToIMYwmYCyyJms6T0RBSwsqvRpSKO6DWSQsB926zH9/mqcqwcpfSE6Nqd5Tsw==
X-Received: by 2002:ac8:5f10:0:b0:450:349:1170 with SMTP id d75a77b69052e-4531255c62dmr14739431cf.6.1723219772696;
        Fri, 09 Aug 2024 09:09:32 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:32 -0700 (PDT)
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
Subject: [PATCH 08/19] mm: Always define pxx_pgprot()
Date: Fri,  9 Aug 2024 12:08:58 -0400
Message-ID: <20240809160909.1023470-9-peterx@redhat.com>
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

There're:

  - 8 archs (arc, arm64, include, mips, powerpc, s390, sh, x86) that
  support pte_pgprot().

  - 2 archs (x86, sparc) that support pmd_pgprot().

  - 1 arch (x86) that support pud_pgprot().

Always define them to be used in generic code, and then we don't need to
fiddle with "#ifdef"s when doing so.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/include/asm/pgtable.h    |  1 +
 arch/powerpc/include/asm/pgtable.h  |  1 +
 arch/s390/include/asm/pgtable.h     |  1 +
 arch/sparc/include/asm/pgtable_64.h |  1 +
 include/linux/pgtable.h             | 12 ++++++++++++
 5 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7a4f5604be3f..b78cc4a6758b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -384,6 +384,7 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
 /*
  * Select all bits except the pfn
  */
+#define pte_pgprot pte_pgprot
 static inline pgprot_t pte_pgprot(pte_t pte)
 {
 	unsigned long pfn = pte_pfn(pte);
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 264a6c09517a..2f72ad885332 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -65,6 +65,7 @@ static inline unsigned long pte_pfn(pte_t pte)
 /*
  * Select all bits except the pfn
  */
+#define pte_pgprot pte_pgprot
 static inline pgprot_t pte_pgprot(pte_t pte)
 {
 	unsigned long pte_flags;
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3fa280d0672a..0ffbaf741955 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -955,6 +955,7 @@ static inline int pte_unused(pte_t pte)
  * young/old accounting is not supported, i.e _PAGE_PROTECT and _PAGE_INVALID
  * must not be set.
  */
+#define pte_pgprot pte_pgprot
 static inline pgprot_t pte_pgprot(pte_t pte)
 {
 	unsigned long pte_flags = pte_val(pte) & _PAGE_CHG_MASK;
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3fe429d73a65..2b7f358762c1 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -783,6 +783,7 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return __pmd(pte_val(pte));
 }
 
+#define pmd_pgprot pmd_pgprot
 static inline pgprot_t pmd_pgprot(pmd_t entry)
 {
 	unsigned long val = pmd_val(entry);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 780f3b439d98..e8b2ac6bd2ae 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1956,6 +1956,18 @@ typedef unsigned int pgtbl_mod_mask;
 #define MAX_PTRS_PER_P4D PTRS_PER_P4D
 #endif
 
+#ifndef pte_pgprot
+#define pte_pgprot(x) ((pgprot_t) {0})
+#endif
+
+#ifndef pmd_pgprot
+#define pmd_pgprot(x) ((pgprot_t) {0})
+#endif
+
+#ifndef pud_pgprot
+#define pud_pgprot(x) ((pgprot_t) {0})
+#endif
+
 /* description of effects of mapping type and prot in current implementation.
  * this is due to the limited x86 page protection hardware.  The expected
  * behavior is in parens:
-- 
2.45.0


