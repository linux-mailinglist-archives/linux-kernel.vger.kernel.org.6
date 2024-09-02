Return-Path: <linux-kernel+bounces-311154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79D968583
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014C01F2415C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA91D54D6;
	Mon,  2 Sep 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SGdy8gyb"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582761D47D7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274643; cv=none; b=FdRrz5h4xDn10QwiKYkG9eYMBiRzOOMBK+ajfM7C9vCdDn6ufYSt1noh8rhj3y5KeCVMB/Za9lK0VTUTjy6EYrdq/im17RHKCezfAOVmsMx39Ik5oTZQdiUSWr+r1jew+MjHD4LOSqrW9LjUTfg1GJLgrchXdei4iVKxVR5Kv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274643; c=relaxed/simple;
	bh=k1hyP2VcgihNcu/8Cs5MExmkREcNlz1Z67cQXyzpGQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rseyr+R2YIFQAoPqd01zpy4W2ugg7IklcJjAqSmQF1Ly0EAbEq+NbiESA2VWAXZ3aktS9y+j9UWrVRYmA1AfUfJ33VJYltTzQ3g8VvqkWBWYob4RRiobwJtd8C9i8rvD/JzSx63cBLzauMIiPljDwdn4haptl/j0CZQpz9h6cq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SGdy8gyb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7148912a1ebso2243341b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274642; x=1725879442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI8x6epz+lgpTG+C2h8Uwi64WQ1pyqGDN7uhkigo9X4=;
        b=SGdy8gybAqvMnB1uU/MlDWxdLWvVhrpeH+Xk+fZ389iB+kKDhyvAa7ns6/QWYBDrvt
         6Nef6+8CTxkQqB3js97jFj8rKTp1yky6yr+888fPKh7XvcJ8C7h7zfHfT2qtTuAAT4k5
         WGB4juZOnUZdi0GZwMGqUwfeTANn+fk+78Iw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274642; x=1725879442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI8x6epz+lgpTG+C2h8Uwi64WQ1pyqGDN7uhkigo9X4=;
        b=XDe3QPGyGB8Qc21UidvgzbPr8w5BeB8k0CB0kC8CYk3aL2w+j4vnRIcAW8PKbhdsSt
         lm5HLZoGReCm5QRmimwcYSYoV9OlOdBKsA6nv4KOSMxN8bpMK7ILR9qdwFXWdb26ho8n
         jR7htNGVlJidG9iP51bipWo3uM6r1r54h6YrlVCCnQzuOfFupUKEpJXcJhpxDjsKdxrR
         tW8zQqe60Cm2Q08fWejk4Bm4ZFhX8V0ojYl6H9WaSEPCMjXmeGLoyAtMwpwvfyu5NAj3
         DxI+ciWtAakjgwU8RES3bG/14VYO2bKZJPs/AHiv8F3SuOJojuHbFUkby2RbHWKARdJB
         CqTg==
X-Forwarded-Encrypted: i=1; AJvYcCVm6qi/YWE6Q5Pe/Rlwz+Nmvb73tri4RJGCpgeMFc9Wzl2bKxCEKcPdyzidhosjHGC/gITnB7amUWwQ6y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TciKGkHB1x8EQcZ3z52KQhnlWM/vJlQO7XAiFv1YpYgHteJ/
	iSak+hl6SRIkOwksQbinBlIzKJJwJejYl7vzuTAKKoJ9RKiOsFADBH6Oz2DNBQ==
X-Google-Smtp-Source: AGHT+IGLwRMX44IKlGt+H5gt3hkRaMplRKOvJumSxUrofE28iE/4nKwpJmCvLJa/H6R9+h0WwNtHuQ==
X-Received: by 2002:a05:6a00:1905:b0:714:157a:bfc7 with SMTP id d2e1a72fcca58-7173c30b357mr7393343b3a.15.1725274641533;
        Mon, 02 Sep 2024 03:57:21 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:21 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 09/24] zram: pass estimated src size hint to zstd
Date: Mon,  2 Sep 2024 19:55:57 +0900
Message-ID: <20240902105656.1383858-10-senozhatsky@chromium.org>
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
index abec68d1104b..310d970078e2 100644
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
2.46.0.469.g59c65b2a67-goog


