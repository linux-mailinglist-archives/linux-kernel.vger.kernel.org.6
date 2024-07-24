Return-Path: <linux-kernel+bounces-260853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B1293AF66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DD11F21335
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63D152E12;
	Wed, 24 Jul 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Cy9f4KBp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A315252B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814805; cv=none; b=JuNPBk5PPcL9RyPVTK8k4j+JOuYB7FIKAJ4DGw54+q3Q/PiZVPgEc9g+50zvmhZN/6/DnYlIX+9HhdTuw3nuVqQY9TB3/CBNIdR2MxZSReH5B66zxNzrofVO5MFQk5SWPJMN9r8pXCvtrMLR3cLYG4yn07ajaDhk22GdUQvXItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814805; c=relaxed/simple;
	bh=+2sIhdpfQYCNtz090jbEOfXX066AW8OJGfzVGgws3Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kpDa5eWuUkDprFsO3TLKyDmJtFxUEkbFLUZyRlPT07luKeUCJe4FZ/SZQCIbBqKZQbAG6kshlkaxcWgynvBeoBOouS1pfpyNrABkQvGHOqBx7q9MjO0UmFWAePXsY9zC9s21uUcaebvL2X7OyHzwdKQeTrR4YITI6yklMbX1QXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Cy9f4KBp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc491f9b55so15419605ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721814802; x=1722419602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Pi9ykJgDXDaJ4tze/4eRzB5JgzMNRwhMMIIYD9f6s=;
        b=Cy9f4KBpS2OddEBMoDdcR3OcBkNebJ7CsxZsMX0K/zSLt9pDHnstz0hMz7Ag2dh9O2
         hwHmqdsXKghMm4QSSaW4IuuAm5c2JH3ErxpAICZdKzz8d6id1WldG4nyK3p80QbYW1Vq
         BYsG2nxVfohjuoUR5gR4T7A1et5k4glK3qEdkOl26mcmlkc5MsWOdEawcl/sYZMtgMBW
         292RbTrBNNTiDNMiDO0RHnYXaD11DHb2+C6zD6z2GTRtFBEY70DopTmg3TlTZS3BWzwd
         CC40aGMHNHR/qopqgxZQUhxlxvTBXLtGgG2ErPMQfKv8DhdBkoecVuSuQpBQfXspZJZs
         w8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721814802; x=1722419602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+Pi9ykJgDXDaJ4tze/4eRzB5JgzMNRwhMMIIYD9f6s=;
        b=JBNtFP1T+nmubh12AcKfnpFeLEq0LW7goZu/2uy1cNAnaOVHm2WCbRTzimr+KPtc4Q
         ULl7cLDiPSN/NhTR3bfZbFfZXJhEi9I4HNjZAEZXn6XLH8rknzrkORfmtnZlrEVrPbBt
         InXxfyM8GpZg+55FM3UAOUYNLRNmgG2H9Y1MjGDL/pQ2U2MgKWq+bzqza6XEiIrEi4el
         iGTduLx4MqQroyvg1lSuHL0Iwjr9fx4qK1D/wwNC3fm3LIr8Emk3nZZVMI0oF1rH8xlu
         6iImP4B2QPIKbGsWEOrw/zxu5X0V+kkFFVtpk3mMKZTX3Cbb8y8M+9drwkmwRmOk7pd7
         B4pw==
X-Forwarded-Encrypted: i=1; AJvYcCVrx+nF2F5ahJjGoUfsX571L3hm6qRu64LqQduYatqK+w+LEoODDn58xrQVldRfDgCjfUaXXlQVwQhKimINNP7APO1fPg8JlHO1NhD6
X-Gm-Message-State: AOJu0Yxoetwk7vlL8YE5yitYNhPkf0rp/Ot/5gWVsESJNB2dxl2luBL8
	8T1b5VhitNMJv4yE6Y8kw2OjLF0U2yDTZhObmSBiYsyFQjD2ujWiizuNIbt9ohE=
