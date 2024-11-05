Return-Path: <linux-kernel+bounces-396183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ACC9BC915
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2A41F22F17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F01D0784;
	Tue,  5 Nov 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ueUscxhA"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6901CDA3E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798751; cv=none; b=SYuW16iEPF0enjYIlnr4AFN2hCRzqbaDCxGgG7F2nBjSMu+QXiuIY72TBqefS9A6rG9K+41P5tqxjRSe7zWiyXsof4wrbZYr2dkQs1Wh+B69Mr1193T6gpqNGGyWJ3Jg9LXf7WW53/WmJ4mhm65bLhe7EJqkjcvcoCFPR7Nlku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798751; c=relaxed/simple;
	bh=KcY42FPvtnq6OFbQUwWWfgE+hW7UfWMrW1tl39zYFaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+Fqe7Su3GyEZyJMo7UGqJNj1v7RCFGQZgBToTidPOeBdQFZfj8yiaff0FlNGKSJhP6JUdrQBQlLCrRNBNQmfEJr0mR9UtP508mzKLIT+YCjHy7O1KUQZeRQRm5D5twpmK0xLEvV7BYvzBaMdnHpzzM5GVaUdFOblBsYbGlJkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ueUscxhA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso6401136a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730798748; x=1731403548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9FPXG1LQELNToyRoGqMx1mS5uhmOWH7uDHaAUOLnUw=;
        b=ueUscxhA8AXkI1svH/2ejX60BzZGbFmong8EFGvvPLIkBckgzXuAVKiSwD75OMO69j
         ZFVubf8p/xOpG9mX4aw5J3fUAsagiGDEIJLfMPAj4JqkAG4cRnyr7JSbtyueBqLa3zpx
         rIx2yY+R3C7OfsIDNJWiiqW/6tVDuiqo+XA4fvkJk7Vfq/pMubb1aJR3bp2a19Tr+BDJ
         W64OSqrYIIv/ynVeGJI64eg9zmrJQE27BfsiSEiDGxoLm0V9d60cSmnQB3lpinlY3VEt
         kdNSfvuNw5tUXbKudC7WgMVa94y6psND9F1cCOByetjLpcjc+7vck4iwWgJlBtJdlOV0
         jUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798748; x=1731403548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9FPXG1LQELNToyRoGqMx1mS5uhmOWH7uDHaAUOLnUw=;
        b=KPrmgeRMGPEPNetyImGN4vKcnxe8Pv4o2AW0urc1ClgmqYfYiwgdZxwwGZV0AqJI6e
         rdwrMEgUCEkhqOhUsA7FrR5c58Ex4BDJg3uEBsyTqHqEVmLDHOnozpjHrfFU7D3lOvlC
         lAMepbiLKo+/WlnwRP+DnUUFK7kBISdNpD2rofjVJJgW5fbN6bxUNVJbe7I5FVLBMVMU
         2BaQ6lHOBGU/Bj0qu8fXL2FrHbQwmSplh723b+cUeYth99EucEbdQgSyFK0ip82S+X7K
         WDzENa88BwBT4kMe1Tk0ZVkrvzXQZXPCkHKzLeOivv5Z8LCpJ3fSLmPiEzwxw00Jffas
         67bA==
X-Forwarded-Encrypted: i=1; AJvYcCUDPgfXMOyoVfoMUr5nTNxmq20oPOg08Uul1Xro3zFP6ab83AJy7TQitYlhxtmaulX3t8ACipYdr9eZXL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEBZeAtscwWiqvGaTj9AIUWFjCjcYN6GCw/Yxf1OwWdsQ+JgL
	jBew6PstcLbvfgsrt7T60jU/lgF2xKzkFPT649qZUiRsrVp65srpbvYk5TlLbm0+xnQuPakPSda
	1OD6g1Ia5mdvvfLAbRzWKSWs0QB4jvZbwYHjh
X-Google-Smtp-Source: AGHT+IFWw5e0Lj3WFMEm21UIlPzv+yQa97oWMx8p8bOR9ghoVbBQ1kyOtpJM5Qa+FzaQTbnGQmtSwGG5N1r5PakPfjY=
X-Received: by 2002:a17:907:2cc7:b0:a99:d308:926 with SMTP id
 a640c23a62f3a-a9de632d0a5mr3159772266b.57.1730798747742; Tue, 05 Nov 2024
 01:25:47 -0800 (PST)
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
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 10:25:35 +0100
Message-ID: <CANn89iL-r3+HBC10m+QdFVn20DdNH=r5EBQDV=EmewWm6Vsyqg@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: Peter Seiderer <ps.report@gmx.net>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:22=E2=80=AFPM En-Wei WU <en-wei.wu@canonical.com>=
 wrote:
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

I do not have such concerns. Note this is temporary until we fix the root c=
ause.

>
> Catching the bug in xfrm4_remove_tunnel_encap() and
> xfrm6_remove_tunnel_encap() (the original patch) is nice because it
> won't affect the systems which are not using the xfrm.
>

Somehow xfrm is feeding to gro_cells_receive() packets without the mac
header being set, this is the bug that needs to be fixed.

GRO needs skb_mac_header() to return the correct pointer.

For normal GRO, it is set either in :

1) napi_gro_frags : napi_frags_skb()  calls skb_reset_mac_header(skb);

2) napi_gro_receive() : callers are supposed to call eth_type_trans()
before calling napi_gro_receive().
    eth_type_trans() calls skb_reset_mac_header() as expected.

xfrm calls skb_mac_header_rebuild(), but it might be a NOP if MAC
header was never set.

