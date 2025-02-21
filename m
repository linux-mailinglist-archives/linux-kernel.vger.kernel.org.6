Return-Path: <linux-kernel+bounces-525511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E89A3F0BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABD27AD42A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66009204C02;
	Fri, 21 Feb 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zd1gDhsf"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95C202F96
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130815; cv=none; b=Bsd/Vzdp1vairMDZLPAlRjahRVZarjbZ1H7RNlURddROUV45poiOAxhrAeIc/74I3QYCF0e0XNfYvYdP1zWotQSIaPNL1eSQxxoMmjxvzHMAEET60mMbg5wCUio4tyTSmkAAqDBZPuOn5R0mKDZh8/Y2BvxA9d5/jFs0MEsgNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130815; c=relaxed/simple;
	bh=4ECjkVJZGjCWtN7ZuQfyB0BeUv4fd6cOc0FBKhTa2+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXt3LpuhsakOJC+3HhPn3G04ODfl81ERuYVcuViUWT2+qqxLZfqeJJItT/xw/I8IMNWg5kiVPRk7GhIh9i8hVnslXC/EmoHbFFZd0R8Jp+tWlVnOCXu7CE8TzD5oD+9nwiN/xd59pTHG5W9GjyQPsxbFosWgQ6M+Qx1URjAPdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zd1gDhsf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220bfdfb3f4so41200795ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130814; x=1740735614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hGRfBbi2fKBhcLL3toY8LXz3XIHS2H2SZvxy9aDrUM=;
        b=Zd1gDhsfe/LCUDCr8ess941Es/4yq0VhSr3dFY5L7CtOcRIyXNijhq32mZH9D3bCVz
         dxgVtkPRibT9eLFmp0S9l9lJiGkuXrljAxnCUA4fSrpalPR6bEp7oMLH0q4s1nGYqGu7
         1k4PjlYTsze3GUMW3byN1DQUDcNMKldRJ3InE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130814; x=1740735614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hGRfBbi2fKBhcLL3toY8LXz3XIHS2H2SZvxy9aDrUM=;
        b=gaPi9jsev+ZACUF94+5JATL0S5f16wZsWCiPkldv0xK/noRhAd21Tw8TJrugJU4SEg
         fk9cSwJhWraetpgV/S0UlGxvaP5NBe60fqQEcoOZ0t+eou985f3cyrPblrn1tsoicHrb
         xdqrk4TCT70qQENZrTddNk+7ZcC1pJ8XEPE5m7H2XtoxlV4EU8almjSdmwaY7/n11s8n
         iZdHRymHhTFPINXK1ECc5Te9dDiK4Q/DPzbsg8Q87hGIwu2O7fpOecenNGP+PZx6Yhwi
         K87A6QPOnJRHgl8ZQvSqii5ayoyJqXlYe23N+q8C9NgTi2Rm8FG0mO15QFkyArGg0mSF
         PnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk7BhvVF3XU+hlXZmRaZoAW+u8VZFL4OVFprbASAJ/IA5WOhqZrUf1EIrHjbSMGBXy5/TebQxignHheGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwITNZpXW9Z4Q7G1K63nSROP02onOq8IIietHGPEEsVhgS40YWn
	A9nEUoNfeegRFbPvo6M3DNpZQdGlH7HJSDlgw5OXlKEDOzAiZwaqq22Rl1h8Dg==
X-Gm-Gg: ASbGncvftcbkXjqNeXMmc5D3Rkp3+JFtyAzqFLV0GoUWEggTl7SkrXRbADKUQl1r9H6
	IjKM3/FHRpz+i6oHbfMBFqw0AD3CkrtawnTVfdbtzykYNwh99g0altFmHogEgpVe7Ew6SOkkvgI
	sf8OOC1hJa+a4RqI9B+hoHVjaQBJXbUAy4BzFJ0pLY7g92kSFlle3kzgNY2x9bOFc+RF9YRI+KC
	0hdE3hCsoUeg6JTSUFr2U2RrDP880JPH0qXJ6KI+wtEMiDVgDAoMUsQGqdmKGj++wJCuq5Y3Guf
	gHbBi+9pX75hy581yo8mIk/x/Gs=
X-Google-Smtp-Source: AGHT+IHnD4WYtByveH7o9SWK4ZPshLs+PqzDTaY7xc5G/UiEwzsRQaEFLwJdetxPgoe922xVEvOq1g==
X-Received: by 2002:a17:902:e892:b0:220:fae9:8a6 with SMTP id d9443c01a7336-2219ff3127emr51606815ad.4.1740130813846;
        Fri, 21 Feb 2025 01:40:13 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d051sm131952525ad.108.2025.02.21.01.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:40:13 -0800 (PST)
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
Subject: [PATCH v7 16/17] zram: do not leak page on writeback_store error path
Date: Fri, 21 Feb 2025 18:38:09 +0900
Message-ID: <20250221093832.1949691-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
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
index 48639a48ddb8..7a5c5b861fe5 100644
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


