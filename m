Return-Path: <linux-kernel+bounces-426743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB47A9DF728
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97FC2B21890
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8119C1DC1B7;
	Sun,  1 Dec 2024 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQ4FGh2n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443631DACBE
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088187; cv=none; b=s6sptIKqrBk3CWI3aZRBZD/blodEl1lOTqi+RpdC4zLyLb5O+2Ku1rGMwG4d9kTp9JpJe4MU1n588cdoVCvCef3oh+T20BdZf1da+RRt3Y4DybWF/nJsneke6VkE+LZrmt2nRyKaRphlyiWGf3Fl2jqGVBzzWmp5f7Nw3AeVJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088187; c=relaxed/simple;
	bh=BPZc/pv+eViynoCybzxq2B/XetETvyb3Y3175EYjJ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMmyVedifn9gqY4jFi4kHKIoD0lh+9aM39NFQZkJQoH6VrQuzce40Jv1etLp4Sf3Qm5ue+ME9x82lMqooP5jKQCamAyTbLzCqbTBCX7qTiaCOW9j2uhZ7g7yhhyKZIGoQS4qdKo6BPhune3s/hIyULJRQAlt6lfH1U8c8KeW3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQ4FGh2n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733088185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=286MOANtSnZ8I6XGYWwioLKp0ba2wutq5KAnTtwnT/g=;
	b=XQ4FGh2n8Dn3mAgu7jiDXRlp7S2KmETMu7MI6yTsALQLVgoD6GGcDAychAt50xLjsndlX/
	4FNlx2vatEdzg/pcBstlaU2E/A3sQF1tjefIQ6yVFchOuI2xbgeBll+c9YYkLPwQcNovOk
	loAEvT12CnoBMc57/t7/IpCAhPsV0hE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-H_XrC2vJNUuyHjSuiKQDKw-1; Sun, 01 Dec 2024 16:23:04 -0500
X-MC-Unique: H_XrC2vJNUuyHjSuiKQDKw-1
X-Mimecast-MFC-AGG-ID: H_XrC2vJNUuyHjSuiKQDKw
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4669d0e1696so77027391cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 13:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733088183; x=1733692983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=286MOANtSnZ8I6XGYWwioLKp0ba2wutq5KAnTtwnT/g=;
        b=ZXY6ZSidetnuqTHJ1FTSYhM/bOo33ZFePu4umGrj0hjyaTIzorR0OkZVtBNcdo86nT
         hq/SGoeOk7rFZwwnUU0OjVJkMpyXXKwy9dMKmxcMRJkaNXplvOlhhFj5Z5zSGqsbh/2F
         blbmGHeKj3rGdODe6ZDhY658WsFcvvEBG3gEizkKnN7bySAGeUqiT3zI4TyWPmA1H8zh
         18DBprcwgyZBjIn2mGnnLlbVZUqhqhrfDlwpax1rUBJx4dutzazdKIA+RmFPXzOlyx3A
         /dDyHuUtUF9AQnEUEJ79Y5fVxBs8MgGQygveTIhbOkX2D58RxHbuCNVv4QyT+u9lv2Lw
         +70A==
X-Gm-Message-State: AOJu0YzkkV2mzOFStVwTOt0VH/niM+tIPGp0VJjDnphK3z+GiYGvQnW9
	xKOLDPwGbMzBWiEoG59vBwQs30y4FpdJ/k3onZ/1D0Fz/2uAaC+y0TA816SSrVesW7UpuqAJ/DV
	xc0XGeby9s82W4c7Jy0N0mq2iYWPgJVR0evSq14nMd0Y5Y8IJm/3pWAqYKx6rINYhPgMFiQJat5
	6EtY2ins8D+U9u0FxXTXJfOxnj2ZaRQEZice59mkaL2Iw=
X-Gm-Gg: ASbGncuuT1/2GeL+HMz7DMYGacxKrjBbvuqd54q9eMaN7kDgA7KjXa8zwqBfjHSwJcu
	VuX4MWvyJE/Ay2NN6bEsl+Ml1J2iUE0+11s6D7VojGL3Ulf1lyxCmzeneMoEOioIzyMTAJqRT68
	UmRxXrY7vLVojr6yP/FQYppVvLdCuEfBetlz9nmZ4fmqtFkgpG6Y1Fnw+MOPqlopzhA6sZIkHbO
	1IjmrqP3YVdSo9rkfLwWLHhRqhwoC4ylcq/I5xQ+7NiUdN0pdJm0g0yVsq0i7Qx4hJeGQRuCL04
	f/6UsihKDz8tSXkpKrK/8zpcqw==
X-Received: by 2002:ac8:5d94:0:b0:464:c8f2:e553 with SMTP id d75a77b69052e-466b36549f8mr229630881cf.42.1733088183191;
        Sun, 01 Dec 2024 13:23:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcAYLfsmzWB1NZC0VaVby3ei9BnOo2eK+B/fq4AhdvJKUiO4tdmK0mrgEzoTHHOBn14RPVSQ==
X-Received: by 2002:ac8:5d94:0:b0:464:c8f2:e553 with SMTP id d75a77b69052e-466b36549f8mr229630581cf.42.1733088182855;
        Sun, 01 Dec 2024 13:23:02 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4249f0asm41278911cf.81.2024.12.01.13.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 13:23:01 -0800 (PST)
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
Subject: [PATCH 7/7] mm/hugetlb: Unify restore reserve accounting for new allocations
Date: Sun,  1 Dec 2024 16:22:40 -0500
Message-ID: <20241201212240.533824-8-peterx@redhat.com>
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

Either hugetlb pages dequeued from hstate, or newly allocated from buddy,
would require restore-reserve accounting to be managed properly.  Merge the
two paths on it.  Add a small comment to make it slightly nicer.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 10251ef3289a..64e690fe52bf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1361,11 +1361,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
 							nid, nodemask);
 
-	if (folio && !gbl_chg) {
-		folio_set_hugetlb_restore_reserve(folio);
-		h->resv_huge_pages--;
-	}
-
 	mpol_cond_put(mpol);
 	return folio;
 
@@ -3012,15 +3007,20 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
-		if (!gbl_chg) {
-			folio_set_hugetlb_restore_reserve(folio);
-			h->resv_huge_pages--;
-		}
 		list_add(&folio->lru, &h->hugepage_activelist);
 		folio_ref_unfreeze(folio, 1);
 		/* Fall through */
 	}
 
+	/*
+	 * Either dequeued or buddy-allocated folio needs to add special
+	 * mark to the folio when it consumes a global reservation.
+	 */
+	if (!gbl_chg) {
+		folio_set_hugetlb_restore_reserve(folio);
+		h->resv_huge_pages--;
+	}
+
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, folio);
 	/* If allocation is not consuming a reservation, also store the
 	 * hugetlb_cgroup pointer on the page.
-- 
2.47.0


