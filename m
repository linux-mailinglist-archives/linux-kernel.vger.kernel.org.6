Return-Path: <linux-kernel+bounces-385293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752B9B3528
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB531F224F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C91DE4C6;
	Mon, 28 Oct 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DFT+zkFD"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D721DE3D8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130193; cv=none; b=EelV+3qXOHyKouhqJBkdVariNMXIXow9+0yhiZXPFP70EYtdq4Ug9L0PH9TNAqNHZjBSm6A/4zmSnh6DDi5bgJOVcM4mrF4tsux5j0wtvhVtpcPswnxiWXXFpdIXjzm/d1xKOhNZsJrQ5LTNp9jIt1SGOBQ+KuUBYhprZ+E06vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130193; c=relaxed/simple;
	bh=XVo/3bwi+PIOaKUXsNSyar2v36pwhDUCgR7r4pY4lo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkXPM0J/cHQpvTzsHw6sRI18Oib/+sdqPFnr6xQN3H4xkFqoIgv7OHm1JzLrLCQstapItkAL/i6uHczQv/KDL0MsnGkjAknJi0eVPTrc5R/BhtCOwA+pLL93s69m+HfOT4VzldvEEn8vrTf2CXYFUHi5ExM2wO68gQN3q7t4h3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DFT+zkFD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so44505751fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730130188; x=1730734988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/+Fm3T4pn4crwgwgU+f7W2PGkdCB3Gmk2ieoRtXcSM=;
        b=DFT+zkFDNiTDjHxmvz9FT/kJ0fFG4DDowh8ta4HP0FFrWiYgUwfJLymYae5r6JliUF
         PUU5nSg+hi2U0f4DasJStpZ0ultXXqJdPoMgDGX1zVa9rw3HBMAZhJk6wpzC/n/cb279
         9VDfsnw+CmrdsuoMGBZAgTurImuujMHm7qRoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130188; x=1730734988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/+Fm3T4pn4crwgwgU+f7W2PGkdCB3Gmk2ieoRtXcSM=;
        b=ZQAquhdlDdq6dCVcTlIBZ1pdqj4Mh5+y3cIA4YQr4tQrXLsYNpykeT5LjWk2/xpUb/
         2nvPVy0Y1DbHG5OkehNNRv+mkEzWHiSg7fWrS2kdWi9MMoSqXf6L99xkCtJJyj39pS7q
         ALgW2+9SEGPEOwsrxB6sHPnYuQ6tlY0dRt9GMJT+6EXUNk1FuLUdHeSeYvFF5iqNXFBa
         JJxO0gMzxPwipnRBhxJaAZVUX6DbZ1m1QJWlrR6qPdWOgWhrqW4nL53FNkgsLLvMdMRX
         5r3/noOI95zwvPSXcpp/llQ3NGL+0QKxwDYK9OaSOFWMwukLQ/fSFhA3hWdvML/ugaih
         838g==
X-Forwarded-Encrypted: i=1; AJvYcCUrF0YX46SdjF1FBrfQJyIa3gx7PZ5TT/+xp/aR7U4tq7oQ9wWEA49E8wJSQ0XZ1FyPrJfpMcFSy90V72I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIiMXrL+aEovFVeealp/9mJXqPXiP/f59K8+0QcHF2OPMexil
	8NBP6TtuqwLSs36GNPTB+oBrLM2LHWgHMActFpxFo3n7GkJOySfooPPXroWmpWW4Dbl8LCe9h0y
	FHw==
X-Google-Smtp-Source: AGHT+IEXTf3QCd3TQqb7Btl91C1DC3dERL5Tvft7i3H5neTikScJGFn/xEqpb8insX0XCN+lC0lVPg==
X-Received: by 2002:a2e:6112:0:b0:2fa:fc98:8235 with SMTP id 38308e7fff4ca-2fcbe0bb894mr28869201fa.42.1730130188198;
        Mon, 28 Oct 2024 08:43:08 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4507fb3sm11976191fa.14.2024.10.28.08.43.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 08:43:07 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so42615711fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:43:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPxQELR2CdH2vaCcTmSwMj7Yd84x7Xt1S6geXyR6DO5sJckT7RuLc/Fqtnle7EtdKO6zITLsgPhCjkEZM=@vger.kernel.org
X-Received: by 2002:a2e:bc0d:0:b0:2fa:d9db:7bac with SMTP id
 38308e7fff4ca-2fcbdf6250cmr34338691fa.3.1730130185979; Mon, 28 Oct 2024
 08:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017094222.1014936-1-wenst@chromium.org> <20241017094222.1014936-8-wenst@chromium.org>
 <CAD=FV=X-YzEGEc+tp-uB6vdPMEC-V9M=Gb60H69=_XY9w4R8nw@mail.gmail.com> <CAGXv+5H8kxrr=JJsMMY5Y+HC5JqMN-bMkm7hztOzQgrbew6-rw@mail.gmail.com>
In-Reply-To: <CAGXv+5H8kxrr=JJsMMY5Y+HC5JqMN-bMkm7hztOzQgrbew6-rw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Oct 2024 08:42:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VbTMLr8ybCvKwm4aau+UkwCewuj2mqFX_+9hdCALLBRA@mail.gmail.com>
Message-ID: <CAD=FV=VbTMLr8ybCvKwm4aau+UkwCewuj2mqFX_+9hdCALLBRA@mail.gmail.com>
Subject: Re: [PATCH v9 7/7] arm64: dts: mediatek: mt8173-elm-hana: Mark
 touchscreens and trackpads as fail
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 28, 2024 at 2:14=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> > > @@ -35,6 +37,7 @@ touchscreen@40 {
> > >                 hid-descr-addr =3D <0x0001>;
> > >                 interrupt-parent =3D <&pio>;
> > >                 interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;
> > > +               status =3D "fail-needs-probe";
> >
> > It's a little weird that there's no pinctrl definition for the
> > touchscreens but there is one for the trackpad, but that predates your
> > patch and is unlikely to be a big deal.
>
> To be honest I'm in favor of getting rid of pinctrl settings that
> do nothing more than mux in a GPIO, as mentioned in my talk at ELCE.
> Such settings are already implied by the interrupts or gpios properties.
> The fact that the OS doesn't enforce exclusiveness between the
> subsystems is not something the DT should deal with.

One could also argue that the fact that the Linux kernel happens to
auto-mux pins to GPIO is not something that the device tree should
assume. Personally I have never liked the "auto-mux" behavior of Linux
and I've found that it can get in the way when you need to do more
advanced pinmuxing, like when a driver needs to sometimes use a pin in
"special function" mode and sometimes in GPIO mode. The auto-muxing
happens behind the back of the driver which then needs to account for
this fact and work around it. Just sayin. :-P

