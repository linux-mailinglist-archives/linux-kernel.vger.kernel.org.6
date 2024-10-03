Return-Path: <linux-kernel+bounces-349121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC6298F149
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F9C280CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216619E971;
	Thu,  3 Oct 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGFV9pzP"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B11865EB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965270; cv=none; b=Vh7KftW0YJ1xHbxzeHvWgqtQf+h6oD9tgAByFrr2w3OnynqgmPntwzuHHsNyM4q5+KsUiCNnQHWn7D//E2iVfDZQTyyRRbzDMOG4OR/uQfTm7nBNXAyBkClXga/BW7jLXHUfOjml6+zRaz/fa8NlSo7pglk5JJMYRo28Op6fB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965270; c=relaxed/simple;
	bh=476ImO6OCFxdTzcjdPBg5DCCYjfCpnail5AkiuIHIiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vtlmwl0uGa0lxp0C0yo4LPIZGFV8dOmbDexhF4Skl7Sze+Ozue7pBnUnO3MoICodGN25GjYahfOSz7UDhdAup4PFXSBncDpo38cI53Z7LdPlXv2JCcKYjV4uNbgoD5DMoJ/q/Ya7eStIpTmN//4sJj5k+RacN92Rv4zIzboFDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BGFV9pzP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2facf00b0c7so19452931fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727965266; x=1728570066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+PbIVzPmTFgo+wem8zP/ILMMROawRmR6s8VsxpDs5g=;
        b=BGFV9pzP1Q0m/VTT7beqE0+dAkKPE5OBZVhTeDrw5GunEGXH/d0I1lWQQ24ewASlUR
         RWbQYMLeqJbmM39UjtxRbjTkuiKoXNk0c1ZYQFmuHeTMRQRUfK8gX3Aa90dMQ3ER71o6
         ubH/Or559FGC0GwbsuY9MUsbvrTQfeMDdwhs6nVQI9J8TOtW6RPBkHA1e1qJ2uMjv6NK
         VWddWC9B/4b3nVT3obfP0IbwlHJNIueroLFkcjsZ89js4dBBL+qULsEfNdW9Bkveijkq
         TlHq4irpj8RbAZJ/jn18qB7z1z4sBv9o0swonX14022CQftRzBaPwyvCs6I/Skka9vYK
         Fm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965266; x=1728570066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+PbIVzPmTFgo+wem8zP/ILMMROawRmR6s8VsxpDs5g=;
        b=dQdY8OUjx2U+myg4xGbaIVIy73L0h2a1QDCEk2GAu+Z1S2dnOaqL/CMOy4++Y4n1th
         p+a/4O/tVeNwISZJAa3hRnIhNTowI9GYsZ8JhTMZgnT0ZC869TBFcMCPT+xAS+HlPjiy
         YKnDA6DIYwxe07zJUtv0i2Fmmo+ZSU1fKG9VbG8o4dA8JdWlCJVGxs6UpQPOhCKmxXwb
         MscKRj7bN+PrkXxn1eZDZbwZx1zfU7773SGAvbDEZpNvgC0Ndy7PcgGqCuwMCh0twfeV
         ToN8BwspjWeIkErLX4cH4KpuZNpK8o996tFSAQhcQi+78QbEeKizJjR/GHbQjSOoLPzH
         TU/w==
X-Forwarded-Encrypted: i=1; AJvYcCX03/yhb3L6LoQrrebjCGdUjxDhaTegnAu5OUg9+UZNGbuZ0F3Nkj5YpY6W864imPCwE7S1p+i6YYPvFnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe46N2zXeGvsHuVrCSDcqDjdN4NdAUkaqatU69SjuncNZBLisL
	OWtB8NPLsyaXthPb3xbD7SrCJvp8RHSdIKWp3t5gxMw5EJX0IY51hodR3ZP7Z8V62+cISAHKpYk
	G01GjAXU/xCBPMYp7+U2R1IZxbLWINvUi5wVQ5A==
X-Google-Smtp-Source: AGHT+IE3TeGGZwQsdoDdBAe93x0WsfMkV6m4NMdQ1UVnCLUym3gG0AImGTyOg4Hvw8XHR/yI1atm6MbsKMmVLOEKeck=
X-Received: by 2002:a05:651c:1508:b0:2fa:d464:32d3 with SMTP id
 38308e7fff4ca-2faea267974mr11541841fa.20.1727965266490; Thu, 03 Oct 2024
 07:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410020735.aBI61ZYn-lkp@intel.com> <Zv0S3wXOzgmyFP3x@google.com>
 <CACRpkdZmKfNWF7ciHJMi4JU+_JnxjWD_kMhfxFOeydQ11Vyc4Q@mail.gmail.com> <Zv6EwdDybm_I0QSh@google.com>
In-Reply-To: <Zv6EwdDybm_I0QSh@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 3 Oct 2024 16:20:54 +0200
Message-ID: <CACRpkdbtNdE2-dvSgfy+nwHommLUVxn7gjpS9pkvSABMupkh-w@mail.gmail.com>
Subject: Re: drivers/input/touchscreen/cyttsp_i2c.c:47:18: error: implicit
 declaration of function 'i2c_transfer'
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 1:49=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Oct 02, 2024 at 03:37:56PM +0200, Linus Walleij wrote:
> > On Wed, Oct 2, 2024 at 11:31=E2=80=AFAM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >
> > > >    drivers/input/touchscreen/cyttsp_i2c.c:118:26: warning: 'cyttsp_=
i2c_driver' defined but not used [-Wunused-variable]
> > > >      118 | static struct i2c_driver cyttsp_i2c_driver =3D {
> > > >          |                          ^~~~~~~~~~~~~~~~~
> > > >    cc1: some warnings being treated as errors
> > > >
> > >
> > > This is really weird: cyttsp_i2c.h includes linux/i2c.h, it has
> > > dependency in Kconfig on I2C and CONFIG_I2C is present in the .config
> > > referenced above, so all the declarations should be there.
> >
> > I usually ask Arnd about all kind of Kconfig business when
> > things get weird.
> >
> > But could it be one of these awful things:
> >
> > config TOUCHSCREEN_CYTTSP_I2C
> >         tristate "support I2C bus connection"
> > -        depends on TOUCHSCREEN_CYTTSP_CORE && I2C
> > +       depends on TOUCHSCREEN_CYTTSP_CORE && (I2C=3Dy ||
> > I2C=3DTOUCHSCREEN_CYTTSP_CORE)
> >
> > Since I2C is tristate it could be a module and then this touchscreen
> > has to be a module too.
>
> "depends" should handle this and force touchscreen be a module if I2C is
> a module. Also in the provided config I2C is built-in...

Hm yeah I'm lost too :/

Linus

