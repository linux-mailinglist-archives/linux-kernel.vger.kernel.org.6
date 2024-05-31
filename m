Return-Path: <linux-kernel+bounces-197330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A558D6962
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAFF1F277A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0374815AD93;
	Fri, 31 May 2024 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LhVIrZAi"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FD4653C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182331; cv=none; b=NIOBighe8tmOHV+e/XT2Ikr7OxfHAxsYKiSjMF5L92/oygoFoYrz3ZP8ShLWdKrLHPvHfTF3U+F3U+oHuwJ7ZIV/GCg9nHuDiui5ZiT/cjC4j1UOQIDF8zVxF4gbAHyQMZy1YbBTdrY0pUfFPZv40dTZTW7UL5rzvrCPaC6Xb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182331; c=relaxed/simple;
	bh=JLgUk4/H0I49wI7AFpjfE5SBqXIrl4DmbD4W1JvveUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXETYv5Dw5/USlMFAlMWe2tJ3r7YJR6j7RapXnRsOc0yAcbJtXMHit/MchQdvE5zwyHa/KlLhDZDfmDw4pIAvLtSCurrse+Yag1c7Mgmn4kxu9AuroYPnmED2K2p6Kf+MLys8h1/Kdxr4e9vg98D5H6P/Crx/3QPbPCFl3lG/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LhVIrZAi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so2631678a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717182328; x=1717787128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI3ySpP1YuGuRU+0r2fjh+wjdLvP3upJGIzwxGrKcXs=;
        b=LhVIrZAiHb7iMJSGRxvYzuyS37uhblIV4+4flec2xUd0h9+pTRbsY6S4E1cRvrORPH
         jH3wgPoZVNRSrLa1erSkHI44EtEqEYqBhCSvrBg7kSAbQvB0M9Ry2Qv8xYmDoDTOPIDr
         /fjGQjac5/PT8FxjEb5NO+Vri925HWedruGDHcBobRcrJWZ7Bb/dTSCqxXbUNGs3lZV2
         UxUefJ9UHX83icT+tfjtNoWYvSypj8EL+IDbyQUzHVLWkP1yAze33zV57m0xWNF8UOMX
         +R/cBr5aqrGHNrv4+j8ix/BGlbzngEVcPvVGhSdWHYRv026D2OKiszL+7KUnjizxx8J9
         CNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717182328; x=1717787128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI3ySpP1YuGuRU+0r2fjh+wjdLvP3upJGIzwxGrKcXs=;
        b=CptmGrey+RO73EnWIVqZkrllsEh15Y5ydx4u2AClzAUyf2wT773sIaYweqf6V5/nRy
         vjmqX5i+31dRwZPj9/eeh5BI9JGTrmePxvVSJieT2WjmIDqhgjVJ2i3i897aaqqerLUA
         Y7VoxIHD1D1L8mjN/ibT7i9e9ZDTl3EYrzDwgAFc0dAZlzZbaowoNSonCivR593/ilH/
         f0fLCibpgh9+AI9HplfzZ5ZCHoqcSGpo0XBC9P2INEJmaxmU6rEJsVckpMWzbKgs+f5H
         p+J4H3kMAj1xP5JmsuCdaV8iajQkyH0ITKpj3aEmcCMt7zhlW6BCzZmvPjB3vjS5OblT
         F1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCU3jSanRMEKQUvT2ScqTsL53VRL9t2l5mrI7xIbSIFGOGsRnzLJUs5jhGrOsgMwysC/TUXDb28zGAEFpzHfCJNSfOyABRq5b56Er5Au
X-Gm-Message-State: AOJu0YwjR5kmknKcOjU488uHkJKkRhHb8n4Cc8+kQfd4dog2bwR9FCvl
	l7u7ge0Kpmu0yJIKRpmHejTK6ZC33nsY376tR9jfwLP3R279ayec1RXUUrcUXb9PVPeblLSX3U+
	IxbqWckxob8jLncPcl8S2mgADDGaXtqgtTn/Pqw==
