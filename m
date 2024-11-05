Return-Path: <linux-kernel+bounces-396076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630D59BC7A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873F71C2163A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696D1FF023;
	Tue,  5 Nov 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="v4dXqGl2"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0851FEFA2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730793960; cv=none; b=u03Ea7E1w5NL+TZzLvbv0Ypv8OLOqL1O8djdBG4i0jJjMdnVUw62VadYrbt4wTCxeTrNd0gdvJA8MbJyOpYWkujvDOCRu8h5RJixsm37Vo86BB7tRe0T7jh55j+HEZXJLKQ7kGLMbLru2i33vu+8weL3crdx/oTFC+06STPX+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730793960; c=relaxed/simple;
	bh=YPaHXVAA/YI+D7uTy+xljhnWRnN8Gd/dLo79RfZ+upo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NY3H5N1oOJsLuO5qs4d7rnLhKGNLnnaL140xX6kQMYLvqQmYRGeZabokmjYk2WexM4SC9fN+wph3Fiw+sb2G7akjiWUEinz1+tkOm6m8/4hPxJlqvYJkr+HxjffbQVf33aXPRW9HvRE9MvHnoQT1BbYF2WBE7jaxnDlZD/OdfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=v4dXqGl2; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 144873F2A9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730793955;
	bh=ZOwmbvypNY7SJx9qJfB/HL5HYlEP7KynRr9HfRBtRvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=v4dXqGl2mHKuufvIYUoIw9WiiPrEgTQYcoC1Xk64569BVYZnOxrMNH7cMYNCbgspB
	 pdRnJNZCbbJQ+XOwBUd3zHb5DqrkHmKSXJVlqZo10KpbM+ByHkTolYbiP7izfP8DLu
	 zs75yF3aEwCR4OmKziCvrdqJgRbPhiise7abyDDiY+25X67jyN7r6Rg2hnvXRORT4H
	 EDWu8STBtsxbBupkTUPINL0PhpawQxeXNaAeOlWuwsa/YgepCIhp03xOrk1/nabb8p
	 MYoN/hOApdYWPlGCKL2lGw9n5VuOYvLfWNyOUxH3ppSoTpcmgw2sNhnEquUNpWsq0F
	 KTng4uKNzMCEQ==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d67fe93c6so2874219f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730793952; x=1731398752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOwmbvypNY7SJx9qJfB/HL5HYlEP7KynRr9HfRBtRvU=;
        b=dbDhZI1+xh9wqbsy+msyZ9jAFCa+23U/lUf8dtulsVnOl7/pyz84/Vex+klKkK2Y/e
         JNiOYFqvMuj+QVbY7wK/hwUBXOaUy5rMaWo9+VPAgpzDv4ixJ73XM9Tgi3OjpvpVjIdH
         Em4yw/NSiIc21wgkkaCBwIoEi5kgcxGw3E6M/B35KWtf9ft92l4w20rQtBKvR3YJNgWO
         JQWzSqLNJHsWjQKEnGNhAdBzH5bDqUpocn7TK+YJssVZnkzJ7M9GGgnOU+fFp1+seHEk
         ktbVoEdnpbRCcXPlRulY/VpL3qjvVCK+UejCO7KAIGjadAX2K3EDCadeZtVXRt9mxLNq
         DSzw==
X-Forwarded-Encrypted: i=1; AJvYcCXbq4p32L2Cr1Sp8TbjkmU5FPqekEhHX7J2OWDcAa3IksCRk//flq/KS4M4LXudmuwR9KMOIEDt5Dly6K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8cEQByBDvY4Vyif+ld7JJRRem3LXL84jZJvdBkMPpZVgpmtU
	OqE5GnEEDzA69i9y170uEVb3/qyveYI9Wzrs0y3EDWh6ww4rCxlvrsCROrxglP5GrAbfJvLorIe
	dMrDJZTeDIk9ItuSfm2di+Ux4+z9ceUuwfYIi56cqrDapuTeFcMmXuPcdsKoFPDV/kn33fc9U5i
	Jrd5Xve97tB8YQ+nNWgMA9fmyzIzcY+0e9yHYtA2yPNb190RgFgOn1
X-Received: by 2002:a5d:6c68:0:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-381bea1bfc4mr15826498f8f.45.1730793951682;
        Tue, 05 Nov 2024 00:05:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX/dSSZILHuK3uVDEXge5/gJUupfGp22dMkdum7U3ygcz4rT9yxy5cRYzjNB2z/aX/ElvjbgmclkkYIl4wslQ=
