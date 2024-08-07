Return-Path: <linux-kernel+bounces-278560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4294B1D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86A71F2383E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC72E14EC60;
	Wed,  7 Aug 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z03WeJcs"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A8149DE4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065199; cv=none; b=Zt8WK8le0E2RfoILFpqZaYqiyOxcjoffdvNicBu1cM3++8kyxyJjLCnrNvm9qgUwvyIFdjhOVC73JoVYNzqb0KUcohVG5/VhJCFBvxkFHKsh9dNe4XIMDAjWjHrQyDKTpOvk8DPQ+2iZx9VEAYHjoMUij8zUxL8wEXhKPDubRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065199; c=relaxed/simple;
	bh=pSD5olf8arH4asztN/L7oXloRLZzeJzcaShHvOW6MPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzyT7614+X6QfiHXJYyM3oTYTwqKg6sRFLPxymfgrYLyKMZVKZuDD6PDuq16z9EBsxh8L8VooV3vvAJDn9kZiFORnP3h9l4EghMmHeJ0aSJx0RYSvJg5x8iXJDny0C8ILtLYn7JZNOrTrq1Luuy9at8ycMWiHsz0MuwwF27SHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z03WeJcs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280bca3960so1990545e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065195; x=1723669995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipxPc3kHJ/aHYONf/RL5CQxJXN3wQhPlYJdaXX0x/8A=;
        b=Z03WeJcsr57YLumvyiACm4HDnsGvRcPKzOXZARzCv9DNsdB5DbMuDL+NP1FG5Va4GO
         PUIZJCpvxyAT5cB5zp93FtTLHqJHPgz4bBHS1EY+OwaV/1v9/HwcmPrYGLSKj2UzkuH+
         m/450gjKBRiZ+cg1iSyVqdZNJTcYuee/WqPJO80tnlLK98RkKBURJjAYuQKOWbn4FhDv
         7FnZyyRDzwOh1hGgfNFQvw+kGs/WzlITkPZs1v3yLNY4S5f/biZQ5u5knrccSDjR/Cvk
         BFImMM2E8mrwUdewFBIO26jhQZYcwjL8QpKKmzGqlnrSSd30RqOCWBHS4looJK9bpyci
         uw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065195; x=1723669995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipxPc3kHJ/aHYONf/RL5CQxJXN3wQhPlYJdaXX0x/8A=;
        b=j0jsde2M7saUBzZHkzf56drj7IZqiVFtnX6KyZjrmGQ9rjkQkQD+Q3Sb/UCjVZ34oS
         6q2Ow0LcgYe7p1G4owR06jA2vnkiEN90or9sl/Vz8RWliqfipyPweaevXstWm+3aexeV
         enbXUYknQesKGDY8l8WifjXXqgofuNMzf/iIjMtJ9JzFYCAJmp/plhkz2us/unnEB5lD
         JGxX14nvxTm1dZrufZkkU1HZl/JwweW09xdv9NQAtAkgB8CANm0W5Q3nyNGiQV4shse4
         gQ3Teomi3g9PeoO7yMauge/g6CVNeUwPM75xT2URclszjimmvOSw4ZmCJbiL8CPb3P3U
         THNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwTPjZcq4YQnAoS/2wtc3ah4o1x15OewJh1xLyNz9xKLBcN3f8RhOnAlSQrvBIDnlWUeV6KgBQDhqQsJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwViJbtw39UXpVylz6VWOTaRv6qMrS13KnI9Ewf2R4cGdi7of95
	sPbbCNYDm4UOwfJsJPkw+UyzjD7dkjsIdygZABvsgQOcSsohcLWXSyFB7rA4
X-Google-Smtp-Source: AGHT+IGUgTLwkyGxx34ziVOHF9gL7CXCZ85fMygqSYe2EG18dKWn9T+3Dab1GPTFV+wfcEilhPcNtA==
X-Received: by 2002:a05:600c:19d2:b0:428:14b6:ce32 with SMTP id 5b1f17b1804b1-4290aeee1bbmr80955e9.9.1723065195315;
        Wed, 07 Aug 2024 14:13:15 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a92c8sm45869525e9.23.2024.08.07.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:13:14 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	torvalds@linux-foundation.org,
	jeffxu@google.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2 2/6] mm/munmap: Replace can_modify_mm with can_modify_vma
Date: Wed,  7 Aug 2024 22:13:05 +0100
Message-ID: <20240807211309.2729719-3-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807211309.2729719-1-pedro.falcato@gmail.com>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We were doing an extra mmap tree traversal just to check if the entire
range is modifiable. This can be done when we iterate through the VMAs
instead.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mmap.c | 13 +------------
 mm/vma.c  | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4a9c2329b09..c1c7a7d00f5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1740,18 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, struct list_head *uf,
 		bool unlock)
 {
-	struct mm_struct *mm = vma->vm_mm;
-
-	/*
-	 * Check if memory is sealed before arch_unmap.
-	 * Prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
-	arch_unmap(mm, start, end);
-	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
+	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
 }
 
 /*
diff --git a/mm/vma.c b/mm/vma.c
index bf0546fe6ea..7a121bcc907 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
+		/* Don't bother splitting the VMA if we can't unmap it anyway */
+		if (!can_modify_vma(vma)) {
+			error = -EPERM;
+			goto start_split_failed;
+		}
+
 		error = __split_vma(vmi, vma, start, 1);
 		if (error)
 			goto start_split_failed;
@@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 	next = vma;
 	do {
+		if (!can_modify_vma(vma)) {
+			error = -EPERM;
+			goto modify_vma_failed;
+		}
+
 		/* Does it split the end? */
 		if (next->vm_end > end) {
 			error = __split_vma(vmi, next, end, 0);
@@ -815,6 +826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	__mt_destroy(&mt_detach);
 	return 0;
 
+modify_vma_failed:
 clear_tree_failed:
 userfaultfd_error:
 munmap_gather_failed:
@@ -860,17 +872,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
-	/*
-	 * Check if memory is sealed before arch_unmap.
-	 * Prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
 	/* Find the first overlapping VMA */
 	vma = vma_find(vmi, end);
 	if (!vma) {
-- 
2.46.0


