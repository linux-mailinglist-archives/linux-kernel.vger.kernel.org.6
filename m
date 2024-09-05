Return-Path: <linux-kernel+bounces-316144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C93596CBC5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906551C21DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66D946F;
	Thu,  5 Sep 2024 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHAAEmpM"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D384C83
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496311; cv=none; b=SaU0+wAZnXwkaLUh55KmuHm7DihNB2GzP9UGj3sVzxU1ArIGSXKb/TkgEvxpog4ogWxtTdD5t86S6eayNXX/QuWtER+aUQCdYiafw0j0gCqj21ZQZYVWhDGPYLLigyf1MqD0fpaoIJM2yaL5Nh1Ijaxtu995sE90LXQ6Z4RWgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496311; c=relaxed/simple;
	bh=Lx4+ZLTwtckuXYhwvmNIbZVz3klX1ad8ibwPx6HLoxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CTxCin8tkLSwzOKuUe5GUSXIqw4KsqEanDiCokovPpArnf8q88ibe9bpAWbyebVkx/HvssKXhjFIKVWzIDfXz/6y75muTfipieOieGfQxZLxgYg9FbjfsMzkFudSC31vQIBSO0IDKn1aacdKJkxmIb04NPlOLJ82NRBfzAjxmQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHAAEmpM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7143d66b510so189656b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725496308; x=1726101108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCIYE2bxjzqInsqy6M77OBXOLSiNi2ahaVS1P1UY4eQ=;
        b=tHAAEmpM8iACFaPoO36jgqLHqxQCsNM/xco0SOS5V2CbUSySLdrEyFPpwdQ8v4ecX5
         Y3khsfalPyNPLLj1d//pG68p3InRyPIyBY0fZzRJvKZPoqe8WsESVK3qDhOTpX2SgckS
         NA3tqlJtqbdCWKxH3bfoad0p+zRVyrmRpfn959No3FOdLSK/8LnFsXwmBjiHRHdEz/TE
         tWZcXCwUQ1OO+SvkJVpa6tzeS/uhsdqcdqyLKvYddGofZAEnezANYisd6yXQHsEqwzOk
         A8SSO0ccIBDM28kMiu2EqqakAzO+HHQo3IiBvS3kuDHUneKeh0Z6IpzHRLTpCp1rRb6O
         4TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496308; x=1726101108;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OCIYE2bxjzqInsqy6M77OBXOLSiNi2ahaVS1P1UY4eQ=;
        b=c3NAsWkdqAPKtAc2gOxC9cChf5HUIfP1SL15f/OmGWDEqQX1LIhzvB8Oilu3tD1DwR
         WQ+hCW1xkK7n9swznuiyNW8NhiaSggYEalpCMZ3E8Fyz3RcMU1vxqpUF+RUWihr7FCqw
         mUsrKJCFEANfmpNiSjDyev1BGnYWX1hf3H4rOfB4VX6yLXJH9BNulNNa92fWb4QPhXcm
         AIFt9n6FXMcJ4xwng8QmkJg7F5eNJS/oMPO0W6gRZYGI0WuhL6Kgq1sJ05BeVYL3SGzV
         LF9wITUPGJaKEQHH/zmsVWTsaWqSdz47OkXWCPgXSRRh6HxPO7oAOCH+QzDqzemIVvrb
         n2jg==
X-Forwarded-Encrypted: i=1; AJvYcCVxMUIIwUFMW2NeBSvhzVIzc1oyA08+DRIv4pYbrVG/Pz9kG0BaL4Fn68laE4MwDcyBXqpRzhG9kq6Aq/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLy5KE1oCz+yzL4OxyMN1jHtvlsPF0ZN2xM3zGofRHRBjqbcE
	dyYUlN6mEyMl1C9wxc2m0wA7zIDTW29kvInj78ncZ85MZNb8j9aRVzImn5hpfgAUUoN4uCBS79y
	VFn1A45u8Ug==
