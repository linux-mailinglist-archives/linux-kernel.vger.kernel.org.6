Return-Path: <linux-kernel+bounces-279771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DA594C1AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BD1B25D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374B19007B;
	Thu,  8 Aug 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="LdGvJKYu"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846018FC71
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131764; cv=none; b=F468CALGEEY0V7R0bPJIy6gCGCWfjUT2hykSVhPxr8oJIbUkqP0k+D8d7xSU/ofyJa9N2KtwOzDh77fPYSihZzyZ75OuRNqFJyEGtrXa89JSZ+7ERuzeaXF6uV7eee6p/tdwOa//SDb07mRdG45wuiYsdSsJlvZtPvs5tb6spHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131764; c=relaxed/simple;
	bh=mXuho5qRbcIktuppWuhYAb1FR0k6aVabcnCwkyhGc3A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi4GEmVbx3X0HUDSX4Nu9dlCQyGrfp995DZiQC0lwwpfpaIXnGQz1aFFv9s212nn+EiHF2iSVlDl7kxP7p9M/KodXBjTkRE1aX7t78PpSoIbGArgBGU37RiyCwU0rmR4F/Nr4p/Gx+G9Vxo+5huiw+uY9CdkQrqe1bcuv3zkCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=LdGvJKYu; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so5964186d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723131761; x=1723736561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRSFFXDfNtNVk7lGVeoRIubNta7FSFGwpVVL6fGvxf0=;
        b=LdGvJKYuAiuXr1Pgwa8qR0Tm1+o6wENHB9veXPs+HxeigAnOegl1HiFAsIovDIUBgp
         h+Ii9Wi5D8YgTZWvgIcVZRxfYPMkHYkDpaLRGBrsXHzCT4CFCQFLIBhBb7R5BvuSB8cY
         7AxsT+FjjLsEZwtwoCTptYwdW7lt/s7oJYIWK+CfmK5VgkzR1UaZIxyAo9xI1xhgcKlk
         Rr80o39Z7jQ+/2tVRCmLdSVX6BaaOfHg8YlFtL1uQ2dw3rDllnVrefMmz0fAV5S/lrQA
         U7rkln/Xpw8xfffF8w3ySuB+ZA/XATZDxc9FQTBmYuPuUpy1Uubiu7910pMSDZnJFrjK
         ocHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131761; x=1723736561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRSFFXDfNtNVk7lGVeoRIubNta7FSFGwpVVL6fGvxf0=;
        b=nQi7tZY26IC2QrwO6FQZH9C1EE7zDDypbvxk4bLDO34oSzflZJz/JdG7WwipYv9JnZ
         c8SvFk5ukN0c4q6wM8WufxSYHbLIR85rz743PmBT0j1A6OzgDnvqDaWfmLbXjEKDYaXL
         5fzgi4J5fCDdwcuIYVd6Cxtttn7C8KLXptxf0L+twbTWFaeJJZTCsoZFykS8rcVkcB0P
         14Z1Km4X5DSRNjY+6UHxsm0ztJaEj3k/pZiv5J3znPc4f98pmGp3GgHAYX1rBnCVtqjp
         PFqSFUMXwtvUw3Fm1RHtaB3HpKFimIdWLEsrqu/8CMfhD87C6T9ENTmrNgwuDrgTpHFv
         IPgg==
X-Forwarded-Encrypted: i=1; AJvYcCWg65yB1REQeEeliNgkLw6ecg9lnODK5Lal0K4KHciVY0wn1ufPDKfs/Oh4SebByAdzB84fzCK6975jQu19aHg7koIQFAaebkOxBseC
X-Gm-Message-State: AOJu0YyizXVB9POk2VBA0xvYZQV32EVkfDP2Yvz9xoYyD2IiT0XyhyuX
	K321/ycPkgNb60FuurkcW+mv7idgoS+aNgcQ6t7tDQzb8sYlewEcB4px3MwcKi4=
X-Google-Smtp-Source: AGHT+IEedYPnvL6gKHQRQr0wt7cczChz5kQMKQlE59fzWebBtyv5plUCNw68Wg5Sa6xCxlvPXi39qw==
X-Received: by 2002:a05:6214:4604:b0:6b9:607e:275e with SMTP id 6a1803df08f44-6bd6bd3263bmr24643256d6.34.1723131761187;
        Thu, 08 Aug 2024 08:42:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b72d9sm67160936d6.60.2024.08.08.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:42:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	dan.j.williams@intel.com,
	yi.zhang@redhat.com,
	alison.schofield@intel.com,
	david@redhat.com,
	yosryahmed@google.com
Subject: [PATCH v3 1/4] mm: update the memmap stat before page is freed
Date: Thu,  8 Aug 2024 15:42:34 +0000
Message-ID: <20240808154237.220029-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240808154237.220029-1-pasha.tatashin@soleen.com>
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is more logical to update the stat before the page is freed, to avoid
use after free scenarios.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb_vmemmap.c | 4 ++--
 mm/page_ext.c        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..fa83a7b38199 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -185,11 +185,11 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 static inline void free_vmemmap_page(struct page *page)
 {
 	if (PageReserved(page)) {
-		free_bootmem_page(page);
 		mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
+		free_bootmem_page(page);
 	} else {
-		__free_page(page);
 		mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
+		__free_page(page);
 	}
 }
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index c191e490c401..962d45eee1f8 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -330,18 +330,18 @@ static void free_page_ext(void *addr)
 	if (is_vmalloc_addr(addr)) {
 		page = vmalloc_to_page(addr);
 		pgdat = page_pgdat(page);
+		mod_node_page_state(pgdat, NR_MEMMAP,
+				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		vfree(addr);
 	} else {
 		page = virt_to_page(addr);
 		pgdat = page_pgdat(page);
+		mod_node_page_state(pgdat, NR_MEMMAP,
+				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
-
-	mod_node_page_state(pgdat, NR_MEMMAP,
-			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
-
 }
 
 static void __free_page_ext(unsigned long pfn)
-- 
2.46.0.76.ge559c4bf1a-goog


