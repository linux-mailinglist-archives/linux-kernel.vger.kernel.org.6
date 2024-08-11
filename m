Return-Path: <linux-kernel+bounces-282412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D794E3A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CFC281694
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2915FA7A;
	Sun, 11 Aug 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="pXNV2Erl"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16A158D98
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723415248; cv=none; b=JdcW367qxHfNy9n+gPoGAtiNM4y/Uj8DCUbF4Cr8bBtZZzv/+2GhqYnn3nP9l9RzBccUd/UmnTPYPhTeWZdFKaTn70ZLN0KNwnywzXgbufGewnq3r7sOolYEjjE0q9E0MBWSyOexwRWYU6TfBS60vzMcw9VMtB8deJxYxklRMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723415248; c=relaxed/simple;
	bh=SzyJrnQp8Uz830lPa3hcN4gxoi7JSiSAYiOGEnSLnIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLhjaO50Ow9rP4vaIQKGEsu43KCD5pP8b3lEIZ7eYMOYAveKydRiVeChpftTEPulPGIODr0mEg3rrGnzQm1upP4l1gOgDkQrVmD15oMqSiLtdhwlq3v0TcGBYOa3Qs68ujPolXF2JHm3i5RmTCM3gaK8EM4fDPN5JaXcEJey9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=pXNV2Erl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso5058122a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723415245; x=1724020045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4Zac+A5KLRIfYXaRReKZx0UGyVecnM7nQMC/JMtMM8=;
        b=pXNV2Erlq6D6aOXOF89sa94GVEfnnzb7eC/BsvlR7N3HYLINXPVZ0JvY3+K9p0vRcR
         72VTOgjvo2pGDOA34MZ8vFWJlJETQXtD9AZhNeci6e0M7tK0hzSjFTjledfvORL7KuZC
         pevm0IUE9wXHAA6scPwJiGCCwdwwEDHHBKxm8OhzyIUHzlwEpYwSGBHnsYUBQq8xSw5y
         9giEFUzSjKFrOfCNYIE2vZKoQkp3cklYnilgi9Te3VH4w3cRbf+k3NlcIlVe2nw5/z0D
         wwob16L6g5DuhupjpxPfS/+TQMcEPG2615U0jb0e/8gn1uhZq2g1Cu3uc61Zq9UTcNO0
         EkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723415245; x=1724020045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4Zac+A5KLRIfYXaRReKZx0UGyVecnM7nQMC/JMtMM8=;
        b=DFTkP/Bep/Do5C/ZRB8iWR9x8TCuJvCpndXFPEyl8VtW1oUVLAet2PHPXCSxDkKeQs
         yVdEYVAnV0iHKrim5tXYmz7wQ12cY+rJ3pMN1waNKFntPyY9Ki4WyPf28Y1J8l3OJpbm
         kS1zcKBLHly83qNslSieZ7JqrT8e0T172Pf2J2R9qcHP5MaKYYM5iyEE41V4HFwm2HBX
         QPOaqp4Iyq615xCJdGnudIJmuextDSANhwDr4PAHbE8UnsPdrhck2vRU08CkIEp8QC0q
         AyeCVvD3tDQcM13gCijBxEVlY6H37C9qzVs7T0UzfMcj8K/delqxn+lLXi8RDOZx3sfp
         EOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOvaBrP1Ipev4y9Dk2EOn8vs87gJPGRWKE9ZlBtCDfuUaZ0Esy/Y2JqhLoJc9pxc7lvPtFG1D9ZNoWBM0Q/FbvNsodNZUMflsOjtZq
X-Gm-Message-State: AOJu0Yy2sby//AWrbif5Z8MMxF1T9kwWW6D1hGf58uPGgvX5qdGAXuaS
	zd8iKyYy77qQXaZdmqpdIdjncXhFkQiyudvvrPpP6Z6+IHXv9tvtqcDAvOJbjdc=
X-Google-Smtp-Source: AGHT+IFuRotOvb7NG9VaBxjLgw3eDaFGdEzAK/4EBQJP5b+w6dEHIXP2tg92tewHv2u6HT5+eJvTWw==
X-Received: by 2002:a17:906:d247:b0:a7a:b43e:86cf with SMTP id a640c23a62f3a-a80aa5a6dadmr522707266b.27.1723415244273;
        Sun, 11 Aug 2024 15:27:24 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb212e49sm174447566b.160.2024.08.11.15.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 15:27:23 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] io_uring/net: Remove unneeded if check in io_net_vec_assign()
Date: Mon, 12 Aug 2024 00:26:39 +0200
Message-ID: <20240811222638.24464-2-thorsten.blum@toblux.com>
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
 io_uring/net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index d08abcca89cc..9f35f1eb54cb 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -189,8 +189,7 @@ static int io_net_vec_assign(struct io_kiocb *req, struct io_async_msghdr *kmsg,
 	if (iov) {
 		req->flags |= REQ_F_NEED_CLEANUP;
 		kmsg->free_iov_nr = kmsg->msg.msg_iter.nr_segs;
-		if (kmsg->free_iov)
-			kfree(kmsg->free_iov);
+		kfree(kmsg->free_iov);
 		kmsg->free_iov = iov;
 	}
 	return 0;
-- 
2.46.0


