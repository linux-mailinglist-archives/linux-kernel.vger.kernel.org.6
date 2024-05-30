Return-Path: <linux-kernel+bounces-195953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2F8D54CE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8231F232ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360A18735B;
	Thu, 30 May 2024 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KFMlbyfE"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C1190674
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105632; cv=none; b=CAeY65eFUAVkKkXJhXC4aft0jK6Cpo7s6JAnhywZLuIM/ILW3wiN3LxXr4rFXAC/KQbBNQ79gTo4fs5FufaiMALFieqe8cL0E2oVx7YmSWfwX0vzRacVtx65JYbucPwPxfqkAl4G4/jUEFQKmYVJnZSJbfaiv+TvaojOrYKziew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105632; c=relaxed/simple;
	bh=6dowC/Uwf26NiZaIg168nDsdSN0aKz+6tZkvOLAwGnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwIGmfA+6nQxsECJK+JnYVjdSxwUe+O3ICLrMmDV36J9xuerrJAJ+lKxF/MIHe7ak3OYqg9X5qSeWajXAeQFZPKKrLnPwqMWxIwLKV8NIBZWlAo9K4XPmK95rPM8zMNp4gwnTJt3WYuf/AOq7IiE+L5G/h8P7XTFrGyy35xEMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KFMlbyfE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f12eda7c7fso724956a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717105630; x=1717710430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27TjARiWthXWjefcQW0222UB7xMw3bcD7v/H3qDKiuE=;
        b=KFMlbyfELd+IMDBFEv5TVqpkYAIFrnadoOkHZntt+LWWH5Lyvbt/DCUuIzSgcEJyw1
         jThW9oHKYeY+NY4aOwCCj9kYiDcpRCLRQOR3w4wV7rq8auNss+wFYeHVovWx9wWPbDub
         LW5C8L8KXNXc8KXUmI8a/rQMFRQ+YvkhMD+DfJr+ezRo9xkkYGs6V7wy+DOapKKeFHAJ
         fQ4IvRgfrNgqTzSOmi+j/oy0AddmU7pH3ja8xlu0soA40jA9MzxdOz8GFxoLLP2Mc88I
         jDuPxmj5VH1Pf/JETPXZ62xAmTMkYRzi2UNFSrI7V1mMYdhMSjuMdWN7ZEppnUlupffu
         Jq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105630; x=1717710430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27TjARiWthXWjefcQW0222UB7xMw3bcD7v/H3qDKiuE=;
        b=mK2j92KFoAvxCfKam6OA4xvKj/GdedevtL5Inuwj1R0GC7Pfv5WY6pYonQMTwYa0zm
         P//0tWL01/HDfjLCiAd0DvSaA6ZQ4Epanz2Mgs+gkfFO1RMuMxIyryanVIKI54rAFIZZ
         062ecFNF+wFrKW4kI2IhWE7aVdhFr9djddtmrucVdFjNWSLSWbpjyuSwXSopcuRFAcqG
         uNBcia5Cw8T6fawkcIM2pD6KVrDQTmNlN+UYPvyjLpe1g2ZqYncs3EOgZx/scT23ZQSf
         o+CqjtT/KoPuyNVly9oVLeicwjyL4JPldy4D7JCK5myDH0+JylWmOAxEiKUS1Be5vlHS
         0inQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrPK54eZ3gWFAbMeeuyWHpi+xGVVrFpDlRdnWN4IddClt4iOht5EW/wXML1mDoecsgIiQxpgvGBOx3pEsmzFA0VmoCnmp8kKZdAWha
X-Gm-Message-State: AOJu0YyQyzAhN2enhLjVRB/1iCSvz8fJS1Xong/d6VWJ5eMXlbwzb29T
	Yc/jyzpLvflvF1tMxA6pOkiMMQjygpUMXzZYgnNl4d06gvQBLQLBW5WU45b4PqM=
X-Google-Smtp-Source: AGHT+IHZeVl7ouGz/puxd9+5HcfYhWbufP8hbtU6k28G151wktaPRdVbkT1nW53EUrW/uRp7+N61ew==
X-Received: by 2002:a05:6830:1e15:b0:6ef:9ec1:2bf8 with SMTP id 46e09a7af769-6f911f9fc2bmr93153a34.23.1717105629904;
        Thu, 30 May 2024 14:47:09 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23a42bcsm2009991cf.16.2024.05.30.14.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:47:09 -0700 (PDT)
Date: Thu, 30 May 2024 14:47:07 -0700
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
Subject: [RFC net-next 5/6] udp: pass rx socket on rcv drops
Message-ID: <64c8339aa96232b5d36738162e7bf58412bf6682.1717105215.git.yan@cloudflare.com>
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
 net/ipv4/udp.c | 6 +++---
 net/ipv6/udp.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 189c9113fe9a..e5dbd1cbad50 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2074,7 +2074,7 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		kfree_skb_for_sk(skb, sk, drop_reason);
 		return -1;
 	}
 
@@ -2196,7 +2196,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return -1;
 }
 
@@ -2485,7 +2485,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 drop:
 	__UDP_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return 0;
 }
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c81a07ac0463..97a327c759b8 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -673,7 +673,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		kfree_skb_for_sk(skb, sk, drop_reason);
 		return -1;
 	}
 
@@ -776,7 +776,7 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	kfree_skb_for_sk(skb, sk, drop_reason);
 	return -1;
 }
 
@@ -1054,7 +1054,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 discard:
 	__UDP6_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, reason);
+	kfree_skb_for_sk(skb, sk, reason);
 	return 0;
 }
 
-- 
2.30.2



