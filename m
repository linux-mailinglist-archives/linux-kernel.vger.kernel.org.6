Return-Path: <linux-kernel+bounces-336397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7CE983A26
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7231C2277D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A512FF72;
	Mon, 23 Sep 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo90i49e"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081BB1272A6
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133106; cv=none; b=noqVT+bMtpA0U7ZJ6vcCdXUWcJXTX278CN3rFyCtgZR+vMiidYHqDZK+vvbeTNtuH9UVBInZxEMGN2ixWaf3EPNUo7hHT4iUdptOnSK4StwgkEuU1I2E56GYNCSkr+mVr41+F3WRbDgmZ1jKE9m/MN1+eWyNPMYBLRrMJTNp1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133106; c=relaxed/simple;
	bh=qkaPYRAZSasb6ju7LOEnZOnDHWzzGT8YOnhblSx3BnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upA7TUJkoMcXTHVBOthtVrGVk+r5G4GXLMmihVE5b/5/0nU1oBc3eiJx4+vkPN4UrNdl6N5OCpb9Tf/kNxsmu51A13eDPBYaIzTsgog0YM3wMCbZBFpESdxXPN8F70axRN94GsmnK5tMt2WRh+MnUU4tcnVLOLBYyYdmFLsPtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo90i49e; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ddca648c26so40141397b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727133104; x=1727737904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPDqT4tYuF6YjiitP1AaWuH6hXZ6wk6au/QNmRqOg+Q=;
        b=Eo90i49ehGU2QLCAaq/qPf6QCWD69nPLbxwAwRHUM5iWBn+Mq56+Nsmnap0J+Uqhz6
         BpNTU0yN9zzn8eCJYCXDA4BiOaSBC9Pp+0GO2OkJJs5h44mBPoWh5ndahvutaewCMyGq
         7QQwYiEInKvuvQ3ag8wDmz8Gm4g+QLFEY+QmErm7wJmARtgE1PCo5Aq5k6htvr87sbZ+
         9TTC0WZxk+yp5inJuUCw/0cRiw1+QKWWRLKRnw5JFAfD+Va2vEag6aAXP+aunFDq1Mat
         4ejahE8olmFBCmmrmuLx/LPWe0LB7v5L7qpLqko6PXg8OL6Gnz2NrFb3+Guidnh7Xw7k
         YgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727133104; x=1727737904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPDqT4tYuF6YjiitP1AaWuH6hXZ6wk6au/QNmRqOg+Q=;
        b=SU16dG2B/9SRD7oCKw4n7dRK8QasxrHsUOPIcN01oSJ4MkF5+jnxTNxw94meIgeEh+
         h125m20DtHVS/zbc3fSusoU7Txl5d9tUMmvndsJcKMFCTTcZAVBtPbCAKadtfHYUa/Cg
         2HdGVKYGmTYZJydbmn0NrAkbiQveejzcrVuy7lXG1i+BjQznBb4OqoFHnxG+xu3z01W6
         Kf1KhlPJ4hvft1YwzA8kpKrAW4TjLCwIoU40NOLPJpUipFgYvEk2JD8gY+pmA9qFSg8r
         NahDc2nQZck6FCuJZXkggpu778g7ameoTGePI/Ev4xhI6gLXlFlAY15PTkc4Cevd0Ixe
         lBNA==
X-Forwarded-Encrypted: i=1; AJvYcCXpMZNgA/qUqlecmG17moUumkRSTlGRq08R4fB59++9ujvMomTqJyFLeMppfBBF4/3z/IQcytTpyzLwc/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbrh6TYXapw0MMVdvdck4dsngsXY0s2UnNObOjvqPCs4O5XA0
	miVD0BxRJBNFYpxvR8EsSanwu0qvV5aTyz5TlWJUgjanEKiLNwOd
X-Google-Smtp-Source: AGHT+IFcssM6pnQQDk/NRr4NihPaeFHiGgxFPtmnmmYpIunNZgYl6WAQdDvridjor3AWUUXZ9mYN5w==
X-Received: by 2002:a05:6902:150a:b0:e1f:aec0:4e6d with SMTP id 3f1490d57ef6-e24978b67eemr1107670276.14.1727133103972;
        Mon, 23 Sep 2024 16:11:43 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2499c6226csm50606276.43.2024.09.23.16.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 16:11:43 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	hughd@google.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] swapfile: add a batched variant for swap_duplicate()
Date: Mon, 23 Sep 2024 16:11:41 -0700
Message-ID: <20240923231142.4155415-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240923231142.4155415-1-nphamcs@gmail.com>
References: <20240923231142.4155415-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add swap_duplicate_nr(), the batched variant of swap_duplicate(), that
operates on multiple contiguous swap entries.

This will be used in the following patch to remove SWAP_MAP_SHMEM.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 10 ++++++++--
 mm/swapfile.c        | 13 +++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ca533b478c21..e6ab234be7be 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -483,7 +483,7 @@ extern swp_entry_t get_swap_page_of_type(int);
 extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t, int);
-extern int swap_duplicate(swp_entry_t);
+extern int swap_duplicate_nr(swp_entry_t, int);
 extern int swapcache_prepare(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
@@ -553,7 +553,7 @@ static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
 {
 }
 
-static inline int swap_duplicate(swp_entry_t swp)
+static inline int swap_duplicate_nr(swp_entry_t swp, int nr)
 {
 	return 0;
 }
@@ -606,6 +606,12 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 }
 #endif /* CONFIG_SWAP */
 
+static inline int swap_duplicate(swp_entry_t entry)
+{
+	return swap_duplicate_nr(entry, 1);
+}
+
+
 static inline void free_swap_and_cache(swp_entry_t entry)
 {
 	free_swap_and_cache_nr(entry, 1);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0cded32414a1..47a2cd5f590d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3695,18 +3695,23 @@ void swap_shmem_alloc(swp_entry_t entry, int nr)
 	__swap_duplicate(entry, SWAP_MAP_SHMEM, nr);
 }
 
-/*
- * Increase reference count of swap entry by 1.
+/**
+ * swap_duplicate_nr() - Increase reference count of nr contiguous swap entries
+ *                       by 1.
+ *
+ * @entry: first swap entry from which we want to increase the refcount.
+ * @nr: Number of entries in range.
+ *
  * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
  * but could not be atomically allocated.  Returns 0, just as if it succeeded,
  * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
  * might occur if a page table entry has got corrupted.
  */
-int swap_duplicate(swp_entry_t entry)
+int swap_duplicate_nr(swp_entry_t entry, int nr)
 {
 	int err = 0;
 
-	while (!err && __swap_duplicate(entry, 1, 1) == -ENOMEM)
+	while (!err && __swap_duplicate(entry, 1, nr) == -ENOMEM)
 		err = add_swap_count_continuation(entry, GFP_ATOMIC);
 	return err;
 }
-- 
2.43.5

