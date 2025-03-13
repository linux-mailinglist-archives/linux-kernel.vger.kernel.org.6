Return-Path: <linux-kernel+bounces-560370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC4A60338
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BFE17A9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA071F5831;
	Thu, 13 Mar 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NELMSqTp"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5CE1F5615
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900029; cv=none; b=HciRp4dqwjqTwbeFHHu6Txn7ewjClf6PA1e36MGUkUR+1HVWwUkmXiUz7LsbQwgXVLZx6hJAOPJ5lgyP/U48mt/f6hhIpCC41QHX4GYIzl8duiXs+FhOWCBgbRN0zSMF34vhQ9uD8qwUonXcezthtQGjjrD3ZxDs+qsCACp7Z0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900029; c=relaxed/simple;
	bh=BVUrVAfT5xc89udf2TBcaTF/XSlcQ15FasIY5sdTWY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUFabFexd/1T8NdXlfS82gRcB+7+9YQmenJ0wtatKqHa+N/0Gz8PuJLz0V6awzbyWih5qOWolp4dUtT3/5NPdSEKoXeRUpDV3t9rh6EDpTT4Lw87gfxNtRqfjv61PEKRNAe8A9pX9xWFX/FghUucGvxwzYxf7t4VOKp5njpS/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NELMSqTp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c56321b22cso159391285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741900027; x=1742504827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ouliMx/rxg1GN/5kBba4AjsVs5wNUw9q6lxfkWoRUQ=;
        b=NELMSqTpH+JST81bqEKPZVzSvvwog2kVt6Csvi152M2ObpaRx0Axq2bpVQaIC2fDc+
         s35ncjXZYhePJDC+h8HkEwoHKRQdSSEg290Jm7Qbq2L/xtqRWgrp9GEX/aG2flkSykl2
         2oWhcSwGJVq8RurZBGLjcBBCnHJYNNMG1wByIU+U0NDSZwPmWIiDfhIvI4+4jmivzsww
         wtpPKK/Izvh0jEofOJ8LNO/UOocvCacN9byE417J4cGO98GeMK3RuzB0kD62Rdu04A4+
         hQR+WFgiX2EKj+cCnQe72yA6FNRZ/HWqqljDFAmPsbwb+5q5PropbBgKXGzdfBxsNUvc
         ufhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900027; x=1742504827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ouliMx/rxg1GN/5kBba4AjsVs5wNUw9q6lxfkWoRUQ=;
        b=HNqI31BpeSvnOONt9itdyXfg4BNMPRtpgpRcGd/iTJRYzOiCccY/3jz3Go1jOxk/Pt
         3dgsLeal50QpUZSTJeheKvFOYEnEGWjnFbBTVmZjSn0t4S5jB9mBnaPqDyva07/5EdHZ
         m2eKmHvx7XVXJtAOT/4XM7eKfc/nrO7bPQtuGmVVKfOrXW2y+6aRaZfxZ2hsCUi17LO7
         6jnZgHekM0tUwiV4baaEq/QL1d53iKx7JNvAO7IOVMzrIPy77gzbCivO+J/rIH85w/i3
         k8WC4Xni891ryawjU5NG9kS9s3B5mOmnMIoVK843F+kQrL15f5Cek7UGrLvnBgHT+iZw
         s9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW7DqnPEbVGgg7rOcFivMfc8V++oCllFYTx4F1cP6dLLoXSa+Ej4eAmEy0wbV2beQhpBcF0k2UOp2IQL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/0V8PCxQ2ndNG+USwJp7Xq1E4e2ZacehzWeh/qmkdV9kLQvh
	R459o8MpsrO2eEpjjSOlIH9EPsL6rTcO8vU2jyFD34zESXrBLTzOhef30bMFAls=
X-Gm-Gg: ASbGncv1KanSKJ7n3b/50+6IryH63Xdan7K9WX/UQeTjcsWY8vsH63fXa2cDgH9biZK
	pc0WqHuiOUmsmxEm+xgM4PBmnulpjVZ+FsaS9nQbLP8jXcftFZ7MGAiaaXix6v86ccD56pRByJ1
	oKN/TCC1UCFZ1gSO4JuLNpwLByE8hNq67HDNlfb9neLmzDuWLWLHL1YK2bkyYoCsvU1zdt5zd7h
	3kfeZaX4OYg7TwExBuBRXLO+C50Qs49U5AnMB0GXE+UppJKKORdF++T46Zzc6OCFbriyV1hfykL
	o85jdSGC4Dp1QEiX9TDXOBugVQX0bZ1KP691mdPgF1w=
X-Google-Smtp-Source: AGHT+IGURnx3waTxMIfAkGQ+RELMEfUq3qDPKdHBU4TLhM9iO7ZYMst5c+ohVVmbcycCmEztxbjgYQ==
X-Received: by 2002:a05:620a:8ecb:b0:7c5:53ab:a732 with SMTP id af79cd13be357-7c5737b8b58mr536730085a.16.1741900026755;
        Thu, 13 Mar 2025 14:07:06 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9d641sm143094885a.65.2025.03.13.14.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:07:04 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mm: page_alloc: defrag_mode kswapd/kcompactd assistance
