Return-Path: <linux-kernel+bounces-219478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1460F90D334
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055AC1C2137B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEB9156F39;
	Tue, 18 Jun 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fCphVX32"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C308146582
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717839; cv=none; b=NGsZqqE5Rd+/+ZRTJq9NNGTJmwy8KjXvJ3ImZwZrNiyIttqWJC0nik6JCkeYlK1loXhLyHSsyZABtBUfMngyRQ27ikeca30zxSrOMO2hYvbnRrd0RoHxsvylPNY2tkVwH/4OS6CsP1rkwE+q87AOuzD5QqhcW17XthTwvXxN5Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717839; c=relaxed/simple;
	bh=qym/wY0UPU4absR0iVFdNfA3zkG6d6gBXHOC9jSdadQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noMDJHr8jzGTYdncK8H4ndsCD33Z4Lr3EV7ceaYHarqO0PCKj98CQ3ZshILlMAOQZtOVYAVrljayAW8X9AklAC50PEx4oayGlrxD3ZfuCLLMGJkoJs+T3HX35N+mpcj46K4hkC9CweaX7fxfU22e6hKZ/5DHXRJt58imREkM2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fCphVX32; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso2613555eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718717836; x=1719322636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQlUnRddyv5Ix+rCUJ5MBByRljWGE0pbXOEFTO2x3Ug=;
        b=fCphVX32WuUwVFFf8x89CC1M2KJK29scvoCMEMHhGaWkLgOUokdlmJQrBhKMQ6tvKl
         HtioaTAyYIbUDZsXi3GZlfeMKCr7npR73CZa1/fvS6WtgHsoNOyyH2ZdGZOLPLwA7tc9
         k0UnUIDvTWYZtD/0LageU0e745DmEu8UoyDeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717836; x=1719322636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQlUnRddyv5Ix+rCUJ5MBByRljWGE0pbXOEFTO2x3Ug=;
        b=wwOUdPdj2xWFW/a/TavSkmbLF0G37xJm5ug661mvsblB4jzpgMPcZ/Ms1dMuKKYUzl
         IEtA0sXkXAnzLnr9pRiM8MyVWLNtEffiMNT/8VT9hv5iJS22QSqIxi3A3QcB6ptHiAG4
         8hh3XKDmPvTnAwEr42jpzpxG0KDTibSLjDH/vpOm03Tj/QvoL3ifIuw6scy+WImjrl9B
         4v4MXsyiofY1vizBYx+altgk3nXFRQstUdzYjg2ecr/escb74wKHc27N3K10b4kATP9C
         JAnt9h83bGaToKKbeSt8M9lYiXuo8WHr7Z9C20DkX8OfnJfzlkQ2FtZSfPXL208n2FMe
         ayaw==
X-Forwarded-Encrypted: i=1; AJvYcCV7f9lyMLMkq3u8j2KUJT593IH0mPXBYoHl2bVWrIlYT9oULWIfzxBaXfBsYGnsHjhp3bPiI13firGL4ba4TfmlLkQxdusILj0CvZtt
X-Gm-Message-State: AOJu0YyynHeI1rXYI6jVpBhKJ2VCi2ISn9rwZYehAMezbT7JymA7LInQ
	tqIoEA+3/3N1nCA8c+4boHjjfkaMCeolFpfT2xaKQx3yd1k/qDaCaZ+VFzKpt0xK5PXk9J5om8k
	=
X-Google-Smtp-Source: AGHT+IEvDR4V6piQsZ26/TPPwvopJe5jzZfSUEAiDrPd7mT4+E9oC5Oj3ukjvFrqrCyhoSFijUj9Zw==
X-Received: by 2002:a05:6870:b488:b0:254:b3cc:a6da with SMTP id 586e51a60fabf-2584297b83emr13685122fac.29.1718717835943;
        Tue, 18 Jun 2024 06:37:15 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe2773dsm524217085a.99.2024.06.18.06.37.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:37:15 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44056f72257so356361cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:37:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFgXct6EkfHmWGD83o4K0ElsIy+/Lhg1yVqWO3xhvAdYfWKUBS//CtNl+9tCP0EwIuoMxUdpWJvZ0JTO3TGN7SpSiCX5IOtauoFqlP
X-Received: by 2002:ac8:7d0b:0:b0:442:1504:c264 with SMTP id
 d75a77b69052e-4449dca56b6mr3233511cf.23.1718717834474; Tue, 18 Jun 2024
 06:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615093758.65431-1-tejasvipin76@gmail.com>
 <CAD=FV=XRZKL_ppjUKDK61fQkWhHiQCJLfmVBS7wSo4sUux2g8Q@mail.gmail.com> <aa757abb-9883-4a46-a5e1-a7d4d5b044eb@gmail.com>
In-Reply-To: <aa757abb-9883-4a46-a5e1-a7d4d5b044eb@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 06:36:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XX-_YA6ZjiwfqttL5y4i+QRLJn=BQUM2ugSa8HNkEUtg@mail.gmail.com>
Message-ID: <CAD=FV=XX-_YA6ZjiwfqttL5y4i+QRLJn=BQUM2ugSa8HNkEUtg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2024 at 5:25=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> >>         rm692e5_reset(ctx);
> >>
> >> -       ret =3D rm692e5_on(ctx);
> >> -       if (ret < 0) {
> >> -               dev_err(dev, "Failed to initialize panel: %d\n", ret);
> >> +       dsi_ctx.accum_err =3D rm692e5_on(ctx);
> >> +       if (dsi_ctx.accum_err) {
> >> +               dev_err(dev, "Failed to initialize panel: %d\n", dsi_c=
tx.accum_err);
> >
> > I'd probably change rm692e5_on() to take the "dsi_ctx" as a parameter
> > and then you don't need to declare a new one there.
> >
> > ...also, you don't need to add an error message since rm692e5_on()
> > will have already printed one (since the "multi" style functions
> > always print error messages for you).
>
> I'm guessing that the change about regulator_bulk_enable and
> rm692e5 should also be applied to all the other panels where
> similar behavior occurs?

Yeah, I'd say so.


> >>                 gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> >>                 regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx-=
>supplies);
> >> -               return ret;
> >> +               return dsi_ctx.accum_err;
> >
> > Not new for your patch, but it seems odd that we don't do this error
> > handling (re-assert reset and disable the regulator) for errors later
> > in the function. Shouldn't it do that? It feels like the error
> > handling should be in an "err" label and we should end up doing that
> > any time we return an error code... What do you think?
>
> Personally I don't think this is necessary because imo labels
> only get useful when there's a couple of them and/or they're
> jumped to multiple times. I don't think either would happen in
> this particular function. But I guess if you have some convention
> in mind, then it could be done?

I think mostly my suggestion was just that we should also do the
gpiod_set_value_cansleep() and regulator_bulk_disable() at the end of
rm692e5_prepare() if `dsi_ctx.accum_err` is non-zero. Then you've got
two places doing the same thing: here and at the end of the function.

...oh, but everything below here is already a no-op if the error is
set. ...so I guess looking at it closer, my suggestion wouldn't be a
"goto" but would instead be to just move the gpio/regulator call to
the end. What do you think?

-Doug

