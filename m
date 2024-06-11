Return-Path: <linux-kernel+bounces-210561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98A8904592
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454072817F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D17F154C17;
	Tue, 11 Jun 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e+BePbcu"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC03154430
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136697; cv=none; b=BJOPJ5ftKuVF1E1zJqvTZm288R2lEOMbkuZzbN97bFfy+1TxFJpGBrLh/bZNTBt8I60Mg8if98Q4nLvDJEdXLug8oPeg8XJR3ADeOKTyKSdJ7bjG6mcl+yfuLBHbHPZPRk0hlWDSOpooqidxq9FIeV0ukx+CcKYridF9KC+cl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136697; c=relaxed/simple;
	bh=jkzjDY7vnEB8DqdbcGuw7ABHpoGpOOOicO2KkYgqYYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhOTaBSG7NIt7aE8D9yrCji5aOyDkpIfi9WPQQWkXgTPSyJX0US7icWOaTvIWBweRMDqN9pp1kicJYHMbcfjqZ7+bQgUPs5/Yf17+i3X93PbqcHVJQidJ2h/gVkAZymiOC+2ouGaB5bKoAkOwnrX4xa8BPWC8EEaxgrtU66uZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e+BePbcu; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ae259b1c87so1927896d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136694; x=1718741494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=e+BePbcu8ZjGcArQu6Z63bcVoN2WEDS+54nsb7qzW2UGNbanIk834sFQ/lJqIXX0ad
         PElzQgX3oI7KjLwZbRAJ63Yndve7vIliRfM1/02lx+xh7I9dbwnMKWhDbAzF3f/2jBx/
         KyKJ2PJlACfvEwb3W5wXGePw3C41Si0Gx5TBLhwIpBQMuqkxg+2Dz8Bt9efxd/GDHddv
         ehWHKmv0sfv93kna3hVUE87uKHQNwcfSeKtC/aL6vikViBmTkhDC+jerlFebXLGbyPUm
         umgB/NVMaFsELeyMkP0rU/9OmqjQAmXkIlNeKI1Yhyt4Ff5wNbOEJMXZ63LK1j702s2z
         ECgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136694; x=1718741494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=RWnUDnViTGCltaMaHoLNAzAFh7074baA9AuJy88Wf6ciCqyqGAPbHytiZvi4Ghv8y1
         Q3n/H2kPiQ4HJCZl8gU/GBB+LHu+t8OZNXff7RmAAEugdNsTtPtBHECyRJ3vKrQtuM2U
         us++V3lYxAMilMHXft4gHj5ZUqwRNShsnybyaWR2rYSbFSrwGy+azBD9t0lQVZBgddqu
         BrahrX8XLvx6S/sChwlAE2qFMaV0hKP7yo1QSrwN1JVFKAQ/s4+EP5DhQxSOSHrGDmFg
         gRWN5HwOq9Sb7Mv/Ls+tMaVY8ScvPwK3HfuuNoIGHtBBJZNRsqDqaqVIERDsFqQxm+V7
         bnFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIKaRaaMZDPA23gur4iXNzErDYsWMWANNIQe1YJOypDOvxDYte42rNSowAcCFBgj/oVUu8EHGdHANsJO166NDBh2wcNtGmgHpT4WRZ
X-Gm-Message-State: AOJu0Yy7oAhDI9Rvj1jZdpFhYYfjIcv6BaF2aGtrobDdePMTuO6Y465i
	CbcoXO1Ev4c7SmGDRAYYbDS+6O1DAH77gNmmS28Agc2bn4N16rZIUBaY02+NsLM=
X-Google-Smtp-Source: AGHT+IEIVKV/a0EOOQ2T3f8JufAk9clK5Yfa/OE6wFOWw3Hdml8aRpN+s1jZuSt/UZhuL5AijoE+yA==
X-Received: by 2002:a05:6214:5b85:b0:6b0:767d:4c25 with SMTP id 6a1803df08f44-6b0d3cf4fffmr154996d6.22.1718136694494;
        Tue, 11 Jun 2024 13:11:34 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06795349csm41843116d6.1.2024.06.11.13.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:33 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:31 -0700
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
Subject: [PATCH v4 net-next 3/7] ping: use sk_skb_reason_drop to free rx
 packets
Message-ID: <afc28801e350a974c312f6a6f90a643831dad356.1718136376.git.yan@cloudflare.com>
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

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 823306487a82..619ddc087957 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -946,7 +946,7 @@ static enum skb_drop_reason __ping_queue_rcv_skb(struct sock *sk,
 	pr_debug("ping_queue_rcv_skb(sk=%p,sk->num=%d,skb=%p)\n",
 		 inet_sk(sk), inet_sk(sk)->inet_num, skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		pr_debug("ping_queue_rcv_skb -> failed\n");
 		return reason;
 	}
-- 
2.30.2



