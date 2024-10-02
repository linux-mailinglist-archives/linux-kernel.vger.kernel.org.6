Return-Path: <linux-kernel+bounces-347043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B8E98CCF8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094862845C3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BF839EB;
	Wed,  2 Oct 2024 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E6uZ25Pa"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD680C0C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727849543; cv=none; b=lgXrburghIeYnX93Y4D8E8OtdGMSxBoOBF0BpOFxAnZImuOLYo/kOxDyMWyCZFX8mbsi1/ysqPFU99UDPyjorpQuHgrlpO68RQfpP54p/RitZ88NnwQHRLiRBraWrcGqH0dpwsradPgwuqrfXFRnpoLtXnzxovvuLJtaVYbuuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727849543; c=relaxed/simple;
	bh=RhOoeaZh3e8vBWulpT0PgaErB99mR/wewa1QzAAq4UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBcbR56c6gcz3Ifs/c+cfO6fjeCkigiNaFL3YGo9FYYR8CFL17VxUU2JnAMJ2U9Ldo2L2DDLjj8tulRO9O3RAWgaWfHEcgLKCb8CN0mCqUAOlW4XpdCy1A+cfFfe5Ls0DfYEmFtDd0jD+4BliGinnBhbdBe4LoM8SqQoaMHxuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E6uZ25Pa; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50958a19485so1049383e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727849540; x=1728454340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gRVw9Ao8S14vAD7Qrx9bOM+QzpUrQ9B4bjieXKmtSw=;
        b=E6uZ25Pai6Q/5WapihzqIaou46fLWzciCmn/tLBb1+Q2GcL8uq2L38t7vFWA8FhuTB
         zNFrRR35/mJ4xhEDYeWRAH3OaUMNBDQTiKzBdPxBjpvlWVtbxLsa2KntY2wF1+d55mC2
         Vxe0fQCj/zqQcBWRmV2ctv+ziT/HPC5izrmn5FAhqh9MSZi86hYYQ3X0ik5TQNtvorMO
         HzawzfrYjQSrPOxuZWzxYhUktvnhiHEBD+EdqS12s63M9xmsiYHZDWk7X1ia7aozBZgR
         kE10fYO5TrygbCKv/y0oHvBUR3yP0zW4dCGAl5pp1ne3f2skz8Y6Wm3diHANQcryQcuU
         Uuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727849540; x=1728454340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gRVw9Ao8S14vAD7Qrx9bOM+QzpUrQ9B4bjieXKmtSw=;
        b=WsHNOf47jyYS/zo5z592urSvYzVMLNzduBNjChM+XAonlZD3QkmbGHlxmxM4LijbTA
         uFTM/h4gi3oxepUSRJHGqrFp6eeDIgO45d3S/gMqaavfQx+wk2AoInWl6aXQ7iN94s8F
         BjRJ0uLAMs769ypoJCqSBsIi6DjT6MMFaW1gIaARfu2SM1r5HUVDl4n67VwMHOngg9Nz
         tALSHoh7pabbZN+85RuWNR4z5H7hL8PETix4P6KQxoyOq6E/T6TstGhYLHRHgBkEGlVt
         KhJfLFcRyMJCK5+PHaQ7N4Cx+EiNfMkeanZYlKjFPQe0CP/5fjAYkwiniXAZJoYaIrGN
         9stw==
X-Forwarded-Encrypted: i=1; AJvYcCW1TyX6aKzE4EPwjdTokn507Co/gX+g+bh5PTiySUUoncM+HT+S/D+QqI9XO0QpO0J5bFZMmdMwtH0wSbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63gf3YESdIvrzXUWCoftwYrmlYxf/1xpXjYceC0aOkfTIbeqE
	9sHos5+A15wzA6ckO8KbeT6lJYeekqM6J+TeV0kj4aOVzJ9PgbQQVZivkjYeRjf+7ZXVhX/zZzs
	gYx6D4LM9KFwlyHHRWtlwmDgG8V8EgC5upmXTaw==
X-Google-Smtp-Source: AGHT+IGpXewdAmbQUykzuhwaPWwvc9LPCK98znOg4oLTVt2j6A6L18Ea2PLMy1Y2wiOxthZ5LEvC6zFqOahIgMkLvKc=
X-Received: by 2002:a05:6122:20a6:b0:50a:36ab:c788 with SMTP id
 71dfb90a1353d-50c58133bdamr2071541e0c.3.1727849539934; Tue, 01 Oct 2024
 23:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919130444.2100447-1-aardelean@baylibre.com>
 <20240919130444.2100447-9-aardelean@baylibre.com> <CA+GgBR_kKYOgPUHM5-LUAZboy6nab1tLvC4TFtzpqkjP+5A8wg@mail.gmail.com>
 <047034ae-135b-4ce9-a407-9b2a00841324@baylibre.com> <20241001194114.16e0ffa5@jic23-huawei>
In-Reply-To: <20241001194114.16e0ffa5@jic23-huawei>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 2 Oct 2024 09:12:09 +0300
Message-ID: <CA+GgBR_HTwNT6WKdweuuTZ_t+ZmMXrMkYNK+b3pp4f2MmTWzGw@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 9:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Tue, 1 Oct 2024 08:42:23 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 10/1/24 3:26 AM, Alexandru Ardelean wrote:
> > > On Thu, Sep 19, 2024 at 4:05=E2=80=AFPM Alexandru Ardelean
> > > <aardelean@baylibre.com> wrote:
> > >>
> >
> > ...
> >
> > >> @@ -153,7 +349,19 @@ static int ad7606_scan_direct(struct iio_dev *i=
ndio_dev, unsigned int ch,
> > >>         if (ret)
> > >>                 goto error_ret;
> > >>
> > >> -       *val =3D sign_extend32(st->data[ch], 15);
> > >> +       chan =3D &indio_dev->channels[ch + 1];
> > >> +       if (chan->scan_type.sign =3D=3D 'u') {
> > >> +               if (storagebits > 16)
> > >> +                       *val =3D st->data.buf32[ch];
> > >> +               else
> > >> +                       *val =3D st->data.buf16[ch];
> > >> +               return 0;
> > >
> > > Arrggh...
> > > I messed up here.
> > > Guillaume found a bug here, where this should be "goto error_ret" or
> > > do an "if ()  {} else {}"
> > > How should we do it here?
> if / else. Goto an error label when it's not an error would be horrible!
> > >
> > > Do we send a fix-patch or send a new series?
> > >
> >
> > Since this patch is already applied, just follow up with another
> > patch with a Fixes: tag.
>
> I sometimes tweak these sort of things if I haven't pushed out
> as togreg yet (or they are really bad!) but in this case I'm not
> 100% sure what the comment is, so I'll just apply a fix on top.
>
> So David is entirely correct in general but by luck of timing
> this time I'll tweak it.
>
> Please check the result in iio.git/testing
> I'll hold off pushing that out as togreg until at least end of
> tomorrow.  One more day o

The "return 0" needs to be removed in the driver.

        if (chan->scan_type.sign =3D=3D 'u') {
                if (storagebits > 16)
                        *val =3D st->data.buf32[ch];
                else
                        *val =3D st->data.buf16[ch];
-                return 0;
        } else {
                if (storagebits > 16)
                        *val =3D sign_extend32(st->data.buf32[ch], 17);
                else
                        *val =3D sign_extend32(st->data.buf16[ch], 15);
        }



>
> Jonathan
>
>
> >
> >
> >
>

