Return-Path: <linux-kernel+bounces-351737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB51991582
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8235B1F23110
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F713C8EA;
	Sat,  5 Oct 2024 09:31:03 +0000 (UTC)
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9313B284
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728120662; cv=none; b=o5lPU/e0cIxslwXrDownVQtFocg60wLKb7llimXSFhaPjbT86RgFLjwYRw34ojkq0V6nJbuLi19W7gUekeXG7l3qrUb8fchsahOWzWztxDMpZ1oLnab+Gpgwu56lx3pBP+NXG5N1pY6VD5X1FLwV7bMlph+8Mz8Eui7a2PTQ0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728120662; c=relaxed/simple;
	bh=aAgkbQuDSdaMcvSPO1coMTWFTiFZlnNEDgp6yX6CmvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqGrGGTPV15A20DW6hxYEu31tWdRBLH2wuXGj3xWIvY+dht/M7N/oIyVdOBOQewFDjIayc16N+zienNi5tWi6QcgUlo9UtDTqVzviiq6BPE7w+YWo/35JgvdLOxw85qXFXqPsY5RDZYJetX2Adlo5pYPgYUjWzauehP+7n0x8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.230])
	by sina.com (10.185.250.21) with ESMTP
	id 670106B60000143A; Sat, 5 Oct 2024 17:28:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7905263408386
X-SMAIL-UIID: 9D5C3EE092FE4F48BD12D50E33EC6B49-20241005-172824-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in gtp_encap_enable_socket
Date: Sat,  5 Oct 2024 17:28:12 +0800
Message-Id: <20241005092812.2152-1-hdanton@sina.com>
In-Reply-To: <66f18d50.050a0220.c23dd.0012.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Sep 2024 08:46:24 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    9410645520e9 Merge tag 'net-next-6.12' of git://git.kernel..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110c6c27980000

#syz test

--- x/net/smc/af_smc.c
+++ y/net/smc/af_smc.c
@@ -3053,9 +3053,7 @@ int smc_setsockopt(struct socket *sock,
 	/* generic setsockopts reaching us here always apply to the
 	 * CLC socket
 	 */
-	mutex_lock(&smc->clcsock_release_lock);
 	if (!smc->clcsock) {
-		mutex_unlock(&smc->clcsock_release_lock);
 		return -EBADF;
 	}
 	if (unlikely(!smc->clcsock->ops->setsockopt))
@@ -3067,7 +3065,6 @@ int smc_setsockopt(struct socket *sock,
 		sk->sk_err = smc->clcsock->sk->sk_err;
 		sk_error_report(sk);
 	}
-	mutex_unlock(&smc->clcsock_release_lock);
 
 	if (optlen < sizeof(int))
 		return -EINVAL;
@@ -3133,19 +3130,15 @@ int smc_getsockopt(struct socket *sock,
 		return __smc_getsockopt(sock, level, optname, optval, optlen);
 
 	smc = smc_sk(sock->sk);
-	mutex_lock(&smc->clcsock_release_lock);
 	if (!smc->clcsock) {
-		mutex_unlock(&smc->clcsock_release_lock);
 		return -EBADF;
 	}
 	/* socket options apply to the CLC socket */
 	if (unlikely(!smc->clcsock->ops->getsockopt)) {
-		mutex_unlock(&smc->clcsock_release_lock);
 		return -EOPNOTSUPP;
 	}
 	rc = smc->clcsock->ops->getsockopt(smc->clcsock, level, optname,
 					   optval, optlen);
-	mutex_unlock(&smc->clcsock_release_lock);
 	return rc;
 }
 
--

