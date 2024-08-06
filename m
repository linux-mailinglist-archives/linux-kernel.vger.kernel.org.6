Return-Path: <linux-kernel+bounces-277019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB9949B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E131C22AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC0173336;
	Tue,  6 Aug 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="YlV4UK0N"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A715FA92
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982501; cv=none; b=LSDaSr03y40d7Cfvk8eY3+FUxxM5Xj4c4AIpU+OJSclof4jh1O90wjJdqce6siPKEc/+r2ooKb/ShaP7xpA4CmWZ/DtJ9hIczSjGSBM5pAXZBQiT9J3/vs/PRcSQhwZBAeMoo9nndDKDar+Mtb4Ab/V/9EncNSJ6AFLGkPfOQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982501; c=relaxed/simple;
	bh=Ogo68UR/OsXc9UdIgAzdmezFiK2lZB543zE7hjBKpoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j8Ja8Yk0tl0Jn8aaHkL1X5FsCJxl5I87sVOFEhAxhruxPF9co7XL1eiCn8SUHX/SmwbKU+KWsGLaqqkIhE9SfgtF8L9x7q7oQl7zPEG28SfJyepujpiLcv7j8ymjaWANSX/fdye8EvlZku7SLSBGXp7aymeCY6Yr6jA2WWMShuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=YlV4UK0N; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bb687c3cceso5630026d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722982498; x=1723587298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpwrGsGSvnHFdGVf1tlm4Wyo1L4IUT4bE3I4p9OVTOM=;
        b=YlV4UK0Ns+x6vWW4pQb1PxiOCgj3UfN2LH3YTukO/FXGZ0bD92QPr48/UUmJ6Hq0RH
         zOBse55MvGDNU/iAqK3YB3o2rytTM0FQ2tJXc6eB3ckMwiPoKuu9AHg3qS/oOfmzm9vE
         KxUd7vQJ5i7LTHUBD1no49qrotXEgHqW9WzeimmlwRzfazm/Jo3Ywvw7lF33T/ClGrLQ
         lHvUjBP01T+yUrQH6obD0TfVR04vypt3/fmUnOVElDqWhm2y4zjsu5X+HhJ5e7El1vrV
         EYws6boRBqVOiWDRP7AKJjEAfRZ/WjfVfZMU7oYmw8C/b8kHsvKekeWsbp15264WBQHN
         6wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982498; x=1723587298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpwrGsGSvnHFdGVf1tlm4Wyo1L4IUT4bE3I4p9OVTOM=;
        b=vw0OFMMRGDIbsAn8UlOOaqKQsURfGj1DUFKb8qK/1amOtIOiHdCJ4zGJtQadTNvC+z
         xFVNbFWlfBCE28jgv2HQcT3LNQwB2NOlGcgwJ27nrlhoTPiQHG2w+hQLtxdZysgibhTb
         dXcNxZMenA5NIaA/vJ+cH4saLXaB89I1X5qR1oYpGzW088yBZwMRGYAql+4pdQ6K/1QL
         R1lgij7QWwxLRh19JgPNS84cSNkrrxOQWn6uPZcOizEWbFEcD6bglHOL7Gre4XuOFjC1
         +E2roMuZFSP1eG42RJXtUKvgtf+BZEenJQgqzmzq/a8kaqJwJzohit60cEP54o4g6uf+
         DeDw==
X-Forwarded-Encrypted: i=1; AJvYcCUBAef/3q/AImJxoMqiqfTEJJPMe4IgeA7ZW1PJwrzpEOXtid/TCRdoopYh5bZoSk+u0Pc14TihffNsxtYIhP2t0eNGXM8J+rjhPvjB
X-Gm-Message-State: AOJu0Yx94bdvhVcIeGDII8vCKi4/ccm9ZRwfeCTjSYO8APebR31ewQMe
	VvVgp6Fe4/YsovfIURI4zl40gY4glTl9LwjbWaVIXL6GZvkEwYv5hY2AohjpXUc=
X-Google-Smtp-Source: AGHT+IGvHhFLKBv+CzG3kEzbceETNjAkvAWmYHLIEUsuY6FkehJnB//a5YH4EciwSMoOH9WpYcIhcQ==
X-Received: by 2002:a05:6214:5990:b0:6b0:86f9:64ad with SMTP id 6a1803df08f44-6bb98493eb3mr259732626d6.52.1722982497815;
        Tue, 06 Aug 2024 15:14:57 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c8778e1sm50584506d6.128.2024.08.06.15.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:14:57 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alexghiti@rivosinc.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	arnd@arndb.de,
	bhe@redhat.com,
	bjorn@rivosinc.com,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	chenhuacai@kernel.org,
	chenjiahao16@huawei.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	dawei.li@shingroup.cn,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	kent.overstreet@linux.dev,
	kernel@xen0n.name,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev,
	luto@kernel.org,
	maobibo@loongson.cn,
	mark.rutland@arm.com,
	mcgrof@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	muchun.song@linux.dev,
	namcao@linutronix.de,
	naveen@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	palmer@dabbelt.com,
	pasha.tatashin@soleen.com,
	paul.walmsley@sifive.com,
	peterz@infradead.org,
	philmd@linaro.org,
	rdunlap@infradead.org,
	rientjes@google.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	souravpanda@google.com,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	tzimmermann@suse.de,
	will@kernel.org,
	x86@kernel.org
Subject: [PATCH 1/2] mm: update the memmap stat before page is freed
Date: Tue,  6 Aug 2024 22:14:53 +0000
Message-ID: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
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


