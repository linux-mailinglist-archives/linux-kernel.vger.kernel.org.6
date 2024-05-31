Return-Path: <linux-kernel+bounces-197472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 933078D6B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD751F2891F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C146446A5;
	Fri, 31 May 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+YZr2bl"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC178269
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188836; cv=none; b=b4ROjiry+0n1+hmmRMfVWLIyprd88CGLnNlB4iYFJzO2yvkyIhZSp4ASUzN3+OP560YjBjdXjs56zK5m24wOkJRnyiuJsPaj8TImVjYER4xt3o0ICeSOgnxB3p8Ojk/fQYAf63jEwZp52JoX4Ji8k68abe76J6LozxtgAiSBPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188836; c=relaxed/simple;
	bh=C6PXGr+AZPUn1H/wm9hTI+jmjinV6q5QhqWIqVwXGaw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RjqQA/EKP1rxII10kjQ6DNpuHPW+Cr1HG5Ai7DBM7pZWbNMge11tkmscZE0e4O9RwCkmjDjNx3M4TsJDzFk/jMfMh5C97BHcAP4pMVY4kntiMdY1I1j0vJgw2LgqmJV6FPVjlGZ9rkU0NiJwYlk/ZIlZE4k64AEWsLgMWfyH8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+YZr2bl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a248f46aaso38335957b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717188834; x=1717793634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dR/I60iKvQtYFc+Ix4QkX6HdwceIps2qkQq8Wc4ness=;
        b=r+YZr2blbeuJ1Fz2NT0f3F+o6wmz6067o3x+hGJ5mKmdknv1du4fzNOy5PaH7r8q8u
         9UoVBkLgAulnC+nJl9xLnw7Y1SeqzETGTuClnKgVHVgpTz+0/DR+escJeLvn+khaatL2
         ItC+rFpdU0WGhRz3ut51+XZwlDsIjEzAX1TVEQJAwW6fcGongK5OUWHj5cexrFjeNjwZ
         NGvR+ca2lkf0yF0YncqQ+mxRT/bfnOVnG+brQV5VBJ+YiK/fcLZYcKBxZ6tgts3TjeJX
         a9zCZv8QqtZ4D2VJI1EVZDX/YcQwifBrFrdRFG/Yg0/7OVB9PjOaQXJRlno8s7lGFxhi
         +QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717188834; x=1717793634;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dR/I60iKvQtYFc+Ix4QkX6HdwceIps2qkQq8Wc4ness=;
        b=O5JJrhe8mPgOF0jB4czzt5QKuoJGZqCsxnGdaHo8P3XdwaLHAuKk0zpiC8HO73vQSE
         ApTzi/vaGdycvCiBoYzL9HGh/E9wISx4tUk7Op6n4Re6Nw4R/aYhuKV74n4V1qKI0A6H
         JwlXkQv3MFE1hN2KrCHviOzy/2gKY2tZvih1SisAocjFkkx9LVSKw8GNCxaVgiBuDjo+
         lgMINN0gYVQiYJWqix6e/h3epynEl7up0y+96FJguYTwfY3l6bXyi9777k8T5Xi/sS4n
         46B4eZJfvjrUdLfw4sTCJm7gsSxOh33Zsjm1pHxmZaqEjC++VngFzhXWuCtwTgEh1Gtv
         zQtw==
X-Forwarded-Encrypted: i=1; AJvYcCXBWbPfY6eFjjgGd54LIbeFbTebyixZ9GFwjuZqlPdjHicyyPndo1M/MiBHugq9iyzVcL49hizmbBOlb1Ahw/BpKWza1m6HwqnUGSwT
X-Gm-Message-State: AOJu0YwG9RmSf4a8XT/bH/v/TVlKF376hLeo6wZ5KZq2hk7Yg4tES4al
	E2NiTQFnv3+txpqBR5xzcZ97Alk6yfdRtQhIQDGSg2uUGHHJZH05MJGM5pcBc9DO/uzKC0TBG3v
	p3Q==
