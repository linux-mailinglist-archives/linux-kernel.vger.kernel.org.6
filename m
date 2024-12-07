Return-Path: <linux-kernel+bounces-436208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605F29E8276
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46ED11658F0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56517198A06;
	Sat,  7 Dec 2024 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sc82Jjhz"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDB19539F
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609741; cv=none; b=NYfM7ez4I+59CiMHQMQ8GYY+iSPReK/kYZsA0twPUuMtDDzeFdmgzKClFzDSST2EMl6pqOFdQ6p7THXSqKLxaQwK4AQiMNadkrlCXD1y7JSkR3fHrfkIMTIxo6qd70K+W1ulIfiOSoHO+9Zg1ssP5mi5CGTn5f5dlaAMAhKrm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609741; c=relaxed/simple;
	bh=7eooM8lictiogeSqDWNnopPiMIbG0zFPlbWX1bsoFTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qztlQ3/qTbwf2b+PYzav0ofeT2LBRxVWO51vfTd5aAJ8c6Z/xCWT1dD/REMLknMh92IO2pzv+jdupS14s56Gldzc42xl85M7cmRrmBTY9FNa4CiWcgpmG6ueS5DWdc8R3XIntFyWstzwd5CjMaQo4YUNSyvEFJXR7UJP3pE5pWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sc82Jjhz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso2033974a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733609739; x=1734214539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW2cgcwHB51Y5IYZaisd+Bp0HxAyG3VEQ4AUms4DlWs=;
        b=Sc82Jjhzwf42VIpjTq25RTYjSwkXnlstTVLZ1431JTsgTyq3sR6YDdVyU4T39YT6+5
         fK1TgrLrw38Vjl+3s/vtojjahZdNXVzgteeFRE0iIZN2nWKGhGz8e4fnrhvsewqBAhPP
         WwbWmwuzf5pvR4m6EWDYtLq33D9yWFWm9hJUgJUYOx1+jOY9TUI6BEJci08PdqYNvy+P
         LUS8+tLo0yEi5jNPwZge6XkD8YBYMiTrFecpiJWadFUCkXUHJyqkbT9/8ebDsFwkWKy/
         2w9/BHc3RPvHlCYk+czOMgkp6mD22/9PsnvGDI+LpsA4VdQ96SrXdmFVDGoJ3wVhQekE
         ajYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609739; x=1734214539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW2cgcwHB51Y5IYZaisd+Bp0HxAyG3VEQ4AUms4DlWs=;
        b=GGQfOXzc5iNsLIw2vcyQTVailxAIsr3UIQ9Em97L7/Cyas928lm1bM/rbK7DtofYle
         +PDoXqIDbaTflRHAS9BVVcpL0u9epL+IIMQOBje2VZcTsN/g3dFpQEV8cfIUTDBG1I3y
         w08KuDQN2J5ijnuZEJBIBBTNhaW+SKK3MxwMc9g5BwXHNxzOmfGuTtU0mc7ifoNqOP9g
         KjCyWJGgVPWqplvn/MZLtjgQJDE0F/wLm8zpsIxhHLjF05YbokoO5XJuIUXawX1FJogD
         kOAt9EE+/WGJ5JIjTfUFtr2Uow81Qab0CEtV2/umUC846Tf0s2SIuNheDPcnW5W3zVQF
         Td5g==
X-Forwarded-Encrypted: i=1; AJvYcCXcZiqUVBn6kwPcFi45K2Y1pq47Mp7aBVOvQ3ksqzimcThfRdquAFh6JqvM90cZJ3T2r/BlQ5xe9JfrWyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWZLw7WOUKhaZJioUC6/9KpVCAAUnqiURSGhOF903A3R7U5JJ
	BfEJ//84bL22rHvnOoYShV7sEZsvD9//WHrDMsCuDeGYX7QRNsjpZ5CifNIX/gc5CPsHnPYXd9+
	r8w==
