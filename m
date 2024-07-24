Return-Path: <linux-kernel+bounces-261427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65E93B727
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78731283FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12716DC16;
	Wed, 24 Jul 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtZe9R8b"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91216D33A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847748; cv=none; b=pWttAIBuFh7bCSzxvzKpD1AW8/zblG+9JfbKNbZsx1LEMczmg7o0sUfb22dg4XbE3jc6WByZOSJQgkFb/t3zOSyy+vvBSCEyvMfBpP0jR2P5pyGoPVi2Uh74QATBAZL5leHmKdpJWhAu69EvAKkhZsDvpcqfJlpkpVlcON33Pjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847748; c=relaxed/simple;
	bh=rGVLNhAjSzvTNlgJoN+vRdGIm9OMfTJHAiadJXPXIHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f0Qh531StBff9Md9gNftgcPrKCsEpox2lDSmPW/vYmHNyIVRafHafdMrUtyK2GQcQZtSXsdKLmvnYOVouIq2h7pKe2/tbFh1mX8qTxr3AHR9T4URJ2w8sl1VcHOMnLL1rzwSAjPEe9MvX1zCL/iia/eLqix8oGj64f2YqDIQuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FtZe9R8b; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb50fbebd9so193459a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721847746; x=1722452546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys2craRirgSkjM83RG964eoUiETMfTD1cND24tGgc4M=;
        b=FtZe9R8bIj6nd+rousnMGDbxAFpGSxrXJPJfBohrTQIod4ljLpf6c+3MyOnXSGyaPl
         JH1QcYBgbjs8ROSGNbcjbbpTuCDmVMJgtrXr5iwTITW7hgDPBW/TkuQ7daUTA0uR0JRL
         js0TnIFDl99nAYkgdiTtKpL8hWBxw3vYyARVwSRQeQA5pyfNIp2iVAy5CSW1CXzCzixz
         3LE0VwTsWEvUN/VnZtTObKVAOJdtwKDBwqwaOti2OJI4pm6G/cXdIYbhB3oiFEd+6Uyj
         hc7yW6s/Q6ntS+MnuMpBMy4GMVyMH4bCEL8RAjbYMPO0PP43pnNfJ9urayF6dRkQH3zq
         8e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721847746; x=1722452546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys2craRirgSkjM83RG964eoUiETMfTD1cND24tGgc4M=;
        b=IZahAxm/U4MECPXvdENWgUrNU2oCf9OoQbGKrUp8zo0/9ErrlltcX6rz0uTe9hkrSt
         Z5BAs0S/GHclCTlDJ2hgXn/x3sV5yZPRpkLMAwYfed3XznEQQBYfnhJLQ+4xrPJsZP+t
         J/fbxMEGwK6WM2uAZJUKz0ugnjE9kZZQAIisBRnS8HAoUWpf1pyGNIJA7CMRpT1NlYaA
         yP0+Ev8CildZiH0P8QINvZruK52a5lYOr7P0jImIuZk20/axGdT5Hr8rE1aW/MHWUd6f
         xD0+iwlqTdVT3vLydOCHqjtCUxHFjS6Hl2t4x+3SXaCVb7tyLxF3KscX3NyBbxOUMBzx
         JXYw==
X-Forwarded-Encrypted: i=1; AJvYcCVTarGA8Nc7eG62C/XoN9utbm1m8Fbzc4TgKw6BqVkkVB0Xl0E7NaFyV/iljaqtAB9EhR6819JeC2Uchq3XObZzAiDnEBTRHN5uH8qw
X-Gm-Message-State: AOJu0Yzx3kpvHRaflIFW6YGh3G6GRKgPQGA0MkFa9EaiHcOlf691/iio
	RC1Q2ec2E+k3/5e1BxJ7RfTP2iunXToEIsLtrPBqM1/jXi82mdm+f3JpFfaPxqkR9SpqvQLulgc
	o89rw0J78iA==
X-Google-Smtp-Source: AGHT+IGYuWhGCshfz/1OfOrlFgcnBDPUyftLtmcQ4FX3/fi/oAJTe3cbfgo0sG0FCKIUMQtWQ+YJ7xLut+dAxw==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a17:90a:17ec:b0:2c9:9c25:7584 with SMTP
 id 98e67ed59e1d1-2cf23e1b73bmr1597a91.5.1721847746082; Wed, 24 Jul 2024
 12:02:26 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:02:14 +0000
In-Reply-To: <20240724190214.1108049-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724190214.1108049-1-kinseyho@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724190214.1108049-5-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 4/4] mm: clean up mem_cgroup_iter()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

A clean up to make variable names more clear and to improve code
readability.

No functional change.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/memcontrol.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4314a2b8848d..7e3e95c62122 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -992,9 +992,9 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup_reclaim_cookie *reclaim)
 {
 	struct mem_cgroup_reclaim_iter *iter;
-	struct cgroup_subsys_state *css = NULL;
-	struct mem_cgroup *memcg = NULL;
-	struct mem_cgroup *pos = NULL;
+	struct cgroup_subsys_state *css;
+	struct mem_cgroup *pos;
+	struct mem_cgroup *next = NULL;
 
 	if (mem_cgroup_disabled())
 		return NULL;
@@ -1006,10 +1006,9 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 restart:
 	if (reclaim) {
 		int gen;
-		struct mem_cgroup_per_node *mz;
+		int nid = reclaim->pgdat->node_id;
 
-		mz = root->nodeinfo[reclaim->pgdat->node_id];
-		iter = &mz->iter;
+		iter = &root->nodeinfo[nid]->iter;
 		gen = atomic_read(&iter->generation);
 
 		/*
@@ -1022,43 +1021,36 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 			goto out_unlock;
 
 		pos = rcu_dereference(iter->position);
-	} else if (prev) {
+	} else
 		pos = prev;
-	}
 
-	if (pos)
-		css = &pos->css;
-
-	for (;;) {
-		css = css_next_descendant_pre(css, &root->css);
-		if (!css) {
-			break;
-		}
+	css = pos ? &pos->css : NULL;
 
+	while ((css = css_next_descendant_pre(css, &root->css))) {
 		/*
 		 * Verify the css and acquire a reference.  The root
 		 * is provided by the caller, so we know it's alive
 		 * and kicking, and don't take an extra reference.
 		 */
-		if (css == &root->css || css_tryget(css)) {
-			memcg = mem_cgroup_from_css(css);
+		if (css == &root->css || css_tryget(css))
 			break;
-		}
 	}
 
+	next = mem_cgroup_from_css(css);
+
 	if (reclaim) {
 		/*
 		 * The position could have already been updated by a competing
 		 * thread, so check that the value hasn't changed since we read
 		 * it to avoid reclaiming from the same cgroup twice.
 		 */
-		if (cmpxchg(&iter->position, pos, memcg) != pos) {
+		if (cmpxchg(&iter->position, pos, next) != pos) {
 			if (css && css != &root->css)
 				css_put(css);
 			goto restart;
 		}
 
-		if (!memcg) {
+		if (!next) {
 			atomic_inc(&iter->generation);
 
 			/*
@@ -1077,7 +1069,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	if (prev && prev != root)
 		css_put(&prev->css);
 
-	return memcg;
+	return next;
 }
 
 /**
-- 
2.45.2.1089.g2a221341d9-goog


