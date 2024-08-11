Return-Path: <linux-kernel+bounces-282414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8DC94E3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9CD281F7D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07B1662FE;
	Sun, 11 Aug 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="uAlyXlbJ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53715C152
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723415333; cv=none; b=e50jCkzd/8A07Zm86EdunIkoQkeDxx4tU3xx2wSPzI9hwddf9qw63AlnrcJ+6ZYz0yhjtutqs2YsWybcOsf5tqjX5ftk0s9+pT92je/mqgccGKzxKXamdYHLLJRlic4rKdjtR9mnMrTQ18xYEhgzn14sGSXSArDsOsdq2wzwEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723415333; c=relaxed/simple;
	bh=SvuBgeyo27tgYl4Mr5AlkANtSM/xC+yG8m8oOENgZv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DX4sySsFint9Wd2jcoYHEiz9Ol2/0cKhd2VcHfwZcDZ2Vz7J5r8zNqd+e8Odsy/BDzdOVra3Js4Wly04nB8C6Ms4gX94gcf3ksRi7HR464C1PBIBZSt2mCqdzSDVTtF3wqfTjTQ90SEWqNGVqd/hpgG380BTpl2Pm2a5I3+XzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=uAlyXlbJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efd855adbso4744837e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723415328; x=1724020128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9kZmqufziw/U+BnNxjrYdFrOXuxXNNyKWmcKd111XVA=;
        b=uAlyXlbJc8Kmw1xRFgAaXH8L6C6YOTFcL6tlJRhDSQ3zJNMxdLPjhpxu6lAgXgwa5i
         hvShzlJFE3a4S72bgezsmUrwVMDXg6nkBezSMo+EaQmgvroCipaMdskz7GGwIma3nklA
         tIPnyImvXpY1kgL0hoboF4zVL7yG5LSwFQMGti99dW8/5xC6WwTNovTH17r28v5+tuAq
         zNrZR+V4BKKKKSKLIxhJbEnRsgMMOe8IWe1PvoViPlugc28pUx5Dc7oWkUzgvEfQjY5i
         4ugGME4zEHW99MOV2UAlBCd7IO4F+3MZrcA5NVGKnrYDZQKGF3yA2K8YeIq+GA2odoPc
         z8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723415328; x=1724020128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kZmqufziw/U+BnNxjrYdFrOXuxXNNyKWmcKd111XVA=;
        b=Udi7F645c2WxlmirD3pmcKaAY1y64Fo5sU1SZSnSoH/vs3pm368o2If5pdP8LrAzzG
         S4JzxL5vh801//MuLQyq1b5fyEh6PtlTHbCLXM5/7cMfoPGS85vnSVMwS6PmkLy2jB8a
         MZRjKlP/0O2shGmbLFycjeYVZN6ppT9Kmxp7MDsYUYTBH9yy8w/cz7vOlEhHMVw9V7+P
         QsafnXPJCqg+HVDgbklvUZQV3y2BYh7QKZv6+yKHu8awBpGHhmKctLSnJ9xB2zLpKWMX
         HMdvaDLfpH8BCui8WEudsxiqPHHrjM1q3bI8LN2nbXrAEwwSf8ncxRml/ksZKn/QFZfN
         32zw==
X-Forwarded-Encrypted: i=1; AJvYcCXCOcGJ6IIrpQMql7tfFKNuTRAGugcOF6Eh1kr/OWT+fWyVYJcnZSu4AG0rVK1uWJiPC7VIagDKi46IV4Nk9W4Bd+kflwtD4ezCoPsv
X-Gm-Message-State: AOJu0YyBBLH8wY5MQi1kud7ppWedORQRP9v86K41faFj/pJjQg8b/md5
	xhzbmC4iCaBOlK/vQTr4SeDpfk9UOxtBlO+MQr57OxYKnBAw5FQEA6Lrs5/wACg=
X-Google-Smtp-Source: AGHT+IENX86CxS1gvrkgJ3UUqgNCjaYT47MBR3MYQB8KT1yLME4fAVlu2X15Xe16bQ5f2lcEQ4b8hA==
X-Received: by 2002:a05:6512:2248:b0:52b:bf8e:ffea with SMTP id 2adb3069b0e04-530ee9cf30fmr6123089e87.40.1723415324643;
        Sun, 11 Aug 2024 15:28:44 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cce18sm176097366b.124.2024.08.11.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 15:28:44 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] io_uring: Remove unneeded if check in io_free_batch_list()
Date: Mon, 12 Aug 2024 00:28:18 +0200
Message-ID: <20240811222817.24610-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfree() already checks if its argument is NULL. Remove the unneeded if
check and fix the following Coccinelle/coccicheck warning reported by
ifnullfree.cocci:

  WARNING: NULL check before some freeing functions is not needed

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 io_uring/io_uring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3942db160f18..7597b9dcab28 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1382,8 +1382,7 @@ static void io_free_batch_list(struct io_ring_ctx *ctx,
 			if ((req->flags & REQ_F_POLLED) && req->apoll) {
 				struct async_poll *apoll = req->apoll;
 
-				if (apoll->double_poll)
-					kfree(apoll->double_poll);
+				kfree(apoll->double_poll);
 				if (!io_alloc_cache_put(&ctx->apoll_cache, apoll))
 					kfree(apoll);
 				req->flags &= ~REQ_F_POLLED;
-- 
2.46.0


