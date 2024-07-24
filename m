Return-Path: <linux-kernel+bounces-260917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6893B029
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2DA1C234B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3C156C7B;
	Wed, 24 Jul 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Wi8JX1OF"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F013A3FD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819608; cv=none; b=fvyOHFE3Oe5s43WW4PeX9lW6D+tAsTKyk8BddYPh8Lv/m7C3R0ekW7xqD7G5esa9OXKSrp8cJR22RPhq46LdZW7uCVSbEx+Y+gBkTUHmNH9bS11A8g87sJDQ2pgFpD/deYhK/3zLkaxYzvwZscmPJSbRaQuksz0oHbQ4qITQMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819608; c=relaxed/simple;
	bh=m/2T3aGKPu8PTJknO8CvmQ04OJKcAg5RNwtoC7au0zs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=a5L6r7MSoPILGV9rvopAVb/G63kQlvHvfg/m9ikJ3YvRw3SWLwKHW1al2gfDrO9gV5+F74e+l/P41zHMxrN0I9GifJKfvcFrDEjZVW1Ab3RRQQDG08GiG5zrNgDUmh7HiCcZbpceo+2gDX54hAgejpK5kU9aaOrHH4ouz/5b/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Wi8JX1OF; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721819603; bh=iO7TxJfJTh+nifQEM0EC2ohn2mapYQDySZ9dWdp18m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wi8JX1OFsDuBN+/PKxwOsbWA/s2OnQ3NJgeNipyZEwJuojaMfm2MgGMAobb7QlIZB
	 lUpi6KqNnx6fR2J18MusdDeWNfu/2HLwvn2UDuQt4e/OrcIBeQXfz7ndIMqM/gjrOj
	 xmx9HI/q7JaeFdt8WL6PpTDblCZcJLL1gKrg6ls8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 35538421; Wed, 24 Jul 2024 19:13:21 +0800
X-QQ-mid: xmsmtpt1721819601tzz5zgp68
Message-ID: <tencent_B78F6EC46ED2CC9E67F9C6DCD2C6C66D0906@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrgGSuue8Ej3EjyXF7C18f/IsU9STm08JVVGElUOyZ9Twd1YfTh8
	 WAK66DDPjcPxeKGQA8u+DWxlJD4OgOwnwPnX3kTym62bHNgPvdbGDlImeOl8nMMzeO6MEaExRZcN
	 Jvyh27f6zYYBp5XSScX4pRi5braC8l2ChtMnwOyIYQnfr001931UBAlHtQ9pXu1wTFFz1sSQqp3L
	 eZDKwCZvv0AjJabbWUz+KDioGjIKZAAZZjXFH1PgvBmOVdUGdbYT5CQIL3a5TRTJlJImoBcnnwZW
	 YOhUF9egvltur7NkAq6LQMkWlugiUPOJvss62zqlbZ/rPyiEBwnJd41XGj8tucGbiOSBiptGLR6p
	 nTPcsdpWzqN455pXx9u7ZMUp8JHH+x+g3sLzjooVe3zbEAH41y5OLSIVD5zSCwavTrxP28J03yVd
	 VMy4k9RkXnefFsdEDEJycJEWKFC3WdCmEUeKiocsvRveRk8r7rFTftbOVnGMT3dA45S9N1+4J/2q
	 MNIVe3zeerZvteF3PCFgUoE0GXAkBTq9nIzKd87lL98BTm+GN7oPu/LZYIKdkGee6stYudm0Lzeg
	 xla5ky/8utIrLyeTXtlTl8g7PlKIfi/Vw6J+M3e2Uyy+7a8LC9dVJ2hImw9rn2H77aosbySR3lwe
	 SMPNXYLON5lgpMmPmaoPI9wx8exiU42YwceAK5kRu8iz1RXledBoYuJTFG1bbob9FSS0BtfEdyQs
	 FHe0tNWqaq2CBUVgnN/6T+hQEQbk1SJjJtnxPrVcjKw1IAbkGXHS9km1qpm5Hnv8povZZlxuJFqW
	 RFPgbW9kMISOM2m7hYr7SWHjc+7JRXaeQopixFirneGFijhbuvfAITTgE2Qsn6+QHDSVAxbLxksT
	 gqiETioWnTXh0he9CT/5Pmetfg0z4dBJYG+dsCRuvTYaBwfpT8t3M=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_task_work_add_remote
Date: Wed, 24 Jul 2024 19:13:21 +0800
X-OQ-MSGID: <20240724111321.1621333-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000fd3d8d061dfc0e4a@google.com>
References: <000000000000fd3d8d061dfc0e4a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when alloc buffer for req, init mem to 0

#syz test: upstream 2c9b3512402e

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8e6faa942a6f..a650db25c383 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -933,7 +933,7 @@ static void io_preinit_req(struct io_kiocb *req, struct io_ring_ctx *ctx)
 __cold bool __io_alloc_req_refill(struct io_ring_ctx *ctx)
 	__must_hold(&ctx->uring_lock)
 {
-	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO;
 	void *reqs[IO_REQ_ALLOC_BATCH];
 	int ret;
 


