Return-Path: <linux-kernel+bounces-264844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32493E920
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C3A1C20F33
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 19:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF736F30B;
	Sun, 28 Jul 2024 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0BxHdmX"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0789053AC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722196530; cv=none; b=KZvVuuFDn3O6PNB3gLPLv3M3G8s8AYn4S46nqve7g6cX7HIxOEqgz8swpz8n4+CTKNQ88lO3pdsr928vZ/ocluvLBkZRU9Q2fwgcpKNhgVfj1/tWHKrUAeO1sGoJBOOhjLlooNdY/xkxNQxKJqCXjOzVzjr8EqUMzfoGxNYTKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722196530; c=relaxed/simple;
	bh=lSYebAIMD3JWlCWJQxtfucwqKYQHJfNyl5Vn3AEBQO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn4LFxXeNEnrv1Q+VreJTB9EQpd1uFKbQ8IrdqU3E4qlvyId5+LGlrImugw/68urgiEeB3Rq+FZjLjhNV6YkuEwzRAzY/3lGSXnpnydIB7WBfYzUFDZUIXnJV8zcc5B/km36x+2iW2/AniGKidluwKxhfTwN+I86guXoPezjxeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y0BxHdmX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso270191566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722196526; x=1722801326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bso3oc3/1moVUnYBS/9tcxc93Inl8H8ROTrw4KGIFu4=;
        b=Y0BxHdmXVOdfkPQG225Pny5Dic7xt3vswUjYSQnLc6WfQfpdfSKKhGR1xb5zhSqhyo
         plNsVXUXhd7K/EHVyMJObryjKAxzBsnQWgyOjeqYyden/4VUO0iRYzq/36RMi6y7H6t9
         g7GJLBvG1LJtGeu546ZarAopY79lTs28/eCc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722196526; x=1722801326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bso3oc3/1moVUnYBS/9tcxc93Inl8H8ROTrw4KGIFu4=;
        b=gVoi1K4eFIs0EBJHm5RXA+4Clf00udCiNOLaOe/JkZdyflRZlVz1YTY/BJyy0pGS2k
         mwN+vytvVM8Ifr2alqPFarmOZ2VKspqW2gkm1Gt8AeUP7wtUug9Nufrq58RDugnvaKXk
         PYd/+2NuZJqixNAG0bel+KSnVQnRmA/lj0E+YjkTXN6uJTiyKgCohc0ymYag1VSbq91J
         Xm9+G5Cl4ISeXH3xrsLLTG41gngRBw1Fv6rAZWyRTK/r7BhMaBSaoCoWMkMGzUVc3FnB
         5dY2MQ204gOLHO0qYvN3c1nMNmmQVuYiiSuXkk2tw4ynmKRpmkY6ZtiXeBJcKPUwRukT
         OPHQ==
X-Gm-Message-State: AOJu0Yx5/8kdxhjtoMFMK7TOSIltT0WhWkdYem6sxMgo31tiIaSa4GED
	ha6l3Pl5n8v9P6PZsRhe5LMbRWIXNoQOPVisBK2cmV6Ygk+TItxqq0F42o0dkjcnip2nbow0Rhg
	Vsy5/tg==
X-Google-Smtp-Source: AGHT+IEAWmJ5TXOl2UZ141s5Ewyhvw2iwDxM7v0c1R8iSI4Y6ZCFNLUqyjAvWU/jdgOkp0EkaI7aNQ==
X-Received: by 2002:a17:907:7e8f:b0:a7a:c812:36c5 with SMTP id a640c23a62f3a-a7d40179cc2mr350176066b.46.1722196526182;
        Sun, 28 Jul 2024 12:55:26 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41185sm422510466b.128.2024.07.28.12.55.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 12:55:24 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so4449066a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:55:24 -0700 (PDT)
X-Received: by 2002:a50:9318:0:b0:5a1:c43:82ca with SMTP id
 4fb4d7f45d1cf-5b021f0d87bmr2806527a12.26.1722196523942; Sun, 28 Jul 2024
 12:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
In-Reply-To: <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 28 Jul 2024 12:55:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
Message-ID: <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jul 2024 at 11:12, David Laight <David.Laight@aculab.com> wrote:
>
> Although min_t(type,x,y) should just be
>         type __x =3D x;
>         type __y =3D y;
>         __x < __y ? __x : __y;
> Absolutely no point doing anything else.

I tried it. Doesn't quite work:

  net/ipv4/proc.c: In function =E2=80=98snmp_seq_show_tcp_udp=E2=80=99:
  net/ipv4/proc.c:414:9: error: ISO C90 forbids variable length array
=E2=80=98buff=E2=80=99 [-Werror=3Dvla]
    414 |         unsigned long buff[TCPUDP_MIB_MAX];
        |         ^~~~~~~~

(and same issue repeated twice for IPv6).

Similar case here:

  drivers/gpu/drm/drm_color_mgmt.c: In function
=E2=80=98drm_plane_create_color_properties=E2=80=99:
  drivers/gpu/drm/drm_color_mgmt.c:535:16: error: ISO C90 forbids
variable length array =E2=80=98enum_list=E2=80=99 [-Werror=3Dvla]
    535 |         struct drm_prop_enum_list enum_list[max_t(int,
DRM_COLOR_ENCODING_MAX,
        |                ^~~~~~~~~~~~~~~~~~

and

  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function
=E2=80=98stmmac_dma_interrupt=E2=80=99:
  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2915:9: error: ISO
C90 forbids variable length array =E2=80=98status=E2=80=99 [-Werror=3Dvla]
   2915 |         int status[max_t(u32, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUE=
S)];
        |         ^~~

and several cases in drivers/md/dm-integrity.c.

I guess all of these could just be made to use MIN_T()/MAX_T instead.
We're not talking hundreds of cases, it seems to be just a small
handful.

Let me go check.

               Linus

