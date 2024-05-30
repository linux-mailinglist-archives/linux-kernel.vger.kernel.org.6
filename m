Return-Path: <linux-kernel+bounces-195952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7368D54C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B61B251D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A71862B0;
	Thu, 30 May 2024 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B+TVWrV7"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CB18733D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105629; cv=none; b=SBon1W8SPgVixYB2Ha/95awrB5o0tp4AtBBYRAj31lfCjM8lQ7gbOQLSvYmWtkmMewXH2w5U32HxG2sEkBPqWmJXYworiLdc5mpx1AuhtWdoiE8m5Rxa5dGAnyQUVfUL6sfi4sLMHHFSqUtLRqD2Vs0WSAissBMA2/zfkCHG4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105629; c=relaxed/simple;
	bh=vPCt4wAtO1HnG/ewxxcEuNhbOK4WI09M32LaeYKYdac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeR+8wMNS+98KNyzStXJR/QxopijFMYZH1S/BZTFNXRq6o/2CLHQRL5MDmeN13HY3jZCw2Ub+OcnRzIwp3gqkWehCR5n0pUbLhf1vfqB8cggy6l69OmNak2Q2kTQmb2mobYDdaqgZsL9PU3f8T9RPjDPgMJxOsHr9aPw6uwz01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B+TVWrV7; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d1bb1c3b74so824452b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717105627; x=1717710427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgOT6ysidbDZUdOMVUdTAX9+IvxmNFHfY7koismnltE=;
        b=B+TVWrV7DoBOVh0/pNl43jXb/mu8Zl4ACR1cwegfBEWhI9OMROjQgxCKQIgsfHZHlm
         JX+4brnMEOml97/OJcDlSmdwkV+iVgVyXRyy6E2Zt3ow/5n1DUc990JygAUc0wa8LmK4
         1YWwoZEQ36ZEncyVo7z3Uq/8BKN8x+rRD699+mJdw3+Nme4/oj1FgQmcMAYCv9ifrj/e
         tOJtEkDf2bXM39Qy6XvfRcopxFqJeBo/xzt7EH47el0MMLTJKxdReR6ldPy9e7OTUwgQ
         /Nl4/muW7oTwAvHkReuSPCUfaGvSyVm22gxMA2Np+Ue0XpXBb/9m3EKfAE9ik+1JaFFy
         T5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105627; x=1717710427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgOT6ysidbDZUdOMVUdTAX9+IvxmNFHfY7koismnltE=;
        b=KeysiP5ZsQB1Q08KfFf7/Unil/5FGwip6IjnG9YzCt9fadxZKjHy8NeFnUVAW5LGF7
         NSt728j6s0eYee1ORyeaWyQqqimTjrOO5OUMv3lOgMcO4kZepHLm3uuho07XlnoVK2BT
         Txeq7mYMryHxjzKOb9vpaMrUcaxNz+i8uiMnYfZEAO40bjQDOGUKiAy0V4fo3p9rGR/n
         +1rUmpUcnoGgseJxDo9Rxu8eJxizWuxhGvgI9SsEYH+Wh7WoeN2Vrlgl5ue+a/otd8Xh
         n1WUCgpGesiWjo8NZoJusP3rXELTxrn94SurRP5TBP0YOKggmENwMuz0k2503hGLVJOF
         afmg==
X-Forwarded-Encrypted: i=1; AJvYcCWrl5fvAiPb49YqXgne5L7ApV8wjZDWdVt6Bz9rAqvEOf9xJRJ2syVDwT5zV1yQDWOJiCX5w6f9SUCYr/Zx+a5wGpsV/Ow+9mZfjxuL
X-Gm-Message-State: AOJu0YznGxHvivFsep8RGkaIy2j1t3hPuswnl/EJQt/GgaTIspVIcocT
	ewJksXPK/F8MK9DA4qycYo7XqcDo+ye2QFrf5HF3gXYkf7/dqvfNLR2r6L9MkRs=
X-Google-Smtp-Source: AGHT+IEYtelnJyVi+cGFfRgSrc10AA9izjzGiI3lDu+ulwo+lb8cwJNtiaOv8DUtTMKtfa7cDYp9xg==
X-Received: by 2002:a05:6808:11d0:b0:3c9:708d:ca69 with SMTP id 5614622812f47-3d1e35cd6efmr10513b6e.56.1717105627129;
        Thu, 30 May 2024 14:47:07 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a746691sm1919416d6.38.2024.05.30.14.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:47:06 -0700 (PDT)
Date: Thu, 30 May 2024 14:47:04 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [RFC net-next 4/6] tcp: pass rx socket on rcv drops
Message-ID: <48392b4d422dd64cb8e76822737928c189b2b4d2.1717105215.git.yan@cloudflare.com>
References: <cover.1717105215.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717105215.git.yan@cloudflare.com>

Use kfree_skb_for_sk call to pass on the rx socket

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/syncookies.c | 2 +-
 net/ipv4/tcp_input.c  | 2 +-
 net/ipv4/tcp_ipv4.c   | 4 ++--
 net/ipv6/syncookies.c | 2 +-
 net/ipv6/tcp_ipv6.c   | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index b61d36810fe3..fd0ccf0a0439 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -496,6 +496,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 out_free:
 	reqsk_free(req);
 out_drop:
-	kfree_skb_reason(skb, reason);
+	kfree_skb_for_sk(skb, sk, reason);
 	return NULL;
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c04a9c8be9d..6c5f6fe7d9fa 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4849,7 +4849,7 @@ static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
 			    enum skb_drop_reason reason)
 {
 	sk_drops_add(sk, skb);
-	kfree_skb_reason(skb, reason);
+	kfree_skb_for_sk(skb, sk, reason);
 }
 
 /* This one checks to see if we can put data from the
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8f70b8d1d1e5..cff9e0c7daec 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1944,7 +1944,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 reset:
 	tcp_v4_send_reset(rsk, skb, sk_rst_convert_drop_reason(reason));
 discard:
-	kfree_skb_reason(skb, reason);
+	kfree_skb_for_sk(skb, sk, reason);
 	/* Be careful here. If this function gets more complicated and
 	 * gcc suffers from register pressure on the x86, sk (in %ebx)
 	 * might be destroyed here. This current version compiles correctly,
@@ -2381,7 +2381,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 discard_it:
 	SKB_DR_OR(drop_reason, NOT_SPECIFIED);
 	/* Discard frame. */
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return 0;
 
 discard_and_relse:
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index bfad1e89b6a6..d09fec4bb0c0 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -275,6 +275,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 out_free:
 	reqsk_free(req);
 out_drop:
-	kfree_skb_reason(skb, reason);
+	kfree_skb_for_sk(skb, sk, reason);
 	return NULL;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 750aa681779c..c7a7f339ca74 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1682,7 +1682,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
-	kfree_skb_reason(skb, reason);
+	kfree_skb_for_sk(skb, sk, reason);
 	return 0;
 csum_err:
 	reason = SKB_DROP_REASON_TCP_CSUM;
@@ -1948,7 +1948,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 discard_it:
 	SKB_DR_OR(drop_reason, NOT_SPECIFIED);
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return 0;
 
 discard_and_relse:
-- 
2.30.2



