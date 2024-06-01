Return-Path: <linux-kernel+bounces-197640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0438D6D60
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC99B2338D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3A0AD55;
	Sat,  1 Jun 2024 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Nqtbt4To"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE448AD31
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206186; cv=none; b=Y4xOEIKh/5x+wx3bp/Dbu2nxz7FhXRNDIR3ertGCo3Vrv6hT1eOB53pEE6v5EiyHBxzJHULqW7UHXLoL5d4t5cwE05/aUPX87J1NOa3RIm7NyitoT1fWH8vG462IQuCpODpDMAs0kgmBpEgnpVu59GqhvFgke9GbkK8XOhPHUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206186; c=relaxed/simple;
	bh=S72Ki5HHkpC2an6q78XTrK7f5rHLvP6MDa6qVibaFlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvugragMgDtxNd4hbjbbAv7vm8TTuxaQpglO+uvg8vKZAKTBu/HMHVvGxWkao3yrq/XSiKv7nRpfyDxPz5GJnuYPRnpzETJ31LwsfoO2H1ddZzc8B11/0SEU3J8YKw8bHbPz73WxqSld18zQRRpxmI5K+xz/y0I8OT2YsGOGNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Nqtbt4To; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a2424ecb8so28465097b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206184; x=1717810984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/La4XSUTmNeuu9YRTxpONiBsYW4Mtyght862Rg0qE8=;
        b=Nqtbt4To/8w3O533vKLdhzuG6bV8QHLsQcNSVonu1qpDl5SgF/4KYfk29909tebBhi
         WVxQBeiOpIj4hSnG4N3SbvbvAP09w43N2AA4msyptg1qlsnL3X8bG4BXiwmNPX9+Wi27
         OUoiiwavqaF0wLRjpXWp2t7cMbielEuSFKVwS859mtQ7VSCjJ0+NC0k3rLlpy/xifv8k
         vMzETkn8EPC06xlFzAmorGs0zsZ4nyD/V0xPaq8tmHX/YUsye/PteJfGctczQougjzbu
         PiGyMPt5FzR5UQ420aqx4rlCvIOFZmoaSD8/SuyzTqu/8pkQc0SSvUmZhbVSKa9L5EMT
         /bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206184; x=1717810984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/La4XSUTmNeuu9YRTxpONiBsYW4Mtyght862Rg0qE8=;
        b=OnjQm3hxPOjN3L1EjjR9hsIQZqkhE/Pn2EWNvIQatDQDNQ8nNdkfzD1gNTiZUH94dO
         P0Dtc5L14kmPMPRUdw8HmRO7rhzSqa9lfTwTQgMYOBIK+4o991TgbSrLFcKgiN2li3iB
         niI+EtsFWx3sDMwQIBQ1B/kl7OD3oCSBfR3a3RN14Aqj9yDU+HFEDZba4kucl6ZE4xKn
         aj/ec/Nf8CYlaaIpLWHOC0GaZc8Xt+AGvn45g8XieDRNN/92GQrjaE2XkezeU24UeV75
         S+Vk35U3wi008UEwqSqQuCO8LXmQaHAXjRkGiTECwqKmF6Bl49wyRXJWL1vHozP7DWtG
         q/BA==
X-Forwarded-Encrypted: i=1; AJvYcCUKPRq2E/re3YcWMyVu1fEqFuLkPLEFvWwMhZ97E8K2Oc4tqh1iVHpBFuDPcaJ/BUSC4v1tDobGfR2ISMXwpF5AZ7jto9go0QPnZVzY
X-Gm-Message-State: AOJu0YzlXBnAtTGIVrbTh5Q0IcmQV8sGDaT1AH7u307XUhq1eEiy2KUp
	y3U3b+v8fds5SpSB1zFUt4bBs9W07wiS3OVXXoWaujK4cn5TYzWCJm3spA33PFE=
X-Google-Smtp-Source: AGHT+IEua05S7PDRoCJza0EQl0jMFsfegyLK1tQ6xf+usXIX97QNBaJMtekX4NLQSbhGYbhg72SnZg==
X-Received: by 2002:a81:4520:0:b0:61b:3364:32db with SMTP id 00721157ae682-62c797fac84mr38162817b3.36.1717206183488;
        Fri, 31 May 2024 18:43:03 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c7667dc7esm5397227b3.81.2024.05.31.18.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:43:02 -0700 (PDT)
Date: Fri, 31 May 2024 18:43:00 -0700
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
Subject: [RFC v2 net-next 7/7] af_packet: use sk_skb_reason_drop to free rx
 packets
Message-ID: <b86569aac8c4a2f180e7d3e22389547ff2e26cdc.1717206060.git.yan@cloudflare.com>
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
 net/packet/af_packet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index fce390887591..3133d4eb4a1b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2226,7 +2226,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 }
 
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



