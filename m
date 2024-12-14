Return-Path: <linux-kernel+bounces-445941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE469F1DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288E7188BD37
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055CC187FFA;
	Sat, 14 Dec 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Axd3XqYA"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973942A92
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167086; cv=none; b=n4zWft1itGKr6+l6X/KN0GGG5igWmLZDsUmMTP3EqpXEQ/FiaO8A2oylHCwcYI5eDxAhGHyNE6W+smLavoPfVsCEt+8wBkDqGPaMoaDTcUdgcw9/udji97+ngXvjqmr/qbD8awLnnf5sjmU/Fbg6od7nzyIGMWNGVxkFao/bDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167086; c=relaxed/simple;
	bh=RtrI2tlYyIdcBio787YKVgk1cTNToRPh2j3uJiZRdZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtVlCXFqJMH6JCc50P92KDEVJvQKMYOihWcdntn+tFH4mckGu3q3ccuxU22XeoB637YzdzXKH5arEabQ9T0d8eyeV1IZyiilHF32qI/jWLz9cd/iGCr9BYMXNFW4zQTeqO2wsesDa+UreW4ZYBJTL1uDR/VEALJaagDV/LQpq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Axd3XqYA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b1f05caso24307105ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167081; x=1734771881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CB+suh8vMLKY78fggEtIk5gD9ivloFZvOHbrupXaAs=;
        b=Axd3XqYAMnwF827qRBo2Tl5EWXfoB0OI6Zp3tE3Ewo39i7y9aZw+dFB9ysDK/ZkCzl
         fZ0ZBVPNDLFjtbHSsB2r8ebKjw9HqZ56ZDhu5ypNLaT6dht5EwOzU482TZ71djBF7BlX
         a8GC2sFiYq4Z6iMwhWWCM0sXm1SXT1s6v7vp4AzMWQuGPXCMzim2LasCywRZvK9Xrz++
         arPH9F7gwkjTM2lrdviUePW8YZ8IHLmd8Fm7qYNnTKyPjVcBakIVxdeYXhb+3Znmqn5X
         PCr56Dr6UcLeeoALdWwy5xagnC+RUZ9en0nVyvom1QTvOi2Np4ymglNyB78suR3ptM01
         pjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167081; x=1734771881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CB+suh8vMLKY78fggEtIk5gD9ivloFZvOHbrupXaAs=;
        b=NCQYm1QdspBhjSqId2t+ShKdagLfJAKwGKD2CLGNiXpdw6chWp553PMdUELGIEZfg6
         sIpW/HN3dFznR+4Lp8ve13nGQnW0SXlfmgzlSM25YrOxnLKwX8WXWRh9e0ujcrOb/EqR
         59BTHbE32QP1091G8YMlkxSU0vAPo6i0pIYpY3q6M2SBAnpJHd2ZuRPypcoY4cpO5qox
         kqEPZrbwARhqzEbX26IVdel+exfAfhtwImXe/qptIb/23xIDctShiY9uKy7Mot+gN8bH
         4iF3d4HgG+SxKLdWICvUqhzsHuCQJkAoCuTpsiC5WixLO+Oucqm+GOJTpbafote55kcP
         IhRg==
X-Forwarded-Encrypted: i=1; AJvYcCUHQa35tnys64sLyQyJGMhrBF762uBSR+ZztVyhRWH5qsS3a348ZyE7/iwhlEKANDDldPOJObbDHiNpzUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw963yBo1/wwaAa7NiyrlWkSqKxUYQzTaGph9aImFNjffO+34JQ
	liKhMx+y4byRSRa5f0OHqg+z2YYhjSYWZBnL9u3nn0FhfDLFKkXAIXZHH7Y08/Y=
X-Gm-Gg: ASbGncs+dzWoX2ItoOJzfbN+xWp89++GoJsV664vct0PlG7DoXxlAqocLX0ogAXyT/L
	p29J5Q/xlha+3VwhguoY29uFAl5QmUI43OVAOwmqHJ7sXDiEoKWosMGjteXigDyCTeSvoYMW+S9
	aZaw2P30vDDYB7X4IemBmPWdquKgMzpDiulkqZP/7UALZaJNrEuyW8qP8+WbCi0J+o32b4a2GbJ
	HhsZt6QvuulpwsqctLs/Gp6k4oolKneEjIpoQyYbHHcb4XBJC6QY5GRd784gTv4fpBYGqk89G2+
	l7kupSjrQtceHSXkGgqqehMXIPREDg==
X-Google-Smtp-Source: AGHT+IE0QPwbAOQZHxlo/n3+wbqMrZuKXsuKTSsN4acRfuabgW+JUZvSc3827znPlMKVF1C6eV/6aw==
X-Received: by 2002:a17:902:dac6:b0:215:8847:435c with SMTP id d9443c01a7336-21892982123mr70599045ad.12.1734167081724;
        Sat, 14 Dec 2024 01:04:41 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:04:40 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/12] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Sat, 14 Dec 2024 17:02:53 +0800
Message-Id: <1781d3bab60aade7d64fbeb6682b9e73bd673d3c.1734164094.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734164094.git.zhengqi.arch@bytedance.com>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/tlb.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 408d0f36a8a8f..93591a80b5bfb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -9,11 +9,13 @@
 #define __ASM_TLB_H
 
 #include <linux/pagemap.h>
-#include <linux/swap.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #define tlb_flush tlb_flush
@@ -82,7 +84,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
@@ -92,7 +93,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -106,7 +106,6 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 	if (!pgtable_l4_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -120,7 +119,6 @@ static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
 	if (!pgtable_l5_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
-- 
2.20.1


