Return-Path: <linux-kernel+bounces-195954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D88D54D1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3DA1F2355F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC11836F0;
	Thu, 30 May 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RIqk3s5l"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F0194C77
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105635; cv=none; b=DWp8sUFaOAtw0wfh5sfjKP2/HU7YoM/+tOsGAHnS3vjH2cOwM0Mw9fY3T8W39Wg8U3iB8Fdl4Blx1d9Edsc4vuztTtSoi+mKyGQ0y6vQLwPtOm/dxGYwuMPcYiShRznKKOvNdps/UBlnLddxHuASwPoobLUoJ2iCrkd+ChRUiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105635; c=relaxed/simple;
	bh=zBPfgKOCZ7FGTb7LtwnzoLHAcib59MLufF+CqN5TSP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqdm89SEroGFKYu+tiq0wbDrNcMhuY0yBKyxPyp+ryKSheA6DTYK4Y2+vQwcpafwxitp8ci4wv22i2b/IU6xtwqMfM7N8+sbGElylRlYU2xtFsHpMl2O92TKqK0EFKnJoyYO1oSQfRjSIGjUrOYQxldRzHdt+zle+YMbTVbFGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RIqk3s5l; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ae0adfba9cso7771576d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717105633; x=1717710433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hK/RV3ZAvRKcX5XY/+KVfGOngLsfuJvHovUEHHeWptM=;
        b=RIqk3s5lhEwhRYw2FJe+5RyMoRbsOM8vHvqrYMHGPlB89vYoQ/PqZ7HbJZtaDYZUWa
         C4JTfmtEFVTY6rSLh1NYvVTpzyhPWLBgdF66rNKCmdn9ac90gzM3GvhWEYUwj4HVfVoW
         NK97NcO/BRerw9aXN0sm1A/l2CIHmsIWZ1O6zkzt9XrDCpxVatMWZMqVnIXbG+Tk5KBm
         opLgza+MZ9UTbMGVwxGJCPLu7jpqvYlrA4mDcBrBRHmJgg+5g56VQ177iT5/x5L9tmij
         o4mNTmuUpveL82Ywmx556WyuJV6C3HpY7Z61XYmiXJhENLJLWnOssgh+KUNMe77nPjO3
         p3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105633; x=1717710433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK/RV3ZAvRKcX5XY/+KVfGOngLsfuJvHovUEHHeWptM=;
        b=eI6YPmFkfrAvj/OWze7zFw8PLtwKql8lrpTTizzu3q45Fefn/RO/yzkM+x6qdRf1RQ
         nt17UgrfhuN7NcDWjDzrMCGkUSpoolrTbdJ7LZ8ZwZU2lIJ04abFKELDZSoKAymczfwT
         qx2wtsiZaAWZBtUIkPfsRAucTl3OFm5GkWkuqJuZng2VX3qc4SSw4N9S14ol+RQU3Bf+
         DZ6qF8z4UYsB/lGedHjYjNzSBKHYmRZNHVDj41ZIxXwy9Ptj3N1+iSSnZ5eIDOZhFrEm
         lbs3X2WjCZ59oRFF2gBHmfukwVZ5xeoH2Ow6mn69Id5eFaBBkctcmg4JdpUn5rDEsIBa
         0QYw==
X-Forwarded-Encrypted: i=1; AJvYcCUf/kvqfT1BPB6I88mqFrbvmhPmGL0IjgmnMYX5vz2JtY+nCZyhLlX9KVbvwO7/dQhvtZSOuW+52/JTLKyWHgPcO+4cOqgnXsKuUquP
X-Gm-Message-State: AOJu0Yw9pdki7h7puDPmmMOSJprPA+vHFKvSmxEOcaBMxy7yAB9Lx6RW
	+KzYBSAlOfnv80e35dO46f7MIXGYJHSUFXgGnKKXo7NIdsAT3l2fERJDFyCY2Sw=
X-Google-Smtp-Source: AGHT+IHbqI93EibzSyAta5LKCbpan2p512WiBaSen+5LGFNq3txKFmbJqCRt3fWHnZRqPqSQpd153A==
X-Received: by 2002:a05:6214:33ca:b0:6ae:19e2:39d3 with SMTP id 6a1803df08f44-6aecd6ef732mr1410496d6.45.1717105632747;
        Thu, 30 May 2024 14:47:12 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4064d2sm1877406d6.91.2024.05.30.14.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:47:11 -0700 (PDT)
Date: Thu, 30 May 2024 14:47:10 -0700
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
Subject: [RFC net-next 6/6] af_packet: pass rx socket on rcv drops
Message-ID: <df2ad57a2986038ae9b5e46c73d48c22bb86b788.1717105215.git.yan@cloudflare.com>
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
 net/packet/af_packet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index fce390887591..30a6447b4fc4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2226,7 +2226,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return 0;
 }
 
@@ -2494,7 +2494,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return 0;
 
 drop_n_account:
@@ -2503,7 +2503,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
 
 	sk->sk_data_ready(sk);
-	kfree_skb_reason(copy_skb, drop_reason);
+	kfree_skb_for_sk(copy_skb, sk, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2



