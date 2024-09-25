Return-Path: <linux-kernel+bounces-339645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C92998685F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FEC284AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE714B09E;
	Wed, 25 Sep 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m7FTtcOA"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E154767
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300129; cv=none; b=Busuz8x1C10kXKqttX70Uk8RboWnyLjnQ5OVS9NSAAApJRy8C9YpLyGwlxXLi16DKGNEc0Jx/40I2JvW2lX+f7goyp7/qI9QfYGidgC79VgAReCkKERB8G98CU+CVwZRDXdhs3I9NFERQlD8J6D0crQbXPVNFuK/BVC99NqGLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300129; c=relaxed/simple;
	bh=q2EhClv7uowqfWc+yJkUHR0IftpzijEAuyD/le/y+tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhNbUb8GV4Rrb5xp3qKK6DdWUQVf8MqnCvC8RXefD1TKYAGlAhvAO4KgHSfUEhAalLzinSz6Oa9gWUO1x8LGY09ZUfOhQkziZTrj/do+uz0XAvM3M+dvsAVv+kjnirQjt7gpxoQNB3Fnf2fmLupzid9GvALYRLtpSPiWU2AU+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m7FTtcOA; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6db67400db4so4427187b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727300126; x=1727904926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTn08FN5vLzO9rVd5RQtGmIp0o3LUoCpyHjARrWMfnY=;
        b=m7FTtcOAglnFVP+dPysk/1C4k+lfe6Y7xCtzbgVS+8YnVE/uR/2eWDTibcEfbCyLYY
         V+FxLcUmqjVCFhIcOJkgn55+c3beu14y784IxKK4pxkHwenwiRHrjwjdZxI01PwsJw9l
         x57GuP3NKq3wyWRPxYc6SWTLMmEvHw2QCbggY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727300126; x=1727904926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTn08FN5vLzO9rVd5RQtGmIp0o3LUoCpyHjARrWMfnY=;
        b=lbbXQghwQOZLBfvLSc3ErE0tBn+DrrW3RJmC8dr5xr45s9mV8eGyuAhlP8O6+ixeCP
         LoCYe7ipARe1DjM6+txhqsWeOrhODJP6ZfWLIrKxPTkqS1f642P/erF+rSWrgR/62J9A
         1covftZwzw1qOqEJqqdVRLsS8wWTEaokspg6SmFSa6xqWfe8hCSUbbTvEOyJ87o/MFwX
         WrX+p6svJskhg9PrMveqdMuyA2tIArMHueMbbUmsncI0CwyG0TAUOycSMoZ1rRHfipmX
         2bzizraaeIBL8qjuQetE+6fJmwin4x+iLiFO5/DeUJiTLuniETwrkp6Iyli5kR1TPx7D
         Qagg==
X-Forwarded-Encrypted: i=1; AJvYcCUAvhLKkv37vM6ezAOI3oByZhrsQ925GGRpGQkRef3XpM2mwgiZ0xo0xe8EFR55F2uh2zbexfgTiToq/lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnlX+thLEVZPHmyltCvmyPw2fArBZNN8nwPmFN+iAMPfNs1CX
	3c5IleqwHctiBcnVuTk0vRd1a0xb6kOPi0fDyChhRM9uVkvzNTJXkafkaJkYUyuY5SP+dEtiHug
	4gimx6ikUzhOQpl4+SOZrJcflovWsfapWxXBt
X-Google-Smtp-Source: AGHT+IHziupVypVEkVK/CbCaXWpRCK8FetXKM/KwR70lVH1JtZYCUnM6U7a9e0A0MI4BpovvwHjM1uW6+KjC3yrr2O0=
X-Received: by 2002:a05:690c:7183:b0:6d4:b774:e503 with SMTP id
 00721157ae682-6e21d9fdd43mr29525877b3.41.1727300126618; Wed, 25 Sep 2024
 14:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid>
 <vnemjw6uo3sydriabdrzwinbnam2xitrezrw3ztcymi63zakep@2rruplyjzuol>
 <CANFp7mVir-XEuVBd+kbQq0+5Si0CBo8TNxcdNpG6X+PDR-J1Zw@mail.gmail.com> <25dcuu7bli47etvyijpi4winx4t42jwjq5ld2de3vmzkucic5j@h3wejwqyo7p2>
