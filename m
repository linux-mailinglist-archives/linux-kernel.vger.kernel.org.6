Return-Path: <linux-kernel+bounces-526758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F06A402B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC5A16CC3F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22365256C9B;
	Fri, 21 Feb 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O/4TfJbu"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B06254AEC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177100; cv=none; b=jWTF5IRS+J0OhcB7TpnaunORFo8i0p+u1lcbPEToxhS466ZpcORrGjq6Lgp54J/snojcI152sTJ/1Xdy7Vc8/KrAXFk+L3WekIu6kZAQea/7Y760bcrgBgmu8+f1+ZUpf61dwHqtDIsFEs7cTPkU/HlayVBBcxOV2ZG2gse7moc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177100; c=relaxed/simple;
	bh=ArBd8fY4nmFldglPlUQtrhyZTTykwzeoztjFAtHonew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYtxosR2f8TlFrP9trWRn7Fs9rw+ZCzi8xxCV+Bm3w7s45z5zjl1QqNXDQXyEwfOZcDJuBGQjIv9cX+fzwXCe2ZrLADBf0KI1dctZIs6D7CLG+iRCVNGHvmiD2x/fZriMd4rnn3Vq7tv36aDofZevwJatj8sH3rmTZtWu2STi1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O/4TfJbu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2211cd4463cso54074625ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177098; x=1740781898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR4o+z78q2mq61XCgJA6k+y16NepOIdls2rvyffegGo=;
        b=O/4TfJbukKiaK7FYAfsLLIMN7DoSQU2Jx36nloWpkcz5BVf5YqulU9d0W1v7t1iMEu
         Gvf/UpSVvV9f8JyYJj8Dds8hLwSXhxyMkk8TL5F/ACNSlrh7zC0UQOgfyvr24KBbVJJ0
         2Au6wY+cYGhjjLYQ2ezVAuEr9dofeg0wpqW+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177098; x=1740781898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR4o+z78q2mq61XCgJA6k+y16NepOIdls2rvyffegGo=;
        b=LFwLr1yvS64TgCFCQWPfFALI/SBZIvOJ9K/ssrAyuKrzwBXTVYBzeEdpX5v/3s4PYX
         ZquPSRudr9cb9OVKsbTg0a6o5PBdgSRLaxIoMAOIcNrt6vhp1QadxfOSvLRlvjkPt+My
         oTByG3xz3906ibNqSaMjvN6M3fAIE/dlDVUOfX181DpN+d5I9TfqWsoiV6oBKTyqljf/
         BjS07X6WOxxeoPk5v6THvyPm11vYdMcyS7m77ahQljOQUUvNZSAL9J6O++IyxhzDHe0t
         XxfbCcrMnChzdq5Zfq2JkMr4m2i57LCDLIl3o8okXflFVJr1bPscowWgGe8rgP8YL3K6
         Xi7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa9CPtYBK3jQ2UlLP35B1mdzevlODi3rO/w6AqH0JUjkbpz8SzlcgBJRHu7syhBXZUPTbXHUCKof6ZfBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysUthYO6wYTWVDTatNky2+t04vlCM7J0FR4boEyTACvxdMeRSc
	eHjODvmjPQa56cP3JGCwzK5/vYclA0FynP0j6oExYYC6zPVyUA/UfbNgcb4a3A==
X-Gm-Gg: ASbGnct4gcxB1dZ12Xi8SY20WjwNxhXb6On3jY/VW/OPFLvWGLWJkGV+/NMo6KbhoOD
	o6LtYsbOG1uIYL2YIgcwffYu/Lo49Ic/3Vwp8BNHdHd2DyLBVUhVC/Fh4m8/B1mvvQhERp3k8as
	eMYIW9fgQPWXmiq8DTi9UV0eykjiMvGEdhoDsGoMwqcK1nfRi7lVeZKS0kg7T2wCOsgeRTZmUzC
	BBSl5BBeJQ6DxvFipIFj5Tf8ACrUq8RXDbVxLndAB2YHz5ptszaPJbvL9uSCvi5hGDvI0ygF+M+
	sxoSjynJQ4E74fT+yGC80rtfskI=
X-Google-Smtp-Source: AGHT+IGz76l7D3zW41L+K8j03WiqF3YSL7loobTRLV3etxTMk2gUtAOA9cHRBz1EbaHcXZjvwLcRjA==
X-Received: by 2002:a05:6a00:a01:b0:72f:d7ce:5003 with SMTP id d2e1a72fcca58-73426d9059bmr6835280b3a.22.1740177098531;
        Fri, 21 Feb 2025 14:31:38 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242546867sm16266956b3a.24.2025.02.21.14.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:31:38 -0800 (PST)
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
Subject: [PATCH v8 16/17] zram: do not leak page on writeback_store error path
Date: Sat, 22 Feb 2025 07:25:47 +0900
Message-ID: <20250221222958.2225035-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the page used for local object data is freed
on error out path.

Fixes: 330edc2bc059 (zram: rework writeback target selection strategy)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1da329cae8ce..4e9381b153da 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -792,7 +792,7 @@ static ssize_t writeback_store(struct device *dev,
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret = len;
 	int mode, err;
 	unsigned long blk_idx = 0;
@@ -934,8 +934,10 @@ static ssize_t writeback_store(struct device *dev,
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-	__free_page(page);
+
 release_init_lock:
+	if (page)
+		__free_page(page);
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.48.1.601.g30ceb7b040-goog


