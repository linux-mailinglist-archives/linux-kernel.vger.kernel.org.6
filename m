Return-Path: <linux-kernel+bounces-193748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5A8D3171
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE341F2102D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8EC174EFB;
	Wed, 29 May 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfhl9sZe"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79234168C08
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971356; cv=none; b=nvGfQpBddnELdBXHdx7NGFnsGnLDOMR/FNZD8l4J4+E5ihjUFprIuSG9Ung4EXrKVH699EJi+N7IyC+p08kpLOuBhDce8/zn+n+oqGNJYNHIQdQM5HnM3ti/atRZaFVPzNmaq4cXM1BzFuK4MajfpUD73obaPZQLTBe9Vafi0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971356; c=relaxed/simple;
	bh=jFlA7G1DVQAoAOQlVDDsBtYyxpiTxi+T4dKpoOXZh5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PC0qPdZfKtiqU1DRj1Cd2eJEK5Fw1x3rYK4Pqo7eRxAB4jToiu0TI590YMZsVnX0q7fS6g975kV8TidGIJHZ8ndPi2im9uExxdAcy7PzWcSKOBurp6lzpmx7/3AkGNTW1a+aLg5BcKVIx5DSp1l0KPJ4iav/bXgfreMg7FjgDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cfhl9sZe; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f8ea2df4b3so1391834b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971355; x=1717576155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEiK5CEmIDFaJlnWMqRQRlmiXqqRnfHwoYyNloeZy6o=;
        b=Cfhl9sZeCrZoX5nIl+ZEYDoPKdouCajLIH04ugcNcaDmrgEXAgmMSTQaKzO0BzISDG
         OC+rqrG5q1gQftcIndFsaJ+bTxNOND5N3FFTHTdApWkfijwSuQWcqF3O4iEvdTpOV5/R
         swtYESFmAb7ROJENugZ0gWOxHgV4saOPiJTZEfrbK224sYKID1ksQK9jb7DZGAJ7QLpo
         ErPwiIFb3vlHGHm+HEu6YqLeHIBOKwOggXU2dHP/4+/6nS3CP3A5JDlrLAQJ/54zStGN
         p8NMABoaUIVVtz0meOb0IQ4yd1H75JSn79rioDeW1GlGSMbB9ZqWK7W8yz7zwmwwXf0x
         45VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971355; x=1717576155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEiK5CEmIDFaJlnWMqRQRlmiXqqRnfHwoYyNloeZy6o=;
        b=YTBBBrbXT+YeH/qKV/VJCq9bNtxvkHeVBmnyGofTzS9OkwjAZ7etuRQEA5DrqrDnU+
         0+PJBN8JrLDt+9eIrqzgC/LNrgFSyNDUh/jbDKhLwWZlgPv5keQm4RLV5H8kQ3k79Kr3
         xOX0ID3WEvtOgDM6srTfSZ2ZV4RLTvq1/m86rtnlh63mh97loGD0KG0yQY10XU1pkzwG
         53KsZnzwCKFrTGHlf+pULLBL1KNgLMu+Oysv0RF2Rer47sTEVToFbHgIgYzKqMeUNsy8
         R8RfPN1Y6pYodqaVsNmGYaa/lV+FYIN1kYUduuJI//9/2i9qsJqjBb49pUc6ujHb9O4x
         qiog==
X-Forwarded-Encrypted: i=1; AJvYcCUZTELfh+gtVwi1AARFyNEiMhlg1CnB0Wi8kOBusBclj5RcTovCBWvHK1w4KFuNe3Ke6hkH9tAG/Hwta9RxRmqwbsuJYW26UiiFGvH5
X-Gm-Message-State: AOJu0Yyuwv3fc5wV6XRwhBBR5mu1ENgq1iIJPrUz5k8A7Cnd+gVyFJLG
	2QHbWjnVAF6xj5PcZsEoda5zsPkdQrGN/fEKo0DmjSIeOq1cKsJj
X-Google-Smtp-Source: AGHT+IHC+4YVrv2f2RKD1f5/1XnNvm559LObbEuRJtkuQpqFiFl9jlcgtsUPga8jgyaa5WCSFkT/bQ==
X-Received: by 2002:a05:6a00:908f:b0:6f3:ebc4:4407 with SMTP id d2e1a72fcca58-6f8f2b49544mr16440786b3a.4.1716971354683;
        Wed, 29 May 2024 01:29:14 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702220d948bsm174916b3a.131.2024.05.29.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:29:13 -0700 (PDT)
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
Subject: [PATCH v5 4/6] mm: introduce arch_do_swap_page_nr() which allows restore metadata for nr pages
Date: Wed, 29 May 2024 20:28:22 +1200
Message-Id: <20240529082824.150954-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529082824.150954-1-21cnbao@gmail.com>
References: <20240529082824.150954-1-21cnbao@gmail.com>
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
index 117b807e3f89..2f32eaccf0b9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1089,6 +1089,15 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
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
@@ -1097,12 +1106,17 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
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
index 100f54fc9e6c..c0c6de31a313 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4314,7 +4314,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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


