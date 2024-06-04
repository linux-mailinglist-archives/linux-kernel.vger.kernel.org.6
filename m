Return-Path: <linux-kernel+bounces-201423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C5C8FBE40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86F91C20980
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B4D14E2F1;
	Tue,  4 Jun 2024 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ECNOhF4D"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5814E2D4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537674; cv=none; b=NEge3AfD4jsopjojTdFiOe2J3VpTxQ7mdUSfMX5McZZ/EAPLKy26HnJjoiIvne5UEBMTLL8w1Zt245QizU4hQ0dyRjcjSEEDtLuNmE7sColgFLTqicF2hXXm9HlBR7Dnp/CyKvi2KtCX/+MCIAgmE3InW6c9GpYxYLoA464naEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537674; c=relaxed/simple;
	bh=kSyvuVmoawm0A1229Z9cjCnSswrtkKHtT2WgaP8HoEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kY+LI3meqXtcFY6wUH2cENZJS53ua0wypOMKQAntycwa6uepCGSP8rdE6aXDjtkpUctATRYg4JGT2HeDf4771U98w3aCJEiMXvTUWsIz1fhhwU1sVKyIJG5I96FqJvDVHyf5JSUD1Mw3XxEfnplOLU9uIl26djCaWP7G6wIuPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ECNOhF4D; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44025bb945dso5448041cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537672; x=1718142472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=ECNOhF4DhW2ck/MgMn1GFml8XgX8b+BjYujnwEMYcKdHODY0s8cx8aSIJ1Y1K1B+wc
         fWxZD4GHXFcZSBH5YsyaeEbm0AmPHfFrU4LrrDgr72TrjMXcDE9YiwuNGGtXWNkDRJwg
         zqYbNQ6YRjdRUGYDewv2hfnYC25Id6c+SOJ1rB/aoHgUEFWOR5NMMmf6ZTeLR49z9ZjX
         u2IZQ3sFjhQItraejhwuuBdRMiRqnRuKg3A3P24uM9Xv21/2LWZWwiMFVFOm0QKa4Wr0
         cErmXR1vL/CG0CVG5oKDxRd7y2++TrFJHbgfIPoqgEa83AeIezy9cLfX6nUlgMPDjG0o
         vLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537672; x=1718142472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=J/EyE50HOZyQ2hZq/oL9Ngze0ovRS6PKZXqMk78htj8kkx/iNFoUvRt6Zy2DyKYXTg
         wEoVDeavPqhQ0Sf9so52byDeSMOVYxevvgY/Ghs3SHQSzzbQhHR3gK4i3abOCQ9LSrfa
         D3WC8DBxP9ctPKozTPrF8rJGQO7mSt9lnuPLRT4cI3ptvef4DT5kFfXNaAcm0ExhvpMO
         GsOYqyiTai7398j5bknspx7R5+ePL8pUpFF5K5whcGLhI7Znea9DAHz6Jkv5kw3nL5X7
         VNgf45sty9TqeODzyy2BKsasonPe77cDdWlAv65byXeLpNykTEcltk8A47oxWuhnCTU1
         zolA==
X-Forwarded-Encrypted: i=1; AJvYcCUba+BdgcB0NGFP30MaOtugXBBU2wSOaeUHq9qMyIg6Nnxb4XAs1bm8xyYYLvx/+wxohPp+BtEIgAsg4Ee8ixz74DD1be/3gyMIotcJ
X-Gm-Message-State: AOJu0YzVSdM/sPOr3vU7mECZsqLnoSgVqnt2Jdi8OaIPOaD6XOX9It9W
	6zH6v9UppgGWRhXcorrQpA4vOb6NL9OORlH9HXe0uwsJAIFcm6rV66iSTZdK4Vc=
X-Google-Smtp-Source: AGHT+IGrjmW80tkDxovgZo69Xf5PbK5esJcY0OF5LniVh0HDjzfNjOgJwHal5f9dAzBVDUlBowbAnQ==
X-Received: by 2002:ac8:5dd2:0:b0:43d:f989:edbc with SMTP id d75a77b69052e-4402b670b7emr5780621cf.52.1717537672021;
        Tue, 04 Jun 2024 14:47:52 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4402627e268sm6946441cf.61.2024.06.04.14.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:47:51 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:48 -0700
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
Subject: [RFC v3 net-next 4/7] net: raw: use sk_skb_reason_drop to free rx
 packets
Message-ID: <854cb997b5407fbc4d23014d895f7cef5df724a1.1717529533.git.yan@cloudflare.com>
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



