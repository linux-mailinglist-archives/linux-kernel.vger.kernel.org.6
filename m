Return-Path: <linux-kernel+bounces-550038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF49A55A65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10C31898994
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E5206F22;
	Thu,  6 Mar 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiLSyING"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684472E3373
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302020; cv=none; b=tZUN9/kqfDqouxrfz+7IaTnzUsTi6RxzsO0VXDoRYCRjQuPGBn5jaMEkXJqQwE4Jmj6HV9/kgyli/RI6V0kAbrv27PTP5HPpRlVYRlzDDytIu/kPHpK/HqZpDg83v+2cLbOqnFbhLeY0WyHnSwkqM1oUJhfgvc+n9dLfc6CXITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302020; c=relaxed/simple;
	bh=KbuAqtkYtNbIf7bFsEkGfJoWaMV6On0bXLqnHFLgpjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbfSLuwJIM5880sLj0sXBsMq/WPDH15IvB7BaoLRZp7C1BOIcbxpdf623hCdnqvqtHiHCiXroo5jEEA0cwRYlaowxSIhyzX07vw9W78RRHG8ehk2Dfv1MqPq6w37oVElu68spvMd7OomphbEVqYE8SU9hjkZCJbrHskh5c/NuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiLSyING; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fd9d9ae47cso12331887b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 15:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741302016; x=1741906816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=geAOgzeebd8mAMWoJQZj/D/Fwtsvs8mA1xjntUbssZw=;
        b=QiLSyINGepD4VGn5lryz3/V2UFDqqE8azJd7WHjYpPg39wFt1hfjeQnJGDh71jt6is
         lSPVr36UXT5yRWjaC2pNuwk+zmbwSEdDkQ+SG2EbE4ecPszWkbxl3aRKXArID6mke7TO
         pIZfJtlruGmIvcQ7X2pys2GphHth6x9j66lJwsDnAJ5hmQGiq+bFJexdLgzSgtbbT0M4
         XChgUbox814+4rjhF71dRlqr/y7/mS+uoHprpJ8Q+ANnwZ0uVujBt12TK7zM9Cg+kyt2
         o+Nuh46boeNx5XcsR21j/sJzoR1dq4FVULQNrjAknNCtZKPhQjxtQtqiGeQLa/oaIxXB
         +zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302016; x=1741906816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geAOgzeebd8mAMWoJQZj/D/Fwtsvs8mA1xjntUbssZw=;
        b=om1TOTvHOXxJJbdAtDSCdb21dyrYNva/bc55anABkWw71kqWOqRpTx6PyGHhWqu/+B
         q/P7BNCVo/fHHZmFnmDaWYc9dBhH6O1EbbvqqjZqtv5ewRRSFmzT4kg1Ezz/omSux+GF
         b2HtXfvg6dKLlm9NSHRqoYQBJGM22rW2jTnqVUS1IufQT8ZRXXWpXBFUjULFuuKouXTU
         4OodIqdjsBxUX9iQfYXM1VmEAl4VsLLfgdlTGxemzASHmqw4ECXKrUtge7SgEn5A+nnz
         9vmRYxzO6GOIrGscghmnbB80k3O7rwFNdTNpl1ZDJUoFWQnB4OaKCagrqOLSZy2zkTys
         ikAA==
X-Forwarded-Encrypted: i=1; AJvYcCVMPHJobE6FVBMFAWpPjlCnmAavSLAC0kESPZ7oVXNpEKw2Klz+pTQbpxBlyJpvxOk4ao68IDIJCncEOQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdOgINPrjf1F8/kwOmJzPY/okF+S6yaBvrPXg7eB0eMb+caaP
	brGWNHWi+YvL+UoD0LSy6kWPFrGL+bRVdk9yfZyawIXmC/E7M0Th