X-Google-Smtp-Source: AGHT+IHB3WwwOeRp8JWZP344FPZEZNd311bvbABQQU0UAKM6DV8pqhPHlbDVM2DQMrU5wlZOgwxKpQ==
X-Received: by 2002:a17:903:645:b0:1fd:6766:684f with SMTP id d9443c01a7336-1fdd216e7b5mr19969225ad.31.1721814802424;
        Wed, 24 Jul 2024 02:53:22 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25b3a7sm90232325ad.60.2024.07.24.02.53.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jul 2024 02:53:21 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Date: Wed, 24 Jul 2024 17:53:07 +0800
Message-Id: <20240724095307.81264-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The obj_cgroup_memcg() is supposed to safe to prevent the returned
memory cgroup from being freed only when the caller is holding the
rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
ignore thoes conditions when users call some upper APIs which call
obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
the link below). So it is better to add lockdep assertion to
obj_cgroup_memcg() to find those issues ASAP.

Because there is no user of obj_cgroup_memcg() holding objcg_lock
to make the returned memory cgroup safe, do not add objcg_lock
assertion (We should export objcg_lock if we really want to do).
Additionally, this is some internal implementation detail of memcg
and should not be accessible outside memcg code.

Some users like __mem_cgroup_uncharge() do not care the lifetime
of the returned memory cgroup, which just want to know if the
folio is charged to a memory cgroup, therefore, they do not need
to hold the needed locks. In which case, introduce a new helper
folio_memcg_charged() to do this. Compare it to folio_memcg(), it
could eliminate a memory access of objcg->memcg for kmem, actually,
a really small gain.

Link: https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
 - Remove mention of objcg_lock in obj_cgroup_memcg()(Shakeel Butt).

 include/linux/memcontrol.h | 20 +++++++++++++++++---
 mm/memcontrol.c            |  6 +++---
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fc94879db4dff..742351945f683 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -360,11 +360,11 @@ static inline bool folio_memcg_kmem(struct folio *folio);
  * After the initialization objcg->memcg is always pointing at
  * a valid memcg, but can be atomically swapped to the parent memcg.
  *
- * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
+ * The caller must ensure that the returned memcg won't be released.
  */
 static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 {
+	WARN_ON_ONCE(!rcu_read_lock_held() && !lockdep_is_held(&cgroup_mutex));
 	return READ_ONCE(objcg->memcg);
 }
 
@@ -438,6 +438,19 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 	return __folio_memcg(folio);
 }
 
+/*
+ * folio_memcg_charged - If a folio is charged to a memory cgroup.
+ * @folio: Pointer to the folio.
+ *
+ * Returns true if folio is charged to a memory cgroup, otherwise returns false.
+ */
+static inline bool folio_memcg_charged(struct folio *folio)
+{
+	if (folio_memcg_kmem(folio))
+		return __folio_objcg(folio) != NULL;
+	return __folio_memcg(folio) != NULL;
+}
+
 /**
  * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
  * @folio: Pointer to the folio.
@@ -454,7 +467,6 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (memcg_data & MEMCG_DATA_KMEM) {
 		struct obj_cgroup *objcg;
@@ -463,6 +475,8 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 		return obj_cgroup_memcg(objcg);
 	}
 
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
 	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 622d4544edd24..3da0284573857 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2366,7 +2366,7 @@ void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
-	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
+	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
 	/*
 	 * Any of the following ensures page's memcg stability:
 	 *
@@ -4617,7 +4617,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
 	struct uncharge_gather ug;
 
 	/* Don't touch folio->lru of any random page, pre-check: */
-	if (!folio_memcg(folio))
+	if (!folio_memcg_charged(folio))
 		return;
 
 	uncharge_gather_clear(&ug);
@@ -4662,7 +4662,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 		return;
 
 	/* Page cache replacement: new folio already charged? */
-	if (folio_memcg(new))
+	if (folio_memcg_charged(new))
 		return;
 
 	memcg = folio_memcg(old);
-- 
2.20.1


