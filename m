Return-Path: <linux-kernel+bounces-439201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC199EAC25
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A8228FC35
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3F3226539;
	Tue, 10 Dec 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0vPbmDq"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9D223333
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822953; cv=none; b=SPDFnfQoIticuEQi4BV8Hqj/5X354EJ0HLkCkmnLvvYBMFxaEyANGfXj/9rOC02PCG+AGVl5JIM/eFc3JzD1lvaY1ekHmPKAacizZPOu7j1g5CD9peXxE0f6S/IixrqeO4ii0S4x7Zcd/5S81yuNICMlcQJC8n7w6ZHyuj6/cIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822953; c=relaxed/simple;
	bh=1l7G3AJzYY0SYn9JnpUenU6kM5eqxuwNxfMwXuxqaYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqcQPF6OVOSn1LDbX0v9zQk1LBkEkkCAOTpBruD0yAtKrpJqRQ2QGW/Z7NJQ6eDC5Xn+LBxbyPI0GVdV7B9q1oQzl+SqA56Jmfibt5x1im5ZKRyiZTYPGk0ApsRPkdWEpdvsAUDTGF3+aQqy4mgJcYf3HleykDrEBTIY7T9fAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0vPbmDq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so3584915a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733822951; x=1734427751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1vqDO82M+XCnuau+JNGqK2Zehr2Sd7WYRXd6APN34sY=;
        b=h0vPbmDqiu9kba6EKH8I+DtjaWsC/8RB/fHd2lDpaguEGTu67jp4jKRww46vJX7zg4
         8JlJHAUjLJJ89fPbH4m9g3TAsBF9X2RBnOtnaYqBqxy9Z+SFNgRDD4/wP7MfED2eR4qb
         Tp1UJ04582zjYba4QbjIOMu66Z6SqN9n4RkAFqUX5IlyvaU8LJm5JnVVH6P/ux8Kmlko
         t3aDYrt4znj+SZXURTtDHBQkOCao2+arX1Su9dNsHTQ8UyVslvyt+wjbeHPHlQkDUgC0
         aB2mmdEN9zMFCQUZCVkbL7d56d0DLha9Uj49OYTlvqpcXHFeELTo7OuFNJDnpdbhfm/1
         AwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822951; x=1734427751;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vqDO82M+XCnuau+JNGqK2Zehr2Sd7WYRXd6APN34sY=;
        b=cc1lpf3FBhI2HyHQGSpgHEWXDGdeiPKxmoJERbdKb93g22AubViKSeBhZRBi8JpCEZ
         t86B2c53c5yZknzjew+rIS4oaotEJ2JRptDQfhWzlFFtdcVTrTIAsTeFDZahfn2JVmma
         quglsxAknGX0pmFCVIiwfFQxq2tOfAYNePzygtusgTvkzIejT+r0dt1dHtNWGm0lbRl6
         NXMV40HATLPkGo7Ofrx5h6irl7gUZoxzOeBJnYw/BUb7QYYNklQDkQWvIJwIFOBDd9hH
         x6BpVEZEloFoYHuVCaYvfqJrhUVgzm0PExvzOvW0kHvtXSVnyEWFXgb3cyqjRPFJwi4A
         N0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWtI1EYK7byrqcwCFvQ2AxGqAzpZknX45UK3Npli2BW1aiSulqsNd5fyw0SBsj1GNeEsDm9Kj5SY8t3mU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHJn0Xh4TAOg85pUuONb4gniQgYEe0ccAHO84gfVynExhbZta
	zMWmCO4aV2M0gcA2yPE8G6W9TG+RcoZAVsD5czkIgpLlIUeBrOOC
X-Gm-Gg: ASbGncuQaGYXTvtrIlEWcb1JpHTO5LRlM+gs5b6bhD3aaMrqyVn2W5cyQ6eXO1B5NsY
	PYL2MowkVCuqyvZ/g2kaiLQ/rjA16XER0bkl3sIfxzCwirdrKWfBCt/XoI5QZ1aDCggAf7cMqnw
	5I3zWljKJJA6KW8y3PCmk9WXbDc62E7qKWT/xfejVX7u59Maw9H5EttyJs7GWrjay6r+h6f/wW1
	rwIWcFRgjmJF7VGSbyiTuBYCpIZ8rxDqQ5Gt3aGG+LeI0QG/ebLEjMNBzWzaRrKDvzCZ59rwq2E
	oqZrX1rv
X-Google-Smtp-Source: AGHT+IHZXjaBzRsPyNk7dOYudpCeCcHTvHtx8g1LtmYlWSNCnk4Uj7a71khFvxql+RO1r55gAZOC2Q==
X-Received: by 2002:a17:90b:384f:b0:2ee:b0f1:ba17 with SMTP id 98e67ed59e1d1-2efcf2c624dmr6555372a91.37.1733822950656;
        Tue, 10 Dec 2024 01:29:10 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1568f26asm8750095a12.9.2024.12.10.01.29.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Dec 2024 01:29:10 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 3/3] mm, swap_cgroup: remove global swap cgroup lock
Date: Tue, 10 Dec 2024 17:28:05 +0800
Message-ID: <20241210092805.87281-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210092805.87281-1-ryncsn@gmail.com>
References: <20241210092805.87281-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup maintainance")
replaced the cmpxchg/xchg with a global irq spinlock because some archs
doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale well.

And as commented in swap_cgroup.c, this lock is not needed for map
synchronization.

Emulation of 2 bytes xchg with atomic cmpxchg isn't hard, so implement
it to get rid of this lock. Introduced two helpers for doing so and they
can be easily dropped if a generic 2 byte xchg is support.

Testing using 64G brd and build with build kernel with make -j96 in 1.5G
memory cgroup using 4k folios showed below improvement (10 test run):

Before this series:
Sys time: 10809.46 (stdev 80.831491)
Real time: 171.41 (stdev 1.239894)

After this commit:
Sys time: 9621.26 (stdev 34.620000), -10.42%
Real time: 160.00 (stdev 0.497814), -6.57%

With 64k folios and 2G memcg:
Before this series:
Sys time: 8231.99 (stdev 30.030994)
Real time: 143.57 (stdev 0.577394)

After this commit:
Sys time: 7403.47 (stdev 6.270000), -10.06%
Real time: 135.18 (stdev 0.605000), -5.84%

Sequential swapout of 8G 64k zero folios with madvise (24 test run):
Before this series:
5461409.12 us (stdev 183957.827084)

After this commit:
5420447.26 us (stdev 196419.240317)

Sequential swapin of 8G 4k zero folios (24 test run):
Before this series:
19736958.916667 us (stdev 189027.246676)

After this commit:
19662182.629630 us (stdev 172717.640614)

Performance is better or at least not worse for all tests above.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_cgroup.c | 73 +++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 1770b076f6b7..a0a8547dc85d 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -7,19 +7,20 @@
 
 static DEFINE_MUTEX(swap_cgroup_mutex);
 
+/* Pack two cgroup id (short) of two entries in one swap_cgroup (atomic_t) */
+#define ID_PER_SC (sizeof(atomic_t) / sizeof(unsigned short))
+#define ID_SHIFT (BITS_PER_TYPE(unsigned short))
+#define ID_MASK (BIT(ID_SHIFT) - 1)
 struct swap_cgroup {
-	unsigned short		id;
+	atomic_t ids;
 };
 
 struct swap_cgroup_ctrl {
 	struct swap_cgroup *map;
-	spinlock_t	lock;
 };
 
 static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
 
-#define SC_PER_PAGE	(PAGE_SIZE/sizeof(struct swap_cgroup))
-
 /*
  * SwapCgroup implements "lookup" and "exchange" operations.
  * In typical usage, this swap_cgroup is accessed via memcg's charge/uncharge
@@ -30,19 +31,32 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
  *    SwapCache(and its swp_entry) is under lock.
  *  - When called via swap_free(), there is no user of this entry and no race.
  * Then, we don't need lock around "exchange".
- *
- * TODO: we can push these buffers out to HIGHMEM.
  */
-static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
-					struct swap_cgroup_ctrl **ctrlp)
+static unsigned short __swap_cgroup_id_lookup(struct swap_cgroup *map,
+					      pgoff_t offset)
 {
-	pgoff_t offset = swp_offset(ent);
-	struct swap_cgroup_ctrl *ctrl;
+	unsigned int shift = (offset & 1) ? 0 : ID_SHIFT;
+	unsigned int old_ids = atomic_read(&map[offset / ID_PER_SC].ids);
 
-	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
-	if (ctrlp)
-		*ctrlp = ctrl;
-	return &ctrl->map[offset];
+	return (old_ids & (ID_MASK << shift)) >> shift;
+}
+
+static unsigned short __swap_cgroup_id_xchg(struct swap_cgroup *map,
+					    pgoff_t offset,
+					    unsigned short new_id)
+{
+	unsigned short old_id;
+	unsigned int shift = (offset & 1) ? 0 : ID_SHIFT;
+	struct swap_cgroup *sc = &map[offset / ID_PER_SC];
+	unsigned int new_ids, old_ids = atomic_read(&sc->ids);
+
+	do {
+		old_id = (old_ids & (ID_MASK << shift)) >> shift;
+		new_ids = (old_ids & ~(ID_MASK << shift));
+		new_ids |= ((unsigned int)new_id) << shift;
+	} while (!atomic_try_cmpxchg(&sc->ids, &old_ids, new_ids));
+
+	return old_id;
 }
 
 /**
@@ -58,21 +72,19 @@ unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
 				  unsigned int nr_ents)
 {
 	struct swap_cgroup_ctrl *ctrl;
-	struct swap_cgroup *sc;
-	unsigned short old;
-	unsigned long flags;
 	pgoff_t offset = swp_offset(ent);
 	pgoff_t end = offset + nr_ents;
+	unsigned short old, iter;
+	struct swap_cgroup *map;
 
-	sc = lookup_swap_cgroup(ent, &ctrl);
+	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
+	map = ctrl->map;
 
-	spin_lock_irqsave(&ctrl->lock, flags);
-	old = sc->id;
-	for (; offset < end; offset++, sc++) {
-		VM_BUG_ON(sc->id != old);
-		sc->id = id;
-	}
-	spin_unlock_irqrestore(&ctrl->lock, flags);
+	old = __swap_cgroup_id_lookup(map, offset);
+	do {
+		iter = __swap_cgroup_id_xchg(map, offset, id);
+		VM_BUG_ON(iter != old);
+	} while (++offset != end);
 
 	return old;
 }
@@ -85,9 +97,13 @@ unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
  */
 unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 {
+	struct swap_cgroup_ctrl *ctrl;
+
 	if (mem_cgroup_disabled())
 		return 0;
-	return lookup_swap_cgroup(ent, NULL)->id;
+
+	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
+	return __swap_cgroup_id_lookup(ctrl->map, swp_offset(ent));
 }
 
 int swap_cgroup_swapon(int type, unsigned long max_pages)
@@ -98,14 +114,15 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 	if (mem_cgroup_disabled())
 		return 0;
 
-	map = vcalloc(max_pages, sizeof(struct swap_cgroup));
+	BUILD_BUG_ON(!ID_PER_SC);
+	map = vcalloc(DIV_ROUND_UP(max_pages, ID_PER_SC),
+		      sizeof(struct swap_cgroup));
 	if (!map)
 		goto nomem;
 
 	ctrl = &swap_cgroup_ctrl[type];
 	mutex_lock(&swap_cgroup_mutex);
 	ctrl->map = map;
-	spin_lock_init(&ctrl->lock);
 	mutex_unlock(&swap_cgroup_mutex);
 
 	return 0;
-- 
2.47.1


