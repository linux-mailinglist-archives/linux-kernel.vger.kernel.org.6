Return-Path: <linux-kernel+bounces-291647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DFE95652B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080C81C217EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3515B0E5;
	Mon, 19 Aug 2024 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W244npaE"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A025A41
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054668; cv=none; b=uWAig2X/MiSk5Jp4IgxxtLRNi9m0xfsQBwu7GoK08U+ov1lJGEl4JWCfw5Wft4SHBaohzG6/rzgapcfLZTvoyB+frEC9PdfyNNvj6Of7xgdDjuQG8AydfGx7DA+80bohxtTIeZ/9ys5rEf5N7DAoyHtiZUQyXxpVjNIdL1aEe/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054668; c=relaxed/simple;
	bh=hlQXhSmOrxAM2VM/5ki5m+tINxDUwNIT8Yb4lImdW7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ViNwmNrr+yRXwE3ktl1Q7+z0Mz3Po4fNmFRBWJmabKy62Xu/yNRMAv9tJnGsozLGKG4UJMlMcinLukVHFC0fImBQYjqSP/uvny9C822rX31hb+rJp2bkLoWQbNktdbTB6PecdMWiLm8AC9a2/9A+udjdc+A1WXswlsQbXjz8KaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W244npaE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-710ffaf921fso2569074b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724054665; x=1724659465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5pMgQRu6k6leW3rh4d4vvY0vdZxZHpL/sFft5GJjjc=;
        b=W244npaEMP6BXtvwO3YZJCsCaFOOUU82NI/oSf21LJPdFYQdqFyRfbBMq6M0GgexJO
         Yhr0EjM3UGr7T+sh+ZCmmw6S0iPKG6xuArAoc2qKAZX1XgoSAFga0XdEYyNcFGu7DhL/
         wmCXsdJEITzRkfrt68vN6J0Z4RiZ4l97JuYeJhgNoh0OXT+AQ/+BoWuQHHVbIoxsq6Us
         y41jWi9W57mgnDQAasZP/UqZFWlFYef1rzC3vPQ6QMY0b22rHz6rzEa2JxFMOdIULAYL
         qpHUJyO18v8zcfEQAxcEVHpEp8N9Nz8gMSYBfJAlbcsJV4QHiydZsbdgbifjhvyFu9Q8
         ldWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054665; x=1724659465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5pMgQRu6k6leW3rh4d4vvY0vdZxZHpL/sFft5GJjjc=;
        b=AswAXWrd/wbEbGNEBe3qcgX1kdfyRq1d2AkSaGecPv2pZDFHV7+tANshXzoEdzAYEn
         7Ge6wVcZc0rGX2smohbLqWoq1K4sv2j1845KaN56MHY9WGC/orVOd4hE6jIIuAWhx+Il
         PT6exePzui0zVocLOBSX5twUMLHK29Mhqrp3EVjB85upd2kHkSjPJpTXlGKfUCmbCABh
         pXxlSJY5epdp7ySLSMP7ydNFQmwdE58hv5fiW6Dwxgt9u928+tTNXjrgS9cIcrjcS/JB
         bEmwf+VjWwQmE3lSTsOM2rKc6WQ2FDpDHm+QfjlG47mzMgk5CHm1PzuubWZ0mFg5wcW9
         ko0A==
X-Forwarded-Encrypted: i=1; AJvYcCV5arlxOAmAhORXn0eWIStx/Y6xeoHTXA9mfPua1vcDUJLfd35y2rWgMKLpZGyh6qqf596gT/iMcXYt4t8xevGc5xT0shqUY5JGFIBP
X-Gm-Message-State: AOJu0YzI29uk5XKmBB6ZiwVNGK6L17r+R8MYINEBhKiZqqm0q5L2126u
	M+wd1i/aWdkZYfuFwN2Q+2+c5ECXg3kL1D/GcSYsWeQM56po6nTirbphQ2+Zp50=
X-Google-Smtp-Source: AGHT+IHLfanBTcn2DvSOg+cw6SKdo5DRsRm2SonlABa3P0MXIOz858+YTpfkVL9sUDXKpvUfjPtHTg==
X-Received: by 2002:a05:6a20:158b:b0:1c3:3d23:c325 with SMTP id adf61e73a8af0-1c8f870c61dmr19956646637.24.1724054664643;
        Mon, 19 Aug 2024 01:04:24 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a7672sm7183121a12.4.2024.08.19.01.04.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Aug 2024 01:04:24 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: muchun.song@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com
Subject: [PATCH] mm: kmem: fix split_page_memcg()
Date: Mon, 19 Aug 2024 16:04:15 +0800
Message-Id: <20240819080415.44964-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

split_page_memcg() does not care about the returned memcg for kmem
pages, so folio_memcg_charged() should be used, otherwise obj_cgroup_memcg
will complain about this.

Reported-by: syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e0b3b7ee6de6e..6c84af0a9ede6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3018,12 +3018,11 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 	struct folio *folio = page_folio(head);
-	struct mem_cgroup *memcg = folio_memcg(folio);
 	int i;
 	unsigned int old_nr = 1 << old_order;
 	unsigned int new_nr = 1 << new_order;
 
-	if (mem_cgroup_disabled() || !memcg)
+	if (mem_cgroup_disabled() || !folio_memcg_charged(folio))
 		return;
 
 	for (i = new_nr; i < old_nr; i += new_nr)
@@ -3032,7 +3031,7 @@ void split_page_memcg(struct page *head, int old_order, int new_order)
 	if (folio_memcg_kmem(folio))
 		obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);
 	else
-		css_get_many(&memcg->css, old_nr / new_nr - 1);
+		css_get_many(&folio_memcg(folio)->css, old_nr / new_nr - 1);
 }
 
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
-- 
2.20.1


