Return-Path: <linux-kernel+bounces-201426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E758FBE47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2DF1F21E25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C00814F137;
	Tue,  4 Jun 2024 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="F0YGIPaM"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227EB14F113
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537686; cv=none; b=BSlq2rTfQQj1T6yq3C/+6qoRT5qV4S/TxEkk06Amqj6qQ1ZxET3aQ+YYshWAayz0iQSJzPHKXFhTCFVXc10FTAaGXHTtKzdnjjRamK5gq6Z1/FewyxOikegQwm7051HvAQE9taSWsZ97a+tTBAwU9B77sIVCn7NsXzYdCLuikPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537686; c=relaxed/simple;
	bh=uEGMHEFbMp0HLSU5Z7U4ENmeA4RvQ8IslnoZTeDpYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoovlly3FjatkK+zXqpbEuPgBeb1OKTkAipy4U15NJ6Bz58tM6ZWBKIbHZYguoUEsDGPWwqansAFAyw+TqnjLagpNYOk0bU/nuvkDlUwCZ165+56AGsoJvJTgFRRbV+HkfwH751KACOwIEADRpBzTAV/+Ke2ktXeWQnesTqrb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=F0YGIPaM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6afbf9c9bc0so13763676d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537683; x=1718142483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=F0YGIPaM93k2hd8gAAMatCKDnEXoBJD0/kl28LTYZPwbQgJOaSlpNPIySbvb8tpCUb
         LTfyQlbFJr3uE6aIYr1Fq8awtTVe6uijQlzsui4kBZKgdzbmV2zXQ+LmdQM64i4qI7zC
         E1OrxBwneRq1oFhNE+7MBHsf9KC3l+/cXKf05bieZUjjW2rwlpDKV/KZTL+mLc+Hvfnr
         nfWKopr9oWoPaGjwmQa05zEOFBPlRTBQdKIQJGYfJ+TTPS9GPr/gHQFgPMPT16o3bne9
         9OwXAv3qzfYebk6ycFiBxZgAvb/5OK/+sCuX+5IEor9DyYXVn6jGR1zM5+f9EZfkKp9f
         nHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537683; x=1718142483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04wpAGrgh0quqRhPOuIE9e5b5DYf6qkerlRm6e6uUE=;
        b=Mog3mSZ9wgRdkkCHWk4YHz3Q983HQElDBEmSOD19hvERcaEddAfJT8jDFI5FwVwaA6
         m4UTMi6eM0jmoUpcIcBb1fE2VCkm9Rovc8iklJL0b/gmO6jt1ToBlKOXH3BrZOQo89f4
         PdiEoNm67Yjd1ReSzIdg42R6WGjaYyxbGheLFNOL1Rfbooazy1xOu5cm4MWjiuP6sXM5
         HDaORdwJCoNm96bBZyAM/NtGs14hQjjEPJhCRSJcHr3KlgW8KXtrtUm9J1x9MPIg4ies
         9q8sTKC2/LXPnGfxZeXOkdteaU3gqZCOnvqMVW14d6JracLCch3ljs/iaJeaM12Xcp2i
         jFzg==
X-Forwarded-Encrypted: i=1; AJvYcCUEe8aofBRrEq4H/LEWWLu6IYdMW6/+vs8zvi39i1H1LlM9KDu/Ik+d1ZrOBFK7aUrQhkSlNWdylpcEnUqBsYo/rMFT6mcUilXYx+Jy
X-Gm-Message-State: AOJu0YxKK3bLt4CEUL51lZ6jDwxND8BBA/xImSDdMbvZYY1PxJh+XIN+
	ubRnJv18xKFfOEm2I9+++FXU9giRpeTBcjxeIvzg5xG5FFY7o/B8gaokFH6NVjA=
X-Google-Smtp-Source: AGHT+IG6/GBC9sNG+exjZROqqV20El9+yth58LdwTrthEzSlb+iKsIQbqjd2bF6oWHOLCPDaM1c5tg==
X-Received: by 2002:a05:6214:3902:b0:6af:cb9f:59dc with SMTP id 6a1803df08f44-6b020320c02mr6439866d6.1.1717537683041;
        Tue, 04 Jun 2024 14:48:03 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b418d5csm42118766d6.106.2024.06.04.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:48:01 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:59 -0700
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
Subject: [RFC v3 net-next 7/7] af_packet: use sk_skb_reason_drop to free rx
 packets
Message-ID: <0fa6bd81ccb75b9fe28971a895bb7a700b30b81b.1717529533.git.yan@cloudflare.com>
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
Closes: https://lore.kernel.org/r/202406011859.Aacus8GV-lkp@intel.com/
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2->v3: fixed uninitialized sk, added missing report tags.
---
 net/packet/af_packet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index fce390887591..42d29b8a84fc 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2121,7 +2121,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		      struct packet_type *pt, struct net_device *orig_dev)
 {
 	enum skb_drop_reason drop_reason = SKB_CONSUMED;
-	struct sock *sk;
+	struct sock *sk = NULL;
 	struct sockaddr_ll *sll;
 	struct packet_sock *po;
 	u8 *skb_head = skb->data;
@@ -2226,7 +2226,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 }
 
@@ -2234,7 +2234,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		       struct packet_type *pt, struct net_device *orig_dev)
 {
 	enum skb_drop_reason drop_reason = SKB_CONSUMED;
-	struct sock *sk;
+	struct sock *sk = NULL;
 	struct packet_sock *po;
 	struct sockaddr_ll *sll;
 	union tpacket_uhdr h;
@@ -2494,7 +2494,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 drop_n_account:
@@ -2503,7 +2503,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
 
 	sk->sk_data_ready(sk);
-	kfree_skb_reason(copy_skb, drop_reason);
+	sk_skb_reason_drop(sk, copy_skb, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2



