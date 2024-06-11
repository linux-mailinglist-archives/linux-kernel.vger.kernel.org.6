Return-Path: <linux-kernel+bounces-209331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9829032C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAAA1C25590
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706F4171672;
	Tue, 11 Jun 2024 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="joAzkqwJ"
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094225745
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087762; cv=none; b=QTm7hCFQcNhGuCS3BYhUVDR/Lo898PUT1/GJ+A3hVdGroaQiUwbSwCyJiY+d1hUz2dJWK7FAj+EqC/FYf2JNU9+WkhGzVoQcjNE+JNKGLQSGL+z2VO/G4ZTYDQW6J/AAxWVeyjMvaOMRFj8xUY895CBDYQ/8QBxOGiQVTvXnzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087762; c=relaxed/simple;
	bh=2TcxIHarXUetmN6m+p7MSOSHn1eK/BCK+GeqZ5spaOw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=A1VrNL5udpHWJRvpQWSjYxhyzARu/dHSWnrmY2ejB9Es/3dvvumg7X8N9bT0pITcgKRLwnAeNIkHMv8gDZY7K3nrHB7X9iOK1b7wKj4k3P0eCyCygcx8nkHQROi5veu7mA9o5loiLJdC7gVvdVvkhOLaij/l4Ro/gw5SSvdXxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=joAzkqwJ; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718087756; bh=+LJqoTztZ9FFlDRToGk5VAfBsCHNi2dx2x3RsSC+pGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=joAzkqwJiFcHqF/8iluE/yJFt001xciWRZNWUD/nXuklUJk6ZsoarSQc/h88bzzr4
	 9X2kF0DaPBKEoKmQpCmp3m1fY67RBGyvXYiPIIDNLtBTn2J79sjP3Fi89CBa3jE4Dt
	 ZYlsVgmOjW0Awf8gbxsIx3A1kQYi6isJlRjclxtc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 8F62EC1F; Tue, 11 Jun 2024 14:35:54 +0800
X-QQ-mid: xmsmtpt1718087754t874zkw7a
Message-ID: <tencent_554425A5BAF0BB7633499ED51B7D4BEF1B08@qq.com>
X-QQ-XMAILINFO: NUygYfydBsqcI4zVzxZJ6YzLLAckxdkIfw1DtgWHPHM2ftRGu35UpSmbWBK1sw
	 iTogOVETBTCycwSU6emXoHeLaCw8XhWBWvLbYHFcqVzKNDdSRSpRad6GkXqT8Jod/Ep+myUXS8fK
	 K7qXHDILtxgyRT0LhMucuG4K/vwB9b9uWsxPvis6wtNapaCqP/LLk5C1CnixfH2/+u3ghZ4kqjX0
	 T1XPEOxmSNis88PKOtXRrjRfLZ3A8D1P21Grov2WAJFUuoutpwihJEDl1NQZ9KJ1gZeAk2xopOKs
	 Y3WM0xMLtJtEEC3TE6gi1ZsSEF5xZNGIiPIFIYpXS/GvXLYq2tRCEmvb/mI8UbmBi9Vx05tUkqrN
	 A6bUXPp0KCSS2GaIjZcGcxkPGPGAj2FVSp2gO74zKh0pMDmEzKRmDVsprhAT4V93CZ41wD21NW5z
	 hcLfXrGy63qfl2F/i34uDK5XsKJDStzEIovjiqIMwHvIiOwJvgo+B6bx/KhWOR+YDmSL7cU8gmiL
	 xlBsy8yvgRaAHo2K5R9TUUoRvyY8WNUsIhY80J39/mHqpQQGNZUEzv1xYyIzfOzCtVSrwatgkbfX
	 3JJatKN6h2dFTNguMh5jTYLg2FAo7FoQM43ybXRCEwPEE/ozt0JFp9hU+/iXrnS+xyl3BHa3Z4t6
	 QdX38ZaMZb7UnrvnwOh4yQMUw+rpbUgGV5Qys2899I5lBcQa0b3lUiWJrDUi8Mp5jlkKmaECDk8U
	 ySCCy7OCe00oO0wdjotefs4h81E4XiVbw802LLNTK4aLKf+lupbemp9BXmcmv3pb2f/dl61fBHyC
	 wtshMao+w4kikF1+QWrrza2Et2f+JvV9qCEGl/COOZ3Emj6kgyD3VUPmZO4tPRzc/LcKvYGloQv8
	 n1qnEA8bgMTNfShwUpBwwU+OdXYPoogCkTEf8Xh59fAy/w0xVzvjaKFk52Pwl16nX9rbZwizUk
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Tue, 11 Jun 2024 14:35:55 +0800
X-OQ-MSGID: <20240611063554.1641767-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b0906d061a468b93@google.com>
References: <000000000000b0906d061a468b93@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr defref in l2cap_sock_recv_cb

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cc8ed4d0a848

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6db60946c627..a9edcf9152c3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1413,6 +1413,9 @@ static int l2cap_sock_release(struct socket *sock)
 	l2cap_chan_hold(chan);
 	l2cap_chan_lock(chan);
 
+	printk("chan %p data: %p, sk: %p, %s\n", chan, chan->data, sk, __func__);
+	if (refcount_read(&sk->sk_refcnt))
+		chan->data = NULL;
 	sock_orphan(sk);
 	l2cap_sock_kill(sk);
 
@@ -1481,12 +1484,23 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
-	lock_sock(sk);
+	l2cap_chan_hold(chan);
+	l2cap_chan_lock(chan);
+	sk = chan->data;
 
+	printk("chan %p data: %p, is :%d, %s\n", chan, chan->data, IS_ERR_OR_NULL(sk), __func__);
+	if (IS_ERR_OR_NULL(sk) || sock_flag(sk, SOCK_DEAD)) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		return -ENXIO;
+	}
+
+	pi = l2cap_pi(sk);
+	lock_sock(sk);
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
@@ -1535,6 +1549,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return err;
 }


