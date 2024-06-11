Return-Path: <linux-kernel+bounces-209669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB75903920
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD451C232E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F49178CD2;
	Tue, 11 Jun 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbW5gedb"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E17407C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102615; cv=none; b=X2p6z0oYpEShJ7dn9DbUISQ0UOsOHNrOqOeXm180TpGR00R9eOOiPTZrElHLfAZbDi69ZrBnEWqIxN4zzUdZGEo+2TJV32hRyofWAxk9iiON5ajBrKHyV477skpRCmXJXpROM4QXRKAFn8RAVnbKpewT7Wkrvaml8+ouAnCz/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102615; c=relaxed/simple;
	bh=MGVPZT99C7czUylQoinKVYX89BF9iCjGD6vVH+sJD04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNrrgMh0pg9iP0k91hEb+sJuKDk3/yXiCxkrXuWWUhdyvZVvBhsySe+dkxcgbTyPXjewLUpB6okbb9VlWdaam+Rgm/pJU7TqFeuezW0PkCzbgAyYCfR6eTZgkyyQ3GGCE2wFrXDdPXO1vNC89xi7ViukrDECXq4BgbGn8YctXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbW5gedb; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80b7699abcaso1006742241.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718102613; x=1718707413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjJPPu+V3wPP4/Iy5VWY/CaPSv8B3HGHbuPTt5kcSF4=;
        b=nbW5gedbVxOc2VTtTsm/c+nP2S7GGY+A6WgVnz9jWZD95Zyqq5Cuw91Iwg1NMihuPg
         jyH3Pm07A9l7AfUcikRMN5hZyBnrhSl5Swt/j9cvn8PwKa1PvnbJVT2PAVukgDpVsD4b
         Edg3RBWBy6v31Nl+q5z8MkfJbovReXUK7gZqloVi/ZUk7RkD1Xvh9e8pWYbsiefSV7Gv
         KoholIQQJObsmyngTLSyFvMjLupqdsNsWsSqFtB7RB+VIXY57Yk3F6lcYjmHfB8pvcHy
         4IinojPmR/U21g6lgUzDN8jmGSb1N5aLT9jrxcPW+sijDm1t2jY78B25yfTcRoTQFGZU
         PVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718102613; x=1718707413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjJPPu+V3wPP4/Iy5VWY/CaPSv8B3HGHbuPTt5kcSF4=;
        b=umY4D7sqB1l5faGlBaeehTTGd4PAzJFfcWkiuHvPOdlcWoJurSVXwfFYgCgahrhpdm
         zfZsZS8HW4TclSHW0wTxizsFEymcGaoosQXiaSZGCSXFPEgjzuf2vNhOSp3dhGFdk7Aa
         51b5xNkR9AxDNuUp+fKN5gK2YxA+QKMS/zxecS8+bJ+qK0HKCdivntwN5aLJQ3meoTv2
         cl2di927lJc9G7FxoDEmkBqmBc29fXDuT0y5jocgsuj4/a29xC5GB9fOMFhRyYq5/25V
         i+yOGsJ5U2h4putoW7cC+kWmPfb4Ip+VazHdYJKUyXEhzlPNAi962kDAEJGHwUh8dG/S
         0N5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3TpI7sMIreCBgFolWKk80t/d+jFBHD62w2xEiMtCmORgJdUWzpg3zlDJgnIH+fUkRMeGW/vp/f3DtY0wrGZVTTX5jc0t3MEjOs0dY
X-Gm-Message-State: AOJu0YzTtcmQWi52/1jb+g2Z7DnXt/fl6jalnYoop+ZmuUSLRj21J84M
	/rYBE+qCCN/BTYK8+UGgDddFlqqe77lham0z//CkK/8VQddDpCZeZalh5wdyrYAFtXJ5eZTFGql
	l+KWxpJKUKQkTdH7vnZqzRzG+hDIRq91YEWQj/A==
X-Google-Smtp-Source: AGHT+IFpr23aYuAqSidt1J8SNJdOcXSGq4NhSt3mf8LKhmevYSl9NpAPajnw1ksyeFGk4/eT2fWADV1msYIaZ9C0Gss=
X-Received: by 2002:a67:f851:0:b0:48c:3b13:7ff5 with SMTP id
 ada2fe7eead31-48c3b138113mr8743658137.22.1718102612732; Tue, 11 Jun 2024
 03:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <Zl2Ibey9Qck-VLWE@manut.de>
 <CAHUa44GAiUf9+PxqhXOwGfOuc250YDyJ7uzGe2B1bGmBw2iegg@mail.gmail.com> <Zme-NMa3Bvp2h7aL@nuoska>
In-Reply-To: <Zme-NMa3Bvp2h7aL@nuoska>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 11 Jun 2024 16:13:21 +0530
Message-ID: <CAFA6WYPYSfrDtnLPRs7_0h5Hf01oPfOpqmt4c7_Twxv-re87xQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, Manuel Traut <manut@mecka.net>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jun 2024 at 08:32, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> On Mon, Jun 10, 2024 at 02:52:31PM +0200, Jens Wiklander wrote:
> > Hi Manuel,
> >
> > On Mon, Jun 3, 2024 at 11:10=E2=80=AFAM Manuel Traut <manut@mecka.net> =
wrote:
> > >
> > > On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > @@ -7,6 +7,7 @@
> > > >
> > > >  #include <linux/arm_ffa.h>
> > > >  #include <linux/errno.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/scatterlist.h>
> > > >  #include <linux/sched.h>
> > > >  #include <linux/slab.h>
> > > > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *=
ffa_dev)
> > > >       optee->ffa.bottom_half_value =3D U32_MAX;
> > > >       optee->rpc_param_count =3D rpc_param_count;
> > > >
> > > > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > > > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > > > +             optee->in_kernel_rpmb_routing =3D true;
> > >
> > > The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the mo=
ment.
> > > If I remove this check here, the series works for me.
> >
> > You're right, I missed pushing those flags to optee_os. I've pushed the=
m now.
>
> Thanks! Tested with optee 4.1 and your patches from
> https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe_v7/
> in Trusted Substrate uefi firmware
> ( https://gitlab.com/Linaro/trustedsubstrate/meta-ts/ )
> and this series and a bunch of dependencies backported to
> our Trusted Reference Stack
> ( https://trs.readthedocs.io/en/latest/ )
> 6.6.29 kernel on rockpi4b (rk3399 ARM64 SoC) with secure boot and
> the optee side fTPM TA device used to create an encrypted rootfs with
> systemd. Kernel side RPMB routing is in use and works for the TPM use cas=
es.
>

Glad to see that you can get fTPM to work without tee-supplicant after
this patch-set.

> Full boot and test log (with unrelated test failures)
> https://ledge.validation.linaro.org/scheduler/job/88692
>
> root@trs-qemuarm64:~# cat /sys/class/tee/tee0/rpmb_routing_model
> ...
> kernel

So coming back to the real question, do we really need this new
rpmb_routing_model ABI? Did systemd still need it with no
tee-supplicant dependency? IMHO, a user-space ABI requires use-case
justification otherwise it's just going to add on maintenance burden.

-Sumit

>
> Tested-by: Mikko Rapeli <mikko.rapeli@linaro.org>
>
> Cheers,
>
> -Mikko

