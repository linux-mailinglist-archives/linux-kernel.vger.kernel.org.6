Return-Path: <linux-kernel+bounces-173907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8CF8C076F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E6DB2325F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8083B298;
	Wed,  8 May 2024 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah2I32fw"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2324B2F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208134; cv=none; b=lhRVTWusD5QMCt5xLuu9/QMlFlqkkr3jrx8RD2KYzsu/cgAyBoH/VqHgpQmDT7myw7urLNEvJNqq3BENSogI0Tob2pKBWhCMprySE5zXWedJB6t1CQ1IAOskJovonpPVydbrqB6gmebyxMjWtfaVINuV0iCY8w7mHB8fPbmGXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208134; c=relaxed/simple;
	bh=xdbI3HgqGVbYBMlkoEOKyGSFZrOh4mVYelo6HDS93bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRLbJ7dpdE7MVRrlG/m4xeMoex8UNRm7bMP593M3bpQ1JFpHlEYFsgAsXnBNvDQM1SFKKt0g91TDG3vB9PZG2wZBSHmT+yGQX6HBkcE62L4BoI+c4wk0LyPq+N9W2dXC0o42zQ34pWhPSMmUrkHOXtsh7xFAXbNDox2rvvpp+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah2I32fw; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso204254a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715208132; x=1715812932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DcpNxuaHKQ2XGPRcrgwYPClc6OYNtCFnxYQ34hBDF0=;
        b=Ah2I32fwodcmjO7bcCXeobZR2yL7NVrXgDawWk6FR3zEDwRUbEcmCW00Wzx7lhXnjh
         jQB6nMqZqQHNKmM868iHBN5OWqL36XeeFPKIgzKxuU74fF20pByN8IP0xXdR6tGtvxyS
         XWX17s8OuucoCL5YDRkjYylO87u8UGRF1mqp34ryvaX6hU1d/7chNhPtSoY3JeXXV80S
         6G62x1ZBMIGCA/Ly6Wxfg9PnmrfhxNhsFgfMwptqPE+ds6p61R8THb9HlPTWnueJ++t+
         tVryNnOZYJd7ydNHMQtEVpo5YHvN5qmluQG48fX444JOJINHxg2KcstCpUoP62TX8seh
         By4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208132; x=1715812932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DcpNxuaHKQ2XGPRcrgwYPClc6OYNtCFnxYQ34hBDF0=;
        b=AjJVIaLGvJs5MGDySs7DwU0y9n5yQ5YuE+GNANe9nzBWsUTGsBh1RIlZG9+uwQnS+G
         f2shLUPDb1viLu7arr2fDyucEsRfTGE0oqD330HiCJKcTEQHja0pbhlVYOjWOLy53Xtb
         87vokk//Mu+3YL2wcUQXXVozschtTr8KfNxz2NlY2Zz+Qn/mIPWA6MXzw8JPnrxpSA8L
         e+MTCHyVi0v9ja8YWnZv+udWPQC2mWcgJdXBtwSuypd2HMsdRW19nSWFGYKTncXuBlz+
         rRQ+7Ut0yC9Ls29vP4J3P05Su5zKZB/5sb+2f9t4JxtW5+LIO4QbEF1WYOQlbMR2zJOa
         u5yA==
X-Forwarded-Encrypted: i=1; AJvYcCUWPTk+kqUfjjLc4c7PTeCCRAr5tknGXm8Q8ONMEJH+rn88pOLG3whH+Vzk4vp3F0Tzo6Nb03yfdt/o2sFibd1arrNnLRwQsDijBZWR
X-Gm-Message-State: AOJu0YyJuMK/LOpu+RuoiptlBAPGjTeUXNRpc81+ZHt50jNyqQQCYQVz
	0w/BSI5GMpcEU1jfQidZ46YtfsAK+6rkgu5cgX/oebWdwsPxWChO
X-Google-Smtp-Source: AGHT+IGkFdAUAzrMlbUlBhREM/CEvwatOEIMRBL45vN2bg1LTAUKPSPifp6IeAAwfIL/STXKxZU/xg==
X-Received: by 2002:a17:90a:8b06:b0:2a2:981b:2c9e with SMTP id 98e67ed59e1d1-2b6169e1a86mr4021869a91.36.1715208132570;
        Wed, 08 May 2024 15:42:12 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126b666sm102082a91.34.2024.05.08.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:42:12 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v4 4/6] mm: introduce arch_do_swap_page_nr() which allows restore metadata for nr pages
Date: Thu,  9 May 2024 10:40:38 +1200
Message-Id: <20240508224040.190469-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508224040.190469-1-21cnbao@gmail.com>
References: <20240508224040.190469-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Should do_swap_page() have the capability to directly map a large folio,
metadata restoration becomes necessary for a specified number of pages
denoted as nr. It's important to highlight that metadata restoration is
solely required by the SPARC platform, which, however, does not enable
THP_SWAP. Consequently, in the present kernel configuration, there
exists no practical scenario where users necessitate the restoration of
nr metadata. Platforms implementing THP_SWAP might invoke this function
with nr values exceeding 1, subsequent to do_swap_page() successfully
mapping an entire large folio. Nonetheless, their arch_do_swap_page_nr()
functions remain empty.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 include/linux/pgtable.h | 26 ++++++++++++++++++++------
 mm/memory.c             |  3 ++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 18019f037bae..463e84c3de26 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1084,6 +1084,15 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
 })
 
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE
+static inline void arch_do_swap_page_nr(struct mm_struct *mm,
+				     struct vm_area_struct *vma,
+				     unsigned long addr,
+				     pte_t pte, pte_t oldpte,
+				     int nr)
+{
+
+}
+#else
 /*
  * Some architectures support metadata associated with a page. When a
  * page is being swapped out, this metadata must be saved so it can be
@@ -1092,12 +1101,17 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
  * page as metadata for the page. arch_do_swap_page() can restore this
  * metadata when a page is swapped back in.
  */
-static inline void arch_do_swap_page(struct mm_struct *mm,
-				     struct vm_area_struct *vma,
-				     unsigned long addr,
-				     pte_t pte, pte_t oldpte)
-{
-
+static inline void arch_do_swap_page_nr(struct mm_struct *mm,
+					struct vm_area_struct *vma,
+					unsigned long addr,
+					pte_t pte, pte_t oldpte,
+					int nr)
+{
+	for (int i = 0; i < nr; i++) {
+		arch_do_swap_page(vma->vm_mm, vma, addr + i * PAGE_SIZE,
+				pte_advance_pfn(pte, i),
+				pte_advance_pfn(oldpte, i));
+	}
 }
 #endif
 
diff --git a/mm/memory.c b/mm/memory.c
index eea6e4984eae..b51c059af0b0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4266,7 +4266,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
+	arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
+			pte, vmf->orig_pte, 1);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
-- 
2.34.1


