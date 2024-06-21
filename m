Return-Path: <linux-kernel+bounces-225136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4379912C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B45282AED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C328168494;
	Fri, 21 Jun 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QOdNyeZW"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E413D521
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990471; cv=none; b=YlIXwxzPD/ci0kDVv8r4XqHTZf+6Va8HUc4FM6YH4931Uq8mPR1hl1da2u05CPH7+mNoHa1Vs7N64RV7WtLp3F9B5s1tsmqinS4zMXxkVN4n9D1nujjm/fuH5HxkxtNeiHLdc4XiiP3QWt72/FVnSTyG4BBl9AZ1SM8neW9nByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990471; c=relaxed/simple;
	bh=I/luRIkvOcbcT9wuLGb2btKD8UMXkYQlJQH8n4fvvRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZEFGzzC9Fb8qqjd3ssMw6ZWNv7+95d3TyTLU6yfXgLBZgeEwVc1ftz0zDy49fs59Iupqe2SR9+jbCwX/1IMwk1mQ3kazqXfWcr44UmvHIVgGWszmxQOqEvOhuuhTPsNanqDo2MUTAODQ/WY/oTyrgQJWQIriaMEgAdR0YeY8Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QOdNyeZW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6fd7bee2feso67675366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718990468; x=1719595268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5geVM6kNOmyxNjLK0qy8h1CsiCtOOy9GQmItUlINgo=;
        b=QOdNyeZWSN7rjT8DD1gKHMvAMznVhDlrzelP1N5q8SFWaCJ78BURlG/wRpnbOPTxz4
         bMQHOv4EkDuQteqEHRxSji8F2xI662V2j9NobIegjZUaHOPcBmQlHzLfAK2WL6bSiQNt
         gH5nsCO3L+TTXWlixuCWSKTaqXRstCr7B4XVJPNpZwEoSkh+nhx1VA4l2F5AZFio+YRy
         nhkUNgbppxYV7j+gHJFt33HfsHfjH83cdpHlAhM6tSSxYU/p1kpdurjMcY55Iu0Zn3Ao
         zDi7dY55b7LNgX2+wJh7gNFMSiYKVmG6WfwzPuKNcY8IPBgWyhnp7O+FVw6etDLD71og
         /vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718990468; x=1719595268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5geVM6kNOmyxNjLK0qy8h1CsiCtOOy9GQmItUlINgo=;
        b=ikKL3oMCH9siUOiaKMwPSSEk7LtEESfhgYitG0420iYAjJ0rB4hZUUy79u7zwGNDPB
         FrcZZhMHGJeKel7FQeSJkvayia7Sc4BhRBRJ0KaiN9HYjqch2pp7WoA4MOS3vnkfpJCF
         ujuAQQrI28mHNNpOvqDUmj2yFhraGx+N3Xvk+mClFLIalYnJElK1QEwD5q2yUUSFAwsj
         H3zR/Z0XMvTcm/Xl+kcIB3XezZUNYMWT5TMeRc6WLlvSURY931P0fbxVIRy6UaymiR66
         Np6JXTHlWq/MzXtulvNdtsb3YfLj+FlBGuQSJ/VmOXWywIUsuLcu1NYISnh+uQcOHnC8
         AA8A==
X-Forwarded-Encrypted: i=1; AJvYcCUKPM2ozZ+icCbP2mLe6xIkwDPfTJcvRvW4uaZCQyNH+ZQbcHmvOaB8bVXtJilCGGRwlekWOxrVzDkyAP52guhjoo0Y0mrJk6JZ3Oz0
X-Gm-Message-State: AOJu0Yx7kncPsa0QKJ1zpalRyP++2FbRNpcrzXXjhRTNxQQxPlAR8po9
	kK8Q3LHKslo0wD/8cBsjYUs/tmwIJSssheCWGsfYrblQ0QPslnplBmnJ9VeGepPbsatKzpd/418
	r2b1YcnRpO1qjEg34qgQc119S2RuY6UwlUfCqnQ==
X-Google-Smtp-Source: AGHT+IG4FB5C+nnJ3fPlzdu5kNLw931HpbPpKfZhcOo9WuAIJG6c2cz6pS9CQ9UI0emKRbU1bfH9gBo9EY35Yyqmbu4=
X-Received: by 2002:a17:906:d83:b0:a65:7643:3849 with SMTP id
 a640c23a62f3a-a6fab7d6be4mr535810166b.73.1718990467879; Fri, 21 Jun 2024
 10:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
 <44ac34f6-c78e-16dd-14da-15d729fecb5b@iogearbox.net> <CAO3-PbrhnvmdYmQubNsTX3gX917o=Q+MBWTBkxUd=YWt4dNGuA@mail.gmail.com>
 <e6553be1-4eaa-e90a-17f8-dece2bb95e7b@iogearbox.net>
