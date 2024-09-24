Return-Path: <linux-kernel+bounces-336590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C5983CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553A41C22870
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92F84A27;
	Tue, 24 Sep 2024 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="elf8R8Ou"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8484A22
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158292; cv=none; b=WtgWAjj9fB0ZvkygYnL/GX6lr4WGxDdQDiU6qrKoJO7dhXIvwJAGFPRPObzDTD3hUEmAIQ0pX3Xy1yTbcWBoayW4zIsj5+TqB30vgLOS7t9QtjsBNedtrqMRMW55Rb4823IgvgF3HJwbVb0DjiOlAtuksNEr/cpAp6jmrWF/0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158292; c=relaxed/simple;
	bh=i+oN1kWXkG7Mo/Suv04Lea2nSB9WperDd3TZtQVOhCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMU0o14gfTwLkwhWRmhiTlheVXimcJJr+xooBckzm1pXo8iNA0h3eUJJYko5FSxfUB625fjYxxLxLvQn1bDIDcoB8nrgMql3Z9eSiT1NNDtXABGJ2oF1C8GE/McfKniJfgR4XzFEUD/6z6NW+7N+TY8PwKU6XlplqcpQHAOG1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=elf8R8Ou; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2055136b612so61987355ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158290; x=1727763090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxMRr8GFLSu76sONoxW9925XRbgCGcQv9BKiL/bcjLY=;
        b=elf8R8Ou887fRIUdHkxvQ2jFLR2BeH/wUg8Wt6Gfrf3C4XaKjxIRm68nQtgpiyZP83
         A0iddivabe6fU5WWE/WcNv37WS9FWlt2SnG85bJV91iUq7YRlOhiuawCSoUUrKiC1yOs
         ycAQqxjgqpF1vydw8Vje/YbxAFJoPwomc/HkMF9rgdNVIV+d3iNdpGVqF9Tfrq1oMJOl
         QQaqx2AvbVSjhyDWymePgfW+9gj7uifsTAbXV1ENjBOuKfBFZpro0sOJp/ivB2Q4iMTE
         VyE+m8IzW3f2XH11DNKouzX9qF+lXG1RhA7q3Ll9ulReGvC86z2x5Qp48YTyyyjEvMl3
         mjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158290; x=1727763090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxMRr8GFLSu76sONoxW9925XRbgCGcQv9BKiL/bcjLY=;
        b=jrUXXrr2Em65liQYY7X2zFxfMIAnSKaKdX3L4pMkuZtF7YefWLmQk+etphvQ8oPdFs
         Bb9H83IAJRiGm7bc4DG2WuFaKa3Zkb54Ef/UCKpiZvM+88Q19lAQmosr9uIxow5BJa30
         tS6dyZRsl0dnDSzsWfIxn+EEq2MOb5Loei+js49C1j+R1E4AQGg/ZNDJJkGSqcGMEVH7
         jg5b6YpxLOPC2mt26AuX+eeMXzulrOoG9L3H9G5i3cy0jpCATU34ZJYCD/eJZ0Mjfjno
         /X8u2FS9Qy/WWWkqoSe9lTUPIKLjry9R2vg5evQD/YgEE8DwLiqCrisze8empFIfJvdh
         1giw==
X-Gm-Message-State: AOJu0Ywv3uji43++jga8aNGD2ofOwFHdJ/2vFqBo2SI3B3fpZ3mdXuIL
	biUOVstf0gV3r1oSQ3UEV1XkkOtZWB9NHMwK9UjqfTgu2LflREWfygZj6TY7Vxg=
X-Google-Smtp-Source: AGHT+IGuU8VFNPNElLsd/e1qu4NWf2AelC2dd7GFKvCMDCyRlgITelf6+XB9J1CmvT70UykrnIRqmQ==
X-Received: by 2002:a17:902:f542:b0:201:f70a:7492 with SMTP id d9443c01a7336-208d98603b2mr202721885ad.53.1727158290456;
        Mon, 23 Sep 2024 23:11:30 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:11:30 -0700 (PDT)
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
Subject: [PATCH v4 10/13] mm: page_vma_mapped_walk: map_pte() use pte_offset_map_rw_nolock()
Date: Tue, 24 Sep 2024 14:10:02 +0800
Message-Id: <ecffb7d71363fa79048c0a929780215e0fa93491.1727148662.git.zhengqi.arch@bytedance.com>
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

In the caller of map_pte(), we may modify the pvmw->pte after acquiring
the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
this time, the pte_same() check is not performed after the pvmw->ptl held,
so we should get pmdval and do pmd_same() check to ensure the stability of
pvmw->pmd.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/page_vma_mapped.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae5cc42aa2087..6410f29b37c1b 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -13,9 +13,11 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 	return false;
 }
 
-static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
+static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
+		    spinlock_t **ptlp)
 {
 	pte_t ptent;
+	pmd_t pmdval;
 
 	if (pvmw->flags & PVMW_SYNC) {
 		/* Use the stricter lookup */
@@ -25,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 		return !!pvmw->pte;
 	}
 
+again:
 	/*
 	 * It is important to return the ptl corresponding to pte,
 	 * in case *pvmw->pmd changes underneath us; so we need to
@@ -32,10 +35,11 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 	 * proceeds to loop over next ptes, and finds a match later.
 	 * Though, in most cases, page lock already protects this.
 	 */
-	pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
-					  pvmw->address, ptlp);
+	pvmw->pte = pte_offset_map_rw_nolock(pvmw->vma->vm_mm, pvmw->pmd,
+					     pvmw->address, &pmdval, ptlp);
 	if (!pvmw->pte)
 		return false;
+	*pmdvalp = pmdval;
 
 	ptent = ptep_get(pvmw->pte);
 
@@ -67,8 +71,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 	} else if (!pte_present(ptent)) {
 		return false;
 	}
+	spin_lock(*ptlp);
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pvmw->pmd)))) {
+		pte_unmap_unlock(pvmw->pte, *ptlp);
+		goto again;
+	}
 	pvmw->ptl = *ptlp;
-	spin_lock(pvmw->ptl);
+
 	return true;
 }
 
@@ -278,7 +287,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
-		if (!map_pte(pvmw, &ptl)) {
+		if (!map_pte(pvmw, &pmde, &ptl)) {
 			if (!pvmw->pte)
 				goto restart;
 			goto next_pte;
@@ -307,6 +316,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (!pvmw->ptl) {
 			pvmw->ptl = ptl;
 			spin_lock(pvmw->ptl);
+			if (unlikely(!pmd_same(pmde, pmdp_get_lockless(pvmw->pmd)))) {
+				pte_unmap_unlock(pvmw->pte, pvmw->ptl);
+				pvmw->ptl = NULL;
+				pvmw->pte = NULL;
+				goto restart;
+			}
 		}
 		goto this_pte;
 	} while (pvmw->address < end);
-- 
2.20.1


