Return-Path: <linux-kernel+bounces-244922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C56192AB84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D344E1F22482
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2CD14F11C;
	Mon,  8 Jul 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFEcj2JD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D277345B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475743; cv=none; b=JEXpNtmesqJPtrBxe/AQp5/0eDWt7YRFllz3eW6G5kAG+REhXKzr4nwUyD2xeJosLHW0taBdSHzlyRxUxkEw6SCXRK8R3vghBfJKQUTIBLASLfmjp60Pqw5+4lmf9mKhe6CQE15CEoFubkfOzj+xvgef14iC8XgOM1P13hRTIvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475743; c=relaxed/simple;
	bh=d+LOuQ4m1wf9+M44COEPxfzFwnRQ3RLfHS/hWSSAgsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcq5k98jf95meJQv0xxlqf5qGgjtzvkjxIR222D9Qk77IvM0h9Sp22HydQEgtd/z1O11uz1/nP3X/m3M2IS66B99Nl92KD1oemVUzOjv1Urb0Ss4Q8zDVtaIGCjzKsCcPPdtIwfwPyjiS8C7nAbmxDrKBo//OD7h9gWkkNBIUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFEcj2JD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720475741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bdZl7zE1LbnN4RcXWZNvf+JG0YErrvEqH4FuELpRXl4=;
	b=AFEcj2JDsLQyq5t9hGjLp+f4MTV0aadcD1dhyU3W15jUed8DvjE7PbeezU//3wyrXmxF8A
	UGYjIiM2CVdHkU/83YG5kEF02A+Sq8id0Bdxy1X+Y5l8lmqPkUt2C9mXIFjUYW1l9OCp+5
	Y6+3F5f7/6u6PZRX+kT/6uKQRyhxwe0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-6opEpnqnOZqNOrQM5xrRyg-1; Mon, 08 Jul 2024 17:55:40 -0400
X-MC-Unique: 6opEpnqnOZqNOrQM5xrRyg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b5df8c7c61so14126586d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720475739; x=1721080539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdZl7zE1LbnN4RcXWZNvf+JG0YErrvEqH4FuELpRXl4=;
        b=eYdPuCroXPXmWY64NL2KQu7ll4rSPeE+Mws/c1nl2P9h15GehsJPktpOVhAazDtqOo
         KJXqeYSgET/DJAgLEGVq3KmXAHr2GASwxwZ099Nfzo8m31PhzcifJmnTflS+OnItPvHF
         bnGFXc4lTVtyWtmIYh7kF2DxZf3xfMM+prMbaiccg6H6ktsL7KbkkWD0HKjwvytQA2Az
         FjrF2hUJT1dfpnn5FO1lWE53neFs7kuUmC0XnpqfVM/TerDEH0whFV9Br0fzPgAKJKyi
         tqH9psHBxUijkl8JwYXeuZuwkdcU5dS93A5b6FGj9lbuuinXU0ykXNRUIxztxEHgT3AB
         7idA==
X-Forwarded-Encrypted: i=1; AJvYcCUqDOFd/QUnNI4iOKu8SbWEv1H0LsBYbmv4l6mrmw2xdpzoi7XkUYl286pvWvbaYsmGuaIFoGxto6Q/V3aPNHcx2Isok0Duxy9jCuvK
X-Gm-Message-State: AOJu0YycNQefoGSuHjXy7Mr1U/FOVkFm0V1EdnTWanF1Mv4eLLFb4hd+
	lXl6G2n19IkJMj0o+xv108O+Pa4X7gKPTybNE/5mX9Zj0DHUEZkeIYyw6fQlMwTPsLl+rYYERs1
	JDcI16wzHFiBeIONHknBBQhPj1QsuBxA8/wA3QW4zqpt2jYyhkBU3JBSnhUsBKg==
X-Received: by 2002:a05:620a:a13:b0:79f:1556:37c9 with SMTP id af79cd13be357-79f198e98d3mr81920185a.0.1720475739627;
        Mon, 08 Jul 2024 14:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTMT/OKeMh7vZgTCdEn6Vg7yRvRPIacM/xcR6Apjdr9yu5OBZcwg9nO9A1LGya7GmMSN5vIA==
X-Received: by 2002:a05:620a:a13:b0:79f:1556:37c9 with SMTP id af79cd13be357-79f198e98d3mr81918985a.0.1720475739296;
        Mon, 08 Jul 2024 14:55:39 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff691bsm32294585a.21.2024.07.08.14.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:55:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Huang Ying <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm/migrate: Putback split folios when numa hint migration fails
Date: Mon,  8 Jul 2024 17:55:37 -0400
Message-ID: <20240708215537.2630610-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This issue is not from any report yet, but by code observation only.

This is yet another fix besides Hugh's patch [1] but on relevant code path,
where eager split of folio can happen if the folio is already on deferred
list during a folio migration.

Here the issue is NUMA path (migrate_misplaced_folio()) may start to
encounter such folio split now even with MR_NUMA_MISPLACED hint applied.
Then when migrate_pages() didn't migrate all the folios, it's possible the
split small folios be put onto the list instead of the original folio.
Then putting back only the head page won't be enough.

Fix it by putting back all the folios on the list.

[1] https://lore.kernel.org/all/46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com/

Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Don't need to copy stable if this can still hit 6.10..  Only smoke tested.
---
 mm/migrate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e10d2445fbd8..20da2595527a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2615,14 +2615,8 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
 				     NULL, node, MIGRATE_ASYNC,
 				     MR_NUMA_MISPLACED, &nr_succeeded);
-	if (nr_remaining) {
-		if (!list_empty(&migratepages)) {
-			list_del(&folio->lru);
-			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
-					folio_is_file_lru(folio), -nr_pages);
-			folio_putback_lru(folio);
-		}
-	}
+	if (nr_remaining && !list_empty(&migratepages))
+		putback_movable_pages(&migratepages);
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
 		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
-- 
2.45.0


