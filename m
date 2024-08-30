Return-Path: <linux-kernel+bounces-308509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BAF965DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA9C1C22DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E59B17BB16;
	Fri, 30 Aug 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITPrvGzp"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59016F0EF;
	Fri, 30 Aug 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012285; cv=none; b=VIbbS9rbeo+wevYChSTGWrV0nOACuZE+HOsav2Bj25WkMwC4XkKlRHcPDgJ+iWHK5f7LMHG14Oxnuz5YkHVk2tVUHPIxJcCswYnatxbg6O7afgMb28yneijTYGho/GAcgFB+7hdb74uUcbzKsH3WnobNg5UTYZ+I65zKQy8PEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012285; c=relaxed/simple;
	bh=fVFvsLDfOCuGJsWwcR/FCYnCnhmVNtmLd+5C5LFv9gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UefmQI6qhReO/YkYWrVM3zwq9LMi4d3PbSKeVsNK5HEdMt+xK8XDwBfYjhre8KAKNzEL5Nyr1Dn7VN/g2IevG/wfZBgxNT0vVMCODa/XhRwh38WuFHhBdnjf/Xi2YNsncnpJwoHNWDYZ/IEs80wVIDmFb6W2Gr7dc+InVKKgVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITPrvGzp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a7fd79ff71so104095985a.2;
        Fri, 30 Aug 2024 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012283; x=1725617083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5a45zgnKr1XZRxdreeDmqy+oLRtttPm8KTNMecFwc8=;
        b=ITPrvGzp5HSFif5Np610DRw8tw9ZpRm+06EhZYYDIy6h+4mBmaK+ePmQ4z1rXB9w5R
         XvuXNNCjeq9vb3HRNM+XgXKK4a3nBnHYf1f5LnLNFb1cLYTpybgBgvo12teJhDc3WuKe
         PC5/nx4HcR3pXcStKn3vi05W+kcedvrfvj3U/92H4tNXILNkSt6FpdbWZtZthQ5UUVxN
         zvJia/n+xr2sqZboAaTTxqWJIZd/flsGRFQq18tcaVYfGZxKALsSdCZVCMqFwxKhdwoR
         /Af8bfxvi05N9rvzD01BmFj/wUKbExjHlX79qcyYfc1oSVziX7r0rZHYNWwuvpcdaaZs
         MoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012283; x=1725617083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5a45zgnKr1XZRxdreeDmqy+oLRtttPm8KTNMecFwc8=;
        b=EkfszyWZUpDLJpDb8S7mIU140NitG7mZzgx9AtV377hKqs8fn5evCgI9BsL0bGoQ3i
         wj9W+Gj+Pvc1rOWFPYVKNcScLLi120wZPmkO43sltG4Qv9rRQj8R+oogT5SvW1HUzFFg
         GDv/moO1ccQdYFDbPmKaRC6sb/5mcqbD/CyDrtvjCKfVCHDrxK23pLmm0zMqE/OqqOK1
         N9m1jo5b45O9+1/kqVvttHhUP645ep8XmxHqfmSHhX8VkcR6JMRDvElLWhEAmn1C0Znt
         T6kHa2zmJMsOtFD2YaZ8jtENJQv1ODVLXB5+Mdy0vxBJ+qvhbz+MMaEte+B3PPEEa6xa
         s2wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW231TWpjAZyF+XrjFivtqSbvc6hj4R6tWem4eWRU85jOJYlHDAl1bSAlT2iwkYa/yyXMh7p2HshWHT5Ukp@vger.kernel.org, AJvYcCWpfvxB3vS3MCdzMY7jlHsSg7gViP37a1Hhkj7im9zAyleJiZCMZRgQsOFZARzE/JIQ0AGaXxjdG/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YztnzHtcpAqDTeOjWKGUJGCFxuXXmf3k13dPxzmT0lWa6Lf/QhP
	yn3MyjHrOSGCXgNEwm4Ta0dJxztofxESC6sZ7GN1N/QRhO3mz9Zs
X-Google-Smtp-Source: AGHT+IGgUTAqqh5BMFm/0McbIC4rNQXxf1Fjc0Krv4v/rvVrVCmsGivh9at8oTGIG8VkATlTayTR6g==
X-Received: by 2002:a05:6214:5410:b0:6bf:6b15:a6d9 with SMTP id 6a1803df08f44-6c33e69f6ecmr68793496d6.51.1725012282619;
        Fri, 30 Aug 2024 03:04:42 -0700 (PDT)
Received: from localhost (fwdproxy-ash-014.fbsv.net. [2a03:2880:20ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c435dbsm13151326d6.71.2024.08.30.03.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:04:41 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	npache@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Shuang Zhai <zhais@google.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 1/6] mm: free zapped tail pages when splitting isolated thp
Date: Fri, 30 Aug 2024 11:03:35 +0100
Message-ID: <20240830100438.3623486-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830100438.3623486-1-usamaarif642@gmail.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhao <yuzhao@google.com>

If a tail page has only two references left, one inherited from the
isolation of its head and the other from lru_add_page_tail() which we
are about to drop, it means this tail page was concurrently zapped.
Then we can safely free it and save page reclaim or migration the
trouble of trying it.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Shuang Zhai <zhais@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/huge_memory.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 15418ffdd377..0c48806ccb9a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3170,7 +3170,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned int new_nr = 1 << new_order;
 	int order = folio_order(folio);
 	unsigned int nr = 1 << order;
+	struct folio_batch free_folios;
 
+	folio_batch_init(&free_folios);
 	/* complete memcg works before add pages to LRU */
 	split_page_memcg(head, order, new_order);
 
@@ -3254,6 +3256,27 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		if (subpage == page)
 			continue;
 		folio_unlock(new_folio);
+		/*
+		 * If a folio has only two references left, one inherited
+		 * from the isolation of its head and the other from
+		 * lru_add_page_tail() which we are about to drop, it means this
+		 * folio was concurrently zapped. Then we can safely free it
+		 * and save page reclaim or migration the trouble of trying it.
+		 */
+		if (list && folio_ref_freeze(new_folio, 2)) {
+			VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new_folio), new_folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_test_large(new_folio), new_folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_mapped(new_folio), new_folio);
+
+			folio_clear_active(new_folio);
+			folio_clear_unevictable(new_folio);
+			list_del(&new_folio->lru);
+			if (!folio_batch_add(&free_folios, new_folio)) {
+				mem_cgroup_uncharge_folios(&free_folios);
+				free_unref_folios(&free_folios);
+			}
+			continue;
+		}
 
 		/*
 		 * Subpages may be freed if there wasn't any mapping
@@ -3264,6 +3287,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		 */
 		free_page_and_swap_cache(subpage);
 	}
+
+	if (free_folios.nr) {
+		mem_cgroup_uncharge_folios(&free_folios);
+		free_unref_folios(&free_folios);
+	}
 }
 
 /* Racy check whether the huge page can be split */
-- 
2.43.5


