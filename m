Return-Path: <linux-kernel+bounces-204588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A6C8FF0D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB881C22881
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DE919753A;
	Thu,  6 Jun 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QWA8iU7x"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57E1974F7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688281; cv=none; b=JH3ch0Bmz3APXAScewelcIEn5VggJKp4ijlbF1AkomT7ZI/Zh0gjTydl5zzu2hrvTXIjDzAi9gcUdxrFh6BiWh79VzXANXZZUux7MJq7BxILddCn9vwFP8tBmfouGvmJ/upXvMiDFliMoqgqKp9cGqjLckdaSX7kLgR97YWD2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688281; c=relaxed/simple;
	bh=IUkk5zhj1DcZWdKzXDJyYKMNokzbRhqdTi9DBTeq744=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRrbF08NAE2BQRhxJwRdeBvnJyNM7Ndzu1oiZ72gMvSRHP6aLSb8oZZPd/7mMEL5O7n7s0tVMKRu8X4C21iM6fofdtC7aE4b4E35o+QQz1txvMWg66IUQ817+B4/cqf4AaNcnzZrL2eJypwlOLOyKKGkJAWCztEgBlYA9DRLP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QWA8iU7x; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a20ccafc6so1270427a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717688277; x=1718293077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjoaKFiRHLufhoyzTuU0DqLcR7JBMRRBL3wKbN+Uo8A=;
        b=QWA8iU7xtyLQy3d9bnvBrXcikdquZqcsZ9M2/V2DcgXRKnjjR3MNC0u3JfeoD3xXVY
         02uHaHAqsqWoXFotMgj5l1rtiN14Ksre73OanLTRfY1OV4AQf89z3c1FThv/tpudF305
         XIgFw1rqW8l+KmJpADZxlqxef/E71IwP6pzstwZR3HzLqhYesf5YLHlEDGI1aDl3zUh3
         Cnw2LT3aSX91YPQI8vIKT46gr3cXPFPqnV8QaeI1g3j5s6i6ByYxI2HQaNN0pOLhZ61g
         9azPz3mu2oLuV2cIuim+U/VLQgw/Q8LWIWnLoT+Qmv/S5qm2N8nqAeci036USmKS9EAf
         ltdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688278; x=1718293078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjoaKFiRHLufhoyzTuU0DqLcR7JBMRRBL3wKbN+Uo8A=;
        b=HPx7Y1nL6cg3ddLu2gIfdd7J3+S/JsQ9ZyoLqAOI22kDduyckGgCcyDLQvpgeT1iao
         heK6vC1Lj5dRO0dw6wO+RKwKGI2bgQ5wsWZas/eeOOu1C+kArozVuQkHcNXuC/T1ZHw7
         rmhUMefa2UwDhsu3ALDZwF8yLWtxblJ9/eqEaDVZxEjADbhPPpHlzyJsDSSh9NTWHeUy
         eppeeYrz7jGR9BA18LKZb6vfqFjdpK2VxgXagysfKZN5i3cbV7PbChbiBxRwcsA35pCh
         btH0t7ikfIl1xnJC+AFZGc+Ye77TSIgs2+lWyCr8pw3ZGk/6hO3HwSMGOo6YocbLkcap
         /7rA==
X-Forwarded-Encrypted: i=1; AJvYcCWTZYUapokA90/sMFqLv9+VhDa7msw6SY/DZnR4SknYKOm9lcQ883nroeSBEpxzSAMLR6p6lfjSa5QjlMLy7m1zKFCuL6B5Xfl8oAr+
X-Gm-Message-State: AOJu0YwKnVKNxOsnhO7q0gHDa5KGpOq/a2GTmUPXd4gfODyFBUpGiU5n
	xdNX9scI2tiaT1Ra17w2qpCEbAs0+dBHPyPK2hip4cpP9HVHExKsi5HZJkTCtubhfDuHisiK93/
	xiKLnK23aJLkAejV4j7c6TOYl9XkcqajEJdMgpQ==
X-Google-Smtp-Source: AGHT+IFyT9WsgPIRQEwtewW7+PsUVNq1ikXDbAY6s7szeZI0EmQvhrtFcHcCN0i82engvdvgRnpiJmodMWMxvl4wN3Q=
X-Received: by 2002:a50:d7c2:0:b0:57a:231e:2cf5 with SMTP id
 4fb4d7f45d1cf-57a8b7c6225mr4188691a12.32.1717688277507; Thu, 06 Jun 2024
 08:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717529533.git.yan@cloudflare.com> <983c54f98746bd42d778b99840435d0a93963cb3.1717529533.git.yan@cloudflare.com>
 <20240605195750.1a225963@gandalf.local.home>
