Return-Path: <linux-kernel+bounces-339651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2504986870
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08ABD1C2204F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8F11552E0;
	Wed, 25 Sep 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rp4woOtY"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710922EE4
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300602; cv=none; b=oD/lVw2gGTooIyGZDZAx2hB/gM9tp8vQ4il44xSXced7MEVeYvqaYOm5HJSwhXVRZHXFZ9FkqqYZKC7I+6Pck01CoBCzjR/WQ+6oNOKZBgThjoScFzCnfC+pRaRVEBECSYnPTR/Cpsfyzy2ulyJwheeh3hymChtwm7KwiGxAA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300602; c=relaxed/simple;
	bh=ufu1bVAo5GvTPqMeSZvyXyLw+NRp32KsM3FWTmCFM/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkiMFC9CZtI/buZnrdDiFJtvlTio1jEUfz0kHvBlyXVnyXT6YP8sgy3ISs3FT1F5h2L4Kno4ob4fHHD60GWtbj8kFQ0B6nIV4bbarahouVfaOLaUdHAlPBocwBHAHiwK4ER2UpGDkoDk2UHFvt5nfeISjW2Y9+uWKW+JcGX/MMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rp4woOtY; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6dddca05a60so14846867b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727300599; x=1727905399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNxWBoGQtrXvoxbTLYp7sPgZb44qwzuaJymtkJKKR3M=;
        b=Rp4woOtY1BgP9tLLduVK/qsUDQ+aTHduXxlqo8qyav9xX0+cd73p4Hbtzm5IWz+/VW
         a1KG7m7/BS0ZbK2iMC9/3BlAV+lBiv6JcrRniI6f9ywfBprd9BFRvx4in2qM6EJdI5KN
         YrhzMMPdlTA46ehP7HD1OnzT3APbT8DWiQqHISrbrJFnFzeN6cOYirdk+wdXXMArF7J7
         eFThMWu4TcAvWGGN5AXGCJZimGNc8bQ2zhEDSAzNU254vmv0WYWniSEoVLPTaAWXGsCh
         V/aaBp2vF6bjlklyQgXFrYLGJ/cYGuZ2dbC08eYfPqmL6hMDsw8/gNIkN1KwzKSU11Dk
         9e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727300599; x=1727905399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNxWBoGQtrXvoxbTLYp7sPgZb44qwzuaJymtkJKKR3M=;
        b=Y8hXBL+eXtGvdfPet3DeJ9u2aLmXO//02lODOI5v5sKge5xiy7Kz6V2bfe/LdfNe+C
         BG8bC2e26qR7/WhosKW+BLYqsZRJXL6ODiWO+4pMwbYgefxPQ+0fJDOvrbMXumBXG9gy
         tJF9eD1OtAitfNf1R2ES8Xnf+wHnsSPmu0f5WSDt9gPmooNGshHxxFWtfM6pLslD+Rqx
         ssBrTmY5wkLsGFpNiU5SfXswfT9+6e1Sa1QZUIxD31sy4ZUjclh44kGasHtjCfPuZGXq
         8mCCe0uqdKbrTAiEqWzo+UseqzOCLQQn9vbQPf+zod5w6qfwGiE40cwp6kFfjAlXZo5x
         F9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMo9PLEJc/Zt0qtVAFf5Zc8FT+PooN91CxL0ilIcSLcLxpp20O1iVvXz+rm127V57QBgusw0JTWbvRyRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6VKFFDHdHBuCsaYBBDq+/eddl/DhVUYUF6ugtaGB9e/dvhvy
	YBjTh4EqUhZY8LL2H3gxhuYIC1lzdAJnber6QGxHUv2o7QUDkuzsCuwR+huBOAIIQyyIOf+5721
	S4CxC4VZD1XtHg4IQOErHwc4nmF16rYk8f4ltaQ==
X-Google-Smtp-Source: AGHT+IEs3WtMy6I/o0epYdPq0lTljYR0f07/xhhSVqM1QkPWW0L69fzMyRLh7JZWwRgCQttXXsapW+5yOM9YqbOc9C8=
X-Received: by 2002:a05:690c:6482:b0:6e2:5d2:3426 with SMTP id
 00721157ae682-6e22ed8041emr10317177b3.4.1727300599382; Wed, 25 Sep 2024
 14:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid>
 <vnemjw6uo3sydriabdrzwinbnam2xitrezrw3ztcymi63zakep@2rruplyjzuol>
 <CANFp7mVir-XEuVBd+kbQq0+5Si0CBo8TNxcdNpG6X+PDR-J1Zw@mail.gmail.com>
 <25dcuu7bli47etvyijpi4winx4t42jwjq5ld2de3vmzkucic5j@h3wejwqyo7p2> <CANFp7mUAeqekz57yOB8oF67wZ9=f9b8decmr-maia0DYVUQ89A@mail.gmail.com>
