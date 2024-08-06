Return-Path: <linux-kernel+bounces-275603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF3948782
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578D0B24060
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8828366;
	Tue,  6 Aug 2024 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkGdJ2MC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA05182C5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910884; cv=none; b=t2+k06/AIBOENnAx90zEi4e4K0F7nvQ15wJ5pdYRoM/RKljzMJPGOHwO7ZxS3DFlytw0IMxge7rJzYBk9IRSlPj4pU9aeYkN4duJhU8d0N+7420GWFqQwkm4cEkGuyPksd9oS0e/7q2JRNU0sNowMHuwcXhgAVgvWmAuCCtWbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910884; c=relaxed/simple;
	bh=xps+glxZeFp3Mb1v2Adq8WZaOGiU0jfykOgLRet3dso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b1+Her5AXBSf+xvwX9fqIa20tPkcR8843VdKdZOG762X1Z0f3r3oury2znq58xI/oYVtzDxg4Fk0DazD7yj0suWd7r2YrijMNEZk8sDswbXzk1RWWqaLrdylrH3+fJQeHieEDH4e9kL7ZlFGhQJke9o26CQzq/Soi/96UnkNhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkGdJ2MC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6698f11853aso6016537b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722910882; x=1723515682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yV7dY4XDiIXGgrOmDcJWCpFmJrDLDUqsW20nfMTrSyE=;
        b=jkGdJ2MCXZPFfjVl/Tv4b/cyVZ/Jet62JDGbkTFAi7Niy9x3bn+uagK/Szse1GiVVf
         IgkNfv+ljz2JY50nBXyDfaIhz5HMNtT5akpTayvqCuW3yS4wLEf8nXxRDwjs+feH62EF
         IAlSCvjLuabgebuhYH8uZGIB7UjR3Q8pVBpcEHeVh8Vb8zdKWJyEfIj+do0OlnKK8t3z
         J4nRy+NnebKymp9dM7U1u9KNM8orxXVGUsyxAMS4tociuzhbxznl+LxcpBtTU87G6aMK
         4pvJgE0fJqM+twhw9tuBWlFA+piEbvyNsYmMVORlXHZSkMrO0tHo6N5NJ9njdzwLsJxj
         wBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910882; x=1723515682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yV7dY4XDiIXGgrOmDcJWCpFmJrDLDUqsW20nfMTrSyE=;
        b=vApGBLA2l8XkL6miH+JIAVqdku3TwaMiDyRSOWd4Z9wjmkWBW8RB5kQvGD3kzx0FRo
         PZeFZpXQCctwu30iZvOTRP4zMI1ziDi1s1B8v29NjydWsSxQzf3saZIGbgQpdg22Bl2P
         xGDvZ6TKABUjmWHe5arZfR2Umj6kxugY4aNUXLghja+yjvtFXE4l+McdQhCun0+HDp05
         Ngmbkquh3T5M2WBidJ0MyI9p+zq3Sg3EFXKpkVHNqY7B9lNHJDWukQQhKD0v0OJJDZsH
         e/K7uZmZJRkF4b+1QOtyde+KVKNIL51V9+NsWlvuB5+5z+1i8Qoatk9r4LcMjik5U6an
         F3rg==
X-Forwarded-Encrypted: i=1; AJvYcCXk8diWnUZcOSLvBU1Kqdae+slEk0v8HEgXRJJXudWe+RYK57Ki1tZ0Xgd3j662gddp35TafhCeHYW2BETvSecwM6Wnuboxk/ImJiRh
X-Gm-Message-State: AOJu0YyZqhvx3/HWzkajaVTPnPVgIycZaewUYm0NnWsy8iOqjoNaqJwT
	xkv1tefRMI50GWMmbnkRMJmCiEYKMfjMvDRV6y+LJOCNebV1AdOtA0deog/wkTA8cV/hVMDxY3J
	ITw==
X-Google-Smtp-Source: AGHT+IGSY6zrX4Qs7JrUctkrSdbtisepSykseFX5DdXlWxT8TG2QUbuQRw2CO7r/i/yRAh7feSGbV18ovH8=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:261c:802b:6b55:e09c])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2b84:b0:e0b:cce3:45c7 with SMTP id
 3f1490d57ef6-e0bde3ef075mr24855276.9.1722910881783; Mon, 05 Aug 2024 19:21:21
 -0700 (PDT)