In-Reply-To: <20240605195750.1a225963@gandalf.local.home>
From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 6 Jun 2024 10:37:46 -0500
Message-ID: <CAO3-PbqRNRduSAyN9CtaxPFsOs9xtGHruu1ACfJ5e-mrvTo2Cw@mail.gmail.com>
Subject: Re: [RFC v3 net-next 1/7] net: add rx_sk to trace_kfree_skb
To: Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Mina Almasry <almasrymina@google.com>, 
	Florian Westphal <fw@strlen.de>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Borkmann <daniel@iogearbox.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Neil Horman <nhorman@tuxdriver.com>, 
	linux-trace-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 6:57=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 4 Jun 2024 14:47:38 -0700
> Yan Zhai <yan@cloudflare.com> wrote:
>
> > skb does not include enough information to find out receiving
> > sockets/services and netns/containers on packet drops. In theory
> > skb->dev tells about netns, but it can get cleared/reused, e.g. by TCP
> > stack for OOO packet lookup. Similarly, skb->sk often identifies a loca=
l
> > sender, and tells nothing about a receiver.
> >
> > Allow passing an extra receiving socket to the tracepoint to improve
> > the visibility on receiving drops.
> >
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v2->v3: fixed drop_monitor function prototype
> > ---
> >  include/trace/events/skb.h | 11 +++++++----
> >  net/core/dev.c             |  2 +-
> >  net/core/drop_monitor.c    |  9 ++++++---
> >  net/core/skbuff.c          |  2 +-
> >  4 files changed, 15 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> > index 07e0715628ec..aa6b46b6172c 100644
> > --- a/include/trace/events/skb.h
> > +++ b/include/trace/events/skb.h
> > @@ -24,15 +24,16 @@ DEFINE_DROP_REASON(FN, FN)
> >  TRACE_EVENT(kfree_skb,
> >
> >       TP_PROTO(struct sk_buff *skb, void *location,
> > -              enum skb_drop_reason reason),
> > +              enum skb_drop_reason reason, struct sock *rx_sk),
> >
> > -     TP_ARGS(skb, location, reason),
> > +     TP_ARGS(skb, location, reason, rx_sk),
> >
> >       TP_STRUCT__entry(
> >               __field(void *,         skbaddr)
> >               __field(void *,         location)
> >               __field(unsigned short, protocol)
> >               __field(enum skb_drop_reason,   reason)
> > +             __field(void *,         rx_skaddr)
>
> Please add the pointer after the other pointers:
>
>                 __field(void *,         skbaddr)
>                 __field(void *,         location)
> +               __field(void *,         rx_skaddr)
>                 __field(unsigned short, protocol)
>                 __field(enum skb_drop_reason,   reason)
>
> otherwise you are adding holes in the ring buffer event.
>
> The TP_STRUCT__entry() is a structure that is saved in the ring buffer. W=
e
> want to avoid alignment holes. I also question having a short before the
> enum, if the emum is 4 bytes. The short should be at the end.
>
> In fact, looking at the format file, there is a 2 byte hole:
>
>  # cat /sys/kernel/tracing/events/skb/kfree_skb/format
>
> name: kfree_skb
> ID: 1799
> format:
>         field:unsigned short common_type;       offset:0;       size:2; s=
igned:0;
>         field:unsigned char common_flags;       offset:2;       size:1; s=
igned:0;
>         field:unsigned char common_preempt_count;       offset:3;       s=
ize:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
>
>         field:void * skbaddr;   offset:8;       size:8; signed:0;
>         field:void * location;  offset:16;      size:8; signed:0;
>         field:unsigned short protocol;  offset:24;      size:2; signed:0;
>         field:enum skb_drop_reason reason;      offset:28;      size:4; s=
igned:0;
>
> Notice that "protocol" is 2 bytes in size at offset 24, but "reason" star=
ts
> at offset 28. This means at offset 26, there's a 2 byte hole.
>
The reason I added the pointer as the last argument is trying to
minimize the surprise to existing TP users, because for common ABIs
it's fine to omit later arguments when defining a function, but it
needs change and recompilation if the order of arguments changed.

Looking at the actual format after the change, it does not add a new
hole since protocol and reason are already packed into the same 8-byte
block, so rx_skaddr starts at 8-byte aligned offset:

# cat /sys/kernel/debug/tracing/events/skb/kfree_skb/format
name: kfree_skb
ID: 2260
format:
        field:unsigned short common_type;       offset:0;
size:2; signed:0;
        field:unsigned char common_flags;       offset:2;
size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;
 size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:void * skbaddr;   offset:8;       size:8; signed:0;
        field:void * location;  offset:16;      size:8; signed:0;
        field:unsigned short protocol;  offset:24;      size:2; signed:0;
        field:enum skb_drop_reason reason;      offset:28;
size:4; signed:0;
        field:void * rx_skaddr; offset:32;      size:8; signed:0;

Do you think we still need to change the order?

Yan


> -- Steve
>
>
>
> >       ),
> >
> >       TP_fast_assign(
> > @@ -40,12 +41,14 @@ TRACE_EVENT(kfree_skb,
> >               __entry->location =3D location;
> >               __entry->protocol =3D ntohs(skb->protocol);
> >               __entry->reason =3D reason;
> > +             __entry->rx_skaddr =3D rx_sk;
> >       ),
> >
>

