Return-Path: <linux-kernel+bounces-336591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD9983CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C51328455C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4374B84037;
	Tue, 24 Sep 2024 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BfTQjvTh"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD784D0F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158298; cv=none; b=a785mdmKS1G5p9OtV0ZqNbjZmZKdcWgAtnn7RQjvchYg7f9wwo8VbuQIyTHLBwOOu0TD3jpSCBCvyhMcrI4jeMCuc2iN58VTd3G8Hw2CyZqw3TMQG8JN1daFa6PznBQlwPilD6i2xF6asKRzWatl4/eHUGGsJJqP7KOhYbzRTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158298; c=relaxed/simple;
	bh=M/64Ci4YVvyqTSzbm0kd6G+2YPtWZDsuLrmsgyWUzVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qjrt8wyI/goVFZcZwLF5DCkgdIpQ+IZ0k62Q1gpHqjw9FYZTc+16/B/NSXWf0VwGpLduj8kdc+cmWWXV0mfDVph5Z95ky4MCDC4VR5/VV3fcQ6QFrGh0z2FzcdKMef8iQLjbllTxjU5X56kC/DSYexIcJmG3wPLQJ7qrridiwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BfTQjvTh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053525bd90so47136865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158297; x=1727763097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnMCKwBqnYl3LJbu0M9HQTu7wcymlNTkAYqiZlfWQ7I=;
        b=BfTQjvThNxtE0DZX/8NgsgaEL9Hnxin+ktQXh5DZHE8TILZ83UD5tTmm8PPOGZzkuz
         HNYVEUeMjNYbemaqyCDyuC6+LRxIh5T06vTd3LiiqQp0mIY+5CnuXr2m7jfFR3w4ljcC
         UnzEKKZXW0LV4Rik4ctd5TGWfxNvYRaM/VDZ2LFk2dpbKuSUBGmPT0Y+hvnCdGpO9rE0
         QPPRDH4VlNOIpBS+3Y/AvXBrfGy+s50jCOzgN6Ef74vn9ngMPROoTaQzvrfV+O5SL8+U
         xHH50aEEi9L+SpTX6kZtOrrzJx9+kDIbDwofkc9F7V3aMFCIgUMOydqNNORFFjfn921j
         qivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158297; x=1727763097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnMCKwBqnYl3LJbu0M9HQTu7wcymlNTkAYqiZlfWQ7I=;
        b=VhnBvpTcwP1y9DMZ+fRg7vUt5UAzDxNq3i43DvPwnwZpxkL5zPkyRgBjwVtmE8AcHI
         w8dGDE3WPjJIb0Y1ZvMV+tBc4w9PhBbsJzzQ1h/njeNrHNG1CmlwZrgB716jAJvI1f25
         Ktz+ktcZ7SCl0E+32OPH0xDdKwGStnmMtKvtcHvWduAORZqUGaJ0Z283JxcinsaKx2ic
         IuHZgPABC3v4xSzIPxT2hOKFMnfQr6H1R98Y0tf7g/I9+/iWG3Lh2vaFjJHXDZpN0+us
         IvlNdbwF8qXSdW9lShTJ1NH9pQlMi0RLvO+MZadmbQhUI7gQJXyS/r5mnUWC05GrVUjl
         xH/A==
X-Gm-Message-State: AOJu0Yxb+6Rxk9ow+swcQsIBXa0DQueED+51HuWlxXr+CmtKFJMQCXpD
	FMidt8VXVYznQWqGj1gHv+hQIvKJEt8FP31rbsWB3c2haUoZNlRkpM9vaqRLyt4=
X-Google-Smtp-Source: AGHT+IFBI5Ned/vbTuuRRzdnv79MFASKoi0/m2fLpf4am0H6y8GNq4qW/RgfzVT9no9zcYiBkg/Xzw==
X-Received: by 2002:a17:902:ea07:b0:20a:f013:ddb5 with SMTP id d9443c01a7336-20af013e29dmr19152265ad.59.1727158296610;
        Mon, 23 Sep 2024 23:11:36 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:11:36 -0700 (PDT)
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
Subject: [PATCH v4 11/13] mm: userfaultfd: move_pages_pte() use pte_offset_map_rw_nolock()
Date: Tue, 24 Sep 2024 14:10:03 +0800
Message-Id: <c55fd0511ef5bfc3ec4fbe36b34ce19c7903f6c5.1727148662.git.zhengqi.arch@bytedance.com>
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

In move_pages_pte(), we may modify the dst_pte and src_pte after acquiring
the ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
will use pte_same() to detect the change of the pte entry, there is no
need to get pmdval, so just pass a dummy variable to it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
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