X-Gm-Gg: ASbGncs/N3sRVoKEDdHSrqF6uElAYUAICXuzL4ZczuzPY48bJFSs+uEJiHBI/MlKogD
	ult53+QTn47CB+OMef0IGgungsoD6TAEkRw9QfvS50y5k4BV/15FyC6JF6gjOUwRCrfkv8eixzm
	hhQETeCo1ECmL+9nOsMA4OlXB9PECZ5dpplZcBwk+HQVM0txwZ0qjsrNWMt9PIAsHc1W13wzKzb
	hfa9dny+mrmaFssMddfBaJHYkyR4xUMJD3alqnnwe4Yn2kfdKG8G1G/O2B4hynOi8mRQS/0okNA
	uahON7oOss/RPgzl4IBhuplCrrG6sjwokCQv
X-Google-Smtp-Source: AGHT+IGgG/4b/FIa0kd9TWIEiHSPrmyea0X37UqteSiydOz0UfID+3itnlJ73noe5bd9kiIP6s7VYA==
X-Received: by 2002:a05:690c:4c09:b0:6fb:ae6b:a340 with SMTP id 00721157ae682-6febf3b42c1mr17124967b3.30.1741302016225;
        Thu, 06 Mar 2025 15:00:16 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c2e85dsm4688647b3.93.2025.03.06.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:00:15 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] page_io: return proper error codes for swap_read_folio_zeromap()
Date: Thu,  6 Mar 2025 15:00:15 -0800
Message-ID: <20250306230015.1456794-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to zswap_load(), also return proper error codes for
swap_read_folio_zeromap():

* 0 on success. The folio is unlocked and marked up-to-date.
* -ENOENT, if the folio is entirely not zeromapped.
* -EINVAL (with the follio unlocked but not marked to date), if the
  folio is partially zeromapped. This is not supported, and will SIGBUS
  the faulting process.

This patch is purely a clean-up, and should not have any behavioral
change. It is based on (and should be applied on top of) [1].

[1]: https://lore.kernel.org/linux-mm/20250306205011.784787-1-nphamcs@gmail.com/

Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/page_io.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 4bce19df557b..48ed1e810392 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -511,7 +511,23 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 	mempool_free(sio, sio_pool);
 }
 
-static bool swap_read_folio_zeromap(struct folio *folio)
+/**
+ * swap_read_folio_zeromap - check if the folio was zeromapped, and if so,
+ *                           zero-fill it.
+ * @folio: the folio.
+ *
+ * Return: 0 on success, with the folio zero-filled, unlocked, and marked
+ * up-to-date, or one of the following error codes:
+ *
+ *  -ENOENT: the folio is entirely not zeromapped. The folio remains locked.
+ *
+ *  -EINVAL: some of the subpages in the folio are zeromaped, but not all of
+ *  them. This is an error because we don't currently support a large folio
+ *  that is partially in the zeromap. The folio is unlocked, but NOT marked
+ *  up-to-date, so that an IO error is emitted (e.g. do_swap_page() will
+ *  sigbus).
+ */
+static int swap_read_folio_zeromap(struct folio *folio)
 {
 	int nr_pages = folio_nr_pages(folio);
 	struct obj_cgroup *objcg;
@@ -519,15 +535,17 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 
 	/*
 	 * Swapping in a large folio that is partially in the zeromap is not
-	 * currently handled. Return true without marking the folio uptodate so
+	 * currently handled. Return -EINVAL without marking the folio uptodate so
 	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
 	 */
 	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
-			&is_zeromap) != nr_pages))
-		return true;
+			&is_zeromap) != nr_pages)) {
+		folio_unlock(folio);
+		return -EINVAL;
+	}
 
 	if (!is_zeromap)
-		return false;
+		return -ENOENT;
 
 	objcg = get_obj_cgroup_from_folio(folio);
 	count_vm_events(SWPIN_ZERO, nr_pages);
@@ -538,7 +556,8 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 
 	folio_zero_range(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
-	return true;
+	folio_unlock(folio);
+	return 0;
 }
 
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
@@ -635,10 +654,8 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	}
 	delayacct_swapin_start();
 
-	if (swap_read_folio_zeromap(folio)) {
-		folio_unlock(folio);
+	if (swap_read_folio_zeromap(folio) != -ENOENT)
 		goto finish;
-	}
 
 	if (zswap_load(folio) != -ENOENT)
 		goto finish;
-- 
2.43.5


