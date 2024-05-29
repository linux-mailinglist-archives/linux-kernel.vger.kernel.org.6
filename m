Return-Path: <linux-kernel+bounces-193443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B88D2C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E431F22EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E8315B987;
	Wed, 29 May 2024 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p49MXVqc"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B215B980
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960378; cv=none; b=eucDUCKCLecXre9UdKEL2yuuDxhqRufCLzzhNS0YhCu3pvIy5CCHz7LSNrcr+z8MVBj/h6XtLNOIIVIFp13r5SLoB6qbxB2R8gJGDqTR1IraGgPRFvjzEVUmCU1th2n5nlelmTZ5zsjXzQoz8w8usezlaQ183yH8JKp2eIM0Hk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960378; c=relaxed/simple;
	bh=sXgwCUC0sQjZAv8pdBXHiuXTQoFTMkYAXip7NzBwyqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9QvFu39H5isUt7n6Eakf8SrLwMgoG+oal6gq1+67zBQMv0ze/930FDBbA1dleBRs/oSlhlJiVssM0bwd1MZgM0xVag8y6uwrg1MD2WwspcxCmj3XwfL27t7O+xbs2aAZK4KblPB3+KFGwfRxbntftNfdrRFKqW9EIrTDENGJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p49MXVqc; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48ba6ec5435so17703137.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716960376; x=1717565176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15ENZisTgKP86u3z7+Gtpy0dd++13PTR5V24Sl4v+pI=;
        b=p49MXVqc63R5H+jkkrJnx3IJSdbZVsbxdeklEXpOAqT1TwQpSH9oyBF0ggUUq3RE9H
         lWa1IInuTQKV5oPd7QHKIfswbId4F27dCIcJWGCF8ukxuXcDYUU3nl7G/gQRWVbAEjRS
         7v3WFyPKuJ+4IvwvHTE++YDG0CSlklyTd4toZfKHqLBilBEy5hJBLgzsQkwW20BJnIaw
         PBywxYI0c9Y/4JF8JN3TIZ/4XKHn3yhDxRbAEbeNW5VRrinSECRKzmESb7+FdHYjppWT
         /b3oIX+skPsX/ohkGO8UnBzNDYd/uaSqxajRGf4oxBnY1Cm4HkdJrOz2ttBoZrchTclq
         CSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716960376; x=1717565176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15ENZisTgKP86u3z7+Gtpy0dd++13PTR5V24Sl4v+pI=;
        b=JhYMQ29nQU5RpjjXPmn0/Su4/EOvsXbEI7QFskSFN5cZrhcKi4Civ7QDkjRmNgpEyo
         yi5kiRCcEWJLkI+M8xqhcl6XKMraTtSr2Svaly4VHmYi7HoA0Y9NiOC3ULResoLwmIJ5
         iQsPUnTQl9OFPE6RaPUOyeDhBmhnJnG+vXuFtAVy0GwuZsVYCnW7FiJI5q1YsYSo1p4N
         T4LuZvknwsNDi6UrEf2g3upR0n+Jd3IxvvkVY6qN8EBYNSgR1AkRoxSAroAQWEOoP15I
         Dlopp1FkT7ml+KWlucOYZBxIW6Xi7hDT/wXy0VsgWo2S9lQNRw2SXmppLEPqFvSThdJA
         MIGw==
X-Forwarded-Encrypted: i=1; AJvYcCV14Z6OVivXAp5CTwCbafgc9Sjr90gChPnmxStooMHmL0Nu10BaBzRe/jYcXSThm/NUbgCHMcXdDaNDsneckJ4yap5hAh0m4JqVs1Pd
X-Gm-Message-State: AOJu0Yx2WRvPaIP7SJDjVTJA4cFirA4L3B10c/VJu0Kofb4r/2/0VgZZ
	ztAqw++DYX8xBh9cRbwCLuqPB46sbELpnAVHNing9Uy2oixE/jJje9B+ZBECHB7T7B4VFg1j1nP
	KahLz471m4PAFZkUSAHoaQW2/wsKWpzHlSpE88g==
X-Google-Smtp-Source: AGHT+IGlTxxgeYGP2YfV8+ZTwt7HTIl+R8Dwu5gdKq4zDJ3MAVZ5rbhlD8FwZvpwmiVig13ibCFackQouSPTKa4Nui4=
X-Received: by 2002:a05:6102:2404:b0:48b:8f15:8a8f with SMTP id
 ada2fe7eead31-48b9ce2e281mr698247137.8.1716960375838; Tue, 28 May 2024
 22:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
 <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com> <ZlWkSCCjJ2fbE2ML@nuoska>
In-Reply-To: <ZlWkSCCjJ2fbE2ML@nuoska>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 10:56:04 +0530
Message-ID: <CAFA6WYOT52fdqgGvDYE91DQ_4MUbAv_1Gnn2fTyMNhrj_Agu=w@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manuel Traut <manut@mecka.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikko,

On Tue, 28 May 2024 at 15:00, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> On Mon, May 27, 2024 at 03:24:01PM +0200, Jens Wiklander wrote:
> > On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > On 5/27/24 14:13, Jens Wiklander wrote:
> > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to prob=
e and
> > > > use an RPMB device via the RPMB subsystem instead of passing the RP=
MB
> > > > frames via tee-supplicant in user space. A fallback mechanism is ke=
pt to
> > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > > available.
> > > >
> > > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > > devices until one is found with the expected RPMB key already
> > > > programmed.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Tested-by: Manuel Traut <manut@mecka.net>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > > >  MAINTAINERS                               |   1 +
> > > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > > >  drivers/tee/optee/device.c                |   7 +
> > > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > > >  drivers/tee/optee/optee_smc.h             |   2 +
> > > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++=
++++
> > > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentat=
ion/ABI/testing/sysfs-class-tee
> > > > new file mode 100644
> > > > index 000000000000..c9144d16003e
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > > @@ -0,0 +1,15 @@
> > > > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing_model
> > >
> > > Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?
> >
> > Doesn't the routing model concern tee-supplicant more than a TEE
> > client? Then it might make more sense to have
> > /sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for both
> > devices representing the same internal struct optee makes it easier to
> > find. Anyway, I don't mind removing one. Mikko, what do you prefer?
>
> As simple as possible. A single sysfs file is enough. Even the existence =
of the sysfs file
> could be the needed indicator for userspace to queue tee-supplicant start=
up.
>
> Outside of these patches, I think the optee RPC setup with fTPM TA is one=
 area which
> currently requires tee-supplicant to be started. Detecting the existence =
of TPM before
> kernel drivers are loaded is possible via the exported EFI logs from firm=
ware to kernel
> or ACPI TPM2 table entry, and detecting optee and thus starting tee-suppl=
icant in userspace too.

One thing I am trying to find an answer about is why do we need to
defer tee-supplicant launch if it's bundled into initrd? Once you
detect OP-TEE then tee-supplicant should be launched unconditionally.
As per your example below, the motivation here seems to be the TPM2
device dependent on RPMB backend but what if other future systemd
services come up and depend on other services offered by
tee-supplicant?

-Sumit

>
> In userspace and systemd it's just important to know that service need to=
 wait for a TPM2
> device to appear in early initrd and when can things be postponed to main=
 rootfs and later
> stages. Kernel and udev will bring up the device then once discovered.
> Knowledge about the RPMB backend is important when something like TPM2 de=
vice
> depends on it.
>
> Hope this helps,
>
> -Mikko

