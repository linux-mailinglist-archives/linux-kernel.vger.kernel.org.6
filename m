Return-Path: <linux-kernel+bounces-187567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ECE8CD424
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765F3B207E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DAE14AD1B;
	Thu, 23 May 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvwdCDvn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C91D545
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470508; cv=none; b=dYBRRPV4u6csHMrCuy8xFToZPm9BkcPSsWEzkSjt+9Yd93UGO1J0ckdn4AvQBqxX5blAn0j4meJR7otrBzSL+VY9FOmjlOT22hf4GrBY7xe5U7xtRSqBItPFijWMbn1H2aH+nkDpiK/UG/NuTBalN6xNhII0swEioMuOhs2V5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470508; c=relaxed/simple;
	bh=frsFIBZZBUMfVTrWwRd+78dd0v5HtpDdTLozyRbWWVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6UuVl32wzenFGVcqE1NLDhc0pNuZ72RmZxYmask2BJT+1aljZcMIr6JFJgbgYjmjdAowDktpnHr/pgvO9328miNj1QeSKYj3a/yO4tJC8XogHCoPaQw/V1H9hUOVw82ljqwaFE9PzsFpviv/+6aqza7uaXghS0Eu6MIUPb7BWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvwdCDvn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716470505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VsbXcm1sxFBR27e0f5ft9IivKoeATBdnB7W0mM8QHqU=;
	b=KvwdCDvnC7xoKKpk/1JNdiSl4hUUeA9CUCEViy+XgtZyl371U5X8D7HrdRpzXrAHeJqL5G
	OW1ZHsLnXfMV3lxPuMEgqvVf43r66RO0J3LPE3iTpbP/pOrolXh+rX+RWYq0un7N01aYma
	uVvHf67fcpU1wqvLtBOou02cQeT/KfI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-XgJ3Avr8MliUEkl5KO_9_g-1; Thu, 23 May 2024 09:21:43 -0400
X-MC-Unique: XgJ3Avr8MliUEkl5KO_9_g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ab89f69cd8so459276d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716470503; x=1717075303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsbXcm1sxFBR27e0f5ft9IivKoeATBdnB7W0mM8QHqU=;
        b=DQUGMs/FqDLAKr7c3VwHxPDnXfYWrfpB6d1Kf7b43MDyRq1k2qMrKBUsvS+3wPJICs
         k5hNxI3qOdeLnsM505x+nLHEIPFbdu8pHwUkat2bplw54uMvv7anTb6gfqiNCbc6OzRI
         j4qzHVb1yKOwYDUoh0q4D50DWQTOUVjT+/+wChR38Zzliq3hhBni87I6lVM7sRhGazWF
         adPB31Anqnimr84RpCZsKU8ul9GJKMVLIAqjCTiKkzR4fvNFeQsXdkaOHh2sJxyteKqJ
         yAPUzUkmVF8cgE409MZC4n4rTpNQEOE73Xha8fT0RzutBvQ28mlm2EeLxqZPUZlWUPXC
         RdgA==
X-Gm-Message-State: AOJu0Yzbs9Rd5aWrJgeFxmyQ6XhbuSzaOmeqaQ372CnFHaIxIUZ9OQQN
	wmp1i/6B5SbaR9j9mh9hdIdVOGNv+puLpA3hYHYgnCpk7SGe9u52zywdqmKJ3FeqDfIktRlbTVo
	XPSe/Gri0TA8BmFfEUa0tx48voM3zvGj8hCyUPAb9lqJSIrSPdQVK0aK3MGv6IR0Ls5nPN/j1eh
	9soxzpA8WqSVHNzUhIilNR24Kgc3Bifi9a/M384Sx8Rho=
X-Received: by 2002:a05:6214:20ca:b0:6a0:cd60:cd3b with SMTP id 6a1803df08f44-6ab808f7119mr50153026d6.3.1716470502443;
        Thu, 23 May 2024 06:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7NO9vVltJj/+QkjBYp5MEJF3IkhEATQaB+o8Vu0R5dHDKGWSJnhD6+0WyJTsI/P7Ex3Q1fg==
X-Received: by 2002:a05:6214:20ca:b0:6a0:cd60:cd3b with SMTP id 6a1803df08f44-6ab808f7119mr50152616d6.3.1716470501696;
        Thu, 23 May 2024 06:21:41 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab873f7108sm13713156d6.125.2024.05.23.06.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 06:21:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Pavel Tatashin <pasha.tatashin@soleen.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Gavin Shan <gshan@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] mm/debug_vm_pgtable: Drop RANDOM_ORVALUE trick
