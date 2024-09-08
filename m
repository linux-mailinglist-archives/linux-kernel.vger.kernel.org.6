Return-Path: <linux-kernel+bounces-320180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692F97070D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A53281817
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0315A85F;
	Sun,  8 Sep 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BgYqFs9Q"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C3158A08
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795950; cv=none; b=LDc/ZZeXvuogn/qsraSnC+HEOIrDYlyqfgiEkaLTxgTRuFas3d1QFIGeQMQnghVixjQk/iSgOuG74ZACUxb6szHSme6OeBFqdMBu+TYAdUSsk7lPI69bU9gPYvAV1QrzLfUvOR8QTrn27lgG4u708nGN7OZNtkLOBpTRjHHUPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795950; c=relaxed/simple;
	bh=oR3naV05tO9HRz4kvtPKoCFr1CXNpq4dqwybuFPJMjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frVqbHUY+ZYtwfKtNCRGXu7JLM64UsDXbARgwmgH8GcPYjRGeozKjyKz/8WvIV5jwr3WBHuKR4U3o3UijZC953VGztnxM9r1em5BnDBG0A0/WVp/ZBpOXRtfl+FlzSGZo1lS/0wQAffGoLG4i/gNENbGKRRD2gcg2juQjjsBGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BgYqFs9Q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2767784a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725795949; x=1726400749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcgEvHbf96KCRkopD9YVwbrf1iPmkYihwVMDRIbnuTE=;
        b=BgYqFs9Q+SXJRvhSqlBZuATvOaDdXO9yTyfWD83ahwBfJ4IJIOPThp0T2m800/HaxA
         vBEHYcgx7TxpvW2ZwYNQj0GdMQXThZOMqs2SJLpriqFdW8t1hdNlGcIcezZtB/JtCzdx
         /3Q+APEpYb76HmxzMDNdluAOa248ll/O1bBb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795949; x=1726400749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcgEvHbf96KCRkopD9YVwbrf1iPmkYihwVMDRIbnuTE=;
        b=gdJtkHtGudYq+Ie8jEqELHSsZsQMawRq7wd5yQxEbeyoTfXT00oRj/B/zuM9uYCsij
         wyLPByu+39XuHKtgnHkUwG7c4tP+KV5oEOOsJkBnBN4+Z5WRdq9SEJYpe8rADS5wV7R0
         ZkU9/A5hQ7so0WyGOua5tZ88r10c+pYlU2YUNfobOaF/iiCyGh82/GDeYD4DLmqPyGKj
         AhZOsTZ7lw4lKnCndi94yxTgt+X7By8/JjAHWs8cZzS0kufoMHbDiWkYQVBUQhd9S7jo
         iAIV56Ecx9R2aTLn22GJk3tR1Cy4GcWQk8Exs3gEhx6kYkHBOKxQOcMedrptcwgJdRgw
         D9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyY67lr309sMHq6kDny1xya9BVA4XAIo8ptTgOVxIrj+rvdYNWAM0XAsZVgUw7WqViQhWQxwOUbdsdfgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFYeTNEochE8HLk0SH/3ppZMNFx2E9ULvZnSZFSJ792iYhxI1
	Qxpt+7wpWZfV5+V1dmIhHDhgj7T2zQ45bDSH8KPstA8Taskge73y5jDKJkX5mg==
X-Google-Smtp-Source: AGHT+IG1zHRcC5WnMATiGeCahyvvtTRg9LKd2Hphw+MiISdIsqZGnvxrtvnP3RHRVURf4Yh1ewzGaQ==
X-Received: by 2002:a17:902:e74f:b0:207:2697:da17 with SMTP id d9443c01a7336-2072697dbdemr13884195ad.23.1725795948875;
        Sun, 08 Sep 2024 04:45:48 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5879:695a:4656:45ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1f3f6sm19087065ad.226.2024.09.08.04.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:45:48 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/3] zram: introduce ZRAM_PP_SLOT flag
Date: Sun,  8 Sep 2024 20:45:11 +0900
Message-ID: <20240908114541.3025351-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240908114541.3025351-1-senozhatsky@chromium.org>
References: <20240908114541.3025351-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag will indicate that the slot was selected as
a candidate slot for post-processing (pp) and was assigned
to a pp bucket.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 10 ++++++++--
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1f1bf175a6c3..a14aef6bf634 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -178,6 +178,7 @@ static inline u32 zram_get_priority(struct zram *zram, u32 index)
 static void zram_accessed(struct zram *zram, u32 index)
 {
 	zram_clear_flag(zram, index, ZRAM_IDLE);
+	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].ac_time = ktime_get_boottime();
 #endif
@@ -659,8 +660,9 @@ static ssize_t writeback_store(struct device *dev,
 			goto next;
 
 		if (zram_test_flag(zram, index, ZRAM_WB) ||
-				zram_test_flag(zram, index, ZRAM_SAME) ||
-				zram_test_flag(zram, index, ZRAM_UNDER_WB))
+		    zram_test_flag(zram, index, ZRAM_SAME) ||
+		    zram_test_flag(zram, index, ZRAM_PP_SLOT) ||
+		    zram_test_flag(zram, index, ZRAM_UNDER_WB))
 			goto next;
 
 		if (mode & IDLE_WRITEBACK &&
@@ -1368,6 +1370,9 @@ static void zram_free_page(struct zram *zram, size_t index)
 		goto out;
 	}
 
+	if (zram_test_flag(zram, index, ZRAM_PP_SLOT))
+		zram_clear_flag(zram, index, ZRAM_PP_SLOT);
+
 	handle = zram_get_handle(zram, index);
 	if (!handle)
 		return;
@@ -1927,6 +1932,7 @@ static ssize_t recompress_store(struct device *dev,
 		if (zram_test_flag(zram, index, ZRAM_WB) ||
 		    zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
 		    zram_test_flag(zram, index, ZRAM_SAME) ||
+		    zram_test_flag(zram, index, ZRAM_PP_SLOT) ||
 		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index b976824ead67..e0578b3542ce 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -50,6 +50,7 @@ enum zram_pageflags {
 	ZRAM_SAME,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
 	ZRAM_UNDER_WB,	/* page is under writeback */
+	ZRAM_PP_SLOT,	/* Selected for post-processing */
 	ZRAM_HUGE,	/* Incompressible page */
 	ZRAM_IDLE,	/* not accessed page since last idle marking */
 	ZRAM_INCOMPRESSIBLE, /* none of the algorithms could compress it */
-- 
2.46.0.469.g59c65b2a67-goog


