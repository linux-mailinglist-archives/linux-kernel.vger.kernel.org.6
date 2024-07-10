Return-Path: <linux-kernel+bounces-247987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F4792D707
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01E9B214E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D861C1946DE;
	Wed, 10 Jul 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TB1BeChD"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628234545
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631097; cv=none; b=s5Jbw9OlliusAVldKG2SWmc+jSQQOptYKcCAK9xkVMeG6hMyf0nj89Kn1PX3hvldbGL9qH3FqzU+eCGOn4PR36S3B/+gvu7Ju3HimKfat/Vn7Eb64iAqUkUUewLpQNUcU1unma0dtsiyeYubclAaHIPZYuNZfVumqbTCjspyxTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631097; c=relaxed/simple;
	bh=oq70z4/bCsrC1GoQvBoxOPOia/ExqElmdDJ/iZsXfL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vB5/AOmUrahvezV+cfiLr7R4VXV8oxg+qlmj7wqnPrkZ+hTL43vWvNciK3BEk8godIc44XzRSxFQAQdavca/x6BL78dYpEVGlSUSxjoK3gqWPYUaXCuxiOvNenVPBdGCBpHZdhLuQEXdQml/RdrFx7JV9eWaq1DG24Kqr4TwgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TB1BeChD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so266a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631094; x=1721235894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HGeZAs5GCO0/ogUU/V9u51auuYtWzKSV+J+gDPs5AQ=;
        b=TB1BeChDHW6vSnVRI/5kHSoCHullabm7gJQ8B/sVA71vlWgHTfigpyqjJ8WGjR4bgC
         y+Y+SsWXzDiCivYqRr1IfKBImgLQsUc4ew+xQk+Xjw8X0SO5mHQA+5y1C940Dd8hFL25
         eqtNo0BlH/H58pmNwi2b6ffDA8GNUIGW8c5TLCgi5S3D6z1gloUiAAJh+tNo/dTulMIr
         nnf/tWDEfbaDIlTF9Uul5n5sGJSt1su5lO9xdISDIODoc0+Va3WOcwuQ/UK9iI8pLm7t
         k64K0XjuGXp2c1n5YWr5lKJ9QxJI3HM7kB61aNljVpcNUofckiKgKbprRd8kGUsnFMGg
         3+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631094; x=1721235894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HGeZAs5GCO0/ogUU/V9u51auuYtWzKSV+J+gDPs5AQ=;
        b=CtOjjeIbRo02T/IWDBUh9wHH/hxTimw5EvmGW2b2smkUIrKrcIlJj0xivrq7I86RHr
         0nQ3nRHd+2RPeXe/2AyqZbLgcrlql3KBpKh6WPjKDdgW3AtpUCN7+9FFwIXRYORgxwOB
         MLsGD6Y5dd7F1J+GppjPMr7+G7igKCM9jWKUcSHn4ethZbcTCBcYoeuwsu1jWCpIrcIn
         7/KQwi+FV1FebCWx7rWONNHpYVO91FvTAPHnziSOkTY+HX9ih9DnD21B9yFBOOCu/Di0
         RHJtXmYVocrhLvqBEJ8AKKkCxK/wJurDXM2+F0CiQBLUTSNzzsnHHboMVMeDf7LkebmC
         kUJA==
X-Forwarded-Encrypted: i=1; AJvYcCVaFABxskVL5QatWpJfimqCkGy/bMvMGByNSzqCDRr5bma1vfsaQmUGnmFgX9CWpeE5ZrzRPQdLyxGDYAUZQVLs1LvZmy/C8MALQUoP
X-Gm-Message-State: AOJu0Yx83ByLfedvcbFSZ5gZKW/S4eCZdiv3zRgzmYTXaDdbAlhkzFNH
	DZKrTP7JHXroZqPN2JS4dNVYWUohntlA+iQkafqHeLFvhyoyJ5wcAFr3lU66g4ldGyuKaiZz0q4
	1/0wNvClSX8YlOiB8OKPUdGT0O3YkjLAQvlbQ
X-Google-Smtp-Source: AGHT+IFY/CNV/3qrOH0Lh/APA9kMWu5yookxnY4Qhb2zRpXDPgqdWc1JKzZnJgXLhNnDQvH3c7i3SF5iReQ6xkV6bXo=
X-Received: by 2002:a50:8716:0:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-596f914a15amr216846a12.5.1720631093774; Wed, 10 Jul 2024
 10:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709125433.4026177-1-leitao@debian.org> <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
 <Zo5uRR8tOswuMhq0@gmail.com>
In-Reply-To: <Zo5uRR8tOswuMhq0@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jul 2024 10:04:39 -0700
Message-ID: <CANn89iLssOFT2JDfjk9LYh8SVzWZv8tRGS_6ziTLcUTqvqTwYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device _properly_
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, keescook@chromium.org, horms@kernel.org, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:19=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Eric,
>
> On Tue, Jul 09, 2024 at 08:27:45AM -0700, Eric Dumazet wrote:
> > On Tue, Jul 9, 2024 at 5:54=E2=80=AFAM Breno Leitao <leitao@debian.org>=
 wrote:
>
> > > @@ -2596,7 +2599,7 @@ void dev_net_set(struct net_device *dev, struct=
 net *net)
> > >   */
> > >  static inline void *netdev_priv(const struct net_device *dev)
> > >  {
> > > -       return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_=
ALIGN);
> > > +       return (void *)dev->priv;
> >
> > Minor remark : the cast is not needed, but this is fine.
>
> In fact, the compiler is not very happy if I remove the cast:
>
>         ./include/linux/netdevice.h:2603:9: error: returning 'const u8[]'=
 (aka 'const unsigned char[]') from a function with result type 'void *' di=
scards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers=
]
>          2603 |         return dev->priv;
>               |                ^~~~~~~~~

This is because of the =E2=80=98const=E2=80=99 qualifier of the parameter.

This could be solved with _Generic() later, if we want to keep the
const qualifier.

