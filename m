Return-Path: <linux-kernel+bounces-261426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED7893B726
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9427BB247A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3646D16D4C3;
	Wed, 24 Jul 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ao+bXdE4"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC016C6AD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847746; cv=none; b=oMXoyZVnTGzOq6yA8NcrlXyCUX7txGBafnIm/IieOGuvKzRSF0QhorGA0+dYZatvDl0ojwrHBACo70hLlpPJkYu2LOMsSQB1I+vSfI9Tb5dp+a4doxkBkfa1VURm0Vf2X7MrtDapIbFT9uSuL1eGzPx2WTto2Jkldzq+kvJS6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847746; c=relaxed/simple;
	bh=sTj77cJUVCVZkNczDF9RCrE7mv7tSFEGITNZCht7iBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H5wdlXrD9UdhGfENOyWo382DedvU3eqOdwHAC/5tFv0A7c/TG/PUSFu2T9ej9S1AG++7Xwr1yH+832rpAy5H4Y/ECJOArLlIB7JDVx4/x18DvQmBkPQPGLDQY/mfWBSXIQyVCrB7o7xOrt/NivjQ2M3geBpGs6dyQdPtHjk03b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ao+bXdE4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fd5fe96cfeso1011595ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721847744; x=1722452544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TQiG1UXUGUFW+lVBdf0Q/W1aoqYwGoLbWZS7cahHzw=;
        b=ao+bXdE4Gx09INNpC6JaNknFPgIcqgc+zUagBuZwHxHj94+0S4Pts0DI9iCVWSHs0w
         etgj/0V4vA6lTCJEU35kb1vzXV+12um1PsjlYipqLvZiVboOQz8UyyMX95XMM4WBIYV+
         nmsxshAV69Gn5phyIGk24wqA/Bi4S/Ii0rYzs8oL/q72JvmSdAfrM7E53PVGKnrWS0vB
         +3wDrvWy83199Z1tIycSGF8/+tpSJkC4eeNtunLR8MQ0hNCoafLXDowqAkPK09W8XWDD
         pt+qDlOp/+F75mzCA1TkmPCUiZ4P1h/e9/tog6k4qNuYdIWbmYOOrVpIDq2a75tKCUfo
         FGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721847744; x=1722452544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TQiG1UXUGUFW+lVBdf0Q/W1aoqYwGoLbWZS7cahHzw=;
        b=w2ZpmLcC93UanjzTs8R0cUgrhJY1NZhKLZoGOecpHSj/CjjkE8jsriuDtXjQBwDCeF
         +lKe0MR4NCqv9KqKh9qq4vpzr49J/1/nbyJ6TL6N5nvVPssQLXegYd4W9AJV05F2MT6O
         SQPlXLFIdTV3gJey4eYArKyS395n+1uRH+V/SDuHIEbjlKaPw5F2LGH6FSqOwcP2QDzH
         YFlVlrsFnjDbq4xM3qUwMV356XNkNpWl2QPEKN8xeFb8fCbn7SCd3sp5Qw+T4OyLrBEg
         CWcMcoYLkQ4P6Ww1gljwgX9Vd6DpTTipeHxjNAPtq0d6QngWFbZWkCmWZ4AnKrZfmJj1
         d4vw==
X-Forwarded-Encrypted: i=1; AJvYcCXe/PmY+htO+rP+g8FUZLuefyxtQ2cP+d0CRfj9nuC81d2oTnI/XCvYhm0Kan84ZS1IpBr5/b7gvpCIM1OK5iQSmtboG4dN2zXSfYzs
X-Gm-Message-State: AOJu0YyOHsHolF/OYC6lQzu+W6THdv/YKNiSPdmLR/A+Vz3TB01BSbg/
	nC1I8+QJVdN43WnAYTJQsehj0fJSuVEAf4mAnqocKqH+2x0RuZ1vynLTY/WpHN0ejtbDiNUzqtg
	Pw4+e8pP8IQ==
X-Google-Smtp-Source: AGHT+IE+tnQU31Bbj4dJVy+3PQYbdu9GD4nWCJk68x0wq+h9pms1Ho5g0zih9cGcyJ9eyRiAWRuy7HbM8eN7gg==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a17:903:24d:b0:1fc:369b:c1b5 with SMTP id
 d9443c01a7336-1fed3531a98mr17415ad.5.1721847744302; Wed, 24 Jul 2024 12:02:24
 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:02:13 +0000
In-Reply-To: <20240724190214.1108049-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724190214.1108049-1-kinseyho@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724190214.1108049-4-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 3/4] mm: restart if multiple traversals raced
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, if multiple reclaimers raced on the same position, the
reclaimers which detect the race will still reclaim from the same memcg.
Instead, the reclaimers which detect the race should move on to the next
memcg in the hierarchy.

So, in the case where multiple traversals race, jump back to the start
of the mem_cgroup_iter() function to find the next memcg in the
hierarchy to reclaim from.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/memcontrol.h |  4 ++--
 mm/memcontrol.c            | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4cbab85e2e56..2b354abe6d48 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -57,7 +57,7 @@ enum memcg_memory_event {
 
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
-	unsigned int generation;
+	int generation;
 };
 
 #ifdef CONFIG_MEMCG
@@ -77,7 +77,7 @@ struct lruvec_stats;
 struct mem_cgroup_reclaim_iter {
 	struct mem_cgroup __rcu *position;
 	/* scan generation, increased every round-trip */
-	unsigned int generation;
+	atomic_t generation;
 };
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f672bc47c6b5..4314a2b8848d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1005,18 +1005,20 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	rcu_read_lock();
 restart:
 	if (reclaim) {
+		int gen;
 		struct mem_cgroup_per_node *mz;
 
 		mz = root->nodeinfo[reclaim->pgdat->node_id];
 		iter = &mz->iter;
+		gen = atomic_read(&iter->generation);
 
 		/*
 		 * On start, join the current reclaim iteration cycle.
 		 * Exit when a concurrent walker completes it.
 		 */
 		if (!prev)
-			reclaim->generation = iter->generation;
-		else if (reclaim->generation != iter->generation)
+			reclaim->generation = gen;
+		else if (reclaim->generation != gen)
 			goto out_unlock;
 
 		pos = rcu_dereference(iter->position);
@@ -1050,10 +1052,14 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * thread, so check that the value hasn't changed since we read
 		 * it to avoid reclaiming from the same cgroup twice.
 		 */
-		(void)cmpxchg(&iter->position, pos, memcg);
+		if (cmpxchg(&iter->position, pos, memcg) != pos) {
+			if (css && css != &root->css)
+				css_put(css);
+			goto restart;
+		}
 
 		if (!memcg) {
-			iter->generation++;
+			atomic_inc(&iter->generation);
 
 			/*
 			 * Reclaimers share the hierarchy walk, and a
-- 
2.45.2.1089.g2a221341d9-goog


