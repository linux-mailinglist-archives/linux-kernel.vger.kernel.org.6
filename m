Return-Path: <linux-kernel+bounces-197635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8B8D6D55
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C81C21889
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4090125B2;
	Sat,  1 Jun 2024 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XQ15/Q1X"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99736F9D4
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206172; cv=none; b=G+OLp0GhBLHnAc3/7vH1MoIYBw/2LpVy2MXrSnCyokeuwyEk6/t5tNAY8FOJDOze+CGcdI942AnVBK2toP7PS/dicvNXdqsAf3mQWD4FZccN8NDfBgNQximpF5Yy87cgR+vYAtbeHTIDX5MxfZjWlZM3ohPjex5zLsmYrbYcfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206172; c=relaxed/simple;
	bh=Gs30pldD4IYhwgM9Z2RPF0lE51iD4CooDjoR4sEXvh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpV4GYuAAqSr5qHH46gWmA4E8yISUjXwN9ZR0qisg4/UHC3m5F4YtvhP336wAZ0a3CCwYK7YKPFcKUP7xw4l1GuSGFe5GxcqdPt0qYLaG109idRQFqLSkWeicF2J493tS6dx+gqgWC78/Uw1x4uqtMeesa9ag8tQG5Tn8k6eBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XQ15/Q1X; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a0894f1d3so21045117b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206169; x=1717810969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z9GdxrPO2MLCd8f731wHDlufWSwkyCPNseSHb6h3wQ=;
        b=XQ15/Q1XETdGOTRLWhBTT3gErcVCeO0uprAAVCdu9YptwBW9E4SMhhg5H0RaJoLh1f
         6/v7f6XrurPJGgL6kJDcPJLKhY9IbbUEIgpe+uJb88cwcweR3/JIJOLCVA/HHPFcnhYc
         gFNIj0uV7OWHxaT2utpa0gYWNRfd3i5G7CvDWX6RBe0Y8m2KDBWhVa1jNbd/6hiXxWjj
         E8uEUk1645Zwv1sHPhuUcE+O+xaijnVYoBGqoiTsuDnKlrC2+YMwtmsOIxFLeEXCQuBO
         8liIhGRJNiJXL5zMEdbkrgVI+KFvAyMpLxE4sgvHCEwQRNrTpR8t9n8442O6m+3oQEot
         1psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206169; x=1717810969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z9GdxrPO2MLCd8f731wHDlufWSwkyCPNseSHb6h3wQ=;
        b=djEnHCXhH/xUYMH/Fp7zUD4weklf7jkxyB/cLF0AoWPcGOUfqHiX2o9We/u+FWyfnh
         unVvYFSi28eBSG5gacIaoG6lFkRPYcEYBEPuVLCCewan8Tljl3WxIhMzWYwD6eBba3ro
         +cZEwKAsoY8ifjBnE1RqhoJLc5iZj4odnrrhxG3us86ODSzhRG1OzqgB3KDatpPWiA8I
         bSukmHkrEOgo8gW/KoXoLHQV8Q+mj2+VbDuoIeqLE1hP6JnplK79Z7WLq/yi81q/FSn0
         8I0kY9r6yEJSsSTrVR5LqBLXHlUF4gKVTn3klI1fDLgyrDV8CGnddidwdqnz8WNMuTEs
         dsMw==
X-Forwarded-Encrypted: i=1; AJvYcCUMWKC0GkA+RJRwcd1eRBZqBQ3vt5KthuR6vuFSV7SKEs/vSHv982FWnQ/b909Y41htOH7NaL5CFq+BwGJoKdhguvrCG5zdTNir2R5/
X-Gm-Message-State: AOJu0YzR19dUPZ9VdJzjqbxCdaooUXfnGDWv2rfxygBff3pV/8XeUf5M
	YLGDT1Rk0Q1shxIotnjfRE+SxxB1UBJLzwwidgE1mPvV/3YPY16i4mPz8K7T6wd3ymMyK0zQwZB
	ctqo=
X-Google-Smtp-Source: AGHT+IG/p7TPTItF3rbnoq/hG8AoVbSWCKhcw+n9wi696EyChGLv7ahUjI/js3/etNq+svJTYAOu4w==
X-Received: by 2002:a05:690c:d17:b0:61b:e694:2225 with SMTP id 00721157ae682-62c6cc6ba10mr53472687b3.5.1717206169542;
        Fri, 31 May 2024 18:42:49 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c766c8db1sm5386287b3.138.2024.05.31.18.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:42:48 -0700 (PDT)
