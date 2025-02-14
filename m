Return-Path: <linux-kernel+bounces-515457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4A8A36522
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7595918966DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2DA26989C;
	Fri, 14 Feb 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciSohYQU"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731B269829
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555919; cv=none; b=N+BMIzB480If1KsdjKksia+BhX98xQY7zq8/PG0DXVTzj5FAc403RCsrvELBqzT8HgyEgx4HU8pPN/LqVresVOQYx+JgVUf9kAZYZAVcbgtaYWroeyKDunY6n6niFeCvgnTEMs4EvNH1sJyeH95rcg7pDBo8mnqL3newqC8Et2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555919; c=relaxed/simple;
	bh=AD+oohae5+ejRZ2Rzd5XjPagNVmRG8kydqZMbl7927I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTwb67+tT7A+Sqe14m5RUovn6XOn95vS/gJUsZc92ryIMkc4ZQWtDS62QYNItINJvoZP0TyKid/XYHOfMhk4Jcho3WzlfdfF8TVMuyvBYj52qp0O5dfZ/8PMVgYXl4Nt4+zBjohA6VIVHGL7+GDtub772cMpmFBvzndVnt78hBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciSohYQU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f6a47d617so41709375ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555917; x=1740160717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vo/Vw3N/1YvU4dFuupnxGUy23lCsf9jYjVH89XpowKk=;
        b=ciSohYQUSYJNitIDoROKR2nAKehMZwRPURlXe/QzjQXETUEYwfuANR4ZDuAB0KBMtE
         ggNDz8MoHQm9I6K319rk9aF1QzUss7N57T3naDwW55VPUMnDiAVOpXZ/RqbR/HA3xLQc
         +jYS3MnLizz8WLIx34ftvPmtlAP2RzSROQ3Ff17V+Ip/W5GY2uvE7coTM/AR/1vx1LMY
         YmSbDXfLC6fWQoVIx7T/tqLB2mzXniWxyw+kVdxhq7keuIdIGtFbifouncBPBGq0hW07
         pUOkmsQhE0TlaTKQsqUw8abvZskgdGuAQzHvIWyUmU/bV9iDawpEClgOK0suYbR8mNab
         JN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555917; x=1740160717;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vo/Vw3N/1YvU4dFuupnxGUy23lCsf9jYjVH89XpowKk=;
        b=fcgKUNx3iB1bu6udMPEnXEt645EnOS/qrANjOrtl5n2tHxrRfKvBmn99VeuRWK6Jh4
         vgW1rYULKk9dJWSh7H49F2Glp8Ie1Uo3CzvWuGC68CMlEWojR/wUd3iZUWyI1CcvP3Kx
         X7nOIx0ycP68hBE33UxRJe1AegG7igqBNpBPpv0axXVys7KAK5B9Scy5xziq9V3+4YsI
         LBancNArabmFatGcO1ltusdIoVqRZohdF54jCk1D0tvzl0DEvwhaFgMyzDbXC0VVvjpz
         yPuURKyOqu4jSa6V0xA0nua3vX0T5RPom0Rx4U/Z28n5n80r+LQueUwWJK60TfhjPNlm
         kMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmxxvsHyXrSAX5rx39H4XtBa1AaXK3yf4kSjgQNTJbD3iT/Z1/V4yl2WbgOj0xxsxDfX+JPMIkSg3uhwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBDvX/t2Bjg9YwwQboVtwBWm6Oky58w970JPCJdCnvfmPic7T
	jYFNSULu9JCi/Gmq2vchxImZ5ReyYowcJ2JSAEiu0/g3TIeFmLeb
X-Gm-Gg: ASbGncu50ZbNFPDuwG7kbQrwA05HxEgrvFrkEPSg8JMZ8n5RhPvkoSXZs/Msg5/agHL
	7Di7+ThGsn1axZ8Z2jATLkWv3W/zlQP5DdBUz2aZX9oNPBYlO9e4ln3AunmILDFpIr4tt20w+Tv
	4VkVn5u72V5Lleki94sFuBR909q9I06cSKiV7NJ40hJioYdjTQc8b45WJKMk5Ux+svYwNWInSh/
	68fhRQkPkWmjux3oIvul47OEuN43H0HFx3788JYp3hi2Kugv2kBc71FdAGPnB7bfCScVA1Oby/H
	T9OH7Ue+gB/dyRIAzDQ/sLNVqkvPcAFLsv4X
X-Google-Smtp-Source: AGHT+IEqu8/5Sy9EBJ+I/60NzQrDUdehFXtUPvZTfs+82aTm3p2XSzB32UYFzYofOshKbGfGpZWekA==
X-Received: by 2002:a17:902:ce09:b0:20d:cb6:11e with SMTP id d9443c01a7336-22104062bcdmr2226915ad.26.1739555917455;
        Fri, 14 Feb 2025 09:58:37 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55943b5sm31216605ad.246.2025.02.14.09.58.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 09:58:37 -0800 (PST)
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
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 3/7] mm, swap: avoid redundant swap device pinning
Date: Sat, 15 Feb 2025 01:57:05 +0800
Message-ID: <20250214175709.76029-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214175709.76029-1-ryncsn@gmail.com>
References: <20250214175709.76029-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

There are only two callers of __read_swap_cache_async not holding a swap
device reference, so make them hold a reference instead, and drop the
get/put_swap_device calls in __read_swap_cache_async. This should reduce
the overhead for swap in during page fault slightly.

Signed-off-by: Kairui Song <kasong@tencent.com>
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


