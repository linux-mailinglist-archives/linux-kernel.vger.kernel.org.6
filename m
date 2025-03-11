Return-Path: <linux-kernel+bounces-556041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8DBA5C031
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D421768AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8402580DB;
	Tue, 11 Mar 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e7kLhcAo"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026425A32C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694606; cv=none; b=WALGJqDjOYwRYpxJk4YPEI9eaP3CRFLfOzjgzOWq0GhXaHpkrFXERbr3mJAkoo9EwUyEeQPevTFu+peK/1okt3eUJRfWSmtzatb12zbpPcAg2LRuu+wQoPfEqUOirOUwfmO7I/DcF8t27/ek5gydcJjmkcsNNJp9ME4FwiQHa64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694606; c=relaxed/simple;
	bh=ri2c4Ytlpnb6MthNw5Uj/vFPwNDGP/hWkEwxnYNr2f4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtZqNwNGBKEkhTRRqfxDQrNbaauu+DfTWrPgUaR4Y2pYzXTGuCBtuHwUgziyLimyLh78sSV8ObtZvIGmWCpUUjuj2vskYhbpVzWJu1ZjGjh/6/xix/wdjrZf+vEO67vihkcYnJCLmXHesEGMcAAN0l3lS6WtJOvrq5XuD3eMq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e7kLhcAo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso4037305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694600; x=1742299400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knj5Ou9okDSc0sSB2beqc0E37iP0V7u+FLPcU5pOcYQ=;
        b=e7kLhcAoemdU5CQ1+MqTl5XYqmdHzYw3UofZ8lb0Fp+7KNLHkoazArvKnWYjP8chQF
         3ZBhe089Po+M1opDLaH5OGkyRqM0CQK2wrhw5K3ckb1Q9Oc139ZZQYkv3q3Igwr5VQnU
         Zt7t77QNib+DB224i2Zf2UkVOUnUeMoSyHfZOkHGgc0g8u/IiTPd15o5w17uThtZefzC
         uJrARnJgBTbMN2qPdae1cyegQAlU3ORZvo5aSnFH7j+YVLIJl64kMxBEMy6yD53w6fKr
         WvogJXlA+MKwbal6aIv6bCs+WD7E4B9EoWmrgx6IepUGidCosSi+8dvZYRaRiBsHlypH
         PBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694600; x=1742299400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knj5Ou9okDSc0sSB2beqc0E37iP0V7u+FLPcU5pOcYQ=;
        b=vcC9JNRTiieQJFabiW0evhIy9fHU5NWu1JtZ/eSWMVtZcrJXPMW4N0ArFgB6HkoYNd
         y81nZD6ng5Riwi3ZmagclIR2RKbNxI28q3lYeAenwblkp1LmT3Ihqdm/TAbfxS9mY/SF
         en1rPP9FRv8rSFpPHZiB+zuQd08eERUsS9rkUrJ7voXx3lDZsZJe26biRUIq1euz39Ge
         3JkJCsHsfpGF98uxBJj2pQFed0zk5Ct38ZZoystLjT27dVD+oaZCPxqhjOwNnvyMT9ui
         qOga4nOLTkrNLi72FZ9gp/Dxlq+4DqbwdZBAT+cXiyl2bMOPHkm8u67nIUVJXvfCqPmp
         YZFg==
X-Forwarded-Encrypted: i=1; AJvYcCW3fXpCK7/1vlQ7TDMuTZJnN6h6993FFCKudhnsOn84EmJJE7H52HcedtQyUGgw7yO7M0Emy+IfhrkSBUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gCWVykzbMTYs980/Ga3QirVtfesz2f7nm4k+4pf/ysHfhxo5
	x+bXy6LHCK9FNGTVpeTB9mwySKR3dQHZz0lN4HQijBXB85uhKysB0AwnHKLwHfbLNKu2sCh2UdN
	e
X-Gm-Gg: ASbGncvTPjLhDI25WW5OjUoaNqoUzhfb3bNSlmaF0cFs31mIHZsMn9iBSGr00ioTkYJ
	uK96DFuI1hTEL+9F/xsyjzc8k1LqaKEwcdQ7BUKCAmwzqx4zoXY9qamx6ZPCNHqazpD/MQVQxZA
	EJUuLPy2/WVAYFeoXkj5DXpWbhZlV+frOPmn4SR9tK4juWddkvwkAZsl3/2w5h0JDoihi6cE27F
	mT+agcGllEB/mJESZoN23If4A6/yX4DIPQrAkzbgySJ7MlQ6YVH3gYluyttK46DNRKi3ZtRGXVn
	s7eauTpJBgC1APhxpiAJC9Bk5anvh7nnRUiJ58rznQ==
X-Google-Smtp-Source: AGHT+IFE78qSsS5yU5/l+uAzJm2HZ5z+m+zV9CngekvXXRG3SR7vhfOo11ZsJyhSi8jrg6/4UN5k1Q==
X-Received: by 2002:a05:600c:b52:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43d01d5f83amr38503055e9.10.1741694599622;
        Tue, 11 Mar 2025 05:03:19 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:19 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:14 +0100
Subject: [PATCH net-next v22 13/23] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-13-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
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
 h=from:subject:message-id; bh=ri2c4Ytlpnb6MthNw5Uj/vFPwNDGP/hWkEwxnYNr2f4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZx7b1lJBZaipGBDRDV/D9519rBlmLohDdpP
 gwu9A8wtBuJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmcQAKCRALcOU6oDjV
 hzHrB/9+xXaf4K5ly3V2Lhg4WdJg6c6ILQ599VLT1cbQqI0Jvc3Slu+OGyItDI4m/LKkiJElsg9
 jPAuH2hshBm4MnggABqtF/zaubRWqrWuHI0Vy4+iKc3P3h9es31lhIfYc2yW+dBRo2+Ht+0LzYe
 CiWpgueT0BOJu7sAbRsKIdqdwoTDL1+atejhVM64dqsyjGFFZB8ooErtC2rqwvEI/WEEmzauNFW
 tXFHreDWmeTL3SyacRmva2PGSOpKPybKzhfQYbCyFH+0XTHnFF+SBTmIjZGzJ4m/hKZw+/xcsj+
 LSF/J3LtiyiIs+nSrLREJJKasz1Q+1W4rxIGWbkYbIH2Zd1N
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
index a5bfd06bc9499b6886b42e039095bb8ce93994fb..e05c9ba0e0f5f74bd99fc0ed918fb93cd1f3d494 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -220,6 +220,7 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -230,9 +231,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
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
@@ -380,7 +383,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	rcu_read_unlock();
 	peer = sock->peer;
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -413,6 +416,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(peer, sk, skb);
 	ret = size;
 peer_free:

-- 
2.48.1