Date: Fri, 31 May 2024 18:42:46 -0700
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
Subject: [RFC v2 net-next 2/7] net: introduce sk_skb_reason_drop function
Message-ID: <0cb76a7cc4fc9967ea901d5cb638d8c0e118e7bd.1717206060.git.yan@cloudflare.com>
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

Long used destructors kfree_skb and kfree_skb_reason do not pass
receiving socket to packet drop tracepoints trace_kfree_skb.
This makes it hard to track packet drops of a certain netns (container)
or a socket (user application).

The naming of these destructors are also not consistent with most sk/skb
operating functions, i.e. functions named "sk_xxx" or "skb_xxx".
Introduce a new functions sk_skb_reason_drop as drop-in replacement for
kfree_skb_reason on local receiving path. Callers can now pass receiving
sockets to the tracepoints.

kfree_skb and kfree_skb_reason are still usable but they are now just
inline helpers that call sk_skb_reason_drop.

Note it is not feasible to do the same to consume_skb. Packets not
dropped can flow through multiple receive handlers, and have multiple
receiving sockets. Leave it untouched for now.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v1->v2: changes function names to be more consistent with common sk/skb
operations
---
 include/linux/skbuff.h | 10 ++++++++--
 net/core/skbuff.c      | 22 ++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fe7d8dbef77e..c479a2515a62 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1251,8 +1251,14 @@ static inline bool skb_data_unref(const struct sk_buff *skb,
 	return true;
 }
 
-void __fix_address
-kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason);
+void __fix_address sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+				      enum skb_drop_reason reason);
+
+static inline void
+kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+{
+	sk_skb_reason_drop(NULL, skb, reason);
+}
 
 /**
  *	kfree_skb - free an sk_buff with 'NOT_SPECIFIED' reason
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2854afdd713f..9def11fe42c4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1190,7 +1190,8 @@ void __kfree_skb(struct sk_buff *skb)
 EXPORT_SYMBOL(__kfree_skb);
 
 static __always_inline
-bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+bool __sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+			  enum skb_drop_reason reason)
 {
 	if (unlikely(!skb_unref(skb)))
 		return false;
@@ -1203,26 +1204,27 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 	if (reason == SKB_CONSUMED)
 		trace_consume_skb(skb, __builtin_return_address(0));
 	else
-		trace_kfree_skb(skb, __builtin_return_address(0), reason, NULL);
+		trace_kfree_skb(skb, __builtin_return_address(0), reason, sk);
 	return true;
 }
 
 /**
- *	kfree_skb_reason - free an sk_buff with special reason
+ *	sk_skb_reason_drop - free an sk_buff with special reason
+ *	@sk: the socket to receive @skb, or NULL if not applicable
  *	@skb: buffer to free
  *	@reason: reason why this skb is dropped
  *
- *	Drop a reference to the buffer and free it if the usage count has
- *	hit zero. Meanwhile, pass the drop reason to 'kfree_skb'
- *	tracepoint.
+ *	Drop a reference to the buffer and free it if the usage count has hit
+ *	zero. Meanwhile, pass the receiving socket and drop reason to
+ *	'kfree_skb' tracepoint.
  */
 void __fix_address
-kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason reason)
 {
-	if (__kfree_skb_reason(skb, reason))
+	if (__sk_skb_reason_drop(sk, skb, reason))
 		__kfree_skb(skb);
 }
-EXPORT_SYMBOL(kfree_skb_reason);
+EXPORT_SYMBOL(sk_skb_reason_drop);
 
 #define KFREE_SKB_BULK_SIZE	16
 
@@ -1261,7 +1263,7 @@ kfree_skb_list_reason(struct sk_buff *segs, enum skb_drop_reason reason)
 	while (segs) {
 		struct sk_buff *next = segs->next;
 
-		if (__kfree_skb_reason(segs, reason)) {
+		if (__sk_skb_reason_drop(NULL, segs, reason)) {
 			skb_poison_list(segs);
 			kfree_skb_add_bulk(segs, &sa, reason);
 		}
-- 
2.30.2



