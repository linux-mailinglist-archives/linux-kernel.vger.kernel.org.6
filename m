Return-Path: <linux-kernel+bounces-371738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DFA9A3FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDEB1F22048
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7A1EE031;
	Fri, 18 Oct 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WAfMJV28"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDCF42ABD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258222; cv=none; b=DoVawMAjjQ0KvTagpQzVYT3MjC5WLs5MlM0NWrDxi3PSDRJSRP/tdCGrtyIPraMAennPf51LLk5qA1FHA57379jGUkXeChRNt4U1j6ULOcOMXZ7yf0f6h3/nsQWBK0GrjbMBtSFCr9m7QNu4/xMkb4eDTy1nMbsx7wSGNxKfBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258222; c=relaxed/simple;
	bh=p3DTc4O8vInbNPSupIvHX0R53UKRk87fWs5iJU5kRpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLP4uxNGYI/jRPr5hah6P+PAj5diruENZvi/7kdNDnWbLLqzvQUXlBVYCde9w2Mc/EK+hRgjS+PWWcmMllC+ouN3cwh7mAy9t20mem857dP99UQ4RktGbO44GEwy9krcxZnb9qSEDS7Xi0sp4rsuwRW7pzS8TGjk68HJimXLVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WAfMJV28; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E68743F5AB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729257715;
	bh=Z5nbekklhuEu06YT3tciT7nnVcLbYF0ZUP641zijrpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=WAfMJV285qGNo1c4RB3kmeKKKC1HS+w/o/gBZZfJnyFI+AurrHw/g941Dq915imLM
	 MNG2dCIiGgLqU2kgtgjXUcXKyDI91D+2mzIz9gywxK2cS8PrfyclRmp5X//wpUdthQ
	 bZlHpZ9/Kne8dIcWBx2AOCqEdNbowsV3aHpZExlDbQHqObo2Hc/hAXLaVuX9JCreet
	 RgI1hDI4eVZBytVexuPn54WlVPpoyUfVqbl7A64zfy8Y7g7u4WJ+okBV+tHPE0y3ug
	 s4ZgN3aqWkXXpem7jg9QYWSHFqjQsJHsHbBLGqjhW4Maly74wWfOL3yf61k2AOJacA
	 2hx86MWKkbgmw==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so1174119f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257715; x=1729862515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5nbekklhuEu06YT3tciT7nnVcLbYF0ZUP641zijrpg=;
        b=s5+vFjQBukCMwBcOltpNbPc9jJ/sv6T+WcqikGL+6lfRar+bIDpsXPp3YO6SyhoJJP
         vWP6FGLW5LtYaIIjaJmzu6fArhY/RK7f4OAyUG6EbteMjCrvGDZ2jMktKG0RUNIPVRxI
         0JPBuQqG0oR8QTjTgX3nFsnVfMO6FKzz/qTADMMQQKQTJzje61nVTsOLgD2cw3ej/4lL
         Az/PFc5+EAGxiRFzTt/EsUWUXekV4K7LOkT1Fe6SJBFCmI6v8iPf6N6cLo467l5d/wRy
         TvhgJe+UzG9ovU3DmENpNFNlIcDNTX6wA9bhyj7ncUunHrgCOLA6TZnK4JU6DtHFpX1R
         mmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUObvVLxNqp8Uer6h7iXQiUT8cdxcUtc0/t/p+umBnixtw/q2mEbkg4/KYHHkEA80zQ2IFYy7D8HugV9j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0+6zk9GijXWWdl13YuHgXVOyGQgI6GfSohFSNnul5aEGJjtT
	3ks9A0Ru8j9ktj5DruXpZJCFfByjRMrI8k2ByisUNnkjzrmfD00GAhpqKZtSVMtZYZ6/7N1FTUa
	N7rietUUmz9UOaf4gTATKiYLHAOKtCA6Vm5b3scOJ8HZ6zCThhh5zR/f7cs8heRZ+LgESt1BYLk
	5A3ddRb9bStS15RAaoj80RLEwoI1qACQmJhCKjp4sNPrtRfD97ypA67Rr0DhfIfRlq4w==
X-Received: by 2002:a5d:6801:0:b0:37d:4e59:549a with SMTP id ffacd0b85a97d-37eab6edd1fmr1692928f8f.16.1729257714665;
        Fri, 18 Oct 2024 06:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvqVis6AOhAKHGQ0jRLkpLbn5cO2x+TXp7Dkwd5xfWMTZeQul3F0FXVsek1XUcmw0usZznNWbYyTZlznmrbGs=
