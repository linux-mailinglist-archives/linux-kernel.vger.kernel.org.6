Return-Path: <linux-kernel+bounces-339975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF4E986CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B509E1C21241
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBE21925AB;
	Thu, 26 Sep 2024 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U5nj8WXJ"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EBA13D276
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333294; cv=none; b=UFYJmsTebQdsHxXldJvcuf8yZETNZQcfSk4724wJ8Ia/Q1wOlVfm6GDRtELHYt1U0z8ut+6BcT624KjjjalYt3PPNBAOqrunog9KGA8598VOpi+Uw5fvWQTs5a4hYbxxojiB9uGPwkN6tCPMpO6ICHuwqD6ZNFNu+goV6fjo9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333294; c=relaxed/simple;
	bh=M/64Ci4YVvyqTSzbm0kd6G+2YPtWZDsuLrmsgyWUzVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xfk8ol5VWGIzl5tsTZ4baTrK71wZtzVQ8WZPZnTbzlGDnrrmHiO3CEr4KwtmfL08nlZR2KyQMGMxSsFHwUdhpbbzd9t8+ZFZ0bO/XD2l9dE6/HHUELCYb4z49KmRuKw0WCCv/PWXJMS38iiUb/dhyfre81ceclBXMTyEK8pBeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U5nj8WXJ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-49bdc6e2e2cso272884137.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333292; x=1727938092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnMCKwBqnYl3LJbu0M9HQTu7wcymlNTkAYqiZlfWQ7I=;
        b=U5nj8WXJQBqjaIORF30SdurQjye0eWgmnaBreXxzmDm54zseAgADaJ1ujlZ4bbxWh6
         3Usde+7EMRfiz3RrpJTTdgH9vg9UPvAtKkmQR9fvtH9gNFeZX6Xx+YpV0ilVYcLuQ1Hs
         ow85NZkmjT82Xd3pabu4dUAwexZ2xjjMmOalxKfo7tqxEfT2yKzi+lXyujjcwGr0NJMs
         nl98JqJFZGP1i0msZLck0VlUJvACLW6A4KKkvtu8iSIeEIi6RkOJTyGTHqix2J45v8tH
         Twi4gF9NeQKzNooghsPorLjQaGaSYNqMt0rybaYj0VOuXOH6U4Rx/zIFxJCXPVfJwqwX
         dUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333292; x=1727938092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnMCKwBqnYl3LJbu0M9HQTu7wcymlNTkAYqiZlfWQ7I=;
        b=ZSZXBJ/XTnBC9ndx0wqpXxmSNCfpisDB5conPaMcHhTYtyeVuSR6ERlKkZ7xcC4E96
         XYlmGzgpO3HWc9dGcCi7Bpy/ca7/OxM9+zJTUsNlt1WAE687V69X2l53Q+pCRge4cXWt
         J1cgeDUifoUEgT51VP9BXqx34OfCL6e9XCffrpgZP5UJw3yddF2TmlpPX3cidoiFHCgb
         y1UQz4kIC1B1k3mTo8eEpsELLWaAb08nE7Xic273cRVLEEiSOsWFc8X3vpxYXB5w7a2H
         4bXO8MWrHwZ4srzX0m5AAx7pIlJvB6ldzPwl6zAWzxz4IPMsvfJcUXzetr1E+HS6rGuX
         oFHw==
X-Gm-Message-State: AOJu0YyrVcnNaeCHbVfCP/mwmEu5GZaTJiR0QmXKTEoQY0rGx3NX4XnN
	Qayit3cWiA74CUrNV7366EsS12gu1jdYDkXmLceTL3737cNtTH+TICBDLF/M8QM=
X-Google-Smtp-Source: AGHT+IEjiufoSG+9f7J9DudEHL9YuIq0UaJx7YZ52pOk+qHYx73DXmea6YZQnzcRnEEhuuY+i+vKHw==
X-Received: by 2002:a05:6102:e06:b0:493:b055:bf56 with SMTP id ada2fe7eead31-4a15dc39965mr6802341137.2.1727333291940;
        Wed, 25 Sep 2024 23:48:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:48:11 -0700 (PDT)
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
Subject: [PATCH v5 11/13] mm: userfaultfd: move_pages_pte() use pte_offset_map_rw_nolock()
Date: Thu, 26 Sep 2024 14:46:24 +0800
Message-Id: <1530e8fdbfc72eacf3b095babe139ce3d715600a.1727332572.git.zhengqi.arch@bytedance.com>
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


