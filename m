Return-Path: <linux-kernel+bounces-385284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318FD9B3508
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9941282A26
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5DF1DE88D;
	Mon, 28 Oct 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bn+/cViJ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78AE1DE4D7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129801; cv=none; b=cX3TpCWIFTPusZogujaOr2YclXBjBXQQkXdcWqp71Rk2u5q+V7W9fcpve59KxXQ7Trsef2v7HyDuSCPWmEHRoOGttAbMQVUO7BmChnHyD/jKdPVNpMuGv2A+sy8yZZ5F1dmaF9Qp6pTYx67xqtmzAFTv/Lsr8hhPpRmrgGzVG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129801; c=relaxed/simple;
	bh=h/sYbjBtUQyTXv3lWKehaN8u4xS1tuIY7Lx/bC7eiMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiCrPBpZVDWGESEiMIkkBc+DrTGs2TEgZoteJ0MRWHr8eAEDsSYmgSKjSAzxq7uEJqd5+mxtGysFv9K8em1wIFYP1xX5+1brk/pwhQ1IJ6vICz0CyKhatMcpeRZtoVUDX7a+Eg+K/oI0Y1nZgdpX7HQ98GBu/XJRl/xWujEuuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bn+/cViJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c7edf2872so40088145ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730129799; x=1730734599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjToYipGNG7BRjJmYYUN95GYe0BFvqocrUKKBYihP5M=;
        b=Bn+/cViJWxET6LJzheGiMsk6+EErfCY376g66HKGh/DY8mAlEhKp8tQvRY7IQ3HvT7
         ihef+OP3ddVYaU+IO0k3jXQKUp9+DtfSmQiHD3gnb1NVkEJhblcQ3BiuDgwAxYryzphi
         d4RyEDE+UJC9FcalJcmlFiXt1VmePKbj/1LT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129799; x=1730734599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjToYipGNG7BRjJmYYUN95GYe0BFvqocrUKKBYihP5M=;
        b=QXoaXKp1vnO/cdV3ytuoSLMjY4T8pqga9JBxgg3avEdgniiRzmDrJa1NfmfLvwFj8N
         m0V3A/+mcbVLHY7igFHT0i26c+AQKc+Lb9pDQ7W1MbcBBgx2KJDXE47bBTE/6gCgJxeu
         rYxJ9OzGvU5BJbE//hMFx4FRmtcMiNeh2egRWiw85XuyuPDZhUAmR5p3pM1BEtX3Ag8X
         6TlhvzPBQ7kJ2TqxsUhCrlBgr7jWgOWvbQF1ExLSk1p+H0wOp4i2IVS1AYbxoc87XGM9
         GxpIoyUTn8bF777zb5pEN/Apn1ztd1fKTcZRGXuvjZjtQ8FdBDcazvaGNOINecVKmPI+
         syOA==
X-Forwarded-Encrypted: i=1; AJvYcCWRpEnyJfdT2PHcKHhYzwf6ZP4J2jV4UP2pQUfSRGoKLHSSxXsPha11ihpjZpG0AAcQgLwe+wqxAwn+mq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNlXHqbw1v6/9i/aurDAM1ztATZCuP6Ws/SE5eF2by4qaBc+t
	hqNjInIOyq2G7OZUOFGybg5joJ1XVb8yGjNemiSMPxDFFqM+7gaJPqzmEhy8u9UecDkwLY8cXd0
	=
X-Google-Smtp-Source: AGHT+IEhW49x326CUSg5pYX2QhNQvIE1pFpUgquKoiZ4DdCT0c/L21tirfRTum/rMTE3NF54rgjhNA==
X-Received: by 2002:a17:902:f642:b0:20b:a73b:3f5 with SMTP id d9443c01a7336-210e85f5c62mr3889195ad.14.1730129799203;
        Mon, 28 Oct 2024 08:36:39 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f1f8:97e1:9c5b:d66f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4a230sm52148315ad.31.2024.10.28.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:36:38 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 2/2] zram: clear IDLE flag in mark_idle()
Date: Tue, 29 Oct 2024 00:36:15 +0900
Message-ID: <20241028153629.1479791-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241028153629.1479791-1-senozhatsky@chromium.org>
References: <20241028153629.1479791-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If entry does not fulfill current mark_idle() parameters, e.g.
cutoff time, then we should clear its ZRAM_IDLE from previous
mark_idle() invocations.

Consider the following case:
- mark_idle() cutoff time 8h
- mark_idle() cutoff time 4h
- writeback() idle - will writeback entries with cutoff time 8h,
  while it should only pick entries with cutoff time 4h

The bug was reported by Shin Kawamura.

Fixes: 755804d16965 ("zram: introduce an aged idle interface")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a16dbffcdca3..cee49bb0126d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -410,6 +410,8 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 #endif
 		if (is_idle)
 			zram_set_flag(zram, index, ZRAM_IDLE);
+		else
+			zram_clear_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
 	}
 }
-- 
2.47.0.163.g1226f6d8fa-goog


