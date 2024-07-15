Return-Path: <linux-kernel+bounces-252979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37459931AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC7F1C217DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043C13AD06;
	Mon, 15 Jul 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJbB3sxw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734413A268
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071319; cv=none; b=IH5gWw/bR4ArzPZzLlTQtvxtb6kgJSGaUyb+F0s3QO+45KulvJXuEQJaenJkGAsdU43KUCRobIfN8Vr4ho3vNrxhDvb8ttiFPTgYk+2E7TWvHe8t7PcEjMX8NqJTJn5XWANJR0GE8/hbCEiHQwYsCuUmmxaQbEESIkeKiLT5Qc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071319; c=relaxed/simple;
	bh=YCiezBGQi5XZZC1nGB6Xk5gi7omXw4czBvCuVu44aKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noWX6JHG/gmXPVpbnQA/L/4oqPI5k8Y6AiQncIOCxT54ha2CZU7+5sx0/DzRM0wiO/TdVbeOX14zeKYcoj1wH9Srm9rMFjYwV1CDLRP96ChAOYqR6OF4vhmLjtUjgccL0Nd4bRj951hJTxgYBEY74jZ2J4jiRasDGDbqEQrzkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJbB3sxw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTG40gQ1/IqtnBedMzEchXvuwrXGVRlB32P0aAwFHGI=;
	b=VJbB3sxwlhGGuBloRtEDjZib0FqgHWBRnV5tM3rIP1eP/60MiYmTdzDn1xrqOp471EKOmN
	szublzGnpAE+FKeAiHCJMWKeMk+IJIqK9kk6AAaYw4w6SJAQk7t8iqvyMjq2QN1Di1HRp4
	IkB6hAOwJx5MRmfQnzu/BEFdb/w6QDM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-Vl4LE_m5MsaiVHFIAZ1mrA-1; Mon, 15 Jul 2024 15:21:53 -0400
X-MC-Unique: Vl4LE_m5MsaiVHFIAZ1mrA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7678caf7dso6081036d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071313; x=1721676113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTG40gQ1/IqtnBedMzEchXvuwrXGVRlB32P0aAwFHGI=;
        b=aVVOY3RRrJz5J2NyzOODc4f3F6Cw0w4RdZNUJfPboO4UMfU3qc4cavZBwShT+JgcsC
         iBfNxWCVCGsWI0LvpklBlIMY3RMrPAkGVENwUYEFCabOcghh1LQqiupEv8Y0JWjQ9E5x
         YDLqDLiYB8+ESapp1PMD03T0pV1tNw29RmPbk35kgv7pqPPpHTZpz7LZm6hpyEAoMhgh
         3JtE0NeyjVD8vzf8/fJrm4QC9QAOsuDrUHy4Kp1aIl96OZvUKyOSOGFUeEb0lfd2R04Y
         x3meyJoQS9ARSsqI2HHtIZSr6/DZTwmSXQqo85e1G7nNlvMQQVe7mvHS4HXkErDPOu6Z
         6eNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlInBcxVhNadRPgNfdZGXgAKMBoyeiQJblltXhua4O8IcD1TCOXa8Aysjs9jtAJbkPhFz9wSCVxFuDOwjeIrS6EznEvqziaRT6+bGX
X-Gm-Message-State: AOJu0Yxwho0z7ZtsuUt00oKNjH9tqDWeHJ7z+Rog0x66xJuHrFTX+Mk6
	N/+P/xQ2KMDQYNCuTj2uVZ5yceuC17f4340Y0sNEpzVp2sI5FW939a65LWpYdlFmFjNIXWUwizi
	y1Azcrt1IAZU8N8yMu/sASQ2dFQWcvHvscQXufkEHGsCvB2RNnf0sba3RmwnHmQ==
X-Received: by 2002:a05:6214:3d9c:b0:6b7:586c:6db with SMTP id 6a1803df08f44-6b77e1a9bbbmr4344406d6.9.1721071312953;
        Mon, 15 Jul 2024 12:21:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuaD7Bvj1JQVrhIrOGjnKODWs3APjSgAvSuKVxjGp/QvXbyCQZIOrqbPCB4cG0KJw/WyvKgQ==
