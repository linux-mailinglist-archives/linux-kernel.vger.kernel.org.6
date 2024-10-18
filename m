Return-Path: <linux-kernel+bounces-371514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A69A3C24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA8F281564
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940F20400F;
	Fri, 18 Oct 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j85zSYob"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A9202F8D;
	Fri, 18 Oct 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248645; cv=none; b=lR+Fd4BgDpb0j6ebXJhqLNE2KQQEOu7thgMi13WwcUsHxM8YxCNZ86a45wXynr4jGSSdscs/IzfeXqXKVNhIPWy/HTzd9kYKX8iRSxkZ7w6QTbWaMujAQVQ8P8V+HPD8dzhXKc9yw22SAUCxxFdBp/V4u4QR8GUqvMc6my38Wb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248645; c=relaxed/simple;
	bh=dBCJBtfCMVkqHpxpzx0QimH2+im8KVN3SYCM3UISWTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEtpEto/nuMzZtX41PTIujK3gqKr95K6wYzfM39XgBT8T+6eklrwDlh1F6kLP3YItyJjkrO2dAUwd+IJQOOiVMFI/G31Y/ok0aW8Ld2cSxnUWZFr71KiGTtyKA2GrRsofpFl1Om45BLuIXWQbpxZSyfc5JrPLHB6ZCNns6hivdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j85zSYob; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso1922386276.1;
        Fri, 18 Oct 2024 03:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248642; x=1729853442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huWuZ5uHt0Ar/gjZBjsyETlUQ5fMZuwQtvUTxwg+3Fk=;
        b=j85zSYobfTlsXNhJ9KI1Nc/t/aI3GaHQGfC1leob+2lxrvGldLJhogbu1SWakTfXrJ
         Vbfb+p6JFq3K2N6ll2Tx2nVPuvZSNRC76K/XFzx8L6aP1g4IlZtRFT1+geb66UQMc9vV
         bYwnDlaBHgC7hbG8VuIaTpKbftrPyvNxp2D+DuArjAp9Zf2mAIB+gGu2gxhCql/W6AbJ
         y8cmlDkRrXLUuYJHIniqxZ5zcm+m8hyz07x2rE2m6raMdjOOGZ+/zaqKzAcBCAWuBXTu
         RAkfeje8kIbcYIpHCf13CBgGpUiOYcXkbN6X/1E0hbxp1JV9IiK0WHnN5jEU1LuyK8Ql
         JkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248642; x=1729853442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huWuZ5uHt0Ar/gjZBjsyETlUQ5fMZuwQtvUTxwg+3Fk=;
        b=Hk0ZwR83cVYvhIwJDpbi4lLOyqtTniYIBj40Tdma89ANGhtHz9hi/Pg59GRwImYvuT
         k9x1UqeGN34u9m/Y33jSYMWK44P/EWcplUX64FKQZp6CSmx+7FrMlsHrh3CVy9e6XW2d
         3oOqiwXWXiuUDW/BGIxXUvbg1VBohSsDs+2Tcqh/f0SibiwBFdXaeyGR8KKMTtSS9prx
         nqw3XAgy+mnmqKZfR7BGy0peoG7/QNO2k3GNjpLsk0l06VIrPI49IDkbJC7MI+/FA8/h
         iBGb8czHuwwATIyw3tLK0aA3swzVQVYohh0wDQzYErs2bEmobqFi7BzvTpMLCe5dLfLu
         g4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUF+W0qKbjwjma4YLNgj6DrbMLlaZHcWFkl5lCKWgnqEH2I1YIKdHPkCk3KX3sZ9tSzeS5O74txLe8=@vger.kernel.org, AJvYcCVtHO2Tn5hQROyvqhnHo98F2CBH6Ri47hQY5o6qNSQq0x1XiL7VOtoYC10dBUgfdm/h5nqj1WMFdFpywTK3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4o19NVpTunNOMQFRJdn2Sv7/KDvA7e4pCqPaR4nWYamfWBz82
	dRLBHb5FJKp/YB4BssKaAgQEGASan5jfj1FfACQc0D0P3FQ8yMzP
X-Google-Smtp-Source: AGHT+IH7UKKLWj1Gm56LuvSXibMHdJ9P4Zdin80hAy+JrAjlN+8W7nDtiVAWx8XbC+00QhotrmRWLQ==
X-Received: by 2002:a05:6902:2b8b:b0:e28:fbbf:7406 with SMTP id 3f1490d57ef6-e2bb12f6a58mr1693699276.15.1729248642473;
        Fri, 18 Oct 2024 03:50:42 -0700 (PDT)
