Return-Path: <linux-kernel+bounces-261425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B7B93B725
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F26B24358
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E03F16C87D;
	Wed, 24 Jul 2024 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXcCH6fj"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4D16C68C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847744; cv=none; b=ONRVtl4rKHv13PXOzp30QI15za4yZtNKRvvCj2d9sl+7QW+oKhOSAUNzdqpfAQ4TvBxDduykrfBE0ayoCuwBy8BJtKx7M4eogFmkwaeO+YvDdKberCbHpUiZ+n8X0vd4lIc0HT5BYRq25tlM6rrcGERTDgNUsIEIsPQR7hDqq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847744; c=relaxed/simple;
	bh=OFk5wDl8xpbdEo44lplWr1p5F7ojENQPq4VGlH1jB9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SVaL3DkLUQAeEJd5OyhbYQHXZSvDyqFQ6PhZsO9U4Y27/H1fhoi6TOKB7ctw470MTI46pOjTBvVBGEZPQJCNooisJ2JXTGpyI2ssjYhQcgCE4tIAquKO7fcmlXhG9GdE8ipI0p93rbRYfNfqvR0mRp/MXOkLGSm2ZQYgYpwk/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXcCH6fj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-72c1d0fafb3so105817a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721847743; x=1722452543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmGz1OUSAYzLu3Mkr9WfTC/ktWFGonkMAhMj+nbyydo=;
        b=XXcCH6fjno4piANDvv4EwU8SJ6HnglWRFS/PtVQpCDpj6Zpld5fLafQYEpo1YroAnf
         pjCIr/iyqhFvwvzrR+y9iP0vYtyW/cTY3TYP5yDRnMLZgET0BzBTzTwL0VirxUByu6Y/
         wf2lX/XMo/cOPDRXqxYTCw9KqAUmoK/Yu99UE5qkfojeyZ+1BtnYwzHtsnOvP/oCQiHa
         PRAss8hUyAyYEYArLE+9LfNhMBa67q/TT73UgtYh25nH5gqYf8pQIca3S2B/a4KnFSO3
         8hSnnfYMelW6/bvIZcvDvwdiKORBkKppjmK4VwrA2BUpTG+edvB5DYJV+8pl5A7OWjOP
         WvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721847743; x=1722452543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmGz1OUSAYzLu3Mkr9WfTC/ktWFGonkMAhMj+nbyydo=;
        b=IgPXO+gKV9IWkP7QqECps/NuFoNQWBGkG3vJEn0B5zPY4GQ+frEvB36xUr4rS/BcIM
         eBirpuAFJDnlWgWnIqDQ8gfRl2jKUm0AnMw20CFkGglIz2GSs0O1rJzplPSrIq4uJFuv
         9tHWIfIx+BO8UV32v3cjwgKUQaAVMjdUcsoMut/rwXQhc8czadth5mSVNei4X2uZ1aK2
         Odgt+75WduFFZLeOa2rnv3LLrB+s18GzIQ3K2KwA/K/gJ5B+RC6jWwub3Syud6OOjJ3F
         rCP9VYtiQE8hFnX9PJlvMsX0mD3M2koV9tUN4dxxHNcYofv5PIHVyOSlf2CAT9XEZZWo
         BSwg==
X-Forwarded-Encrypted: i=1; AJvYcCXdcJuF5BK87MY0PQSBIlS2shIBpzBBPwICeQaQ2LN0Amuw64c176OutiTXNW4GtephoYWbCo2hgaPSht71+hcE7BlEz0UtF8lSM7U6
X-Gm-Message-State: AOJu0YyirNxcO+jcTnXksSfI9drjwHl/kMELXjtAdehfwkLx9HGzy/3C
	ljfeeeml0S0TJ4gRxO0frZovieO0+IEYkTvALb0KhbNMq+AHi4xbVU55fWjYMA00Pqid5OHEFKy
	LKBA+plfQpw==
X-Google-Smtp-Source: AGHT+IGLvyDW6X3i6jqfX6m7Tz2BzQtjRTiuAHBzI1w6qDTToawljkbGNllzBAuC3KsBrh2qsLZDEguaiP99GA==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a17:903:1105:b0:1fb:27bd:82e2 with SMTP
 id d9443c01a7336-1fed38ccc31mr9895ad.8.1721847742363; Wed, 24 Jul 2024
 12:02:22 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:02:12 +0000
In-Reply-To: <20240724190214.1108049-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724190214.1108049-1-kinseyho@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724190214.1108049-3-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 2/4] mm: increment gen # before restarting traversal
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

The generation number in struct mem_cgroup_reclaim_iter should be
incremented on every round-trip. Currently, it is possible for a
concurrent reclaimer to jump in at the end of the hierarchy, causing a
traversal restart (resetting the iteration position) without
incrementing the generation number.

Move the traversal restart such that the generation number is
incremented before the restart.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/memcontrol.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 062bfeee799c..f672bc47c6b5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1003,7 +1003,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		root = root_mem_cgroup;
 
 	rcu_read_lock();
-
+restart:
 	if (reclaim) {
 		struct mem_cgroup_per_node *mz;
 
@@ -1030,14 +1030,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	for (;;) {
 		css = css_next_descendant_pre(css, &root->css);
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
 
@@ -1060,8 +1052,18 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 */
 		(void)cmpxchg(&iter->position, pos, memcg);
 
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
 
 out_unlock:
-- 
2.45.2.1089.g2a221341d9-goog


