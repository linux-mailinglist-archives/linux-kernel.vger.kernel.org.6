Return-Path: <linux-kernel+bounces-395640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D069BC0E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B62B2213C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB651FCF4D;
	Mon,  4 Nov 2024 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5xkWc2j"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BA11FCC78
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759287; cv=none; b=k5E+NGVfph1VHZoUy2T8bGCoWtrJ4TKuzGUfj2od0TgE1dJW0ZBb+3MQW1cPWX8sGlyzwSJx3Kz/Y+DDAewhUvDUiHSbX7KNOPgPPhZvBpskU1Xi6o1Pd1I4iPwk/FzLaq7HsC70vlaBi/il1ZfSTvSwyaXE0WEwHLmg/jXHwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759287; c=relaxed/simple;
	bh=EJNvneSb2bAkEoIP2yqDhFgTFWhaaoBBZ0be+xlgRAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XVxnkjWQfC69UoXOPUDlHls2OJKMpJneOGPS/utFp8MwZH3ZdZcifbhODyYxLaqoLyvQDFMMYNfi5QVbEqM11cATCbjAfO87pxREFRxlSSSmxSHBxMyQj8KyhoNwEtktDXlAtLK9boO3nWQjDaEaYvaoYRynXR5Bk+YrJFu1cFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5xkWc2j; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3314237b86so3942389276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730759285; x=1731364085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y1rurBWlXkBJ5QujXdpx9YV8mvueM8qn9kB2Iz3Dps=;
        b=i5xkWc2jukm6ne3EuLkiOI0dfJdRnGUSnC7YI2qgwhSua3373O08QqycRpRYEoFZnH
         hvyJhmDrrV8E0gqslY6cThTer9rZGAVHlB0OiGtsbbyB5gfzOhRCeU6rZHRgs9RKr+2y
         JY/K4uaYfN5aM/gXHVIp0hlIPgiweUp20Xic2mK7mxfO8PkLj+fjEhRZyDlZaTjcPFdj
         rFwWUd7BE+7kTi7C585JW8ohr1w0+ca6tof5WCSP1DOBMZjhg367pwxAwZPX7kz3bB2D
         Of+467RwbgZ6liKw1d8Lz64StppoL6/W/41M2Sv9Qq12Gq6AZB+VtebS711FzH+0nnjq
         EbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759285; x=1731364085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y1rurBWlXkBJ5QujXdpx9YV8mvueM8qn9kB2Iz3Dps=;
        b=JRAjQUxJGNlZblz8w896N28nbQ9XMIkkR+SRkfqkmrnTue2AJ5shDimvwpo/lvYuML
         NUaSVtXgSY7pDkcgSPiP7TMLjK75R0Aa+L6dXFKfneFOWszHhXGUBHVESFE1CDoMbStn
         BllqCEZrTftNePGKNb4xibvBctL0pXK6KRwKf/Q12wrh0c/01wdW9+ZSNwIFsUll3jts
         wMfS0UssKZk55ROkcoMCWvwMIl9ji8TAahDynngSbXDfYYuV5UVwzFFArIgHDLOmuVLw
         xxKJH+Xnupt1JR5Qh6Ol3c65kLQOV2QmYEK1mPbzoWF3Ip0w+hNaVN1WhcWAstEKN0V8
         rLtw==
X-Forwarded-Encrypted: i=1; AJvYcCWR30zpFqwuIfD1OIMN5ucbv6EDZr1dVZyJGis35xUbbogQJfG/oBePk4XyLovMd9+0+Gf7rmcrlYaHEPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg80rUZV0Vyv7uzJS2RdizGrHdC6cFFZSreD5Ee0TvBFNrSnY5
	4qXSs8Jcr82+VKoCOetsgmWL6ksPDlpkPEzgb5Azzb+L0JTPijwpFQZ+qnerMIYrvLkQl0qIse9
	z2Ee53vbuPA==
X-Google-Smtp-Source: AGHT+IFYKOaIjpS8Fz6C5WIVgYJMz0Emr23R1GgYJzZPyhN+IxJ95BqWZNBsDFRPvDl3JbnLJUB3ze0a9JPbmw==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:2520:b863:90ba:85bc])
 (user=kerensun job=sendgmr) by 2002:a25:b324:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e330253c596mr9576276.1.1730759285167; Mon, 04 Nov 2024 14:28:05
 -0800 (PST)
