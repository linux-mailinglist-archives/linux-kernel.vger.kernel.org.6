Return-Path: <linux-kernel+bounces-250178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F50092F4F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA87281ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C9A12FF6E;
	Fri, 12 Jul 2024 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YhSR3rbo"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F212EBE9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761567; cv=none; b=fSMvJBbxX+n6k6vtUh1p9GTw0RbLOOz2imkxpDmjWx9Nqkkk55xm2tm6PEXf8S9rDmbu6f9t0BfloBgt1q4sgaYEr+I2XrerAQPWGRqccASRzAZHHDZjWqqaGmc9wLw43mbCDZ0Kbtls5SKCjKv8MnJg2phqh26mqBe5dtMkx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761567; c=relaxed/simple;
	bh=/2817xy2+Q8w7Yvd63vNMy+pnclhpzK34BUeLPjTGsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUBtjN+xRcQPiPoNlJ2AGpq+Ya+VRFQHJ3XTKLXFx7aJEnAOMFGq6NlqsjIisPWSRXVbIh632o6j7Jp6VwYfBKBPeKFwtZAciUGGGRAD2Jb7dgzE3MfPCKVGSn667VyohnLzSmZ4fije1a/MZWUdIyiI2eqPlKoPMjj6eqBqqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YhSR3rbo; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-383dfcd8cdfso6333615ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761565; x=1721366365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u21liy2GbPpyOwv3EJWVVcbcrohKbu0gurqjkloMlXg=;
        b=YhSR3rbooVcPDJb7M7Z81YCpsloGTNoENKeWhoLZnI7Qac+QSaoIXIx47d0wRkFvEH
         z/87FqdgIqyWt9MSjz7jHlm2JJ6D+Omg8VZNG8Sn81mcvooceVNQCsYgfHwG8qHkW4JN
         WqCfVxgEERUyORqscvA6qvhfXj1joQGT3Ie5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761565; x=1721366365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u21liy2GbPpyOwv3EJWVVcbcrohKbu0gurqjkloMlXg=;
        b=qe3jgZHezCYGLbQnIOo3284/RBItPPSEah5PsSJBmuWUczMr9857dusMKpdBSIcLTe
         qxV09Q76VYEDhKPzVaYHiJxnYmofT9xyvVVbgfMob3h+ZA1+WHxtEegCSM+sY/dOchXU
         0qaNM7ZYsuN2iQ9O+DmpDupCO/8r9v+m1rqfCcrDYq9tOfxe+vWfhTIGVi2keo2D1Cxd
         9hrBTkh0WZKzwCpZd5bOfz1vgcvcypJtoswPSecqZp91O1gVyw1XycNt2O9G4CHhS/Ub
         TQVHrx9xarnG0qbld9uHdKdyuuLBh+G+09U2rY2RlcqxQ1mJv++Ulud8o2DUYXNF8gXn
         7Jaw==
X-Gm-Message-State: AOJu0YzTdoPpIszYRcMtn8w7UOf+uHsy5TP6GScJUvDh67PsE6x4cfce
	CNPY1mwjXX9SJBQnfjbxgqf5eSiUd+45XFLO4mm+AYoftX6nVaw6HQU1APNkZw==
X-Google-Smtp-Source: AGHT+IGB7MW+cNp14mvUUbY0QXUbtSi+vnyQGU6EbhqbeFX09AMdNK63I0P6STHkhPjEOGbAgonfVw==
X-Received: by 2002:a05:6e02:1d95:b0:375:aaaf:e88f with SMTP id e9e14a558f8ab-38a5aa280aemr134150545ab.27.1720761565510;
        Thu, 11 Jul 2024 22:19:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 09/23] zram: pass estimated src size hint to zstd
Date: Fri, 12 Jul 2024 14:18:20 +0900
Message-ID: <20240712051850.484318-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240712051850.484318-1-senozhatsky@chromium.org>
References: <20240712051850.484318-1-senozhatsky@chromium.org>
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
2.45.2.993.g49e7a77208-goog