Date: Mon,  5 Aug 2024 20:21:11 -0600
In-Reply-To: <20240806022114.3320543-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806022114.3320543-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806022114.3320543-2-yuzhao@google.com>
Subject: [RFC PATCH 1/4] mm: HVO: introduce helper function to update and
 flush pgtable
From: Yu Zhao <yuzhao@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Frank van der Linden <fvdl@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Muchun Song <muchun.song@linux.dev>, 
	Nanyong Sun <sunnanyong@huawei.com>, Yang Shi <yang@os.amperecomputing.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Nanyong Sun <sunnanyong@huawei.com>

Add pmd/pte update and tlb flush helper function to update page
table. This refactoring patch is designed to facilitate each
architecture to implement its own special logic in preparation
for the arm64 architecture to follow the necessary break-before-make
sequence when updating page tables.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/hugetlb_vmemmap.c | 55 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..2dd92e58f304 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -46,6 +46,37 @@ struct vmemmap_remap_walk {
 	unsigned long		flags;
 };
 
+#ifndef vmemmap_update_pmd
+static inline void vmemmap_update_pmd(unsigned long addr,
+				      pmd_t *pmdp, pte_t *ptep)
+{
+	pmd_populate_kernel(&init_mm, pmdp, ptep);
+}
+#endif
+
+#ifndef vmemmap_update_pte
+static inline void vmemmap_update_pte(unsigned long addr,
+				      pte_t *ptep, pte_t pte)
+{
+	set_pte_at(&init_mm, addr, ptep, pte);
+}
+#endif
+
+#ifndef vmemmap_flush_tlb_all
+static inline void vmemmap_flush_tlb_all(void)
+{
+	flush_tlb_all();
+}
+#endif
+
+#ifndef vmemmap_flush_tlb_range
+static inline void vmemmap_flush_tlb_range(unsigned long start,
+					   unsigned long end)
+{
+	flush_tlb_kernel_range(start, end);
+}
+#endif
+
 static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 			     struct vmemmap_remap_walk *walk)
 {
@@ -81,9 +112,9 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
-		pmd_populate_kernel(&init_mm, pmd, pgtable);
+		vmemmap_update_pmd(start, pmd, pgtable);
 		if (!(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH))
-			flush_tlb_kernel_range(start, start + PMD_SIZE);
+			vmemmap_flush_tlb_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -171,7 +202,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 		return ret;
 
 	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
-		flush_tlb_kernel_range(start, end);
+		vmemmap_flush_tlb_range(start, end);
 
 	return 0;
 }
@@ -220,15 +251,15 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 
 		/*
 		 * Makes sure that preceding stores to the page contents from
-		 * vmemmap_remap_free() become visible before the set_pte_at()
-		 * write.
+		 * vmemmap_remap_free() become visible before the
+		 * vmemmap_update_pte() write.
 		 */
 		smp_wmb();
 	}
 
 	entry = mk_pte(walk->reuse_page, pgprot);
 	list_add(&page->lru, walk->vmemmap_pages);
-	set_pte_at(&init_mm, addr, pte, entry);
+	vmemmap_update_pte(addr, pte, entry);
 }
 
 /*
@@ -267,10 +298,10 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 
 	/*
 	 * Makes sure that preceding stores to the page contents become visible
-	 * before the set_pte_at() write.
+	 * before the vmemmap_update_pte() write.
 	 */
 	smp_wmb();
-	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+	vmemmap_update_pte(addr, pte, mk_pte(page, pgprot));
 }
 
 /**
@@ -536,7 +567,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	}
 
 	if (restored)
-		flush_tlb_all();
+		vmemmap_flush_tlb_all();
 	if (!ret)
 		ret = restored;
 	return ret;
@@ -664,7 +695,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			break;
 	}
 
-	flush_tlb_all();
+	vmemmap_flush_tlb_all();
 
 	/* avoid writes from page_ref_add_unless() while folding vmemmap */
 	synchronize_rcu();
@@ -684,7 +715,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
-			flush_tlb_all();
+			vmemmap_flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
 			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages,
@@ -692,7 +723,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 		}
 	}
 
-	flush_tlb_all();
+	vmemmap_flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog


