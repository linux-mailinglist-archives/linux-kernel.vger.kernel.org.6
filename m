Return-Path: <linux-kernel+bounces-270560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC54944176
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619DBB21E4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9413C677;
	Thu,  1 Aug 2024 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hZkOmvBq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0F13BAC3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480764; cv=none; b=hs18dgt6zHBMnW2+sv96uGQPYUSgIQns0xo2XW2k60xp7j9np4FtYHE3sSAMcQ11/XvEdoKiXavM7XB6Op9Nhko+h970pZR+AXBY8Yx/bEBkX898qJ+w+yxzPEp9H4l/34ozWt6K4Gw3Sa34nBGjRZIsWxhk+HaBvjS5X+XfXxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480764; c=relaxed/simple;
	bh=jdh5QL8IAPjC5hwY1uxfbyge2t1ate/DN9AIY7RnTmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0QR8/mGMBHJumcVVqXMxcHKgbr22uQqHewXyc66FJtA1ObgKF1ggrLK+CiFYPJh6X0TCv0mnLnu7gtVyuyDz7m8k/6PQEXR/KvPUtChm3830lproy3MalB5xYsbmg5i0cA2Tz1AZbRq8bSs/Bd0vpwtEq2gGFfp/jFQFRcLHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hZkOmvBq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd6ed7688cso51550045ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722480761; x=1723085561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MO67bKN71emtFnIdYufuYQuueaGz+jJ9f99zlg6P9GY=;
        b=hZkOmvBqvvApsh6CfHv/euLDrMB4eW5EAqpOM4BpSgA0wCBjKMkieSheugXNv27pGJ
         xv7abBUZ98GfyKV+vEtaOyVJUP1JaTyRMSshTczXciatvVh1KDIdOL7pE4z6ehSDc9v5
         AzazYpLsDvMoUFPjXU+K4NmL4Xhll/9wl3M5jJIrPK+p36a/RrGVPjWeceWoEbpRLwMz
         s899886ep8PyrpTXk7knnoWiFz50VMohxSq/pkojpDpLLfhfprIlWd35kYaXqWSkXoo7
         vyzc//SrMJ0u6iCrisjovjs+hWoa1gqse7vcBWHOxEnZxLwPzfG+qvqPmwU7CYkkL43X
         P70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722480761; x=1723085561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MO67bKN71emtFnIdYufuYQuueaGz+jJ9f99zlg6P9GY=;
        b=ow7Nxs/PQ/3YQnh8chidwa/obN7cHxF4gFdsc07V4t27+TXhwbDRtw2Y21mn2FHIki
         OoU8ieCj6s1lC2ULQZV3WKMcSPjvyU6Cp04oTIGyVGRBxfI+A3+BS4n5UuzM19PlqJmI
         06bH01XAwhrAdC3GKFLwTwAl+oUQ6xiVS93SQc7O5BpszWrMHf+6Zo/Dfa2jTMLhUvzr
         50eBy3l3qC43sQW9yJOHLtWk9l6zrnq6glqsZj03GVsczk8hp1KApEG44w+snh1r/We2
         1tgQN6BfEfBGW7webjRpI2oveud1kovUfXVXpfcqrJDCeATQpKyHkAPH+3YPIqAIRAhD
         Ak+A==
X-Forwarded-Encrypted: i=1; AJvYcCUVF5E0ZpAawzTS0dQswHS//+yUY/pEUPJkO+U+QF6w/aJSQf60bJhS4E7ztE5HxUk5HZttRjno0FqH8UgJnKEGeU3Zqph5MXjEHZ6O
X-Gm-Message-State: AOJu0Yy4oxCZOMA21OG2MphADxaCX09dDoiGpIAwG7pDVeFYm8cfBPPf
	r+U4zP4zcA7QJrghjEHFGu54vQVURSvkN1qF4vxsOltNfUmSrCwrQtdtVJt+300=
X-Google-Smtp-Source: AGHT+IHUUI2hJklTanphWfjhEVjpkQn8/7G1hpxN+PZYzcg0FnUHpugBQX6p1CwTxCTIR0lX05VE4Q==
X-Received: by 2002:a17:902:f691:b0:1fd:d5b8:a4be with SMTP id d9443c01a7336-1ff4d242db4mr15825825ad.53.1722480761112;
        Wed, 31 Jul 2024 19:52:41 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee4b0asm128018165ad.176.2024.07.31.19.52.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 31 Jul 2024 19:52:40 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	vbabka@kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: list_lru: fix UAF for memory cgroup
Date: Thu,  1 Aug 2024 10:46:03 +0800
Message-Id: <20240801024603.1865-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mem_cgroup_from_slab_obj() is supposed to be called under rcu
lock or cgroup_mutex or others which could prevent returned memcg
from being freed. Fix it by adding missing rcu read lock.

Fixes: 0a97c01cd20b ("list_lru: allow explicit memcg and NUMA node selection")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
---
v2:
 Only grab rcu lock when necessary (Vlastimil Babka)

 mm/list_lru.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index a29d96929d7c7..9b7ff06e9d326 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -85,6 +85,7 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 }
 #endif /* CONFIG_MEMCG */
 
+/* The caller must ensure the memcg lifetime. */
 bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg)
 {
@@ -109,14 +110,22 @@ EXPORT_SYMBOL_GPL(list_lru_add);
 
 bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
 {
+	bool ret;
 	int nid = page_to_nid(virt_to_page(item));
-	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
-		mem_cgroup_from_slab_obj(item) : NULL;
 
-	return list_lru_add(lru, item, nid, memcg);
+	if (list_lru_memcg_aware(lru)) {
+		rcu_read_lock();
+		ret = list_lru_add(lru, item, nid, mem_cgroup_from_slab_obj(item));
+		rcu_read_unlock();
+	} else {
+		ret = list_lru_add(lru, item, nid, NULL);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(list_lru_add_obj);
 
+/* The caller must ensure the memcg lifetime. */
 bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg)
 {
@@ -139,11 +148,18 @@ EXPORT_SYMBOL_GPL(list_lru_del);
 
 bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
 {
+	bool ret;
 	int nid = page_to_nid(virt_to_page(item));
-	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
-		mem_cgroup_from_slab_obj(item) : NULL;
 
-	return list_lru_del(lru, item, nid, memcg);
+	if (list_lru_memcg_aware(lru)) {
+		rcu_read_lock();
+		ret = list_lru_del(lru, item, nid, mem_cgroup_from_slab_obj(item));
+		rcu_read_unlock();
+	} else {
+		ret = list_lru_del(lru, item, nid, NULL);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(list_lru_del_obj);
 
-- 
2.20.1


