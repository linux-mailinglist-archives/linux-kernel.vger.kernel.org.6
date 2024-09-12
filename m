Return-Path: <linux-kernel+bounces-326065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3E9976216
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FA71F239EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120018C321;
	Thu, 12 Sep 2024 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R8HULKJZ"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DA189F2A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124666; cv=none; b=ox5TWyJacWhmoF8Beo/Hnv1k+rZ/b+w5f5sn1HlzS9eHIQ7d2omO0rTd7KSyRkGgdxobafKELvZ62tSKxXVjq5oxIfnUzZhGzcKlXbrDZB3pV+uQkjQtEa8+gBmR3Ej51ebZ7GBoeU+5skuQGygS8Ydw/jo4E/7K0RMWHhV/wnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124666; c=relaxed/simple;
	bh=cMrFZFeYshEhBFOfKSSKpG6P8VFIuhAwYxrlWBPSmzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tErpTQUPDtRZF8uPvK8XVAhY90LkCtIb6bhdH7lEBeAHui+V1AypFAyM8RCeir6OGBadcIlJ6ZtFa9CfZG7064WmtiTJ/O+vMCjmdgeZxGD4F93UJCNiRZRIvk2jUBh4fprTn+zFmghnuMB5IkR7oP6ja6f756BlsKo3fkgEiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R8HULKJZ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-277efdcfa63so269872fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726124663; x=1726729463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwMu+l4YrL6K6neHxIk3gwGHEtDDHlzEJ+d/igKF6jE=;
        b=R8HULKJZCjJOh+d0J4jYm2LPlvnUN/TlvXO9vIAZMOuZWQ3i5RdbAagfPQXjMgfq+V
         pkNrqSQzPGF0U7mMloYKQnW2JiY6ND+KmdX7xeMfnD17WRK/4fHTc8r4+Zqvzvdj7I/3
         UnM30pd0IaGbHw8fSEo3fgeP4DMUOAA8y63JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726124663; x=1726729463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwMu+l4YrL6K6neHxIk3gwGHEtDDHlzEJ+d/igKF6jE=;
        b=GIlHPaEWIQ/QOfUBo/69ZJY++IrAMQ0XTSXkaksZoqqNKFf148uzGFUScVvELO8B+g
         /G32TJAHUMWD7kLZRz/KxWfO55lQKbRrPaJsktyTHDyCZEnXxHS++E3cuxO+t94z1pfY
         QYeRYOzEcROk6c20NZynTc6VP+7rixNtstls670/tIxMjzqbPSwr9WVCGUa1Ojzocgc2
         YWtzb0RLXurtMqNBvT/UvogNbYeSxGE3TzI01NN7seKGMh8uPhJr6+sTPokB02tvARJD
         Ou76oOT5vnVRvfzxZuBTRDgR/hMtdGKchq3DGt0VZO1uznDkBdrFFBbcpc1smWXXVxU6
         sYIQ==
X-Gm-Message-State: AOJu0YyyVDeB5t+G5xV15TcVSNrPAflcgdmey7GHJJK3SX6ecsSDqIym
	mnBROiuEXaK1kCI6UD2UdZFuzDOsYVVdEuF/4VZlNXNcSyj0QYnX2+rscqYCdQ==
X-Google-Smtp-Source: AGHT+IGwcigeArG87HZCWXsUWOzefcpatw1EYMe7A1pLPrG4o9yaF5072wBhWhAl9kCLBq1zno9Uuw==
X-Received: by 2002:a05:6870:1606:b0:273:da6b:9a3d with SMTP id 586e51a60fabf-27c3f313a5amr984354fac.22.1726124663688;
        Thu, 12 Sep 2024 00:04:23 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:2fb2:d683:de5d:c3cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5a23sm1101543a12.31.2024.09.12.00.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:04:23 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 1/6] zram: introduce ZRAM_PP_SLOT flag
Date: Thu, 12 Sep 2024 16:02:16 +0900
Message-ID: <20240912070413.4179924-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240912070413.4179924-1-senozhatsky@chromium.org>
References: <20240912070413.4179924-1-senozhatsky@chromium.org>
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
2.46.0.598.g6f2099f65c-goog