Received: from localhost (fwdproxy-ash-113.fbsv.net. [2a03:2880:20ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460aea455f9sm6044301cf.64.2024.10.18.03.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:50:42 -0700 (PDT)
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
Subject: [RFC 3/4] mm/zswap: add support for large folio zswapin
Date: Fri, 18 Oct 2024 11:48:41 +0100
Message-ID: <20241018105026.2521366-4-usamaarif642@gmail.com>
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

At time of folio allocation, alloc_swap_folio checks if the entire
folio is in zswap to determine folio order.
During swap_read_folio, zswap_load will check if the entire folio
is in zswap, and if it is, it will iterate through the pages in
folio and decompress them.
This will mean the benefits of large folios (fewer page faults, batched
PTE and rmap manipulation, reduced lru list, TLB coalescing (for arm64
and amd) are not lost at swap out when using zswap.
This patch does not add support for hybrid backends (i.e. folios
partly present swap and zswap).

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/memory.c | 13 +++-------
 mm/zswap.c  | 68 ++++++++++++++++++++++++-----------------------------
 2 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 49d243131169..75f7b9f5fb32 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4077,13 +4077,14 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 
 	/*
 	 * swap_read_folio() can't handle the case a large folio is hybridly
-	 * from different backends. And they are likely corner cases. Similar
-	 * things might be added once zswap support large folios.
+	 * from different backends. And they are likely corner cases.
 	 */
 	if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) != nr_pages))
 		return false;
 	if (unlikely(non_swapcache_batch(entry, nr_pages) != nr_pages))
 		return false;
+	if (unlikely(!zswap_present_test(entry, nr_pages)))
+		return false;
 
 	return true;
 }
@@ -4130,14 +4131,6 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	if (unlikely(userfaultfd_armed(vma)))
 		goto fallback;
 
-	/*
-	 * A large swapped out folio could be partially or fully in zswap. We
-	 * lack handling for such cases, so fallback to swapping in order-0
-	 * folio.
-	 */
-	if (!zswap_never_enabled())
-		goto fallback;
-
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	/*
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
diff --git a/mm/zswap.c b/mm/zswap.c
index 9cc91ae31116..a5aa86c24060 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1624,59 +1624,53 @@ bool zswap_present_test(swp_entry_t swp, int nr_pages)
 
 bool zswap_load(struct folio *folio)
 {
+	int nr_pages = folio_nr_pages(folio);
 	swp_entry_t swp = folio->swap;
+	unsigned int type = swp_type(swp);
 	pgoff_t offset = swp_offset(swp);
 	bool swapcache = folio_test_swapcache(folio);
-	struct xarray *tree = swap_zswap_tree(swp);
+	struct xarray *tree;
 	struct zswap_entry *entry;
+	int i;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
 	if (zswap_never_enabled())
 		return false;
 
-	/*
-	 * Large folios should not be swapped in while zswap is being used, as
-	 * they are not properly handled. Zswap does not properly load large
-	 * folios, and a large folio may only be partially in zswap.
-	 *
-	 * Return true without marking the folio uptodate so that an IO error is
-	 * emitted (e.g. do_swap_page() will sigbus).
-	 */
-	if (WARN_ON_ONCE(folio_test_large(folio)))
-		return true;
-
-	/*
-	 * When reading into the swapcache, invalidate our entry. The
-	 * swapcache can be the authoritative owner of the page and
-	 * its mappings, and the pressure that results from having two
-	 * in-memory copies outweighs any benefits of caching the
-	 * compression work.
-	 *
-	 * (Most swapins go through the swapcache. The notable
-	 * exception is the singleton fault on SWP_SYNCHRONOUS_IO
-	 * files, which reads into a private page and may free it if
-	 * the fault fails. We remain the primary owner of the entry.)
-	 */
-	if (swapcache)
-		entry = xa_erase(tree, offset);
-	else
-		entry = xa_load(tree, offset);
-
-	if (!entry)
+	if (!zswap_present_test(folio->swap, nr_pages))
 		return false;
 
-	zswap_decompress(entry, &folio->page);
+	for (i = 0; i < nr_pages; ++i) {
+		tree = swap_zswap_tree(swp_entry(type, offset + i));
+		/*
+		 * When reading into the swapcache, invalidate our entry. The
+		 * swapcache can be the authoritative owner of the page and
+		 * its mappings, and the pressure that results from having two
+		 * in-memory copies outweighs any benefits of caching the
+		 * compression work.
+		 *
+		 * (Swapins with swap count > 1 go through the swapcache.
+		 * For swap count == 1, the swapcache is skipped and we
+		 * remain the primary owner of the entry.)
+		 */
+		if (swapcache)
+			entry = xa_erase(tree, offset + i);
+		else
+			entry = xa_load(tree, offset + i);
 
-	count_vm_event(ZSWPIN);
-	if (entry->objcg)
-		count_objcg_events(entry->objcg, ZSWPIN, 1);
+		zswap_decompress(entry, folio_page(folio, i));
 
-	if (swapcache) {
-		zswap_entry_free(entry);
-		folio_mark_dirty(folio);
+		if (entry->objcg)
+			count_objcg_events(entry->objcg, ZSWPIN, 1);
+		if (swapcache)
+			zswap_entry_free(entry);
 	}
 
+	count_vm_events(ZSWPIN, nr_pages);
+	if (swapcache)
+		folio_mark_dirty(folio);
+
 	folio_mark_uptodate(folio);
 	return true;
 }
-- 
2.43.5


