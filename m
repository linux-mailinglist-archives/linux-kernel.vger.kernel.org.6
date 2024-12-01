Return-Path: <linux-kernel+bounces-426742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 377069DF727
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813C5B214A3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE7F1DB548;
	Sun,  1 Dec 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itXNgL/f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1A1DA62E
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088186; cv=none; b=Veao0vOzLPAYQY8XxlOu3AFESEwjuObqbQpcernUgn4gm20uYk55FnEVIHoM9WBraMkq+wMxJGzEsS0hqcjVAmIlX+0zxcrLje6r+ranDMgv30ZQKPmBQiFGuhgzwHJGcC8EHRPU9wdZnxqE5UDE4dCqtMIFuxSGBvnIZFYciP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088186; c=relaxed/simple;
	bh=8Hkpil8l+PF0PLDcFoYxVOpxSR2JrK5WHoQieoSAbtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGXiVY3EUuH4eC8bA/WtQrMR2zydwsJk8Svt/NPA118STZ+9h3p5JwMG+77XnKv2TzGo6D23Z5C47z2Va+IRtTvTG9jm/BWr20duGUNaxjYvxrlE02spScVDB6FwnPqSQhOmZHRU9sZpa1PqShEdJZtthMlMcvUX6/Z5I1Z+D9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itXNgL/f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733088183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrrRdtWvOXhX0IC/Bu+h8sPnIUOX9C/tAx/abPzoJUA=;
	b=itXNgL/fotTr5w+PDOXxGVDiRZoK6j+PT2mHftUuzKe1AEkIV+NmybcM6Og18el0b0F61m
	qxjsxFow0GTaisGm4pI4SxH9iOtySD/4yEmgJGifH3SqyZF5vhSod8J/eHt+z65XYExNPA
	NT9GHOZmJsKWJyPO6lzsDFMUR9+a/4E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-sN8ATsnnMJOD9p_4ZasdHQ-1; Sun, 01 Dec 2024 16:23:02 -0500
X-MC-Unique: sN8ATsnnMJOD9p_4ZasdHQ-1
X-Mimecast-MFC-AGG-ID: sN8ATsnnMJOD9p_4ZasdHQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-466bc740022so75909321cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 13:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733088181; x=1733692981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrrRdtWvOXhX0IC/Bu+h8sPnIUOX9C/tAx/abPzoJUA=;
        b=RwE6vMmIa81e/n2JmjZUM1VqDWsfDUGoKRdvjKDsN5nlYMPM/4E7n1Mw3rGTAlYCri
         MqOz2E70YfM+QV68egAqX2SaRma4kJkq+xlPbm+d+RuLUt4xKN7FDHoUARyjED3aAWUL
         +ko/s821UT531TJqtqtw7vV4dUEFc9VLwJNG0tcXz1L0urPM/Ae44vet4YZSDw70ioJT
         nMAdv+hzvmCSRcgiC8FzuIp+kYPA4Jpuqdfk0CZYAXOdeIHlqBDbDfXi5JQ1HNku2HDr
         8fP1M1Kbw/Cl7xaUixsAdYWl4eIkTxtHY6SUyuDY+owK+bOl+VVQAS8Kk8+tgqnyrUJY
         m7GQ==
X-Gm-Message-State: AOJu0YxWilNyBueItii6tkmWBXeuHziawHkNPtMjPG3YG+Hjv3astN/B
	kHgzhCPEBQ+jDfS6YcDVmq3CCfMfScchjFLhTNJIrRkiBwFEatxGb8dO4cI5gObANy1W0Qczbot
	+m3IK+ceWuBXuHPRqNvlyH7TR9jxwRuzSCUUCccBUzHwkD2KvlM2QhWqftPV7b+Zsz8IMmp2F6g
	vzY5wQtgWt6dkxAdSiaNyuSD3we5r/Yix/lWC09wJNa9A=
