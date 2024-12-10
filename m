Return-Path: <linux-kernel+bounces-440343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2D9EBBF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDE4167E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCE237A59;
	Tue, 10 Dec 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PFAhwcXE"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9623978C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866699; cv=none; b=XKekTvgqzvmozf+qH7vcwUBchPGAhhleAlEym0wkXmAyS+LBlrSRuEMssJn9CUJwSKyjqo04r/RG32eqg6CZqD8X5o6Dpg0yo4aWZxJogjtPZCskJOnUtiGkv+7TPwIMjHYOJlxys3lBMr5w+vP3p7lTh8Yz08djSTHavG+p5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866699; c=relaxed/simple;
	bh=tYVwqyB74v30wxub/2XwQXi7EDQ2PRrHyv5WyH8ynQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USHE92pWJnPZayLuPWIdKcuLd6LIt8jtdC5ZE32QTK8t9P2/0WOlvBk1lbLB38kErFsZyeJusKzmX/Z3HQl5VQ1TVdma7dRYlE5xyGc4s6WGgrCATQzhFo0bgcgU5t0leP7dvv/JDvheHnmFHnz1Qu8mBmeBAjfW9uUng0C242s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PFAhwcXE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46779ae3139so10392791cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733866696; x=1734471496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jq0f3dJTpHJXJDokS6aQHyPKu/LFNDC+TZCLMRgrQ0=;
        b=PFAhwcXEhQxXFFgBa0kvrfu6L6MzOX/zNZNHJhGOh8DzE38tI+/rb4JV/RaYOep9lC
         fH81H1nZM7BoJSXcBwmW8md3bj71wU9UlAmBjDY8XPOm8zVuylc6/9dGzz6eXlvndlYv
         CbFsKMqgo/DUXHYx1khyJe6ZAB3AudT252F126X3qskdNdUOvaEl6I75wj6LmvoggAi3
         t9YjE5vCvoVkkMW6FPlR10bj/pyPnxldoavYFxL7ReOuHn3SwjP8zYRBbIvviJrfhWFQ
         6vQQ044F1OFuMunoiKkrZj+XHpm2AG6lUXyU8vTDTc8fzkQtPQqIPPK8tYjLrsz2E30A
         RYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866696; x=1734471496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Jq0f3dJTpHJXJDokS6aQHyPKu/LFNDC+TZCLMRgrQ0=;
        b=GbtF6haFNHJKXdB7FKorX+CHxkhe710yFmiJZ6a8RHnHemvcAza3ZfLXbP4GG/8H3q
         H2bs8VM8GLyhYkhmshIx1w7Xii4xA9C45Kp65hARjAsLM6SeuRrF5Y7UQx0sHpGVzkvv
         9HBxYK6h0xx1Hrahok/hVNDToaGOMsOL+HCGEgTu4RUaNIZSlYOXkSBmmkFtdx5XxOuL
         1O3PM2X9FtYsLqEeliXHAviXZkIrKIPhGhPLULW5Ua6U6oeXAUzEs8NOeAp3Y6zztbhk
         Hi4b8kJFFkuAxG5MuuFeYlJu1ORxA3WiAWCwXrhhJMYXyQrJ9LGVnU7lYgeyqy1MwjyV
         xPrw==
X-Gm-Message-State: AOJu0YyizqyR1BL0g0HxBwnxGklypUf5prAx+mt5usKSHmPiwC3FVGyg
	z2elpCDhZzne3zi8K66tU+ZWcWkuPzQk4XwtKFe323BT1hXdlUV4HJWMv/xq0N4=
