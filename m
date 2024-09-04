Return-Path: <linux-kernel+bounces-314574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2425496B54F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF25828CF14
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8691D0148;
	Wed,  4 Sep 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hAV1l7pp"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291421CDFA3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439311; cv=none; b=bcq3MGD9rGfCEMgGKgjjLKJKV9TnWf/oo6PaKnqCmgtDJHhY3hUUJJ8WwpwyMqRbGFzDjDZG+n1+ccuqA/ewAwE4wen1MtjdcQ6ny4YlgoGGfPHjqd9viXkh2OIwyGCqEzD3ZqAwVqrNIEQcWgLQWMHBUKnRdtKkZKqvilhgpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439311; c=relaxed/simple;
	bh=zVU5JZ4/ifmYtzZKes/SHFL4sJ0rbrE0x8fSa2fyEJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBpnqu+IQM3Z2z1eopTAQpLtAsDvWn2dhSMSHeilL0j8vxOxwE/icZtdhawD+t8kUVMnvQxeGLT0QvvBia6i0beAWS03ibyGTjuVwmUMX8k+sJjIkmkc/u6Jrxhta+isJ7K2FOlZVAri6RTx/21F0+A0gnof6Cg/mZhO0o9eYcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hAV1l7pp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20696938f86so13468105ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439309; x=1726044109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DklgHNcyYpWTok/ex913aKZBAOiPUnESXBkqa0TTMVk=;
        b=hAV1l7pp5zvXkfO+L/hBkHrbueUVLJOQpusLGWoAtbzlEqSR/zrTtPuEK/1BV0QBWU
         hc7TfzebAV2FVLT9PmfClLab4s2lYLNsw9O85CSFuBDele81ggwmUqtf/4ma1of+fB8l
         pEG2COE8DmgYFFXpnWkDIF5JaxLwoidCLQYDKdjd6edQlAS6/RbkfwQ5S6CBBF9T9oOs
         EF4Gd0tlTTsneGaClQtj4rWILgZm0fPwWbtIx4znj3FUMx4Xr/otVi0qqqqwRz95Cg+A
         Rdezyxa0uzqlHSdFIaydGwF0OfXGFiytV8Pmowk6R0if7w+JI+Wzi8/l5ppGk4KCA10i
         rJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439309; x=1726044109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DklgHNcyYpWTok/ex913aKZBAOiPUnESXBkqa0TTMVk=;
        b=GeECGDPzsf3ZyANKL4eLkhE607rHUVRf2/wTv8aqph6aasFWt52bMWM+dlQYYkyzez
         bR3SdkafHiiu2Pr99DcynADKtscBuCCsRyDvxrH8fixeObX5DKmBvZv5N2GK/Psugrfw
         v3hgz/ed0tKhfBuZhIrxjT5TrPl9ng6wm+wZfPtJ9O+NK3lG7GhcuSgZ5H8SjaFLIUvl
         wPkGCCUEalGUNCzV5jkGTBKo5Bgz8CRv6mde51IOO1P1rkF28K7FIAAZEVGmD9pqpUpz
         T/1lyVLUehuty8SbZYJ8p4wr9FxZBksRyCCAfpiMmhPcBOFCSTL1mg59z1L3TdhpIjE/
         ptAA==
X-Gm-Message-State: AOJu0Yzd6RJj0Ry4FAUV++2rT7tAd4YMJvNsJXq28Nne7eHJq5YuSYCH
	UzvWu4zCmvE7vSS4hD0Ts7CPeKUlvVq5HeR+Te60qMNgNKfqKCwzLqA2oXA0W2Y=
X-Google-Smtp-Source: AGHT+IErn+gfx0jNqN8oYReDzi5ALFGdG/LuObb3FXvUpU+trUkKEzs/YdM2MbdzLHq+FDgFhXw6+A==
X-Received: by 2002:a17:902:d50a:b0:205:6c25:fe12 with SMTP id d9443c01a7336-2056c25ffb5mr96453155ad.34.1725439309345;
        Wed, 04 Sep 2024 01:41:49 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:41:49 -0700 (PDT)
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
Subject: [PATCH v3 10/14] mm: page_vma_mapped_walk: map_pte() use pte_offset_map_rw_nolock()
Date: Wed,  4 Sep 2024 16:40:18 +0800
Message-Id: <20240904084022.32728-11-zhengqi.arch@bytedance.com>
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

In the caller of map_pte(), we may modify the pvmw->pte after acquiring
the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
this time, the pte_same() check is not performed after the pvmw->ptl held,
so we should get pmdval and do pmd_same() check to ensure the stability of
pvmw->pmd.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/page_vma_mapped.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae5cc42aa2087..f1d73fd448708 100644
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
 
@@ -69,6 +73,12 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 	}
 	pvmw->ptl = *ptlp;
 	spin_lock(pvmw->ptl);
+
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pvmw->pmd)))) {
+		spin_unlock(pvmw->ptl);
+		goto again;
+	}
+
 	return true;
 }
 
@@ -278,7 +288,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
-		if (!map_pte(pvmw, &ptl)) {
+		if (!map_pte(pvmw, &pmde, &ptl)) {
 			if (!pvmw->pte)
 				goto restart;
 			goto next_pte;
@@ -307,6 +317,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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


