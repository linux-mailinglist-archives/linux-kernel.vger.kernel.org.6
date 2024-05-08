Return-Path: <linux-kernel+bounces-173905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735F48C076D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2980D284415
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541939AC3;
	Wed,  8 May 2024 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOLABrv7"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422924B33
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208120; cv=none; b=Cx0jw1LvTQBO3jYtGIx1QsyB22t2aLjJ0X4wsbcD1k54HCEnw27MduNd2Mvu0xAkHziizWmO3nkwny78isrgxjBKU8vt/fQTnoBEdHiJanvjZTjMQ6xq1LZFyfxOgpVR+GBcOIpxjI8kMudubK7zVU/k1TFlf0PegoUJWZYLIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208120; c=relaxed/simple;
	bh=VqBZ46CyXKDAAuUJum5h9nOVdshvg4zc3yJsiQ7tErU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lK8z6uXn+qU5/YTTbU5OOVAtU0Ovv68NNus1NwnF7PV8L6zYJ2rdACynj2Ca0wUdxKnbqnY7iHlIi5TM3c2psYAwMOER5I5eVWZrfPNZqg8cnkUXj5FmAeJ1bCE+J1FB+PnW6e1/mWhepHxRJsYSRdYeYKPzZhDA5nIPzlLH214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOLABrv7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-61aef9901deso225686a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715208118; x=1715812918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKP4frf3SJsYj3bpFkLEvp3HW+vS2YimBRDSFS3kDwg=;
        b=nOLABrv7cIMijse0YMjRuOFPYV+7TNOCb0LeV8J7kU4mozc6JEStyp6GyQL+byNN9b
         andMjioCoCe7I7Yn9qwFVZtFAxjoyFfKWw9znSPOqb6bEdkjcDH2lqjaqr4CkhEmb++a
         JYJ9Mqxu9cnqCtMhGaah22OjZEq89QDiibvnQ0EVLQddpclwdnK4DqxaKrrG4Q5pGjXc
         uS5crHbv87Bwiu1ZeFQVMAdjDvG5GqPQPpTMSaZSwkjc7PboJEtALg6Kg66vY/qNtnh4
         CW8YYsokRPw8yNsQgpcVac3pKLXdUc02OIrynwjd6PJHxQYuO2rTl8xCPg0b9EJlC+HF
         Avxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208118; x=1715812918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKP4frf3SJsYj3bpFkLEvp3HW+vS2YimBRDSFS3kDwg=;
        b=W39BNNrOmRBXI5B89tcjxNcpKZKYo+iB5i8LzDZgX957XItJcJyX9QZ2qsxYGoj6M2
         ecD4jIqpyTOwNQEVbbilMfJAcgwVrvnRNbcJmvxSyvxbfcJc7fTkgw7xpGeZUZDpsQx1
         toEkmg7wo6fag8yANZBvzLEt+0kcR2Kc2p9HzUM5y2vSGxPWH2keX5pAZr+guuvOczHH
         CZ88yOrVF0hXK1t/Y+QkST1v5skPfiPsoGI7XxcYNOl/igrsT+phRFG0SB8PZRqTN4HW
         zPU63X7gSqEgBIS80cvy3hd2RmV+NLEwtEc7ei0/346fIs22jg3s4ZqJ9oDSAIE5BdlR
         tC+w==
X-Forwarded-Encrypted: i=1; AJvYcCXTRY3cLylJ/HNHYqKXz+8BeOzR8qAITkGTRo1ZWu9jPfT1vQyVyv9m4aScKKoiEQXweyXHXczY3WomLAeZtJOELMuRXNjD3FFOWplr
X-Gm-Message-State: AOJu0Yy0MUYRydUJJi1Q1GTV3g+XMCEnZGO8ug4gUI5ai86zxkSDfRHZ
	GysO2j6DuUKv+VeqTr2NUShFK6MIA+mQBhyOGSlwwI6UzZbnl3wY
X-Google-Smtp-Source: AGHT+IFi9srqYFLAGkCKh6k9BgPnyvD1B3mYyYQyZ3x2gIfLtku4oUuO4QjlFLxaj5GaZF8qFdK07w==
X-Received: by 2002:a17:90b:894:b0:2b6:2138:e407 with SMTP id 98e67ed59e1d1-2b62138e4c9mr3786419a91.9.1715208118171;
        Wed, 08 May 2024 15:41:58 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126b666sm102082a91.34.2024.05.08.15.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:41:57 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 2/6] mm: remove the implementation of swap_free() and always use swap_free_nr()
Date: Thu,  9 May 2024 10:40:36 +1200
Message-Id: <20240508224040.190469-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508224040.190469-1-21cnbao@gmail.com>
References: <20240508224040.190469-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

To streamline maintenance efforts, we propose removing the implementation
of swap_free(). Instead, we can simply invoke swap_free_nr() with nr
set to 1. swap_free_nr() is designed with a bitmap consisting of only
one long, resulting in overhead that can be ignored for cases where nr
equals 1.

A prime candidate for leveraging swap_free_nr() lies within
kernel/power/swap.c. Implementing this change facilitates the adoption
of batch processing for hibernation.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Chris Li <chrisl@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 include/linux/swap.h | 10 +++++-----
 kernel/power/swap.c  |  5 ++---
 mm/swapfile.c        | 17 ++++-------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1d35e92d7e9..48131b869a4d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -482,7 +482,6 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
-extern void swap_free(swp_entry_t);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
@@ -561,10 +560,6 @@ static inline int swapcache_prepare(swp_entry_t swp)
 	return 0;
 }
 
-static inline void swap_free(swp_entry_t swp)
-{
-}
-
 static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 }
@@ -613,6 +608,11 @@ static inline void free_swap_and_cache(swp_entry_t entry)
 	free_swap_and_cache_nr(entry, 1);
 }
 
+static inline void swap_free(swp_entry_t entry)
+{
+	swap_free_nr(entry, 1);
+}
+
 #ifdef CONFIG_MEMCG
 static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 {
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 5bc04bfe2db1..75bc9e3f9d59 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -200,12 +200,11 @@ void free_all_swap_pages(int swap)
 
 	while ((node = swsusp_extents.rb_node)) {
 		struct swsusp_extent *ext;
-		unsigned long offset;
 
 		ext = rb_entry(node, struct swsusp_extent, node);
 		rb_erase(node, &swsusp_extents);
-		for (offset = ext->start; offset <= ext->end; offset++)
-			swap_free(swp_entry(swap, offset));
+		swap_free_nr(swp_entry(swap, ext->start),
+			     ext->end - ext->start + 1);
 
 		kfree(ext);
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ec12f2b9d229..99e701620562 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1343,19 +1343,6 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 	swap_range_free(p, offset, 1);
 }
 
-/*
- * Caller has made sure that the swap device corresponding to entry
- * is still around or has not been recycled.
- */
-void swap_free(swp_entry_t entry)
-{
-	struct swap_info_struct *p;
-
-	p = _swap_info_get(entry);
-	if (p)
-		__swap_entry_free(p, entry);
-}
-
 static void cluster_swap_free_nr(struct swap_info_struct *sis,
 		unsigned long offset, int nr_pages)
 {
@@ -1385,6 +1372,10 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
 	unlock_cluster_or_swap_info(sis, ci);
 }
 
+/*
+ * Caller has made sure that the swap device corresponding to entry
+ * is still around or has not been recycled.
+ */
 void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 	int nr;
-- 
2.34.1


