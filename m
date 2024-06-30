Return-Path: <linux-kernel+bounces-235097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0191D025
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32E82820BE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 06:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9FE38DD8;
	Sun, 30 Jun 2024 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiwyYisR"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A3381C6
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719728551; cv=none; b=ubD8iE/KHxLpM4XADs1l7RV3MntZWJ0wLehrB+ZaQDqAtudWx5y/z6SFdvKWu2lSKl2eRHAR/FgR3aXOz825JUUpLd2SKWCgXq2Iy/zCiOhEu80lll8gmBLEICEVRvblEhXZbTX9hFY0f36KvWuNO1gc034888Dwn99Hi99iiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719728551; c=relaxed/simple;
	bh=E0/2Zsw/c3s8rO3qytPM+N3zUeGD1TOzOjOzFQdDGJI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SUQSY8gtepRF3kps6A/6rny42isnXybdfVmzRk2uIU+NFSGtUD9/yID1TXkn1/1nXrlaPJpveAp+RivpMhYWP3cWEngp5ECN6GhvF8eu3X6F1fGIMNYDqColx3ol3S1oU+hSH15WMFcKsYYkVmdB7zRqn9V4z/glS58e2wz921Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiwyYisR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6fe617966fso151313866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 23:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719728548; x=1720333348; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP1tqki2OQjE7qLc7XHFfJ+XmmeA2L8B/vYI13zeoos=;
        b=QiwyYisRQnQsutS7aVxqTtoPtdiQ9XpaGI66vgdZns2Exim76yzoYIFN7d0x7uF6Kg
         mELM5iy2giwx1jLP5OuQmk0lXkLacJtd4Dn/Cgwhl640BYUt9hsWjV+s/FYzyWDH7uNB
         W78twgcu8TqqxrJCP3lOQKr4dhSOxWciEgEvg2zqNehsz3tLoACwLChi12g6yjqGfaJS
         6nd69qQMjmbBhdM2CVsssdcZqv+EEgc5HtCPfuKvITAJVhLcDuaPCdIHCdQ3dlhRpgTz
         ZznjHhFyvlDqJlOOxBQIpu2aMWf79p2gvR0IoAYHHA3t4QK13lAQhHPNsfxMkVrE6CPo
         Vd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719728548; x=1720333348;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WP1tqki2OQjE7qLc7XHFfJ+XmmeA2L8B/vYI13zeoos=;
        b=NiaVlkr5CRlLx7NXg7yrlZeAz5SvPbPvZMcyuPanomP2EEdHAiEjTP15jd8I/a9qEb
         +toGsUbVHnzh7aGAIEeU79retuHIFrWyl08Ubke4EYM/BkSG9GcxFauVwEKoZo0hnPZd
         LcGpkJPwCP+iPJBH7KumDQO8dP4MexuUFuV2NHZ/XksPpXnbi+Q3/Zmx7bXtjqk5t/DK
         iSoVadNQfb7qKFYYYmBrplsmz5vn/vukN3UOhXViPhIa+XQ+gAVIRydF2uecdEGU/UZs
         ynwEMtEab5XCC74QhWghr9H7b0ce8iOlSWgvhD7CoRsmkghW5u4XfKGSqFza/dKBZDgq
         D7jA==
X-Gm-Message-State: AOJu0YzRxvX+SrQxhu9BvFZbU6W1sufOSpHAhKRjgPMaxA0lo8qgy7ZT
	gV4pgG4dQjLQ0cOb3Apa3BlX6O+W56VW+8Ik4B08t+MS18YeAeaa
X-Google-Smtp-Source: AGHT+IGQpuy0srm2hPHC/45iTm73CM1fBq99K/JibHnZZ0sQYw802l5cqHY5qLgUdTMPs9C06I8AVg==
X-Received: by 2002:a17:906:6b85:b0:a6f:5165:fedd with SMTP id a640c23a62f3a-a7514498c75mr129453266b.40.1719728547770;
        Sat, 29 Jun 2024 23:22:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf63390sm216577966b.69.2024.06.29.23.22.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Jun 2024 23:22:27 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	tandersen@netflix.com
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH] kernel/fork.c: get totalram_pages from memblock to calculate max_threads
Date: Sun, 30 Jun 2024 06:22:14 +0000
Message-Id: <20240630062214.31707-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Since we plan to move the accounting into __free_pages_core(),
totalram_pages may not represent the total usable pages on system
at this point when defer_init is enabled.

Instead we can get the total usable pages from memblock directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport (IBM) <rppt@kernel.org>
CC: David Hildenbrand <david@redhat.com>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..eb2b5f96aa61 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -44,6 +44,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/memblock.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -999,7 +1000,7 @@ void __init __weak arch_task_cache_init(void) { }
 static void set_max_threads(unsigned int max_threads_suggested)
 {
 	u64 threads;
-	unsigned long nr_pages = totalram_pages();
+	unsigned long nr_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
 
 	/*
 	 * The number of threads shall be limited such that the thread
-- 
2.34.1


