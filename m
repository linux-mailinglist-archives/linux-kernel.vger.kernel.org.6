Return-Path: <linux-kernel+bounces-390119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174F89B75CA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2612858A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280EF14D6E1;
	Thu, 31 Oct 2024 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0X2feZH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00F14B08C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361219; cv=none; b=BsnYCoBV/DX2YT9YNFQeHLxzM39NyRcNU6BNE+iJvKpW1lgwUvHIo4Oye8Fkiwc6TahaqzUJoTlPY5dZ8/XLbzqCYF/yuOsPl18hZ0aPgNJuFyj7QZ5w1J6zlfWo+TktkTzsAjxUcnqV1o+Uz3/5S3LxF5PLB3JOQxnRSCvQV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361219; c=relaxed/simple;
	bh=ebyycB/4ib5ntik36V9DCo6Bsoe3rbRd7K6jN5T6igE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oPmCUFXsyWoYH+EiJC1uXNT4DrSmF19t+kEq/g4dMwznhisMNNqWhJSGAO9gf31SpdpB6gtKgD9zqSdPCsQHxskvpPEWp9ugE+HtIwCDm8HOl+m4eL8YBhoIzA0gevjR2eq5Y7zXnsps9tuF8ONmBAswezBGhYV4ghagtt/4uqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0X2feZH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdb889222so6417835ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730361216; x=1730966016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sU363tB9SzeZJUVZs434e5usD3yu6o22dmX8GcOkH+o=;
        b=l0X2feZHQZcIjsawpaF56ZPzFBs7ItewQUGVW/oVQ4b3i4N//JiTTj0PlJlnqs2NYJ
         Fd33UfcqOa58mCN3sASHOT6Cmk4RkdtdNHoD6jlAi1Kly4nr03sLDcfjQBuOQh2UOM1g
         jDA0IW2gryXAFv5ELwN4+nSvIUGMfNrZ/osF8wQfqthND026a6HojARVdHwAJ7jCbO12
         oteqQxFJ2tVHIfhW3kKcBrEFaE9B8lELTuuZ2Rjrs5A0WNe/fhyTYC4EIziSjENT5OxK
         4PlwLCpxfwQCDBi9XpFih8gLYpjkixkd92ycw0QeszT0A266YuJpv5w1VZSQ6Rs16jKt
         YH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730361216; x=1730966016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU363tB9SzeZJUVZs434e5usD3yu6o22dmX8GcOkH+o=;
        b=MpLM1oSpL+SUMgZN4+k2RIP+peXo+BuVKHSrzSUx1/8FcXbznWGbiKiL1bnS60TH5t
         6rPImtNPSnJTflQv+S7nzNEGGFkUQOLGilH+5IjQyZEGh9ksFSfMKQ5cducJqQxSMrGs
         l5vVkuq4WHuMlOHoe2SXciJ408ZuQOAuAwubVQ1YicOC3ly1Iak+UhtCy5ZLQNVZlcZX
         NH8oMuRFoNFmaMy1pRXvhVfJhb+YmzMjIiblNDEhBu/D2fQvDdpD43eH6TPxLXQrTGTR
         YFPJNdq6Ddu7cahM98YhDW467FO49czS1/NIuc35ZlZIbR0d545j7dA6cXTgepPexSzO
         Q1tw==
X-Gm-Message-State: AOJu0YxgbwxgKeEX5CArEYc2l7WV6wCz7PD+bJnlFbgwDAvp6L0i9I55
	nPwxCN2e970b/WiqPa9Y0u+lyoc6MD5OzX1vLZVirPiznRBU24fx
X-Google-Smtp-Source: AGHT+IEMaIacrNEzQWnP3x9A3xtQPUa6GNLwSJqzoZ3Y7vWC+lCf1dGa/O/BBvY5QcpAwJ+ZZ1m4eg==
X-Received: by 2002:a17:902:c40c:b0:20c:7d4c:64db with SMTP id d9443c01a7336-21103c7bfafmr24112375ad.49.1730361215675;
        Thu, 31 Oct 2024 00:53:35 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:a0a1:9dd7:69ac:8730])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057063f9sm5415695ad.65.2024.10.31.00.53.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Oct 2024 00:53:35 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v3] mm: add per-order mTHP swpin counters
Date: Thu, 31 Oct 2024 20:53:25 +1300
Message-Id: <20241031075325.1037-1-21cnbao@gmail.com>
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
The new interface can be found at:
/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin
For example,
$ cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
12809
$ cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
4763

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: Usama Arif <usamaarif642@gmail.com>
---
 -v3: minor refine changelog per Huang, Ying. thanks!

 Documentation/admin-guide/mm/transhuge.rst | 4 ++++
 include/linux/huge_mm.h                    | 1 +
 mm/huge_memory.c                           | 3 +++
 mm/page_io.c                               | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 2a171ed5206e..5caa3fb2feb1 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -534,6 +534,10 @@ zswpout
 	is incremented every time a huge page is swapped out to zswap in one
 	piece without splitting.
 
+swpin
+	is incremented every time a huge page is swapped in from a non-zswap
+	swap device in one piece.
+
 swpout
 	is incremented every time a huge page is swapped out to a non-zswap
 	swap device in one piece without splitting.
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
index b26c6503e993..f92068864469 100644
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


