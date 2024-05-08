Return-Path: <linux-kernel+bounces-172836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E28BF74F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE691F213C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6189376F1;
	Wed,  8 May 2024 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOkrMjQP"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C051C4B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154172; cv=none; b=mO518RQ1Qo+aNWUeewB17jPTjCzFBe18hWYFoijwfMKXrPT+vIjV1NeZiCyTPPJTkJPkaS01w8eac5iUhe7rh7zSBzfSc9Yr8SuGTsh3X+J+0hOfOI9uEpOnz6zx5m35DXBpmaV244wOhNXnZbHmxo/i+uKKOVDhGB0RyS28UfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154172; c=relaxed/simple;
	bh=FRBhLTt/FHOdPdldPK2JgCScJh/quKT94FOX0NLvGcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHLp4Hz9KX8vZjmqd9DBKQrvyc3DWP+BmhDUUIMy+h7NvNwCb183fCOmWIAjvDxdAbO+o4RuT2K6shSZcL5o7WPzaD4Gu+Ll0kZnkHXD7HYgcvVloNCC5hqwFMqQH5/Lq0AR2UuT23EegUDHKIN6eXsF7HHYMySKBBM3WN7MWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dOkrMjQP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so3010002a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154170; x=1715758970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EvmWJu/VXtBqzoQye3a2VzbJm8fhR7v5ZjISdbrAiY=;
        b=dOkrMjQPC8GkW9WsZ44muU5Wiz9dpsk+y4Dgw0h2n72qVYBqPYmhjwTuIrjGH1cgzd
         bXskbXyx0IYZnpX9EdjSjlRNh72n5h2YRSwgLT+neCyo3AHj36Rvg9iAPtMJedIB2Mpd
         0yqVRrAnq/kb5Cgjm5g/9bsddHxLjNWoRmRXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154170; x=1715758970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EvmWJu/VXtBqzoQye3a2VzbJm8fhR7v5ZjISdbrAiY=;
        b=odybI8k/9az2G1Ret1E5Q4aa2+pdxzvl6gjRlIRyR6d1lavjZShX3xBLHWG2AyQmis
         LwYQSg8ploccQ1Ei0IWRBsPrN7o9dFuLxFPJ+LfRsVFmMfRPFemmSWuhDpix9LGUxokM
         DcmPMoLfv6hOxWsy8nskU5ITmNeCD8Vklfv92cgWEGKDa5aXaEW+u1fqxVpuMd9iQRyO
         wQiSJLQfWiD0nFfGcJf1TZ4pFnbxVz80txEibqFGysoAgaIofQMY13nbstnATxjLjYLO
         nIfa+9eSgqXERXyYtq3tZPySTRQ0CRqR3pHky8oodIcPa9iwWo1LPWYUjpaJWE6Raz4/
         Vasw==
X-Gm-Message-State: AOJu0YxN7C16XuCnD1zNAqbg/cpNwOQWXQsx4VZwERc31HPUBm+L8feQ
	dWutX5Vo/ZwQPcaGSrLzYl1pFanCslNH7q49pd2ufPs/dedeDhHl1wwvukw+cLS5eeH50XpqbNk
	=
X-Google-Smtp-Source: AGHT+IHVhKTM2v7Uz/Aq4g+yImMIqtZc4Gvz8s0tsH6+Eo+knHPIcdNtEwPD2ijl/sCOPSx9VMynkw==
X-Received: by 2002:a17:90a:d781:b0:2b4:fcfd:780e with SMTP id 98e67ed59e1d1-2b616bf08b5mr1618670a91.49.1715154170221;
        Wed, 08 May 2024 00:42:50 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:49 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 06/19] zram: pass estimated src size hint to zstd
Date: Wed,  8 May 2024 16:41:59 +0900
Message-ID: <20240508074223.652784-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508074223.652784-1-senozhatsky@chromium.org>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
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


