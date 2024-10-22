Return-Path: <linux-kernel+bounces-376858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22BD9AB6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FABB23A42
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9E1CC8BF;
	Tue, 22 Oct 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqj3jxGQ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA01CC889
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625411; cv=none; b=agdtGbHceP1dLhv1GwrFlnWG1suZmJwzZ6fklUZQBqzkOUVSIx6qjQCMBgDeB18YJS0+LWw6Js+3W+VwSztDVUw4clvb3D5PJKUUx/M0UsiUW2gTTTiElRuDS3j/tGNv4RH7wj0V39Q2i2hZzJL5jZsnftwPdxfzORzQawy+YIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625411; c=relaxed/simple;
	bh=7IHuhTajhKK2ytXTaAghCPfcVQI5lnm1fWCY/s8m/i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwB0hG0vtQIMB2g9LkfrrhIZxm/rIMYcd+Kct0Mn2nXsgE6/GVo5ZzBoqE1prWAHtYmBLbz3rLfggtvyK3aauRmdzAkxoXYD/MeIMd35i/9SF+KtUAFbniqngNi+W9YScmM+n4rgD3XQQmP4p+1eOOoFaJymIAJ2FggcpIkyc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqj3jxGQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cceb8d8b4so1124445ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625409; x=1730230209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y5IVfma5ek0o5p05lfogeIX/Ksc+K9HaTmPWOdXoK94=;
        b=Jqj3jxGQeH4KnQqYo1PAMIU7Bpjm8HYZsPkyTz72zxes8P/z+xdA1LefXXrzsYtNVM
         p2h9Th3csN0ri/CAXW3W3K2EBSYMwK5JIeb0u2pRxg1UBwgCy8JOzmLvvB3RJylaV+hk
         z0Ui2F1xfwP6X6bXp4lUR34MyNHc1D2qfNJ7gQcGrXeaSwoBwgUd+hiua1Ss+QA3U65k
         wek0PFAwYuiWDoWCLClfDS83K6yKvw823PZ1P4Yfa3aCmyXTEVOHqx4BlM5SUZw+pnt2
         DyFHPILn7knkU6h/I7cdYVqDvt5PMvGtIvuwu+x54pQhnBvcrXCgStJvhVzfvxbtxmWX
         AAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625409; x=1730230209;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5IVfma5ek0o5p05lfogeIX/Ksc+K9HaTmPWOdXoK94=;
        b=SRD7VDIS6FMR/Jv49e9MpTJrb/jtWPk3SVwCZoNUYgXuyyTQVOj7XlSC9zy4nfqGIC
         XV6AYiD9Ct7HH/ZM0W2VK6l7epS71mbCnaX8luRk152Lb9/kXDKlmBIZ5vY2EQo8Kcd9
         fQs/Yr7JsFCvyGuw3iFQoVEEafS2PVSHyJHgzisphImurA1h1G4NIYzKeEAhbPcbOb/i
         75J4bVSnMB1tI+Cq9sFH8qSKmEZ/NvZoVbLfpN1OBgS3dk3P0Q5H7Ojpz+2IpZeYn6Iv
         Wv0jXuokvpPfm0zcXhmw2kXX7xRMMXm18fKYnTFc3KTj4ukMWoMiK8lawN52CMLhvmq2
         eDkw==
X-Forwarded-Encrypted: i=1; AJvYcCVrUPtYK8W/rquJIgdD6zW7ck9Lvyl9g85E12IdDRv8zhzx4a7GKJTvP2It3ywHAhESQLl7PAoBAnCR3Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMoe0STP7VjitnrvdlnqXgFU+4xOkAA3DRhZ/PnrLsxeDGTlP7
	ICFMVUdXfqu0PNaKjD0QwCNQORVskNinRJO639fElVRzgI5U6KvP
X-Google-Smtp-Source: AGHT+IEaW5p22BuL++IGvPbx1wSKUh2fWL5sYrhcqHGPkvgStJJ2rzNvX7pO43mcwrLobjoc3axngg==
X-Received: by 2002:a17:902:e845:b0:20b:a41f:6e4d with SMTP id d9443c01a7336-20fab2e2baemr2651685ad.15.1729625409537;
        Tue, 22 Oct 2024 12:30:09 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.30.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:30:09 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 07/13] mm, swap: hold a reference of si during scan and clean up flags
