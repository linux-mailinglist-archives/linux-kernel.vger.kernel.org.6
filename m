Return-Path: <linux-kernel+bounces-199136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC58D82D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A125B21B79
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6B12C482;
	Mon,  3 Jun 2024 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL1QWV2I"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36896286A6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419153; cv=none; b=o8kYOjY9hjMP7T4z+9nAX4Tu1zJQkln68DS2cNKPhW02dP1W6Jkt2/MT70Lj4Z66A97QvbQ6E1Pg/cwOorhV/zbbS7sRj1mB/G5BQVF9mMv6sagtFlrAFsnTaVcBReq7celk6jLN8pxSR93brugeaVt4ibix6/G3IAUBf1RI47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419153; c=relaxed/simple;
	bh=JadfoHdtygKM61WU7kYRFYh3wqb4hbUSntCtUEQugPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1RwD6aXKzCnjvEbWpsRzgBbm03WRUmsij5tArByOMA/tSpXEvAH+58ZgWBaZKQbloD6sJ31AN6gpZyl9DGPolcnAwy1JY1OE94h4VnTp94PmbIXalesfNdisbWk3apmWHAu3erDazUlCRkhZwNdyPBCk/8PgzJE9W+My3GCoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL1QWV2I; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68ee841138so158193966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717419150; x=1718023950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JadfoHdtygKM61WU7kYRFYh3wqb4hbUSntCtUEQugPM=;
        b=HL1QWV2I3Zn80z8vfxR5iVwLi2g097ZSkz2N8Zm2i1hI1zbMhA/sC4XaqYRCuSRGzm
         HmVhLZDvZU94iL7Dv7fg38UeUtGpaGktLDBrkEEqnpIvfY/hAg6KhMep1/EoSUzUXSfd
         YXGnv42W/wnDeYzLZmPTG03XXC+/t0G5h5OgpBaTqv1SVpsrcAXg04owWhTvKCQA0B47
         1t6CvR/s82zZki/b1AdS5OMAC1ja/DSNryN3F3h0jCPlkyhdggJ0zIaQBQSVgK307f25
         97R8QGvlmpWPrsGewbstN9j/3KKozb0GZvjadwPZZgln96mm6mdIZLKvbMg6BfBupQD/
         LH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419150; x=1718023950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JadfoHdtygKM61WU7kYRFYh3wqb4hbUSntCtUEQugPM=;
        b=rvNhKxbFzm1+xdfYWhLnUrnl2LseLYjAZwEu809TdZyjK0HabtmDRGGzXmuQVSb3hW
         +lBx8OGZZ0dF5UH/rwiTI6P2ES9DdIwIZ2SIvGmgHFFO+XwkWHvohVwksRlsR6tLxcrz
         9mdyVFMzI9rNv2cAX+mbUJcgNwvr1ZOxCx2M1frh2XyH1UfoQuJPpl3NgD15evONfHPh
         wQvY0T2tu6V9ZjI7S/dTG5NymjlHL5UdmZfQiRvLhq+QwjGHDDQYYykm48bElI5o6QkM
         bJhegpZSTB5ijqXM0p5OR+I26PsWi1XnVwFGos0a/tmPhvqtP592igDBfx7RlSN2mIO2
         gxng==
X-Forwarded-Encrypted: i=1; AJvYcCXceDW0pu+XjmFK2H6K290tdEOHh2Hu5/rbE1kooTQFfsuRdS35VbbCkrDSKJ1oZ8PYwN4ZK8YMsgqGoisxFQWhJrnb53QcteYFRdiQ
X-Gm-Message-State: AOJu0YzVpwdr2PVFtl7kzD1Olh3M8JQn05kyQVaYLd6iYwJbF1mM38dJ
	fSTaY8R9QRrFSIievJlJpvH9Whdqs15yns+VQzQgd+Nlv7q5D6aBgeToRXFF40UV66dI8VVQR8x
	CRTOWxxYKxNbsJW3aHOl31rFQd8Y=
X-Google-Smtp-Source: AGHT+IH+hFOoB5n9mksl1sTJcqgRo5z8ZFztQ7reoKx7ztNpC8OUPWrAL4RoN66lVacXrfm8Whe41NrkKqRo2+hvnNw=
X-Received: by 2002:a17:907:516:b0:a59:b88c:2b2a with SMTP id
 a640c23a62f3a-a6821b71cdemr466092666b.50.1717419150212; Mon, 03 Jun 2024
 05:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net> <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
 <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
 <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>
 <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz> <20240603121853.GA19897@nvidia.com>
In-Reply-To: <20240603121853.GA19897@nvidia.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 3 Jun 2024 14:52:18 +0200
Message-ID: <CAGudoHEe=AiRpkyLJTZzU8MtiGC86Kivbyi1xF-Hh0hGJKWhCg@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>, 
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org, 
	danny@kdrag0n.dev, mic@digikod.net, linux-kernel@vger.kernel.org, 
	joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:18=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Sun, Jun 02, 2024 at 05:30:51PM +0200, Mateusz Guzik wrote:
>
> > As is I think the config mostly gets in the way and most people have a
> > setup which does not use it (for example my vim does not). Alternativel=
y
> > maye it is neovim which is overzalous here and other editors don't trea=
t
> > the entire file. If there is a way to convince the thing to only tend t=
o
> > whitespace issues in edited lines that would be great.
>
> Yes, I think that is quite overzealous, I'd view it as a vim issue.
>

I don't know about vim specifically, it was neovim here, for the record.

Anyhow I put on latex gloves and typed in "apt install emacs", added
the plugin as documented on github
(https://github.com/editorconfig/editorconfig-emacs + entries to
.emacs.d/init.el) and got precisely the same behavior.

There is no way I'm trying to other editors.

At this point I suspect this *is* the intended behavior and other
people don't run into it because their editor does not look at
.editorconfig to begin with.

Note my vim does not either, I only ran into it after experimenting with ne=
ovim.

--=20
Mateusz Guzik <mjguzik gmail.com>

