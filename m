Return-Path: <linux-kernel+bounces-535309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAE1A4712D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B73188207C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC861DD88E;
	Thu, 27 Feb 2025 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TzPe2+qh"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5B1B3922
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619386; cv=none; b=Gt1PZff7OSOzdf/MdLe0jhXliCjhLg8o2QLqVtoMCJZOzmFoq9sxB3hxcVzZjCsqy7M7iIle4n3pJumhRhwH0ZEhsLTJ4YUCrgDx/34zSV9knBDXF4jRHny6hxyfBhVmiftpcO0W287WCpautL5NfLLBAOdJETVgTuQboDzDNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619386; c=relaxed/simple;
	bh=TtyqMEWWXVuF5D1AonBdS9TIDufBNGXd/kgliq1Dnl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihk4x3uqe4T/2e3EjwhRQRhLVxgL23EqCHH7MVBhzshc4X21EKQB+SDeS4MTKa99KVwDsuR9lBUsRVcNoqdV6OOOdv6cX0PCw79u2RO0YCAYdshQ+xIFeCX/mHm6ZLBR2j530lJUqQygW+tZVO2XHuR3EDWcLgf0JCZVMANFsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TzPe2+qh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4397dff185fso3767415e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619382; x=1741224182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uMr00AMeKOQq6/G8Cq5+hM8t9kqBTSy3qx3wjRFbm8=;
        b=TzPe2+qh0i2N991gBSnTJXifuqnHpd7Sqi+G5b8AXh08+UlCXOp2CdOFZg80oMg7DF
         P3+V8GTKLFUzf9MNcXNkCTLBLhzRCMFu8xCcz1xyVodlk1Y1pZNYq7AC4K/x/u7oPDm6
         3JmbvaZJhZsmcusXaEaCfmWnF3XagDkRCvM/fMWou1/dxnx624xpzMCoQlUqYBsAkaB1
         OAFY+NhQw0X3ymsPZGVcAUhQe/2mPYmz5zgo4KJ25d2+r6IyFuxKq+6SiPb2H4T2OvH5
         sOng6HttJV4c4k2Atd5n0joIvSBlsZNpm8/sizhjQt8MCok0zb48u0rFlXAqQYNAOSft
         pKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619382; x=1741224182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uMr00AMeKOQq6/G8Cq5+hM8t9kqBTSy3qx3wjRFbm8=;
        b=kS4AOv87K6UoXR6zZEwV5jy2zOA4KWFxxhbOmAZE+KOcE6nI3p/joOJ2PRJLK87FW5
         PlTWYoIe1fDmp3/5JEiVXH8Cn6F43XL4+nOPP9Qll+T3d2O1y2Fcq9Qbj/akGL0ioQCq
         RalnYwPllPI2dBuMkT7lMUuAnbySvb6hILUvfIfxYTeN+1PRbHG1kCFuIkwJum6a2MKE
         lQyqDHJVA5uUaaE2f7w/Mv1zRaz6H9XjoUEFZuWENE6P84+gDqI90/ykgxxovuFmrAIV
         vmHBitSDpxmOJkrAvxTWYvRQWdafrnmcEj1mFXtnauIPoh0zUYYogtBkRtcqjw/9IqjI
         luaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxH5PqncrkQGhDdd8E7caJfohtk9fZhN3l/T2p69EhQw6UTUfdEb3cLtNGlozNnT5ibIJn+axWTYZ5Bcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkryHEdKi8qz9Cq1j7nsYQeJzSKlVIAj4m8eApzDeSPMJW1Qw
	vJbSM6l08cKwDH7V4P0xtcy3waFnPCUBswhFazzt3HxbatuY+/GKdtPDsqWO9WbpB5m4VdCSU5I
	Y
