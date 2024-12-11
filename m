Return-Path: <linux-kernel+bounces-440956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201BB9EC70E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB70169524
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32F1D88B4;
	Wed, 11 Dec 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XVdZ5xkm"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0E1D7E57
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905541; cv=none; b=TEyiu06HFaS9LcQ2TW4l92MY0I3otDlnada72oID28TcVEaAYmlt9EvI1e+kkrCWjf8eGGyLyeI/eGAy7TcBoEu2b9X7nVKSInj0kfaYR30VFzCTmRcqzavaAJLGuy/DRV5ub2fbj4h+aT4iHpZx9UoxuPBBM8wU1MQpWaXYJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905541; c=relaxed/simple;
	bh=pdUVcHtSvWlmyaynBCROp5scYokxRBlmfYPDAt3XE50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJ4gXWB0gcCOoTvPphNorMtMu4NZChjWlJDrbrRBeqKECUUCHrgwjyOu+gUTV4mn65OuPM7qD/kODl6spBIpTscGTpz+kG/wbgi5L3lv0vQsjTu0ElwBikvWapdb92nQpZzQPWZCbTf7ciErv1n48GKaWAZljOssXJoNGvCwXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XVdZ5xkm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so2679839b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733905539; x=1734510339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpFrEuRxuJLDjBCvW51G0SAJ1v38zE0w8k1cMiwV7pw=;
        b=XVdZ5xkm135IvqLdCuVcgNpUTjmpBh92fdvzF2oKakRZI0ocFFW0OoN5IMRKVvHYVB
         uODRVX68QyIJeUAfzUGCkfb60jzv9wWnVh2A44Wqy7X3tJfyJengVMZe5yNKRxU1SmNm
         Q9qwVjIvQA3X7Vf35RyFZUOSTpao8NlCJxjZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905539; x=1734510339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpFrEuRxuJLDjBCvW51G0SAJ1v38zE0w8k1cMiwV7pw=;
        b=qogTb7Ivp6075ptZLfWn+8uO3FoJ1KPTEgjvi2RaErYI9Y59tkrbiZGUH+fV8cSyB2
         2sqdQXf2G6eH5IxQLJfCKjnLJQHY+2EbxM+07CbaAy9Gjb3LmFVlCPlJGWTwER5UbCxT
         8WxndPkYFS/idLex9yu9zUbO6Xcj0FshwXBmrPsaAvwuHKQJIwAJ8/6ekQLNp30hF7/a
         R2IZsoJk7hUqaeg4vC8RZKQL0JAVyB12jKrkIV/XZXF9JTRJKesZmDSdcJ4AFF0/bF3t
         2ZrpCffo0WDW2bTGIbtjNl3Ad7cqyEbh4y/Tci8sCIpQ8bNBTQT/G6x/S6DIe/JnpgSy
         6MNw==
X-Forwarded-Encrypted: i=1; AJvYcCUFhxxEPPwurFzv6c+156LsayomYC0pl46p9yV2/Mp6V/5naImSmv5VAr1CdOFuVQkEFT6RgVigtW1c/BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIDSNYM3cSb1vh+wMalI3Qnh9Vh6+Kv/ktI3AVUsUZoovAmhJ
	e5WqVG9pBtRCr6WGLJtYildY2f/hifQ4457CVmtKh9YFtmj3kV8DypH2MK73eg==
X-Gm-Gg: ASbGncs+Pkyp553GGZ05EHD7m6xyFkICmPyYizH+DazjpCZHdSTY/xMU13CrQKdDuRW
	vmVzU5DRA2009iDjxivjv/OcfYnib0G5nILCYQMrKY7shIewf+/yNxXz5yaKFFZAt7gWKl3QwdC
	qb8KJQw+5eguFelt/7/IFAsdhYidmFXW77PyWmRMn6Iy9HXjCEnUb9AhBNzmPOGxfFbEITBG4FP
	SVjqoTLxrfOmNQUnAz589c7pUHh+MI5RIM9U/4RU2khIufL0ztG3mQD
X-Google-Smtp-Source: AGHT+IFc7pqcgesJ91tbY8xLMjE+g/5nPNs3Li9kj5H7bFUMYzH3ATBanvEwOFKlDM8DKU9Vn9huPw==
X-Received: by 2002:a05:6a00:4654:b0:725:e325:ab4d with SMTP id d2e1a72fcca58-728ed48ac16mr3214398b3a.16.1733905538927;
        Wed, 11 Dec 2024 00:25:38 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725ce12cfc8sm7609381b3a.28.2024.12.11.00.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:25:38 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/2] zram: use zram_read_from_zspool() in writeback
Date: Wed, 11 Dec 2024 17:25:30 +0900
Message-ID: <20241211082534.2211057-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only can read pages from zspool in writeback, zram_read_page()
is not really right in that context not only because it's a more
generic function that handles ZRAM_WB pages, but also because it
requires us to unlock slot between slot flag check and actual page
read.  Use zram_read_from_zspool() instead and do slot flags check
and page read under the same slot lock.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

This is not -stable material.  The patch simply makes things look
more logical and corect.  The page content still can change while
we are in submit_bio_wait() and we try to handle that when
submit_bio_wait() returns.

 drivers/block/zram/zram_drv.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d06761ad541f..0a924fae02a4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -55,8 +55,8 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
 
 static void zram_free_page(struct zram *zram, size_t index);
-static int zram_read_page(struct zram *zram, struct page *page, u32 index,
-			  struct bio *parent);
+static int zram_read_from_zspool(struct zram *zram, struct page *page,
+				 u32 index);
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -831,13 +831,10 @@ static ssize_t writeback_store(struct device *dev,
 		 */
 		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
+		if (zram_read_from_zspool(zram, page, index))
+			goto next;
 		zram_slot_unlock(zram, index);
 
-		if (zram_read_page(zram, page, index, NULL)) {
-			release_pp_slot(zram, pps);
-			continue;
-		}
-
 		bio_init(&bio, zram->bdev, &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-- 
2.47.1.613.gc27f4b7a9f-goog


