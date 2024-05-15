Return-Path: <linux-kernel+bounces-180074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA458C69C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7851F234FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E792155A57;
	Wed, 15 May 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cg70LgCK"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EE155723
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787013; cv=none; b=AKw1Nsv79i0CdgcUhEyxAJN19I6WSqBNCzoaXmiFIBGVPJDtzUuyavAYeCTFcBzyXNiaCYHBkPSH6L5CvlZzUGvtcMzJ+sIszTeoU/fVuGqXsC1KzuzpEi7/2LBrYYEh0sFvDR3BZO8iSkhEbP6vVJu7L47j/7CUqxABIUOMELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787013; c=relaxed/simple;
	bh=iN8matYjyvj8EmXmPi1mXOrlyGDmDH19/5Kdt0+yZnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdjL1K3/pq6IXG58NkmSG8f9wJfrZui/G+IpPQCGwc3dnUFI/sDB7zkTqo50qHHgBEYUprwwRIwYPs+0OanpRL3EkelKASq3S3Wr56ZLsFwz9IwaYJf+NJojh0TqLjYRFkhlzcLaAjvxpv2FdDSUHfSHxqQazTRjgrQEdg373og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cg70LgCK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43dfa9a98d2so767981cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715787010; x=1716391810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWQRenWjdpHYMXaannQIn7Uf7C7Qw+cYZ1N3+xFMxeM=;
        b=Cg70LgCKhsiiTD6OG0VZUNlLHjaIijTPnLTa+9hM6u6KCDJdyRmmqE3JDwKijlPjYW
         gdQ8RzpNhsxO+Wc5Rpfyyb9Ane8QbQ+OR/H9tXadZOhYkHsvXoAV91CP080mL9LeZ+Ww
         ybLnfwfgzo5/5F+mavAZ7RHD/vMVuztVMG9kR67kxKwmiAuzQhVMhj+3E5+gAf9nyU0M
         hBWUufY5fp3u5RTeD7H4HgOrEbif+bkAULrwBJ8BtpS/Cm/bMLXLccVBvOhWKDcyiS/x
         PV9zveW2nUVTxMt6cAPS2r2vK6jLrFzqwWbCS8gLjfWzW4T9zIP5pnXqgCtnCwHG16So
         cVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715787010; x=1716391810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWQRenWjdpHYMXaannQIn7Uf7C7Qw+cYZ1N3+xFMxeM=;
        b=kLOwKKfcfhH6gpDPuNYzJCV/wNLQKZrbhbV8jSynd4qvd3N5RxkfBTP+pBmGnaw+lu
         pKYDSEfjFPFEP0eqA/3ojVcOAjLV1UU7rBsEsAZibq2KM865s99Ie6IIPymExv/7NTto
         dk2sZCjwvfIANFrxZZ42akmsRPPmqpVBnbT8yFeJBxHbq2uAE4NpeYGB3tbKnUblx3fv
         DGDKiYxhL14ZkQm9tTSHanvBusGRE2joqv8CX9AU5snWzsKr425z8qDKlnzA/q/pu0Nj
         zZoiE7ddRea8O9ebFiaTGFUuSSVAOdTJC2g+CZBXzkO4b3ZZxXmdZEqpwxGFlWyPhWX5
         jcRw==
X-Forwarded-Encrypted: i=1; AJvYcCXZYkxpfhuvpqx+TZQYUzcRPNLhMX/twXApzreeW3LuBew7XvXLgHWW0li4w1jbWBO1jDGrgpk+7xy0m1dPih4PfH6LzPd4y7kE51s5
X-Gm-Message-State: AOJu0Yx1pinct8/VIAJNKm4Lq7gv7WLlMKXKQWVuWO6apSQrSm8aiYUg
	AnW33N66jL5UydWYhdbcAnvqOxNtlYtEyq7ZT+2WFhgBKp0TVOi7qTg9Z3qag1gwDCkEjpE3753
	e+9nD7QebsHq3muM40ppkz21b7OYd7hQEnh8Y
X-Google-Smtp-Source: AGHT+IGJGp0luo4tSLl+hVgce9Ibj6n3gBuMuLJQ2JNyO3iqpNBP3apqcepmnIos8wr124kd0+SIi+IoDsgY10kszjM=
X-Received: by 2002:a05:622a:1dcb:b0:43d:dfa2:216f with SMTP id
 d75a77b69052e-43e094d0189mr11430441cf.6.1715787010055; Wed, 15 May 2024
 08:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjQeE643YAbK1hq5@google.com> <20240503155020.v2.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>
In-Reply-To: <20240503155020.v2.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>
From: Jonathan Denose <jdenose@google.com>
Date: Wed, 15 May 2024 10:29:58 -0500
Message-ID: <CAMCVhVNr=ax6tv=VXRpQoz=z=yR+LiHGUU6r7LpHM4oBoJSKSw@mail.gmail.com>
Subject: Re: [PATCH v2] Input: elantech - fix touchpad state on resume for
 Lenovo N24
To: dmitry.torokhov@gmail.com
Cc: gregkh@linuxfoundation.org, jefferymiller@google.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:12=E2=80=AFAM Jonathan Denose <jdenose@google.com=
> wrote:
>
> The Lenovo N24 on resume becomes stuck in a state where it
> sends incorrect packets, causing elantech_packet_check_v4 to fail.
> The only way for the device to resume sending the correct packets is for
> it to be disabled and then re-enabled.
>
> This change adds a dmi check to trigger this behavior on resume.
> Signed-off-by: Jonathan Denose <jdenose@google.com>
> ---
>
> Changes in v2:
> - change ps2_sendbyte() calls to ps2_command()
>
>  drivers/input/mouse/elantech.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantec=
h.c
> index 4e38229404b4b..18f26315cae25 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1476,6 +1476,23 @@ static void elantech_disconnect(struct psmouse *ps=
mouse)
>         psmouse->private =3D NULL;
>  }
>
> +/*
> + * Some hw_version 4 models fail to properly activate absolute mode on
> + * resume without going through disable/enable cycle.
> + */
> +static const struct dmi_system_id elantech_needs_reenable[] =3D {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +       {
> +               /* Lenovo N24 */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "81AF"),
> +               },
> +       },
> +#endif
> +       { }
> +};
> +
>  /*
>   * Put the touchpad back into absolute mode when reconnecting
>   */
> @@ -1486,6 +1503,22 @@ static int elantech_reconnect(struct psmouse *psmo=
use)
>         if (elantech_detect(psmouse, 0))
>                 return -1;
>
> +       if (dmi_check_system(elantech_needs_reenable)) {
> +               int err;
> +
> +               err =3D ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_D=
ISABLE);
> +
> +               if (err)
> +                       psmouse_warn(psmouse, "Failed to deactivate mouse=
 on %s: %d\n",
> +                                       psmouse->ps2dev.serio->phys, err)=
;
> +
> +               err =3D ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_E=
NABLE);
> +
> +               if (err)
> +                       psmouse_warn(psmouse, "Failed to reactivate mouse=
 on %s: %d\n",
> +                                       psmouse->ps2dev.serio->phys, err)=
;
> +       }
> +
>         if (elantech_set_absolute_mode(psmouse)) {
>                 psmouse_err(psmouse,
>                             "failed to put touchpad back into absolute mo=
de.\n");
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

Hello,

Is there anything else needed from me?
--=20
Jonathan

