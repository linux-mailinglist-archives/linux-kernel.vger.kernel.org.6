Return-Path: <linux-kernel+bounces-324395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1239A974BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2001F25C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEF1143C49;
	Wed, 11 Sep 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yqkgdkqk"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68313C918
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041705; cv=none; b=OmNOk9EihSs1MMc/hzd7EaPzATgk6mZ2rBox05/3t1HER7aLJzbRRYAar7yieeUT+ULKAID3gC/stMYRqrH9f3GI9kQwbrhrTyVkoG+qvamCyjdGKu1akfPiE7GgAXo0bLCAZmTwgclrYRQKrryhCu7bzO7u+pC4yOmrXJpZ/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041705; c=relaxed/simple;
	bh=cMrFZFeYshEhBFOfKSSKpG6P8VFIuhAwYxrlWBPSmzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ij+5lAhcWjIuilH+HRl3izDSkOEQNNlxz0WAGm38uMg3XdLikRibobeRqEOGXnoBKqtR+5x616KIQD3xgEfugJnrmVCQWiLfsKN1sZeLMrwBto/GVLaB03Yq1rrPkFzy7usL+GAkSM83VPUrVwJWuQALqsgzIPqjgZoFXcBU4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yqkgdkqk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20543fdb7acso43958055ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726041702; x=1726646502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwMu+l4YrL6K6neHxIk3gwGHEtDDHlzEJ+d/igKF6jE=;
        b=YqkgdkqkJ4NF5q9hmWq793l5pcpDCGE+nL9VgpwAHs8mxViMWtui+dC9g8a6+vzhN9
         2a9bVvYMmirBDrshovE4xqXyY4MTYnubLBDOxe6GwCM7I4MKahSYpbSx3MWj43ftic+1
         S5URBN4ProA1dX99DSSIdeAQh8qNZ1ZIu5uDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041702; x=1726646502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwMu+l4YrL6K6neHxIk3gwGHEtDDHlzEJ+d/igKF6jE=;
        b=hA7OhLW9nCY7Z+sEe9+CWqVj9gYqUSOWXNHW8oRt3ga0sOzOQbFU+pYXaI8HH965Ra
         10Izb+SuiyduphjD1avu1go/3QFPD3howQWaQqbAqvs5OHM2acBg7joxoK12z7B7Dhnq
         5Xjc2NWN5es+siL93nP3ALGo5hQrTXG9o8UoabYUjmuNQRo+4VUd+kiSAiNcIVuSVWoY
         3Y2pU7Scr6cxXB3ze5N7tj3lYVWCCsogVo8TXQqBYd+aQPpv2wDoY+azEMt9J2pqZJVl
         +i4+MBzTlZWZfQL6hvQIP8EZV4VN5DTsuLFbbT/AUWSAGjz/6cslxp+7/DoEHTVhMGXc
         elfw==
X-Gm-Message-State: AOJu0Yy1nWXgnGEduwAgCMH2ci5YD541PB+tLKFIuryB2HNinaY/Z1sY
	+Z+0fG3GSxZhERiL9gNUrhtMzxMmY9GHrHcfSyTvci5Q10SSt8u13CPdxp5bzn5CKQ36u0NZqHi
	CXA==
X-Google-Smtp-Source: AGHT+IEJ5kdKi8ZHj36iu4mabyJVW1yVRBuLobeZh0LrkxNR6h67V1dnTXCqPCDJpMGGRu6vVcoxmQ==
X-Received: by 2002:a17:902:c94d:b0:1fb:2bed:6418 with SMTP id d9443c01a7336-2074c79a82amr53297775ad.57.1726041702520;
        Wed, 11 Sep 2024 01:01:42 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d828:3442:b431:2762])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e37922sm58737795ad.110.2024.09.11.01.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:01:42 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 1/6] zram: introduce ZRAM_PP_SLOT flag
Date: Wed, 11 Sep 2024 17:01:09 +0900
Message-ID: <20240911080130.3766632-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911080130.3766632-1-senozhatsky@chromium.org>
References: <20240911080130.3766632-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag indicates that the slot was selected as a
candidate slot for post-processing (pp) and was assigned
to a pp bucket.  It does not necessarily mean that the
slot is currently under post-processing, but may mean
so.  The slot can loose its PP_SLOT flag, while still
being in the pp-bucket, if it's accessed or slot_free-ed.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 ++
 drivers/block/zram/zram_drv.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ee2a279c5f25..d170bf6cdcd8 100644
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
@@ -1354,6 +1355,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 		zram_clear_flag(zram, index, ZRAM_INCOMPRESSIBLE);
 
 	zram_set_priority(zram, index, 0);
+	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
 
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index cfc8c059db63..914cb6629969 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -48,6 +48,7 @@ enum zram_pageflags {
 	ZRAM_SAME = ZRAM_FLAG_SHIFT,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
 	ZRAM_UNDER_WB,	/* page is under writeback */
+	ZRAM_PP_SLOT,	/* Selected for post-processing */
 	ZRAM_HUGE,	/* Incompressible page */
 	ZRAM_IDLE,	/* not accessed page since last idle marking */
 	ZRAM_INCOMPRESSIBLE, /* none of the algorithms could compress it */
-- 
2.46.0.598.g6f2099f65c-goog


