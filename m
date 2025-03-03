Return-Path: <linux-kernel+bounces-540888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72AA4B619
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C6F3A50FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095F1E8847;
	Mon,  3 Mar 2025 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gkiot92r"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59D1E98F4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968755; cv=none; b=NB+uM3sfzTuGSXv2SoAUS4JLqGjsUucC7dKVvwHwGPgoTekqgpJ9V82c6uCdXYCXGC/jc/0P1QA1WATOKA89c2t+5m/jgo1uVj9QaPS7+b86TT5+QBG1jHQEAs1WjRoeCTyGS+H5iUpZ8kNw8HSrhynS4f68XZwlBY3XiyzyKfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968755; c=relaxed/simple;
	bh=nq698JtCOHpeNKIC4Ok0mLG99cT8esicaS6FMZLlIWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSHwZMtN0yGaNkdo0e5hdYvLkSkF5oK/xTZNbdccdqErsNnFZ17gkXnyhkl9B9Sy0MdvdECmUStFC8p550bmLPLcjrS+/Rm1w2vKWEgvrreJdqjjbhZLDZY0/bauF9n5Pvv/5a7FVrHIWnJCPXnfkG4PsNpKBzL3/oterGIc1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gkiot92r; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22356471820so59496305ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968753; x=1741573553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9V04z24we0PKbaMB+rapzgCCE9wJRDyCG7EP1iiRhA=;
        b=gkiot92rZmadQ/IxCsYqFxW1Rk2PE6u87nH3VXclSUVJ2UZ+tBSjjKFeUYhUjt27VT
         eliT4WfFSw8n0f+MzgDrJ34C6v+6b6a6MINK5vRF7igjWtWUqlUn4ZfCIfrVMjlZCk6c
         1WaJ8MDlqsIv3gWlO4GfELT9LqeL4VXDqjZMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968753; x=1741573553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9V04z24we0PKbaMB+rapzgCCE9wJRDyCG7EP1iiRhA=;
        b=sBmZ9l8AYwKTwZt6l9hni75G2vr4pyar1PA+5S5qB0CbeNc1kojQRzI5qh8WX2d3ds
         NvmmZRsspFhT7iUCAh+1Gu30di7gHftSy9zJfo+T+XVMGwk3gVL75fDJ4v4OF5wYVsAy
         dkC3LlxDxHjoxdEa1ICNpRJh4ixbfD2lfIuYV56Ve5Iv1o4CjPZj8v7RyDX61IRtYjyb
         A6jVXmwT1OCgcU1eQOZJ5m57ku7CwpOkIz6Z+Yaf9ISiGkgWIW3l3Gn4KjpN0TNIS9Jv
         BaTnbt0QWB/05RzSrrnMNpysaVvnfshMVKGt01LoiPV9VmpAvImEYpFw/rqOQTwoZViD
         Rn4g==
X-Forwarded-Encrypted: i=1; AJvYcCXnPDGtHYMMthkZnrOVGElnYwGxR1+cpL+DS9XuIMmrQqj0eL5ImdwDdfqql3uvYkd9vcfHA+A/I+fr/9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPO1qADETv9V5360KzZU8BQ7yJ9lKJXxHn/i/wQHlPxGV8yMX
	rRw+Gv+upGKqSseqGUkhkVTiKLI6QKlk0O2MuFI6xmKD4y06AtmerCOgTQWYqg==
X-Gm-Gg: ASbGncvRn2X73rYv2anTgfQB7ODly4C297U9yqrzOmDuy0sL1yJSDzR9187u5BnX505
	pV1/1XtpGb9AwvQO+MFRWn93LCSoG2kKduVWkYz4pDxUwk9+uapEV95Z5aTysQuH3wrx6+jsG79
	3/z/oqlAguqCM8yZTFX+254D8Kj4Q5IYRHD8jjCXxsELkqzYquRek2BgnZp6rdK7oVJr0/qg80u
	LKZy0jnbCseBEiLkGMSwcYR7RlIv2ez3y0Hdk+U8DTuNsoN0sqm7nZyqJ8XoHVmxQSNdQChjdAu
	co3CXu2adcDkt5DXT1fYXJpjYDujyF/2gZkD+DeZYfkTmCw=
X-Google-Smtp-Source: AGHT+IFRGkg4HAVHTSk7P/5WiDLiMFVD4ws7CbIAd4dpZ2NPws7biEyrBHhEpztlue9ApQq6yVEBhg==
X-Received: by 2002:a17:903:32c8:b0:223:245a:11e2 with SMTP id d9443c01a7336-22368f71ed9mr148206025ad.6.1740968753298;
        Sun, 02 Mar 2025 18:25:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c7f12sm66879285ad.122.2025.03.02.18.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:52 -0800 (PST)
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
Subject: [PATCH v10 16/19] zram: permit reclaim in zstd custom allocator
Date: Mon,  3 Mar 2025 11:03:25 +0900
Message-ID: <20250303022425.285971-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When configured with pre-trained compression/decompression
dictionary support, zstd requires custom memory allocator,
which it calls internally from compression()/decompression()
routines.  That means allocation from atomic context (either
under entry spin-lock, or per-CPU local-lock or both).  Now,
with non-atomic zram read()/write(), those limitations are
relaxed and we can allow direct and indirect reclaim.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 1184c0036f44..22c8067536f3 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -24,19 +24,10 @@ struct zstd_params {
 /*
  * For C/D dictionaries we need to provide zstd with zstd_custom_mem,
  * which zstd uses internally to allocate/free memory when needed.
- *
- * This means that allocator.customAlloc() can be called from zcomp_compress()
- * under local-lock (per-CPU compression stream), in which case we must use
- * GFP_ATOMIC.
- *
- * Another complication here is that we can be configured as a swap device.
  */
 static void *zstd_custom_alloc(void *opaque, size_t size)
 {
-	if (!preemptible())
-		return kvzalloc(size, GFP_ATOMIC);
-
-	return kvzalloc(size, __GFP_KSWAPD_RECLAIM | __GFP_NOWARN);
+	return kvzalloc(size, GFP_NOIO | __GFP_NOWARN);
 }
 
 static void zstd_custom_free(void *opaque, void *address)
-- 
2.48.1.711.g2feabab25a-goog


