Return-Path: <linux-kernel+bounces-243002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C7B929011
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827B0B2257C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A981D531;
	Sat,  6 Jul 2024 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSR+awEG"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4541CD13;
	Sat,  6 Jul 2024 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720232754; cv=none; b=mzJdHZcFAAwmtglRx/HGqMNnR9oEzEivS5zKkxuJlxlkCDFiGToHy1SRkHexEWO1A4fKTUQH/5gsROds+TUKd57xz75DzDkVLlBcQo4xrihyilu1XKR9N0tmqorVDDt5iI5y00Zxs5GTJm236ZdZtIqVIREu8CzvV8KZnYLuStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720232754; c=relaxed/simple;
	bh=YrTzPnsKP3lgW5rjaja6ONSdfBGOK2GJR73aKwaKN0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZt37NwzR8jVUFP0xnuSx1n8gjgqCwr+LayBiEAM5amBCRrFRMQLZ3TaYyEwco08uu1rhUTXDXWNtJEt2s4zyXUc6UKrkiX40p6E7qbGSdqd/+jOooduSU1uarQnzBX0n544NMSG4oTjiLIsUHqSQ3IA+vPQmKs7ulBHt4FCdNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSR+awEG; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c229aa4d35so1005676eaf.3;
        Fri, 05 Jul 2024 19:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720232751; x=1720837551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBpJ3BE0SiSrY/2ro6Q/w/amFbTKvzieCspG8933e1E=;
        b=WSR+awEGXKEc3HHbY3De2Q6LJ+VtCwsPvuqikYR19+vwglAIwg5eCd+/Id5TkywncI
         XmzzL8PTDBnadEW6cTPVQV8ZzPWb3IknyY2oEBcDy2ZPrkeG48eJgZ0Ux4+jTcf4RT8H
         ZB/7HHOf3zbl957yModVuyWyWYmcv8otwJ46+P8we6jNZJOVlV71Z4jmXAyIrRmYXXln
         5fWWKnNKK1KrfELeukABCH5zl73095pEIT6/yeqeL3kNVr7XM6ve4+G6IUuYZhPU6qVj
         umGfGeq6kDxJAwNCVchFYq94/5huhgrFzOt+QwzIFsJDZysyLxqisLJvREmTBuJBN9mM
         E5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720232751; x=1720837551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBpJ3BE0SiSrY/2ro6Q/w/amFbTKvzieCspG8933e1E=;
        b=vXRzyZRY/3DsiwwMD7ZfUivcSvDfwT8+OfgrIVS20HQyiFD/5WKZxyXTJFKUxHrrOE
         RQH+13tSpFItcWt++V1UjO8DQkplr1PbkwT2qO5EesAu1k4jr0P/chmJipBI4llgeZVh
         1JL+06FVACbmGf3uFzGoxUuPfiTvBtW0n/18SZD5sbdpPYT+7g/0vzmL8frCTE/UsTRo
         dzs/zyzMLXlQYIy+IuBYWKSECTmXYx5SZsNKjaIZpw87iqPvbjh2gf582iHrd2CiN+Qi
         hkIfmU1XFyrciobT1qgAxfRqkXcZ/+V9/zG8M+W6txc/byqDvScnFT6wLgW9LFNOak0f
         9GkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg4g9hGZY9DGDPaHtzc9FKWmyEGef78CtYQR8N7mldhs9gbpRzOnlZtVyewHEksBXpPnxw+u7YNROhvJBX5N591p0ZGoysyBgQBZONSik16qZr7swpk6AB5vePtYOYmZCwPbhdyn+d
X-Gm-Message-State: AOJu0Yxc6NQW+PDCQnYLMFzpfLQ65Ga+4ajNKdBwGU33P4SH8tLHemG2
	42v6ME0p5cIBSPBkgSFvO+EgHM3ionc6JXTR2tvMBQFXLFE01Q1G
X-Google-Smtp-Source: AGHT+IHXQIeoErfRsmMJa9fwH9FrJ6bXuw08Ue12BsvAoEyW/uWu0HwgyBVleoabGwNScNNl0KNw/w==
X-Received: by 2002:a05:6870:a687:b0:25e:26f0:adff with SMTP id 586e51a60fabf-25e2bb802c5mr5147649fac.28.1720232751471;
        Fri, 05 Jul 2024 19:25:51 -0700 (PDT)
Received: from cbuild.incus (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15417a7bsm971274b3a.205.2024.07.05.19.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 19:25:50 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] mm: zswap: interrupt shrinker writeback while pagein/out IO
Date: Sat,  6 Jul 2024 02:25:22 +0000
Message-ID: <20240706022523.1104080-7-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706022523.1104080-1-flintglass@gmail.com>
References: <20240706022523.1104080-1-flintglass@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent the zswap global shrinker from writing back pages
simultaneously with IO performed for memory reclaim and faults, delay
the writeback when zswap_store() rejects pages or zswap_load() cannot
find entry in pool.