X-Gm-Gg: ASbGncvLVSve9n/8wdqhRpQcRCDg3A0nxdFTGdqRr8zj7eD3iFPJKd3MJlIrNWJai/6
	0D9n2xBJmP1VksKgJY6gzgtQO5vG2ZbFI3ZQ7GWTpDH9NjHikUq4NZX2XtLHFWTD99fLQ4tCONd
	xCxnjh84WcCTlPCFGip2KEYEKo2H8wmOlv1Yu4C9zQGJC2Gg4hF1YR+M+qjHPE0+aE2qXGWCxyz
	a6BenkNX8WE1AQgWZgHZn/I+NssEO1egV/lcws4vHAAKlQv3Lw7aD1XHJHVVbzmRnsNq6Ixppku
	r4Cw2/LNlhOkLg+SKGgM7HPDGRCKq1JBDXzxow==
X-Google-Smtp-Source: AGHT+IGZThjyw8csEc9jaKBEB01FBs7BagGwCj/RTwFGtAQi5NzxPS4XLTcnCxkbaJJKJ5YG1bTYuA==
X-Received: by 2002:a05:600c:3148:b0:43a:b0ac:b10c with SMTP id 5b1f17b1804b1-43ab9027824mr39036915e9.26.1740619381916;
        Wed, 26 Feb 2025 17:23:01 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:23:00 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:39 +0100
Subject: [PATCH net-next v20 14/25] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-14-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=TtyqMEWWXVuF5D1AonBdS9TIDufBNGXd/kgliq1Dnl4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75gt9fLJiTmhxT0bUy5Bi6FTRSIqFhwvBG/A
 2zr4Z49m6qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YAAKCRALcOU6oDjV
 h9NQB/48oDDwO6rfMTo/wD4vJDTUBdcmTjVgmpfNVuMKMBdBbkaaKaziuenj8/OcDoCwbRuXOIm
 4k3SLbk1dc1Vd+AAZL4XfRJjhwAfsyOCqbeit/q2CjTi5vUReTA15QVMm6yZEhIXlau4IHeH7dq
 c3IpDoT/c2OYGGAcNlN3JzUhuVq3u2W3PLuO0yFzb7ZJ49XzZQedJpqiSTIWm+KJTG1mbjizx1p
 fcy+MoK++2YUania4VCIgo6H216+LY6gceB1TXsqtKNIZUSuYWbJBAfTj7KN+uLzFasxwPQpXRt
 hbet8lVu2vx4RfMSU2oOw/4EIfmVTb9fRIkgIqvofOH1iops
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Userspace may want to pass the MSG_NOSIGNAL flag to
tcp_sendmsg() in order to avoid generating a SIGPIPE.

To pass this flag down the TCP stack a new skb sending API
accepting a flags argument is introduced.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/skb.h |  1 +
 drivers/net/ovpn/tcp.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index bd3cbcfc770d2c28d234fcdd081b4d02e6496ea0..64430880f1dae33a41f698d713cf151be5b38577 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -25,6 +25,7 @@ struct ovpn_cb {
 	struct scatterlist *sg;
 	u8 *iv;
 	unsigned int payload_offset;
+	bool nosignal;
 };
 
 static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 2d343bce477156a9f60ce92d18c815b7c832d2af..10cb0493290c9c4b90fb2734bcc208853d77dfd3 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -215,6 +215,7 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -225,9 +226,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 	peer->tcp.tx_in_progress = true;
 
 	do {
-		int ret = skb_send_sock_locked(sk, skb,
-					       peer->tcp.out_msg.offset,
-					       peer->tcp.out_msg.len);
+		flags = ovpn_skb_cb(skb)->nosignal ? MSG_NOSIGNAL : 0;
+		ret = skb_send_sock_locked_with_flags(sk, skb,
+						      peer->tcp.out_msg.offset,
+						      peer->tcp.out_msg.len,
+						      flags);
 		if (unlikely(ret < 0)) {
 			if (ret == -EAGAIN)
 				goto out;
@@ -370,7 +373,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	rcu_read_unlock();
 	peer = sock->peer;
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -403,6 +406,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(peer, sk, skb);
 	ret = size;
 peer_free:

-- 
2.45.3


