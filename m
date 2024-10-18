Return-Path: <linux-kernel+bounces-371512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DB9A3C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C031C23D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50101202F86;
	Fri, 18 Oct 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWmXRq34"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7A202620;
	Fri, 18 Oct 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248642; cv=none; b=CezuxM98se5x53a8w9v3DEUPVhSvlG9OWN5Bh4M88S0nc0O6+bmh9tOL+DHB5VskVCsXwV/SIzLqRnfsPySyaAfJgVXEgc5u/AFIg9QlrHL8Jsvm38Pw/p2v90TmxmbSoD3dKg3sxqAcp6W6e3wj1oqjlQrjTZ+yhU9ODVtogBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248642; c=relaxed/simple;
	bh=E+3KLj+KeDz4T4Ju/Jg5+vwxJgYsOhayerSq8YuPCNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2DT1BV2SVoBcIk2pOKvnOFF7tFzbvswyswU3O1kqedQZl+qKF5adDNNGFSN8uykgcCqrZJwjbV/Yuo7t2FOI7weQTwGy7HllP0JhfUA1TVRkkkpfGTWlB0tH1IfVE20bO0TM/unTkHdXYyVXFvF5/5OSphXRasNZgFpaejFaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWmXRq34; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1507c42faso117763385a.0;
        Fri, 18 Oct 2024 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248640; x=1729853440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2+OQEgh0fCG5oZB9bP27eMnsujYhSchw3YP6zGdLsg=;
        b=nWmXRq34c5BpIa+tn/S4HtqNRaFqFPuKKga287H6Cd9QU97ySNOTy+aY143tV+Qp1o
         injgOqQ8DMrkV/zGZUdaR590eFiK36vrbmUoCjkrGJDU1fuKrxPslR96wumv/hRfgS5B
         VjZswFnkLz3fBHIY2Y+LxoCA/fGJIqytwPqAphFlpcoZdoefGnkgo0YhVBcc86bRH/d5
         POV5epcIt55pl1X0Yv/yKmaUemOz8HF+lH7cEDcuUvWzcSceQBE/zNsenwomI2UhX741
         5//hMuTZLI3/S9LK6puVOp3O6Onzs1aE2/jhRDqLkKnSwCBMELoLecaYYXAZOPw/tznt
         zV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248640; x=1729853440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2+OQEgh0fCG5oZB9bP27eMnsujYhSchw3YP6zGdLsg=;
        b=azMXHlIMKfwnIo0iiskjE519Nkb/ok0tgaDFmeT4zY7dYeSxqKHAOhbFfXLXH9Snv6
         lXR6OBAk9+XYYR8qntUa4+Bv1K6uCn0YNOqMo30hQsJgF7sfgI9QlGjAIWbQ2MYHcoSd
         uFg93l65KWduX+CZMlOuA0T0bL3WeG/9bhlFQAXUlHpcKiVLHYvDWLQP/CZEKnKYpWj1
         jSKFunOmycLmUX7efWa4sX3kiOqMNZTpJxZ3MCZBDoog69v/L3xedAMHzQx7UfHdOLpf
         dpNXnLd++12Y/zSqNqXwZjeWvtXyrMiA3Of78+qoCAhdudLpdIaqxF47RQ2fI5I22YbY
         UIng==
X-Forwarded-Encrypted: i=1; AJvYcCWDh/ZOB+mC7LHBZIRz7jVd0Tkdfyg2MPYZEJoTrQU0t7miX1P80KJB0oyqKzA/8xzg/tkFTjhZA0w=@vger.kernel.org, AJvYcCXn0o4/oSp7yWlPtjuh3gmMch03C9r+Qe3MyTcjQK2+c5wfXYWFy+Sl9tIq8PFKE7tkzGARTB4vTc6uEB0j@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVc7Id8qSIJRezLBEU+soZPzroJMTmOM74VJaZ0uwQTuxlYoT
	SrPtdyj8dUQvPDYh67qBfMeEy6iaLVi1Sr+uajvDalayeqhIRLQI
X-Google-Smtp-Source: AGHT+IExnPa9OX7aimLs3HML3KX6QH8HCRkuDhHElKsmz6WwfmgBG4EaxhA/mKXEbRMU3PnKMeQz8Q==
X-Received: by 2002:a05:620a:4708:b0:7b1:3c19:a665 with SMTP id af79cd13be357-7b14d51d341mr914254285a.19.1729248639792;
        Fri, 18 Oct 2024 03:50:39 -0700 (PDT)
