Return-Path: <linux-kernel+bounces-412743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9989D0E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255E11F227B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B647119538D;
	Mon, 18 Nov 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4k+a7vY"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51EE194C8D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925874; cv=none; b=XRERD8ZWDcvJFdhiKMrwkbjQkCgNQgSdPPvdzS8SXAzdPP4kCiC+O4ycKtM4eFAjW6j/rhg3Dlq3wfWywyXaJHsOk30N4SbWCl9xwEIXWkERTWdfQLBFQU5UzkyYGurIAttXFjzQiW2fvy5sgQECPUKzoZ9StbTlYoNoOqqNWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925874; c=relaxed/simple;
	bh=j1fz5OKcxtFtYCZ1AdIFbpu/JJQZ5mET+VDZ0WiyZxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADxfIlLzQu/QfvHb7tWSxRbFaG6zbrFjW0E2LWoZoB40BaUBOw/0rt7ni/SNaPhoHhVg7Doiv51ZL4gUqzkwtFuUMGWO0et9PNeoXo548a+PLGsPKEFVegxoA7E6Q4HwimJcCi5HMU9F0nJe2I+o3Yj1TzZcD5EcOfOUADt1T9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e4k+a7vY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb47387ceso39722065ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731925872; x=1732530672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I32VO0apGgp4lSLTII1ojr1S39dox5QX5dFI6JIsBCc=;
        b=e4k+a7vYHBa+NOO5LyWkplgpDnLAWSEWbBE1S3Y50S+SLtCZojy2QznE+12SaYzGzB
         PZZfVXBKfJp30nbhWOsbYq1AuSG59Ys+enhItUE2gPA4YtMbzgeyRMtw77OxQYcbOrOQ
         fnxXbhJTBSGRE2v1kMM5HhNR3CfhFLi/QI4ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925872; x=1732530672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I32VO0apGgp4lSLTII1ojr1S39dox5QX5dFI6JIsBCc=;
        b=FG2OX1+tuARC1ZUzgChDHeSy0APz0+K4rph6W1S3AbpMFsui96dShOTwFQH8Wg7ruB
         oKpmX6xAZ3hpcxAVslWz762bvkQR3AKjFssTIuKx/FrYN25eqGoDlJraTBwkeZaK2ROJ
         sB7MwYMOSzWMW4Ti7BK7Hup5vTwakwK4LJNEiEjIyYBxSDuYtxKYWvEWgy2481/iC+vf
         Frt9aTC6iaLKPgViMCTioJx+Ry/dSJ98BkRFcZs1DkiI6ZH5x3OZSH6n4Ru4M+cn8R++
         W2PrQgPvhZVVB2pQ7SmhYBwA84/VIQSEEr/yDZzQG3uKwJoa2b1jYx61KzItCEcRsh05
         qRjg==
X-Gm-Message-State: AOJu0YzUpE+5y3MZHc/Q5o2wD6e0jkNHGJYso7sWdA55VpXd4SdUFWI0
	2CdHfJMgFw+cPlnq6A4OXxWjFSl88sO/X1B9az1ktwHRDKbvrhB/7aksKszAng==
X-Google-Smtp-Source: AGHT+IFoGGct5z8epVdmpuexs7KBF7JTmI34F+LDla+ntNP+aR67ePG2UlBhF15sO6NZTrd1/iZTxA==
X-Received: by 2002:a17:902:f710:b0:212:c9d:5f62 with SMTP id d9443c01a7336-2120c9d604amr74698155ad.52.1731925872289;
        Mon, 18 Nov 2024 02:31:12 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ea56426954sm2895527a91.42.2024.11.18.02.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:31:11 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 2/8] zram: free slot memory early during write
Date: Mon, 18 Nov 2024 19:30:33 +0900
Message-ID: <20241118103054.3191944-3-senozhatsky@chromium.org>
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
index 882a32d46a75..987d72f2249c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1640,6 +1640,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
@@ -1728,13 +1733,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
2.47.0.338.g60cca15819-goog


