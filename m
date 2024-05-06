Return-Path: <linux-kernel+bounces-170343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6478BD570
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7531C2266A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B74915990F;
	Mon,  6 May 2024 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9hwrpB6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE81598FA
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023769; cv=none; b=DnO2AyCSRJ/SB5X2EC3w0MdbTimyj5lIch3LXQ+iFK+Mv+5QNiq2Gxp1/46/JVmz6rhCtiQYR1IpATeYMBzu4UU1IjW6IjHNUft5w7R7qFHMzL4PEfaPZk5knDUctFnmyGXB/ij6ZQwTngvJmHmVqUlRclc+JWFocourUKhuefk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023769; c=relaxed/simple;
	bh=78VsLkCuW49vhVgkUXJxT+pNVEKkHi1mMQj62BGccng=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sd1biJ2RuhgO2fP2K4knGTpkPsa+ZmRyuCklrcjULYb+6N+0Gq3Q/GAOt8t54x3Ooz3F9o/OTmgLWqVFHOFHLuffmPtLB1m9MBan9iNDuWvWuCTs8hmettq+G8ID9ELi9Er49oWncSxtrwD1MQ37NF0CSLAR6UmTA/PUeHvd61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9hwrpB6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61df903af62so46917167b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715023766; x=1715628566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vMsFvGn5E9drw/PQULeDN2NnDOV6ZTK3bSrrukYn3gE=;
        b=o9hwrpB6NbTHO0NadKc2rt6piAKOj5GzKtPIFzaiqwGV+ITfdeiQtvwVuLrxXaIzTf
         VtQJtXsaW894aFAIhX6lV8Lan29VutEspRHsqs1Yuk+7hmCaHZqLrnPjTibSC3GYQHrh
         CQGtv2NpTNkmwUISq7lkDGOh5tMcNFzsrsd4/poHlsnLNiYmrzNEoGxgD+j+ztESbLyl
         Kr/iTsUfeAQuCpNhfU2NoVN+TcmI5DvWOOuBxT7MievIgWs9lEshs42WYQ9vqsuhqwZV
         uomAXFkWCqQP5ZcxGKt+8KhisG5gpTGZeUTn0jYeDJUqM9Agn8xCPFIH+r29LzWlBMsF
         mTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023766; x=1715628566;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMsFvGn5E9drw/PQULeDN2NnDOV6ZTK3bSrrukYn3gE=;
        b=N5rziKH/OpxSdbJVDxdSiINm7slgQcJai5YUHlf1/dJmAPTLq5TYHXIZnAN2YmGHyM
         tRZnfJIqv80q48GpbU09j2GE7aIVm1NjJj7yY0CSA9sGzIsSHM09Yk+7GS7nWcBoThzJ
         HLnOghgKnZLtIsSETKZu25MMSaGQuGstwPojEq33LbVHL43+UEuiXk0FfxD55nwwoa1+
         ssM+/hHeozac8u3HXQA+gkUQCRK0i7KK/0YekO5Bjlt67+JbgWBOouwG5Jkq3y9mupK1
         enhThNdRq1F1hAn1mh7A6xc6X5AYzUtYDffrl5D5w3XnenSmvSGXlXpqC0TPpis+fL9Q
         /C6g==
X-Forwarded-Encrypted: i=1; AJvYcCX/3XuBLMgN251CnHSHhb/TwutSwl1vR/5bXGlFFa3dyJW+mdTlIgwBuBZqlYEjvyrrQPjN1CkLgZh35YZdlv66Wnn6FK8MAjAKDs9I
X-Gm-Message-State: AOJu0YzGcSw14y6CudV/LZJepv0/TXiGL3QcY5zTOFDmHrn459QCAHFG
	3V/f1BC9fPzXZxWhcXNvEuqykJLBF2aXglmukhw037N+vNyih4FewkHnjdPb/JSsz3w4BR5e5Ct
	5Jt79tW5UiAXn7QAOAQ==
X-Google-Smtp-Source: AGHT+IENOCELgpMw5VEmqAi5bqOPnEO/Pk6007gBdU/F+qmzq+7vIo3uBQyfw0E3lDsJXlJtZTiPMqjyGbUwAkXi
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4f05:0:b0:61b:e75b:4806 with SMTP
 id d5-20020a814f05000000b0061be75b4806mr3003407ywb.1.1715023766466; Mon, 06
 May 2024 12:29:26 -0700 (PDT)
Date: Mon,  6 May 2024 19:29:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506192924.271999-1-yosryahmed@google.com>
Subject: [PATCH v2] mm: do not update memcg stats for NR_{FILE/SHMEM}_PMDMAPPED
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, 
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Previously, all NR_VM_EVENT_ITEMS stats were maintained per-memcg,
although some of those fields are not exposed anywhere. Commit
14e0f6c957e39 ("memcg: reduce memory for the lruvec and memcg stats")
changed this such that we only maintain the stats we actually expose
per-memcg via a translation table.

Additionally, commit 514462bbe927b ("memcg: warn for unexpected events
and stats") added a warning if a per-memcg stat update is attempted for
a stat that is not in the translation table. The warning started firing
for the NR_{FILE/SHMEM}_PMDMAPPED stat updates in the rmap code. These
stats are not maintained per-memcg, and hence are not in the translation
table.

Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
NR_SHMEM_PMDMAPPED. Use __mod_node_page_state() instead, which updates
the global per-node stats only.

Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000001b9d500617c8b23c@google.com
Fixes: 514462bbe927 ("memcg: warn for unexpected events and stats")
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/rmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 12be4241474ab..ed7f820369864 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1435,13 +1435,14 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
 {
+	pg_data_t *pgdat = folio_pgdat(folio);
 	int nr, nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
 	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
 	if (nr_pmdmapped)
-		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
+		__mod_node_page_state(pgdat, folio_test_swapbacked(folio) ?
 			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
 	if (nr)
 		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
@@ -1493,6 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		enum rmap_level level)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
+	pg_data_t *pgdat = folio_pgdat(folio);
 	int last, nr = 0, nr_pmdmapped = 0;
 	bool partially_mapped = false;
 	enum node_stat_item idx;
@@ -1540,13 +1542,14 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	}
 
 	if (nr_pmdmapped) {
+		/* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg */
 		if (folio_test_anon(folio))
-			idx = NR_ANON_THPS;
-		else if (folio_test_swapbacked(folio))
-			idx = NR_SHMEM_PMDMAPPED;
+			__lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_pmdmapped);
 		else
-			idx = NR_FILE_PMDMAPPED;
-		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
+			__mod_node_page_state(pgdat,
+					folio_test_swapbacked(folio) ?
+					NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED,
+					-nr_pmdmapped);
 	}
 	if (nr) {
 		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


