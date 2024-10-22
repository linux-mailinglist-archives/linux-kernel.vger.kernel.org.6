Return-Path: <linux-kernel+bounces-376862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E89AB6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BEA1C233E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5C1CDA05;
	Tue, 22 Oct 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAEnrMgN"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5290F1CB32A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625426; cv=none; b=g6zRz2PCoWqMjtbpKhjOOrXJQWfgKW2cQW09PkQouj0VgPipyQRHfHO8GdTCgFDeZMNK5TA/xI947TDIqYm8HWgPPBRMd4RwEcOTQNBhaVzH7Y2BQ9Y+hgeHDaz8H1Tigg0jOaefGVp7m8jpyWVZQFQ9Y/6tuhDZztYSLhIumOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625426; c=relaxed/simple;
	bh=aYdVGM//JHutpU7XqJVJfc6/kfsl1LRCJbyobHUvTg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP5ksLjog8zHBvwNUHJfk3mjKzzW6domGiJTrzRq3k8GQTMCeaeDFTnxAj30ks9lnO2hgMQ+lXU3oYimth3K0VpiBIf77C6py3O8U1buDl3Z0XiKlLKDlBgR8CfZu98Ic7oDjCsWYl0kdNZENcPlyV+zQ9oyP/TtqNxJc2BmFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAEnrMgN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso4925032a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625425; x=1730230225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=58sEe9Vj5/e+n1OUXtAWiattRyV+UTZMgvOaHIMS+fY=;
        b=LAEnrMgNzL5HZu6ZgbtFNB4mxcQgzg37dZz8qS6Oy4LZt75CoU1a1hcxjsr/XOqhiM
         GClbJRN1hm0h1iAMtVWQLs6XDEWnSQJCTgGojzhfNm78363ECas3ZCoxD8u23NIWZVxz
         62kXbTSLlz8EhBsZFCLqoWhs88srKy4v952XvULxWzkuTekBBGve/2VPmj1qt0DfO8jX
         fkEUQzWfsDU/Ur3DPHdJiSONlj3ui1c98FVxLtfjVgNQoHz5yZC9AzSAZh7jsz8uLUhj
         FWLBP63Bsd33QCgKXfqV7FldF/HcK9gRDbtXXhLXVSFn/I9Kv2ghjKtS6XAnVWm9itcY
         aDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625425; x=1730230225;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58sEe9Vj5/e+n1OUXtAWiattRyV+UTZMgvOaHIMS+fY=;
        b=Y4C/e6Ribq2DJfH1PuRtSLgGfN51a+z+AloOPOZ+W4DT0IckY8IOYaUZ+HqIV6PU9z
         qHIgNGXnjfK45ys+pSq0HTnW9OOR8SMZZnocxacYFJKfxJmOlCxZIo/Wke2Y3k1dBZnW
         pUmaMAdla3GoH0NLh70NGJQQVzniYY2EhodohD9jvpZvQz6G0gjBru0wF3kWtelsriZA
         o6nQiNUzC1OsXjO6tuAeW5paVMXBsHUU3O7kWG6u8SU/F1F3nHIanSSCLz8mv/5EG8zd
         ipKxaHzUu0lfiU60GglQ3cpyEKt7akfDVfZr3m2ZA840bpeDZXo+HOEcMi3XR13xsdC5
         Wtnw==
X-Forwarded-Encrypted: i=1; AJvYcCW2m9kxSiIJs2zBX24umBZc2Dg8j3LZ8jRHpveItUCf8W9hZ7X8q0gBeKVRVM//uMTCzRqjf2X5kFwqDls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIDyROhh1KBfYGqYdGYLdz5WhmaeKQD/pHzHDXBJ6wRx+2rj0
	0HU9fFRrAL+zSX6wa9XM0eo7pgi0BdcNnyk8GSVncrJ7X8WyBOdF
X-Google-Smtp-Source: AGHT+IH//2l1S5Hl16buo+tJ0OBYMYhrYsRemVW2E65MZE0w+xwxw5pa87HO3zq6jV4yi+SknPNUlg==
X-Received: by 2002:a17:90a:de8e:b0:2e2:bd68:b8d8 with SMTP id 98e67ed59e1d1-2e76b5b59a9mr38950a91.8.1729625424694;
        Tue, 22 Oct 2024 12:30:24 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.30.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:30:24 -0700 (PDT)
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
Subject: [PATCH 11/13] mm, swap: introduce a helper for retrieving cluster from offset
Date: Wed, 23 Oct 2024 03:24:49 +0800
Message-ID: <20241022192451.38138-12-ryncsn@gmail.com>
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

It's a common operation to retrieve the cluster info from offset,
introduce a helper for this.

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index f529e2ce2019..f25d697f6736 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -423,6 +423,12 @@ static inline unsigned int cluster_index(struct swap_info_struct *si,
 	return ci - si->cluster_info;
 }
 
+static inline struct swap_cluster_info *offset_to_cluster(struct swap_info_struct *si,
+							  unsigned long offset)
+{
+	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
+}
+
 static inline unsigned int cluster_offset(struct swap_info_struct *si,
 					  struct swap_cluster_info *ci)
 {
@@ -434,7 +440,7 @@ static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si
 {
 	struct swap_cluster_info *ci;
 
-	ci = &si->cluster_info[offset / SWAPFILE_CLUSTER];
+	ci = offset_to_cluster(si, offset);
 	spin_lock(&ci->lock);
 
 	return ci;
@@ -756,7 +762,7 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	bool need_reclaim, ret;
 	struct swap_cluster_info *ci;
 
-	ci = &si->cluster_info[offset / SWAPFILE_CLUSTER];
+	ci = offset_to_cluster(si, offset);
 	lockdep_assert_held(&ci->lock);
 
 	if (end < nr_pages || ci->count + nr_pages > SWAPFILE_CLUSTER)
@@ -1457,10 +1463,10 @@ static void swap_entry_range_free(struct swap_info_struct *si, swp_entry_t entry
 	unsigned char *map_end = map + nr_pages;
 	struct swap_cluster_info *ci;
 
-	/* It should never free entries across different clusters */
-	VM_BUG_ON((offset / SWAPFILE_CLUSTER) != ((offset + nr_pages - 1) / SWAPFILE_CLUSTER));
-
 	ci = lock_cluster(si, offset);
+
+	/* It should never free entries across different clusters */
+	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
 	VM_BUG_ON(cluster_is_free(ci));
 	VM_BUG_ON(ci->count < nr_pages);
 
-- 
2.47.0


