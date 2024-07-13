Return-Path: <linux-kernel+bounces-251423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD09304B8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357471F224B9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA724481B1;
	Sat, 13 Jul 2024 09:29:43 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96F21A0C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720862983; cv=none; b=M0YPNzxbs4JG8XzXZZGV2GWqQPFn7+I5o5gIS+VsnUP9aHnyXUJIUG+fTqoEgY8fFs7ljZBL2FyNNDvb3R7azjf0nJD9PEXzOykshBq3iFAMuY5Jofrgw1FGam9+qlTA/o9vIoEC+EfkEiCufRg3hMem4l1PovnHEmWyDfWcNRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720862983; c=relaxed/simple;
	bh=PZJmn/5cFiHK5fj9OM4ccs5HSvEZJ44nxBXL5alYu0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSbXZVhxhLi4M6HFipPXXvGiKrys6FBHOEMRskD2ejANUkKVdfoZ9KNCzErXWyne64pECDcv6HRzzsvCyWpp62G2JvVcIb6ufWCTMEjQgu8ZkC5AQPIwBzFD1f1MyFpflCuRH61ZiHhq72vOzn8vjuDHiTOb2iFBGE9KinPvHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.52])
	by sina.com (10.185.250.24) with ESMTP
	id 669248FB00000562; Sat, 13 Jul 2024 17:29:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 58892810748377
X-SMAIL-UIID: 16ABC7EA7DE7437AAB096B845AC48BCC-20240713-172933-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1e811482aa2c70afa9a0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [io-uring] general protection fault in tomoyo_socket_bind_permission
Date: Sat, 13 Jul 2024 17:29:25 +0800
Message-Id: <20240713092925.927-1-hdanton@sina.com>
In-Reply-To: <0000000000007b7ce6061d1caec0@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Jul 2024 01:21:23 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c2be31980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  3fe121b62282

--- x/io_uring/net.c
+++ y/io_uring/net.c
@@ -1742,8 +1742,12 @@ int io_bind(struct io_kiocb *req, unsign
 	struct io_bind *bind = io_kiocb_to_cmd(req, struct io_bind);
 	struct io_async_msghdr *io = req->async_data;
 	int ret;
+	struct socket *sk;
 
-	ret = __sys_bind_socket(sock_from_file(req->file),  &io->addr, bind->addr_len);
+	sk = sock_from_file(req->file);
+	if (!sk)
+		return -ENOTSOCK;
+	ret = __sys_bind_socket(sk,  &io->addr, bind->addr_len);
 	if (ret < 0)
 		req_set_fail(req);
 	io_req_set_res(req, ret, 0);
--

