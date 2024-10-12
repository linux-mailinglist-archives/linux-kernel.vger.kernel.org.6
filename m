Return-Path: <linux-kernel+bounces-362129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C919899B16A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB431C21A91
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801C713B293;
	Sat, 12 Oct 2024 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3HWdJjj"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40415C0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728716890; cv=none; b=mUwXO588bLIQNBCWvbTFqvuMXwiWNkytdHaSaO+/3WiUHRfm/1RvKt2iZoDbRcBN1ndxqFgwBMrrSDpVAHLgduH4Dr8yCJtcoJ3JdJfHpq82yQ6rYUk3PlT1ncCZainLeMGtVDTcNqMmR9Bend09S0ze8JizuyTGxUTzXNKXsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728716890; c=relaxed/simple;
	bh=ZaEzI/iMLq8TlKaVzQj7ianFbzl/5KNPTVIZ1+frxpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Qu/voip+Z2oh4d2LpD1y6KykhaYYUoDKlPTU4zimL5gAur95IxpavVZhQMnFSz61F/QJUs7HVQmLS2sDrnA8fZS3ZPmP2aKn6MWokQ41YuvtCaTCw9fm+fCPmkycNiwrdwcG04I6wSUPFslD2n6CsZUjeT1Cv4Cm9xBv04RZdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3HWdJjj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbca51687so5177045ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728716888; x=1729321688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZmMCnNR2UPbWiVSXiubgc7IFfujo/BpYLBWN53BWGg=;
        b=M3HWdJjjufN/9E65t2G4XCyNHaeHdkkuaB4BJZsevAmn6P5Kk1DBQX77ClPkx6XUju
         Zrbxnu7tW/2qtWYoC6nT+yGA1TX6n7xkb6skJ9/nZ+HYkk1nv1eKoYACh7ZQfufr2B+S
         nKiNEX+x++tIpQ6PvLYkqvqUFxOQwhxs0vxP+uZP4P2T6OpcuNM/jU9mqqFc1HoKffY6
         Fo9dEcUkSY2udUy9M1ATOE2aVuxQ/cTPRTfqWUJSBdzVCkS4IwM66Y57taPceAJenLPU
         EKd9/A7+qkkmv5GEWZnNOP9/byqOOxSXzDNHqd+4NnazLcMnbanLVz4Qv1sitY2r1zHx
         IjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728716888; x=1729321688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZmMCnNR2UPbWiVSXiubgc7IFfujo/BpYLBWN53BWGg=;
        b=ephpABkH/0OoU+tE5X+KrSS4bm8N47pPkOGdghSTkKat+JosvmH0ZkBpTUsM8VCUSD
         vIy1gDaH+PYt3ZUWNgfwB6aAyhZIxQyHxvOeRgj3rxQJLE+0y+ZPH8T7mpV5vAVSB6sP
         vUrQSKHSZWZWh/cmKhFZ+7rLB/SILRy9KUnGD9XZE+YIg8q+5ZwxSc4rDP5M+k0sxFCC
         JBB6bh4DIRVXsBrY6c/Pj8AE5pvNio7mpd7cPV6rv9A2xeQatKg3jVihV5yrm48kiyG5
         4xB72HYNIcjFst6awMqnTajYnPbkCfGHngNtYZykLrryPs2Gabxhwk6sm0A0dJwpUgSu
         MJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGrTaoIbDWp/81eba30nwft95Gn58lhiqC/x2ChC7geWnGRMJEQ6xh4ofvctQvwooyJLRTSARYWQZPUxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwppuLuQ4fAZ5RkKOQllBEGddeZYJGAloPW9O6EOIwKxkvcAM1j
	J3nnzdBgjLk4SEp0ZTKWy+PGgFx2/kdVOWxrAYUZUL0dptaUFzjd