X-Google-Smtp-Source: AGHT+IE30DEKE1FmkDHyXVEgb18pk8hQIQZ3jjidV9bnSpPgD31orrHx3Ag9gA6JiXHe4ejfE1LRp0NQL5E=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3bc3:51e0:49a8:3695])
 (user=surenb job=sendgmr) by 2002:a05:690c:95:b0:627:a671:8805 with SMTP id
 00721157ae682-62c796f106dmr7653617b3.3.1717188834102; Fri, 31 May 2024
 13:53:54 -0700 (PDT)
Date: Fri, 31 May 2024 13:53:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531205350.3973009-1-surenb@google.com>
Subject: [PATCH 1/1] mm: fix xyz_noprof functions calling profiled functions
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

Grepping /proc/allocinfo for "noprof" reveals several xyz_noprof functions,
which means internally they are calling profiled functions. This should
never happen as such calls move allocation charge from a higher level
location where it should be accounted for into these lower level helpers.
Fix this by replacing profiled function calls with noprof ones.

Fixes: b951aaff5035 ("mm: enable page allocation tagging")
Fixes: e26d8769da6d ("mempool: hook up to memory allocation profiling")
Fixes: 88ae5fb755b0 ("mm: vmalloc: enable memory allocation profiling")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/filemap.c |  2 +-
 mm/mempool.c |  2 +-
 mm/util.c    | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9fe5c02ae92e..37061aafd191 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1000,7 +1000,7 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 		do {
 			cpuset_mems_cookie = read_mems_allowed_begin();
 			n = cpuset_mem_spread_node();
-			folio = __folio_alloc_node(gfp, order, n);
+			folio = __folio_alloc_node_noprof(gfp, order, n);
 		} while (!folio && read_mems_allowed_retry(cpuset_mems_cookie));
 
 		return folio;
diff --git a/mm/mempool.c b/mm/mempool.c
index 6ece63a00acf..3223337135d0 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -273,7 +273,7 @@ mempool_t *mempool_create_node_noprof(int min_nr, mempool_alloc_t *alloc_fn,
 {
 	mempool_t *pool;
 
-	pool = kzalloc_node(sizeof(*pool), gfp_mask, node_id);
+	pool = kmalloc_node_noprof(sizeof(*pool), gfp_mask | __GFP_ZERO, node_id);
 	if (!pool)
 		return NULL;
 
diff --git a/mm/util.c b/mm/util.c
index c9e519e6811f..6c3e6710e4de 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -705,7 +705,7 @@ void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flag
 
 	if (oldsize >= newsize)
 		return (void *)p;
-	newp = kvmalloc(newsize, flags);
+	newp = kvmalloc_noprof(newsize, flags);
 	if (!newp)
 		return NULL;
 	memcpy(newp, p, oldsize);
@@ -726,7 +726,7 @@ void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
 
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
-	return __vmalloc(bytes, flags);
+	return __vmalloc_noprof(bytes, flags);
 }
 EXPORT_SYMBOL(__vmalloc_array_noprof);
 
@@ -737,7 +737,7 @@ EXPORT_SYMBOL(__vmalloc_array_noprof);
  */
 void *vmalloc_array_noprof(size_t n, size_t size)
 {
-	return __vmalloc_array(n, size, GFP_KERNEL);
+	return __vmalloc_array_noprof(n, size, GFP_KERNEL);
 }
 EXPORT_SYMBOL(vmalloc_array_noprof);
 
@@ -749,7 +749,7 @@ EXPORT_SYMBOL(vmalloc_array_noprof);
  */
 void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags)
 {
-	return __vmalloc_array(n, size, flags | __GFP_ZERO);
+	return __vmalloc_array_noprof(n, size, flags | __GFP_ZERO);
 }
 EXPORT_SYMBOL(__vcalloc_noprof);
 
@@ -760,7 +760,7 @@ EXPORT_SYMBOL(__vcalloc_noprof);
  */
 void *vcalloc_noprof(size_t n, size_t size)
 {
-	return __vmalloc_array(n, size, GFP_KERNEL | __GFP_ZERO);
+	return __vmalloc_array_noprof(n, size, GFP_KERNEL | __GFP_ZERO);
 }
 EXPORT_SYMBOL(vcalloc_noprof);
 

base-commit: 8e06d6b9274dc504af6021a8bbc2daf6713ceb20
-- 
2.45.1.288.g0e0cd299f1-goog


