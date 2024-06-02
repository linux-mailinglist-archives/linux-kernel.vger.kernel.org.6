Return-Path: <linux-kernel+bounces-198060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C378A8D72EF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 02:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FF71C209E9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AE4EC7;
	Sun,  2 Jun 2024 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8B/HwKw"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A47FB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717289124; cv=none; b=TCI4+VnKlZq8dGHpsPkswLL6L6HRo8/qnZDL5dADhhv8Z6efefMUKSIzeTV7BLNDtBVcxRkTy6mYfgO18GG9n8+Nz2pMPLiF1oD4x4iou/pZDEC1ZiVu1S00kTip+7LcZ4kuQlq/ffFPXcXMRaozMtqRSyzcGTUbc21x8f8ENCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717289124; c=relaxed/simple;
	bh=yrwRMRjKMXjWPeaY75V1F17sHboGD5oEvhOLg9yUDBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RehrBBgcy7XUJNGrPRmUrIiBkV5wGS1+ADB/Emwi71cTCrxmuMRDd6MXB+XgBpD/KvENHK+sRee0xnKq2sNEywApdPM1ctIWokbryYk03zyhnS00r2eM1d+J/dCgGhagpHNiQw4ZbE8/8zaOxHpq3MC7XAei5LDh+dMPv8bm6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8B/HwKw; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b9f9e7176eso1522107eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 17:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717289121; x=1717893921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ny3ufmHx1+bPqTe/RqTA9t4s0xhOCgE7MQam6lSXckQ=;
        b=b8B/HwKwdq7BqDWiFytGhyx4F5SURSuBn0ksV8O7r6K/4A/HRKKM7gwC55dnlZw2LZ
         cvGBcc6a1oZfVJThw04bGf9QshER/qHq4tVThWWdgd2p0fjow1/7qz6ukzK1qou0J+99
         APAGGfsVDVqMaWFU715pU9cOyG5AbKgb9KTNOc8aXcXNDOa6G8Vu7YZ7FZne5Ai0ub2N
         6Bb5F6CyS1Povp4q1ViwsaTDVPgaShNV+5OGbPAVS8EMLsco9XP5yFZsXa+6QSWzp91C
         TZHAj073GBfo63Loy/3WKQEKUw3OIBJE/MykK5kqy7cExFwJHA2DHvm4P/c7cbB6t6bw
         TVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717289121; x=1717893921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny3ufmHx1+bPqTe/RqTA9t4s0xhOCgE7MQam6lSXckQ=;
        b=tgQsJmEAZxHIGY65Eq+1YyIWAZdI4eDPZcWOD4oLN1/g/NfZLoRccBNVsqH/EHCHcp
         tTI+irfd+iINLMO5M9WpiQa0Uy1xv9w5Y6zm3PHHQ4a8MDGddGPMKC+mMGVkLI3wcFqU
         NKThpXdsa9xQmIBkFKOCIOhshmMFl3u3MZXmBRqGUv6K2sd1jVn39Y0DDywcOkdpml6/
         /l0EpBeYBmuSN2KpzMlPjhZBANaI1ULsEZnW0dCGqUCWZdUR8wyJpyvLmxhww7U/Jdwb
         LQ3oIHrXwgoUJ5VF9yLbfXXh26z8rxVLz7ig2KV1bBKSQmf70VGUfX2RYl3tEfiFsnJw
         1FYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+WCzd0QEAg3I2Mtd9Sldxh2o+ALonW0sOJA4ERfVzGC33ruluRBV8aQKUECjR3oo6rk98LL+smyMK7uzVu1StnOlQnyFbZXrdXvWU
X-Gm-Message-State: AOJu0Yxs2kfMjDM6QR5cyozC5Fx9EX3k1PVzbCzS9Sq+Ob+gGUCwqXQr
	pk+uz3v1gZSRNLce8V0XD+KcMaERslFSZP0v8SLR9VbRvSObCrvf
X-Google-Smtp-Source: AGHT+IHh1cIQ7orF2jvAI+3PDDIW+Q+O5ga+7R2QrzrMB6FWHK2QCyt/0bb6GGjNhBejybR7NX1Nkg==
X-Received: by 2002:a05:6358:44e:b0:199:2a86:126b with SMTP id e5c5f4694b2df-19b48d7cf3cmr578625155d.8.1717289121340;
        Sat, 01 Jun 2024 17:45:21 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a9ae60b8sm5308820a91.30.2024.06.01.17.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 17:45:20 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	minchan@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org
