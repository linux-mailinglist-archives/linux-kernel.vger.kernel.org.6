Return-Path: <linux-kernel+bounces-316443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC7396CFA7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02871F23756
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE7191F79;
	Thu,  5 Sep 2024 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kVDlOdB8"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323242C0B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518877; cv=none; b=ETnPqZzcoSb7Ijb8neWasyf7vui4vmjatSYDdkS9JLqruwnm/iZ27czKNsrvKRdt3IAXIUHYI9QGjGYOEYx2sL+24AQnGRg72asO0YclVWCwBNZpp+BLehl2bk6no65XzV7uKJU4qwvXxGklkUyDGxA3m5qEPAWmqFg7qtnOEYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518877; c=relaxed/simple;
	bh=mzKXSqOdgvgkFU4SO2RWR0OAPaZFVb1eDFJtbLVh+ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMWbAfNRy7aFyWqsS0sv+AXPitMT01xg4c87r3qWE10JMxGw3eseuWdEgvLEIVuDmuyRjG0kWMIEY918MgeCM/hkE3CxXj7M0fnAMOMyFs3lasDNQFWSganlt3DuVBL69Ij510+Bzv1bm1TIgGKwN+19uP3pkCeI9gSp5Uhc+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kVDlOdB8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7176645e440so290147b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 23:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725518875; x=1726123675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIhDyqF9M2O2ZjRQd691tori9EsH0IRAbKfkH6ZoQcs=;
        b=kVDlOdB8IksO5VOOdgZaDX44u9oWumRwoHbJQvx6X6OWKPGB+/jn0zxpSws+df2YiM
         B9UpaqDiZVxlKM8cLsP6rk5YatjIsnFim/ye2L7nQOukNCW5/x6zS64ipeZLA43TkzCg
         uXVMo01xxWj8PCWgaj5kQ0tworswTDRNQUrKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725518875; x=1726123675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIhDyqF9M2O2ZjRQd691tori9EsH0IRAbKfkH6ZoQcs=;
        b=iYdkHZ8GSYLQM948BU+KB+yoXbMKVPopE7jR/w5O9ZPot9FmZ5c+w123fkd4JPZdn0
         Cf96tRUxd2nY2HZ1E+oTvp2wnPuoMaMMH3XutABpaOmJtALWu4dLechkqoMZ+/1TYbMO
         UJxDcOPen6v99Kp87Fzui3ZZulgAJNSTYh9ww6e3ftqBPK/Xa+rF51ku1Ih9gCvUXys2
         KY55mI6O/Dh8KanbmxHPUeuEiJ+6O8XHK9oeqaQ5eZ3sdPMVmQEzwEd5ICVxy7Va56Jz
         YDTnOLWO89ueobyhsN8+8b28U5JmBuC89gWOvQgpwRAsw3ARPgnqlofI1D2J/PmNbzn3
         Kw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV80qlf85+3rVQCGOmUi5znSmRRIm7nB6AZUJTg4lYhXpfPFVD+nYHm+MeWQpOx4aeLK2f6o+ozxITjo4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMcH+94NyEOvmlwJObUN8izJdOpuHpdCcI2Gv0akZiquMndi+
	outp8w9GyGh69mYUSFBKkRHSc0Go/en540oQCUWkP26kAFTZSC6+D6/GtsRBdhstyhon3IRmh4j
	dKg==
X-Google-Smtp-Source: AGHT+IEqjRvOmBXN9hJWq8lL6jJY5+QXZ5XSwN6DOK2JdMuzeyss353QZbuBS30FPJ6tDXscqd5zSw==
X-Received: by 2002:aa7:8a05:0:b0:714:2371:7a02 with SMTP id d2e1a72fcca58-7177a92d064mr6843904b3a.5.1725518874686;
        Wed, 04 Sep 2024 23:47:54 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:734f:d85:4585:b52d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778598e1dsm2600224b3a.163.2024.09.04.23.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 23:47:54 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] mm: use unique zsmalloc caches names
Date: Thu,  5 Sep 2024 15:47:23 +0900
Message-ID: <20240905064736.2250735-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each zsmalloc pool maintains several named kmem-caches for
zs_handle-s and  zspage-s.  On a system with multiple zsmalloc
pools and CONFIG_DEBUG_VM this triggers kmem_cache_sanity_check():

  kmem_cache of name 'zspage' already exists
  WARNING: at mm/slab_common.c:108 do_kmem_cache_create_usercopy+0xb5/0x310
  ...

  kmem_cache of name 'zs_handle' already exists
  WARNING: at mm/slab_common.c:108 do_kmem_cache_create_usercopy+0xb5/0x310
  ...

We provide zram device name when init its zsmalloc pool, so we can
use that same name for zsmalloc caches and, hence, create unique
names that can easily be linked to zram device that has created
them.

So instead of having this

cat /proc/slabinfo
slabinfo - version: 2.1
zspage                46     46    ...
zs_handle            128    128    ...
zspage             34270  34270    ...
zs_handle          34816  34816    ...
zspage                 0      0    ...
zs_handle              0      0    ...

We now have this

cat /proc/slabinfo
slabinfo - version: 2.1
zspage-zram2          46     46    ...
zs_handle-zram2      128    128    ...
zspage-zram0       34270  34270    ...
zs_handle-zram0    34816  34816    ...
zspage-zram1           0      0    ...
zs_handle-zram1        0      0    ...

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 73a3ec5b21ad..896ca02ed75a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -293,13 +293,17 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
 
 static int create_cache(struct zs_pool *pool)
 {
-	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
-					0, 0, NULL);
+	char name[32];
+
+	snprintf(name, sizeof(name), "zs_handle-%s", pool->name);
+	pool->handle_cachep = kmem_cache_create(name, ZS_HANDLE_SIZE,
+						0, 0, NULL);
 	if (!pool->handle_cachep)
 		return 1;
 
-	pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
-					0, 0, NULL);
+	snprintf(name, sizeof(name), "zspage-%s", pool->name);
+	pool->zspage_cachep = kmem_cache_create(name, sizeof(struct zspage),
+						0, 0, NULL);
 	if (!pool->zspage_cachep) {
 		kmem_cache_destroy(pool->handle_cachep);
 		pool->handle_cachep = NULL;
-- 
2.46.0.469.g59c65b2a67-goog