Date: Thu, 13 Mar 2025 17:05:35 -0400
Message-ID: <20250313210647.1314586-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313210647.1314586-1-hannes@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When defrag_mode is enabled, allocation fallbacks strongly prefer
whole block conversions instead of polluting or stealing partially
used blocks. This means there is a demand for pageblocks even from
sub-block requests. Let kswapd/kcompactd help produce them.

By the time kswapd gets woken up, normal rmqueue and block conversion
fallbacks have been attempted and failed. So always wake kswapd with
the block order; it will take care of producing a suitable compaction
gap and then chain-wake kcompactd with the block order when its done.

                                                VANILLA        DEFRAGMODE-ASYNC
Hugealloc Time mean               52739.45 (    +0.00%)   34300.36 (   -34.96%)
Hugealloc Time stddev             56541.26 (    +0.00%)   36390.42 (   -35.64%)
Kbuild Real time                    197.47 (    +0.00%)     196.13 (    -0.67%)
Kbuild User time                   1240.49 (    +0.00%)    1234.74 (    -0.46%)
Kbuild System time                   70.08 (    +0.00%)      62.62 (   -10.50%)
THP fault alloc                   46727.07 (    +0.00%)   57054.53 (   +22.10%)
THP fault fallback                21910.60 (    +0.00%)   11581.40 (   -47.14%)
Direct compact fail                 195.80 (    +0.00%)     107.80 (   -44.72%)
Direct compact success                7.93 (    +0.00%)       4.53 (   -38.06%)
Direct compact success rate %         3.51 (    +0.00%)       3.20 (    -6.89%)
Compact daemon scanned migrate  3369601.27 (    +0.00%) 5461033.93 (   +62.07%)
Compact daemon scanned free     5075474.47 (    +0.00%) 5824897.93 (   +14.77%)
Compact direct scanned migrate   161787.27 (    +0.00%)   58336.93 (   -63.94%)
Compact direct scanned free      163467.53 (    +0.00%)   32791.87 (   -79.94%)
Compact total migrate scanned   3531388.53 (    +0.00%) 5519370.87 (   +56.29%)
Compact total free scanned      5238942.00 (    +0.00%) 5857689.80 (   +11.81%)
Alloc stall                        2371.07 (    +0.00%)    2424.60 (    +2.26%)
Pages kswapd scanned            2160926.73 (    +0.00%) 2657018.33 (   +22.96%)
Pages kswapd reclaimed           533191.07 (    +0.00%)  559583.07 (    +4.95%)
Pages direct scanned             400450.33 (    +0.00%)  722094.07 (   +80.32%)
Pages direct reclaimed            94441.73 (    +0.00%)  107257.80 (   +13.57%)
Pages total scanned             2561377.07 (    +0.00%) 3379112.40 (   +31.93%)
Pages total reclaimed            627632.80 (    +0.00%)  666840.87 (    +6.25%)
Swap out                          47959.53 (    +0.00%)   77238.20 (   +61.05%)
Swap in                            7276.00 (    +0.00%)   11712.80 (   +60.97%)
File refaults                    138043.00 (    +0.00%)  143438.80 (    +3.91%)

With this patch, defrag_mode=1 beats the vanilla kernel in THP success
rates and allocation latencies. The trend holds over time:

  thp_fault_alloc

      VANILLA        DEFRAGMODE-ASYNC
        61988                   52066
        56474                   58844
        57258                   58233
        50187                   58476
        52388                   54516
        55409                   59938
        52925                   57204
        47648                   60238
        43669                   55733
        40621                   56211
        36077                   59861
        41721                   57771
        36685                   58579
        34641                   51868
        33215                   56280

DEFRAGMODE-ASYNC also wins on %sys as ~3/4 of the direct compaction
work is shifted to kcompactd.

Reclaim activity is higher. Part of that is simply due to the
increased memory footprint from higher THP use. The other aspect is
that *direct* reclaim/compaction are still going for requested orders
rather than targeting the page blocks required for fallbacks, which is
less efficient than it could be. However, this is already a useful
tradeoff to make, as in many environments peak periods are short and
retaining the ability to produce THP through them is more important.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9a02772c2461..4a0d8f871e56 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4076,15 +4076,21 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 	struct zone *zone;
 	pg_data_t *last_pgdat = NULL;
 	enum zone_type highest_zoneidx = ac->highest_zoneidx;
+	unsigned int reclaim_order;
+
+	if (defrag_mode)
+		reclaim_order = max(order, pageblock_order);
+	else
+		reclaim_order = order;
 
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zoneidx,
 					ac->nodemask) {
 		if (!managed_zone(zone))
 			continue;
-		if (last_pgdat != zone->zone_pgdat) {
-			wakeup_kswapd(zone, gfp_mask, order, highest_zoneidx);
-			last_pgdat = zone->zone_pgdat;
-		}
+		if (last_pgdat == zone->zone_pgdat)
+			continue;
+		wakeup_kswapd(zone, gfp_mask, reclaim_order, highest_zoneidx);
+		last_pgdat = zone->zone_pgdat;
 	}
 }
 
-- 
2.48.1


