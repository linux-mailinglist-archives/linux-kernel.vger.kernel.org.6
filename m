Return-Path: <linux-kernel+bounces-240051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A583392688B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC6D282EF0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D1118EFD2;
	Wed,  3 Jul 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LH7tgryV"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E018C329
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032431; cv=none; b=TW5jUINR7dZEDZEqpxInZtkjiJQQrMZYdjIJiVeT91g89xADLcXf6egnGDdcFhjqUoAAVdJvl6FjD8aLuSEjGzGTsaBQYuEnS4vCuWJjATlQi+r69Fj2HQi9dvJGbeC8y9XJgzjgz50x1xksYdJfdAS/ML4dpLmS0aLql4Lu7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032431; c=relaxed/simple;
	bh=U1aIMAwz3FbjRMw0teXuS4vAqrIqN0t6zHAZzcqTBjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POlFkY2+B0Y9EiU+7pWQxd0giYgp8wAwrKY1xAMXeDRlsJ5KSjx4LAuB5OGUcNbcwB2x69JABMGVRBhHghkYambDumY+3D+myipimoYXrdtVpOpuH9CRnbj22ABmE15Ue+JlOfGVmA7yYOb1+RkXQPd4EntPYrvgG7VYOi52NG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LH7tgryV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so2821362a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720032428; x=1720637228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQk72JCv8xunalg/OFrZG+6tfe91SGi/hEKDU2c5Qzc=;
        b=LH7tgryVBT5Mx6Q3iKrvZTdAsXB/yBWXvdSy5grWBoTzCkDxO/TYcZPNv1Pu9+dp1t
         ra8+RV4hNBhClJdV+T/HC/x/5iOxbXEdtCYtddj9v353hRbNn68BsMbnfRt3O2ulNKGd
         aSpHEGq0EVSLDHf0sn2no4cZQTN/MNrCClfhk90yEOdjLe3qwTbfrESrAcJfHXsksl1S
         WKqBnm//5u9oAQ1ISJDWVFszWuOzTHL5bZ4EO6kngpKeiA81oczED2T2URpSH8FOu+dp
         yH0V6MK+Y4+CXvO7aaVX4yLad5APqh8GIv/6PLfHr6joI+2Io15KUNIJHLLF1JyRfHhM
         GZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720032428; x=1720637228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQk72JCv8xunalg/OFrZG+6tfe91SGi/hEKDU2c5Qzc=;
        b=md96xXx15V1RYqizlBG44Q9Kumcjbvs+wfhaEdh1FwWGKD2uTEzW4pugW2Hwwiej6g
         jjYTDTE/xWznJvCoD7WF/kp9qUJn3ek8lauvx5kGTlSyPZakw+C7dSpaYTKRaxj+bx1w
         mQVifttxXdQ6F82+tcB6MZZ1j2lXYgXO8ihqEEd1U9cZnwInTAABQ6Tj4iXjaorw8kPZ
         fTl7fKMDHQxex15YRgcEHvNlY9F6D5JeCZD56fT2GN8ropStFUGFp6FSf+09lYqgXkRd
         xDSI4v0beJtsp9X1AkPA8WVncZMydYG2txIfxgAHzbr/7P5lsN/52Lk2PUb7HtePTue6
         Nrdg==
X-Forwarded-Encrypted: i=1; AJvYcCUxBS6FRScuu1ag7z/Az+t3nRww9AAqjB3EacdbjglS/+2oDcwM5Uc7kxUWXkhxOjZ2mLJcJEaTPEP+gGK8q0ckfaMcrIM5B5yRZhqf
X-Gm-Message-State: AOJu0YzrzzWOShpFluW8uP6q6V3/00qVBZUYYjgDFjV0CinnJZnJntrB
	14JKxXHqQZusoWELS963gLLa5aImEaDEJ0Z2OnEE5sVdTkW6fJNqtnoB7XlpXIb21yatxBfVd1B
	ispSy8NdmhpD4TedAXpaj/B5Weit89P+knfxH2Q==
X-Google-Smtp-Source: AGHT+IE+I2Ldl64Ugcw74PGxeiTNFpW4lIMiFyy0VDEc+IyHnAgc0h1HWq+4B0AXk/S9PyvzZEqP8UbqgHIHW0O0g9A=
X-Received: by 2002:a05:6402:5216:b0:57d:2c9:6497 with SMTP id
 4fb4d7f45d1cf-5879ede274dmr11842347a12.3.1720032428007; Wed, 03 Jul 2024
 11:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
 <CAO3-Pbp8frVM-i6NKkmyNOFrqqW=g58rK8m4vfdWbiSHHdQBsg@mail.gmail.com>
 <6677dc5cb5cca_33522729474@willemb.c.googlers.com.notmuch>
 <CAO3-PbrKRqeA4bCPnv7xkDiUFtuCMfzYZiEur3wM=+x8nc2xpQ@mail.gmail.com> <668160415228c_c6202948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <668160415228c_c6202948c@willemb.c.googlers.com.notmuch>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 3 Jul 2024 13:46:56 -0500
