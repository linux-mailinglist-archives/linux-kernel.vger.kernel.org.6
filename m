Return-Path: <linux-kernel+bounces-277975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1D94A8E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15AA1F2396D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C9201252;
	Wed,  7 Aug 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdlc/N/S"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919516D33D;
	Wed,  7 Aug 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038468; cv=none; b=XDv7+U4zIEGzQZFg0TmkdKNuuq4w+m1xT0B2RyeSydYtph4TOqYeTlbCJbrnERiwCMYlQ9tjxCyHf5iyj1EIw7xstHEyDKm92WwNCcB3Xu8ccPvKChVu0ok6LpnCmCHewzObsB/F5zWDTTpsk0BUQZej05zq6psrH6UkMm4NRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038468; c=relaxed/simple;
	bh=XpYlSRalM38SQjuNc1jcVn+PQ1YrBsxXCKDHCm81Ek0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pr5Y+KxsZ0q2MOBlEFC4+c6doB85SDpZhy3TPnl4H9GnrAi5gaKno0VPpSp08r6vK+tQcpq6/GM8RZaSbAOZBXtSL6QMphVitlpHcuIuvOsRpD4iD4JOivRwRqGkJ9HEFUIAfel/xSggBTNmxsTvObCT+tYPrnwsX09WCDqYUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kdlc/N/S; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1e2ac1ee5so110425885a.2;
        Wed, 07 Aug 2024 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723038465; x=1723643265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n39d+IWtdA2JQS+BpIYOw0YcWHtdqS2CWkUSdBw2K4k=;
        b=Kdlc/N/S2Fy0QwPlTf3enwGJxlUvEqh9BQdLCKsi1fynxraps0NsqAuluFRNCuCfuz
         8Ka6LO5+T+GV9r5nhBo7OfjlUxIiNkQwSLk3N4IwwXe3gsesXuCfpPhamHFHT/hr9gnM
         AJR3m8QzTNYDgPLFh3gjmLaxpr0AllDSWbCuAIBFSivA+3l+b3G5Pxti9+Vkd9Syx9pD
         Vb1iMac16InO0V90Rs7F1go1mIpwTIeAJXYD+Ih7c6HZotVmDf4xT3vJ577HMD4/hGSn
         +TUZXddM9w1Lm27pe3bqU/NxoVjiAw029oxaT0EWiuLGxsMSqAaUKFdzlUlygNSREEJr
         mxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038465; x=1723643265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n39d+IWtdA2JQS+BpIYOw0YcWHtdqS2CWkUSdBw2K4k=;
        b=s9BPCSyR9/BJVoZPEP6iyGvJ4jCzufQoJLDDl21jvMJsRp3+6MURK9nrpEL7pNgk+E
         P8pD6SgSCwCK6Ra3AkTUP4m9N7w2BahOzFB0fhY87zO7SsdJgEPHB4+8XT1gyjNiuP+V
         xxy0UmZSJ44UojhVudBgAk67VichA4mEOZRvPWCgU7g07XFfgm6aSRyCAGgvrrRo70zR
         8rGFOrAviz4R+eHxJ1quamhRMmBjxdMQLBs77QH2vc51joMKRZAhw/vp/V3trJEmApn0
         phE710R1tuEAWRnHAwDSyNKj7i32lzLr1KuQ2O44KwReMsXRKu6V4LfSG2aHCKv9mweo
         trCA==
X-Forwarded-Encrypted: i=1; AJvYcCWCmC8E39ZB3rcYG78xpZEtWlHUiC5CoJDh4jrDvE36KN5Vsuj6tOb7HWTJ91wLJk20l9+i6TgEuM2YHZanfj5wKswScjM469qCscmJwBnSaPprTbvNWY5AUCHa9ziYF1G4C/Kzd7cV
X-Gm-Message-State: AOJu0YySf4SXIyJLwwrryv7aB4Geo9jq8FsG3MQMGUXwdGNjlOx+9NCn
	37ncQPNAFE+ohbD0CAWCc0WMF2JIrhbV2Atg45ql8V2hRbejWZbh
X-Google-Smtp-Source: AGHT+IH2crYrVw5Uo49cNtRninlNhqXXouxpaW9XqAiOrqXC/AGUTQip+1f+mVtZYYseV7xd5/GWxg==
X-Received: by 2002:a05:620a:c44:b0:79f:ddc:163b with SMTP id af79cd13be357-7a34ef63f55mr2296134385a.42.1723038465591;
        Wed, 07 Aug 2024 06:47:45 -0700 (PDT)
Received: from localhost (fwdproxy-ash-020.fbsv.net. [2a03:2880:20ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e0b4fsm62506585a.31.2024.08.07.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:47:45 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Shuang Zhai <zhais@google.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 1/4] mm: free zapped tail pages when splitting isolated thp
Date: Wed,  7 Aug 2024 14:46:46 +0100
Message-ID: <20240807134732.3292797-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240807134732.3292797-1-usamaarif642@gmail.com>
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
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
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/huge_memory.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0167dc27e365..35c1089d8d61 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2923,7 +2923,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned int new_nr = 1 << new_order;
 	int order = folio_order(folio);
 	unsigned int nr = 1 << order;
+	struct folio_batch free_folios;
 
+	folio_batch_init(&free_folios);
 	/* complete memcg works before add pages to LRU */
 	split_page_memcg(head, order, new_order);
 
@@ -3007,6 +3009,26 @@ static void __split_huge_page(struct page *page, struct list_head *list,
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
+		if (list && page_ref_freeze(subpage, 2)) {
+			VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new_folio), new_folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_test_large(new_folio), new_folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_mapped(new_folio), new_folio);
+
+			folio_clear_active(new_folio);
+			folio_clear_unevictable(new_folio);
+			if (folio_batch_add(&free_folios, folio) == 0) {
+				mem_cgroup_uncharge_folios(&free_folios);
+				free_unref_folios(&free_folios);
+			}
+			continue;
+		}
 
 		/*
 		 * Subpages may be freed if there wasn't any mapping
@@ -3017,6 +3039,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
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