In-Reply-To: <CANFp7mUAeqekz57yOB8oF67wZ9=f9b8decmr-maia0DYVUQ89A@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 25 Sep 2024 23:43:08 +0200
Message-ID: <CAA8EJpqiF_0bgYT8boFa4UPJWcxgw89mmfbdMVKeAP-xnFOP4g@mail.gmail.com>
Subject: Re: [PATCH 8/8] platform/chrome: cros_ec_typec: Disable auto_enter
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Sept 2024 at 23:35, Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> On Wed, Sep 25, 2024 at 2:24=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, Sep 25, 2024 at 10:39:00AM GMT, Abhishek Pandit-Subedi wrote:
> > > On Wed, Sep 25, 2024 at 10:03=E2=80=AFAM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Wed, Sep 25, 2024 at 09:25:09AM GMT, Abhishek Pandit-Subedi wrot=
e:
> > > > > Altmodes with cros_ec are either automatically entered by the EC =
or
> > > > > entered by typecd in userspace so we should not auto enter from t=
he
> > > > > kernel.
> > > >
> > > > This makes policy decision for the whole platform. Consider somebod=
y
> > > > running normal Linux distro on chromebooks. Can this be configured =
by
> > > > the userspace itself?
> > >
> > > This is just the default for when the driver registers. You will then
> > > find that there is now a sysfs entry for auto_enter that you can
> > > control from userspace to allow you to auto-enter the mode on partner
> > > attach (which you could probably write a udev rule for).
> >
> > I think, a usual policy is to handle everything automatically, unless
> > userspace configures it in a different way. Otherwise it might be reall=
y
> > surprising to users, if the kernel expects an action from the
> > non-existing userspace agent.
>
>
>
> >
> > > I still need to send a follow-up for how to handle auto-enter when
> > > there are multiple modes available on the partner that are all
> > > enabled. This first patch series is mostly about supporting existing
> > > use-case for ChromeOS.
> >
> > Doesn't EC decide that, which AltMode to select?
>
> On ChromeOS systems with only DisplayPort supported, ChromeOS EC
> automatically enters DP altmode.
>
> However, systems with Thunderbolt + USB4 have the AP_DRIVEN_MODE
> feature enabled which expects the AP to enter/exit modes (due to the
> security implication of TBT PCIE tunnels). ChromeOS has a userspace
> daemon, typecd (https://chromium.googlesource.com/chromiumos/platform2/+/=
HEAD/typecd),
> which handles the mode entry policy for ChromeOS. Currently, it talks
> to the EC directly (via ectool) and this patch series is moving this
> support to the kernel so we can use sysfs instead.
>
> Currently, if you put a normal Linux distro on a ChromeOS device with
> AP_DRIVEN_MODE enabled from the EC, it will not automatically enter
> any alternate modes and there's no mechanism to do so via sysfs
> either. You will need to either port typecd or compile + deploy ectool
> to make the mode requests directly.

Well, I'd say that without a proper sysfs interface the feature is
incomplete. At the very least it must be documented in the commit
messages, so that anybody who tries to get this up and running can
find necessary userspace bits (and then can implement necessary driver
support).

Also consider extending bolt, a usual ThunderBolt daemon used on
Linux, to support new sysfs attributes.

>
> >
> > > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.or=
g>
> > > > > ---
> > > > >
> > > > >  drivers/platform/chrome/cros_ec_typec.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/pl=
atform/chrome/cros_ec_typec.c
> > > > > index ec13d84d11b8..e06a0f2712ce 100644
> > > > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > > > @@ -294,6 +294,7 @@ static int cros_typec_register_port_altmodes(=
struct cros_typec_data *typec,
> > > > >       desc.svid =3D USB_TYPEC_DP_SID;
> > > > >       desc.mode =3D USB_TYPEC_DP_MODE;
> > > > >       desc.vdo =3D DP_PORT_VDO;
> > > > > +     desc.no_auto_enter =3D true;
> > > > >       amode =3D cros_typec_register_displayport(port, &desc,
> > > > >                                               typec->ap_driven_al=
tmode);
> > > > >       if (IS_ERR(amode))
> > > > > @@ -314,6 +315,7 @@ static int cros_typec_register_port_altmodes(=
struct cros_typec_data *typec,
> > > > >               memset(&desc, 0, sizeof(desc));
> > > > >               desc.svid =3D USB_TYPEC_TBT_SID;
> > > > >               desc.mode =3D TYPEC_ANY_MODE;
> > > > > +             desc.no_auto_enter =3D true;
> > > > >               amode =3D cros_typec_register_thunderbolt(port, &de=
sc);
> > > > >               if (IS_ERR(amode))
> > > > >                       return PTR_ERR(amode);
> > > > > --
> > > > > 2.46.0.792.g87dc391469-goog
> > > > >
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

