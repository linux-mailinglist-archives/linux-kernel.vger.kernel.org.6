Return-Path: <linux-kernel+bounces-179557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313E8C6166
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD801F21C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290159148;
	Wed, 15 May 2024 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CN5XvkMc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380E55E5B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757433; cv=none; b=ddnO6sJwZWdlVBMXJbZMXNEQnF4ENkiZkY09mP2Zza7myt5w60whZo9VUu9KuMHZggDs9bZ4IyxQPmTHULKIxMcOdg7xedMN0ssazGfBLwTLRvocDF2vuQPkiefxvSRv7/8SuRBzfk05Uyc9t09dqpMeUvmqrlDHMa+wPriao74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757433; c=relaxed/simple;
	bh=NfNIjYe0R8m8g+PZ0SlYD1aU6GoRy1xQlpR4Iu21ap4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBFOjIOgPSkes+a5gROXPkEd7mi+7xJaZ/vaKfg98e2jb2KwhKBuXRMZfGFOgqJdLPfOmQ5i/gC6NcIIw8z/kUJ0dO/C5JHeREwga20yxO9PHG6K+ERKqBdcZnS04Us+qz3GQoU50/VVa7MxKtperBUWSmmamdaZ3cjoJh98Pso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CN5XvkMc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso43073755ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757431; x=1716362231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKysrwqZlMwVUU8fiuTWrWkRyKYxV6Zxfm3TNnO+6jg=;
        b=CN5XvkMcvsVZxxf/c50nuKiByew5wDs3YGQ6sG59SAfQ+WqRBaSSgVOkXyaA1t7TED
         rrvS5DwDzzubQ6VDyEvHG36glPUI//4McE/8PspWacnWMiQgSW2ZuEgj/O6CKZW+bg6/
         WE64SRs9ojutSPlsnVY5+y63jm0r3KUASLlXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757431; x=1716362231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKysrwqZlMwVUU8fiuTWrWkRyKYxV6Zxfm3TNnO+6jg=;
        b=vMlwxVr27P2Z9EU+BjShg96DEbESixTB+aoWVaqJJ/cUbM9ijmluZwe+0jxy87CjTB
         EbuvA5wRs6z2icWdAt76dfuewfiHypMlEighWKWnmcn72NTseUXiSZTqxUf5J3CJVlx8
         AiqJRcfRVJ/qlrRP7qqDM2AfOa96cqSQHQVQmQ26NFqQcUlQFrRjGGesewdkHCo+LLKf
         zSP2hWdRcNUWLeN0MoeeAJjYG8X39ER6si3fTpjDW8O4QwXzi/R+6F5A+wKVU6lGEjH1
         eYw8qWph/4gV15k4ldFnP7v6KSBHRUoATnr5BtY+B6iGxwIhCv2ia6TWujSpSMFpcHA7
         +EFg==
X-Gm-Message-State: AOJu0YxA+7icKc3Z8erJM7OsAfT0HOi2iGROCG9RwDofO4Xq0XGgnuxL
	lr85E5afOcyX7r5mOaJ7T6AoKw690NtLtlQxdMuv4vdppPSTKhcI5e8PXUPnFQ==
X-Google-Smtp-Source: AGHT+IGDnOeAF1FL804TtRjppmHScnFvlydpSaTIsnO+VLF+Nn6sN4yHuLdVS3qjMSH7/M91C1F0BQ==
X-Received: by 2002:a17:902:c145:b0:1ec:659c:95fb with SMTP id d9443c01a7336-1ef43e25e5cmr138560735ad.32.1715757431472;
        Wed, 15 May 2024 00:17:11 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:11 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 06/21] zram: pass estimated src size hint to zstd
Date: Wed, 15 May 2024 16:12:43 +0900
Message-ID: <20240515071645.1788128-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
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
index bfe836844232..f930e9828be2 100644
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