In-Reply-To: <e6553be1-4eaa-e90a-17f8-dece2bb95e7b@iogearbox.net>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 21 Jun 2024 12:20:55 -0500
Message-ID: <CAO3-PboYruuLrF7D_rMiuG-AnWdR4BhsgP+MhVmOm-f3MzJFyQ@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 11:41=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 6/21/24 6:00 PM, Yan Zhai wrote:
> > On Fri, Jun 21, 2024 at 8:13=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 6/21/24 2:15 PM, Willem de Bruijn wrote:
> >>> Yan Zhai wrote:
> >>>> Software GRO is currently controlled by a single switch, i.e.
> >>>>
> >>>>     ethtool -K dev gro on|off
> >>>>
> >>>> However, this is not always desired. When GRO is enabled, even if th=
e
> >>>> kernel cannot GRO certain traffic, it has to run through the GRO rec=
eive
> >>>> handlers with no benefit.
> >>>>
> >>>> There are also scenarios that turning off GRO is a requirement. For
> >>>> example, our production environment has a scenario that a TC egress =
hook
> >>>> may add multiple encapsulation headers to forwarded skbs for load
> >>>> balancing and isolation purpose. The encapsulation is implemented vi=
a
> >>>> BPF. But the problem arises then: there is no way to properly offloa=
d a
> >>>> double-encapsulated packet, since skb only has network_header and
> >>>> inner_network_header to track one layer of encapsulation, but not tw=
o.
> >>>> On the other hand, not all the traffic through this device needs dou=
ble
> >>>> encapsulation. But we have to turn off GRO completely for any ingres=
s
> >>>> device as a result.
> >>>>
> >>>> Introduce a bit on skb so that GRO engine can be notified to skip GR=
O on
> >>>> this skb, rather than having to be 0-or-1 for all traffic.
> >>>>
> >>>> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> >>>> ---
> >>>>    include/linux/netdevice.h |  9 +++++++--
> >>>>    include/linux/skbuff.h    | 10 ++++++++++
> >>>>    net/Kconfig               | 10 ++++++++++
> >>>>    net/core/gro.c            |  2 +-
> >>>>    net/core/gro_cells.c      |  2 +-
> >>>>    net/core/skbuff.c         |  4 ++++
> >>>>    6 files changed, 33 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>>> index c83b390191d4..2ca0870b1221 100644
> >>>> --- a/include/linux/netdevice.h
> >>>> +++ b/include/linux/netdevice.h
> >>>> @@ -2415,11 +2415,16 @@ struct net_device {
> >>>>       ((dev)->devlink_port =3D (port));                         \
> >>>>    })
> >>>>
> >>>> -static inline bool netif_elide_gro(const struct net_device *dev)
> >>>> +static inline bool netif_elide_gro(const struct sk_buff *skb)
> >>>>    {
> >>>> -    if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> >>>> +    if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
> >>>>               return true;
> >>>> +
> >>>> +#ifdef CONFIG_SKB_GRO_CONTROL
> >>>> +    return skb->gro_disabled;
> >>>> +#else
> >>>>       return false;
> >>>> +#endif
> >>>
> >>> Yet more branches in the hot path.
> >>>
> >>> Compile time configurability does not help, as that will be
> >>> enabled by distros.
> >>>
> >>> For a fairly niche use case. Where functionality of GRO already
> >>> works. So just a performance for a very rare case at the cost of a
> >>> regression in the common case. A small regression perhaps, but death
> >>> by a thousand cuts.
> >>
> >> Mentioning it here b/c it perhaps fits in this context, longer time ag=
o
> >> there was the idea mentioned to have BPF operating as GRO engine which
> >> might also help to reduce attack surface by only having to handle pack=
ets
> >> of interest for the concrete production use case. Perhaps here meta da=
ta
> >> buffer could be used to pass a notification from XDP to exit early w/o
> >> aggregation.
> >
> > Metadata is in fact one of our interests as well. We discussed using
> > metadata instead of a skb bit to carry this information internally.
> > Since metadata is opaque atm so it seems the only option is to have a
> > GRO control hook before napi_gro_receive, and let BPF decide
> > netif_receive_skb or napi_gro_receive (echo what Paolo said). With BPF
> > it could indeed be more flexible, but the cons is that it could be
> > even more slower than taking a bit on skb. I am actually open to
> > either approach, as long as it gives us more control on when to enable
> > GRO :)
>
> Oh wait, one thing that just came to mind.. have you tried u64 per-CPU
> counter map in XDP? For packets which should not be GRO-aggregated you
> add count++ into the meta data area, and this forces GRO to not aggregate
> since meta data that needs to be transported to tc BPF layer mismatches
> (and therefore the contract/intent is that tc BPF needs to see the differ=
ent
> meta data passed to it).
>

Very very sorry to resendx2 :( Not sure why my laptop also decided to
switch on html... I removed CCs from the message hopefully it reduces
some noises...

We did this before accidentally (we put a timestamp for debugging
purposes in metadata) and this actually caused about 20% of OoO for
TCP in production: all PSH packets are reordered. GRO does not fire
the packet to the upper layer when a diff in metadata is found for a
non-PSH packet, instead it is queued as a =E2=80=9Cnew flow=E2=80=9D on the=
 GRO list
and waits for flushing. When a PSH packet arrives, its semantic is to
flush this packet immediately and thus precedes earlier packets of the
same flow.

The artifact of this behavior can also cause latency increase and hash
degradation since the mismatch does not result in flushing, it results
in extra queuing on the same hash list, until the list is flushed.
It=E2=80=99s another reason we want to disable GRO when we know metadata ca=
n
be set differently for tracing purposes (I didn=E2=80=99t mention this thou=
gh
because it seems distracting).

Thanks
Yan

> Thanks,
> Daniel

