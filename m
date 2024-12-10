Return-Path: <linux-kernel+bounces-438695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB69F9EA479
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FE164BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE767A0D;
	Tue, 10 Dec 2024 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2g4fbmf"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF42B9BC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795125; cv=none; b=Ue2Mcm1Si4IZblllRvWpsD/T7ODW69iXX6UJnn5iOqzNeQ+LtepCJvpotb0OPR6u3gvk6KSWzlAtpMuZq+JQSjuwGkhBtD3UxrxF6Y3MUfZHo1q4E3aubhBqinggWkNE2T3NYlkOM+Ie7MhFcajTZCfWca8Y/putbmL7ar3x01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795125; c=relaxed/simple;
	bh=f/VOvLcpFGdSwyD/bwa5x3xxYOFeWx8ZvwNTh873AMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uS1Kh5ZzoWKHwCIQm9ZNQeakXHxacyM7Q+UpKdkz7EfkKWHmL6oPCrnYHpcmwpaNWetTcIuK7o9R9UE9GklJAuykGtc36ByN57E8ZV1M5wb1wjgOVudYcswap9b3Bsu2p4DAR3ZqzeGhGGWjhVxWpblXjuge5LufE55FsMbC4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2g4fbmf; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3989d27ba3so3901942276.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 17:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733795123; x=1734399923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDeSzNmG0r25Rn5nUf/295MidZQ+oiAWsebYRxIgxz4=;
        b=T2g4fbmfh40FRTk4XwcgZbHtkxnvcXJvPsN90V61ntLKvrpGeDP1qM0M7q3W3/EaaB
         jc6aPdFPU/OVeP98Lwxq16a70wfupsa8VkIQya55eMU0OZVh6Zy6elQQrMHukmDbBNjb
         mNBbWQPHxk92cSCe924txd0edrREHDOeJn7mjemegC5uDImm9U76rYLFW/J0DCGbKx+c
         0YCscA2Bpyby3rj2TWPmn6WmBaNNjf+sw0HASXyAJ9d69CFH+LSzboLB6FJb8gzqTdZM
         xFDXa1J7CzuFLBQPWPDerJoLL8YEXFBj7OqzeE2N3v/NMUORyPvlEum/yeTKLcC6o49h
         +OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733795123; x=1734399923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDeSzNmG0r25Rn5nUf/295MidZQ+oiAWsebYRxIgxz4=;
        b=iZB/73gcR5c1C/kHHoeB6v9CrtLghzq5XjmvPbBO9QnnQeMOFYI7Z65Gc5RgZ6xObl
         aTYDmefwlbtSE3n2vr2LvenLaI3wH0mUrdhHQzr8M190smeTYXz09geQgDgG2f+z1I1k
         IXQWvfbHZ9wPqEB55GnwVOE1ZuFHXZdm7LfTrezL/vrq3ySrTLyEWQjkmnmcOhhrSJJa
         9vZ73pSGmyjuBnacBosmFkpgfjlM/uXS8DzNcfiAz3SuaRK0yFCM9X99TaKV1emOKvXD
         aHilkMKtb58jCTo9xj8qvd71iPOv3vrHe5OdUAuWe7ea1iCR3b/LP02pAlnW5djnnSlM
         7c1A==
X-Forwarded-Encrypted: i=1; AJvYcCVwEHkqdi2Dz/gFlbVI01CW7/wTL6YABV8twAq8gJoG6EFp8OrxMpZQTO85NpL+ja9Bk4lNd1z5b3YAq6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhRhrQF5fvabKhrs41vO50gz9cJZBmqssxHtE0ophy7hkRj4/8
	HO0ItaPx3X9Uj8Z9BXNSLb/DKY8jQHdAg4syrAm44roxJIvdr2is/EDVgIg8EfsD1arUGSNZpCy
	/ObanERTd3RrtqltWJ+M1aWPeI6O7jBmomT4Sqg==
X-Gm-Gg: ASbGncvHK91GmyFk9Bb0HV0Zu9I24fwiawXXVtBkr0KHgx/1yWw5tS9Q1tIl7u7JFRG
	E70NOIBptPxk4H5/Yeh/UEWdOD4PEj6QxGUbW