X-Received: by 2002:a5d:6801:0:b0:37d:4e59:549a with SMTP id
 ffacd0b85a97d-37eab6edd1fmr1692913f8f.16.1729257714273; Fri, 18 Oct 2024
 06:21:54 -0700 (PDT)
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
 <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com> <CAMqyJG2MqU46jRC1NzYCUeJ45fiP5Z5nS78Mi0FLFjbKbLVrFg@mail.gmail.com>
In-Reply-To: <CAMqyJG2MqU46jRC1NzYCUeJ45fiP5Z5nS78Mi0FLFjbKbLVrFg@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Fri, 18 Oct 2024 15:21:43 +0200
Message-ID: <CAMqyJG0DYVaTXHxjSH8G8ZPRc=2aDB0SZVhoPf2MXpiNT1OXxA@mail.gmail.com>
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

> Seems like the __netif_receive_skb_core() and dev_gro_receive() are
> the places where it calls skb_reset_mac_len() with skb->mac_header =3D
> ~0U.
I believe it's the root cause.

My concern is that if we put something like:
+       if (!skb_mac_header_was_set(skb)) {
+               DEBUG_NET_WARN_ON_ONCE(1);
+               skb->mac_len =3D 0;
in skb_reset_mac_len(), it may degrade the RX path a bit.

Catching the bug in xfrm4_remove_tunnel_encap() and
xfrm6_remove_tunnel_encap() (the original patch) is nice because it
won't affect the systems which are not using the xfrm.

Kind Regards,
En-Wei.

On Mon, 14 Oct 2024 at 22:06, En-Wei WU <en-wei.wu@canonical.com> wrote:
>
> Hi, sorry for the late reply.
>
> I've tested this debug patch (with CONFIG_DEBUG_NET=3Dy) on my machine,
> and the DEBUG_NET_WARN_ON_ONCE never got triggered.
>
> Thanks.
>
> On Wed, 2 Oct 2024 at 14:59, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Oct 2, 2024 at 12:40=E2=80=AFPM En-Wei WU <en-wei.wu@canonical.=
com> wrote:
> > >
> > > Hi,
> > >
> > > I would kindly ask if there is any progress :)
> >
> > Can you now try this debug patch (with CONFIG_DEBUG_NET=3Dy ) :
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 39f1d16f362887821caa022464695c4045461493..e0e4154cbeb90474d92634d=
505869526c566f132
> > 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -2909,9 +2909,19 @@ static inline void
> > skb_reset_inner_headers(struct sk_buff *skb)
> >         skb->inner_transport_header =3D skb->transport_header;
> >  }
> >
> > +static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> > +{
> > +       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> > +}
> > +
> >  static inline void skb_reset_mac_len(struct sk_buff *skb)
> >  {
> > -       skb->mac_len =3D skb->network_header - skb->mac_header;
> > +       if (!skb_mac_header_was_set(skb)) {
> > +               DEBUG_NET_WARN_ON_ONCE(1);
> > +               skb->mac_len =3D 0;
> > +       } else {
> > +               skb->mac_len =3D skb->network_header - skb->mac_header;
> > +       }
> >  }
> >
> >  static inline unsigned char *skb_inner_transport_header(const struct s=
k_buff
> > @@ -3014,11 +3024,6 @@ static inline void
> > skb_set_network_header(struct sk_buff *skb, const int offset)
> >         skb->network_header +=3D offset;
> >  }
> >
> > -static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> > -{
> > -       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> > -}
> > -
> >  static inline unsigned char *skb_mac_header(const struct sk_buff *skb)
> >  {
> >         DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
> > @@ -3043,6 +3048,7 @@ static inline void skb_unset_mac_header(struct
> > sk_buff *skb)
> >
> >  static inline void skb_reset_mac_header(struct sk_buff *skb)
> >  {
> > +       DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
> >         skb->mac_header =3D skb->data - skb->head;
> >  }
> >
> > @@ -3050,6 +3056,7 @@ static inline void skb_set_mac_header(struct
> > sk_buff *skb, const int offset)
> >  {
> >         skb_reset_mac_header(skb);
> >         skb->mac_header +=3D offset;
> > +       DEBUG_NET_WARN_ON_ONCE(skb_mac_header(skb) < skb->head);
> >  }
> >
> >  static inline void skb_pop_mac_header(struct sk_buff *skb)

