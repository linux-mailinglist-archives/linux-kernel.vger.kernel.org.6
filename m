Return-Path: <linux-kernel+bounces-296778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BCC95AF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE65A1F26A19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD61885B8;
	Thu, 22 Aug 2024 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IkyPdiXK"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA71885AC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310893; cv=none; b=tSU7yakpW8CRVZLY9QHYjqfhHfiex2w+8KZiY2LsxqyHk0pQojwCdVk6XeizA4bb4almBRVn5STc7g8eVgzYCrHOEBjpfJKpBYCSqC1xBNngos+KkA0xjGE7nlVa7k1E7ilUzMM8+SKZSuUtbgydtjDT76/V+5jiFuzp4v9WXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310893; c=relaxed/simple;
	bh=iOolcBEuZVXthEhfPky/D4p9xkDBHkn1HC+6Bh1rqVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntCMz+EIYj7gZoEsxpBlPxE5kxBNv7pBBHD92FSssNmX+lS7RVJzxrno2XELp8bCmCtSx9yl96+OGZKKoL3OYkgXosd3gSDpCO1lCPrMXa+zhhqLZOBdKsYEbIYL8Gbs4LPWHA6yNNXGtswZchFMK3a4uzPHJ/MQF03kx0EVBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IkyPdiXK; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db14930a1aso293535b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310891; x=1724915691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wvuIpVK8M95P7HYfgMO/FZeMoPfoEIc6BtRbN48KOY=;
        b=IkyPdiXKlhn4kLb2IcnRxmAgjXJ3fkw2EzfdSRp3+e6IeGbEYguSlmi2QS9viGo4S5
         r1ZPd9gF0Dy5xYOhGrI4C2O/ySXiwS7cuJRRRV1Pla7cFJZn5Oomj1WmtDaujRGuaJ5P
         DsXyvEAhlfEDOU7eXApBiK2oEi5WM3xrS9S5y/H2dtAZgazrzRnBiShE+iQyjFt2BvQP
         kTmAOZitgJPAhz15r//1c/z7woJRA6ZMJeqT3CWo9/ackcfHAeBqYH2eAlcF6YqkFSZi
         3sTDYBISHAomxfBGS+c0kDiPBgHoj2tr9Ze/pSw6Blg3bEsFflT6lWXF0J7dBXPclxZ3
         0FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310891; x=1724915691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wvuIpVK8M95P7HYfgMO/FZeMoPfoEIc6BtRbN48KOY=;
        b=N5x4ywR2O58vEvKzZKvWcBPymDvmgOfkWgrWWvZKJ9Br2vQZmwcvqR+Mm2Z+7J2JW9
         2aIID3kH7FCGAsc/M5ekb2nAPNKLJa+1tE28T99TG6Y0d44s7QFQSYCmc9TF13+TwcE+
         md83wz6bq9ZfOwiQ/dCYejXyVesdM6LRth3Nn5CNzhJIXShvuLzlxQDaZUXuJ0nX+XOs
         v5yUW559HYVEiPdiikT9Cc9pOnVtVWfuSmE+BtHkoK5lwtSldXzw74Lh1WAViLCl5JIJ
         iPhUk4dacTA5lpykq7PXIU8clulSRu4f6gIya3r2HNGnN/84DKWiVHGpDG3BS4bcWlKN
         8VHQ==
X-Gm-Message-State: AOJu0YxRF2yGkUXgkocozNSAU3iLeISPIzdqbgm0HnWbwJsUXTn9XGwk
	xXIklsP0pPS7lcdDUnB0LkFm+b0gOcR/B4Zc1kHZOcMeJrTOmaqJcYHDLGjMy+o=
X-Google-Smtp-Source: AGHT+IH3dTXEnimLAtKAfnTveP36n8fQueYjLUMvugh9RpWMjyLI+ldrjyQ+VF2Ub3qToXnGQhbMbg==
X-Received: by 2002:a05:6808:3847:b0:3d6:2b12:7dc0 with SMTP id 5614622812f47-3de22ff6ae0mr1325714b6e.20.1724310890896;
        Thu, 22 Aug 2024 00:14:50 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:50 -0700 (PDT)
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
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 11/14] mm: userfaultfd: move_pages_pte() use pte_offset_map_rw_nolock()
Date: Thu, 22 Aug 2024 15:13:26 +0800
Message-Id: <d4e0c8970662ecc88352822e6d81a11b4dd72b1e.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In move_pages_pte(), we may modify the dst_pte and src_pte after acquiring
the ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
already do the pte_same() check, there is no need to get pmdval to do
pmd_same() check, just pass a dummy variable to it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/userfaultfd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 6ef42d9cd482e..414ee744257b7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1135,7 +1135,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	spinlock_t *src_ptl, *dst_ptl;
 	pte_t *src_pte = NULL;
 	pte_t *dst_pte = NULL;
-
+	pmd_t dummy_pmdval;
 	struct folio *src_folio = NULL;
 	struct anon_vma *src_anon_vma = NULL;
 	struct mmu_notifier_range range;
@@ -1146,7 +1146,14 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				src_addr, src_addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 retry:
-	dst_pte = pte_offset_map_nolock(mm, dst_pmd, dst_addr, &dst_ptl);
+	/*
+	 * Use the maywrite version to indicate that dst_pte will be modified,
+	 * but since we will use pte_same() to detect the change of the pte
+	 * entry, there is no need to get pmdval, so just pass a dummy variable
+	 * to it.
+	 */
+	dst_pte = pte_offset_map_rw_nolock(mm, dst_pmd, dst_addr, &dummy_pmdval,
+					   &dst_ptl);
 
 	/* Retry if a huge pmd materialized from under us */
 	if (unlikely(!dst_pte)) {
@@ -1154,7 +1161,9 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		goto out;
 	}
 
-	src_pte = pte_offset_map_nolock(mm, src_pmd, src_addr, &src_ptl);
+	/* same as dst_pte */
+	src_pte = pte_offset_map_rw_nolock(mm, src_pmd, src_addr, &dummy_pmdval,
+					   &src_ptl);
 
 	/*
 	 * We held the mmap_lock for reading so MADV_DONTNEED
-- 
2.20.1


