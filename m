Return-Path: <linux-kernel+bounces-320173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E489706FE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC922281ECF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280FC156F46;
	Sun,  8 Sep 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BknI1biw"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721315855B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795763; cv=none; b=mZ1M8TGUPFfa2EKRdXcG569Ig0T7Q0Ej4K9PA97Y1JizdVCW/SbkAz7qVbd891e03EVvhINc7qT7PWwNqel2CZHCouaeopN4m1ISxNbKu6YQ4Q4m1VtcNPomms6WHdCIGUMJ8VdwHblAhBAr3RCWRgmlwQENL0qzLM3Jo8263mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795763; c=relaxed/simple;
	bh=oR3naV05tO9HRz4kvtPKoCFr1CXNpq4dqwybuFPJMjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZm8NUN+jqeZTBoQd6BAOMGulOHrUPjOikF6jiNv41ariHZzZaueaZtFstWJnSyzqwMevfP86E/K+ICIP20bx6qHdxFO9yzozxgZrtOBwlI+MrthVLUZW6nScYGcQUUaA29vsfopKieKGIwfHfY8asCotAZ6MdEryQ/L3cGEKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BknI1biw; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e03d17365bso531153b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725795761; x=1726400561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcgEvHbf96KCRkopD9YVwbrf1iPmkYihwVMDRIbnuTE=;
        b=BknI1biwpa+czDhhK64zrhFYU21Uxl20i7iWfsm17dsqvLmtxFx7ebhDiKNghZqDI6
         dN13tyvCq/z57d7p059toMLY9uf289pX76bLM7codRqsRCzUKruOIhX8rbyXGsytCzZM
         yzCVIZeTQzAh0jX7mz3xm+bAD6Fl7CKGwVELE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795761; x=1726400561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcgEvHbf96KCRkopD9YVwbrf1iPmkYihwVMDRIbnuTE=;
        b=rPlBZnxegSYjdRZMXrikO5bNk/MX4Rvdt7N0bN0+GYkPoKzlPWszL615tYujaQ5/YB
         xwy/gsrXgMNJY33gNKh6folXFBBYtQ7i/aapp0fyOH+eIT2rrFBfSakCQv3+kl8taFO2
         6wqdpjD2WBvbedj8XAEGgyaxn6TawVc2XhUs7ZpVOYmuUperH1XJOcOpQBCuzt459/RQ
         LKTVbA+DLGNorIXLXkVfAk9t4oZb1E/wt1S6pmF3Jd99aHqRh4Dex70Lsm5o0n9QD0fn
         XsfhTtvFNP7Q9et7U6GjEVAYb1TMlLOcmxcGheLeXy11GkjJFNv1jdQJIsPWN6zK+6gN
         yalg==
X-Forwarded-Encrypted: i=1; AJvYcCUt8lJrgti8N/5n11MdtpBfSn5WCMoWJninDEqgLfVox9Vaus+Swn09GinFRffOHksQRx9YnTwQvl7IkGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIANOYwFg+EVWimzm0RpkmQlLIz+ZTalrccJoDl/7FXqyDZF43
	pvEqdzPyh1oj5X9R8/gqwOCOJMKLOX463msUR/jH7MIp1zZpo1we0BKw5uuF/w==
X-Google-Smtp-Source: AGHT+IHZWrNDRaJJORSIPHd/QO1zw77yK5P7d3v2OMupnQ85Qsrv18YaTtzK9Q1oqdQRxYdguNStqg==
X-Received: by 2002:a05:6808:120b:b0:3db:3b15:7e76 with SMTP id 5614622812f47-3e02a028640mr8555169b6e.47.1725795760934;
        Sun, 08 Sep 2024 04:42:40 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5879:695a:4656:45ff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823cf3a2esm1923029a12.24.2024.09.08.04.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:42:37 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/3] zram: introduce ZRAM_PP_SLOT flag
Date: Sun,  8 Sep 2024 20:42:01 +0900
Message-ID: <20240908114223.3024872-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240908114223.3024872-1-senozhatsky@chromium.org>
References: <20240908114223.3024872-1-senozhatsky@chromium.org>
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