Message-ID: <CAO3-PbphGpqRwYE22WCAoU89sW+-jy9k4=_aA54jEnJM9GLiew@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Mina Almasry <almasrymina@google.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	David Howells <dhowells@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Ahern <dsahern@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Antoine Tenart <atenart@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 8:40=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Yan Zhai wrote:
> > On Sun, Jun 23, 2024 at 3:27=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Yan Zhai wrote:
> > > > > > -static inline bool netif_elide_gro(const struct net_device *de=
v)
> > > > > > +static inline bool netif_elide_gro(const struct sk_buff *skb)
> > > > > >  {
> > > > > > -     if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> > > > > > +     if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_=
prog)
> > > > > >               return true;
> > > > > > +
> > > > > > +#ifdef CONFIG_SKB_GRO_CONTROL
> > > > > > +     return skb->gro_disabled;
> > > > > > +#else
> > > > > >       return false;
> > > > > > +#endif
> > > > >
> > > > > Yet more branches in the hot path.
> > > > >
> > > > > Compile time configurability does not help, as that will be
> > > > > enabled by distros.
> > > > >
> > > > > For a fairly niche use case. Where functionality of GRO already
> > > > > works. So just a performance for a very rare case at the cost of =
a
> > > > > regression in the common case. A small regression perhaps, but de=
ath
> > > > > by a thousand cuts.
> > > > >
> > > >
> > > > I share your concern on operating on this hotpath. Will a
> > > > static_branch + sysctl make it less aggressive?
> > >
> > > That is always a possibility. But we have to use it judiciously,
> > > cannot add a sysctl for every branch.
> > >
> > > I'm still of the opinion that Paolo shared that this seems a lot of
> > > complexity for a fairly minor performance optimization for a rare
> > > case.
> > >
> > Actually combining the discussion in this thread, I think it would be
> > more than the corner cases that we encounter. Let me elaborate below.
> >
> > > > Speaking of
> > > > performance, I'd hope this can give us more control so we can achie=
ve
> > > > the best of two worlds: for TCP and some UDP traffic, we can enable
> > > > GRO, while for some other classes that we know GRO does no good or
> > > > even harm, let's disable GRO to save more cycles. The key observati=
on
> > > > is that developers may already know which traffic is blessed by GRO=
,
> > > > but lack a way to realize it.
> > >
> > > Following up also on Daniel's point on using BPF as GRO engine. Even
> > > earlier I tried to add an option to selectively enable GRO protocols
> > > without BPF. Definitely worthwhile to be able to disable GRO handlers
> > > to reduce attack surface to bad input.
> > >
> > I was probably staring too hard at my own things, which is indeed a
> > corner case. But reducing the attack surface is indeed a good
> > motivation for this patch. I checked briefly with our DoS team today,
> > the DoS scenario will definitely benefit from skipping GRO, for
> > example on SYN/RST floods. XDP is our main weapon to drop attack
> > traffic today, but it does not always drop 100% of the floods, and
> > time by time it does need to fall back to iptables due to the delay of
> > XDP program assembly or the BPF limitation on analyzing the packet. I
> > did an ad hoc measurement just now on a mostly idle server, with
> > ~1.3Mpps SYN flood concentrated on one CPU and dropped them early in
> > raw-PREROUTING. w/ GRO this would consume about 35-41% of the CPU
> > time, while w/o GRO the time dropped to 9-12%. This seems a pretty
> > significant breath room under heavy attacks.
>
> A GRO opt-out might make sense.
>
> A long time ago I sent a patch that configured GRO protocols using
> syscalls, selectively (un)registering handlers. The interface was not
> very nice, so I did not pursue it further. On the upside, the datapath
> did not introduce any extra code. The intent was to reduce attack
> surface of packet parsing code.
>
> A few concerns with an XDP based opt-out. It is more work to enable:
> requires compiling and load an XDP program. It adds cycles in the
> hot path. And I do not entirely understand when an XDP program will be
> able to detect that a packet should not enter the GRO engine, but
> cannot drop the packet (your netfilter example above).
>
Agree that XDP based approach is just offering for XDP users. But
given the way GRO works on flows today, it feels really hard to
provide an elegant and generic interface.

For DoS scenarios, let me expand it a bit. Packets themselves could be
a good indicator that they should not go through GRO, like fragments,
or with special flags like SYN/RST/PSH. Under an attack, we sometimes
also need conntrack or SYN cookies to help determine if some packets
are legit or not. We have a few kfuncs to lookup conntrack entries in
XDP today, but I am not sure if we can confidently drop them without
completely mirroring full conntrack functionality. Rather, using
conntrack as extra heuristics to mark suspicious packets in XDP, like
TCP packets out of windows, etc, and still leave verdict to iptables
seems a safer thing to do. I did observe a few occurrences in the past
where a substantial amount of SYN flood passed through XDP, with some
clever tricks in faking flow headers. Those were eventually dealt by
SYN cookies, but all of those go through GRO unnecessarily although
they all carry a SYN flag. Would be definitely beneficial to save
every cycle under attacks.

> > But I am not sure I understand "BPF as GRO engine" here, it seems to
> > me that being able to disable GRO by XDP is already good enough. Any
> > more motivations to do more complex work here?
>
> FWIW, we looked into this a few years ago. Analogous to the BPF flow
> dissector: if the BPF program is loaded, use that instead of the C
> code path. But we did not arrive at a practical implementation at the
> time. Things may have changed, but one issue is how to store and
> access the list (or table) of outstanding GRO skbs.
>
I see, thanks for the explanation.

Yan

> > best
> > Yan
> >
> > >
> > > >
> > > > best
> > > > Yan
> > >
> > >
>
>

