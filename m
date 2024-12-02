Return-Path: <linux-kernel+bounces-428190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278E9E0B3F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C558F164115
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39DB1DE886;
	Mon,  2 Dec 2024 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAJ7DNVH"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A51DE2B9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164938; cv=none; b=UmP27MkjBiiHPorpqkcrym96b9I8C+GAh2c7Fr16laVlXOoBoHLTv8YbsiLfvhyoYvamx8zAtlsQK/zJJvF/SkdhqgzCYkU+phq5MoZ+qjo07/JFwo8SHvzJbA+bYGD6QevPiQ3xIapq8JGtq7Yob6Xr+xybC4ZQUfhCp3bdasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164938; c=relaxed/simple;
	bh=7xMcIoyfw2WhDIAFKEZLat3eNgZVj3iRjhG+H08KVv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYcHoJBKGah5U+RJRUe+SaJvvy+/2oN8OfcXbKddS5aRhWPSuZmMIrqV0Mr9HaXBFdmZ7ajGsWlDcVEFh97r36Bs0gHKjVNp4dNyUtuI2jb2rfvK0jo3u5ychSPjABngMDmehAx23UfwPzGaqTPgF/rwOCj8O76+25AVl8Qrlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAJ7DNVH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724fc1aaa91so4186490b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733164936; x=1733769736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bgfYlxq8M7pj/EQVq83uOmq930B/5yWrzKvSMuqYhjs=;
        b=JAJ7DNVHcSGWICQsHg/KNKBfta+N95ILEholS4MSG+W92ato4WjQAuun24cIGSTy7I
         teMozxFj7kieQMeE88RdUEBUBwymXfo+Gja2hTDJiwsIZLQGMWA6hKALMtOZJghuHqHe
         7bwRve59z8ZsHiVC7XXItswo3MpoEhmE6R5CiTp/FH0f9Gf4IHp3RF/oZL3JHh8GpcCc
         E/PVjmsB8IWF7Be+jonbhkQxxdNxu3mpmKW96wn2IOTtNCEWHgTKAWhivtdQIuLZ02/f
         0jXiLVnmwaNduMMokdNqIUGw3I/+ZZhPxsWAS3ruHCfaVsnHzE0aEjSLJWWXRvevrKJr
         iG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164936; x=1733769736;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgfYlxq8M7pj/EQVq83uOmq930B/5yWrzKvSMuqYhjs=;
        b=KAT/U15iJ9CGf50YGXJVzFsTHUrOUyZKRDHYRBD006rzB/36XRvQbjYaDK3lVuBX51
         gjBCaQ1jS/0QKuWRZH7yExD9dVQYAv2OqAmaWEeDnYVRva34dJMuE0N9QHd/CWcIV78d
         9K7ADMeVmjNbhXj+NrATv5f2/gizYsb2Yk8FTtx2vtGLkpEuT2dVYso+m4v4NkJPz4Cy
         UvR1LTsZJrz33q/q4KZ4IcKxrhQRkJkGMf8dL381dfln0hNkA6SVtVA31ozhjU0idjYT
         LYdWu/gGZjw255K1uqqOe7rmj8BS48ufEjCQdQoVt2WZ0rQboBmlbAmpJVjKcBRwcO+8
         0PCA==
X-Forwarded-Encrypted: i=1; AJvYcCVcya69si12NAi4wKdyEv1+Fp6BNfNWraZhk0QKmt8pZ33bjHNrAqBuu2C1Fitw1uyzWJeH8H2HrE6CjOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wHHvltjX4p1pKdQSg37i0vvZPslM+8x0MlcA+X5w3Gc402x8
	Kab6dhWl1G5v/LaLlJgrjlvz6BzTjz8c8q/t2L8pREKmHcwC112l
X-Gm-Gg: ASbGnctcAJuV1SSYfdmd/IDNvFHrUtAizXHbKFNvKl0D0k3q207TTnW/6zD5nmIOmrW
	GcScMitnx7f8wwpw7uNvYjstvigpHJRxbcraWAD8d3n4JeeMNAKf/LiCSM1tSiEVrWrHjAX1RzN
	VA9zFGFnA9ljyJPI1cZRXzluo7zdI9mCx4LGjHeyjJEYZllm+qkkbx6WO7iVel2sdmWz8c2iBsf
	zKs6qFuN4mvZguUpVDHfbbG2BYcG7smPT8sLXwGiob6xUgUdEXcmJG/6JERnoWZ5P7AXtA=
X-Google-Smtp-Source: AGHT+IEeppgHPbYXo/4IKwmclLHEdajSYeynVAjocWeV2X5vj8HNw3SKD3ti5afx7GbXPWkD1M5KNQ==
X-Received: by 2002:a05:6a00:1c8d:b0:725:3bd4:9b56 with SMTP id d2e1a72fcca58-7253bd49c85mr31675949b3a.5.1733164936073;
        Mon, 02 Dec 2024 10:42:16 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb7d5sm8849781b3a.94.2024.12.02.10.42.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Dec 2024 10:42:15 -0800 (PST)
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
Subject: [PATCH 2/4] mm/swap_cgroup: remove swap_cgroup_cmpxchg
Date: Tue,  3 Dec 2024 02:41:52 +0800
Message-ID: <20241202184154.19321-3-ryncsn@gmail.com>
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

This function is never used after commit 6b611388b626
("memcg-v1: remove charge move code").

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap_cgroup.h |  2 --
 mm/swap_cgroup.c            | 29 -----------------------------
 2 files changed, 31 deletions(-)

diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
index ae73a87775b3..d521ad1c4164 100644
--- a/include/linux/swap_cgroup.h
+++ b/include/linux/swap_cgroup.h
@@ -6,8 +6,6 @@
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 
-extern unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
-					unsigned short old, unsigned short new);
 extern unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
 					 unsigned int nr_ents);
 extern unsigned short lookup_swap_cgroup_id(swp_entry_t ent);
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index f63d1aa072a1..1770b076f6b7 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -45,35 +45,6 @@ static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
 	return &ctrl->map[offset];
 }
 
-/**
- * swap_cgroup_cmpxchg - cmpxchg mem_cgroup's id for this swp_entry.
- * @ent: swap entry to be cmpxchged
- * @old: old id
- * @new: new id
- *
- * Returns old id at success, 0 at failure.
- * (There is no mem_cgroup using 0 as its id)
- */
-unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
-					unsigned short old, unsigned short new)
-{
-	struct swap_cgroup_ctrl *ctrl;
-	struct swap_cgroup *sc;
-	unsigned long flags;
-	unsigned short retval;
-
-	sc = lookup_swap_cgroup(ent, &ctrl);
-
-	spin_lock_irqsave(&ctrl->lock, flags);
-	retval = sc->id;
-	if (retval == old)
-		sc->id = new;
-	else
-		retval = 0;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
-	return retval;
-}
-
 /**
  * swap_cgroup_record - record mem_cgroup for a set of swap entries
  * @ent: the first swap entry to be recorded into
-- 
2.47.0


