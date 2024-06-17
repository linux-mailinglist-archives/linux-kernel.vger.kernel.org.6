Return-Path: <linux-kernel+bounces-218090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824AE90B928
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C2B1C23D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABA3199E8E;
	Mon, 17 Jun 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Zuj1ZWqr"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022861993B7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647762; cv=none; b=sLcyCwtoOApOoDJ3cMRzkbftuF9wK0hQMQ8YJ5t9odAtQjuIQc1pg/IEKTkdrwX5ubDzSHQOwAMaPjJDmvyl0365x1E4nPb7xkIgdxI4Z01ozN6YqV/f5eOXuaURdMItXnzrAAO6zF2/I//Fmdw+oAN/fryZZGbkjfXd6hzNrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647762; c=relaxed/simple;
	bh=kSyvuVmoawm0A1229Z9cjCnSswrtkKHtT2WgaP8HoEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNOG6F+2iptEhOXmr+3yPWeTXewecVaoXx2he0hCD1P/5Ju1Ek7niYHseE0neYHoOF+2QUJK/eQZBoNiHCZt0erQmrQvf8ILSwH0mBnDlCVaSt/IccccX9FKsKEOZimVRDlBF5s+XP12wOUoEwTZIOIxp+/kl+Ji49h1sQ7c/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Zuj1ZWqr; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79767180a15so316493385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718647760; x=1719252560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=Zuj1ZWqrgc1oKVPzaxNH89GqWcd5rKo/WitGeJdHTtXxv2SpD/uGNAR772DWC97sgH
         l9+6bpma9ThbDqOWlk9uuyA2tcpJgxEMp00mIZKZJfX6lJCSEU1xRTE5QMXDwScJ1HhY
         5JreeDmBoqYURw/NXZC36kacsJmGj3yZQqVGooTwWmlhyqvWVr8F0eD3aFrU4vfX1yzG
         C8Xyofx1rF8znhAYC26htNv49Svm+UlSBC6aBVB3NPWtEe1Z+StDsXV80w5FM5Vs56kx
         TGYMN4+e7oXo/lXrjYDKe1RYpX9Z31w3/WxkJfG4v0u++taqN5hb1uW76w3rpCIcJlvd
         5bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647760; x=1719252560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=gtsMhq34uSplOG0fkeDR5zAgdeGl/9DPQ06Orx6+8A7RasV3SesE78fcfkEjR3JDHO
         RlefMaHMaDy0am8xuSrxBaYRerY8LkOq+93t6yInYYhtk5m9HldNWzZNtz3BsJcNGLMN
         h3kEEel0iqz7K7Bs1lXdbX0cl8UG6bgkaee6gk9Z50eptqOOcpVKuhu/UYonmsSURFMZ
         UoMiaASKwiVw7Wu1iFkqRPeq6nKothZK6cyBcKHTLwKwIRo65IIc4q4fsC07ero84vCt
         OLpJVq1kOvEV3RPtdtF7qSXX3fswFKqmsVIhU8Va8OIilYNa3ljTTLdZ6M6PzNaqtFiV
         ZSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRozPWVCGtz6EbzPGCwa20/HabOUDra10axyHT0ernj/lwrvrKTvavy3w5Ok5eTv+rOy+hGgUI89LBwgpE+donH05uQLU8hCBXb0dZ
X-Gm-Message-State: AOJu0YwnjHQXByjDycGLMEQVdscpdxv4B/pFIRPdP+OJnM0Skbphbl+h
	Pm/BiC4bSJSqN+Q24ZtddUHFMlClQtjjYnw04n/MOGzcKFqfGmHhk/CZ+vSQrug=
X-Google-Smtp-Source: AGHT+IFt142mv1kQXOxjOXG2zlKr3bAUesSTGPIJ0qabHwch6YJ0EygKVZ1T56BN3wNDO4NEfEIHhA==
X-Received: by 2002:a05:620a:179e:b0:79a:2fcb:ed4f with SMTP id af79cd13be357-79a2fcbf663mr1038790485a.13.1718647759840;
        Mon, 17 Jun 2024 11:09:19 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecbe5esm450927985a.30.2024.06.17.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:09:19 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:16 -0700
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
Subject: [PATCH net-next v5 4/7] net: raw: use sk_skb_reason_drop to free rx
 packets
Message-ID: <ecc59c738bbe913aa031c7b37cd78d9fb06096fa.1718642328.git.yan@cloudflare.com>
References: <cover.1718642328.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718642328.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/raw.c | 4 ++--
 net/ipv6/raw.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 1a0953650356..474dfd263c8b 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -301,7 +301,7 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	ipv4_pktinfo_prepare(sk, skb, true);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
 
@@ -312,7 +312,7 @@ int raw_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index f838366e8256..608fa9d05b55 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -362,14 +362,14 @@ static inline int rawv6_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if ((raw6_sk(sk)->checksum || rcu_access_pointer(sk->sk_filter)) &&
 	    skb_checksum_complete(skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_CSUM);
 		return NET_RX_DROP;
 	}
 
 	/* Charge it to the socket. */
 	skb_dst_drop(skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
 
@@ -390,7 +390,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
@@ -415,7 +415,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 	if (inet_test_bit(HDRINCL, sk)) {
 		if (skb_checksum_complete(skb)) {
 			atomic_inc(&sk->sk_drops);
-			kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_CSUM);
 			return NET_RX_DROP;
 		}
 	}
-- 
2.30.2



