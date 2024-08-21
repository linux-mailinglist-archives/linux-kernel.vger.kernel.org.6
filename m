Return-Path: <linux-kernel+bounces-295120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C849596FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F49C284254
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C258A1CBE81;
	Wed, 21 Aug 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FFtR0xWj"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A031B1D6E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228463; cv=none; b=XvJV9SKqbkOZlgcFkk6Qwsq1shHNZcxhUE7B+lWh//ndKWNodUqNK4YVfaw97PwRp4b9oLt/WDdycnJaLvMb+I2un1Z1/ywFqEKX7wZMEoV/iy1Wl4+mVswoFwGjyf3FNNfKwB1A8j9+s5VonQTgDtjznofmLbbgZ3Hc6OlnLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228463; c=relaxed/simple;
	bh=rHqDHFrF26/hCS+KcrGpklG8aSJcd2dafPbIgZSe4as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAmLVVbcVg3U1WPhXQ1x79LPRGk1SC2EJMNW6tr9NG8VijNAQCjXdMy7w8e6c+Ut7rB4HC9HrJkxyk5nBFvl5a7qzIrOUE8knbVfQMietLTq1s1dFvkKwgC/8cicHA/nSJ1ndBoZ7qzideCBHm0SGumDH4wo2WzPZyWJ+N5pcZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FFtR0xWj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso4879454a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228461; x=1724833261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nMMKQBovMbpHaGn8Lvg/undANxxFw84odzUdkp5IAc=;
        b=FFtR0xWjW0Ff9PeIQ1vFAx8Xjor5qGWkGdw8ur89bD5vRjYHB/jHnTHHWO8GPG5TLn
         rX6X5Konib859FnurKYzsteqFM3hbkCJIXzq9ElNMzsCBMNhpXu/LDZcu9zCGOHsizT5
         X//YL+mEs1patQZIz+/njGORUSLTe23tlqOzzLtFapYUqQ/hT2vJXnd6bydUPzpIDyTb
         yb/XceEvIRRaXrrBTAumavxQ8PGROiwMUCqfOLa+S75G//fXR9h8U5xZl3pouJh6jeMg
         jAFgDHNLxFwXe5NkwUc4W3B1/XRUDCHWmKPZ5ZwMJCzaXkBS2O9uDcV385WhoDVXxGvT
         3dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228461; x=1724833261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nMMKQBovMbpHaGn8Lvg/undANxxFw84odzUdkp5IAc=;
        b=FUa8FN3en7r3LpHuRW8D27/e+NLTINNeZoVGt7Phl7FF1tcVq67jVO0nB02yUUqXlb
         Le6Pfdnd/IcymXQnoS+w+G1QLWS8/yCsM7PGU49DAT2YsZ/kJkR6dhCxpKPprt36UGak
         m87VPN887vcgZP8iWs2i13e6qwd224BQsFnpSVJRkMnpyExQqwV77OucIFiUO9vTo+l5
         mEG776N7qyP58qb1bavozpacJnHDyo1GJg/OppdG3LD1vpYkQUNqB7Xqu+HueX5YzCEK
         ZT0Tq0n4K/1SPhAfyeUtdOKfrRqA6MwJgBd6RZaEVW8f9ihUczenMlmDDRHKvUM1tep3
         pw0A==
X-Gm-Message-State: AOJu0YyhgNzd0u6YQnF1wLie1iVt/gYykz8Thu5tvf0URR/E9AbavzH7
	6UjiIBosPgVEFjPayF2xznuwiMyyx/I+ld5AvgZ8PRQeOKicCq34YVQO8/TEBdYG9f2fVaLwO0o
	W
X-Google-Smtp-Source: AGHT+IGVCW7LuSOfGhGGSqonUfZfQEf1Y51LpMxCXHDPBrQX3ltYUdmnoycYhvy3ErzvacrcFVYd1w==
X-Received: by 2002:a17:90b:3851:b0:2d3:d239:24c2 with SMTP id 98e67ed59e1d1-2d5e9b99f57mr1469884a91.19.1724228461120;
        Wed, 21 Aug 2024 01:21:01 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:21:00 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 14/14] mm: khugepaged: retract_page_tables() use pte_offset_map_maywrite_nolock()
Date: Wed, 21 Aug 2024 16:18:57 +0800
Message-Id: <c72aab4401c890a2b348eae119ec395e30a2f805.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In retract_page_tables(), we may modify the pmd entry after acquiring the
pml and ptl, so we should also check whether the pmd entry is stable.
Using pte_offset_map_maywrite_nolock() + pmd_same() to do it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8fcad0b368a08..821c840b5b593 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1721,6 +1721,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		spinlock_t *pml;
 		spinlock_t *ptl;
 		bool skipped_uffd = false;
+		pte_t *pte;
 
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
@@ -1756,11 +1757,25 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 					addr, addr + HPAGE_PMD_SIZE);
 		mmu_notifier_invalidate_range_start(&range);
 
+		pte = pte_offset_map_maywrite_nolock(mm, pmd, addr, &pgt_pmd, &ptl);
+		if (!pte) {
+			mmu_notifier_invalidate_range_end(&range);
+			continue;
+		}
+
 		pml = pmd_lock(mm, pmd);
-		ptl = pte_lockptr(mm, pmd);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+		if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			pte_unmap_unlock(pte, ptl);
+			if (ptl != pml)
+				spin_unlock(pml);
+			mmu_notifier_invalidate_range_end(&range);
+			continue;
+		}
+		pte_unmap(pte);
+
 		/*
 		 * Huge page lock is still held, so normally the page table
 		 * must remain empty; and we have already skipped anon_vma
-- 
2.20.1


