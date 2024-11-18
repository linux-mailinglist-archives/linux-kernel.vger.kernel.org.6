Return-Path: <linux-kernel+bounces-412745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4707E9D0F13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBC5B25F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C689198822;
	Mon, 18 Nov 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WVr1lEiV"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70933197552
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925882; cv=none; b=WkURduHfKAxHeKpXjm+8lEv/FdPRC/0v0cFB7r4hk8HpTebeNPkopNu/QOQtINdmKkozjDbhBt181pxxrUdYTV3zOJMsDx6LxNTeNgV8HHQeAs0ASGQQKBisXT+tW27QbnXu4KvnO5yT4BCyz0fyVt3wqGoEoG3+qDIiKM0UIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925882; c=relaxed/simple;
	bh=mIqXYsg/C2qrCITDcJd1YaJTS14sI9c5kfQAcRy8Hek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyuvZap4R4zFVm0UFJV3Y/xJZm5nJM3LeRjow7lJIwuzRYoFKWb6JCjTMIYWJX6kt2Jq64j2xoQqzsH+eS6LvAJww7ZK79B8C7Xb7dC1M9tE52DeNzPyBKkgE84dGIMW9NX7zgxROi9VL9UObJPV8cQnDF7AdLPl/+X1cO1CPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WVr1lEiV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so1515888a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731925880; x=1732530680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkzCN3UhBBpnf4e6T+uWXcn8BnX32ULT9Gcxhq6EsGQ=;
        b=WVr1lEiVhOY4lCMKO05VQ7GCsuBhiYKD8X3eXOzAWYl26qgFTKjW67/Y4jBLJMGqCb
         Jjcd9DZP0bcqEVqV3Mnyssq/SjTkmWth51DWb488XKdrkT3y0/zlhirgYY8qtAYpXmS7
         Tf2zPUAGqzlbCHHcxIGkFA7NzOiVD5ZBcV7qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925880; x=1732530680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkzCN3UhBBpnf4e6T+uWXcn8BnX32ULT9Gcxhq6EsGQ=;
        b=WciXd03ouoVYXiFRYfcrte4DTs60WCRPWiGzBzfy6ISCyAXA+Mp1/WSjtqtNB6xl3B
         hvSSr4piiu19yywl3JuedwjawCjBt31z5swMSqZQwWnTshLDdf0sJk9lyl/ahO9A61Ma
         6ypVhoggBkXmQl6vrIkd7Gys/Os3VwS+mQpd3qYVoGzXOUE6W6Aa7zv/qYO5mwGkxmnq
         DfrvA7cYWpP/nEappA7kkygAvdWYlTFsusWl5LmoJRtQ3U5x9pxa41geRgN4x3QjUYaj
         NHn/lpwf04Rh11mqSyE6RpXXGKchbv/vDwwSCsVi5v13lCt2RGZLhpHRfW9AhxguWlk7
         +nrg==
X-Gm-Message-State: AOJu0YwaaPpxgSIUJWsTcgYp1N79NjdZ80TGqPBPldS4i3Sw17f+tb32
	TrgrNUzwI5R7++OiG6qy17ysg4ZFinAt8L/A5WqRlJ7UkfZOsdPr8AV2tE3iYg==
X-Google-Smtp-Source: AGHT+IEfqhqURqDaD0G6JGPl35VcW+CAUQ5rdIfn+KXLAYTZYCO5p9vfNExEvOyytiZIAr03Fg1bqw==
X-Received: by 2002:a05:6a20:9144:b0:1db:edb3:ed87 with SMTP id adf61e73a8af0-1dc90b482cbmr17702579637.22.1731925880281;
        Mon, 18 Nov 2024 02:31:20 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7f8c1dce9afsm5653798a12.82.2024.11.18.02.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:31:19 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 4/8] zram: handle ZRAM_SAME immediately
Date: Mon, 18 Nov 2024 19:30:35 +0900
Message-ID: <20241118103054.3191944-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241118103054.3191944-1-senozhatsky@chromium.org>
References: <20241118103054.3191944-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handling of ZRAM_SAME now uses a goto to the final stages of
zram_write_page() plus it introduces a branch and flags variable,
which is not making the code any simpler.  In reality, we can
handle ZRAM_SAME immediately when we detect such pages and
remove a goto and a branch.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e80b4d15b74b..76ff74a75125 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1625,7 +1625,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	void *src, *dst, *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
-	enum zram_pageflags flags = 0;
 
 	/* First, free memory allocated to this slot (if any) */
 	zram_slot_lock(zram, index);
@@ -1635,10 +1634,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	mem = kmap_local_page(page);
 	if (page_same_filled(mem, &element)) {
 		kunmap_local(mem);
-		/* Free memory associated with this sector now. */
-		flags = ZRAM_SAME;
 		atomic64_inc(&zram->stats.same_pages);
-		goto out;
+		zram_set_flag(zram, index, ZRAM_SAME);
+		zram_set_handle(zram, index, element);
+		return 0;
 	}
 	kunmap_local(mem);
 
@@ -1719,7 +1718,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	zs_unmap_object(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
-out:
+
 	zram_slot_lock(zram, index);
 	if (comp_len == PAGE_SIZE) {
 		zram_set_flag(zram, index, ZRAM_HUGE);
@@ -1727,13 +1726,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		atomic64_inc(&zram->stats.huge_pages_since);
 	}
 
-	if (flags) {
-		zram_set_flag(zram, index, flags);
-		zram_set_handle(zram, index, element);
-	}  else {
-		zram_set_handle(zram, index, handle);
-		zram_set_obj_size(zram, index, comp_len);
-	}
+	zram_set_handle(zram, index, handle);
+	zram_set_obj_size(zram, index, comp_len);
 	zram_slot_unlock(zram, index);
 
 	/* Update stats */
-- 
2.47.0.338.g60cca15819-goog


