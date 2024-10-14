Return-Path: <linux-kernel+bounces-364684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4C99D7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DA9283342
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367E1CF7B0;
	Mon, 14 Oct 2024 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cejzsElW"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52041CF296
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936391; cv=none; b=kk+seJn/w5+5L5wb+CCY+0bVW4LPkL/l9MgNM6PAtHeSKN2lPRHvrsBJIWwyfcGHlJ8yxT+kgFiGF9LZRX0ejR8H4ZqmC1fWswagI0bdVh27o7gCa32KPEpxyQZ7DPY9t+nvXqKV16/g8nkUoxJm1S3L00g3rqt/JK9Z5ORn+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936391; c=relaxed/simple;
	bh=4Ri6T/8OAnNvzcSG8Fe8w51CffeTL4mskN3jbG4uPus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTYz1Xb8LT5WqFdwQencEF+fA5n2o9GqNhPTFrC+RgzbmHXtCtK9hmWSzZFop/eY5pYUvgGKZ0KGh6SM22veX0hQtZL3EqIVZPWjZTebbE26U9TsLOPNhGd3EnHR4v37rKN2wpUuYQT13D0HiqU02NlUWYxQsTHUerRlTO+quEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cejzsElW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 36F8940624
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728936388;
	bh=yKWzm2dNvhWm9z8YkvsjycCHxzeK70hrT0KE+1kqPr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cejzsElWkwN0Wok0rL5wPZElfezmBPgiVBCbUKIdmbH+Rsku17tar4sBZAw4gM2hM
	 /XcbRMmOSuo5+XmlQ86HNBNrnQFaxXqHF7vqWOQU0555Q1xxoYHpKcXl3kav6uZ5D1
	 gy/mnHGS8YhcIzNFJyB4UAMhY1pvPqqpZxP3VZ+N082PTY7H4DyW0bYH2biBrEkixQ
	 milZWcA5r8UKmlZGBD75qlbkBUWVih9eO4DXZ8DNjSRD3Cr3GLKLrLynUGKVZwn8Fl
	 tT9mbJ2AQw+Zhec7wGn0fu0XwGbCrnZmoKejl9MGwG9urrVB5OzwmulCJeq/0xBPe0
	 GzsTi2B3PP8HA==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4311f7b9f04so20085355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936385; x=1729541185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKWzm2dNvhWm9z8YkvsjycCHxzeK70hrT0KE+1kqPr4=;
        b=bc8FOd5nt7ShGgonDsQ8b6Bb/1vxsSLwCwTWr3gZ6qgCXc0NOs/z6lqezzniRc3AKq
         Sc+AZmgCBmlnTa8IPRzn3BBArDlmgl8bO348MfBuHovTqB2kUA+6EpS7B9b7osSEP7Xb
         0D6CmLAXZ66GSgXSKcZad4cRVd+rTyRmr1LnwHH4d6WeC22bMRlhRgJWKnch3757ZtCc
         ivcIzNTUSvXU82odV089dLuBs1RIyogI9bvTc4VdcQXyXUm8B7gQBbwafayzp7KFHPEe
         Bqk8VdjwQTLLE4o9SNAMeEpULQCW5YGgNVtUdaVPA6VRwBo3TgUZn4ouOaD2whTb6zW6
         G+dg==
X-Forwarded-Encrypted: i=1; AJvYcCWstB0v8nT4/ZW4F5q2Y722ZkU1F6IrVGfKDlzwa2bbzlCKJlAhqfMUQgc1lBwjgyl1VDPvbcygsGamSH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFx1pV6GS3eZoTcBBepeSvS5eoOUpdJ1+RaT5nLaTfV2OPpEaZ
	HmcQOTqcJwshE6fHXseiSlfw5SkKajWz2lsYB46d/xOn8OK0ObjY3rGYcl7V5Pajsq8gUiMaVqV
	R0/iPrqjRRLuMm392nF84qQHMOlVGWoc73S6A1dh6d0RBUnznAnBMll+DGtUB2TGnJOOGOETLzO
	/c1ku2orAkvbK/8rrqggY+/CXA49Cid8RNZbrmo502nm9QVvi+hVAj
