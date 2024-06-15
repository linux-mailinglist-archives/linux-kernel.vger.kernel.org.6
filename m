Return-Path: <linux-kernel+bounces-215633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D4909537
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A581C2168E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F108C19D89A;
	Sat, 15 Jun 2024 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QIaPCYc3"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32175635
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718415096; cv=none; b=qjmZfZndY74dsig2H/mLkzdxTDggJ4BTMNh/Z+nSIoHM7CaSqSLRfQCanQW7FzTvRH3WTSUQN2qXmU0WxecpQVcOWFJDEh4zP0+5E0EMXmQ1kcL/JHrlNejpA9dUfBSal5L1IX0m4oOu6qGkPjPoUf4LWhCbzfgBB0hviWn1cDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718415096; c=relaxed/simple;
	bh=nehH3T81ejemlLKx/jrzh+9n4GlSlk++MOZyKeiA9U8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=sFQmy76o4iy3PpmpXJVsKoMKxWWZyCI/OfUPDIhCkxtk20ILTHRbu09k/kEhHRTx8h81PVn9asTVYq8wyDEIM0pAQLQf1dbhwXkt1abFKANvISLToROhku+1shg21W3U5pSWTt0fMAOVe9GXwHl2HMpU1ZqCNdME406+dwnmilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QIaPCYc3; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718415083; bh=aPzxEe2AT3dF0AMQYc5JgGBhkzh96nnm8qimgTmA7Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QIaPCYc3Ho13EYA59vk+2rfu/NUbKVBjbP2LY6ElZggR2XRuzuYAPIaDuSBd4JSIi
	 YZ+JQx2Hq19JW63IviP7rbtVyTbdmugXeGYOnV0cjvpqqeFxTE1GJl5g7caHAQORPQ
	 aBuY1uIARsGHX+RRFdoxu4JYmbizYzf9crs6q5+I=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 64B878E0; Sat, 15 Jun 2024 09:25:11 +0800
X-QQ-mid: xmsmtpt1718414711t2bhippe3
Message-ID: <tencent_7C660A3DDB361896D036564A16742F776B09@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeie32sTzZtrFxyKLDjhbnhGkBODtguGQBHuy6ebPnJKRujjB9Ijnu
	 4Z0Hhb7CUAl6FMu3CZXaiS4zw58tYgH1V4j8gvTlbYuxAJsucXcs91Xar+GC53AaTPIFpDdjVpfv
	 p2Mg53LvPeihMtWcU/O0WMlD6Jr4PZieJojcJL6LWgsr7qrW7nyx2r8xU2V3Py01WReSAN2D5esm
	 Dypxrly2WolME4wrCUzaLrODKXSJK7qzrifdzX+qsXtL2cUI3JSMbeU0/OUaI4lR1Db1YM4TL/Gs
	 efmImw37nUe/UI6SHgYgKMb08HpL5mY3NnjWn5DyM3CMJlgkhbFZmeD2YPi1yX6Y6ODMN86LT9V5
	 iszhONPKWsO1YhhGEbcOAAtvOWnCtIuna+RMSaJdXMYuWokSviUOxYdm2vh3dlht4yfg0UHAnEe/
	 IwQAaBZza1JwR/RrzGcTcNvnPy41SzBXYJcZY68QEoubZgZdajiPdvHKYLXifUCQoAKn0OhvpyQ3
	 xuztlprQJHZn9U+9S12LyKLVqsCvcnFb/lFq+J58vEE+ZYzXxbaLlWdN3ZqCiZDZokSH56cV+8ux
	 9Q5B3mf3npmjJOqMgsmEY1uaoZQQglbq7rG9wxvMGP4ew8NJBFPv71QxQwmeMoqfZQ/L30pUZFDE
	 qzAOI0V+0Cay3AbPluVow0b7xaNNPtYwA585O5PKNdE4K/pt+cYGcqszYSFbwJZOsD6NQHKTNdtN
	 +vBMsUqfL0fvpo8guRV3UXpue5FRyygk9yNmqw1/nKSl2uhIX3F/Q6HbePoRS15lfb2FZ4VDwZDC
	 Ou3dfVldKBEQR2Qcyfu1WuClLW0C5I9I93ejnBoMsAdNjGKZTJUeOmxcJFIZ9zkpERjvk8WvLq9r
	 HLYM83+1OiulsSkO3JDFwj9VZmubkAy0FsJ/LJgWpHGZTw92XqZ88=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Sat, 15 Jun 2024 09:25:12 +0800
X-OQ-MSGID: <20240615012511.3389653-2-eadavis@qq.com>
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
index 6db60946c627..d6c2394f0235 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1241,6 +1241,7 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	/* Kill poor orphan */
 
+	l2cap_pi(sk)->chan->data = NULL;
 	l2cap_chan_put(l2cap_pi(sk)->chan);
 	sock_set_flag(sk, SOCK_DEAD);
 	sock_put(sk);
@@ -1413,6 +1414,7 @@ static int l2cap_sock_release(struct socket *sock)
 	l2cap_chan_hold(chan);
 	l2cap_chan_lock(chan);
 
+	printk("err: %d, sk refcnt: %u, %s\n", err, refcount_read(&sk->sk_refcnt), __func__);
 	sock_orphan(sk);
 	l2cap_sock_kill(sk);
 
@@ -1481,12 +1483,23 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
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
+
+	if (!sk) {
+		printk("%s\n", __func__);
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		return -ENXIO;
+	}
 
+	pi = l2cap_pi(sk);
+	lock_sock(sk);
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
@@ -1535,6 +1548,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return err;
 }


