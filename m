Return-Path: <linux-kernel+bounces-278761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB894B466
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FE51F23360
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB54A21;
	Thu,  8 Aug 2024 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km8bwIiO"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C52BA2D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079126; cv=none; b=aJiPAfnONxGMqWhkaYeyDmLoGrIyPVRZAU+2ZEEIGmPciI1pHeExm6HKNXdIiEk8d9fnOj0PdXEP/VT6xvnNf7nxDfNLEczbxfQynPHVIF1h7LxtRUucmO8ZLA7g1GOl+fLrggWuTJveehd9R3alJOl9bm62z1/eWyp4/45R0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079126; c=relaxed/simple;
	bh=JIzhvwMJBIYK3CP+zdMzwZBNdK7DsqW3+kdNtzGfN0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qietKTMgOdO8mNsRPIu8l8Kb7GwMNYY9Rc0CsdpbqdpkLr2YU9ncWQz7wKu0mykEwC2fevIYEL+mRrFqeqqpRq9bq+5lzBGrLMXRdmTWH5O/F71MpmflWRT47epaQh9n5aHGdidpTPxQbBwU+hI2pny7I3H4ur7Hqofim0wj4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km8bwIiO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so396391a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 18:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723079124; x=1723683924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGt+WO+BgfCM6JRIz2Vp6XstPIQFh7sJFzxCx1ifVF8=;
        b=km8bwIiOnoVpoQ2G7FwrtOWsQSbBaMQ6PrcZGo0oLwRbp4HZnGOzg/jCWfU/mgMyZ+
         G7wu/7lIUFwowH3kARz76cb0hZIm+FJo89Z1LkwcKzbBc+HqddXDjW0obG1yaNcpHRUc
         SvYsl9Ixq6XBg4NwPQKF76UyQGSqQhAUZfpbYHNbVggdZ8/vP9Uoa0mVioAcBSOcTyee
         c30/BD5fmKbGSTLvv0KBCzEC11yETl8PTL/pKHpD5q6DWi5V/Wq9rKlpOTS8jG+ZiCqr
         1/Ug1kRuz1OvKc1RTCyxtOfTf9R4rEUrHvRnEyryxyZF08djxCQKiJYLzHPmd0CL47ml
         3jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723079124; x=1723683924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGt+WO+BgfCM6JRIz2Vp6XstPIQFh7sJFzxCx1ifVF8=;
        b=DMM4bO+wgHhYNSpiBcid9wNnhTC3yuXPRUzbGlC/m1Xa/wfiU03zBnPkegocCOTr9L
         hxvaWJaHC/MLZgfejBBaMGI/OI7zmAJu4AWlTWbDGG8KgH5yMNQT+CAheP8xwffbIdKO
         cwT3VJBQTd3vPPfVUpC6bovZgZTNSm4PeivKMe2viahbAN/grFQGqgN41MldflZfdO4z
         ceXYTi/Iy0JrfcQp9+kBkm6e21UzuVh5dhHK8O6xufnpIG3Qw+7f9wUBFZR9fnTpciGA
         fvUAgwnNT2fWNgUgZ+Klfzl4cJzsQLWAOEdYM753gAK0xn3wQ3jTdLlM09zBQAHLbkl6
         SpUw==
X-Forwarded-Encrypted: i=1; AJvYcCVlw10npRYEpFf2pfn17phZPjvq4muFgjg1eFjnGnJDp6bvS5EGJLqCncpdHwepFcL8+vW3jWE48d2b7cx3fPFSrKFvxGr1t3Ip58J2
X-Gm-Message-State: AOJu0Yz1aH1Fj2EsXEZGHXBLuwHvh2fZrk9SA8mwpQlA1ECX7WNa4Nly
	UmSbEgFbUtVp5pPY3JCBpafMfHKNolb+QoFQ+f9VZb/8ZoZAwkvi
X-Google-Smtp-Source: AGHT+IFNZ3LEVTvWBsb2U6K2+uOj6TPv2ISJ5ATjnSCBem9MDAfR1DacVCd8nZBhcpt0/t+voUop0Q==
X-Received: by 2002:a17:90b:3886:b0:2ca:8a93:a40b with SMTP id 98e67ed59e1d1-2d1c3450a5fmr378381a91.31.1723079124116;
        Wed, 07 Aug 2024 18:05:24 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3a9cc5asm2234639a91.10.2024.08.07.18.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:05:23 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	ziy@nvidia.com,
	hanchuanhua@oppo.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 2/2] mm: collect the number of anon large folios partially unmapped
Date: Thu,  8 Aug 2024 13:04:57 +1200
Message-Id: <20240808010457.228753-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808010457.228753-1-21cnbao@gmail.com>
References: <20240808010457.228753-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When an mTHP is added to the deferred_list, its partial pages
are unused, leading to wasted memory and potentially increasing
memory reclamation pressure. Tracking this number indicates
the extent to which userspace is partially unmapping mTHPs.

Detailing the specifics of how unmapping occurs is quite difficult
and not that useful, so we adopt a simple approach: each time an
mTHP enters the deferred_list, we increment the count by 1; whenever
it leaves for any reason, we decrement the count by 1.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 5 +++++
 include/linux/huge_mm.h                    | 1 +
 mm/huge_memory.c                           | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 715f181543f6..5028d61cbe0c 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -532,6 +532,11 @@ anon_num
        These huge pages could be still entirely mapped and have partially
        unmapped and unused subpages.
 
+anon_num_partial_unused
+       the number of anon huge pages which have been partially unmapped
+       we have in the whole system. These unmapped subpages are also
+       unused and temporarily wasting memory.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 294c348fe3cc..4b27a9797150 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -282,6 +282,7 @@ enum mthp_stat_item {
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
 	MTHP_STAT_NR_ANON,
+	MTHP_STAT_NR_ANON_SPLIT_DEFERRED,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b6bc2a3791e3..6083144f9fa0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -579,6 +579,7 @@ DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
+DEFINE_MTHP_STAT_ATTR(anon_num_partial_unused, MTHP_STAT_NR_ANON_SPLIT_DEFERRED);
 
 static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -593,6 +594,7 @@ static struct attribute *stats_attrs[] = {
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
 	&anon_num_attr.attr,
+	&anon_num_partial_unused_attr.attr,
 	NULL,
 };
 
@@ -3229,6 +3231,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT_DEFERRED, -1);
 			/*
 			 * Reinitialize page_deferred_list after removing the
 			 * page from the split_queue, otherwise a subsequent
@@ -3291,6 +3294,7 @@ void __folio_undo_large_rmappable(struct folio *folio)
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT_DEFERRED, -1);
 		list_del_init(&folio->_deferred_list);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
@@ -3332,6 +3336,7 @@ void deferred_split_folio(struct folio *folio)
 		if (folio_test_pmd_mappable(folio))
 			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT_DEFERRED, 1);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
@@ -3379,6 +3384,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 			list_move(&folio->_deferred_list, &list);
 		} else {
 			/* We lost race with folio_put() */
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT_DEFERRED, -1);
 			list_del_init(&folio->_deferred_list);
 			ds_queue->split_queue_len--;
 		}
-- 
2.34.1


