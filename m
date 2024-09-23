Return-Path: <linux-kernel+bounces-336398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8D8983A27
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BADD1F2244B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365513664E;
	Mon, 23 Sep 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmR1x1FS"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC693126F0A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133107; cv=none; b=W3jGKMq9KiVYqU+Is0eCov5DnGfzkWYBo6AlZqd5ybwLovK04WCSpfgawC/2Lbl9OQrGdHauNuewWzYUn3qOZsgnk+L7twESRsGVSBVVa9E4CP5nl/SotZPpw5q1jyj9TadGTF9/kZitXHcuxgJ5SEk8c3BAhf+yUSZrCcALfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133107; c=relaxed/simple;
	bh=KTBAr4CcuZCVEhcseNZsFXERaSMNaJ/qGDbL/SOJQQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWgEL821QNFRt9EDv/j/Kr3G9/a0dDbiZQguQh4H8ySQhVLrdkC1+DTqt7Vx/OgDrF6tvdi1amqnTh9ODUE40bR/0xAB9qQX8HxAMk0OKuxpLnn0ILbRU0EmXxap0NpreTxRkrMEkEdztYMdf5xwUkcI7rG4c0TiNhuZ6rNJWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmR1x1FS; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e201f6eda9fso4396060276.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727133105; x=1727737905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gPbe3KNGXZnnS8+FFZzqNPtSCfvfbRnB6uu/A9bSpc=;
        b=EmR1x1FSx+PX6RImQE2nH2khiMcH77FpT/NLpqGmi3ZuTg4FQFseEMT04gIim8LcYw
         zvKiSmusRZfzDNr2kcnYI+zY4BdAhqgInR7UiWzGfeh4Pjn7X633ZXb/UhTBpH5rcjkr
         yIP8JuyW7v8ep85wmwbV7blboBfPc17ybG9HUAuDWLx7hrTn+OZJ4xwqrVIqBNP4J3f3
         oMO+DDDfq/JHJRMxTOxOk5h2+dEzFVpZ1Ji2cZ9VBexXud8XPVChMD72ni6+7xiolpkd
         Qk1y34eFkIub0uMKf94woYcnPMllGt1N2JIShWsKQp28HwXD4891P9HSwaaek1TWCnGK
         69NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727133105; x=1727737905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gPbe3KNGXZnnS8+FFZzqNPtSCfvfbRnB6uu/A9bSpc=;
        b=ae6zw6yyPz6lgI124e03nKnRLNRnRSwRzNO8uOgwLetqqE64DUPddsQeG+SGrQbzoD
         Ej6+dr1SbspQXHF7kPkehqzkB/oPfRL8WG2poifyuZHS/iDsyERUrdb2ywTEtHEc24Na
         XlZmXYPCr1AmlTJoCxV7FSeEGbc6X++c3xGUqWssqwa44K3+WRlxHwld1R715JCvE12E
         7fTgIZcyf7m2FAH8g6396U6k8F9u0WfVR819WCpbIl2mCLBXaP5MYSabSCv6l0WbNQXN
         NvgORbr15GDj7h4UMVwqz54ZKnyYzqzRoGFHOu8qGRNDcafxPHNSjQvuZZ9SpDRFsHYE
         5AiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBHchPSRmK9LD/DJBt+5dkcpk/D+byYmxk5aichsP3/0UvB4NM70nrex+7crGC3QG4i+15VQp9xhTh+HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/q5RfA58EAZfqGA8Dn3znyk15SGgtYGGxN+XAj5MdG8eMIUwD
	PxxztKSMJVG/6bwfBfH1MsXGnrrV+M2WztgC0v0Bht1I0gwH1nHz
X-Google-Smtp-Source: AGHT+IFlyb1PljXDzq/V7UeC9hqJSsT1MOj/S9VfhqqJ+Q0LEEGkENMIw9m5hji2q2AQZgaGNfV2PQ==
X-Received: by 2002:a05:6902:102e:b0:e1d:436c:3b4f with SMTP id 3f1490d57ef6-e2250cc504cmr10944928276.50.1727133104733;
        Mon, 23 Sep 2024 16:11:44 -0700 (PDT)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d15d44esm555897b3.100.2024.09.23.16.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 16:11:44 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	hughd@google.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] swap: shmem: remove SWAP_MAP_SHMEM
Date: Mon, 23 Sep 2024 16:11:42 -0700
Message-ID: <20240923231142.4155415-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240923231142.4155415-1-nphamcs@gmail.com>
References: <20240923231142.4155415-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SWAP_MAP_SHMEM state was introduced in the commit aaa468653b4a
("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if a swap entry
belongs to shmem during swapoff.

However, swapoff has since been rewritten in the commit b56a2d8af914
("mm: rid swapoff of quadratic complexity"). Now having swap count ==
SWAP_MAP_SHMEM value is basically the same as having swap count == 1,
and swap_shmem_alloc() behaves analogously to swap_duplicate().

Remove this state and the associated helper to simplify the state
machine (both mentally and in terms of actual code). We will also have
an extra state/special value that can be repurposed (for swap entries
that never gets re-duplicated).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  6 ------
 mm/shmem.c           |  2 +-
 mm/swapfile.c        | 15 ---------------
 3 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e6ab234be7be..017f3c03ff7a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -232,7 +232,6 @@ enum {
 /* Special value in first swap_map */
 #define SWAP_MAP_MAX	0x3e	/* Max count */
 #define SWAP_MAP_BAD	0x3f	/* Note page is bad */
-#define SWAP_MAP_SHMEM	0xbf	/* Owned by shmem/tmpfs */
 
 /* Special value in each swap_map continuation */
 #define SWAP_CONT_MAX	0x7f	/* Max count */
@@ -482,7 +481,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
 extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t, int);
 extern int swap_duplicate_nr(swp_entry_t, int);
 extern int swapcache_prepare(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
@@ -549,10 +547,6 @@ static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
-{
-}
-
 static inline int swap_duplicate_nr(swp_entry_t swp, int nr)
 {
 	return 0;
diff --git a/mm/shmem.c b/mm/shmem.c
index 361affdf3990..1875f2521dc6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1559,7 +1559,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
 			NULL) == 0) {
 		shmem_recalc_inode(inode, 0, nr_pages);
-		swap_shmem_alloc(swap, nr_pages);
+		swap_duplicate_nr(swap, nr_pages);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(swap));
 
 		mutex_unlock(&shmem_swaplist_mutex);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 47a2cd5f590d..cebc244ee60f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1381,12 +1381,6 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
 	if (usage == SWAP_HAS_CACHE) {
 		VM_BUG_ON(!has_cache);
 		has_cache = 0;
-	} else if (count == SWAP_MAP_SHMEM) {
-		/*
-		 * Or we could insist on shmem.c using a special
-		 * swap_shmem_free() and free_shmem_swap_and_cache()...
-		 */
-		count = 0;
 	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
 		if (count == COUNT_CONTINUED) {
 			if (swap_count_continued(si, offset, count))
@@ -3686,15 +3680,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	return err;
 }
 
-/*
- * Help swapoff by noting that swap entry belongs to shmem/tmpfs
- * (in which case its reference count is never incremented).
- */
-void swap_shmem_alloc(swp_entry_t entry, int nr)
-{
-	__swap_duplicate(entry, SWAP_MAP_SHMEM, nr);
-}
-
 /**
  * swap_duplicate_nr() - Increase reference count of nr contiguous swap entries
  *                       by 1.
-- 
2.43.5

