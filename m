Return-Path: <linux-kernel+bounces-296776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE40D95AF1C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF741F26A37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC8D18859B;
	Thu, 22 Aug 2024 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BSUNtw57"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D11885A2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310887; cv=none; b=pkdhGgvLTOJoxRL/h9C67sOVuVVtWPucaOoNcz+jNgIacJBQc3069IBbUvz5PyesBclkHPRkbuieQsxQzx467KG1Bsxy9Ih3ZWA6J81Qj86BWHxg0dB6fKpVvw5UjazK26M0G3lMgpfy17gLfAOySjiSbzEqyY+NU5idtxAk8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310887; c=relaxed/simple;
	bh=NDVt8UFk+zbfrRMfMiJ0eEKdBEzxM75Y5QRnhcSFNmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4nrUdLEq1WxLgbdwLDAv3RSh6mgp74xIvo1T9D+ScuEC0iXLFy0pprX2dhQHNno+9MUN1+Q98xhYJA59OTOa7BnazwcUQAJJGb4vQTRWnxC+YZBwKU2zjka+/dyWcOZaOHqcAMKLSFvnpdnYb1fSVyDRMXc10GBO8Al0258ESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BSUNtw57; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db2315d7ceso298595b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310885; x=1724915685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crbz/R3rJcbpbcovfp9fh4ozsAEMZSaAxrx7zvZfRRw=;
        b=BSUNtw576jvEjIJoJ9xgAAwGsuSieh8ylg8a5IgnAubAVyCc2jyMnkLhSE+C4uBAow
         TegzwyVMOSAWIwytdourj9Qu8i4ywKkofc+PPJKX6G89ErjdsjXwlxP1UIO/oBQc0+30
         WaOGPr4B9MkyehQJ0A2Zf82WELGkIjjL2rGNQ3VPTa7nTzNdQa9D53poRsiQKn7eEk3R
         np3iOayYoPW6CJ4KUz2R6EkqQtHCuhn22jIvS9bUt2lALzUxHFu+Kp/HU2o1Wm9VcDE0
         Ytx7+jQLbq7T9SfpIvOUHi296FCCM+vsTPdolPwZVJIKAqezQkSF+mDFYHqt4jCpyieL
         KdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310885; x=1724915685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Crbz/R3rJcbpbcovfp9fh4ozsAEMZSaAxrx7zvZfRRw=;
        b=T84h6pXSkv1gNHTxMT87VtbYkkS3R+DixNp60tDLYZ0NPsOiOfmdtx1j9JVMGCrQs5
         2Wm9WQkfFD3Cx5w+fi2gPfFLqf8230YXVVlE9+gebxo8bjbpzC2cWZ0exPF7YXW/aCA2
         DYL6c9ZCDWInYQxqjWpuJkHzsp2iX5lmny4ju+qop8P3cm+vg8ByuLsb/P9jiE5BjM2B
         j5aWb61Cwlar4+5ORuhWOqq1R7Jw8Tl3sd6Gvl9RejTrddl/5XZGZ+20m8min68LjeDe
         sg02Rz4NyQ/JCShB9fVo1rgIt8SW3Rbfrmog8WLZbtjcf94OK0T/FjVIYkWnJRNNzN8D
         he2A==
X-Gm-Message-State: AOJu0YxNMWaMhkBfSB595SF6XEiWF0uVBncwIN4gR3edo8Spx699bPAE
	MexhO3t9B3YgGphxY51LFbSzGDOI0HW4MOMQbvijahyKe+aVSbB/kGtaNf5V0vo=
X-Google-Smtp-Source: AGHT+IF73IAzwqsx0nomJCVJryAV7cndKc0EgZ0+2TYoDy25bfQlq+9JSwXFUBQmZZcxXSkt111lxw==
X-Received: by 2002:a05:6808:d46:b0:3d9:29c1:be5c with SMTP id 5614622812f47-3de194fbf2bmr5329807b6e.12.1724310885053;
        Thu, 22 Aug 2024 00:14:45 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:44 -0700 (PDT)
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
Subject: [PATCH v2 10/14] mm: page_vma_mapped_walk: map_pte() use pte_offset_map_rw_nolock()
Date: Thu, 22 Aug 2024 15:13:25 +0800
Message-Id: <d200bf710fc6f11202ea2d777ac2eb9f7fb0c6c9.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the caller of map_pte(), we may modify the pvmw->pte after acquiring
the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
this time, the write lock of mmap_lock is not held, and the pte_same()
check is not performed after the pvmw->ptl held, so we should get pmdval
and do pmd_same() check to ensure the stability of pvmw->pmd.

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


