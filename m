Return-Path: <linux-kernel+bounces-282073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F3394DF5F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE1E281A8F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 00:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF9A955;
	Sun, 11 Aug 2024 00:23:37 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0DA923
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723335817; cv=none; b=nG11OWsBg4kuUhEP5f7Rx2VFW0HCpa0DQWz/lOsoih2+AbQ+IPStXXnlsP6QsQKVbsTxxEt6tN5k8w1EzS1+bc5bovJoyhQpNrOiqcjuTb0p9ExsN0NGLHQ5Yu+WkXQR/wYcJK/FMEBIRok4YykOLQFIhK5EP9FN8RJ306yeWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723335817; c=relaxed/simple;
	bh=TIKU+MCDqRcoNgTm3cJk9HwKFQm5Q0BcDSVFrUkQicY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aD3TCLDzsF8rCkhIoQk1uVNxrTXYynbw4GfqpW+E2oN9KQm08n+Wj160GPTUH+vV8AdwARvcOXBNl+UVTYqRuj7j2HwkRnrbyJJsMR8tv3HQbEZNuY4yfwrfo+2gLuo/AwSAIKkYSuyhbWUm87B5zQhdD/CSt9kLlFhba0BV60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.243])
	by sina.com (10.185.250.24) with ESMTP
	id 66B8023D00005B42; Sun, 11 Aug 2024 08:13:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 46191410748375
X-SMAIL-UIID: D495B45112F04C958DB0024A92B15ADF-20240811-081352-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
Date: Sun, 11 Aug 2024 08:13:41 +0800
Message-Id: <20240811001341.2890-1-hdanton@sina.com>
In-Reply-To: <0000000000005f5a6d061f43aabe@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 09 Aug 2024 10:42:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    eb3ab13d997a net: ti: icssg_prueth: populate netdev of_node
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17522ec5980000

#syz test net-next  eb3ab13d997a

--- x/net/vmw_vsock/vsock_bpf.c
+++ y/net/vmw_vsock/vsock_bpf.c
@@ -77,37 +77,29 @@ static int vsock_bpf_recvmsg(struct sock
 			     size_t len, int flags, int *addr_len)
 {
 	struct sk_psock *psock;
-	int copied;
+	int copied = -EAGAIN;
 
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
-		return __vsock_recvmsg(sk, msg, len, flags);
+		return -EAGAIN;
 
 	lock_sock(sk);
-	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
-		release_sock(sk);
-		sk_psock_put(sk, psock);
-		return __vsock_recvmsg(sk, msg, len, flags);
-	}
+	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock))
+		goto out;
 
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	while (copied == 0) {
 		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
-		if (!vsock_msg_wait_data(sk, psock, timeo)) {
-			copied = -EAGAIN;
+		copied = -EAGAIN;
+		if (!vsock_msg_wait_data(sk, psock, timeo))
+			break;
+		if (sk_psock_queue_empty(psock))
 			break;
-		}
-
-		if (sk_psock_queue_empty(psock)) {
-			release_sock(sk);
-			sk_psock_put(sk, psock);
-			return __vsock_recvmsg(sk, msg, len, flags);
-		}
-
 		copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	}
 
+out:
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 
--

