Return-Path: <linux-kernel+bounces-213118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B583906C45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7CA1C21D22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E4145B1E;
	Thu, 13 Jun 2024 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjeVHFqO"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801BF143C67
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279232; cv=none; b=RhhTt+4BoiQW18wdJc7JbOHuCu0vqoSjQCD6RoScbc1XJJhrVu4vxMm62sMdInhjUyq+lOmaS6c1jnOKXxitlD9mgELmQrJJhS/x4FkASNxpZL4YZDzVrTvSbrY8gQNtpXyXlGduZSZDSGz7bMa+dlm6QezldCfh5UcggX+Ikew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279232; c=relaxed/simple;
	bh=u8uqNXfneUxeojJqX6uW43gawvkWd/SVV0l8sqbDYiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVRA332SkSf7yxypItFrUJDeTl9ay5UQNx7cDtiaQSVNLxLNJGANxy3rMoYnrWnMP0XobMYnuKt1D2fl6Y0jiVdRoFoL6DUSJvRSnn6i8z3zmQ5rn6BTbEUXE7CGm4CRjN0yjV4zTdKpo9lacRNz2PnV6NKsAtV8DQ6B9MOx4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hjeVHFqO; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfe1aa7cce2so1041151276.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718279229; x=1718884029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LOKAxIeKteFuhp7/Gqn9TPI7GSn3AjIAgrQwVRNEFU=;
        b=hjeVHFqOks17mJr5ZOK3MfW+jrYXcZYEDqkvr5Cp+D6iEZmVOwIjLMVwcCJhE434Im
         myUPaK2lB7bPK14p+MVgCMvoZMQEpJ+aRuO3SNDE729WXwxjQ/jk33RPjeuS8k8jcZq2
         xufjyQeOl/dTSN5mjnJJoyo9cjJHu06XHIDJ0lYtOx9584059S1sYeDvV1F5m90PcZnW
         9oQNfwtYojMh2ubIVFrehDoErOZlXKoHG6CsNKmsL7a7iRDcGFJjnR3OGnhor5BqV3Ab
         c/mwm7AKeDXITNkjX8cjSV8p3H2MctJZSyapjdXWxxLI+sdOwzFJbrKmluJpjJlmb1+A
         sJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279229; x=1718884029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LOKAxIeKteFuhp7/Gqn9TPI7GSn3AjIAgrQwVRNEFU=;
        b=n2k8pN8sRU5LCveF8lj1WYHgaOQhLfe9BOpPRtATsYbIpfJZp0zxR4yJkEoKHmlH9Z
         rEf8Fu5nIy72Yk4IeosSqTBG2qT82/DuYxhHtD6do/gw/cxcw0HN3rOt44v/ZXmue2YQ
         TLF03X0J/zGkeO890PLwDb9igD58Z9H4COHX/1VDUI0MpuIqHadRV41XeybU++O0rcpi
         wdMs/H95BecPLSm1AE9YU43Fj2mSvNo9ejRsoNVbnHdamY9SUVAV9XMNsqeJ4s6cKiLS
         etkdjZ9/3QvZV+10b2ahG2ajl00EpcjfclTfZ3p2mC0cpbVXGLS59QCcaXTG4vpPXan3
         Grsw==
X-Forwarded-Encrypted: i=1; AJvYcCWFkRYNdtFsiyOrMynejxikBdxoKlpnkDg2sq8O+YZy9phg7yAXm4771lKv1OeFwdqV3cfIAD9yFFd9KpZF/PAXbVyR4gBtD/fcciFU
X-Gm-Message-State: AOJu0YxbSOcYcqm2+2KQH4OyLiR0YKxEyB0hYlR+pfJH33t8Gk5znOAE
	8KHooul1Kc+uPSLK6pyRSXkkv+8p/VOlFo11/nm08V+Kr6RljQL39FHGOhNDEV8OOK2qLYgQdnN
	4/Jv+VI377SP3EzYn47I2EUyPkAoFClnOXgJWGw==