Subject: [PATCH v2] mm: swap: reuse exclusive folio directly instead of wp page faults
Date: Sun,  2 Jun 2024 12:45:02 +1200
Message-Id: <20240602004502.26895-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

After swapping out, we perform a swap-in operation. If we first read
and then write, we encounter a major fault in do_swap_page for reading,
along with additional minor faults in do_wp_page for writing. However,
the latter appears to be unnecessary and inefficient. Instead, we can
directly reuse in do_swap_page and completely eliminate the need for
do_wp_page.

This patch achieves that optimization specifically for exclusive folios.
The following microbenchmark demonstrates the significant reduction in
minor faults.

 #define DATA_SIZE (2UL * 1024 * 1024)
 #define PAGE_SIZE (4UL * 1024)

 static void *read_write_data(char *addr)
 {
         char tmp;

         for (int i = 0; i < DATA_SIZE; i += PAGE_SIZE) {
                 tmp = *(volatile char *)(addr + i);
                 *(volatile char *)(addr + i) = tmp;
         }
 }

 int main(int argc, char **argv)
 {
         struct rusage ru;

         char *addr = mmap(NULL, DATA_SIZE, PROT_READ | PROT_WRITE,
                         MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
         memset(addr, 0x11, DATA_SIZE);

         do {
                 long old_ru_minflt, old_ru_majflt;
                 long new_ru_minflt, new_ru_majflt;

                 madvise(addr, DATA_SIZE, MADV_PAGEOUT);

                 getrusage(RUSAGE_SELF, &ru);
                 old_ru_minflt = ru.ru_minflt;
                 old_ru_majflt = ru.ru_majflt;

                 read_write_data(addr);
                 getrusage(RUSAGE_SELF, &ru);
                 new_ru_minflt = ru.ru_minflt;
                 new_ru_majflt = ru.ru_majflt;

                 printf("minor faults:%ld major faults:%ld\n",
                         new_ru_minflt - old_ru_minflt,
                         new_ru_majflt - old_ru_majflt);
         } while(0);

         return 0;
 }

w/o patch,
/ # ~/a.out
minor faults:512 major faults:512

w/ patch,
/ # ~/a.out
minor faults:0 major faults:512

Minor faults decrease to 0!

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2:
 * don't set the dirty flag for read fault, per David;
 * make write-protect of uffd_wp clear and remove confusion(
   it used to be "wrprotected->writable->wrprotected"), per
   David;
 Thank you for reviewing, David.

 -v1:
 https://lore.kernel.org/linux-mm/20240531104819.140218-1-21cnbao@gmail.com/

 mm/memory.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index eef4e482c0c2..9696c7397b85 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4316,6 +4316,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
 	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
 	pte = mk_pte(page, vma->vm_page_prot);
+	if (pte_swp_soft_dirty(vmf->orig_pte))
+		pte = pte_mksoft_dirty(pte);
+	if (pte_swp_uffd_wp(vmf->orig_pte))
+		pte = pte_mkuffd_wp(pte);
 
 	/*
 	 * Same logic as in do_wp_page(); however, optimize for pages that are
@@ -4325,18 +4329,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	if (!folio_test_ksm(folio) &&
 	    (exclusive || folio_ref_count(folio) == 1)) {
-		if (vmf->flags & FAULT_FLAG_WRITE) {
-			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
-			vmf->flags &= ~FAULT_FLAG_WRITE;
+		if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
+		    !vma_soft_dirty_enabled(vma)) {
+			pte = pte_mkwrite(pte, vma);
+			if (vmf->flags & FAULT_FLAG_WRITE) {
+				pte = pte_mkdirty(pte);
+				vmf->flags &= ~FAULT_FLAG_WRITE;
+			}
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
 	folio_ref_add(folio, nr_pages - 1);
 	flush_icache_pages(vma, page, nr_pages);
-	if (pte_swp_soft_dirty(vmf->orig_pte))
-		pte = pte_mksoft_dirty(pte);
-	if (pte_swp_uffd_wp(vmf->orig_pte))
-		pte = pte_mkuffd_wp(pte);
 	vmf->orig_pte = pte_advance_pfn(pte, page_idx);
 
 	/* ksm created a completely new copy */
-- 
2.34.1


