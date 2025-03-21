Return-Path: <linux-kernel+bounces-571503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3375EA6BE03
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC801897A46
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2BA1D5174;
	Fri, 21 Mar 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LAsuQIo"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3B1388
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569998; cv=none; b=SDh4Ce/VLrRJe9QR3QNLHHWv8AcLwWj4sln2fYjBwYkylDj7lt1tD+6ehYLilOxy9ozWifwP6wAnxAyEQmbhR/34wTvQWO0DOZJwxbQzwcA5HllbuwD9x2h1rzqSf8U2AF/qId7xwTKHeFi5vt1cHT1TYKNnMPnZg29WL9X4io4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569998; c=relaxed/simple;
	bh=rR79tbWP+1YMxLCZkPMGkxbByXOoDSm03FZ0WSLrUsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j13OCtkB5/JFlsQXgQId3ZigeYpWI//1bbUiB62f0u0Zo5/D/0J2PieHRBwysvwtiHKgBbpbU85pva4e5z4ouV2k1TosezXhff/Q7z2cbPms7Ty7vBcH0aK7/elnQmG5Sc11o/BQx1+6B51YqxXvPJUpIfNSn/7HOXP4SMdREws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LAsuQIo; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-477282401b3so1985071cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742569996; x=1743174796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tHHIrPqJW/dhMbJ42KnhCWqKTqIVh+RwEH2sp+CKGY=;
        b=1LAsuQIop4ZGt4ydKa4+S6NQgxzqVWJv+puw3niTsSD5xI5Z1FGzoDTU9soTwMBFyZ
         7oDToWn+j5gJvjZEFJQ0q1sTUl2O9b5ZWTAIXKcj7Lh/sT5dxc6rDoJeAjY3ElwbznC3
         Lk3fb9iua/ZMjztk/vES9ScRzFxxtBe7TNAdSZQ52UMK1Ry2E+Agjg5Eo6F+CPuTRG76
         NTGeUF9lBgz2A8W6v6IhY7bNRuygbrqgaS9KVjT2rzs4ZuKILp3ye5Out46j87Yv6Qf8
         g2LGw6KiUIYRCueZdFHYoVVIdmio+r5XlYEbLlWGkwvZtp8z35uPakx9UPP03k46pLVU
         NhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742569996; x=1743174796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tHHIrPqJW/dhMbJ42KnhCWqKTqIVh+RwEH2sp+CKGY=;
        b=ix8aZBqFFGF3kec3hpqf+btBBaOQyrcIre8357yL1+oiULDgHtmgFZ5hM7XOAMr0GC
         zYHJCxMixg8ToD3DzmDxfOpeZOsmtV7pSaHL2azxUu3mI3Bh9dBwpCd2i1Uwio5doFW9
         w2IVKTX2dDcRs9Mj2N04EnTGgEg8iDl8I345QxQ3X4hh032RAcF/X6uZLO34iQRE8+CZ
         FoGxvniAOUW6zW3uPoPJy2Oh8JYuuxPRGQT1QetTRSW4A/EdsvO2bwSKI3rm9NhBqmyy
         aLOWlXQlbniSWbGgDVd2z9mQEuwKdGy64kXFXBcd+GBuavr4gNCKwmsdoIVfRQBtEVQL
         YD3w==
X-Forwarded-Encrypted: i=1; AJvYcCVjGBtYWoXXoVryFys0DuMCj1zSOApTfAonx4bODKueRugz6di/8weVZbgJ4HZx+4GRniubNPC1c+TyWGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbzezHVCvDLGxxFfnxlgjqjJ2pe8UMAINQzNbl394jOXTjFv2
	EGG38VOThQh65rBeWLk5SIlz+9FRlkWak4CE7Io0m9HcDTNXHu1sjACMCiNIdpy9ts2g5V5JLYv
	hJftncfOsVckfBGyHeIDBA2be/ei9jjpQ9F/s
X-Gm-Gg: ASbGncthDHPd/jPCMwqp5+4pJJlB1daodBIV1b/HIM/s4CpL/89fXT0+hkmzYbX/pee
	XtopJcvcLmng4cmLlASsA/TwK0d8JZ6I5WT+gqz3IpFG7lClcOYzU0qxHA1uCSA0bEfz8b3E0MS
	SPWwJO8XwBYV8OjJ2SozOV4dd/a5111+4Myf4=
X-Google-Smtp-Source: AGHT+IG7KBMcJue7QheRLhZKBDvi1C8hUdlYyAMS4RYvgI1oMECk6x11bhhwn+ySWnwDiOb99R8WzGGs0BOeVderSkI=
X-Received: by 2002:a05:622a:1e0f:b0:476:afd2:5b6f with SMTP id
 d75a77b69052e-4771dd9b3a5mr48681641cf.29.1742569995636; Fri, 21 Mar 2025
 08:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321121352.29750-1-qasdev00@gmail.com>
In-Reply-To: <20250321121352.29750-1-qasdev00@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Mar 2025 16:13:04 +0100
X-Gm-Features: AQ5f1JqyM7auzV4r3GFGYZ-GyXF3263m_GX_tJo8yJ2yPw2NWRFggXNPfQlg2EE
Message-ID: <CANn89iJ+VtuyB1tRLeNqVzx3ZpxEiusyfAJv855B90P2XcpDag@mail.gmail.com>
Subject: Re: [PATCH] net: dl2k: fix potential null deref in receive_packet()
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, yyyynoom@gmail.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 1:15=E2=80=AFPM Qasim Ijaz <qasdev00@gmail.com> wro=
te:
>
> If the pkt_len is less than the copy_thresh the netdev_alloc_skb_ip_align=
()
> is called to allocate an skbuff, on failure it can return NULL. Since
> there is no NULL check a NULL deref can occur when setting
> skb->protocol.
>
> Fix this by introducing a NULL check to handle allocation failure.
>
> Fixes: 89d71a66c40d ("net: Use netdev_alloc_skb_ip_align()")

This commit has not changed the behavior in case of memory alloc error.

> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  drivers/net/ethernet/dlink/dl2k.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dli=
nk/dl2k.c
> index d0ea92607870..22e9432adea0 100644
> --- a/drivers/net/ethernet/dlink/dl2k.c
> +++ b/drivers/net/ethernet/dlink/dl2k.c
> @@ -968,6 +968,11 @@ receive_packet (struct net_device *dev)
>                                                            np->rx_buf_sz,
>                                                            DMA_FROM_DEVIC=
E);
>                         }
> +
> +                       if (unlikely(!skb)) {
> +                               np->rx_ring[entry].fraginfo =3D 0;

Not sure how this was tested...

I think this would leak memory.

> +                               break;
> +                       }
>                         skb->protocol =3D eth_type_trans (skb, dev);
>  #if 0
>                         /* Checksum done by hw, but csum value unavailabl=
e. */
> --
> 2.39.5

