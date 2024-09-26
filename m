Return-Path: <linux-kernel+bounces-339973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB84986CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC81B255F2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1041118B478;
	Thu, 26 Sep 2024 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EvJ6YCzX"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A618786B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333279; cv=none; b=hXN6hd4Rn2wgLgKH+AHnyC8QVoNeF1G9sPwywOd1GKC/5XgcLypZfms8+Ev4WwtNzb/Plqj0peZP3JRpiDJqvcWvcoSQEQqPsPDwN9Z4XynlNEkU6VDCN1mF+4i7JXCVZY+70jcTAqFq1nP1KGjzfZteARIGnjrA1+udg6ZMBvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333279; c=relaxed/simple;
	bh=pj4lw9RRA4PWKbqJxPwbDgZhVSrxJd4D2Kzv+dDcxPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxL3b4XfRRr+UggRxIRhAaaKztFszG44CErZSb+hv4okAvvrPpVfS5XeTg0POSUdMgLlUPmJ6JXfxML2EZYmWj62wyhnCeYlE6hnJ0ssK1DCRAVTd961preIhCEnl2cnxWSAyCNxA7CFAJjzq8k608WtsOUcBqoYi7e9pMjFhSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EvJ6YCzX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-457ce5fda1aso4651191cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333277; x=1727938077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHtLGGTaDvd+j7nlO+D4nlmKtDmH5wZnqdyAY1Z6B8s=;
        b=EvJ6YCzXlTBpt8XPQCDUn3Egcf2SJo0SDZwKcnM82A60qMd88bZpOzJ4oC9gXVjOP1
         FWvCKoZVPV/hsIjq2NI6IohY/vQ22Mg/iCDxV9AH5M9J870cMBAD4jF3t/URxgbNrmDL
         yfA2LYlCYTOebr1Vut04/KkEYwZZzYO0GbHZY0ROsjS1AYPLGSY52cfyYDP4eC+Xe3pj
         6DsLD/Xy/K7HLPf6IHH5pthfSbiJjefwyHl5b428PNnc8aE8TvxAi4ZGINJHAByfaKti
         +i8Nrg0lvJcFlMsLTBtaJCzIpVD1Zt0578yyQc4VIu926Ix+dDTmKJaDPqiYxoNFHjhU
         78JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333277; x=1727938077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHtLGGTaDvd+j7nlO+D4nlmKtDmH5wZnqdyAY1Z6B8s=;
        b=D77GqIIk2W8D0/tQ7Z+bgDmcS8uV3ZyfDHr4qf4jgEAAxNFSpYmEebBockzeiKtyj0
         LIJWt/fiA1CynM9Z3glwXbBLHe+98zG4m+dVam1mhPCFvSEfOT6O+lfz7f/RoOun3uhW
         P8ZN2Y3sl4SRHnp2i8i/GXWZlQkc/vwA6Gqzu74nuJQ8CnwFKUDitvUBfnjMY9oCAhIf
         yl3Rqxel45wFoUjFhpSfLXTaJfFQErfAV31XfH9qhEuhEuMgOcr76eMS+NW/SPXVK1rX
         koe3OpLVBwUqSc7qJeE8NyjidYFh80/CAeO6zDoWu76R6v+EdvSdtxB9jZD0d8IDXxKS
         yrRw==
X-Gm-Message-State: AOJu0YyZo+5NH/kX9Zf51bsxjpyN8GcagQNLKOwLHjgX72ZXbMruRB4k
	8VR91Wk46MjtfEzYUhtpUc1eBAKL4ESMhn+Bj8znj01ujMnUtYDbT5fWZLHINmw=
X-Google-Smtp-Source: AGHT+IGbo2MSjNAvLC3c2ApJAOpwKD09S+YUwBzMfKcY13i9YN/E+PXjNs0XRR1eOHqqnOUdrqUWyg==
X-Received: by 2002:ac8:7d42:0:b0:458:2ce1:26f8 with SMTP id d75a77b69052e-45b5e045ea9mr77074431cf.60.1727333276776;
        Wed, 25 Sep 2024 23:47:56 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:47:56 -0700 (PDT)
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
Subject: [PATCH v5 09/13] mm: mremap: move_ptes() use pte_offset_map_rw_nolock()
Date: Thu, 26 Sep 2024 14:46:22 +0800
Message-Id: <9d582a09dbcf12e562ac5fe0ba05e9248a58f5e0.1727332572.git.zhengqi.arch@bytedance.com>
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

In move_ptes(), we may modify the new_pte after acquiring the new_ptl, so
convert it to using pte_offset_map_rw_nolock(). Now new_pte is none, so
hpage_collapse_scan_file() path can not find this by traversing
file->f_mapping, so there is no concurrency with retract_page_tables(). In
addition, we already hold the exclusive mmap_lock, so this new_pte page is
stable, so there is no need to get pmdval and do pmd_same() check.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/mremap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 24712f8dbb6b5..9dffd4a5b4d18 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -143,6 +143,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
 	unsigned long len = old_end - old_addr;
+	pmd_t dummy_pmdval;
 	int err = 0;
 
 	/*
@@ -175,7 +176,15 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		err = -EAGAIN;
 		goto out;
 	}
-	new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
+	/*
+	 * Now new_pte is none, so hpage_collapse_scan_file() path can not find
+	 * this by traversing file->f_mapping, so there is no concurrency with
+	 * retract_page_tables(). In addition, we already hold the exclusive
+	 * mmap_lock, so this new_pte page is stable, so there is no need to get
+	 * pmdval and do pmd_same() check.
+	 */
+	new_pte = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &dummy_pmdval,
+					   &new_ptl);
 	if (!new_pte) {
 		pte_unmap_unlock(old_pte, old_ptl);
 		err = -EAGAIN;
-- 
2.20.1


