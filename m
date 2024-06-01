Return-Path: <linux-kernel+bounces-197636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E48D6D57
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D177E1C2163A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A115EA6;
	Sat,  1 Jun 2024 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="P6BCgOqj"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010A6FB6
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206174; cv=none; b=jEuNuh28CuBJ9aEBQPfQWMJVrSUiSh6Z7mafrQ3tlpHzdX3AYmHu+P4TTFyK0ch3A3FGAQ0rPwl3tlPFI2cRF04kOYpv/BJRBMosRExJJzfnSWJgNdvwoOIutjco5nJAhVA0iHE3JzFzHXV2KNRWG/1735y8i/BnQR41lTaeDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206174; c=relaxed/simple;
	bh=jkzjDY7vnEB8DqdbcGuw7ABHpoGpOOOicO2KkYgqYYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWm38VSWdh0bvNMcvIu78FxwtMR8WT75WZBxTy/s0tpBXjdMgqz4ZhGZR7QW+8gQkyX8goBqJ4rBI8pJ6cujUoPF9KUjHljOvlyJiWUT13FxZXztG47j7d/RiqgHCX9cxUtRrBpxebCap8WgEzYlCN+Gek+UI9b+iLNRqK7l1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=P6BCgOqj; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-62a2424ed01so27974957b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206172; x=1717810972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=P6BCgOqjCwEYkeAdeHdpygNBK/qpkaaRTAoG3Srt734tzOsdCer3T7xSEb8QjSZy+2
         DCoioOQojDkxUysL/G2PvHNUmDcM9YU0jKUERh8K1jpIt9kQeOALk4V4WaR4rY09speE
         G8eYlu48+epL/jS9HWmK4Mwy3V/c8H1IUyxUa4QZPFozfnxFTRt+JOAoG+omCPo7jKvf
         SXG8vFVQNcv+v827gegNe/z6fkWaphPaYenKBwVSr2bdW9LD4MAnTwdcTLbZz/MJ6Q02
         RaQWwT3nLZUhqYff2Rgqi9BlDjPOep9vpDxbzDUuReLbDtM9aOyYCDlY5ngsA+6yQyre
         D+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206172; x=1717810972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZokBvFXzTLhgVv1PaHNF9XfQX0m9YCf5c4LTRhvqEjE=;
        b=QXygvMGc7a0e7kjndAaLih7JvBxxPBbigANIoxN2GsepfVgd65bVln9Wx/sKqqHvcb
         KmiD3/mEOjuhB2iNvwroOXxuxlvxqMOB4z7vTBn72n4XOUPVXY0QaowobVlOmF4xEqiC
         Pz/IcHvdoNfXZonnCmp0TfVNopXz9oLid3yNDYO8IxU04evY/W4zZiKcAWinX171jG3f
         NjMwcjhmrAfFjVQKcfrdArykGjMOjhb5blsSiLpSUFRSanxFyHMxlcI6kAUgxYfEItrG
         n3+OmOPhT7DzezRUpRcP44wz7xRZZwVwXd0ylZsAhSLQPkjiGElq36A8fN9jz0V8ttvH
         56/A==
X-Forwarded-Encrypted: i=1; AJvYcCUfeypby0GTvmOZnVK64PrM3GhBxp1G6RZDvp9XE0JB//O3giwqVGSebptzkPb0dGzR6dnySK9BGN4YOimVQRMpWF9TyZ2DQvmGAX5i
X-Gm-Message-State: AOJu0YzlkffLC8Y/pDU9xKrIqPnxsackuArxTBBwMwxU9vYpDzYA+YNH
	Biw5oWTLmz7r4JQnxMIXRvk92Pw1U4mAWd4CJEUnwFDS75lultpqBA/fm3YPVl8=
X-Google-Smtp-Source: AGHT+IHxVHyrr3VrYHe1OY427vM5xOxlLkkCH+3te1HypqOSqMSXO5Gncg6Y43GhkUSd/fqXGDmlUw==
X-Received: by 2002:a81:e302:0:b0:61a:cd65:3010 with SMTP id 00721157ae682-62c7971cf21mr35315987b3.30.1717206172275;
        Fri, 31 May 2024 18:42:52 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c765b8c28sm5377187b3.28.2024.05.31.18.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:51 -0700 (PDT)
Date: Fri, 31 May 2024 18:42:49 -0700
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
Subject: [RFC v2 net-next 3/7] ping: use sk_skb_reason_drop to free rx packets
Message-ID: <71a5ce50c3a2657bc9b28d5030e33bef112e74cc.1717206060.git.yan@cloudflare.com>
References: <cover.1717206060.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717206060.git.yan@cloudflare.com>

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



