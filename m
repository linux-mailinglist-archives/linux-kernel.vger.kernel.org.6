Return-Path: <linux-kernel+bounces-299815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8680F95DA4F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7861F23378
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F78BEE;
	Sat, 24 Aug 2024 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNLSO+lN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE5F4FA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724461518; cv=none; b=MktPs0+yUKzokyUTKd6KySI49zqoZL8NGF9HbkMMUyXxSJhL8J8mkjBXr/PFSP1iGNeVnFQcZErDZ6GY1zwnLRHF9z2t02XefJutCbTE74gQr9r/k/Diq94yoap2jipTNLxZcqql/nQ/9MoC4zMaATVICkH1pXyNx0B2zl68qDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724461518; c=relaxed/simple;
	bh=FENPNbdY2Hx1424WtuAHuua/RRvSRIxo+2X03/BiCik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onO/1bOqyFKUJUHKqxITg1V4N/DREaQ5U4/cPDLjHaVu3HF4JB2ArPSmHcxdkT1ljQcB7aBiXb5bd11WoNOZgjLOBDMwhgNQB0pcJ3g2nbDoRyMLvRFLVRpWGQ4/AWfcMBZyE1goA7uCWiAk/8SHYP6SD72UQ4JeFVP7qnoeZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNLSO+lN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-202089e57d8so16687155ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724461516; x=1725066316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fvnizBuO11jjlZtTiefVW+ElYgnwDD8L4QEiBXi3dY=;
        b=PNLSO+lNHeKvl7clORbWE1nZE5oJFnx2gEonS2v7zCLPZk6b4YZZ99UD7OwTwkNP01
         hNclKi4HZeVN0Li+0GCs+QlLzmYiwsHe9f3uI0WsMnI1fjE+QFYsEEFGOkXFHNmG6Vaz
         VdwAEAhwF43oDUESDpa41axSTF0Gt81qp2lVx1wkJXZUQROQ+fnJ4sSfT0rOKS6LuLt3
         YqwQsJn04FdnocXm33z6ZZrvewWdID9pDXr5BjhTaoC52ZEscBYUm6eHfbXQTG+6EcrE
         uBL7LXQ62EXJY9ab+76dbysjF0sSL2u7EJ0pB2TZxyN63U+u7OXyf7mHg8jh8J1Nur48
         L4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724461516; x=1725066316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fvnizBuO11jjlZtTiefVW+ElYgnwDD8L4QEiBXi3dY=;
        b=TXIJ9Z88CCObWoCea+N8mq6hzT+KNP3AZwTyeR7iujh+bPsNBb6EVV3t4s7uylSc8m
         9RIBiR57cuI3rJ6Zh1GaRY8B9u9c0SJ1mhveV9tVmKBIQDggjzX+E/ZeVLY3lkMMSYxo
         MHGG/ap8fhQsTFBwmzQfyt4yhif5rWMY4IoBKGeOFvzrZ6fe9hV+gdey6pAwzVFzrsNO
         Tl3hBQgVLPhkwHujB5oyzfRGOOjgk0iU+P6kRgTlkheKZsGO1Z4z2GlBxLzdX8gNaLIV
         PcSUBeppPeSZUyXtUv1d2maybf2nXOz1TtLwxVrZU0+GwKWPmhivViijUHE5sOLOT/RV
         QbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPsRGFoupaPnFyLkuHRikzDyTXltecs0lASCt22peB5zFB8ocABynH3zaz55Xb1HUFICy5T7o0Z9Ug50I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmtcbQ/xjfWvbsqOWqhwzY7BPFOMLp+RQtEmCncuImQW/UE1D
	IOx1jYnmCtsjkoTZI2SJRSvhjx7EcK7QgBtkRMo7UnajZKPyzp0A
X-Google-Smtp-Source: AGHT+IFUsnJOcIozfJLBYBiMbcDGe/SYAgg1aJHSClzsIiFxd+TuEBD6xCjLHozi/xa8m8owGr2qkQ==
X-Received: by 2002:a17:902:dad1:b0:201:f2a4:cf74 with SMTP id d9443c01a7336-2037fe1ac56mr132147095ad.22.1724461516426;
        Fri, 23 Aug 2024 18:05:16 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:8d8:dd4b:c921:b282])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad56c9fsm3274064a12.64.2024.08.23.18.05.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Aug 2024 18:05:16 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	ioworker0@gmail.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	usamaarif642@gmail.com,
	v-songbaohua@oppo.com,
	yuanshuai@oppo.com,
	ziy@nvidia.com
Subject: [PATCH v4 2/2] mm: count the number of partially mapped anonymous THPs per size
Date: Sat, 24 Aug 2024 13:04:41 +1200
Message-Id: <20240824010441.21308-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240824010441.21308-1-21cnbao@gmail.com>
References: <20240824010441.21308-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When a THP is added to the deferred_list due to partially mapped,
its partial pages are unused, leading to wasted memory and potentially
increasing memory reclamation pressure.

Detailing the specifics of how unmapping occurs is quite difficult
and not that useful, so we adopt a simple approach: each time a
THP enters the deferred_list, we increment the count by 1; whenever
it leaves for any reason, we decrement the count by 1.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 7 +++++++
 include/linux/huge_mm.h                    | 1 +
 mm/huge_memory.c                           | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index b78f2148b242..6630f2ed14ee 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -556,6 +556,13 @@ nr_anon
        These huge pages could be entirely mapped or have partially
        unmapped/unused subpages.
 
+nr_anon_partially_mapped
+       the number of anonymous THP which are likely partially mapped, possibly
+       wasting memory, and have been queued for deferred memory reclamation.
+       Note that in corner some cases (e.g., failed migration), we might detect
+       an anonymous THP as "partially mapped" and count it here, even though it
+       is not actually partially mapped anymore.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2ee2971e4e10..4902e2f7e896 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -127,6 +127,7 @@ enum mthp_stat_item {
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
 	MTHP_STAT_NR_ANON,
+	MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 26ad75fcda62..a81eab98d6b8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -598,6 +598,7 @@ DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
+DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
 
 static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -611,6 +612,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
 	&nr_anon_attr.attr,
+	&nr_anon_partially_mapped_attr.attr,
 	NULL,
 };
 
@@ -3457,6 +3459,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			/*
 			 * Reinitialize page_deferred_list after removing the
 			 * page from the split_queue, otherwise a subsequent
@@ -3523,6 +3526,7 @@ void __folio_undo_large_rmappable(struct folio *folio)
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 		list_del_init(&folio->_deferred_list);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
@@ -3564,6 +3568,7 @@ void deferred_split_folio(struct folio *folio)
 		if (folio_test_pmd_mappable(folio))
 			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, 1);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
@@ -3611,6 +3616,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 			list_move(&folio->_deferred_list, &list);
 		} else {
 			/* We lost race with folio_put() */
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			list_del_init(&folio->_deferred_list);
 			ds_queue->split_queue_len--;
 		}
-- 
2.39.3 (Apple Git-146)