X-Received: by 2002:a5d:6c68:0:b0:381:b68f:d14b with SMTP id
 ffacd0b85a97d-381bea1bfc4mr15826465f8f.45.1730793951234; Tue, 05 Nov 2024
 00:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
 <20240912113518.5941b0cf@gmx.net> <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
 <CAMqyJG1W1ER0Q_poS7HQhsogxr1cBo2inRmyz_y5zxPoMtRhrA@mail.gmail.com>
 <CANn89iJ+ijDsTebhKeviXYyB=NQxP2=srpZ99Jf677+xTe7wqg@mail.gmail.com>
 <CAMqyJG1aPBsRFz1XK2JvqY+QUg2HhxugVXG1ZaF8yKYg=KoP3Q@mail.gmail.com>
 <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com>
 <CAMqyJG2MqU46jRC1NzYCUeJ45fiP5Z5nS78Mi0FLFjbKbLVrFg@mail.gmail.com> <CAMqyJG0DYVaTXHxjSH8G8ZPRc=2aDB0SZVhoPf2MXpiNT1OXxA@mail.gmail.com>
In-Reply-To: <CAMqyJG0DYVaTXHxjSH8G8ZPRc=2aDB0SZVhoPf2MXpiNT1OXxA@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Tue, 5 Nov 2024 16:05:40 +0800
Message-ID: <CAMqyJG2UKG_P5Dbp6t=K98HAhBVHu-iuCrTjUx+NqzUJHTDA0w@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Seiderer <ps.report@gmx.net>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Can I kindly ask if there is any progress?

Thanks,
Regards.

On Fri, 18 Oct 2024 at 21:21, En-Wei WU <en-wei.wu@canonical.com> wrote:
>
> > Seems like the __netif_receive_skb_core() and dev_gro_receive() are
> > the places where it calls skb_reset_mac_len() with skb->mac_header =3D
> > ~0U.
> I believe it's the root cause.
>
> My concern is that if we put something like:
> +       if (!skb_mac_header_was_set(skb)) {
> +               DEBUG_NET_WARN_ON_ONCE(1);
> +               skb->mac_len =3D 0;
> in skb_reset_mac_len(), it may degrade the RX path a bit.
>
> Catching the bug in xfrm4_remove_tunnel_encap() and
> xfrm6_remove_tunnel_encap() (the original patch) is nice because it
> won't affect the systems which are not using the xfrm.
>
> Kind Regards,
> En-Wei.
>
> On Mon, 14 Oct 2024 at 22:06, En-Wei WU <en-wei.wu@canonical.com> wrote:
> >
> > Hi, sorry for the late reply.
> >
> > I've tested this debug patch (with CONFIG_DEBUG_NET=3Dy) on my machine,
> > and the DEBUG_NET_WARN_ON_ONCE never got triggered.
> >
> > Thanks.
> >
> > On Wed, 2 Oct 2024 at 14:59, Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Wed, Oct 2, 2024 at 12:40=E2=80=AFPM En-Wei WU <en-wei.wu@canonica=
l.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I would kindly ask if there is any progress :)
> > >
> > > Can you now try this debug patch (with CONFIG_DEBUG_NET=3Dy ) :
> > >
> > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > index 39f1d16f362887821caa022464695c4045461493..e0e4154cbeb90474d9263=
4d505869526c566f132
> > > 100644
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -2909,9 +2909,19 @@ static inline void
> > > skb_reset_inner_headers(struct sk_buff *skb)
> > >         skb->inner_transport_header =3D skb->transport_header;
> > >  }
> > >
> > > +static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> > > +{
> > > +       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> > > +}
> > > +
> > >  static inline void skb_reset_mac_len(struct sk_buff *skb)
> > >  {
> > > -       skb->mac_len =3D skb->network_header - skb->mac_header;
> > > +       if (!skb_mac_header_was_set(skb)) {
> > > +               DEBUG_NET_WARN_ON_ONCE(1);
> > > +               skb->mac_len =3D 0;
> > > +       } else {
> > > +               skb->mac_len =3D skb->network_header - skb->mac_heade=
r;
> > > +       }
> > >  }
> > >
> > >  static inline unsigned char *skb_inner_transport_header(const struct=
 sk_buff
> > > @@ -3014,11 +3024,6 @@ static inline void
> > > skb_set_network_header(struct sk_buff *skb, const int offset)
> > >         skb->network_header +=3D offset;
> > >  }
> > >
> > > -static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> > > -{
> > > -       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> > > -}
> > > -
> > >  static inline unsigned char *skb_mac_header(const struct sk_buff *sk=
b)
> > >  {
> > >         DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
> > > @@ -3043,6 +3048,7 @@ static inline void skb_unset_mac_header(struct
> > > sk_buff *skb)
> > >
> > >  static inline void skb_reset_mac_header(struct sk_buff *skb)
> > >  {
> > > +       DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
> > >         skb->mac_header =3D skb->data - skb->head;
> > >  }
> > >
> > > @@ -3050,6 +3056,7 @@ static inline void skb_set_mac_header(struct
> > > sk_buff *skb, const int offset)
> > >  {
> > >         skb_reset_mac_header(skb);
> > >         skb->mac_header +=3D offset;
> > > +       DEBUG_NET_WARN_ON_ONCE(skb_mac_header(skb) < skb->head);
> > >  }
> > >
> > >  static inline void skb_pop_mac_header(struct sk_buff *skb)

