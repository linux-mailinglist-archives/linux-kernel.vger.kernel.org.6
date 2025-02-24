Return-Path: <linux-kernel+bounces-529755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D35A42A91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735E7160139
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EB0265CD8;
	Mon, 24 Feb 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BreM1I9O"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCAE265CC1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420183; cv=none; b=O9ARCDo+zIR8iCy/qAu2mQQpm/YqHZicheu/3+BWa+nO+3XSoB8pQHmVEIn+QD2OpvwZnUODPH9vzzshBeWk5e70melADN63HXYU/4NipySqloZTg7bhZWJB8iV4vSK3jzaKPkN7clGemfMJscpNiLb6VAU/DARGIWyThSuidDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420183; c=relaxed/simple;
	bh=xqToex4VcWxib0ndV9cUtQuDd3ofcz9vQ62tZ39OdXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9YhiVknSnHKHbPxWhSgf1tdzpvQNmUX+/Ql/mZlkcVGjItBpjufrj0+xy9qS+CGSwKx/DeYI0h2rNJ9CIH3IQ6XhrUIvqQ26lMs8T1T/76cAoVNIduFnrsasA0DQyR3pv/UBOC8WyDAp8nq7jLxcNcR7rux/jaMn5fMvppeYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BreM1I9O; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2211acda7f6so105731745ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740420182; x=1741024982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HFN+prd/q5R/gZ+dsQNPlGWJ7GO+s/LReOSW13ezbxY=;
        b=BreM1I9O+NMV+eJMqF7OMxGwR5+XMgF5w2c1aHRA5YN8yqbZsnsl6RYGZ0XYexn4iz
         lN7cIuaqjVZiyrb0xrFXi6E13gVB3sLNxIcizRP6r6lfT1SjTSZOMO+1NZwK1L2/fOTr
         UTnpRzdc5HfhL0j2jpAE+QXZPbx5Y9R1c6P4l9R0QxXRILSETAOWIolHJDXJsXUllHRT
         W+dS7mOn7AfScHxmf9SnRYpgJFYxiiEmGmBF4kl+EkdGf42QFpEOz515RRfhzgIGr6SZ
         O0iY+d89MQsXzLVtGSDmg/cTSTv5/PfKBCjk56lEa3HnxFlfSkvEoGbBa77HoLvaisgG
         LXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420182; x=1741024982;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFN+prd/q5R/gZ+dsQNPlGWJ7GO+s/LReOSW13ezbxY=;
        b=T8MXveT11dxZ57BZb+hJZhrZ/1O9uxVl05ngX7WJenw2/U2SN/U1EWYWQ3C4TderGl
         zXr6smARdjPtKGoB8WNV7RA/6nJ1sLtsWF4ayBCsFjx+Af1mmtOpgnPDmO4wOk5A0nRd
         CJgKS5m8sCRHE31ugvv0a7w0bWBlg3pthSVL3/wypcngoc55haCqR1Q/e02svU4hh6GR
         hLZ5XVClWrs4NzwLMoxQaWtfi47pkF2VQHAQlLtu0vyddHQOqjLpzpSOWK/UZzH1yEIG
         meaUAsXaFuzfKhduMUBlcKNekfAsKgvrg3UbHpmeHhiJTvY3JVnnRWZkczpUaIGuDubY
         2xGg==
X-Forwarded-Encrypted: i=1; AJvYcCWtEKYgpNAFbf2U9hd5RuGgVq27Fki7n1bKAg0m7vT25NygD5MiIAAnc4RjsRi3jTWvS0jOJM24no+dTSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2u2cLV9S7aYxPFSr/3iNumJqDbCJznLB/jpP+WWc4Omp2oX+
	kVxURfDJLj+6nAj1gt0aYc7jjsRwzRI7biVmoXMdWiowWC1njBWB
X-Gm-Gg: ASbGncsP9+6sWv+/psskkOgekMfyrEqe4JtTdJ8h+5Ir9W1L4WCZqcuKvtPp8m443rL
	D2nFciCjRGjQ77sX8yEbraxe3ujpafUYFa8M3N7d/pkk2gLpZ95txY2rqnXVvPjh0Ksbz1vlIH6
	Ol+Zn06v7gXowiVADdVqZp8X42dY100xI1Z0D3hTpGjjM4zMClJhMeYO49WnTZ50NRqwar8cjuE
	0L+wZOJThuohX8s3jTARVLvvGheMEM/9eivFfFIOO3vmJhq9Ns+tsaqxX3Gp0cycXd0CUu6V8oW
	2MIE8Qvy5ys3gHpUJoThk8u4vXbzckVQdT3MsYPOukP7
X-Google-Smtp-Source: AGHT+IE7STMjzV87+hEURfhIdB6UH8LCMfNhfiVrnK0UHPVcExU8+vGKEEn+3A78YlQKgQnFURWA4g==
X-Received: by 2002:a17:902:c950:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-2219ff5e619mr252864045ad.25.1740420181541;
        Mon, 24 Feb 2025 10:03:01 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([1.203.117.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556e15esm184834695ad.190.2025.02.24.10.02.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 10:03:01 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 3/7] mm, swap: avoid redundant swap device pinning
Date: Tue, 25 Feb 2025 02:02:08 +0800
Message-ID: <20250224180212.22802-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180212.22802-1-ryncsn@gmail.com>
References: <20250224180212.22802-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Currently __read_swap_cache_async() has get/put_swap_device() calls to
increase/decrease a swap device reference to prevent swapoff. While some
of its callers have already held the swap device reference, e.g in
do_swap_page() and shmem_swapin_folio() where __read_swap_cache_async()
will finally called. Now there are only two callers not holding a swap
device reference, so make them hold a reference instead. And drop the
get/put_swap_device calls in __read_swap_cache_async. This should reduce
the overhead for swap in during page fault slightly.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swap_state.c | 14 ++++++++------
 mm/zswap.c      |  6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index a54b035d6a6c..50840a2887a5 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -426,17 +426,13 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists)
 {
-	struct swap_info_struct *si;
+	struct swap_info_struct *si = swp_swap_info(entry);
 	struct folio *folio;
 	struct folio *new_folio = NULL;
 	struct folio *result = NULL;
 	void *shadow = NULL;
 
 	*new_page_allocated = false;
-	si = get_swap_device(entry);
-	if (!si)
-		return NULL;
-
 	for (;;) {
 		int err;
 		/*
@@ -532,7 +528,6 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	put_swap_folio(new_folio, entry);
 	folio_unlock(new_folio);
 put_and_return:
-	put_swap_device(si);
 	if (!(*new_page_allocated) && new_folio)
 		folio_put(new_folio);
 	return result;
@@ -552,11 +547,16 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug)
 {
+	struct swap_info_struct *si;
 	bool page_allocated;
 	struct mempolicy *mpol;
 	pgoff_t ilx;
 	struct folio *folio;
 
+	si = get_swap_device(entry);
+	if (!si)
+		return NULL;
+
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
@@ -564,6 +564,8 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 	if (page_allocated)
 		swap_read_folio(folio, plug);
+
+	put_swap_device(si);
 	return folio;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index ac9d299e7d0c..83dfa1f9e689 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1051,14 +1051,20 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
+	struct swap_info_struct *si;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
 
 	/* try to allocate swap cache folio */
+	si = get_swap_device(swpentry);
+	if (!si)
+		return -EEXIST;
+
 	mpol = get_task_policy(current);
 	folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
 				NO_INTERLEAVE_INDEX, &folio_was_allocated, true);
+	put_swap_device(si);
 	if (!folio)
 		return -ENOMEM;
 
-- 
2.48.1


