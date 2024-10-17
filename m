Return-Path: <linux-kernel+bounces-369098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5A19A18E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2F31C2160D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82B7D3F4;
	Thu, 17 Oct 2024 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="o54veFtX"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBA54F8C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133675; cv=none; b=nBGLPy+/a9m4gMSPxViXxb9PzUH1tKNHeHHofsHzeXF/pWe0oQ98esIAa+AZq9clmMNtaaauFVJ3So+zgTjM8bvIF8BEy5cq/unqD4OhEmY8hA7tfF2PeJACvW2f/hF3sglfT/TaSWVqtW98o5efeSJyRWZrNoATriAatoermHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133675; c=relaxed/simple;
	bh=QOxGn6HUGUC7agxtcrT7HyZI+wUqBau396XTdEeY4VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW/uf4JNr+tcXAv1grP719DZZ37tqTncfjh56I4JVo6N6MP9cZqjfYUZqTdbjpdzVgUPvvNXz1BhFjeTFCI2/jA1OM2wPGfbiL8whSSvi7Ge96s0Qr5fQ66OhzXoSKdffcQgI8lEZylIfF5rdITeorjgQiE/v1j/CjP969eoV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=o54veFtX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso822736a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729133669; x=1729738469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLxmOw/KJpTCPuMZfngsa+JDKUmVUuEwD65qtQ7UoWU=;
        b=o54veFtXNeC2tYD9KaP1Uqs1RfCVyOGJGFwl0Df4MMt9K6nxCilET2f4X3j6QUE1so
         uirs3k/XbilyLhpTIySYwbFHb4LAxxZA1SUFH3G/A7rx968X24ix4R0cTHnrdZyICFz4
         8AnnasaGqreBP67KV6Vc8SlA6tTyEh+zU6DwPw5MOaqBHIHYRouz/zv2qQoacLPJqfeA
         78qalM3LkIAhJ/GUUzzT5l1JYe9F654Qj3siUr65HryxKXN0+63jSmkI8BltBDQYMUJG
         lqljGEcHhd/fas4eWnSf1mimmwFsSJ8tJA98s21ELC9Wcn+l6ijf7wmjDa3M6BoAB3oG
         Y0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133669; x=1729738469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLxmOw/KJpTCPuMZfngsa+JDKUmVUuEwD65qtQ7UoWU=;
        b=lrIvYs9LE/g2AM+AbPH0SCEZAPGM8Ls6hgAvndmevXNrRJ3FfpEobVi83DcX4Yenwd
         gBRZFTG/IgQorP/tvV4XBkIZOKZdTRIgT0ZDl4Wrz78FoN5zcH9l1xATBQALHa56H32q
         JL5pOKhuUp2edwgBK/ioZcWDgykXAVs1AsmlToMFzbPBJLgh7onBf4+UWRrSH7wu+pjA
         tlvbTvRNHwOdf/mhvbaAYCpS8OJERFn6NRu6Lb/6Sa9CWrdVKEEBqXOaAJtokH9QQLxO
         M+ubsrmscGk9BTwxFr5uCiVnFwI1wDhwqhhgKY2xG3zliWTKVMWmilnViVWJWWdlJLKM
         Fs2A==
X-Forwarded-Encrypted: i=1; AJvYcCWyct4BgT1irAwVTv3HTFlbA26fQNGen8OB5g8yA/ICiGKEZ6F1seOb665ZnLlVUgqzQeeosOJWzgSIdJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYr4Md7R+OEeHDtC3gmmSNYWqQXwgdgQSJ/Ibwp7At9bqUMjGk
	ruPMxKd6G2lmEjPqlnhMkUZEzUU0zdPiSIm+BvFWPanpvlhBYpsEW52PCnePA7EspZs7MbG9+wA
	FgOX3W+IhboyCovHKfDRwt16G7/ZOxCBKmWXzDA==
X-Google-Smtp-Source: AGHT+IHJr0xtyYJ73R4TB29Xaxtuba8FwbpRz+j+A4yiemcdfoXx5LoOn1+I+zgJ2gBD6GfkFXcv7FUmqsgjZ2m9e3Q=
X-Received: by 2002:a05:6402:1e8a:b0:5c8:957a:b1e2 with SMTP id
 4fb4d7f45d1cf-5c948adff84mr13751317a12.0.1729133669244; Wed, 16 Oct 2024
 19:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016134223.4079-1-everestkc@everestkc.com.np> <2f82fbcb-4a3c-4dfe-8852-7fc0b27c38e4@linuxfoundation.org>
In-Reply-To: <2f82fbcb-4a3c-4dfe-8852-7fc0b27c38e4@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 16 Oct 2024 20:54:17 -0600
Message-ID: <CAEO-vhFkT6RwR6h7KRD0YyQphhuqm0d53xj7xp7r3gco+DxwHg@mail.gmail.com>
Subject: Re: [PATCH][next] pinctrl: th1520: Dereference pointer only after
 NULL check
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, 
	linus.walleij@linaro.org, linux-riscv@lists.infradead.org, 
	linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 3:00=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/16/24 07:42, Everest K.C. wrote:
> > The pointer `func` is dereferenced before NULL check.
> > Move the dereference after the NULL check.
>
> Change log looks fine.
>
> Short log that clearly says it is a fix would be better:
>
> Fix potential null pointer defereference
>
> >
> > This issue was reported by Coverity Scan.
> > Report:
> > CID 1600802: (#1 of 1): Dereference before null check
> > (REVERSE_INULL)
> > check_after_deref: Null-checking func suggests that it
> > may be null, but it has already been dereferenced on all
> > paths leading to the check.
> >
> > Fixes: 1fc30cd92770 ("pinctrl: th1520: Factor out casts")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> >   drivers/pinctrl/pinctrl-th1520.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl=
-th1520.c
> > index 7474d8da32f9..07f8b51fb294 100644
> > --- a/drivers/pinctrl/pinctrl-th1520.c
> > +++ b/drivers/pinctrl/pinctrl-th1520.c
> > @@ -803,11 +803,13 @@ static int th1520_pinmux_set_mux(struct pinctrl_d=
ev *pctldev,
> >   {
> >       struct th1520_pinctrl *thp =3D pinctrl_dev_get_drvdata(pctldev);
> >       const struct function_desc *func =3D pinmux_generic_get_function(=
pctldev, fsel);
> > -     enum th1520_muxtype muxtype =3D (uintptr_t)func->data;
> > +     enum th1520_muxtype muxtype;
> >
> >       if (!func)
> >               return -EINVAL;
> >
> > +     muxtype =3D (uintptr_t)func->data;
> > +
> >       return th1520_pinmux_set(thp, thp->desc.pins[gsel].number,
> >                                th1520_pad_muxdata(thp->desc.pins[gsel].=
drv_data),
> >                                muxtype);
>
> Otherwise looks good to me. With the change to short log:
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
The patch sent by another patch submitter has already been
applied for this issue.
https://lore.kernel.org/all/20241016155655.334518-1-colin.i.king@gmail.com/
> thanks,
> -- Shuah
>
Thanks,
Everest K.C.

