Return-Path: <linux-kernel+bounces-426873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEAB9DF998
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DF0B22955
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CEF1E32D3;
	Mon,  2 Dec 2024 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcrnSf8d"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F71E32CD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110123; cv=none; b=p9KrOAbkTyi1i29LNNGEzhnucxeN/k6Kvs8zJKuQZyDeAMtAOA+YjdiJgCMSOUAOJPZqL/4u5iLGawTDaNA5NcCpKvwF8hEUPe/rQ9f/P0jyHBlRKrpRwPryaWK7BvlRe6nKu7y7H6nqWIxtXd5ZF4+++oidYUwHe/PFQouoXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110123; c=relaxed/simple;
	bh=7eooM8lictiogeSqDWNnopPiMIbG0zFPlbWX1bsoFTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=slvxahdBv8v/fcdrvLkx9ngWk6Hp41WUF+EkhpIH/p4hwR8D3tnl32dMQXJ9DR7XxVXpzr+lxwFAusjAz9p+m8ggvouDMUydtoBREB1qZAo/VdaVqj7Imk2XbnROyDbe7fmfLp6gs6TVuoUe5qbpzgCadVe1tM7ESN5l0NIZ91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcrnSf8d; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-215699398bdso10445505ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733110121; x=1733714921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW2cgcwHB51Y5IYZaisd+Bp0HxAyG3VEQ4AUms4DlWs=;
        b=dcrnSf8dHhji03PwfLKjPr1xsISY4MQ5sEKjRue9wdoXAmzMswifMuaKEU7l8zyL0S
         es+qQQ/6AP9DQyln8/X6CfLYvcActUXc1UIxd+XMDm/bOHK6dhJys77p8KpnQJ8J2VMD
         IvCjIUo0SwWyxCKMFSap36e15wvWw2O36t2djjv8lLNOuIbe59Q8092eh739hjz9iLiN
         lv4LY/ujBix+JLumG8VXgAntJAMdyaa7do30YqpkrHvYodF7+N0v9+HWJGQh7K6pkCEn
         fxGC2E65sfvkBbx5lUF776VBSZnr9kFH5T2Eqzov8maS2huvlQnVEmpBdxr+Sk+js0yd
         tt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733110121; x=1733714921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW2cgcwHB51Y5IYZaisd+Bp0HxAyG3VEQ4AUms4DlWs=;
        b=YAP2NhEgKw6In33FfqumPLDSBx3A4um9RS07u1BdBHzbTKm+OkoHSPFa3aoL5QndiQ
         sk1QcLD+bXvAD+RXcnKDw8Ns63JfDoRUWhGO7d1KCIg3RIAyaWvuK1LCsJkOfWbIJ/Y0
         9pHESUHI/xStfvWYOMJYDnM44Yvqe9RyzSoBzYiSLvjCbHzMYM9MzFY3/DcombxgJf8s
         QY4kgbS3HJDv45rWWo29DtFOFb5wsPJZKcO4UF5E2DRx7J4MKPXNz4VDziqxwwNjRs9f
         HJhe0c1QTl0o2vZpN0K3p/MHw1BhQsJEQDlN0xD25Q/53begLpw2XZe0YtT37xwqQAqp
         DWFA==
X-Forwarded-Encrypted: i=1; AJvYcCXo/WqtjGrxeQB04zUbbL9bD9ncWj1ufaZPuam5KQmC1ki4Z/bbLXyoU1JrFnDL5yrGP9m8JLIGPMCRJqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz972tzGBOgWdelJkCusZVGVc92eECiuLeJ23VPXlE52olgT8GB
	Zsq2WFI3hGobmDFxJYzTDWkl5nH7jCpmQf+BO8ppuHdQWWyWP5qnAYx/HP/yocZshU/mzBHn4SO
	jmg==
X-Google-Smtp-Source: AGHT+IGV/8vBTUsUxmc+joe52tDW4U0gAzmSevdVnbajr1Q1NEr3Inb6b68KRcu10pksEIJ78suAm86dnjs=
X-Received: from plgp12.prod.google.com ([2002:a17:902:ebcc:b0:212:3f35:e4bd])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2452:b0:215:609f:3f9e
 with SMTP id d9443c01a7336-215609f4515mr110182305ad.40.1733110121122; Sun, 01
 Dec 2024 19:28:41 -0800 (PST)
Date: Sun,  1 Dec 2024 20:28:22 -0700
In-Reply-To: <20241202032823.2741019-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202032823.2741019-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202032823.2741019-6-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 5/6] mm/mglru: rework refault detection
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


