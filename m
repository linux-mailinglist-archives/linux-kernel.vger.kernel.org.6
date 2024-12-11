Return-Path: <linux-kernel+bounces-440957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E579EC710
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1587C169D65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AAC1D90DC;
	Wed, 11 Dec 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OfcTn4vA"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2ED1D9587
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905544; cv=none; b=BOvnjIJyJ80yRW4t+VC7GCUYFKUSpwu3JQx3UzMGbMh6OKov/X9uLwshjyJjEwPsalt3+W4ghC49fbRwXKLQ8aR7PtVp3uxmnYsKKRUwwsi5IHJRtKy09/s/U9cKlyzUJ+jAUf4xQ3LEmw/BdZBsG932jQfcHxzopyi1JOjKr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905544; c=relaxed/simple;
	bh=NmafERao6+f990Sr/ZpzmP5eALhaxDZMtEn8LZbeMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK29QtXDq35ERcXl1h1LiCjJnqOOPZWJU1kOLw5gorIut5KW3VknUoTavCHL1yXkEmFGVcawUV2x7eNOnIgVDyffKwhaYq8rXw9V/vO6t6v3snYOQRbMfyB04JrN9Da6QNfKCo8FadyOKjFxy6IMGuGwoJjUIAETMWrnuNDld7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OfcTn4vA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728f28744c5so159739b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733905543; x=1734510343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrit5dWat5+KEtfzWEJoDf25m2BEg9CZE40GlSsUXhs=;
        b=OfcTn4vAEal7+FISc6md+5UZRLc7Tcdu5QG9IRtvT8M6R4FZFiJ8TD7+eBpcwaNRZu
         1W0ld9zOvKopW4363I3g7CvDTH8bs0pJSpoS7w88bpUzZF8bsbSAbZdPl3w8Qpu6Xty8
         ADaBoXhe1aaCrLeuuo7Nu4u5Okm1KjTLNKMX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905543; x=1734510343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrit5dWat5+KEtfzWEJoDf25m2BEg9CZE40GlSsUXhs=;
        b=NWTQ5KFU2iu+N8wkyyBPVzYmq7Xxa/RCBr9XMS7BYCwRXSMm7POJ0oJE953jh/u8su
         TqSPYjVkJfz3b/FBcIh64m7xU4QBbmP+25RhQ+NeRTZbLWb2Yv0SwVMwKUlEtCZoItTE
         kTNmCbqpCkWEgdaqCsyV2NbL1yQQPRifaSgaLSA4LbjPU9IOVU2svZDOhNJR6FVGALCk
         Ja0P2NRyq8YNT05syQp/DODA9YGu2ab7SXaIZPjDBSBT8P53oJP4BKsMTifcT4PJ4vzn
         sQsAKSzvBaQ5BwqJy4570Pw9N8ADQk6u96eH9ELom0sojtcWvDAibBpl2Xo6uvajKCst
         04jg==
X-Forwarded-Encrypted: i=1; AJvYcCX3BPtlL6IR+p0E6uIUitb+nusKzBS7mRYCj0ZAH4LYjXUQKP6aAx+fZyR0L6ESg9/yha9v+mmuBHl2ozE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7nYL00FV6DHMvfpGmDqUk2P3bdW6ZQN2pxiCYJfpzNEr04aB
	to+cnaYnL2OlkLSI28seirfDX67c0/uHbNWtBvCzE8pjR+AYYikXWz9BblFWkw==
X-Gm-Gg: ASbGnctjz2WJQHEH+rN/O7sr9xTPWyRqNsEZ4AXA9Z0aqyNCSMqo+oO9oGlXBmqD3gq
	k31hxHfZRkHBeSWjSupDb2bTTih/dObNu7Kp8BWT1ubuJ+ieAIAxJvw95nAZAmEh/ZNuwnq2EG6
	oGJ2hmVfQsuXYVxvUZG5lYnrUjSrEA6HAInWr4CHTAW3x1d83+gdbLOlJtgSpsyzPtrmzcHFfxq
	mu2iRxwXyq6857PFXjX4K2Ge2ljV6Pm8e1hRnOFrlMElHMSb2tvN7oU
X-Google-Smtp-Source: AGHT+IHKEJdrtngzC8pdZ7wnMxsSoVeaJZ29/neyDE/CkEGzgcGwTEW4V14t9NPjwEdTRJ8ZW/tuwQ==
X-Received: by 2002:a05:6a21:3990:b0:1e1:a0b6:9861 with SMTP id adf61e73a8af0-1e1c12ae4d1mr3756909637.12.1733905542792;
        Wed, 11 Dec 2024 00:25:42 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725c91baf30sm7766543b3a.80.2024.12.11.00.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:25:42 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] zram: cond_resched() in writeback loop
Date: Wed, 11 Dec 2024 17:25:31 +0900
Message-ID: <20241211082534.2211057-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241211082534.2211057-1-senozhatsky@chromium.org>
References: <20241211082534.2211057-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram writeback is a costly operation, because every target slot
(unless ZRAM_HUGE) is decompressed before it gets written to a
backing device.  The writeback to a backing device uses
submit_bio_wait() which may look like a rescheduling point.
However, if the backing device has BD_HAS_SUBMIT_BIO bit set
__submit_bio() calls directly disk->fops->submit_bio(bio) on
the backing device and so when submit_bio_wait() calls
blk_wait_io() the I/O is already done.  On such systems we
effective end up in a loop

    for_each (target slot) {
	decompress(slot)
	__submit_bio()
	    disk->fops->submit_bio(bio)
    }

Which on PREEMPT_NONE systems triggers watchdogs (since there
are no explicit rescheduling points).  Add cond_resched() to
the zram writeback loop.

Fixes: a939888ec38b ("zram: support idle/huge page writeback")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

 drivers/block/zram/zram_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0a924fae02a4..f5fa3db6b4f8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -884,6 +884,8 @@ static ssize_t writeback_store(struct device *dev,
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
+
+		cond_resched();
 	}
 
 	if (blk_idx)
-- 
2.47.1.613.gc27f4b7a9f-goog


