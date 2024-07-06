Return-Path: <linux-kernel+bounces-243050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E39290F8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1D0283E05
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699E757FC;
	Sat,  6 Jul 2024 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H9uUbBTd"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497D7347E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241843; cv=none; b=rOXHaUp0cNvhHc1V+BZ0w1Gis/o6eutw6m45Sv4ZnFBhaG3pu0q5sSjX6XFMP1RISk0AEbuq0He3Rbci7srwUy0cA7qLBm9N12J0W6wVUy7miIeutHOYc8JrzC9wvonmzYm0ly3wn2CMnzagFaoYddxKdPVvLlZd0BNtpWX+TtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241843; c=relaxed/simple;
	bh=d4sQtH1CMOfdwHUjN9Or0CwJq08KoxlzJDmfznBURQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIa0Y6fazDS00K6Z+rlCG7aI1InzUb9uqoY9Pee7rdVGXysgCRCKdhrKvY4iDWZZGOHud0Qp+gs3F8aO6OG2PvuLJfTB3zusdxWVeFaK2xIPm7KZSZFkPOW9zLhxCtNzTJDaHhfe161VNlcYEQJf4A2YB+iXZJvhY1Birb2YnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H9uUbBTd; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e035ecb35ffso2104122276.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241841; x=1720846641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItQuTXBasJJqFqQGi1leSL1bLvz+yxnE1Fe3ZC5JuEc=;
        b=H9uUbBTd+OVhQE54qZKGPt2YUSJl8mYR38nuG97tU06KnAWvJy+2MSdfzH2k0DT8k8
         K/bLELu2B5aDZGyAdDB046XNJGevlX/J5uTmduIY5bVym7q2fHvvqQIyq27Ped09kidn
         mEx9dq4kmE+CBHAGgnhyjzY7h/0xkIf1jlsow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241841; x=1720846641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItQuTXBasJJqFqQGi1leSL1bLvz+yxnE1Fe3ZC5JuEc=;
        b=hgACtksfY7WfNRCsYF6Pq+o3D29oL8Y8Zs0JmisSia5M1OkeDBmG9v0wkG/uuv4PIz
         ITUOF1alCMs9zWyHfVDV9XEaQDj/45zsEW4jrQO/pqPADALE1zQhbXU0y/UDXOEIopWG
         VKdSI5vFFbthxFs0EPPr/40r5q/a42hPJggquf018v7X5Jw706WhY+PKldDymRq1xOym
         O0ebLOmomd4SngM5t5n0Ta3bpvwJgb0NY0HhJznFlXuLCouQg5LdZNmz2bzbASwcnf/B
         PdPr36jf/rJiqBVpUoM0jzNIiHG9B5Nmq7UDz9XUYhshf5ymcjj092rqnigs3r/614Yv
         +ebA==
X-Gm-Message-State: AOJu0Yw7ylUXyjWCK4IDNKXlWV/INB7JYNMFe2y/PssuUFHsmxDzZPuW
	jOuM9EWqWCU8zTaXO707qgPL0xjQQDn9+0FZsupnrCXLwrlPVN3gNA8zHsgVIA==
X-Google-Smtp-Source: AGHT+IH3TxO6XRauX78xSEH9zyZoG0lQ6N4GKqEwieuZodw7hWb3+rGnNMiqHwTJgN6A6SdOHegAyA==
X-Received: by 2002:a05:6902:1a48:b0:e02:be75:6a87 with SMTP id 3f1490d57ef6-e03c19d0aabmr8542134276.37.1720241840942;
        Fri, 05 Jul 2024 21:57:20 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:20 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 14/23] zram: recalculate zstd compression params once
Date: Sat,  6 Jul 2024 13:56:16 +0900
Message-ID: <20240706045641.631961-15-senozhatsky@chromium.org>
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

zstd compression params depends on level, but are constant
for a given instance of zstd compression backend.  Calculate
once (during ctx creation).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 2328a462b82c..a9808abcf5f2 100644
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
2.45.2.803.g4e1b14247a-goog


