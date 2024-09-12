Return-Path: <linux-kernel+bounces-326070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6CA97621D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE2F1F24078
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBE18C920;
	Thu, 12 Sep 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/J+729U"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24818EFF4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124680; cv=none; b=h6Jl0AfUbTuJDGMtCnnyY4WpHrJAnq1axmlEDYpVdtsMk9Feh+4nR9OwOnd+2wlrKUj8GPEXczK+RXsikqXpuGUrybk5Dql7kVQsFDsLyG3ciYKfQu8FQ6433fhGEQAjE3Bi8QIeg8c2nnbfwlXvJIgAWUmmHZECFSqidf2i1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124680; c=relaxed/simple;
	bh=ESMGWutE/ueYLMAj2JiYG7tbgPqYxMU1kdGf4uO7PX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQ7EdFQ3IP3dkW8xUV0I/26ANlSqp4CkjZJGLUi2E+/6ALrqP/Sn9flqdya1I9rcK6VbOItW3BZY9VIFOlM9Hy/C40sfbCISYn00dCJI7U4ecXSrJ3p+yZoCyYuYRgS0e7eMGQtAN6w3dV7fd3+G+882FzdfrXtHaU+Iohq43k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c/J+729U; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71923d87be4so374880b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726124678; x=1726729478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uxEhnmpnm3I1DwDVMOxLe1iKdHvwPreOeTeNXmi03A=;
        b=c/J+729UD21RfytljelW0kL9AAYZy6LsaSU2zfntjK5YDhPdXZfekNB35CDglqajFG
         PCP35pitHuTgPhnONWkXJZRhSN9HCdi17s2/xAaVEBrvtbdhdfpm4H34BRArr1x+OdIq
         M6J1X4Pm5cgMyA3ACRZc5AWxZ/kfaCiiH0DvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726124678; x=1726729478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uxEhnmpnm3I1DwDVMOxLe1iKdHvwPreOeTeNXmi03A=;
        b=mA86NW71DjMSqIVJxUPtTNByo6yyzgCzuotoCgZefdTD0YE+Wgmgloqh4Elg/RyrI+
         Uqc83M9asf8dptn4cXxtkXuMfoieZBTgru4zDuFTWbFrauKiYaTLmNYnUg8kSs2hZaTf
         AbUssCi4UCWcofSkGEFT6dz7OFVZ7VoKSooW8TXP6KzNlooClULtX4vP5i+dR9nHdzZu
         16la7Ar01mrAzMFCZYINvbNN3E26pSRU+Zg1+EAjaTv8srzS71l+JZQmyITfd+Ehm6W9
         AupdwjrqB9raS4T3skNNrf5PQjxw7g41IZ1/D2V6Fn8qL4a/yjGYlndKScDhe3Rzv/Yt
         f5aQ==
X-Gm-Message-State: AOJu0YyEZwEXPgyWfICbEZ+GQhzZ80hSZvMSMFAqswq4CabMkgtLYp9W
	0uxoZb6BPSDA4lTERqm2+OGiz8DAv6q7bYnoitaLEGiiDwyNW6YE23BNTL9ozA==
X-Google-Smtp-Source: AGHT+IHxbY/zTNbD1OSJJmig6eMIYQ1euNqHzW8qtk2WIE0dG64pvGxq38P5tJES6spF7EYJEfVe7A==
X-Received: by 2002:a05:6a00:a96:b0:717:8eca:95 with SMTP id d2e1a72fcca58-719261d0951mr3207502b3a.17.1726124678268;
        Thu, 12 Sep 2024 00:04:38 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:2fb2:d683:de5d:c3cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5a23sm1101543a12.31.2024.09.12.00.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:04:38 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 6/6] zram: reshuffle zram_free_page() flags operations
Date: Thu, 12 Sep 2024 16:02:21 +0900
Message-ID: <20240912070413.4179924-7-senozhatsky@chromium.org>
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

Drop some redundant zram_test_flag() calls and re-order
zram_clear_flag() calls.  Plus two small trivial coding
style fixes.  No functional changes.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e48e2deec685..8f01dc1fc796 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1499,20 +1499,17 @@ static void zram_free_page(struct zram *zram, size_t index)
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].ac_time = 0;
 #endif
-	if (zram_test_flag(zram, index, ZRAM_IDLE))
-		zram_clear_flag(zram, index, ZRAM_IDLE);
+
+	zram_clear_flag(zram, index, ZRAM_IDLE);
+	zram_clear_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
+	zram_set_priority(zram, index, 0);
 
 	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
 		zram_clear_flag(zram, index, ZRAM_HUGE);
 		atomic64_dec(&zram->stats.huge_pages);
 	}
 
-	if (zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
-		zram_clear_flag(zram, index, ZRAM_INCOMPRESSIBLE);
-
-	zram_set_priority(zram, index, 0);
-	zram_clear_flag(zram, index, ZRAM_PP_SLOT);
-
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
 		free_block_bdev(zram, zram_get_element(zram, index));
@@ -1536,13 +1533,12 @@ static void zram_free_page(struct zram *zram, size_t index)
 	zs_free(zram->mem_pool, handle);
 
 	atomic64_sub(zram_get_obj_size(zram, index),
-			&zram->stats.compr_data_size);
+		     &zram->stats.compr_data_size);
 out:
 	atomic64_dec(&zram->stats.pages_stored);
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
-	WARN_ON_ONCE(zram->table[index].flags &
-		~(1UL << ZRAM_UNDER_WB));
+	WARN_ON_ONCE(zram->table[index].flags & ~(1UL << ZRAM_UNDER_WB));
 }
 
 /*
-- 
2.46.0.598.g6f2099f65c-goog