X-Gm-Gg: ASbGncvbxLCAO5R3HVQk8zjJU4uPHWIoDFCTfHCMYsD/ESewyU+yAPjsPTd0LzcK3ro
	uWSD5Ip/vU+DZyu1/UnJxk3JRez6UZmjFjCk2qIcDpOPjwkQJMZ7afo7tEB9nxT1g/BBcrD/Fv6
	BpluREoQGiLLOUhGTmYyNyxfs7/SYqd0Z2MzMh9B8RreKwlBfaipE6adhJu08uQcy2fj2Ea14Ub
	ZeQqyHGVOmP+XRMfoj9jhVhc5zpl4DZAMiR1Fq+3xDumR5ux71QkDEjAt/1o+f0E1rjGB+woP2T
	NeE3YwgXVa64OJ004x4fqd6vzuIFqtcvKKDeZbY=
X-Google-Smtp-Source: AGHT+IHxInG7lq5H3xVJww7rlvFoTxqlg+CA0d/WG83+KpCA77jzrX+fsIGQc0RjdUSsv/+VccPkKg==
X-Received: by 2002:a05:622a:4d45:b0:466:a584:69f8 with SMTP id d75a77b69052e-467893bcc14mr7050891cf.43.1733866696431;
        Tue, 10 Dec 2024 13:38:16 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296f61f6sm65978991cf.43.2024.12.10.13.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:38:16 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	kernel-team@meta.com,
	david@redhat.com,
	nphamcs@gmail.com,
	gourry@gourry.net,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	kbusch@meta.com,
	ying.huang@linux.alibaba.com
Subject: [RFC v2 PATCH 4/5] vmstat: add page-cache numa hints
Date: Tue, 10 Dec 2024 16:37:43 -0500
Message-ID: <20241210213744.2968-5-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210213744.2968-1-gourry@gourry.net>
References: <20241210213744.2968-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count non-page-fault events as page-cache numa hints instead of
fault hints in vmstat. Add a define to select the hint type to
keep the code clean.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/vm_event_item.h | 8 ++++++++
 mm/memory.c                   | 6 +++---
 mm/vmstat.c                   | 2 ++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f70d0958095c..c5abb0f7cca7 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -63,6 +63,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HUGE_PTE_UPDATES,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
+		NUMA_HINT_PAGE_CACHE,
+		NUMA_HINT_PAGE_CACHE_LOCAL,
 		NUMA_PAGE_MIGRATE,
 #endif
 #ifdef CONFIG_MIGRATION
@@ -185,6 +187,12 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NR_VM_EVENT_ITEMS
 };
 
+#ifdef CONFIG_NUMA_BALANCING
+#define NUMA_HINT_TYPE(vmf) (vmf ? NUMA_HINT_FAULTS : NUMA_HINT_PAGE_CACHE)
+#define NUMA_HINT_TYPE_LOCAL(vmf) (vmf ? NUMA_HINT_FAULTS_LOCAL : \
+					 NUMA_HINT_PAGE_CACHE_LOCAL)
+#endif
+
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
 #define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
diff --git a/mm/memory.c b/mm/memory.c
index af7ba56a4e1e..620e2045af7b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5578,10 +5578,10 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 		*last_cpupid = folio_last_cpupid(folio);
 
 #ifdef CONFIG_NUMA_BALANCING
-	count_vm_numa_event(NUMA_HINT_FAULTS);
-	count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
+	count_vm_numa_event(NUMA_HINT_TYPE(vmf));
+	count_memcg_folio_events(folio, NUMA_HINT_TYPE(vmf), 1);
 	if (folio_nid(folio) == numa_node_id()) {
-		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
+		count_vm_numa_event(NUMA_HINT_TYPE_LOCAL(vmf));
 		*flags |= TNF_FAULT_LOCAL;
 	}
 #endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4d016314a56c..bcd9be11e957 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1338,6 +1338,8 @@ const char * const vmstat_text[] = {
 	"numa_huge_pte_updates",
 	"numa_hint_faults",
 	"numa_hint_faults_local",
+	"numa_hint_page_cache",
+	"numa_hint_page_cache_local",
 	"numa_pages_migrated",
 #endif
 #ifdef CONFIG_MIGRATION
-- 
2.43.0


