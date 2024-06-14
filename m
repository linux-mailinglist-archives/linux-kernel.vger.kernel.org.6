Return-Path: <linux-kernel+bounces-215461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF89909307
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23771F2336D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC1E19ADB8;
	Fri, 14 Jun 2024 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GdPLF6ZB"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354E15B562
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718394049; cv=none; b=BdVUEapW5tqZ71Hs3zTuER+qx2r6W1ONMJ/LrQL6N1FDtJKaBRMuKbqtlrlvPz4WVzg1saKPKlk+urKrJwtlL6mBU7rY0zZfMQYfV/OA5HyRQopJ5tqecwx+SfU+gfMXu5YrCrBk4aUvHuz0FEr7g/yCLBekR+kVYHDV+Sax7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718394049; c=relaxed/simple;
	bh=VqNw2ns7aqtWqDR0d5abv9h9DSXkqkFbhkx4mdQOkI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtmFPDjjahLhXoUdFh8MDW+lcUUCMXJDiOoR0kT8lYbmJ5SFTQYQoZUMFBw15JjBeimbSiygwpXwROdhx5Y3LrKGBSgnWa5uhxh1L7FOQfHnoXDJuN7ojE783qOUqAgoQmKm0MuEU/sf1YxV88SaAHBWTqSViMy6c3mQ6rm5zfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GdPLF6ZB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c7ec8f1fcso3071513a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718394045; x=1718998845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wbc4GSgCSERDLxOuFdZrA/q/zxBmzXnyTxqibt9VdMs=;
        b=GdPLF6ZBrIuMGKusGj1cDSHwE4PMQconZgUcSvXqO09whx4gb+M8m5jeX5h9XUP+ZF
         q6Qt+a3u2Tp2e72LJRVCgaohhYV5KoVxipn8NB3nFyur8C8dfhIhoPf38mSuT1q7uawt
         mGvGEyvLL4wd5wUBosXWdkA+DM3+2WndiXAh61t+VAzUVq7U2b0Wj/ngCKqVwAxqWWnA
         c3Gd7Gy+zr4w5Eu698f5tCIrL1vb0Pl7Wjc7gNUQcIQgS4hdhGPJozAVJnwFydIcR95f
         R7ssTsmygMFi2/iuRJXkXKsq+QSCNPZTEZY/t+GvWyyt1oNqFXdF2TfNY27vSOlMATPp
         EFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718394045; x=1718998845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wbc4GSgCSERDLxOuFdZrA/q/zxBmzXnyTxqibt9VdMs=;
        b=PrYLXyB+OPjidgYmVGZdbOjZ1QQQRXOXz1BGzcZaoquSLlATqimATE4amQCjt65GF7
         AgsvpnTWLKfAtbjq1+KVlCPPL7O0Nrdz7NUoKjHujjWM4N1dEMSUWUtLV9QusQxR6Vqg
         yo9rEZIG/o4jhBWIuay2qNsxtvdZA3SCDMU6acy++JreLR4h7596Sudf6pU0t6t79eMx
         y/Qbrur8LBYxeiRqxTQ0iP95ubRbVMCOHeb1IB/r3UOwgH4K43Os52dvCmlp+1oEuISj
         Y+qVkgQ+obSkj5FNGLExXIshJnT2nnv0xbZOOBItRedKF5oYP7jJHj3oWofKfHENrta6
         u+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9HFGXduqF3aN5SsCXdSLo6hU0kwll6UJg0Em46V2TqPc/0rtHZ8CmmGj807gtu8VQLRrDv0b32bzzpk+vKeM9Sme9MoSxjZgAsKTx
X-Gm-Message-State: AOJu0YyywsoGGfeL8vhpRiv60dOJgQ4f1+uETxsykAjy5aH0nrg2ey06
	AHhLD2Uff6sNOf3GrSZBAUVxHWRChmRFt7ho0G7G4kRXIi5RwQDXBV2t1ej9w5szpelN+sAQIrz
	64ATCsq0Nyk7ov0AdBVsgtZXLTKRKut9yvi0/Hw==
X-Google-Smtp-Source: AGHT+IEH8WEKx3xQbq1+oKvg4iOkF+AGoOi+MlB17Wrarh1LPwitVZ/727ewHKaMbj47weG8aVpunbjT5+1+Srui+5I=
X-Received: by 2002:a50:8747:0:b0:57c:563b:f37f with SMTP id
 4fb4d7f45d1cf-57cbd67dbedmr2527046a12.19.1718394045408; Fri, 14 Jun 2024
 12:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718136376.git.yan@cloudflare.com> <dcfa5db9be2d29b68fe7c87b3f017e98e5ec83b4.1718136376.git.yan@cloudflare.com>
 <fed7b2ca-5180-417f-a676-fb126157dff3@kernel.org> <86109f6c4a8303950ac13811a3f8506ff44a6cfc.camel@redhat.com>