X-Gm-Gg: ASbGncvIbAThEv/UJQMGzjYDws0b2HqyBX3rr6X5T3GYkfsaNlEHmw5ZnX2vJAtDIpJ
	zmBoLzyOMlHxWG0iJD+JXDiSRsHQWwI/dftVXG7AzJyyj5VodGND7UJTcqbuDD12kqic/pZay4Q
	V5ALT8yArQzt+2QXBFJ+GfoTDbndRzdgwIVEyjU8tRBrgF5Mo7aMEnTiIHtlLzXD5PSZu0noMSB
	7ZPDoJY8ACvDCJ3JOFuQ2Hbjfquop174wHP4kXLmugSdrzDwHKRe+YCiuJV9inXsKxLQ7l0Vw7L
	hVwTivBL6aP2UXFhLIRSpS1yaQ==
X-Received: by 2002:ac8:7c48:0:b0:466:a41a:6448 with SMTP id d75a77b69052e-466b359e3e1mr323828951cf.18.1733088180886;
        Sun, 01 Dec 2024 13:23:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMtpb17mmgqOgRNsdiR78ELm0LNQJM3Yg9dkXYjGdXNTa3Aa8RyK4xqT6Ebmoe6jg1COSs1w==
X-Received: by 2002:ac8:7c48:0:b0:466:a41a:6448 with SMTP id d75a77b69052e-466b359e3e1mr323828541cf.18.1733088180557;
        Sun, 01 Dec 2024 13:23:00 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4249f0asm41278911cf.81.2024.12.01.13.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 13:22:59 -0800 (PST)
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
	Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH 6/7] mm/hugetlb: Drop vma_has_reserves()
Date: Sun,  1 Dec 2024 16:22:39 -0500
Message-ID: <20241201212240.533824-7-peterx@redhat.com>
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

After the previous cleanup, vma_has_reserves() is mostly an empty helper
except that it says "use reserve count" is inverted meaning from "needs a
global reserve count", which is still true.

To avoid confusions on having two inverted ways to ask the same question,
always use the gbl_chg everywhere, and drop the function.

When at it, rename "chg" to "gbl_chg" in dequeue_hugetlb_folio_vma().  It
might be helpful for readers to see that the "chg" here is the global
reserve count, not the vma resv count.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b7e16b3c4e67..10251ef3289a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1246,16 +1246,6 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 	hugetlb_dup_vma_private(vma);
 }
 
-/* Returns true if the VMA has associated reserve pages */
-static bool vma_has_reserves(long chg)
-{
-	/*
-	 * Now "chg" has all the conditions considered for whether we
-	 * should use an existing reservation.
-	 */
-	return chg == 0;
-}
-
 static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	int nid = folio_nid(folio);
@@ -1341,7 +1331,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 
 static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, long chg)
+				unsigned long address, long gbl_chg)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
@@ -1350,11 +1340,10 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 	int nid;
 
 	/*
-	 * A child process with MAP_PRIVATE mappings created by their parent
-	 * have no page reserves. This check ensures that reservations are
-	 * not "stolen". The child may still get SIGKILLed
+	 * gbl_chg==1 means the allocation requires a new page that was not
+	 * reserved before.  Making sure there's at least one free page.
 	 */
-	if (!vma_has_reserves(chg) && !available_huge_pages(h))
+	if (gbl_chg && !available_huge_pages(h))
 		goto err;
 
 	gfp_mask = htlb_alloc_mask(h);
@@ -1372,7 +1361,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
 							nid, nodemask);
 
-	if (folio && vma_has_reserves(chg)) {
+	if (folio && !gbl_chg) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
@@ -3023,7 +3012,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
-		if (vma_has_reserves(gbl_chg)) {
+		if (!gbl_chg) {
 			folio_set_hugetlb_restore_reserve(folio);
 			h->resv_huge_pages--;
 		}
-- 
2.47.0