Date: Thu, 23 May 2024 09:21:39 -0400
Message-ID: <20240523132139.289719-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Macro RANDOM_ORVALUE was used to make sure the pgtable entry will be
populated with !none data in clear tests.

The RANDOM_ORVALUE tried to cover mostly all the bits in a pgtable entry,
even if there's no discussion on whether all the bits will be vaild.  Both
S390 and PPC64 have their own masks to avoid touching some bits.  Now it's
the turn for x86_64.

The issue is there's a recent report from Mikhail Gavrilov showing that
this can cause a warning with the newly added pte set check in commit
8430557fc5 on writable v.s. userfaultfd-wp bit, even though the check
itself was valid, the random pte is not.  We can choose to mask more bits
out.

However the need to have such random bits setup is questionable, as now
it's already guaranteed to be true on below:

  - For pte level, the pgtable entry will be installed with value from
    pfn_pte(), where pfn points to a valid page.  Hence the pte will be
    !none already if populated with pfn_pte().

  - For upper-than-pte level, the pgtable entry should contain a directory
    entry always, which is also !none.

All the cases look like good enough to test a pxx_clear() helper.  Instead
of extending the bitmask, drop the "set random bits" trick completely.  Add
some warning guards to make sure the entries will be !none before clear().

Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/r/CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/debug_vm_pgtable.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index f1c9a2c5abc0..866eddb6cfda 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -40,22 +40,7 @@
  * Please refer Documentation/mm/arch_pgtable_helpers.rst for the semantics
  * expectations that are being validated here. All future changes in here
  * or the documentation need to be in sync.
- *
- * On s390 platform, the lower 4 bits are used to identify given page table
- * entry type. But these bits might affect the ability to clear entries with
- * pxx_clear() because of how dynamic page table folding works on s390. So
- * while loading up the entries do not change the lower 4 bits. It does not
- * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
- * used to mark a pte entry.
  */
-#define S390_SKIP_MASK		GENMASK(3, 0)
-#if __BITS_PER_LONG == 64
-#define PPC64_SKIP_MASK		GENMASK(62, 62)
-#else
-#define PPC64_SKIP_MASK		0x0
-#endif
-#define ARCH_SKIP_MASK (S390_SKIP_MASK | PPC64_SKIP_MASK)
-#define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
 #define RANDOM_NZVALUE	GENMASK(7, 0)
 
 struct pgtable_debug_args {
@@ -511,8 +496,7 @@ static void __init pud_clear_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PUD clear\n");
-	pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
-	WRITE_ONCE(*args->pudp, pud);
+	WARN_ON(pud_none(pud));
 	pud_clear(args->pudp);
 	pud = READ_ONCE(*args->pudp);
 	WARN_ON(!pud_none(pud));
@@ -548,8 +532,7 @@ static void __init p4d_clear_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating P4D clear\n");
-	p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
-	WRITE_ONCE(*args->p4dp, p4d);
+	WARN_ON(p4d_none(p4d));
 	p4d_clear(args->p4dp);
 	p4d = READ_ONCE(*args->p4dp);
 	WARN_ON(!p4d_none(p4d));
@@ -582,8 +565,7 @@ static void __init pgd_clear_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PGD clear\n");
-	pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
-	WRITE_ONCE(*args->pgdp, pgd);
+	WARN_ON(pgd_none(pgd));
 	pgd_clear(args->pgdp);
 	pgd = READ_ONCE(*args->pgdp);
 	WARN_ON(!pgd_none(pgd));
@@ -634,10 +616,8 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
 	if (WARN_ON(!args->ptep))
 		return;
 
-#ifndef CONFIG_RISCV
-	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
-#endif
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
+	WARN_ON(pte_none(pte));
 	flush_dcache_page(page);
 	barrier();
 	ptep_clear(args->mm, args->vaddr, args->ptep);
@@ -650,8 +630,7 @@ static void __init pmd_clear_tests(struct pgtable_debug_args *args)
 	pmd_t pmd = READ_ONCE(*args->pmdp);
 
 	pr_debug("Validating PMD clear\n");
-	pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
-	WRITE_ONCE(*args->pmdp, pmd);
+	WARN_ON(pmd_none(pmd));
 	pmd_clear(args->pmdp);
 	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(!pmd_none(pmd));
-- 
2.45.0


