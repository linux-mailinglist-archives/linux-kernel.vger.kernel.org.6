Return-Path: <linux-kernel+bounces-278571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F10F94B1FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B8E1F20F02
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF5C14A08D;
	Wed,  7 Aug 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="yxU+H8bL"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0788286A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065576; cv=none; b=PuG5/J/YdY9tItBpyD2fUOyfMF6E5czCYLw3nogofIitXfU33y2zC337XWPMFNStjNRxUL3aSXxBQWdZmOAdYsPS2+fgo2/UZCcTG3eHZuP8ZAMyPLGeyO0UJhC6+WLA+NoNC7BGxzV+ytfqYxkVYdoeTYu5aWnjljVsH59/RDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065576; c=relaxed/simple;
	bh=mXuho5qRbcIktuppWuhYAb1FR0k6aVabcnCwkyhGc3A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IClp0cSDZwyJt9cblbeSejZgA8AZ5EtmU5TEof4Q/V5vFv5gOTf8U7f5pev4Mqx2mHMGHaNStOUNDTKTDQHZqHp1hOXdloHwVdpcJOAgYjxxbok25+yZwc3k6d75QzOvVdilXvR2drlpDKwLK7yzV+uNwZgAii5uKrZ8USKMrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=yxU+H8bL; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70943b07c2cso177851a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723065573; x=1723670373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRSFFXDfNtNVk7lGVeoRIubNta7FSFGwpVVL6fGvxf0=;
        b=yxU+H8bLn/VnjVHhhEWYqNM/2tzUm2JA+J1eBxBL9E5KfNReNlHtYTKwwU0Mgg+1Wt
         fQUUvj3nnFtMxxt9arm5B/6XxLv/GYnWs3F5lzEht3ESlDNR78/J7gQC28gw9soNFWlx
         fIM9JpwqmorhBP/dr4bAxn11PSbvxlrgrvmALLdij7WWJTXmufzioGYzx/AP26epWItW
         I6z79WY5asX9/u9IobTPPqcRsUsUXYVQLwOwaUnQPynJeiXD9weSSmtoc4B5yaY1zl53
         GcFmpohnxcKbR/bgC+lodW8ilHhkGi6sLWCyYlu1pl8i5z1+H++7vrjS1nsk7aTXWDGe
         USTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065573; x=1723670373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRSFFXDfNtNVk7lGVeoRIubNta7FSFGwpVVL6fGvxf0=;
        b=JtiwNBHHYzUK8QysCAQfLt3/2qvUlHylsEYAM1fSN08//O3ctFnx4vr+CK8Ix8vkyj
         JOYKK3MZzq2IzxDusUDc42dRzBT5QKZbUTDpkXSfbXaVQy/QIilP3PjYSpuKhvmWpQyo
         J/mvAydWfRzcR+1omx0lUsNeaOtMNUwzZWM52yrVUHdIWowfviG8PA2xQhiID3l+ch+/
         PxGNJKwU5vwL4sRX0I/7ELGDdb69/rt89S2Kfd7QQbZ06P8kmz3DJAQhI9KBeeF4PBxk
         qhNC8Xe6kz/yb9ix+6TGMxVCJg66xUF5BGV+XfhpKh4i9sZRMKWWdGyx2rOlXJOvi5FN
         PlOA==
X-Forwarded-Encrypted: i=1; AJvYcCVGMxW5eRvq/AZMm9mOUTITmmNHNwnwjrKa0+hHNyB8eN7k51TxMfzMO2q+IrOh1M3va8VkqFcmTfq2tE8iTrAddvzKFLvuHN1oDEmK
X-Gm-Message-State: AOJu0YzaMqHm+fTh1gnBWewArSJ0IyKJ5PKDJSXKydqdKwwsNtO9I4fw
	fbrIgLnrYfHn0g06+qjD8dSuHSC9aBj05hTo7wd3A7cTkR0eemTA6xiobRnX4iU=
X-Google-Smtp-Source: AGHT+IH15LQSc/UvvmQ30rxTzDG4NPtwy6Tdib44HAX04NTTQ2nGeWxvTn4nEbzI17bKR2TPoCepVA==
X-Received: by 2002:a05:6830:370c:b0:709:3c5b:effb with SMTP id 46e09a7af769-709b9975138mr23032461a34.23.1723065573520;
        Wed, 07 Aug 2024 14:19:33 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c839ee1sm59976976d6.89.2024.08.07.14.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:19:33 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
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
	willy@infradead.org
Subject: [PATCH v2 1/3] mm: update the memmap stat before page is freed
Date: Wed,  7 Aug 2024 21:19:27 +0000
Message-ID: <20240807211929.3433304-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
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


