Return-Path: <linux-kernel+bounces-426737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E822D9DF722
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85F928153C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130501D9591;
	Sun,  1 Dec 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpK1W4hP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6691D7E3E
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088174; cv=none; b=gOuF6GonFvIPS/vEt1xG+8dVJ1disdTLKEhrVETiITrMCTOy1qemnDcdwPX51HEJ2NL9qejv9pfStfGG6A6KIREbsZElKUPXOWCks7y5u8ImC7RdHHl7POixOzD5YcpgqUNQdfwR62uW+nkZZpQWig8fbRAZ9XBIl7N+XUp5oHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088174; c=relaxed/simple;
	bh=8sVq+14GI7Ys+M4ugo6xJzdxYpIEvy+9vJqPLYXLNZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSLKmDe9tNM6INEyA2W9YqeD/DgJkZi5fgSgKYct3AsS8gM5n/zZjS0Ey3GykB4xCqTIMroqs2Th2HGlSQNmfZgsVemzpjFXCd9lg5M1CiPW7rjXaoSTqNkBRMB4ny5eMPCT2m74doZOWfQBwbCnRwAf+NeB7yuJlntW/YJmHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpK1W4hP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733088170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgKna+t5A1Bp9qSkDY4pJYluOesve9BjxVP72JgrxSQ=;
	b=EpK1W4hPtKBiS+GaxnmXvH3jOTbKdTRlKg0lB2KvKYYQiO6OpuSD6ypSkVeKcMTftsguKt
	GNuQeQvUW1+R7HZJ7JMSKtyFxTuO7HjmMvQOvnuy4qNQSgcyG3Uf4JsILiX6LvaONaQn13
	DQ/OO2jqDXlhtRURAtWat3Ch7BmrD5U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-9QWqZNvdPwqsIYBvd1Eqkw-1; Sun, 01 Dec 2024 16:22:49 -0500
X-MC-Unique: 9QWqZNvdPwqsIYBvd1Eqkw-1
X-Mimecast-MFC-AGG-ID: 9QWqZNvdPwqsIYBvd1Eqkw
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-466b72ca44eso51471391cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 13:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733088168; x=1733692968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgKna+t5A1Bp9qSkDY4pJYluOesve9BjxVP72JgrxSQ=;
        b=DAKVPjcm86Rw/+fBmb4z0Egad4CsQ2Kv5m04ucxiaan7NCuRIzIAquYCD6O124L8aS
         OIC4o7l8uMdd6ANq2qDaRSk2VQzGOpwdKEVPXBkqM/jxb1sZHXJ5eujTV76d8Kn0s52I
         htmdfcmWaZRYwUAfPL5BrvCRgOLD4eOIYwA1wvzpVgfy5Svda9GDci5cv272auKlkABr
         Qas6egDv4akiFeIgyqCWgDGHn6uPapbdG71g3tuL+wUG0cLTJcj+SoRdElIEmiNkRVuD
         nuMMyF4RnmdksaSg6ZZrnaDiNklSdy2ApeF2ZEs8bDD2/xSVZwndarodi4940QMd2HLG
         ddyQ==
X-Gm-Message-State: AOJu0YzvTLIej1hc2639ORHuv4kUm1qil4pM+KcTgMvFr4sJ+7HjOnOF
	7sRzvQJy3IKRIxegxBEscD8j9q5vlo/R3rVfAGI2Cq/9diCbs1MyjWXcxB2cWljo+luEC0F/ep0
	K4MjLzu7232IsdHyZeF8d9GewmDVpZGEb2KlmT2n1I+jajN8fzqywLwbaX6iUS15w+Znem1+xxN
	rqGpUp37/qBR56wVkkfBZ4AtvImI1bfGuMImEy6YVgqq0=
X-Gm-Gg: ASbGncsXp8u2QJPLk2mXCda0EFOVHus6focWfy4f3Z51y25Ccv3y66b/tlh1TZXOgZ6
	BxOsKG8qU6sp/rmHBXwwTviCvatkTili3zNwErSxdy7ZEcMSpCY6ew4WMvNwF+S4EERMKqpKlms
	FzP958v9Y5wIPSx6eGrFbfPF9ids8HMoRrKDjZmKoF/8SgjpC/Hf/1FwtxLqphr9SbkkL63sxR2
	7rUAwau89fIj20UCRPAupfkSpzFGvSdCT03sxPdRtbJKK4i3HQRqcZX/QjGhCNG/qZvLOZzIzS/
	E/ZqBgf3lqhk6EJ8n3qpUak+vA==
X-Received: by 2002:a05:622a:1a20:b0:466:a587:8ce9 with SMTP id d75a77b69052e-466b34dc575mr318575601cf.6.1733088167934;
        Sun, 01 Dec 2024 13:22:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7GykcZ01mbWQKH4SyRwwIoF+mZE5tT1yvMdlS3a2CiAzYqEu5ysg5BfeHrZjo8bJtgpTuBA==