X-Google-Smtp-Source: AGHT+IHFpink+Q293EhYr5U3tq2VDPbFBHBjghBbhVxgaG4IqWejDV0X1BOwqLDyC7goxOFASWf1sJs6gdyGUmv2tSI=
X-Received: by 2002:a25:aca8:0:b0:dfb:25ba:4390 with SMTP id
 3f1490d57ef6-dfe66d5a5e0mr4339265276.36.1718279229482; Thu, 13 Jun 2024
 04:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
 <20240613095901.508753-1-jtornosm@redhat.com>
In-Reply-To: <20240613095901.508753-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Thu, 13 Jun 2024 19:46:57 +0800
Message-ID: <CAMSo37UzU9WrQOQVo=Bb-LfOwS=GJrsSLMgGAwLY7JoGQ9ap7g@mail.gmail.com>
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

Hi, Jose

On Thu, 13 Jun 2024 at 17:59, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hello again,
>
> There was a problem copying the patch, sorry, here the good one:

Thanks very much for the work!

I will test it tomorrow, and let you know the result then.

Best regards,
Yongqin Liu
>
> $ git diff drivers/net/usb/ax88179_178a.c
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178=
a.c
> index 51c295e1e823..60357796be99 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -174,7 +174,6 @@ struct ax88179_data {
>         u32 wol_supported;
>         u32 wolopts;
>         u8 disconnecting;
> -       u8 initialized;
>  };
>
>  struct ax88179_int_data {
> @@ -327,7 +326,8 @@ static void ax88179_status(struct usbnet *dev, struct=
 urb *urb)
>
>         if (netif_carrier_ok(dev->net) !=3D link) {
>                 usbnet_link_change(dev, link, 1);
> -               netdev_info(dev->net, "ax88179 - Link status is: %d\n", l=
ink);
> +               if (!link)
> +                       netdev_info(dev->net, "ax88179 - Link status is: =
%d\n", link);
>         }
>  }
>
> @@ -1543,6 +1543,7 @@ static int ax88179_link_reset(struct usbnet *dev)
>                          GMII_PHY_PHYSR, 2, &tmp16);
>
>         if (!(tmp16 & GMII_PHY_PHYSR_LINK)) {
> +               netdev_info(dev->net, "ax88179 - Link status is: 0\n");
>                 return 0;
>         } else if (GMII_PHY_PHYSR_GIGA =3D=3D (tmp16 & GMII_PHY_PHYSR_SMA=
SK)) {
>                 mode |=3D AX_MEDIUM_GIGAMODE | AX_MEDIUM_EN_125MHZ;
> @@ -1580,6 +1581,8 @@ static int ax88179_link_reset(struct usbnet *dev)
>
>         netif_carrier_on(dev->net);
>
> +       netdev_info(dev->net, "ax88179 - Link status is: 1\n");
> +
>         return 0;
>  }
>
> @@ -1678,12 +1681,21 @@ static int ax88179_reset(struct usbnet *dev)
>
>  static int ax88179_net_reset(struct usbnet *dev)
>  {
> -       struct ax88179_data *ax179_data =3D dev->driver_priv;
> +       u16 tmp16;
>
> -       if (ax179_data->initialized)
> +       ax88179_read_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID, GMII_PHY_PHY=
SR,
> +                        2, &tmp16);
> +       if (tmp16) {
> +               ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MOD=
E,
> +                                2, 2, &tmp16);
> +               if (!(tmp16 & AX_MEDIUM_RECEIVE_EN)) {
> +                       tmp16 |=3D AX_MEDIUM_RECEIVE_EN;
> +                       ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_S=
TATUS_MODE,
> +                                         2, 2, &tmp16);
> +               }
> +       } else {
>                 ax88179_reset(dev);
> -       else
> -               ax179_data->initialized =3D 1;
> +       }
>
>         return 0;
>  }
>
> Best regards
> Jos=C3=A9 Ignacio
>


--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