X-Google-Smtp-Source: AGHT+IGHM+cFCKr3cD4qLfBdzN50PJ4EDyUgAhS4Wnkb4lkIVrzCC1xfhFir50c+Rban7OD/Mp5ebucWbvjCKDVrJhg=
X-Received: by 2002:a50:9f22:0:b0:57a:2bfd:82b3 with SMTP id
 4fb4d7f45d1cf-57a36430e90mr1727721a12.23.1717182327616; Fri, 31 May 2024
 12:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717105215.git.yan@cloudflare.com> <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
 <CANn89iLo6A__U5HqeA65NuBnrg36jpt9EOUC7T0fLdNEpa6eRQ@mail.gmail.com>
 <CAO3-PboQ68+xFe4Z10L-s-k3NCgciGXNWM00-3wgqbPmGaBB9A@mail.gmail.com> <CANn89iJ_rd_vUH1LPbby5vV=s=jWdpzvDKnm6H1YK=wRPWBiyw@mail.gmail.com>
In-Reply-To: <CANn89iJ_rd_vUH1LPbby5vV=s=jWdpzvDKnm6H1YK=wRPWBiyw@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 31 May 2024 14:05:16 -0500
Message-ID: <CAO3-PbqaiqWvc1vgHzj2-DEQUPCxTByp4r+zTBWyo-XP4u1G4A@mail.gmail.com>
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

On Fri, May 31, 2024 at 12:32=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, May 31, 2024 at 6:58=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > Hi Eric,
> >
> >  Thanks for the feedback.
> >
> > On Fri, May 31, 2024 at 1:51=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, May 30, 2024 at 11:46=E2=80=AFPM Yan Zhai <yan@cloudflare.com=
> wrote:
> > > >
> > > > Implement a new kfree_skb_for_sk to replace kfree_skb_reason on a f=
ew
> > > > local receive path. The function accepts an extra receiving socket
> > > > argument, which will be set in skb->cb for kfree_skb/consume_skb
> > > > tracepoint consumption. With this extra bit of information, it will=
 be
> > > > easier to attribute dropped packets to netns/containers and
> > > > sockets/services for performance and error monitoring purposes.
> > >
> > > This is a lot of code churn...
> > >
> > > I have to ask : Why not simply adding an sk parameter to an existing
> > > trace point ?
> > >
> > Modifying a signature of the current tracepoint seems like a breaking
> > change, that's why I was saving the context inside skb->cb, hoping to
> > not impact any existing programs watching this tracepoint. But
> > thinking it twice, it might not cause a problem if the signature
> > becomes:
> >
> >  trace_kfree_skb(const struct sk_buff *skb, void *location, enum
> > skb_drop_reason reason, const struct sock *sk)
> >
> > As return values are usually not a thing for tracepoints, it is
> > probably still compatible. The cons is that the last "sk" still breaks
> > the integrity of naming. How about making a "kfree_skb_context"
> > internal struct and putting it as the last argument to "hide" the
> > naming confusion?
> >
> > > If this not possible, I would rather add new tracepoints, adding new =
classes,
> > > because it will ease your debugging :
> > >
> > > When looking for TCP drops, simply use a tcp_event_sk_skb_reason inst=
ance,
> > > and voila, no distractions caused by RAW/ICMP/ICMPv6/af_packet drops.
> > >
> > > DECLARE_EVENT_CLASS(tcp_event_sk_skb_reason,
> > >
> > >      TP_PROTO(const struct sock *sk, const struct sk_buff *skb, enum
> > > skb_drop_reason reason),
> > > ...
> > > );
> >
> > The alternative of adding another tracepoint could indeed work, we had
> > a few cases like that in the past, e.g.
> >
> > https://lore.kernel.org/lkml/20230711043453.64095-1-ivan@cloudflare.com=
/
> > https://lore.kernel.org/netdev/20230707043923.35578-1-ivan@cloudflare.c=
om/
> >
> > But it does feel like a whack-a-mole thing. The problems are solvable
> > if we extend the kfree_skb tracepoint, so I would prefer to not add a
> > new tracepoint.
>
> Solvable with many future merge conflicts for stable teams.
>
I don't quite follow it. I think this specific commit using skb->cb is
unnecessary so I am going to re-work it. As you initially mentioned,
maybe I should just extend kfree_skb tracepoint. I saw a similar
change dd1b527831a3("net: add location to trace_consume_skb()"), is it
something I might follow, or do you specifically mean changes like
this can annoy stable teams?

