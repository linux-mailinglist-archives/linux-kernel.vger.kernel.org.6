Return-Path: <linux-kernel+bounces-339472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D947A9865A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B4D1F25301
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610B057880;
	Wed, 25 Sep 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hJoA46mE"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146D22318
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285520; cv=none; b=cqnnhcV7OS/ZYspiiGEkSY7fhP56JbYrY/MGuxvN2jOpjFrA0mcH6nC4hcZ8Mukq4cZeJemsQV574HiVHFnN2slnyh0n7eMkGoFftx7wq2zsIlEdu/aPRA1sSJCAKqhDeoTm689/gcCTdHWxWIHVwJ0Lnq4H0JvTnbNyP0PP+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285520; c=relaxed/simple;
	bh=AsiidYyDiQ7aCzf8VNXogBUE8Ky+6+7IQkomdzNyO1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/6wiM2ggizYbBo1UTvt67CEA8tIC12MFlgNmB8KeapRDw5+jJFYegkZY9MoiTZ4EH1RHePN+mnUK0jQ0czVpzPrLPYpp5kSEmabevpoCvSPHogH1VPj/FUSSNvmbNE4KNR251ApkP3odKTg1n86x5XLEyNUrpx+rK5pSyEuqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hJoA46mE; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-709339c91f9so53805a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727285518; x=1727890318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foQOdpYay332QgWU2K1U9huYqUmxout+sEt9nqJbTuc=;
        b=hJoA46mE8CkPI8diNSUlled3PQG8+MGHKbAInokuQDOYwk5V5WwcR9EjsF2d8oeafk
         mXLiwGwEFWNT/wKQZte6Hxj/6NAp5IWkQRwK0uTHS3y43h5bWkC5lS2bLflTIKQ51Cx6
         hXa/9NFIfrmXEXtPqhqNFp5dXvqbOHVH/ANuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285518; x=1727890318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foQOdpYay332QgWU2K1U9huYqUmxout+sEt9nqJbTuc=;
        b=Z6MmtsA+wq+x5+ucSAftdAPiTkqIunGp5QMFS/f4QfOF0vG/8cD2hIkMMrirn2pdhe
         U4NhEcuaFsptg+X2mF51lPXJa52JqcCJqmzZ9SJ9cOK47y5vSc3EFzr7Nda/uexf/thr
         sY+wsO1f09jKhEH4UlsZcu2Z5Y+yDiAgUK7EaE+H383W9DzvGyMHdKq14G3/k+zkXPAw
         iLpPaKUIDlBFKgLpJLv5/YAxgbwGFhVJiQ6hIoP/ZcMqeufSHCjYzBSlxKE4iddby91e
         L7JWIzMwX8uVv+n+WVs9aksRHaNRtEuzTQHtG8mpAqUE8pG8eaoWChi+HiI/MgfTHuDJ
         iZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWBs8gtU4H9zRtGGn/uWp5xVnMClUE7xUYZO8prqn+I0pxdChEKMg0GYnYiLoeJYqqhwJ0wMQzM73kExA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/JK1f8lQHjyZT8p3adMcHoN72ZdtiT38YkoCXQe9kJiyW12Z
	TSGkiG/dlU82LKnHbEsQrmxKgP492+NCi1X1vWnFlrshsyBIfodjPRqF08bQOGIXeMMD9eqToLR
	zvMuv2ISse413XmcXySRCdsPLcFLnBK4tGskIhBHclDBc68M=
X-Google-Smtp-Source: AGHT+IGDyjRSElFnaMnXIeXsT+1r7wgSbMDhOYbLu5UUMTpYavmhKmGkvO/4gbtslkfwpxqyNkClPrrpGW6Xol0KjPs=
X-Received: by 2002:a05:690c:2e88:b0:6e2:413:f19 with SMTP id
 00721157ae682-6e21d84c892mr27692897b3.27.1727285506776; Wed, 25 Sep 2024
 10:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.2.Ie0d37646f18461234777d88b4c3e21faed92ed4f@changeid> <oedfq4fkjlbalytba7fxg462tyutgxxk5wnhg2mhkfevclv33q@ugc472nkwpo6>
In-Reply-To: <oedfq4fkjlbalytba7fxg462tyutgxxk5wnhg2mhkfevclv33q@ugc472nkwpo6>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 25 Sep 2024 10:31:33 -0700
Message-ID: <CANFp7mXEx370EpWPcsFpiN9jW0iJzjr1povO89bTRX91dZ3XQQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] usb: typec: altmode_match should handle TYPEC_ANY_MODE
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 9:54=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Sep 25, 2024 at 09:25:03AM GMT, Abhishek Pandit-Subedi wrote:
> > altmode_match is used when searching for the first port altmode that
> > matches the partner or plug altmode. If the port registered with mode
> > set to TYPEC_ANY_MODE, it should always match if the SVID matches.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Fixes?

This is new for Thunderbolt which registers as TYPEC_ANY_MODE so
there's no FIXES. I think Heikki may need to chime in on how the
`mode` is supposed to be used.

IMO, it may be appropriate to get rid of the mode check entirely.

>
> > ---
> >
> >  drivers/usb/typec/class.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 9262fcd4144f..179856503d5d 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -230,7 +230,8 @@ static int altmode_match(struct device *dev, void *=
data)
> >       if (!is_typec_altmode(dev))
> >               return 0;
> >
> > -     return ((adev->svid =3D=3D id->svid) && (adev->mode =3D=3D id->mo=
de));
> > +     return ((adev->svid =3D=3D id->svid) &&
> > +             (adev->mode =3D=3D id->mode || adev->mode =3D=3D TYPEC_AN=
Y_MODE));
> >  }
> >
> >  static void typec_altmode_set_partner(struct altmode *altmode)
> > --
> > 2.46.0.792.g87dc391469-goog
> >
>
> --
> With best wishes
> Dmitry

