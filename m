Return-Path: <linux-kernel+bounces-339974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8923986CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E691C21334
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7D18D656;
	Thu, 26 Sep 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Kn7Qa/C7"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6092B18D64C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333287; cv=none; b=fcKVEwRzUI5hYeUB4v+8wRpgzpAu3NWwASovPTOPwpIGzU/UoHYNE1bNjlN5CPVxqU+VzADUD8k+VTmtxj+zvHtZAyCgvg9wmj7FOcU02zVXNWDobWwAbPeEUTYe9rYpv9MCvAizuHJF+hIr8x5+4XNCgS5j9fEjmKxzELzoS3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333287; c=relaxed/simple;
	bh=ksedbhOfsf/xVArskq0f4ybneNoWGq+FSHDnXQ6TWpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r9IZecOz+LX2hMpCtZHjE9U9xAqgT1ZhLq8LkR3wutKbpUvqK8QmXi+HI0aY7nuzoAdujW9CYOxXtBC/cyWdj3wfAqze5LT1vfeYrU9fzbmu4sTbGNxXB4ovFtcV3MPVx4Rn+f2b+wIfNawDhwJRP8cJO0kYJNUQLk1ifDRI/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Kn7Qa/C7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-457e153cbdcso5178971cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333284; x=1727938084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsEgu/iD0T6JQDFamAgFHiL1Lm0nKVk+wAfYQhZRThE=;
        b=Kn7Qa/C744SfmKnSmPsS9K6Wak7ANO0QfTVuMqvVMHokuC/jRw2xoGRAu97KHygYx0
         bFQHjDgrXGxNSwwVK0PHIFMVWL44OeBT1VvWa/zIB1E59n0XIq+aweUJE5pEDhUtutTo
         xXHqx0uYgRr61zK0QQhOC1WWT+CUjwGpuxuGaE5n1HzHm4h8XaL/gzqq91eFDJlBdaAE
         +ebvy9yBrMPlWgPBKDAJWqC13+Z5l9ITknWqM8PK5Pyz6ljmHaW5UjScPRgiVypySI09
         Jahi/Ws/hYCqk0/lY5aOdxCEp/XisdZLHdWA6Rzlx8LlBaSSZoMgSQ82TU9tUoNTdX+/
         gs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333284; x=1727938084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsEgu/iD0T6JQDFamAgFHiL1Lm0nKVk+wAfYQhZRThE=;
        b=k4WTRVDmHkUX7saspDJzcRlN1OfEbGMBCOWmzQ6RSTXp4L0b+QLFAh8puxflIBUWDV
         jGki0/4pfTvZXa/C8NjfbCy8UuuqaLeL8+XKsw0yJDx+z9QowtNyggqxCaGuGr/SVd8Q
         reg0hTvpm46BU57vdlq7DBB5Y47EmY0Am3SXNV25fXBRDHZJNPue1+Raj5Xty5fXdX0o
         C77XsvK1fBBhzggeSn4bmRTs4JkN3UsofcKtdZVw8L6dMxfuOgHtO/4OPYfOExBJjQyx
         oYpr5lSIhij1l8PJHRyCMeQrmepDzKSlcc9g0i5RVLP66fQNGsYJ2Aq83jMTThwwoivt
         9R8g==
X-Gm-Message-State: AOJu0YxR7nwf0J7v9OFABrSXq5vT5IgrRQM1yiKyFhDxOyOcEfgl7mR4
	Rfab/4oBtwbx5qhbstYVS3wQ4LgS/Y8cxIButcjpMf5aU1OOqZxw6TtugquG6dc=
X-Google-Smtp-Source: AGHT+IGAlBKd7aKCt6XxIcAXM/Sjs0v2+e+7/droKiEQYGe4LhoKPN6bWAepHInU8bkNuwlluGjQYA==
X-Received: by 2002:ac8:7d4c:0:b0:458:4aec:2749 with SMTP id d75a77b69052e-45b5e045e56mr87889061cf.57.1727333284339;
        Wed, 25 Sep 2024 23:48:04 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:48:03 -0700 (PDT)
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
Subject: [PATCH v5 10/13] mm: page_vma_mapped_walk: map_pte() use pte_offset_map_rw_nolock()
Date: Thu, 26 Sep 2024 14:46:23 +0800
Message-Id: <2620a48f34c9f19864ab0169cdbf253d31a8fcaa.1727332572.git.zhengqi.arch@bytedance.com>
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

In the caller of map_pte(), we may modify the pvmw->pte after acquiring
the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
this time, the pte_same() check is not performed after the pvmw->ptl held,
so we should get pmdval and do pmd_same() check to ensure the stability of
pvmw->pmd.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/page_vma_mapped.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae5cc42aa2087..ab1671e71cb2d 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -13,7 +13,8 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 	return false;
 }
 
-static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
+static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
+		    spinlock_t **ptlp)
 {
 	pte_t ptent;
 
@@ -25,6 +26,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 		return !!pvmw->pte;
 	}
 
+again:
 	/*
 	 * It is important to return the ptl corresponding to pte,
 	 * in case *pvmw->pmd changes underneath us; so we need to
@@ -32,8 +34,8 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 	 * proceeds to loop over next ptes, and finds a match later.
 	 * Though, in most cases, page lock already protects this.
 	 */
-	pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
-					  pvmw->address, ptlp);
+	pvmw->pte = pte_offset_map_rw_nolock(pvmw->vma->vm_mm, pvmw->pmd,
+					     pvmw->address, pmdvalp, ptlp);
 	if (!pvmw->pte)
 		return false;
 
@@ -67,8 +69,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 	} else if (!pte_present(ptent)) {
 		return false;
 	}
+	spin_lock(*ptlp);
+	if (unlikely(!pmd_same(*pmdvalp, pmdp_get_lockless(pvmw->pmd)))) {
+		pte_unmap_unlock(pvmw->pte, *ptlp);
+		goto again;
+	}
 	pvmw->ptl = *ptlp;
-	spin_lock(pvmw->ptl);
+
 	return true;
 }
 
@@ -278,7 +285,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
-		if (!map_pte(pvmw, &ptl)) {
+		if (!map_pte(pvmw, &pmde, &ptl)) {
 			if (!pvmw->pte)
 				goto restart;
 			goto next_pte;
@@ -305,8 +312,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		} while (pte_none(ptep_get(pvmw->pte)));
 
 		if (!pvmw->ptl) {
+			spin_lock(ptl);
+			if (unlikely(!pmd_same(pmde, pmdp_get_lockless(pvmw->pmd)))) {
+				pte_unmap_unlock(pvmw->pte, ptl);
+				pvmw->pte = NULL;
+				goto restart;
+			}
 			pvmw->ptl = ptl;
-			spin_lock(pvmw->ptl);
 		}
 		goto this_pte;
 	} while (pvmw->address < end);
-- 
2.20.1


