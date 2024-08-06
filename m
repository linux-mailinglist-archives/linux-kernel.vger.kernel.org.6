Return-Path: <linux-kernel+bounces-275605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E3948784
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868D92855A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A91636127;
	Tue,  6 Aug 2024 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEMtGgpH"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DAF28DC1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910889; cv=none; b=UM7/5PDn39dNDvnKEe0eIlmRt+MQGxKnsuy4zWZsf1F857tP7AVnW90s+j69VytiCEZENgrgPDMJMjUgAdY1koQK10v+fzBpzc3QZOaKdcFkx6upIXuYZ8tcd0EKPGt4MVqlwLAb77vX103YTbuQykAagfI8pNMiUS+N8ab5JC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910889; c=relaxed/simple;
	bh=gYr+IKanW7SO53Hh0FAwufRCBjhpyVN8/ZLbUUxhUqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nRscTMuCh69NSlx+P29lLFoUI8y7ZJ+U2ZXMTKhr4j05HFCQd2R5s7no3dd0/IyWB9CBObhOw6GSw1okTFgB5vZATQgMEiUdtidKC9ApHxHPRBaIhMxplG3QaCX69dNSq0QoEYEp8Hb4jEox9fT4YQaujbQc+ohSe60vB1rZRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEMtGgpH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65b985bb059so410457b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722910887; x=1723515687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz9+L9Nas5YdR+3aU4+X/tR5OCfJ0AKY3iAQMLv0S5k=;
        b=KEMtGgpHKPr1kCuqmks0+nESA+I99x+GCEQ8lD6u4tjp9zFJF0U2npuQZi9snCHJ3Y
         9gQERoJJ3aL9XixKXAj3FkdCg0zI4di367gU7S6FKMglloK5I1P9iNUpZM4zHq5/xnxb
         LL49F9HEqzkqkayj9eEKkWckXZHjHHTXLhCWY8UYJ3RLiWP21Lw5N8cx0vThvgsfm99F
         vx2W5h9MLBkj6WEjQaGWlBehH+duLxDGRa0DGRddILVkNkgF5hM6+wJYw6Bjal9N5YJR
         HxPaSfn+oLmiWcB4Q+EDzbHcyKV9Aur8jymaYMyoARbILonDOcGtpu0wcz9lb52KQb2+
         Gmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910887; x=1723515687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz9+L9Nas5YdR+3aU4+X/tR5OCfJ0AKY3iAQMLv0S5k=;
        b=Psrp+2qJBxW3XwMYvsu/l3P885jbIYgDyU9saYHKYNjS5hCa7P/DcuLmelxDjPsRXY
         /Zrvt7oODj6S/RjY40Rl6Xyv5gCsSuE3PevjZc8080izAzY6mYV2ykget0KfVCJPyRme
         JrSfzhUzo76XSN4d8aewNxD+1ssHbDY6W2ix9Ys+EJ0LC6KdkcGfAU3JZS2fUb0i7PgV
         PpcUSKwE50c5GWUVU7KD7gYzZF97ckwzSJZi8xQeS6cL/NN3DBV7mWkZJmyFj8SDTbhN
         reGmn+aALzLDtzQ/tkEZlNkoHJkUXGe7hxT/dWc6p9mEYAIS9Gug+t3pY3oHT/oj81G4
         2jBg==
X-Forwarded-Encrypted: i=1; AJvYcCWS1dDW0Hru0TNT1D5nvJPoILbPwQOUUp539mUJ5+l81WyWj/+//SvOY7JFnxnopFy9VAqhpCLW1eMmnNQlCvlPXkNLwKN441p+trQN
X-Gm-Message-State: AOJu0Yyf53esu2+/K0WthVzvWhn+XtdIEsEoG7e6z/yZlYeqYy/rJYvr
	tpgn/I65JXY1BBgSfnu2Sa489B8Ku/nRdtfZBqoZvQFokj+mAQJOriG69URa4ZwLqJsDagB4oa0
	TgQ==
