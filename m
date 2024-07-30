Return-Path: <linux-kernel+bounces-266580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C119401E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9391F22A93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB21366;
	Tue, 30 Jul 2024 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xMeDl1RD"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F0391
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722298030; cv=none; b=FUwTZfxIyMQdhsz1tg1HpjXLbpuepthuZMAg6FYWMaQ69U3fUmE+MDxLLMWO9tpOm2gDccrRNQr4qvlbzpYbhy0zdzIH06FHlRxhIvs77MUwolZmRnBxS1fNz2AKurchiJ+zUtJHTnnWZpLgGK9+Qnu8ejdC0YgRn81ulTWNLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722298030; c=relaxed/simple;
	bh=eZm97zrjYiE0PMFduXm7VqN3vNfCF2/+jcwRXMcsBzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyvPD12gwBn9CapBoOunKrnZ2z5cBClgdhwEVT7haIUbUiDJoh2fzSjTjWaUGYml924Qz7xXMs6xuWOUbOBimOVywWPCmCxTHjtd7kJDAoPPXw7NlPq1sS9pxfrWkZgasjbc0Ojh172zBrSaL/6ZFgh9HSPJjKfKmDjxBVsNwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xMeDl1RD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso7381a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722298026; x=1722902826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChlUpzBf8jWBQzajiKanYyrLrced2TsETaljmhqol/U=;
        b=xMeDl1RDViAwGC+H1UtqSNArr2Z/fban4lbbVSyLDvsMEnWKOUgcWKJRLmjUQEmldA
         r5NluCJfP2JStTwaKJLtGh4eU/OoSzSZErOgnRigbGOIdtouDYA7uD0+3/Q7eq3n7EjW
         a/rWuFixjaDq079MEzO0IywNOdqkr2MgfhtyA0kdJNxsO5muQpvej/VqmzO3ldA/O3W0
         /JFKM4KbZApwZyuZItSUs7so5GDtMeY37Vn7iANDl1MBOuuKOjVl/BDvrrQF16n2j4jT
         yw8P7FRR6WSeRAfXrMLBALG1hJEdDrZUu0cDtSzyPsNJ2EBRxhS9X/5hWDQyhPNEsJfE
         Kj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722298026; x=1722902826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChlUpzBf8jWBQzajiKanYyrLrced2TsETaljmhqol/U=;
        b=vcmBqWUBl9Mrm27dtbzvgOD4Cz7Ob6437mxEE78i0hL8v9FbGgif+jwRAIbI8tXOuY
         yI2EeYo1XWt4HT8Gs65yzfSTFEDrxWSHjjMgIE0AJqoFpKjbvU3B2z2N2HEi8c3T6MtA
         Quarb5GiUBdU2qv/G6TG1b2mGRbvGIiuRYIyv6N/wzDJJCWOnYSDQinmIPGoQkiPn4Fa
         S46uBzyewlCVlI0F8oek9S2pBwXNDhNntCzZMwlQTGwjs4RPyqGkPKUr6oYRyGiGbIJy
         knY9QZ7dbjDU/NYeyoTU8fZpHQ+0LUf1fYWmwK1cwBWiqigzhi5BlZJ7nHcaRuzY0sYP
         caRw==
X-Forwarded-Encrypted: i=1; AJvYcCUqHL1XkUjLvjarCAY37ZGWxD2m9Ft8QY+n3NizyJx0Xaw6+HCeOWRZW2CRYwDRgsSwgOVABal28l7c5VxXyLxnnSQgmS0jCiMrRUoR
X-Gm-Message-State: AOJu0Yy6mnir9MgHAHHJXVc3v0FJIN0wgdkR2p/NA6dHr2ZKvJcC5n1W
	jsB2SCx0EGXLLR7xyBiDzqJkwELzAu+fr4WTbb4yfRxx/iChNZKKaBX2L4bT8hCxQgFVaS02lJB
	8D6Y2bB76F+SHkeC+FPuxuuuSKZhNM6T3A9jf
X-Google-Smtp-Source: AGHT+IHCcv2cqpoiv/vgvFsJ1hu+psLY1VBf/2quyXAwMShj5J+ffUGNoYKRJdbDe6h6XfUgW9ldic35FXupSVO4Akg=
X-Received: by 2002:a05:6402:27c9:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5b461375635mr43245a12.6.1722298025664; Mon, 29 Jul 2024
 17:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729220059.3018247-1-prohr@google.com>
In-Reply-To: <20240729220059.3018247-1-prohr@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 29 Jul 2024 17:06:54 -0700
Message-ID: <CANP3RGd1iv12GMVrm+HxhNJcofJGFc96z+Or6kLheV1JeAx2wA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] Add support for PIO p flag
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lorenzo Colitti <lorenzo@google.com>, 
	David Lamparter <equinox@opensourcerouting.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 3:01=E2=80=AFPM Patrick Rohr <prohr@google.com> wro=