Date: Wed, 23 Oct 2024 03:24:45 +0800
Message-ID: <20241022192451.38138-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022192451.38138-1-ryncsn@gmail.com>
References: <20241022192451.38138-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The flag SWP_SCANNING was used as an indicator of whether a device
is being scanned, and prevents swap off. But it's already no longer
used.  The only thing protects the scanning now is the si lock.

However allocation path may drop the si lock, in theory this could
leaf to UAF.

So clean this up, just hold a reference for whole allocation path.
So per CPU counter killing will wait for existing scan and other
usage. The flag SWP_SCANNING can also be dropped.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 62 +++++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 16dcf8bd1a4e..1651174959c8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -219,7 +219,6 @@ enum {
 	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
 	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
 					/* add others here before... */
-	SWP_SCANNING	= (1 << 14),	/* refcount in scan_swap_map */
 };
 
 #define SWAP_CLUSTER_MAX 32UL
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4e629536a07c..d6b6e71ccc19 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1088,6 +1088,21 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	return cluster_alloc_swap(si, usage, nr, slots, order);
 }
 
+static bool get_swap_device_info(struct swap_info_struct *si)
+{
+	if (!percpu_ref_tryget_live(&si->users))
+		return false;
+	/*
+	 * Guarantee the si->users are checked before accessing other
+	 * fields of swap_info_struct.
+	 *
+	 * Paired with the spin_unlock() after setup_swap_info() in
+	 * enable_swap_info().
+	 */
+	smp_rmb();
+	return true;
+}
+
 int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 {
 	int order = swap_entry_order(entry_order);
@@ -1115,13 +1130,16 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 		/* requeue si to after same-priority siblings */
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
-		spin_lock(&si->lock);
-		n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
-					    n_goal, swp_entries, order);
-		spin_unlock(&si->lock);
-		if (n_ret || size > 1)
-			goto check_out;
-		cond_resched();
+		if (get_swap_device_info(si)) {
+			spin_lock(&si->lock);
+			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
+					n_goal, swp_entries, order);
+			spin_unlock(&si->lock);
+			put_swap_device(si);
+			if (n_ret || size > 1)
+				goto check_out;
+			cond_resched();
+		}
 
 		spin_lock(&swap_avail_lock);
 		/*
@@ -1272,16 +1290,8 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	si = swp_swap_info(entry);
 	if (!si)
 		goto bad_nofile;
-	if (!percpu_ref_tryget_live(&si->users))
+	if (!get_swap_device_info(si))
 		goto out;
-	/*
-	 * Guarantee the si->users are checked before accessing other
-	 * fields of swap_info_struct.
-	 *
-	 * Paired with the spin_unlock() after setup_swap_info() in
-	 * enable_swap_info().
-	 */
-	smp_rmb();
 	offset = swp_offset(entry);
 	if (offset >= si->max)
 		goto put_out;
@@ -1761,10 +1771,13 @@ swp_entry_t get_swap_page_of_type(int type)
 		goto fail;
 
 	/* This is called for allocating swap entry, not cache */
-	spin_lock(&si->lock);
-	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 0))
-		atomic_long_dec(&nr_swap_pages);
-	spin_unlock(&si->lock);
+	if (get_swap_device_info(si)) {
+		spin_lock(&si->lock);
+		if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 0))
+			atomic_long_dec(&nr_swap_pages);
+		spin_unlock(&si->lock);
+		put_swap_device(si);
+	}
 fail:
 	return entry;
 }
@@ -2650,15 +2663,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	spin_lock(&p->lock);
 	drain_mmlist();
 
-	/* wait for anyone still in scan_swap_map_slots */
-	while (p->flags >= SWP_SCANNING) {
-		spin_unlock(&p->lock);
-		spin_unlock(&swap_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&swap_lock);
-		spin_lock(&p->lock);
-	}
-
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
 	p->max = 0;
-- 
2.47.0


