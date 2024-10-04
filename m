Return-Path: <linux-kernel+bounces-350791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFAA9909BB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522511C20A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5292A1D9A6F;
	Fri,  4 Oct 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QcBmcLKp"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAC1D433C
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060852; cv=none; b=sQS2Q8a11hCkPBQPouzOoHNngeqo85MEUbtFQE67sCj7htdtQf+M3uJoqmW2g0wknE4Pa4X0jhdezqvt+LeZC6zhxf4CxYk0XVanbCisZG91JMtNy0hWnEGb4205OmOAATkddFj0ViuDKUPdoG37e0yVxjND1IrrXQQdLIIILpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060852; c=relaxed/simple;
	bh=WnuGJomRwQzJvsyz5vLSl8rkhqsBna9Tnk7N2fb5klw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojmM+H5VeyImQcq636Uq/zWsTktXKD8gx7DhmuT5C5mXTVexrrSuFmk917ZC+GtnneOcF0JBTBMwsSjkPaqNBbmhO92EYui/Sz7HXZXh8unDpAslTgYv6tcG0P9sDPsmCCBSy4bT+Zak3tiuVkr7f8V5oO2M5Kc2i0wOZib5KHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QcBmcLKp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c5bca59416so2920500a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728060849; x=1728665649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4I4FHGBmIga8TS8rlluIiPlCWfdlIWIkty9QofFB+s=;
        b=QcBmcLKp+snnvHKZqZsanMPT9gN+qznVkI83i+1yM+ozGbbrWQLYKbZXVTQk+gbYma
         N6EBiPb3t1xkMmg2nG9PWva4xu80sjap1RnNKYawrTAyppvfYs3wi8crCmtAnYE93OBo
         eDJmD5NR7ArjK1IuHujEDiUJmIFZ8VrdTExpjchXKm1KPb3NRb3t1ZlmbuO5WER58kUY
         yF6LrcaX8l1IAtJRk2a/vK+W8HzF0StMiD6T+3wDQk7S7rld5tQwod0bCgVJRMhABido
         dL7igt2F9nhWYFrzPXDGAh42H+u/bOAkrPz4s4zvQ0PZHsQ7ZyC3tJvYeqY8jZFoTTll
         8WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728060849; x=1728665649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4I4FHGBmIga8TS8rlluIiPlCWfdlIWIkty9QofFB+s=;
        b=ool12a9NMyH6bGtLSndvFNvL4mDHtY+NOHeAveVAt8l3ZBvI9ihVtZWyz3h5CDgdeJ
         dap7sJ37nkS7zPmNvtDJnFaHcewy9Kal7mHodvV+QiPh6vhOsu9fb0FKEz1BW2vZ/0NQ
         zHdtt2qOh3SZCJXEJJRweXpzOM9txBf3cyzyFOQnqBb4nOrxTl40a25SOPYARK66Va7S
         r8AJ/2h2DlyMk9EETFV4ZvnhEjFz5+VzEDkNY/DykAZxQhHPvLTLYiQxf8x5DSqBiYIB
         OCdAwdv9mkKhSccAmNUZkmtoLR6K8kGptoAk62mksRzGQAVmfWa1vkITEmS+VoMuUiyy
         xbvA==
X-Forwarded-Encrypted: i=1; AJvYcCUoda3jNHdvZq5WI0BbOygO6Y5lRnN2+CdjlxYljEeXfuqisOApoKfzIF70xzP3nJhB3JGq4brYt0/ZOu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ffmFPFaFC03O3PrcdJotgU25jpzyXBjFh8l6zNqZqCTMXsu1
	QgNrWxoqXDt8ZtW6vgCF28cybo1JT/RI4eKCd3ep5NNMdIiRyPgx4nft2bjhZA8Dnu5p1w09KGa
	wmQ5ue6Vf9A1vQoN3mzWpys4vbUEIH4Hjv5fH
X-Google-Smtp-Source: AGHT+IGso2p4NWNwSbzMQE2c3tpT4/QZdSFfR6Nhjv6Ro5e6ZeUwHBEI5A36vvSPoEIzkjdipDSzz7z5xNPdHjtK118=
X-Received: by 2002:a05:6402:3495:b0:5c2:4cbe:ac33 with SMTP id
 4fb4d7f45d1cf-5c8d2e11c47mr2347656a12.2.1728060848926; Fri, 04 Oct 2024
 09:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001060005.418231-1-dongml2@chinatelecom.cn>
 <20241001060005.418231-2-dongml2@chinatelecom.cn> <20241004093641.7f68b889@kernel.org>
In-Reply-To: <20241004093641.7f68b889@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 18:53:55 +0200
Message-ID: <CANn89iJQbjtWhqv-D_fG4LpKtNK4G5g0JQq+fBrxv4VTY-QHSA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] net: ip: add drop reason to ip_route_input_noref()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, atenart@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, dsahern@kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, dongml2@chinatelecom.cn, bigeasy@linutronix.de, 
	toke@redhat.com, idosch@nvidia.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 6:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> no longer applies, please respin
>
> On Tue,  1 Oct 2024 13:59:59 +0800 Menglong Dong wrote:
> > +     enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_NOT_SPECIFIE=
D;
> >       const struct iphdr *iph =3D ip_hdr(skb);
> > -     int err, drop_reason;
> > +     int err;
> >       struct rtable *rt;
>
> reverse xmas tree
>
> >
> > -     drop_reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
> > -
> >       if (ip_can_use_hint(skb, iph, hint)) {
> >               err =3D ip_route_use_hint(skb, iph->daddr, iph->saddr, ip=
h->tos,
> >                                       dev, hint);
> > @@ -363,7 +362,7 @@ static int ip_rcv_finish_core(struct net *net, stru=
ct sock *sk,
> >        */
> >       if (!skb_valid_dst(skb)) {
> >               err =3D ip_route_input_noref(skb, iph->daddr, iph->saddr,
> > -                                        iph->tos, dev);
> > +                                        iph->tos, dev, &drop_reason);
>
> I find the extra output argument quite ugly.
> I can't apply this now to try to suggest something better, perhaps you
> can come up with a better solution..

Also, passing a local variable by address forces the compiler to emit
more canary checks in more
networking core functions.


See :


config STACKPROTECTOR_STRONG
bool "Strong Stack Protector"
depends on STACKPROTECTOR
depends on $(cc-option,-fstack-protector-strong)
default y
help
  Functions will have the stack-protector canary logic added in any
  of the following conditions:

  - local variable's address used as part of the right hand side of an
    assignment or function argument
  - local variable is an array (or union containing an array),
    regardless of array type or length
  - uses register local variables

  This feature requires gcc version 4.9 or above, or a distribution
  gcc with the feature backported ("-fstack-protector-strong").

  On an x86 "defconfig" build, this feature adds canary checks to
  about 20% of all kernel functions, which increases the kernel code
  size by about 2%.

