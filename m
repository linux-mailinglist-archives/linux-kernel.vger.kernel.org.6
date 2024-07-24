Return-Path: <linux-kernel+bounces-260952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B024893B0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D71B229D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FEE1586DB;
	Wed, 24 Jul 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L7/ctwkb"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AE156871
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823091; cv=none; b=EywBOomtS705VdAWcsZ3PBavZ4QTo2IJbopboDmckw5lFmWkTzOxukVaiAkDT2ztlDX1KqD54a8rtE85X8xAa7UoWCm/YAnVGoGnBtVeQJRdqpFiUZqyDSiQWino/uzGxgr0yikPlUXYxVcRPXxmBYucBElVgQRbV9h/OH6mLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823091; c=relaxed/simple;
	bh=Q99uqcgWBlI8DceU05gnhWLhuWfoDr3+7ZPbHM8fxqw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=e9bRrzdyrKZ55D65U6qVWT+POBPNCbnsckGBDGgB0BOHDDOYWHyngZpuJdn84hWewX9zQE0dcsmyG3lAvb+awQOkfKJh0JE15mf42fTx7exVctjk8bCTYM3q6ln5VyYXZ5NlBKsLQbdrhGRvTJnP1NJFVUqjwziwTmQZxpjchFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=L7/ctwkb; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721823084; bh=utvrdmv5yHjy84D9u/m5qF1GJiEKqJT/z+VzYafOlCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7/ctwkbhwEQSY4wCYgh9Ck+9E8birpVeboAr0luX1Wr6RMxmwLd78eJIf59yZzLd
	 mYhyeJrrncxBFPrU6yYs8BcRda2DYs9YpNmSYn6Uu+vvLE/HnKOz0eDCMfzPpKRuUi
	 kurM2hGTOkVvGgdeXwdKk4SDLe/OqvwBXY8SwCvM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 2D62740C; Wed, 24 Jul 2024 20:11:22 +0800
X-QQ-mid: xmsmtpt1721823082t419vs7k9
Message-ID: <tencent_BDF63D63379896FC36DA4B94758377296609@qq.com>
X-QQ-XMAILINFO: NioaTWkRhWwaqtUXUk0vapTe+wKzke6jw7fYHcdxgH4cHcEtolZ/1Aajc2Vt1Z
	 3ZFJJIy1nD7g05Pru50DcO17PiV40WZQ+yZjyEUjIRFzjHQ/KzNknQBfcVj8SXK0QbR4AWovt3O7
	 RMtWGUQFTtdJF9lsHyfhzqRLRmVf+oT2lR0s85gZFLAkaLEOF1ZysaqRq2isYyI9BPdQYA+7teip
	 VPQ005OB4D3maAvXqL+X9oWWlfTmmWFMtJtMn+7WBdPVW8oZxs5vvMOcZCHrkuSA9yOISZ2S7LRO
	 kYR7T+CunTny/N5lQB8Qfla/43MZuykkp/qaoUYM8mIss6WJKiwXvn9RBMU5acFWLMB66ta5ClEs
	 C+Sg0GKTlZ0KTVlZsmI3TA68zA9xFKU1AAITZDd6h4HGpcjrBmK7odL/M/SWNkNLvTt2dwUq7QuU
	 KxYIPCUYW7CzzUe2CLtnd9k4TxuCE0G+DDzSb+7Lf5bcJByWEjP5SM7mREFJaQ/i7RopHA9Ij8RV
	 wFvop8fJqY2lVDDpfVcre5HYmQR+SeJ2AI64cnATBvbzqfFBcaknSltKDaexcFDyL747nsC4tAzv
	 072mxyLZrDRujhvHL+tmRPJzRS8Csswz7n/L9aQSdAlVLnDkG36QAYwdzpbzm+89V4+grD2jX5fe
	 cHKtxk1U8OxaaMYVNiLu2oM1doZ4q11Q1T1JUOK6+CuE9YmUyZVtYEdOUIUojURjMYEyYTeIyVdd
	 +kzou+3HTaUQcMZKnQiRoZXpVYsicuRf4aV2GCSjodkTLsOL5HsUfwviOoYZ1HSin/2X7RToyEj9
	 3/mEFhgxMiNlEA2CHtLBS2oWH6ayzEFK9PRHtHJlcZi6E9QqBuiFICa4rJG0B3mugZk7M063cBwA
	 embSA78Q9LkJzjgYRAZRFiPDMwNZi/VnE6amDuJG0G6lEmwGSG2yVl2O8Q6JGSWg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_task_work_add_remote
Date: Wed, 24 Jul 2024 20:11:23 +0800
X-OQ-MSGID: <20240724121122.1678304-2-eadavis@qq.com>
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
index 8e6faa942a6f..acd2c5aac1ad 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2177,6 +2177,7 @@ static inline int io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		return 0;
 	}
 
+	atomic_set(&ctx->cq_wait_nr, IO_CQ_WAKE_INIT);
 	io_queue_sqe(req);
 	return 0;
 }


