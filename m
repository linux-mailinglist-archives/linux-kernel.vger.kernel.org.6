Return-Path: <linux-kernel+bounces-314575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B892196B550
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744C328D1CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41A1D0161;
	Wed,  4 Sep 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aCe8WgS9"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19091CFED1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439318; cv=none; b=V3ES/gDSCyACGadfmUVFiqi1zfZxKAgTU+hxRYwGcvO5/ah6lzBxWSOlYX9ee+rcchLVYLPKvoh2woUk81zkx5MiIsx5T8QlihXCT+7H9yPS2Ke9c8RHfhkZ1jsPdSQAqsFTPFCRJ8ElJHNyqsJsWW1Z38qofEAYoOU4MeKL+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439318; c=relaxed/simple;
	bh=uIbfcvTo6Td8qMQXROw79N/GDlcQcfN90m4HD/LjEwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ax+sllgyGNPvlC1ImGEGltvIb2nfdvfnFydUM7WD/iDh2uP4FAkwNpqxXgCke1UdcGLa6n2RDr6qQX0dG4VxKcjW4BUvRNBUVD4A5TzoJHBl4dDHftxVKlGeGKF4WCmtVauxRkjUTa3UKLeghyKEeixV8nC5UhkJ517Z7xBGhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aCe8WgS9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206aee4073cso6775605ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439316; x=1726044116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PxEMdLIb7w0CeH690VB/ed9+hRnYGoSsqaGDg4GBd4=;
        b=aCe8WgS9qI6c4pq2U4xhuZdXsibXD4jY8RkrzjyLaKJhekXS7RlTsChuuY0l73HFkp
         cCTFGNQchnpKv52V1Hq3VdFXNzzfMBjc2aycQPaw2X+5b90F5+JAwmX2itg3Pdk9oF2g
         flAEBwtnWyr0ysR44IjA2s78ouBEkPnXSJXfahGGl6lA2CJj9Tdn1AEQQElo1EyaTO4v
         aclqSglz6itFzsVmAXvjjeWy0of1/feotus75LypHIOAfEienFKtmCm7bcNSDcK1gB/I
         zOZeIHDbtIPiAsIOWcSClmd+Tl00x60YvVwwllk+EwlCPxwnfoM//g5sesOrLGHuQ4Un
         Plew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439316; x=1726044116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PxEMdLIb7w0CeH690VB/ed9+hRnYGoSsqaGDg4GBd4=;
        b=mtu/3X0HpnG88FV/qWmrmSjxRFbBLZdHuJ5aU2mtiDfBKGqOl2mflIZzYeV/D6My8n
         SexBjlxuC4zvAeQcxzaMAUZczNpFX4i66n1FyUUdkjDzZXk1NaocgTA0SbmL0PgUTypw
         0r8JltL4adzW8fEoAQYGG+UJnt9HLEZFWFpy0N3MCxsh1LdrcmTkxgAOOkjsdskmgfZi
         em6MAeVYRSJhAFlABLaob/N1x3R/l+osFR94QpBonXivY1HvFEhL18uJJBdfJ6yUCZqV
         HVMZO9Mlu6j5BTzjsAXrxLvmDyDrRb6rbuiWIHMqcv85dCkcgF9Eh+kEQylGuM0sJBid
         hEOw==
X-Gm-Message-State: AOJu0Ywszu/sMU9eq0eUcDN/++ZiGIplrHPpEHq4usy2fbi4yYMqWNSY
	rgJunUSv0uORfpumI0LKWsQuNuAgTwbaGalHNGKIRkigWMDRtbVbV9Jg7OLkKmY=
X-Google-Smtp-Source: AGHT+IHUb0AH81Bf+t9sl3x8o3nWMR3fxDcIYnthyKOt2Ee/pQCOOrlcmsn4X1RsHo/HQ+Mvmo6mhg==
X-Received: by 2002:a17:902:f94c:b0:205:4273:7d65 with SMTP id d9443c01a7336-20546131866mr119665875ad.21.1725439316150;
        Wed, 04 Sep 2024 01:41:56 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:41:55 -0700 (PDT)
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
Subject: [PATCH v3 11/14] mm: userfaultfd: move_pages_pte() use pte_offset_map_rw_nolock()
Date: Wed,  4 Sep 2024 16:40:19 +0800
Message-Id: <20240904084022.32728-12-zhengqi.arch@bytedance.com>
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

In move_pages_pte(), we may modify the dst_pte and src_pte after acquiring
the ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
already do the pte_same() check, there is no need to get pmdval to do
pmd_same() check, just pass a dummy variable to it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/userfaultfd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ce13c40626472..48b87c62fc3dd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1135,7 +1135,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	spinlock_t *src_ptl, *dst_ptl;
 	pte_t *src_pte = NULL;
 	pte_t *dst_pte = NULL;
-
+	pmd_t dummy_pmdval;
 	struct folio *src_folio = NULL;
 	struct anon_vma *src_anon_vma = NULL;
 	struct mmu_notifier_range range;
@@ -1146,7 +1146,14 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				src_addr, src_addr + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 retry:
-	dst_pte = pte_offset_map_nolock(mm, dst_pmd, dst_addr, &dst_ptl);
+	/*
+	 * Use the maywrite version to indicate that dst_pte will be modified,
+	 * but since we will use pte_same() to detect the change of the pte
+	 * entry, there is no need to get pmdval, so just pass a dummy variable
+	 * to it.
+	 */
+	dst_pte = pte_offset_map_rw_nolock(mm, dst_pmd, dst_addr, &dummy_pmdval,
+					   &dst_ptl);
 
 	/* Retry if a huge pmd materialized from under us */
 	if (unlikely(!dst_pte)) {
@@ -1154,7 +1161,9 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		goto out;
 	}
 
-	src_pte = pte_offset_map_nolock(mm, src_pmd, src_addr, &src_ptl);
+	/* same as dst_pte */
+	src_pte = pte_offset_map_rw_nolock(mm, src_pmd, src_addr, &dummy_pmdval,
+					   &src_ptl);
 
 	/*
 	 * We held the mmap_lock for reading so MADV_DONTNEED
-- 
2.20.1


