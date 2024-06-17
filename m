Return-Path: <linux-kernel+bounces-218427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789CA90BFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB41C22AED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116919A29A;
	Mon, 17 Jun 2024 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbzbfyED"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB119ADAC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665929; cv=none; b=E+pMdKwdUID8YHvu3GrQYUqgnCM6vEJbwuPylC28K9luGEOHyNV6Mf49JL1JMnyCbCH8HtoDx/GqM0BOISTyAx0PFoOAiCMmYtjIkuRIfiD1MKH23agwOxQG8cU/pTLMBRTNFm4ofV8NjbSMnNeIcP30tXbEQ3MIw43TwU8SP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665929; c=relaxed/simple;
	bh=tw5n1+6ZqfKCPk9PrTP4UXUDk/aoPt20oVvsxNWyPlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbzKoFFu09yJRfcbcKCHaOA5cR4duY/KVgLq1U3dHJtovpOFMBwMkSWJ/cFCCd91ASiQJcN+HB6nm86LSIrqL0UXi8y7x0mOJgp0bp6c1sHSFhxqvunHKYhYieAJe+nRVDr9GuWgWMGNGeybA7+04vcWw4UtDMgrioS6wWHzr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbzbfyED; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f862f7c7edso30601975ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718665927; x=1719270727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnwDyt6wGwOClIOvqiBxhppNdg8blfjOHv9/ogWAFm0=;
        b=IbzbfyED3CBCQEjkqNc47CEYcLgH1izLIpzh7nupduvrWDDVd0BxecAvJSM9cxu0Al
         Cbd5r30W/yhEMNC07xh/vIBI/N6/XfSf7m/9PafecZgy+jHKtRMcNhXCmS16WoXO35MZ
         wzEy1wulODkFCw4N8K8cqV9JQPdXXp/zgHxls0GkagvrRM47oRg1cNMKjm+0PTfyhEHA
         /bxhV7R4baZus0RnLZbKvyE8HcJzC50ywR9LxrEje4cmun4TEvT8oL0Sz33cr6qZ+vCs
         stlOUNlFd4K7SuykSyx4iBvkbfsAx13R7e7iiY9x/SI3Bigv+fuLfXELD3lLnc6SfOlE
         fNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665927; x=1719270727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnwDyt6wGwOClIOvqiBxhppNdg8blfjOHv9/ogWAFm0=;
        b=HTcMKLgcCrXuPCMBfIkUtVjMxPdbI0E+ViSQt7WZAxdiDN965plX35xf1VtPTu/j02
         OYWCL6tjkOXoUb/yapqOAiSsWAn3cuABv6wp1vrC7JTzOBXels3rPFORJJAsGRF83/yT
         ozQcfH1S6u0EibXDmNs5wFk+2223jXV8OHIV4nO9/LcfD1VjLyYpAUXar1AH9GYPzvWv
         tIrj+98acLbmo7Wudfon+yur58j1P+5wxnuuEzw4FfnrfvbXfqOAkNGURjMlDlVRUu9T
         CzRKuRd/8PaRizhnHjAGNvPKESeYXVHPPBJPFToc/qaOMtFkby7KnV/pgDdHyl0SaEVy
         RRjw==
X-Forwarded-Encrypted: i=1; AJvYcCX795irbcxY5LcfOVVZH6Tt2ckhvH4AkJkB9967+pSxzrhV1tEk0Yh9b+4/q1tKglmroL75df1DatJSrTVqotgDirhlM+qDS/U3QOl5
X-Gm-Message-State: AOJu0YzCusBxvzRKFbjZLcv+cWxM6eqi033ODKoebRnkFvHea8C0+5bW
	W5WboTFksYuOaUDYupQ5YEw6jS3gBW1TUiu3G+pUcDI+Ezv7EHwS
X-Google-Smtp-Source: AGHT+IHq7JHs/BU8iswnoca29J8kwvvCjAMVVEyjUdJyYgosbrLVDRGHuiSVkNgDJ8EmnZbLmCegbw==
X-Received: by 2002:a17:902:c086:b0:1f8:3f13:196a with SMTP id d9443c01a7336-1f8628062b0mr84791845ad.45.1718665927204;
        Mon, 17 Jun 2024 16:12:07 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5a0d5sm84658605ad.43.2024.06.17.16.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:12:06 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	Shuai Yuan <yuanshuai@oppo.com>
Subject: [PATCH v2 2/3] mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==false
Date: Tue, 18 Jun 2024 11:11:36 +1200
Message-Id: <20240617231137.80726-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617231137.80726-1-21cnbao@gmail.com>
References: <20240617231137.80726-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

For the !folio_test_anon(folio) case, we can now invoke folio_add_new_anon_rmap()
with the rmap flags set to either EXCLUSIVE or non-EXCLUSIVE. This action will
suppress the VM_WARN_ON_FOLIO check within __folio_add_anon_rmap() while initiating
the process of bringing up mTHP swapin.

 static __always_inline void __folio_add_anon_rmap(struct folio *folio,
                 struct page *page, int nr_pages, struct vm_area_struct *vma,
                 unsigned long address, rmap_t flags, enum rmap_level level)
 {
         ...
         if (unlikely(!folio_test_anon(folio))) {
                 VM_WARN_ON_FOLIO(folio_test_large(folio) &&
                                  level != RMAP_LEVEL_PMD, folio);
         }
         ...
 }

It also improves the code’s readability. Currently, all new anonymous
folios calling folio_add_anon_rmap_ptes() are order-0. This ensures
that new folios cannot be partially exclusive; they are either entirely
exclusive or entirely shared.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Shuai Yuan <yuanshuai@oppo.com>
---
 mm/memory.c   |  8 ++++++++
 mm/swapfile.c | 13 +++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1f24ecdafe05..620654c13b2f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4339,6 +4339,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(folio != swapcache && swapcache)) {
 		folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
+	} else if (!folio_test_anon(folio)) {
+		/*
+		 * We currently only expect small !anon folios, for which we now
+		 * that they are either fully exclusive or fully shared. If we
+		 * ever get large folios here, we have to be careful.
+		 */
+		VM_WARN_ON_ONCE(folio_test_large(folio));
+		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
 	} else {
 		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
 					rmap_flags);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ae1d2700f6a3..69efa1a57087 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1908,8 +1908,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
 		if (pte_swp_exclusive(old_pte))
 			rmap_flags |= RMAP_EXCLUSIVE;
-
-		folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags);
+		/*
+		 * We currently only expect small !anon folios, for which we now that
+		 * they are either fully exclusive or fully shared. If we ever get
+		 * large folios here, we have to be careful.
+		 */
+		if (!folio_test_anon(folio)) {
+			VM_WARN_ON_ONCE(folio_test_large(folio));
+			folio_add_new_anon_rmap(folio, vma, addr, rmap_flags);
+		} else {
+			folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags);
+		}
 	} else { /* ksm created a completely new copy */
 		folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
-- 
2.34.1


