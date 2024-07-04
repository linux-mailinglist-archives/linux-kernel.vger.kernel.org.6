Return-Path: <linux-kernel+bounces-240384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADBB926D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1159A282028
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539011CA0;
	Thu,  4 Jul 2024 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3pbaPsl"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C801A107A0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056577; cv=none; b=P28VQ6PCi2u/e5+MjNP48F3Qr/QxZBZ3PaLtTUKHR93zjTX2XJvD0hhQ9N8/QWojtk/hREs+zLSCv5ANOZgOgZPYUw5x0ghO9w40KHti+Xzprfj6rzf9vvCQ7J8KF8YHIV62ujvipSPyjw8buGWtIGC/iLKNo2vNP2FZaK6Fjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056577; c=relaxed/simple;
	bh=k32WDnHi5U945AuRce984UDpc4BdZz37WC+JhOGhmf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMWJixjrsRSEx6eKBCwCX4+tnmboJbXgXE0OpeYE0nqQfqKezwWy/qPZOR9LO/8Po/uvPs8uUkhDb2J9bM/3WoL9SzbVR+spCLYRtMwzoGrwV8sbASRd+p4xYhb7pH8azgYGuXBkE1SJQsjsnMEz7kvhLNA17BZR0uLOnSqD5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3pbaPsl; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so50256a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 18:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720056574; x=1720661374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en/S1K7ufPc3QQhnQIZMOSOA2N5wr5GPlScNLierXSU=;
        b=m3pbaPslZ3rHAWb30k++0aOyjKsb11xzTJ6qkX9rmy2wqSZn2OjTwBH6AS6HjVol3Z
         g4xLm3tc1N2Hrj0JHMPIouL8nfz0PpH6ju0SGgY6o9zzCgXNWOhFBJlSNqmuncoirZdN
         5D39e+ozXICWoODtX6ocnA0BfRs6bR66wMr4gDXTweL0LXnjIZUhYNnAuMvP/AhQVGRE
         XrapjTxwv3oZbktPo3vdpmQyPK1yusvN559qBpw2OZQomW3e1XD0UzRVUhK8j9ApW5t1
         zG45V6Lfl+P6gRwcbwTi2Ou9fzuaqwvL/5sJJvtrt+hPlCFtvDCUSFK0KwjI0QYnFwvN
         2SgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720056574; x=1720661374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=en/S1K7ufPc3QQhnQIZMOSOA2N5wr5GPlScNLierXSU=;
        b=HhmzE9zrPUDcRb0PqXzdoW+4hV+fA6c4HhF0iXusDIq3+/daNmtP1K+VYiHhuHX9Id
         bwcTnxsli7xWlvbAxgFhJjWbpf3aSho0EZUsNdh2kDx1CtrU4g41Xzd3Wyrl3XyQKBMH
         NO1hvUXIRceztoodelveJ3IAzEze7CXGu2eTl9D+7wL/RpmFAGGtEYHjFpKpxjDeF9t+
         kmBhMfPdftRYPxYEXcoNp7lxreFRnnFqQI6nTEtw/veYxlJHzfu6v+MF5fCx4RgOOX/L
         MEZIkoEup+k4MIWiDT2rkPAKyNdasOJV88pkJKnX4PPANdCcWVBPhXbTiAycYjaqh47h
         7M8g==
X-Forwarded-Encrypted: i=1; AJvYcCXbwgxA1ZDMdn9dW75BMPZaEKI8QvSJ6CPEFI1AdW+KhWPgdNumJy58P0VvYNVy5a7fVVKsUGQNEj2mraX9SQ4gQiGa7CfaipHxUMFl
X-Gm-Message-State: AOJu0YxcGbxhkzUkpRRSalCtq5lFGvnhyx2kV5DiaVnLnATUS4YEn19m
	SImpcTnDtt9Ll79zaGnwgrwB5QwbsuFTVgrBOL1bX//PoMOnkWtF
X-Google-Smtp-Source: AGHT+IH8h2nR3XKUpaLoYTVF/0kMtRKeMW80TtrbBrxF+W4lZJ6aIxPIG8j8eHodbQfKLiXVzHYJhw==
X-Received: by 2002:a05:6a20:12d4:b0:1be:c3c1:7be8 with SMTP id adf61e73a8af0-1c0cc742f4amr152039637.26.1720056573824;
        Wed, 03 Jul 2024 18:29:33 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac153767dsm110162735ad.148.2024.07.03.18.29.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jul 2024 18:29:33 -0700 (PDT)
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
	Barry Song <baohua@kernel.org>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH v3 1/2] mm: add per-order mTHP split counters
Date: Thu,  4 Jul 2024 09:29:04 +0800
Message-ID: <20240704012905.42971-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704012905.42971-1-ioworker0@gmail.com>
References: <20240704012905.42971-1-ioworker0@gmail.com>
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

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  3 +++
 mm/huge_memory.c        | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index 954c63575917..5cbd838e96e6 100644
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
 
@@ -3307,6 +3314,7 @@ void deferred_split_folio(struct folio *folio)
 	if (list_empty(&folio->_deferred_list)) {
 		if (folio_test_pmd_mappable(folio))
 			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
-- 
2.45.2