X-Google-Smtp-Source: AGHT+IHUPQSbmeHjhZigLeW58QOY18ICrs203NRPh39wz9VYTS5JC1PdHx3HOB6u+ncLsUa1QDiBpyCBj6pKLQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6a00:8682:b0:714:1e0f:4477 with SMTP
 id d2e1a72fcca58-71730791c72mr43937b3a.5.1725496307872; Wed, 04 Sep 2024
 17:31:47 -0700 (PDT)
Date: Thu,  5 Sep 2024 00:30:50 +0000
In-Reply-To: <20240905003058.1859929-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905003058.1859929-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905003058.1859929-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 1/5] cgroup: clarify css sibling linkage is
 protected by cgroup_mutex or RCU
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

Explicitly document that css sibling/descendant linkage is protected by
cgroup_mutex or RCU. Also, document in css_next_descendant_pre() and
similar functions that it isn't necessary to hold a ref on @pos.

The following changes in this patchset rely on this clarification
for simplification in memcg iteration code.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Kinsey Ho <kinseyho@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: T.J. Mercier <tjmercier@google.com>
---
 include/linux/cgroup-defs.h |  6 +++++-
 kernel/cgroup/cgroup.c      | 16 +++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 7fc2d0195f56..ca7e912b8355 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -172,7 +172,11 @@ struct cgroup_subsys_state {
 	/* reference count - access via css_[try]get() and css_put() */
 	struct percpu_ref refcnt;
=20
-	/* siblings list anchored at the parent's ->children */
+	/*
+	 * siblings list anchored at the parent's ->children
+	 *
+	 * linkage is protected by cgroup_mutex or RCU
+	 */
 	struct list_head sibling;
 	struct list_head children;
=20
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 0a97cb2ef124..ece2316e2bca 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4602,8 +4602,9 @@ struct cgroup_subsys_state *css_next_child(struct cgr=
oup_subsys_state *pos,
  *
  * While this function requires cgroup_mutex or RCU read locking, it
  * doesn't require the whole traversal to be contained in a single critica=
l
- * section.  This function will return the correct next descendant as long
- * as both @pos and @root are accessible and @pos is a descendant of @root=
.
+ * section. Additionally, it isn't necessary to hold onto a reference to @=
pos.
+ * This function will return the correct next descendant as long as both @=
pos
+ * and @root are accessible and @pos is a descendant of @root.
  *
  * If a subsystem synchronizes ->css_online() and the start of iteration, =
a
  * css which finished ->css_online() is guaranteed to be visible in the
@@ -4651,8 +4652,9 @@ EXPORT_SYMBOL_GPL(css_next_descendant_pre);
  *
  * While this function requires cgroup_mutex or RCU read locking, it
  * doesn't require the whole traversal to be contained in a single critica=
l
- * section.  This function will return the correct rightmost descendant as
- * long as @pos is accessible.
+ * section. Additionally, it isn't necessary to hold onto a reference to @=
pos.
+ * This function will return the correct rightmost descendant as long as @=
pos
+ * is accessible.
  */
 struct cgroup_subsys_state *
 css_rightmost_descendant(struct cgroup_subsys_state *pos)
@@ -4696,9 +4698,9 @@ css_leftmost_descendant(struct cgroup_subsys_state *p=
os)
  *
  * While this function requires cgroup_mutex or RCU read locking, it
  * doesn't require the whole traversal to be contained in a single critica=
l
- * section.  This function will return the correct next descendant as long
- * as both @pos and @cgroup are accessible and @pos is a descendant of
- * @cgroup.
+ * section. Additionally, it isn't necessary to hold onto a reference to @=
pos.
+ * This function will return the correct next descendant as long as both @=
pos
+ * and @cgroup are accessible and @pos is a descendant of @cgroup.
  *
  * If a subsystem synchronizes ->css_online() and the start of iteration, =
a
  * css which finished ->css_online() is guaranteed to be visible in the
--=20
2.46.0.469.g59c65b2a67-goog


