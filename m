Return-Path: <linux-kernel+bounces-193433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C45328D2BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E849C1C22357
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A1015B579;
	Wed, 29 May 2024 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3N7tETX"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4815B569
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716959114; cv=none; b=jhQIqqHzDjkDNYL9PYPZU0t4FtUJKxFeQbu0PlDUgTkrvDEL/VRZ1gzrGGRMYORMJRF0OqfPSYKzh3ySwHcabWu8BIABV3d/pOmVq0j8nfNMwN29A5uGLN3mInQfMPaFBQcIivrMB7sR4uh9ePZLKBToRC8eRIOn1fehOyow97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716959114; c=relaxed/simple;
	bh=edYATESJWmsjM0xhVxjlpyLFJN2AzhjUneUPftzfzJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2X4KjMhuKbuE53YNnRc9ePB+HqYDQUL2pFt5Bzk4r+NuJc+M9wgsYdOtNlQgb5M9v727RHPwEWRESkxiX/GEfMPJtdT3+zqvyZyXwTpwcr010dn4ZFopn8TaN6owbz6ZKz4Ek1PZAq0uy2nG5C9Dm28sliOr21ZOZ4z5/Q1u1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3N7tETX; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-48a39a3b10dso516728137.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716959110; x=1717563910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKmbUeAYX99Z/W8wHYS7l713oDOhasoyW6w2BmqBmx0=;
        b=g3N7tETX30wucCzrKJCbJQwD0P4Et0XZsSMwojoks6QDeGnhSOsgI/TsBhBlkC4cVp
         mh+6oyk0yKTtKYcbAjgZhXXr3hyV2t3j5kXCxiTkEBeiuXP40F2F/UEUG8H5UlbCTv07
         GYev2HnnZKcSCXf+KkUUIeB5JKB34ibcM8OgMvL3mLubkh1GCI9XqtIL2kQTSoIh0Bpm
         l67QDaLa7cz1oOQ21/knagatgBEyRat1wEEApNSRd1nV5lcePv3VoZtjiB+A5R2YuM2C
         vfHnahrJar7RGs3fLZJtXUGjWybU4tJbFuz9zo8rksaql4MN+XMNCkYXlrUqjNMMAjoK
         yhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716959110; x=1717563910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKmbUeAYX99Z/W8wHYS7l713oDOhasoyW6w2BmqBmx0=;
        b=KpkYcnfo7Wrox7xAARI8gSAcaQgDZtxH51c1wGQeNmk+T1DXGtHSHdxa65nsZXollC
         PcgjkdVJgnlNVnoq3ubSR9IZVEISWalnOQ6rIuvj6Rpc1B7CzIBx6GWNSXmX6P+GuZIl
         Pbx/9F/fn2k4Kgs+8Qni0m5ouCeEo9xs/S0rjNYgMMvwnfNVgzpUvPLac/xXIgnFZsc0
         RjIFlr+SmD1KkQ/SLOW1uFbASvUpfZpE88WsUebtCYqdg4oP/IPtwupwX3bjeftoToL1
         Y/t/BGF+Irea7L5OFNstiCQnzyAeUBCvmCeQUn7INtQJ+IxgB8U7wLcvjgv+gArFVG1V
         0E2Q==
X-Gm-Message-State: AOJu0YxqyHU9ulmtsMBZ1zsbIqUC++5z57ZckQv47cTlrWEqhkI7fsFI
	uIvRon2NRIqmZWwJCJAD08QJNfwd73XNStehE236p238Jb/QzxuMnH47JEw1yhvlPAzLCA0qoX/
	y3fiVY3WvPLSwFRnq3Nmjofd1b7mJbxAWh49FHQ==
X-Google-Smtp-Source: AGHT+IGLmzof1jZ4cDRooqbgTFk+QfXjN2BKW7YXz8qJTEkMgr7Y2s74VX0eUhStsUj7n1f+KqTK4cvVJU85NhMUGvw=
X-Received: by 2002:a05:6102:98:b0:47b:614e:cbd with SMTP id
 ada2fe7eead31-48a386d7d64mr12686870137.31.1716959110120; Tue, 28 May 2024
 22:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <CAFA6WYNF77WrpC6PPY4idM7XkObnrS9hDyyBJDsaLRLcqdH_9g@mail.gmail.com>
 <CAHUa44EFYwYU6LSGfv+2ym_pweDKbJzqQG0MfW=bqx5UGSnYSQ@mail.gmail.com>
In-Reply-To: <CAHUa44EFYwYU6LSGfv+2ym_pweDKbJzqQG0MfW=bqx5UGSnYSQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 10:34:58 +0530
Message-ID: <CAFA6WYMobtWMFjv11Gg5-bhU_Guf_R4tx35kwdK-aT4hjLfn0g@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 at 14:38, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi Sumit,
>
> On Mon, May 27, 2024 at 4:38=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Mon, 27 May 2024 at 17:44, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe =
and
> > > use an RPMB device via the RPMB subsystem instead of passing the RPMB
> > > frames via tee-supplicant in user space. A fallback mechanism is kept=
 to
> > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > available.
> > >
> > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > devices until one is found with the expected RPMB key already
> > > programmed.
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Tested-by: Manuel Traut <manut@mecka.net>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> > >  MAINTAINERS                               |   1 +
> > >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> > >  drivers/tee/optee/device.c                |   7 +
> > >  drivers/tee/optee/ffa_abi.c               |  14 ++
> > >  drivers/tee/optee/optee_ffa.h             |   2 +
> > >  drivers/tee/optee/optee_private.h         |  26 +++-
> > >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> > >  drivers/tee/optee/optee_smc.h             |   2 +
> > >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++=
++
> > >  drivers/tee/optee/smc_abi.c               |  14 ++
> > >  11 files changed, 387 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentatio=
n/ABI/testing/sysfs-class-tee
> > > new file mode 100644
> > > index 000000000000..c9144d16003e
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > > @@ -0,0 +1,15 @@
> > > +What:          /sys/class/tee/tee{,priv}X/rpmb_routing_model
> > > +Date:          May 2024
> > > +KernelVersion: 6.10
> > > +Contact:        op-tee@lists.trustedfirmware.org
> > > +Description:
> > > +               RPMB frames can be routed to the RPMB device via the
> > > +               user-space daemon tee-supplicant or the RPMB subsyste=
m
> > > +               in the kernel. The value "user" means that the driver
> > > +               will route the RPMB frames via user space. Conversely=
,
> > > +               "kernel" means that the frames are routed via the RPM=
B
> > > +               subsystem without assistance from tee-supplicant. It
> > > +               should be assumed that RPMB frames are routed via use=
r
> > > +               space if the variable is absent. The primary purpose
> > > +               of this variable is to let systemd know whether
> > > +               tee-supplicant is needed in the early boot with initr=
amfs.
> >
> > Why do we need this if we already have [1] [2]? AFAICS, whichever
> > devices like fTPM etc. systemd depends upon, it can be easily known
> > via existing sysfs property.
> >
> > [1] https://docs.kernel.org/admin-guide/abi-testing.html?highlight=3Dop=
tee#abi-sys-bus-tee-devices-optee-ta-uuid-need-supplicant
> > [2] Documentation/ABI/testing/sysfs-bus-optee-devices
>
> The dependency is reversed. A TA depending on tee-supplicant will not
> be loaded until tee-supplicant is ready. rpmb_routing_model is used as
> one of the inputs to determine if tee-supplicant must be started early
> or if it can wait until the real rootfs is available.
>

Okay but I am still not able to understand the reasoning as to why
tee-supplicant can't be started unconditionally. If it's available in
the initrd then systemd should be able to launch it unconditionally.
Or is there any dependency I am missing for the tee-supplicant to be
started? RPMB routing isn't the only service offered by tee-supplcant,
so gating it behind that for no real reason isn't making sense to me.

IOW, why do we need to defer starting tee-supplicant until the real
rootfs is available?

-Sumit

