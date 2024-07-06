Return-Path: <linux-kernel+bounces-243045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780999290F3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 06:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED11B22993
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB18E47781;
	Sat,  6 Jul 2024 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eMwy2TlU"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E1446D2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241832; cv=none; b=X5Uupn6AfrALGZPP+H4K5AKK3lfvTR/n7aSbSdRfsUqG5BWvkIouTr22TtB1xCwq5y56udsJUeYu7vtMk/7WP4+Y2NDyGJ0OASsF0oKxfdWp4F92gxslSdBq1YvBfQ00x0f3AZ262AgdKImtelRV3YM8GU106ZwIeReK33X0ro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241832; c=relaxed/simple;
	bh=ggSUuq9wLdZU/3HYnfroJ7OsgBtfw6Jt/Gbe7ZJLLBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHz5bh2uB2VdZHr9czlU+pT4+CIme7QDZjLoH0EBGGQYmbaYyPRn0U0wu1o+qH9l5+s87cEyGtiflQXSn9BPL0eKR/R6H9KkmcCVloCF7TmhejPbanhUB1SXjA4VHHVifHQ3Tc89L3u2TET9TqDrX2UZnELuvJA0RdVoMQytkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eMwy2TlU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e035dc23a21so1970574276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241830; x=1720846630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1uUrn/uLdGhHca2hINlCuTEUNbGnPeH+z1GhABqRLM=;
        b=eMwy2TlUNQdhp27ONxFAghaJPRXur9VFZ/3mcv8PjuO1/ourn6GG0F61ZY44okVt2P
         /qYdMJP3Ou/dPJCUHPCHq98T2K49t5SZFAbB5morpUoVecI0PKTPSbohJzvM58bOYqcQ
         eLlWLK+WkUuOQHutuNI5ukDrxAf6SO+vPFZQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241830; x=1720846630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1uUrn/uLdGhHca2hINlCuTEUNbGnPeH+z1GhABqRLM=;
        b=jPcMM82xFiwkBKwkxZjs1Yx1Sh1pouGLG5nJWWEs4GE9TBrB3SZXUK7SkxBt4ALwre
         oj0Dhx/LLx9PmJTDEAdHSEaXj35kH2O/NPJ876EW5c1AioPyySTTn4cxpetRwUWOcx+J
         mvJ/hxOJReco1RBjAaREPpY341UG0JPWn2GqtF0O93qld5u9ayumeKApxkMJlIo7bV/s
         8JHmXRidW6CSyKe5wYHZ6W1eFbZ+N11lSLKjStwJXD2QISGplDrQ8Hj8OJ5MF3kCxPPP
         JCGBrdNkA1kbdfmLI8kIfukrsDQc9MBFJqRsRDx9ZcPMFClZhvKLzr+whMz1h0bmWTRT
         P2yA==
X-Gm-Message-State: AOJu0YwCnxSJ6BBzPpz1J7lScRR8f7awadBviNDftKsde+fUy1glvk57
	/Z+DeokjkO9Cnm2462h9shflTwayM4ZtKj0al7gKCxPtg2LyaCQbLX/1ZD5ad64WICl9DhfSuYL
	WOg==
X-Google-Smtp-Source: AGHT+IFkmFrOWWV2il3nNHTJLfhLxc/wo/WUpobx+TQdGpp6n0qTLtSqr6ofZZytwxBHX4E/L8gJkw==
X-Received: by 2002:a25:d80b:0:b0:dff:1020:6f31 with SMTP id 3f1490d57ef6-e03c19e9540mr6726053276.45.1720241829733;
        Fri, 05 Jul 2024 21:57:09 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:09 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 09/23] zram: pass estimated src size hint to zstd
Date: Sat,  6 Jul 2024 13:56:11 +0900
Message-ID: <20240706045641.631961-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240706045641.631961-1-senozhatsky@chromium.org>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
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
index d0d01df2261f..e70e6dd2b4d6 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -35,7 +35,7 @@ static void *zstd_create(void)
 		return NULL;
 
 	ctx->level = zstd_default_clevel();
-	params = zstd_get_params(ctx->level, 0);
+	params = zstd_get_params(ctx->level, PAGE_SIZE);
 	sz = zstd_cctx_workspace_bound(&params.cParams);
 	ctx->cctx_mem = vzalloc(sz);
 	if (!ctx->cctx_mem)
@@ -65,7 +65,7 @@ static int zstd_compress(void *ctx, const unsigned char *src, size_t src_len,
 			 unsigned char *dst, size_t *dst_len)
 {
 	struct zstd_ctx *zctx = ctx;
-	const zstd_parameters params = zstd_get_params(zctx->level, 0);
+	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
 	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-- 
2.45.2.803.g4e1b14247a-goog


