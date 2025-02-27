Return-Path: <linux-kernel+bounces-535573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD6FA474B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9473AA4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1EE1EFFA8;
	Thu, 27 Feb 2025 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XBBqUcAe"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281841EFF8C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631053; cv=none; b=Xg3D2N2vQqLP4X7xwyEtWcH/mEAHgzYAneptpESW+KygHx1c+c2Art+0S+REJP8rAgP9F8ZT7ZD3X518sLFKwCbJmrgN0I4yxIMTb5ZF4vfgYNKgSS4wf5azZViBv6j+/HXpptuNSZLgeBDX5Ge3XOJhvJfFb/ZOp49EeDvClH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631053; c=relaxed/simple;
	bh=3ZU/JAkRZCtDJckZQQCn2jpwXitiZk8mc8tI7tKlqb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xqi4QHycxGVZJxkWOCbMi3I0UE8pRkfVPH7wT03Vv56YFjSVV5aVH+VJVKXYV9LtuQtyNfMPgHD9Mv8hKudKV0Z+yzzLiYxyGmVEvdOzPWTaESSHcF/HBQ5/Pn7pEQ+4ojU1rcmTHP1UY+opfER6FchDiDqYZI5WIJYfiFdQvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XBBqUcAe; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso257177a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631051; x=1741235851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atSj686udXXb8naSP/ilX+V3ED7QvGuQ33PoSFmI78o=;
        b=XBBqUcAens1o/luKjsmhwMeeaDlDwpVNYIsxpKQGOKVY6NtBqbV6qjgq/UxGb6XTMJ
         2jz7q4A2L1nzuqb6OYB8vXqUUzb4asHc1RlS7tlX0Rtq0x2ko+cIrjnRgM7SaYwgFBRm
         FXgTAgOnfBETuZPdoEROtDGQXCdTNqmAZV6JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631051; x=1741235851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atSj686udXXb8naSP/ilX+V3ED7QvGuQ33PoSFmI78o=;
        b=Qy7HNpUH5a8zkfl9etQ3Qwv5QSKNygruDKH3MdhltuPRmlzWSoNwLhaJDlLwXngEzW
         zcsH5czlQQgEcI99wrFAQm/+tBgaHrBtFXBGxpAXVFlbrxJuZ0ggLzALz6i2U0kYNk+c
         UnEoilC3eQ/aSIS+9IrNh8KHyELjFUiXtGeuYKpN3wk/wJa9+FDGNtkwjcTFoH+Tzilf
         fMRjQDICkWPITbut9Xt6gAUW9fg/nJPmbBCY6vw+L4ibLBhOBHsWk/+Ixh8uSueW/Fzu
         0gd4hq27Fqop9fau8ki7EVSgMvnQXGE9fD5Bk9yI89Wvsiqk8jFIAeNEceh27KTuppHv
         LPhw==
X-Forwarded-Encrypted: i=1; AJvYcCU1sTy4zY/HLgyRs9bW/H23VRXC8ogHyoRm9oCtD9yo5cB1pmTzod88ap4Q5IfSs8baJ1P5FN2WJCfrLpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXdM/VXcU5ZiRkMxJO+pLug4vdC4NxZ2GYifehu3kDgzVv2CH
	OFHTigeuZSu1ZJRkQsKOare2QeIP20d+ZZBpCXPu93OCgU7BjIW+wIw/FnuOOQ==
X-Gm-Gg: ASbGncs3PPpP26a171diT3rO/IMKsBSNwiqjZQ7+jvkbxtYlcNu7+ds2GW1bHawcQni
	0TKPlikK1zflf9GG/A+eNmSQ1vEqB8RJkYIs57UijziMgJPuo/wWKiCYes462JVhYL/HIzJ32ZU
	j8NJk8jIukYp2KMcbUSs08Y9Vy+2uLmlPV4D/rSohqVd+8lRpPYKPecf9rwWUvO5th6CpDCIbjQ
	TGbOhzMjMFvc4+aD91WvQ13NKXEbPEbptEZqew9KooK6LZJvscQvrky3eJMJPS/QuGd6tjISC4Z
	Vqz+S7+DfGjTfbRxjoZzJbO2mAzr
