Return-Path: <linux-kernel+bounces-215389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B493E9091FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E66A28B3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9619E7D3;
	Fri, 14 Jun 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVfKxho2"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8584619B3F7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387324; cv=none; b=P6zeuAIvIA0BWrcbQ8gpWamWgrHoyTwZ58IEKRs3OhD9Ac0Y3/PxFigfo5v7GkSgZtHNZ1S7IxIq6DJaUFtdZnupFHT8QD4fPs1RBaKKXAwaMrUzmLzTS6GsEmprcq6rqjaIgUZC9hCfHQfk5Mn9xSHHw80plX/luTBtxIVyd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387324; c=relaxed/simple;
	bh=92J8SyqxIdf2oE6L5pTOUXazVSTyJnFiR/byTfNtl/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWk1mf5Pug1qUOY8zM37QFEKfVMzZl6rtxp6cI1jH1H8A6DI21UmgUgcjvKnX2QSsLI4laCe1UeZ+oEin2vPp5vOyLY9UoD6ZY9njojiR7ZtbhvxnEHl3H4DAmaOYrzIpznIg+WXB/2A6If1WCL+xEXcq2VYOtvy+kyu3tbRZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AVfKxho2; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfe71dd22a5so2667515276.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718387321; x=1718992121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/1LOPv92dlO9DKKyPTS9cPz+tBToHnqWBwgmZh3nDw=;
        b=AVfKxho2HOkrGPN0M2Zq1/bMxgOLQz3fhN/A+DC8VLDeHkJ4h8xH8y5VYOEJSaXA0x
         6CTgNtmppB0wrfbKpiKzclvhGgrAZ6ZnXYoM4Gt+fjHT6u0OVSYj1Yyqlae9QBafSq+U
         cZXTQegp5zEF1XrMocEEg2J6sZzjW03LsyE8wycbf//X5vfOV9aT3eer4N2caGvdgYkg
         M7Fc9nzEpVJQbpxWxvLPsq49PYoBEu8WI6VYEgr0FGPgDsUVIVo/TR/o9EDkBTB9iieu
         6jbUfUX7eLKCiIwe+2hFVmAAKJGfXExDpYg2ICmVrmP9siuqKI0qfkawhgEBe99mOhrG
         0pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718387321; x=1718992121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/1LOPv92dlO9DKKyPTS9cPz+tBToHnqWBwgmZh3nDw=;
        b=cm12oAaUnWWAgYXT7UdM4yUO7yoDw/Xw7yTQpAGs9EFvRLWOWtbTpAn6EUaB5Lxlad
         e2+KhoWDf8p7SmH8U3rYFeB30q5rDF/F4w81l4X4S7XbaT7mY+jB//G2CpCsZmi9G8zs
         OrorlSvJx8TBapHropeGV32lsNP1WxgZ+PnyjPuEFczRulA4FlREshNwWhaeXyfzcfny
         hCQYJFGCHKHPXHkB+pZmdGLhoGYvKmBF5zIg1ScUDwCa16G4cEh/JPNGBytrO1vDeSup
         Y3BXeyBT9rO6zazUFD+64TurGdJIavLK28A/AGYOYqOO6+nPUQ8ksLNhdpmJzzl/UMMD
         csYg==
X-Forwarded-Encrypted: i=1; AJvYcCX6i2cNR11uG/hkoxdNu68AjZtUXAZEvsJ4Mb1eq5e6j8mBq34kq3+HD6Fy9728i+61EKLeA9E4GGDlvGVaeu0xkxDyEgtxMIsHZn8x
X-Gm-Message-State: AOJu0YwTCGmY0oK8TMMybHYAevNCm7DUS25af82n981mFK4kNHCO3csT
	aFioLJ5OQDUDCUGbuObTX7Ff1+bjgE8gvOXHf7W7IRwJKeq2roE6lu1KNLS+8nItrwDxNyREzcw
	gg9B3cRguRpdaA5t9nwRtZCdgCYugcholfnhjaA==
X-Google-Smtp-Source: AGHT+IGUxEdaon415iN8h281a2LuqoE9nZyftt9g8HQiehPuXE3/tb0mRmefYubCxnRYFAQS7EzlNNoC73f3DBYcL/8=
X-Received: by 2002:a25:c785:0:b0:de6:1057:c85f with SMTP id
 3f1490d57ef6-dff1537c45dmr3081777276.22.1718387321539; Fri, 14 Jun 2024
 10:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
 <20240613095901.508753-1-jtornosm@redhat.com> <CAMSo37UzU9WrQOQVo=Bb-LfOwS=GJrsSLMgGAwLY7JoGQ9ap7g@mail.gmail.com>