In-Reply-To: <86109f6c4a8303950ac13811a3f8506ff44a6cfc.camel@redhat.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 14 Jun 2024 14:40:34 -0500
Message-ID: <CAO3-PboH9aNSC7RaJdkouFoa5L2Eoqi7OjLuAay9EGABr1fEBQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/7] net: add rx_sk to trace_kfree_skb
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Mina Almasry <almasrymina@google.com>, 
	Florian Westphal <fw@strlen.de>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Borkmann <daniel@iogearbox.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Neil Horman <nhorman@tuxdriver.com>, 
	linux-trace-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 5:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2024-06-12 at 09:59 +0200, Jesper Dangaard Brouer wrote:
> >
> > On 11/06/2024 22.11, Yan Zhai wrote:
> > > skb does not include enough information to find out receiving
> > > sockets/services and netns/containers on packet drops. In theory
> > > skb->dev tells about netns, but it can get cleared/reused, e.g. by TC=
P
> > > stack for OOO packet lookup. Similarly, skb->sk often identifies a lo=
cal
> > > sender, and tells nothing about a receiver.
> > >
> > > Allow passing an extra receiving socket to the tracepoint to improve
> > > the visibility on receiving drops.
> > >
> > > Signed-off-by: Yan Zhai<yan@cloudflare.com>
> > > ---
> > > v3->v4: adjusted the TP_STRUCT field order to be consistent
> > > v2->v3: fixed drop_monitor function prototype
> > > ---
> > >   include/trace/events/skb.h | 11 +++++++----
> > >   net/core/dev.c             |  2 +-
> > >   net/core/drop_monitor.c    |  9 ++++++---
> > >   net/core/skbuff.c          |  2 +-
> > >   4 files changed, 15 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> > > index 07e0715628ec..3e9ea1cca6f2 100644
> > > --- a/include/trace/events/skb.h
> > > +++ b/include/trace/events/skb.h
> > > @@ -24,13 +24,14 @@ DEFINE_DROP_REASON(FN, FN)
> > >   TRACE_EVENT(kfree_skb,
> > >
> > >     TP_PROTO(struct sk_buff *skb, void *location,
> > > -            enum skb_drop_reason reason),
> > > +            enum skb_drop_reason reason, struct sock *rx_sk),
> > >
> > > -   TP_ARGS(skb, location, reason),
> > > +   TP_ARGS(skb, location, reason, rx_sk),
> > >
> > >     TP_STRUCT__entry(
> > >             __field(void *,         skbaddr)
> > >             __field(void *,         location)
> > > +           __field(void *,         rx_skaddr)
> >
> > Is there any reason for appending the "addr" part to "rx_sk" ?
> > It makes it harder to read this is the sk (socket).
> >
> > AFAICR the skbaddr naming is a legacy thing.
>
> I'm double-minded about the above: I can see your point, but on the
> flip side the 'addr' suffix is consistently used in net-related
> tracepoints.
> >
> > >             __field(unsigned short, protocol)
> > >             __field(enum skb_drop_reason,   reason)
> > >     ),
> > > @@ -38,12 +39,14 @@ TRACE_EVENT(kfree_skb,
> > >     TP_fast_assign(
> > >             __entry->skbaddr =3D skb;
> > >             __entry->location =3D location;
> > > +           __entry->rx_skaddr =3D rx_sk;
> > >             __entry->protocol =3D ntohs(skb->protocol);
> > >             __entry->reason =3D reason;
> > >     ),
> > >
> > > -   TP_printk("skbaddr=3D%p protocol=3D%u location=3D%pS reason: %s",
> > > -             __entry->skbaddr, __entry->protocol, __entry->location,
> > > +   TP_printk("skbaddr=3D%p rx_skaddr=3D%p protocol=3D%u location=3D%=
pS reason: %s",
> >                                ^^^^^^^^^
> > I find it hard to visually tell skbaddr and rx_skaddr apart.
> > And especially noticing the "skb" vs "sk" part of the string.
>
> I agree 'rx_skaddr' is sub-optimal. Either be consistent with all the
> other net tracepoints and use 'skaddr' (which will very likely will
> increase Jesper concerns, but I personally have no problem with such
> format) or prefer readability with something alike 'rx_sk' or (even
> better) 'sk'.
>

Jesper explained to me in a private message that "addr" makes more
sense when there was no BPF, since likely nothing would dereference
the pointer anymore at that time, so it's purely an address. But it is
no longer the case now. Also, in later patches of this change, I am
already breaking the "convention" by replacing kfree_skb with
sk_skb_reason_drop, so how about breaking it once more, and just
calling it "rx_sk". I want to keep the "rx_" to emphasize this is a
receiving socket. Let me send an amended version early next week and
see if more thoughts come.

thanks
Yan


> Thanks,
>
> Paolo
>

