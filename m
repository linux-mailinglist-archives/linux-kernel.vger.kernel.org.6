Return-Path: <linux-kernel+bounces-413926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920599D20A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586B2282752
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB971991AF;
	Tue, 19 Nov 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0p99Gn5"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22102198E63
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000873; cv=none; b=CdJUPBxRujXVj5EhxcbSBigC9eMWtRBLWcpK6Z86uTguT4fnW0NVc2P7BEaShuiAkqzWPHZXcA6bCw1TVXtDQqPHaDa/rE7JZIrXw/Ugxyz8TBTpykl1RfUtUu0UsUrFtGNOzcO5ypegUVzLUA5htYoFqUEKl3nGaePU8fETgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000873; c=relaxed/simple;
	bh=SczjJdKEBNX/mqKU8yTEr7MCNMXpYCdEbjooumU28p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFDh42gq1A3KjqzbuyfBSeRK14IhyZoQmreA+zqE3/KslTbWjEPsft46SnAJ1kAL/vCrGccYCuuSG2ZmAvFmjO9HZDzKZnBlI+rrT1HyyXY6lOvknld8xSLDfyptlctgpyvTvzwKtbki19WRTHFiZCY1Dy/19Mb/gXkiC6M0ZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H0p99Gn5; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so2392990a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732000871; x=1732605671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMQqiNmYmiFMft9yq6eBRmUzx8BPO2n9E5AN93b4Lcs=;
        b=H0p99Gn58PDrRsH5spu8M+ZJa6sslM0hBG8nh4JsgxL7FQYg1zJFdTHqYMn8m7z+gm
         xlcNyobxqEqGNxTtl0Blv9RvmrQo8ob+mirlHrmuEpJHOFmF2fwYBoBnF6QjCerCy/XU
         J4QalH70H6Q3h0ilzgBpWFakmlRsYTSRRsd2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000871; x=1732605671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMQqiNmYmiFMft9yq6eBRmUzx8BPO2n9E5AN93b4Lcs=;
        b=JuGynkQlKaYOXg2I5W6ap1NYVeH6fKaajsichPermU+YWcyTV2SZEtBUZ/wWP1EAG6
         OoJTwBRNuICRbCfwKA+xF5HtjzC+V4ZA9qh+4SI7UCZc67CC5c+7hNu1bBAQeePHNDLW
         S5gkJqAJn3+FOmly5Nu9nkS74rIpxLV8lmTtJxpOOAahNxfU1RQVd/0w+xGvvrznyWIN
         ki10+cLBTtNP1RHO+qsB+M6Ut1cw8ajjRK98p1zwEJWZiofFVZTyrWJpGNjJTxlf2GBW
         CDkj4AkyR5+uTdlHFSqHoOCwPWElbBbFFPo4z/ZfUbqyM21BMPi7Wbe88qbu8gR/p38c
         Bo1w==
X-Gm-Message-State: AOJu0Yy+OnL8LvLSK06AxbahTKig6XbO8YTTNfzkGo1gYKN3+OCKTiqY
	X0auHM4wqXFt/WCurcCMylEVmn8ci6fvHhLPZJ+GxLKwGeuHmD0Ged5HhUf7RQ==
X-Google-Smtp-Source: AGHT+IEqmtXnoRwOq40F0SEQzW7Ex0ubamKlsAciS92ROOQnLymwuA47V96kcMUoGX9IlyuX8DpbCA==
X-Received: by 2002:a05:6a20:9152:b0:1db:ea00:8e91 with SMTP id adf61e73a8af0-1dc90afc661mr19853250637.2.1732000871488;
        Mon, 18 Nov 2024 23:21:11 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-724770ee8basm7460258b3a.7.2024.11.18.23.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:21:10 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 2/8] zram: free slot memory early during write
Date: Tue, 19 Nov 2024 16:20:40 +0900
Message-ID: <20241119072057.3440039-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
In-Reply-To: <20241119072057.3440039-1-senozhatsky@chromium.org>
References: <20241119072057.3440039-1-senozhatsky@chromium.org>
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
2.47.0.371.ga323438b13-goog


