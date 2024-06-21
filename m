Return-Path: <linux-kernel+bounces-224834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83DA912764
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9327B289DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571E1CFB5;
	Fri, 21 Jun 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h28bHYlV"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB634A20
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979502; cv=none; b=cB7ZA4Su+Gdw/qfF+SbdbirUVGB4nJJUANwYc1NjR/9SMdhXvtlWvuWX4fQs8gTptH+4XoMCWT/lfMPlebm1B8L3OyarSMLiNetn0vIzMTPnJtjMBh8ahlFKNIFU0CGRKofwE1iXkktqIpsy9MlJdLHKekDYqBM722uW3OxyMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979502; c=relaxed/simple;
	bh=n7sRdVZnuoja4D98V6jjIaOfl2tc0zgFKRp9P30B6FI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=L9wGauXGI7VDnQ3zQt/MMSQni1vhxTsEl13JAW+8XDT+0RxM0GNIFjNKDMFQfbhy7KMC2q9eo0RRhQWRBMao4LK+uIn7xvIVqwG2e/ZD60FskM5q2u4d/2zJ1JkKt3y2on2EGwh2dxMyv21QgWwS9N17wpR73tZCEoGEmCMsORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h28bHYlV; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718979491; bh=7iGHzMdbw4xNDAwkARERVRAd7Jd5FqkeQAf7UOaKCNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h28bHYlV9JCtHbFoaVs5JQTs9wHzQK9iD+NmufCT1rDPw0DGxsaU0AEkgbht41T8J
	 9OaAPx9Ik0S5OekqwtWEXLLDWQKpbZErdPV1+qkxUs/3JiHUla0GUhFF72K7Sjgo9H
	 6THFZHfXazR05aP7VpNPx/quqrREYhZsT0rDZx1Y=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 48907AD0; Fri, 21 Jun 2024 22:18:09 +0800
X-QQ-mid: xmsmtpt1718979489tzummuvi8
Message-ID: <tencent_492ED0AECD4C9AA7EF06DD92D60679099D06@qq.com>
X-QQ-XMAILINFO: NzOHSugmTg7Xb8RikqmNW57THop/J9mO6dIarxXOQuZK6CJrbYRdh14WknP2o+
	 Xf+r2LC9HeEl7A3BxyUlBGqJVyGLM1b9XkOgVKtg147dG03zKmXsnjSmxHxKTFNuZlAy+jh9XLXe
	 xZtNCx95L+pDrrpZhmgEB58H9L7WHNpWtdNQDvLZY/pPCj7pD5AXTbromnFbVM447VSXqGWx+hwC
	 IpQLZ5W9aDbXGlp4w7oSPUePKIPrmyZ5Y99ixMAM1zA5L1iCU4ef1tJuun9KjYtnfI10A5y5JWQR
	 DkBuS/VCWnoytwEWA/xnncgFRYQQQxq6/22XGPXOLpS1MWJicc2kLAiCn+N3JMsa7+vrwnIJN4sS
	 YVuX2d2mS7rykFenhABG7/yYWaGvvoSHeFeyQdpnkcC21WBmRCYwFdFHqPN3PeHVPXK3RKxsh1vF
	 3bXHFtsbNg+CKd5IiWlDKcBmt/4vmBCLFK9cwVdkTfbMtwR6wT+ExhuoG9xVWZdzr3G53FVnN+l6
	 YbCyrU+DoZBqqtB9NcgQGVFlV7hEP9Y57r+jNFhARjsWPOpPgPWImcZ00evfF94+tUbwinIWRNBC
	 yq42ipsCfZBmZgfvNJXa/+xtJg0ALSZoURMJqm13IwaND/uMtTduNK1gB1iORMWQQXp70hkFb8bj
	 CY9jubeAWJppOxPV4YnR2hR2trI3um1v6JRrUQKFW1zzcbRDhsXk6rfVGD/ubcbQxGXr47l+1J1N
	 MYT6M3xFqkYVmaWMKr8ZNlS4GZ9UQyk4zzHpXSdMSEE5PFI/h894sbgBq6HcZmu1/p3GzuFq4uGx
	 vXvOO1Ppo/TcThbbs4ANHMttdfcAvCpP7QLKngL2mPXXyl2Rdojg08PkoH8dpJcdM7Eg1M3/ly8N
	 MoF1OBGTHcn3I2SzGBSEZF3XvB9lrmNLrNkXSLLr8/TU+D/WRUaPTxxFwhKWzveQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Fri, 21 Jun 2024 22:18:09 +0800
X-OQ-MSGID: <20240621141808.2654263-2-eadavis@qq.com>
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
index 6db60946c627..b72f5db97ccb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1239,6 +1239,7 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	l2cap_pi(sk)->chan->data = NULL;
 	/* Kill poor orphan */
 
 	l2cap_chan_put(l2cap_pi(sk)->chan);
@@ -1481,10 +1482,15 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
+	sk = chan->data;
+	if (!sk)
+		return -ENXIO;
+
+	pi = l2cap_pi(sk);
 	lock_sock(sk);
 
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {


