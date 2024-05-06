Return-Path: <linux-kernel+bounces-170211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AEE8BD386
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A411C21CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E7E1581FE;
	Mon,  6 May 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXaFGxY1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5AB156962
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014829; cv=none; b=DfMHOl232s3t7RC8/bkBeU0RpEA/BU7dhqvyaYgW6+M9D9Jlq6S0ksXHsmHb1vdHX30jau8MlJv3Yr+/eZOX+9CGlA60StuYYhDjQpiYH8H0Hw3eyisrK1LhegwA5yd5f1ZbL1TUQTYiCT5dcSgfoggoELRIjlLEnWL1+a/SLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014829; c=relaxed/simple;
	bh=jhh8LyHkwXk9703eTsRhjl8hIDK7WrfNFcjG2s8a6Kk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uzK+L46gToqlObedRPon+qkSJ5vQ1g0UGZ0MSRSAPEFX3erm1QqL1lqeFgHhC/65fcv6KmSOuIj65SA6Lo1ENkTroeZE/EeZ7NQDYbY/IbII+QC9cEmK7IypU3r415ad2ffuhJiYl4+/zdzqpJg/FZutzW/jwg1eLpvzxRYpFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXaFGxY1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be25000a4so45682547b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715014827; x=1715619627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NtGseJ2cTzNz5m7usek72YLEdD+Xy4saxF80B0cOKZw=;
        b=xXaFGxY1ALAGoHlPQw1NQ/YZY3yU9ou5iFANjdyC7ll5p9alCOphrNH4TQLdnfToyB
         m2c7VrJ+Ihundckf3pYO08BEBXo9ZO46fajrYMkFN6SLRREMLzV3t3zfR8d+heADImvK
         LkLJW5Ve99CxnttYro5HMKaqnzjNmZYXAK9J35QrpgutxXN8RSD8IoklQ1XSNjgsRh4l
         yeHVnMA6n/12q3Svl7+CasLPFLhEcu8HCnf64hHrpiHDRkXbEau/wWILZKs8ibkmUGpl
         5vPtHsvwgFZWWamEpr7RUnQOFl2uVP+cyb2PYva+gd5fwMltEHhw3YmnvG5TdleMrxtP
         YqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715014827; x=1715619627;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtGseJ2cTzNz5m7usek72YLEdD+Xy4saxF80B0cOKZw=;
        b=oJ2AxhbaKw3Yf43D2FcmtL5vZwonTOC/enFLuiG4n18wBjhi8vRr/lQmw5AK2ad8Gw
         St0HsXxmaBO8L/hufnePwmFo+PdLthQNZ2DVmQfwLpPRJDSibZ3Fa6SanlIOS4WklgRY
         ck+1I0KsdDHqS1RufmWA7LqARGcBZrsUs0fHJRWcoh9ioE+1z8rvw3nMgTE3LWJGBgny
         5FuYvwZDccGJnqHyEbRSITDWhGYZ4l2Ys+nrdw/fKxFA0DfGhtTdy5SOwyIL+6P8ACXQ
         VUtSnXs05fGsGn+usttaVQ2QwaSBoLTIsppiwvmqrn9+3uem7NiRgzqARgtvdD8Jockb
         LlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwowXniH5ycDR2fBMI3FI6t+gtFNTSD6h6hJVmWl/gM5vPqckT4KEqQZXkqp03ZPUKInq5PHytVmGYd9hqQQRWclCwgL0M314MakPi
X-Gm-Message-State: AOJu0Yyo4QVYiL5w8vSV7QknrDhIB7xJbfYWvj4Sr58RRZ+sBbWnpz6+
	4X+2AGY+fogtd4cWFIG8VDHtsRmQ27x9hIjiyUeOeb5L4coXM6lw8TmxuGTZ9nFQzucvE2+nUEZ
	XMCQExOY05QW6SAkjMw==
X-Google-Smtp-Source: AGHT+IHlyLVb/6ZNQeHwPNEf5AX1+AhaGqFqM5/t0YfXLcEDdTp7Br6QVMdHD+ukGbKsxUoTnlGAazy8w9nonexk
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2b8a:b0:deb:88f5:fa10 with
 SMTP id fj10-20020a0569022b8a00b00deb88f5fa10mr1022569ybb.5.1715014827422;
 Mon, 06 May 2024 10:00:27 -0700 (PDT)
Date: Mon,  6 May 2024 17:00:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506170024.202111-1-yosryahmed@google.com>
Subject: [PATCH] mm: do not update memcg stats for NR_{FILE/SHMEM}_PMDMAPPED
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
NR_SHMEM_PMDMAPPED as these stats are not maintained per-memcg. Use
__mod_node_page_state() instead, which updates the global per-node stats
only.

Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000001b9d500617c8b23c@google.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/rmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 12be4241474ab..c2cfb750d2535 100644
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
+					nr_pmdmapped);
 	}
 	if (nr) {
 		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


