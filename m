Return-Path: <linux-kernel+bounces-233915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793FC91BF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382E02847EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F0F1BE25C;
	Fri, 28 Jun 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeRatLlD"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E18194C67
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580152; cv=none; b=Bms1m/BKoFkd/TzMbklvsPPbSaEExOxBkK1lBGQvZg3Z7wlgy/qOCWwFaFZjb9/uy4odgw2Qt7O9rpSKXAuaX8DBoJQVqYwZURzDUEYKS66wj0a7qicgE7yQSWILkdwtRjeFhTkg/u0mdwVc1mvELhSYJ7/9zI3KSWfM53MufkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580152; c=relaxed/simple;
	bh=jmD4ZeQHkvJ7O7wavkcETxc25rT0RGWjVo6xM5X++AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4kQnFH5luk36+flAwIAWSK55i4hs6p3by0gKuEHAtDN58ARSpvLwRiA2ezqgXOFegfSsaHdwAGTvrFtJxjmhHoRX71xJnlkFADTlLvL6Ror6Nose/U9c6/N4bzOPQjVYcEh26T8SEfc0PJf4XxJKkVWl6624QzXmKP5KLvzT/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeRatLlD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7163489149eso415888a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719580150; x=1720184950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA8e/eG8oKstNM7/17OixM+41nIGNrDwvlLD106HjE4=;
        b=WeRatLlDtTOM4K7yie65zLNGTC1sa5vdUqdctO/umNAtZ0TCSt8CFsYO6ziepIE61u
         1vwTXGGoogk396j6kKoMWhFMFyKs1CwqM4gf66U7pwG9rB53smh74QIKPVjF49GFiNjR
         CcGwPmHGfdQV76xXq2R3Nrl16OwtglMfjyJ6OcAHz1FF5XTLl1LesHDcPJKbvR/0RiIR
         VC9LwsREOv91oNCyRAv6kxfRA0eM4XYU/ilNcR+nOu7OKO3eiWM+PS0RbQ96PVMDcgRC
         yHeZ+1OIiKDUaviHURkBBtH9G0py1bUtmq9cy5W1qSDAAYipw3DF7nHcjgEsiaj9B6mR
         m8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719580150; x=1720184950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pA8e/eG8oKstNM7/17OixM+41nIGNrDwvlLD106HjE4=;
        b=wXgzjxfmzWr2EJWkaIsi6vTSzP5ky5b6cvWiwDpFRZ7m/OBU+5Hn/6ByecXoQpKYqZ
         CgCq37cz++YkizxF/ajDOAg3/e1x5o5pIng3+Uy29oUUz0+vm9VV62kECQTD+hxyz0xJ
         JzGFSsNH/qzMi/d6uV7LfNBIFrjM6uSAhU/YAgeRk8ORi5d4dUVff9BfZZeE9lCZtqi5
         B5NCOdvfNeTO9GyDUSTwt3mPAZmwxkZb2vhoo63mXBUW7bjoCNQUc+v5ldfhhvI/aLrj
         K7bVbik4jhuaMo3RgMXA8sd4Aqi6BPpmM4KXizfFMK4+Fvd+CP1D9R0CqKlXMjZPp+9/
         BSdA==
X-Forwarded-Encrypted: i=1; AJvYcCVRws85+sIztbaGIu1wCtT+NcGytaOfx78PnfebJ9mf3oN5tASZKAXErK1ctU31mIlp+02t3Ds1A6zx9arQBbLbi+r3IfbDwWUogbiD
X-Gm-Message-State: AOJu0YzQUH9YJhGnDghZVRRNpCI2/78TdJYKUCqwGjVTWqFV4rxrwdnD
	hZ9LAoFk9qPFWvwdiOCeg7igrCXRxWUXJwZDA0UTx5F4ZzsynSCy
X-Google-Smtp-Source: AGHT+IFjbkgnF3EAdZd/5nvVUSzeFKuPrDEySNvAscHEob4ZAfU8Zv04k82jTF9h3HEfGazGu1kgAQ==
X-Received: by 2002:a05:6a21:998b:b0:1be:c58a:7433 with SMTP id adf61e73a8af0-1bec58a775emr9386756637.59.1719580149845;
        Fri, 28 Jun 2024 06:09:09 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080498946bsm1526102b3a.200.2024.06.28.06.09.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 06:09:09 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: dj456119@gmail.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH v2 1/2] mm: add per-order mTHP split counters
Date: Fri, 28 Jun 2024 21:07:49 +0800
Message-ID: <20240628130750.73097-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628130750.73097-1-ioworker0@gmail.com>
References: <20240628130750.73097-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the split counters in THP statistics no longer include
PTE-mapped mTHP. Therefore, we propose introducing per-order mTHP split
counters to monitor the frequency of mTHP splits. This will help developers
better analyze and optimize system performance.

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
        split
        split_failed
        split_deferred

Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  3 +++
 mm/huge_memory.c        | 19 ++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 212cca384d7e..cee3c5da8f0e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -284,6 +284,9 @@ enum mthp_stat_item {
 	MTHP_STAT_FILE_ALLOC,
 	MTHP_STAT_FILE_FALLBACK,
 	MTHP_STAT_FILE_FALLBACK_CHARGE,
+	MTHP_STAT_SPLIT,
+	MTHP_STAT_SPLIT_FAILED,
+	MTHP_STAT_SPLIT_DEFERRED,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c7ce28f6b7f3..a633206375af 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -559,6 +559,9 @@ DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
 DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
+DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
+DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 
 static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -569,6 +572,9 @@ static struct attribute *stats_attrs[] = {
 	&file_alloc_attr.attr,
 	&file_fallback_attr.attr,
 	&file_fallback_charge_attr.attr,
+	&split_attr.attr,
+	&split_failed_attr.attr,
+	&split_deferred_attr.attr,
 	NULL,
 };
 
@@ -3068,7 +3074,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
-	bool is_thp = folio_test_pmd_mappable(folio);
+	int order = folio_order(folio);
 	int extra_pins, ret;
 	pgoff_t end;
 	bool is_hzp;
@@ -3076,7 +3082,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
-	if (new_order >= folio_order(folio))
+	if (new_order >= order)
 		return -EINVAL;
 
 	if (folio_test_anon(folio)) {
@@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		i_mmap_unlock_read(mapping);
 out:
 	xas_destroy(&xas);
-	if (is_thp)
+	if (order >= HPAGE_PMD_ORDER)
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
+	count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAILED);
 	return ret;
 }
 
@@ -3278,13 +3285,14 @@ void deferred_split_folio(struct folio *folio)
 #ifdef CONFIG_MEMCG
 	struct mem_cgroup *memcg = folio_memcg(folio);
 #endif
+	int order = folio_order(folio);
 	unsigned long flags;
 
 	/*
 	 * Order 1 folios have no space for a deferred list, but we also
 	 * won't waste much memory by not adding them to the deferred list.
 	 */
-	if (folio_order(folio) <= 1)
+	if (order <= 1)
 		return;
 
 	/*
@@ -3305,8 +3313,9 @@ void deferred_split_folio(struct folio *folio)
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (list_empty(&folio->_deferred_list)) {
-		if (folio_test_pmd_mappable(folio))
+		if (order >= HPAGE_PMD_ORDER)
 			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+		count_mthp_stat(order, MTHP_STAT_SPLIT_DEFERRED);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
-- 
2.45.2


