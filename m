Return-Path: <linux-kernel+bounces-283563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7594F664
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DDC1F22A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF0B18A6A7;
	Mon, 12 Aug 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+wNwXxF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1618B499
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486361; cv=none; b=sn5SIIhWklMYU3VU77eraJEKHNtFld2Hq9Ge50giyzwPlESQ3yenT9KPhk1SkyfulFyhjHZWhb2R+z88uZ8dXRv0Dz0ZMuadu0cSFlebfQyJWEJMdhfIsv+vcfWjh/vE/ehgU94E8PEZ/99tmXpBksgmukezDF0l7RWUlZ890tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486361; c=relaxed/simple;
	bh=7RUkptmdOEoTaWI5G/XfwfT/YiV+5T3HhVmyBbiSmpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiqRMvD4Bz+bzM41BQPQ6kx+lA7KkqT+JF52FprBIkb7bS46jFxivTFU4q7w7vNCtAp5wfxTP9xwz9C5VRbaSQJWlcdgKwIdyRzg6ECiCjbby3bQY/0Gkgytq/Z0vnR8l0z6UaPqueMU0iZONvCwylaeZaIYjKUoM7U+aRmK9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+wNwXxF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aC2RF+//p0GJfjgH/iZrlW9ATLJl4mVfe8Rdc4jHgk=;
	b=g+wNwXxFxB696wqTE34xC3fI1p16vcRqwUy3waBW23AbkEbFJ/FUbKoDA41VlggRDAH8Tf
	eMdIsZd2oMzMeZ44UWrAcC7FvvpMKXnLYRYOmZkviarToeOH0dSGKlu1CeYcusU+gqxRRK
	CUzL94bLy/osHek5lSKN9HpHrES/1D8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-_fdUnv7lOrqYrCmRkuKR2A-1; Mon, 12 Aug 2024 14:12:35 -0400
X-MC-Unique: _fdUnv7lOrqYrCmRkuKR2A-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7093f4569b3so148711a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486354; x=1724091154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aC2RF+//p0GJfjgH/iZrlW9ATLJl4mVfe8Rdc4jHgk=;
        b=pge56zN1XAypncuOi9rdDYFLvixM5Cg2JK3avxeNkXIUbpWxYMRJUQVU14kxiNdJjO
         xoyok9ApnpQFFlLyJlL4fJW0IB/QvjtCAmhom7Whgxnf43PSCiMb36YPIPm7PItXDgEM
         Q25AtviqRn9zrn/eJHS3ZN1nmKdd98yugy7X8aHUl5w2h7dGIY1fp50MoS7cnq7/g12c
         w0+Lrj89GvaKkF0HGPkeb13HF7aoLvxe1t5XalnpBSkMhRg6JwKDfMOcESifOrD9dlKM
         MvB2qg0qkprFrUFLZJpAuUCtdLwpVQNBc3Xsy2U+CKCEstqxjaMHq2sIPXlM9VKYJKsc
         Vxmg==
X-Gm-Message-State: AOJu0YxBwmBA9WGrwyP2z8h6XLOfUVU9oedXRROJDuXSgsLqJMyyofBq
	v2l1eKKxPv6Yg0ZKZGszsjzRcyUHAh1WCGhDfUt8HQ94bFoQwQsl/xmYjV4D8pUxM48jaMKmLC4
	SdTL942RMGolA6D4Vw+K4pxr2v8ygX0e9x4hcfb++2qIo6TfJruRGzQ0aJuuc1WGCkXvctoaKZ7
	bkRzGBVHZlTG59jw2bzgu+OeRSdZhO4z61JwDdGiuRuiY=
X-Received: by 2002:a05:6358:d25:b0:1ac:a26c:a07a with SMTP id e5c5f4694b2df-1b1a02f2896mr6055d.4.1723486353871;
        Mon, 12 Aug 2024 11:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKB0h9tqBDznq7jPudw+rKB1F4j/lDBjBP5vz8Ij/mXfeVHheDU0KW5XKnOwJHdaPAJFxqTQ==
X-Received: by 2002:a05:6358:d25:b0:1ac:a26c:a07a with SMTP id e5c5f4694b2df-1b1a02f2896mr2555d.4.1723486353186;
        Mon, 12 Aug 2024 11:12:33 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dee013sm268663985a.84.2024.08.12.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:12:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Kirill A . Shutemov" <kirill@shutemov.name>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	peterx@redhat.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Rientjes <rientjes@google.com>
Subject: [PATCH v5 2/7] mm/mprotect: Push mmu notifier to PUDs
Date: Mon, 12 Aug 2024 14:12:20 -0400
Message-ID: <20240812181225.1360970-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240812181225.1360970-1-peterx@redhat.com>
References: <20240812181225.1360970-1-peterx@redhat.com>
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
index 37cf8d249405..d423080e6509 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -363,9 +363,6 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 	unsigned long next;
 	long pages = 0;
 	unsigned long nr_huge_updates = 0;
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
@@ -431,9 +420,6 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
 
-	if (range.start)
-		mmu_notifier_invalidate_range_end(&range);
-
 	if (nr_huge_updates)
 		count_vm_numa_events(NUMA_HUGE_PTE_UPDATES, nr_huge_updates);
 	return pages;
@@ -443,22 +429,36 @@ static inline long change_pud_range(struct mmu_gather *tlb,
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


