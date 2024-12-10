Return-Path: <linux-kernel+bounces-439399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DF29EAEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2373160EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71667212D8D;
	Tue, 10 Dec 2024 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UeBfT/C6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB52080FE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828076; cv=none; b=PBI55+f6edqdLnr+zAYBnwifWdB8aABAWzwHO2V58JkSRvx2mwrM+XgKb8gGCG+gF5Z60GbCtRwQXc8Kl37IakZP4O3rB65v+DzUKOMwoVsGNOJwyB6/Ef70Oycoef11ceR/QLPZBn26MFgle4qb8/gDfBDm5JgYnkgTj97PFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828076; c=relaxed/simple;
	bh=lE+1kRH1U/7IVQo6hTz7tDbC7zT0gIo9rITcVmUZ18A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG+wVsQhxoPAV8WJi+opw1WrwuNQ1klEgQF7clv80m7YLiFagR1lI7OM8X15f+/WzCv1jS+4t2jewYBYff6dXwAChscC/tmZ2U+18yeLTApC/nqdlRA5PSYcJcT0eg9Zwu4ZyMo2q62urCHvkxaZk7NKhzKNoljnt2yY8lXNqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UeBfT/C6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21619108a6bso27809865ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733828075; x=1734432875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATNOyPUUs3gPB5Gzn7rO553POCCitam43iQCzU3DuAw=;
        b=UeBfT/C6NzRz3sU0+Uii8ZZl3fyuQhipmnSJjsMcSH+kSwPJxqUIOrKPipeF1bRX9h
         X08xuwGsKlIJJ94ogtM1eExs8ii9+5ER/c+1/YOzltaJy6RtY1En9GQOxm9RFlnfVINJ
         PKW+xcOiqufHlrLy32qxSuT2b4M9viavA884g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828075; x=1734432875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATNOyPUUs3gPB5Gzn7rO553POCCitam43iQCzU3DuAw=;
        b=BD5Wf6/qzg/N69EAQeQv4KCv36u7+Rhi7B8Az/fKrazM0L8Vg+953yvzM6g2g34S9f
         5V5PUHWiMK1AmDBqreefr4cgo9nx9ju8sqNnKcI8bEKecxIHqtQgie916zzgDoC98VQC
         MrD+IHEugthJJMNZxxqmlbWtMEJdkBhoCOr4o3mfO8KK5Iv1wlj/I0gq8nlNlfhl5Rx3
         pFKjTkjCrjCwY/fpAsk6AYsSEUOj9Pwfp5P47jgrQHp3u81Rmj+4wgqJf4U8elTr0bPH
         ocJ832gnDfud4cYduQrRmYzamur0fGBbY7lqNhErLwZF56o2FePYHGrxC94kZm4rPvpJ
         rZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrexj06y9B3XC4tHsYM3Z/erpkGr3MIZxePyhGVy6lxsOS48aWLTacjne+qj14ZXBXP/eWAIlsRqbjr1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoP9x1Nwq/+XAGs1lAQoD7RBKCQaf0H0PnlMZkvTXmFhrQ6K/
	20cuRHouAg2GhUFCarQAj2+TcW1WwQ3MVPVojLM5ellj1eHQ0rjK6JNb7+lXFA==
X-Gm-Gg: ASbGnctG39r8qOVgOCzbRnNqAhpJVs2g26vHgbIISuqpbCp8yRKQe4x0k2iYyW5+dcj
	8OSIOnZRC85PeWWET6PQwUb/heiEw4bPpiIA2032c93FUhygYyxIzyj+lA0jaR88PM5DPZMbH/1
	1HFlQQJptTUdcn35qG2mro6tzujjA+xDBJXcSGJIFA2ZjXhIMcvSOCM2uBc2g4mhlvF9zsPnmFf
	CVr+u9jroz6Rjf1vgDwJYTPbugorEWTqvnb3KVH7Kqd0hLx8skByohZ
X-Google-Smtp-Source: AGHT+IHwqm8mlfj88tt2oDbXl2G2KOx142k+H+H2T7ahDyGRc12eSz/W7yAD73omKWT7c7y3DLD5LQ==
X-Received: by 2002:a17:902:cec2:b0:216:4263:133f with SMTP id d9443c01a7336-2166a0bc05bmr51425815ad.57.1733828074786;
        Tue, 10 Dec 2024 02:54:34 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2167504c525sm9825525ad.12.2024.12.10.02.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:54:34 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/6] zram: free slot memory early during write
Date: Tue, 10 Dec 2024 19:53:56 +0900
Message-ID: <20241210105420.1888790-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241210105420.1888790-1-senozhatsky@chromium.org>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation entry's previously allocated
memory is released in the very last moment, when we already
have allocated a new memory for new data.  This, basically,
temporarily increases memory usage for no good reason.  For
example, consider the case when both old (stale) and new
entry data are incompressible so such entry will temporarily
use two physical pages - one for stale (old) data and one
for new data.  We can release old memory as soon as we get
a write request for entry.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 172546aa1fce..174b4053189b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1647,6 +1647,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
 
+	/* First, free memory allocated to this slot (if any) */
+	zram_slot_lock(zram, index);
+	zram_free_page(zram, index);
+	zram_slot_unlock(zram, index);
+
 	mem = kmap_local_page(page);
 	if (page_same_filled(mem, &element)) {
 		kunmap_local(mem);
@@ -1742,13 +1747,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zs_unmap_object(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
 out:
-	/*
-	 * Free memory associated with this sector
-	 * before overwriting unused sectors.
-	 */
 	zram_slot_lock(zram, index);
-	zram_free_page(zram, index);
-
 	if (comp_len == PAGE_SIZE) {
 		zram_set_flag(zram, index, ZRAM_HUGE);
 		atomic64_inc(&zram->stats.huge_pages);
-- 
2.47.1.613.gc27f4b7a9f-goog