X-Google-Smtp-Source: AGHT+IFMmUxALkINzQWN8gf7Q3YK+P75Vuow7GtzNSGuILQu16IGYnty2dUkcPld7M0nulZzMOwUew==
X-Received: by 2002:a17:902:e5cd:b0:20c:8dff:b4ed with SMTP id d9443c01a7336-20cbb1bb3a4mr31421915ad.16.1728716888441;
        Sat, 12 Oct 2024 00:08:08 -0700 (PDT)
Received: from suhua-virtual-machine.localdomain ([36.112.24.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33ff19sm32837545ad.272.2024.10.12.00.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:08:07 -0700 (PDT)
From: suhua <suhua.tanke@gmail.com>
X-Google-Original-From: suhua <suhua1@kingsoft.com>
To: muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	suhua.tanke@gmail.com,
	suhua <suhua1@kingsoft.com>
Subject: [PATCH] mm/hugetlb: Perform vmemmap optimization batchly for specific node allocation
Date: Sat, 12 Oct 2024 15:08:02 +0800
Message-Id: <20241012070802.1876-1-suhua1@kingsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When HVO is enabled and huge page memory allocs are made, the freed memory
can be aggregated into higher order memory in the following paths, which
facilitates further allocs for higher order memory.

echo 200000 > /proc/sys/vm/nr_hugepages
echo 200000 > /sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages
grub： default_hugepagesz=2M hugepagesz=2M hugepages=200000

Currently not support for releasing aggregations to higher order in the
following way, which will releasing to lower order.

grub: default_hugepagesz=2M hugepagesz=2M hugepages=0:100000,1:100000

This patch supports the release of huge page optimizations aggregates to
higher order memory.

eg:
cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-xxx ... default_hugepagesz=2M hugepagesz=2M hugepages=0:100000,1:100000

Before:
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
...
Node    0, zone   Normal, type    Unmovable  55282  97039  99307      0      1      1      0      1      1      1      0
Node    0, zone   Normal, type      Movable     25     11    345     87     48     21      2     20      9      3  75061
Node    0, zone   Normal, type  Reclaimable      4      2      2      4      3      0      2      1      1      1      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
...
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
Node    1, zone   Normal, type    Unmovable  98888  99650  99679      2      3      1      2      2      2      0      0
Node    1, zone   Normal, type      Movable      1      1      0      1      1      0      1      0      1      1  75937
Node    1, zone   Normal, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
Node    1, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0

After:
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
...
Node    0, zone   Normal, type    Unmovable    152    158     37      2      2      0      3      4      2      6    717
Node    0, zone   Normal, type      Movable      1     37     53      3     55     49     16      6      2      1  75000
Node    0, zone   Normal, type  Reclaimable      1      4      3      1      2      1      1      1      1      1      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
...
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
Node    1, zone   Normal, type    Unmovable      5      3      2      1      3      4      2      2      2      0    779
Node    1, zone   Normal, type      Movable      1      0      1      1      1      0      1      0      1      1  75849
Node    1, zone   Normal, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
Node    1, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0

Signed-off-by: suhua <suhua1@kingsoft.com>
---
 mm/hugetlb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 190fa05635f4..906294ac85dc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3301,6 +3301,7 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 {
 	unsigned long i;
 	char buf[32];
+	LIST_HEAD(folio_list);
 
 	for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
 		if (hstate_is_gigantic(h)) {
@@ -3310,14 +3311,18 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 			struct folio *folio;
 			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
-			folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-					&node_states[N_MEMORY]);
+			folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
+					&node_states[N_MEMORY], NULL);
 			if (!folio)
 				break;
-			free_huge_folio(folio); /* free it into the hugepage allocator */
+			list_add(&folio->lru, &folio_list);
 		}
 		cond_resched();
 	}
+
+	if (!list_empty(&folio_list))
+		prep_and_add_allocated_folios(h, &folio_list);
+
 	if (i == h->max_huge_pages_node[nid])
 		return;
 
-- 
2.34.1


