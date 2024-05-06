Return-Path: <linux-kernel+bounces-169449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665A8BC8CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6703B1C2149E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52E4142651;
	Mon,  6 May 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="USREE9Ki"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15669142658
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982342; cv=none; b=kKKmHvdry5/Q3QVy5Dzp+pzd8X89BIOFvT9WXErGbGfdZEFOOVIiwL1ZrxRxfLNwI2OjbU4o9JX70dZDKvqECgzmiEbdg1RK9/x8ZAAR+m93A8A9ewYpygfmA4+2aBGnF8QjJuJ5As6nISemN+NG5Za8jNBepdeKSAPgFhxdQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982342; c=relaxed/simple;
	bh=FRBhLTt/FHOdPdldPK2JgCScJh/quKT94FOX0NLvGcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7vkCDfhrIqfuS11NL0yek092vNC4KbmVX4Ux59ZcIYDpxC1E4tKoBadETtepa+LMkbITl2Q6PYMCbigpDGRcuf4xWcavYyX8cH54nIFrKe7CEJFzxNjgp5WNVpPHUKZSZc/NJjM6V2eQba1qbgIE9FgXQQeWC8IX38aSgR5/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=USREE9Ki; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eab16c8d83so10901845ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982339; x=1715587139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EvmWJu/VXtBqzoQye3a2VzbJm8fhR7v5ZjISdbrAiY=;
        b=USREE9KiozbUeQsQtYFP9rLh8fk4Ns4PqZvLqOy3oo9CudM3ZLfhQDK7fnHSIJf5ZW
         FD+61fFvZJFVYt1le59UJotSQ5z1fDxyr+uAw/+587HkxABdvxvZqrH0dvxdi98klJx5
         yM1gG2/vg3kGKvdLlB15zr+sWaYrUmhQnR5JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982339; x=1715587139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EvmWJu/VXtBqzoQye3a2VzbJm8fhR7v5ZjISdbrAiY=;
        b=AR7yi0zUzYwrvkvBVPJ26Zt+U9jJr9fC6yheGdzasJI0slRH3q8dV/teAKY6A88ybD
         URYEmfWYOCIeAwfVLiylwsXNZ+q3KU7CnaBfORcaIlCRzMG6/dr7+Qq/3Ma5xGjFaw1k
         wD8A53pJVtuRpjWyD/NyTBarXHDlGcNp77BxkmOhAdwsXU7d4T80lrrmEpzTkidEClV7
         GAmthPr5RSBppdkKCTqiYkr+yzYJGOsQo/Asrz2B6uggsZvHgDuD/GZOmQranwMoogeN
         X+L2V+BI+xKhfWZMSZA6aCB1+MrwLyaus4U1m9nOpSyVZevAWEsK/5R1Hhh1yUO5SAbI
         tK7g==
X-Gm-Message-State: AOJu0YySBauCyChvxZ8gr7sgC4Vg9wz2/QDs80gg7XXXIVrXy0FrkOLX
	cxQLuHHQtvlG27/BX0y/ND0BqsqryD8QXmVGejoDz/ypHWdKu1YgnDP5OJXuHQ==
X-Google-Smtp-Source: AGHT+IHAlAMMb1xOBQ8h5iXt0t3MILo5VpT1GAqE/mOolH78hccZi0QsEujFUvP+FM022nf/kSp60g==
X-Received: by 2002:a17:903:2349:b0:1e5:3c5:55a5 with SMTP id c9-20020a170903234900b001e503c555a5mr10089448plh.8.1714982339556;
        Mon, 06 May 2024 00:58:59 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:58:59 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 06/17] zram: pass estimated src size hint to zstd
Date: Mon,  6 May 2024 16:58:19 +0900
Message-ID: <20240506075834.302472-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram works with PAGE_SIZE buffers, so we always know exact
size of the source buffer and hence can pass estimated_src_size
to zstd_get_params().

This hint on x86_64, for example, reduces the size of the work
memory buffer from 1303520 bytes down to 90080 bytes. Given that
compression streams are per-CPU that's quite some memory saving.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 4da49626f110..4a7734aa1a8a 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -35,7 +35,7 @@ static void *zstd_create(void)
 		return NULL;
 
 	ctx->level = ZSTD_defaultCLevel();
-	params = zstd_get_params(ctx->level, 0);
+	params = zstd_get_params(ctx->level, PAGE_SIZE);
 	sz = zstd_cctx_workspace_bound(&params.cParams);
 	ctx->cctx_mem = vzalloc(sz);
 	if (!ctx->cctx_mem)
@@ -65,7 +65,7 @@ static int zstd_compress(void *ctx, const unsigned char *src,
 			 unsigned char *dst, size_t *dst_len)
 {
 	struct zstd_ctx *zctx = ctx;
-	const zstd_parameters params = zstd_get_params(zctx->level, 0);
+	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
 	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