te:
>
> draft-ietf-6man-pio-pflag is adding a new flag to the Prefix Information
> Option to signal that the network can allocate a unique IPv6 prefix per
> client via DHCPv6-PD (see draft-ietf-v6ops-dhcp-pd-per-device).
>
> When ra_honor_pio_pflag is enabled, the presence of a P-flag causes
> SLAAC autoconfiguration to be disabled for that particular PIO.
>
> An automated test has been added in Android (r.android.com/3195335) to
> go along with this change.
>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: David Lamparter <equinox@opensourcerouting.org>
> Cc: Simon Horman <horms@kernel.org>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 14 ++++++++++++++
>  include/linux/ipv6.h                   |  1 +
>  include/net/addrconf.h                 | 10 +++++++---
>  net/ipv6/addrconf.c                    | 15 ++++++++++++++-
>  4 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 3616389c8c2d..eacf8983e230 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2362,6 +2362,20 @@ ra_honor_pio_life - BOOLEAN
>
>         Default: 0 (disabled)
>
> +ra_honor_pio_pflag - BOOLEAN
> +       The Prefix Information Option P-flag indicates the network can
> +       allocate a unique IPv6 prefix per client using DHCPv6-PD.
> +       This sysctl can be enabled when a userspace DHCPv6-PD client
> +       is running to cause the P-flag to take effect: i.e. the
> +       P-flag suppresses any effects of the A-flag within the same
> +       PIO. For a given PIO, P=3D1 and A=3D1 is treated as A=3D0.
> +
> +       - If disabled, the P-flag is ignored.
> +       - If enabled, the P-flag will disable SLAAC autoconfiguration
> +         for the given Prefix Information Option.
> +
> +       Default: 0 (disabled)
> +
>  accept_ra_rt_info_min_plen - INTEGER
>         Minimum prefix length of Route Information in RA.
>
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index 383a0ea2ab91..a6e2aadbb91b 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -89,6 +89,7 @@ struct ipv6_devconf {
>         __u8            ioam6_enabled;
>         __u8            ndisc_evict_nocarrier;
>         __u8            ra_honor_pio_life;
> +       __u8            ra_honor_pio_pflag;
>
>         struct ctl_table_header *sysctl_header;
>  };
> diff --git a/include/net/addrconf.h b/include/net/addrconf.h
> index 62a407db1bf5..b18e81f0c9e1 100644
> --- a/include/net/addrconf.h
> +++ b/include/net/addrconf.h
> @@ -37,10 +37,14 @@ struct prefix_info {
>                 struct __packed {
>  #if defined(__BIG_ENDIAN_BITFIELD)
>                         __u8    onlink : 1,
> -                               autoconf : 1,
> -                               reserved : 6;
> +                               autoconf : 1,
> +                               routeraddr : 1,
> +                               preferpd : 1,
> +                               reserved : 4;
>  #elif defined(__LITTLE_ENDIAN_BITFIELD)
> -                       __u8    reserved : 6,
> +                       __u8    reserved : 4,
> +                               preferpd : 1,
> +                               routeraddr : 1,
>                                 autoconf : 1,
>                                 onlink : 1;
>  #else
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 55a0fd589fc8..4febf679a435 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -239,6 +239,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly=
 =3D {
>         .ioam6_id_wide          =3D IOAM6_DEFAULT_IF_ID_WIDE,
>         .ndisc_evict_nocarrier  =3D 1,
>         .ra_honor_pio_life      =3D 0,
> +       .ra_honor_pio_pflag     =3D 0,
>  };
>
>  static struct ipv6_devconf ipv6_devconf_dflt __read_mostly =3D {
> @@ -302,6 +303,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_m=
ostly =3D {
>         .ioam6_id_wide          =3D IOAM6_DEFAULT_IF_ID_WIDE,
>         .ndisc_evict_nocarrier  =3D 1,
>         .ra_honor_pio_life      =3D 0,
> +       .ra_honor_pio_pflag     =3D 0,
>  };
>
>  /* Check if link is ready: is it up and is a valid qdisc available */
> @@ -2762,6 +2764,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8=
 *opt, int len, bool sllao)
>         u32 addr_flags =3D 0;
>         struct inet6_dev *in6_dev;
>         struct net *net =3D dev_net(dev);
> +       bool ignore_autoconf =3D false;

This ' =3D false' appears to be spurious (as ignore_autoconf is only
read after being written), but is of course harmless.

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

>         pinfo =3D (struct prefix_info *) opt;
>
> @@ -2864,7 +2867,8 @@ void addrconf_prefix_rcv(struct net_device *dev, u8=
 *opt, int len, bool sllao)
>
>         /* Try to figure out our local address for this prefix */
>
> -       if (pinfo->autoconf && in6_dev->cnf.autoconf) {
> +       ignore_autoconf =3D READ_ONCE(in6_dev->cnf.ra_honor_pio_pflag) &&=
 pinfo->preferpd;
> +       if (pinfo->autoconf && in6_dev->cnf.autoconf && !ignore_autoconf)=
 {
>                 struct in6_addr addr;
>                 bool tokenized =3D false, dev_addr_generated =3D false;
>
> @@ -6926,6 +6930,15 @@ static const struct ctl_table addrconf_sysctl[] =
=3D {
>                 .extra1         =3D SYSCTL_ZERO,
>                 .extra2         =3D SYSCTL_ONE,
>         },
> +       {
> +               .procname       =3D "ra_honor_pio_pflag",
> +               .data           =3D &ipv6_devconf.ra_honor_pio_pflag,
> +               .maxlen         =3D sizeof(u8),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dou8vec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_ONE,
> +       },
>  #ifdef CONFIG_IPV6_ROUTER_PREF
>         {
>                 .procname       =3D "accept_ra_rtr_pref",
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

