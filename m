Return-Path: <linux-kernel+bounces-295117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E589596FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0131B222B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B311B1D6D;
	Wed, 21 Aug 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bpKlZ24o"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B631C2DA1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228443; cv=none; b=r/JvRCnAKvKw+/Aot6Dho8YbLJznThXrEZ2mhM6gKfVWaVH2FCEI6VC821aTnmCSGcRn0G08o0h2YYHuib67WNPymfh5+TQjcLdW7MqZxUZlWjNWL79oDYLSqNOrS8HL95+LY0yxwBQtjmPxwnaizZ+TQI/ltwPkSOOD4OH08EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228443; c=relaxed/simple;
	bh=jipI0HnrMJtWTaSzKSKu3sudEFw8XtUqiZMmeV6Lz9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEOZkXaoAzzaKjdu1vmo64rZ9l7k0OLDRoOQCwTpS+ZuFe5yqxT1WwvlN07sP1b1x6GMFIftnYKaiJAuuvyWZMsFd018Jsuwyj3f3e1j+HVa1xrXsOjbI3lzny0/Hz2cJZNDoHZTsilJx14Vi4cHIy4RnClzeG6YQARheipla28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bpKlZ24o; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so4316349b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228442; x=1724833242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOO3xScatAPPPb8tw2FfV0S/NtjYDESd+MYV0EHgGGs=;
        b=bpKlZ24oh+WPmHDChiWIFK1I46hMjN0WLjvPBs34Rmfr+eojdhxx7Eg78iyYfE+jDk
         ZCHcE24Ws7HAvAbEUl5SCJL4m78BJ0DuXF5Ya62DNg0YwIVhsze7O7+n+rjWgv4xCw2i
         +icApaxLoIb/LzWTMA/aLrhf+MPeVF6O1j5RqEqwgFFDY9wvvDds646eyKUJDP/1KUbk
         lqUDNq8R5nIEOiIuivBpUe4Hw4P+6e7tLG41erQ1TNEwmCB+wtp1R6Xgh6Gi0cHPC9pE
         0xTX3MZlxXs0prm/r6Aab6qrbPsdubCF/XiY6D7RK8QX3H0RnWn+ynK2WWWecu4MPBUZ
         zIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228442; x=1724833242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOO3xScatAPPPb8tw2FfV0S/NtjYDESd+MYV0EHgGGs=;
        b=JVr6euu+cY08qdVr7XNslkSpUb5d9Y+OL2v+CTd0bxNyJCZCDBo/LpfJkFJDGkKrj8
         0fXxXy6/ECBtXSFaT7oj2pqLHqzAuf+kmn+88To0Orawn6As9LI6szF19R4JFSo+mezd
         cMdb4p5nMNNu4SNXhTCzh2kS1yilsX5YB1a2ObXaqC3X+W6dblmHrfZ8BkLGRhKsXUoy
         A9jM8+dPBp6slJE+5ZczsR6cECv+UAUIKCY8jUAmbLCRXLu5AgUg7LvaLsDw/NoI9GCX
         Y5WbOREr/qPfShP/AndfavWoUHfTfpYdT9Y81JRpEnxjmSyxjj3rJu4jvNmsAZMQYWkf
         N2sw==
X-Gm-Message-State: AOJu0YwKYZJzU14U2cUefPJvD+4vVBgdLH97J8VtTCJOo/F2FEdB9kkw
	6oKefovJohkJCwFwCBroTcOZ/SwzIuUzfPDJFH6w4esXH7hmnFvsiwb6THJeYYU=
X-Google-Smtp-Source: AGHT+IFM+x1tDjPFZswDxs94u/u9nyN6BfWsdj/MLtJd+fBRDvg5mEN2O6omshjTkNyUCHM1AQzwKQ==
X-Received: by 2002:a05:6a20:e605:b0:1c3:ce0f:bfb7 with SMTP id adf61e73a8af0-1cada055937mr1798278637.21.1724228441599;
        Wed, 21 Aug 2024 01:20:41 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:20:41 -0700 (PDT)
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
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 11/14] mm: userfaultfd: move_pages_pte() use pte_offset_map_maywrite_nolock()
Date: Wed, 21 Aug 2024 16:18:54 +0800
Message-Id: <efcf6bed86afb586217dee89551200c33e51c085.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In move_pages_pte(), we may modify the dst_pte and src_pte after acquiring
the ptl, so convert it to using pte_offset_map_maywrite_nolock(). But
since we already do the pte_same() check, there is no need to get pmdval
to do pmd_same() check, just pass NULL to pmdvalp parameter.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/userfaultfd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 6ef42d9cd482e..310289fad2b32 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1146,7 +1146,13 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				src_addr, src_addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 retry:
-	dst_pte = pte_offset_map_nolock(mm, dst_pmd, dst_addr, &dst_ptl);
+	/*
+	 * Use the maywrite version to indicate that dst_pte will be modified,
+	 * but since we will use pte_same() to detect the change of the pte
+	 * entry, there is no need to get pmdval.
+	 */
+	dst_pte = pte_offset_map_maywrite_nolock(mm, dst_pmd, dst_addr, NULL,
+						 &dst_ptl);
 
 	/* Retry if a huge pmd materialized from under us */
 	if (unlikely(!dst_pte)) {
@@ -1154,7 +1160,9 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		goto out;
 	}
 
-	src_pte = pte_offset_map_nolock(mm, src_pmd, src_addr, &src_ptl);
+	/* same as dst_pte */
+	src_pte = pte_offset_map_maywrite_nolock(mm, src_pmd, src_addr, NULL,
+						 &src_ptl);
 
 	/*
 	 * We held the mmap_lock for reading so MADV_DONTNEED
-- 
2.20.1


