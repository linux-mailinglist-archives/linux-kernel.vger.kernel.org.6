Return-Path: <linux-kernel+bounces-195950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D9D8D54C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2115B2473C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AB6186295;
	Thu, 30 May 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fe0U3Gwo"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287B21A0D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105623; cv=none; b=TjT3WMtjMr7XrfLOYEs9eT3AARhVFsdhFIOilsrHFKhXJACuXwozZ5xdY1S0cTUmog6bcJcCEBYXbE7A/RfSsNf9znndodfhSTOJfQT3lIrkgxpD4qiDbMcn7molI8LLkiKkJBFcIZkkd0p80GXxH2gwGgFm5jhiEXIf9VMhmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105623; c=relaxed/simple;
	bh=SUfnamc/6k/sjO/J1uJ3QJC2mTjrFfkQhfB+xutr5gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTozPtVeBWrxGytjTP71l+IA4Zlm1MLiAI4EZ6EE0lH/6RUby+/6rzvlc3T81OtcLFNikWiMkSYJnIFauGhPGq0HrflcJWkRKdd1IKOf5sBVV8uoy7A72M4jcN8Ha4gWZZzDIGdeCFMOWQox5Pl7C2xlT/Mc/fkwE3YmaVadHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fe0U3Gwo; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-794f4d9f0d2so7253285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717105621; x=1717710421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MK2P6q1XiYjTWQIaOe4RIEfd3S5ujqhwLQADP0nXD8w=;
        b=fe0U3GwolInkcTr2/bNiARHo8zrLPyQktZfVQ4oJTP6EHWyxXfkXBW/xczlF2QM4db
         sqRI1kQgwXoXTcdckgZH3lY0sCtAIp9JDviuZXNt1S8pyBdPQNWaVwr0pGTW8njm4Q+K
         pBQWLhnIVA0eo4PDk6MruCFTfJnTXNmd3qWdhjNyRcuwWjBvscdrQY/ka9mV09DvJRQl
         SZrLNnYHMDeBNp8iawal4n/3dGPjNonPwAQSA8NQptd01WJpn7jzIBt7XouKL8Xmzs5L
         jTOOx7JIDT0xZX7Kt7/F2JBhwY2we58r98Fchhq3z+vmnxzC9BIOv0kawdf9vISswtHB
         /5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105621; x=1717710421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MK2P6q1XiYjTWQIaOe4RIEfd3S5ujqhwLQADP0nXD8w=;
        b=VWZnAjMXC1pOAMME4fH4Zeg5Kio6Zu1isfbyfsTQgUFWGiE6G8ulIxMTU3L5KgH2Mn
         5tArWZEkn1v+o9FNepL6/XZkwQ5jFyn9apbgLr6ZSQB7mARmciROzKhvJYA5IEOvS0dC
         xhm7WDuak0lhK7DI+LYLuzF0U/rt9BrXhVnAfzc/tVqtT37y80ju9G2a9/HNl0Amn9vQ
         5FJ7LcrWOiO4gVfu74kTe7NmUn7AUU3LbZQYqYzAo/fJ4CNNzCybsML9tEcEOWR6UONu
         YaRje8QkeCI/Ez0jBIgpRptE163ahVJX1qF64MwkNR0sZ5KoWQnX0iypClgEilPMKIIh
         dLMw==
X-Forwarded-Encrypted: i=1; AJvYcCUjrVfOBYm9T7m+y8Mjg0G7UjD+hxo9BSvVFA7aei69uKuyMt9JUHqv9sPpSmP2TpB5JLwU7XrZ8qkbK0HLoOlx8Ymco2hYCrKf+AXU
X-Gm-Message-State: AOJu0YzcQ8bw8JjQar52rqKaL9cOp/ic/cnnuzomobMCLkv1dYGDLTjS
	m5w/0oTMTzDJ0wLHPEzA7eXXEzlVatykqUvn5pdnyPNJl+6CUZwwdAkdPAIeDNA=
X-Google-Smtp-Source: AGHT+IEm8CT3YJuc+qq9i8YbFNAZnmfEhM4lFa1VZEFA2/RthzAoH5D/o+zx+iB7B1JdGyD6bB3+PQ==
X-Received: by 2002:a05:6214:5d11:b0:6ad:6209:ca76 with SMTP id 6a1803df08f44-6aecd56ee4bmr1597006d6.3.1717105621480;
        Thu, 30 May 2024 14:47:01 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b406622sm1887586d6.78.2024.05.30.14.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:47:00 -0700 (PDT)
Date: Thu, 30 May 2024 14:46:59 -0700
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
Subject: [RFC net-next 2/6] ping: pass rx socket on rcv drops
Message-ID: <bbccd685a486a53501bdc75403f3be7fd5260b5e.1717105215.git.yan@cloudflare.com>
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
 net/ipv4/ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 823306487a82..e2f9866f67c7 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -946,7 +946,7 @@ static enum skb_drop_reason __ping_queue_rcv_skb(struct sock *sk,
 	pr_debug("ping_queue_rcv_skb(sk=%p,sk->num=%d,skb=%p)\n",
 		 inet_sk(sk), inet_sk(sk)->inet_num, skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		kfree_skb_for_sk(skb, sk, reason);
 		pr_debug("ping_queue_rcv_skb -> failed\n");
 		return reason;
 	}
-- 
2.30.2