X-Google-Smtp-Source: AGHT+IEJkvjK9xJSO0CePo42cX0OoaGvyhAPmRkoUPST+KqNGlEPU6xv/EJnWdmaTpIOPBA38FE11Q==
X-Received: by 2002:a05:6a21:1515:b0:1ee:c8a4:c329 with SMTP id adf61e73a8af0-1f2e36efeefmr3287648637.0.1740631051528;
        Wed, 26 Feb 2025 20:37:31 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7ddf246bsm411855a12.2.2025.02.26.20.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:31 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v9 11/19] zram: move post-processing target allocation
Date: Thu, 27 Feb 2025 13:35:29 +0900
Message-ID: <20250227043618.88380-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate post-processing target in place_pp_slot().  This
simplifies scan_slots_for_writeback() and scan_slots_for_recompress()
loops because we don't need to track pps pointer state anymore.
Previously we have to explicitly NULL the point if it has been added
to a post-processing bucket or re-use previously allocated pointer
otherwise and make sure we don't leak the memory in the end.

We are also fine doing GFP_NOIO allocation, as post-processing can
be called under memory pressure so we better pick as many slots as
we can as soon as we can and start post-processing them, possibly
saving the memory.  Allocation failure there is not fatal, we will
post-process whatever we put into the buckets on previous
iterations.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 50 +++++++++++++++--------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6755ca90f737..7ad89df9a304 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -295,15 +295,24 @@ static void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
 	kfree(ctl);
 }
 
-static void place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
-			  struct zram_pp_slot *pps)
+static bool place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
+			  u32 index)
 {
-	u32 idx;
+	struct zram_pp_slot *pps;
+	u32 bid;
+
+	pps = kmalloc(sizeof(*pps), GFP_NOIO | __GFP_NOWARN);
+	if (!pps)
+		return false;
 
-	idx = zram_get_obj_size(zram, pps->index) / PP_BUCKET_SIZE_RANGE;
-	list_add(&pps->entry, &ctl->pp_buckets[idx]);
+	INIT_LIST_HEAD(&pps->entry);
+	pps->index = index;
+
+	bid = zram_get_obj_size(zram, pps->index) / PP_BUCKET_SIZE_RANGE;
+	list_add(&pps->entry, &ctl->pp_buckets[bid]);
 
 	zram_set_flag(zram, pps->index, ZRAM_PP_SLOT);
+	return true;
 }
 
 static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
@@ -737,15 +746,8 @@ static int scan_slots_for_writeback(struct zram *zram, u32 mode,
 				    unsigned long index,
 				    struct zram_pp_ctl *ctl)
 {
-	struct zram_pp_slot *pps = NULL;
-
 	for (; nr_pages != 0; index++, nr_pages--) {
-		if (!pps)
-			pps = kmalloc(sizeof(*pps), GFP_KERNEL);
-		if (!pps)
-			return -ENOMEM;
-
-		INIT_LIST_HEAD(&pps->entry);
+		bool ok = true;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
@@ -765,14 +767,13 @@ static int scan_slots_for_writeback(struct zram *zram, u32 mode,
 		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
-		pps->index = index;
-		place_pp_slot(zram, ctl, pps);
-		pps = NULL;
+		ok = place_pp_slot(zram, ctl, index);
 next:
 		zram_slot_unlock(zram, index);
+		if (!ok)
+			break;
 	}
 
-	kfree(pps);
 	return 0;
 }
 
@@ -1827,16 +1828,10 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct zram_pp_slot *pps = NULL;
 	unsigned long index;
 
 	for (index = 0; index < nr_pages; index++) {
-		if (!pps)
-			pps = kmalloc(sizeof(*pps), GFP_KERNEL);
-		if (!pps)
-			return -ENOMEM;
-
-		INIT_LIST_HEAD(&pps->entry);
+		bool ok = true;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
@@ -1859,14 +1854,13 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 		if (zram_get_priority(zram, index) + 1 >= prio_max)
 			goto next;
 
-		pps->index = index;
-		place_pp_slot(zram, ctl, pps);
-		pps = NULL;
+		ok = place_pp_slot(zram, ctl, index);
 next:
 		zram_slot_unlock(zram, index);
+		if (!ok)
+			break;
 	}
 
-	kfree(pps);
 	return 0;
 }
 
-- 
2.48.1.658.g4767266eb4-goog