>
> >
> > >
> > > Also, the name ( kfree_skb_for_sk) and order of parameters is confusi=
ng.
> > >
> > > I always prefer this kind of ordering/names :
> > >
> > > void sk_skb_reason_drop( [struct net *net ] // not relevant here, but
> > > to expand the rationale
> > >               struct sock *sk, struct sk_buff *skb, enum skb_drop_rea=
son reason)
> > >
> > > Looking at the name, we immediately see the parameter order.
> > >
> > > The consume one (no @reason there) would be called
> > >
> > > void sk_skb_consume(struct sock *sk, struct sk_buff *skb);
> >
> > I was intending to keep the "kfree_skb" prefix initially since it
> > would appear less surprising to kernel developers who used kfree_skb
> > and kfree_skb_reason. But your points do make good sense. How about
> > "kfree_sk_skb_reason" and "consume_sk_skb" here?
> >
>
> IMO kfree_skb() and consume_skb() were a wrong choice. We have to live
> with them.
>
> It should have been skb_free(), skb_consume(), skb_alloc(),
> to be consistent.
>
> Following (partial) list was much better:
>
> skb_add_rx_frag_netmem, skb_coalesce_rx_frag, skb_pp_cow_data,
> skb_cow_data_for_xdp,
> skb_dump, skb_tx_error, skb_morph, skb_zerocopy_iter_stream, skb_copy_ubu=
fs,
> skb_clone, skb_headers_offset_update, skb_copy_header, skb_copy,
> skb_realloc_headroom, skb_expand_head, skb_copy_expand, skb_put,
> skb_push, skb_pull, skb_pull_data, skb_trim, skb_copy_bits,
> skb_splice_bits, skb_send_sock_locked, skb_store_bits,
> skb_checksum, skb_copy_and_csum_bits, skb_zerocopy_headlen,
> skb_zerocopy, skb_copy_and_csum_dev, skb_dequeue,
> skb_dequeue_tail, skb_queue_purge_reason, skb_errqueue_purge,
> skb_queue_head, skb_queue_tail, skb_unlink, skb_append,
> skb_split, skb_prepare_seq_read, skb_seq_read, skb_abort_seq_read,
> skb_find_text, skb_append_pagefrags, skb_pull_rcsum, skb_segment_list,
> skb_segment, skb_to_sgvec, skb_to_sgvec_nomark, skb_cow_data, skb_clone_s=
k,
> skb_complete_tx_timestamp, skb_tstamp_tx, skb_complete_wifi_ack,
> skb_partial_csum_set, skb_checksum_setup, skb_checksum_trimmed,
> skb_try_coalesce, skb_scrub_packet, skb_vlan_untag, skb_ensure_writable,
> skb_ensure_writable_head_tail, skb_vlan_pop, skb_vlan_push, skb_eth_pop,
> skb_eth_push, skb_mpls_push, skb_mpls_pop, skb_mpls_update_lse,
> skb_mpls_dec_ttl, skb_condense, skb_ext_add, skb_splice_from_iter
>
> (just to make my point very very clear)
>
> Instead we have a myriad of functions with illogical parameter
> ordering vs their names.
>
> I see no reason to add more confusion for new helpers.

ACK. Thanks for clarifying.

Yan

