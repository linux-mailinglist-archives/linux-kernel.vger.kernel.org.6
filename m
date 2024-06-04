Return-Path: <linux-kernel+bounces-201425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ED28FBE45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474A62870C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B3714F115;
	Tue,  4 Jun 2024 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T5X1JEct"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197714EC73
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537681; cv=none; b=u9eII6QEaUezh73/w//MeICcIwMhzC7qiQLLBQ+1OrjhHMaO3WDOaMTfP7X1xkxf5HHMFSYU16HSPWHe5JtVwmMCQaVT3mFMqq//TsqcSHphbNYcsU5rrU0PsgzPSdIk9m+qyXY3DKFR/+SSN2ZNdMRsvlC+4bTdpM/aAuE8rtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537681; c=relaxed/simple;
	bh=j0ydkIBK6v7Eeei6xO8sCTgU/f0LdUJsud2ZNVHdLms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZymRVv5ObWKKir/7PJc9TeQMcUFg8aIUk00o+YYzfhgAUBm5nRmbVvx9zUkSTTDaL8FRdrBnBtCgBhRoqapcwaqilyGPA4VflTx9e+iOOneoGQfc292OPaDwOFeXctDhw3667NbqX7vzfEO/GBw3Jrx5m7ElK/vw0i9un/PDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T5X1JEct; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7951da82ea7so51285985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537679; x=1718142479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAchTAFhWTofDy57Shf/o1FtCjgXoHrGCl9Vam22s+I=;
        b=T5X1JEctGnbiLaXWA6giLtXwC1dEPb/3azd9MjhXYd0QJ46VYdU/3dT/a/VOKXi6FZ
         CPgKAczY1VMPTg/wO1CAkMaybsd0DH3gw0456Gsgn/+aR1x2HXlzh/ULrFOu03B0gzPk
         9wmmd0rwtZaVwWWDkG9QdEKolKKZJZPDlqx9oDR/QORbR/PH09xr08qDpOcdfVSUSRd8
         aYFKrfFPjT6yAU0pNbMBJxsdjRLSfPqkgJdzcDeY+pMYiShbPty/ogRDDdrrPHMMyw+9
         5yAb2e4tH6ZAji28mc0jmbG3f7PBRlAef/+5IXpYAMKRMOP+5Hz0NHm4t560W0rffnFg
         CTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537679; x=1718142479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAchTAFhWTofDy57Shf/o1FtCjgXoHrGCl9Vam22s+I=;
        b=OzbEIBQ6jMiaG9BOfSFZyBIUe4CbdB7zi0Bny4aIVSZd5dXG4f8ul2MS1HX3td+sLE
         c6XE0d04v6vaUKAoPYBcFrIJztvB19/ypkiszKNOtAFSbaPMwg4SVQkaXov4Wc4+WHa4
         k17MvhlQ8eOWjjsS1FaJHFTBzVqxWnHnjRJaZpcfBryco8hstYKskxm/4zlhCYsEIxzZ
         5jKNL/bTvEU1X6pO+S0bFwYDNSNtITN0kpf3n60Vt+a8epw0rn58ALPf+RLn7jKpJvyY
         giSagRJS2+UvHqWuczCt0KOp2P68Uy7dlNVtIMAZs57xGGP6/XeUUchLm1FLQFbG3lpm
         BLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFY1ICTVHQQbBOLnY7EX2owfl4djSwSMw7lUDSFTIAxJCvVxcyOuKpnJpsSxmjLsicaMtczQA3vaNEkApuZPZLiBv2iHcLSguJ5GnQ
X-Gm-Message-State: AOJu0YwcDxI02SNwbDs8mgVfOVP75iqvRSJdWLY6x8RfpR38I4NAOLeu
	DSNg2yZZKMJXPdlz1CTCPyoS7TrhTZfJmudaA4iwEGB+QrTCtwqFfooE/kZYSYI=
X-Google-Smtp-Source: AGHT+IHNt3jn7WJz+jPbwIdxjTdsnrRgXiY2ppLki/PsmmyW/+qrqDLmLsFiCBczM03ovu0HJirHLA==
X-Received: by 2002:a05:620a:2590:b0:792:ffab:75ef with SMTP id af79cd13be357-79523d3f13cmr63560485a.5.1717537679049;
        Tue, 04 Jun 2024 14:47:59 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7951a69940asm70746385a.35.2024.06.04.14.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:47:58 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:55 -0700
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
Subject: [RFC v3 net-next 6/7] udp: use sk_skb_reason_drop to free rx packets
Message-ID: <449b5d073ebc49bb1350b46c56ada8469a96f8d8.1717529533.git.yan@cloudflare.com>
References: <cover.1717529533.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717529533.git.yan@cloudflare.com>

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