X-Google-Smtp-Source: AGHT+IGLJjHyW+Ykmm2+aL9lWknHp1gQ6xAIWeFiqeIX5Kn/EtyOEYWZv/R88rJ8RijCnornkXxmr9Is4Ew=
X-Received: from pjboi8.prod.google.com ([2002:a17:90b:3a08:b0:2ea:4a74:ac2])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d05:b0:2ee:7c02:8f08
 with SMTP id 98e67ed59e1d1-2ef6ab29d43mr12407603a91.37.1733609739414; Sat, 07
 Dec 2024 14:15:39 -0800 (PST)
Date: Sat,  7 Dec 2024 15:15:21 -0700
In-Reply-To: <20241207221522.2250311-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241207221522.2250311-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207221522.2250311-6-yuzhao@google.com>
Subject: [PATCH mm-unstable v3 5/6] mm/mglru: rework refault detection
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Kairui Song <kasong@tencent.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

With anon and file min_seq being able to move independently, rework
workingset protection as well so that the comparison of refaults
between anon and file is always on an equal footing.

Specifically, make lru_gen_test_recent() return true for refaults
happening within the distance of MAX_NR_GENS. For example, if min_seq
of a type is max_seq-MIN_NR_GENS, refaults from min_seq-1, i.e.,
max_seq-MIN_NR_GENS-1, are also considered recent, since the distance
max_seq-(max_seq-MIN_NR_GENS-1), i.e., MIN_NR_GENS+1 is less than
MAX_NR_GENS.

As an intermediate step to the final optimization, this change by
itself should not have userspace-visiable effects beyond performance.

Reported-by: Kairui Song <kasong@tencent.com>
Closes: https://lore.kernel.org/CAOUHufahuWcKf5f1Sg3emnqX+cODuR=2TQo7T4Gr-QYLujn4RA@mail.gmail.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/workingset.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index ad181d1b8cf1..2c310c29f51e 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -260,11 +260,11 @@ static void *lru_gen_eviction(struct folio *folio)
  * Tests if the shadow entry is for a folio that was recently evicted.
  * Fills in @lruvec, @token, @workingset with the values unpacked from shadow.
  */
-static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
+static bool lru_gen_test_recent(void *shadow, struct lruvec **lruvec,
 				unsigned long *token, bool *workingset)
 {
 	int memcg_id;
-	unsigned long min_seq;
+	unsigned long max_seq;
 	struct mem_cgroup *memcg;
 	struct pglist_data *pgdat;
 
@@ -273,8 +273,10 @@ static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
 	memcg = mem_cgroup_from_id(memcg_id);
 	*lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-	min_seq = READ_ONCE((*lruvec)->lrugen.min_seq[file]);
-	return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
+	max_seq = READ_ONCE((*lruvec)->lrugen.max_seq);
+	max_seq &= EVICTION_MASK >> LRU_REFS_WIDTH;
+
+	return abs_diff(max_seq, *token >> LRU_REFS_WIDTH) < MAX_NR_GENS;
 }
 
 static void lru_gen_refault(struct folio *folio, void *shadow)
@@ -290,7 +292,7 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 
 	rcu_read_lock();
 
-	recent = lru_gen_test_recent(shadow, type, &lruvec, &token, &workingset);
+	recent = lru_gen_test_recent(shadow, &lruvec, &token, &workingset);
 	if (lruvec != folio_lruvec(folio))
 		goto unlock;
 
@@ -331,7 +333,7 @@ static void *lru_gen_eviction(struct folio *folio)
 	return NULL;
 }
 
-static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
+static bool lru_gen_test_recent(void *shadow, struct lruvec **lruvec,
 				unsigned long *token, bool *workingset)
 {
 	return false;
@@ -432,8 +434,7 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 		bool recent;
 
 		rcu_read_lock();
-		recent = lru_gen_test_recent(shadow, file, &eviction_lruvec,
-					     &eviction, workingset);
+		recent = lru_gen_test_recent(shadow, &eviction_lruvec, &eviction, workingset);
 		rcu_read_unlock();
 		return recent;
 	}
-- 
2.47.0.338.g60cca15819-goog