In-Reply-To: <25dcuu7bli47etvyijpi4winx4t42jwjq5ld2de3vmzkucic5j@h3wejwqyo7p2>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 25 Sep 2024 14:35:14 -0700
Message-ID: <CANFp7mUAeqekz57yOB8oF67wZ9=f9b8decmr-maia0DYVUQ89A@mail.gmail.com>
Subject: Re: [PATCH 8/8] platform/chrome: cros_ec_typec: Disable auto_enter
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 2:24=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Sep 25, 2024 at 10:39:00AM GMT, Abhishek Pandit-Subedi wrote:
> > On Wed, Sep 25, 2024 at 10:03=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Wed, Sep 25, 2024 at 09:25:09AM GMT, Abhishek Pandit-Subedi wrote:
> > > > Altmodes with cros_ec are either automatically entered by the EC or
> > > > entered by typecd in userspace so we should not auto enter from the
> > > > kernel.
> > >
> > > This makes policy decision for the whole platform. Consider somebody
> > > running normal Linux distro on chromebooks. Can this be configured by
> > > the userspace itself?
> >
> > This is just the default for when the driver registers. You will then
> > find that there is now a sysfs entry for auto_enter that you can
> > control from userspace to allow you to auto-enter the mode on partner
> > attach (which you could probably write a udev rule for).
>
> I think, a usual policy is to handle everything automatically, unless
> userspace configures it in a different way. Otherwise it might be really
> surprising to users, if the kernel expects an action from the
> non-existing userspace agent.



>
> > I still need to send a follow-up for how to handle auto-enter when
> > there are multiple modes available on the partner that are all
> > enabled. This first patch series is mostly about supporting existing
> > use-case for ChromeOS.
>
> Doesn't EC decide that, which AltMode to select?

On ChromeOS systems with only DisplayPort supported, ChromeOS EC
automatically enters DP altmode.

However, systems with Thunderbolt + USB4 have the AP_DRIVEN_MODE
feature enabled which expects the AP to enter/exit modes (due to the
security implication of TBT PCIE tunnels). ChromeOS has a userspace
daemon, typecd (https://chromium.googlesource.com/chromiumos/platform2/+/HE=
AD/typecd),
which handles the mode entry policy for ChromeOS. Currently, it talks
to the EC directly (via ectool) and this patch series is moving this
support to the kernel so we can use sysfs instead.

Currently, if you put a normal Linux distro on a ChromeOS device with
AP_DRIVEN_MODE enabled from the EC, it will not automatically enter
any alternate modes and there's no mechanism to do so via sysfs
either. You will need to either port typecd or compile + deploy ectool
to make the mode requests directly.

>
> > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > ---
> > > >
> > > >  drivers/platform/chrome/cros_ec_typec.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/plat=
form/chrome/cros_ec_typec.c
> > > > index ec13d84d11b8..e06a0f2712ce 100644
> > > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > > @@ -294,6 +294,7 @@ static int cros_typec_register_port_altmodes(st=
ruct cros_typec_data *typec,
> > > >       desc.svid =3D USB_TYPEC_DP_SID;
> > > >       desc.mode =3D USB_TYPEC_DP_MODE;
> > > >       desc.vdo =3D DP_PORT_VDO;
> > > > +     desc.no_auto_enter =3D true;
> > > >       amode =3D cros_typec_register_displayport(port, &desc,
> > > >                                               typec->ap_driven_altm=
ode);
> > > >       if (IS_ERR(amode))
> > > > @@ -314,6 +315,7 @@ static int cros_typec_register_port_altmodes(st=
ruct cros_typec_data *typec,
> > > >               memset(&desc, 0, sizeof(desc));
> > > >               desc.svid =3D USB_TYPEC_TBT_SID;
> > > >               desc.mode =3D TYPEC_ANY_MODE;
> > > > +             desc.no_auto_enter =3D true;
> > > >               amode =3D cros_typec_register_thunderbolt(port, &desc=
);
> > > >               if (IS_ERR(amode))
> > > >                       return PTR_ERR(amode);
> > > > --
> > > > 2.46.0.792.g87dc391469-goog
> > > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