X-Google-Smtp-Source: AGHT+IE5Ot4MCUehL2BALtzt0Nbbacrl8HCjMPwdvfemN8nL8qevC8oWRD8zmA2efNk4jGDFZ//D943lM9s=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:261c:802b:6b55:e09c])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:113:b0:648:3f93:61f2 with SMTP id
 00721157ae682-689641a414emr5295867b3.6.1722910886865; Mon, 05 Aug 2024
 19:21:26 -0700 (PDT)
Date: Mon,  5 Aug 2024 20:21:13 -0600
In-Reply-To: <20240806022114.3320543-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806022114.3320543-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806022114.3320543-4-yuzhao@google.com>
Subject: [RFC PATCH 3/4] arm64: pause remote CPUs to update vmemmap
From: Yu Zhao <yuzhao@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Frank van der Linden <fvdl@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Muchun Song <muchun.song@linux.dev>, 
	Nanyong Sun <sunnanyong@huawei.com>, Yang Shi <yang@os.amperecomputing.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Pause remote CPUs so that the local CPU can follow the proper BBM
sequence to safely update the vmemmap mapping `struct page` areas.

While updating the vmemmap, it is guaranteed that neither the local
CPU nor the remote ones will access the `struct page` area being
updated, and therefore they will not trigger kernel PFs.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/include/asm/pgalloc.h | 55 ++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.c             | 14 ++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 8ff5f2a2579e..1af1aa34a351 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/cpu.h>
 
 #define __HAVE_ARCH_PGD_FREE
 #define __HAVE_ARCH_PUD_FREE
@@ -137,4 +138,58 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 	__pmd_populate(pmdp, page_to_phys(ptep), PMD_TYPE_TABLE | PMD_TABLE_PXN);
 }
 
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+
+#define vmemmap_update_lock vmemmap_update_lock
+static inline void vmemmap_update_lock(void)
+{
+	cpus_read_lock();
+}
+
+#define vmemmap_update_unlock vmemmap_update_unlock
+static inline void vmemmap_update_unlock(void)
+{
+	cpus_read_unlock();
+}
+
+#define vmemmap_update_pte vmemmap_update_pte
+static inline void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
+{
+	preempt_disable();
+	pause_remote_cpus();
+
+	pte_clear(&init_mm, addr, ptep);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	set_pte_at(&init_mm, addr, ptep, pte);
+
+	resume_remote_cpus();
+	preempt_enable();
+}
+
+#define vmemmap_update_pmd vmemmap_update_pmd
+static inline void vmemmap_update_pmd(unsigned long addr, pmd_t *pmdp, pte_t *ptep)
+{
+	preempt_disable();
+	pause_remote_cpus();
+
+	pmd_clear(pmdp);
+	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+	pmd_populate_kernel(&init_mm, pmdp, ptep);
+
+	resume_remote_cpus();
+	preempt_enable();
+}
+
+#define vmemmap_flush_tlb_all vmemmap_flush_tlb_all
+static inline void vmemmap_flush_tlb_all(void)
+{
+}
+
+#define vmemmap_flush_tlb_range vmemmap_flush_tlb_range
+static inline void vmemmap_flush_tlb_range(unsigned long start, unsigned long end)
+{
+}
+
+#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
+
 #endif
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 2dd92e58f304..893c73493d9c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -46,6 +46,18 @@ struct vmemmap_remap_walk {
 	unsigned long		flags;
 };
 
+#ifndef vmemmap_update_lock
+static void vmemmap_update_lock(void)
+{
+}
+#endif
+
+#ifndef vmemmap_update_unlock
+static void vmemmap_update_unlock(void)
+{
+}
+#endif
+
 #ifndef vmemmap_update_pmd
 static inline void vmemmap_update_pmd(unsigned long addr,
 				      pmd_t *pmdp, pte_t *ptep)
@@ -194,10 +206,12 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 
 	VM_BUG_ON(!PAGE_ALIGNED(start | end));
 
+	vmemmap_update_lock();
 	mmap_read_lock(&init_mm);
 	ret = walk_page_range_novma(&init_mm, start, end, &vmemmap_remap_ops,
 				    NULL, walk);
 	mmap_read_unlock(&init_mm);
+	vmemmap_update_unlock();
 	if (ret)
 		return ret;
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog


