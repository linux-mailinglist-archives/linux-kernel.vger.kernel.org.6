Return-Path: <linux-kernel+bounces-428192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5EF9E0B40
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13D9164741
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC461DE8B3;
	Mon,  2 Dec 2024 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQVgWGbr"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A01DE8A5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164947; cv=none; b=RnfTYUfepldc/N3TZ9cY5N5uIxDLkmlRRPXR1NdRuTPwhpYZmdw5bAggsdKj5vkRvv349IaEycoDhL3ZBVI9v3IlLdGfuD0OOsW4bs4zaVWDLpt9+nWV4RttsNwTqWH7nfh9EIXFeL99xzKSzBFV/IdZGKNJfWm+W7Lw1YL3gU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164947; c=relaxed/simple;
	bh=03Tp5Bvvbel16Ml166yBp6r99cBxzKBlFQMhKZVMWzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ncl585SQGZ/18hiRNre3I8xjVpfzndb4WBea2hDKVzjwWY6WHxLRY02fWOqQLMslD6q4deaQUhcsqCalTu4HHarqzN/PYdoV+rTDskaMnXP/YmlOrC+m6TUzVmq1sgMiB9D4kL1uhp8ZOF7uRyX7MK9R+4nuhvBQmBRcD+wS0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQVgWGbr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7251abe0e69so3952241b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733164944; x=1733769744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n486kN9w2/p4kQRIxzmOz9BLiT1ewnt6ZG6JQNAAsl4=;
        b=WQVgWGbrIfwnnPLFx0F7wRrV9UhKNqyviiiLjrzlzNnFpoXEbRmbHe3qIbgbkHu0kq
         dVJKSReAKfibzFNPytdhvjPR0ukR1s/R3e5L9dxBo1uB2cE/FUWTlS7IUpkKpoWlXT1V
         j0rObOZ9JKq3yXT4stxbud4au5L8yVDZSjVLD2vVZL1s6pTW0a8trUj/YWJKCAb+7R2Y
         rsRdRwKULUX0xhca81PFYTyWtnzWkdPzJ0mVE+B1/cJ4D2uruLRtleENN14cXSNMpXTx
         MS0EMeOfIlw2zvvFuFt+C2VX2xkCTA4oirGYeVeupeKiPkHlWtWDjgtmoaTumpNHEao/
         W6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164944; x=1733769744;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n486kN9w2/p4kQRIxzmOz9BLiT1ewnt6ZG6JQNAAsl4=;
        b=uvbiKX8Y31qP2ph2WhiBxnfxJ2dJqO9+2TSSTCbjjVcGjwmw3bbZsY9YHLKngV8djj
         GFP0IA1ur8Q9zvLCiQ/nqjjQHn/htCvXeLroagCNVbYcrq3oF9uQhhwfAESsUoXGPROm
         DRtj4U+K6oO3eBq4l51hDefqWFCuM1kUpCrXbr7VXbVLaD1FFoMBznLfyx6M4Wwr8WF5
         xqZ6r76R5SSfuoCLpujTdKa9H4hGoEMnXWwax+2OpLjCvrdEKsVlFKP5vj4yylLtWjlV
         aeYaD/r34HbtCIwyXFeBbeSO4qOmfh9W9gvKKq7uyhQFAyalqF5/No2NIb7hjTeJwVoj
         i8UA==
X-Forwarded-Encrypted: i=1; AJvYcCWpeD9yVKr6t6SJtiC+S7KupolV2G1eOHmAvcsCNyHWA6EJyjSR0fbxVPwCcyS9pVqh1NGFGEr0Fb1dafU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUzYIZiH/6Tcic8QLA2KhiUkEnf9kvq+8j3kpaYbWdXPGSSx/p
	1poDNMpA4J8ABwOwU3NdpFWwxQfedXMZ3x2okb7sNu+Tyj2GotjQPQwESM3sWHP1LA==
X-Gm-Gg: ASbGncvOwPwHC1t7+uqs1dhRtekiF+wID4k4kIiiQNKs9++ctoyBW+aSE6dn9i8id+G
	v/M9HlI5FCs7+oprwfoXYzqV37F8yWROXmbkoUO4QdchuIKDFRx5zrGXi+jOzKe4acC2iy5dXIk
	UUqceFh+CtOoRgT7rlw+W11FNUaTRBMQoPT90JISpPY9e2enFq8Tlo+I78auV9v+scnTEoHIDZ1
	6hl8mBrOYepm+XRwdtre3SquFrCpMa4ZTZq0D5me8MIfvYPs4D0Rdef6vTH/qVrCcCPlKg=
X-Google-Smtp-Source: AGHT+IE6F7f6lJrUVeUD4BRVPb3PuBX80oqzE3+WCYBtL1H232mPA2ctT8z6mSlYDWpdAGJGBit8ww==
X-Received: by 2002:a05:6a00:4f81:b0:71d:eb7d:20d5 with SMTP id d2e1a72fcca58-72530045b6emr37194340b3a.8.1733164944304;
        Mon, 02 Dec 2024 10:42:24 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb7d5sm8849781b3a.94.2024.12.02.10.42.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Dec 2024 10:42:23 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
Date: Tue,  3 Dec 2024 02:41:54 +0800
Message-ID: <20241202184154.19321-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202184154.19321-1-ryncsn@gmail.com>
References: <20241202184154.19321-1-ryncsn@gmail.com>
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

Emulation of 2 bytes cmpxchg/xchg with atomic isn't hard, so implement
it to get rid of this lock.

Testing using 64G brd and build with build kernel with make -j96 in 1.5G
memory cgroup using 4k folios showed below improvement (10 test run):

Before this series:
Sys time: 10730.08 (stdev 49.030728)
Real time: 171.03 (stdev 0.850355)

After this commit:
Sys time: 9612.24 (stdev 66.310789), -10.42%
Real time: 159.78 (stdev 0.577193), -6.57%

With 64k folios and 2G memcg:
Before this series:
Sys time: 7626.77 (stdev 43.545517)
Real time: 136.22 (stdev 1.265544)

After this commit:
Sys time: 6936.03 (stdev 39.996280), -9.06%
Real time: 129.65 (stdev 0.880039), -4.82%

Sequential swapout of 8G 4k zero folios (24 test run):
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
 mm/swap_cgroup.c | 56 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index a76afdc3666a..028f5e6be3f0 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -5,6 +5,15 @@
 
 #include <linux/swapops.h> /* depends on mm.h include */
 
+#define ID_PER_UNIT (sizeof(atomic_t) / sizeof(unsigned short))
+struct swap_cgroup_unit {
+	union {
+		int raw;
+		atomic_t val;
+		unsigned short __id[ID_PER_UNIT];
+	};
+};
+
 static DEFINE_MUTEX(swap_cgroup_mutex);
 
 struct swap_cgroup {
@@ -12,8 +21,10 @@ struct swap_cgroup {
 };
 
 struct swap_cgroup_ctrl {
-	unsigned short	*map;
-	spinlock_t	lock;
+	union {
+		struct swap_cgroup_unit *units;
+		unsigned short *map;
+	};
 };
 
 static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
@@ -31,6 +42,24 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
  *
  * TODO: we can push these buffers out to HIGHMEM.
  */
+static unsigned short __swap_cgroup_xchg(void *map,
+					 pgoff_t offset,
+					 unsigned int new_id)
+{
+	unsigned int old_id;
+	struct swap_cgroup_unit *units = map;
+	struct swap_cgroup_unit *unit = &units[offset / ID_PER_UNIT];
+	struct swap_cgroup_unit new, old = { .raw = atomic_read(&unit->val) };
+
+	do {
+		new.raw = old.raw;
+		old_id = old.__id[offset % ID_PER_UNIT];
+		new.__id[offset % ID_PER_UNIT] = new_id;
+	} while (!atomic_try_cmpxchg(&unit->val, &old.raw, new.raw));
+
+	return old_id;
+}
+
 /**
  * swap_cgroup_record - record mem_cgroup for a set of swap entries
  * @ent: the first swap entry to be recorded into
@@ -44,22 +73,19 @@ unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
 				  unsigned int nr_ents)
 {
 	struct swap_cgroup_ctrl *ctrl;
-	unsigned short *map;
-	unsigned short old;
-	unsigned long flags;
 	pgoff_t offset = swp_offset(ent);
 	pgoff_t end = offset + nr_ents;
+	unsigned short old, iter;
+	unsigned short *map;
 
 	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
 	map = ctrl->map;
 
-	spin_lock_irqsave(&ctrl->lock, flags);
-	old = map[offset];
+	old = READ_ONCE(map[offset]);
 	do {
-		VM_BUG_ON(map[offset] != old);
-		map[offset] = id;
+		iter = __swap_cgroup_xchg(map, offset, id);
+		VM_BUG_ON(iter != old);
 	} while (++offset != end);
-	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	return old;
 }
@@ -85,20 +111,20 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 
 int swap_cgroup_swapon(int type, unsigned long max_pages)
 {
-	void *map;
+	struct swap_cgroup_unit *units;
 	struct swap_cgroup_ctrl *ctrl;
 
 	if (mem_cgroup_disabled())
 		return 0;
 
-	map = vzalloc(max_pages * sizeof(unsigned short));
-	if (!map)
+	units = vzalloc(DIV_ROUND_UP(max_pages, ID_PER_UNIT) *
+			sizeof(struct swap_cgroup_unit));
+	if (!units)
 		goto nomem;
 
 	ctrl = &swap_cgroup_ctrl[type];
 	mutex_lock(&swap_cgroup_mutex);
-	ctrl->map = map;
-	spin_lock_init(&ctrl->lock);
+	ctrl->units = units;
 	mutex_unlock(&swap_cgroup_mutex);
 
 	return 0;
-- 
2.47.0


