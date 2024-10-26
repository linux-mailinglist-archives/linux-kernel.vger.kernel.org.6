Return-Path: <linux-kernel+bounces-383026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B35409B164F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A76282B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360FB1C7B7F;
	Sat, 26 Oct 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5d0p0ta"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591D2EAE0
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729931078; cv=none; b=FLyN7nxQJzUWDrTOGSck7SlGm5Vh5eq3RhqDEpn5U51g0Pk3I9YzGZlNA9ZyKB1FyLHMQDrWF5Z8y1g/JEmNQ6U7z78bHfT2ROobWFK30i+T69qw0GA1s00YJHF0Y3qj5LZn6Rnsis1tZdT+SJI4IvYFV8y8+0U2NJJ8TaJXyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729931078; c=relaxed/simple;
	bh=e8oeltC/vuDKIq8H8Mr4ABJ+eAhkDF734AjsCqbyOeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rTPpi+TicO6l+Xr1DA0Fof5f3WD0S44tvrMWwOEOW/pWiS7yp35/DJSYI1UsN4POmZ3EFtdf8CVXRBY9tUWnrpXxvk0Wqvr5ua6huPHofwzl+O8gXsWmUYpk5eJu3OQ5VSabXewzWM6WHZtGSs/NYrFTFF+dZtGms87C37mPAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5d0p0ta; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so2128994a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729931075; x=1730535875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XorRTbiB9fNi80ZoTkLFTNgIsMBK5QYf5PnFoxW5V/Q=;
        b=P5d0p0tafMOCBj1P3pfh7qJ+Z3GMzAYAvPGlUA2mQEm3LUs/IwdCX8uWoWMeV1r2TZ
         pnN/nXfuXnDtsEaOXsUnYCmfMywfDJTxKKrsQAeD5CFW/BEofk7jPZuBEankoOjA/4iJ
         ZtocRQSsTjgkzMkTGZoCgfjugmZRPm3wQeeQAP1N2L5Aq9CyeOrduQURkj9cFzxabojH
         CT2cdb/T+fZIBFKMTl/Pyub5E4PAiH0yuwqh/ldGWfpswIekW9FjUZHJWqS3WfL7U6rQ
         RuFbZI7rTLJzWwa0a51yBR0LFA7SpYoxDdboXpVDepV3abZSOUyPVABfeHF/FW8yMU56
         CNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729931075; x=1730535875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XorRTbiB9fNi80ZoTkLFTNgIsMBK5QYf5PnFoxW5V/Q=;
        b=Tzrvh/8GySerEl/fWm2fECdP/wU6NoLUtv4DyX1SnZzfmGcPf7+lvn0PpBU7gN+lm2
         ykEXNgfvPTMDDjqdYNjsM2tKgn2sdmFqwpDZFbZQheR+n1s0g011+90CGBy2Lr9OhDRR
         bgqGukjcyVOk0u9CYl4K27koLe4Da3DQbWs49u4obDzdnx23WPQGvNfsDSdH8yLZ20vk
         Qp/lNeXe+rxnIgZRMgzF72jhO32LrChSkCcgybjiRF8pZmATt+qDtYs3L8FGu1SnTP+3
         h/jLDjTytPHcTQ1ioyAZPrZlcoE4wMBwwv9MHifo9m8KiDgshqi9tslseDSBUL7C/Pyb
         zAvA==
X-Gm-Message-State: AOJu0Yx69qWtCLIqUdy4SiJCRcyEzfkXqrl9KzZMKFdmpoOzNzEebFH/
	t2mm42A8+WSwc5pvY1oDyJR5q9nDSQqvVvNBFo2294DdVbGYFe51
X-Google-Smtp-Source: AGHT+IEtrrz2kV2IPR7EXre6cDCAc9fw38xdnWE2UaWAFoXKMDo6wToszg75o9qq52IB7jtOqkiuEw==
X-Received: by 2002:a17:90a:f185:b0:2e1:682b:361a with SMTP id 98e67ed59e1d1-2e8f11bad82mr2499850a91.28.1729931074696;
        Sat, 26 Oct 2024 01:24:34 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:b036:2443:5187:864])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555c33sm2932319a91.3.2024.10.26.01.24.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Oct 2024 01:24:34 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] mm: add per-order mTHP swpin counters
Date: Sat, 26 Oct 2024 21:24:23 +1300
Message-Id: <20241026082423.26298-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This helps profile the sizes of folios being swapped in. Currently,
only mTHP swap-out is being counted.

Cc: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 3 +++
 include/linux/huge_mm.h                    | 1 +
 mm/huge_memory.c                           | 3 +++
 mm/page_io.c                               | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 2a171ed5206e..203ba7aaf5fc 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -533,6 +533,9 @@ anon_fault_fallback_charge
 zswpout
 	is incremented every time a huge page is swapped out to zswap in one
 	piece without splitting.
+swpin
+	is incremented every time a huge page is swapped in from a non-zswap
+	swap device in one piece.
 
 swpout
 	is incremented every time a huge page is swapped out to a non-zswap
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c59e5aa9b081..b94c2e8ee918 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -120,6 +120,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_ZSWPOUT,
+	MTHP_STAT_SWPIN,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 830d6aa5bf97..846c1a43f61c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -616,6 +616,7 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
+DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 #ifdef CONFIG_SHMEM
@@ -635,6 +636,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_fallback_charge_attr.attr,
 #ifndef CONFIG_SHMEM
 	&zswpout_attr.attr,
+	&swpin_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
@@ -666,6 +668,7 @@ static struct attribute_group file_stats_attr_grp = {
 static struct attribute *any_stats_attrs[] = {
 #ifdef CONFIG_SHMEM
 	&zswpout_attr.attr,
+	&swpin_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
diff --git a/mm/page_io.c b/mm/page_io.c
index c69fab5060a1..5d9b6e6cf96c 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -487,6 +487,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 		for (p = 0; p < sio->pages; p++) {
 			struct folio *folio = page_folio(sio->bvec[p].bv_page);
 
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
 			count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
 			folio_mark_uptodate(folio);
 			folio_unlock(folio);
@@ -573,6 +574,7 @@ static void swap_read_folio_bdev_sync(struct folio *folio,
 	 * attempt to access it in the page fault retry time check.
 	 */
 	get_task_struct(current);
+	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
 	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
 	count_vm_events(PSWPIN, folio_nr_pages(folio));
 	submit_bio_wait(&bio);
@@ -589,6 +591,7 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 	bio->bi_iter.bi_sector = swap_folio_sector(folio);
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
+	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
 	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
 	count_vm_events(PSWPIN, folio_nr_pages(folio));
 	submit_bio(bio);
-- 
2.39.3 (Apple Git-146)


