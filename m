Return-Path: <linux-kernel+bounces-197205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F94D8D6783
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF1E1C240A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59515171658;
	Fri, 31 May 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BGHtCbBt"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0F24211
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174708; cv=none; b=Y4Ac8bz5bxQH2xczg/SJ0BvMbmGjjmXqhlyWlKsqklObhAgzdP+0zAl/Hlx/frCnFJTOBrAFI2hnLuo75ICmjgiFjQoBbyThwamoTw2rsjLmh4P5EJfrLrB+aduzpYPSrOZQ18tJbmSzqRPB8rPPPWaNMEhhOVjMb7gPmnQsoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174708; c=relaxed/simple;
	bh=hhhEDWLVE4M5G+vhOXoMR9p4anhHS0Vwh9WszXG8WM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikkgNl6qvoYSZWV3U/H04b9eMF/1jf+E/Mcg0PreMCsrxsoos0EDyPkb76Y3H+wDob9yv2ctk6KYNYuw7zFWy78fZBIXYYsT83XYvyyqoSfsTjYfJp7WCuhiWEb71kYj/FVG4rJtVZtBhh6YtIqOpxXEkPDfyG4IpFV+h/wqwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BGHtCbBt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so1917147a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717174705; x=1717779505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5xx0RyZHVRYdA+i2tq2L6FCdad/7w6t5hRkVK59jgU=;
        b=BGHtCbBtidgcG+d4AV9P5FvOm6akq0QKNk9NwM+fRneFarDgdpL3m/1N8In9KT9LLy
         /+rQvv8Tzs4V+/m1FCmh8o7Dw60M5+otq/NkVnpDuq4xxjmvxmSeA3BSTz2jwPw3H4R4
         rKuu0OqxFta1qLwQhEOSj4sOt/IftLDBeomjTfGdWsOWrRFdbUsIg/gaI1LYizkzOWon
         LhSJ45UueIY53qtJYjNjJtUDRb+uXiTMiqMqm+9Yl1mQ8Y53GoNULkO+fB088P3BOeFU
         yGSkO6rwg9PcOp9eRqNoo/98DCYeEuVHOix6fA2GjfPJigBlGf+jI89HIgrdjCjfymy7
         88eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717174705; x=1717779505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5xx0RyZHVRYdA+i2tq2L6FCdad/7w6t5hRkVK59jgU=;
        b=I2NSzL87molvB80IaEqYCRLGStfeb+5xkWATG6owe0ZdE1QY0VbIkoeqBUlZfCH+1X
         f52gS2+A05xva3R9GA94HN0H9drzSsbuR9cyLQcDCTNFx9A4TNss4pOM+PDhjdkG+on1
         yAycvo3ulhcaKuTIGJ5Hxu8kPJpm6WfIBQxW/Pt81Skvfm9meBaKPZ4RK1TG5T2uXPw2
         bnZkVhnGl03fH1dlSuu5Qk8F7kf0L2SbKTMka7fCrgGNX9X5nZUQeQncLiEFbCNXLhQ1
         R8qZttyV8Q7Y2VMJ2zOSvvNh14JsRoLDqZK8+4M3uzoTKpLvOr1i/DXHIfDCKW1CNFk+
         IQYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnyLlBtyNC6Vm84t9l8JcLaPAB15BUy+DSzFHcVBU2Hf0GN121mNVPOOmCvzpV0LuE9XHAiVmMnAIpOlj/CgigGMX0F11CHWvX0YDf
X-Gm-Message-State: AOJu0YwR4ZAxA8WDbEbjgLki+8bJon3L2w1UxFZSzNfz5pVfDc0nRDTY
	vZPmuVFpoebgEzT4PKmj2xGmsUFfwSVpeLTOOitvUf5l9NsZAKL9EWpL4+L5+S74Dmdr2bhRsd5
	+9fsFztQhciDs3mFVkBHTpF1vlR55k3Jn+zap9Q==