X-Received: by 2002:a05:622a:1a20:b0:466:a587:8ce9 with SMTP id d75a77b69052e-466b34dc575mr318575121cf.6.1733088167457;
        Sun, 01 Dec 2024 13:22:47 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4249f0asm41278911cf.81.2024.12.01.13.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 13:22:46 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Rik van Riel <riel@surriel.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>,
	linux-stable <stable@vger.kernel.org>
Subject: [PATCH 1/7] mm/hugetlb: Fix avoid_reserve to allow taking folio from subpool
Date: Sun,  1 Dec 2024 16:22:34 -0500
Message-ID: <20241201212240.533824-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201212240.533824-1-peterx@redhat.com>
References: <20241201212240.533824-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 04f2cbe35699 ("hugetlb: guarantee that COW faults for a
process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed"),
avoid_reserve was introduced for a special case of CoW on hugetlb private
mappings, and only if the owner VMA is trying to allocate yet another
hugetlb folio that is not reserved within the private vma reserved map.

Later on, in commit d85f69b0b533 ("mm/hugetlb: alloc_huge_page handle areas
hole punched by fallocate"), alloc_huge_page() enforced to not consume any
global reservation as long as avoid_reserve=true.  This operation doesn't
look correct, because even if it will enforce the allocation to not use
global reservation at all, it will still try to take one reservation from
the spool (if the subpool existed).  Then since the spool reserved pages
take from global reservation, it'll also take one reservation globally.

Logically it can cause global reservation to go wrong.

I wrote a reproducer below, trigger this special path, and every run of
such program will cause global reservation count to increment by one, until
it hits the number of free pages:

  #define _GNU_SOURCE             /* See feature_test_macros(7) */
  #include <stdio.h>
  #include <fcntl.h>
  #include <errno.h>
  #include <unistd.h>
  #include <stdlib.h>
  #include <sys/mman.h>

  #define  MSIZE  (2UL << 20)

  int main(int argc, char *argv[])
  {
      const char *path;
      int *buf;
      int fd, ret;
      pid_t child;

      if (argc < 2) {
          printf("usage: %s <hugetlb_file>\n", argv[0]);
          return -1;
      }

      path = argv[1];

      fd = open(path, O_RDWR | O_CREAT, 0666);
      if (fd < 0) {
          perror("open failed");
          return -1;
      }

      ret = fallocate(fd, 0, 0, MSIZE);
      if (ret != 0) {
          perror("fallocate");
          return -1;
      }

      buf = mmap(NULL, MSIZE, PROT_READ|PROT_WRITE,
                 MAP_PRIVATE, fd, 0);

      if (buf == MAP_FAILED) {
          perror("mmap() failed");
          return -1;
      }

      /* Allocate a page */
      *buf = 1;

      child = fork();
      if (child == 0) {
          /* child doesn't need to do anything */
          exit(0);
      }

      /* Trigger CoW from owner */
      *buf = 2;

      munmap(buf, MSIZE);
      close(fd);
      unlink(path);

      return 0;
  }

It can only reproduce with a sub-mount when there're reserved pages on the
spool, like:

  # sysctl vm.nr_hugepages=128
  # mkdir ./hugetlb-pool
  # mount -t hugetlbfs -o min_size=8M,pagesize=2M none ./hugetlb-pool

Then run the reproducer on the mountpoint:

  # ./reproducer ./hugetlb-pool/test

Fix it by taking the reservation from spool if available.  In general,
avoid_reserve is IMHO more about "avoid vma resv map", not spool's.

I copied stable, however I have no intention for backporting if it's not a
clean cherry-pick, because private hugetlb mapping, and then fork() on top
is too rare to hit.

Cc: linux-stable <stable@vger.kernel.org>
Fixes: d85f69b0b533 ("mm/hugetlb: alloc_huge_page handle areas hole punched by fallocate")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cec4b121193f..9ce69fd22a01 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1394,8 +1394,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 
 static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, int avoid_reserve,
-				long chg)
+				unsigned long address, long chg)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
@@ -1411,10 +1410,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 	if (!vma_has_reserves(vma, chg) && !available_huge_pages(h))
 		goto err;
 
-	/* If reserves cannot be used, ensure enough pages are in the pool */
-	if (avoid_reserve && !available_huge_pages(h))
-		goto err;
-
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
@@ -1430,7 +1425,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
 							nid, nodemask);
 
-	if (folio && !avoid_reserve && vma_has_reserves(vma, chg)) {
+	if (folio && vma_has_reserves(vma, chg)) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
@@ -3007,17 +3002,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
 		if (gbl_chg < 0)
 			goto out_end_reservation;
-
-		/*
-		 * Even though there was no reservation in the region/reserve
-		 * map, there could be reservations associated with the
-		 * subpool that can be used.  This would be indicated if the
-		 * return value of hugepage_subpool_get_pages() is zero.
-		 * However, if avoid_reserve is specified we still avoid even
-		 * the subpool reservations.
-		 */
-		if (avoid_reserve)
-			gbl_chg = 1;
 	}
 
 	/* If this allocation is not consuming a reservation, charge it now.
@@ -3040,7 +3024,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
 	 * a reservation exists for the allocation.
 	 */
-	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	folio = dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
 	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
 		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
-- 
2.47.0