X-Received: by 2002:adf:fa89:0:b0:37c:c9ae:23fb with SMTP id ffacd0b85a97d-37d5529ad6amr8623568f8f.40.1728936385580;
        Mon, 14 Oct 2024 13:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Rv+5feZ6KMU+bI/PuCXsLMCpYt6xl/6DTOnQJErbOP78zNn0YELGl8S9OXhnnUC1Gk5vtffyIMyaLxksW1E=
X-Received: by 2002:adf:fa89:0:b0:37c:c9ae:23fb with SMTP id
 ffacd0b85a97d-37d5529ad6amr8623550f8f.40.1728936385133; Mon, 14 Oct 2024
 13:06:25 -0700 (PDT)
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
 <CAMqyJG1aPBsRFz1XK2JvqY+QUg2HhxugVXG1ZaF8yKYg=KoP3Q@mail.gmail.com> <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com>
In-Reply-To: <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Mon, 14 Oct 2024 22:06:14 +0200
Message-ID: <CAMqyJG2MqU46jRC1NzYCUeJ45fiP5Z5nS78Mi0FLFjbKbLVrFg@mail.gmail.com>
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

Hi, sorry for the late reply.

I've tested this debug patch (with CONFIG_DEBUG_NET=3Dy) on my machine,
and the DEBUG_NET_WARN_ON_ONCE never got triggered.

Thanks.

On Wed, 2 Oct 2024 at 14:59, Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Oct 2, 2024 at 12:40=E2=80=AFPM En-Wei WU <en-wei.wu@canonical.co=
m> wrote:
> >
> > Hi,
> >
> > I would kindly ask if there is any progress :)
>
> Can you now try this debug patch (with CONFIG_DEBUG_NET=3Dy ) :
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 39f1d16f362887821caa022464695c4045461493..e0e4154cbeb90474d92634d50=
5869526c566f132
> 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2909,9 +2909,19 @@ static inline void
> skb_reset_inner_headers(struct sk_buff *skb)
>         skb->inner_transport_header =3D skb->transport_header;
>  }
>
> +static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> +{
> +       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> +}
> +
>  static inline void skb_reset_mac_len(struct sk_buff *skb)
>  {
> -       skb->mac_len =3D skb->network_header - skb->mac_header;
> +       if (!skb_mac_header_was_set(skb)) {
> +               DEBUG_NET_WARN_ON_ONCE(1);
> +               skb->mac_len =3D 0;
> +       } else {
> +               skb->mac_len =3D skb->network_header - skb->mac_header;
> +       }
>  }
>
>  static inline unsigned char *skb_inner_transport_header(const struct sk_=
buff
> @@ -3014,11 +3024,6 @@ static inline void
> skb_set_network_header(struct sk_buff *skb, const int offset)
>         skb->network_header +=3D offset;
>  }
>
> -static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> -{
> -       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> -}
> -
>  static inline unsigned char *skb_mac_header(const struct sk_buff *skb)
>  {
>         DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
> @@ -3043,6 +3048,7 @@ static inline void skb_unset_mac_header(struct
> sk_buff *skb)
>
>  static inline void skb_reset_mac_header(struct sk_buff *skb)
>  {
> +       DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
>         skb->mac_header =3D skb->data - skb->head;
>  }
>
> @@ -3050,6 +3056,7 @@ static inline void skb_set_mac_header(struct
> sk_buff *skb, const int offset)
>  {
>         skb_reset_mac_header(skb);
>         skb->mac_header +=3D offset;
> +       DEBUG_NET_WARN_ON_ONCE(skb_mac_header(skb) < skb->head);
>  }
>
>  static inline void skb_pop_mac_header(struct sk_buff *skb)

