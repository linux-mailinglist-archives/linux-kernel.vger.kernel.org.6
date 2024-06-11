Return-Path: <linux-kernel+bounces-210564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39039904599
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAEE282C71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685C15278E;
	Tue, 11 Jun 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="btQCwUEn"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BF155A43
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136707; cv=none; b=BDqLq48lXEItKTbF+gbLC3KiFIffNetT9ADhgEP2feK0vRq/72NImTNC+LzJcOH+h8jNjIcZj1pNNmWhDHEDzTisfdIdKSdu5Q48y5NVZawlweGyt98Fb9FGWChe0o8bB50UtcSS0P//SBjUHZb7mcvUjKx7WSELF/ryj0ncw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136707; c=relaxed/simple;
	bh=j0ydkIBK6v7Eeei6xO8sCTgU/f0LdUJsud2ZNVHdLms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn0QTx4FENH5VuZNyUd9d+s97gkOZKfKUJVWxvrisVwW5L3qYPatOh5/2qxyAYV4JPM6LmnVMt6SVTB3Dok64JSXr7ZITo1bQsGwQgQ9XawJM/3cExDm4+Nr5J5KP/092LvvdDjnJfJcAmL5AVq7vd4bsdev9h+AePf5/jxCDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=btQCwUEn; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b06b78e716so19773346d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136705; x=1718741505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAchTAFhWTofDy57Shf/o1FtCjgXoHrGCl9Vam22s+I=;
        b=btQCwUEnz5mYGvQivuuuQwtQFHqYcLe85KdCB9GWw4BwmMAwm/WitqR2aLYDydLe2+
         5rcgY12GsJ0++tYhUec/4nW5eaOOJgt5j4GG/mi9QteHSfTAG4abq/mkZtKdAOm2um/J
         43repbhJ4b61ZOUlfGRd8F39X+oFgdfRGtRCir0jULxA+iFjzGUBfwFagnqq/NAKACjy
         XZTPlyGE/jcwY0ROiWPPWHHc9HzyiRyLcpfRiwfbK8BdvQKA9c3J+2OVG9uVE6LNr067
         6chlEAiZEVuuTx5urW+sXnvjVinmW5C1p/EnuUUzbkezN+ESelF8SQvGaSGoWwrK736w
         7qHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136705; x=1718741505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAchTAFhWTofDy57Shf/o1FtCjgXoHrGCl9Vam22s+I=;
        b=X6N4BCgNkHPRGxzq4SuCQQJro11Ff5YuvJBiOhMe6z9RcJjEv43xX8GvAHeRDpUZgh
         ZXs9ZVWEvWwPF+mYCU10lY4uhjf3p91fEMxh5lkbETWbUHuIF8X/fF120FK2TD5YeVnD
         9dOY+OxHgE60UyHX7LvAGMiNnPRb9P2j9SQ0ouI6lxCKtyL3cVRpnZ3O3DtqVTKTRmT6
         tVhoYiTg12FrboeFP6u2/zBkSvu8GjfKpFhq4eX58tL7sxzSOlgvzsnJX6SN7l5Jd7jh
         DC8EJBdOxxGwgAVT5W0tzi5qtTHi+56bkABzIYiyAdZntc3cjp9V1qARpa6D8Ogd3Rdv
         iUbg==
X-Forwarded-Encrypted: i=1; AJvYcCX0A1+454ELFsTrYgiMRiaUFB+1Ri2YkZK/mZVLpdC/rkE64EPsjdTUXPJjUATkoTM0AcGAmppB6rxQBpeI9mO8z4FBrjsU8pozZiGi
X-Gm-Message-State: AOJu0YxtKavCgYt/HXIy2MpfXOppQQzkw9pjpYm4vwBwSYuHPhlMTmmG
	K5Gau+NxJnQa0SrsghJLaY4Z2wHAHtqrCksOi0vb2T/Zo/d9KCqNYkHn0Z80a7g=
X-Google-Smtp-Source: AGHT+IEK2A7vGoKY5E2V9Rwtbr7PMRiox+OCvFwNmPWCHFGCi9cRvjVD9gQTHMU1KfmJN2HlWmQyug==
X-Received: by 2002:a05:6214:3a08:b0:6b0:8d20:e57e with SMTP id 6a1803df08f44-6b08d20eba6mr25114156d6.7.1718136704595;
        Tue, 11 Jun 2024 13:11:44 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06ed7213bsm37089046d6.15.2024.06.11.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:43 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:41 -0700
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-trace-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4 net-next 6/7] udp: use sk_skb_reason_drop to free rx
 packets
Message-ID: <3398cda9d35d079a7563ceb08c49fbc2aa7c9021.1718136376.git.yan@cloudflare.com>
References: <cover.1718136376.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718136376.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202406011751.NpVN0sSk-lkp@intel.com/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: added missing report tags
---
 net/ipv4/udp.c | 10 +++++-----
 net/ipv6/udp.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 189c9113fe9a..ecafb1695999 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2074,7 +2074,7 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		sk_skb_reason_drop(sk, skb, drop_reason);
 		return -1;
 	}
 
@@ -2196,7 +2196,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
 }
 
@@ -2383,7 +2383,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
-	struct sock *sk;
+	struct sock *sk = NULL;
 	struct udphdr *uh;
 	unsigned short ulen;
 	struct rtable *rt = skb_rtable(skb);
@@ -2460,7 +2460,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	 * Hmm.  We got an UDP packet to a port to which we
 	 * don't wanna listen.  Ignore it.
 	 */
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 short_packet:
@@ -2485,7 +2485,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 drop:
 	__UDP_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 }
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c81a07ac0463..b56f0b9f4307 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -673,7 +673,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		sk_skb_reason_drop(sk, skb, drop_reason);
 		return -1;
 	}
 
@@ -776,7 +776,7 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
 }
 
@@ -940,8 +940,8 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct in6_addr *saddr, *daddr;
 	struct net *net = dev_net(skb->dev);
+	struct sock *sk = NULL;
 	struct udphdr *uh;
-	struct sock *sk;
 	bool refcounted;
 	u32 ulen = 0;
 
@@ -1033,7 +1033,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP6_INC_STATS(net, UDP_MIB_NOPORTS, proto == IPPROTO_UDPLITE);
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
 
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return 0;
 
 short_packet:
@@ -1054,7 +1054,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 discard:
 	__UDP6_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return 0;
 }
 
-- 
2.30.2



