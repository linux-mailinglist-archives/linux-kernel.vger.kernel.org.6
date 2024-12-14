Return-Path: <linux-kernel+bounces-445940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E23D9F1DB0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952A31687E9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD318FC79;
	Sat, 14 Dec 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H2zFPTmS"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1818E379
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167073; cv=none; b=jQ84mp0trSlZcnpx2U0CMSl15qZg1zS8hEbLuSwSTh05rdmc+4LIYAh5t0H1ggY7WVtvXFpNm/QJd9T/cW1FHBqB7iSo53TvEXRTxW/V7a0J92MTeNMyDqAM16aGRqYtKKMDA61SPEHqVgELbpWbY8LkxPev4wjpbdG6Nrty1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167073; c=relaxed/simple;
	bh=2rLUjE/bBcdnW4BziWlyu8gvQ7w1P03MQD9OH0V2m1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OB/cM9HBqJA010JUAJDjcSrRnBel536nv/rWAW2iGgqT36GjpjdETinWhlM3erpxeVSee89IKxuUPiMtYEthiVbep80RIw41Um3cLqn6NOs1aDXlOi2WkJeudtfCx/4oYtHjsymY3YBKK9zWklj7GvfIbRIekVIMpQhsa+0IgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H2zFPTmS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728e1799d95so3058970b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167072; x=1734771872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12IiSMzMVIlfwdGc3SnaXSwRS1fKZAvHGusKFMV1b3k=;
        b=H2zFPTmSl4MeudeJgucox0hf3rswkD6kdoVvT4ke0Nbghtgbujsb54Ieyy5bPn2ri7
         obes7A86jaS0dEn4RdD/MXrTtJdngzLxbklSqzY0GL6eYNcKD6E5489GQNZBN+P/FsFq
         WGClcmiBgFCDdlIxMiYm80DbDPvUaVMe9vdzHD5mRuA8Sbha8Jrbmjjh+3ugM8o1hDX0
         oKf7J5hN3ZA0pcQgDzTvoBXIE539xdU3L/KHs6zK7e05b/0lckgd6IYDHYz89DFDDpt8
         sjg1wP9meux4twRIScQcxXCLm7CqeQ6cl8Qlt+gIqcFAJl39DMAOcOyQeJZmMEghqaaW
         czkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167072; x=1734771872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12IiSMzMVIlfwdGc3SnaXSwRS1fKZAvHGusKFMV1b3k=;
        b=OB2KJC0Z9LYPduQShES5WKnBD79238srwrF1jyfBMF7tTNT6N8rXab4dAGg9XzlSa7
         OmzdbtFj0gpuUkErFNigScp2e0QMkp/lPfvhm3aCnpuVMhlPxamNCMiPaVDh3cHy7yod
         OaUAbC5ikXcUBZhDkpE6hl5yZpzZY9gJq8FRB7s3twIec8Dx+PDhVNSLaQIwKn7VbRnY
         uYUZ6QrU0tlM9gzvpTVIxhFjXr4/dq+39Iv0SkM44gpG0EbxfxSeebMgki+IDd6mqlRt
         7D2J6OQeNmSgRydblvjt1T2ReXUTJTY9TiubmPk3E6OX2BghGbqYaSt6BRzHCu/MtTmQ
         C6dA==
X-Forwarded-Encrypted: i=1; AJvYcCUY2+9NCdDodBnsrZ32ARoyfElBCa1qJXo0znNJv6WFlosJXjt2cb5Oy5tOTG/8+UTjI3gedhkM3w3/jAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHk9io5PZwCL0cX/HwAqSBHfMM0HALHhyXdeFUTikeWiLs/e6e
	x8R48o4L56dw7T53Ih0gen9nJWEWa+TzGeyOJ3QxDwoBxfqES+qOk0YkgXDNmUk=
X-Gm-Gg: ASbGncvu97MDeryXvDeVDaZvDgL2PZbALlIVO0TBAVYapf7MJMcrwluHByzWxgHN7Kt
	LxKAq4OdWemalJd6ZS2Nvudi3H54OHuAiSGz/wlMU0kRd9rd/SnlNrBfIk978G7ehrz9KzzwpP6
	XUQI/03BF6K+8c82LaE0XYKIa2zM+gB8M71mPqmL250GetowJLpaydZzaqAR+Ypr354c6XcjYHZ
	qYVcD7d7ugbrVTUwTJ4qSkrp13mqQVVfValFMv3JfAS2fwXE+4uA2xM09cTi6fcfcSuW4xqzgVQ
	Z4dFDmKdvnFer53I0klnNp7mva9eMQ==
X-Google-Smtp-Source: AGHT+IFvnXDbPrP66UsHi9s8CFtvVszYyEfjge+aAOFm/P/L2638kVYMzofXCSp9Xlrusy3CzYMSYA==
X-Received: by 2002:a05:6a21:33a0:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1dfd55614mr8533024637.17.1734167071820;
        Sat, 14 Dec 2024 01:04:31 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:04:31 -0800 (PST)
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
Subject: [PATCH 06/12] arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Sat, 14 Dec 2024 17:02:52 +0800
Message-Id: <59fd7e0364e8dd293132d81b91b28694e70263e2.1734164094.git.zhengqi.arch@bytedance.com>
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
 arch/arm/include/asm/tlb.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ef79bf1e8563f..264ab635e807a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -26,12 +26,14 @@
 
 #else /* !CONFIG_MMU */
 
-#include <linux/swap.h>
 #include <asm/tlbflush.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #include <asm-generic/tlb.h>
@@ -41,8 +43,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
@@ -61,7 +61,6 @@ __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 #ifdef CONFIG_ARM_LPAE
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
-- 
2.20.1


