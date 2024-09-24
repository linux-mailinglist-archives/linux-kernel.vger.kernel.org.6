Return-Path: <linux-kernel+bounces-336588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647A8983CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38B01F233B9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250B577107;
	Tue, 24 Sep 2024 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RnszBx6s"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889549652
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158280; cv=none; b=eQW/5PIicCuiX58zbCz5Cua38lTmFzBO6PflnsZ36pArWtR0WtIiwFRLCG3oFMLdlSncNcm1shcp11cTEOzpnEj1pwcEpjd1Zyll+93w0j+wUEVrIPepN2pPmWIgN2PGByZteKyXuBNam/0zVfJwWzpo9VMqJgF8U5dS4eiRqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158280; c=relaxed/simple;
	bh=VqnJhrj6tVNjxXhKEF9Of8+QKuUBH9ccpJxvoP5+WEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrQv977a5XGP5s/nOBTpUm/4032HXo52toYb9eRYhFPaa5y+teFeeamCMLZqkzW0zvC806MZcMdT97+RLgFdcu4g4nKHXaQ6M9utu34HgwqKXtfOKm3PAdZurzGN+Jvd9BlQjSDYuxCmeAS/stZvqFnAJBaZPhmN+ZM1nxYwT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RnszBx6s; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2053a0bd0a6so50987995ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158278; x=1727763078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5exoCzehntR4bd+ahks+h4WFwEAjFaMLu5nKDHss+4=;
        b=RnszBx6sZzzPUvqhlkpV/5mW/lrmgkrfeRHnma5bxErfR4uXGEkAFenx5f7u8xg3Jb
         Lhh5of8gIRl9JmX9FEQ3t5wYgWcRs6q2DvfF8D3ZqS3LqWYc6AnhOzaiNbATnSqT0sdF
         zIKbaB7oqOZ8Q3DdQwX/ZtyELYEh0xhy1zzciXIvH/0sIu2x9mCjJ75qWAlXYSp+Se+l
         sPB3JvhVzlZMYhsLtEBjFjhuTgaOemTrOogGltITsrD5U5RKkYFWJxiiF/rqRDXO3PM1
         Haee8534RAEYCD9H1+PXm9s5Tv90R+Vwm0Z6YkfFdgjp7wKxIHCukD7Yb3ExiWwcfDKp
         ENIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158278; x=1727763078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5exoCzehntR4bd+ahks+h4WFwEAjFaMLu5nKDHss+4=;
        b=YOYEf4v4H38rBAegO+kZa45SQOeW0Lo4/w+5jDiR2DMnAN0Hb51dPGWV8r7GsN3itl
         WQpmXz2BLCEXxMjwgtkam9uP099KiiI88exj7R3Gh2f0PxFRi9kSru27Vn6Wsc5sebA/
         fkk301R1Cxcwhth1QM/P5YC80R/ypEodIVfzcxzi/L17sHgeR77DWvYCCLoLBHtb0UW6
         elc/kf6m2upT1WQ0MyTMTn8GLyfq8ZfpHRzexaQdSxl9zODSO4hey3ZOIO9EKSu7OwST
         yeiWWPwJjHvUVepeZf+zGh1ExwUHlPWA9PM3xwDojLW2Hx03F++3SOJSmNxZlH/rAwDZ
         Ox5g==
X-Gm-Message-State: AOJu0YzWM17Ot+8pz7zcbzT6ZyufNQYdBEITi0LC2aXppKXFqTH7tXc1
	vDZwJTYfOZ8B8wvixiiFbHP4UQ9csyhSsloJY4WCsAOAkZe7MFYfQmPu/T6por4=
X-Google-Smtp-Source: AGHT+IHw+OqtuQ5LCBY4YmqC9EJn7stUTlaTSc5oItaKMOqNO6mqJktvnwlzFLYt5xYGl9LymCl5gw==
X-Received: by 2002:a17:902:d50f:b0:207:1709:380 with SMTP id d9443c01a7336-208d838ede3mr189786005ad.27.1727158278506;
        Mon, 23 Sep 2024 23:11:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:11:17 -0700 (PDT)
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
Subject: [PATCH v4 08/13] mm: copy_pte_range() use pte_offset_map_rw_nolock()
Date: Tue, 24 Sep 2024 14:10:00 +0800
Message-Id: <b70b7cb91e000d540773a0e892789da64ab6c108.1727148662.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727148662.git.zhengqi.arch@bytedance.com>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
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


