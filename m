Return-Path: <linux-kernel+bounces-316146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B096CBC9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CA01F2758A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA5512B93;
	Thu,  5 Sep 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMngY00S"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2FCDDA9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496315; cv=none; b=lRoB+VQ6QxFNIQ+I38Rd00Ol3dhPd9K5lEUNB+puSag3jA3s9zzh2Zmn8Mz5EJjq+QR9xRRsvhZP64cG2nMh7C7VuoKIm0w7uwZesOHg+kp2a/ikRWIfv7EiKi9YnZv/JIvqIf4AywvTUyRHX2yxDxCCX7tZT7Hs1cKakcTdb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496315; c=relaxed/simple;
	bh=ZLKOWxT3NuOir/w+fbRaVKkoQ7BQs6qbrCt9McP4q70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p7Q3ckrUKhnYOVe7+N96yvdL0mFEzuSsK//BnCQyGx0zzeZKPYQnDkLJu31JONGAF6XUzcWAsf/0qK5YIVn0aVh4zAqFZAKkVNSeSu3ctbetERvrhxCOFqAZPdFK5FrjS4Ep2DUCnSX89XQHG218ZEum7yktjuX7AdqyCy9o1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mMngY00S; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d4fb78fe49so269303a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725496313; x=1726101113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ac9f2JvhNnpWVv2ZKYegshHvMbbmkBcnbuU73G1cYt8=;
        b=mMngY00Sf9O5z89pMRe/B1BCUmu+O7z3z4Hm/s7H5elhaCSimN4eIHfMqPp9CfJKxS
         Zj+Knf2OoRFYQ9XC3j/g6a5fBnQiD3LebFY2dor/Z9WGlU+lY5XtdH3iLYUTYE0QhsCc
         zrnLDfJ5XYAfuyOAW0DMBxFcq4K7gVpakK1q5DrZaDZPs6QFydEhysTsitl10egHS4z+
         6NZLrm/at1/zlPPWCFzXiN6jGkLUMT6wrHlNTJlr8yKtl1ISwL4jAyH8yQSZs15TLduy
         /i5Q0J/gJdah5tnR0UgOqYqGpsozNissMCC6EagyvOJKbJRZqN98HNsYqt6/sHezwQkz
         rmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496313; x=1726101113;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ac9f2JvhNnpWVv2ZKYegshHvMbbmkBcnbuU73G1cYt8=;
        b=bciZ4KGF6P4ZNPzOnnTC7OwWHZnlJnGA3sPDfC0WrYWPSzU4OxIUgkk1P6GzY4poXZ
         V+zYjV1mP/41nevAxc4I6pYB7duREZuGJadGapMY2D+e4Avy+suQmWJhZSi79ofLsMNy
         vnH222P4CNIay+lsgbw4x5zYjZkACzBX2g8GwMBhU1OGbbwW61mfFx2yJFD1cIIq33jg
         +k46Nu62tY8nRspvnOsPhDDJT/Sjg45/hEvdRdE/kAJDwclhiwniX5UlBhsmCFt/CAAn
         /XvbZCtTgH6igQZRu2md5wHR80X4d85NZJ+cNz0NAJwf0KA2zxOzc3++iarnqp8eovOZ
         7h6A==
X-Forwarded-Encrypted: i=1; AJvYcCVCA+EFX7SXZDzTOC+T52gDUepGK+lM0rh+86LpZlWdD+HFeRqwbPQ8Jao+3rS2TaQ+Z05qaBEQbj5MA/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zt/S8I1EwQw3R2wH9dmFLUK+L3YFSgv1LedbLLN0Y29igpmg
	r1i12J7VFj8abQoYnc7Jq3jiFLqQYY0ORKc1GFzOQKcJLN3lIg9ONR8EDstZH4HQhbwLOLXTOEx
	W5dkzjOH1qA==
X-Google-Smtp-Source: AGHT+IHuJuEjgofhNfeZ87JSGyMalBhwo29t0H9DuDw9GmIw/cnVXOLyLUXVF5+Ftrg6N3vF7BBT4Qhm6qOSmQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a63:f303:0:b0:7a1:f561:8c99 with SMTP id
 41be03b00d2f7-7d4c1087417mr46719a12.6.1725496311779; Wed, 04 Sep 2024
 17:31:51 -0700 (PDT)
Date: Thu,  5 Sep 2024 00:30:52 +0000
In-Reply-To: <20240905003058.1859929-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905003058.1859929-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905003058.1859929-4-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 3/5] mm: increment gen # before restarting traversal
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	"T . J . Mercier" <tjmercier@google.com>, Hugh Dickins <hughd@google.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The generation number in struct mem_cgroup_reclaim_iter should be
incremented on every round-trip. Currently, it is possible for a
concurrent reclaimer to jump in at the end of the hierarchy, causing a
traversal restart (resetting the iteration position) without
incrementing the generation number.

By resetting the position without incrementing the generation, it's
possible for another ongoing mem_cgroup_iter() thread to walk the tree
twice.

Move the traversal restart such that the generation number is
incremented before the restart.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/memcontrol.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cdd324812b55..c24ef6a106e0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -999,7 +999,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *r=
oot,
 		root =3D root_mem_cgroup;
=20
 	rcu_read_lock();
-
+restart:
 	if (reclaim) {
 		struct mem_cgroup_per_node *mz;
=20
@@ -1026,14 +1026,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup=
 *root,
 	for (;;) {
 		css =3D css_next_descendant_pre(css, &root->css);
 		if (!css) {
-			/*
-			 * Reclaimers share the hierarchy walk, and a
-			 * new one might jump in right at the end of
-			 * the hierarchy - make sure they see at least
-			 * one group and restart from the beginning.
-			 */
-			if (!prev)
-				continue;
 			break;
 		}
=20
@@ -1056,8 +1048,18 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup=
 *root,
 		 */
 		(void)cmpxchg(&iter->position, pos, memcg);
=20
-		if (!memcg)
+		if (!memcg) {
 			iter->generation++;
+
+			/*
+			 * Reclaimers share the hierarchy walk, and a
+			 * new one might jump in right at the end of
+			 * the hierarchy - make sure they see at least
+			 * one group and restart from the beginning.
+			 */
+			if (!prev)
+				goto restart;
+		}
 	}
=20
 out_unlock:
--=20
2.46.0.469.g59c65b2a67-goog


