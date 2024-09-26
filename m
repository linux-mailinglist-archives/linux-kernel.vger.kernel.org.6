Return-Path: <linux-kernel+bounces-339972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B80986CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650E71F24726
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECEF18F2F2;
	Thu, 26 Sep 2024 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YlJjuAjY"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158918C33D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333272; cv=none; b=jRty+yewr6cXOB43HCrsmC/XgbzYXRacHwz2aPB3akyGH14E26NNlqFYO2CQ1p3PQSr8uiho4o8JaLiO4XcBlB/ozPncgfYe0vMhLGtRy8NT9czEFex4ZMt5inMK0zb16GDSEk9yFD8HdbsK4wXy79bjGvWAJg/0IWmRhX17SJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333272; c=relaxed/simple;
	bh=gOCug7h2oDN1d5Lx1fQiD5OJfBDKrJ9h7gKP2OJkqUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBTnkao1WLGNpLsU2rnCL+4UmBTw+4oI6eBeisCvJ91iB+TcOnTQyv/wOCsVoPV/h5Ps3ADGPfbcIwj/pxzmOjbl7srTZgs5W7+Cy3laN8p4HgSp02vJ0E7Q3C19qfRZpntQcEKQvbFnlVGdP/tmTAm4NCAY+ZnMuMjUd1ooN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YlJjuAjY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99de9beb2so44969285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333269; x=1727938069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DwHdqVJkGu7HChE1YzlDZaDZvpQCVqvAB2HVgACkHs=;
        b=YlJjuAjYMJVIT5dbIKYDfOlqa4u6upPLFSmICiTN9cstDahG0+l3iO3WfvrHQ+WwCP
         2v7duiNH3eh70JWky89s4RRcoYgCVR19saOb52YI686EJhUCGobzrzfCDxVWoSe3wEyQ
         gNgXoBp4jUxUkANbiDfMXlShct2/jG+gYVfRjl4qPthIOWt1K05lQ6elgCr36WV95+IV
         uHHP7O10U5a7t/DzJl9PieM+9Xy3OC77ZZ8u5BsKp1FxN1HZvFNDyjWGs6wO9FGQJ8m9
         zT0f85ct4tDL3GL5HxsjmGUOuTHdPrH4X/Mlnl+EdMTetQz4Lgypqeip0QTtshYMzdpi
         S5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333269; x=1727938069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DwHdqVJkGu7HChE1YzlDZaDZvpQCVqvAB2HVgACkHs=;
        b=HpUWUfbJOgBuLYfCpQ5LBEUuKNSnsqOT2Vnd799FbWTDcJhVaq8DYCjmcrMOWZ94HL
         k6uxE30e4bAKkRXhYMCHP+K87pqnucS1hHfeqwCxcXjoQMYXPzsw0ULmCy2T13Gj+KLN
         MCGrITawky2JSgPSWQkGQLGfRTnAGKESefl91D1KkJFVOIQkklebatk6/J054lbk0drW
         891jnV/38b6p8IZRpqaUUqHufx/wmrp1xA4BmBsHpdaSQecArvhenI0jhOH5GJ/hBSvK
         f0rOu8Lc2qPA1IYt5+EXKCT8OIEm/rZyCemjp3o2fDufVfZIfb3U3ARq87QeZo1nuHM+
         jfYg==
X-Gm-Message-State: AOJu0YzcciWjKDr28ieLuwFyEA80sfWFoKCsY9pAxNhkKcqnk91agaGG
	ln9o2/CDcdaLe05aNeAfCVYyM9WuQtn3Y83ecoEbYqnb60/2LAScRfovl5s1RdGQLu7BIkKQn1a
	w
X-Google-Smtp-Source: AGHT+IGf6yhFgM7V9dSkmNMD310kmtT4NpPr6tml7YSLsMbfjuBNhYOZWImI0+hdwHwJZd31DH/Ogg==
X-Received: by 2002:a05:620a:4009:b0:7a7:f18a:e46f with SMTP id af79cd13be357-7ace744e486mr712325485a.43.1727333269291;
        Wed, 25 Sep 2024 23:47:49 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:47:48 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 08/13] mm: copy_pte_range() use pte_offset_map_rw_nolock()
Date: Thu, 26 Sep 2024 14:46:21 +0800
Message-Id: <9166f6fad806efbca72e318ab6f0f8af458056a9.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727332572.git.zhengqi.arch@bytedance.com>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In copy_pte_range(), we may modify the src_pte entry after holding the
src_ptl, so convert it to using pte_offset_map_rw_nolock(). Since we
already hold the exclusive mmap_lock, and the copy_pte_range() and
retract_page_tables() are using vma->anon_vma to be exclusive, so the PTE
page is stable, there is no need to get pmdval and do pmd_same() check.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/memory.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6432b636d1ba7..c19cf14e1c565 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1086,6 +1086,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
+	pmd_t dummy_pmdval;
 	pte_t ptent;
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress, max_nr, ret = 0;
@@ -1111,7 +1112,15 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		ret = -ENOMEM;
 		goto out;
 	}
-	src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
+
+	/*
+	 * We already hold the exclusive mmap_lock, the copy_pte_range() and
+	 * retract_page_tables() are using vma->anon_vma to be exclusive, so
+	 * the PTE page is stable, and there is no need to get pmdval and do
+	 * pmd_same() check.
+	 */
+	src_pte = pte_offset_map_rw_nolock(src_mm, src_pmd, addr, &dummy_pmdval,
+					   &src_ptl);
 	if (!src_pte) {
 		pte_unmap_unlock(dst_pte, dst_ptl);
 		/* ret == 0 */
-- 
2.20.1


