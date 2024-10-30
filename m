Return-Path: <linux-kernel+bounces-389732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E719B708E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE8928248B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A421E378D;
	Wed, 30 Oct 2024 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRrxw3TC"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2872319CC24
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331277; cv=none; b=FyoK2WRKV+iZJiMy0s15ss+4A2ApQrfn6IIpXhJTmDpo2e0C0DNJSzwjU4Jtfcd0smtI07+BulmsbXY8xIJjkbMGLBXvwx60ZgA29/OkfGLiPEHXcnemq5R1FYA8gR94t7kNTe5nj1T7UWZjIx/HowFe9O2fotpQuJnuBYLzJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331277; c=relaxed/simple;
	bh=Lr96Dr+3pHYDT/ZweEI9gdb/KVUiCeRKcC/s7EX+CbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1xKkb0803OXOr/x+xuMasYl0xNHSLs/4VnCPTrVJm05JJer+NPSQkw4YHIUySNBEDt254bR4pdO1blweykn4d8TdJRWAcMi3dJl6c6JFZRI8pLjmebPkmw8XMeLHaSfmWpDx+NwQHEOJ++I5tvZX8imShWOJjybM8cL/yvoaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRrxw3TC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso355874a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730331273; x=1730936073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLinXQ+6cmEN16o8u5D/vD9Sr8m7QjMLrxE4k4mlIMI=;
        b=LRrxw3TC5Sasr4ZBPsOZABpW6o84GjXQarnf069iwxcbDQEdcIA/tiHVWYRhgZP5sN
         nhdGqVIPA2tJlqw0uGBBAsYRNEE3KOtItuz6vxqQhH4md2BiYn85yQJCGoMgRQvBfu09
         xyrrrBOcuBBh3v15wGxd930KvzVUtjUvhpHgU8N858QJcpTCj0n33z31lovXysLYfHK+
         tGbEBXOJw24R5OZfwHvzZIIcalykSCme6ZmmpovwWe5A2xqacPOXsC5JnlXagGWQpgLI
         GWSKoOEfGYvykBELf+vWKxhUZdFsgHXvN7k4b8UZYaLrCVDKfnBbDQNGSXJ9s3gi3ePi
         eK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730331273; x=1730936073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLinXQ+6cmEN16o8u5D/vD9Sr8m7QjMLrxE4k4mlIMI=;
        b=bY4fdMJ/cC9Np5YrwqusSLQ5iYVdYRFhpLnSNoZ/NBFpO1IGEEvQmPjRwfKKtNNBZs
         exEJGUSfeFKo5gHqdt/TroZgRSM4uBOjfhSYYOcItaLHZmU5dUdBrcdz/eAFQXiPR2GH
         uC+3zpFnnwE/TaWsofdpmnO1+d89VcsdlA3DcOYZxBGBFcuSRnYqSrb8ZNX/stoY5X3U
         zCa7rWe0pX00G2yJBKJsCNs5sb2fcFTIT1pgf2Gwi4FTaqVTuoXtOssLo0zF8U2KaJi5
         IfycWa/L8wfYPXn4kRZpPyFYEmW2J1bc9OxmmV9oWYdwp2xkBiTBTJkSh5q389vU8KRU
         nwXw==
X-Gm-Message-State: AOJu0Ywni+qU4mF0IwshXiWwHjDuVUUArc/zzgbI3BkblL32pNvsQtgL
	T/HZQ/MqHe00eWeZ1l3Ys0ysVrCpLQBSL2Wb66KzuMqs1BDfyUEY
X-Google-Smtp-Source: AGHT+IFMBQ6hOXENoU4C2iQdnIx5Tbzd8Kqz+qFUsHY4NTcdFkrpcKXbX7bk1SCdDQv21XVjwd/UCA==
X-Received: by 2002:a05:6a20:43ac:b0:1d8:a759:525c with SMTP id adf61e73a8af0-1d9a851df61mr22390033637.39.1730331273060;
        Wed, 30 Oct 2024 16:34:33 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:3db0:5853:dba9:51af])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a11cbfsm129307a12.89.2024.10.30.16.34.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Oct 2024 16:34:32 -0700 (PDT)
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
Subject: [PATCH v2] mm: add per-order mTHP swpin counters
Date: Thu, 31 Oct 2024 12:34:23 +1300
Message-Id: <20241030233423.80759-1-21cnbao@gmail.com>
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
/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
         swpin
For example,
cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
12809
cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
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
 -v2:
 * collect Baolin's reviewed-by and David's acked-by, thanks!
 * add some examples for the interface in the changelog, Per
   Huang, Ying. thanks!
 * add a blank line in doc which was missed in v1.

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


