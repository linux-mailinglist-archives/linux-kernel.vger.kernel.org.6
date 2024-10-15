Return-Path: <linux-kernel+bounces-365822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA2999EA54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAF328A879
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B31C07D4;
	Tue, 15 Oct 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="0B3WgVwz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EEB1C07C4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996726; cv=none; b=P0u+9i89uUrmz4Eg+sTm0T3U+dLCVql8cWwMWhjspteJtYShOP3Qrqdn+sATrYG/EhWYwl2GDmGRMl/9O0fczikfsbHVhrPC1f1Z/msyYKVdtiGkyYAPax/sKkGgnVwAdlHBikwk7nGNUGsMp/hQiQ+dtaWn0defs26I7MhY3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996726; c=relaxed/simple;
	bh=JqLdNxUdrbf9m7X8XkWe1+HXlycHAz8SZlUD7XMM7h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BD6VPXZQ2woSE52QsiMWenhBovWtDfHWxqMK32bWnVsREiOInE2jU9x0sqzoDWxyJOsVgjaoNwbLrvC5rfTsUR/RKjY/2IiPOClkSrgcUTxLxANkw3yyaGgFDJUbHuQaCtlanBbHkwfpni2jKNvGiiMeSoklbXNZkRoWDdRIdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=0B3WgVwz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431481433bdso2440255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1728996723; x=1729601523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qamiraWdxMoUu029itAshQt6SKv15LdwoZC2cdLFctQ=;
        b=0B3WgVwzi8qn63HnB5ghiG9Ss1FvPqv5gvCapqFsJZTQAC9cvN3iwqHtMZJ0jM32Ab
         xlv3Glctrqk9XNrGj5SkKUZe2qN9FfshJnbZuzLJuzxCEieEELH+GYNiKkbgKwRP0Mxy
         vrg9GgtyVfzWab0NpVz/uXr5I1h/EVHL/Q+aV2L4S+Macw5qigtrd8nEJ9Ql1WGclhJa
         v7puStaj1FfKTCEOnBx0gpFxUqqRrlacScDp0I6lrkSGEYoKEdMZFbhMnVjtBMLax+UR
         IjnkVupb2KwE5W6Iuvf028swXer5Ocd62+PZQx7UsK3VR0F3yBrbJbCGj5YxaBgAIgk4
         89rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996723; x=1729601523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qamiraWdxMoUu029itAshQt6SKv15LdwoZC2cdLFctQ=;
        b=K2oYKf8ZRSljr/NSPYvkPJnVcGfN63+UP2SxnWuCeUV/yHefdH4GvLE62GFwhknn8i
         iyjs4tt2XMwRA5TKQ3mdgE8FtpFnAXyrG9U/RhnO41Vlukoi1d050TCnbnyrzGyg8PWt
         58tPDXWEXESpQF7II0qusO+P+/bkNBjgSk6xOLDFdnn1rcs76qMB6RA0ReNK45xrOW/E
         4Aw+k3SiljnXKUQVI7wQ4KNyIhGBEHFZuZX67D0KKvbajTdr3z6dD1hPAroSe7foFxEp
         xKI+u7OPgtovjL/sNCAns0ewlHGFXn4M3tqyKZVa+VEDZAM1Dz0jC0RRHoO+RFqs60Ij
         0knQ==
X-Gm-Message-State: AOJu0YxtsDqqa3WA7rikT4FL7k/6DeoXpOa65hp9v/XzuVQN0zYGqvuv
	6C+bgFNOxkgZl1vu4YrS8Jv++8jR2oLU36Jhe/rnG3uA8BZG3NCt+SayTbdXe8jAPvbLu8gZwGY
	4ZZU=
X-Google-Smtp-Source: AGHT+IGlcfxtmIQrnyIIKngfm0k3VUAbv5d96errbARi7ueQs0o9UH2OdW8TpdwQkwZ8/lcbTm4l1Q==
X-Received: by 2002:a05:600c:1d29:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-4311df5bda1mr134372545e9.29.1728996722337;
        Tue, 15 Oct 2024 05:52:02 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::179:225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa89c55sm1508730f8f.46.2024.10.15.05.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:52:01 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/page_alloc: Let GFP_ATOMIC order-0 allocs access highatomic reserves
Date: Tue, 15 Oct 2024 13:51:58 +0100
Message-Id: <20241015125158.3597702-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Under memory pressure it's possible for GFP_ATOMIC order-0 allocations
to fail even though free pages are available in the highatomic reserves.
GFP_ATOMIC allocations cannot trigger unreserve_highatomic_pageblock()
since it's only run from reclaim.

Given that such allocations will pass the watermarks in
__zone_watermark_unusable_free(), it makes sense to fallback to
highatomic reserves the same way that ALLOC_OOM can.

This fixes order-0 page allocation failures observed on Cloudflare's
fleet when handling network packets:

  kswapd1: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
  nodemask=(null),cpuset=/,mems_allowed=0-7
  CPU: 10 PID: 696 Comm: kswapd1 Kdump: loaded Tainted: G           O 6.6.43-CUSTOM #1
  Hardware name: MACHINE
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x3c/0x50
   warn_alloc+0x13a/0x1c0
   __alloc_pages_slowpath.constprop.0+0xc9d/0xd10
   __alloc_pages+0x327/0x340
   __napi_alloc_skb+0x16d/0x1f0
   bnxt_rx_page_skb+0x96/0x1b0 [bnxt_en]
   bnxt_rx_pkt+0x201/0x15e0 [bnxt_en]
   __bnxt_poll_work+0x156/0x2b0 [bnxt_en]
   bnxt_poll+0xd9/0x1c0 [bnxt_en]
   __napi_poll+0x2b/0x1b0
   bpf_trampoline_6442524138+0x7d/0x1000
   __napi_poll+0x5/0x1b0
   net_rx_action+0x342/0x740
   handle_softirqs+0xcf/0x2b0
   irq_exit_rcu+0x6c/0x90
   sysvec_apic_timer_interrupt+0x72/0x90
   </IRQ>

Fixes: 1d91df85f399 ("mm/page_alloc: handle a missing case for memalloc_nocma_{save/restore} APIs")
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org # v5.9+
Link: https://lore.kernel.org/all/CAGis_TWzSu=P7QJmjD58WWiu3zjMTVKSzdOwWE8ORaGytzWJwQ@mail.gmail.com/
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

v2: Update comment and add Fixes, Reviewed-by, and Cc: stable tags.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8afab64814dc..94a2ffe28008 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2893,12 +2893,12 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
 
 			/*
-			 * If the allocation fails, allow OOM handling access
-			 * to HIGHATOMIC reserves as failing now is worse than
-			 * failing a high-order atomic allocation in the
-			 * future.
+			 * If the allocation fails, allow OOM handling and
+			 * order-0 (atomic) allocs access to HIGHATOMIC
+			 * reserves as failing now is worse than failing a
+			 * high-order atomic allocation in the future.
 			 */
-			if (!page && (alloc_flags & ALLOC_OOM))
+			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
 				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 
 			if (!page) {
-- 
2.34.1


