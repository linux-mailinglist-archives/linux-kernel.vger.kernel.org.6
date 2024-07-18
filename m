Return-Path: <linux-kernel+bounces-256157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305F79349FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78951F23F94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A83B7D075;
	Thu, 18 Jul 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C2JzCQlH"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8A974E26
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291873; cv=none; b=GBKpJ4LZT6JGt6v9PCQvTsJHR0l+BkrBiBmb4cZwNvEutzoJdmgK8K+3du328HeDvI7u0ckl6m6A2J+OvsUS9nm9OLbcEW79zPducW4QH77JHR4o/mDes7L2a55CXwq+UFXR0dbt1pDQRypS5JxN9+n7y529D3nrriYviTj3ubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291873; c=relaxed/simple;
	bh=JWGUuDAmjCPbUhNmI7o3apoyVx0SvIntUZeoG9Xqf6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SWqTaN2I3Ijtad2tiG8+uBzNzNDtfVOhAVB9aWyLa5TneQJzFCduPi4h/pSIJ1kCYGeYvfA32v3vJQLTOCGFL1kaaep1WADvhOYByo5Rse4xQShz+UkC7p3jDtcQisI1oBpNY2MRf5pHI7/qTn4VfxrIi0ucDcKDzR+2shpFGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C2JzCQlH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fbc09ef46aso4865255ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721291870; x=1721896670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2AnZP4FqCh9/qWbyE+Hky3ezI0Nozss7q4XoUoHApw=;
        b=C2JzCQlHfea4GgJHbEt18CyO6Crod8tv9WRGkAuT/WMZeQYwgMNpf1EIe2fsUW4+Cl
         SLtXU+y1Zp7lL8lwRWwBDuErMcreMRHM1JjpkM/riB78l8IvJ9xi1nv9HGpA0/oSEGTG
         yiyB/m6ZjP8Fwg9GpJL3986StkA0Re056Y1kUI8NeNjkJA4uxptQE+YYqxOVHZg7guGr
         BxRpUNcocpGtxcworRWda8Yjfh9SHAehbvZa7PoJK0N1fCOpB4EjJI18jLglLCB1kWrT
         IvB6hQIXza7B2lE3p9vdooiLavx8fOjr0a7xD55MKRMThnfQoUkDTfEEFdxw4Yd3aRea
         +iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721291870; x=1721896670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2AnZP4FqCh9/qWbyE+Hky3ezI0Nozss7q4XoUoHApw=;
        b=t3BYp2UA2JfUKNwzCwO1SbM8D5av4IemYEsfQQN/XjGqLyxwGSzvIHbHGLcFSFJw7U
         PkC/mKgl6AVV38iYL2LWhQoSVKrtYp+6k+yJhjZSHQZ0+2CUmGrc0VQdbg8DESu2DTEG
         Kq+iVXJ5lKWLxmUfMb4VqA8+Lb7fCGAHlKHTy4J7JaDdQtlLvX4xmSdpuVOwOhkgC3bN
         sq+GoCWi2m4JqRjgQClknUvxl8fudc157Bc3E/4PYav4J9DKDgBSohnV4C62bpXpm2UV
         ysqVZ9QAeA1XfmZht9IgqYp6DikY6BA3/PuTw0asR0tAwKeKGJACVIwa0KjVpXFEi5EG
         o/kA==
X-Forwarded-Encrypted: i=1; AJvYcCW5q6RQDSulyH7adi4sytrb1/eRAynoOkxLnOTYAf59TeleSgDOyOzU8/ZxgFyUpakW0l9R8v3ym47XndOQmFaDm8UqtwnwhvvdreRg
X-Gm-Message-State: AOJu0Yw3ErrHrrlzDennVbros5AmLw51k2PwRkN9+Z2/Xy8mlpgpt8WZ
	bz7/iH1ASelTKeeu8/HQY0UpQHDCWNPDqRGo7fYc8uNGDKT7TRbD4SvvwY20GeA=
X-Google-Smtp-Source: AGHT+IEC0f5u4KW3dI+7gEfPH5gQl0/+SWgpuQgkQEtrW6DcjlYDOVoEHaGaYYEy7RT4WAJEfUf90g==
X-Received: by 2002:a17:903:32c1:b0:1fc:3600:5ce7 with SMTP id d9443c01a7336-1fc4e134b59mr38303345ad.17.1721291869942;
        Thu, 18 Jul 2024 01:37:49 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb70089sm87925435ad.7.2024.07.18.01.37.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jul 2024 01:37:49 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: list_lru: fix UAF for memory cgroup
Date: Thu, 18 Jul 2024 16:36:07 +0800
Message-Id: <20240718083607.42068-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mem_cgroup_from_slab_obj() is supposed to be called under rcu
lock or cgroup_mutex or others which could prevent returned memcg
from being freed. Fix it by adding missing rcu read lock.

Fixes: 0a97c01cd20bb ("list_lru: allow explicit memcg and NUMA node selection)
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 3fd64736bc458..225da0778a3be 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -85,6 +85,7 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
+/* The caller must ensure the memcg lifetime. */
 bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg)
 {
@@ -109,14 +110,20 @@ EXPORT_SYMBOL_GPL(list_lru_add);
 
 bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
 {
+	bool ret;
 	int nid = page_to_nid(virt_to_page(item));
-	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
-		mem_cgroup_from_slab_obj(item) : NULL;
+	struct mem_cgroup *memcg;
 
-	return list_lru_add(lru, item, nid, memcg);
+	rcu_read_lock();
+	memcg = list_lru_memcg_aware(lru) ? mem_cgroup_from_slab_obj(item) : NULL;
+	ret = list_lru_add(lru, item, nid, memcg);
+	rcu_read_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(list_lru_add_obj);
 
+/* The caller must ensure the memcg lifetime. */
 bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg)
 {
@@ -139,11 +146,16 @@ EXPORT_SYMBOL_GPL(list_lru_del);
 
 bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
 {
+	bool ret;
 	int nid = page_to_nid(virt_to_page(item));
-	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
-		mem_cgroup_from_slab_obj(item) : NULL;
+	struct mem_cgroup *memcg;
 
-	return list_lru_del(lru, item, nid, memcg);
+	rcu_read_lock();
+	memcg = list_lru_memcg_aware(lru) ? mem_cgroup_from_slab_obj(item) : NULL;
+	ret = list_lru_del(lru, item, nid, memcg);
+	rcu_read_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(list_lru_del_obj);
 
-- 
2.20.1


