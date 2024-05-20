Return-Path: <linux-kernel+bounces-183890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C78A8C9F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC081F21A07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A73136E28;
	Mon, 20 May 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XfQITgr5"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6663136E10
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218091; cv=none; b=rfHlpE9QY/CviUPvC3cikFcERHtRBLP/8T0nJ/ctAtu+D4XM4SpFDK7mNgtBgpqS777sN0nVo/POq914DrvaPfCXSDYRHSnFzhanu7eXvuoMWNmYsYvik+3Toq7Xyn5fXKoUf/NMkqo8abPgwf2834D/nahRLuXRMJTHynW5Ov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218091; c=relaxed/simple;
	bh=aFdkKXMgw7IZRUOUAg2Gv8HZiNrYgQERd5uStPFtaHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyXPpOvUpmoojmBYhYPgKJUHQdjyMqdRn6zmMHCZJdu5yOiooaQyPs+nS6rJoI09yFl/yhxl96pc12GUDf7bMC0SNN7zWs+9hIt0Ys78v/tp+/WqTKXXKJHteHZDh+PguiwfZqvCEWoYDjK04oV5xx6H5l+loIHgEqOR1LUf8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XfQITgr5; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so61747311fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716218088; x=1716822888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a5RomlnN7TsyUGfzH2IKfbBBCjtXMvPMQ0e+f389oQ=;
        b=XfQITgr5fo8pYIbVPV/dy+anzdYuYM2D2t32nXelhu2snUKK/sRjWKapKvyh6YTCcH
         nDlRshbm/xi7R6NWTXDyCQUKUMrcG2OePij+j+06hAWkJ9ktkekkHsxirgiUTtIIpnUz
         bI0B6fquwatURLlzjsTC+sJTnQGEtmlOVlq0rh+nqLcscc/d4p+/za3/uIvjApYbTDXb
         wM8kPsUMt6vL4JpNXH3I27xlCHSpJqKHOa20IiHUKqLdWClAybsd80QwTzQjNnNoM78d
         /9qNrAOF+8VXl/kgWtwQgYf/gq67X4b4CFphvjh+bnO+0tdA2CeJ/UPxaJXASebq8jXs
         AXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716218088; x=1716822888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a5RomlnN7TsyUGfzH2IKfbBBCjtXMvPMQ0e+f389oQ=;
        b=KFg3jjvWFmxI0VAnHVIJ0ETemIAqo7f1zlx6Lnw6dtv3SWhuCVAVPEDVCZ/Foe+4eK
         XNWcai8tu16e4U2bolAeCEGWVBVv7Hr+sZStRPERYEjgXHHKNZWaJRQIg6psZg9GOruj
         yoXiR1fDqnNagUPOpehTqhTJwNx5nzPuPEL3/5Kofg2z9L8OfgFlVB5eMRdJfaLyW1r6
         5ncxJ1QA4NszY64CYPRw5pVWrUPME3sAa1J9XiyT6FIOszgzaXsYkuZ1ZoiJZ9cZQPsk
         txam3d/9Kg0dtvHMjnDKDtIFMagiGnujE6GuGJahfLgalA4f//j+NfTxtFFBByszB1j4
         0wFw==
X-Forwarded-Encrypted: i=1; AJvYcCXHYWpAcPb7KDRUmiFL7hUTm2gl3DShLr9WbcqljCXT7RNCvXMlPudpq0Y6WPtuXShn6CyfSWmGIcnPhumPrr6AhLygK42PQaT54/hY
X-Gm-Message-State: AOJu0YyTqR/ihFEq/THsNqTdPnWH1pBzietk+v6jERO9z7tXjBeE81/K
	PVz9yQiQT17qrFI8VkZaiB/EFEVjkCyGU8TS1GWWcYVgd4mHaoL/uRhXb04W0+LeqHisc0pP49/
	Vca/9eyL3ey0qFpm/tKRuDUIZsfCpn/qrjCft4A==
X-Google-Smtp-Source: AGHT+IGOXShFs30lQnhQLOEgZQ8QsxTjLN/aoAVIEKU7vh4edvsbFuB9I715CHqiF72yWbQBIxAVVEWz6TsCZrP11y4=
X-Received: by 2002:a2e:7c02:0:b0:2e0:5f2c:e0c0 with SMTP id
 38308e7fff4ca-2e5204b2edfmr187637791fa.37.1716218087754; Mon, 20 May 2024
 08:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430105307.1190615-1-b-padhi@ti.com> <20240430105307.1190615-3-b-padhi@ti.com>
 <954f974f-8b97-4ff6-bb57-35501fa9ceb9@wanadoo.fr>