X-Received: by 2002:a05:6214:3d9c:b0:6b7:586c:6db with SMTP id 6a1803df08f44-6b77e1a9bbbmr4344156d6.9.1721071312655;
        Mon, 15 Jul 2024 12:21:52 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761978d30sm24039356d6.31.2024.07.15.12.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:21:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>,
	x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
	kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Rientjes <rientjes@google.com>
Subject: [PATCH v3 3/8] mm/mprotect: Push mmu notifier to PUDs
Date: Mon, 15 Jul 2024 15:21:37 -0400
Message-ID: <20240715192142.3241557-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240715192142.3241557-1-peterx@redhat.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mprotect() does mmu notifiers in PMD levels.  It's there since 2014 of
commit a5338093bfb4 ("mm: move mmu notifier call from change_protection to
change_pmd_range").

At that time, the issue was that NUMA balancing can be applied on a huge
range of VM memory, even if nothing was populated.  The notification can be
avoided in this case if no valid pmd detected, which includes either THP or
a PTE pgtable page.

Now to pave way for PUD handling, this isn't enough.  We need to generate
mmu notifications even on PUD entries properly.  mprotect() is currently
broken on PUD (e.g., one can easily trigger kernel error with dax 1G
mappings already), this is the start to fix it.

To fix that, this patch proposes to push such notifications to the PUD
layers.

There is risk on regressing the problem Rik wanted to resolve before, but I
think it shouldn't really happen, and I still chose this solution because
of a few reasons:

  1) Consider a large VM that should definitely contain more than GBs of
  memory, it's highly likely that PUDs are also none.  In this case there
  will have no regression.

  2) KVM has evolved a lot over the years to get rid of rmap walks, which
  might be the major cause of the previous soft-lockup.  At least TDP MMU
  already got rid of rmap as long as not nested (which should be the major
  use case, IIUC), then the TDP MMU pgtable walker will simply see empty VM
  pgtable (e.g. EPT on x86), the invalidation of a full empty region in
  most cases could be pretty fast now, comparing to 2014.

  3) KVM has explicit code paths now to even give way for mmu notifiers
  just like this one, e.g. in commit d02c357e5bfa ("KVM: x86/mmu: Retry
  fault before acquiring mmu_lock if mapping is changing").  It'll also
  avoid contentions that may also contribute to a soft-lockup.

  4) Stick with PMD layer simply don't work when PUD is there...  We need
  one way or another to fix PUD mappings on mprotect().

Pushing it to PUD should be the safest approach as of now, e.g. there's yet
no sign of huge P4D coming on any known archs.

Cc: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 21172272695e..2a81060b603d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -363,9 +363,6 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 	pmd_t *pmd;
 	unsigned long next;
 	long pages = 0;
-	struct mmu_notifier_range range;
-
-	range.start = 0;
 
 	pmd = pmd_offset(pud, addr);
 	do {
@@ -383,14 +380,6 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 		if (pmd_none(*pmd))
 			goto next;
 
-		/* invoke the mmu notifier if the pmd is populated */
-		if (!range.start) {
-			mmu_notifier_range_init(&range,
-				MMU_NOTIFY_PROTECTION_VMA, 0,
-				vma->vm_mm, addr, end);
-			mmu_notifier_invalidate_range_start(&range);
-		}
-
 		_pmd = pmdp_get_lockless(pmd);
 		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
@@ -428,9 +417,6 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
 
-	if (range.start)
-		mmu_notifier_invalidate_range_end(&range);
-
 	return pages;
 }
 
@@ -438,22 +424,36 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
+	struct mmu_notifier_range range;
 	pud_t *pud;
 	unsigned long next;
 	long pages = 0, ret;
 
+	range.start = 0;
+
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
 		ret = change_prepare(vma, pud, pmd, addr, cp_flags);
-		if (ret)
-			return ret;
+		if (ret) {
+			pages = ret;
+			break;
+		}
 		if (pud_none_or_clear_bad(pud))
 			continue;
+		if (!range.start) {
+			mmu_notifier_range_init(&range,
+						MMU_NOTIFY_PROTECTION_VMA, 0,
+						vma->vm_mm, addr, end);
+			mmu_notifier_invalidate_range_start(&range);
+		}
 		pages += change_pmd_range(tlb, vma, pud, addr, next, newprot,
 					  cp_flags);
 	} while (pud++, addr = next, addr != end);
 
+	if (range.start)
+		mmu_notifier_invalidate_range_end(&range);
+
 	return pages;
 }
 
-- 
2.45.0


