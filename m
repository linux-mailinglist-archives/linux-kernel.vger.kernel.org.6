Return-Path: <linux-kernel+bounces-336586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE3983CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02031C227F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4AD770E5;
	Tue, 24 Sep 2024 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cBCKvAGr"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857D126BE8
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158267; cv=none; b=VBq7GGoL6qQH/FwVHlLYvtt+XoYDKDP4zLBx4IoGzT3yURudZK0XYMtyaHutn6ZoP7w4+g6trA4H87vzgSsvMYJF+Lc+QBY8wHla2n18A+pBRjuEfD6TfIK3jmw5BHy9WWLJFoVpADzJ9vGqis5q82hWVcj98g1zXzznR++H3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158267; c=relaxed/simple;
	bh=AW2pi97601MGuZiCOXDhP3jZoiCUTCuHUPQzcZePTCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBouQcU0axdfJBXXp6PeSx0tp+CwQtmawDiTcS4DLU6DOAusk3PKs3/l9s5SzZEGO0O4xi/hkqkth1gDTWWWBY/Nvnw2KXNi3/P3rp5gUjlVkww/yyJV2ICWu2mZWw2s1wHm3v8itpQ9NZ5ePJ1pp72n7J8vJfF9YhgmNzE4kQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cBCKvAGr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2059204f448so43655425ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158266; x=1727763066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88oX8R3xcxvOkzUvzbp2hva7xyyimZKCI3msRz7gwSQ=;
        b=cBCKvAGrulo/XUVYfJ0pCxmgoJp/TdbOYHnZqWqrjJ71jq4IFreTO9MKiEBEviH+vW
         +ObFOv06qZ1g/wMlnw1aEsU+YhvZXAbvuq1uxD8yaMg3/zfrLd/bcVK8wb5y03EM7BZE
         glVY+a7o1E0alcjCGozDdE6AHo9dJ5bT5+CI2AR5LHOT72svHCmk2kZm1Kg/BrvlXq20
         1lpbAcZe/V6vl7B8RIWJQ4J+H/z6/jpOvZNk1QPzbPowW7idjh3x46Gqw+gEm1CTMg1N
         JP7ZmLBwPfm7ZX8VqzeOdY/FaE4T4i5DOkCJC5BlZnEnX84kkZFqisdgwuKuuVcdPkda
         eYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158266; x=1727763066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88oX8R3xcxvOkzUvzbp2hva7xyyimZKCI3msRz7gwSQ=;
        b=SGjnFtEodfChzzm6qGQ3akD0L6sJ7fc3/1JvmgZNXAvtc3T8sLlKir35ZJ7paHhI2O
         /tz6LD3pdy2FLBzXfJSOyIanpm9UvoehTh7DahHIx8o7YS2wR9pmzbpY5gV4LJUbGfgg
         9LqAbejDCLRfjVamukVLIFaeTUvZNL7c510NKCORhZi/m7bCDKsvKkWEnn9tNzQYDWPQ
         DtfGrcIjapGTKcQK4xxu6fTP6mHzQf2Tzcwb4mhlEtZaK4KFuTWTm0gjLInSKx901ssG
         66L1h8qi3tcllRjjMc2LFWradlScdq7BIA4K+u5DAj+JjOU9m/kUoGx3Dkb59hGssU72
         ae2g==
X-Gm-Message-State: AOJu0YxyC05OBBTibsUsbpaQjVkcy0M8y5I9BbzKztL51Kc5PqmTqhCK
	GMOV/y5MtwTbzmGem1kADl+jRrzJafl4AZWdXcu770jhFhRHC7TvUoFOjIpXc04=
X-Google-Smtp-Source: AGHT+IE0gKFIx3/KW4QPIJwQt51ZMLGla2X2YU2KRRy7vcX0w9t/15+gAAip1FE70+J7SP+04M4CVg==
X-Received: by 2002:a17:902:d511:b0:205:7574:3b87 with SMTP id d9443c01a7336-208d980bb34mr182109485ad.15.1727158265764;
        Mon, 23 Sep 2024 23:11:05 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:11:05 -0700 (PDT)
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
Subject: [PATCH v4 06/13] mm: handle_pte_fault() use pte_offset_map_rw_nolock()
Date: Tue, 24 Sep 2024 14:09:58 +0800
Message-Id: <eed9571b3d6f260e6e9d571fcac8b1ce8dd3571d.1727148662.git.zhengqi.arch@bytedance.com>
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

In handle_pte_fault(), we may modify the vmf->pte after acquiring the
vmf->ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
will do the pte_same() check, so there is no need to get pmdval to do
pmd_same() check, just pass a dummy variable to it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/memory.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a245d28787034..6432b636d1ba7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5750,14 +5750,24 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		vmf->pte = NULL;
 		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
 	} else {
+		pmd_t dummy_pmdval;
+
 		/*
 		 * A regular pmd is established and it can't morph into a huge
 		 * pmd by anon khugepaged, since that takes mmap_lock in write
 		 * mode; but shmem or file collapse to THP could still morph
 		 * it into a huge pmd: just retry later if so.
+		 *
+		 * Use the maywrite version to indicate that vmf->pte may be
+		 * modified, but since we will use pte_same() to detect the
+		 * change of the !pte_none() entry, there is no need to recheck
+		 * the pmdval. Here we chooes to pass a dummy variable instead
+		 * of NULL, which helps new user think about why this place is
+		 * special.
 		 */
-		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
-						 vmf->address, &vmf->ptl);
+		vmf->pte = pte_offset_map_rw_nolock(vmf->vma->vm_mm, vmf->pmd,
+						    vmf->address, &dummy_pmdval,
+						    &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			return 0;
 		vmf->orig_pte = ptep_get_lockless(vmf->pte);
-- 
2.20.1