X-Google-Smtp-Source: AGHT+IH9FYdZyuYf6+rQs47uyzndT1wVwnYcReW2ltFVfptMntuMiqQM909xz0QThYmGJkZYxK5rC55WkYQfh3JUnOo=
X-Received: by 2002:a05:6902:150b:b0:e38:b2fb:f57d with SMTP id
 3f1490d57ef6-e3a0b12a8c7mr11436978276.28.1733795122949; Mon, 09 Dec 2024
 17:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203165450.1501219-1-heiko@sntech.de> <20241209150619.33998-1-dse@thaumatec.com>
 <D67AV178CEBD.3QA9VD4ZPRNQ1@cknow.org> <2203458.KiezcSG77Q@diego>
 <4e015ea9.960.193ae0c236a.Coremail.andyshrk@163.com> <ay5hbnqqjhopaqof6z7j2rzm2bc6xa2vbzan2ak3if6wzmyip2@kqh7gtrajnm2>
 <33e2c5db.1300.193ae284b6d.Coremail.andyshrk@163.com>
In-Reply-To: <33e2c5db.1300.193ae284b6d.Coremail.andyshrk@163.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 10 Dec 2024 03:45:11 +0200
Message-ID: <CAA8EJprLA09NP0KAztc5eoAMkGcrom84jg_pcbNcwN0FAaSLrw@mail.gmail.com>
Subject: Re: Re: [PATCH v3 0/3] drm/rockchip: Add driver for the new DSI2 controller
To: Andy Yan <andyshrk@163.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Daniel Semkowicz <dse@thaumatec.com>, Diederik de Haas <didi.debian@cknow.org>, andy.yan@rock-chips.com, 
	Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	neil.armstrong@linaro.org, quentin.schulz@cherry.de, rfoss@kernel.org, 
	robh@kernel.org, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2024 at 03:22, Andy Yan <andyshrk@163.com> wrote:
>
>
> Hi Dmitry,
>
> =E5=9C=A8 2024-12-10 09:01:38=EF=BC=8C"Dmitry Baryshkov" <dmitry.baryshko=
v@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
> >On Tue, Dec 10, 2024 at 08:50:51AM +0800, Andy Yan wrote:
> >>
> >>
> >> Hi,
> >>
> >> At 2024-12-10 07:12:26, "Heiko St=C3=BCbner" <heiko@sntech.de> wrote:
> >> >Am Montag, 9. Dezember 2024, 17:11:03 CET schrieb Diederik de Haas:
> >> >> Hi,
> >> >>
> >> >> On Mon Dec 9, 2024 at 4:06 PM CET, Daniel Semkowicz wrote:
> >> >> > On 03.12.24 21:54, Heiko Stuebner wrote:
> >> >> > > This series adds a bridge and glue driver for the DSI2 controll=
er found
> >> >> > > in the rk3588 soc from Rockchip, that is based on a Synopsis IP=
 block.
> >> >> > >
> >> >> >
> >> >> > I did more tests with different LVDS displays. I tested following
> >> >> > configurations with DSI/LVDS bridge:
> >> >> > - 1024x600@60.01
> >> >> > - 1024x768@60.02
> >> >> > - 1280x800@60.07
> >> >> > - 1366x768@60.06
> >> >> >
> >> >> > All of them worked without issues, except 1366x768.
> >> >> > With this resolution, video is blurry, and offset incorrectly
> >> >> > to the left. There are also repeating errors on the console:
> >> >> >
> >> >> >   rockchip-drm display-subsystem: [drm] *ERROR* POST_BUF_EMPTY ir=
q err at vp3
> >> >> >
> >> >> > In correct operation with other resolutions, there is no error.
> >> >> > I am not sure if this is a problem in your series or rather in VO=
P2
> >> >> > driver.
> >> >
> >> >This really sounds like something is wrong on the vop side.
> >> >The interrupt is part of the vop, the divisable by 4 things likely to=
o.
> >>
> >> This is a hardware limitation on vop side:
> >> The horizontal resolution must be 4 pixel aligned.
> >
> >Then mode_valid() and atomic_check() must reject modes that don't fit.
>
> We round down to 4 pixel aligned in mode_fixup in our bsp kernel,

What is meant by the "bsp kernel" here? I don't see it being present
in the mainline kernel. So, if the mode is unsupported, it should be
rejected.

> because sometimes, some boards do indeed choose a screen that is not 4 pi=
xel aligned
> >
> >>
> >>
> >>
> >
> >--
> >With best wishes
> >Dmitry



--=20
With best wishes
Dmitry