Received: from localhost (fwdproxy-ash-017.fbsv.net. [2a03:2880:20ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156fe5b6fsm57894985a.82.2024.10.18.03.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:50:39 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	david@redhat.com,
	willy@infradead.org,
	kanchana.p.sridhar@intel.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC 1/4] mm/zswap: skip swapcache for swapping in zswap pages
Date: Fri, 18 Oct 2024 11:48:39 +0100
Message-ID: <20241018105026.2521366-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241018105026.2521366-1-usamaarif642@gmail.com>
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in [1], there is a significant improvement in no
readahead swapin performance for super fast devices when skipping
swapcache.

With large folio zswapin support added in later patches, this will also
mean this path will also act as "readahead" by swapping in multiple
pages into large folios. further improving performance.

[1] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@kernel.org/T/#m5a792a04dfea20eb7af4c355d00503efe1c86a93

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/zswap.h |  6 ++++++
 mm/memory.c           |  3 ++-
 mm/page_io.c          |  1 -
 mm/zswap.c            | 46 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index d961ead91bf1..e418d75db738 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -27,6 +27,7 @@ struct zswap_lruvec_state {
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
+bool zswap_present_test(swp_entry_t swp, int nr_pages);
 void zswap_invalidate(swp_entry_t swp);
 int zswap_swapon(int type, unsigned long nr_pages);
 void zswap_swapoff(int type);
@@ -49,6 +50,11 @@ static inline bool zswap_load(struct folio *folio)
 	return false;
 }
 
+static inline bool zswap_present_test(swp_entry_t swp, int nr_pages)
+{
+	return false;
+}
+
 static inline void zswap_invalidate(swp_entry_t swp) {}
 static inline int zswap_swapon(int type, unsigned long nr_pages)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 03e5452dd0c0..49d243131169 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4289,7 +4289,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapcache = folio;
 
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
+		if ((data_race(si->flags & SWP_SYNCHRONOUS_IO) ||
+		    zswap_present_test(entry, 1)) &&
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
 			folio = alloc_swap_folio(vmf);
diff --git a/mm/page_io.c b/mm/page_io.c
index 4aa34862676f..2a15b197968a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -602,7 +602,6 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	unsigned long pflags;
 	bool in_thrashing;
 
-	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 7f00cc918e7c..f4b03071b2fb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1576,6 +1576,52 @@ bool zswap_store(struct folio *folio)
 	return ret;
 }
 
+static bool swp_offset_in_zswap(unsigned int type, pgoff_t offset)
+{
+	return (offset >> SWAP_ADDRESS_SPACE_SHIFT) <  nr_zswap_trees[type];
+}
+
+/* Returns true if the entire folio is in zswap */
+bool zswap_present_test(swp_entry_t swp, int nr_pages)
+{
+	pgoff_t offset = swp_offset(swp), tree_max_idx;
+	int max_idx = 0, i = 0, tree_offset = 0;
+	unsigned int type = swp_type(swp);
+	struct zswap_entry *entry = NULL;
+	struct xarray *tree;
+
+	while (i < nr_pages) {
+		tree_offset = offset + i;
+		/* Check if the tree exists. */
+		if (!swp_offset_in_zswap(type, tree_offset))
+			return false;
+
+		tree = swap_zswap_tree(swp_entry(type, tree_offset));
+		XA_STATE(xas, tree, tree_offset);
+
+		tree_max_idx = tree_offset % SWAP_ADDRESS_SPACE_PAGES ?
+			ALIGN(tree_offset, SWAP_ADDRESS_SPACE_PAGES) :
+			ALIGN(tree_offset + 1, SWAP_ADDRESS_SPACE_PAGES);
+		max_idx = min(offset + nr_pages, tree_max_idx) - 1;
+		rcu_read_lock();
+		xas_for_each(&xas, entry, max_idx) {
+			if (xas_retry(&xas, entry))
+				continue;
+			i++;
+		}
+		rcu_read_unlock();
+		/*
+		 * If xas_for_each exits because entry is NULL and
+		 * the number of entries checked are less then max idx,
+		 * then zswap does not contain the entire folio.
+		 */
+		if (!entry && offset + i <= max_idx)
+			return false;
+	}
+
+	return true;
+}
+
 bool zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-- 
2.43.5


