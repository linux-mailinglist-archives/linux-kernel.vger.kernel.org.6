Return-Path: <linux-kernel+bounces-390147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E5D9B7624
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E6A284D16
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D2170A26;
	Thu, 31 Oct 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ON9OUtRz"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC9155333
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362455; cv=none; b=Mj+HwqDe8QmR6DUPf2RMIUPTvJMoXhZRRyHO5KdUhraxlX4gI2VD27CiRwXA/MWSzTqEa5MZed+cT7orUsE6aYyaoT33xgNrP9sc2i6Q1fzIHcBGNiYgGTxjkrJNXUFgKfH1SX4GtcPd6Tih69GT2U1YjYOS1LVd8Swu8ROU4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362455; c=relaxed/simple;
	bh=zjp+gQydTtb+snYiIz7gJ7pjUJX6WXPqJzZSVREH5I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+KlNw8qVfYjb3MOIOa2GWLOV8n7Ut5E/BgadZT/q7YQF7eb1xsbLNQ7VcM/vj2PQ2eHSCae15PN4zIKsBsy55GoEqw5NFNPS4e+kjVyLrLkMl9xs/Et+5QLh3adRN2bhtlHEryiznzWZvLfwjVXJYHSyHnCqhN/zzFKyEAaZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ON9OUtRz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e52582cf8so494581b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730362453; x=1730967253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipuWYZPCHxpoUpiQDdIApzlSejCgHBDIxG7j4EZzxr4=;
        b=ON9OUtRz8eZAjgR/FDsgZgn8votKnT7IlO/IAiYcynSSyE7l3QtOtGUlNry42B7f9h
         lKAs+vFHmi4cGD3WLom+e0vviDi+nk2I87eKRidzengD2H8F9o/IAnDyl9P2wbQdI0Kz
         eCMTugrFqFoOdoq+juMZaG1IBLLBvmW18zWmyG7AdZbOqjOko9RIc9v6m5xtp/zjyyFQ
         oEI777QXlL1rVCReiVkxBQ7JmIZ5gfLDmnF6sXOXujYNswulhDLasrDhCFLxmP2+NPcF
         SZQw7s5kd/OBJvR19o8vlZQJD7SW3x4/Dn8ydq5FJsn8tYXZaT98g/Xd+NgiZKvrbOpP
         kTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362453; x=1730967253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipuWYZPCHxpoUpiQDdIApzlSejCgHBDIxG7j4EZzxr4=;
        b=fsy0lagM7Ia9/4gk5ofHFsfaRLGmLKae/WSaHCPcPO/1VJugf3DE+jPGZKZT027Axv
         P4567QKpBFVikqrM/x5lk4IH5T1Zjg9bTgu+XP9EY389r18arB/NlrbcRNgC+3A5/1XA
         vQIdxaXEPQMcT6TrN4hbn0ea4JkPNftm686T8tUUooCadUy+lIWlJb3B4+x0HHZaoetP
         xTE5r4mVHEwMjp9KqDePumBXVVx68csEdzbAZjN0sUweffXf65yRulskM39qAx+/tKVz
         mF/zzUioPhzS1466iFIki7wQzTD+nWEcNKu4vSzDLCVUcmFPmSXL66q+6h7SeL3DM56p
         buuw==
X-Forwarded-Encrypted: i=1; AJvYcCWInVuxBnEDn5XpjMl9ONNnFXScnq30FOr2u6sCIX1MXGb9mgk/JccjWwr1DW7rJ+fz9JMdbkroKn7RVc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoYEjhMs0YrZs1US+HXe9XguQPOab/mMC7ti4go/H/t3boj+w
	R6nw0/goK8pb6YIh/fxIeTssCYaUWlYaa1LMckXZ/bYfHnS/YutjXxw3Jw4W5uA=
X-Google-Smtp-Source: AGHT+IGhQTI8wahkjaT4dlfz/gtxWygzYcya76y9Il/Jpy4crLp7RHv4SMqkN227j2dZrXUEfJpRWQ==
X-Received: by 2002:a05:6a21:3947:b0:1d9:3456:b71e with SMTP id adf61e73a8af0-1d9a83c1926mr23625663637.12.1730362453050;
        Thu, 31 Oct 2024 01:14:13 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9201b2586sm5163996a91.0.2024.10.31.01.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:14:12 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	peterx@redhat.com,
	catalin.marinas@arm.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/7] mm: khugepaged: retract_page_tables() use pte_offset_map_rw_nolock()
Date: Thu, 31 Oct 2024 16:13:17 +0800
Message-Id: <4c3f4aa29f38c013c4529a43bce846a3edd31523.1730360798.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1730360798.git.zhengqi.arch@bytedance.com>
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In retract_page_tables(), we may modify the pmd entry after acquiring the
pml and ptl, so we should also check whether the pmd entry is stable.
Using pte_offset_map_rw_nolock() + pmd_same() to do it, and then we can
also remove the calling of the pte_lockptr().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6f8d46d107b4b..6d76dde64f5fb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1721,6 +1721,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		spinlock_t *pml;
 		spinlock_t *ptl;
 		bool skipped_uffd = false;
+		pte_t *pte;
 
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
@@ -1756,11 +1757,25 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
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


