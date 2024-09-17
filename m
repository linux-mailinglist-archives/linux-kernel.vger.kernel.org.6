Return-Path: <linux-kernel+bounces-331250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE597AA58
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40681C21896
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679A2E3F7;
	Tue, 17 Sep 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hVol8mWf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888815AF6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726539031; cv=none; b=JVqwGXKp5rA2jlfLEbVSqAniH+loJ5viB6gLffsEu/MyjaPaskfA8SIZmCgnXvp7qdgIO7xCSaZUi2luaT77nZy9WGuuMvSBXe9R62DPwgqwdIf9AXgTAhmjYYSusdPL7anLPkaakQchYjx9vkNFkdXbc+14DPMrnhHOQDx0a4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726539031; c=relaxed/simple;
	bh=zs1xjkHS1qDR4NEj1PsKCOx0BbN2dHqRScEEUTjaEgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKk9pyQDYd3ejDjLAxJ6GnqpyLgmICJeWMCnxwXK+oJoNR+o0eHAFa1fQUyufGmd1QDtTFkcG5TvG5yO1jGODiONKNTRdIMgmbCqIMa5El0RB4MPhz6Ut77YgI9Q/nV1heDQhdOUnzDichzerTzmHkTytNbWcI04mwrZ/sO5wLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hVol8mWf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20536dcc6e9so28607935ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726539029; x=1727143829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8H7PhtZWFmbqhqP3UZN7g8qBsoFfPmUW3Wpglk6Y3U=;
        b=hVol8mWfSLvJ6aYtx8f7njHTqYXqRTXfVUkS/6tFuftIOPj41InA2FwrRFF7FwiYZy
         oF14+kGiO1jWFGAElW79sO5IZPzvHYandd5LerDDWNdMyPU5oj1mcZuXwX6e/8rxbhpf
         MCnT9qfzn/SnUsNOuYM978Hh3MTVaJ+FGRsJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726539029; x=1727143829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8H7PhtZWFmbqhqP3UZN7g8qBsoFfPmUW3Wpglk6Y3U=;
        b=LFyv7sJu497CSu4jL/LDNa2oqIHm8MGUIK0yXZrc3L1iFO2F77I+/AiOdgjeV8Eouo
         oqPHYWZW+tMplEZJAKJHurGcwp2lL0Nl5XJCBZh9J1fgM1INhjP3FnzkbLzpNYOlJjON
         oYhgzqUvpffCkm5dCUCAYpiAPmkrWIwf9/S3xB0KaDdop0Ofp8OSg2MGh98Rxx/LOwco
         gC8ZaOoRB2XKgAJqlUxXpfEXigazQZqPdCOJOBK5U8WBx/aZjqvFRdhGbGAdIcTBHt00
         5OKFJxVCKrDx0fK5XLHOP7vRzJQG1h+3u/seKkYEzTNZ/eDFa8UfLzP7Jm8kDi5q9kdF
         AnQw==
X-Gm-Message-State: AOJu0Yy/navvqqnmkT6llvXr7bKP/nfoNqZyOUkQaYu8NFJ+8O3OichO
	I1ZliUJJ7/N3pXl+dyMHTuQsE/lPWf8X6XDE5b13c/iaOwhhhBLkrSignCAtpQ==
X-Google-Smtp-Source: AGHT+IGW9izy2scT00BIEr9qBSc7odAOqerh23E67N1ckI9Ho82ST9EryEzRyvH3doY/o6Bdr7/Q8Q==
X-Received: by 2002:a17:902:fc4e:b0:1fc:369b:c1dd with SMTP id d9443c01a7336-2078262ccccmr205190435ad.6.1726539028896;
        Mon, 16 Sep 2024 19:10:28 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:693c:b4a9:5e6e:c397])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd9313fsm6037293a91.44.2024.09.16.19.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 19:10:28 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 1/7] zram: introduce ZRAM_PP_SLOT flag
Date: Tue, 17 Sep 2024 11:09:06 +0900
Message-ID: <20240917021020.883356-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240917021020.883356-1-senozhatsky@chromium.org>
References: <20240917021020.883356-1-senozhatsky@chromium.org>
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
2.46.0.662.g92d0881bb0-goog


