Return-Path: <linux-kernel+bounces-281198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A994D43D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71BE3B23FB5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761F19AA73;
	Fri,  9 Aug 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c45B0Sr3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC819AA46
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219775; cv=none; b=tUZH0obe+/SXTm9pGK9nRhfvrJg6kWHbWavnQYOoeGlHRvNQZLEdJUx8lk2niaccv/YJWSXMXCv6LkETOo5RlTnkqL3B0aNBnFDh7/iz1j1F70HQGrM6ldpQhr4su8Kcystg5i0pq93gnLGedRaOj+hqA2n0P7FDJd8HtcBmLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219775; c=relaxed/simple;
	bh=NRE6RSln8yk8W4KIRztpuy77GMwMRMzE4sT6CQJcyFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3/pndqueJyD0WpV3hw8XaV7/q2ST1HS7+s10aN/MKV6z7pYlisz1/Vk9uPoos/rPHmWA5bYloa5KHyNKafvOWZRQ0oYwzpH7SkAX2aOpyvbnzUxaApPUIvfCWEXwFJZk4/g87cewflMH+34KRg+XwPtA/g5NXIArV/FQbgL6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c45B0Sr3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAUMBfy0kdSy8bea6Q2/adQQTYYkrWuiUWfctkd/rW8=;
	b=c45B0Sr3yazNTZNhbIwtCuU7Ramq6snK4CcOpNVf1lQ5CTjMIK5jQWCW6ZJV3AxHh+dpT8
	210JM1/828YOAGynPsiCJ22reBHXB9VKdQyMG4KuqkTk278gUwQhm4g8LtbBkivUY9lNDV
	M9RL4suMguN+XyCweQsVBwbTDd5J//Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-lgmQy4LoNoCR2yiZjmP1lQ-1; Fri, 09 Aug 2024 12:09:31 -0400
X-MC-Unique: lgmQy4LoNoCR2yiZjmP1lQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4502562fc7eso657031cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219771; x=1723824571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAUMBfy0kdSy8bea6Q2/adQQTYYkrWuiUWfctkd/rW8=;
        b=o7CdUyt0/DFGlCdtId4R5fb6au0YwkZjIFOkDp08Erkc05udGcdBHfP8ahPlWJ6SMY
         oQivEdj2YBgowTN5tr9ICbd/uxpKcQzb14uX8aPo4vmWEGTFC59LfnZE/CX5h/UCAYBO
         KMVLz6l1iS22aCUMGoTV8fZTN7LcIrjV2K+I2OFV9hp09cntceLZcYNBNpoOPFlbPCdL
         XqHc0DhSd1XaBh0MwRaDArd2R/1btrzD6hizn4KDmV3Mo+JEwCiW8P253RTDQwWFO3zM
         p8qlmBPSkfkr4McKuhTWSiwphHgjAFoL7Cyb1uvxVlWLfz0r5ZhHIi43pcebm3V+MtVX
         XxTg==
X-Forwarded-Encrypted: i=1; AJvYcCUqWwuY4kRkYMh4VHXu3ukz8TSSjEB0EeSC43o5yFtt9pINDYwvFvIPfVumP6CmuzPaxcoMJXZJ/S7fsH7a1pYIAxTRPnzxuTbv9Zjq
X-Gm-Message-State: AOJu0YxyAxBxF+LTL2ZCOOuuOFeHKUSsdsusjyHf/rlNYP4uxJ7/os1A
	EftR48ILipqkLIM1q2PuKcN71sU6VuCa1CGmcvsO3jL7/YiPoOLl+WQOKoooYN9s3T3PGJGuAxI
	hjeBo0HstCnozFxsnR2pprenvoBkzTtqBov6nZPZYI/k3O/sf36Obh9NJXChkXw==
X-Received: by 2002:a05:622a:180e:b0:44e:d016:ef7 with SMTP id d75a77b69052e-45312652444mr12909271cf.7.1723219771015;
        Fri, 09 Aug 2024 09:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2AJ498flXqsf/RjsZizkWR5q4LBdwGhozxnqN6XMiL4rwNH8ESKXDSym68P6o8cpdHObfXw==
X-Received: by 2002:a05:622a:180e:b0:44e:d016:ef7 with SMTP id d75a77b69052e-45312652444mr12908941cf.7.1723219770588;
        Fri, 09 Aug 2024 09:09:30 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:30 -0700 (PDT)
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
Subject: [PATCH 07/19] mm/fork: Accept huge pfnmap entries
Date: Fri,  9 Aug 2024 12:08:57 -0400
Message-ID: <20240809160909.1023470-8-peterx@redhat.com>
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

Teach the fork code to properly copy pfnmaps for pmd/pud levels.  Pud is
much easier, the write bit needs to be persisted though for writable and
shared pud mappings like PFNMAP ones, otherwise a follow up write in either
parent or child process will trigger a write fault.

Do the same for pmd level.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6568586b21ab..015c9468eed5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1375,6 +1375,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pgtable_t pgtable = NULL;
 	int ret = -ENOMEM;
 
+	pmd = pmdp_get_lockless(src_pmd);
+	if (unlikely(pmd_special(pmd))) {
+		dst_ptl = pmd_lock(dst_mm, dst_pmd);
+		src_ptl = pmd_lockptr(src_mm, src_pmd);
+		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+		/*
+		 * No need to recheck the pmd, it can't change with write
+		 * mmap lock held here.
+		 */
+		if (is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd)) {
+			pmdp_set_wrprotect(src_mm, addr, src_pmd);
+			pmd = pmd_wrprotect(pmd);
+		}
+		goto set_pmd;
+	}
+
 	/* Skip if can be re-fill on fault */
 	if (!vma_is_anonymous(dst_vma))
 		return 0;
@@ -1456,7 +1472,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
 	if (!userfaultfd_wp(dst_vma))
 		pmd = pmd_clear_uffd_wp(pmd);
-	pmd = pmd_mkold(pmd_wrprotect(pmd));
+	pmd = pmd_wrprotect(pmd);
+set_pmd:
+	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
 	ret = 0;
@@ -1502,8 +1520,11 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * TODO: once we support anonymous pages, use
 	 * folio_try_dup_anon_rmap_*() and split if duplicating fails.
 	 */
-	pudp_set_wrprotect(src_mm, addr, src_pud);
-	pud = pud_mkold(pud_wrprotect(pud));
+	if (is_cow_mapping(vma->vm_flags) && pud_write(pud)) {
+		pudp_set_wrprotect(src_mm, addr, src_pud);
+		pud = pud_wrprotect(pud);
+	}
+	pud = pud_mkold(pud);
 	set_pud_at(dst_mm, addr, dst_pud, pud);
 
 	ret = 0;
-- 
2.45.0