In-Reply-To: <CAMSo37UzU9WrQOQVo=Bb-LfOwS=GJrsSLMgGAwLY7JoGQ9ap7g@mail.gmail.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Sat, 15 Jun 2024 01:48:30 +0800
Message-ID: <CAMSo37XjHhBz1hc_se0Fj8=gnju-iOT52Nf60jwLJ1hPN_kUaQ@mail.gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jstultz@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Jose

On Thu, 13 Jun 2024 at 19:46, Yongqin Liu <yongqin.liu@linaro.org> wrote:
>
> Hi, Jose
>
> On Thu, 13 Jun 2024 at 17:59, Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com> wrote:
> >
> > Hello again,
> >
> > There was a problem copying the patch, sorry, here the good one:
>
> Thanks very much for the work!
>
> I will test it tomorrow, and let you know the result then.
>

I tested with the ACK android15-6.6 and the android-mainline branches,
which have the issue reported,
after applying this patch, the network works again now.

Here is the console output from the mainline branch, in case you want to ch=
eck:
https://gist.github.com/liuyq/bd3fdada41411bc89a0cd4acf9ec11cf

Thanks again for all the help!

Best regards,
Yongqin Liu



> >
> > $ git diff drivers/net/usb/ax88179_178a.c
> > diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_1=
78a.c
> > index 51c295e1e823..60357796be99 100644
> > --- a/drivers/net/usb/ax88179_178a.c
> > +++ b/drivers/net/usb/ax88179_178a.c
> > @@ -174,7 +174,6 @@ struct ax88179_data {
> >         u32 wol_supported;
> >         u32 wolopts;
> >         u8 disconnecting;
> > -       u8 initialized;
> >  };
> >
> >  struct ax88179_int_data {
> > @@ -327,7 +326,8 @@ static void ax88179_status(struct usbnet *dev, stru=
ct urb *urb)
> >
> >         if (netif_carrier_ok(dev->net) !=3D link) {
> >                 usbnet_link_change(dev, link, 1);
> > -               netdev_info(dev->net, "ax88179 - Link status is: %d\n",=
 link);
> > +               if (!link)
> > +                       netdev_info(dev->net, "ax88179 - Link status is=
: %d\n", link);
> >         }
> >  }
> >
> > @@ -1543,6 +1543,7 @@ static int ax88179_link_reset(struct usbnet *dev)
> >                          GMII_PHY_PHYSR, 2, &tmp16);
> >
> >         if (!(tmp16 & GMII_PHY_PHYSR_LINK)) {
> > +               netdev_info(dev->net, "ax88179 - Link status is: 0\n");
> >                 return 0;
> >         } else if (GMII_PHY_PHYSR_GIGA =3D=3D (tmp16 & GMII_PHY_PHYSR_S=
MASK)) {
> >                 mode |=3D AX_MEDIUM_GIGAMODE | AX_MEDIUM_EN_125MHZ;
> > @@ -1580,6 +1581,8 @@ static int ax88179_link_reset(struct usbnet *dev)
> >
> >         netif_carrier_on(dev->net);
> >
> > +       netdev_info(dev->net, "ax88179 - Link status is: 1\n");
> > +
> >         return 0;
> >  }
> >
> > @@ -1678,12 +1681,21 @@ static int ax88179_reset(struct usbnet *dev)
> >
> >  static int ax88179_net_reset(struct usbnet *dev)
> >  {
> > -       struct ax88179_data *ax179_data =3D dev->driver_priv;
> > +       u16 tmp16;
> >
> > -       if (ax179_data->initialized)
> > +       ax88179_read_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID, GMII_PHY_P=
HYSR,
> > +                        2, &tmp16);
> > +       if (tmp16) {
> > +               ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_M=
ODE,
> > +                                2, 2, &tmp16);
> > +               if (!(tmp16 & AX_MEDIUM_RECEIVE_EN)) {
> > +                       tmp16 |=3D AX_MEDIUM_RECEIVE_EN;
> > +                       ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM=
_STATUS_MODE,
> > +                                         2, 2, &tmp16);
> > +               }
> > +       } else {
> >                 ax88179_reset(dev);
> > -       else
> > -               ax179_data->initialized =3D 1;
> > +       }
> >
> >         return 0;
> >  }
> >
> > Best regards
> > Jos=C3=A9 Ignacio
> >
>
>
> --
> Best Regards,
> Yongqin Liu
> ---------------------------------------------------------------
> #mailing list
> linaro-android@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-android



--
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