X-Google-Smtp-Source: AGHT+IGLriP1YxK99Pam+kTFTQWmuJHkERLmVNSyEIQ+k8i0LCvU0BLDob6DGhcSuNAm2Q2bkGLCQixte550DbTbqa8=
X-Received: by 2002:a50:cc9b:0:b0:578:197b:30d3 with SMTP id
 4fb4d7f45d1cf-57a36382541mr1679095a12.2.1717174705169; Fri, 31 May 2024
 09:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717105215.git.yan@cloudflare.com> <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
 <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com>
In-Reply-To: <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 31 May 2024 11:58:13 -0500
Message-ID: <CAO3-PboQ68+xFe4Z10L-s-k3NCgciGXNWM00-3wgqbPmGaBB9A@mail.gmail.com>
Subject: Re: [RFC net-next 1/6] net: add kfree_skb_for_sk function
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, David Howells <dhowells@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

 Thanks for the feedback.

On Fri, May 31, 2024 at 1:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, May 30, 2024 at 11:46=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wr=
ote:
> >
> > Implement a new kfree_skb_for_sk to replace kfree_skb_reason on a few
> > local receive path. The function accepts an extra receiving socket
> > argument, which will be set in skb->cb for kfree_skb/consume_skb
> > tracepoint consumption. With this extra bit of information, it will be
> > easier to attribute dropped packets to netns/containers and
> > sockets/services for performance and error monitoring purposes.
>
> This is a lot of code churn...
>
> I have to ask : Why not simply adding an sk parameter to an existing
> trace point ?
>
Modifying a signature of the current tracepoint seems like a breaking
change, that's why I was saving the context inside skb->cb, hoping to
not impact any existing programs watching this tracepoint. But
thinking it twice, it might not cause a problem if the signature
becomes:

 trace_kfree_skb(const struct sk_buff *skb, void *location, enum
skb_drop_reason reason, const struct sock *sk)

As return values are usually not a thing for tracepoints, it is
probably still compatible. The cons is that the last "sk" still breaks
the integrity of naming. How about making a "kfree_skb_context"
internal struct and putting it as the last argument to "hide" the
naming confusion?

> If this not possible, I would rather add new tracepoints, adding new clas=
ses,
> because it will ease your debugging :
>
> When looking for TCP drops, simply use a tcp_event_sk_skb_reason instance=
,
> and voila, no distractions caused by RAW/ICMP/ICMPv6/af_packet drops.
>
> DECLARE_EVENT_CLASS(tcp_event_sk_skb_reason,
>
>      TP_PROTO(const struct sock *sk, const struct sk_buff *skb, enum
> skb_drop_reason reason),
> ...
> );

The alternative of adding another tracepoint could indeed work, we had
a few cases like that in the past, e.g.

https://lore.kernel.org/lkml/20230711043453.64095-1-ivan@cloudflare.com/
https://lore.kernel.org/netdev/20230707043923.35578-1-ivan@cloudflare.com/

But it does feel like a whack-a-mole thing. The problems are solvable
if we extend the kfree_skb tracepoint, so I would prefer to not add a
new tracepoint.

>
> Also, the name ( kfree_skb_for_sk) and order of parameters is confusing.
>
> I always prefer this kind of ordering/names :
>
> void sk_skb_reason_drop( [struct net *net ] // not relevant here, but
> to expand the rationale
>               struct sock *sk, struct sk_buff *skb, enum skb_drop_reason =
reason)
>
> Looking at the name, we immediately see the parameter order.
>
> The consume one (no @reason there) would be called
>
> void sk_skb_consume(struct sock *sk, struct sk_buff *skb);

I was intending to keep the "kfree_skb" prefix initially since it
would appear less surprising to kernel developers who used kfree_skb
and kfree_skb_reason. But your points do make good sense. How about
"kfree_sk_skb_reason" and "consume_sk_skb" here?

thanks
Yan

