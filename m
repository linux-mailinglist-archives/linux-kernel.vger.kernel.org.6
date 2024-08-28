Return-Path: <linux-kernel+bounces-304101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E2B961A40
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EF8284CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594291D460F;
	Tue, 27 Aug 2024 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZE/MPbO"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151651D4173
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800301; cv=none; b=u6G5kT8gTe0B9MmuDNLoSoBTsm3KLtn+YQ7B7kckpOfrpAgwGPUWznG1zc18Qrntmr8wlglfaU3TodEsyq54dmAUenxcrlgNcyALwbEYOhyRT8gKGLrVDT8ycX5ETzdsrTa+NEVaNvMN10nNBEDLl+D8qMZQxD9PPHQ88CiYaBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800301; c=relaxed/simple;
	bh=pmnA98OHlkAk1b+OhNUeP4JA8KFIHmpFHK8wxlWLNA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HqULM0js4Owp8jX6LvMYLyfBzCjap+WjI135haLxmPziviBz3tQfEijMDbKAe7VuoYl1ptw1k4Og73+5C2+SLCJX9JvvfUCexMxwNDiQ1L6vd6tmG7sphEiM9Ynfk6W3tlrWoIs8DfWDfNkPG5w2RMnoVxU1ytTAuGwEnlcgsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZE/MPbO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7d1fe1dd173so2448161a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724800299; x=1725405099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLJnrvY/TNbJZgveXjXzKwi1waLm2OswD6XrKXtY0Dg=;
        b=VZE/MPbOss8wfDj3UEJ1b8YUikmnFZXldSQhRVU5t9KPHd5waNUCQtyGM6icJJqprn
         JTpcqQGM0F1K/xuxquTCJZ1no81EIhckSNloyIiq5SQenw0TV4JOkfIqcYTQsfkm1Dc4
         uWyr/YAUd52cNyKCYb3qk/9tCXXn27s9mTKy7BKFIloYdbJIgejSybW7Ue8mxCDA/Tfb
         Z7PK5zJMEyqGNKURrGVsVvGoGlZXZ/ncqGqJcs0lFxS+b1M0m3LgT3tzVg2nMRTuCk9J
         p0D5TfF+hAZokcGQAeh/V8IzjfEgE/+bPAvPDl50jKyS+jbTI5FXdv4esX+PN3NHd2CF
         vUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800299; x=1725405099;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uLJnrvY/TNbJZgveXjXzKwi1waLm2OswD6XrKXtY0Dg=;
        b=v95gXL6g7Mez+UbeamyjhKTHUQBu2tYP/SY1HrE0BsMTCr57ilwHe68h6PjAaC44tY
         +PPhVbLN4KNFuymUHjz7go89s7KOfRqH69dTyJaWvP79l/oNlIhu0+9XCS/2ot1awM75
         6im3wbeLK8ogpaeERlgqutmKb6pND0hcj6xNK5YYpBH5lZB9ePl4/wmevdK+9uHCIT8M
         kU24oWiY8Pvb0EFIMIE7e1mYNaOm0NUC7RRfeOmxFR8sfGgQY7dTosC5HALHSR4iSkZT
         ldALLaLFl6ElO5PUHdlA+ce4siQCzQJ9iDUvwcttoeG48XVJEU6YE+tRxaNylp4PICbb
         nHDw==
X-Forwarded-Encrypted: i=1; AJvYcCVgOsBmwVpFr8C/USTame1PYLgcTYo8jHhy6ON1rNGR7HMSJGHlITn4j+bFzFYzdo1Tf83DRCHs411R0OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9gBxraAsuCb87sHyvqA6vCsRvmwBJPUVBc2ETbJfd4oJJNUs
	eQR+MXrh32l8qA6Yfsm3YxQNm9a48L1YjZOQMnTHDy3bnQ3fegohBWijO+W8fw9IujpPmQlFosR
	2Py6di8ovOQ==
X-Google-Smtp-Source: AGHT+IEokv9e6LuULnuwid4WZdlPlarG8J+pXfvpDb7CgbDsiCb9RtBxcqB82FKfSIIge11nvt7XccQqszzV4Q==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6a02:5aa:b0:6e7:95d3:b35c with SMTP
 id 41be03b00d2f7-7d2228eb22fmr302a12.5.1724800299140; Tue, 27 Aug 2024
 16:11:39 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:07:38 +0000
In-Reply-To: <20240827230753.2073580-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827230753.2073580-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v3 1/5] cgroup: clarify css sibling linkage is
 protected by cgroup_mutex or RCU
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
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
2.46.0.295.g3b9ea8a38a-goog


