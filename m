Return-Path: <linux-kernel+bounces-314579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E896B555
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C72DB251AB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AD1CE710;
	Wed,  4 Sep 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="StYn44fm"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F971D0DE1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439338; cv=none; b=l8GeGsSF5OZLSRyPcPUf6YLaG2LYpGHT+Ukxk7/gXVU3RYTTI3Rb+GcF80aAPayotluutCu93djYziok5vjplM1G8tCw3aKn5/7pYlCRNd4/1KNpg4E/aGVaovQks4yl5Ksgcam7iNNJqEJzoOvMHlZudGirMmEbXCj/8fkRhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439338; c=relaxed/simple;
	bh=8AzoJE8l7/0rgAUJHjuIMB0gJiKomtVvJS2dRHBDsH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f21m5StnWCWl/QKS8IX05YqkcTXjko+nMIiTVbh8hHaRlr12VSxWHS+lagIUfgOpQcakwcMeJ1zxT/KHXIiPu0nHxD8ZX00TrjD7c1yjOlhrwQKmCQ3JylykGQKvj68Hk3oPrNURGH+FOdTrJE2OYKySXM0+Kg23bOONnTYsEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=StYn44fm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20551eeba95so27654975ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439336; x=1726044136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylbiZHnndQyBxRrEPbsYoqCd5Ue19pmhRhZr0okk+70=;
        b=StYn44fmgOEupfxYXUiRKwXo7Mnkef9gc/TMa31YkVOq0QqwcEDAcqRAgxfN3Z5Aw6
         QKOZJ6eK4MQIUqWMmiDPrbMHDsdYFUlDLwJKt5fJ4GT3u/xWlUHm6xdSxcurS7UpQnWH
         8UaBZa7764uoXRkD/uz8hc0ld+maAbYICvWWyswRJ5Hgq7lJRAFOJcTT6ftaHl+XOJKG
         czK8XJPdlBXRYttavgvnSmfKb14jHp/BfDjgeAZbDgVfUVu6sHI61gap9XkuIFW26BsA
         orvpTSifteOrw57BbcRL+2Xp9gxdgp3nSHGY8ztoPqbw+swZUSCVNjTDXueF6R7vnkKN
         eZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439336; x=1726044136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylbiZHnndQyBxRrEPbsYoqCd5Ue19pmhRhZr0okk+70=;
        b=ncvzdEopC1drGGxx67mcaOcBR6T5R5slXzCvp6sJX1tFoGbWPbCXs259zI3vel4Fm9
         m7asLnow1CehbXWuSMWekzPhY1iSLW1xUPq5ISM//n4Na2jmKv04NTsWHRkLJ2eDtzHW
         VcEE+csfxqt/D09AapSmki0nnv6D9tN1rBM5VunxonrB49xTNyQC/+n5oCuHet8xyuFv
         XIOKdIoQT+lnZvaS5OKDhnFLW6OW6grSYu1Y+JPcSe05f1MOR146FrOQ4Vz+mL8wl/pV
         Yg9gnBQeqdjST2DDToWpE3vKbGQUM2mB6YOOVIbYk+jn9OMRMbrWK/EDvC0uPv3LxvOX
         DNNQ==
X-Gm-Message-State: AOJu0YxqPC3tl9lFBEf5DAxHroAr6URhgZ44zN0S4aZqXxBzAD90XjkB
	vVG4/Q94jgxlGUA+Oup99rC6roahlOg/gCIZr0WaJOHQsiZ0UAlAqUEK2PySNEw=
X-Google-Smtp-Source: AGHT+IGRRbNTDVHBE5FEDByUohEYiQ4MupDiF5X1fYOKyMaX8J1f74Xy7lHxJ4SbBUityp3jftUwsg==
X-Received: by 2002:a17:902:e848:b0:206:c43f:7896 with SMTP id d9443c01a7336-206c43f8dd5mr2410565ad.21.1725439336115;
        Wed, 04 Sep 2024 01:42:16 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:42:15 -0700 (PDT)
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
Subject: [PATCH v3 14/14] mm: khugepaged: retract_page_tables() use pte_offset_map_rw_nolock()
Date: Wed,  4 Sep 2024 16:40:22 +0800
Message-Id: <20240904084022.32728-15-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In retract_page_tables(), we may modify the pmd entry after acquiring the
pml and ptl, so we should also check whether the pmd entry is stable.
Using pte_offset_map_rw_nolock() + pmd_same() to do it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a117d35f33aee..318cc3eefb040 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1724,6 +1724,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		spinlock_t *pml;
 		spinlock_t *ptl;
 		bool skipped_uffd = false;
+		pte_t *pte;
 
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
@@ -1759,11 +1760,25 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 					addr, addr + HPAGE_PMD_SIZE);
 		mmu_notifier_invalidate_range_start(&range);
 
+		pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pgt_pmd, &ptl);
+		if (!pte) {
+			mmu_notifier_invalidate_range_end(&range);
+			continue;
+		}
+
 		pml = pmd_lock(mm, pmd);
-		ptl = pte_lockptr(mm, pmd);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+		if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			pte_unmap_unlock(pte, ptl);
+			if (ptl != pml)
+				spin_unlock(pml);
+			mmu_notifier_invalidate_range_end(&range);
+			continue;
+		}
+		pte_unmap(pte);
+
 		/*
 		 * Huge page lock is still held, so normally the page table
 		 * must remain empty; and we have already skipped anon_vma
-- 
2.20.1


