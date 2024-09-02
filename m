Return-Path: <linux-kernel+bounces-311159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F0B968588
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F096DB281D0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A33184547;
	Mon,  2 Sep 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KEHGRYyS"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A11D6183
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274654; cv=none; b=djbIHnMmBv5I7WY0Mmi1oKMtXNa324S/NEcuBIQuamtkWzg7TY2S78kgJx7yRl5bHnhZ6Q10bHJThQrgyR0AH8iphfgWsxaZuVZOPNPDpbSCo8onol7+2ycBXnQHhwHtp9yLxO6g5LfgvMgrrDwbOkhXXASnLC6jS6V6ndJpzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274654; c=relaxed/simple;
	bh=L/UuHbCK3F3NwpKzUUx6HZtiZwhVDs26MzzMCuiANow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRq4vtP1B/N/ExAt6ii7RFMZyG7Q8oq+A1C+7lwz4Ah6+mlLMQc0xIVGjIOc6cEpePZioGSUAq37rEy4H1MPUjuWOsj16YF8am/macLZiskc5lYVAh90pLt/kk719C44bpm5qswqvsU8eeYINerQ+1jI+KeYn0Dcdfdar8Jv7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KEHGRYyS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso3680390b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274651; x=1725879451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcwfn8M4A82GSXxq9cNv/IUP8NdY2Oxfvj5IFWYeDkc=;
        b=KEHGRYySjw0De3FrZu/ouvxCG+CsBBb3HKKW7EFPVzisN2P+Ffzvf8IQFqH/yIU2/p
         AKVvVWuXK2G00GHzA2gseUYMNzfT+T6S8Z/1eu4ZWYAzUxySK+h+iZEEsdP8Tk60Q4sg
         RlN1lEXsC4b1c6NmD0wtelAw+jViej5l/Rr48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274651; x=1725879451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcwfn8M4A82GSXxq9cNv/IUP8NdY2Oxfvj5IFWYeDkc=;
        b=lmI1GW1otqTjksSx7DOAu3qDjnu3ufRKzwrTotrkGC9c2rahzsXx92LqsSN8Tc1mDR
         ZKTESzobe8PtFNMy4kUh322n2gqAnwQGt3ddxvl1tFx/Syq+hjHWEeC+OeDuO7ydPC8E
         1FvX/1pM1iEWTf5a6MhObtmyIh2+A6GRfL1n9aT7ZPjOaMHygMJ1sjYaorCNPnP4V0hY
         YRPjaFvMncV3Mv6XqVt/nOUgnZqxSfxU+TVEwR85wjfdbRhiEUoagcjIhnl5RIMsYyvZ
         EitNZbr4luMC+5zUxQkFzxiYJ1amnZEWjqmqIBoO1xtVZ0KSita02EBHmSyxSY0SpynO
         lc3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUczu0zrSzNn8NMCqcQiBCRDF1LsHnR9SzdTZoHxF+QSP63NhYr99VZ6GlfHhStgbfENfHEZzCMMGRMWkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrR33tesCJ3pK87zD4NwKSAS2fBy+y6LHyHWNC6uyvDPYWBV3C
	jMkDL+M4H2hPUwognH/NL60P22sBj2l1TAj15eGqXoInTFcFa9R0X7DcXyP/BA==
X-Google-Smtp-Source: AGHT+IHeWtca78/mNUevUcUqEQ+cli22gJmFHjJFqPd1ZpmfdWezc7WEICHeiYI53M2UHfA+r97LqQ==
X-Received: by 2002:a05:6a20:2d94:b0:1ce:e8ef:1d76 with SMTP id adf61e73a8af0-1cee8ef2019mr3684606637.2.1725274651568;
        Mon, 02 Sep 2024 03:57:31 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:31 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 14/24] zram: recalculate zstd compression params once
Date: Mon,  2 Sep 2024 19:56:02 +0900
Message-ID: <20240902105656.1383858-15-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zstd compression params depends on level, but are constant
for a given instance of zstd compression backend.  Calculate
once (during ctx creation).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index c356c5e6e503..7c6798f0c912 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -10,6 +10,7 @@
 struct zstd_ctx {
 	zstd_cctx *cctx;
 	zstd_dctx *dctx;
+	zstd_parameters cprm;
 	void *cctx_mem;
 	void *dctx_mem;
 	s32 level;
@@ -40,6 +41,7 @@ static void *zstd_create(struct zcomp_params *params)
 		ctx->level = zstd_default_clevel();
 
 	prm = zstd_get_params(ctx->level, PAGE_SIZE);
+	ctx->cprm = zstd_get_params(ctx->level, PAGE_SIZE);
 	sz = zstd_cctx_workspace_bound(&prm.cParams);
 	ctx->cctx_mem = vzalloc(sz);
 	if (!ctx->cctx_mem)
@@ -69,11 +71,10 @@ static int zstd_compress(void *ctx, const unsigned char *src, size_t src_len,
 			 unsigned char *dst, size_t *dst_len)
 {
 	struct zstd_ctx *zctx = ctx;
-	const zstd_parameters prm = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
 	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-				 src, src_len, &prm);
+				 src, src_len, &zctx->cprm);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	*dst_len = ret;
-- 
2.46.0.469.g59c65b2a67-goog