Date: Mon,  4 Nov 2024 14:27:34 -0800
In-Reply-To: <20241104222737.298130-1-kerensun@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104222737.298130-1-kerensun@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104222737.298130-2-kerensun@google.com>
Subject: [PATCH 1/4] mm: fix quoted strings spliting across lines
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch fixes quoted strings splitting across lines in
pr_warn_once() by putting them into one line.

Signed-off-by: Keren Sun <kerensun@google.com>
---
 mm/memcontrol-v1.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 81d8819f13cd..3951538bd73f 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -602,9 +602,7 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. "
-		     "Please report your usecase to linux-mm@kvack.org if you "
-		     "depend on this functionality.\n");
+	pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. Please report your usecase to linux-mm@kvack.org if you depend on this functionality.\n");
 
 	if (val & ~MOVE_MASK)
 		return -EINVAL;
@@ -1994,15 +1992,11 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 		event->register_event = mem_cgroup_usage_register_event;
 		event->unregister_event = mem_cgroup_usage_unregister_event;
 	} else if (!strcmp(name, "memory.oom_control")) {
-		pr_warn_once("oom_control is deprecated and will be removed. "
-			     "Please report your usecase to linux-mm-@kvack.org"
-			     " if you depend on this functionality. \n");
+		pr_warn_once("oom_control is deprecated and will be removed. Please report your usecase to linux-mm-@kvack.org if you depend on this functionality.\n");
 		event->register_event = mem_cgroup_oom_register_event;
 		event->unregister_event = mem_cgroup_oom_unregister_event;
 	} else if (!strcmp(name, "memory.pressure_level")) {
-		pr_warn_once("pressure_level is deprecated and will be removed. "
-			     "Please report your usecase to linux-mm-@kvack.org "
-			     "if you depend on this functionality. \n");
+		pr_warn_once("pressure_level is deprecated and will be removed. Please report your usecase to linux-mm-@kvack.org if you depend on this functionality.\n");
 		event->register_event = vmpressure_register_event;
 		event->unregister_event = vmpressure_unregister_event;
 	} else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
@@ -2408,9 +2402,7 @@ static int mem_cgroup_hierarchy_write(struct cgroup_subsys_state *css,
 	if (val == 1)
 		return 0;
 
-	pr_warn_once("Non-hierarchical mode is deprecated. "
-		     "Please report your usecase to linux-mm@kvack.org if you "
-		     "depend on this functionality.\n");
+	pr_warn_once("Non-hierarchical mode is deprecated. Please report your usecase to linux-mm@kvack.org if you depend on this functionality.\n");
 
 	return -EINVAL;
 }
@@ -2533,16 +2525,11 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
 		case _KMEM:
-			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
-				     "Writing any value to this file has no effect. "
-				     "Please report your usecase to linux-mm@kvack.org if you "
-				     "depend on this functionality.\n");
+			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. Writing any value to this file has no effect. Please report your usecase to linux-mm@kvack.org if you depend on this functionality.\n");
 			ret = 0;
 			break;
 		case _TCP:
-			pr_warn_once("kmem.tcp.limit_in_bytes is deprecated and will be removed. "
-				     "Please report your usecase to linux-mm@kvack.org if you "
-				     "depend on this functionality.\n");
+			pr_warn_once("kmem.tcp.limit_in_bytes is deprecated and will be removed. Please report your usecase to linux-mm@kvack.org if you depend on this functionality.\n");
 			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
 		}
@@ -2551,9 +2538,7 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			ret = -EOPNOTSUPP;
 		} else {
-			pr_warn_once("soft_limit_in_bytes is deprecated and will be removed. "
-				     "Please report your usecase to linux-mm@kvack.org if you "
-				     "depend on this functionality.\n");
+			pr_warn_once("soft_limit_in_bytes is deprecated and will be removed. Please report your usecase to linux-mm@kvack.org if you depend on this functionality.\n");
 			WRITE_ONCE(memcg->soft_limit, nr_pages);
 			ret = 0;
 		}
@@ -2847,9 +2832,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	pr_warn_once("oom_control is deprecated and will be removed. "
-		     "Please report your usecase to linux-mm-@kvack.org if you "
-		     "depend on this functionality. \n");
+	pr_warn_once("oom_control is deprecated and will be removed. Please report your usecase to linux-mm-@kvack.org if you depend on this functionality.\n");
 
 	/* cannot set to root cgroup and only 0 and 1 are allowed */
 	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
-- 
2.47.0.163.g1226f6d8fa-goog