When the zswap shrinker is running and zswap rejects an incoming page,
simulatenous zswap writeback and the rejected page lead to IO contention
on swap device. In this case, the writeback of the rejected page must be
higher priority as it is necessary for actual memory reclaim progress.
The zswap global shrinker can run in the background and should not
interfere with memory reclaim.

The same logic applies to zswap_load(). When zswap cannot find requested
page from pool and read IO is performed, shrinker should be interrupted.

To avoid IO contention, save the timestamp jiffies when zswap cannot
buffer the pagein/out IO and interrupt the global shrinker. The shrinker
resumes the writeback in 500 msec since the saved timestamp.

Signed-off-by: Takero Funaki <flintglass@gmail.com>
---
 mm/zswap.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index def0f948a4ab..59ba4663c74f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -35,6 +35,8 @@
 #include <linux/pagemap.h>
 #include <linux/workqueue.h>
 #include <linux/list_lru.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -176,6 +178,14 @@ static bool zswap_next_shrink_changed;
 static struct work_struct zswap_shrink_work;
 static struct shrinker *zswap_shrinker;
 
+/*
+ * To avoid IO contention between pagein/out and global shrinker writeback,
+ * track the last jiffies of pagein/out and delay the writeback.
+ * Default to 500msec in alignment with mq-deadline read timeout.
+ */
+#define ZSWAP_GLOBAL_SHRINKER_DELAY_MS 500
+static unsigned long zswap_shrinker_delay_start;
+
 /*
  * struct zswap_entry
  *
@@ -244,6 +254,14 @@ static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpools[0]))
 
+static inline void zswap_shrinker_delay_update(void)
+{
+	unsigned long now = jiffies;
+
+	if (now != zswap_shrinker_delay_start)
+		zswap_shrinker_delay_start = now;
+}
+
 /*********************************
 * pool functions
 **********************************/
@@ -1378,6 +1396,8 @@ static void shrink_worker(struct work_struct *w)
 	struct mem_cgroup *memcg;
 	int ret, failures = 0, progress;
 	unsigned long thr;
+	unsigned long now, sleepuntil;
+	const unsigned long delay = msecs_to_jiffies(ZSWAP_GLOBAL_SHRINKER_DELAY_MS);
 
 	/* Reclaim down to the accept threshold */
 	thr = zswap_accept_thr_pages();
@@ -1405,6 +1425,21 @@ static void shrink_worker(struct work_struct *w)
 	 * until the next run of shrink_worker().
 	 */
 	do {
+		/*
+		 * delay shrinking to allow the last rejected page completes
+		 * its writeback
+		 */
+		sleepuntil = delay + READ_ONCE(zswap_shrinker_delay_start);
+		now = jiffies;
+		/*
+		 * If zswap did not reject pages for long, sleepuntil-now may
+		 * underflow.  We assume the timestamp is valid only if
+		 * now < sleepuntil < now + delay + 1
+		 */
+		if (time_before(now, sleepuntil) &&
+				time_before(sleepuntil, now + delay + 1))
+			fsleep(jiffies_to_usecs(sleepuntil - now));
+
 		spin_lock(&zswap_shrink_lock);
 
 		/*
@@ -1526,8 +1561,10 @@ bool zswap_store(struct folio *folio)
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
 
 	/* Large folios aren't supported */
-	if (folio_test_large(folio))
+	if (folio_test_large(folio)) {
+		zswap_shrinker_delay_update();
 		return false;
+	}
 
 	if (!zswap_enabled)
 		goto check_old;
@@ -1648,6 +1685,8 @@ bool zswap_store(struct folio *folio)
 	zswap_entry_cache_free(entry);
 reject:
 	obj_cgroup_put(objcg);
+	zswap_shrinker_delay_update();
+
 	if (need_global_shrink)
 		queue_work(shrink_wq, &zswap_shrink_work);
 check_old:
@@ -1691,8 +1730,10 @@ bool zswap_load(struct folio *folio)
 	else
 		entry = xa_load(tree, offset);
 
-	if (!entry)
+	if (!entry) {
+		zswap_shrinker_delay_update();
 		return false;
+	}
 
 	if (entry->length)
 		zswap_decompress(entry, page);
@@ -1835,6 +1876,8 @@ static int zswap_setup(void)
 	if (ret)
 		goto hp_fail;
 
+	zswap_shrinker_delay_update();
+
 	shrink_wq = alloc_workqueue("zswap-shrink",
 			WQ_UNBOUND, 1);
 	if (!shrink_wq)
-- 
2.43.0