In-Reply-To: <954f974f-8b97-4ff6-bb57-35501fa9ceb9@wanadoo.fr>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 20 May 2024 09:14:36 -0600
Message-ID: <CANLsYkxjFGZ3EaTQjmtJ5Vtad5CV0CNfC4F88XurXknXRCmmBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] remoteproc: k3-r5: Do not allow core1 to power up
 before core0 via sysfs
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Beleswar Padhi <b-padhi@ti.com>, andersson@kernel.org, s-anna@ti.com, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	u-kumar1@ti.com, nm@ti.com, devarsht@ti.com, hnagalla@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 18 May 2024 at 04:44, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 30/04/2024 =C3=A0 12:53, Beleswar Padhi a =C3=A9crit :
> > PSC controller has a limitation that it can only power-up the second
> > core when the first core is in ON state. Power-state for core0 should b=
e
> > equal to or higher than core1.
> >
> > Therefore, prevent core1 from powering up before core0 during the start
> > process from sysfs. Similarly, prevent core0 from shutting down before
> > core1 has been shut down from sysfs.
> >
> > Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5=
F subsystem")
> >
> > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > ---
> >   drivers/remoteproc/ti_k3_r5_remoteproc.c | 23 +++++++++++++++++++++--
> >   1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remotep=
roc/ti_k3_r5_remoteproc.c
> > index 6d6afd6beb3a..1799b4f6d11e 100644
> > --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > @@ -548,7 +548,7 @@ static int k3_r5_rproc_start(struct rproc *rproc)
> >       struct k3_r5_rproc *kproc =3D rproc->priv;
> >       struct k3_r5_cluster *cluster =3D kproc->cluster;
> >       struct device *dev =3D kproc->dev;
> > -     struct k3_r5_core *core;
> > +     struct k3_r5_core *core0, *core;
> >       u32 boot_addr;
> >       int ret;
> >
> > @@ -574,6 +574,15 @@ static int k3_r5_rproc_start(struct rproc *rproc)
> >                               goto unroll_core_run;
> >               }
> >       } else {
> > +             /* do not allow core 1 to start before core 0 */
> > +             core0 =3D list_first_entry(&cluster->cores, struct k3_r5_=
core,
> > +                                      elem);
> > +             if (core !=3D core0 && core0->rproc->state =3D=3D RPROC_O=
FFLINE) {
> > +                     dev_err(dev, "%s: can not start core 1 before cor=
e 0\n",
> > +                             __func__);
> > +                     return -EPERM;
> > +             }
> > +
> >               ret =3D k3_r5_core_run(core);
> >               if (ret)
> >                       goto put_mbox;
> > @@ -619,7 +628,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
> >   {
> >       struct k3_r5_rproc *kproc =3D rproc->priv;
> >       struct k3_r5_cluster *cluster =3D kproc->cluster;
> > -     struct k3_r5_core *core =3D kproc->core;
> > +     struct device *dev =3D kproc->dev;
> > +     struct k3_r5_core *core1, *core =3D kproc->core;
> >       int ret;
> >
> >       /* halt all applicable cores */
> > @@ -632,6 +642,15 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
> >                       }
> >               }
> >       } else {
> > +             /* do not allow core 0 to stop before core 1 */
> > +             core1 =3D list_last_entry(&cluster->cores, struct k3_r5_c=
ore,
> > +                                     elem);
> > +             if (core !=3D core1 && core1->rproc->state !=3D RPROC_OFF=
LINE) {
> > +                     dev_err(dev, "%s: can not stop core 0 before core=
 1\n",
> > +                             __func__);
> > +                     return -EPERM;
>
> Hi,
>
> this patch has already reached -next, but should this "return -EPERM;" be=
 :
>         ret =3D -EPERM;
>         goto put_mbox;
>
> instead?
>

This has already been addressed:

https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/commit=
/?h=3Drproc-next&id=3D1dc7242f6ee0c99852cb90676d7fe201cf5de422

> CJ
>
> > +             }
> > +
> >               ret =3D k3_r5_core_halt(core);
> >               if (ret)
> >                       goto out;
>

